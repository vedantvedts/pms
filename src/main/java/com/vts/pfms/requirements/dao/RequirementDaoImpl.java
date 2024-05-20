package com.vts.pfms.requirements.dao;

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

import com.vts.pfms.project.dao.ProjectDaoImpl;
import com.vts.pfms.project.model.PfmsInititationRequirement;
import com.vts.pfms.project.model.RequirementSummary;
import com.vts.pfms.requirements.model.Abbreviations;
import com.vts.pfms.requirements.model.DocMembers;
import com.vts.pfms.requirements.model.ReqDoc;
import com.vts.pfms.requirements.model.RequirementInitiation;
import com.vts.pfms.requirements.model.RequirementsTrans;
import com.vts.pfms.requirements.model.TestAcceptance;
import com.vts.pfms.requirements.model.TestApproach;
import com.vts.pfms.requirements.model.TestPlanSummary;
import com.vts.pfms.requirements.model.TestScopeIntro;

@Transactional
@Repository
public class RequirementDaoImpl implements RequirementDao {
	private static final Logger logger=LogManager.getLogger(RequirementDaoImpl.class);
	java.util.Date loggerdate=new java.util.Date();

	@PersistenceContext
	EntityManager manager;


	private static final String REQLIST="SELECT a.InitiationReqId, a.requirementid,a.reqtypeid,a.requirementbrief,a.requirementdesc,a.priority,a.needtype,a.remarks,a.category,a.constraints,a.linkedrequirements,a.linkedDocuments,a.linkedPara,'0',a.ReqMainId,a.ParentId,a.Demonstration,a.Test,a.Analysis,a.Inspection,a.SpecialMethods,a.Criticality FROM pfms_initiation_req a WHERE ReqInitiationId=:ReqInitiationId AND isActive='1' ORDER BY ReqMainId";
	@Override
	public List<Object[]> RequirementList(String reqInitiationId) throws Exception {
		// TODO Auto-generated method stub
		Query query=manager.createNativeQuery(REQLIST);
		query.setParameter("ReqInitiationId", reqInitiationId);
		List<Object[]> RequirementList=(List<Object[]> )query.getResultList();	
		return RequirementList;
	}

	private static final String ABBREVIATIONS="SELECT AbbreviationsId,Abbreviations,Meaning FROM pfms_abbreviations WHERE InitiationId =:InitiationId AND  ProjectId=:ProjectId and AbbreviationType='T'";		
	@Override
	public List<Object[]> AbbreviationDetails(String initiationId, String projectId) throws Exception {
		Query query = manager.createNativeQuery(ABBREVIATIONS);
		query.setParameter("InitiationId", initiationId);
		query.setParameter("ProjectId", projectId);
		return (List<Object[]>)query.getResultList();
	}
	@Override
	public long addAbbreviations(List<Abbreviations> iaList) throws Exception {
		Long l=0l;
		for(Abbreviations ia:iaList) {
			manager.persist(ia);
			l++;
		}
		return l;
	}
	@Override
	public long AddreqMembers(DocMembers r) throws Exception {

		manager.persist(r);
		manager.flush();

		return r.getMemeberId();
	}
	private static final String DOCMEMLIST = " SELECT a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname' ,b.designation,a.labcode,b.desigid FROM employee a,employee_desig b,pfms_doc_members c WHERE a.isactive='1' AND a.DesigId=b.DesigId AND  a.empid = c.empid AND c.initiationid =:initiationid AND ProjectId=:ProjectId AND MemeberType= 'T' AND c.isactive =1 ORDER BY b.desigid ASC";

