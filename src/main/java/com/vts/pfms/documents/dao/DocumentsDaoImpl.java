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

import com.vts.pfms.documents.model.ICDDocumentConnections;
import com.vts.pfms.documents.model.IGIApplicableDocs;
import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentShortCodes;
import com.vts.pfms.documents.model.IGIDocumentShortCodesLinked;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.IGIInterface;
import com.vts.pfms.documents.model.PfmsApplicableDocs;
import com.vts.pfms.documents.model.PfmsICDDocument;
import com.vts.pfms.documents.model.PfmsIGIDocument;
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
	
	private static final String IGIDOCUMENTLIST="SELECT a.IGIDocId, a.IGIVersion, a.LabCode, a.InitiatedBy, a.InitiatedDate, a.IGIStatusCode, a.IGIStatusCodeNext, a.CreatedBy, a.CreatedDate, a.Remarks, CONCAT(IFNULL(CONCAT(b.Title,' '),(IFNULL(CONCAT(b.Salutation, ' '), ''))), b.EmpName) AS 'EmpName', c.Designation FROM pfms_igi_document a JOIN employee b ON a.InitiatedBy=b.EmpId LEFT JOIN employee_desig c ON b.DesigId=c.DesigId WHERE a.IsActive=1  ORDER BY a.IGIDocId DESC";
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
	
	public static final String GETINTERFACECOUNTBYTYPE = "SELECT COUNT(InterfaceId) AS InterfaceCount FROM pfms_igi_interfaces WHERE IsActive=1 AND InterfaceType=:InterfaceType";
	@Override
	public int getInterfaceCountByType(String interfaceType) throws Exception {

		try {
			Query query =manager.createNativeQuery(GETINTERFACECOUNTBYTYPE);
			query.setParameter("InterfaceType", interfaceType);
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
	
	/* ************************************************ IGI Document End***************************************************** */
	
	/* ************************************************ ICD Document ***************************************************** */
	private static final String ICDDOCUMENTLIST = "SELECT a.ICDDocId, a.ICDVersion, a.LabCode, a.InitiatedBy, a.InitiatedDate, a.ICDStatusCode, a.ICDStatusCodeNext, a.CreatedBy, a.CreatedDate, a.Remarks, CONCAT(IFNULL(CONCAT(b.Title,' '),(IFNULL(CONCAT(b.Salutation, ' '), ''))), b.EmpName) AS 'EmpName', c.Designation, a.ProjectId, a.InitiationId FROM pfms_icd_document a JOIN employee b ON a.InitiatedBy=b.EmpId LEFT JOIN employee_desig c ON b.DesigId=c.DesigId WHERE a.IsActive=1 AND a.ProjectId=:ProjectId AND a.InitiationId=:InitiationId ORDER BY a.ICDDocId DESC";
	@Override
	public List<Object[]> getICDDocumentList(String projectId, String initiationId) throws Exception {
		try {
			Query query=manager.createNativeQuery(ICDDOCUMENTLIST);
			query.setParameter("ProjectId", projectId);
			query.setParameter("InitiationId", initiationId);
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

	private static final String GETFIRSTVERSIONREQINITIATIONID = "SELECT a.ICDDocId FROM pfms_icd_document a WHERE a.InitiationId=:InitiationId AND a.ProjectId=:ProjectId AND a.ICDVersion='1.0' AND a.IsActive=1 LIMIT 1";
	@Override
	public Long getFirstVersionICDDocId(String projectId, String initiationId) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETFIRSTVERSIONREQINITIATIONID);
			query.setParameter("InitiationId", initiationId);
			query.setParameter("ProjectId", projectId);
			BigInteger count = (BigInteger)query.getSingleResult();
			return count.longValue();
			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DocumentsDAOImpl getFirstVersionIGIDocId " + e);
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
	
	private static final String GETICDCONEECTIONSLIST = "SELECT a.ICDConnectionId, a.ICDDocId, a.SubSystemMainIdOne, a.SubSystemMainIdTwo, a.SubSystemOne,  a.SubSystemTwo,  a.InterfaceId,\r\n"
			+ "	b.InterfaceSeqNo, b.InterfaceCode, b.InterfaceName, b.InterfaceType, b.DataType, b.SignalType, b.InterfaceSpeed\r\n"
			+ "FROM pfms_icd_document_connections a LEFT JOIN pfms_igi_interfaces b ON a.InterfaceId=b.InterfaceId\r\n"
			+ "WHERE a.IsActive=1 ORDER BY a.SubSystemMainIdOne, a.SubSystemMainIdTwo";
	@Override
	public List<Object[]> getICDConnectionsList() throws Exception {
		try {
			Query query=manager.createNativeQuery(GETICDCONEECTIONSLIST);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
	}

	private static final String DELETEICDCONNECTIONBYID = "UPDATE pfms_icd_document_connections SET IsActive=0 WHERE ICDConnectionId=:ICDConnectionId";
	@Override
	public int deleteICDConnectionById(String icdConnectionId) throws Exception {
		try {
			Query query=manager.createNativeQuery(DELETEICDCONNECTIONBYID);
			query.setParameter("ICDConnectionId", icdConnectionId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
}
