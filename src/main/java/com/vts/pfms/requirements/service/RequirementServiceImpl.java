package com.vts.pfms.requirements.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itextpdf.html2pdf.HtmlConverter;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.dao.CARSDao;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.documents.model.IGIInterface;

import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.PfmsIGIDocument;
import com.vts.pfms.project.dao.ProjectDao;
import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;
import com.vts.pfms.project.model.PfmsInititationRequirement;
import com.vts.pfms.project.model.RequirementSummary;
import com.vts.pfms.requirements.dao.RequirementDao;
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
import com.vts.pfms.utils.PMSLogoUtil;
import com.vts.pfms.requirements.model.TestPlanMaster;

@Service
public class RequirementServiceImpl implements RequirementService {
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;

	private static final Logger logger = LogManager.getLogger(RequirementServiceImpl.class);

	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdf1 = fc.getSqlDateAndTimeFormat(); /* new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); */

	private SimpleDateFormat sdf = fc.getRegularDateFormat(); /* new SimpleDateFormat("dd-MM-yyyy"); */
	private SimpleDateFormat sdf2 = fc.getSqlDateFormat();
	private int year = Calendar.getInstance().get(Calendar.YEAR);
	private int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
	DecimalFormat df = new DecimalFormat("0.00");
	
	@Autowired
	RequirementDao dao;
	
	@Autowired
	PMSLogoUtil LogoUtil;
	
	@Autowired
	ProjectDao prodao;
	
	
	@Autowired
	Environment env;
	
	@Autowired
	CARSDao carsdao;
	
	@Override
	public List<Object[]> RequirementList(String reqInitiationId) throws Exception {
		return dao.RequirementList(reqInitiationId);
	}
	@Override
	public long ProjectRequirementAdd(PfmsInitiationRequirementDto prd, String userId, String labCode)
			throws Exception {
		// TODO Auto-generated method stub
		PfmsInititationRequirement pir=new PfmsInititationRequirement();
//		pir.setInitiationId(prd.getInitiationId());
		pir.setReqTypeId(prd.getReqTypeId());
		pir.setRequirementBrief(prd.getRequirementBrief());
		pir.setRequirementDesc(prd.getRequirementDesc());
		pir.setRequirementId(prd.getRequirementId());
		pir.setReqCount(prd.getReqCount());
		pir.setPriority(prd.getPriority());
		pir.setLinkedRequirements(prd.getLinkedRequirements());
		pir.setNeedType(prd.getNeedType());
		pir.setRemarks(prd.getRemarks());
		pir.setCategory(prd.getCategory());
		pir.setConstraints(prd.getConstraints());
		pir.setLinkedDocuments(prd.getLinkedDocuments());
		pir.setLinkedPara(prd.getLinkedPara());
		pir.setCreatedBy(userId);
		pir.setCreatedDate(sdf1.format(new Date()));
		pir.setIsActive(1);
//		pir.setProjectId(prd.getProjectId());
		pir.setReqInitiationId(prd.getReqInitiationId());
		return prodao.ProjectRequirementAdd(pir);
	}
	
	@Override
	public List<Object[]> AbbreviationDetails(String testPlanInitiationId, String specsInitiationId) throws Exception {
		
		return dao.AbbreviationDetails(testPlanInitiationId, specsInitiationId);
	}


	@Override
	public long AddDocMembers(DocMembers rm) throws Exception {
		
		int numberOfPersons= rm.getEmps().length; 
		
		String []assignee= rm.getEmps();
		long count=0;
		for(int i=0;i<numberOfPersons;i++) {
			DocMembers r = new DocMembers();
//			r.setInitiationId(rm.getInitiationId());
			r.setCreatedBy(rm.getCreatedBy());
			r.setCreatedDate(rm.getCreatedDate());
			r.setEmpId(Long.parseLong(assignee[i]));
			r.setIsActive(1);
//			r.setProjectId(rm.getProjectId());
			r.setMemeberType(rm.getMemeberType());
			r.setTestPlanInitiationId(rm.getTestPlanInitiationId());
			r.setSpecsInitiationId(rm.getSpecsInitiationId());
			count=dao.AddreqMembers(r);
			
		}
		return count;
	}
	@Override
	public List<Object[]> DocMemberList(String testPlanInitiationId, String specsInitiationId) throws Exception {
		
		return dao.DocMemberList(testPlanInitiationId, specsInitiationId);
	}
	@Override
	public Object[] TestScopeIntro(String testPlanInitiationId) throws Exception {
	
		return dao.TestScopeIntro(testPlanInitiationId);
	}
	@Override
	public long TestScopeIntroSubmit(String testPlanInitiationId, String attributes, String details, String UserId) throws Exception {
		
		TestScopeIntro pr= new TestScopeIntro();
		if(attributes.equalsIgnoreCase("Introduction")) {
			pr.setIntroduction(details);
		}else if(attributes.equalsIgnoreCase("System Identification")) {
			pr.setSystemIdentification(details);
		}else if(attributes.equalsIgnoreCase("System Overview")) {
			pr.setSystemOverview(details);
		}
//		pr.setProjectId(Long.parseLong(ProjectId));
//		pr.setInitiationId(Long.parseLong(initiationid));
		pr.setTestPlanInitiationId(Long.parseLong(testPlanInitiationId));
		pr.setProjectType("T");
		pr.setCreatedBy(UserId);
		pr.setCreatedDate(sdf1.format(new Date()));
		pr.setIsActive(1);
		return dao.TestScopeIntroSubmit(pr);
	}
	@Override
	public long TestScopeUpdate(String testPlanInitiationId, String attributes, String details, String userId) throws Exception {
		TestScopeIntro pr= new TestScopeIntro();
		if(attributes.equalsIgnoreCase("Introduction")) {
			pr.setIntroduction(details);
		}else if(attributes.equalsIgnoreCase("System Identification")) {
			pr.setSystemIdentification(details);
		}else if(attributes.equalsIgnoreCase("System Overview")) {
			pr.setSystemOverview(details);
		}
//		pr.setProjectId(Long.parseLong(ProjectId));
//		pr.setInitiationId(Long.parseLong(initiationid));
		pr.setTestPlanInitiationId(Long.parseLong(testPlanInitiationId));
		pr.setModifiedBy(userId);
		pr.setModifiedDate(sdf1.format(new Date()));
		return dao.TestScopeUpdate(pr,attributes);
	}
	
