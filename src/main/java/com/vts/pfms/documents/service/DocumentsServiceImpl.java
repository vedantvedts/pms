package com.vts.pfms.documents.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.vts.pfms.documents.dto.StandardDocumentsDto;
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
import com.vts.pfms.project.model.RequirementSummary;
import com.vts.pfms.requirements.model.RequirementInitiation;

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
		
		if(igiInterface.getInterfaceId()==null) {
			int count = dao.getInterfaceCountByType(igiInterface.getInterfaceType());
			String[] split = igiInterface.getInterfaceType().split(" ");
			String seqCount = (count>=99)?("_"+(count+1)) : ((count>=9 && count<99)?("_0"+(count+1)) : ("_00"+(count+1)) );
			igiInterface.setInterfaceSeqNo((split[0].charAt(0)+""+split[1].charAt(0))+seqCount);
		}
		return dao.addIGIInterface(igiInterface);
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
	public BigInteger getDuplicateInterfaceCodeCount(String interfaceId, String interfaceCode) throws Exception {
		
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
	public List<PfmsApplicableDocs> getPfmsApplicableDocs() throws Exception {
		
		return dao.getPfmsApplicableDocs();
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
				applicableDoc.setApplicableDocId(applicableDocIds[i]!=null? Long.parseLong(applicableDocIds[i]):0);
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
	public BigInteger getDuplicateIGIShortCodeCount(String shortCode, String shortCodeType) throws Exception {
		
		return dao.getDuplicateIGIShortCodeCount(shortCode, shortCodeType);
	}
	
	@Override
	public long addApplicableDocs(PfmsApplicableDocs pfmsApplicableDocs, String docId, String docType) throws Exception {
		
		try {

			long applicableDocId = dao.addApplicableDocs(pfmsApplicableDocs);
			
			IGIApplicableDocs shortCodesLinked = IGIApplicableDocs.builder()
															.ApplicableDocId(applicableDocId)
															.DocId(Long.parseLong(docId))
															.DocType(docType)
															.CreatedBy(pfmsApplicableDocs.getCreatedBy())
															.CreatedDate(sdtf.format(new Date()))
															.IsActive(1)
															.build();
			return dao.addIGIApplicableDocs(shortCodesLinked);
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
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
			
			List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");
			
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
	/* ************************************************ IGI Document End ***************************************************** */
	
	/* ************************************************ ICD Document ***************************************************** */

	@Override
	public List<Object[]> getICDDocumentList(String projectId, String initiationId) throws Exception {
		
		return dao.getICDDocumentList(projectId, initiationId);
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
	public Long getFirstVersionICDDocId(String projectId, String initiationId) throws Exception {
		
		return dao.getFirstVersionICDDocId(projectId, initiationId);
	}
	
	@Override
	public long addICDDocumentConnections(ICDDocumentConnections connection) throws Exception {
		
		return dao.addICDDocumentConnections(connection);
	}
	
	@Override
	public List<Object[]> getICDConnectionsList(String icdDocId) throws Exception {
		
		return dao.getICDConnectionsList(icdDocId);
	}
	
	@Override
	public int deleteICDConnectionById(String icdConnectionId) throws Exception {

		return dao.deleteICDConnectionById(icdConnectionId);
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
			
			List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");
			
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
					notification.setNotificationUrl("ICDDocumentList.htm?projectId="+icdDocument.getProjectId()+"&initiationId="+icdDocument.getInitiationId()+"&projectType="+(icdDocument.getProjectId()!=0?"M":"I") );
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
				notification.setNotificationUrl("ICDDocumentList.htm?projectId="+icdDocument.getProjectId()+"&initiationId="+icdDocument.getInitiationId()+"&projectType="+(icdDocument.getProjectId()!=0?"M":"I") );
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
	public List<Object[]> getProductTreeAllListByProjectId(String projectId) throws Exception {
		
		return dao.getProductTreeAllListByProjectId(projectId);
	}
	
	/* ************************************************ ICD Document End***************************************************** */
	
	/* ************************************************ IRS Document ***************************************************** */
	
	@Override
	public List<Object[]> getIRSDocumentList(String projectId, String initiationId) throws Exception {
		
		return dao.getIRSDocumentList(projectId, initiationId);
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
	public Long getFirstVersionIRSDocId(String projectId, String initiationId) throws Exception {
		
		return dao.getFirstVersionIRSDocId(projectId, initiationId);
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
			
			List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");
			
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
					notification.setNotificationUrl("IRSDocumentList.htm");
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
				notification.setNotificationUrl("IRSDocumentList.htm");
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
	
	/* ************************************************ IRS Document End***************************************************** */
	
	/* ************************************************ IDD Document ***************************************************** */
	
	@Override
	public List<Object[]> getIDDDocumentList(String projectId, String initiationId) throws Exception {
		
		return dao.getIDDDocumentList(projectId, initiationId);
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
	public Long getFirstVersionIDDDocId(String projectId, String initiationId) throws Exception {
		
		return dao.getFirstVersionIDDDocId(projectId, initiationId);
	}
	
	@Override
	public long iddDocumentApprovalForward(String docId, String docType, String action, String remarks, String empId, String labcode, String userId) throws Exception {
		try {
			
			PfmsIDDDocument iddDocument = dao.getPfmsIDDDocumentById(docId);
			String statusCode = iddDocument.getIDDStatusCode();
			String statusCodeNext = iddDocument.getIDDStatusCodeNext();
			
			List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");
			
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
					notification.setNotificationUrl("IDDDocumentList.htm");
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
				notification.setNotificationUrl("IDDDocumentList.htm");
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
}
