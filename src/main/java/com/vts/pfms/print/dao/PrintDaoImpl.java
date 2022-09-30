package com.vts.pfms.print.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;
import com.vts.pfms.master.model.EmployeeExternal;
import com.vts.pfms.milestone.model.MilestoneActivityLevelConfiguration;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.print.model.InitiationSanction;
import com.vts.pfms.print.model.InitiationsanctionCopyAddr;
import com.vts.pfms.print.model.TechImages;



@Transactional
@Repository
public class PrintDaoImpl implements PrintDao {

	private static final String LABLIST="select labcode, labname,labaddress, labcity,lablogo from lab_master";
	private static final String PFMSINITLIST="SELECT a.initiationid,a.projectprogramme,b.projecttypeshort,c.category,a.projectshortname,a.projecttitle,a.projectcost,a.projectduration,a.isplanned,a.ismultilab,a.createddate,a.deliverable,a.ismain,d.projecttitle AS initiatedproject,a.remarks,a.fecost,a.recost FROM pfms_initiation a,project_type b,pfms_security_classification c ,pfms_initiation d WHERE a.projecttypeid=c.categoryid  AND a.categoryid=b.projecttypeid AND a.isactive='1' AND a.initiationid=:initiationid AND a.mainid=d.initiationid UNION SELECT a.initiationid,a.projectprogramme,b.projecttypeshort,c.category,a.projectshortname,a.projecttitle,a.projectcost,a.projectduration, a.isplanned,a.ismultilab,a.createddate,a.deliverable,a.ismain,a.projecttitle AS initiatedproject,a.remarks,a.fecost,a.recost FROM pfms_initiation a,project_type b,pfms_security_classification c WHERE a.projecttypeid=c.categoryid  AND a.categoryid=b.projecttypeid AND a.isactive='1' AND a.initiationid=:initiationid AND a.mainid=0";
	private static final String PROJECTDETAILSLIST= "SELECT a.Requirements,a.Objective,a.Scope,a.MultiLabWorkShare,a.EarlierWork,a.CompentencyEstablished,a.NeedOfProject,a.TechnologyChallanges,a.RiskMitiagation,a.Proposal,a.RealizationPlan,a.initiationid FROM pfms_initiation_detail a WHERE a.initiationid=:initiationid ";
	private static final String COSTDETAILSLIST="	SELECT c.headofaccounts,CONCAT (c.majorhead,'-',c.minorhead,'-',c.subhead) AS headcode,a.itemdetail,a.itemcost FROM pfms_initiation_cost a,budget_item c WHERE a.budgetitemid=c.budgetitemid AND a.isactive='1' AND a.initiationid=:initiationid AND a.budgetheadid=c.budgetheadid";
	private static final String PROJECTSCHEDULELIST="select milestoneno,milestoneactivity,milestonemonth,initiationscheduleid,milestoneremark from pfms_initiation_schedule where initiationid=:initiationid and isactive='1'";

	private static final String PROJECTSLIST="SELECT projectid, projectcode, projectname FROM project_master";
	
