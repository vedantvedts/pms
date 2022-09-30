package com.vts.pfms.project.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.print.model.ProjectTechnicalWorkData;
import com.vts.pfms.project.dao.ProjectDao;
import com.vts.pfms.project.dto.PfmsInitiationAttachmentDto;
import com.vts.pfms.project.dto.PfmsInitiationAttachmentFileDto;
import com.vts.pfms.project.dto.PfmsInitiationAuthorityDto;
import com.vts.pfms.project.dto.PfmsInitiationAuthorityFileDto;
import com.vts.pfms.project.dto.PfmsInitiationCostDto;
import com.vts.pfms.project.dto.PfmsInitiationDetailDto;
import com.vts.pfms.project.dto.PfmsInitiationDto;
import com.vts.pfms.project.dto.PfmsProjectDataDto;
import com.vts.pfms.project.dto.PfmsRiskDto;
import com.vts.pfms.project.dto.ProjectAssignDto;
import com.vts.pfms.project.dto.ProjectMasterAttachDto;
import com.vts.pfms.project.dto.ProjectScheduleDto;
import com.vts.pfms.project.model.PfmsApproval;
import com.vts.pfms.project.model.PfmsInitiation;
import com.vts.pfms.project.model.PfmsInitiationAttachment;
import com.vts.pfms.project.model.PfmsInitiationAttachmentFile;
import com.vts.pfms.project.model.PfmsInitiationAuthority;
import com.vts.pfms.project.model.PfmsInitiationAuthorityFile;
import com.vts.pfms.project.model.PfmsInitiationChecklistData;
import com.vts.pfms.project.model.PfmsInitiationCost;
import com.vts.pfms.project.model.PfmsInitiationDetail;
import com.vts.pfms.project.model.PfmsInitiationLab;
import com.vts.pfms.project.model.PfmsInitiationSchedule;
import com.vts.pfms.project.model.PfmsProjectData;
import com.vts.pfms.project.model.PfmsProjectDataRev;
import com.vts.pfms.project.model.PfmsRisk;
import com.vts.pfms.project.model.PfmsRiskRev;
import com.vts.pfms.project.model.ProjectAssign;
import com.vts.pfms.project.model.ProjectMain;
import com.vts.pfms.project.model.ProjectMaster;
import com.vts.pfms.project.model.ProjectMasterAttach;
import com.vts.pfms.project.model.ProjectMasterRev;

@Service
public class ProjectServiceImpl implements ProjectService {

	@Value("${file_upload_path}")
	String uploadpath;
	
	@Value("${Project_Master_Attachments}")
	String ProjectMasterFilePath;
	
	private static final Logger logger=LogManager.getLogger(ProjectServiceImpl.class);
	
	FormatConverter fc=new FormatConverter();
	private SimpleDateFormat sdf1 = fc.getSqlDateAndTimeFormat(); /* new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); */
			
	private  SimpleDateFormat sdf=fc.getRegularDateFormat(); /*new SimpleDateFormat("dd-MM-yyyy");*/
	private  SimpleDateFormat sdf2=fc.getSqlDateFormat();
	private int year = Calendar.getInstance().get(Calendar.YEAR);
	private int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
	DecimalFormat df=new DecimalFormat("0.00");
	
	@Autowired
	ProjectDao dao;
	
	@Override
	public List<Object[]> ProjectIntiationList(String Empid,String LoginType) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationList");	
		return dao.ProjectIntiationList(Empid,LoginType);
	}

	@Override
	public List<Object[]> ProjectTypeList() throws Exception {

		logger.info(new Date() +"Inside ProjectTypeList");
		return dao.ProjectTypeList();
	}
	
	@Override
	public Long ProjectMainAdd(ProjectMain proType) throws Exception {
		
		return dao.ProjectMainAdd(proType);
	}


	@Override
	public List<Object[]> OfficerList() throws Exception {
		
		return dao.OfficerList();
	}
	
	@Override
	public Long ProjectMainEdit(ProjectMain proType) throws Exception {
		

		return dao.ProjectMainEdit(proType);
	}
	@Override
	public Object[] ProjectMainEditData(String ProjectMainId) throws Exception {
		
		return dao.ProjectMainEditData(ProjectMainId);
	}

	@Override
	public Long ProjectMainClose(ProjectMain proType) throws Exception {
		
		return dao.ProjectMainClose(proType);
	}

	@Override
	public List<Object[]> PfmsCategoryList() throws Exception {
	
		logger.info(new Date() +"Inside PfmsCategoryList");
		return dao.PfmsCategoryList();
	}

	@Override
	public List<Object[]> PfmsDeliverableList() throws Exception {
	
		logger.info(new Date() +"Inside PfmsDeliverableList");
		return dao.PfmsDeliverableList();
	}

	@Override
	public List<Object[]> LabList(String IntiationId) throws Exception {

		logger.info(new Date() +"Inside LabList");
		return dao.LabList(IntiationId);
	}

	@Override
	public Long ProjectIntiationAdd(PfmsInitiationDto pfmsinitiationdto, String UserId,String EmpId,String EmpName)
			throws Exception {
		logger.info(new Date() +"Inside ProjectIntiationAdd");
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
		PfmsNotification notification = new PfmsNotification();
		
		pfmsinitiation.setEmpId(Long.parseLong(pfmsinitiationdto.getEmpId()));
		pfmsinitiation.setDivisionId(Long.parseLong(pfmsinitiationdto.getDivisionId()));
		pfmsinitiation.setProjectProgramme(pfmsinitiationdto.getProjectProgramme());
		pfmsinitiation.setProjectTypeId(Long.parseLong(pfmsinitiationdto.getProjectTypeId()));
		pfmsinitiation.setCategoryId(Long.parseLong(pfmsinitiationdto.getCategoryId()));
		pfmsinitiation.setProjectShortName(pfmsinitiationdto.getProjectShortName());
		pfmsinitiation.setProjectTitle(pfmsinitiationdto.getProjectTitle());
		pfmsinitiation.setFeCost(Double.parseDouble(pfmsinitiationdto.getFeCost())* 100000);
		pfmsinitiation.setReCost(Double.parseDouble(pfmsinitiationdto.getReCost())* 100000);
		pfmsinitiation.setProjectCost(Double.parseDouble(pfmsinitiationdto.getFeCost())*100000+Double.parseDouble(pfmsinitiationdto.getReCost())*100000);
		/*
		 * pfmsinitiation.setProjectDuration(Integer.parseInt(pfmsinitiationdto.
		 * getProjectDuration()));
		 */
		pfmsinitiation.setIsPlanned(pfmsinitiationdto.getIsPlanned());
		//pfmsinitiation.setIsMultiLab(pfmsinitiationdto.getIsMultiLab());
		//pfmsinitiation.setDeliverable(pfmsinitiationdto.getDeliverableId());
		
		if(pfmsinitiationdto.getIsMultiLab()!=null && pfmsinitiationdto.getIsMultiLab().equals("Y")) {
		pfmsinitiation.setLabCount(0);
		}
        pfmsinitiation.setProjectStatus("PIN");
		pfmsinitiation.setCreatedBy(UserId);
		pfmsinitiation.setCreatedDate(sdf1.format(new Date()));
		pfmsinitiation.setIsActive(1);
		pfmsinitiation.setIsMain(pfmsinitiationdto.getIsMain());
		pfmsinitiation.setMainId(Long.parseLong(pfmsinitiationdto.getMainId()));
		pfmsinitiation.setNodalLab(Long.parseLong(pfmsinitiationdto.getNodalLab()));
		pfmsinitiation.setRemarks(pfmsinitiationdto.getRemarks());
		pfmsinitiation.setIndicativeCost(Double.parseDouble(pfmsinitiationdto.getIndicativeCost()));
		pfmsinitiation.setPCRemarks(pfmsinitiationdto.getPCRemarks());
		pfmsinitiation.setPCDuration(Long.parseLong(pfmsinitiationdto.getDuration()));
		
		
		notification.setEmpId(Long.parseLong(pfmsinitiationdto.getEmpId()));
		notification.setNotificationby(Long.parseLong(EmpId));
		notification.setNotificationDate(sdf1.format(new Date()));
		notification.setNotificationMessage("Project Initiation Assigned By " + EmpName );
		notification.setNotificationUrl("ProjectIntiationList.htm");
		notification.setCreatedBy(UserId);
		notification.setCreatedDate(sdf1.format(new Date()));
		notification.setIsActive(1);
		notification.setScheduleId(Long.parseLong("0"));
		notification.setStatus("PST");
		
		return dao.ProjectIntiationAdd(pfmsinitiation,notification);
	}

	@Override
	public Long ProjectShortNameCount(String ProjectShortName) throws Exception {
	
		logger.info(new Date() +"Inside ProjectShortNameCount");
		return dao.ProjectShortNameCount(ProjectShortName);
	}

	@Override
	public List<Object[]> ProjectDetailes(Long IntiationId) throws Exception {
	
		logger.info(new Date() +"Inside ProjectDetailes");
		return dao.ProjectDetailes(IntiationId);
	}
	
	@Override
	public List<Object[]> ProjectDetailsPreview(Long IntiationId) throws Exception {
	
		logger.info(new Date() +"Inside ProjectDetailsPreview");
		return dao.ProjectDetailsPreview(IntiationId);
	}

	@Override
	public Long ProjectIntiationAdd(PfmsInitiationDetailDto pfmsinitiationdetaildto, String UserId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationAdd");
		PfmsInitiationDetail pfmsinitiationdetail=new PfmsInitiationDetail();
		
		pfmsinitiationdetail.setInitiationId(Long.parseLong(pfmsinitiationdetaildto.getInitiationId()));
		pfmsinitiationdetail.setRequirements(pfmsinitiationdetaildto.getRequirements());
		pfmsinitiationdetail.setObjective(pfmsinitiationdetaildto.getObjective());
		pfmsinitiationdetail.setScope(pfmsinitiationdetaildto.getScope());
		pfmsinitiationdetail.setMultiLabWorkShare(pfmsinitiationdetaildto.getMultiLabWorkShare());
		pfmsinitiationdetail.setEarlierWork(pfmsinitiationdetaildto.getEarlierWork());
		pfmsinitiationdetail.setCompentencyEstablished(pfmsinitiationdetaildto.getCompentencyEstablished());
		pfmsinitiationdetail.setNeedOfProject(pfmsinitiationdetaildto.getNeedOfProject());
		pfmsinitiationdetail.setTechnologyChallanges(pfmsinitiationdetaildto.getTechnologyChallanges());
		pfmsinitiationdetail.setRiskMitiagation(pfmsinitiationdetaildto.getRiskMitiagation());
		pfmsinitiationdetail.setProposal(pfmsinitiationdetaildto.getProposal());
		pfmsinitiationdetail.setRealizationPlan(pfmsinitiationdetaildto.getRealizationPlan());
		pfmsinitiationdetail.setCreatedBy(UserId);
		pfmsinitiationdetail.setCreatedDate(sdf1.format(new Date()));
		pfmsinitiationdetail.setIsActive(1);
		
		
		
		return dao.ProjectIntiationDetailAdd(pfmsinitiationdetail);
	}

	@Override
	public List<Object[]> BudgetItem(String BudegtId) throws Exception {

		logger.info(new Date() +"Inside BudgetItem");
		return dao.BudgetItem(BudegtId);
	}

	@Override
	public List<Object[]> ProjectIntiationItemList(String InitiationId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationItemList");
		return dao.ProjectIntiationItemList(InitiationId);
	}

	@Override
	public Long ProjectIntiationCostAdd(PfmsInitiationCostDto pfmsinitiationcostdto, String UserId,Object[] ProjectCost) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationCostAdd");
		PfmsInitiationCost pfmsinitiationcost=new PfmsInitiationCost();
		pfmsinitiationcost.setInitiationId(Long.parseLong(pfmsinitiationcostdto.getInitiationId()));
		pfmsinitiationcost.setBudgetHeadId(Long.parseLong(pfmsinitiationcostdto.getBudgetHeadId()));
		
		String Item=pfmsinitiationcostdto.getBudgetItemId();
		
		String[] temp = null;
		String ReFe = "";
		if(Item!=null) {
			temp=Item.split("_");
			ReFe=temp[1];
		}
		
		pfmsinitiationcost.setBudgetItemId(Long.parseLong(temp[0]));
		
