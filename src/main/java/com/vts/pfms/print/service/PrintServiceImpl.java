package com.vts.pfms.print.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.milestone.dto.MilestoneActivityLevelConfigurationDto;
import com.vts.pfms.milestone.model.MilestoneActivityLevelConfiguration;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.print.dao.PrintDao;
import com.vts.pfms.print.model.InitiationSanction;
import com.vts.pfms.print.model.InitiationsanctionCopyAddr;
import com.vts.pfms.print.model.TechImages;

import net.bytebuddy.asm.Advice.OffsetMapping.ForOrigin.Renderer.ForReturnTypeName;


@Service
public class PrintServiceImpl implements PrintService{

	@Autowired
	PrintDao dao;
	FormatConverter fc=new FormatConverter();
	
	private static final Logger logger=LogManager.getLogger(PrintServiceImpl.class);

	@Override
	public List<Object[]> LabList() throws Exception {

		logger.info(new Date() +"Inside LabList");		
		return dao.LabList();
	}

	@Override
	public List<Object[]> PfmsInitiationList(String InitiationId) throws Exception {

		logger.info(new Date() +"Inside PfmsInitiationList");
		return dao.PfmsInitiationList(InitiationId);
	}
	
	@Override
	public LabMaster LabDetailes() throws Exception {
	
		logger.info(new Date() +"Inside LabDetailes");
		return dao.LabDetailes();
	}
	
	@Override
	public List<Object[]> ProjectIntiationDetailsList(String InitiationId) throws Exception {
	
		logger.info(new Date() +"Inside ProjectIntiationDetailsList");
		return dao.ProjectIntiationDetailsList(InitiationId);
	}

	@Override
	public List<Object[]> CostDetailsList(String InitiationId) throws Exception {

		logger.info(new Date() +"Inside CostDetailsList");
		return dao.CostDetailsList(InitiationId);
	}

	@Override
	public List<Object[]> ProjectInitiationScheduleList(String InitiationId) throws Exception {

		logger.info(new Date() +"Inside ProjectInitiationScheduleList");
		return dao.ProjectInitiationScheduleList(InitiationId);
	}
	
	@Override
	public List<Object[]> ProjectsList() throws Exception {
		logger.info(new Date() +"Inside ProjectsList");
		return dao.ProjectsList();
	}

	
	@Override 
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype ,String LabCode) throws Exception
	{
		logger.info(new Date() +"Inside LoginProjectDetailsList"); 
		List<Object[]> projectidlist=(ArrayList<Object[]>) dao.LoginProjectDetailsList(empid,Logintype,LabCode);  
		return projectidlist;
	}
	
	
	
