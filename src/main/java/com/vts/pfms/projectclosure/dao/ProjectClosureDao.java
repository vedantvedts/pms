package com.vts.pfms.projectclosure.dao;

import java.util.List;

import com.vts.pfms.project.model.ProjectMaster;
import com.vts.pfms.projectclosure.model.ProjectClosure;
import com.vts.pfms.projectclosure.model.ProjectClosureACP;
import com.vts.pfms.projectclosure.model.ProjectClosureACPAchievements;
import com.vts.pfms.projectclosure.model.ProjectClosureACPConsultancies;
import com.vts.pfms.projectclosure.model.ProjectClosureACPProjects;
import com.vts.pfms.projectclosure.model.ProjectClosureACPTrialResults;
import com.vts.pfms.projectclosure.model.ProjectClosureCheckList;
import com.vts.pfms.projectclosure.model.ProjectClosureSoC;
import com.vts.pfms.projectclosure.model.ProjectClosureTrans;

public interface ProjectClosureDao {

	public List<Object[]> projectClosureList(String EmpId, String labcode, String LoginType) throws Exception;
	public ProjectMaster getProjectMasterByProjectId(String projectId) throws Exception;
	public ProjectClosure getProjectClosureById(String closureId) throws Exception;
	public long addProjectClosure(ProjectClosure closure) throws Exception;
	public long editProjectClosure(ProjectClosure closure) throws Exception;
	public ProjectClosureSoC getProjectClosureSoCByProjectId(String projectId) throws Exception;
	public long addProjectClosureSoC(ProjectClosureSoC soc) throws Exception;
	public long editProjectClosureSoC(ProjectClosureSoC soc) throws Exception;
	public long addProjectClosureTransaction(ProjectClosureTrans transaction) throws Exception;
	public List<Object[]> projectClosureApprovalDataByType(String projectId, String closureForward, String closureForm)  throws Exception;
	public List<Object[]> projectClosureRemarksHistoryByType(String projectId, String closureForward, String closureForm) throws Exception;
	public Object[] getEmpGDDetails(String empId) throws Exception;
	public List<Object[]> projectClosureSoCPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectClosureSoCApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public List<Object[]> projectClosureTransListByType(String projectId, String closureStatusFor, String closureForm) throws Exception;
	public ProjectClosureACP getProjectClosureACPByProjectId(String projectId) throws Exception;
	public long addProjectClosureACP(ProjectClosureACP acp) throws Exception;
	public long editProjectClosureACP(ProjectClosureACP acp) throws Exception;
	public long addProjectClosureACPProjects(ProjectClosureACPProjects projects) throws Exception;
	public long addProjectClosureACPConsultancies(ProjectClosureACPConsultancies consultancies) throws Exception;
	public long addProjectClosureACPAchievements(ProjectClosureACPAchievements achievements) throws Exception;
	public long addProjectClosureACPTrialResults(ProjectClosureACPTrialResults trialResults) throws Exception;
	public List<ProjectClosureACPProjects> getProjectClosureACPProjectsByProjectId(String projectId) throws Exception;
	public List<ProjectClosureACPConsultancies> getProjectClosureACPConsultanciesByProjectId(String projectId) throws Exception;
	public List<ProjectClosureACPTrialResults> getProjectClosureACPTrialResultsByProjectId(String projectId) throws Exception;
	public List<ProjectClosureACPAchievements> getProjectClosureACPAchievementsByProjectId(String projectId) throws Exception;
	public int removeProjectClosureACPProjectDetailsByType(long projectId, String acpProjectType) throws Exception;
	public int removeProjectClosureACPConsultancyDetails(long projectId) throws Exception;
	public int removeProjectClosureACPTrialResultsDetails(long projectId) throws Exception;
	public ProjectClosureACPTrialResults getProjectClosureACPTrialResultsById(String trialResultId) throws Exception;
	public int removeProjectClosureACPAchievementDetails(long projectId) throws Exception;
	public List<Object[]> projectClosureACPPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectClosureACPApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public Object[] projectOriginalAndRevisionDetails(String projectId) throws Exception;
	public Object[] projectExpenditureDetails(String projectId) throws Exception;
	public ProjectClosureCheckList getProjectClosureCheckListByProjectId(String closureId)  throws Exception;
	public long addProjectClosureCheckList(ProjectClosureCheckList clist)throws Exception;

}
