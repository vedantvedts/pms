package com.vts.pfms.documents.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.documents.dto.ICDConnectionDTO;
import com.vts.pfms.documents.dto.ICDPinMapDTO;
import com.vts.pfms.documents.dto.InterfaceTypeAndContentDto;
import com.vts.pfms.documents.dto.StandardDocumentsDto;
import com.vts.pfms.documents.model.DataTypeMaster;
import com.vts.pfms.documents.model.FieldGroupLinked;
import com.vts.pfms.documents.model.FieldGroupMaster;
import com.vts.pfms.documents.model.FieldMaster;
import com.vts.pfms.documents.model.ICDConnectionConnectors;
import com.vts.pfms.documents.model.ICDConnectionInterfaces;
import com.vts.pfms.documents.model.ICDConnectionPurpose;
import com.vts.pfms.documents.model.ICDConnectionSystems;
import com.vts.pfms.documents.model.ICDConnectorPinMapping;
import com.vts.pfms.documents.model.ICDConnectorPins;
import com.vts.pfms.documents.model.ICDDocumentConnections;
import com.vts.pfms.documents.model.ICDMechanicalInterfaces;
import com.vts.pfms.documents.model.ICDPurpose;
import com.vts.pfms.documents.model.ICDSystemAttach;
import com.vts.pfms.documents.model.IGIConnector;
import com.vts.pfms.documents.model.IGIConnectorAttach;
import com.vts.pfms.documents.model.IGIConstants;
import com.vts.pfms.documents.model.IGIDocumentIntroduction;
import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentShortCodes;
import com.vts.pfms.documents.model.IGIDocumentShortCodesLinked;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.IGIFieldDescription;
import com.vts.pfms.documents.model.IGIInterface;
import com.vts.pfms.documents.model.IGIInterfaceContent;
import com.vts.pfms.documents.model.IGIInterfaceTypes;
import com.vts.pfms.documents.model.IGILogicalChannel;
import com.vts.pfms.documents.model.IGILogicalInterfaces;
import com.vts.pfms.documents.model.IRSArrayMaster;
import com.vts.pfms.documents.model.IRSDocumentSpecifications;
import com.vts.pfms.documents.model.IRSFieldDescription;
import com.vts.pfms.documents.model.PfmsICDDocument;
import com.vts.pfms.documents.model.PfmsIDDDocument;
import com.vts.pfms.documents.model.PfmsIGIDocument;
import com.vts.pfms.documents.model.PfmsIRSDocument;
import com.vts.pfms.documents.model.StandardDocuments;
import com.vts.pfms.documents.model.UnitMaster;

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
	public List<StandardDocuments> getStandardDocuments() throws Exception;
	public List<Object[]> getIGIApplicableDocs(String docId, String docType) throws Exception;
	public long addIGIApplicableDocs(String igiDocId, String docFlag, String[] applicableDocIds, String userId) throws Exception;
	public int deleteIGIApplicableDocument(String igiApplicableDocId) throws Exception;
	public Long getFirstVersionIGIDocId() throws Exception;
	public List<Object[]> getIGIShortCodesLinkedListByType(String docId, String docType) throws Exception;
	public long addIGIDocumentShortCodesLinked(IGIDocumentShortCodesLinked igiDocumentShortCodeLinked) throws Exception;
	public int deleteIGIDocumentShortCodesLinked(String shortCodeLinkedId) throws Exception;
	public Long getDuplicateIGIShortCodeCount(String shortCode, String shortCodeType) throws Exception;
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
	public int getLogicalInterfaceCountByType(String logicalChannelId, String msgType) throws Exception;
	public List<IGILogicalChannel> getIGILogicalChannelList() throws Exception;
	public IGILogicalChannel getIGILogicalChannelById(String logicalChannelId) throws Exception;
	public long addIGILogicalChannel(IGILogicalChannel igiLogicalChannel) throws Exception;
	public int deleteIGILogicalChannelById(String logicalChannelId) throws Exception;
	public List<Object[]> fieldMasterList() throws Exception;
	public FieldMaster getFieldMasterById(String fieldMasterId) throws Exception;
	public long addFieldMaster(FieldMaster field) throws Exception;
	public List<Object[]> dataTypeMasterList() throws Exception;
	public long addDataTypeMaster(DataTypeMaster dto) throws Exception;
	public DataTypeMaster getDataTypeMasterById(Long DataTypeMasterId) throws Exception;
	public int removeIGIFieldDescription(String logicalInterfaceTypeId) throws Exception;
	public Long addIGIFieldDescription(IGIFieldDescription igiFieldDescription) throws Exception;
	public List<Object[]> getIGILogicalInterfaceConnectionList() throws Exception;
	public List<FieldGroupMaster> getFieldGroupMasterList();
	public Long addFieldGroupMaster(FieldGroupMaster fieldGroup) throws Exception;
	public FieldGroupMaster getFieldGroupMasterById(Long fieldGroupId) throws Exception;
	public Long addFieldGroupLinked(FieldGroupLinked fieldGroupLinked) throws Exception;
	public int removeFieldGroupLinked(String fieldMasterId) throws Exception;
	public List<FieldGroupLinked> getFieldGroupLinkedList(String fieldMasterId);
	public List<ICDMechanicalInterfaces> getICDMechanicalInterfacesList();
	public ICDMechanicalInterfaces getICDMechanicalInterfacesById(Long mechInterfaceId);
	public Long addICDMechanicalInterfaces(ICDMechanicalInterfaces mechanicalInterfaces, MultipartFile drawingOne, MultipartFile drawingTwo, String labcode);
	public List<IGIConnector> getConnectorMasterList() throws Exception;
	public IGIConnector getIGIConnectorById(Long dataTypeMasterId) throws Exception;
	public long addIGIConnector(IGIConnector connector) throws Exception;
	public List<IGIConstants> getIGIConstantsMasterList();
	public IGIConstants getIGIConstantsById(Long constantId) throws Exception;
	public long addIGIConstants(IGIConstants constant) throws Exception;
	public List<IGIConnectorAttach> getIGIConnectorAttachList();
	public IGIConnectorAttach getIGIConnectorAttachById(String connectorAttachId) throws Exception;
	public long addIGIConnectorAttach(IGIConnectorAttach connectorAttach, MultipartFile attachment, String labcode) throws Exception;
	public Long getDuplicateFieldNameCount(String fieldName,String fieldMasterId) throws Exception;
	public Long getDuplicateGroupNameCount(String groupName,String fieldGroupId) throws Exception;
	public Long getDuplicateGroupCodeCount(String groupCode,String fieldGroupId) throws Exception;

	/* ************************************************ IGI Document End***************************************************** */
	
	/* ************************************************ ICD Document ***************************************************** */
	public List<Object[]> getICDDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long addPfmsICDDocument(PfmsICDDocument pfmsIGIDocument) throws Exception;
	public PfmsICDDocument getPfmsICDDocumentById(String icdDocId)throws Exception;
	public Long getFirstVersionICDDocId(String projectId, String initiationId, String productTreeMainId) throws Exception;
	public long addICDDocumentConnections(ICDDocumentConnections connection, MultipartFile drawingAttach, String labcode) throws Exception;
	public List<ICDConnectionDTO> getICDConnectionsList(String icdDocId) throws Exception;
	public int deleteICDConnectionById(String conInterfaceId) throws Exception;
	public long addPfmsIGITransaction(Long docId, String docType, String statusCode, String remarks, Long actionBy) throws Exception;
	public long igiDocumentApprovalForward(String docId, String docType, String action, String remarks, String EmpId, String labcode, String userId) throws Exception;
	public long icdDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception;
	public List<Object[]> getProductTreeAllList(String projectId, String initiationId) throws Exception;
	public long icdDocumentUserRevoke(String icdDocId, String userId, String empId) throws Exception;
	public ICDDocumentConnections getICDDocumentConnectionsById(String icdConnectionId) throws Exception;
	public List<ICDPurpose> getAllICDPurposeList() throws Exception;
	public long addICDConnectionPurpose(ICDConnectionPurpose icdConnectionPurpose) throws Exception;
	public int getICDConnectionsCount(Long subSystemMainIdOne, Long subSystemMainIdTwo, Long icdDocId) throws Exception;
	public int deleteICDConnectionPurposeByICDConnectionId(String icdConnectionId) throws Exception;
	public ICDPurpose getICDPurposeById(String purposeId) throws Exception;
	public long addICDPurpose(ICDPurpose purpose) throws Exception;
	public List<Object[]> getICDMechInterfaceConnectionList(String icdDocId) throws Exception;
	public long addICDConnectionSystems(ICDConnectionSystems subsystems) throws Exception;
	public long addICDConnectionInterfaces(ICDConnectionInterfaces interfaces) throws Exception;
	public int deleteICDConnectionSystemsByICDConnectionId(String icdConnectionId, String subSystemType) throws Exception;
	public int deleteICDConnectionInterfaceByICDConnectionId(String icdConnectionId) throws Exception;
	public long addICDConnectionConnectors(ICDConnectionConnectors connectors);
	public long addICDConnectorPins(ICDConnectorPins pins);
	public Long getDuplicateConnectorCount(String icdConnectionId, String connectorNo, String systemType, String subSystemId, String icdConnectorId) throws Exception;
	public List<Object[]> getICDConnectorList(String icdConnectionId) throws Exception;
	public List<ICDConnectionConnectors> getAllICDConnectorList();
	public List<Object[]> getICDConnectorPinListByICDConnectionId(String icdConnectionId) throws Exception;
	public ICDConnectionConnectors getICDConnectionConnectorsById(String icdConnectorId) throws Exception;
	public int deleteICDConnectionConnectorPinDetails(String icdConnectorId) throws Exception;
	public ICDConnectorPinMapping getICDConnectorPinMappingById(String connectorPinMapId) throws Exception;
	public long addICDConnectorPinMapping(ICDConnectorPinMapping pinMap);
	public List<ICDPinMapDTO> getICDConnectorPinMapListByICDDocId(String icdDocId) throws Exception;
	public ICDConnectorPins getICDConnectorPinsById(String connectorPinId) throws Exception;
	public int deleteICDConnectionConnectorById(String icdConnectorId) throws Exception;
	public List<ICDSystemAttach> getICDSystemAttachListByICDDocId(String icdDocId);
	public ICDSystemAttach getICDSystemAttachById(String systemAttachId) throws Exception;
	public long addICDSystemAttach(ICDSystemAttach systemAttach, MultipartFile attachment, String labcode);
	
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
	public long addIRSFieldDescription(IRSFieldDescription irsFieldDescription);
	public List<Object[]> getIRSFieldDescriptionList(String irsDocId)throws Exception;
	public int removeIRSFieldDescription(String irsSpecificationId, String fieldGroupId) throws Exception;
	public List<IRSFieldDescription> getIRSFieldDescriptionEntityList(String irsDocId);
	public IRSFieldDescription getIRSFieldDescriptionById(String irsFieldDescId);
	public int updateIRSFieldDescription(String groupVariable, String arrayMasterId, String irsSpecificationId, String fieldGroupId) throws Exception;
	public List<IRSArrayMaster> getIRSArrayMasterListByIRSDocId(String irsDocId);
	public IRSArrayMaster getIRSArrayMasterById(String arrayMasterId) throws Exception;
	public long addIRSArrayMaster(IRSArrayMaster arrayMaster) throws Exception;
	public int irsFieldDescSerialNoUpdate(String[] newslno, String[] irsFieldDescId) throws Exception;
	
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
	public List<Object[]> getSystemProductTreeAllList() throws Exception;
	public List<Object[]> getLogicalChannelList() throws Exception;
	public int getLogicalChannelCount() throws Exception;
	public List<Object[]> getIGIFieldDescriptionList() throws Exception;
	public long getMechanicalInterfaceCount() throws Exception;
	
	/*********************************************** Naveen 4/9/25 **************************************************/
	public UnitMaster getUnitMasterById(long unitMasterId)throws Exception;
	public long addUnitMaster(UnitMaster unitmaster)throws Exception;
	public List<Object[]> unitMasterList()throws Exception;

}
