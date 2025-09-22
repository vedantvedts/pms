package com.vts.pfms.documents.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.dao.CARSDao;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.documents.dao.DocumentsDao;
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
import com.vts.pfms.documents.model.IGIApplicableDocs;
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
import com.vts.pfms.documents.model.PfmsIGITransaction;
import com.vts.pfms.documents.model.PfmsIRSDocument;
import com.vts.pfms.documents.model.StandardDocuments;
import com.vts.pfms.documents.model.UnitMaster;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class DocumentsServiceImpl implements DocumentsService{

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Autowired
	DocumentsDao dao;
	
	@Autowired
	CARSDao carsdao;
	
	private static final Logger logger=LogManager.getLogger(DocumentsServiceImpl.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf = fc.getRegularDateFormat();
	
	@Override
	public long InsertStandardDocuments(StandardDocumentsDto dto) throws Exception {
		try {
			Path fullpath=Paths.get(uploadpath, "StandardDocuments");
			File theDir = fullpath.toFile();
			if (!theDir.exists()){
				theDir.mkdirs();
			}
			StandardDocuments model= (dto!=null && dto.getSelectedStandardDocumentId()!=null && !dto.getSelectedStandardDocumentId().equalsIgnoreCase(""))? 
					dao.StandardDocumentDataById(Long.parseLong(dto.getSelectedStandardDocumentId()))
					:new StandardDocuments();
			model.setDocumentName(dto.getDocumentName());
			model.setDescription(dto.getDescription());

			if(dto.getAttachment()!=null && !dto.getAttachment().isEmpty()) {
				if(dto.getSelectedStandardDocumentId()!=null && !dto.getSelectedStandardDocumentId().equalsIgnoreCase("")) {
				File oldFile = new File(uploadpath + "\\" + model.getFilePath().toString());
				if (oldFile.exists()) {
					oldFile.delete();
				}
				}
				model.setFilePath("StandardDocuments"+File.separator+dto.getAttachment().getOriginalFilename());
				saveFile1(fullpath, dto.getAttachment().getOriginalFilename(), dto.getAttachment());
			}

			if(dto!=null && dto.getSelectedStandardDocumentId()!=null && !dto.getSelectedStandardDocumentId().equalsIgnoreCase("")) {
				model.setModifiedBy(dto.getCreatedBy());
				model.setModifiedDate(dto.getCreatedDate());
			}else {
				model.setCreatedBy(dto.getCreatedBy());
				model.setCreatedDate(dto.getCreatedDate());
				model.setIsActive(dto.getIsActive());
			}
			return dao.standardDocumentInsert(model);
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public static int saveFile1(Path uploadPath, String fileName, MultipartFile multipartFile) throws IOException {
		logger.info(new Date() + "Inside SERVICE saveFile ");
		int result = 1;

		if (!Files.exists(uploadPath)) {
			Files.createDirectories(uploadPath);
		}
		try (InputStream inputStream = multipartFile.getInputStream()) {
			Path filePath = uploadPath.resolve(fileName);
			Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException ioe) {
			result = 0;
			throw new IOException("Could not save image file: " + fileName, ioe);
		} catch (Exception e) {
			result = 0;
			logger.error(new Date() + "Inside SERVICE saveFile " + e);
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Object[]> standardDocumentsList() throws Exception {
		return dao.standardDocumentsList();
	}
	
	@Override
	public Object[] standardattachmentdata(String standardDocumentId) throws Exception {
		return dao.standardattachmentdata(standardDocumentId);
	}
	
	@Override
	public long StandardDocumentDelete(long standardDocumentId) throws Exception {
		return dao.StandardDocumentDelete(standardDocumentId);
	}
	
	@Override
	public List<IGIInterfaceTypes> getIGIInterfaceTypesList() throws Exception {

		return dao.getIGIInterfaceTypesList();
	}
	
	@Override
	public List<IGIInterfaceContent> getIGIInterfaceContentList() throws Exception {
		
		return dao.getIGIInterfaceContentList();
	}

	//srikant start
	@Override
	public List<Object[]> interfaceTypeMasterList() throws Exception {
		
		return dao.interfaceTypeMasterList();
	}

	@Override
	public IGIInterfaceTypes getIGIInterfaceTypeById(String interfaceTypeId) throws Exception {
		
		return dao.getIGIInterfaceTypeById(interfaceTypeId);
	}

	@Override
	public long addInterfaceTypeAndContentDetails(InterfaceTypeAndContentDto dto) throws Exception {
		try {
			
			IGIInterfaceTypes iGIInterfaceTypes = dto.getAction() != null && dto.getAction().equalsIgnoreCase("Edit")
					? dao.getIGIInterfaceTypeById(dto.getInterfaceTypeId())
					: new IGIInterfaceTypes();
			

			iGIInterfaceTypes.setInterfaceType(dto.getInterfaceType());
			iGIInterfaceTypes.setInterfaceTypeCode(dto.getInterfaceTypeCode());
			
			if (dto.getAction() != null && dto.getAction().equalsIgnoreCase("Add")) {
				iGIInterfaceTypes.setIsActive(dto.getIsActive());
				iGIInterfaceTypes.setCreatedBy(dto.getCreatedBy());
				iGIInterfaceTypes.setCreatedDate(dto.getCreatedDate());
			}
			
			// Remove Previously added Interface Type Contents
			if (dto.getAction() != null && dto.getAction().equalsIgnoreCase("Edit")) {
				dao.removeIGIInterfaceTypesContents(String.valueOf(iGIInterfaceTypes.getInterfaceTypeId()));
				iGIInterfaceTypes.setModifiedBy(dto.getCreatedBy());
				iGIInterfaceTypes.setModifiedDate(dto.getCreatedDate());
			}
			
			long iGIInterfaceTypesId = dao.addIGIInterfaceTypes(iGIInterfaceTypes);

			// Adding IGIInterfaceTypesContents
			for (int i = 0; i < dto.getInterfaceContent().length; i++) {
				if (dto.getAction() != null && dto.getAction().equalsIgnoreCase("Edit")) {
					IGIInterfaceContent iGIInterfaceContent = IGIInterfaceContent.builder()
							.InterfaceContent(dto.getInterfaceContent()[i])
							.InterfaceContentCode(dto.getInterfaceContentCode().get(i))
							.InterfaceTypeId(iGIInterfaceTypes.getInterfaceTypeId())
							.IsDataCarrying(dto.getIsDataCarrying().get(i)).IsActive(1).ModifiedBy(dto.getCreatedBy())
							.ModifiedDate(dto.getCreatedDate()).build();
					dao.addIGIInterfaceTypesContents(iGIInterfaceContent);
				} else {
					IGIInterfaceContent iGIInterfaceContent = IGIInterfaceContent.builder()
							.InterfaceContent(dto.getInterfaceContent()[i])
							.InterfaceContentCode(dto.getInterfaceContentCode().get(i)).InterfaceTypeId(iGIInterfaceTypesId)
							.IsDataCarrying(dto.getIsDataCarrying().get(i)).CreatedBy(dto.getCreatedBy())
							.CreatedDate(dto.getCreatedDate()).IsActive(dto.getIsActive()).build();
					dao.addIGIInterfaceTypesContents(iGIInterfaceContent);
				}

			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public Object[] InterfaceAddCheck(String interfaceTypeCode, String interfaceId) throws Exception {
		
		 return dao.InterfaceAddCheck(interfaceTypeCode, interfaceId);
	}

	@Override
	public Object[] InterfaceContentAddCheck(String interfaceContentCode, String contentId) throws Exception {
		
		return dao.InterfaceContentAddCheck(interfaceContentCode, contentId);
	}
	
	//srikant end;
	/* ************************************************ IGI Document ***************************************************** */
	
	
	@Override
	public List<Object[]> getIGIDocumentList() throws Exception
	{
		return dao.getIGIDocumentList();
	}
	
	@Override
	public long addPfmsIGIDocument(PfmsIGIDocument pfmsIgiDocument) throws Exception
	{
		return dao.addPfmsIGIDocument(pfmsIgiDocument);
	}
	
	@Override
	public List<Object[]> getDocumentSummaryList(String docId, String docType) throws Exception
	{
		return dao.getDocumentSummaryList(docId, docType);
		
	}
	
	@Override
	public IGIDocumentSummary getIGIDocumentSummaryById(String SummaryId) throws Exception
	{
		return dao.getIGIDocumentSummaryById(SummaryId);
	}
	
	
	@Override
	public long addIGIDocumentSummary(HttpServletRequest req, HttpSession ses) throws Exception
	{
		try {
			String UserId = (String) ses.getAttribute("Username");
			String action = req.getParameter("action");
			
			IGIDocumentSummary documentSummary = action != null && action.equalsIgnoreCase("Add") ? new IGIDocumentSummary()
												: dao.getIGIDocumentSummaryById(req.getParameter("summaryId"));
			documentSummary.setAbstract(req.getParameter("abstract"));
			documentSummary.setAdditionalInformation(req.getParameter("information"));
			documentSummary.setKeywords(req.getParameter("keywords"));
			documentSummary.setDistribution(req.getParameter("distribution"));
			documentSummary.setApprover(Long.parseLong(req.getParameter("approver")));
			documentSummary.setReviewer(req.getParameter("reviewer"));
			documentSummary.setPreparedBy(req.getParameter("preparedBy"));
			documentSummary.setDocId(Long.parseLong(req.getParameter("docId")));
			documentSummary.setDocType(req.getParameter("docType"));
			documentSummary.setReleaseDate(fc.rdfTosdf(req.getParameter("pdc")));
			if (action.equalsIgnoreCase("Add")) {
				documentSummary.setCreatedBy(UserId);
				documentSummary.setCreatedDate(sdtf.format(new Date()));
				documentSummary.setIsActive(1);
			} else if (action.equalsIgnoreCase("Edit")) {

				documentSummary.setSummaryId(Long.parseLong(req.getParameter("summaryId")));
				documentSummary.setModifiedBy(UserId);
				documentSummary.setModifiedDate(sdtf.format(new Date()));
			}
			
			return dao.addIGIDocumentSummary(documentSummary);
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public List<Object[]> getDocumentMemberList(String docId, String docType) throws Exception
	{
		return dao.getDocumentMemberList(docId, docType);
	}
	
	@Override
	public List<Object[]> getDocmployeeListByDocId(String labCode, String docId, String docType) throws Exception
	{
		return dao.getDocmployeeListByDocId(labCode, docId, docType);
	}

	@Override
	public long addIGIDocumentMembers(HttpServletRequest req, HttpSession ses) throws Exception {
		
		try {
			String[] assignee = req.getParameterValues("Assignee");
			String UserId = (String) ses.getAttribute("Username");
			
			if(assignee!=null && assignee.length>0) {
				for(int i=0;i<assignee.length;i++) {
					IGIDocumentMembers docMembers = new IGIDocumentMembers();
					docMembers.setDocId(Long.parseLong(req.getParameter("docId")));
					docMembers.setDocType(req.getParameter("docType"));
					docMembers.setEmpId(Long.parseLong(assignee[i]));
					docMembers.setCreatedBy(UserId);
					docMembers.setCreatedDate(sdtf.format(new Date()));
					docMembers.setIsActive(1);
					
					dao.addIGIDocumentMembers(docMembers);
				}
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public int deleteIGIDocumentMembers(String igiMemeberId) throws Exception {
		
		return dao.deleteIGIDocumentMembers(igiMemeberId);
	}
	
	@Override
	public IGIDocumentMembers getIGIDocumentMembersById(Long IgiMemeberId) throws Exception {
		
		return dao.getIGIDocumentMembersById(IgiMemeberId);
	}
	
	@Override
	public long addIGIInterface(IGIInterface igiInterface) throws Exception {
		
		try {

			if(igiInterface.getInterfaceId()==null) {
				String interfaceType = igiInterface.getInterfaceType();
				String interfaceContent = igiInterface.getInterfaceContent();

				String[] interfaceTypeSplit = interfaceType!=null?interfaceType.split("/") : null;
				String[] interfaceContentSplit = interfaceContent!=null && !interfaceContent.equalsIgnoreCase("0")?interfaceContent.split("/") : null;


				if(interfaceTypeSplit!=null && interfaceContentSplit!=null && igiInterface.getParentId()==0) {

					long countT = dao.getInterfaceTypeCountByinterfaceTypeId(interfaceTypeSplit[0]);
					long countC = dao.getInterfaceContentCountByinterfaceContentId(interfaceTypeSplit[0], interfaceContentSplit[0]);

					String seqCount = String.format("%03d", countC + 1);

					String interfaceCode = (interfaceTypeSplit[1]!=null?interfaceTypeSplit[1]:"-")
							+ "_" + (interfaceContentSplit[1]!=null?interfaceContentSplit[1]:"-")
							+ "_" + seqCount + "-"+ (countT+1);

					String interfaceName = (interfaceTypeSplit[2]!=null?interfaceTypeSplit[2]:"-")
							+ " " + (interfaceContentSplit[2]!=null?interfaceContentSplit[2]:"-")
							+ " - " + interfaceCode;
					igiInterface.setInterfaceCode(interfaceCode);
					igiInterface.setInterfaceName(interfaceName);
				}else if(igiInterface.getParentId()>0) {
					
					Long countP = dao.getInterfaceCountByParentId(igiInterface.getParentId());
					igiInterface.setInterfaceCode(igiInterface.getInterfaceCode() + ("-"+(countP+1)));
					igiInterface.setInterfaceName(igiInterface.getInterfaceName() + ("-"+(countP+1)));
				}

				igiInterface.setInterfaceTypeId(interfaceTypeSplit!=null?Long.parseLong(interfaceTypeSplit[0]):0L);
				igiInterface.setInterfaceContentId(interfaceContentSplit!=null?Long.parseLong(interfaceContentSplit[0]):0L);
			}
			return dao.addIGIInterface(igiInterface);
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public List<IGIInterface> getIGIInterfaceListByLabCode(String labCode) throws Exception {
		
		return dao.getIGIInterfaceListByLabCode(labCode);
	}
	
	@Override
	public PfmsIGIDocument getPfmsIGIDocumentById(String igiDocId) throws Exception {
		
		return dao.getPfmsIGIDocumentById(igiDocId);
	}
	
	@Override
	public IGIInterface getIGIInterfaceById(String interfaceId) throws Exception {

		return dao.getIGIInterfaceById(interfaceId);
	}
	
	@Override
	public Long getDuplicateInterfaceCodeCount(String interfaceId, String interfaceCode) throws Exception {
		
		return dao.getDuplicateInterfaceCodeCount(interfaceId, interfaceCode);
	}
	
	@Override
	public List<IGIDocumentShortCodes> getIGIDocumentShortCodesList() throws Exception {
		
		return dao.getIGIDocumentShortCodesList();
	}
	
	@Override
	public long addIGIDocumentShortCodes(IGIDocumentShortCodes igiDocumentShortCodes, String docId, String docType) throws Exception {
		
		try {

			long shortCodeId = dao.addIGIDocumentShortCodes(igiDocumentShortCodes);
			
			IGIDocumentShortCodesLinked shortCodesLinked = IGIDocumentShortCodesLinked.builder()
															.ShortCodeId(shortCodeId)
															.DocId(Long.parseLong(docId))
															.DocType(docType)
															.CreatedBy(igiDocumentShortCodes.getCreatedBy())
															.CreatedDate(sdtf.format(new Date()))
															.IsActive(1)
															.build();
			return dao.addIGIDocumentShortCodesLinked(shortCodesLinked);
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public List<StandardDocuments> getStandardDocuments() throws Exception {
		
		return dao.getStandardDocuments();
	}
	
	@Override
	public List<Object[]> getIGIApplicableDocs(String docId, String docType) throws Exception {
		
		return dao.getIGIApplicableDocs(docId, docType);
	}
	
	@Override
	public long addIGIApplicableDocs(String docId, String docType, String[] applicableDocIds, String userId) throws Exception {
		try {
			
			for(int i=0; i<applicableDocIds.length; i++) {
				IGIApplicableDocs applicableDoc = new IGIApplicableDocs();
				applicableDoc.setStandardDocumentId(applicableDocIds[i]!=null? Long.parseLong(applicableDocIds[i]):0);
				applicableDoc.setDocType(docType);
				applicableDoc.setDocId(docId!=null?Long.parseLong(docId):0);
				applicableDoc.setCreatedBy(userId);
				applicableDoc.setCreatedDate(sdtf.format(new Date()));
				applicableDoc.setIsActive(1);
				
				dao.addIGIApplicableDocs(applicableDoc);
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public int deleteIGIApplicableDocument(String igiApplicableDocId) throws Exception {
		
		return dao.deleteIGIApplicableDocument(igiApplicableDocId);
	}
	
	@Override
	public Long getFirstVersionIGIDocId() throws Exception {

		return dao.getFirstVersionIGIDocId();
	}

	@Override
	public List<Object[]> getIGIShortCodesLinkedListByType(String docId, String docType) throws Exception {
		
		return dao.getIGIShortCodesLinkedListByType(docId, docType);
	}

	@Override
	public long addIGIDocumentShortCodesLinked(IGIDocumentShortCodesLinked igiDocumentShortCodeLinked) throws Exception {

		return dao.addIGIDocumentShortCodesLinked(igiDocumentShortCodeLinked);
	}
	
	@Override
	public int deleteIGIDocumentShortCodesLinked(String shortCodeLinkedId) throws Exception {
		
		return dao.deleteIGIDocumentShortCodesLinked(shortCodeLinkedId);
	}
	
	@Override
	public Long getDuplicateIGIShortCodeCount(String shortCode, String shortCodeType) throws Exception {
		
		return dao.getDuplicateIGIShortCodeCount(shortCode, shortCodeType);
	}
	
	@Override
	public List<Object[]> igiTransactionList(String docId, String docType) throws Exception {

		return dao.igiTransactionList(docId, docType);
	}
	
	@Override
	public long igiDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception {
		try {

			PfmsIGIDocument igiDocument = dao.getPfmsIGIDocumentById(docId);
			String statusCode = igiDocument.getIGIStatusCode();
			String statusCodeNext = igiDocument.getIGIStatusCodeNext();
			
			List<String> reqforwardstatus = Arrays.asList("RIN", "RRR", "RRA", "REV");
			
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(reqforwardstatus.contains(statusCode)) {
					igiDocument.setIGIStatusCode("RFW");
					igiDocument.setIGIStatusCodeNext("RFR");
				}else {
					igiDocument.setIGIStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("RFR")) {
						igiDocument.setIGIStatusCodeNext("RFA");
					}else if(statusCodeNext.equalsIgnoreCase("RFA")) {
						igiDocument.setIGIStatusCodeNext("RAM");
					}else if(statusCodeNext.equalsIgnoreCase("RAM")) {
						igiDocument.setIGIStatusCodeNext("RAM");
					}
				}
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(statusCodeNext.equalsIgnoreCase("RFR")) {
					igiDocument.setIGIStatusCode("RRR");	
				}else if(statusCodeNext.equalsIgnoreCase("RFA")) {
					igiDocument.setIGIStatusCode("RRA");	
				}
				
				// Setting StatusCode Next
				igiDocument.setIGIStatusCodeNext("RFW");
			}
			
			dao.addPfmsIGIDocument(igiDocument);
			
			// Handling Transaction
			addPfmsIGITransaction(Long.parseLong(docId), docType, igiDocument.getIGIStatusCode(), remarks, Long.parseLong(empId));
			
			// Handling Notification
			List<Object[]> documentSummaryList = dao.getDocumentSummaryList(docId, docType);
			Object[] documentSummary = null;
			if(documentSummaryList!=null && documentSummaryList.size()>0) {
				documentSummary = documentSummaryList.get(0);
			}
			
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A")) {
				String reqStatusCode2 = igiDocument.getIGIStatusCode();
				if(reqStatusCode2.equalsIgnoreCase("RFW")) {
					notification.setEmpId(documentSummary!=null && documentSummary[5]!=null?Long.parseLong(documentSummary[5].toString()):0);
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("IGI Document Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFR")) {
					notification.setEmpId(documentSummary!=null && documentSummary[6]!=null?Long.parseLong(documentSummary[6].toString()):0);
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("IGI Document Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFA")) {
					notification.setEmpId(documentSummary!=null && documentSummary[7]!=null?Long.parseLong(documentSummary[7].toString()):0);
					notification.setNotificationUrl("IGIDocumentList.htm");
					notification.setNotificationMessage("IGI Document Doc Approved");
				}
				
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdtf.format(new Date()));

				carsdao.addNotifications(notification);
				
			}else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")){
				notification.setEmpId(documentSummary!=null && documentSummary[7]!=null?Long.parseLong(documentSummary[7].toString()):0);
				notification.setNotificationUrl("IGIDocumentList.htm");
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"IGI Document Doc Request Returned":"IGI Document Doc Request Disapproved");
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				carsdao.addNotifications(notification);
			}
			
			return 1L;
		
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public long igiDocumentUserRevoke(String igiDocId, String userId, String empId) throws Exception {
		try {
			// Revoke
			dao.igiDocumentUserRevoke(igiDocId);
			
			// Handling Transaction
			addPfmsIGITransaction(Long.parseLong(igiDocId), "A", "REV", "NIL", Long.parseLong(empId));
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public List<IGILogicalInterfaces> getIGILogicalInterfaces() throws Exception {
		
		return dao.getIGILogicalInterfaces();
	}
	
	@Override
	public IGILogicalInterfaces getIGILogicalInterfaceById(String logicalInterfaceId) throws Exception {
		
		return dao.getIGILogicalInterfaceById(logicalInterfaceId);
	}
	
	@Override
	public long addIGILogicalInterfaces(IGILogicalInterfaces logicalInterfaces) throws Exception {
		try {
			return dao.addIGILogicalInterfaces(logicalInterfaces);
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public int getLogicalInterfaceCountByType(String logicalChannelId, String msgType) throws Exception {

		return dao.getLogicalInterfaceCountByType(logicalChannelId, msgType);
	}
	
	@Override
	public List<IGILogicalChannel> getIGILogicalChannelList() throws Exception {
		
		return dao.getIGILogicalChannelList();
	}
	
	@Override
	public IGILogicalChannel getIGILogicalChannelById(String logicalChannelId) throws Exception {
		
		return dao.getIGILogicalChannelById(logicalChannelId);
	}
	
	@Override
	public long addIGILogicalChannel(IGILogicalChannel igiLogicalChannel) throws Exception {
		
		return dao.addIGILogicalChannel(igiLogicalChannel);
	}
	
	@Override
	public int deleteIGILogicalChannelById(String logicalChannelId) throws Exception {
		
		return dao.deleteIGILogicalChannelById(logicalChannelId);
	}

	@Override
	public List<Object[]> fieldMasterList() throws Exception {
		
		return dao.fieldMasterList();  
	}
	
	@Override
	public FieldMaster getFieldMasterById(String fieldMasterId) throws Exception {
		
		return dao.getFieldMasterById(fieldMasterId);
	}

	@Override
	public long addFieldMaster(FieldMaster field) throws Exception {
		
		return dao.addFieldMaster(field);
	}

	@Override
	public List<Object[]> dataTypeMasterList() throws Exception {
		
		return dao.dataTypeMasterList();
	}

	@Override
	public DataTypeMaster getDataTypeMasterById(Long DataTypeMasterId) throws Exception  {
		
		return dao.getDataTypeMasterById(DataTypeMasterId);
	}

	@Override
	public long addDataTypeMaster(DataTypeMaster dto) throws Exception {
		
		return dao.addDataTypeMaster(dto);
	}
	
	@Override
	public int removeIGIFieldDescription(String logicalInterfaceTypeId) throws Exception {
	
		return dao.removeIGIFieldDescription(logicalInterfaceTypeId);
	}
	
	@Override
	public Long addIGIFieldDescription(IGIFieldDescription igiFieldDescription) throws Exception {
		
		return dao.addIGIFieldDescription(igiFieldDescription);
	}
	
	@Override
	public List<Object[]> getIGILogicalInterfaceConnectionList() throws Exception {
		
		return dao.getIGILogicalInterfaceConnectionList();
	}
	
	@Override
	public List<FieldGroupMaster> getFieldGroupMasterList() {
		
		return dao.getFieldGroupMasterList();
	}
	
	@Override
	public Long addFieldGroupMaster(FieldGroupMaster fieldGroup) throws Exception {
		
		return dao.addFieldGroupMaster(fieldGroup);
	}
	
	@Override
	public FieldGroupMaster getFieldGroupMasterById(Long fieldGroupId) throws Exception {
		
		return dao.getFieldGroupMasterById(fieldGroupId);
	}
	
	@Override
	public Long addFieldGroupLinked(FieldGroupLinked fieldGroupLinked) throws Exception {
		
		return dao.addFieldGroupLinked(fieldGroupLinked);
	}
	
	@Override
	public int removeFieldGroupLinked(String fieldMasterId) throws Exception {
		
		return dao.removeFieldGroupLinked(fieldMasterId);
	}
	
	@Override
	public List<FieldGroupLinked> getFieldGroupLinkedList(String fieldMasterId) {
		
		return dao.getFieldGroupLinkedList(fieldMasterId);
	}
	
	@Override
	public List<ICDMechanicalInterfaces> getICDMechanicalInterfacesList() {
		
		return dao.getICDMechanicalInterfacesList();
	}
	
	@Override
	public ICDMechanicalInterfaces getICDMechanicalInterfacesById(Long mechInterfaceId) {
		
		return dao.getICDMechanicalInterfacesById(mechInterfaceId);
	}
	
	@Override
	public Long addICDMechanicalInterfaces(ICDMechanicalInterfaces mechInterfaces, MultipartFile drawingOne, MultipartFile drawingTwo, String labcode) {
		try {
			
			Timestamp instant = Timestamp.from(Instant.now());
	        String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

	        Path path = Paths.get(uploadpath, labcode, "ICD", "MechInterface");

			if (drawingOne != null && !drawingOne.isEmpty()) {
				mechInterfaces.setDrawingOne("Drawing1-" + timestampstr + "." + FilenameUtils.getExtension(drawingOne.getOriginalFilename()));
                saveFile1(path, mechInterfaces.getDrawingOne(), drawingOne);
            } 

			if (drawingTwo != null && !drawingTwo.isEmpty()) {
				mechInterfaces.setDrawingTwo("Drawing2-" + timestampstr + "." + FilenameUtils.getExtension(drawingTwo.getOriginalFilename()));
                saveFile1(path, mechInterfaces.getDrawingTwo(), drawingTwo);
            } 
			
			return dao.addICDMechanicalInterfaces(mechInterfaces);
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
		
	}
	
	@Override
	public List<IGIConnector> getConnectorMasterList() throws Exception {

		return dao.getConnectorMasterList();
	}
	
	@Override
	public IGIConnector getIGIConnectorById(Long dataTypeMasterId) throws Exception {

		return dao.getIGIConnectorById(dataTypeMasterId);
	}
	
	@Override
	public long addIGIConnector(IGIConnector connector) throws Exception {

		return dao.addIGIConnector(connector);
	}
	
	@Override
	public List<IGIConstants> getIGIConstantsMasterList() {

		return dao.getIGIConstantsMasterList();
	}
	
	@Override
	public IGIConstants getIGIConstantsById(Long constantId) throws Exception {

		return dao.getIGIConstantsById(constantId);
	}
	
	@Override
	public long addIGIConstants(IGIConstants constant) throws Exception {

		return dao.addIGIConstants(constant);
	}
	
	@Override
	public List<IGIConnectorAttach> getIGIConnectorAttachList() {
		
		return dao.getIGIConnectorAttachList();
	}
	
	@Override
	public IGIConnectorAttach getIGIConnectorAttachById(String connectorAttachId) throws Exception {
		
		return dao.getIGIConnectorAttachById(connectorAttachId);
	}
	
	@Override
	public long addIGIConnectorAttach(IGIConnectorAttach connectorAttach, MultipartFile attachment, String labcode) throws Exception {
		try {
			if (attachment != null && !attachment.isEmpty()) {
				Timestamp instant = Timestamp.from(Instant.now());
		        String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

		        Path path = Paths.get(uploadpath, labcode, "IGI", "Connectors");
				connectorAttach.setAttachment("Drawing-" + timestampstr + "." + FilenameUtils.getExtension(attachment.getOriginalFilename()));
                saveFile1(path, connectorAttach.getAttachment(), attachment);
            } 
			
			return dao.addIGIConnectorAttach(connectorAttach);
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
		
	}

	@Override
	public Long getDuplicateFieldNameCount(String fieldName, String fieldMasterId) throws Exception {
		
		return dao.getDuplicateFieldNameCount(fieldName, fieldMasterId);
	}
	
	@Override
	public Long getDuplicateGroupNameCount(String groupName, String fieldGroupId) throws Exception {
		
		return dao.getDuplicateGroupNameCount(groupName, fieldGroupId);
	}
	
	@Override
	public Long getDuplicateGroupCodeCount(String groupCode, String fieldGroupId) throws Exception {
		
		return dao.getDuplicateGroupCodeCount(groupCode, fieldGroupId);
	}
	
	/* ************************************************ IGI Document End ***************************************************** */
	
	/* ************************************************ ICD Document ***************************************************** */

	@Override
	public List<Object[]> getICDDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception {
		
		return dao.getICDDocumentList(projectId, initiationId, productTreeMainId);
	}
	
	@Override
	public long addPfmsICDDocument(PfmsICDDocument pfmsIGIDocument) throws Exception {
		
		return dao.addPfmsICDDocument(pfmsIGIDocument);
	}
	
	@Override
	public PfmsICDDocument getPfmsICDDocumentById(String icdDocId) throws Exception {

		return dao.getPfmsICDDocumentById(icdDocId);
	}
	
	@Override
	public Long getFirstVersionICDDocId(String projectId, String initiationId, String productTreeMainId) throws Exception {
		
		return dao.getFirstVersionICDDocId(projectId, initiationId, productTreeMainId);
	}
	
	@Override
	public long addICDDocumentConnections(ICDDocumentConnections connection, MultipartFile drawingAttach, String labcode) throws Exception {
		try {
			
			Timestamp instant = Timestamp.from(Instant.now());
	        String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

	        Path path = Paths.get(uploadpath, labcode, "ICD", "Connections");

			if (drawingAttach != null && !drawingAttach.isEmpty()) {
				connection.setDrawingAttach("Drawing-" + timestampstr + "." + FilenameUtils.getExtension(drawingAttach.getOriginalFilename()));
                saveFile1(path, connection.getDrawingAttach(), drawingAttach);
            } 
			
			return dao.addICDDocumentConnections(connection);
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
		
	}
	
	@Override
	public List<ICDConnectionDTO> getICDConnectionsList(String icdDocId) throws Exception {
		
		return dao.getICDConnectionsList(icdDocId);
	}
	
	@Override
	public int deleteICDConnectionById(String conInterfaceId) throws Exception {

		return dao.deleteICDConnectionById(conInterfaceId);
	}
	
	@Override
	public long addPfmsIGITransaction(Long docId, String docType, String statusCode, String remarks, Long actionBy) throws Exception {
		
		PfmsIGITransaction transaction = PfmsIGITransaction.builder()
										 .DocId(docId)
										 .DocType(docType)
										 .StatusCode(statusCode)
										 .Remarks(remarks)
										 .ActionBy(actionBy)
										 .ActionDate(sdtf.format(new Date()))
										.build();
		
		return dao.addPfmsIGITransaction(transaction);
	}
	
	@Override
	public long icdDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception {
		try {

			PfmsICDDocument icdDocument = dao.getPfmsICDDocumentById(docId);
			String statusCode = icdDocument.getICDStatusCode();
			String statusCodeNext = icdDocument.getICDStatusCodeNext();
			
			List<String> reqforwardstatus = Arrays.asList("RIN", "RRR", "RRA", "REV");
			
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(reqforwardstatus.contains(statusCode)) {
					icdDocument.setICDStatusCode("RFW");
					icdDocument.setICDStatusCodeNext("RFR");
				}else {
					icdDocument.setICDStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("RFR")) {
						icdDocument.setICDStatusCodeNext("RFA");
					}else if(statusCodeNext.equalsIgnoreCase("RFA")) {
						icdDocument.setICDStatusCodeNext("RAM");
					}else if(statusCodeNext.equalsIgnoreCase("RAM")) {
						icdDocument.setICDStatusCodeNext("RAM");
					}
				}
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(statusCodeNext.equalsIgnoreCase("RFR")) {
					icdDocument.setICDStatusCode("RRR");	
				}else if(statusCodeNext.equalsIgnoreCase("RFA")) {
					icdDocument.setICDStatusCode("RRA");	
				}
				
				// Setting StatusCode Next
				icdDocument.setICDStatusCodeNext("RFW");
			}
			
			dao.addPfmsICDDocument(icdDocument);
			
			// Handling Transaction
			addPfmsIGITransaction(Long.parseLong(docId), docType, icdDocument.getICDStatusCode(), remarks, Long.parseLong(empId));
			
			// Handling Notification
			List<Object[]> documentSummaryList = dao.getDocumentSummaryList(docId, docType);
			Object[] documentSummary = null;
			if(documentSummaryList!=null && documentSummaryList.size()>0) {
				documentSummary = documentSummaryList.get(0);
			}
			
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A")) {
				String reqStatusCode2 = icdDocument.getICDStatusCode();
				if(reqStatusCode2.equalsIgnoreCase("RFW")) {
					notification.setEmpId(documentSummary!=null && documentSummary[5]!=null?Long.parseLong(documentSummary[5].toString()):0);
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("ICD Document Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFR")) {
					notification.setEmpId(documentSummary!=null && documentSummary[6]!=null?Long.parseLong(documentSummary[6].toString()):0);
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("ICD Document Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFA")) {
					notification.setEmpId(documentSummary!=null && documentSummary[7]!=null?Long.parseLong(documentSummary[7].toString()):0);
					notification.setNotificationUrl("ICDDocumentList.htm?projectId="+icdDocument.getProjectId()+"&initiationId="+icdDocument.getInitiationId()+"&productTreeMainId="+icdDocument.getProductTreeMainId()+"&projectType="+(icdDocument.getProjectId()!=0?"M":"I") );
					notification.setNotificationMessage("ICD Document Doc Approved");
				}
				
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdtf.format(new Date()));

				carsdao.addNotifications(notification);
				
			}else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")){
				notification.setEmpId(documentSummary!=null && documentSummary[7]!=null?Long.parseLong(documentSummary[7].toString()):0);
				notification.setNotificationUrl("ICDDocumentList.htm?projectId="+icdDocument.getProjectId()+"&initiationId="+icdDocument.getInitiationId()+"&productTreeMainId="+icdDocument.getProductTreeMainId()+"&projectType="+(icdDocument.getProjectId()!=0?"M":"I") );
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"ICD Document Doc Request Returned":"ICD Document Doc Request Disapproved");
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				carsdao.addNotifications(notification);
			}
			
			return 1L;
		
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public List<Object[]> getProductTreeAllList(String projectId, String initiationId) throws Exception {
		
		return dao.getProductTreeAllList(projectId, initiationId);
	}
	
	@Override
	public long icdDocumentUserRevoke(String icdDocId, String userId, String empId) throws Exception {
		try {
			// Revoke
			dao.icdDocumentUserRevoke(icdDocId);
			
			// Handling Transaction
			addPfmsIGITransaction(Long.parseLong(icdDocId), "B", "REV", "NIL", Long.parseLong(empId));
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public ICDDocumentConnections getICDDocumentConnectionsById(String icdConnectionId) throws Exception {
		
		return dao.getICDDocumentConnectionsById(icdConnectionId);
	}
	
	@Override
	public List<ICDPurpose> getAllICDPurposeList() throws Exception {
		
		return dao.getAllICDPurposeList();
	}
	
	@Override
	public long addICDConnectionPurpose(ICDConnectionPurpose icdConnectionPurpose) throws Exception {

		return dao.addICDConnectionPurpose(icdConnectionPurpose);
	}
	
	@Override
	public int getICDConnectionsCount(Long subSystemMainIdOne, Long subSystemMainIdTwo, Long icdDocId) throws Exception {
		
		return dao.getICDConnectionsCount(subSystemMainIdOne, subSystemMainIdTwo, icdDocId);
	}
	
	@Override
	public int deleteICDConnectionPurposeByICDConnectionId(String icdConnectionId) throws Exception {
		
		return dao.deleteICDConnectionPurposeByICDConnectionId(icdConnectionId);
	}

	@Override
	public ICDPurpose getICDPurposeById(String purposeId) throws Exception {
		
		return dao.getICDPurposeById(purposeId);
	}
	
	@Override
	public long addICDPurpose(ICDPurpose purpose) throws Exception {
		
		return dao.addICDPurpose(purpose);
	}
	
	@Override
	public List<Object[]> getICDMechInterfaceConnectionList(String icdDocId) throws Exception {

		return dao.getICDMechInterfaceConnectionList(icdDocId);
	}
	
	@Override
	public long addICDConnectionSystems(ICDConnectionSystems subsystems) throws Exception {
		
		return dao.addICDConnectionSystems(subsystems);
	}
	
	@Override
	public long addICDConnectionInterfaces(ICDConnectionInterfaces interfaces) throws Exception {
		
		return dao.addICDConnectionInterfaces(interfaces);
	}
	
	@Override
	public int deleteICDConnectionSystemsByICDConnectionId(String icdConnectionId, String subSystemType) throws Exception {

		return dao.deleteICDConnectionSystemsByICDConnectionId(icdConnectionId, subSystemType);
	}
	
	@Override
	public int deleteICDConnectionInterfaceByICDConnectionId(String icdConnectionId) throws Exception {
		
		return dao.deleteICDConnectionInterfaceByICDConnectionId(icdConnectionId);
	}
	
	@Override
	public long addICDConnectionConnectors(ICDConnectionConnectors connectors) {

		return dao.addICDConnectionConnectors(connectors);
	}
	
	@Override
	public long addICDConnectorPins(ICDConnectorPins pins) {

		return dao.addICDConnectorPins(pins);
	}
	
	@Override
	public Long getDuplicateConnectorCount(String icdConnectionId, String connectorNo, String systemType, String subSystemId, String icdConnectorId) throws Exception {

		return dao.getDuplicateConnectorCount(icdConnectionId, connectorNo, systemType, subSystemId, icdConnectorId);
	}
	
	@Override
	public List<Object[]> getICDConnectorList(String icdConnectionId) throws Exception {
		
		return dao.getICDConnectorList(icdConnectionId);
	}
	
	@Override
	public List<ICDConnectionConnectors> getAllICDConnectorList() {

		return dao.getAllICDConnectorList();
	}
	
	@Override
	public List<Object[]> getICDConnectorPinListByICDConnectionId(String icdConnectionId) throws Exception {

		return dao.getICDConnectorPinListByICDConnectionId(icdConnectionId);
	}
	
	@Override
	public ICDConnectionConnectors getICDConnectionConnectorsById(String icdConnectorId) throws Exception {
		
		return dao.getICDConnectionConnectorsById(icdConnectorId);
	}
	
	@Override
	public int deleteICDConnectionConnectorPinDetails(String icdConnectorId) throws Exception {

		return dao.deleteICDConnectionConnectorPinDetails(icdConnectorId);
	}
	
	@Override
	public ICDConnectorPinMapping getICDConnectorPinMappingById(String connectorPinMapId) throws Exception {
		
		return dao.getICDConnectorPinMappingById(connectorPinMapId);
	}
	
	@Override
	public long addICDConnectorPinMapping(ICDConnectorPinMapping pinMap) {
		
		return dao.addICDConnectorPinMapping(pinMap);
	}
	
	@Override
	public List<ICDPinMapDTO> getICDConnectorPinMapListByICDDocId(String icdDocId) throws Exception {
		
		return dao.getICDConnectorPinMapListByICDDocId(icdDocId);
	}
	
	@Override
	public ICDConnectorPins getICDConnectorPinsById(String connectorPinId) throws Exception {

		return dao.getICDConnectorPinsById(connectorPinId);
	}
	
	@Override
	public int deleteICDConnectionConnectorById(String icdConnectorId) throws Exception {
		
		return dao.deleteICDConnectionConnectorById(icdConnectorId);
	}
	
	@Override
	public List<ICDSystemAttach> getICDSystemAttachListByICDDocId(String icdDocId) {
		
		return dao.getICDSystemAttachListByICDDocId(icdDocId);
	}
	
	@Override
	public ICDSystemAttach getICDSystemAttachById(String systemAttachId) throws Exception {
		
		return dao.getICDSystemAttachById(systemAttachId);
	}
	
	@Override
	public long addICDSystemAttach(ICDSystemAttach systemAttach, MultipartFile attachment, String labcode) {
		try {
			
			Timestamp instant = Timestamp.from(Instant.now());
	        String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

	        Path path = Paths.get(uploadpath, labcode, "ICD", "SubSystems");

			if (attachment != null && !attachment.isEmpty()) {
				systemAttach.setAttachment("Drawing-" + timestampstr + "." + FilenameUtils.getExtension(attachment.getOriginalFilename()));
                saveFile1(path, systemAttach.getAttachment(), attachment);
            } 
			
			return dao.addICDSystemAttach(systemAttach);
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
		
	}
	
	/* ************************************************ ICD Document End***************************************************** */
	
	/* ************************************************ IRS Document ***************************************************** */
	
	@Override
	public List<Object[]> getIRSDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception {
		
		return dao.getIRSDocumentList(projectId, initiationId, productTreeMainId);
	}

	@Override
	public long addPfmsIRSDocument(PfmsIRSDocument pfmsIRSDocument) throws Exception {
		
		return dao.addPfmsIRSDocument(pfmsIRSDocument);
	}
	
	@Override
	public PfmsIRSDocument getPfmsIRSDocumentById(String irsDocId) throws Exception {
		
		return dao.getPfmsIRSDocumentById(irsDocId);
	}
	
	@Override
	public Long getFirstVersionIRSDocId(String projectId, String initiationId, String productTreeMainId) throws Exception {
		
		return dao.getFirstVersionIRSDocId(projectId, initiationId, productTreeMainId);
	}
	
	@Override
	public long addIRSDocumentSpecifications(IRSDocumentSpecifications irsDocumentSpecifications) throws Exception {
		
		return dao.addIRSDocumentSpecifications(irsDocumentSpecifications);
	}
	
	@Override
	public List<Object[]> getIRSDocumentSpecificationsList(String irsDocId) throws Exception {
		
		return dao.getIRSDocumentSpecificationsList(irsDocId);
	}
	
	@Override
	public int deleteIRSSpecifiactionById(String irsSpecificationId) throws Exception {
		
		return dao.deleteIRSSpecifiactionById(irsSpecificationId);
	}
	
	@Override
	public long irsDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception {
		try {

			PfmsIRSDocument irsDocument = dao.getPfmsIRSDocumentById(docId);
			String statusCode = irsDocument.getIRSStatusCode();
			String statusCodeNext = irsDocument.getIRSStatusCodeNext();
			
			List<String> reqforwardstatus = Arrays.asList("RIN", "RRR", "RRA", "REV");
			
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(reqforwardstatus.contains(statusCode)) {
					irsDocument.setIRSStatusCode("RFW");
					irsDocument.setIRSStatusCodeNext("RFR");
				}else {
					irsDocument.setIRSStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("RFR")) {
						irsDocument.setIRSStatusCodeNext("RFA");
					}else if(statusCodeNext.equalsIgnoreCase("RFA")) {
						irsDocument.setIRSStatusCodeNext("RAM");
					}else if(statusCodeNext.equalsIgnoreCase("RAM")) {
						irsDocument.setIRSStatusCodeNext("RAM");
					}
				}
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(statusCodeNext.equalsIgnoreCase("RFR")) {
					irsDocument.setIRSStatusCode("RRR");	
				}else if(statusCodeNext.equalsIgnoreCase("RFA")) {
					irsDocument.setIRSStatusCode("RRA");	
				}
				
				// Setting StatusCode Next
				irsDocument.setIRSStatusCodeNext("RFW");
			}
			
			dao.addPfmsIRSDocument(irsDocument);
			
			// Handling Transaction
			addPfmsIGITransaction(Long.parseLong(docId), docType, irsDocument.getIRSStatusCode(), remarks, Long.parseLong(empId));
			
			// Handling Notification
			List<Object[]> documentSummaryList = dao.getDocumentSummaryList(docId, docType);
			Object[] documentSummary = null;
			if(documentSummaryList!=null && documentSummaryList.size()>0) {
				documentSummary = documentSummaryList.get(0);
			}
			
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A")) {
				String reqStatusCode2 = irsDocument.getIRSStatusCode();
				if(reqStatusCode2.equalsIgnoreCase("RFW")) {
					notification.setEmpId(documentSummary!=null && documentSummary[5]!=null?Long.parseLong(documentSummary[5].toString()):0);
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("IRS Document Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFR")) {
					notification.setEmpId(documentSummary!=null && documentSummary[6]!=null?Long.parseLong(documentSummary[6].toString()):0);
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("IRS Document Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFA")) {
					notification.setEmpId(documentSummary!=null && documentSummary[7]!=null?Long.parseLong(documentSummary[7].toString()):0);
					notification.setNotificationUrl("IRSDocumentList.htm?projectId="+irsDocument.getProjectId()+"&initiationId="+irsDocument.getInitiationId()+"&productTreeMainId="+irsDocument.getProductTreeMainId()+"&projectType="+(irsDocument.getProjectId()!=0?"M":"I") );
					notification.setNotificationMessage("IRS Document Doc Approved");
				}
				
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdtf.format(new Date()));

				carsdao.addNotifications(notification);
				
			}else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")){
				notification.setEmpId(documentSummary!=null && documentSummary[7]!=null?Long.parseLong(documentSummary[7].toString()):0);
				notification.setNotificationUrl("IRSDocumentList.htm?projectId="+irsDocument.getProjectId()+"&initiationId="+irsDocument.getInitiationId()+"&productTreeMainId="+irsDocument.getProductTreeMainId()+"&projectType="+(irsDocument.getProjectId()!=0?"M":"I") );
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"IRS Document Doc Request Returned":"IRS Document Doc Request Disapproved");
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				carsdao.addNotifications(notification);
			}
			
			return 1L;
		
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public long irsDocumentUserRevoke(String irsDocId, String userId, String empId) throws Exception {
		try {
			// Revoke
			dao.irsDocumentUserRevoke(irsDocId);
			
			// Handling Transaction
			addPfmsIGITransaction(Long.parseLong(irsDocId), "C", "REV", "NIL", Long.parseLong(empId));
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public List<Object[]> getDataCarryingConnectionList(String icdDocId) throws Exception {
		
		return dao.getDataCarryingConnectionList(icdDocId);
	}
	
	@Override
	public IRSDocumentSpecifications getIRSDocumentSpecificationsById(String irsSpecificationId) throws Exception {
		
		return dao.getIRSDocumentSpecificationsById(irsSpecificationId);
	}

	@Override
	public long addIRSFieldDescription(IRSFieldDescription irsFieldDescription) {
		
		return dao.addIRSFieldDescription(irsFieldDescription);
	}
	
	@Override
	public List<Object[]> getIRSFieldDescriptionList(String irsDocId) throws Exception {
		
		return dao.getIRSFieldDescriptionList(irsDocId);
	}
	
	@Override
	public int removeIRSFieldDescription(String irsSpecificationId, String fieldGroupId) throws Exception {
		
		return dao.removeIRSFieldDescription(irsSpecificationId, fieldGroupId);
	}
	
	@Override
	public List<IRSFieldDescription> getIRSFieldDescriptionEntityList(String irsDocId) {
		
		return dao.getIRSFieldDescriptionEntityList(irsDocId);
	}
	
	@Override
	public IRSFieldDescription getIRSFieldDescriptionById(String irsFieldDescId) {

		return dao.getIRSFieldDescriptionById(irsFieldDescId);
	}
	
	@Override
	public int updateIRSFieldDescription(String groupVariable, String arrayMasterId, String irsSpecificationId, String fieldGroupId) throws Exception {
		
		return dao.updateIRSFieldDescription(groupVariable, arrayMasterId, irsSpecificationId, fieldGroupId);
	}
	
	@Override
	public List<IRSArrayMaster> getIRSArrayMasterListByIRSDocId(String irsDocId) {

		return dao.getIRSArrayMasterListByIRSDocId(irsDocId);
	}
	
	@Override
	public IRSArrayMaster getIRSArrayMasterById(String arrayMasterId) throws Exception {
		
		return dao.getIRSArrayMasterById(arrayMasterId);
	}
	
	@Override
	public long addIRSArrayMaster(IRSArrayMaster arrayMaster) throws Exception {
		
		return dao.addIRSArrayMaster(arrayMaster);
	}
	
	@Override
	public int irsFieldDescSerialNoUpdate(String[] newslno, String[] irsFieldDescId) throws Exception {
		try {
			for(int i=0;i<irsFieldDescId.length;i++) {
				IRSFieldDescription fieldDesc = dao.getIRSFieldDescriptionById(irsFieldDescId[i]);
				fieldDesc.setFieldSlNo(Integer.parseInt(newslno[i]));
				dao.addIRSFieldDescription(fieldDesc);
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	/* ************************************************ IRS Document End***************************************************** */
	
	/* ************************************************ IDD Document ***************************************************** */
	
	@Override
	public List<Object[]> getIDDDocumentList(String projectId, String initiationId, String productTreeMainId) throws Exception {
		
		return dao.getIDDDocumentList(projectId, initiationId, productTreeMainId);
	}
	
	@Override
	public long addPfmsIDDDocument(PfmsIDDDocument pfmsIDDDocument) throws Exception {
		
		return dao.addPfmsIDDDocument(pfmsIDDDocument);
	}
	
	@Override
	public PfmsIDDDocument getPfmsIDDDocumentById(String irsDocId) throws Exception {
		
		return dao.getPfmsIDDDocumentById(irsDocId);
	}
	
	@Override
	public Long getFirstVersionIDDDocId(String projectId, String initiationId, String productTreeMainId) throws Exception {
		
		return dao.getFirstVersionIDDDocId(projectId, initiationId, productTreeMainId);
	}
	
	@Override
	public long iddDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception {
		try {
			
			PfmsIDDDocument iddDocument = dao.getPfmsIDDDocumentById(docId);
			String statusCode = iddDocument.getIDDStatusCode();
			String statusCodeNext = iddDocument.getIDDStatusCodeNext();
			
			List<String> reqforwardstatus = Arrays.asList("RIN", "RRR", "RRA", "REV");
			
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(reqforwardstatus.contains(statusCode)) {
					iddDocument.setIDDStatusCode("RFW");
					iddDocument.setIDDStatusCodeNext("RFR");
				}else {
					iddDocument.setIDDStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("RFR")) {
						iddDocument.setIDDStatusCodeNext("RFA");
					}else if(statusCodeNext.equalsIgnoreCase("RFA")) {
						iddDocument.setIDDStatusCodeNext("RAM");
					}else if(statusCodeNext.equalsIgnoreCase("RAM")) {
						iddDocument.setIDDStatusCodeNext("RAM");
					}
				}
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(statusCodeNext.equalsIgnoreCase("RFR")) {
					iddDocument.setIDDStatusCode("RRR");	
				}else if(statusCodeNext.equalsIgnoreCase("RFA")) {
					iddDocument.setIDDStatusCode("RRA");	
				}
				
				// Setting StatusCode Next
				iddDocument.setIDDStatusCodeNext("RFW");
			}
			
			dao.addPfmsIDDDocument(iddDocument);
			
			// Handling Transaction
			addPfmsIGITransaction(Long.parseLong(docId), docType, iddDocument.getIDDStatusCode(), remarks, Long.parseLong(empId));
			
			// Handling Notification
			List<Object[]> documentSummaryList = dao.getDocumentSummaryList(docId, docType);
			Object[] documentSummary = null;
			if(documentSummaryList!=null && documentSummaryList.size()>0) {
				documentSummary = documentSummaryList.get(0);
			}
			
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A")) {
				String reqStatusCode2 = iddDocument.getIDDStatusCode();
				if(reqStatusCode2.equalsIgnoreCase("RFW")) {
					notification.setEmpId(documentSummary!=null && documentSummary[5]!=null?Long.parseLong(documentSummary[5].toString()):0);
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("IDD Document Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFR")) {
					notification.setEmpId(documentSummary!=null && documentSummary[6]!=null?Long.parseLong(documentSummary[6].toString()):0);
					notification.setNotificationUrl("DocumentApprovals.htm");
					notification.setNotificationMessage("IDD Document Doc request Forwarded");
				}else if(reqStatusCode2.equalsIgnoreCase("RFA")) {
					notification.setEmpId(documentSummary!=null && documentSummary[7]!=null?Long.parseLong(documentSummary[7].toString()):0);
					notification.setNotificationUrl("IDDDocumentList.htm?projectId="+iddDocument.getProjectId()+"&initiationId="+iddDocument.getInitiationId()+"&productTreeMainId="+iddDocument.getProductTreeMainId()+"&projectType="+(iddDocument.getProjectId()!=0?"M":"I") );
					notification.setNotificationMessage("IDD Document Doc Approved");
				}
				
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdtf.format(new Date()));
				
				carsdao.addNotifications(notification);
				
			}else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")){
				notification.setEmpId(documentSummary!=null && documentSummary[7]!=null?Long.parseLong(documentSummary[7].toString()):0);
				notification.setNotificationUrl("IDDDocumentList.htm?projectId="+iddDocument.getProjectId()+"&initiationId="+iddDocument.getInitiationId()+"&productTreeMainId="+iddDocument.getProductTreeMainId()+"&projectType="+(iddDocument.getProjectId()!=0?"M":"I") );
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"IDD Document Doc Request Returned":"IDD Document Doc Request Disapproved");
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdtf.format(new Date()));
				
				carsdao.addNotifications(notification);
			}
			
			return 1L;
			
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public long iddDocumentUserRevoke(String iddDocId, String userId, String empId) throws Exception {
		try {
			// Revoke
			dao.iddDocumentUserRevoke(iddDocId);
			
			// Handling Transaction
			addPfmsIGITransaction(Long.parseLong(iddDocId), "D", "REV", "NIL", Long.parseLong(empId));
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public List<IGIDocumentIntroduction> getIGIDocumentIntroductionList() throws Exception {
	
		return dao.getIGIDocumentIntroductionList();
	}
	
	@Override
	public IGIDocumentIntroduction getIGIDocumentIntroductionById(String introductionId) throws Exception {

		return dao.getIGIDocumentIntroductionById(introductionId);
	}
	
	@Override
	public Long addIGIDocumentIntroduction(IGIDocumentIntroduction introduction) throws Exception {

		return dao.addIGIDocumentIntroduction(introduction);
	}
	
	@Override
	public int deleteIGIIntroduction(String introductionId) throws Exception {

		return dao.deleteIGIIntroduction(introductionId);
	}

	@Override
	public List<Object[]> getSystemProductTreeAllList() throws Exception {
		
		return dao.getSystemProductTreeAllList();
	}

	@Override
	public List<Object[]> getLogicalChannelList() throws Exception {
		
		return dao.getLogicalChannelList();
	}
	
	@Override
	public int getLogicalChannelCount() throws Exception {
		
		return dao.getLogicalChannelCount();
	}
	
	@Override
	public List<Object[]> getIGIFieldDescriptionList() throws Exception {

		return dao.getIGIFieldDescriptionList();
	}
	
	@Override
	public long getMechanicalInterfaceCount() throws Exception {
	
		return dao.getMechanicalInterfaceCount();
	}

	/*********************************************** Naveen 4/9/25 **************************************************/
	@Override
	public UnitMaster getUnitMasterById(long unitMasterId)throws Exception {
		return dao.getUnitMasterById(unitMasterId);
	}

	@Override
	public long addUnitMaster(UnitMaster unitmaster)throws Exception {
		return dao.addUnitMaster(unitmaster);
	}

	@Override
	public List<Object[]> unitMasterList()throws Exception {
		return dao.unitMasterList();
	}
	
}
