package com.vts.pfms.documents.dao;

import java.math.BigInteger;
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

import com.vts.pfms.documents.model.ICDConnectionInterfaces;
import com.vts.pfms.documents.model.ICDConnectionPurpose;
import com.vts.pfms.documents.model.ICDDocumentConnections;
import com.vts.pfms.documents.model.ICDPurpose;
import com.vts.pfms.documents.model.IGIApplicableDocs;
import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentShortCodes;
import com.vts.pfms.documents.model.IGIDocumentShortCodesLinked;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.IGIInterface;
import com.vts.pfms.documents.model.IGIInterfaceContent;
import com.vts.pfms.documents.model.IGIInterfaceTypes;
import com.vts.pfms.documents.model.IGILogicalInterfaces;
import com.vts.pfms.documents.model.IRSDocumentSpecifications;
import com.vts.pfms.documents.model.PfmsApplicableDocs;
import com.vts.pfms.documents.model.PfmsICDDocument;
import com.vts.pfms.documents.model.PfmsIDDDocument;
import com.vts.pfms.documents.model.PfmsIGIDocument;
import com.vts.pfms.documents.model.PfmsIGITransaction;
import com.vts.pfms.documents.model.PfmsIRSDocument;
import com.vts.pfms.documents.model.StandardDocuments;


@Transactional
@Repository
public class DocumentsDaoImpl implements DocumentsDao{

	
	@PersistenceContext
	EntityManager manager;
	
	
	private static final Logger logger=LogManager.getLogger(DocumentsDaoImpl.class);

