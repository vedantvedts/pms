package com.vts.pfms.projectclosure.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.milestone.model.FileRepMaster;
import com.vts.pfms.project.model.ProjectMaster;

import com.vts.pfms.projectclosure.model.ProjectClosure;
import com.vts.pfms.projectclosure.model.ProjectClosureACP;
import com.vts.pfms.projectclosure.model.ProjectClosureACPAchievements;
import com.vts.pfms.projectclosure.model.ProjectClosureACPConsultancies;
import com.vts.pfms.projectclosure.model.ProjectClosureACPProjects;
import com.vts.pfms.projectclosure.model.ProjectClosureACPTrialResults;
import com.vts.pfms.projectclosure.model.ProjectClosureCheckList;
import com.vts.pfms.projectclosure.model.ProjectClosureSoC;
import com.vts.pfms.projectclosure.model.ProjectClosureTechnical;
import com.vts.pfms.projectclosure.model.ProjectClosureTechnicalChapters;
import com.vts.pfms.projectclosure.model.ProjectClosureTechnicalSection;
import com.vts.pfms.projectclosure.model.ProjectClosureTrans;


@Repository
@Transactional
public class ProjectClosureDaoImpl implements ProjectClosureDao{

	private static final Logger logger = LogManager.getLogger(ProjectClosureDaoImpl.class);

	@PersistenceContext
	EntityManager manager;
	
	private static final String PROJECTCLOSURELIST = "SELECT a.ProjectId,a.ProjectMainId,a.ProjectCode,a.ProjectShortName,a.ProjectName,a.TotalSanctionCost,a.IsMainWC,a.SanctionDate,a.PDC,b.EmpName,c.Designation,\r\n"
			+ "	(SELECT d.ClosureStatusCode FROM pfms_closure cl,pfms_closure_approval_status d WHERE cl.ProjectId=a.ProjectId AND cl.ClosureStatusCode=d.ClosureStatusCode AND cl.IsActive=1 LIMIT 1) AS 'statuscode',\r\n"
			+ "	(SELECT d.ClosureStatus FROM pfms_closure cl,pfms_closure_approval_status d WHERE cl.ProjectId=a.ProjectId AND cl.ClosureStatusCode=d.ClosureStatusCode AND cl.IsActive=1 LIMIT 1) AS 'apprstatus',\r\n"
			+ "	(SELECT d.ClosureStatusColor FROM pfms_closure cl,pfms_closure_approval_status d WHERE cl.ProjectId=a.ProjectId AND cl.ClosureStatusCode=d.ClosureStatusCode AND cl.IsActive=1 LIMIT 1) AS 'statuscolor',\r\n"
			+ "	(SELECT cl.ClosureId FROM pfms_closure cl WHERE cl.ProjectId=a.ProjectId AND cl.IsActive=1 LIMIT 1) AS 'closureid',\r\n"
			+ "	(SELECT cl.ApprovalFor FROM pfms_closure cl WHERE cl.ProjectId=a.ProjectId AND cl.IsActive=1 LIMIT 1) AS 'approvalfor',\r\n"
			+ "	(SELECT cl.ClosureCategory FROM pfms_closure cl WHERE cl.ProjectId=a.ProjectId AND cl.IsActive=1 LIMIT 1) AS 'closurecategory'\r\n"
			+ "	FROM project_master a, employee b, employee_desig c \r\n"
			+ "	WHERE a.IsActive=1 AND a.ProjectDirector=b.EmpId AND b.DesigId=c.DesigId AND a.LabCode=:LabCode AND (CASE WHEN :LoginType IN ('A','Z','E','L') THEN 1=1 ELSE a.ProjectDirector=:EmpId END) ORDER BY a.ProjectId DESC";
	@Override
	public List<Object[]> projectClosureList(String EmpId, String labcode, String LoginType) throws Exception {
		try {
			Query query = manager.createNativeQuery(PROJECTCLOSURELIST);
			query.setParameter("EmpId", EmpId);
			query.setParameter("LabCode", labcode);
			query.setParameter("LoginType", LoginType);
			return (List<Object[]>) query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO projectClosureList "+e);
			return new ArrayList<>();
		}

	}
	
