package com.vts.pfms.documents.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.documents.dto.InterfaceTypeAndContentDto;
import com.vts.pfms.documents.dto.InterfaceTypeAndContentDto;
import com.vts.pfms.documents.dto.StandardDocumentsDto;
import com.vts.pfms.documents.model.ICDConnectionInterfaces;
import com.vts.pfms.documents.model.ICDConnectionPurpose;
import com.vts.pfms.documents.model.ICDDocumentConnections;
import com.vts.pfms.documents.model.ICDPurpose;
import com.vts.pfms.documents.model.IGIDocumentIntroduction;
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
import com.vts.pfms.documents.model.PfmsIRSDocument;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
	public Long getDuplicateInterfaceCodeCount(String interfaceId, String interfaceCode) throws Exception;
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
	public Long getDuplicateIGIShortCodeCount(String shortCode, String shortCodeType) throws Exception;
	public long addApplicableDocs(PfmsApplicableDocs pfmsApplicableDocs, String docId, String docType) throws Exception;
	public List<Object[]> igiTransactionList(String docId, String docType) throws Exception;
	public List<IGIInterfaceTypes> getIGIInterfaceTypesList() throws Exception;
	public List<IGIInterfaceContent> getIGIInterfaceContentList() throws Exception;
	 //srikant start
	public List<Object[]> interfaceTypeMasterList() throws Exception;
	public IGIInterfaceTypes getIGIInterfaceTypeById(String interfaceTypeId) throws Exception;
	public long addInterfaceTypeAndContentDetails(InterfaceTypeAndContentDto dto) throws Exception;
	public Object[] InterfaceAddCheck(String interfaceTypeCode, String interfaceId) throws Exception;
	public Object[] InterfaceContentAddCheck(String interfaceContentCode, String contentId)throws Exception;
	//srikant end
	public long igiDocumentUserRevoke(String igiDocId, String userId, String empId) throws Exception;
	public List<IGILogicalInterfaces> getIGILogicalInterfaces() throws Exception;
	public IGILogicalInterfaces getIGILogicalInterfaceById(String logicalInterfaceId) throws Exception;
	public long addIGILogicalInterfaces(IGILogicalInterfaces igiLogicalInterfaces) throws Exception;
	/* ************************************************ IGI Document End***************************************************** */
	
	/* ************************************************ ICD Document ***************************************************** */
	public List<Object[]> getICDDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long addPfmsICDDocument(PfmsICDDocument pfmsIGIDocument) throws Exception;
	public PfmsICDDocument getPfmsICDDocumentById(String icdDocId)throws Exception;
	public Long getFirstVersionICDDocId(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long addICDDocumentConnections(ICDDocumentConnections connection, MultipartFile drawingAttach, String labcode) throws Exception;
	public List<Object[]> getICDConnectionsList(String icdDocId) throws Exception;
	public int deleteICDConnectionById(String conInterfaceId) throws Exception;
	public long addPfmsIGITransaction(Long docId, String docType, String statusCode, String remarks, Long actionBy) throws Exception;
	public long igiDocumentApprovalForward(String docId, String docType, String action, String remarks, String EmpId, String labcode, String userId) throws Exception;
	public long icdDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception;
	public List<Object[]> getProductTreeAllList(String projectId, String initiationId) throws Exception;
	public long icdDocumentUserRevoke(String icdDocId, String userId, String empId) throws Exception;
	public ICDDocumentConnections getICDDocumentConnectionsById(String icdConnectionId) throws Exception;
	public List<ICDPurpose> getAllICDPurposeList() throws Exception;
	public long addICDConnectionInterfaces(ICDConnectionInterfaces connectioInterfaces) throws Exception;
	public long addICDConnectionPurpose(ICDConnectionPurpose icdConnectionPurpose) throws Exception;
	public int getICDConnectionsCount(Long subSystemMainIdOne, Long subSystemMainIdTwo, Long superSubSysMainIdOne, 
			Long superSubSysMainIdTwo, Long icdDocId) throws Exception;
	public int deleteICDConnectionPurposeByICDConnectionId(String icdConnectionId) throws Exception;

	/* ************************************************ ICD Document End***************************************************** */
	
	/* ************************************************ IRS Document ***************************************************** */
	public List<Object[]> getIRSDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long addPfmsIRSDocument(PfmsIRSDocument pfmsIRSDocument) throws Exception;
	public PfmsIRSDocument getPfmsIRSDocumentById(String irsDocId) throws Exception;
	public Long getFirstVersionIRSDocId(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long addIRSDocumentSpecifications(IRSDocumentSpecifications irsDocumentSpecifications) throws Exception;
	public List<Object[]> getIRSDocumentSpecificationsList(String irsDocId) throws Exception;
	public int deleteIRSSpecifiactionById(String irsSpecificationId) throws Exception;
	public long irsDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception;
	public long irsDocumentUserRevoke(String irsDocId, String userId, String empId) throws Exception;
	public List<Object[]> getDataCarryingConnectionList(String icdDocId)throws Exception;
	public IRSDocumentSpecifications getIRSDocumentSpecificationsById(String irsSpecificationId) throws Exception;
	/* ************************************************ IRS Document End***************************************************** */
	
	/* ************************************************ IDD Document ***************************************************** */
	public List<Object[]> getIDDDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long addPfmsIDDDocument(PfmsIDDDocument pfmsIDDDocument) throws Exception;
	public PfmsIDDDocument getPfmsIDDDocumentById(String irsDocId) throws Exception;
	public Long getFirstVersionIDDDocId(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long iddDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception;
	public long iddDocumentUserRevoke(String iddDocId, String userId, String empId) throws Exception;
	public List<IGIDocumentIntroduction> getIGIDocumentIntroductionList() throws Exception;
	public IGIDocumentIntroduction getIGIDocumentIntroductionById(String introductionId) throws Exception;
	public Long addIGIDocumentIntroduction(IGIDocumentIntroduction introduction) throws Exception;
	public int deleteIGIIntroduction(String introductionId) throws Exception;
	
}