	private static final String MILESTONESUBSYSTEMS="SELECT maa.activityId, maa.Parentactivityid, maa.activityname, maa.orgenddate, maa.enddate,maa.activitystatusid,mas.activityshort,  maa.ProgressStatus,ma.milestoneno, maa.StatusRemarks FROM milestone_activity ma,milestone_activity_level maa,milestone_activity_status mas WHERE ma.milestoneactivityid = maa.parentactivityid AND maa.activitylevelid='1' AND maa.activitystatusid=mas.activitystatusid  AND ma.projectid=:projectid ORDER BY ma.milestoneno";
	private static final String PROJECTDETAILS="SELECT a.projectid,a.projectcode,a.projectname,a.projectname as 'name',a.projectcode as 'code' FROM project_master a WHERE a.projectid=:projectid and  a.isactive='1'";
	private static final String GANTTCHARTLIST="SELECT milestoneactivityid,projectid,activityname,milestoneno,orgstartdate,orgenddate,startdate,enddate,progressstatus FROM milestone_activity WHERE isactive=1 AND projectid=:projectid";
	private static final String MILESTONES="SELECT ma.milestoneactivityid,ma.projectid,ma.milestoneno,ma.activityname,ma.orgstartdate,ma.orgenddate,ma.startdate,ma.enddate, ma.activitytype AS 'activitytypeid' ,mat.activitytype,ma.activitystatusid,mas.activityshort, ma.ProgressStatus,ma.StatusRemarks FROM milestone_activity ma, milestone_activity_type mat ,milestone_activity_status mas WHERE ma.activitytype=mat.activitytypeid AND ma.activitystatusid=mas.activitystatusid AND projectid=:projectid ";
	private static final String EBANDPMRCCOUNT="SELECT 'PMRC',COUNT(scheduleid) AS 'COUNT',scheduledate FROM committee_schedule , committee_meeting_status WHERE  scheduledate<CURDATE() AND isactive=1 AND committeeid=1 AND meetingstatus=scheduleflag AND meetingstatusid>6 AND projectid=:projectid UNION  SELECT 'EB',COUNT(scheduleid) AS 'COUNT',scheduledate  FROM committee_schedule, committee_meeting_status WHERE scheduledate<CURDATE() AND committeeid=2  AND meetingstatus=scheduleflag AND meetingstatusid>6 AND isactive=1 AND projectid=:projectid";
	private static final String PROJECTATTRIBUTES="SELECT pm.projectcode, pm.projectname, pm.ProjectDescription, pm.sanctiondate, pm.objective, pm.deliverable, pm.pdc,   ROUND(pm.TotalSanctionCost/100000,2) AS 'TotalSanctionCost',   ROUND(pm.SanctionCostRE/100000,2) AS 'SanctionCostRE', ROUND(pm.SanctionCostFE/100000,2) AS 'SanctionCostFE', pm.WorkCenter, pm.projectcategory,pc.category,  pm.projecttype AS 'projecttypeid',pt.projecttype ,pma.labparticipating  FROM project_master pm, pfms_security_classification pc, project_type pt , project_main pma  WHERE pm.projectcategory=pc.categoryid AND pm.projecttype=pt.projecttypeid AND pm.projectmainid=pma.projectmainid AND projectid=:projectid  ";
	private static final String PROJECTDATADETAILS="SELECT ppd.projectdataid,ppd.projectid,ppd.filespath,ppd.systemconfigimgname,ppd.SystemSpecsFileName,ppd.ProductTreeImgName,ppd.PEARLImgName,ppd.CurrentStageId,ppd.RevisionNo,pps.projectstagecode,pps.projectstage,pps.stagecolor,pm.projectcode  FROM pfms_project_data ppd, pfms_project_stage pps,project_master pm WHERE ppd.projectid=pm.projectid AND ppd.CurrentStageId=pps.projectstageid AND ppd.projectid=:projectid";
	private static final String PROCUREMETSSTATUSLIST="SELECT f.PftsFileId, f.DemandNo, f.OrderNo, f.DemandDate, f.DpDate, ROUND(f.EstimatedCost/100000,2) AS 'EstimatedCost',ROUND(f.OrderCost/100000, 2) AS 'OrderCost', f.RevisedDp ,f.ItemNomenclature, s.PftsStatus, s.PftsStageName, f.Remarks,'' AS vendorname,f.PftsStatusId  AS id  FROM pfts_file f, pfts_status s  WHERE f.ProjectId=:projectid AND f.EstimatedCost>(SELECT proclimit FROM pfms_project_data WHERE ProjectId=:projectid )  AND f.PftsStatusId=s.PftsStatusId AND s.PftsStatusId<16 AND f.PftsFileId NOT IN(SELECT PftsFileId FROM pfts_file_order) UNION SELECT f.PftsFileId, f.DemandNo, o.OrderNo, f.DemandDate, o.DpDate, ROUND(f.EstimatedCost/100000,2) AS 'EstimatedCost',ROUND(o.OrderCost/100000, 2) AS 'OrderCost', f.RevisedDp ,f.ItemNomenclature, s.PftsStatus, s.PftsStageName, f.Remarks,o.vendorname,f.PftsStatusId  AS id  FROM pfts_file f, pfts_status s,pfts_file_order o  WHERE f.ProjectId=:projectid AND f.PftsFileId=o.PftsFileId  AND f.PftsStatusId=s.PftsStatusId AND s.PftsStatusId<16 AND o.OrderCost>(SELECT proclimit FROM pfms_project_data WHERE ProjectId=:projectid ) ORDER BY  DemandNo , id ASC";
	private static final String RISKMATIRXDATA="SELECT description, severity, probability, mitigationplans revisionno,projectid,actionmainid FROM pfMs_risk WHERE projectid=:projectid";
	private static final String LASTPMRCDECISIONS="SELECT cs.pmrcdecisions,cs.scheduleid,cs.scheduledate FROM committee_schedule cs ,committee_meeting_status cms  WHERE cs.committeeid=:committeeid AND cs.isactive=1 AND cs.projectid=:projectid AND cs.scheduleflag=cms.meetingstatus AND cms.meetingstatusid<=6  AND scheduledate=(SELECT MIN(scheduledate) FROM committee_schedule cs ,committee_meeting_status cms WHERE cs.scheduledate>=CURDATE() AND  cs.committeeid=:committeeid AND cs.isactive=1 AND cs.projectid=:projectid AND cs.scheduleflag=cms.meetingstatus AND cms.meetingstatusid<=6 )  ";
	private static final String MILESTONESCHANGE="SELECT ma.milestoneactivityid,ma.projectid,ma.milestoneno,ma.activityname,ma.orgstartdate,ma.orgenddate,ma.startdate,ma.enddate, ma.activitytype AS 'activitytypeid' ,mat.activitytype,ma.activitystatusid,mas.activityshort, ma.ProgressStatus,IFNULL(ma.StatusRemarks,'-') AS 'Status Remarks' FROM milestone_activity ma, milestone_activity_type mat ,milestone_activity_status mas WHERE ma.activitytype=mat.activitytypeid AND ma.activitystatusid=mas.activitystatusid AND projectid=:projectid AND CASE WHEN :milestoneactivitystatusid='A' THEN 1=1 ELSE ma.activitystatusid =:milestoneactivitystatusid END  AND ma.progressstatus <> 0";

	
	@PersistenceContext
	EntityManager manager;
	
	private static final Logger logger=LogManager.getLogger(PrintDaoImpl.class);
	
	@Override
	public List<Object[]> LabList() throws Exception {

		logger.info(new Date() +"Inside LabList");
		Query query=manager.createNativeQuery(LABLIST);
		
		List<Object[]> LabList=(List<Object[]>)query.getResultList();		

		return LabList;
	}