	@Override
	public ProjectMaster getProjectMasterByProjectId(String projectId) throws Exception {
		try {
			return manager.find(ProjectMaster.class, Long.parseLong(projectId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectMasterByProjectId "+e);
			return null;
		}
		
	}
	
	@Override
	public ProjectClosure getProjectClosureById(String closureId) throws Exception {
		try {
			return manager.find(ProjectClosure.class, Long.parseLong(closureId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureById "+e);
			return null;
		}
		
	}

	@Override
	public long addProjectClosure(ProjectClosure closure) throws Exception{
		try {
			manager.persist(closure);
			manager.flush();
			return closure.getClosureId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addProjectClosure "+e);
			return 0L;
		}
	}

	@Override
	public long editProjectClosure(ProjectClosure closure) throws Exception {
		try {
			manager.merge(closure);
			manager.flush();
			return closure.getClosureId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO editProjectClosure "+e);
			return 0L;
		}
	}
	
	@Override
	public ProjectClosureSoC getProjectClosureSoCByProjectId(String closureId) throws Exception {
		try {
			Query query = manager.createQuery("FROM ProjectClosureSoC WHERE ClosureId=:ClosureId AND IsActive=1");
			query.setParameter("ClosureId", Long.parseLong(closureId));
			List<ProjectClosureSoC> list = (List<ProjectClosureSoC>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureSoCByProjectId "+e);
			return null;
		}
		
	}
	
	@Override
	public long addProjectClosureSoC(ProjectClosureSoC soc) throws Exception{
		try {
			manager.persist(soc);
			manager.flush();
			return soc.getClosureSoCId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addProjectClosureSoC "+e);
			return 0L;
		}
	}

	@Override
	public long editProjectClosureSoC(ProjectClosureSoC soc) throws Exception {
		try {
			manager.merge(soc);
			manager.flush();
			return soc.getClosureSoCId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO editProjectClosureSoC "+e);
			return 0L;
		}
	}
	
	@Override
	public long addProjectClosureTransaction(ProjectClosureTrans transaction) throws Exception{
		try {
			manager.persist(transaction);
			manager.flush();
			return transaction.getClosureTransId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addProjectClosureTransaction "+e);
			return 0L;
		}
	}
	
	private static final String PROJECTCLOSURETRANSAPPROVALDATABYTYPE = "SELECT a.ClosureTransId,\r\n"
			+ "	(SELECT empno FROM pfms_closure_trans t , employee e  WHERE e.EmpId = t.ActionBy AND t.ClosureStatusCode =  b.ClosureStatusCode AND t.ClosureId=d.ClosureId ORDER BY t.ClosureTransId DESC LIMIT 1) AS 'empno',\r\n"
			+ "	(SELECT empname FROM pfms_closure_trans t , employee e  WHERE e.EmpId = t.ActionBy AND t.ClosureStatusCode =  b.ClosureStatusCode AND t.ClosureId=d.ClosureId ORDER BY t.ClosureTransId DESC LIMIT 1) AS 'empname',\r\n"
			+ "	(SELECT designation FROM pfms_closure_trans t , employee e,employee_desig des WHERE e.EmpId = t.ActionBy AND e.desigid=des.desigid AND t.ClosureStatusCode = b.ClosureStatusCode AND t.ClosureId=d.ClosureId ORDER BY t.ClosureTransId DESC LIMIT 1) AS 'Designation',\r\n"
			+ "	MAX(a.ActionDate) AS ActionDate,a.Remarks,b.ClosureStatus,b.ClosureStatusColor,b.ClosureStatusCode\r\n"
			+ "	FROM pfms_closure_trans a,pfms_closure_approval_status b,employee c,pfms_closure d\r\n"
			+ "	WHERE a.ClosureId=d.ClosureId AND a.ClosureStatusCode =b.ClosureStatusCode  AND a.Actionby=c.EmpId AND b.ClosureForward=:ClosureForward AND a.ClosureForm=:ClosureForm AND d.ClosureId=:ClosureId GROUP BY b.ClosureStatusCode ORDER BY a.ClosureTransId ASC";
	@Override
	public List<Object[]> projectClosureApprovalDataByType(String closureId, String closureForward, String closureForm) throws Exception{

		try {
			Query query = manager.createNativeQuery(PROJECTCLOSURETRANSAPPROVALDATABYTYPE);
			query.setParameter("ClosureId", closureId);
			query.setParameter("ClosureForward", closureForward);
			query.setParameter("ClosureForm", closureForm);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			logger.info(new Date()+"Inside DAO projectClosureApprovalDataByType "+e);
			e.printStackTrace();
			return null;
		}

	}
	
	private static final String PROJECTCLOSUREREMARKSHISTORYBYTYPE  ="SELECT b.ClosureId,b.Remarks,a.ClosureStatusCode,d.EmpName,e.Designation FROM pfms_closure_approval_status a,pfms_closure_trans b,pfms_closure c,employee d,employee_desig e WHERE b.ActionBy = d.EmpId AND d.DesigId = e.DesigId AND a.ClosureStatusCode = b.ClosureStatusCode AND c.ClosureId = b.ClosureId AND TRIM(b.Remarks)<>'' AND a.ClosureForward=:ClosureForward AND b.ClosureForm=:ClosureForm AND c.ClosureId=:ClosureId ORDER BY b.ClosureTransId ASC";
	@Override
	public List<Object[]> projectClosureRemarksHistoryByType(String closureId, String closureForward, String closureForm) throws Exception
	{
		List<Object[]> list =new ArrayList<Object[]>();
		try {
			Query query= manager.createNativeQuery(PROJECTCLOSUREREMARKSHISTORYBYTYPE);
			query.setParameter("ClosureId", closureId);
			query.setParameter("ClosureForward", closureForward);
			query.setParameter("ClosureForm", closureForm);
			list= (List<Object[]>)query.getResultList();

		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO projectClosureRemarksHistoryByType " + e);
			e.printStackTrace();
		}
		return list;
	}
	
	private static final String GETEMPGDDETAILS  ="SELECT a.EmpId,a.EmpName,b.Designation FROM employee a,employee_desig b WHERE a.DesigId = b.DesigId AND a.EmpId = (SELECT dm.DivisionHeadId FROM employee emp,division_master dm WHERE dm.DivisionId = emp.DivisionId AND emp.EmpId=:EmpId AND emp.IsActive=1 LIMIT 1)";
	@Override
	public Object[] getEmpGDDetails(String empId) throws Exception
	{
		try {			
			Query query= manager.createNativeQuery(GETEMPGDDETAILS);
			query.setParameter("EmpId", empId);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO getEmpPDEmpId " + e);
			e.printStackTrace();
			return null;
		}		
	}
	
	private static final String PROJECTCLOSURESOCPENDINGLIST  ="CALL pfms_closure_soc_pending(:EmpId,:LabCode);";
	@Override
	public List<Object[]> projectClosureSoCPendingList(String empId,String labcode) throws Exception {
		try {			
			Query query= manager.createNativeQuery(PROJECTCLOSURESOCPENDINGLIST);
			query.setParameter("EmpId", Long.parseLong(empId));
			query.setParameter("LabCode", labcode);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO projectClosureSoCPendingList " + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}

	}

	private static final String PROJECTCLOSURESOCAPPROVEDLIST  ="CALL pfms_closure_soc_approved(:EmpId,:FromDate,:ToDate);";
	@Override
	public List<Object[]> projectClosureSoCApprovedList(String empId, String FromDate, String ToDate) throws Exception {

		try {			
			Query query= manager.createNativeQuery(PROJECTCLOSURESOCAPPROVEDLIST);
			query.setParameter("EmpId", Long.parseLong(empId));
			query.setParameter("FromDate", FromDate);
			query.setParameter("ToDate", ToDate);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO projectClosureSoCApprovedList " + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}
	
	private static final String PROJECTCLOSURESOCTRANSLISTBYTYPE = "SELECT a.ClosureTransId,c.EmpId,c.EmpName,d.Designation,a.ActionDate,a.Remarks,b.ClosureStatus,b.ClosureStatusColor FROM pfms_closure_trans a,pfms_closure_approval_status b,employee c,employee_desig d,pfms_closure e WHERE e.ClosureId = a.ClosureId AND a.ClosureStatusCode = b.ClosureStatusCode AND a.ActionBy=c.EmpId AND c.DesigId = d.DesigId AND b.ClosureStatusFor=:ClosureStatusFor AND a.ClosureForm=:ClosureForm AND e.ClosureId=:ClosureId ORDER BY a.ClosureTransId DESC";
	@Override
	public List<Object[]> projectClosureTransListByType(String closureId, String closureStatusFor, String closureForm) throws Exception {

		try {
			Query query = manager.createNativeQuery(PROJECTCLOSURESOCTRANSLISTBYTYPE);
			query.setParameter("ClosureId", Long.parseLong(closureId));
			query.setParameter("ClosureStatusFor", closureStatusFor);
			query.setParameter("ClosureForm", closureForm);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			logger.info(new Date()+"Inside DAO projectClosureTransListByType "+e);
			e.printStackTrace();
			return null;
		}

	}

	@Override
	public ProjectClosureACP getProjectClosureACPByProjectId(String closureId) throws Exception {
		try {
			Query query = manager.createQuery("FROM ProjectClosureACP WHERE ClosureId=:ClosureId AND IsActive=1");
			query.setParameter("ClosureId", Long.parseLong(closureId));
			List<ProjectClosureACP> list = (List<ProjectClosureACP>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureACPByProjectId "+e);
			return null;
		}
		
	}
	
	@Override
	public long addProjectClosureACP(ProjectClosureACP acp) throws Exception{
		try {
			manager.persist(acp);
			manager.flush();
			return acp.getClosureACPId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addProjectClosureACP "+e);
			return 0L;
		}
	}

	@Override
	public long editProjectClosureACP(ProjectClosureACP acp) throws Exception {
		try {
			manager.merge(acp);
			manager.flush();
			return acp.getClosureACPId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO editProjectClosureACP "+e);
			return 0L;
		}
	}

	@Override
	public long addProjectClosureACPProjects(ProjectClosureACPProjects projects) throws Exception{
		try {
			manager.persist(projects);
			manager.flush();
			return projects.getClosureACPProjectId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addProjectClosureACPProjects "+e);
			return 0L;
		}
	}
	
	@Override
	public long addProjectClosureACPConsultancies(ProjectClosureACPConsultancies consultancies) throws Exception{
		try {
			manager.persist(consultancies);
			manager.flush();
			return consultancies.getConsultancyId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addProjectClosureACPConsultancies "+e);
			return 0L;
		}
	}
	
	@Override
	public long addProjectClosureACPAchievements(ProjectClosureACPAchievements achievements) throws Exception{
		try {
			manager.persist(achievements);
			manager.flush();
			return achievements.getAchievementsId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addProjectClosureACPAchievements "+e);
			return 0L;
		}
	}
	
	@Override
	public long addProjectClosureACPTrialResults(ProjectClosureACPTrialResults trialResults) throws Exception{
		try {
			manager.persist(trialResults);
			manager.flush();
			return trialResults.getTrialResultsId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addProjectClosureACPTrialResults "+e);
			return 0L;
		}
	}

	private static final String PROJECTCLOSUREACPPROJECTSBYPROJECTSBYID = "FROM ProjectClosureACPProjects WHERE ClosureId=:ClosureId AND IsActive=1";
	@Override
	public List<ProjectClosureACPProjects> getProjectClosureACPProjectsByProjectId(String closureId) throws Exception {
		try {
			Query query = manager.createQuery(PROJECTCLOSUREACPPROJECTSBYPROJECTSBYID);
			query.setParameter("ClosureId", Long.parseLong(closureId));
			return (List<ProjectClosureACPProjects>)query.getResultList();

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureACPProjectsByProjectId "+e);
			return null;
		}
	}
	
	private static final String PROJECTCLOSUREACPPROJECTSBYCONSULTANTSBYID = "FROM ProjectClosureACPConsultancies WHERE ClosureId=:ClosureId AND IsActive=1";
	@Override
	public List<ProjectClosureACPConsultancies> getProjectClosureACPConsultanciesByProjectId(String closureId) throws Exception {
		try {
			Query query = manager.createQuery(PROJECTCLOSUREACPPROJECTSBYCONSULTANTSBYID);
			query.setParameter("ClosureId", Long.parseLong(closureId));
			return (List<ProjectClosureACPConsultancies>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureACPConsultanciesByProjectId "+e);
			return null;
		}
	}
	
	private static final String PROJECTCLOSUREACPPROJECTSBYTRIALRESULTSBYID = "FROM ProjectClosureACPTrialResults WHERE ClosureId=:ClosureId AND IsActive=1";
	@Override
	public List<ProjectClosureACPTrialResults> getProjectClosureACPTrialResultsByProjectId(String closureId) throws Exception {
		try {
			Query query = manager.createQuery(PROJECTCLOSUREACPPROJECTSBYTRIALRESULTSBYID);
			query.setParameter("ClosureId", Long.parseLong(closureId));
			return (List<ProjectClosureACPTrialResults>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureACPTrialResultsByProjectId "+e);
			return null;
		}
	}
	
	private static final String PROJECTCLOSUREACPPROJECTSBYACHIVEMENTSBYID = "FROM ProjectClosureACPAchievements WHERE ClosureId=:ClosureId AND IsActive=1";
	@Override
	public List<ProjectClosureACPAchievements> getProjectClosureACPAchievementsByProjectId(String closureId) throws Exception {
		try {
			Query query = manager.createQuery(PROJECTCLOSUREACPPROJECTSBYACHIVEMENTSBYID);
			query.setParameter("ClosureId", Long.parseLong(closureId));
			return (List<ProjectClosureACPAchievements>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureACPAchievementsByProjectId "+e);
			return null;
		}
	}
	
	private static final String REMOVEPROJECTCLOSUREACPPROJECTDETAILSBYTYPE = "UPDATE pfms_closure_acp_projects SET IsActive=:IsActive WHERE ClosureId=:ClosureId AND (CASE WHEN 'S'=:ACPProjectType THEN ACPProjectType=:ACPProjectType ELSE ACPProjectType IN('R','P') END)";
	@Override
	public int removeProjectClosureACPProjectDetailsByType(long closureId, String acpProjectType) throws Exception{
		try {
			Query query = manager.createNativeQuery(REMOVEPROJECTCLOSUREACPPROJECTDETAILSBYTYPE);
			query.setParameter("IsActive", "0");
			query.setParameter("ClosureId", closureId);
			query.setParameter("ACPProjectType", acpProjectType);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO removeProjectClosureACPProjectDetailsByType "+e);
			return 0;
		}

	}

	private static final String REMOVEPROJECTCLOSUREACPCONSULTANCYDETAILSBYTYPE = "UPDATE pfms_closure_acp_consultancies SET IsActive=:IsActive WHERE ClosureId=:ClosureId";
	@Override
	public int removeProjectClosureACPConsultancyDetails(long closureId) throws Exception {
		try {
			Query query = manager.createNativeQuery(REMOVEPROJECTCLOSUREACPCONSULTANCYDETAILSBYTYPE);
			query.setParameter("IsActive", "0");
			query.setParameter("ClosureId", closureId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO removeProjectClosureACPProjectDetailsByType "+e);
			return 0;
		}

	}
	
	private static final String REMOVEPROJECTCLOSUREACPTRIALRESULTSDETAILSBYTYPE = "UPDATE pfms_closure_acp_trial_results SET IsActive=:IsActive WHERE ClosureId=:ClosureId";
	@Override
	public int removeProjectClosureACPTrialResultsDetails(long closureId) throws Exception {
		try {
			Query query = manager.createNativeQuery(REMOVEPROJECTCLOSUREACPTRIALRESULTSDETAILSBYTYPE);
			query.setParameter("IsActive", "0");
			query.setParameter("ClosureId", closureId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO removeProjectClosureACPTrialResultsDetails "+e);
			return 0;
		}
		
	}
	
	@Override
	public ProjectClosureACPTrialResults getProjectClosureACPTrialResultsById(String trialResultId) throws Exception {
		try {
			return manager.find(ProjectClosureACPTrialResults.class, Long.parseLong(trialResultId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureACPTrialResultsById "+e);
			return null;
		}
		
	}

	private static final String REMOVEPROJECTCLOSUREACPACHIVEMENTDETAILSBYTYPE = "UPDATE pfms_closure_acp_achievements SET IsActive=:IsActive WHERE ClosureId=:ClosureId";
	@Override
	public int removeProjectClosureACPAchievementDetails(long closureId) throws Exception {
		try {
			Query query = manager.createNativeQuery(REMOVEPROJECTCLOSUREACPACHIVEMENTDETAILSBYTYPE);
			query.setParameter("IsActive", "0");
			query.setParameter("ClosureId", closureId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO removeProjectClosureACPAchievementDetails "+e);
			return 0;
		}
		
	}

	private static final String PROJECTCLOSUREACPPENDINGLIST  ="CALL pfms_closure_acp_pending(:EmpId,:LabCode);";
	@Override
	public List<Object[]> projectClosureACPPendingList(String empId,String labcode) throws Exception {
		try {			
			Query query= manager.createNativeQuery(PROJECTCLOSUREACPPENDINGLIST);
			query.setParameter("EmpId", Long.parseLong(empId));
			query.setParameter("LabCode", labcode);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO projectClosureACPPendingList " + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}

	}

	private static final String PROJECTCLOSUREACPAPPROVEDLIST  ="CALL pfms_closure_acp_approved(:EmpId,:FromDate,:ToDate);";
	@Override
	public List<Object[]> projectClosureACPApprovedList(String empId, String FromDate, String ToDate) throws Exception {

		try {			
			Query query= manager.createNativeQuery(PROJECTCLOSUREACPAPPROVEDLIST);
			query.setParameter("EmpId", Long.parseLong(empId));
			query.setParameter("FromDate", FromDate);
			query.setParameter("ToDate", ToDate);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO projectClosureACPApprovedList " + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}
	
	private static final String PROJECTORIGINALANDREVISIONDETAILS = "SELECT (SELECT b.ProjectType FROM project_master a,project_type b WHERE a.ProjectId=:ProjectId AND b.ProjectTypeId=a.ProjectCategory LIMIT 1) AS 'Category',(SELECT a.SanctionCostRE FROM project_master a WHERE a.ProjectId=:ProjectId AND a.IsActive=1 LIMIT 1) AS 'pmSanctionCostRE',(SELECT a.SanctionCostFE FROM project_master a WHERE a.ProjectId=:ProjectId AND a.IsActive=1 LIMIT 1) AS 'pmSanctionCostFE',(SELECT a.TotalSanctionCost FROM project_master a WHERE a.ProjectId=:ProjectId AND a.IsActive=1 LIMIT 1) AS 'pmTotalSanctionCost',(SELECT a.SanctionCostRE FROM project_master_rev a WHERE a.ProjectId=:ProjectId ORDER BY a.ProjectRevId LIMIT 1) AS 'pmrevSanctionCostRE',(SELECT a.SanctionCostFE FROM project_master_rev a WHERE a.ProjectId=:ProjectId ORDER BY a.ProjectRevId LIMIT 1) AS 'pmrevSanctionCostFE',(SELECT a.TotalSanctionCost FROM project_master_rev a WHERE a.ProjectId=:ProjectId ORDER BY a.ProjectRevId LIMIT 1) AS 'pmrevTotalSanctionCost',(SELECT a.PDC FROM project_master a WHERE a.ProjectId=:ProjectId AND a.IsActive=1 LIMIT 1) AS 'pmPDC',(SELECT a.PDC FROM project_master_rev a WHERE a.ProjectId=:ProjectId ORDER BY a.ProjectRevId LIMIT 1) AS 'pmrevPDC',(SELECT COUNT(a.ProjectRevId) FROM project_master_rev a WHERE a.ProjectId=:ProjectId LIMIT 1) AS 'NoOfRevisions'FROM DUAL";
	@Override
	public Object[] projectOriginalAndRevisionDetails(String projectId) throws Exception
	{
		try {			
			Query query= manager.createNativeQuery(PROJECTORIGINALANDREVISIONDETAILS);
			query.setParameter("ProjectId", projectId);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO projectOriginalAndRevisionDetails " + e);
			e.printStackTrace();
			return null;
		}		
	}
	
	private static final String PROJECTEXPENDITUREDETAILS = "SELECT SUM(CASE WHEN ReFe = 'RE' THEN Expenditure ELSE 0 END) AS 'ExpenditureRE',SUM(CASE WHEN ReFe = 'FE' THEN Expenditure ELSE 0 END) AS 'ExpenditureFE' FROM project_hoa WHERE ProjectId = :ProjectId";
	@Override
	public Object[] projectExpenditureDetails(String projectId) throws Exception
	{
		try {			
			Query query= manager.createNativeQuery(PROJECTEXPENDITUREDETAILS);
			query.setParameter("ProjectId", projectId);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO projectExpenditureDetails " + e);
			e.printStackTrace();
			return null;
		}		
	}

	@Override
	public ProjectClosureCheckList getProjectClosureCheckListByProjectId(String closureId) throws Exception {
		
		try {
			Query query = manager.createQuery("FROM ProjectClosureCheckList WHERE ClosureId=:ClosureId AND IsActive=1");
			query.setParameter("ClosureId", Long.parseLong(closureId));
			List<ProjectClosureCheckList> list = (List<ProjectClosureCheckList>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureSoCByProjectId "+e);
			return null;
		}
	}

	@Override
	public long addProjectClosureCheckList(ProjectClosureCheckList clist) throws Exception {
		
		
		
		try {
			manager.persist(clist);
			manager.flush();
			return clist.getClosureCheckListId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addProjectClosureCheckList "+e);
			return 0L;
		}
	}

	@Override
	public long editProjectClosureCheckList(ProjectClosureCheckList clist) throws Exception {
		
		
		try {
			manager.merge(clist);
			manager.flush();
			return clist.getClosureCheckListId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO editProjectClosureCheckList "+e);
			return 0L;
		}
	}

	@Override
	public long AddIssue(ProjectClosureTechnical tech) throws Exception {
		
		try {
			manager.persist(tech);
			manager.flush();
			return tech.getTechnicalClosureId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO AddIssue "+e);
			return 0L;
		}
	}

	private static final String TECHNICALCLOSURERECORDLIST="SELECT  a.TechnicalClosureId,a.Particulars,a.RevisionNo,a.IssueDate,a.Status,b.ClosureStatus\r\n"
			+ " FROM  pfms_closure_technical a ,pfms_closure_approval_status b WHERE b.ClosureStatusCode=a.Status AND \r\n"
			+ " a.isActive='1' AND a.ClosureId=:closureId ";
	@Override
	public List<Object[]> getTechnicalClosureRecord(String closureId) throws Exception {
		
		try {			
			Query query= manager.createNativeQuery(TECHNICALCLOSURERECORDLIST);
			query.setParameter("closureId", closureId);
			
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO getTechnicalClosureRecord " + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}

	@Override
	public long AddSection(ProjectClosureTechnicalSection sec) throws Exception {
		
		try {
			manager.persist(sec);
			manager.flush();
			return sec.getSectionId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO AddSection "+e);
			return 0L;
		}
	}

	private static final String TECHNICALCLOSURESECTIONLIST="SELECT  SectionId,ClosureId,SectionName ,'S' AS 'selected' FROM pfms_closure_technical_sections \r\n"
			+ "WHERE sectionid IN (SELECT sectionid FROM `pfms_closure_technical_chapters`) AND closureid=:closureId\r\n"
			+ "\r\n"
			+ "UNION \r\n"
			+ "\r\n"
			+ "SELECT  SectionId,ClosureId,SectionName, 'N' AS 'selected' FROM pfms_closure_technical_sections\r\n"
			+ "WHERE sectionid NOT IN (SELECT sectionid FROM `pfms_closure_technical_chapters`) AND closureid=:closureId";
	@Override
	public List<Object[]> getSectionList(String closureId) throws Exception {
		
		try {			
			Query query= manager.createNativeQuery(TECHNICALCLOSURESECTIONLIST);
			query.setParameter("closureId", closureId);
			
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO getSectionList" + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}

	
	private static final String TECHNICALCLOSURECHAPTERLIST="SELECT a.ChapterId, a.ChapterParentId, a.SectionId, a.ChapterName, a.ChapterContent  FROM  pfms_closure_technical_chapters a ,pfms_closure_technical_sections b WHERE a.SectionId=b.SectionId AND b.ClosureId=:closureId";
	@Override
	public List<Object[]> getChapterList(String closureId) throws Exception {
	
		
		try {			
			Query query= manager.createNativeQuery(TECHNICALCLOSURECHAPTERLIST);
			query.setParameter("closureId", closureId);
			
			
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO getChapterList" + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}

	@Override
	public long ChapterAdd(ProjectClosureTechnicalChapters chapter) throws Exception {
		
		try {
			manager.persist(chapter);
			manager.flush();
			return chapter.getChapterId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO ChapterAdd "+e);
			return 0L;
		}
	}

	@Override
	public ProjectClosureTechnicalSection getProjectClosureTechnicalSectionById(String id) throws Exception {
		
		try {
			return manager.find(ProjectClosureTechnicalSection.class, Long.parseLong(id));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureTechnicalSectionById "+e);
			return null;
		}
		
	}

	@Override
	public long ChapterEdit(String chapterId, String chapterName,String ChapterContent) throws Exception {
		
		ProjectClosureTechnicalChapters chapter=manager.find(ProjectClosureTechnicalChapters.class,Long.parseLong(chapterId));	
		chapter.setChapterName(chapterName);
		chapter.setChapterContent(ChapterContent);
		chapter=manager.merge(chapter);
		if(chapter!=null) {
			return 1;
		}else
		{
			return 0;
		}
		
	}

	private static final String TECHNICALCLOSURECHAPTERCONTENT="SELECT chapterid,chaptercontent FROM pfms_closure_technical_chapters WHERE chapterid=:chapterId";
	@Override
	public Object[] getChapterContent(String chapterId) throws Exception {
		
		try {			
			Query query= manager.createNativeQuery(TECHNICALCLOSURECHAPTERCONTENT);
			query.setParameter("chapterId", chapterId);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO getChapterContent " + e);
			e.printStackTrace();
			return null;
		}		
	}
}
