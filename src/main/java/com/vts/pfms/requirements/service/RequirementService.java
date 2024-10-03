package com.vts.pfms.requirements.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;
import com.vts.pfms.project.model.PfmsInititationRequirement;
import com.vts.pfms.requirements.model.Abbreviations;
import com.vts.pfms.requirements.model.DocMembers;
import com.vts.pfms.requirements.model.DocumentFreeze;
import com.vts.pfms.requirements.model.IGIInterface;
import com.vts.pfms.requirements.model.IgiBasicParameters;
import com.vts.pfms.requirements.model.IgiDocumentMembers;
import com.vts.pfms.requirements.model.PfmsReqTypes;
import com.vts.pfms.requirements.model.ReqDoc;
import com.vts.pfms.requirements.model.RequirementInitiation;
import com.vts.pfms.requirements.model.Specification;
import com.vts.pfms.requirements.model.SpecsInitiation;
import com.vts.pfms.requirements.model.TestAcceptance;
import com.vts.pfms.requirements.model.TestApproach;
import com.vts.pfms.requirements.model.TestDetails;
import com.vts.pfms.requirements.model.TestPlanInitiation;
import com.vts.pfms.requirements.model.TestPlanSummary;
import com.vts.pfms.requirements.model.TestTools;
import com.vts.pfms.requirements.model.IgiDocumentSummary;
import com.vts.pfms.requirements.model.PfmsIgiDocument;

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
	public Long requirementInitiationAddHandling(String initiationId, String projectId, String productTreeMainId, String empId,String username, String version, String remarks) throws Exception;
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
	
	public Long testPlanInitiationAddHandling(String initiationId, String projectId, String productTreeMainId, String empId, String username, String version, String remarks) throws Exception;
	public TestPlanSummary getTestPlanSummaryById(String testPlanInitiationId) throws Exception;
	public TestPlanInitiation getTestPlanInitiationById(String testPlanInitiationId) throws Exception;
	public TestDetails getTestPlanDetailsById(String testId) throws Exception;
	public long projectTestPlanApprovalForward(String testPlanInitiationId, String action, String remarks, String empId, String labcode, String userId) throws Exception;
	public List<Object[]> projectTestPlanPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectTestPlanApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public int getDuplicateCountofTestType(String testType) throws Exception;
	public Object[] getTestPlanApprovalFlowData(String initiationId, String projectId, String productTreeMainId) throws Exception;
	public void testPlanPdfFreeze(HttpServletRequest req, HttpServletResponse res, String testPlanInitiationId, String labCode) throws Exception;
	public Long documentFreezeAddHandling(String docInitiationId, String docType, String pdfFilePath, String excelFilePath) throws Exception;
	public DocumentFreeze getDocumentFreezeByDocIdandDocType(String docInitiationId, String docType) throws Exception;
	public Long getFirstVersionTestPlanInitiationId(String initiationId, String projectId, String productTreeMainId) throws Exception;
	public Long getFirstVersionReqInitiationId(String initiationId, String projectId, String productTreeMainId) throws Exception;
	public void requirementPdfFreeze(HttpServletRequest req, HttpServletResponse res, String reqInitiationId, String labCode) throws Exception;
	public Object[] getRequirementApprovalFlowData(String initiationId, String projectId, String productTreeMainId)throws Exception;
	public Long getFirstVersionSpecsInitiationId(String initiationId, String projectId, String productTreeMainId) throws Exception;

	//specification starts
	public SpecsInitiation getSpecsInitiationById(String specsInitiationId) throws Exception;
	public long SpecificationInitiationAddHandling(String initiationId, String projectId, String productTreeMainId,String empId, String userId,String version,String remarks) throws Exception;
	public List<Object[]> getSpecsList(String specsInitiationId) throws Exception;
	public List<Object[]> getSpecsPlanApprovalFlowData(String projectId, String initationId, String productTreeMainId)throws Exception;
	public long projectSpecsApprovalForward(String specsInitiationId, String action, String remarks, String empId,String labcode, String userId)throws Exception;
	public List<Object[]> projectSpecificationPendingList(String empId, String labcode)throws Exception;
	public List<Object[]> projectSpecificationApprovedList(String empId, String fromdate, String todate)throws Exception;

	public void SpecsInitiationPdfFreeze(HttpServletRequest req, HttpServletResponse resp, String specsInitiationId,
			String labcode)throws Exception;

	public List<Object[]> getAllSqr(String reqInitiationId)throws Exception;

	long AddReqType(PfmsReqTypes pr)throws Exception;

	long deleteSqr(String paraId)throws Exception;

	long updateSerialParaNo(String para, String sn)throws Exception;

	public long deleteInitiationReq(String InitiationReqId) throws Exception;

	public long deleteInitiationSpe(String SpecsId) throws Exception;

	public long addSpecMaster(String[] specificationCode, String[] specificationName)throws Exception;

	public List<Object[]> getSpecMasterList(String SpecsInitiationId)throws Exception;

	public Object[] getSpecName(String mainId)throws Exception;

	public long addTestMaster(String[] testplanCode, String[] testplanName)throws Exception;

	public List<Object[]> getTestPlanMainList(String testPlanInitiationId)throws Exception;

	public Object[] getTestTypeName(String mainid)throws Exception;

	long deleteTestPlan(String testId)throws Exception;


	
	/* Soumya kanta Swain */
	public List<Object[]> IgiDocumentList() throws Exception;

	public long savePfmsIgiDocument(PfmsIgiDocument pfmsIgiDocument) throws Exception;

	public List<Object[]> IgiDocumentSummary() throws Exception;

	public IgiDocumentSummary getIgiDocumentSummaryById(String SummaryId) throws Exception;

	public long addIgiDocumentSummary(IgiDocumentSummary rs) throws Exception;

	public List<Object[]> igiDocumentMemberList(String DocIgiId) throws Exception;

	public List<Object[]> EmployeeList(String labCode, String DocIgiId) throws Exception;

	public long AddIgiDocMembers(IgiDocumentMembers rm) throws Exception;

	public IgiDocumentMembers getIgiDocumentById(Long IgiMemeberId) throws Exception;

	public long editIgiDocument(IgiDocumentMembers idm) throws Exception;

	public long addBasicInterfaceType(IGIInterface iif)throws Exception;

	public List<IGIInterface> getAllIGIInterface(String labCode)throws Exception;

	public List<Object[]> getAllBasicParameters()throws Exception;

	public long AddParameters(IgiBasicParameters ib)throws Exception;

}
