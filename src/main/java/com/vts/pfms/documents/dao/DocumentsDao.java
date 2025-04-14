package com.vts.pfms.documents.dao;

import java.util.List;

import com.vts.pfms.documents.model.ICDConnectionInterfaces;
import com.vts.pfms.documents.model.ICDConnectionPurpose;
import com.vts.pfms.documents.model.ICDDocumentConnections;
import com.vts.pfms.documents.model.ICDPurpose;
import com.vts.pfms.documents.model.IGIApplicableDocs;
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
	public Long getDuplicateInterfaceCodeCount(String interfaceId, String interfaceCode) throws Exception;
	public List<IGIDocumentShortCodes> getIGIDocumentShortCodesList() throws Exception;
	public long addIGIDocumentShortCodes(IGIDocumentShortCodes igiDocumentShortCodes) throws Exception;
	public List<PfmsApplicableDocs> getPfmsApplicableDocs() throws Exception;
	public List<Object[]> getIGIApplicableDocs(String docId, String docType) throws Exception;
	public long addIGIApplicableDocs(IGIApplicableDocs igiApplicableDocs) throws Exception;
	public int deleteIGIApplicableDocument(String igiApplicableDocId) throws Exception;
	public Long getInterfaceTypeCountByinterfaceTypeId(String interfaceTypeId) throws Exception;
	public Long getInterfaceContentCountByinterfaceContentId(String interfaceTypeId, String interfaceContentId) throws Exception;
	public Long getFirstVersionIGIDocId() throws Exception;
	public long addIGIDocumentShortCodesLinked(IGIDocumentShortCodesLinked igiDocumentShortCodeLinked) throws Exception;
	public List<Object[]> getIGIShortCodesLinkedListByType(String docId, String docType) throws Exception;
	public int deleteIGIDocumentShortCodesLinked(String shortCodeLinkedId) throws Exception;
	public Long getDuplicateIGIShortCodeCount(String shortCode, String shortCodeType) throws Exception;
	public long addApplicableDocs(PfmsApplicableDocs pfmsApplicableDocs) throws Exception;
	public List<Object[]> igiTransactionList(String docId, String docType) throws Exception;
	public List<IGIInterfaceTypes> getIGIInterfaceTypesList() throws Exception;
	public List<IGIInterfaceContent> getIGIInterfaceContentList() throws Exception;
	// srikant start
	public List<Object[]> interfaceTypeMasterList()throws Exception;
	public IGIInterfaceTypes getIGIInterfaceTypeById(String interfaceTypeId) throws Exception;
	public long addIGIInterfaceTypes(IGIInterfaceTypes iGIInterfaceTypes)throws Exception;
	public long addIGIInterfaceTypesContents(IGIInterfaceContent iGIInterfaceContent)throws Exception;
	public int removeIGIInterfaceTypesContents(String interfaceTypeId)throws Exception;
	public Object[] InterfaceAddCheck(String interfaceTypeCode, String interfaceId)throws Exception;
	public Object[] InterfaceContentAddCheck(String interfaceContentCode, String contentId)throws Exception;
	//srikant end
	public int igiDocumentUserRevoke(String igiDocId) throws Exception;
	public List<IGILogicalInterfaces> getIGILogicalInterfaces() throws Exception;
	public IGILogicalInterfaces getIGILogicalInterfaceById(String logicalInterfaceId) throws Exception;
	public long addIGILogicalInterfaces(IGILogicalInterfaces igiLogicalInterfaces) throws Exception;
	public int getLogicalInterfaceCountByType(String msgType) throws Exception;
	/* ************************************************ IGI Document End***************************************************** */
	
	/* ************************************************ ICD Document ***************************************************** */
	public List<Object[]> getICDDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long addPfmsICDDocument(PfmsICDDocument pfmsIGIDocument) throws Exception;
	public PfmsICDDocument getPfmsICDDocumentById(String icdDocId)throws Exception;
	public Long getFirstVersionICDDocId(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long addICDDocumentConnections(ICDDocumentConnections connection) throws Exception;
	public List<Object[]> getICDConnectionsList(String icdDocId) throws Exception;
	public int deleteICDConnectionById(String conInterfaceId) throws Exception;
	public long addPfmsIGITransaction(PfmsIGITransaction transaction) throws Exception;
	public List<Object[]> getProductTreeAllList(String projectId, String initiationId) throws Exception;
	public int icdDocumentUserRevoke(String icdDocId) throws Exception;
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
	public int irsDocumentUserRevoke(String irsDocId) throws Exception;
	public List<Object[]> getDataCarryingConnectionList(String icdDocId)throws Exception;
	public IRSDocumentSpecifications getIRSDocumentSpecificationsById(String irsSpecificationId) throws Exception;
	/* ************************************************ IRS Document End***************************************************** */
	
	/* ************************************************ IDD Document ***************************************************** */
	public List<Object[]> getIDDDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long addPfmsIDDDocument(PfmsIDDDocument pfmsIDDDocument) throws Exception;
	public PfmsIDDDocument getPfmsIDDDocumentById(String irsDocId) throws Exception;
	public Long getFirstVersionIDDDocId(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public int iddDocumentUserRevoke(String iddDocId) throws Exception;
	
	public List<IGIDocumentIntroduction> getIGIDocumentIntroductionList() throws Exception;	
	public IGIDocumentIntroduction getIGIDocumentIntroductionById(String introductionId) throws Exception;
	public Long addIGIDocumentIntroduction(IGIDocumentIntroduction introduction) throws Exception;
	public int deleteIGIIntroduction(String introductionId) throws Exception;
	public Long getInterfaceCountByParentId(Long parentId) throws Exception;
}