	@Override
	public List<Object[]> DocMemberList(String initiationid, String ProjectId) throws Exception {

		Query query = manager.createNativeQuery(DOCMEMLIST);
		query.setParameter("initiationid", initiationid);
		query.setParameter("ProjectId", ProjectId);
		return (List<Object[]>)query.getResultList();
	}
	private static final String TESTINTRO="SELECT InitiationId,Introduction,SystemIdentification,SystemOverview FROM pfms_test_scope_intro WHERE initiationid=:initiationid AND ProjectId=:ProjectId AND isactive=1";
	@Override
	public Object[] TestScopeIntro(String initiationid, String ProjectId) throws Exception {
		Query query=manager.createNativeQuery(TESTINTRO);
		query.setParameter("initiationid", initiationid);
		query.setParameter("ProjectId", ProjectId);
		System.out.println("initiationid"+initiationid);
		System.out.println("ProjectId"+ProjectId);
		Object[]ReqIntro=null;
		try {
			ReqIntro=(Object[])query.getSingleResult();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return ReqIntro;
	}
	@Override
	public long TestScopeIntroSubmit(TestScopeIntro pr) throws Exception {
		manager.persist(pr);
		manager.flush();
		return pr.getIntroId();

	}
	@Override
	public long TestScopeUpdate(TestScopeIntro pr, String details) throws Exception {
		System.out.println(details);
		if(details.equalsIgnoreCase("Introduction")) {
			System.out.println("a");
			String INTROUPDATE="UPDATE pfms_test_scope_intro SET Introduction=:Introduction,ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate WHERE initiationid=:initiationid AND  ProjectId=:projectId";
			Query query=manager.createNativeQuery(INTROUPDATE);
			query.setParameter("Introduction", pr.getIntroduction());
			query.setParameter("ModifiedBy", pr.getModifiedBy());
			query.setParameter("ModifiedDate", pr.getModifiedDate());
			query.setParameter("initiationid", pr.getInitiationId());
			query.setParameter("projectId",pr.getProjectId());
			return query.executeUpdate();

		}else if(details.equalsIgnoreCase("System Identification")) {
			System.out.println("a");
			String BLOCKUPDTE="UPDATE pfms_test_scope_intro SET SystemIdentification=:SystemIdentification, ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate WHERE initiationid=:initiationid AND ProjectId=:projectId";
			Query query=manager.createNativeQuery(BLOCKUPDTE);
			query.setParameter("SystemIdentification", pr.getSystemIdentification());
			query.setParameter("ModifiedBy", pr.getModifiedBy());
			query.setParameter("ModifiedDate", pr.getModifiedDate());
			query.setParameter("initiationid", pr.getInitiationId());
			query.setParameter("projectId",pr.getProjectId());
			return query.executeUpdate();	

		}else if(details.equalsIgnoreCase("System Overview")) {
			System.out.println("a");
			String SYSUPDATE="UPDATE pfms_test_scope_intro SET SystemOverview=:SystemOverview, ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate WHERE initiationid=:initiationid AND ProjectId=:projectId";
			Query query=manager.createNativeQuery(SYSUPDATE);
			query.setParameter("SystemOverview", pr.getSystemOverview());
			query.setParameter("ModifiedBy", pr.getModifiedBy());
			query.setParameter("ModifiedDate", pr.getModifiedDate());
			query.setParameter("initiationid", pr.getInitiationId());
			query.setParameter("projectId",pr.getProjectId());
			return query.executeUpdate();

		}

		return 0;
	}
	@Override
	public long addTestPlanSummary(TestPlanSummary rs) throws Exception {
		manager.persist(rs);
		return rs.getSummaryId();
	}
	private static final String DOCSUMUPD="UPDATE pfms_test_plan_summary SET AdditionalInformation=:AdditionalInformation,Abstract=:Abstract,Keywords=:Keywords,Distribution=:Distribution , reviewer=:reviewer,approver=:approver,ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate WHERE SummaryId=:SummaryId AND isactive='1'";
	@Override
	public long editTestPlanSummary(TestPlanSummary rs) throws Exception {
		Query query = manager.createNativeQuery(DOCSUMUPD);
		query.setParameter("AdditionalInformation", rs.getAdditionalInformation());			
		query.setParameter("Abstract", rs.getAbstract());			
		query.setParameter("Keywords", rs.getKeywords());			
		query.setParameter("Distribution", rs.getDistribution());			
		query.setParameter("reviewer", rs.getReviewer());			
		query.setParameter("approver", rs.getApprover());			
		query.setParameter("ModifiedBy", rs.getModifiedBy());			
		query.setParameter("ModifiedDate", rs.getModifiedDate());			
		query.setParameter("SummaryId", rs.getSummaryId());	


		return query.executeUpdate();
	}
	private static final String DOCSUM="SELECT a.AdditionalInformation,a.Abstract,a.Keywords,a.Distribution,a.reviewer,a.approver,(SELECT CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname)FROM employee e WHERE e.empid=a.approver ) AS 'Approver1',(SELECT CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname)FROM employee e WHERE e.empid=a.reviewer) AS 'Reviewer1',a.summaryid FROM pfms_test_plan_summary a WHERE a.InitiationId =:InitiationId AND ProjectId =:ProjectId AND a.isactive='1'";
	@Override
	public List<Object[]> getTestPlanDocumentSummary(String initiationid, String ProjectId) throws Exception {

		Query query = manager.createNativeQuery(DOCSUM);
		query.setParameter("InitiationId", initiationid);
		query.setParameter("ProjectId", ProjectId);
		List<Object[]>DocumentSummary=(List<Object[]>)query.getResultList();

		return DocumentSummary;
	}

	/*
	 * @Override public long addTestApproch(TestApproach pr) throws Exception {
	 * manager.persist(pr); manager.flush(); return pr.getTestApproachId();
	 * 
	 * }
	 */
	/*
	 * private static final String
	 * TESTAPPROACH="UPDATE pfms_test_plan_approach SET TestApproach=:TestApproach,ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate WHERE TestApproachId=:TestApproachId AND isactive='1'"
	 * ;
	 * 
	 * @Override public long editTestApproach(TestApproach rs) throws Exception {
	 * Query query = manager.createNativeQuery(TESTAPPROACH);
	 * query.setParameter("TestApproach", rs.getTestApproach());
	 * query.setParameter("ModifiedBy", rs.getModifiedBy());
	 * query.setParameter("ModifiedDate", rs.getModifiedDate());
	 * query.setParameter("TestApproachId", rs.getTestApproachId()); return
	 * query.executeUpdate(); }
	 */
	private static final String GETTESTAPPROACH="SELECT a.TestId,a.PointDetails FROM pfms_test_plan_contents a WHERE a.InitiationId =:InitiationId AND ProjectId =:ProjectId AND a.isactive='1' ";
	@Override
	public List<Object[]> getApproach(String initiationid, String ProjectId) throws Exception {

		Query query = manager.createNativeQuery(GETTESTAPPROACH);
		query.setParameter("InitiationId", initiationid);
		query.setParameter("ProjectId", ProjectId);
		List<Object[]>DocumentSummary=(List<Object[]>)query.getResultList();
		return DocumentSummary;
	}
	@Override
	public long TestDocContentSubmit(TestApproach pr) throws Exception {
		manager.persist(pr);
		manager.flush();
		return pr.getTestId();

	}
	@Override
	public long addTestApproch(TestApproach rs) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public long editTestApproach(TestApproach rs) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	private static final String TESTCONTENT="SELECT PointName,PointDetails FROM pfms_test_plan_contents WHERE initiationid=:initiationid AND ProjectId=:ProjectId AND isactive=1";
	@Override
	public Object[] GetTestContent(String initiationid, String ProjectId) throws Exception {
		Query query=manager.createNativeQuery(TESTCONTENT);
		query.setParameter("initiationid", initiationid);
		query.setParameter("ProjectId", ProjectId);
		Object[]ReqIntro=null;
		try {
			ReqIntro=(Object[])query.getSingleResult();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return ReqIntro;
	}
	private static final String TESTCONTENTLIST="SELECT PointName,PointDetails,TestId FROM pfms_test_plan_contents WHERE initiationid=:InitiationId AND ProjectId=:ProjectId AND isactive=1";
	@Override
	public List<Object[]> GetTestContentList(String initiationid, String projectId) throws Exception {
		// TODO Auto-generated method stub
		Query query = manager.createNativeQuery(TESTCONTENTLIST);
		query.setParameter("InitiationId", initiationid);
		query.setParameter("ProjectId", projectId);
		List<Object[]>GetContentList=(List<Object[]>)query.getResultList();
		return GetContentList;
	}
	@Override
	public long TestContentUpdate(TestApproach pr, String details) throws Exception {
		String CONTENTUPDATE="UPDATE pfms_test_plan_contents SET PointDetails=:PointDetails, ModifiedBy=:ModifiedBy , ModifiedDate=:ModifiedDate WHERE TestId=:TestId";
		Query query=manager.createNativeQuery(CONTENTUPDATE);
		query.setParameter("TestId", pr.getTestId());
		query.setParameter("PointDetails", pr.getPointDetails());
		query.setParameter("ModifiedBy", pr.getModifiedBy());
		query.setParameter("ModifiedDate", pr.getModifiedDate());

		return query.executeUpdate();
	}
	@Override
	public long TestDocContentUpdate(String initiationid, String projectId, String attributes, String details,
			String userId) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public long TestDocContentUpdate(TestApproach pr, String attributes) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public long insertTestAcceptanceFile(TestAcceptance re) throws Exception {
		manager.persist(re);
		manager.flush();
		return re.getTestId();
	}
	private static final String ACCEPTANCETESTING="SELECT TestId,Attributes,AttributesDetailas,FileName,FilePath FROM pfms_test_plan_acceptance WHERE initiationid=:InitiationId AND ProjectId=:ProjectId AND isactive=1";
	@Override
	public List<Object[]> GetAcceptanceTestingList(String initiationid, String projectId) throws Exception {
		// TODO Auto-generated method stub
		Query query = manager.createNativeQuery(ACCEPTANCETESTING);
		query.setParameter("InitiationId", initiationid);
		query.setParameter("ProjectId", projectId);
		List<Object[]>GetContentList=(List<Object[]>)query.getResultList();
		return GetContentList;
	}

	@Override
	public long AcceptanceUpdate(TestAcceptance pr, String details) throws Exception {
		String fileName = pr.getFileName();
		System.out.println("filename"+fileName);
		String INTROUPDATE="UPDATE pfms_test_plan_acceptance SET AttributesDetailas=:AttributesDetailas, FileName=:FileName,ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate WHERE TestId=:TestId  ";
		Query query=manager.createNativeQuery(INTROUPDATE);
		query.setParameter("AttributesDetailas", pr.getAttributesDetailas());
		query.setParameter("FileName", fileName);
		query.setParameter("ModifiedBy", pr.getModifiedBy());
		query.setParameter("ModifiedDate", pr.getModifiedDate());
		query.setParameter("TestId", pr.getTestId());
		return query.executeUpdate();
	}

	private static final String ACCEPETANCEDATA  ="SELECT TestId,Attributes,AttributesDetailas,FileName,FilePath FROM pfms_test_plan_acceptance WHERE TestId=:TestId";
	@Override
	public Object[] AcceptanceTestingList(String Testid) throws Exception
	{

		Query query=manager.createNativeQuery(ACCEPETANCEDATA);
		query.setParameter("Testid",Testid);
		Object[] ProjectDataSpecsFileData=(Object[])query.getSingleResult();
		return ProjectDataSpecsFileData;
	}
	private static final String EXCELDATA="SELECT TestId,Attributes,AttributesDetailas,FileName,FilePath FROM pfms_test_plan_acceptance WHERE InitiationId =:InitiationId AND ProjectId=:ProjectId AND isactive=1";
	@Override
	public Object[] AcceptanceTestingExcelData(String initiationid,String ProjectId) throws Exception {
		Query query = manager.createNativeQuery(EXCELDATA);
		query.setParameter("InitiationId", initiationid);	
		query.setParameter("ProjectId", ProjectId);
		Object[] result= (Object[])query.getSingleResult();
		return result;
	}


	private final String REQTYPELIST="SELECT RequirementId, ReqName , ReqParentId, ReqCode FROM pfms_req_types a WHERE ReqParentId= '0' AND RequirementId NOT IN (SELECT reqmainid FROM pfms_initiation_req WHERE parentid='0' AND isactive ='1' AND ReqInitiationId=:ReqInitiationId)";
	@Override
	public List<Object[]> requirementTypeList(String reqInitiationId) throws Exception{

		Query query = manager.createNativeQuery(REQTYPELIST);
		query.setParameter("ReqInitiationId", reqInitiationId);

		return (List<Object[]>)query.getResultList();
	}

	private static final String REQUPDATE = "UPDATE pfms_initiation_req SET RequirementDesc=:RequirementDesc,modifiedby=:modifiedby,modifieddate=:modifieddate,priority=:priority,NeedType=:needtype WHERE initiationreqid=:initiationreqid AND isActive=1";
	@Override
	public long RequirementUpdate(PfmsInititationRequirement pir) throws Exception {

		Query query = manager.createNativeQuery(REQUPDATE);
		query.setParameter("RequirementDesc",pir.getRequirementDesc() );
		query.setParameter("modifiedby",pir.getModifiedBy() );
		query.setParameter("modifieddate", pir.getModifiedDate());
		query.setParameter("priority", pir.getPriority());
		query.setParameter("needtype", pir.getNeedType());
		query.setParameter("initiationreqid", pir.getInitiationReqId());
		return query.executeUpdate();
	}

	private static final String REQMAINLIST="SELECT RequirementId,ReqName,ReqParentId,ReqCode FROM pfms_req_types WHERE RequirementId =:reqMainId UNION SELECT RequirementId,ReqName,ReqParentId,ReqCode FROM pfms_req_types WHERE ReqParentId =:reqMainId";
	@Override
	public List<Object[]> getReqMainList(String reqMainId) throws Exception {
		Query query = manager.createNativeQuery(REQMAINLIST);
		query.setParameter("reqMainId", reqMainId);

		return (List<Object[]>)query.getResultList();
	}
	private static final String REQTYPE="SELECT InitiationReqId,RequirementId FROM pfms_initiation_req WHERE ReqMainId =:reqMainId AND ParentId =:initiationReqId AND isactive='1'";
	@Override
	public List<Object[]> getreqTypeList(String reqMainId, String initiationReqId) throws Exception {

		Query query = manager.createNativeQuery(REQTYPE);
		query.setParameter("reqMainId", reqMainId);
		query.setParameter("initiationReqId", initiationReqId);

		List<Object[]>getreqTypeList = new ArrayList<>();
		try {
			getreqTypeList=(List<Object[]>)query.getResultList();
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		return getreqTypeList;
	}

	private static final String METHODLIST="SELECT a.VerificationDataId,b.VerificationMasterId,b.VerificationName,a.TypeofTest,a.Purpose FROM pfms_initiation_verification_data a,pfms_initiation_verification_master b WHERE a.VerificationMasterId=b.VerificationMasterId AND a.IsActive='1'";
	@Override
	public List<Object[]> getVerificationMethodList() throws Exception {
		try {
			Query query = manager.createNativeQuery(METHODLIST);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}

	private static final String PARADETAILSMAIN="SELECT paraid,sqrid,'0',parano,paradetails FROM pfms_initiation_sqr_para WHERE ReqInitiationId=:ReqInitiationId AND isactive=1";
	@Override
	public List<Object[]> getProjectParaDetails(String reqInitiationId) throws Exception {

		Query query = manager.createNativeQuery(PARADETAILSMAIN);
		query.setParameter("ReqInitiationId", reqInitiationId);
		List<Object[]>list= new ArrayList<>();
		try {
			list = (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	private static final String VERIFICATIONLIST="select VerificationId,Provisions,ReqInitiationId,ProvisionsDetails from pfms_initiation_verification where ReqInitiationId=:ReqInitiationId and isactive='1'";
	@Override
	public List<Object[]> getVerifications(String reqInitiationId) throws Exception {

		Query query=manager.createNativeQuery(VERIFICATIONLIST);
		query.setParameter("ReqInitiationId", reqInitiationId);
		List<Object[]> verificationList=(List<Object[]>)query.getResultList();
		return verificationList;
	}

	private static final String REQEDITDATA="UPDATE pfms_initiation_req SET requirementdesc=:requirementdesc,priority=:priority,needtype=:needtype,remarks=:remarks,Constraints=:Constraints,linkedPara=:linkedPara,Demonstration=:Demonstration,Test=:Test,Analysis=:Analysis,Inspection=:Inspection,SpecialMethods=:SpecialMethods,criticality=:criticality,ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate WHERE InitiationReqId=:InitiationReqId";
	@Override
	public long UpdatePfmsInititationRequirement(PfmsInititationRequirement pir) throws Exception {
		Query query=manager.createNativeQuery(REQEDITDATA);
		query.setParameter("requirementdesc",pir.getRequirementDesc());
		query.setParameter("priority",pir.getPriority());
		query.setParameter("needtype",pir.getNeedType());
		query.setParameter("remarks",pir.getRemarks());
		query.setParameter("Constraints",pir.getConstraints());
		query.setParameter("linkedPara",pir.getLinkedPara());
		query.setParameter("Demonstration",pir.getDemonstration());
		query.setParameter("Test",pir.getTest());
		query.setParameter("Analysis",pir.getAnalysis());
		query.setParameter("Inspection",pir.getInspection());
		query.setParameter("SpecialMethods",pir.getSpecialMethods());
		query.setParameter("criticality",pir.getCriticality());
		query.setParameter("ModifiedBy",pir.getModifiedBy());
		query.setParameter("ModifiedDate",pir.getModifiedDate());
		query.setParameter("InitiationReqId",pir.getInitiationReqId());
		return query.executeUpdate();
	}
	private static final String APPDOCDATA="SELECT docid,DocumentName FROM project_req_doc WHERE docid NOT IN  (SELECT docid FROM pfms_req_initiation_linkeddocs WHERE ReqInitiationId=:ReqInitiationId AND isactive='1')";
	@Override
	public List<Object[]> ApplicableDocumentList(String reqInitiationId) throws Exception {
		// TODO Auto-generated method stub
		Query query=manager.createNativeQuery(APPDOCDATA);
		query.setParameter("ReqInitiationId",reqInitiationId);
		return (List<Object[]>)query.getResultList();
	}
	private static final String APPDOCDATAS="SELECT a.LinkedId,b.DocumentName FROM pfms_req_initiation_linkeddocs a , project_req_doc b WHERE a.ReqInitiationId=:ReqInitiationId AND a.docid=b.docId AND isactive='1'";
	@Override
	public List<Object[]> ApplicableTotalDocumentList(String reqInitiationId) throws Exception {
		Query query=manager.createNativeQuery(APPDOCDATAS);
		query.setParameter("ReqInitiationId",reqInitiationId);
		return (List<Object[]>)query.getResultList();
	}

	@Override
	public long addDocs(List<ReqDoc> list) throws Exception {

		long count=0;
		for(ReqDoc rc:list) {
			manager.persist(rc);
			manager.flush();
			count++;
		}

		return count;
	}

	private static final String PRODUCTTREELISTBYPROJECTID = "SELECT a.MainId,a.SubLevelId,a.levelname FROM pfms_product_tree a,project_master b WHERE a.MainId>0 AND a.ProjectId=b.ProjectId AND b.ProjectId=:ProjectId AND a.IsActive='1' ORDER BY a.SubLevelId";
	@Override
	public List<Object[]> productTreeListByProjectId(String projectId)throws Exception
	{
		try {
			Query query=manager.createNativeQuery(PRODUCTTREELISTBYPROJECTID);
			query.setParameter("ProjectId", projectId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}

	}

	private static final String INITIATIONREQLIST = "SELECT a.ReqInitiationId,a.ProjectId,a.InitiationId,a.ProductTreeMainId,a.InitiatedBy,a.InitiatedDate,b.EmpName,c.Designation,a.ReqVersion,d.ReqStatusCode,d.ReqStatus,d.ReqStatusColor FROM pfms_req_initiation a,employee b,employee_desig c,pfms_req_approval_status d WHERE a.IsActive=1 AND a.InitiatedBy=b.EmpId AND b.DesigId=c.DesigId AND a.ReqStatusCode=d.ReqStatusCode AND a.ProjectId=:ProjectId AND a.ProductTreeMainId=:ProductTreeMainId AND a.InitiationId=:InitiationId ORDER BY a.ReqInitiationId DESC";
	@Override
	public List<Object[]> initiationReqList(String projectId, String mainId, String initiationId)throws Exception
	{
		try {
			Query query=manager.createNativeQuery(INITIATIONREQLIST);
			query.setParameter("ProjectId", projectId);
			query.setParameter("ProductTreeMainId", mainId);
			query.setParameter("InitiationId", initiationId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}

	}

	private static final String GETPREPROJECTLIST = "SELECT a.InitiationId,a.ProjectProgramme,a.ProjectShortName,a.ProjectTitle FROM pfms_initiation a WHERE a.IsActive AND a.LabCode=:LabCode AND (CASE WHEN :LoginType IN ('A','Z','E','L') THEN 1=1 ELSE a.EmpId=:EmpId END)";
	@Override
	public List<Object[]> getPreProjectList(String loginType,String labcode, String empId) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETPREPROJECTLIST);
			query.setParameter("LoginType", loginType);
			query.setParameter("LabCode", labcode);
			query.setParameter("EmpId", empId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getPreProjectList "+e);
			return new ArrayList<>();
		}
	}
	
	@Override
	public long addRequirementInitiation(RequirementInitiation requirementInitiation) throws Exception {
		try {
			manager.persist(requirementInitiation);
			manager.flush();
			return requirementInitiation.getReqInitiationId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addRequirementInitiation "+e);
			return 0L;
		}
	}
	
	@Override
	public RequirementInitiation getRequirementInitiationById(String reqInitiationId) throws Exception{
		try {
			return manager.find(RequirementInitiation.class, Long.parseLong(reqInitiationId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getRequirementInitiationById "+e);
			return null;
		}
	}

	@Override
	public PfmsInititationRequirement getPfmsInititationRequirementById(String InitiationReqId) throws Exception{
		try {
			return manager.find(PfmsInititationRequirement.class, Long.parseLong(InitiationReqId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getPfmsInititationRequirementById "+e);
			return null;
		}
	}
	
	@Override
	public Long addOrUpdatePfmsInititationRequirement(PfmsInititationRequirement pfmsInititationRequirement) throws Exception{
		try {
			manager.persist(pfmsInititationRequirement);
			manager.flush();
			return pfmsInititationRequirement.getInitiationReqId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addOrUpdatePfmsInititationRequirement "+e);
			return 0L;
		}
	}
	
	private static final String ROADMAPTRANSLIST = "SELECT a.ReqInitiationTransId,c.EmpNo,c.EmpName,d.Designation,a.ActionDate,a.Remarks,b.ReqStatus,b.ReqStatusColor FROM pfms_req_trans a,pfms_req_approval_status b,employee c,employee_desig d,pfms_req_initiation e WHERE e.ReqInitiationId = a.ReqInitiationId AND a.ReqStatusCode = b.ReqStatusCode AND a.ActionBy=c.EmpId AND c.DesigId = d.DesigId AND e.ReqInitiationId=:ReqInitiationId ORDER BY a.ReqInitiationTransId DESC";
	@Override
	public List<Object[]> projectRequirementTransList(String reqInitiationId) throws Exception {

		try {
			Query query = manager.createNativeQuery(ROADMAPTRANSLIST);
			query.setParameter("ReqInitiationId",reqInitiationId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			logger.info(new Date()+"Inside DAO projectRequirementTransList "+e);
			e.printStackTrace();
			return null;
		}

	}

	@Override
	public long addRequirementTransaction(RequirementsTrans transaction) throws Exception {
		try {
			manager.persist(transaction);
			manager.flush();
			return transaction.getReqInitiationTransId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addRequirementTransaction "+e);
			return 0L;
		}
	}

	@Override
	public RequirementSummary getRequirementSummaryByReqInitiationId(String reqInitiationId) throws Exception{
		try {
			return manager.find(RequirementSummary.class, Long.parseLong(reqInitiationId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getRequirementSummaryByReqInitiationId "+e);
			return null;
		}
	}

	private static final String PROJECTREQUIREMENTPENDINGLIST  ="CALL pfms_req_doc_pending(:EmpId,:LabCode);";
	@Override
	public List<Object[]> projectRequirementPendingList(String empId,String labcode) throws Exception {
		try {			
			Query query= manager.createNativeQuery(PROJECTREQUIREMENTPENDINGLIST);
			query.setParameter("EmpId", Long.parseLong(empId));
			query.setParameter("LabCode", labcode);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO projectRequirementPendingList " + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}

	}

	private static final String PROJECTREQUIREMENTAPPROVEDLIST  ="CALL pfms_req_doc_approved(:EmpId,:FromDate,:ToDate);";
	@Override
	public List<Object[]> projectRequirementApprovedList(String empId, String FromDate, String ToDate) throws Exception {

		try {			
			Query query= manager.createNativeQuery(PROJECTREQUIREMENTAPPROVEDLIST);
			query.setParameter("EmpId", Long.parseLong(empId));
			query.setParameter("FromDate", FromDate);
			query.setParameter("ToDate", ToDate);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO projectRequirementApprovedList " + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}
	
}
