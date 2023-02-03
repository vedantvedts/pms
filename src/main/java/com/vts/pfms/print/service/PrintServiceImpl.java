package com.vts.pfms.print.service;

import java.io.File;
import java.io.FileInputStream;
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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.committee.model.Committee;
import com.vts.pfms.committee.model.CommitteeMeetingDPFMFrozen;
import com.vts.pfms.milestone.dto.MilestoneActivityLevelConfigurationDto;
import com.vts.pfms.milestone.model.MilestoneActivityLevelConfiguration;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.print.dao.PrintDao;
import com.vts.pfms.print.model.CommitteeProjectBriefingFrozen;
import com.vts.pfms.print.model.InitiationSanction;
import com.vts.pfms.print.model.InitiationsanctionCopyAddr;
import com.vts.pfms.print.model.TechImages;


@Service
public class PrintServiceImpl implements PrintService{

	@Autowired
	PrintDao dao;
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	FormatConverter fc=new FormatConverter();
	
	private static final Logger logger=LogManager.getLogger(PrintServiceImpl.class);

	@Override
	public Object[] LabList(String LabCode) throws Exception {

		return dao.LabList(LabCode);
	}

	@Override
	public List<Object[]> PfmsInitiationList(String InitiationId) throws Exception {

		return dao.PfmsInitiationList(InitiationId);
	}
	
	@Override
	public LabMaster LabDetailes(String LabCode) throws Exception {
	
		return dao.LabDetailes( LabCode);
	}
	@Override
	public List<Object[]> GetCostBreakList(String InitiationId,String projecttypeid)throws Exception
	{
		return dao.GetCostBreakList(InitiationId,projecttypeid);
	}
	
	@Override
	public List<Object[]> ProjectIntiationDetailsList(String InitiationId) throws Exception {
	
		return dao.ProjectIntiationDetailsList(InitiationId);
	}

	@Override
	public List<Object[]> CostDetailsList(String InitiationId) throws Exception {

		return dao.CostDetailsList(InitiationId);
	}

	@Override
	public List<Object[]> ProjectInitiationScheduleList(String InitiationId) throws Exception {

		return dao.ProjectInitiationScheduleList(InitiationId);
	}
	
	@Override
	public List<Object[]> ProjectsList() throws Exception {
		return dao.ProjectsList();
	}

	
	@Override 
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype ,String LabCode) throws Exception
	{
		List<Object[]> projectidlist=(ArrayList<Object[]>) dao.LoginProjectDetailsList(empid,Logintype,LabCode);  
		return projectidlist;
	}
	
	
	
