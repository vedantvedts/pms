package com.vts.pfms.documents.service;

import java.math.BigInteger;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.vts.pfms.documents.dto.StandardDocumentsDto;
import com.vts.pfms.documents.model.ICDDocumentConnections;
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

public interface DocumentsService {

	public long InsertStandardDocuments(StandardDocumentsDto dto) throws Exception;
	public List<Object[]> standardDocumentsList() throws Exception;
	public Object[] standardattachmentdata(String standardDocumentId) throws Exception;
	public long StandardDocumentDelete(long standardDocumentId) throws Exception;
	
	/* ************************************************ IGI Document ***************************************************** */
	public List<Object[]> getIGIDocumentList() throws Exception;
	public long addPfmsIGIDocument(PfmsIGIDocument pfmsIgiDocument) throws Exception;
	public List<Object[]> getDocumentSummaryList(String docId, String docType) throws Exception;
	public IGIDocumentSummary getIGIDocumentSummaryById(String SummaryId) throws Exception;
	public long addIGIDocumentSummary(HttpServletRequest req, HttpSession ses) throws Exception;
	public List<Object[]> getDocumentMemberList(String docId, String docType) throws Exception;
	public List<Object[]> getDocmployeeListByDocId(String labCode, String docId, String docType) throws Exception;
	public long addIGIDocumentMembers(HttpServletRequest req, HttpSession ses) throws Exception;
	public IGIDocumentMembers getIGIDocumentMembersById(Long IgiMemeberId) throws Exception;
	public int deleteIGIDocumentMembers(String igiMemeberId) throws Exception;
	public long addIGIInterface(IGIInterface iif)throws Exception;
	public List<IGIInterface> getIGIInterfaceListByLabCode(String labCode)throws Exception;
	public PfmsIGIDocument getPfmsIGIDocumentById(String igiDocId)throws Exception;
	public IGIInterface getIGIInterfaceById(String interfaceId) throws Exception;
	public BigInteger getDuplicateInterfaceCodeCount(String interfaceId, String interfaceCode) throws Exception;
	public List<IGIDocumentShortCodes> getIGIDocumentShortCodesList() throws Exception;
	public long addIGIDocumentShortCodes(IGIDocumentShortCodes igiDocumentShortCodes, String docId, String docType) throws Exception;
	public List<PfmsApplicableDocs> getPfmsApplicableDocs() throws Exception;
	public List<Object[]> getIGIApplicableDocs(String docId, String docType) throws Exception;
	public long addIGIApplicableDocs(String igiDocId, String docFlag, String[] applicableDocIds, String userId) throws Exception;
	public int deleteIGIApplicableDocument(String igiApplicableDocId) throws Exception;
	public Long getFirstVersionIGIDocId() throws Exception;
	public List<Object[]> getIGIShortCodesLinkedListByType(String docId, String docType) throws Exception;
	public long addIGIDocumentShortCodesLinked(IGIDocumentShortCodesLinked igiDocumentShortCodeLinked) throws Exception;
	public int deleteIGIDocumentShortCodesLinked(String shortCodeLinkedId) throws Exception;
	public BigInteger getDuplicateIGIShortCodeCount(String shortCode, String shortCodeType) throws Exception;
	public long addApplicableDocs(PfmsApplicableDocs pfmsApplicableDocs, String docId, String docType) throws Exception;
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
	public long addPfmsIGITransaction(Long docId, String docType, String statusCode, String remarks, Long actionBy) throws Exception;
	public long igiDocumentApprovalForward(String docId, String docType, String action, String remarks, String EmpId, String labcode, String userId) throws Exception;
	public long icdDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception;
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
	public long irsDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception;
	/* ************************************************ IRS Document End***************************************************** */
	
	/* ************************************************ IDD Document ***************************************************** */
	public List<Object[]> getIDDDocumentList(String projectId, String initiationId) throws Exception;
	public long addPfmsIDDDocument(PfmsIDDDocument pfmsIDDDocument) throws Exception;
	public PfmsIDDDocument getPfmsIDDDocumentById(String irsDocId) throws Exception;
	public Long getFirstVersionIDDDocId(String projectId, String initiationId) throws Exception;
	public long iddDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception;
}
