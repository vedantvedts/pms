package com.vts.pfms.documents.dao;

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

import com.vts.pfms.documents.model.IGIBasicParameters;
import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.IGIInterface;
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
	
	private static final String IGIDOCUMENTLIST="SELECT a.IGIDocId, a.IGIVersion, a.LabCode, a.InitiatedBy, a.InitiatedDate, a.IGIStatusCode, a.IGIStatusCodeNext, a.CreatedBy, a.CreatedDate, a.Remarks, CONCAT(IFNULL(CONCAT(b.Title,' '),(IFNULL(CONCAT(b.Salutation, ' '), ''))), b.EmpName) AS 'EmpName', c.Designation FROM pfms_igi_document a JOIN employee b ON a.InitiatedBy=b.EmpId LEFT JOIN employee_desig c ON b.DesigId=c.DesigId WHERE a.IsActive=1  ORDER BY a.IGIDocId DESC";
	@Override
	public List<Object[]> IgiDocumentList() throws Exception {
		try {
			Query query=manager.createNativeQuery(IGIDOCUMENTLIST);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
	@Override
	public long addPfmsIgiDocument(PfmsIGIDocument  pfmsIgiDocument) throws Exception
	{
		try {
		    manager.persist(pfmsIgiDocument);
		    manager.flush();
			return pfmsIgiDocument.getIGIDocId();
		}
		catch (Exception e) {
			logger.error(new Date()  + " Inside DAO savePfmsIgiDocument " + e);
			e.printStackTrace();
			return 0 ;
		}
	}

	private static final String IGIDOCUMENTSUMMARYlIST="SELECT a.SummaryId, a.AdditionalInformation, a.Abstract, a.Keywords, a.Distribution, a.Reviewer, a.Approver, a.PreparedBy,\r\n"
			+ " CONCAT(IFNULL(CONCAT(e1.Title,' '),(IFNULL(CONCAT(e1.Salutation, ' '), ''))), e1.EmpName, ', ', d1.Designation) AS 'Approver1', \r\n"
			+ " CONCAT(IFNULL(CONCAT(e2.Title,' '),(IFNULL(CONCAT(e2.Salutation, ' '), ''))), e2.EmpName, ', ', d2.Designation) AS 'Reviewer1', \r\n"
			+ " CONCAT(IFNULL(CONCAT(e3.Title,' '),(IFNULL(CONCAT(e3.Salutation, ' '), ''))), e3.EmpName, ', ', d3.Designation) AS 'PreparedBy1', a.ReleaseDate \r\n"
			+ "FROM pfms_igi_document_summary a LEFT JOIN employee e1 ON e1.EmpId = a.Approver LEFT JOIN employee_desig d1 ON d1.DesigId = e1.DesigId LEFT JOIN employee e2 ON e2.EmpId = a.Reviewer LEFT JOIN employee_desig d2 ON d2.DesigId = e2.DesigId LEFT JOIN employee e3 ON e3.EmpId = a.PreparedBy LEFT JOIN employee_desig d3 ON d3.DesigId = e3.DesigId \r\n"
			+ "WHERE a.IsActive = 1 AND a.IGIDocId=:IGIDocId";
	@Override
	public List<Object[]> igiDocumentSummaryList(String igiDocId) throws Exception {
		try {
			Query query=manager.createNativeQuery(IGIDOCUMENTSUMMARYlIST);
			query.setParameter("IGIDocId", igiDocId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
   @Override
	public IGIDocumentSummary getIgiDocumentSummaryById(String summaryId) throws Exception {
		try {
			
			return manager.find(IGIDocumentSummary.class, Long.parseLong(summaryId)) ;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getIgiDocumentSummaryById "+e);
			return null;
		}
	}
   
	@Override
	public long addIgiDocumentSummary(IGIDocumentSummary rs) throws Exception {
		try {
			manager.persist(rs);
			manager.flush();
			return rs.getSummaryId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	
	private static final String IGIDOCUMENTMEMBERLIST = " SELECT a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname' ,b.designation,a.labcode,b.desigid,c.IgiMemeberId FROM employee a,employee_desig b,pfms_igi_document_members c WHERE a.isactive='1' AND a.DesigId=b.DesigId AND  a.empid = c.empid AND c.IGIDocId =:IGIDocId AND c.IsActive =1 ORDER BY b.desigid ASC";
	@Override
	public List<Object[]> igiDocumentMemberList(String igiDocId) throws Exception {
		try {
			Query query=manager.createNativeQuery(IGIDOCUMENTMEMBERLIST);
			query.setParameter("IGIDocId", igiDocId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
	private static final String DOCEMPLISTBYIGIDOCID="SELECT a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname' ,b.designation FROM employee a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId AND a.LabCode=:LabCode AND empid NOT IN (SELECT empid FROM pfms_igi_document_members WHERE IGIDocId =:IGIDocId AND  isactive = 1)ORDER BY a.srno=0,a.srno";
	@Override
	public List<Object[]> getDocmployeeListByIGIDocId(String labCode, String igiDocId) throws Exception {
		try {
			Query query=manager.createNativeQuery(DOCEMPLISTBYIGIDOCID);
			query.setParameter("LabCode", labCode);
			query.setParameter("IGIDocId", igiDocId);
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
			logger.error(new Date() + "Inside DAO  getIGIDocumentMembersById "+e);
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
	public long addBasicInterfaceType(IGIInterface iif) throws Exception {
		try {
			manager.persist(iif);
			manager.flush();
			return iif.getInterfaceId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public List<IGIInterface> getAllIGIInterface(String labCode) throws Exception {
		try {
			Query query = manager.createQuery("FROM IGIInterface WHERE LabCode = :LabCode");
			query.setParameter("LabCode", labCode);
			return (List<IGIInterface>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<IGIInterface>();
		}
	}
	
	private static final String BASICPARAMETERS="select * from pfms_igi_parameters";
	@Override
	public List<Object[]> getAllBasicParameters() throws Exception {
		try {
			Query query=manager.createNativeQuery(BASICPARAMETERS);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		
	}
	
	
	@Override
	public long addIGIBasicParameters(IGIBasicParameters ib) throws Exception {
		try {
			manager.persist(ib);
			manager.flush();
			return ib.getParameterId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
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
}
