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

import com.vts.pfms.project.model.ProjectMaster;
import com.vts.pfms.project.model.ProjectMasterRev;
import com.vts.pfms.projectclosure.model.ProjectClosureACP;
import com.vts.pfms.projectclosure.model.ProjectClosureACPAchievements;
import com.vts.pfms.projectclosure.model.ProjectClosureACPConsultancies;
import com.vts.pfms.projectclosure.model.ProjectClosureACPProjects;
import com.vts.pfms.projectclosure.model.ProjectClosureACPTrialResults;
import com.vts.pfms.projectclosure.model.ProjectClosureSoC;
import com.vts.pfms.projectclosure.model.ProjectClosureTrans;


@Repository
@Transactional
public class ProjectClosureDaoImpl implements ProjectClosureDao{

	private static final Logger logger = LogManager.getLogger(ProjectClosureDaoImpl.class);

	@PersistenceContext
	EntityManager manager;
	
	private static final String PROJECTCLOSURELIST = "SELECT a.ProjectId,a.ProjectMainId,a.ProjectCode,a.ProjectShortName,a.ProjectName,a.TotalSanctionCost,a.IsMainWC,a.SanctionDate,a.PDC,b.EmpName,c.Designation,\r\n"
			+ "	(SELECT d.ClosureStatusCode FROM pfms_closure_soc soc,pfms_closure_approval_status d WHERE soc.ProjectId=a.ProjectId AND soc.ClosureStatusCode=d.ClosureStatusCode AND soc.IsActive=1 LIMIT 1) AS 'socstatuscode',\r\n"
			+ "	(SELECT d.ClosureStatus FROM pfms_closure_soc soc,pfms_closure_approval_status d WHERE soc.ProjectId=a.ProjectId AND soc.ClosureStatusCode=d.ClosureStatusCode AND soc.IsActive=1 LIMIT 1) AS 'socstatus',\r\n"
			+ "	(SELECT d.ClosureStatusColor FROM pfms_closure_soc soc,pfms_closure_approval_status d WHERE soc.ProjectId=a.ProjectId AND soc.ClosureStatusCode=d.ClosureStatusCode AND soc.IsActive=1 LIMIT 1) AS 'socstatuscolor',\r\n"
			+ "	(SELECT d.ClosureStatusCode FROM pfms_closure_acp acp,pfms_closure_approval_status d WHERE acp.ProjectId=a.ProjectId AND acp.ClosureStatusCode=d.ClosureStatusCode AND acp.IsActive=1 LIMIT 1) AS 'acpstatuscode',\r\n"
			+ "	(SELECT d.ClosureStatus FROM pfms_closure_acp acp,pfms_closure_approval_status d WHERE acp.ProjectId=a.ProjectId AND acp.ClosureStatusCode=d.ClosureStatusCode AND acp.IsActive=1 LIMIT 1) AS 'acpstatus',\r\n"
			+ "	(SELECT d.ClosureStatusColor FROM pfms_closure_acp acp,pfms_closure_approval_status d WHERE acp.ProjectId=a.ProjectId AND acp.ClosureStatusCode=d.ClosureStatusCode AND acp.IsActive=1 LIMIT 1) AS 'acpstatuscolor'\r\n"
			+ "FROM project_master a, employee b, employee_desig c \r\n"
			+ "WHERE a.IsActive=1 AND a.ProjectDirector=b.EmpId AND b.DesigId=c.DesigId AND a.LabCode=:LabCode AND a.ProjectDirector=:EmpId";
	@Override
	public List<Object[]> projectClosureList(String EmpId, String labcode) throws Exception {
		try {
			Query query = manager.createNativeQuery(PROJECTCLOSURELIST);
			query.setParameter("EmpId", EmpId);
			query.setParameter("LabCode", labcode);
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
	public ProjectClosureSoC getProjectClosureSoCByProjectId(String projectId) throws Exception {
		try {
			return manager.find(ProjectClosureSoC.class, Long.parseLong(projectId));
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
	public ProjectMasterRev getProjectMasterRevByProjectId(String projectId) throws Exception {
		try {
			return manager.find(ProjectMasterRev.class, Long.parseLong(projectId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectMasterRevByProjectId "+e);
			return null;
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
	
	private static final String PROJECTCLOSURESOCTRANSAPPROVALDATABYTYPE = "SELECT a.ClosureTransId,\r\n"
			+ "	(SELECT empno FROM pfms_closure_trans t , employee e  WHERE e.EmpId = t.ActionBy AND t.ClosureStatusCode =  b.ClosureStatusCode AND t.ProjectId=d.ProjectId ORDER BY t.ClosureTransId DESC LIMIT 1) AS 'empno',\r\n"
			+ "	(SELECT empname FROM pfms_closure_trans t , employee e  WHERE e.EmpId = t.ActionBy AND t.ClosureStatusCode =  b.ClosureStatusCode AND t.ProjectId=d.ProjectId ORDER BY t.ClosureTransId DESC LIMIT 1) AS 'empname',\r\n"
			+ "	(SELECT designation FROM pfms_closure_trans t , employee e,employee_desig des WHERE e.EmpId = t.ActionBy AND e.desigid=des.desigid AND t.ClosureStatusCode = b.ClosureStatusCode AND t.ProjectId=d.ProjectId ORDER BY t.ClosureTransId DESC LIMIT 1) AS 'Designation',\r\n"
			+ "	MAX(a.ActionDate) AS ActionDate,a.Remarks,b.ClosureStatus,b.ClosureStatusColor,b.ClosureStatusCode\r\n"
			+ "	FROM pfms_closure_trans a,pfms_closure_approval_status b,employee c,pfms_closure_soc d\r\n"
			+ "	WHERE a.ProjectId=d.ProjectId AND a.ClosureStatusCode =b.ClosureStatusCode  AND a.Actionby=c.EmpId AND b.ClosureForward=:ClosureForward AND a.ClosureForm=:ClosureForm AND d.ProjectId=:ProjectId GROUP BY b.ClosureStatusCode ORDER BY a.ClosureTransId ASC";
	@Override
	public List<Object[]> projectClosureApprovalDataByType(String projectId, String closureForward, String closureForm) throws Exception{

		try {
			Query query = manager.createNativeQuery(PROJECTCLOSURESOCTRANSAPPROVALDATABYTYPE);
			query.setParameter("ProjectId", projectId);
			query.setParameter("ClosureForward", closureForward);
			query.setParameter("ClosureForm", closureForm);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			logger.info(new Date()+"Inside DAO projectClosureApprovalDataByType "+e);
			e.printStackTrace();
			return null;
		}

	}
	
	private static final String PROJECTCLOSURESOCREMARKSHISTORYBYTYPE  ="SELECT b.ProjectId,b.Remarks,a.ClosureStatusCode,d.EmpName,e.Designation FROM pfms_closure_approval_status a,pfms_closure_trans b,pfms_closure_soc c,employee d,employee_desig e WHERE b.ActionBy = d.EmpId AND d.DesigId = e.DesigId AND a.ClosureStatusCode = b.ClosureStatusCode AND c.ProjectId = b.ProjectId AND TRIM(b.Remarks)<>'' AND a.ClosureForward=:ClosureForward AND b.ClosureForm=:ClosureForm AND c.ProjectId=:ProjectId ORDER BY b.ClosureTransId ASC";
	@Override
	public List<Object[]> projectClosureRemarksHistoryByType(String projectId, String closureForward, String closureForm) throws Exception
	{
		List<Object[]> list =new ArrayList<Object[]>();
		try {
			Query query= manager.createNativeQuery(PROJECTCLOSURESOCREMARKSHISTORYBYTYPE);
			query.setParameter("ProjectId", projectId);
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
	
	private static final String PROJECTCLOSURESOCTRANSLISTBYTYPE = "SELECT a.ClosureTransId,c.EmpId,c.EmpName,d.Designation,a.ActionDate,a.Remarks,b.ClosureStatus,b.ClosureStatusColor FROM pfms_closure_trans a,pfms_closure_approval_status b,employee c,employee_desig d,pfms_closure_soc e WHERE e.ProjectId = a.ProjectId AND a.ClosureStatusCode = b.ClosureStatusCode AND a.ActionBy=c.EmpId AND c.DesigId = d.DesigId AND b.ClosureStatusFor=:ClosureStatusFor AND a.ClosureForm=:ClosureForm AND e.ProjectId=:ProjectId ORDER BY a.ClosureTransId DESC";
	@Override
	public List<Object[]> projectClosureTransListByType(String projectId, String closureStatusFor, String closureForm) throws Exception {

		try {
			Query query = manager.createNativeQuery(PROJECTCLOSURESOCTRANSLISTBYTYPE);
			query.setParameter("ProjectId", projectId);
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
	public ProjectClosureACP getProjectClosureACPByProjectId(String projectId) throws Exception {
		try {
			return manager.find(ProjectClosureACP.class, Long.parseLong(projectId));
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

	private static final String PROJECTCLOSUREACPPROJECTSBYPROJECTSBYID = "FROM ProjectClosureACPProjects WHERE ProjectId=:ProjectId AND IsActive=1";
	@Override
	public List<ProjectClosureACPProjects> getProjectClosureACPProjectsByProjectId(String projectId) throws Exception {
		try {
			Query query = manager.createQuery(PROJECTCLOSUREACPPROJECTSBYPROJECTSBYID);
			query.setParameter("ProjectId", Long.parseLong(projectId));
			return (List<ProjectClosureACPProjects>)query.getResultList();

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureACPProjectsByProjectId "+e);
			return null;
		}
	}
	
	private static final String PROJECTCLOSUREACPPROJECTSBYCONSULTANTSBYID = "FROM ProjectClosureACPConsultancies WHERE ProjectId=:ProjectId AND IsActive=1";
	@Override
	public List<ProjectClosureACPConsultancies> getProjectClosureACPConsultanciesByProjectId(String projectId) throws Exception {
		try {
			Query query = manager.createQuery(PROJECTCLOSUREACPPROJECTSBYCONSULTANTSBYID);
			query.setParameter("ProjectId", Long.parseLong(projectId));
			return (List<ProjectClosureACPConsultancies>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureACPConsultanciesByProjectId "+e);
			return null;
		}
	}
	
	private static final String PROJECTCLOSUREACPPROJECTSBYTRIALRESULTSBYID = "FROM ProjectClosureACPTrialResults WHERE ProjectId=:ProjectId AND IsActive=1";
	@Override
	public List<ProjectClosureACPTrialResults> getProjectClosureACPTrialResultsByProjectId(String projectId) throws Exception {
		try {
			Query query = manager.createQuery(PROJECTCLOSUREACPPROJECTSBYTRIALRESULTSBYID);
			query.setParameter("ProjectId", Long.parseLong(projectId));
			return (List<ProjectClosureACPTrialResults>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureACPTrialResultsByProjectId "+e);
			return null;
		}
	}
	
	private static final String PROJECTCLOSUREACPPROJECTSBYACHIVEMENTSBYID = "FROM ProjectClosureACPAchievements WHERE ProjectId=:ProjectId AND IsActive=1";
	@Override
	public List<ProjectClosureACPAchievements> getProjectClosureACPAchievementsByProjectId(String projectId) throws Exception {
		try {
			Query query = manager.createQuery(PROJECTCLOSUREACPPROJECTSBYACHIVEMENTSBYID);
			query.setParameter("ProjectId", Long.parseLong(projectId));
			return (List<ProjectClosureACPAchievements>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getProjectClosureACPAchievementsByProjectId "+e);
			return null;
		}
	}
	
	private static final String REMOVEPROJECTCLOSUREACPPROJECTDETAILSBYTYPE = "UPDATE pfms_closure_acp_projects SET IsActive=:IsActive WHERE ProjectId=:ProjectId AND (CASE WHEN 'S'=:ACPProjectType THEN ACPProjectType=:ACPProjectType ELSE ACPProjectType IN('R','P') END)";
	@Override
	public int removeProjectClosureACPProjectDetailsByType(long projectId, String acpProjectType) throws Exception{
		try {
			Query query = manager.createNativeQuery(REMOVEPROJECTCLOSUREACPPROJECTDETAILSBYTYPE);
			query.setParameter("IsActive", "0");
			query.setParameter("ProjectId", projectId);
			query.setParameter("ACPProjectType", acpProjectType);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO removeProjectClosureACPProjectDetailsByType "+e);
			return 0;
		}

	}

	private static final String REMOVEPROJECTCLOSUREACPCONSULTANCYDETAILSBYTYPE = "UPDATE pfms_closure_acp_consultancies SET IsActive=:IsActive WHERE ProjectId=:ProjectId";
	@Override
	public int removeProjectClosureACPConsultancyDetails(long projectId) throws Exception {
		try {
			Query query = manager.createNativeQuery(REMOVEPROJECTCLOSUREACPCONSULTANCYDETAILSBYTYPE);
			query.setParameter("IsActive", "0");
			query.setParameter("ProjectId", projectId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO removeProjectClosureACPProjectDetailsByType "+e);
			return 0;
		}

	}
	
	private static final String REMOVEPROJECTCLOSUREACPTRIALRESULTSDETAILSBYTYPE = "UPDATE pfms_closure_acp_trial_results SET IsActive=:IsActive WHERE ProjectId=:ProjectId";
	@Override
	public int removeProjectClosureACPTrialResultsDetails(long projectId) throws Exception {
		try {
			Query query = manager.createNativeQuery(REMOVEPROJECTCLOSUREACPTRIALRESULTSDETAILSBYTYPE);
			query.setParameter("IsActive", "0");
			query.setParameter("ProjectId", projectId);
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

	private static final String REMOVEPROJECTCLOSUREACPACHIVEMENTDETAILSBYTYPE = "UPDATE pfms_closure_acp_achievements SET IsActive=:IsActive WHERE ProjectId=:ProjectId";
	@Override
	public int removeProjectClosureACPAchievementDetails(long projectId) throws Exception {
		try {
			Query query = manager.createNativeQuery(REMOVEPROJECTCLOSUREACPACHIVEMENTDETAILSBYTYPE);
			query.setParameter("IsActive", "0");
			query.setParameter("ProjectId", projectId);
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
}
