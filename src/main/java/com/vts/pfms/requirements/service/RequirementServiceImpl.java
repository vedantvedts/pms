package com.vts.pfms.requirements.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.project.dao.ProjectDao;
import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;
import com.vts.pfms.project.model.PfmsInititationRequirement;
import com.vts.pfms.project.service.ProjectServiceImpl;
import com.vts.pfms.requirements.dao.RequirementDao;
import com.vts.pfms.requirements.model.Abbreviations;
import com.vts.pfms.requirements.model.DocMembers;
import com.vts.pfms.requirements.model.TestAcceptance;
import com.vts.pfms.requirements.model.TestApproach;
import com.vts.pfms.requirements.model.TestPlanSummary;
import com.vts.pfms.requirements.model.TestScopeIntro;

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
	ProjectDao prodao;
	
	@Override
	public List<Object[]> RequirementList(String initiationid, String projectId) throws Exception {
		return dao.RequirementList(initiationid,projectId);
	}
	@Override
	public long ProjectRequirementAdd(PfmsInitiationRequirementDto prd, String userId, String labCode)
			throws Exception {
		// TODO Auto-generated method stub
		PfmsInititationRequirement pir=new PfmsInititationRequirement();
		pir.setInitiationId(prd.getInitiationId());
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
		pir.setProjectId(prd.getProjectId());
		return prodao.ProjectRequirementAdd(pir);
	}
	
	@Override
	public List<Object[]> AbbreviationDetails(String initiationId, String projectId) throws Exception {
	return dao.AbbreviationDetails(initiationId,projectId);
	}


	@Override
	public long AddDocMembers(DocMembers rm) throws Exception {
		
		int numberOfPersons= rm.getEmps().length; 
		
		String []assignee= rm.getEmps();
		long count=0;
		for(int i=0;i<numberOfPersons;i++) {
			DocMembers r = new DocMembers();
			r.setInitiationId(rm.getInitiationId());
			r.setCreatedBy(rm.getCreatedBy());
			r.setCreatedDate(rm.getCreatedDate());
			r.setEmpId(Long.parseLong(assignee[i]));
			r.setIsActive(1);
			r.setProjectId(rm.getProjectId());
			r.setMemeberType(rm.getMemeberType());
			count=dao.AddreqMembers(r);
			
		}
		return count;
	}
	@Override
	public List<Object[]> DocMemberList(String initiationid, String ProjectId) throws Exception {
		
		return dao.DocMemberList(initiationid, ProjectId);
	}
	@Override
	public Object[] TestScopeIntro(String initiationid, String ProjectId) throws Exception {
	
		return dao.TestScopeIntro(initiationid, ProjectId);
	}
	@Override
	public long TestScopeIntroSubmit(String initiationid, String ProjectId, String attributes, String details, String UserId) throws Exception {
		
		TestScopeIntro pr= new TestScopeIntro();
		if(attributes.equalsIgnoreCase("Introduction")) {
			pr.setIntroduction(details);
		}else if(attributes.equalsIgnoreCase("System Identification")) {
			pr.setSystemIdentification(details);
		}else if(attributes.equalsIgnoreCase("System Overview")) {
			pr.setSystemOverview(details);
		}
		pr.setProjectId(Long.parseLong(ProjectId));
		pr.setInitiationId(Long.parseLong(initiationid));
		pr.setProjectType("T");
		pr.setCreatedBy(UserId);
		pr.setCreatedDate(sdf1.format(new Date()));
		pr.setIsActive(1);
		return dao.TestScopeIntroSubmit(pr);
	}
	@Override
	public long TestScopeUpdate(String initiationid, String ProjectId, String attributes, String details, String userId) throws Exception {
		TestScopeIntro pr= new TestScopeIntro();
		if(attributes.equalsIgnoreCase("Introduction")) {
			pr.setIntroduction(details);
		}else if(attributes.equalsIgnoreCase("System Identification")) {
			pr.setSystemIdentification(details);
		}else if(attributes.equalsIgnoreCase("System Overview")) {
			pr.setSystemOverview(details);
		}
		pr.setProjectId(Long.parseLong(ProjectId));
		pr.setInitiationId(Long.parseLong(initiationid));
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
	public List<Object[]> getTestPlanDocumentSummary(String initiationid, String ProjectId) throws Exception {
		return dao.getTestPlanDocumentSummary(initiationid, ProjectId);
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
	public long TestDocContentSubmit(String initiationid, String ProjectId, String attributes, String details, String UserId) throws Exception {
		TestApproach pr= new TestApproach();
		pr.setPointName(attributes);
		pr.setPointDetails(details);
		pr.setProjectId(Long.parseLong(ProjectId));
		pr.setInitiationId(Long.parseLong(initiationid));
		pr.setCreatedBy(UserId);
		pr.setCreatedDate(sdf1.format(new Date()));
		pr.setIsActive(1);
		return dao.TestDocContentSubmit(pr);
	}
	@Override
	public Object[] GetTestContent(String initiationid, String ProjectId) throws Exception {
	
		return dao.GetTestContent(initiationid, ProjectId);
	}
	@Override
	public List<Object[]> GetTestContentList(String initiationid, String ProjectId) throws Exception {
		return dao.GetTestContentList(initiationid, ProjectId);
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
			re.setFileName(re.getProjectId()+"_"+re.getInitiationId()+"_"+re.getFile().getOriginalFilename());
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
	public List<Object[]> GetAcceptanceTestingList(String initiationid, String ProjectId) throws Exception {
		return dao.GetAcceptanceTestingList(initiationid, ProjectId);
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
	public Object[] AcceptanceTestingExcelData(String initiationId,String projectId) throws Exception {
		return dao.AcceptanceTestingExcelData(initiationId,projectId);
	}
	
	@Override
	public long addAbbreviations(List<Abbreviations> iaList) throws Exception {
		// TODO Auto-generated method stub
		return dao.addAbbreviations(iaList);
	}

}