	@Override
	public long addTestPlanSummary(TestPlanSummary rs) throws Exception {
		
		return dao.addTestPlanSummary(rs);
	}
	@Override
	public long editTestPlanSummary(TestPlanSummary rs) throws Exception {
		
		return dao.editTestPlanSummary(rs);
	}
	@Override
	public List<Object[]> getTestandSpecsDocumentSummary(String testPlanInitiationId, String specsInitiationId) throws Exception {
		
		return dao.getTestandSpecsDocumentSummary(testPlanInitiationId, specsInitiationId);
	}
	@Override
	public long addTestApproch(TestApproach rs) throws Exception {
		return dao.addTestApproch(rs);
	}
	@Override
	public long editTestApproach(TestApproach rs) throws Exception {
		return dao.editTestApproach(rs);
	}
	@Override
	public List<Object[]> getApproach(String initiationid, String ProjectId) throws Exception {
		return dao.getApproach(initiationid, ProjectId);
	}
	
	@Override
	public long TestDocContentSubmit(String testPlanInitiationId, String attributes, String details,String userId) throws Exception {
		TestApproach pr= new TestApproach();
		pr.setPointName(attributes);
		pr.setPointDetails(details);
//		pr.setProjectId(Long.parseLong(ProjectId));
//		pr.setInitiationId(Long.parseLong(initiationid));
		pr.setTestPlanInitiationId(Long.parseLong(testPlanInitiationId));
		pr.setCreatedBy(userId);
		pr.setCreatedDate(sdf1.format(new Date()));
		pr.setIsActive(1);
		return dao.TestDocContentSubmit(pr);
	}
	@Override
	public Object[] GetTestContent(String initiationid, String ProjectId) throws Exception {
	
		return dao.GetTestContent(initiationid, ProjectId);
	}
	@Override
	public List<Object[]> GetTestContentList(String testPlanInitiationId) throws Exception {
		
		return dao.GetTestContentList(testPlanInitiationId);
	}
	@Override
	public long TestDocContentUpdate(String UpdateAction, String Details, String userId) throws Exception {
		TestApproach pr= new TestApproach();
		pr.setPointDetails(Details);
		System.out.println("UpdateAction"+UpdateAction);
		pr.setTestId(Long.parseLong(UpdateAction));
		pr.setModifiedBy(userId);
		pr.setModifiedDate(sdf1.format(new Date()));
		return dao.TestContentUpdate(pr,Details);
	}

