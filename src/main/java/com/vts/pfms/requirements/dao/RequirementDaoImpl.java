package com.vts.pfms.requirements.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.project.dao.ProjectDaoImpl;
import com.vts.pfms.requirements.model.Abbreviations;
import com.vts.pfms.requirements.model.DocMembers;
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
	
	
	private static final String REQLIST="SELECT a.InitiationReqId, a.requirementid,a.reqtypeid,a.requirementbrief,a.requirementdesc,a.priority,a.needtype,a.remarks,a.category,a.constraints,a.linkedrequirements,a.linkedDocuments,a.linkedPara,a.ProjectId FROM pfms_initiation_req a WHERE initiationid=:initiationid AND ProjectId=:ProjectId AND isActive='1' ORDER BY reqCount";
	@Override
	public List<Object[]> RequirementList(String intiationId,String projectId) throws Exception {
		// TODO Auto-generated method stub
		 Query query=manager.createNativeQuery(REQLIST);
		 query.setParameter("initiationid", intiationId);
		 query.setParameter("ProjectId", projectId);
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
	
}
