package com.vts.pfms.requirements.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;
import com.vts.pfms.project.model.PfmsInititationRequirement;
import com.vts.pfms.requirements.model.Abbreviations;
import com.vts.pfms.requirements.model.DocMembers;
import com.vts.pfms.requirements.model.ReqDoc;
import com.vts.pfms.requirements.model.RequirementInitiation;
import com.vts.pfms.requirements.model.SpecsInitiation;
import com.vts.pfms.requirements.model.TestAcceptance;
import com.vts.pfms.requirements.model.TestApproach;
import com.vts.pfms.requirements.model.TestDetails;
import com.vts.pfms.requirements.model.TestPlanInitiation;
import com.vts.pfms.requirements.model.TestPlanSummary;
import com.vts.pfms.requirements.model.TestTools;

public interface RequirementService {

	List<Object[]> RequirementList(String reqInitiationId)throws Exception;

	long ProjectRequirementAdd(PfmsInitiationRequirementDto prd, String userId, String labCode)throws Exception;

	public List<Object[]> AbbreviationDetails(String testPlanInitiationId, String specsInitiationId) throws Exception;

	public long AddDocMembers(DocMembers rm)throws Exception;
	public Object DocMemberList(String testPlanInitiationId, String specsInitiationId)throws Exception;
	public Object[] TestScopeIntro(String testPlanInitiationId) throws Exception;//method for intro
	public long TestScopeIntroSubmit(String testPlanInitiationId, String attributes, String details,String userId) throws Exception;
	public long TestScopeUpdate(String testPlanInitiationId, String attributes, String details,String userId)throws Exception;
	public long addTestPlanSummary(TestPlanSummary rs) throws Exception;
	public long editTestPlanSummary(TestPlanSummary rs) throws Exception;
	public Object getTestandSpecsDocumentSummary(String testPlanInitiationId, String specsInitiationId)throws Exception;
	public long addTestApproch(TestApproach rs)throws Exception;
	public long editTestApproach(TestApproach rs)throws Exception;
	public Object getApproach(String initiationId, String projectId)throws Exception;
	public long Update(String initiationId, String projectId, String attributes, String details,String userId) throws Exception;
	public Object[] GetTestContent(String initiationid, String ProjectId) throws Exception;
	public List<Object[]> GetTestContentList(String testPlanInitiationId) throws Exception;
	public long TestDocContentSubmit(String testPlanInitiationId, String attributes, String details,String userId)throws Exception;
	public long TestDocContentUpdate(String UpdateAction, String Details, String userId) throws Exception;
	public long insertTestAcceptanceFile(TestAcceptance re, String labCode)throws Exception;
	public 	List<Object[]> GetAcceptanceTestingList(String testPlanInitiationId)throws Exception;
	public long TestAcceptancetUpdate(String UpdateActionid, String Details, String userId, MultipartFile fileAttach,String LabCode) throws Exception;
	public Object[] AcceptanceTestingList(String testid)throws Exception;
	public Object[] AcceptanceTestingExcelData(String testPlanInitiationId) throws Exception;
	public long addAbbreviations(List<Abbreviations> iaList) throws Exception;


	List<Object[]> requirementTypeList(String reqInitiationId) throws Exception;

	long addPfmsInititationRequirement(PfmsInititationRequirement pir) throws Exception;

	long RequirementUpdate(PfmsInititationRequirement pir) throws Exception;

	List<Object[]> getReqMainList(String reqMainId) throws Exception;

	List<Object[]> getreqTypeList(String reqMainId, String initiationReqId) throws Exception;

	public List<Object[]> getVerificationMethodList()throws Exception;

	public List<Object[]> getProjectParaDetails(String reqInitiationId) throws Exception;

	public List<Object[]> getVerifications(String reqInitiationId) throws Exception;

	long UpdatePfmsInititationRequirement(PfmsInititationRequirement pir) throws Exception;

	List<Object[]> ApplicableDocumentList(String reqInitiationId)throws Exception;

	List<Object[]> ApplicableTotalDocumentList(String reqInitiationId)throws Exception;

	long addDocs(List<ReqDoc> list) throws Exception;
	
	public List<Object[]> productTreeListByProjectId(String projectId) throws Exception;
	public List<Object[]> initiationReqList(String projectId, String mainId, String initiationId) throws Exception;
	public List<Object[]> getPreProjectList(String loginType, String labcode, String empId) throws Exception;
	
	public long addRequirementInitiation(RequirementInitiation requirementInitiation) throws Exception;
	public RequirementInitiation getRequirementInitiationById(String reqInitiationId) throws Exception;
	public PfmsInititationRequirement getPfmsInititationRequirementById(String InitiationReqId) throws Exception;
	public Long addOrUpdatePfmsInititationRequirement(PfmsInititationRequirement pfmsInititationRequirement) throws Exception;
	public Long requirementInitiationAddHandling(String initiationId, String projectId, String productTreeMainId, String empId,String username) throws Exception;
	public List<Object[]> projectDocTransList(String docInitiationId, String docType) throws Exception;
	public long projectRequirementApprovalForward(String reqInitiationId, String action, String remarks, String empId, String labcode, String userId) throws Exception;
	public List<Object[]> projectRequirementPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectRequirementApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	
	// Test Plan Changes from Bharath
	public long TestDetailsAdd(TestDetails td)throws Exception;
	public List<Object[]> TestTypeList()throws Exception;
	public List<Object[]> StagesApplicable()throws Exception;
	public Long numberOfTestTypeId(String testPlanInitiationId)throws Exception;
//	public long TestDetailasUpdate(TestDetails tdedit, String userId, String testId)throws Exception;
	public List<Object[]> TestSuiteList()throws Exception;
	public Object getVerificationMethodList(String projectId, String initiationid)throws Exception;
	public List<Object[]> TestDetailsList(String testPlanInitiationId)throws Exception;
	public List<Object[]> TestType(String r) throws Exception;
	public List<Object[]> getDocumentSummary(String testPlanInitiationId) throws Exception;
	public Long insertTestType(TestTools pt) throws Exception;
	public List<Object[]> initiationTestPlanList(String projectId, String mainId, String initiationId) throws Exception;

	// Test Plan Changes from Bharath End
	
	public Long testPlanInitiationAddHandling(String initiationId, String projectId, String productTreeMainId, String empId, String username) throws Exception;
	public TestPlanSummary getTestPlanSummaryById(String testplanInitiation) throws Exception;
	public TestPlanInitiation getTestPlanInitiationById(String testPlanInitiationId) throws Exception;
	public TestDetails getTestPlanDetailsById(String testId) throws Exception;
	public long projectTestPlanApprovalForward(String testPlanInitiationId, String action, String remarks, String empId, String labcode, String userId) throws Exception;
	public List<Object[]> projectTestPlanPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectTestPlanApprovedList(String empId, String FromDate, String ToDate) throws Exception;

	
	//specification starts
	public SpecsInitiation getSpecsInitiationById(String specsInitiationId) throws Exception;

	public long SpecificationInitiationAddHandling(String initiationId, String projectId, String productTreeMainId,
			String empId, String userId);
	
}