//		Double FeCost=Double.parseDouble(pfmsinitiationcostdto.getItemCost());
//		Double ReCost=Double.parseDouble(pfmsinitiationcostdto.getItemCost());
//		
//		if(ProjectCost[0]!=null) {
//			Double ProjectFeCost=Double.parseDouble(ProjectCost[0].toString());
//			FeCost=ProjectFeCost+Double.parseDouble(pfmsinitiationcostdto.getItemCost());
//		}
//		
//		if(ProjectCost[1]!=null) {			
//			Double ProjectReCost=Double.parseDouble(ProjectCost[1].toString());
//			ReCost=ProjectReCost+Double.parseDouble(pfmsinitiationcostdto.getItemCost());		
//		}
//		
		
		
		pfmsinitiationcost.setItemCost(Double.parseDouble(pfmsinitiationcostdto.getItemCost()));
		pfmsinitiationcost.setItemDetail(pfmsinitiationcostdto.getItemDetail());
		pfmsinitiationcost.setCreatedBy(UserId);
		pfmsinitiationcost.setCreatedDate(sdf1.format(new Date()));
		pfmsinitiationcost.setIsActive(1);
	
		
		
		PfmsInitiation pfmsinitiation = new PfmsInitiation();
		long count=dao.ProjectIntiationCostAdd(pfmsinitiationcost,ReFe,pfmsinitiation);
		
		if(count>0)
		{
		double fecost=dao.PfmsInitiationRefeSum(pfmsinitiationcostdto.getInitiationId(), "FE");
		double recost=dao.PfmsInitiationRefeSum(pfmsinitiationcostdto.getInitiationId(), "RE");
		
		
		double totalcost=fecost+recost;
			
			
			pfmsinitiation.setProjectCost(totalcost);
			pfmsinitiation.setReCost(recost);
			pfmsinitiation.setFeCost(fecost);
			pfmsinitiation.setModifiedBy(UserId);
			pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
			pfmsinitiation.setInitiationId(Long.parseLong(pfmsinitiationcostdto.getInitiationId()));
			dao.ProjectIntiationCostsUpdate(pfmsinitiation);
		
		}
		return count;
	}

	@Override
	public int ProjectLabAdd(String [] LabId, String InitiationId, String UserId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectLabAdd");
		Object[] ProjectDetailes= dao.ProjectDetailes(Long.parseLong(InitiationId)).get(0);
		int lastlabcount=0;
		
		if(ProjectDetailes[13]!=null) {
			lastlabcount=Integer.parseInt(ProjectDetailes[13].toString());
		}
		
		List<PfmsInitiationLab> pfmsintiationlablist=new ArrayList<PfmsInitiationLab>();
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
		for(String str:LabId) {
			PfmsInitiationLab pfmsintiationlab=new PfmsInitiationLab();
			pfmsintiationlab.setInitiationId(Long.parseLong(InitiationId));
			pfmsintiationlab.setLabId(Long.parseLong(str));
			pfmsintiationlab.setCreatedBy(UserId);
			pfmsintiationlab.setCreatedDate(sdf1.format(new Date()));
			pfmsintiationlab.setIsActive(1);
			pfmsintiationlablist.add(pfmsintiationlab);
		}
		pfmsinitiation.setInitiationId(Long.parseLong(InitiationId));
		pfmsinitiation.setLabCount(lastlabcount+LabId.length);
		pfmsinitiation.setModifiedBy(UserId);
		pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
		
		
		return dao.ProjectLabAdd(pfmsintiationlablist, pfmsinitiation);
	}

	@Override
	public List<Object[]> ProjectIntiationLabList(String InitiationId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationLabList");
		return dao.ProjectIntiationLabList(InitiationId);
	}

	@Override
	public List<Object[]> BudgetHead() throws Exception {
		
		logger.info(new Date() +"Inside BudgetHead");
		return dao.BudgetHead();
	}

	@Override
	public Long ProjectScheduleAdd(String[] MilestoneActivity, String[] MilestoneMonth, String[] MilestoneRemark, String InitiationId,
			String UserId,Object[] ProjectDetailes,Integer TotalMonth) throws Exception {
		logger.info(new Date() +"Inside ProjectScheduleAdd");
   List<PfmsInitiationSchedule> pfmsinitiationschedulelist=new ArrayList<PfmsInitiationSchedule>();
		int count=dao.ProjectMileStoneNo(InitiationId)+1;
		int count1=0;
		
		
   for(String str:MilestoneActivity) {
	   PfmsInitiationSchedule pfmsinitiationschedule=new PfmsInitiationSchedule();
	   pfmsinitiationschedule.setInitiationId(Long.parseLong(InitiationId));
	   pfmsinitiationschedule.setMilestoneNo(count);
	   pfmsinitiationschedule.setMilestoneActivity(str);
	   pfmsinitiationschedule.setMilestoneMonth(Integer.parseInt(MilestoneMonth[count1]));
	   pfmsinitiationschedule.setMilestoneRemark(MilestoneRemark[count1]);
	   pfmsinitiationschedule.setCreatedBy(UserId);
	   pfmsinitiationschedule.setCreatedDate(sdf1.format(new Date()));
	   pfmsinitiationschedule.setIsActive(1);
	   pfmsinitiationschedulelist.add(pfmsinitiationschedule);
	   count++;
	   count1++;
   }
   
   PfmsInitiation pfmsinitiation=new PfmsInitiation();
   pfmsinitiation.setProjectDuration(TotalMonth);
   
   
		return dao.ProjectScheduleAdd(pfmsinitiationschedulelist,pfmsinitiation);
	}

	@Override
	public List<Object[]> ProjectIntiationScheduleList(String InitiationId) throws Exception {
	
		logger.info(new Date() +"Inside ProjectIntiationScheduleList");
		return dao.ProjectIntiationScheduleList(InitiationId);
	}

	@Override
	public Object[] ProjectProgressCount(String InitiationId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectProgressCount");
		return dao.ProjectProgressCount(InitiationId);
	}
	
	@Override
	public List<Object[]> ProjectIntiationDetailsList(String InitiationId) throws Exception {
	
		logger.info(new Date() +"Inside ProjectIntiationDetailsList");
		return dao.ProjectIntiationDetailsList(InitiationId);
	}
	
	@Override
	public List<Object[]> ProjectIntiationCostList(String InitiationId) throws Exception {
	
		logger.info(new Date() +"Inside ProjectIntiationCostList");
		return dao.ProjectIntiationCostList(InitiationId);
	}

	@Override
	public List<Object[]> ProjectEditData(String IntiationId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectEditData");
		return dao.ProjectEditData(IntiationId);
	}

	@Override
	public int ProjectIntiationEdit(PfmsInitiationDto pfmsinitiationdto, String UserId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationEdit");
		
		int ret=0;
		
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
		
		pfmsinitiation.setInitiationId(Long.parseLong(pfmsinitiationdto.getInitiationId()));
		
		pfmsinitiation.setProjectProgramme(pfmsinitiationdto.getProjectProgramme());
		pfmsinitiation.setProjectTypeId(Long.parseLong(pfmsinitiationdto.getProjectTypeId()));
		pfmsinitiation.setCategoryId(Long.parseLong(pfmsinitiationdto.getCategoryId()));
		pfmsinitiation.setNodalLab(Long.parseLong(pfmsinitiationdto.getNodalLab()));
		pfmsinitiation.setProjectTitle(pfmsinitiationdto.getProjectTitle());
		pfmsinitiation.setIsPlanned(pfmsinitiationdto.getIsPlanned());
		pfmsinitiation.setIsMultiLab(pfmsinitiationdto.getIsMultiLab());
		pfmsinitiation.setDeliverable(pfmsinitiationdto.getDeliverableId());
		if(pfmsinitiationdto.getIsMultiLab().equals("N")) {
			pfmsinitiation.setLabCount(0);
		}
		if(pfmsinitiationdto.getIsPlanned().equalsIgnoreCase("N")) {
			pfmsinitiation.setRemarks(pfmsinitiationdto.getRemarks());
		}else if(pfmsinitiationdto.getIsPlanned().equalsIgnoreCase("P")) {
			pfmsinitiation.setRemarks("");
		}
		
		pfmsinitiation.setModifiedBy(UserId);
		pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
		pfmsinitiation.setIsActive(1);
		pfmsinitiation.setIsMain(pfmsinitiationdto.getIsMain());
		
		pfmsinitiation.setEmpId(Long.parseLong(pfmsinitiationdto.getEmpId()));
		pfmsinitiation.setPCDuration(Long.parseLong(pfmsinitiationdto.getDuration()));
		pfmsinitiation.setPCRemarks(pfmsinitiationdto.getPCRemarks());
		pfmsinitiation.setIndicativeCost(Double.parseDouble(pfmsinitiationdto.getIndicativeCost()));
		
		ret=dao.ProjectIntiationEdit(pfmsinitiation);
		
		List<Object[]> SubProjectList = dao.SubProjectList(pfmsinitiationdto.getInitiationId());
		
		for(int i=0; i<SubProjectList.size();i++) {

			pfmsinitiation.setProjectProgramme(pfmsinitiationdto.getProjectProgramme());
			pfmsinitiation.setProjectTypeId(Long.parseLong(pfmsinitiationdto.getProjectTypeId()));
			pfmsinitiation.setCategoryId(Long.parseLong(pfmsinitiationdto.getCategoryId()));
			pfmsinitiation.setNodalLab(Long.parseLong(pfmsinitiationdto.getNodalLab()));
			pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
			pfmsinitiation.setIsActive(1);
			pfmsinitiation.setInitiationId(Long.parseLong(SubProjectList.get(i)[0].toString()));
			pfmsinitiation.setEmpId(Long.parseLong(pfmsinitiationdto.getPDD()));
			pfmsinitiation.setPCDuration(Long.parseLong(pfmsinitiationdto.getDuration()));
			pfmsinitiation.setPCRemarks(pfmsinitiationdto.getPCRemarks());
			pfmsinitiation.setIndicativeCost(Double.parseDouble(pfmsinitiationdto.getIndicativeCost()));
			
			ret=dao.ProjectIntiationEdit(pfmsinitiation);
		}
		
		return ret;
	}

	@Override
	public Double TotalIntiationCost(String IntiationId) throws Exception {

		logger.info(new Date() +"Inside TotalIntiationCost");
		return dao.TotalIntiationCost(IntiationId);
	}

	@Override
	public List<Object[]> ProjectCostEditData(String InitiationCostId) throws Exception {

		logger.info(new Date() +"Inside ProjectCostEditData");
		return dao.ProjectCostEditData(InitiationCostId);
	}

	@Override
	public int ProjectIntiationCostEdit(PfmsInitiationCostDto pfmsinitiationcostdto,String UserId,String InitiationId,String TotalCost) throws Exception {
		logger.info(new Date() +"Inside ProjectIntiationCostEdit");	
		PfmsInitiationCost pfmsinitiationcost=new PfmsInitiationCost();
			pfmsinitiationcost.setInitiationCostId(Long.parseLong(pfmsinitiationcostdto.getInitiationCostId()));
			//pfmsinitiationcost.setBudgetHeadId(Long.parseLong(pfmsinitiationcostdto.getBudgetHeadId()));
			pfmsinitiationcost.setBudgetItemId(Long.parseLong(pfmsinitiationcostdto.getBudgetItemId()));
			pfmsinitiationcost.setItemCost(Double.parseDouble(pfmsinitiationcostdto.getItemCost()));
			pfmsinitiationcost.setItemDetail(pfmsinitiationcostdto.getItemDetail());
			pfmsinitiationcost.setModifiedBy(UserId);
			pfmsinitiationcost.setModifiedDate(sdf1.format(new Date()));
			pfmsinitiationcost.setIsActive(1);
			
		
		int count=dao.ProjectIntiationCostEdit(pfmsinitiationcost);
		
		double fecost=dao.PfmsInitiationRefeSum(InitiationId, "FE");
		double recost=dao.PfmsInitiationRefeSum(InitiationId, "RE");
		
		
		double totalcost=fecost+recost;
		
		
		if(count > 0)
		{
			
			PfmsInitiation pfmsinitiation=new PfmsInitiation();
			pfmsinitiation.setProjectCost(totalcost);
			pfmsinitiation.setReCost(recost);
			pfmsinitiation.setFeCost(fecost);
			pfmsinitiation.setModifiedBy(UserId);
			pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
			pfmsinitiation.setInitiationId(Long.parseLong(InitiationId));
			dao.ProjectIntiationCostsUpdate(pfmsinitiation);
			
		}
		return  count;
	}

	
	@Override
	public int ProjectScheduleEdit(ProjectScheduleDto projectschedule) throws Exception {

		logger.info(new Date() +"Inside ProjectScheduleEdit");	
		PfmsInitiationSchedule pfmsinitiationschedule=new PfmsInitiationSchedule();
		
		
		pfmsinitiationschedule.setInitiationScheduleId(Long.parseLong(projectschedule.getInitiationScheduleId()));
		pfmsinitiationschedule.setMilestoneActivity(projectschedule.getMileStoneActivity());
		pfmsinitiationschedule.setMilestoneMonth(Integer.parseInt(projectschedule.getMileStoneMonth()));
		pfmsinitiationschedule.setModifiedBy(projectschedule.getUserId());
		pfmsinitiationschedule.setModifiedDate(sdf1.format(new Date()));
		pfmsinitiationschedule.setMilestoneRemark(projectschedule.getMileStoneRemark());
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
		pfmsinitiation.setProjectDuration(projectschedule.getTotalMonth());
		pfmsinitiation.setInitiationId(Long.parseLong(projectschedule.getInitiationId()));

		return dao.ProjectScheduleEdit(pfmsinitiationschedule,pfmsinitiation);
	}

	@Override
	public int ProjectScheduleDelete(String InitiationScheduleId, String UserId,Integer TotalMonth,String InitiationId) throws Exception {
		logger.info(new Date() +"Inside ProjectScheduleDelete");	
		PfmsInitiationSchedule pfmsinitiationschedule=new PfmsInitiationSchedule();
		pfmsinitiationschedule.setInitiationScheduleId(Long.parseLong(InitiationScheduleId));
		pfmsinitiationschedule.setModifiedBy(UserId);
		pfmsinitiationschedule.setModifiedDate(sdf1.format(new Date()));
		
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
		pfmsinitiation.setProjectDuration(TotalMonth);
		pfmsinitiation.setInitiationId(Long.parseLong(InitiationId));
		
		return dao.ProjectScheduleDelete(pfmsinitiationschedule,pfmsinitiation);
	}

	@Override
	public Long ProjectInitiationDetailsUpdate(PfmsInitiationDetailDto pfmsinitiationdetaildto, String UserId,String Details) throws Exception{
		
		logger.info(new Date() +"Inside ProjectInitiationDetailsUpdate");
		PfmsInitiationDetail pfmsinitiationdetail=new PfmsInitiationDetail();
		
		if(Details.equalsIgnoreCase("requirement")) {
			pfmsinitiationdetail.setRequirements(pfmsinitiationdetaildto.getRequirements());
		}
		if(Details.equalsIgnoreCase("objective")) {
			pfmsinitiationdetail.setObjective(pfmsinitiationdetaildto.getObjective());
		}
		if(Details.equalsIgnoreCase("scope")) {
			pfmsinitiationdetail.setScope(pfmsinitiationdetaildto.getScope());
		}
		if(Details.equalsIgnoreCase("multilab")) {
			pfmsinitiationdetail.setMultiLabWorkShare(pfmsinitiationdetaildto.getMultiLabWorkShare());
		}
		if(Details.equalsIgnoreCase("earlierwork")) {
			pfmsinitiationdetail.setEarlierWork(pfmsinitiationdetaildto.getEarlierWork());
		}
		if(Details.equalsIgnoreCase("competency")) {
			pfmsinitiationdetail.setCompentencyEstablished(pfmsinitiationdetaildto.getCompentencyEstablished());
		}
		if(Details.equalsIgnoreCase("needofproject")) {
			pfmsinitiationdetail.setNeedOfProject(pfmsinitiationdetaildto.getNeedOfProject());
		}
		if(Details.equalsIgnoreCase("technology")) {
			pfmsinitiationdetail.setTechnologyChallanges(pfmsinitiationdetaildto.getTechnologyChallanges());
		}
		if(Details.equalsIgnoreCase("riskmitigation")) {
			pfmsinitiationdetail.setRiskMitiagation(pfmsinitiationdetaildto.getRiskMitiagation());
		}
		if(Details.equalsIgnoreCase("proposal")) {
			pfmsinitiationdetail.setProposal(pfmsinitiationdetaildto.getProposal());
		}
		if(Details.equalsIgnoreCase("realization")) {
			pfmsinitiationdetail.setRealizationPlan(pfmsinitiationdetaildto.getRealizationPlan());
		}
		
		pfmsinitiationdetail.setInitiationId(Long.parseLong(pfmsinitiationdetaildto.getInitiationId()));
		pfmsinitiationdetail.setModifiedBy(UserId);
		pfmsinitiationdetail.setModifiedDate(sdf1.format(new Date()));
		
		
		return dao.ProjectInitiationDetailsUpdate(pfmsinitiationdetail,Details);
	}

	@Override
	public Integer ProjectScheduleMonth(String InitiationId) throws Exception {
	
		logger.info(new Date() +"Inside ProjectScheduleMonth");
		return dao.ProjectScheduleMonth(InitiationId);
	}

	@Override
	public int ProjectScheduleEditData(String InitiationScheduleId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectScheduleEditData");
		return dao.ProjectScheduleEditData(InitiationScheduleId);
	}

	@Override
	public Long ProjectInitiationAttachmentAdd(PfmsInitiationAttachmentDto pfmsinitiationattachmentdto,
			PfmsInitiationAttachmentFileDto pfmsinitiationattachmentfiledto,String UserId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectInitiationAttachmentAdd");
		PfmsInitiationAttachment pfmsinitiationattachment=new PfmsInitiationAttachment();
		pfmsinitiationattachment.setInitiationId(Long.parseLong(pfmsinitiationattachmentdto.getInitiationId()));
		pfmsinitiationattachment.setFileName(pfmsinitiationattachmentdto.getFileName());
		pfmsinitiationattachment.setFileNamePath(pfmsinitiationattachmentdto.getFileNamePath());
		pfmsinitiationattachment.setCreatedBy(UserId);
		pfmsinitiationattachment.setCreatedDate(sdf1.format(new Date()));
		pfmsinitiationattachment.setIsActive(1);

		PfmsInitiationAttachmentFile pfmsinitiationattachmentfile=new PfmsInitiationAttachmentFile();
		pfmsinitiationattachmentfile.setFilePath(pfmsinitiationattachmentfiledto.getFilePath());
		pfmsinitiationattachmentfile.setFileName(pfmsinitiationattachmentdto.getFileNamePath());
		
		return dao.ProjectInitiationAttachmentAdd(pfmsinitiationattachment, pfmsinitiationattachmentfile);
	}
	
	@Override
	public List<Object[]> ProjectIntiationAttachment(String InitiationId) throws Exception {
	
		logger.info(new Date() +"Inside ProjectIntiationAttachment");
		return dao.ProjectIntiationAttachment(InitiationId);
	}
	
	@Override
	public List<Object[]> AuthorityAttachment(String InitiationId) throws Exception {
	
		logger.info(new Date() +"Inside AuthorityAttachment");
		return dao.AuthorityAttachment(InitiationId);
	}
	
	

	@Override
	public PfmsInitiationAttachmentFile ProjectIntiationAttachmentFile(String InitiationAttachmentId) throws Exception {

		logger.info(new Date() +"Inside ProjectIntiationAttachmentFile");
		return dao.ProjectIntiationAttachmentFile(InitiationAttachmentId);
	}

	@Override
	public int ProjectInitiationAttachmentDelete(String InitiationAttachmentId,String UserId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectInitiationAttachmentDelete");
		PfmsInitiationAttachment pfmsinitiationattachment=new PfmsInitiationAttachment();
		pfmsinitiationattachment.setInitiationAttachmentId(Long.parseLong(InitiationAttachmentId));
		
		pfmsinitiationattachment.setModifiedBy(UserId);
		pfmsinitiationattachment.setModifiedDate(sdf1.format(new Date()));
		return dao.ProjectInitiationAttachmentDelete(pfmsinitiationattachment);
	}

	@Override
	public int ProjectInitiationAttachmentUpdate(String InitiationAttachmentId, String FileName, String UserId)
			throws Exception {
		
		logger.info(new Date() +"Inside ProjectInitiationAttachmentUpdate");
		PfmsInitiationAttachment pfmsinitiationattachment=new PfmsInitiationAttachment();
		pfmsinitiationattachment.setInitiationAttachmentId(Long.parseLong(InitiationAttachmentId));
		pfmsinitiationattachment.setFileName(FileName);
		pfmsinitiationattachment.setModifiedBy(UserId);
		pfmsinitiationattachment.setModifiedDate(sdf1.format(new Date()));
		return dao.ProjectInitiationAttachmentUpdate(pfmsinitiationattachment);
	}

	@Override
	public String ProjectIntiationAttachmentFileName(String InitiationAttachmentId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationAttachmentFileName");
		return dao.ProjectIntiationAttachmentFileName(InitiationAttachmentId);
	}
	
	@Override
	public String ProjectIntiationAttachmentFileNamePath(String InitiationAttachmentId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationAttachmentFileNamePath");
		return dao.ProjectIntiationAttachmentFileNamePath(InitiationAttachmentId);
	}

	@Override
	public int ProjectLabDelete(String initiationlabid, String InitiationId, String UserId) throws Exception {
		logger.info(new Date() +"Inside ProjectLabDelete");
		Object[] ProjectDetailes= dao.ProjectDetailes(Long.parseLong(InitiationId)).get(0);
		int lastlabcount=0;
		
		if(ProjectDetailes[13]!=null) {
			lastlabcount=Integer.parseInt(ProjectDetailes[13].toString());
		}
		
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
	
			PfmsInitiationLab pfmsintiationlab=new PfmsInitiationLab();
			pfmsintiationlab.setInitiationLabId(Long.parseLong(initiationlabid));
			pfmsintiationlab.setLabId(Long.parseLong(initiationlabid));
			pfmsintiationlab.setModifiedBy(UserId);
			pfmsintiationlab.setModifiedDate(sdf1.format(new Date()));
		
		
	
		pfmsinitiation.setInitiationId(Long.parseLong(InitiationId));
		pfmsinitiation.setLabCount(lastlabcount-1);
		pfmsinitiation.setModifiedBy(UserId);
		pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
		
		
		return dao.ProjectLabdelete(pfmsintiationlab, pfmsinitiation);
	}

	@Override
	public int ProjectIntiationCostDelete(String initiationcostid, String UserId,String InitiationId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationCostDelete");
		PfmsInitiationCost pfmsinitiationcost=new PfmsInitiationCost();
		pfmsinitiationcost.setInitiationCostId(Long.parseLong(initiationcostid));
	
	
		pfmsinitiationcost.setModifiedBy(UserId);
		pfmsinitiationcost.setModifiedDate(sdf1.format(new Date()));
		pfmsinitiationcost.setIsActive(1);
		int count=dao.ProjectIntiationCostDelete(pfmsinitiationcost);
		if(count>0)
		{
			double fecost=dao.PfmsInitiationRefeSum(InitiationId, "FE");
			double recost=dao.PfmsInitiationRefeSum(InitiationId, "RE");
			
			
			double totalcost=fecost+recost;
			
			
			if(count > 0)
			{
				
				PfmsInitiation pfmsinitiation=new PfmsInitiation();
				pfmsinitiation.setProjectCost(totalcost);
				pfmsinitiation.setReCost(recost);
				pfmsinitiation.setFeCost(fecost);
				pfmsinitiation.setModifiedBy(UserId);
				pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
				pfmsinitiation.setInitiationId(Long.parseLong(InitiationId));
				dao.ProjectIntiationCostsUpdate(pfmsinitiation);
				
			}
		}
		
		return count;
	}






	@Override
	public int ProjectIntiationStatusUpdate(String InitiationId, String UserId,String EmpId,String ProjectCode) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationStatusUpdate");
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
		PfmsApproval pfmsapproval=new PfmsApproval();
		PfmsNotification notification= new PfmsNotification();
		
		pfmsinitiation.setInitiationId(Long.parseLong(InitiationId));
		pfmsinitiation.setProjectStatus("PST");
		pfmsinitiation.setModifiedBy(UserId);
		pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
		
		pfmsapproval.setInitiationId(Long.parseLong(InitiationId));
		pfmsapproval.setProjectStatus("PST");
		pfmsapproval.setEmpId(Long.parseLong(EmpId));
		pfmsapproval.setActionBy(UserId);
		pfmsapproval.setActionDate(sdf1.format(new Date()));
		
		BigInteger DivisionHeadId= dao.DivisionHeadId(EmpId);
		notification.setEmpId(DivisionHeadId.longValue());
		notification.setNotificationby(Long.parseLong(EmpId));
		notification.setNotificationDate(sdf1.format(new Date()));
		notification.setNotificationMessage("Pending Project Approval for " + ProjectCode + " from User");
		notification.setNotificationUrl("ProjectApprovalPd.htm");
		notification.setCreatedBy(UserId);
		notification.setCreatedDate(sdf1.format(new Date()));
		notification.setIsActive(1);
		notification.setScheduleId(Long.parseLong("0"));
		notification.setStatus("PST");
		
		return dao.ProjectIntiationStatusUpdate(pfmsinitiation,pfmsapproval,notification);
	}

	@Override
	public Long ProjectForwardStatus(String InitiationId) throws Exception {
	
		logger.info(new Date() +"Inside ProjectForwardStatus");
		return dao.ProjectForwardStatus(InitiationId);
	}

	@Override
	public List<Object[]> ProjectActionList(String ProjectAuthorityId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectActionList");
		return dao.ProjectActionList(ProjectAuthorityId);
	}

	@Override
	public List<Object[]> ProjectApprovePdList(String EmpId) throws Exception {
	
		logger.info(new Date() +"Inside ProjectApprovePdList");
		return dao.ProjectApprovePdList(EmpId);
	}

	@Override
	public int ProjectApprovePd(String InitiationId, String Remark, String UserId, String EmpId,String ProjectCode,String Status) throws Exception {
		logger.info(new Date() +"Inside ProjectApprovePd");
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
		PfmsApproval pfmsapproval=new PfmsApproval();
		PfmsNotification notification= new PfmsNotification();
		
		pfmsinitiation.setInitiationId(Long.parseLong(InitiationId));
		pfmsinitiation.setProjectStatus(Status);
		pfmsinitiation.setModifiedBy(UserId);
		pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
		
		pfmsapproval.setInitiationId(Long.parseLong(InitiationId));
		pfmsapproval.setProjectStatus(Status);
		pfmsapproval.setRemarks(Remark);
		pfmsapproval.setEmpId(Long.parseLong(EmpId));
		pfmsapproval.setActionBy(UserId);
		pfmsapproval.setActionDate(sdf1.format(new Date()));
		String massage="";
		try {
			massage=dao.StatusDetails(Status);
		} catch (Exception e) {

		}
		BigInteger Empid=dao.EmpId(InitiationId);
		BigInteger RtmddoId= dao.RtmddoId();
		if(Status.equalsIgnoreCase("DOR")) {
			notification.setEmpId(RtmddoId.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from DO");	
			notification.setNotificationUrl("ProjectApprovalRtmddo.htm");
		}else if(Status.equalsIgnoreCase("DOI")) {
			notification.setEmpId(Empid.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from DO");	
			notification.setNotificationUrl("ProjectIntiationList.htm");
		}
		
		notification.setNotificationby(Long.parseLong(EmpId));
		notification.setNotificationDate(sdf1.format(new Date()));
		
		
		notification.setCreatedBy(UserId);
		notification.setCreatedDate(sdf1.format(new Date()));
		notification.setIsActive(1);
		notification.setScheduleId(Long.parseLong("0"));
		notification.setStatus(Status);
		
		return dao.ProjectApprove(pfmsinitiation,pfmsapproval,notification);
	}



	@Override
	public List<Object[]> EmployeeList() throws Exception {
		
		logger.info(new Date() +"Inside EmployeeList");
		return dao.EmployeeList();
	}


	@Override
	public List<Object[]> ProjectStatusList(String EmpId,String LoginType) throws Exception{
		
		logger.info(new Date() +"Inside ProjectStatusList");
		return dao.ProjectStatusList(EmpId,LoginType);
	}
	
	@Override
	public List<Object[]> ProjectApprovalTracking(String InitiationId) throws Exception{
		
		logger.info(new Date() +"Inside ProjectApprovalTracking");
		return dao.ProjectApprovalTracking(InitiationId);
	}


	@Override
	public List<Object[]> ProjectApproveRtmddoList(String EmpId) throws Exception {

		logger.info(new Date() +"Inside ProjectApproveRtmddoList");
		return dao.ProjectApproveRtmddoList(EmpId);
	}
	
	@Override
	public List<Object[]> ProjectApproveAdList(String EmpId) throws Exception {
		logger.info(new Date() +"Inside ProjectApproveAdList");
		return dao.ProjectApproveAdList(EmpId);
	}
	
	@Override
	public int ProjectApproveAd(String InitiationId, String Remark, String UserId, String EmpId,String ProjectCode,String Status) throws Exception {
		logger.info(new Date() +"Inside ProjectApproveAd");
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
		PfmsApproval pfmsapproval=new PfmsApproval();
		PfmsNotification notification=new PfmsNotification();
		
		pfmsinitiation.setInitiationId(Long.parseLong(InitiationId));
		pfmsinitiation.setProjectStatus(Status);
		pfmsinitiation.setModifiedBy(UserId);
		pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
		
		pfmsapproval.setInitiationId(Long.parseLong(InitiationId));
		pfmsapproval.setProjectStatus(Status);
		pfmsapproval.setRemarks(Remark);
		pfmsapproval.setEmpId(Long.parseLong(EmpId));
		pfmsapproval.setActionBy(UserId);
		pfmsapproval.setActionDate(sdf1.format(new Date()));
		
		String massage="";
		try {
			massage=dao.StatusDetails(Status);
		} catch (Exception e) {

		}
		BigInteger Empid=dao.EmpId(InitiationId);
		BigInteger DivisionHeadId= dao.DivisionHeadId(Empid.toString());
		BigInteger DORTMTDId= dao.RtmddoId();
		BigInteger TccChairpersonId= dao.TccChairpersonId();
		if(Status.equalsIgnoreCase("ADR")) {
			notification.setEmpId(TccChairpersonId.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from AD");	
			notification.setNotificationUrl("ProjectApprovalTcc.htm");
		}else if(Status.equalsIgnoreCase("ADI")) {
			notification.setEmpId(Empid.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from AD");	
			notification.setNotificationUrl("ProjectIntiationList.htm");
		}else if(Status.equalsIgnoreCase("ADO")) {
			notification.setEmpId(DivisionHeadId.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from AD");	
			notification.setNotificationUrl("ProjectApprovalPd.htm");
		}else if(Status.equalsIgnoreCase("ADT")) {
			notification.setEmpId(DORTMTDId.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from AD");	
			notification.setNotificationUrl("ProjectApprovalRtmddo.htm");
		}
		

		notification.setNotificationby(Long.parseLong(EmpId));
		notification.setNotificationDate(sdf1.format(new Date()));
		notification.setCreatedBy(UserId);
		notification.setCreatedDate(sdf1.format(new Date()));
		notification.setIsActive(1);
		notification.setScheduleId(Long.parseLong("0"));
		notification.setStatus(Status);
		
		return dao.ProjectApprove(pfmsinitiation,pfmsapproval,notification);
	}

	@Override
	public int ProjectApproveRtmddo(String InitiationId, String Remark, String UserId, String EmpId,String ProjectCode,String Status) throws Exception {
		logger.info(new Date() +"Inside ProjectApproveRtmddo");
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
		PfmsApproval pfmsapproval=new PfmsApproval();
		PfmsNotification notification=new PfmsNotification();
		
		pfmsinitiation.setInitiationId(Long.parseLong(InitiationId));
		pfmsinitiation.setProjectStatus(Status);
		pfmsinitiation.setModifiedBy(UserId);
		pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
		
		pfmsapproval.setInitiationId(Long.parseLong(InitiationId));
		pfmsapproval.setProjectStatus(Status);
		pfmsapproval.setRemarks(Remark);
		pfmsapproval.setEmpId(Long.parseLong(EmpId));
		pfmsapproval.setActionBy(UserId);
		pfmsapproval.setActionDate(sdf1.format(new Date()));
		String massage="";
		try {
			massage=dao.StatusDetails(Status);
		} catch (Exception e) {

		}
		BigInteger Empid=dao.EmpId(InitiationId);
		BigInteger DivisionHeadId= dao.DivisionHeadId(Empid.toString());
		BigInteger TccChairpersonId= dao.AdId();
		if(Status.equalsIgnoreCase("RTR")) {
			notification.setEmpId(TccChairpersonId.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from RTMDDO");	
			notification.setNotificationUrl("ProjectApprovalAd.htm");
		}else if(Status.equalsIgnoreCase("RTI")) {
			notification.setEmpId(Empid.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from RTMDDO");	
			notification.setNotificationUrl("ProjectIntiationList.htm");
		}else if(Status.equalsIgnoreCase("RTD")) {
			notification.setEmpId(DivisionHeadId.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from RTMDDO");	
			notification.setNotificationUrl("ProjectApprovalPd.htm");
		}
		

		notification.setNotificationDate(sdf1.format(new Date()));

		notification.setCreatedBy(UserId);
		notification.setCreatedDate(sdf1.format(new Date()));
		notification.setIsActive(1);
		notification.setScheduleId(Long.parseLong("0"));
		notification.setStatus(Status);
		
		return dao.ProjectApprove(pfmsinitiation,pfmsapproval,notification);
		
	}

	@Override
	public List<Object[]> ProjectApproveTccList(String EmpId) throws Exception {

		logger.info(new Date() +"Inside ProjectApproveTccList");
		return dao.ProjectApproveTccList(EmpId);
	}

	@Override
	public int ProjectApproveTcc(String InitiationId, String Remark, String UserId, String EmpId,String ProjectCode,String Status) throws Exception {
		
		logger.info(new Date() +"Inside ProjectApproveTcc");
		PfmsInitiation pfmsinitiation=new PfmsInitiation();
		PfmsApproval pfmsapproval=new PfmsApproval();
		PfmsNotification notification=new PfmsNotification();
		
		pfmsinitiation.setInitiationId(Long.parseLong(InitiationId));
		pfmsinitiation.setProjectStatus(Status);
		pfmsinitiation.setModifiedBy(UserId);
		pfmsinitiation.setModifiedDate(sdf1.format(new Date()));
		
		pfmsapproval.setInitiationId(Long.parseLong(InitiationId));
		pfmsapproval.setProjectStatus(Status);
		pfmsapproval.setRemarks(Remark);
		pfmsapproval.setEmpId(Long.parseLong(EmpId));
		pfmsapproval.setActionBy(UserId);
		pfmsapproval.setActionDate(sdf1.format(new Date()));
		
		String massage="";
		try {
			massage=dao.StatusDetails(Status);
		} catch (Exception e) {

		}
		BigInteger Empid=dao.EmpId(InitiationId);
		BigInteger DivisionHeadId= dao.DivisionHeadId(Empid.toString());
		BigInteger TccChairpersonId= dao.AdId();
		BigInteger CcmChairpersonId= dao.CcmChairpersonId();
		BigInteger DORTMTDId= dao.RtmddoId();
		if(Status.equalsIgnoreCase("PTA")||Status.equalsIgnoreCase("PDR")) {
			notification.setEmpId(CcmChairpersonId.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from TCM");	
			notification.setNotificationUrl("ProjectApprovalTcc.htm");
		}else if(Status.equalsIgnoreCase("PTI")||Status.equalsIgnoreCase("DRI")) {
			notification.setEmpId(Empid.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from TCM");	
			notification.setNotificationUrl("ProjectIntiationList.htm");
		}else if(Status.equalsIgnoreCase("PTD")||Status.equalsIgnoreCase("DRD")) {
			notification.setEmpId(DivisionHeadId.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from TCM");	
			notification.setNotificationUrl("ProjectApprovalPd.htm");
		}else if(Status.equalsIgnoreCase("PTR")||Status.equalsIgnoreCase("DRR")) {
			notification.setEmpId(DORTMTDId.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from TCM");	
			notification.setNotificationUrl("ProjectApprovalRtmddo.htm");
		}else if(Status.equalsIgnoreCase("PTY")||Status.equalsIgnoreCase("DAD")) {
			notification.setEmpId(TccChairpersonId.longValue());
			notification.setNotificationMessage("Pending Project "+massage+" for " + ProjectCode + " from TCM");	
			notification.setNotificationUrl("ProjectApprovalAd.htm");
		}
		
	
		notification.setNotificationby(Long.parseLong(EmpId));
		notification.setNotificationDate(sdf1.format(new Date()));
		notification.setCreatedBy(UserId);
		notification.setCreatedDate(sdf1.format(new Date()));
		notification.setIsActive(1);
		notification.setScheduleId(Long.parseLong("0"));
		notification.setStatus(Status);
		
		
		return dao.ProjectApprove(pfmsinitiation,pfmsapproval,notification);
		
	}





	@Override
	public Double TotalIntiationFeCost(String IntiationId) throws Exception {
	
		logger.info(new Date() +"Inside TotalIntiationFeCost");
		return dao.TotalIntiationFeCost(IntiationId);
	}

	@Override
	public Double TotalIntiationReCost(String IntiationId) throws Exception {
		
		logger.info(new Date() +"Inside TotalIntiationReCost");
		return dao.TotalIntiationReCost(IntiationId);
	}

	@Override
	public List<Object[]> ProjectCost(Long IntiationId) throws Exception {

		logger.info(new Date() +"Inside ProjectCost");
		return dao.ProjectCost(IntiationId);
	}


	

	
	@Override
	public List<Object[]> TccProjectList() throws Exception {

		logger.info(new Date() +"Inside TccProjectList");
		return dao.TccProjectList();
	}


	@Override
	public List<Object[]> ExpertList() throws Exception {

		logger.info(new Date() +"Inside ExpertList");
		return dao.ExpertList();
	}



	
	@Override
	public List<Object[]> NotInvitedEmployeeList(List<Object[]> TccMemberList,List<Object[]> tccinvitedlist, Object[] TccData) throws Exception
	{
		List<Object[]> EmployeeList=dao.EmployeeList();
		
		if(tccinvitedlist.size()>0)
		{
			for(int i=0;i<tccinvitedlist.size();i++)
			{
				for(int j=0;j<EmployeeList.size();j++)
				{
					
					if(EmployeeList.get(j)[0].toString().equals(tccinvitedlist.get(i)[0].toString()) && !tccinvitedlist.get(i)[3].toString().equals("E")  )
					{
						EmployeeList.remove(j);
					}
				
				}
			}
			return EmployeeList;
		}	
		else 
		{
			for(int j=0;j<TccMemberList.size();j++) 
			{
				for(int i=0;i<EmployeeList.size();i++)
				{
					
					if(EmployeeList.get(i)[0].toString().equals(TccMemberList.get(j)[4].toString()))
					{
						EmployeeList.remove(i);						
					}
				}			
				
			for(int i=0;i<EmployeeList.size();i++)
			{
				if( EmployeeList.get(i)[0].toString().equals(TccData[8].toString()))
				{
					EmployeeList.remove(i);	
				}
				if(EmployeeList.get(i)[0].toString().equals(TccData[7].toString()))
				{
					
					EmployeeList.remove(i);	
				}
			}
				
			}
			return EmployeeList;
		}
	}
	

	
	@Override
	public List<Object[]> NotInvitedExpertList(List<Object[]> tccinvitedlist) throws Exception
	{
		List<Object[]> ExpertList=dao.ExpertList();
		
		for(int i=0;i<tccinvitedlist.size();i++)
		{
			for(int j=0;j<ExpertList.size();j++)
			{
				if(tccinvitedlist.get(i)[3].toString().equals("E"))
				{
					if(ExpertList.get(j)[0].toString().equals(tccinvitedlist.get(i)[0].toString()))
					{
						ExpertList.remove(j);
					}
				}
			}
		}
		return ExpertList;
	}


   @Override
	public List<Object[]> ProjectMainList() throws Exception {
		
		return dao.ProjectMainList();
	}
	
	@Override
	public List<Object[]> ProjectList() throws Exception {
		
		return dao.ProjectList();
	}
	
	@Override
	public List<Object[]> ProjectTypeMainList() throws Exception {
	
		return dao.ProjectTypeMainList();
	}

	@Override
	public List<Object[]> ProjectCategoryList() throws Exception {
		
		return dao.ProjectCategoryList();
	}
	
	@Override
	public Long ProjectMasterAdd(ProjectMaster proType) throws Exception {
		
		return dao.ProjectMasterAdd(proType);
	}
	
	@Override
	public Long ProjectEdit(ProjectMaster proType) throws Exception {
		
		return dao.ProjectEdit(proType);
	}
	
	

	@Override
	public Long ProjectClose(ProjectMaster proType) throws Exception {
	
		return dao.ProjectClose(proType);
	}
	@Override
	public Object[] ProjectEditData1(String ProjectId) throws Exception {
	
		return dao.ProjectEditData1(ProjectId);
	}
	
	public List<Object[]> getProjectList() throws Exception{
		List<Object[]> projectList=dao.getProjectList();

		return projectList;
	}
	
	@Override
	public List<Object[]> ProjectAssignList(String EmpId) throws Exception {
		
		return dao.ProjectAssignList(EmpId);
	}
	
	@Override
	public List<Object[]> UserList(String proId) throws Exception {
		
		return dao.UserList(proId);
	}
	
	@Override
	public Object[] ProjectData(String ProId) throws Exception {
		
		return dao.ProjectData(ProId);
	}
	
	@Override
	public Long ProjectAssignAdd(ProjectAssignDto dto) throws Exception {
		logger.info(new Date() +"Inside ProjectAssignAdd");
		long count=0;
		for(int i=0 ; i<dto.getEmpId().length;i++)
		{
			ProjectAssign proAssign = new ProjectAssign();
			proAssign.setProjectId(Long.parseLong(dto.getProjectId()));
			proAssign.setCreatedBy(dto.getCreatedBy());
			proAssign.setCreatedDate(sdf1.format(new Date()));
			proAssign.setEmpId(Long.parseLong(dto.getEmpId()[i]));
			proAssign.setIsActive(1);
			
			count=dao.ProjectAssignAdd(proAssign);
		}
		
		return count;
	}
	

	@Override
	public Long ProjectRevoke(ProjectAssign proAssign) throws Exception {
		logger.info(new Date() +"Inside ProjectRevoke");
		return dao.ProjectRevoke(proAssign);
	}

	
	@Override
	public List<Object[]> ApprovalStutusList(String InitiationId) throws Exception {
		List<Object[]>  list=new ArrayList<Object[]>();
		Object[] obj=dao.ProjectEditData(InitiationId).get(0);
		if(1000000>=Double.parseDouble(obj[8].toString())) {
		list=dao.ApprovalStutusList("6");
		}else {
			list=dao.ApprovalStutusList("4");
		}
		return list;
	}
	
/*-------------------------------------------------------------------------------------------------------------------------------*/	
	
		@Override
		public long ProjectDataSubmit(PfmsProjectDataDto dto) throws Exception {
			
			logger.info(new Date() +"Inside ProjectDataSubmit");
			
			Timestamp instant= Timestamp.from(Instant.now());
			String timestampstr = instant.toString().replace(" ","").replace(":", "").replace("-", "").replace(".","");
			
			PfmsProjectData model=new PfmsProjectData();
			model.setProjectId(Long.parseLong(dto.getProjectId()));
			model.setCurrentStageId(Integer.parseInt(dto.getCurrentStageId()));
			model.setFilesPath(uploadpath);
			
			if(!dto.getSystemConfigImg().isEmpty()) {
				model.setSystemConfigImgName("configimg"+timestampstr+"."+FilenameUtils.getExtension(dto.getSystemConfigImg().getOriginalFilename()));
				saveFile(uploadpath, model.getSystemConfigImgName(), dto.getSystemConfigImg());
			}else
			{
				model.setSystemConfigImgName(null);
			}
//	--------------------------------------------------------------		
			if(!dto.getSystemSpecsFile().isEmpty()) {
				model.setSystemSpecsFileName("specsfile"+timestampstr+"."+FilenameUtils.getExtension(dto.getSystemSpecsFile().getOriginalFilename()));
				saveFile(uploadpath, model.getSystemSpecsFileName(), dto.getSystemSpecsFile());
			}else
			{
				model.setSystemSpecsFileName(null);
			}
//	--------------------------------------------------------------		
			if(!dto.getProductTreeImg().isEmpty()) {
				model.setProductTreeImgName("producttree"+timestampstr+"."+FilenameUtils.getExtension(dto.getProductTreeImg().getOriginalFilename()));
				saveFile(uploadpath, model.getProductTreeImgName(), dto.getProductTreeImg());
			}else
			{
				model.setProductTreeImgName(null);
			}
//	--------------------------------------------------------------		
			if(!dto.getPEARLImg().isEmpty()) {
				model.setPEARLImgName("pearlimg"+timestampstr+"."+FilenameUtils.getExtension(dto.getPEARLImg().getOriginalFilename()));
				saveFile(uploadpath, model.getPEARLImgName(), dto.getPEARLImg());
			}else
			{
				model.setPEARLImgName(null);
			}
// ---------------------------------------------------------------
			
			
			
			model.setCreatedBy(dto.getCreatedBy());
			model.setCreatedDate(sdf1.format(new Date()));
			model.setRevisionNo(0);
			model.setProcLimit(Double.parseDouble(dto.getProcLimit()));
			File theDir = new File(uploadpath);
			if (!theDir.exists()){
			    theDir.mkdirs();
			}
			
			
			
			return dao.ProjectDataSubmit(model);
		}
	
	
	    public static void saveFile(String uploadpath, String fileName, MultipartFile multipartFile) throws IOException 
	    {
	        Path uploadPath = Paths.get(uploadpath);
	          
	        if (!Files.exists(uploadPath)) {
	            Files.createDirectories(uploadPath);
	        }
	        
	        try (InputStream inputStream = multipartFile.getInputStream()) {
	            Path filePath = uploadPath.resolve(fileName);
	            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	        } catch (IOException ioe) {       
	            throw new IOException("Could not save image file: " + fileName, ioe);
	        }     
	    }
	    /*-------------------------------------------------------------------------------------------------------------------------------*/
	    
	    @Override
		public List<Object[]> ProjectStageDetailsList() throws Exception {
			logger.info(new Date() +"Inside ProjectStageDetailsList");
			return dao.ProjectStageDetailsList();
		}
	
		@Override
		public Object[] ProjectDataDetails(String projectid) throws Exception {
			logger.info(new Date()  +"Inside ProjectDataDetails");
			return dao.ProjectDataDetails(projectid);
		}
		
		@Override
		public long ProjectDataEditSubmit(PfmsProjectDataDto dto) throws Exception {
			logger.info(new Date() +"Inside ProjectDataSubmit");
			
			Timestamp instant= Timestamp.from(Instant.now());
			String timestampstr = instant.toString().replace(" ","").replace(":", "").replace("-", "").replace(".","");
			String query="";
			
			PfmsProjectData model=new PfmsProjectData();
			model.setProjectId(Long.parseLong(dto.getProjectId()));
			model.setProjectDataId(Long.parseLong(dto.getProjectDataId()));
			model.setCurrentStageId(Integer.parseInt(dto.getCurrentStageId()));
			model.setFilesPath(uploadpath);
			if(!dto.getSystemConfigImg().isEmpty()) {
				model.setSystemConfigImgName("configimg"+timestampstr+"."+FilenameUtils.getExtension(dto.getSystemConfigImg().getOriginalFilename()));
				saveFile(uploadpath, model.getSystemConfigImgName(), dto.getSystemConfigImg());
				query=query+"SystemConfigImgName='"+model.getSystemConfigImgName()+"',";
			}			
			if(!dto.getSystemSpecsFile().isEmpty()) {
				model.setSystemSpecsFileName("specsfile"+timestampstr+"."+FilenameUtils.getExtension(dto.getSystemSpecsFile().getOriginalFilename()));
				saveFile(uploadpath, model.getSystemSpecsFileName(), dto.getSystemSpecsFile());
				query=query+"SystemSpecsFileName='"+model.getSystemSpecsFileName()+"',";
			}
			if(!dto.getProductTreeImg().isEmpty()) {
				model.setProductTreeImgName("producttree"+timestampstr+"."+FilenameUtils.getExtension(dto.getProductTreeImg().getOriginalFilename()));
				saveFile(uploadpath, model.getProductTreeImgName(), dto.getProductTreeImg());
				query=query+"ProductTreeImgName='"+model.getProductTreeImgName()+"',";
			}
			if(!dto.getPEARLImg().isEmpty()) {
				model.setPEARLImgName("pearlimg"+timestampstr+"."+FilenameUtils.getExtension(dto.getPEARLImg().getOriginalFilename()));
				saveFile(uploadpath, model.getPEARLImgName(), dto.getPEARLImg());
				query=query+"PEARLImgName='"+model.getPEARLImgName()+"',";
			}
			model.setModifiedBy(dto.getModifiedBy());
			model.setModifiedDate(sdf1.format(new Date()));
			model.setRevisionNo(Long.parseLong(dto.getRevisionNo()));
			model.setProcLimit(Double.parseDouble(dto.getProcLimit()));
			
			
			return dao.ProjectDataEditSubmit(model, query);
		}
		
		@Override
		public Object[] ProjectDataSpecsFileData(String projectdataid) throws Exception
		{
			logger.info(new Date() +"Inside ProjectDataSpecsFileData");
			return dao.ProjectDataSpecsFileData(projectdataid);
		}
	
		@Override
		public long ProjectDataRevSubmit(PfmsProjectDataDto dto) throws Exception {
			logger.info(new Date() +"Inside ProjectDataRevSubmit");
			Object[] projectdatadetails=dao.ProjectDataDetails(dto.getProjectId());
			PfmsProjectDataRev model=new PfmsProjectDataRev();
			model.setProjectId(Long.parseLong(projectdatadetails[1].toString()));
			model.setFilesPath(projectdatadetails[2].toString());
			model.setSystemConfigImgName(projectdatadetails[3].toString());
			model.setSystemSpecsFileName(projectdatadetails[4].toString());
			model.setProductTreeImgName(projectdatadetails[5].toString());
			model.setPEARLImgName(projectdatadetails[6].toString());
			model.setCurrentStageId(Integer.parseInt(projectdatadetails[7].toString()));
			model.setRevisionNo(Long.parseLong(projectdatadetails[8].toString()));
			model.setRevisionDate(sdf1.format(new Date()));
			model.setCreatedBy(dto.getModifiedBy());
			model.setCreatedDate(sdf1.format(new Date()));
			
			return dao.ProjectRevDataSubmit(model);
		}
		
		
		@Override
		public List<Object[]> ProjectDataRevList(String projectid) throws Exception 
		{
			logger.info(new Date() +"Inside ProjectDataRevList");
			return dao.ProjectDataRevList(projectid);
		}
		
		@Override
		 public Object[] ProjectDataRevData(String projectdatarevid) throws Exception
		 {
			 logger.info(new Date() +"Inside ProjectDataRevData");
				return dao.ProjectDataRevData(projectdatarevid);
		 }
		
		
		@Override
		public Object[] ProjectDataSpecsRevFileData(String projectdatarevid) throws Exception
		{
			logger.info(new Date() +"Inside ProjectDataSpecsRevFileData");
			return dao.ProjectDataSpecsRevFileData(projectdatarevid);
		}

		@Override
		public List<Object[]> InitiatedProjectList() throws Exception {

			logger.info(new Date() +"Inside InitiatedProjectList");
			return dao.InitiatedProjectList();
		}

		@Override
		public List<Object[]> InitiatedProjectDetails(String ProjectId) throws Exception {
			
			logger.info(new Date() +"Inside InitiatedProjectDetails");
			return dao.InitiatedProjectDetails(ProjectId);
		}

		@Override
		public List<Object[]> NodalLabList() throws Exception {

			logger.info(new Date() +"Inside NodalLabList");
			return dao.NodalLabList();
		}

		
		@Override
		public List<Object[]> ProjectRiskDataList(String projectid) throws Exception 
		{
			logger.info(new Date() +"Inside ProjectRiskDataList");
			return dao.ProjectRiskDataList(projectid);
		}
		
		@Override
		public Object[] ProjectRiskData(String actionmainid) throws Exception 
		{
			logger.info(new Date() +"Inside ProjectRiskData");
			return dao.ProjectRiskData(actionmainid);
		}
		
		
		@Override
		public long ProjectRiskDataSubmit(PfmsRiskDto dto) throws Exception 
		{
			logger.info(new Date() +"Inside ProjectRiskDataSubmit");
			
			PfmsRisk model=new PfmsRisk();
			model.setProjectId(Long.parseLong(dto.getProjectId()));
			model.setActionMainId(Long.parseLong(dto.getActionMainId()));
			model.setDescription(dto.getDescription());
			model.setSeverity(dto.getSeverity());
			model.setProbability(dto.getProbability());
			model.setMitigationPlans(dto.getMitigationPlans());
			model.setRevisionNo(Long.parseLong("0"));
			model.setCreatedBy(dto.getCreatedBy());
			model.setCreatedDate(sdf1.format(new Date()));
			model.setIsActive(1);
			
			
			return dao.ProjectRiskDataSubmit(model);
		}
		
		
	
		
		@Override
		public Object[] ProjectRiskMatrixData(String actionmainid) throws Exception {
			logger.info(new Date() +"Inside ProjectRiskMatrixData");
			return dao.ProjectRiskMatrixData(actionmainid);
		}
		
		@Override
		public long ProjectRiskDataEdit(PfmsRiskDto dto) throws Exception 
		{
			logger.info(new Date() +"Inside ProjectRiskDataEdit");
			dto.setModifiedDate(sdf1.format(new Date()));
			return dao.ProjectRiskDataEdit(dto);
		}
		
		@Override
		public long ProjectRiskDataRevSubmit(PfmsRiskDto dto) throws Exception {
			logger.info(new Date() +"Inside ProjectDataRevSubmit");
			Object[] riskmatrixdata=dao.ProjectRiskMatrixData(dto.getActionMainId());
			PfmsRiskRev model=new PfmsRiskRev();
			
			
			model.setProjectId(Long.parseLong(riskmatrixdata[1].toString()));
			model.setActionMainId(Long.parseLong(riskmatrixdata[2].toString()));
			model.setDescription(riskmatrixdata[3].toString());
			model.setSeverity(riskmatrixdata[4].toString());
			model.setProbability(riskmatrixdata[5].toString());
			model.setMitigationPlans(riskmatrixdata[6].toString());
			model.setRevisionNo(Long.parseLong(riskmatrixdata[7].toString()));			
			model.setRevisionDate(sdf1.format(new Date()));
			model.setCreatedBy(dto.getModifiedBy());
			model.setCreatedDate(sdf1.format(new Date()));
			
			
			return dao.ProjectRiskDataRevSubmit(model);
		}
		
		@Override
		public List<Object[]> ProjectRiskMatrixRevList(String actionmainid) throws Exception {
			logger.info(new Date() +"Inside ProjectRiskMatrixRevList");
			return dao.ProjectRiskMatrixRevList(actionmainid);
		}
		
		@Override
		public List<Object> RiskDataPresentList(String projectid) throws Exception {
			logger.info(new Date() +"Inside RiskDataPresentList");
			return dao.RiskDataPresentList(projectid);
		}
		


		@Override
		public Long ProjectInitiationAuthorityAdd(PfmsInitiationAuthorityDto pfmsinitiationauthoritydto, String UserId,PfmsInitiationAuthorityFileDto pfmsinitiationauthorityfiledto)	throws Exception {
			
			logger.info(new Date() +"Inside ProjectInitiationAuthorityAdd");
			
			PfmsInitiationAuthority pfmsauthority= new PfmsInitiationAuthority();
			pfmsauthority.setInitiationId(Long.parseLong(pfmsinitiationauthoritydto.getInitiationId()));
			pfmsauthority.setAuthorityName(Long.parseLong(pfmsinitiationauthoritydto.getAuthorityName()));
			pfmsauthority.setLetterDate(new java.sql.Date(sdf.parse(pfmsinitiationauthoritydto.getLetterDate()).getTime()));
			pfmsauthority.setLetterNo(pfmsinitiationauthoritydto.getLetterNo());
			pfmsauthority.setCreatedBy(UserId);
			pfmsauthority.setCreatedDate(sdf1.format(new Date()));
			
			PfmsInitiationAuthorityFile pfmsinitiationauthorityfile=new PfmsInitiationAuthorityFile();
			pfmsinitiationauthorityfile.setFile(pfmsinitiationauthorityfiledto.getFilePath());
			pfmsinitiationauthorityfile.setAttachmentName(pfmsinitiationauthorityfiledto.getAttachementName());
			
			return dao.ProjectInitiationAuthorityAdd(pfmsauthority,pfmsinitiationauthorityfile);
		}

		@Override
		public PfmsInitiationAuthorityFile ProjectAuthorityDownload(String AuthorityFileId) throws Exception {

			logger.info(new Date() +"Inside ProjectAuthorityDownload");
			return dao.ProjectAuthorityDownload(AuthorityFileId);
		}

		@Override
		public Long ProjectAuthorityUpdate(PfmsInitiationAuthorityDto pfmsinitiationauthoritydto,
				PfmsInitiationAuthorityFileDto pfmsinitiationauthorityfiledto,String UserId) throws Exception {
			
			logger.info(new Date() +"Inside ProjectInitiationAuthorityAdd");
			
			Long ret=0L;
			
			PfmsInitiationAuthority pfmsauthority= new PfmsInitiationAuthority();
			PfmsInitiationAuthorityFile pfmsinitiationauthorityfile=new PfmsInitiationAuthorityFile();
			
			pfmsauthority.setInitiationId(Long.parseLong(pfmsinitiationauthoritydto.getInitiationId()));
			pfmsauthority.setAuthorityName(Long.parseLong(pfmsinitiationauthoritydto.getAuthorityName()));
			pfmsauthority.setLetterDate(new java.sql.Date(sdf.parse(pfmsinitiationauthoritydto.getLetterDate()).getTime()));
			pfmsauthority.setLetterNo(pfmsinitiationauthoritydto.getLetterNo());
			pfmsauthority.setModifiedBy(UserId);
			pfmsauthority.setModifiedDate(sdf1.format(new Date()));
			
			ret=dao.ProjectAuthorityUpdate(pfmsauthority);
			
			if(pfmsinitiationauthorityfiledto.getFilePath().length!=0) {
			
			pfmsinitiationauthorityfile.setFile(pfmsinitiationauthorityfiledto.getFilePath());
			pfmsinitiationauthorityfile.setAttachmentName(pfmsinitiationauthorityfiledto.getAttachementName()+"."+pfmsinitiationauthorityfiledto.getOriginalName().split("\\.")[1]);
			pfmsinitiationauthorityfile.setInitiationAuthorityFileId(Long.parseLong(pfmsinitiationauthorityfiledto.getInitiationAuthorityFileId()));
	
			ret=dao.AuthorityFileUpdate(pfmsinitiationauthorityfile);
			
			}
			
			
			return ret;
		}
		
		public List<Object[]> getProjectCatSecDetalis(String projectmainId)throws Exception{
			Long projectId=Long.parseLong(projectmainId);
			return dao.getProjectCatSecDetalis(projectId);
		}

		@Override
		public List<Object[]> LoginProjectDetailsList(String empid,String Logintype,String LabCode)throws Exception
		{
			logger.info(new Date() +"Inside LoginProjectDetailsList");
			return dao.LoginProjectDetailsList(empid,Logintype,LabCode);
		}
		
		@Override
		public List<Object[]>  ProjectApprovalFlowEmpData(String empid) throws Exception
		{
			logger.info(new Date() +"Inside ProjectApprovalFlowEmpData");
			List<Object[]> list=new ArrayList<Object[]>();
			
			Object[] temp=dao.EmpDivHeadData(empid);
			if(temp!=null) {
				list.add(temp);
			}
					
			list.addAll(dao.DoRtmdAdEmpData());
			
			temp=dao.DirectorEmpData();
			if(temp!=null) {
				list.add(temp);
			}
			return list;
		}
		
		@Override
		public long  ProjectMainToMaster(String projectmainid,String user) throws Exception
		{
			logger.info(new Date() +"Inside ProjectMainToMaster");
			
			ProjectMain main=dao.ProjectMainObj(projectmainid);
			ProjectMaster master=new ProjectMaster();   
			master.setProjectMainId(main.getProjectMainId());
			master.setProjectCode(main.getProjectCode());
			//ProjectImmsCd
			master.setProjectName(main.getProjectName());
			master.setProjectDescription(main.getProjectDescription());
			master.setUnitCode(main.getUnitCode());
			master.setProjectType(main.getProjectTypeId());
			master.setProjectCategory(main.getCategoryId());
			master.setSanctionNo(main.getSanctionNo());
			master.setSanctionDate(main.getSanctionDate());
			master.setTotalSanctionCost(main.getTotalSanctionCost());
			master.setSanctionCostRE(main.getSanctionCostRE());
			master.setSanctionCostFE(main.getSanctionCostFE());
			master.setPDC(main.getPDC());
			master.setProjSancAuthority(main.getProjSancAuthority());
			master.setProjectDirector(main.getProjectDirector());
			master.setBoardReference(main.getBoardReference());
			master.setRevisionNo(main.getRevisionNo());
			master.setIsMainWC(1); // main.getIsMainWC()
			master.setWorkCenter(main.getWorkCenter());
			master.setObjective(main.getObjective());
			master.setDeliverable(main.getDeliverable());
			master.setIsActive(1);
			master.setCreatedBy(user);
			master.setCreatedDate(sdf1.format(new Date()));
			
			return dao.ProjectMasterAdd(master);
		}
		
		@Override
		public ProjectMasterRev ProjectMasterREVSubmit(String projectid,String userid,String remarks) throws Exception 
		{			
			ProjectMaster master = dao.ProjectMasterData(Long.parseLong(projectid));
			ProjectMasterRev rev = new ProjectMasterRev(); 
			
			rev.setProjectId(master.getProjectId());
			rev.setRevisionNo(master.getRevisionNo());
			rev.setProjectMainId(master.getProjectMainId());
			rev.setProjectCode(master.getProjectCode());
			rev.setProjectImmsCd(master.getProjectImmsCd());
			rev.setProjectName(master.getProjectName());
			rev.setProjectDescription(master.getProjectDescription());
			rev.setUnitCode(master.getUnitCode());
			rev.setProjectType(master.getProjectType());
			rev.setProjectCategory(master.getProjectCategory());
			rev.setSanctionNo(master.getSanctionNo());
			rev.setSanctionDate(master.getSanctionDate());
			rev.setTotalSanctionCost(master.getTotalSanctionCost());
			rev.setSanctionCostFE(master.getSanctionCostFE());
			rev.setSanctionCostRE(master.getSanctionCostRE());
			rev.setPDC(master.getPDC());
			rev.setProjectDirector(master.getProjectDirector());
			rev.setProjSancAuthority(master.getProjSancAuthority());
			rev.setBoardReference(master.getBoardReference());
			rev.setIsMainWC(master.getIsMainWC());
			rev.setWorkCenter(master.getWorkCenter());
			rev.setObjective(master.getObjective());
			rev.setDeliverable(master.getDeliverable());
			rev.setCreatedBy(userid);
			rev.setCreatedDate(sdf1.format(new Date()));
			rev.setRemarks(remarks);			
			return dao.ProjectREVSubmit(rev);
		}
		
		@Override
		public List<Object[]> ProjectTypeMainListNotAdded() throws Exception {
			return dao.ProjectTypeMainListNotAdded();
		}

		@Override
		public List<Object[]> ProjectRevList (String projectid) throws Exception {
			return dao.ProjectRevList(projectid);
		}
		
		@Override
		public long ProjectMasterAttachAdd(ProjectMasterAttachDto dto) throws Exception 
		{
			logger.info(new Date() +"Inside ProjectMastetAttachAdd");
			
			String projectcode = dao.ProjectData(dto.getProjectId())[1].toString();
			String path = ProjectMasterFilePath+"\\"+projectcode;
			File filepath=new File(path);
			long ret=0;
			if(!filepath.exists())
			{
				filepath.mkdirs();
			}
			
			for(int i=0;i<dto.getFiles().length;i++) 
			{
				if(!dto.getFiles()[i].isEmpty()) 
				{
					ProjectMasterAttach modal=new ProjectMasterAttach();
					modal.setProjectId(Long.parseLong(dto.getProjectId()));
					modal.setFileName(dto.getFileName()[i]);
					modal.setOriginalFileName(dto.getFiles()[i].getOriginalFilename());
					modal.setPath(path);
					modal.setCreatedBy(dto.getCreatedBy());
					modal.setCreatedDate(sdf1.format(new Date()));
					
					String fullpath=path+"\\"+modal.getOriginalFileName()	;	
					
					File file = new File(fullpath);
					int count=0;
					while(true) {
						file = new File(fullpath);
						
						if(file.exists())
						{
							count++;
							fullpath = path+"\\"+FilenameUtils.getBaseName(modal.getOriginalFileName())+"-"+count+"."+FilenameUtils.getExtension(modal.getOriginalFileName());
						}
						else
						{
							if(count>0) {
								modal.setOriginalFileName(FilenameUtils.getBaseName(modal.getOriginalFileName())+"-"+count+"."+FilenameUtils.getExtension(modal.getOriginalFileName()));
							}
							break;
						}
					}
					saveFile(path, modal.getOriginalFileName(), dto.getFiles()[i]);
					ret=dao.ProjectMasterAttachAdd(modal);
					
				}						
			}
			return ret;
		}
		
		@Override
		public List<Object[]> ProjectMasterAttachList(String projectid) throws Exception {
			return dao.ProjectMasterAttachList(projectid);
		}
		
		@Override
		public Object[] ProjectMasterAttachData(String projectattachid) throws Exception {
			return dao.ProjectMasterAttachData(projectattachid);
		}
		
		@Override
		public int ProjectMasterAttachDelete(String projectattachid) throws Exception
		{
			Object[] attachdata = dao.ProjectMasterAttachData(projectattachid);
			boolean result= false;
			File file = new File(attachdata[2]+File.separator+attachdata[3]);
			if (file.exists()){
				result = file.delete();
				if (result)
				dao.ProjectMasterAttachDelete(projectattachid);
			}			 
			if(result) 
				return 1;
			else
				return 0;
		}
		
		@Override
		public long TechnicalWorkDataAdd(ProjectTechnicalWorkData modal) throws Exception
		{
			modal.setCreatedDate(sdf1.format(new Date()));
			modal.setIsActive(1);
			
			return dao.TechnicalWorkDataAdd(modal);
		}
		@Override
		public long TechnicalWorkDataEdit(ProjectTechnicalWorkData modal,String techdataid) throws Exception
		{
			return dao.TechnicalWorkDataEdit(modal,Long.parseLong(techdataid));
		}
		
		@Override
		public List<Object[]> InitiationCheckList(String initiationid ) throws Exception 
		{
			return dao.InitiationCheckList(initiationid );
		}
		
		@Override
		public long IntiationChecklistUpdate(PfmsInitiationChecklistData cldata) throws Exception 
		{
			PfmsInitiationChecklistData cldatacheck = dao.InitiationChecklistCheck(cldata);
			if(cldatacheck!=null && cldatacheck.getChecklistDataId()>0) {
				cldatacheck.setIsChecked(cldatacheck.getIsChecked()^1);
				cldatacheck.setModifiedBy(cldata.getCreatedBy());
				cldatacheck.setModifiedDate(sdf1.format(new Date()));
				return dao.InitiationChecklistUpdate(cldatacheck);
			}else {
				cldata.setIsChecked(1);
				cldata.setCreatedDate(sdf1.format(new Date()));
				return dao.InitiationChecklistAdd(cldata);
			}
			
			
		}

		
		
}