	@Override
	public List<Object[]> PfmsInitiationList(String InitiationId) throws Exception {
		
		logger.info(new Date() +"Inside PfmsInitiationList");
		Query query=manager.createNativeQuery(PFMSINITLIST);
		query.setParameter("initiationid", InitiationId);
		
		List<Object[]> PfmsInitiationList=(List<Object[]>)query.getResultList();		

		return PfmsInitiationList;
	}
	
	@Override
	public LabMaster LabDetailes() throws Exception {
		logger.info(new Date() +"Inside LabDetailes");
		LabMaster LabDetailes=manager.find(LabMaster.class, 1);
		return LabDetailes;
	}

	@Override
	public List<Object[]> ProjectIntiationDetailsList(String InitiationId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectIntiationDetailsList");
		Query query=manager.createNativeQuery(PROJECTDETAILSLIST);
		query.setParameter("initiationid", InitiationId);
		List<Object[]> ProjectIntiationDetailsList=(List<Object[]> )query.getResultList();	
			
		
			return ProjectIntiationDetailsList;
	}

	@Override
	public List<Object[]> CostDetailsList(String InitiationId) throws Exception {

		logger.info(new Date() +"Inside CostDetailsList");
		Query query=manager.createNativeQuery(COSTDETAILSLIST);
		query.setParameter("initiationid", InitiationId);
		List<Object[]> CostDetailsList =(List<Object[]>)query.getResultList();
		
		return CostDetailsList;
	}