/*------------------------------------------------------------*/
	@Override
	public Object[] ProjectAttributes(String projectid) throws Exception {
		logger.info(new Date() +"Inside ProjectAttributes");
		return dao.ProjectAttributes(projectid);
	}
	
	@Override
	public List<Object[]> EBAndPMRCCount(String projectid) throws Exception {
		logger.info(new Date() +"Inside EBAndPMRCCount");
		return dao.EBAndPMRCCount(projectid);
	}
	
	@Override
	public List<Object[]> Milestones(String projectid) throws Exception {
		logger.info(new Date() +"Inside Milestones");
		return dao.Milestones(projectid);
	}
	
	@Override
	public List<Object[]> MilestonesChange(String projectid,String milestoneactivitystatusid) throws Exception {
		logger.info(new Date() +"Inside MilestonesChange");
		return dao.MilestonesChange(projectid,milestoneactivitystatusid);
	}
		
	@Override /* present status*/
	public List<Object[]> MilestoneSubsystems(String projectid) throws Exception {
		logger.info(new Date() +"Inside MilestoneSubsystems");
		return dao.MilestoneSubsystems(projectid);
	}

	@Override /* last Pmrc action points*/
	public List<Object[]> LastPMRCActions(String projectid,String committeeid) throws Exception 
	{
		logger.info(new Date() +"Inside LastPMRCActions");
		return dao.LastPMRCActions(projectid,committeeid);
	}
	
	@Override /* old Pmrc action points*/
	public List<Object[]> OldPMRCActions(String projectid,String committeeid) throws Exception 
	{
		logger.info(new Date() +"Inside OldPMRCActions");
		return dao.OldPMRCActions(projectid,committeeid);
	}
	
	@Override
	public List<Object[]> ProjectDetails(String ProjectId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectDetails");
		return dao.ProjectDetails(ProjectId);
	}
	
	@Override
	public List<Object[]> GanttChartList(String ProjectId) throws Exception {
		
		logger.info(new Date() +"Inside GanttChartList");
		return dao.GanttChartList(ProjectId);
	}
	

	@Override
	public Object[] ProjectDataDetails(String projectid) throws Exception {
		logger.info(new Date()  +"Inside ProjectDataDetails");
		return dao.ProjectDataDetails(projectid);
	}
	
	@Override
	public List<Object[]> OldPMRCIssuesList(String projectid) throws Exception { 
		logger.info(new Date()  +"Inside OldPMRCIssuesList");
		return dao.OldPMRCIssuesList(projectid);
	}
	
	@Override
	public List<Object[]> ProcurementStatusList(String projectid)throws Exception{
		logger.info(new Date()  +"Inside ProcurementStatusList");
		return dao.ProcurementStatusList(projectid);
	}
	
	
	@Override
	public List<Object[]> RiskMatirxData(String projectid)throws Exception{
		logger.info(new Date()  +"Inside RiskMatirxData");
		return dao.RiskMatirxData(projectid);
		
	}
	
	@Override
	public Object[] LastPMRCDecisions(String committeeid,String projectid)throws Exception
	{
		logger.info(new Date()  +"Inside LastPMRCDecisions");
		return dao.LastPMRCDecisions(committeeid ,projectid);
	}
	
	@Override
	public List<Object[]> ActionPlanSixMonths(String projectid, String committeeid)throws Exception
	{
		logger.info(new Date()  +"Inside ActionPlanThreeMonths");
		if( committeeid.equalsIgnoreCase("1") ) 
		{
			return dao.ActionPlanSixMonths(projectid,90);
		}
		else if(committeeid.equalsIgnoreCase("2"))
		{
			return dao.ActionPlanSixMonths(projectid,180);
		}		
		return dao.ActionPlanSixMonths(projectid,180);
	}
	
	@Override
	public List<Object[]> LastPMRCActions1(String projectid ,String committeeid) throws Exception 
	{
		logger.info(new Date()  +"Inside LastPMRCActions1");
		return dao.LastPMRCActions1(projectid, committeeid);
	}
	
	@Override
	public List<String> ProjectsubProjectIdList(String projectid ) throws Exception 
	{
		return dao.ProjectsubProjectIdList(projectid);
	}
	
	@Override
	public List<Object[]> ReviewMeetingList(String projectid, String committeeid) throws Exception 
	{
		return dao.ReviewMeetingList(projectid, committeeid);
	}
	
	@Override
	public Object[] TechWorkData(String projectid) throws Exception 
	{
		Object[] data = dao.TechWorkData(projectid);				
		return data;
	}
	
	@Override
	public List<Object[]> ProjectRevList (String projectid) throws Exception {
		return dao.ProjectRevList(projectid);
	}

	@Override
	public List<Object[]> getMeetingSchedules(String ProjectId, String Month, String Year) throws Exception {
		
		return dao.getMeetingSchedules(ProjectId, Month, Year);
	}
	@Override
	public Object[] CommitteeScheduleEditData(String CommitteeScheduleId) throws Exception {

		logger.info(new Date() +"Inside CommitteeScheduleEditData");
		return dao.CommitteeScheduleEditData(CommitteeScheduleId);
	}

	@Override
	public long getLastPmrcId(String projectid, String committeeid, String scheduleId) throws Exception {
		
		return dao.getLastPmrcId(projectid, committeeid, scheduleId);
	}

	@Override
	public long getNextScheduleId(String projectid, String committeeid) throws Exception {
		
		return dao.getNextScheduleId(projectid, committeeid);
	}

	@Override
	public int updateBriefingPaperFrozen(long schduleid) throws Exception {
		
		return dao.updateBriefingPaperFrozen(schduleid);
	}

	@Override
	public String getNextScheduleFrozen(long schduleid) throws Exception {
		
		return dao.getNextScheduleFrozen(schduleid);
	}
	
	@Override
	public List<Object[]> MilestoneActivityStatus() throws Exception {
		
		return dao.MilestoneActivityStatus();
	}
	
	@Override
	public List<Object[]> GetProjectInitiationSanList() throws Exception {
		
		return dao.GetProjectInitiationSanList();
	}
	@Override
	public Object[] GetProjectInitiationdata(String initiationId)throws Exception
	{
		return dao.GetProjectInitiationdata(initiationId);
	}
	
	@Override
	public List<Object[]> GetItemList(String initiationId)throws Exception{ 
		return dao.GetItemList(initiationId);
	}
	
	@Override	
	public List<Object[]> GetAuthorityList()throws Exception
	{
		return dao.GetAuthorityList();
	}

	@Override
	public List<Object[]> GetinitiationCopyAddr() throws Exception
	{
		return dao.GetinitiationCopyAddr();
	}
	
	@Override
	public List<Object[]> GetinitiationDeptList ()throws Exception
	{
		return dao.GetinitiationDeptList();
	}
	
	@Override
	public Long AddInitiationSanction(InitiationSanction initiationsac) throws Exception
	{
		return dao.AddInitiationSanction(initiationsac);
	}
	
	@Override
	public Long AddCopyAddress(InitiationsanctionCopyAddr copyaddress) throws Exception
	{
		return dao.AddCopyAddress(copyaddress);
	}
	
	@Override
	public Object[] GetInitiationSanctionData(String initiationId)throws Exception
	{
		return dao.GetInitiationSanctionData(initiationId);
	}
	
	@Override
	public List<Object[]> GetCopyAddressList (String initiationId)throws Exception
	{
		return dao.GetCopyAddressList(initiationId);
	}
	@Override  
	public int DeleteCopyAddress(String initiationsancopyid) throws Exception
	{
			return dao.DeleteCopyAddress(initiationsancopyid);
	}
	
	@Override
	public Long EditInitiationSanction(InitiationSanction initiationsac) throws Exception
	{
		return dao.EditInitiationSanction(initiationsac);
	}
	 public static int  saveFile(String FilePath, String fileName, MultipartFile multipartFile) throws IOException 
	   {
		    int result=1;
	        Path uploadPath = Paths.get(FilePath);
	          
	        if (!Files.exists(uploadPath)) {
	            Files.createDirectories(uploadPath);
	        }
	        
	        try (InputStream inputStream = multipartFile.getInputStream()) {
	            Path filePath = uploadPath.resolve(fileName);
	            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	        } catch (IOException ioe) { 
	        	 result=0;
	            throw new IOException("Could not save image file: " + fileName, ioe);
	        }   catch (Exception e) {
	        	 result=0;
	        	e.printStackTrace();
	        }
	        return result;
	    }

	@Override
	public int saveGranttChart(MultipartFile file, String Name,String path) throws Exception {
		String Path= path+"\\grantt\\";
		int result=saveFile(Path, Name+"."+FilenameUtils.getExtension(file.getOriginalFilename()), file);
		return result;
	}
	    
	@Override
	public Object[] MileStoneLevelId(String ProjectId, String CommitteeId) throws Exception {
			
		return dao.MileStoneLevelId(ProjectId,CommitteeId);
	}

	@Override
	public int MileStoneLevelUpdate(MilestoneActivityLevelConfigurationDto dto) throws Exception {

		MilestoneActivityLevelConfiguration mod = new MilestoneActivityLevelConfiguration();
		long count=0L;
		
		
		if(dto.getLevelConfigurationId()!=null) {
			mod.setLevelConfigurationId(Long.parseLong(dto.getLevelConfigurationId()));
			mod.setLevelid(Long.parseLong(dto.getLevelid()));
			mod.setModifiedBy(dto.getCreatedBy());
			mod.setModifiedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
			count=dao.MilestoneLevelUpdate(mod);
		}else {
			
			mod.setLevelid(Long.parseLong(dto.getLevelid()));
			mod.setProjectId(Long.parseLong(dto.getProjectId()));
			mod.setCommitteeId(Long.parseLong(dto.getCommitteeId()));
			mod.setCreatedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
			mod.setCreatedBy(dto.getCreatedBy());
			count=dao.MilestoneLevelInsert(mod);
		}

		return (int) count;
	}
	
	@Override
	public List<Object[]> BreifingMilestoneDetails(String Projectid) throws Exception
	{
		return dao.BreifingMilestoneDetails(Projectid);
	}

	@Override
	public int saveTechImages(MultipartFile file, String ProjectId, String path,String userName) throws Exception {
		TechImages image=new TechImages();
		image.setImageName(file.getName()+"."+FilenameUtils.getExtension(file.getOriginalFilename()));
		image.setProjectId(Long.parseLong(ProjectId));
		image.setCreatedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
		image.setCreatedBy(userName);
		image.setIsActive(1);
		long imageId=dao.insertTechImage(image);
		String Path= path+"\\TechImages\\";
		int result=saveFile(Path, imageId+"_"+file.getName()+"."+FilenameUtils.getExtension(file.getOriginalFilename()), file);
		return result;
	}

	@Override
	public List<TechImages> getTechList(String proId) throws Exception {
		
		return dao.getTechList(proId);
	}
	
	@Override
	public List<Object[]> SpecialCommitteesList(String LabCode)throws Exception
	{
		return dao.SpecialCommitteesList(LabCode);
	}
	
	
}