	@Override
	public long Update(String initiationId, String projectId, String attributes, String details, String userId)
			throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	
	@Override
	public long insertTestAcceptanceFile(TestAcceptance re , String LabCode) throws Exception {
		
		String Path = LabCode +"\\ACCEPTANCE\\";
		
		if(!re.getFile().isEmpty()) {
			re.setFileName(re.getTestPlanInitiationId()+"_"+re.getFile().getOriginalFilename());
			saveFile(uploadpath+Path,re.getFileName(),re.getFile());
		}
		
		re.setIsActive(1);
		re.setFilePath(Path);
		return dao.insertTestAcceptanceFile(re);
	}
	public static void saveFile(String uploadpath, String fileName, MultipartFile multipartFile) throws IOException {
		logger.info(new Date() + "Inside SERVICE saveFile ");
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
	@Override
	public List<Object[]> GetAcceptanceTestingList(String testPlanInitiationId) throws Exception {
		
		return dao.GetAcceptanceTestingList(testPlanInitiationId);
	}
	@Override
	public long TestAcceptancetUpdate(String UpdateActionid, String Details, String userId, MultipartFile FileAttach,String LabCode) throws Exception {
		TestAcceptance pr= new TestAcceptance();
		
		System.out.println("hiiii");
		pr.setAttributesDetailas(Details);
		pr.setTestId(Long.parseLong(UpdateActionid));
		String Path = LabCode +"\\ACCEPTANCE\\";
		pr.setFile(FileAttach);
		if(!FileAttach.isEmpty()) {
			pr.setFileName(pr.getFile().getOriginalFilename());
			saveFile(uploadpath+Path,pr.getFileName(),pr.getFile());
		}
	
		pr.setModifiedBy(userId);
		pr.setModifiedDate(sdf1.format(new Date()));
		return dao.AcceptanceUpdate(pr,Details);
	}
	@Override
	public Object[] AcceptanceTestingList(String Testid) throws Exception {
		return dao.AcceptanceTestingList(Testid);
	}
	@Override
	public Object[] AcceptanceTestingExcelData(String testPlanInitiationId) throws Exception {
		return dao.AcceptanceTestingExcelData(testPlanInitiationId);
	}
	
	@Override
	public long addAbbreviations(List<Abbreviations> iaList) throws Exception {

		return dao.addAbbreviations(iaList);
	}
	@Override
	public List<Object[]> requirementTypeList(String reqInitiationId) throws Exception {
		return dao.requirementTypeList(reqInitiationId);
	}
	@Override
	public long addPfmsInititationRequirement(PfmsInititationRequirement pir) throws Exception {
		pir.setCreatedDate(sdf1.format(new Date()));
		pir.setIsActive(1);
		return prodao.ProjectRequirementAdd(pir);
	}
	@Override
	public long UpdatePfmsInititationRequirement(PfmsInititationRequirement pir) throws Exception {
		pir.setModifiedDate(sdf1.format(new Date()));
		return dao.UpdatePfmsInititationRequirement(pir);
	}
	@Override
	public long RequirementUpdate(PfmsInititationRequirement pir) throws Exception {
		return dao.RequirementUpdate(pir);
	}
	@Override
	public List<Object[]> getReqMainList(String reqMainId) throws Exception {
		return dao.getReqMainList(reqMainId);
	}
	@Override
	public List<Object[]> getreqTypeList(String reqMainId, String initiationReqId) throws Exception {
		return dao.getreqTypeList(reqMainId,initiationReqId);
	}
	@Override
	public List<Object[]> getVerificationMethodList() throws Exception {
		return dao.getVerificationMethodList();
	}
	@Override
	public List<Object[]> getProjectParaDetails(String reqInitiationId) throws Exception {
		// TODO Auto-generated method stub
		return dao.getProjectParaDetails(reqInitiationId);
	}
	@Override
	public List<Object[]> getVerifications(String reqInitiationId) throws Exception {
		return dao.getVerifications(reqInitiationId);
	}
	@Override
	public List<Object[]> ApplicableDocumentList(String reqInitiationId) throws Exception {
		return dao.ApplicableDocumentList(reqInitiationId);
	}
	@Override
	public List<Object[]> ApplicableTotalDocumentList(String reqInitiationId) throws Exception {
		// TODO Auto-generated method stub
		return dao.ApplicableTotalDocumentList(reqInitiationId);
	}
	@Override
	public long addDocs(List<ReqDoc> list) throws Exception {
		// TODO Auto-generated method stub
		return dao.addDocs(list);
	}

	@Override
	public List<Object[]> productTreeListByProjectId(String projectId) throws Exception {
		
		return dao.productTreeListByProjectId(projectId);
	}

	@Override
	public List<Object[]> initiationReqList(String projectId, String mainId, String initiationId) throws Exception {
		
		return dao.initiationReqList(projectId, mainId, initiationId);
	}
	
	@Override
	public List<Object[]> getPreProjectList(String loginType, String labcode, String empId) throws Exception {
		
		return dao.getPreProjectList(loginType, labcode, empId);
	}
	
	@Override
	public long addRequirementInitiation(RequirementInitiation requirementInitiation) throws Exception {
		
		return dao.addRequirementInitiation(requirementInitiation);
	}
	
	@Override
	public RequirementInitiation getRequirementInitiationById(String reqInitiationId) throws Exception {
		
		return dao.getRequirementInitiationById(reqInitiationId);
	}

	@Override
	public PfmsInititationRequirement getPfmsInititationRequirementById(String InitiationReqId) throws Exception {
		
		return dao.getPfmsInititationRequirementById(InitiationReqId);
	}

	@Override
	public Long addOrUpdatePfmsInititationRequirement(PfmsInititationRequirement pfmsInititationRequirement) throws Exception {
		
		return dao.addOrUpdatePfmsInititationRequirement(pfmsInititationRequirement);
	}
	
	@Override
	public Long requirementInitiationAddHandling(String initiationId, String projectId, String productTreeMainId, String empId,String username, String version, String remarks) throws Exception {
		try {
			RequirementInitiation reqInitiation = RequirementInitiation.builder()
					  							  .InitiationId(Long.parseLong(initiationId))
					  							  .ProjectId(Long.parseLong(projectId))
					  							  .ProductTreeMainId(Long.parseLong(productTreeMainId))
					  							  .ReqVersion(version!=null?version:"1.0")
					  							  .Remarks(remarks)
					  							  .InitiatedBy(Long.parseLong(empId))
					  							  .InitiatedDate(sdf2.format(new Date()))
					  							  .ReqStatusCode("RIN")
					  							  .ReqStatusCodeNext("RIN")
					  							  .CreatedBy(username)
					  							  .CreatedDate(sdf1.format(new Date()))
					  							  .IsActive(1)
					  							  .build();
			long reqInitiationId = dao.addRequirementInitiation(reqInitiation);
			
			// Handling Transaction
			requirementTransAddHandling(reqInitiationId, null, "RIN", empId, "R");
			
			return reqInitiationId;
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
	}
	
	@Override
	public List<Object[]> projectDocTransList(String docInitiationId, String docType) throws Exception {
		
		return dao.projectDocTransList(docInitiationId, docType);
	}
	
	public Long requirementTransAddHandling(long reqInitiationId, String remarks, String reqStatusCode, String empId, String docType) throws Exception {
		try {
			
			DocumentTrans transaction = DocumentTrans.builder()
											.DocInitiationId(reqInitiationId)
											.DocType(docType)
											.Remarks(remarks)
											.ReqStatusCode(reqStatusCode)
											.ActionBy(empId)
											.ActionDate(sdf1.format(new Date()))
											.build();
			
			return dao.addRequirementTransaction(transaction);
			
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
	}
	
	@Override
	public long projectRequirementApprovalForward(String reqInitiationId, String action, String remarks, String empId, String labcode, String userId) throws Exception {
		try {
			
			RequirementInitiation req = dao.getRequirementInitiationById(reqInitiationId);
			String reqStatusCode = req.getReqStatusCode();
			String reqStatusCodeNext = req.getReqStatusCodeNext();
			
			List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");
			
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(reqforwardstatus.contains(reqStatusCode)) {
					req.setReqStatusCode("RFW");
					req.setReqStatusCodeNext("RFR");
				}else {
					req.setReqStatusCode(reqStatusCodeNext);
					if(reqStatusCodeNext.equalsIgnoreCase("RFR")) {
						req.setReqStatusCodeNext("RFA");
					}else if(reqStatusCodeNext.equalsIgnoreCase("RFA")) {
						req.setReqStatusCodeNext("RAM");
					}else if(reqStatusCodeNext.equalsIgnoreCase("RAM")) {
						req.setReqStatusCodeNext("RAM");
					}
				}
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(reqStatusCodeNext.equalsIgnoreCase("RFR")) {
					req.setReqStatusCode("RRR");	
				}else if(reqStatusCodeNext.equalsIgnoreCase("RFA")) {
					req.setReqStatusCode("RRA");	
				}
				
				// Setting StatusCode Next
				req.setReqStatusCodeNext("RFW");
			}
			
			dao.addRequirementInitiation(req);
			
			// Handling Transaction
			requirementTransAddHandling(Long.parseLong(reqInitiationId), remarks, req.getReqStatusCode(), empId, "R");
			
			// Handling Notification
			RequirementSummary summary = dao.getRequirementSummaryByReqInitiationId(reqInitiationId);
			
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A")) {
				String reqStatusCode2 = req.getReqStatusCode();
				if(reqStatusCode2.equalsIgnoreCase("RFW")) {
					notification.setEmpId(summary.getReviewer());
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("Requirement Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFR")) {
					notification.setEmpId(summary.getApprover());
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("Requirement Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFA")) {
					notification.setEmpId(Long.parseLong(summary.getPreparedBy()));
					notification.setNotificationUrl("Requirements.htm?projectId="+req.getProjectId()+"&initiationId="+req.getInitiationId()+"&productTreeMainId="+req.getProductTreeMainId()+"&projectType="+(req.getProjectId()!=0?"M":"I") );
					notification.setNotificationMessage("Requirement Doc Approved");
				}
				
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdf1.format(new Date()));

				carsdao.addNotifications(notification);
				
			}else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")){
				notification.setEmpId(Long.parseLong(summary.getPreparedBy()));
				notification.setNotificationUrl("Requirements.htm?projectId="+req.getProjectId()+"initiationId="+req.getInitiationId()+"productTreeMainId="+req.getProductTreeMainId()+"projectType="+(req.getProjectId()!=0?"M":"I") );
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"Requirement Doc Request Returned":"Requirement Doc Request Disapproved");
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdf1.format(new Date()));
			
