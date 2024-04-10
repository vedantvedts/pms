package com.vts.pfms.projectclosure.service;

import java.util.List;


import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.project.model.ProjectMaster;
import com.vts.pfms.projectclosure.dto.ProjectClosureACPDTO;
import com.vts.pfms.projectclosure.dto.ProjectClosureApprovalForwardDTO;
import com.vts.pfms.projectclosure.model.ProjectClosure;
import com.vts.pfms.projectclosure.model.ProjectClosureACP;
import com.vts.pfms.projectclosure.model.ProjectClosureACPAchievements;
import com.vts.pfms.projectclosure.model.ProjectClosureACPConsultancies;
import com.vts.pfms.projectclosure.model.ProjectClosureACPProjects;
import com.vts.pfms.projectclosure.model.ProjectClosureACPTrialResults;
import com.vts.pfms.projectclosure.model.ProjectClosureCheckList;
import com.vts.pfms.projectclosure.model.ProjectClosureSoC;

public interface ProjectClosureService {

	public List<Object[]> projectClosureList(String EmpId, String labcode, String LoginType) throws Exception;
	public ProjectMaster getProjectMasterByProjectId(String projectId) throws Exception;
	public ProjectClosure getProjectClosureById(String closureId) throws Exception;
	public long addProjectClosure(ProjectClosure closure, String empId, String labcode) throws Exception;
	public long editProjectClosure(ProjectClosure closure) throws Exception;
	public ProjectClosureSoC getProjectClosureSoCByProjectId(String closureId) throws Exception;
	public long addProjectClosureSoC(ProjectClosureSoC soc, String EmpId, MultipartFile monitoringCommitteeAttach, MultipartFile lessonsLearnt) throws Exception;
	public long editProjectClosureSoC(ProjectClosureSoC soc, MultipartFile monitoringCommitteeAttach, MultipartFile lessonsLearnt) throws Exception;
	public List<Object[]> projectClosureApprovalDataByType(String closureId, String closureForward, String closureForm)  throws Exception;
	public List<Object[]> projectClosureRemarksHistoryByType(String closureId, String closureForward, String closureForm) throws Exception;
	public Object[] getEmpGDDetails(String empId) throws Exception;
	public long projectClosureSoCApprovalForward(ProjectClosureApprovalForwardDTO dto) throws Exception;
	public List<Object[]> projectClosureSoCPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectClosureSoCApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public List<Object[]> projectClosureTransListByType(String closureId, String closureStatusFor, String closureForm) throws Exception;
	public long projectClosureSoCRevoke(String closureId, String userId, String empId, String labcode) throws Exception;
	public ProjectClosureACP getProjectClosureACPByProjectId(String closureId) throws Exception;
	public long addProjectClosureACP(ProjectClosureACP acp) throws Exception;
	public long editProjectClosureACP(ProjectClosureACP acp) throws Exception;
	public long projectClosureACPDetailsSubmit(ProjectClosureACPDTO dto, MultipartFile labCertificateAttach, MultipartFile monitoringCommitteeAttach) throws Exception;
	public List<ProjectClosureACPProjects> getProjectClosureACPProjectsByProjectId(String closureId) throws Exception;
	public List<ProjectClosureACPConsultancies> getProjectClosureACPConsultanciesByProjectId(String closureId) throws Exception;
	public List<ProjectClosureACPTrialResults> getProjectClosureACPTrialResultsByProjectId(String closureId) throws Exception;
	public List<ProjectClosureACPAchievements> getProjectClosureACPAchievementsByProjectId(String closureId) throws Exception;
	public long addProjectClosureProjectDetailsSubmit(ProjectClosureACPDTO dto) throws Exception;
	public long addProjectClosureConsultancyDetailsSubmit(ProjectClosureACPDTO dto) throws Exception;
	public long projectClosureACPTrialResultsSubmit(ProjectClosureACPDTO dto) throws Exception;
	public ProjectClosureACPTrialResults getProjectClosureACPTrialResultsById(String trialResultId) throws Exception;
	public long projectClosureACPAchievementDetailsSubmit(ProjectClosureACPDTO dto) throws Exception;
	public long projectClosureACPApprovalForward(ProjectClosureApprovalForwardDTO dto) throws Exception;
	public List<Object[]> projectClosureACPPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectClosureACPApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public Object[] projectOriginalAndRevisionDetails(String projectId) throws Exception;
	public Object[] projectExpenditureDetails(String projectId) throws Exception;
	public long projectClosureACPRevoke(String closureId, String userId, String empId, String labcode) throws Exception;
	public ProjectClosureCheckList getProjectClosureCheckListByProjectId(String closureId) throws Exception;
	public long addProjectClosureCheckList(ProjectClosureCheckList clist, String empId,MultipartFile qARMilestoneAttach, MultipartFile qARCostBreakupAttach, MultipartFile qARNCItemsAttach) throws Exception;
	
}
