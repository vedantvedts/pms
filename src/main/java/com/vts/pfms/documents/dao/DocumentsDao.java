package com.vts.pfms.documents.dao;

import java.math.BigInteger;
import java.util.List;

import com.vts.pfms.documents.model.ICDDocumentConnections;
import com.vts.pfms.documents.model.IGIApplicableDocs;
import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentShortCodes;
import com.vts.pfms.documents.model.IGIDocumentShortCodesLinked;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.IGIInterface;
import com.vts.pfms.documents.model.IRSDocumentSpecifications;
import com.vts.pfms.documents.model.PfmsApplicableDocs;
import com.vts.pfms.documents.model.PfmsICDDocument;
import com.vts.pfms.documents.model.PfmsIDDDocument;
import com.vts.pfms.documents.model.PfmsIGIDocument;
import com.vts.pfms.documents.model.PfmsIGITransaction;
import com.vts.pfms.documents.model.PfmsIRSDocument;
import com.vts.pfms.documents.model.StandardDocuments;

public interface DocumentsDao {

	public long standardDocumentInsert(StandardDocuments model) throws Exception;
	public List<Object[]> standardDocumentsList() throws Exception;
	public Object[] standardattachmentdata(String standardDocumentId) throws Exception;
	public StandardDocuments StandardDocumentDataById(long StandartDocumentId) throws Exception;
	public long StandardDocumentDelete(long standardDocumentId) throws Exception;
	
	/* ************************************************ IGI Document ***************************************************** */
	public List<Object[]> getIGIDocumentList() throws Exception;
	public long addPfmsIGIDocument(PfmsIGIDocument pfmsIgiDocument) throws Exception;
	public List<Object[]> getDocumentSummaryList(String docId, String docType) throws Exception;
	public IGIDocumentSummary getIGIDocumentSummaryById(String summaryId) throws Exception;
	public long addIGIDocumentSummary(IGIDocumentSummary rs) throws Exception;
	public List<Object[]> getDocumentMemberList(String docId, String docType) throws Exception;
	public List<Object[]> getDocmployeeListByDocId(String labCode, String docId, String docType) throws Exception;
	public long addIGIDocumentMembers(IGIDocumentMembers igiDocumentMember) throws Exception;
	public IGIDocumentMembers getIGIDocumentMembersById(Long igiMemeberId) throws Exception;
	public int deleteIGIDocumentMembers(String igiMemeberId) throws Exception;
	public long addIGIInterface(IGIInterface addIGIInterface)throws Exception;
	public List<IGIInterface> getIGIInterfaceListByLabCode(String labCode)throws Exception;
	public PfmsIGIDocument getPfmsIGIDocumentById(String igiDocId)throws Exception;
	public IGIInterface getIGIInterfaceById(String interfaceId) throws Exception;
	public BigInteger getDuplicateInterfaceCodeCount(String interfaceId, String interfaceCode) throws Exception;
	public List<IGIDocumentShortCodes> getIGIDocumentShortCodesList() throws Exception;
	public long addIGIDocumentShortCodes(IGIDocumentShortCodes igiDocumentShortCodes) throws Exception;
	public List<PfmsApplicableDocs> getPfmsApplicableDocs() throws Exception;
	public List<Object[]> getIGIApplicableDocs(String docId, String docType) throws Exception;
	public long addIGIApplicableDocs(IGIApplicableDocs igiApplicableDocs) throws Exception;
	public int deleteIGIApplicableDocument(String igiApplicableDocId) throws Exception;
	public int getInterfaceCountByType(String interfaceType) throws Exception;
	public Long getFirstVersionIGIDocId() throws Exception;
	public long addIGIDocumentShortCodesLinked(IGIDocumentShortCodesLinked igiDocumentShortCodeLinked) throws Exception;
	public List<Object[]> getIGIShortCodesLinkedListByType(String docId, String docType) throws Exception;
	public int deleteIGIDocumentShortCodesLinked(String shortCodeLinkedId) throws Exception;
	public BigInteger getDuplicateIGIShortCodeCount(String shortCode, String shortCodeType) throws Exception;
	public long addApplicableDocs(PfmsApplicableDocs pfmsApplicableDocs) throws Exception;
	public List<Object[]> igiTransactionList(String docId, String docType) throws Exception;
	/* ************************************************ IGI Document End***************************************************** */
	
	/* ************************************************ ICD Document ***************************************************** */
	public List<Object[]> getICDDocumentList(String projectId, String initiationId) throws Exception;
	public long addPfmsICDDocument(PfmsICDDocument pfmsIGIDocument) throws Exception;
	public PfmsICDDocument getPfmsICDDocumentById(String icdDocId)throws Exception;
	public Long getFirstVersionICDDocId(String projectId, String initiationId) throws Exception;
	public long addICDDocumentConnections(ICDDocumentConnections connection) throws Exception;
	public List<Object[]> getICDConnectionsList(String icdDocId) throws Exception;
	public int deleteICDConnectionById(String icdConnectionId) throws Exception;
	public long addPfmsIGITransaction(PfmsIGITransaction transaction) throws Exception;
	public List<Object[]> getProductTreeAllListByProjectId(String projectId) throws Exception;
	/* ************************************************ ICD Document End***************************************************** */
	
	/* ************************************************ IRS Document ***************************************************** */
	public List<Object[]> getIRSDocumentList(String projectId, String initiationId) throws Exception;
	public long addPfmsIRSDocument(PfmsIRSDocument pfmsIRSDocument) throws Exception;
	public PfmsIRSDocument getPfmsIRSDocumentById(String irsDocId) throws Exception;
	public Long getFirstVersionIRSDocId(String projectId, String initiationId) throws Exception;
	public long addIRSDocumentSpecifications(IRSDocumentSpecifications irsDocumentSpecifications) throws Exception;
	public List<Object[]> getIRSDocumentSpecificationsList(String irsDocId) throws Exception;
	public int deleteIRSSpecifiactionById(String irsSpecificationId) throws Exception;
	/* ************************************************ IRS Document End***************************************************** */
	
	/* ************************************************ IDD Document ***************************************************** */
	public List<Object[]> getIDDDocumentList(String projectId, String initiationId) throws Exception;
	public long addPfmsIDDDocument(PfmsIDDDocument pfmsIDDDocument) throws Exception;
	public PfmsIDDDocument getPfmsIDDDocumentById(String irsDocId) throws Exception;
	public Long getFirstVersionIDDDocId(String projectId, String initiationId) throws Exception;
	
	
	
}