/*------------------------------------------------------------*/
	@Override
	public Object[] ProjectAttributes(String projectid) throws Exception {
		return dao.ProjectAttributes(projectid);
	}
	
	@Override
	public List<Object[]> EBAndPMRCCount(String projectid) throws Exception {
		return dao.EBAndPMRCCount(projectid);
	}
	
	@Override
	public Object[] ProjectCommitteeMeetingsCount(String projectid, String CommitteeCode) throws Exception 
	{
		return dao.ProjectCommitteeMeetingsCount(projectid, CommitteeCode);
	}
	
	@Override
	public List<Object[]> Milestones(String projectid) throws Exception {
		return dao.Milestones(projectid);
	}
	
	@Override
	public List<Object[]> MilestonesChange(String projectid,String milestoneactivitystatusid) throws Exception {
		return dao.MilestonesChange(projectid,milestoneactivitystatusid);
	}
		
	@Override /* present status*/
	public List<Object[]> MilestoneSubsystems(String projectid) throws Exception {
		return dao.MilestoneSubsystems(projectid);
	}

	@Override /* last Pmrc action points*/
	public List<Object[]> LastPMRCActions(String projectid,String committeeid) throws Exception 
	{
		return dao.LastPMRCActions(projectid,committeeid);
	}
	
	@Override /* old Pmrc action points*/
	public List<Object[]> OldPMRCActions(String projectid,String committeeid) throws Exception 
	{
		return dao.OldPMRCActions(projectid,committeeid);
	}
	
	@Override
	public List<Object[]> ProjectDetails(String ProjectId) throws Exception {
		
		return dao.ProjectDetails(ProjectId);
	}
	
	@Override
	public List<Object[]> GanttChartList(String ProjectId) throws Exception {
		
		return dao.GanttChartList(ProjectId);
	}
	

	@Override
	public Object[] ProjectDataDetails(String projectid) throws Exception {
		return dao.ProjectDataDetails(projectid);
	}
	
	@Override
	public List<Object[]> OldPMRCIssuesList(String projectid) throws Exception { 
		return dao.OldPMRCIssuesList(projectid);
	}
	
	@Override
	public List<Object[]> ProcurementStatusList(String projectid)throws Exception{
		return dao.ProcurementStatusList(projectid);
	}
	
	
	@Override
	public List<Object[]> RiskMatirxData(String projectid)throws Exception{
		return dao.RiskMatirxData(projectid);
		
	}
	
	@Override
	public Object[] LastPMRCDecisions(String committeeid,String projectid)throws Exception
	{
		return dao.LastPMRCDecisions(committeeid ,projectid);
	}
	
	@Override
	public List<Object[]> ActionPlanSixMonths(String projectid, String committeeid)throws Exception
	{
		logger.info(new Date()  +"Inside SERVICE ActionPlanThreeMonths ");
		if( committeeid.equalsIgnoreCase("PMRC") ) 
		{
			return dao.ActionPlanSixMonths(projectid,90);
		}
		else if(committeeid.equalsIgnoreCase("EB"))
		{
			return dao.ActionPlanSixMonths(projectid,180);
		}		
		return dao.ActionPlanSixMonths(projectid,90);
	}
	
	@Override
	public List<Object[]> LastPMRCActions1(String projectid ,String committeeid) throws Exception 
	{
		return dao.LastPMRCActions1(projectid, committeeid);
	}
	
	@Override
	public List<String> ProjectsubProjectIdList(String projectid ) throws Exception 
	{
		return dao.ProjectsubProjectIdList(projectid);
	}
	
	@Override
	public List<Object[]> ReviewMeetingList(String projectid, String committeecode) throws Exception 
	{
		return dao.ReviewMeetingList(projectid, committeecode);
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
		 logger.info(new Date()  +"Inside SERVICE saveFile ");
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
	        	 logger.error(new Date()  +"Inside SERVICE saveFile "+e);
	        	e.printStackTrace();
	        }
	        return result;
	    }

	@Override
	public int saveGranttChart(MultipartFile file, String Name,String path ,String labcode) throws Exception {
		logger.info(new Date()  +"Inside SERVICE saveGranttChart ");
		String Path= path+labcode+"\\gantt\\";
		int result=saveFile(Path, Name+"."+FilenameUtils.getExtension(file.getOriginalFilename()), file);
		return result;
	}
	    
	@Override
	public Object[] MileStoneLevelId(String ProjectId, String CommitteeId) throws Exception {
			
		return dao.MileStoneLevelId(ProjectId,CommitteeId);
	}

	@Override
	public int MileStoneLevelUpdate(MilestoneActivityLevelConfigurationDto dto) throws Exception {

		logger.info(new Date()  +"Inside SERVICE MileStoneLevelUpdate ");
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
	public List<Object[]> BreifingMilestoneDetails(String Projectid, String CommitteeCode) throws Exception
	{
		return dao.BreifingMilestoneDetails(Projectid,CommitteeCode);
	}

	@Override
	public int saveTechImages(MultipartFile file, String ProjectId, String path,String userName,String LabCode) throws Exception {
		logger.info(new Date()  +"Inside SERVICE saveTechImages ");
		TechImages image=new TechImages();
		image.setImageName(file.getName()+"."+FilenameUtils.getExtension(file.getOriginalFilename()));
		image.setProjectId(Long.parseLong(ProjectId));
		image.setCreatedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
		image.setCreatedBy(userName);
		image.setIsActive(1);
		long imageId=dao.insertTechImage(image);
		String Path= path+LabCode+"\\TechImages\\";
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
	
	@Override
	public Committee getCommitteeData(String committeeid)throws Exception
	{
		return dao.getCommitteeData(committeeid);
	}
	
	@Override
	public long FreezeBriefing(CommitteeProjectBriefingFrozen briefing) throws Exception 
	{
		Object[] scheduledata = dao.CommitteeScheduleEditData(String.valueOf(briefing.getScheduleId()));
		String meedtingId = scheduledata[11].toString().replaceAll("[&.:?|<>/]", "").replace("\\", "") ;
		String LabCode = briefing.getLabCode();
		String filepath = "\\"+LabCode.toUpperCase().trim()+"\\Briefing\\";
		int count=0;
		String filename = "Briefing-"+meedtingId;
		while(new File(uploadpath+filepath+"\\"+filename+".pdf").exists())
		{
			filename = "Briefing-"+meedtingId;
			filename = filename+" ("+ ++count+")";
		}
		File file = briefing.getBriefingFile();
		saveFile(uploadpath+filepath ,filename+".pdf" ,file );
		
		briefing.setBriefingFileName(filename+".pdf");
		briefing.setFrozenBriefingPath(filepath);
		briefing.setFreezeTime(fc.getSqlDateAndTimeFormat().format(new Date()));
		return dao.FreezeBriefingAdd(briefing);
	}
	
	public void saveFile(String uploadpath, String fileName, File fileToSave) throws IOException 
	{
	   logger.info(new Date() +"Inside SERVICE saveFile ");
	   Path uploadPath = Paths.get(uploadpath);
	          
	   if (!Files.exists(uploadPath)) {
		   Files.createDirectories(uploadPath);
	   }
	        
	   try (InputStream inputStream = new FileInputStream(fileToSave)) {
		   Path filePath = uploadPath.resolve(fileName);
	       Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	   } catch (IOException ioe) {       
		   throw new IOException("Could not save file: " + fileName, ioe);
	   }     
	}
	
	@Override
	public CommitteeProjectBriefingFrozen getFrozenProjectBriefing(String scheduleId)throws Exception
	{
		return dao.getFrozenProjectBriefing(scheduleId);
	}
	
	@Override
	public List<Object[]> AgendaList(String scheduleId) throws Exception 
	{
		return dao.AgendaList(scheduleId);
	}
	
	@Override
	public List<Object[]> AgendaLinkedDocList(String scheduleid) throws Exception
	{
		return dao.AgendaLinkedDocList(scheduleid);
	}

	@Override
	public Object RequirementList(String initiationId) throws Exception {
		// TODO Auto-generated method stub
		return dao.RequirementList(initiationId);
	}
	
}