	@Override
	public long standardDocumentInsert(StandardDocuments model) throws Exception {
		try {
			manager.persist(model);
			manager.flush();

		} catch (Exception e) {
			logger.error(new Date() +"Inside DAO insertSocDetailsData "+ e);
			e.printStackTrace();
		}
		return model.getStandardDocumentId();
	}
	
	
	private static final String STANDARDDOCUMENTSLIST="SELECT a.StandardDocumentId,a.DocumentName,a.Description,a.FilePath,a.IsActive FROM pfms_standard_documents a ORDER BY a.IsActive DESC";
	@Override
	public List<Object[]> standardDocumentsList() throws Exception {
		try {
			Query query=manager.createNativeQuery(STANDARDDOCUMENTSLIST);
			return (List<Object[]>)query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	private static final String STANDARDATTCHMENTDATA="SELECT a.DocumentName,a.FilePath,a.Description FROM pfms_standard_documents a WHERE a.StandardDocumentId=:standardDocumentId";
	@Override
	public Object[] standardattachmentdata(String standardDocumentId) throws Exception {
		logger.info(new Date() + "Inside standardattachmentdata");
		try {
			Query query = manager.createNativeQuery(STANDARDATTCHMENTDATA);
			query.setParameter("standardDocumentId", standardDocumentId);
			Object[] standardattachmentdata = (Object[]) query.getSingleResult();
			return standardattachmentdata;

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl standardattachmentdata", e);
			return null;
		}
	}
	
	
	@Override
	public StandardDocuments StandardDocumentDataById(long StandartDocumentId) throws Exception {
		try{
			StandardDocuments standarddocumentdetails=manager.find(StandardDocuments.class, StandartDocumentId);
			return standarddocumentdetails;
		}catch (Exception e){
			logger.error(new Date()  + "Inside DAO StandardDocumentDataById() " + e);
			e.printStackTrace();
			return null;
		}
	}
	
	private static final String STANDARDDOCUMENTDELETE="UPDATE pfms_standard_documents a SET a.IsActive='0' WHERE a.StandardDocumentId=:standardDocumentId";
	@Override
	public long StandardDocumentDelete(long standardDocumentId) throws Exception {
		try {
			Query query =manager.createNativeQuery(STANDARDDOCUMENTDELETE);
			query.setParameter("standardDocumentId", standardDocumentId);
			return query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	/* ************************************************ IGI Document ***************************************************** */
	
	private static final String IGIDOCUMENTLIST="SELECT a.IGIDocId, a.IGIVersion, a.LabCode, a.InitiatedBy, a.InitiatedDate, a.IGIStatusCode, a.IGIStatusCodeNext, a.CreatedBy, a.CreatedDate, a.Remarks, \r\n"
			+ "CONCAT(IFNULL(CONCAT(b.Title,' '),(IFNULL(CONCAT(b.Salutation, ' '), ''))), b.EmpName) AS 'EmpName', c.Designation, d.ReqStatus, d.ReqStatusColor \r\n"
			+ "FROM pfms_igi_document a JOIN employee b ON a.InitiatedBy=b.EmpId LEFT JOIN employee_desig c ON b.DesigId=c.DesigId LEFT JOIN pfms_req_approval_status d ON a.IGIStatusCode=d.ReqStatusCode WHERE a.IsActive=1  ORDER BY a.IGIDocId DESC";
	@Override
	public List<Object[]> getIGIDocumentList() throws Exception {
		try {
			Query query=manager.createNativeQuery(IGIDOCUMENTLIST);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
	@Override
	public long addPfmsIGIDocument(PfmsIGIDocument  pfmsIgiDocument) throws Exception
	{
		try {
		    manager.persist(pfmsIgiDocument);
		    manager.flush();
			return pfmsIgiDocument.getIGIDocId();
		}
		catch (Exception e) {
			logger.error(new Date()  + " Inside DocumentsDAOImpl addPfmsIgiDocument " + e);
			e.printStackTrace();
			return 0 ;
		}
	}

	private static final String IGIDOCUMENTSUMMARYlIST="SELECT a.SummaryId, a.AdditionalInformation, a.Abstract, a.Keywords, a.Distribution, a.Reviewer, a.Approver, a.PreparedBy,\r\n"
			+ " CONCAT(IFNULL(CONCAT(e1.Title,' '),(IFNULL(CONCAT(e1.Salutation, ' '), ''))), e1.EmpName, ', ', d1.Designation) AS 'Approver1', \r\n"
			+ " CONCAT(IFNULL(CONCAT(e2.Title,' '),(IFNULL(CONCAT(e2.Salutation, ' '), ''))), e2.EmpName, ', ', d2.Designation) AS 'Reviewer1', \r\n"
			+ " CONCAT(IFNULL(CONCAT(e3.Title,' '),(IFNULL(CONCAT(e3.Salutation, ' '), ''))), e3.EmpName, ', ', d3.Designation) AS 'PreparedBy1', a.ReleaseDate \r\n"
			+ "FROM pfms_igi_document_summary a LEFT JOIN employee e1 ON e1.EmpId = a.Approver LEFT JOIN employee_desig d1 ON d1.DesigId = e1.DesigId LEFT JOIN employee e2 ON e2.EmpId = a.Reviewer LEFT JOIN employee_desig d2 ON d2.DesigId = e2.DesigId LEFT JOIN employee e3 ON e3.EmpId = a.PreparedBy LEFT JOIN employee_desig d3 ON d3.DesigId = e3.DesigId \r\n"
			+ "WHERE a.IsActive = 1 AND a.DocId=:DocId AND a.DocType=:DocType";
	@Override
	public List<Object[]> getDocumentSummaryList(String docId, String docType) throws Exception {
		try {
			Query query=manager.createNativeQuery(IGIDOCUMENTSUMMARYlIST);
			query.setParameter("DocId", docId);
			query.setParameter("DocType", docType);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
   @Override
	public IGIDocumentSummary getIGIDocumentSummaryById(String summaryId) throws Exception {
		try {
			
			return manager.find(IGIDocumentSummary.class, Long.parseLong(summaryId)) ;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DocumentsDAOImpl getIgiDocumentSummaryById "+e);
			return null;
		}
	}
   
	@Override
	public long addIGIDocumentSummary(IGIDocumentSummary rs) throws Exception {
		try {
			manager.persist(rs);
			manager.flush();
			return rs.getSummaryId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String IGIDOCUMENTMEMBERLIST = "SELECT a.empid, CONCAT(IFNULL(CONCAT(a.Title,' '),(IFNULL(CONCAT(a.Salutation, ' '), ''))), a.EmpName) AS 'EmpName',b.Designation,a.LabCode,b.DesigId,c.IGIMemeberId FROM employee a,employee_desig b,pfms_igi_document_members c WHERE a.isactive='1' AND a.DesigId=b.DesigId AND a.EmpId = c.EmpId AND c.DocId =:DocId AND c.DocType=:DocType AND c.IsActive =1 ORDER BY b.DesigId";
	@Override
	public List<Object[]> getDocumentMemberList(String docId, String docType) throws Exception {
		try {
			Query query=manager.createNativeQuery(IGIDOCUMENTMEMBERLIST);
			query.setParameter("DocId", docId);
			query.setParameter("DocType", docType);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
	private static final String DOCEMPLISTBYIGIDOCID="SELECT a.EmpId, CONCAT(IFNULL(CONCAT(a.Title,' '),(IFNULL(CONCAT(a.Salutation, ' '), ''))), a.EmpName) AS 'EmpName', b.Designation FROM employee a,employee_desig b WHERE a.IsActive='1' AND a.DesigId=b.DesigId AND a.LabCode=:LabCode AND EmpId NOT IN (SELECT empid FROM pfms_igi_document_members WHERE DocId =:DocId AND DocType=:DocType AND IsActive = 1)ORDER BY a.SrNo=0,a.SrNo";
	@Override
	public List<Object[]> getDocmployeeListByDocId(String labCode, String docId, String docType) throws Exception {
		try {
			Query query=manager.createNativeQuery(DOCEMPLISTBYIGIDOCID);
			query.setParameter("LabCode", labCode);
			query.setParameter("DocId", docId);
			query.setParameter("DocType", docType);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
	@Override
	public long addIGIDocumentMembers(IGIDocumentMembers igiDocumentMember) throws Exception {
		try {
			manager.persist(igiDocumentMember);
			manager.flush();
			return igiDocumentMember.getIGIMemeberId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public IGIDocumentMembers getIGIDocumentMembersById(Long igiMemeberId) throws Exception
	{
		try {
			return manager.find(IGIDocumentMembers.class, igiMemeberId);
		}catch (Exception e) {
			logger.error(new Date() + "Inside DocumentsDAOImpl getIGIDocumentMembersById "+e);
			e.printStackTrace();
			return null;
		}
	}

	private static final String DELETEIGIDOCUMENTMEMBERBYID = "UPDATE pfms_igi_document_members SET IsActive=0 WHERE IgiMemeberId=:IgiMemeberId";
	@Override
	public int deleteIGIDocumentMembers(String igiMemeberId) throws Exception {
		try {
			Query query=manager.createNativeQuery(DELETEIGIDOCUMENTMEMBERBYID);
			query.setParameter("IgiMemeberId", igiMemeberId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public long addIGIInterface(IGIInterface igiInterface) throws Exception {
		try {
			manager.persist(igiInterface);
			manager.flush();
			return igiInterface.getInterfaceId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public List<IGIInterface> getIGIInterfaceListByLabCode(String labCode) throws Exception {
		try {
			Query query = manager.createQuery("FROM IGIInterface WHERE LabCode = :LabCode");
			query.setParameter("LabCode", labCode);
			return (List<IGIInterface>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<IGIInterface>();
		}
	}

	@Override
	public PfmsIGIDocument getPfmsIGIDocumentById(String igiDocId) throws Exception {
		try {
			return manager.find(PfmsIGIDocument.class, Long.parseLong(igiDocId));
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public IGIInterface getIGIInterfaceById(String interfaceId) throws Exception {
		try {
			return manager.find(IGIInterface.class, Long.parseLong(interfaceId));
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static final String DUPLICATEINTERFACECODECOUNT = "SELECT COUNT(InterfaceId) AS 'Count' FROM pfms_igi_interfaces WHERE CASE WHEN InterfaceId<>0 THEN InterfaceId!=:InterfaceId END AND InterfaceCode=:InterfaceCode AND IsActive=1";
	@Override
	public BigInteger getDuplicateInterfaceCodeCount(String interfaceId,String interfaceCode) throws Exception {

		try {
			Query query =manager.createNativeQuery(DUPLICATEINTERFACECODECOUNT);
			query.setParameter("InterfaceId", interfaceId);
			query.setParameter("InterfaceCode", interfaceCode);
			return (BigInteger)query.getSingleResult();
		}catch (Exception e) {
			logger.error(new Date() +" Inside DocumentsDAOImpl getDuplicateInterfaceCodeCount "+ e);
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<IGIDocumentShortCodes> getIGIDocumentShortCodesList() throws Exception {
		try {
			Query query = manager.createQuery("FROM IGIDocumentShortCodes WHERE IsActive=1 ORDER BY ShortCode");
			return (List<IGIDocumentShortCodes>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<IGIDocumentShortCodes>();
		}
	}
	
	@Override
	public long addIGIDocumentShortCodes(IGIDocumentShortCodes igiDocumentShortCode) throws Exception {
		try {
			manager.persist(igiDocumentShortCode);
			manager.flush();

			return igiDocumentShortCode.getShortCodeId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public List<PfmsApplicableDocs> getPfmsApplicableDocs() throws Exception {
		try {
			Query query = manager.createQuery("FROM PfmsApplicableDocs WHERE IsActive=1");
			return (List<PfmsApplicableDocs>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<PfmsApplicableDocs>();
		}
	}
	
	private static final String GETIGIGAPPLICABLEDOCS = "SELECT a.IGIApplicableDocId, a.ApplicableDocId, b.DocumentName FROM pfms_igi_document_applicabledocs a, pfms_applicable_docs b WHERE a.IsActive=1 AND a.ApplicableDocId=b.ApplicableDocId AND a.DocId=:DocId AND a.DocType = :DocType";
	@Override
	public List<Object[]> getIGIApplicableDocs(String docId, String docType) throws Exception {
		try {
			Query query=manager.createNativeQuery(GETIGIGAPPLICABLEDOCS);
			query.setParameter("DocId", docId);
			query.setParameter("DocType", docType);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
	@Override
	public long addIGIApplicableDocs(IGIApplicableDocs igiApplicableDocs) throws Exception {
		try {
			manager.persist(igiApplicableDocs);
			manager.flush();
			return igiApplicableDocs.getApplicableDocId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	private static final String DELETEIGIAPPLICABLEDOCUMENTBYID = "UPDATE pfms_igi_document_applicabledocs SET IsActive=0 WHERE IGIApplicableDocId=:IGIApplicableDocId";
	@Override
	public int deleteIGIApplicableDocument(String igiApplicableDocId) throws Exception {
		try {
			Query query=manager.createNativeQuery(DELETEIGIAPPLICABLEDOCUMENTBYID);
			query.setParameter("IGIApplicableDocId", igiApplicableDocId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public static final String GETINTERFACETYPECOUNTBYTYPEID = "SELECT COUNT(InterfaceId) AS InterfaceCount FROM pfms_igi_interfaces WHERE IsActive=1 AND InterfaceTypeId=:InterfaceTypeId";
	@Override
	public int getInterfaceTypeCountByinterfaceTypeId(String interfaceTypeId) throws Exception {

		try {
			Query query =manager.createNativeQuery(GETINTERFACETYPECOUNTBYTYPEID);
			query.setParameter("InterfaceTypeId", interfaceTypeId);
			BigInteger maxCount = (BigInteger)query.getSingleResult();
			return maxCount.intValue();
		}catch (Exception e) {
			logger.error(new Date() +" Inside DocumentsDAOImpl getInterfaceCountByType "+ e);
			e.printStackTrace();
			return 0;
		}
	}
	
	public static final String GETINTERFACECONTENTCOUNTBYCONTENTID = "SELECT COUNT(InterfaceId) AS InterfaceCount FROM pfms_igi_interfaces WHERE IsActive=1 AND InterfaceTypeId=:InterfaceTypeId AND InterfaceContentId=:InterfaceContentId";
	@Override
	public int getInterfaceContentCountByinterfaceContentId(String interfaceTypeId, String interfaceContentId) throws Exception {
		
		try {
			Query query =manager.createNativeQuery(GETINTERFACECONTENTCOUNTBYCONTENTID);
			query.setParameter("InterfaceTypeId", interfaceTypeId);
			query.setParameter("InterfaceContentId", interfaceContentId);
			BigInteger maxCount = (BigInteger)query.getSingleResult();
			return maxCount.intValue();
		}catch (Exception e) {
			logger.error(new Date() +" Inside DocumentsDAOImpl getInterfaceCountByType "+ e);
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String GETFIRSTVERSIONIGIDOCID = "SELECT a.IGIDocId FROM pfms_igi_document a WHERE a.IGIVersion='1.0' AND a.IsActive=1 LIMIT 1";
	@Override
	public Long getFirstVersionIGIDocId() throws Exception {
		try {
			Query query = manager.createNativeQuery(GETFIRSTVERSIONIGIDOCID);
			BigInteger count = (BigInteger)query.getSingleResult();
			return count.longValue();
			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DocumentsDAOImpl getFirstVersionIGIDocId " + e);
			e.printStackTrace();
			return 0L;
		}
	}

	@Override
	public long addIGIDocumentShortCodesLinked(IGIDocumentShortCodesLinked igiDocumentShortCodeLinked) throws Exception {
		try {
			manager.persist(igiDocumentShortCodeLinked);
			manager.flush();

			return igiDocumentShortCodeLinked.getShortCodeLinkedId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String GETIGISHORTCODESLINKEDLISTBYTYPE = "SELECT a.ShortCodeId, a.ShortCode, a.FullName, a.ShortCodeType, a.IsActive, b.ShortCodeLinkedId FROM pfms_igi_document_shortcodes a, pfms_igi_document_shortcodes_linked b WHERE b.IsActive=1 AND a.ShortCodeId=b.ShortCodeId AND DocId=:DocId AND DocType=:DocType";
	@Override
	public List<Object[]> getIGIShortCodesLinkedListByType(String docId, String docType) throws Exception {
		try {
			Query query=manager.createNativeQuery(GETIGISHORTCODESLINKEDLISTBYTYPE);
			query.setParameter("DocId", docId);
			query.setParameter("DocType", docType);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}

	private static final String DELETEIGIDOCUMENTSHORTCODESLINKED = "UPDATE pfms_igi_document_shortcodes_linked SET IsActive=0 WHERE ShortCodeLinkedId=:ShortCodeLinkedId";
	@Override
	public int deleteIGIDocumentShortCodesLinked(String shortCodeLinkedId) throws Exception {
		try {
			Query query=manager.createNativeQuery(DELETEIGIDOCUMENTSHORTCODESLINKED);
			query.setParameter("ShortCodeLinkedId", shortCodeLinkedId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public static final String DUPLICATEIGISHORTCODECOUNT = "SELECT COUNT(ShortCodeId) AS 'Count' FROM pfms_igi_document_shortcodes WHERE ShortCode=:ShortCode AND ShortCodeType=:ShortCodeType AND IsActive=1";
	@Override
	public BigInteger getDuplicateIGIShortCodeCount(String shortCode,String shortCodeType) throws Exception {

		try {
			Query query = manager.createNativeQuery(DUPLICATEIGISHORTCODECOUNT);
			query.setParameter("ShortCode", shortCode);
			query.setParameter("ShortCodeType", shortCodeType);
			return (BigInteger)query.getSingleResult();
		}catch (Exception e) {
			logger.error(new Date() +" Inside DocumentsDAOImpl getDuplicateIGIShortCodeCount "+ e);
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public long addApplicableDocs(PfmsApplicableDocs pfmsApplicableDocs) throws Exception {
		try {
			manager.persist(pfmsApplicableDocs);
			manager.flush();

			return pfmsApplicableDocs.getApplicableDocId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	

	private static final String IGIDOCTRANSLIST = "SELECT a.IGITransactionId,c.EmpNo,c.EmpName,d.Designation,a.ActionDate,a.Remarks,b.ReqStatus,b.ReqStatusColor FROM pfms_igi_trans a,pfms_req_approval_status b,employee c,employee_desig d WHERE a.StatusCode = b.ReqStatusCode AND a.ActionBy=c.EmpId AND c.DesigId = d.DesigId AND a.DocId=:DocId AND a.DocType=:DocType ORDER BY a.IGITransactionId";
	@Override
	public List<Object[]> igiTransactionList(String docId, String docType) throws Exception {

		try {
			Query query = manager.createNativeQuery(IGIDOCTRANSLIST);
			query.setParameter("DocId", docId);
			query.setParameter("DocType", docType);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			logger.info(new Date()+"Inside DAO igiTransactionList "+e);
			e.printStackTrace();
			return null;
		}

	}

	@Override
	public List<IGIInterfaceTypes> getIGIInterfaceTypesList() throws Exception {
		try {
			Query query = manager.createQuery("FROM IGIInterfaceTypes ORDER BY InterfaceTypeCode");
			return (List<IGIInterfaceTypes>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<IGIInterfaceTypes>();
		}
	}
	
	@Override
	public List<IGIInterfaceContent> getIGIInterfaceContentList() throws Exception {
		try {
			Query query = manager.createQuery("FROM IGIInterfaceContent ORDER BY InterfaceContentCode");
			return (List<IGIInterfaceContent>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<IGIInterfaceContent>();
		}
	}
	
	private static final String IGIDOCUMENTUSERREVOKE = "UPDATE pfms_igi_document SET IGIStatusCode='REV', IGIStatusCodeNext='FWD' WHERE IGIDocId=:IGIDocId";
	@Override
	public int igiDocumentUserRevoke(String igiDocId) throws Exception {
		try {
			
			Query query = manager.createNativeQuery(IGIDOCUMENTUSERREVOKE);
			query.setParameter("IGIDocId", igiDocId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public List<IGILogicalInterfaces> getIGILogicalInterfaces() throws Exception {
		try {
			Query query = manager.createQuery("FROM IGILogicalInterfaces");
			return (List<IGILogicalInterfaces>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<IGILogicalInterfaces>();
		}
	}
	

	@Override
	public IGILogicalInterfaces getIGILogicalInterfaceById(String logicalInterfaceId) throws Exception {
		try {
			return manager.find(IGILogicalInterfaces.class, Long.parseLong(logicalInterfaceId));
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	

	@Override
	public long addIGILogicalInterfaces(IGILogicalInterfaces igiLogicalInterfaces) throws Exception {
		try {
		    manager.persist(igiLogicalInterfaces);
		    manager.flush();
			return igiLogicalInterfaces.getLogicalInterfaceId();
		}
		catch (Exception e) {
			logger.error(new Date()  + " Inside DocumentsDAOImpl addIGILogicalInterfaces " + e);
			e.printStackTrace();
			return 0 ;
		}
	}
	
	public static final String LOGICALINTERFACECOUNTBYTYPE = "SELECT COUNT(LogicalInterfaceId) AS 'Count' FROM pfms_igi_logical_interfaces WHERE MsgType=:MsgType";
	@Override
	public int getLogicalInterfaceCountByType(String msgType) throws Exception {

		try {
			Query query = manager.createNativeQuery(LOGICALINTERFACECOUNTBYTYPE);
			query.setParameter("MsgType", msgType);
			BigInteger count = (BigInteger)query.getSingleResult();
			return count.intValue();
		}catch (Exception e) {
			logger.error(new Date() +" Inside DocumentsDAOImpl getDuplicateIGIShortCodeCount "+ e);
			e.printStackTrace();
			return 0;
		}
	}
	/* ************************************************ IGI Document End***************************************************** */
	
	/* ************************************************ ICD Document ***************************************************** */
	private static final String ICDDOCUMENTLIST = "SELECT a.ICDDocId, a.ICDVersion, a.LabCode, a.InitiatedBy, a.InitiatedDate, a.ICDStatusCode, a.ICDStatusCodeNext, a.CreatedBy, a.CreatedDate, a.Remarks, \r\n"
			+ "CONCAT(IFNULL(CONCAT(b.Title,' '),(IFNULL(CONCAT(b.Salutation, ' '), ''))), b.EmpName) AS 'EmpName', c.Designation, a.ProjectId, a.InitiationId, d.ReqStatus, d.ReqStatusColor, a.productTreeMainId \r\n"
			+ "FROM pfms_icd_document a JOIN employee b ON a.InitiatedBy=b.EmpId LEFT JOIN employee_desig c ON b.DesigId=c.DesigId LEFT JOIN pfms_req_approval_status d ON a.ICDStatusCode=d.ReqStatusCode WHERE a.IsActive=1 AND a.ProjectId=:ProjectId AND a.InitiationId=:InitiationId AND ProductTreeMainId=:ProductTreeMainId ORDER BY a.ICDDocId DESC";
	@Override
	public List<Object[]> getICDDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception {
		try {
			Query query=manager.createNativeQuery(ICDDOCUMENTLIST);
			query.setParameter("ProjectId", projectId);
			query.setParameter("InitiationId", initiationId);
			query.setParameter("ProductTreeMainId", productTreeMainId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
	@Override
	public long addPfmsICDDocument(PfmsICDDocument  pfmsIGIDocument) throws Exception
	{
		try {
		    manager.persist(pfmsIGIDocument);
		    manager.flush();
			return pfmsIGIDocument.getICDDocId();
		}
		catch (Exception e) {
			logger.error(new Date()  + " Inside DocumentsDAOImpl addPfmsICDDocument " + e);
			e.printStackTrace();
			return 0 ;
		}
	}
	
	@Override
	public PfmsICDDocument getPfmsICDDocumentById(String icdDocId) throws Exception {
		try {
			return manager.find(PfmsICDDocument.class, Long.parseLong(icdDocId));
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}

	private static final String GETFIRSTVERSIONICDDOCID = "SELECT a.ICDDocId FROM pfms_icd_document a WHERE a.InitiationId=:InitiationId AND a.ProjectId=:ProjectId AND ProductTreeMainId=:ProductTreeMainId AND a.ICDVersion='1.0' AND a.IsActive=1 LIMIT 1";
	@Override
	public Long getFirstVersionICDDocId(String projectId, String initiationId, String productTreeMainId) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETFIRSTVERSIONICDDOCID);
			query.setParameter("InitiationId", initiationId);
			query.setParameter("ProjectId", projectId);
			query.setParameter("ProductTreeMainId", productTreeMainId);
			BigInteger count = (BigInteger)query.getSingleResult();
			return count.longValue();
			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DocumentsDAOImpl getFirstVersionICDDocId " + e);
			e.printStackTrace();
			return 0L;
		}
	}
	
	@Override
	public long addICDDocumentConnections(ICDDocumentConnections connection) throws Exception {
		try {
			manager.persist(connection);
			manager.flush();
			
			return connection.getICDConnectionId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String GETICDCONEECTIONSLIST = "SELECT a.ICDConnectionId, a.ICDDocId, a.SubSystemMainIdOne, a.SubSystemMainIdTwo, a.SubSystemOne,  a.SubSystemTwo,  b.InterfaceId,\r\n"
			+ "	'NA' AS InterfaceSeqNo, c.InterfaceCode, c.InterfaceName, h.InterfaceType, c.ParameterData, i.InterfaceContent, c.InterfaceSpeed, \r\n"
			+ "	a.SuperSubSysMainIdOne, a.SuperSubSysMainIdTwo, a.SuperSubSystemOne, a.SuperSubSystemTwo,\r\n"
			+ "	d.LevelName AS 'LevelNameS1', e.LevelName AS 'LevelNameS2', f.LevelName AS 'LevelNameSS1', g.LevelName AS 'LevelNameSS2',\r\n"
			+ "	h.InterfaceTypeId, h.InterfaceTypeCode, h.InterfaceTypeCodeId, i.InterfaceContentId, i.InterfaceContentCode, i.InterfaceContentCodeId, \r\n"
			+ "	(SELECT GROUP_CONCAT(k.Purpose SEPARATOR ', ') FROM pfms_icd_connection_purpose j, pfms_icd_purpose k WHERE a.ICDConnectionId = j.ICDConnectionId AND j.PurposeId = k.PurposeId AND j.IsActive=1) AS Purpose, \r\n"
			+ "	a.Constraints, a.Periodicity, a.Description, b.ConnectionCode, b.ConInterfaceId, a.DrawingNo, a.DrawingAttach, \r\n"
			+ "	(SELECT GROUP_CONCAT(k.PurposeId SEPARATOR ', ') FROM pfms_icd_connection_purpose j, pfms_icd_purpose k WHERE a.ICDConnectionId = j.ICDConnectionId AND j.PurposeId = k.PurposeId AND j.IsActive=1) AS PurposeIds \r\n"
			+ "FROM pfms_icd_document_connections a \r\n"
			+ "JOIN pfms_icd_connection_interfaces b ON a.ICDConnectionId = b.ICDConnectionId AND b.IsActive=1\r\n"
			+ "LEFT JOIN pfms_igi_interfaces c ON b.InterfaceId = c.InterfaceId\r\n"
			+ "LEFT JOIN pfms_product_tree d ON a.SubSystemMainIdOne = d.MainId\r\n"
			+ "LEFT JOIN pfms_product_tree e ON a.SubSystemMainIdTwo = e.MainId\r\n"
			+ "LEFT JOIN pfms_product_tree f ON a.SuperSubSysMainIdOne = f.MainId\r\n"
			+ "LEFT JOIN pfms_product_tree g ON a.SuperSubSysMainIdTwo = g.MainId\r\n"
			+ "LEFT JOIN pfms_igi_interface_types h ON c.InterfaceTypeId = h.InterfaceTypeId\r\n"
			+ "LEFT JOIN pfms_igi_interface_content i ON c.InterfaceTypeId = i.InterfaceContentId\r\n"
			+ "WHERE a.IsActive=1 AND ICDDocId=:ICDDocId";
	@Override
	public List<Object[]> getICDConnectionsList(String icdDocId) throws Exception {
		try {
			Query query=manager.createNativeQuery(GETICDCONEECTIONSLIST);
			query.setParameter("ICDDocId", icdDocId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
	}

	private static final String DELETEICDCONNECTIONBYID = "UPDATE pfms_icd_connection_interfaces SET IsActive=0 WHERE ConInterfaceId=:ConInterfaceId";
	@Override
	public int deleteICDConnectionById(String conInterfaceId) throws Exception {
		try {
			Query query=manager.createNativeQuery(DELETEICDCONNECTIONBYID);
			query.setParameter("ConInterfaceId", conInterfaceId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public long addPfmsIGITransaction(PfmsIGITransaction transaction) throws Exception {
		try {
		    manager.persist(transaction);
		    manager.flush();
			return transaction.getIGITransactionId();
		}
		catch (Exception e) {
			logger.error(new Date()  + " Inside DocumentsDAOImpl addPfmsIGITransaction " + e);
			e.printStackTrace();
			return 0 ;
		}
	}
	
	private static final String PRODUCTTREEALLLIST = "SELECT a.MainId, a.SubLevelId, a.LevelName, a.Stage, a.Module, a.RevisionNo, a.SystemMainId, a.LevelCode, CASE WHEN 0=:ProjectId THEN a.InitiationId ELSE a.ProjectId END AS 'ProjectId', a.ParentLevelId, a.LevelId FROM pfms_product_tree a WHERE a.MainId>0 AND a.ProjectId=:ProjectId AND a.InitiationId=:InitiationId AND a.IsActive='1' ORDER BY a.SubLevelId";
	@Override
	public List<Object[]> getProductTreeAllList(String projectId, String initiationId)throws Exception
	{
		try {
			Query query=manager.createNativeQuery(PRODUCTTREEALLLIST);
			query.setParameter("ProjectId", projectId);
			query.setParameter("InitiationId", initiationId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}

	}
	
	private static final String ICDDOCUMENTUSERREVOKE = "UPDATE pfms_icd_document SET ICDStatusCode='REV', ICDStatusCodeNext='FWD' WHERE ICDDocId=:ICDDocId";
	@Override
	public int icdDocumentUserRevoke(String icdDocId) throws Exception {
		try {
			
			Query query = manager.createNativeQuery(ICDDOCUMENTUSERREVOKE);
			query.setParameter("ICDDocId", icdDocId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public ICDDocumentConnections getICDDocumentConnectionsById(String icdConnectionId) throws Exception {
		try {
			return manager.find(ICDDocumentConnections.class, icdConnectionId!=null?Long.parseLong(icdConnectionId):0);
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public List<ICDPurpose> getAllICDPurposeList() throws Exception {
		try {
			Query query = manager.createQuery("FROM ICDPurpose");
			return (List<ICDPurpose>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<ICDPurpose>();
		}
	}
	
	@Override
	public long addICDConnectionInterfaces(ICDConnectionInterfaces connectioInterfaces) throws Exception {
		try {
		    manager.persist(connectioInterfaces);
		    manager.flush();
			return connectioInterfaces.getConInterfaceId();
		}
		catch (Exception e) {
			logger.error(new Date()  + " Inside DocumentsDAOImpl addICDConnectionInterfaces " + e);
			e.printStackTrace();
			return 0 ;
		}
	}
	
	@Override
	public long addICDConnectionPurpose(ICDConnectionPurpose icdConnectionPurpose) throws Exception {
		try {
			manager.persist(icdConnectionPurpose);
			manager.flush();
			return icdConnectionPurpose.getConPurposeId();
		}
		catch (Exception e) {
			logger.error(new Date()  + " Inside DocumentsDAOImpl addICDConnectionPurpose " + e);
			e.printStackTrace();
			return 0 ;
		}
	}

	public static final String GETICDCONNECTIONSCOUNT = "SELECT COUNT(ConInterfaceId) AS 'ConnectionCount' FROM pfms_icd_document_connections a, pfms_icd_connection_interfaces b WHERE a.ICDConnectionId=b.ICDConnectionId AND a.SubSystemMainIdOne=:SubSystemMainIdOne  AND a.SubSystemMainIdTwo=:SubSystemMainIdTwo AND  a.SuperSubSysMainIdOne=:SuperSubSysMainIdOne AND a.SuperSubSysMainIdTwo=:SuperSubSysMainIdTwo AND a.ICDDocId=:ICDDocId";
	@Override
	public int getICDConnectionsCount(Long subSystemMainIdOne, Long subSystemMainIdTwo, Long superSubSysMainIdOne, 
			Long superSubSysMainIdTwo, Long icdDocId) throws Exception {

		try {
			Query query =manager.createNativeQuery(GETICDCONNECTIONSCOUNT);
			query.setParameter("SubSystemMainIdOne", subSystemMainIdOne);
			query.setParameter("SubSystemMainIdTwo", subSystemMainIdTwo);
			query.setParameter("SuperSubSysMainIdOne", superSubSysMainIdOne);
			query.setParameter("SuperSubSysMainIdTwo", superSubSysMainIdTwo);
			query.setParameter("ICDDocId", icdDocId);
			BigInteger maxCount = (BigInteger)query.getSingleResult();
			return maxCount.intValue();
		}catch (Exception e) {
			logger.error(new Date() +" Inside DocumentsDAOImpl getICDConnectionsCount "+ e);
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String DELETEICDCONNECTIONPURPOSEBYICDCONNECTIONID = "UPDATE pfms_icd_connection_purpose SET IsActive=0 WHERE ICDConnectionId=:ICDConnectionId";
	@Override
	public int deleteICDConnectionPurposeByICDConnectionId(String icdConnectionId) throws Exception {
		try {
			Query query=manager.createNativeQuery(DELETEICDCONNECTIONPURPOSEBYICDCONNECTIONID);
			query.setParameter("ICDConnectionId", icdConnectionId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	/* ************************************************ ICD Document End***************************************************** */
	
	/* ************************************************ IRS Document ***************************************************** */
	
	private static final String IRSDOCUMENTLIST = "SELECT a.IRSDocId, a.IRSVersion, a.LabCode, a.InitiatedBy, a.InitiatedDate, a.IRSStatusCode, a.IRSStatusCodeNext, a.CreatedBy, a.CreatedDate, a.Remarks, \r\n"
			+ "CONCAT(IFNULL(CONCAT(b.Title,' '),(IFNULL(CONCAT(b.Salutation, ' '), ''))), b.EmpName) AS 'EmpName', c.Designation, a.ProjectId, a.InitiationId, d.ReqStatus, d.ReqStatusColor, a.ProductTreeMainId \r\n"
			+ "FROM pfms_irs_document a JOIN employee b ON a.InitiatedBy=b.EmpId LEFT JOIN employee_desig c ON b.DesigId=c.DesigId LEFT JOIN pfms_req_approval_status d ON a.IRSStatusCode=d.ReqStatusCode WHERE a.IsActive=1 AND a.ProjectId=:ProjectId AND a.InitiationId=:InitiationId AND a.ProductTreeMainId=:ProductTreeMainId ORDER BY a.IRSDocId DESC";
	@Override
	public List<Object[]> getIRSDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception {
		try {
			Query query=manager.createNativeQuery(IRSDOCUMENTLIST);
			query.setParameter("ProjectId", projectId);
			query.setParameter("InitiationId", initiationId);
			query.setParameter("ProductTreeMainId", productTreeMainId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
	@Override
	public long addPfmsIRSDocument(PfmsIRSDocument  pfmsIRSDocument) throws Exception
	{
		try {
		    manager.persist(pfmsIRSDocument);
		    manager.flush();
			return pfmsIRSDocument.getIRSDocId();
		}
		catch (Exception e) {
			logger.error(new Date()  + " Inside DocumentsDAOImpl addPfmsIRSDocument " + e);
			e.printStackTrace();
			return 0 ;
		}
	}

	@Override
	public PfmsIRSDocument getPfmsIRSDocumentById(String irsDocId) throws Exception {
		try {
			return manager.find(PfmsIRSDocument.class, Long.parseLong(irsDocId));
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private static final String GETFIRSTVERSIONIRSDOCID = "SELECT a.IRSDocId FROM pfms_irs_document a WHERE a.InitiationId=:InitiationId AND a.ProjectId=:ProjectId AND a.ProductTreeMainId=:ProductTreeMainId AND a.IRSVersion='1.0' AND a.IsActive=1 LIMIT 1";
	@Override
	public Long getFirstVersionIRSDocId(String projectId, String initiationId, String productTreeMainId) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETFIRSTVERSIONIRSDOCID);
			query.setParameter("InitiationId", initiationId);
			query.setParameter("ProjectId", projectId);
			query.setParameter("ProductTreeMainId", productTreeMainId);
			BigInteger count = (BigInteger)query.getSingleResult();
			return count.longValue();
			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DocumentsDAOImpl getFirstVersionIRSDocId " + e);
			e.printStackTrace();
			return 0L;
		}
	}

	@Override
	public long addIRSDocumentSpecifications(IRSDocumentSpecifications irsDocumentSpecifications) throws Exception
	{
		try {
		    manager.persist(irsDocumentSpecifications);
		    manager.flush();
			return irsDocumentSpecifications.getIRSSpecificationId();
		}
		catch (Exception e) {
			logger.error(new Date()  + " Inside DocumentsDAOImpl addIRSDocumentSpecifications " + e);
			e.printStackTrace();
			return 0 ;
		}
	}

	private static final String GETIRSDOCUMENTSPECSLIST = "SELECT a.IRSSpecificationId, a.IRSDocId, a.ConInterfaceId, a.LogicalInterfaceId, a.InfoName, a.ActionAtDest, b.ConnectionCode, c.MsgCode, c.MsgName FROM pfms_irs_document_specifications a, pfms_icd_connection_interfaces b, pfms_igi_logical_interfaces c WHERE a.ConInterfaceId=b.ConInterfaceId AND a.LogicalInterfaceId=c.LogicalInterfaceId AND a.IsActive=1 AND a.IRSDocId=:IRSDocId";
	@Override
	public List<Object[]> getIRSDocumentSpecificationsList(String irsDocId)throws Exception {
		try {
			Query query=manager.createNativeQuery(GETIRSDOCUMENTSPECSLIST);
			query.setParameter("IRSDocId", irsDocId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
		
	}
	
	private static final String DELETEIRSSPECIFICATIONBYID = "UPDATE pfms_irs_document_specifications SET IsActive=0 WHERE IRSSpecificationId=:IRSSpecificationId";
	@Override
	public int deleteIRSSpecifiactionById(String irsSpecificationId) throws Exception {
		try {
			Query query=manager.createNativeQuery(DELETEIRSSPECIFICATIONBYID);
			query.setParameter("IRSSpecificationId", irsSpecificationId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String IRSDOCUMENTUSERREVOKE = "UPDATE pfms_irs_document SET IRSStatusCode='REV', IRSStatusCodeNext='FWD' WHERE IRSDocId=:IRSDocId";
	@Override
	public int irsDocumentUserRevoke(String irsDocId) throws Exception {
		try {
			
			Query query = manager.createNativeQuery(IRSDOCUMENTUSERREVOKE);
			query.setParameter("IRSDocId", irsDocId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String GETDATACARRYINGCONNECTIONS = "SELECT a.ConInterfaceId, a.ICDConnectionId, a.InterfaceId, a.ConnectionCode FROM pfms_icd_connection_interfaces a, pfms_igi_interfaces b, pfms_icd_document_connections d WHERE a.IsActive=1 AND a.InterfaceId=b.InterfaceId AND b.InterfaceContentId IN (SELECT c.InterfaceContentId FROM pfms_igi_interface_content c WHERE c.IsDataCarrying='Y' AND c.IsActive=1) AND a.ICDConnectionId = d.ICDConnectionId AND d.ICDDocId =:ICDDocId";
	@Override
	public List<Object[]> getDataCarryingConnectionList(String icdDocId)throws Exception {
		try {
			Query query=manager.createNativeQuery(GETDATACARRYINGCONNECTIONS);
			query.setParameter("ICDDocId", icdDocId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}

	}

	@Override
	public IRSDocumentSpecifications getIRSDocumentSpecificationsById(String irsSpecificationId) throws Exception {
		try {
			return manager.find(IRSDocumentSpecifications.class, Long.parseLong(irsSpecificationId));
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/* ************************************************ IRS Document End***************************************************** */
	
	/* ************************************************ IDD Document ***************************************************** */
	
	private static final String IDDDOCUMENTLIST = "SELECT a.IDDDocId, a.IDDVersion, a.LabCode, a.InitiatedBy, a.InitiatedDate, a.IDDStatusCode, a.IDDStatusCodeNext, a.CreatedBy, a.CreatedDate, a.Remarks, \r\n"
			+ "CONCAT(IFNULL(CONCAT(b.Title,' '),(IFNULL(CONCAT(b.Salutation, ' '), ''))), b.EmpName) AS 'EmpName', c.Designation, a.ProjectId, a.InitiationId, d.ReqStatus, d.ReqStatusColor, a.ProductTreeMainId \r\n"
			+ "FROM pfms_idd_document a JOIN employee b ON a.InitiatedBy=b.EmpId LEFT JOIN employee_desig c ON b.DesigId=c.DesigId LEFT JOIN pfms_req_approval_status d ON a.IDDStatusCode=d.ReqStatusCode WHERE a.IsActive=1 AND a.ProjectId=:ProjectId AND a.InitiationId=:InitiationId AND a.ProductTreeMainId=:ProductTreeMainId ORDER BY a.IDDDocId DESC";
	@Override
	public List<Object[]> getIDDDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception {
		try {
			Query query=manager.createNativeQuery(IDDDOCUMENTLIST);
			query.setParameter("ProjectId", projectId);
			query.setParameter("InitiationId", initiationId);
			query.setParameter("ProductTreeMainId", productTreeMainId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
	@Override
	public long addPfmsIDDDocument(PfmsIDDDocument  pfmsIDDDocument) throws Exception
	{
		try {
			manager.persist(pfmsIDDDocument);
			manager.flush();
			return pfmsIDDDocument.getIDDDocId();
		}
		catch (Exception e) {
			logger.error(new Date()  + " Inside DocumentsDAOImpl addPfmsIDDDocument " + e);
			e.printStackTrace();
			return 0 ;
		}
	}
	
	
	@Override
	public PfmsIDDDocument getPfmsIDDDocumentById(String irsDocId) throws Exception {
		try {
			return manager.find(PfmsIDDDocument.class, Long.parseLong(irsDocId));
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	private static final String GETFIRSTVERSIONIDDDOCID = "SELECT a.IDDDocId FROM pfms_idd_document a WHERE a.InitiationId=:InitiationId AND a.ProjectId=:ProjectId AND a.ProductTreeMainId=:ProductTreeMainId AND a.IDDVersion='1.0' AND a.IsActive=1 LIMIT 1";
	@Override
	public Long getFirstVersionIDDDocId(String projectId, String initiationId, String productTreeMainId) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETFIRSTVERSIONIDDDOCID);
			query.setParameter("InitiationId", initiationId);
			query.setParameter("ProjectId", projectId);
			query.setParameter("ProductTreeMainId", productTreeMainId);
			BigInteger count = (BigInteger)query.getSingleResult();
			return count.longValue();
			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DocumentsDAOImpl getFirstVersionIDDDocId " + e);
			e.printStackTrace();
			return 0L;
		}
	}
	
	private static final String IDDDOCUMENTUSERREVOKE = "UPDATE pfms_idd_document SET IDDStatusCode='REV', IDDStatusCodeNext='FWD' WHERE IDDDocId=:IDDDocId";
	@Override
	public int iddDocumentUserRevoke(String iddDocId) throws Exception {
		try {
			
			Query query = manager.createNativeQuery(IDDDOCUMENTUSERREVOKE);
			query.setParameter("IDDDocId", iddDocId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
}
