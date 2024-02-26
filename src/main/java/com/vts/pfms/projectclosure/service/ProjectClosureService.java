package com.vts.pfms.projectclosure.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.project.model.ProjectMaster;
import com.vts.pfms.project.model.ProjectMasterRev;
import com.vts.pfms.projectclosure.dto.ProjectClosureACPDTO;
import com.vts.pfms.projectclosure.dto.ProjectClosureApprovalForwardDTO;
import com.vts.pfms.projectclosure.model.ProjectClosureACP;
import com.vts.pfms.projectclosure.model.ProjectClosureACPAchievements;
import com.vts.pfms.projectclosure.model.ProjectClosureACPConsultancies;
import com.vts.pfms.projectclosure.model.ProjectClosureACPProjects;
import com.vts.pfms.projectclosure.model.ProjectClosureACPTrialResults;
import com.vts.pfms.projectclosure.model.ProjectClosureSoC;

public interface ProjectClosureService {

	public List<Object[]> projectClosureList(String EmpId, String labcode) throws Exception;
	public ProjectMaster getProjectMasterByProjectId(String projectId) throws Exception;
	public ProjectClosureSoC getProjectClosureSoCByProjectId(String projectId) throws Exception;
	public long addProjectClosureSoC(ProjectClosureSoC soc, String EmpId, MultipartFile monitoringCommitteeAttach, MultipartFile lessonsLearnt) throws Exception;
	public long editProjectClosureSoC(ProjectClosureSoC soc, MultipartFile monitoringCommitteeAttach, MultipartFile lessonsLearnt) throws Exception;
	public ProjectMasterRev getProjectMasterRevByProjectId(String projectId) throws Exception;
	public List<Object[]> projectClosureApprovalDataByType(String projectId, String closureForward, String closureForm)  throws Exception;
	public List<Object[]> projectClosureRemarksHistoryByType(String projectId, String closureForward, String closureForm) throws Exception;
	public Object[] getEmpGDDetails(String empId) throws Exception;
	public long projectClosureSoCApprovalForward(ProjectClosureApprovalForwardDTO dto) throws Exception;
	public List<Object[]> projectClosureSoCPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectClosureSoCApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public List<Object[]> projectClosureTransListByType(String projectId, String closureStatusFor, String closureForm) throws Exception;
	public long projectClosureSoCRevoke(String projectId, String userId, String empId) throws Exception;
	public ProjectClosureACP getProjectClosureACPByProjectId(String projectId) throws Exception;
	public long addProjectClosureACP(ProjectClosureACP acp) throws Exception;
	public long editProjectClosureACP(ProjectClosureACP acp) throws Exception;
	public long projectClosureACPDetailsSubmit(ProjectClosureACPDTO dto, MultipartFile labCertificateAttach, MultipartFile monitoringCommitteeAttach) throws Exception;
	public List<ProjectClosureACPProjects> getProjectClosureACPProjectsByProjectId(String projectId) throws Exception;
	public List<ProjectClosureACPConsultancies> getProjectClosureACPConsultanciesByProjectId(String projectId) throws Exception;
	public List<ProjectClosureACPTrialResults> getProjectClosureACPTrialResultsByProjectId(String projectId) throws Exception;
	public List<ProjectClosureACPAchievements> getProjectClosureACPAchievementsByProjectId(String projectId) throws Exception;
	public long addProjectClosureProjectDetailsSubmit(ProjectClosureACPDTO dto) throws Exception;
	public long addProjectClosureConsultancyDetailsSubmit(ProjectClosureACPDTO dto) throws Exception;
	public long projectClosureACPTrialResultsSubmit(ProjectClosureACPDTO dto) throws Exception;
	public ProjectClosureACPTrialResults getProjectClosureACPTrialResultsById(String trialResultId) throws Exception;
	public long projectClosureACPAchievementDetailsSubmit(ProjectClosureACPDTO dto) throws Exception;
	public long projectClosureACPApprovalForward(ProjectClosureApprovalForwardDTO dto) throws Exception;
	public List<Object[]> projectClosureACPPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectClosureACPApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public Object[] projectOriginalAndRevisionDetails(String projectId) throws Exception;
	
}