				carsdao.addNotifications(notification);
			}
			
			return 1L;
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
		
	}
	
	@Override
	public List<Object[]> projectRequirementPendingList(String empId, String labcode) throws Exception {
		
		return dao.projectRequirementPendingList(empId, labcode);
	}
	
	@Override
	public List<Object[]> projectRequirementApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.projectRequirementApprovedList(empId, FromDate, ToDate);
	}
	
	// Test Plan Changes from Bharath
	@Override
	public long TestDetailsAdd(TestDetails Td) throws Exception {

		return dao.TestDetailsAdd(Td);
	}
	
	@Override
	public List<Object[]> TestTypeList() throws Exception {
		
		return dao.TestTypeList();
	}
	@Override
	public List<Object[]> StagesApplicable() throws Exception {
		return dao.StagesApplicable();
	}
	@Override
	public Long numberOfTestTypeId(String testPlanInitiationId) throws Exception {
	
		return dao.numberOfTestTypeId(testPlanInitiationId);
	}
	@Override
	public List<Object[]> TestDetailsList(String testPlanInitiationId) throws Exception {
		
		return dao.TestDetailsList(testPlanInitiationId);
	}
	
//	@Override
//	public long TestDetailasUpdate(TestDetails prd, String userId, String TestId) throws Exception {
//		
//		logger.info(new Date() + "Inside SERVICE TestDetailasUpdate ");
//		TestDetails pir=new TestDetails();
//		
//		pir.setName(prd.getName());
//		pir.setObjective(prd.getObjective());
//		pir.setDescription(prd.getDescription());
//		pir.setPreConditions(prd.getPreConditions());
//		pir.setPostConditions(prd.getPostConditions());
//		pir.setConstraints(prd.getConstraints());
//		pir.setSafetyRequirements(prd.getSafetyRequirements());
//		pir.setMethodology(prd.getMethodology());
//		pir.setToolsSetup(prd.getToolsSetup());
//		pir.setPersonnelResources(prd.getPersonnelResources());
//		pir.setEstimatedTimeIteration(prd.getEstimatedTimeIteration());
//		pir.setIterations(prd.getIterations());
//		pir.setSchedule(prd.getSchedule());
//		pir.setPass_Fail_Criteria(prd.getPass_Fail_Criteria());	
//		pir.setStageApplicable(prd.getStageApplicable());
//		pir.setRemarks(prd.getRemarks());
//		pir.setModifiedBy(userId);
//		pir.setModifiedDate(sdf1.format(new Date()));
//		/* pir.setIsActive(1); */
//		return dao.TestDUpdate(pir,TestId);
//	
//	}
	
	@Override
	public List<Object[]> TestSuiteList() throws Exception {
		
		return dao.TestTypeList();
	}
	
	@Override
	public List<Object[]> getVerificationMethodList(String projectId, String initiationId) throws Exception {
		
		return dao.getVerificationMethodList(projectId,initiationId);
	}
	
	@Override
	public List<Object[]> TestType(String r) throws Exception {

		return dao.TestType(r);
	}
	
	@Override
	public List<Object[]> getDocumentSummary(String testPlanInitiationId) throws Exception {
		
		return dao.getDocumentSummary(testPlanInitiationId);
	}
	
	@Override
	public Long insertTestType(TestTools pt) throws Exception {
		
		return dao.insertTestType(pt);
	}
	@Override
	public List<Object[]> initiationTestPlanList(String projectId, String mainId, String initiationId) throws Exception {
		
		return dao.initiationTestPlanList(projectId, mainId, initiationId);
	}
	
	// Bharath changes end
	
	@Override
	public Long testPlanInitiationAddHandling(String initiationId,String projectId, String productTreeMainId,String empId, String username, String version, String remarks) throws Exception {
		try {
			TestPlanInitiation testplanInitiation = TestPlanInitiation.builder()
					  							  .InitiationId(Long.parseLong(initiationId))
					  							  .ProjectId(Long.parseLong(projectId))
					  							  .ProductTreeMainId(Long.parseLong(productTreeMainId))
					  							  .TestPlanVersion(version!=null?version:"1")
					  							  .Remarks(remarks)
					  							  .InitiatedBy(Long.parseLong(empId))
					  							  .InitiatedDate(sdf2.format(new Date()))
					  							  .ReqStatusCode("RIN")
					  							  .ReqStatusCodeNext("RIN")
					  							  .CreatedBy(username)
					  							  .CreatedDate(sdf1.format(new Date()))
					  							  .IsActive(1)
					  							  .build();
			long testPlanInitiationId = dao.addTestPlanInitiation(testplanInitiation);
			
			// Handling Transaction
			requirementTransAddHandling(testPlanInitiationId, null, "RIN", empId, "T");
			
			return testPlanInitiationId;
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
	}
	
	@Override
	public TestPlanSummary getTestPlanSummaryById(String summaryId) throws Exception {
		
		return dao.getTestPlanSummaryById(summaryId);
	}
	@Override
	public TestPlanInitiation getTestPlanInitiationById(String testPlanInitiationId) throws Exception {
		
		return dao.getTestPlanInitiationById(testPlanInitiationId);
	}
	
	@Override
	public TestDetails getTestPlanDetailsById(String testId) throws Exception {
		
		return dao.getTestPlanDetailsById(testId);
	}
	
	@Override
	public long projectTestPlanApprovalForward(String testPlanInitiationId, String action, String remarks, String empId, String labcode, String userId) throws Exception {
		try {
			
			TestPlanInitiation testplan = dao.getTestPlanInitiationById(testPlanInitiationId);
			String reqStatusCode = testplan.getReqStatusCode();
			String reqStatusCodeNext = testplan.getReqStatusCodeNext();
			
			List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");
			
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(reqforwardstatus.contains(reqStatusCode)) {
					testplan.setReqStatusCode("RFW");
					testplan.setReqStatusCodeNext("RFR");
				}else {
					testplan.setReqStatusCode(reqStatusCodeNext);
					if(reqStatusCodeNext.equalsIgnoreCase("RFR")) {
						testplan.setReqStatusCodeNext("RFA");
					}else if(reqStatusCodeNext.equalsIgnoreCase("RFA")) {
						testplan.setReqStatusCodeNext("RAM");
					}else if(reqStatusCodeNext.equalsIgnoreCase("RAM")) {
						testplan.setReqStatusCodeNext("RAM");
					}
				}
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(reqStatusCodeNext.equalsIgnoreCase("RFR")) {
					testplan.setReqStatusCode("RRR");	
				}else if(reqStatusCodeNext.equalsIgnoreCase("RFA")) {
					testplan.setReqStatusCode("RRA");	
				}
				
				// Setting StatusCode Next
				testplan.setReqStatusCodeNext("RFW");
			}
			
			dao.addTestPlanInitiation(testplan);
			
			// Handling Transaction
			requirementTransAddHandling(Long.parseLong(testPlanInitiationId), remarks, testplan.getReqStatusCode(), empId, "T");
			
			// Handling Notification
			List<Object[]> summaryList = dao.getTestandSpecsDocumentSummary(testPlanInitiationId, "0");
			
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A")) {
				String reqStatusCode2 = testplan.getReqStatusCode();
				if(reqStatusCode2.equalsIgnoreCase("RFW")) {
					notification.setEmpId(Long.parseLong(summaryList!=null?summaryList.get(0)[4].toString():"0"));
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("Test Plan Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFR")) {
					notification.setEmpId(Long.parseLong(summaryList!=null?summaryList.get(0)[5].toString():"0"));
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("Test Plan Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFA")) {
					notification.setEmpId(Long.parseLong(summaryList!=null?summaryList.get(0)[9].toString():"0"));
					notification.setNotificationUrl("ProjectTestPlan.htm?projectId="+testplan.getProjectId()+"&initiationId="+testplan.getInitiationId()+"&productTreeMainId="+testplan.getProductTreeMainId()+"&projectType="+(testplan.getProjectId()!=0?"M":"I") );
					notification.setNotificationMessage("Test Plan Doc Approved");
				}
				
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdf1.format(new Date()));

				carsdao.addNotifications(notification);
				
			}else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")){
				notification.setEmpId(Long.parseLong(summaryList!=null?summaryList.get(0)[9].toString():"0"));
				notification.setNotificationUrl("ProjectTestPlan.htm?projectId="+testplan.getProjectId()+"initiationId="+testplan.getInitiationId()+"productTreeMainId="+testplan.getProductTreeMainId()+"projectType="+(testplan.getProjectId()!=0?"M":"I") );
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"Test Plan Doc Request Returned":"Test Plan Doc Request Disapproved");
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdf1.format(new Date()));
			
				carsdao.addNotifications(notification);
			}
			
			return 1L;
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
		
	}
	
	@Override
	public long projectSpecsApprovalForward(String specsInitiationId, String action, String remarks, String empId,String labcode, String userId) throws Exception {
		SpecsInitiation specsInitiation = dao.getSpecsInitiationById(specsInitiationId);
		String reqStatusCode = specsInitiation.getReqStatusCode();
		List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");
		String reqStatusCodeNext = specsInitiation.getReqStatusCodeNext();
		try {
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(reqforwardstatus.contains(reqStatusCode)) {
					specsInitiation.setReqStatusCode("RFW");
					specsInitiation.setReqStatusCodeNext("RFR");
				}else {
					specsInitiation.setReqStatusCode(reqStatusCodeNext);
					if(reqStatusCodeNext.equalsIgnoreCase("RFR")) {
						specsInitiation.setReqStatusCodeNext("RFA");
					}else if(reqStatusCodeNext.equalsIgnoreCase("RFA")) {
						specsInitiation.setReqStatusCodeNext("RAM");
					}else if(reqStatusCodeNext.equalsIgnoreCase("RAM")) {
						specsInitiation.setReqStatusCodeNext("RAM");
					}
				}
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(reqStatusCodeNext.equalsIgnoreCase("RFR")) {
					specsInitiation.setReqStatusCode("RRR");	
				}else if(reqStatusCodeNext.equalsIgnoreCase("RFA")) {
					specsInitiation.setReqStatusCode("RRA");	
				}
				
				// Setting StatusCode Next
				specsInitiation.setReqStatusCodeNext("RFW");
			}
			
			dao.addSpecsInitiation(specsInitiation);
			
			// Add data in transaction Table
			requirementTransAddHandling(Long.parseLong(specsInitiationId), remarks, specsInitiation.getReqStatusCode(), empId, "S");
		
			// Handling Notification
			List<Object[]> summaryList = dao.getTestandSpecsDocumentSummary("0", specsInitiationId);
		
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A")) {
				String reqStatusCode2 = specsInitiation.getReqStatusCode();
				if(reqStatusCode2.equalsIgnoreCase("RFW")) {
					notification.setEmpId(Long.parseLong(summaryList!=null?summaryList.get(0)[4].toString():"0"));
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("SpecificationPlan Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFR")) {
					notification.setEmpId(Long.parseLong(summaryList!=null?summaryList.get(0)[5].toString():"0"));
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("SpecificationPlan Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFA")) {
					notification.setEmpId(Long.parseLong(summaryList!=null?summaryList.get(0)[9].toString():"0"));
					notification.setNotificationUrl("ProjectSpecification.htm?projectId="+specsInitiation.getProjectId()+"&initiationId="+specsInitiation.getInitiationId()+"&productTreeMainId="+specsInitiation.getProductTreeMainId()+"&projectType="+(specsInitiation.getProjectId()!=0?"M":"I") );
					notification.setNotificationMessage("SpecificationPlan Doc Approved");
				}
				
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdf1.format(new Date()));

				carsdao.addNotifications(notification);
			}else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")){
				notification.setEmpId(Long.parseLong(summaryList!=null?summaryList.get(0)[9].toString():"0"));
				notification.setNotificationUrl("ProjectSpecification.htm?projectId="+specsInitiation.getProjectId()+"initiationId="+specsInitiation.getInitiationId()+"productTreeMainId="+specsInitiation.getProductTreeMainId()+"projectType="+(specsInitiation.getProjectId()!=0?"M":"I") );
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"Specification Plan Doc Request Returned":"Specification Plan Doc Request Disapproved");
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdf1.format(new Date()));
			
				carsdao.addNotifications(notification);
			}
			
		
		}catch (Exception e) {
		
		}
		
		
		return 1l;
	}
	
	
	
	@Override
	public List<Object[]> projectTestPlanPendingList(String empId, String labcode) throws Exception {
		
		return dao.projectTestPlanPendingList(empId, labcode);
	}
	@Override
	public List<Object[]> projectTestPlanApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.projectTestPlanApprovedList(empId, FromDate, ToDate);
	}
	
	@Override
	public SpecsInitiation getSpecsInitiationById(String specsInitiationId) throws Exception {
		
		return dao.getSpecsInitiationById(specsInitiationId);
	}
	
	@Override
	public long SpecificationInitiationAddHandling(String initiationId, String projectId, String productTreeMainId,String empId, String userId,String version, String remarks) {
		try {
			SpecsInitiation specsInitiation = SpecsInitiation.builder()
					  							  .InitiationId(Long.parseLong(initiationId))
					  							  .ProjectId(Long.parseLong(projectId))
					  							  .ProductTreeMainId(Long.parseLong(productTreeMainId))
					  							  .SpecsVersion(version!=null ?version:"1")
					  							  .InitiatedBy(Long.parseLong(empId))
					  							  .InitiatedDate(sdf2.format(new Date()))
					  							  .ReqStatusCode("RIN")
					  							  .ReqStatusCodeNext("RIN")
					  							  .Remarks(remarks)
					  							  .CreatedBy(userId)
					  							  .CreatedDate(sdf1.format(new Date()))
					  							  .IsActive(1)
					  							  .build();
			long specsId = dao.addSpecsInitiation(specsInitiation);
			
			// Handling Transaction
			requirementTransAddHandling(specsId, null, "RIN", empId, "S");
			
			return specsId;
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
	}
	
	@Override
	public int getDuplicateCountofTestType(String testType) throws Exception {
		
		return dao.getDuplicateCountofTestType(testType);
	}
	
	@Override
	public Object[] getTestPlanApprovalFlowData(String initiationId, String projectId, String productTreeMainId) throws Exception {
		
		return dao.getTestPlanApprovalFlowData(initiationId, projectId, productTreeMainId);
	}

	@Override
	public void testPlanPdfFreeze(HttpServletRequest req,HttpServletResponse res,String testPlanInitiationId, String labCode) throws Exception{
		logger.info(new Date() +"Inside SERVICE testPlanPdfFreeze ");
		try {
			
			req.setAttribute("DocTempAttributes", prodao.DocTempAttributes());
			
			TestPlanInitiation ini = dao.getTestPlanInitiationById(testPlanInitiationId);
			testPlanInitiationId = dao.getFirstVersionTestPlanInitiationId( ini.getInitiationId()+"",ini.getProjectId()+"", ini.getProductTreeMainId()+"")+"";
			Object[] projectDetails = prodao.getProjectDetails(labCode, ini.getInitiationId()!=0?ini.getInitiationId()+"":ini.getProjectId()+"", ini.getInitiationId()!=0?"P":"E");
			req.setAttribute("projectShortName", projectDetails!=null?projectDetails[2]:"");
			
			String filename="TestPlan";
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			req.setAttribute("lablogo",  LogoUtil.getLabLogoAsBase64String(labCode)); 
			req.setAttribute("LabImage",  LogoUtil.getLabImageAsBase64String(labCode)); 
			req.setAttribute("LabList", prodao.LabListDetails(labCode));
			req.setAttribute("path",path);
			req.setAttribute("lablogo",  LogoUtil.getLabLogoAsBase64String(labCode)); 
			req.setAttribute("LabImage",  LogoUtil.getLabImageAsBase64String(labCode)); 
			req.setAttribute("LabList", prodao.LabListDetails(labCode));
			req.setAttribute("uploadpath", uploadpath);
			req.setAttribute("TestScopeIntro",dao.TestScopeIntro(testPlanInitiationId));
			req.setAttribute("MemberList", dao.DocMemberList(testPlanInitiationId, "0"));
			req.setAttribute("DocumentSummary", dao.getTestandSpecsDocumentSummary(testPlanInitiationId, "0"));
			req.setAttribute("AbbreviationDetails",dao.AbbreviationDetails(testPlanInitiationId, "0"));
			req.setAttribute("TestContent", dao.GetTestContentList(testPlanInitiationId));
			req.setAttribute("AcceptanceTesting", dao.GetAcceptanceTestingList(testPlanInitiationId));
			req.setAttribute("TestSuite", dao.TestTypeList());
			req.setAttribute("TestDetailsList", dao.TestDetailsList(testPlanInitiationId));
			req.setAttribute("StagesApplicable", dao.StagesApplicable());
				        
	        CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/requirements/TestPlanPDFDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();                  
	        
	        HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf")) ; 
	         
	        File file=new File(path +File.separator+ filename+".pdf");
	        
	        String fname="Test_Plan-"+testPlanInitiationId;
			String filepath = "Doc_Repo\\Test_Plan";
			int count=0;
			while(new File(uploadpath+filepath+"\\"+fname+".pdf").exists())
			{
				fname = "Test_Plan-"+testPlanInitiationId;
				fname = fname+" ("+ ++count+")";
			}
	        
	        saveFile(uploadpath+filepath, fname+".pdf", file);
	        
	        // Document Freeze Handling
	        documentFreezeAddHandling(testPlanInitiationId, "T", filepath+"\\"+fname+".pdf", null);

	        Path pathOfFile= Paths.get( path+File.separator+filename+".pdf"); 
	        Files.delete(pathOfFile);		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	

	
	@Override
	public void SpecsInitiationPdfFreeze(HttpServletRequest req, HttpServletResponse res, String specsInitiationId,
			String labcode) throws Exception {
		// TODO Auto-generated method stub
		
		logger.info(new Date() +"Inside SERVICE SpecsInitiationPdfFreeze");
		try {
		req.setAttribute("DocTempAttributes", prodao.DocTempAttributes());
		req.setAttribute("lablogo",  LogoUtil.getLabLogoAsBase64String(labcode)); 
		req.setAttribute("LabImage",  LogoUtil.getLabImageAsBase64String(labcode)); 
		req.setAttribute("LabList", prodao.LabListDetails(labcode));
		req.setAttribute("MemberList", dao.DocMemberList( "0",specsInitiationId));
		req.setAttribute("DocumentSummary", dao.getTestandSpecsDocumentSummary( "0",specsInitiationId));
		req.setAttribute("AbbreviationDetails",dao.AbbreviationDetails( "0",specsInitiationId));
		req.setAttribute("SpecContentsDetails", prodao.SpecContentsDetails(specsInitiationId));
		req.setAttribute("SpecsIntro", prodao.getSpecsIntro(specsInitiationId));
		req.setAttribute("SpecProducTree",prodao.SpecProducTreeDetails(specsInitiationId));
		req.setAttribute("filePath", env.getProperty("ApplicationFilesDrive"));
		
		SpecsInitiation specsInitiation = dao.getSpecsInitiationById(specsInitiationId);
		List<Object[]>initiationReqList = dao.initiationReqList(specsInitiation.getProjectId()+"", specsInitiation.getProductTreeMainId()+"",specsInitiation.getInitiationId()+"" );
		String reqInitiationId=null;
		List<Object[]>RequirementList= new ArrayList<>();
		if(initiationReqList!=null && initiationReqList.size()>0) {
			reqInitiationId=initiationReqList.get(0)[0].toString();
			RequirementList=dao.RequirementList(reqInitiationId);
		}
		req.setAttribute("RequirementList", RequirementList);
		req.setAttribute("specsList", dao.getSpecsList(specsInitiationId));
		
		String filename="ProjectSpecification";
		String path=req.getServletContext().getRealPath("/view/temp");
		req.setAttribute("path",path);
		
		
		CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
		req.getRequestDispatcher("/view/requirements/SpecificationPDF.jsp").forward(req, customResponse);
		String html = customResponse.getOutput();
		
		
        HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf")) ; 

        
        File file=new File(path +File.separator+ filename+".pdf");
        
        String fname="Specification-"+specsInitiationId;
		String filepath = "Doc_Repo\\Specification";
        
		int count=0;
		while(new File(uploadpath+filepath+"\\"+fname+".pdf").exists())
		{
			fname = "Specification-"+specsInitiationId;
			fname = fname+" ("+ ++count+")";
		}
		 saveFile(uploadpath+filepath, fname+".pdf", file);
		   
	        // Document Freeze Handling
	        documentFreezeAddHandling(specsInitiationId, "S", filepath+"\\"+fname+".pdf", null);

	        Path pathOfFile= Paths.get( path+File.separator+filename+".pdf"); 
	        Files.delete(pathOfFile);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	public void saveFile(String uploadpath, String fileName, File fileToSave) throws IOException 
	{
	   logger.info(new Date() +"Inside SERVICE saveFile ");
	   Path uploadPath = Paths.get(uploadpath);
	          
	   if (!Files.exists(uploadPath)) {
		   Files.createDirectories(uploadPath);
	   }
	        
	   try (InputStream inputStream = new FileInputStream(fileToSave)) {
		   Path filePath = uploadPath.resolve(fileName);
	       Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	   } catch (IOException ioe) {       
		   throw new IOException("Could not save file: " + fileName, ioe);
	   }     
	} 
	
	@Override
	public Long documentFreezeAddHandling(String docInitiationId, String docType, String pdfFilePath, String excelFilePath) throws Exception {
		try {
			DocumentFreeze freeze = dao.getDocumentFreezeByDocIdandDocType(docInitiationId, docType);
			
			if(freeze==null) {
				freeze = new DocumentFreeze();
				freeze.setDocInitiationId(Long.parseLong(docInitiationId));
				freeze.setDocType(docType);
				freeze.setCreatedBy("SYSTEM");
				freeze.setCreatedDate(sdf1.format(new Date()));
				freeze.setIsActive(1);
			}
		
			if(pdfFilePath!=null) {
				freeze.setPdfFilePath(pdfFilePath);
			}else if(excelFilePath!=null) {
				freeze.setExcelFilePath(excelFilePath);
			}
			return dao.addDocumentFreeze(freeze);
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
	}
	
	
	@Override
	public DocumentFreeze getDocumentFreezeByDocIdandDocType(String docInitiationId, String docType) throws Exception {
		
		return dao.getDocumentFreezeByDocIdandDocType(docInitiationId, docType);
	}
	@Override
	public Long getFirstVersionTestPlanInitiationId(String initiationId, String projectId, String productTreeMainId) throws Exception {
		
		return dao.getFirstVersionTestPlanInitiationId(initiationId, projectId, productTreeMainId);
	}
	
	@Override
	public void requirementPdfFreeze(HttpServletRequest req,HttpServletResponse res,String reqInitiationId, String labCode) throws Exception{
		logger.info(new Date() +"Inside SERVICE requirementPdfFreeze ");
		try {
			
			req.setAttribute("DocTempAttributes", prodao.DocTempAttributes());

			RequirementInitiation ini = dao.getRequirementInitiationById(reqInitiationId);
			reqInitiationId = dao.getFirstVersionReqInitiationId( ini.getInitiationId()+"",ini.getProjectId()+"", ini.getProductTreeMainId()+"")+"";
			Object[] projectDetails = prodao.getProjectDetails(labCode, ini.getInitiationId()!=0?ini.getInitiationId()+"":ini.getProjectId()+"", ini.getInitiationId()!=0?"P":"E");
			req.setAttribute("projectShortName", projectDetails!=null?projectDetails[2]:"");
			
			req.setAttribute("lablogo",  LogoUtil.getLabLogoAsBase64String(labCode)); 
			req.setAttribute("LabImage",  LogoUtil.getLabImageAsBase64String(labCode)); 
			req.setAttribute("LabList", prodao.LabListDetails(labCode));
			req.setAttribute("RequirementList", dao.RequirementList(reqInitiationId));
			req.setAttribute("uploadpath", uploadpath);
			req.setAttribute("ReqIntro", prodao.RequirementIntro(reqInitiationId));
			req.setAttribute("MemberList", prodao.reqMemberList(reqInitiationId));
			req.setAttribute("DocumentSummary", prodao.getDocumentSummary(reqInitiationId));
			req.setAttribute("ProjectParaDetails", dao.getProjectParaDetails(reqInitiationId));
			req.setAttribute("AcronymsList", prodao.getAcronymsList(reqInitiationId));
			req.setAttribute("PerformanceList", prodao.getPerformanceList(reqInitiationId));;
			req.setAttribute("VerificationDataList", dao.getVerificationMethodList());;
			req.setAttribute("ApplicableTotalDocumentList", dao.ApplicableTotalDocumentList(reqInitiationId));
			req.setAttribute("AbbreviationDetails", prodao.getAbbreviationDetails(reqInitiationId));
			req.setAttribute("Verifications", dao.getVerifications(reqInitiationId));
			
			String filename="ProjectRequirement";
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
				        
	        CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/requirements/RequirementPDFDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();                  
	        
	        HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf")) ; 
	         
	        File file=new File(path +File.separator+ filename+".pdf");
	        
	        String fname="Requirement-"+reqInitiationId;
			String filepath = "Doc_Repo\\Requirement";
			int count=0;
			while(new File(uploadpath+filepath+"\\"+fname+".pdf").exists())
			{
				fname = "Requirement-"+reqInitiationId;
				fname = fname+" ("+ ++count+")";
			}
	        
	        saveFile(uploadpath+filepath, fname+".pdf", file);
	        
	        // Document Freeze Handling
	        documentFreezeAddHandling(reqInitiationId, "R", filepath+"\\"+fname+".pdf", null);

	        Path pathOfFile= Paths.get( path+File.separator+filename+".pdf"); 
	        Files.delete(pathOfFile);		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	

	@Override
	public Object[] getRequirementApprovalFlowData(String initiationId, String projectId, String productTreeMainId) throws Exception {
		
		return dao.getRequirementApprovalFlowData(initiationId, projectId, productTreeMainId);
	}
	@Override
	public Long getFirstVersionReqInitiationId(String initiationId, String projectId, String productTreeMainId) throws Exception {
		
		return dao.getFirstVersionReqInitiationId(initiationId, projectId, productTreeMainId);
	}

	@Override
	public List<Object[]> getSpecsList(String specsInitiationId) throws Exception {

		return dao.getSpecsList(specsInitiationId);
	}
	
	@Override
	public Long getFirstVersionSpecsInitiationId(String initiationId, String projectId, String productTreeMainId) throws Exception {
		
		return dao.getFirstVersionSpecsInitiationId(initiationId, projectId, productTreeMainId);
	}
	
	@Override
	public List<Object[]> getSpecsPlanApprovalFlowData(String projectId, String initationId, String productTreeMainId)
			throws Exception {
		return dao.getSpecsPlanApprovalFlowData(projectId,initationId,productTreeMainId);
	}
	@Override
	public List<Object[]> projectSpecificationApprovedList(String empId, String fromdate, String todate)throws Exception {
		return null;
	}
	@Override
	public List<Object[]> projectSpecificationPendingList(String empId, String labcode) throws Exception {
		return dao.projectSpecificationPendingList(empId,labcode);
	}
	@Override
	public List<Object[]> getAllSqr(String reqInitiationId) throws Exception {
		return dao.getAllSqr(reqInitiationId);
	}
	@Override
	public long AddReqType(PfmsReqTypes pr) throws Exception {
		return dao.AddReqType(pr);
	}
	
	@Override
	public long deleteSqr(String paraId) throws Exception {
		return dao.deleteSqr(paraId);
	}
	@Override
	public long updateSerialParaNo(String para, String sn) throws Exception {
		return dao.updateSerialParaNo(para,sn);
	}
	@Override
	public long deleteInitiationReq(String InitiationReqId) throws Exception
	{
		return dao.deleteInitiationReq(InitiationReqId);
	}
	@Override
	public long deleteInitiationSpe(String SpecsId) throws Exception
	{
		return dao.deleteInitiationSpe(SpecsId);
	}
	
	@Override
	public long addSpecMaster(String[] specificationCode, String[] specificationName) throws Exception {
		
		long count=0;
		for(int i=0;i<specificationCode.length;i++) {
			PfmsSpecTypes pst = new PfmsSpecTypes();
			pst.setSpecCode(specificationCode[i]);
			pst.setSpecificationName(specificationName[i]);
			pst.setSpecificationParentId(0l);
			count=dao.addSpecMaster(pst);
		}
		
		return count;
	}
	
	@Override
	public long addTestMaster(String[] testplanCode, String[] testplanName) throws Exception {
		// TODO Auto-generated method stub
		long count=0;
				
		for (int i=0;i<testplanCode.length;i++) {
			PfmsTestTypes pt = new PfmsTestTypes();
			pt.setTestCode(testplanCode[i]);
			pt.setTestName(testplanName[i]);
			pt.setTestParentId(0l);
			count=count+dao.addTestMaster(pt);
		}
		
		return count;
	}
	
	
	@Override
	public List<Object[]> getSpecMasterList(String SpecsInitiationId) throws Exception {
		return dao.getSpecMasterList(SpecsInitiationId);
	}
	
	@Override
	public Object[] getSpecName(String mainId) throws Exception {

		return dao.getSpecName(mainId);
	}
	
	@Override
	public List<Object[]> getTestPlanMainList(String testPlanInitiationId) throws Exception {

		return dao.getTestPlanMainList(testPlanInitiationId);
	}
	
	@Override
	public Object[] getTestTypeName(String mainid) throws Exception {
		// TODO Auto-generated method stub
		return dao.getTestTypeName(mainid);
	}
	
	@Override
	public long deleteTestPlan(String testId) throws Exception {
		// TODO Auto-generated method stub
		return dao.deleteTestPlan(testId);
	}
	
	/* Soumyakanta Swain */
	
	@Override
	public List<Object[]> getVerificationListMaster() throws Exception {
		return dao.getVerificationListMaster();
	}

	@Override
	public long addVerificationData(List<VerificationData> verifyList) throws Exception {
		return dao.addVerificationData(verifyList);
	}
	
	@Override
	public List<Object[]> getverificationDataList(String verificationId) throws Exception {
		return dao.getverificationDataList(verificationId);
	}
	
	@Override
	public long verificationDataEdit(VerificationData verifiData) throws Exception {
		return dao.verificationDataEdit(verifiData);
	}
	@Override
	public List<Object[]> SpecificationMasterList() throws Exception{
		return dao.SpecificationMasterList();
	}
	@Override
	public long specMasterAddSubmit(SpecificationMaster sp) throws Exception {
		return dao.specMasterAddSubmit(sp);
	}
	@Override
	public SpecificationMaster getSpecificationMasterById(long SpecsMasterId) throws Exception {
		return dao.SpecificationMaster(SpecsMasterId);
	}
	@Override
	public List<Object[]> TestPlanMaster() throws Exception {
		return dao.TestPlanMaster();
	}
	@Override
	public TestPlanMaster getTestPlanById(long TestMasterId) throws Exception {
		return dao.getTestPlanById(TestMasterId);
	}
	@Override
	public long testPlanMasterAdd(TestPlanMaster tp) throws Exception {
		
		return dao.testPlanMasterAdd(tp);
	}
	
	@Override
	public List<Object[]> igiDocumentPendingList(String empId, String labcode) throws Exception {
		
		return dao.igiDocumentPendingList(empId, labcode);
	}
	
	@Override
	public List<Object[]> igiDocumentApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.igiDocumentApprovedList(empId, FromDate, ToDate);
	}
	
	@Override
	public List<Object[]> icdDocumentPendingList(String empId, String labcode) throws Exception {
		
		return dao.icdDocumentPendingList(empId, labcode);
	}
	
	@Override
	public List<Object[]> icdDocumentApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.icdDocumentApprovedList(empId, FromDate, ToDate);
	}
	
	@Override
	public List<Object[]> irsDocumentPendingList(String empId, String labcode) throws Exception {
		
		return dao.irsDocumentPendingList(empId, labcode);
	}
	
	@Override
	public List<Object[]> irsDocumentApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.irsDocumentApprovedList(empId, FromDate, ToDate);
	}
	
	@Override
	public List<Object[]> productTreeListByInitiationId(String initiationId) throws Exception {

		return dao.productTreeListByInitiationId(initiationId);
	}
	
	@Override
	public List<TestPlanMaster> getAllTestPlans() throws Exception {
		return dao.getAllTestPlans();
	}
	@Override
	public List<SpecificationMaster> getAllSpecPlans() throws Exception {
		return dao.getAllSpecPlans();
	}
}
