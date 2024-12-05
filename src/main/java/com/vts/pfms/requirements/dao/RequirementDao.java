package com.vts.pfms.requirements.dao;

import java.util.List;

import com.vts.pfms.documents.model.IGIInterface;
import com.vts.pfms.documents.model.IGIBasicParameters;
import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.PfmsIGIDocument;
import com.vts.pfms.project.model.PfmsInititationRequirement;
import com.vts.pfms.project.model.RequirementSummary;
import com.vts.pfms.requirements.model.Abbreviations;
import com.vts.pfms.requirements.model.DocMembers;
import com.vts.pfms.requirements.model.DocumentFreeze;
import com.vts.pfms.requirements.model.ReqDoc;
import com.vts.pfms.requirements.model.RequirementInitiation;
import com.vts.pfms.requirements.model.SpecificationMaster;
import com.vts.pfms.requirements.model.SpecsInitiation;
import com.vts.pfms.requirements.model.DocumentTrans;
import com.vts.pfms.requirements.model.PfmsReqTypes;
import com.vts.pfms.requirements.model.PfmsSpecTypes;
import com.vts.pfms.requirements.model.PfmsTestTypes;
import com.vts.pfms.requirements.model.TestAcceptance;
import com.vts.pfms.requirements.model.TestApproach;
import com.vts.pfms.requirements.model.TestDetails;
import com.vts.pfms.requirements.model.TestPlanInitiation;
import com.vts.pfms.requirements.model.TestPlanSummary;
import com.vts.pfms.requirements.model.TestScopeIntro;
import com.vts.pfms.requirements.model.TestTools;
import com.vts.pfms.requirements.model.VerificationData;
import com.vts.pfms.requirements.model.TestPlanMaster;
public interface RequirementDao {

	List<Object[]> RequirementList(String reqInitiationId) throws Exception;

	
	public List<Object[]> AbbreviationDetails(String testPlanInitiationId, String specsInitiationId) throws Exception;
	public long addAbbreviations(List<Abbreviations> iaList)throws Exception;
	public long AddreqMembers(DocMembers r)throws Exception;
	public List<Object[]> DocMemberList(String testPlanInitiationId, String specsInitiationId) throws Exception;
	public Object[] TestScopeIntro(String testPlanInitiationId)throws Exception;
	public long TestScopeIntroSubmit(TestScopeIntro pr)throws Exception;
	public long TestScopeUpdate(TestScopeIntro pr, String attributes)throws Exception;
	public long addTestPlanSummary(TestPlanSummary rs) throws Exception;
	public long editTestPlanSummary(TestPlanSummary rs) throws Exception;
	public List<Object[]> getTestandSpecsDocumentSummary(String testPlanInitiationId, String specsInitiationId) throws Exception;
	public long addTestApproch(TestApproach rs)throws Exception;
	public long editTestApproach(TestApproach rs)throws Exception;
	public List<Object[]> getApproach(String initiationid, String projectId)throws Exception;
	public long TestDocContentSubmit(TestApproach pr)throws Exception;
	public Object[] GetTestContent(String initiationid, String projectId)throws Exception;
	public List<Object[]> GetTestContentList(String testPlanInitiationId)throws Exception;
	public long TestDocContentUpdate(String initiationid, String projectId, String attributes, String details,String userId)throws Exception;
	public long TestDocContentUpdate(TestApproach pr, String attributes)throws Exception;
	public long TestContentUpdate(TestApproach pr, String attributes)throws Exception;
	public long insertTestAcceptanceFile(TestAcceptance re) throws Exception;
	public List<Object[]> GetAcceptanceTestingList(String testPlanInitiationId) throws Exception;
	public long AcceptanceUpdate(TestAcceptance pr, String details)throws Exception;
	public Object[] AcceptanceTestingList(String Testid) throws Exception;
	public Object[] AcceptanceTestingExcelData(String testPlanInitiationId)throws Exception;


	public List<Object[]> requirementTypeList(String reqInitiationId) throws Exception;
	public long RequirementUpdate(PfmsInititationRequirement pir) throws Exception;
	public List<Object[]> getReqMainList(String reqMainId) throws Exception;


	public List<Object[]> getreqTypeList(String reqMainId, String initiationReqId) throws Exception;


	public List<Object[]> getVerificationMethodList() throws Exception;


	public List<Object[]> getProjectParaDetails(String reqInitiationId) throws Exception;


	List<Object[]> getVerifications(String reqInitiationId) throws Exception;


	public long UpdatePfmsInititationRequirement(PfmsInititationRequirement pir)throws Exception;


	List<Object[]> ApplicableDocumentList(String reqInitiationId) throws Exception;


	List<Object[]> ApplicableTotalDocumentList(String reqInitiationId) throws Exception;


	long addDocs(List<ReqDoc> list) throws Exception;
	
	public List<Object[]> productTreeListByProjectId(String projectId) throws Exception;
	public List<Object[]> initiationReqList(String projectId, String mainId, String initiationId) throws Exception;
	public List<Object[]> getPreProjectList(String loginType, String labcode, String empId) throws Exception;