	@Override
	public List<Object[]> ProjectInitiationScheduleList(String InitiationId) throws Exception {

		logger.info(new Date() +"Inside ProjectInitiationScheduleList");
		Query query=manager.createNativeQuery(PROJECTSCHEDULELIST);
	    query.setParameter("initiationid", InitiationId);
		List<Object[]> ProjectIntiationScheduleList=(List<Object[]>)query.getResultList();		
		
		return ProjectIntiationScheduleList;
	}
	
	
	@Override
	public List<Object[]> ProjectsList() throws Exception {

		logger.info(new Date() +"Inside ProjectInitiationScheduleList");
		Query query=manager.createNativeQuery(PROJECTSLIST);	   
		List<Object[]> ProjectsList=(List<Object[]>)query.getResultList();	
		
		return ProjectsList;
	}
	
	
	@Override
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype ,String LabCode)throws Exception
	{
		logger.info(new java.util.Date() +"Inside LoginProjectDetailsList");
		Query query=manager.createNativeQuery("CALL Pfms_Emp_ProjectList(:empid,:logintype,:labcode);");
		query.setParameter("empid", empid);
		query.setParameter("logintype", Logintype);
		query.setParameter("labcode", LabCode);
		List<Object[]> LoginProjectIdList=(List<Object[]>)query.getResultList();
		return LoginProjectIdList;
	}
	
	
		
	@Override
	public Object[] ProjectAttributes(String projectid) throws Exception 
	{
		logger.info(new Date() +"Inside ProjectAttributes");
		Query query=manager.createNativeQuery(PROJECTATTRIBUTES);	   
		query.setParameter("projectid", projectid);
		Object[] ProjectAttributes=null;
		try {
			ProjectAttributes=(Object[])query.getSingleResult();	
		}catch (Exception e) {
			ProjectAttributes=null;
		}
		return ProjectAttributes;
	}
	
	
	
	
	@Override
	public List<Object[]> EBAndPMRCCount(String projectid) throws Exception {

		logger.info(new Date() +"Inside EBAndPMRCCount");
		Query query=manager.createNativeQuery(EBANDPMRCCOUNT);	   
		query.setParameter("projectid", projectid);
		List<Object[]> EBAndPMRCCount=(List<Object[]>)query.getResultList();	
		
		return EBAndPMRCCount;
	}
	
	
	
	
	
	@Override
	public List<Object[]> Milestones(String projectid) throws Exception {

		logger.info(new Date() +"Inside Milestones");
		Query query=manager.createNativeQuery(MILESTONES);	   
		query.setParameter("projectid", projectid);
		List<Object[]> Milestones=(List<Object[]>)query.getResultList();	
		
		return Milestones;
	}
	
	@Override
	public List<Object[]> MilestonesChange(String projectid,String milestoneactivitystatusid) throws Exception {

		logger.info(new Date() +"Inside MilestonesChange");
		Query query=manager.createNativeQuery(MILESTONESCHANGE);	   
		query.setParameter("projectid", projectid);
		query.setParameter("milestoneactivitystatusid", milestoneactivitystatusid );
		List<Object[]> MilestonesChange=(List<Object[]>)query.getResultList();	
		
		return MilestonesChange;
	}
	
	@Override /* present status*/
	public List<Object[]> MilestoneSubsystems(String projectid) throws Exception {

		logger.info(new Date() +"Inside MilestoneSubsystems");
		Query query=manager.createNativeQuery(MILESTONESUBSYSTEMS);	   
		query.setParameter("projectid", projectid);
		List<Object[]> MilestoneSubsystems=(List<Object[]>)query.getResultList();	
		
		return MilestoneSubsystems;
	}
	
	@Override /* last Pmrc action points*/
	public List<Object[]> LastPMRCActions(String projectid ,String committeeid) throws Exception 
	{
		logger.info(new Date() +"Inside LastPMRCActions");
		Query query=manager.createNativeQuery("CALL Last_PMRC_Actions_List(:projectid,:committeeid);");	   
		query.setParameter("projectid", projectid);
		query.setParameter("committeeid", committeeid);
		//query.setParameter("lastpmrcdate", lastpmrcdate);
		List<Object[]> LastPMRCActions=(List<Object[]>)query.getResultList();			
		return LastPMRCActions;		
	}
	
	@Override /* old Pmrc action points*/
	public List<Object[]> OldPMRCActions(String projectid, String committeeid) throws Exception 
	{
		logger.info(new Date() +"Inside OldPMRCActions");
		Query query=manager.createNativeQuery("CALL Old_PMRC_Actions_List(:projectid,:committeeid);");	   
		query.setParameter("projectid", projectid);
		query.setParameter("committeeid", committeeid);
		List<Object[]> OldPMRCActions=(List<Object[]>)query.getResultList();			
		return OldPMRCActions;		
	}
	
	@Override
	public List<Object[]> ProjectDetails(String ProjectId) throws Exception {
		logger.info(new Date() +"Inside Project Details");
		Query query=manager.createNativeQuery(PROJECTDETAILS);
		query.setParameter("projectid",ProjectId);
		List<Object[]> ProjectList=(List<Object[]>)query.getResultList();		

		return ProjectList;
	}
	
	
	@Override
	public List<Object[]> GanttChartList(String ProjectId) throws Exception {
		
		logger.info(new Date() +"Inside GanttChartList");
		Query query = manager.createNativeQuery(GANTTCHARTLIST);
		query.setParameter("projectid", ProjectId);
		List<Object[]> GanttChartList= query.getResultList();
		return GanttChartList;
	}
	
	
	
	
	
	@Override
	public Object[] ProjectDataDetails(String projectid) throws Exception {
		logger.info(new Date() +"Inside ProjectDataDetails");
		Query query=manager.createNativeQuery(PROJECTDATADETAILS);
		query.setParameter("projectid", projectid);
		Object[] ProjectStageDetails=null;
		try {
			ProjectStageDetails=(Object[])query.getSingleResult();
		}catch (Exception e) {
			return null;
		}
		
		return ProjectStageDetails;
	}
	
	
	@Override   //unfinished or open issues only
	public List<Object[]> OldPMRCIssuesList(String projectid) throws Exception {  
		
		logger.info(new Date() +"Inside OldPMRCIssuesList");
		Query query = manager.createNativeQuery("CALL Old_Issues_List(:projectid);");
		query.setParameter("projectid", projectid);
		List<Object[]> OldPMRCIssuesList= query.getResultList();
		return OldPMRCIssuesList;
	}
	
	
	@Override
	public List<Object[]> ProcurementStatusList(String projectid)throws Exception{
		logger.info(new Date() +"Inside ProcurementStatusList");
		Query query = manager.createNativeQuery(PROCUREMETSSTATUSLIST);
		query.setParameter("projectid", projectid);
		List<Object[]> ProcurementStatusList= query.getResultList();
		return ProcurementStatusList;
	}
	
	
	
	@Override
	public List<Object[]> RiskMatirxData(String projectid)throws Exception{
		logger.info(new Date() +"Inside RiskMatirxData");
		Query query = manager.createNativeQuery(RISKMATIRXDATA);
		query.setParameter("projectid", projectid);
		List<Object[]> RiskMatirxData= query.getResultList();
		return RiskMatirxData;
		
	}
	
	
	
	@Override
	public Object[] LastPMRCDecisions(String committeeid,String projectid)throws Exception
	{
		logger.info(new Date() +"Inside LastPMRCDecisions");
		Query query = manager.createNativeQuery(LASTPMRCDECISIONS);
		query.setParameter("projectid", projectid);
		query.setParameter("committeeid", committeeid);
		
		Object[] LastPMRCDecisions=null;
		try {
			LastPMRCDecisions= (Object[])query.getSingleResult();
		}catch (Exception e) {
			return LastPMRCDecisions;
		}		
		return LastPMRCDecisions;		
	}
	
	@Override
	public List<Object[]> ActionPlanSixMonths(String projectid, int interval)throws Exception
	{
		logger.info(new Date() +"Inside ActionPlanThreeMonths");
		List<Object[]> ActionPlanThreeMonths=new ArrayList<Object[]>();
		//Query query = manager.createNativeQuery("CALL Pfms_Milestone_PDC(:projectid, 180);");
		Query query = manager.createNativeQuery("CALL Pfms_Milestone_PDC_New(:projectid, 180)");
		query.setParameter("projectid", projectid);
		try {
			ActionPlanThreeMonths= query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionPlanThreeMonths "+ e);
		}
		return ActionPlanThreeMonths;
	}

	
	private static final String LASTPRMC="SELECT cs.scheduleid FROM  committee_schedule cs ,committee_meeting_status ms WHERE cs.committeeid=:committeeid AND cs.projectid=:projectid AND cs.isactive=1 AND  ms.meetingstatus=cs.scheduleflag AND ms.meetingstatusid > 6 AND cs.scheduleid<:scheduleId ORDER BY cs.scheduleid DESC LIMIT 1";
	@Override
	public long getLastPmrcId(String projectid,String committeeid,String scheduleId) throws Exception 
	{
		logger.info(new java.util.Date() +"Inside getLastPmrcId ");
		Query query=manager.createNativeQuery(LASTPRMC);
		query.setParameter("projectid", projectid);
		query.setParameter("committeeid", committeeid);
		query.setParameter("scheduleId", scheduleId);
		long result=0;
		try {
		BigInteger CommProScheduleList=(BigInteger)query.getSingleResult();
		result=CommProScheduleList.longValue();
		}catch (Exception e) {
			
		}
		return result;
	}
	@Override
	public List<Object[]> LastPMRCActions1(String projectid ,String committeeid) throws Exception 
	{
		logger.info(new java.util.Date() +"Inside LastPMRCActions");
		Query query=manager.createNativeQuery("CALL last_pmrc_actions_list_bpaper(:projectid,:committeeid);");	   
		query.setParameter("projectid", projectid);
		query.setParameter("committeeid", committeeid);
		List<Object[]> LastPMRCActions=(List<Object[]>)query.getResultList();			
		return LastPMRCActions;		
	}
	
	private static final String PROJECTSUBPROJECTIDLIST ="SELECT CAST(a.projectid AS CHAR) FROM project_master a,project_master b WHERE b.projectid=:projectid AND  CASE WHEN b.ismainwc = 1 THEN a.projectid IN (SELECT projectid FROM project_master WHERE projectmainid= b.projectmainid AND isactive=1) WHEN  b.ismainwc = 0 THEN a.projectid=b.projectid END ORDER BY a.projectid=:projectid DESC  ";
	
	@Override
	public List<String> ProjectsubProjectIdList(String projectid ) throws Exception 
	{
		logger.info(new java.util.Date() +"Inside ProjectsubProjectIdList");
		Query query=manager.createNativeQuery(PROJECTSUBPROJECTIDLIST);	   
		query.setParameter("projectid", projectid);
		List<String> Projectidlist=(List<String>)query.getResultList();			
		return Projectidlist;		
	}
	
	private static final String REVIEWMEETINGLIST = "SELECT scheduleid, committeeshortname, committeename,scheduledate,meetingid FROM committee_schedule cs, committee c, committee_meeting_status cms WHERE (cs.scheduledate BETWEEN (SELECT MAX(cs.scheduledate) FROM committee_schedule cs, committee_meeting_status cms WHERE cs.committeeid=:committeeid AND cs.projectid=:projectid AND cs.scheduledate < CURDATE() AND cs.scheduleflag=cms.meetingstatus AND meetingstatusid > 6)   AND CURDATE() )  AND cs.committeeid=c.committeeid AND cs.scheduleflag=cms.meetingstatus AND cms.meetingstatusid > 6 AND cs.projectid=:projectid AND cs.committeeid <> :committeeid ";
	
	@Override
	public List<Object[]> ReviewMeetingList(String projectid, String committeeid) throws Exception 
	{
		logger.info(new Date() +"Inside ReviewMeetingList");
		Query query=manager.createNativeQuery(REVIEWMEETINGLIST);	   
		query.setParameter("projectid", projectid);
		query.setParameter("committeeid", committeeid);
		List<Object[]> ReviewMeetingList=(List<Object[]>)query.getResultList();		
		return ReviewMeetingList;
	}
	
	private static final String TECHWORKDATALIST = "SELECT a.techdataid, a.projectid,a.relatedpoints, a.attachmentid, a.isactive,'0',b.filepath,b.filenameui,b.filename,b.filepass,b.ReleaseDoc,b.VersionDoc FROM project_technical_work_data a,file_rep_upload b WHERE a.isactive=1 AND a.projectid=:projectid and a.attachmentid=b.filerepuploadid union SELECT a.techdataid, a.projectid,a.relatedpoints, a.attachmentid, a.isactive,'0','' AS filepath,'' AS filenameui,'' AS filename,'' AS filepass,0 AS ReleaseDoc,0 AS VersionDoc FROM project_technical_work_data a WHERE a.isactive=1 AND a.projectid=:projectid AND a.attachmentid=0";
	
	@Override
	public Object[] TechWorkData(String projectid) throws Exception 
	{
		logger.info(new Date() +"Inside TechWorkDataList");
		Query query=manager.createNativeQuery(TECHWORKDATALIST);	   
		query.setParameter("projectid", projectid);
		List<Object[]> ReviewMeetingList=(List<Object[]>)query.getResultList();	
		if(ReviewMeetingList.size()>0) 
		{
			return ReviewMeetingList.get(0);
		}else {
			return null;
		}
	 
	}
	
	private static final String PROJECTREVLIST = "SELECT pr.projectid, pr.revisionno,pm.projectcode AS 'ProjectMainCode', pr.projectcode, pr.projectname, pr.projectdescription, pr.unitcode, pt.projecttype,ps.category,pr.sanctionno,pr.sanctiondate, CASE WHEN pr.totalsanctioncost>0 THEN ROUND(pr.totalsanctioncost/100000,2) ELSE pr.totalsanctioncost END AS 'TotalSanctionCost', pr.pdc, e.empname AS 'ProjectDirector' , ed.designation,  CAST(pr.createddate AS DATE)    FROM project_master p, project_master_rev pr , project_main pm, project_type pt, pfms_security_classification ps, employee e, employee_desig ed WHERE p.projectid=pr.projectid AND pr.projectmainid = pm.projectmainid AND pr.projecttype=pt.projecttypeid AND ps.categoryid =pr.projectcategory AND e.empid=pr.projectdirector AND e.desigid=ed.desigid  AND p.projectid=:projectid ORDER BY  revisionno ASC";
	
	@Override
	public List<Object[]> ProjectRevList(String projectid) throws Exception {
		logger.info(new java.util.Date() +"Inside ProjectRevList");
		Query query=manager.createNativeQuery(PROJECTREVLIST);
		query.setParameter("projectid", projectid);
		return (List<Object[]>)query.getResultList();
	}

	private static final String SCHEDULELIST="SELECT cs.scheduledate,cs.scheduleflag,cms.meetingstatusid,cs.meetingid,cs.scheduledate<DATE(SYSDATE()),(SELECT COUNT(*)+1 FROM  committee_schedule css ,committee_meeting_status mss WHERE css.committeeid=c.committeeid AND css.projectid=cs.projectid AND css.isactive=1 AND  mss.meetingstatus=css.scheduleflag AND mss.meetingstatusid > 6 AND css.scheduledate<cs.scheduledate) AS countid,cs.scheduleid FROM committee_schedule cs, committee c,committee_meeting_status cms WHERE c.committeeid=cs.committeeid  AND c.committeeId IN (1,2) AND cs.scheduleflag=cms.meetingstatus AND cs.projectid=:ProjectId AND YEAR(cs.scheduledate)=:InYear AND MONTH(cs.scheduledate)=:InMonth";
	
	@Override
	public List<Object[]> getMeetingSchedules(String ProjectId, String Month, String Year) throws Exception {
		logger.info(new java.util.Date() +"Inside ProjectRevList");
		Query query=manager.createNativeQuery(SCHEDULELIST);
		query.setParameter("ProjectId", ProjectId);
		query.setParameter("InMonth", Month);
		query.setParameter("InYear", Year);
		return (List<Object[]>)query.getResultList();
	}
	
	private static final String COMMITTEESCHEDULEEDITDATA="SELECT a.committeeid,a.committeemainid,a.scheduledate,a.schedulestarttime,a.scheduleflag,a.schedulesub,a.scheduleid,b.committeename,b.committeeshortname,a.projectid,c.meetingstatusid,a.meetingid,a.meetingvenue,a.confidential,a.Reference,d.category ,a.divisionid  ,a.initiationid ,a.pmrcdecisions,a.kickoffotp ,(SELECT minutesattachmentid FROM committee_minutes_attachment WHERE scheduleid=a.scheduleid) AS 'attachid', b.periodicNon FROM committee_schedule a,committee b ,committee_meeting_status c, pfms_security_classification d WHERE a.scheduleflag=c.MeetingStatus AND a.scheduleid=:committeescheduleid AND a.committeeid=b.committeeid AND a.confidential=d.categoryid";

	
	@Override
	public Object[] CommitteeScheduleEditData(String CommitteeScheduleId) throws Exception {

		logger.info(new java.util.Date() +"Inside CommitteeScheduleEditData");
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEEDITDATA);
		query.setParameter("committeescheduleid", CommitteeScheduleId );
		Object[] CommitteeScheduleEditData=(Object[])query.getSingleResult();
		return CommitteeScheduleEditData;
	}
	
    private static final String NEXTSCHEDULEID="SELECT cs.scheduleid FROM  committee_schedule cs ,committee_meeting_status ms WHERE cs.committeeid=:committeeid AND cs.projectid=:projectid AND cs.isactive=1 AND  ms.meetingstatus=cs.scheduleflag AND ms.meetingstatusid < 7 AND cs.scheduledate>=DATE(SYSDATE()) ORDER BY cs.scheduledate ASC LIMIT 1";	
    @Override
	public long getNextScheduleId(String projectid,String committeeid) throws Exception 
	{
		logger.info(new java.util.Date() +"Inside getNextScheduleId ");
		Query query=manager.createNativeQuery(NEXTSCHEDULEID);
		query.setParameter("projectid", projectid);
		query.setParameter("committeeid", committeeid);
		long result=0;
		try {
		BigInteger CommProScheduleList=(BigInteger)query.getSingleResult();
		result=CommProScheduleList.longValue();
		}catch (Exception e) {
			
		}
		return result;
	}
    
    private static final String NEXTSCHEDULEFROZEN="SELECT briefingpaperfrozen FROM  committee_schedule  where scheduleid=:schduleid ";	
    @Override
	public String getNextScheduleFrozen(long schduleid) throws Exception 
	{
		logger.info(new java.util.Date() +"Inside getNextScheduleFrozen ");
		Query query=manager.createNativeQuery(NEXTSCHEDULEFROZEN);
		query.setParameter("schduleid", schduleid);
		String getNextScheduleFrozen=(String)query.getSingleResult();
		return getNextScheduleFrozen;
	}

    private static final String UPDATEFROZEN="update committee_schedule set BriefingPaperFrozen='Y' where scheduleid=:schduleid";
	@Override
	public int updateBriefingPaperFrozen(long schduleid) throws Exception {
		logger.info(new java.util.Date() +"Inside updateMinutesFrozen");	
		Query query=manager.createNativeQuery(UPDATEFROZEN);
		query.setParameter("schduleid", schduleid);
		int ret=0;
		ret=query.executeUpdate();
		return ret;
	}
	
	private static final String MILESTONEACTIVITYSTATUS="SELECT activitystatusid,activitystatus,activityshort from milestone_activity_status ";
	
	@Override
	public List<Object[]> MilestoneActivityStatus() throws Exception {
		logger.info(new java.util.Date() +"Inside MilestoneActivityStatus");
		Query query=manager.createNativeQuery(MILESTONEACTIVITYSTATUS);
		
		return (List<Object[]>)query.getResultList();
	}
	
	private static final String GETPROJECTSANLIST="SELECT initiationid, projectshortname FROM pfms_initiation";
	@Override
	public List<Object[]> GetProjectInitiationSanList() throws Exception 
	{
		logger.info(new Date() +"Inside GetProjectInitiationSanList");
		Query query = manager.createNativeQuery(GETPROJECTSANLIST);
		
		return  (List<Object[]>) query.getResultList();

	}
	private static final String MILESTONELEVELID="SELECT levelid,levelconfigurationid FROM milestone_activity_level_configuration WHERE projectid=:projectid AND committeeid=:committeeid";
	
	@Override 
	public Object[] MileStoneLevelId(String ProjectId, String Committeeid) throws Exception{
		logger.info(new java.util.Date() +"Inside MileStoneLevelId");

		try {
		Query query=manager.createNativeQuery(MILESTONELEVELID);
		query.setParameter("projectid", ProjectId);
		query.setParameter("committeeid", Committeeid);
		Object[] MileStoneLevelId = (Object[]) query.getSingleResult();
		return MileStoneLevelId;
	
		} catch(NoResultException e) {
			
			return null;
		}

	
	}
	
	@Override 
	public Long MilestoneLevelInsert(MilestoneActivityLevelConfiguration mod) throws Exception{
		logger.info(new java.util.Date() +"Inside MilestoneLevelInsert");

		manager.persist(mod);
		manager.flush();
	
		return mod.getLevelConfigurationId();
	}
	
	private static final String MILESTONELEVELUPDATE="UPDATE milestone_activity_level_configuration SET levelid=:levelid,modifiedby=:modifiedby, modifieddate=:modifieddate WHERE levelconfigurationid=:levelconfigurationid";
	
	@Override 
	public Long MilestoneLevelUpdate(MilestoneActivityLevelConfiguration mod) throws Exception{
		logger.info(new java.util.Date() +"Inside MilestoneLevelUpdate");

		Query query=manager.createNativeQuery(MILESTONELEVELUPDATE);
		query.setParameter("levelid",  mod.getLevelid() );
		query.setParameter("modifiedby", mod.getModifiedDate());
		query.setParameter("modifieddate", mod.getModifiedBy());
		query.setParameter("levelconfigurationid", mod.getLevelConfigurationId());
		
		return (long) query.executeUpdate();
	}
	
	@Override 
	public List<Object[]> BreifingMilestoneDetails(String Projectid) throws Exception{
		logger.info(new java.util.Date() +"Inside BreifingMilestoneDetails");

		Query query=manager.createNativeQuery("CALL Pfms_Milestone_Level_Details (:projectid)");
		query.setParameter("projectid", Projectid);
		
		return (List<Object[]>) query.getResultList();
	}

	private static final String PROJECTINITIATIONDATA="SELECT a.projecttitle  , a.indicativecost , a.projectcost , a.fecost , a.recost ,a.ismain ,a.deliverable , a.pcduration,a.isplanned,b.objective  , b.scope , c.labname ,a.projecttypeid FROM pfms_initiation a , pfms_initiation_detail b , cluster_lab c WHERE a.initiationid = b.initiationid and a.nodallab=c.labid and a.initiationid=:initiationid";
	@Override
	public Object[] GetProjectInitiationdata(String projectid) throws Exception {
		
			logger.info(new Date() +"Inside GetProjectInitiationdata");
			Query query=manager.createNativeQuery(PROJECTINITIATIONDATA);	   
			query.setParameter("initiationid", projectid);
			Object[] ProjectAttributes=null;
			try {
				ProjectAttributes=(Object[])query.getSingleResult();	
			}catch (Exception e) {
				ProjectAttributes=null;
			}
			return ProjectAttributes;
		
	}
	
	private static final String ITEMLIST="SELECT a.minorhead, a.headofaccounts , b.itemdetail , b.itemcost  , c.budgetheaddescription FROM budget_item a,pfms_initiation_cost b ,budget_head c WHERE a.budgetheadid = b.budgetheadid AND a.budgetheadid=c.budgetheadid  AND a.budgetitemid = b.budgetitemid AND b.initiationid=:initiationid";
	
	@Override
	public List<Object[]> GetItemList(String projectid)throws Exception
	{
		logger.info(new Date() +"Inside GetItemList");
		Query query = manager.createNativeQuery(ITEMLIST);
		query.setParameter("initiationid", projectid);
		return  (List<Object[]>) query.getResultList();
	}
	
	private static final String AUTHORITYLIST="SELECT authorityid , authorityname FROM initiation_authority";
	@Override
	public List<Object[]> GetAuthorityList()throws Exception
	{
		logger.info(new Date() +"Inside GetAuthorityList");
		Query query = manager.createNativeQuery(AUTHORITYLIST);
		return (List<Object[]>)query.getResultList();
	}
	private static final String COPYADDR="SELECT  copyaddrid ,copyname, copyaddr , remarks FROM initiation_copyaddr";
	@Override
	public List<Object[]> GetinitiationCopyAddr() throws Exception
	{
		logger.info(new Date() +"Inside GetinitiationCopyAddr");
		Query query = manager.createNativeQuery(COPYADDR);
		return (List<Object[]>)query.getResultList();
	}
	
	private static final String INITIATIONDEPT="SELECT deptaddrid, department , address , city , pin FROM initiation_dept_addr";
	@Override
	public List<Object[]> GetinitiationDeptList ()throws Exception
	{
		logger.info(new Date() +"Inside GetinitiationCopyAddr");
		Query query = manager.createNativeQuery(INITIATIONDEPT);
		return (List<Object[]>)query.getResultList();
	}
	
	@Override
	public Long AddInitiationSanction(InitiationSanction initiationsac) throws Exception{
		logger.info(new Date() +"Inside AddInitiationSanction Add");
		manager.persist(initiationsac);
		manager.flush();
		return initiationsac.getInitiationSanctionId();
	}
	@Override
	public Long AddCopyAddress(InitiationsanctionCopyAddr copyaddress) throws Exception
	{	
		logger.info(new Date() +"Inside AddCopyAddress Add");
		manager.persist(copyaddress);
		manager.flush();
		return copyaddress.getInitiationSanctionCopyId();
	}
	private static final String INITIATIONSANCTIONDATA="SELECT a.initiationid ,a.rdno , b.authorityname , c.department AS 'todepartment' , c.address AS 'toaddress' , c.city AS 'tocity' , c.pin  AS 'topin',d.department AS 'fromdepartment' , d.address AS 'fromaddress' , d.city AS 'fromcity' , d.pin AS 'frompin' ,a.startdate ,a.estimatefund , a.uac ,a.rddate ,a.videno , a.fromdate ,a.fromdeptid ,a.todeptid ,a.authorityid ,a.initiationsanctionid FROM  initiation_sanction a ,initiation_authority b ,initiation_dept_addr c , initiation_dept_addr d WHERE a.authorityid= b.authorityid AND a.fromdeptid= c.deptaddrid AND a.todeptid= c.deptaddrid  AND a.initiationid=:initiationid";
	@Override
	public Object[] GetInitiationSanctionData(String initiationId)throws Exception
	{
		logger.info(new Date() +"Inside GetInitiationSanctionData");
		Query query = manager.createNativeQuery(INITIATIONSANCTIONDATA);
		query.setParameter("initiationid", initiationId);
		List<Object[]> list =(List<Object[]>)query.getResultList();
		Object[] result = null;
		if(list!=null && list.size()>0) {
			result = list.get(0);
		}
		return result;
	}
	private static final String COPYADDRESSDATA="SELECT a.copyaddrid , a.copyname , a.copyaddr , a.remarks,b.initiationsanctioncopyid	 FROM initiation_copyaddr a , initiationsanction_copy_addr b WHERE a.copyaddrid=b.copyaddrid AND b.initiationid=:initiationid";
	@Override
	public List<Object[]> GetCopyAddressList (String initiationId)throws Exception
	{
		logger.info(new Date() +"Inside GetCopyAddressList");
		Query query = manager.createNativeQuery(COPYADDRESSDATA);
		query.setParameter("initiationid", initiationId);
		List<Object[]> list =(List<Object[]>)query.getResultList();
		return list;
	}
	private static final String DELETEINITIATIONSANCOPY="DELETE FROM initiationsanction_copy_addr WHERE InitiationSanctionCopyId=:initiationsancopyid";
	@Override  
	public int DeleteCopyAddress(String initiationsancopyid) throws Exception{

		Query query=manager.createNativeQuery(DELETEINITIATIONSANCOPY);
		query.setParameter("initiationsancopyid", initiationsancopyid);
		int count =(int)query.executeUpdate();
		
		return count;
	}
	
	  private static final String UPDATEINITIATIONSAC="UPDATE initiation_sanction SET RdNo=:rdno ,AuthorityId=:authorityid, FromDeptId=:fromdeptid , FromDate=:fromdate ,  ToDeptId=:todeptid ,StartDate=:startdate , EstimateFund=:estimatefund , UAC=:uac ,RdDate=:rddate , VideNo=:videno ,ModifiedBy=:modifiedby , ModifiedDate=:modifieddate  WHERE InitiationSanctionId=:initiationsanctionid";
		public Long EditInitiationSanction(InitiationSanction initiationsac) throws Exception{
			logger.info(new java.util.Date() +"Inside EditInitiationSanction");	
			Query query=manager.createNativeQuery(UPDATEINITIATIONSAC);
			query.setParameter("rdno",initiationsac.getRdNo() );
			query.setParameter("authorityid",initiationsac.getAuthorityId());
			query.setParameter("fromdeptid",initiationsac.getFromDeptId());
			query.setParameter("fromdate",initiationsac.getFromDate());
			query.setParameter("todeptid",initiationsac.getToDeptId());
			query.setParameter("startdate",initiationsac.getStartDate() );
			query.setParameter("estimatefund",initiationsac.getEstimateFund());
			query.setParameter("uac",initiationsac.getUAC());
			query.setParameter("rddate",initiationsac.getRdDate());
			query.setParameter("videno",initiationsac.getVideNo() );
			query.setParameter("modifiedby",initiationsac.getModifiedBy() );
			query.setParameter("modifieddate",initiationsac.getModifiedDate() );
			query.setParameter("initiationsanctionid",initiationsac.getInitiationSanctionId());
              return (long)query.executeUpdate();
		}

		@Override
		public long insertTechImage(TechImages image) throws Exception {
			logger.info(new Date() +"Inside insertTechImage Add");
			manager.persist(image);
			manager.flush();
			return image.getTechImagesId();
		}
		
		
		private static final String TECHIMAGE="FROM TechImages WHERE ProjectId=:proId";
		@Override
		public List<TechImages> getTechList(String proId)throws Exception
		{
			logger.info(new Date() +"Inside getTechList");
			Query query = manager.createQuery(TECHIMAGE);
			query.setParameter("proId", Long.parseLong(proId));
			List<TechImages> list =(List<TechImages>)query.getResultList();
			return list;
		}
}