	public long addRequirementInitiation(RequirementInitiation requirementInitiation) throws Exception;
	public RequirementInitiation getRequirementInitiationById(String reqInitiationId) throws Exception;
	public PfmsInititationRequirement getPfmsInititationRequirementById(String InitiationReqId) throws Exception;
	public Long addOrUpdatePfmsInititationRequirement(PfmsInititationRequirement pfmsInititationRequirement) throws Exception;
	public List<Object[]> projectDocTransList(String docInitiationId, String docType) throws Exception;
	public long addRequirementTransaction(DocumentTrans transaction) throws Exception;
	public RequirementSummary getRequirementSummaryByReqInitiationId(String reqInitiationId) throws Exception;
	public List<Object[]> projectRequirementPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectRequirementApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	
	// Test Plan Changes from Bharath
	public long TestDetailsAdd(TestDetails Td) throws Exception;
	public List<Object[]> TestTypeList() throws Exception;
	public List<Object[]> StagesApplicable() throws Exception;
	public long numberOfTestTypeId(String testPlanInitiationId) throws Exception;
//	public long TestDUpdate(TestDetails pir, String TestId) throws Exception;
	public List<Object[]> getVerificationMethodList(String projectId, String initiationId) throws Exception;
	public List<Object[]> TestDetailsList(String testPlanInitiationId) throws Exception;
	public List<Object[]> getDocumentSummary(String testPlanInitiationId) throws Exception;
	public List<Object[]> TestType(String r)throws Exception;
	public Long insertTestType(TestTools pt) throws Exception;
	public List<Object[]> initiationTestPlanList(String projectId, String mainId, String initiationId) throws Exception;
	// Test Plan Changes from Bharath End

	public long addTestPlanInitiation(TestPlanInitiation testplanInitiation) throws Exception;
	public TestPlanSummary getTestPlanSummaryById(String summaryId) throws Exception;
	public TestPlanInitiation getTestPlanInitiationById(String testPlanInitiationId) throws Exception;
	public TestDetails getTestPlanDetailsById(String testId) throws Exception;
	public TestPlanSummary getTestPlanSummaryByTestPlanInitiationId(String testPlanInitiationId) throws Exception;
	public List<Object[]> projectTestPlanPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> projectTestPlanApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public Object[] getTestPlanApprovalFlowData(String initiationId, String projectId, String productTreeMainId) throws Exception;
	public DocumentFreeze getDocumentFreezeByDocIdandDocType(String docInitiationId, String docType) throws Exception;
	public long addDocumentFreeze(DocumentFreeze freeze) throws Exception;
	public Long getFirstVersionTestPlanInitiationId(String initiationId, String projectId, String productTreeMainId) throws Exception;
	public Long getFirstVersionReqInitiationId(String initiationId, String projectId, String productTreeMainId) throws Exception;
	public Object[] getRequirementApprovalFlowData(String initiationId, String projectId, String productTreeMainId)throws Exception;
	public int getDuplicateCountofTestType(String testType) throws Exception;
	
	// specification Starts
	public SpecsInitiation getSpecsInitiationById(String specsInitiationId)throws Exception;
	public long addSpecsInitiation(SpecsInitiation specsInitiation) throws Exception;
	public List<Object[]> getSpecsList(String specsInitiationId) throws Exception;
	public Long getFirstVersionSpecsInitiationId(String initiationId, String projectId, String productTreeMainId) throws Exception;


	public List<Object[]> getSpecsPlanApprovalFlowData(String projectId, String initationId, String productTreeMainId)throws Exception;


	public List<Object[]> projectSpecificationPendingList(String empId, String labcode) throws Exception;


	public List<Object[]> getAllSqr(String reqInitiationId)throws Exception;


	long AddReqType(PfmsReqTypes pr)throws Exception;


	long deleteSqr(String paraId)throws Exception;


	long updateSerialParaNo(String para, String sn)throws Exception;
	public long deleteInitiationReq(String InitiationReqId) throws Exception;
	public long deleteInitiationSpe(String SpecsId) throws Exception;


	public long addSpecMaster(PfmsSpecTypes pst)throws Exception;


	 public  List<Object[]> getSpecMasterList(String SpecsInitiationId)throws Exception;


	public Object[] getSpecName(String mainId)throws Exception;


	public long addTestMaster(PfmsTestTypes pt)throws Exception;


	public List<Object[]> getTestPlanMainList(String testPlanInitiationId)throws Exception;


	public Object[] getTestTypeName(String mainid)throws Exception;


	long deleteTestPlan(String testId)throws Exception;
	
	/* Soumyakanta Swain */

	public List<Object[]> getVerificationListMaster()throws Exception;
	public long addVerificationData(List<VerificationData> verifyList)throws Exception;
	public List<Object[]> getverificationDataList(String verificationId)throws Exception;
	public long verificationDataEdit(VerificationData verifiData)throws Exception;


	public List<Object[]> SpecificationMasterList() throws Exception;
	public long specMasterAddSubmit(SpecificationMaster sp) throws Exception;
	public SpecificationMaster SpecificationMaster(long specsMasterId)throws Exception;
	public List<Object[]> TestPlanMaster()throws Exception;
	public TestPlanMaster getTestPlanById(long testMasterId);


	long testPlanMasterAdd(TestPlanMaster tp)throws Exception;
}
