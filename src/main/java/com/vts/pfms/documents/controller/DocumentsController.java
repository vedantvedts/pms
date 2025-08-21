package com.vts.pfms.documents.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.documents.dto.ICDConnectionDTO;
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
import com.vts.pfms.documents.model.IGIDocumentShortCodes;
import com.vts.pfms.documents.model.IGIDocumentShortCodesLinked;
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
import com.vts.pfms.documents.service.DocumentsService;
import com.vts.pfms.producttree.dto.ProductTreeDto;
import com.vts.pfms.producttree.model.ProductTree;
import com.vts.pfms.producttree.service.ProductTreeService;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.requirements.service.RequirementService;
import com.vts.pfms.utils.InputValidator;
import com.vts.pfms.utils.PMSLogoUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
public class DocumentsController {

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Autowired
	DocumentsService service;
	
	@Autowired
	ProjectService projectservice;
	
	@Autowired
	RequirementService reqservice;
	
	@Autowired
	ProductTreeService prodservice;
	
	@Autowired
	PMSLogoUtil logoUtil;
	
	private static final Logger logger = LogManager.getLogger(DocumentsController.class);
//	private SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
//	private SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
//	private SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf = fc.getRegularDateFormat();
	
	
	@RequestMapping(value = "StandardDocuments.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String ProjectIntiationList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside StandardDocuments.htm" + UserId);
		try {
			List<Object[]> stnadardDocumentsList=service.standardDocumentsList();
			req.setAttribute("stnadardDocumentsList", stnadardDocumentsList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside StandardDocuments.htm" + UserId, e);
		}

		return "standardDocuments/standardDocumentsList";
	}
	
	
	@RequestMapping(value = "StandardDocumentsAddSubmit.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String StandardDocumentsAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,@RequestPart(name = "Attachment", required = false) MultipartFile Attachment) {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside StandardDocumentsAddSubmit.htm" + UserId);
		try {
			String SelectedStandardDocumentId=req.getParameter("SelectedStandardDocumentId");
			String DocumentName=req.getParameter("DocumentName");
			String Description=req.getParameter("Description");
			String DocumentFrom=req.getParameter("DocumentFrom");
			System.out.println("DocumentFrom:"+DocumentFrom);
			
			
			  if(!InputValidator.isValidCapitalsAndSmallsAndNumeric(DocumentName)) {
			   
			  return redirectWithError(redir, "StandardDocuments.htm","'Document Name' must contain only Alphabets and Numbers"); 
			  }
			  
			  if(!InputValidator.isContainsDescriptionPattern(Description)) {
			  
			  return redirectWithError(redir, "StandardDocuments.htm","'Description' may only contain letters, numbers, and @ . , ( ) - & (Spaces allowed)'");
			  }
			 
			StandardDocumentsDto dto=new StandardDocumentsDto();
			dto.setDocumentName(DocumentName);
			dto.setDescription(Description);
			dto.setAttachment(Attachment);
			dto.setCreatedBy(UserId);
			dto.setCreatedDate(sdtf.format(new Date()));
			dto.setIsActive(1);
			dto.setSelectedStandardDocumentId(SelectedStandardDocumentId);
			
			long InsertStandardDocuments=service.InsertStandardDocuments(dto);
			if(InsertStandardDocuments>0) {
				if(DocumentFrom!=null && DocumentFrom.equalsIgnoreCase("Add")) {
				    redir.addAttribute("result", "Document Added Successfully..&#128077;");
				}else {
					redir.addAttribute("result", "Document Updated Successfully..&#128077;");
				}
			}else {
				if(DocumentFrom!=null && DocumentFrom.equalsIgnoreCase("Add")) {
					redir.addAttribute("resultFail", "Document Added UnSuccessful..&#128078;");
				}else {
					redir.addAttribute("resultFail", "Document Updated UnSuccessful..&#128078;");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside StandardDocumentsAddSubmit.htm" + UserId, e);
		}

		return "redirect:/StandardDocuments.htm";
	}
	
	
//	@RequestMapping(value = "StandardDocumentsView.htm", method = {RequestMethod.GET, RequestMethod.POST})
//	public void StandardDocumentsView(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
//	    try {
//	        String StandardDocumentId = req.getParameter("StandardDocumentviewId");
//	        System.out.println("StandardDocumentId:"+StandardDocumentId);
//	        Object[] standardattachmentdata = service.standardattachmentdata(StandardDocumentId);
//	        File my_file = null;
//	        String attachmentFiledata = standardattachmentdata[1].toString().replaceAll("[/\\\\]", ",");
//	        String[] fileParts = attachmentFiledata.split(",");
//	        my_file = new File(uploadpath+ File.separator+fileParts[0]+File.separator+fileParts[1]);  //this will automatically download
//	        res.setHeader("Content-disposition", "inline; filename=\"" + fileParts[1] + "\"");
//	        String mimeType = getMimeType(my_file.getName()); // Get the appropriate MIME type based on the file extension
//	        res.setContentType(mimeType);
//	        OutputStream out = res.getOutputStream();
//	        FileInputStream in = new FileInputStream(my_file);
//	        byte[] buffer = new byte[4096];
//	        int length;
//	        while ((length = in.read(buffer)) > 0) {
//	            out.write(buffer, 0, length);
//	        }
//	        in.close();
//	        out.flush();
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	        logger.error(new Date() + "Inside StandardDocumentsView.htm" + req.getUserPrincipal().getName(), e);
//	    }
//	}
	
	@RequestMapping(value = "StandardDocumentsDownload.htm", method = {RequestMethod.GET, RequestMethod.POST})
	public void StandardDocumentsDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
		try {
			String StandardDocumentId = req.getParameter("StandardDocumentId");
			System.out.println("StandardDocumentId:"+StandardDocumentId);
			Object[] standardattachmentdata = service.standardattachmentdata(StandardDocumentId);
			File my_file = null;
			String attachmentFiledata = standardattachmentdata[1].toString().replaceAll("[/\\\\]", ",");
			String[] fileParts = attachmentFiledata.split(",");
			my_file = new File(uploadpath+ File.separator+fileParts[0]+File.separator+fileParts[1]);  //this will automatically download
			res.setHeader("Content-disposition", "inline; filename=\"" + fileParts[1] + "\"");
			String mimeType = getMimeType(my_file.getName()); // Get the appropriate MIME type based on the file extension
			res.setContentType(mimeType);
			OutputStream out = res.getOutputStream();
			FileInputStream in = new FileInputStream(my_file);
			byte[] buffer = new byte[4096];
			int length;
			while ((length = in.read(buffer)) > 0) {
				out.write(buffer, 0, length);
			}
			in.close();
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside StandardDocumentsDownload.htm" + req.getUserPrincipal().getName(), e);
		}
	}
	
	private String getMimeType(String filename) {
	    String extension = filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
	    switch (extension) {
	        case "pdf":
	            return "application/pdf";
	        case "doc":
	            return "application/msword";
	        case "docx":
	            return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
	        case "xls":
	            return "application/vnd.ms-excel";
	        case "xlsx":
	            return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
	        case "png":
	            return "application/png";
	        // Add more mappings for other file types as needed
	        default:
	            return "application/octet-stream";
	    }
	}
	
	@RequestMapping(value="GetSelectedDocumentDetails.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public  @ResponseBody String  GetSelectedDocumentDetails(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside GetSelectedDocumentDetails.htm"+Username);
		Gson json = new Gson();
		Object[] SelectedDocumentData=null;
		try {
			String selectedDocumentId = req.getParameter("selectedDocumentId");
			if(selectedDocumentId!=null) {
            SelectedDocumentData=service.standardattachmentdata(selectedDocumentId);
			}
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetSelectedDocumentDetails.htm"+Username, e);
			}
		return json.toJson(SelectedDocumentData);

	}
	
	
	@RequestMapping(value = "StandardDocumentDelete.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String StandardDocumentDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,@RequestPart(name = "Attachment", required = false) MultipartFile Attachment) {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside StandardDocumentDelete.htm" + UserId);
		long StandardDocumentDelete=0;
		try {
			String SelStandardDocumentId=req.getParameter("SelStandardDocumentId");
			if(SelStandardDocumentId!=null) {
			StandardDocumentDelete=service.StandardDocumentDelete(Long.parseLong(SelStandardDocumentId));
			}
			if(StandardDocumentDelete>0) {
				    redir.addAttribute("result", "Document InActivated Successfully..&#128077;");
			}else {
					redir.addAttribute("resultFail", "Document InActivated UnSuccessful..&#128078;");
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside StandardDocumentDelete.htm" + UserId, e);
		}

		return "redirect:/StandardDocuments.htm";
	}
	
	
	/* ************************************************ IGI Document ***************************************************** */
	
	@RequestMapping(value = "IGIDocumentList.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiDocumentList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIDocumentList.htm " + UserId);

		try {
			List<Object[]> igiDocumentList = service.getIGIDocumentList();
			req.setAttribute("igiDocumentList", igiDocumentList);
			if(igiDocumentList!=null && igiDocumentList.size()>0) {
				req.setAttribute("igiDocumentSummaryList", service.getDocumentSummaryList(igiDocumentList.get(igiDocumentList.size()-1)[0].toString(), "A"));
			}
			
			return "documents/IGIDocumentList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocumentList.htm " + UserId, e);
			return "static/Error";
		}

	}

	@RequestMapping(value = "IGIDocumentAdd.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiDocumentAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside IGIDocumentAdd.htm" + UserId);

		try {
			String isAmend = req.getParameter("isAmend");
			String igiDocId = req.getParameter("igiDocId");
			PfmsIGIDocument pfmsIgiDocument = PfmsIGIDocument.builder()
												.IGIVersion(req.getParameter("version"))
												.LabCode(labcode)
												.InitiatedBy(EmpId)
												.InitiatedDate(sdf.format(new Date()))
												.IGIStatusCode("RIN")
												.IGIStatusCodeNext("RIN")
												.CreatedBy(UserId)
												.CreatedDate(sdtf.format(new Date()))
												.IsActive(1)
											.build();
			
			long result = service.addPfmsIGIDocument(pfmsIgiDocument);

			if(isAmend!=null && isAmend.equalsIgnoreCase("Y")) {
				service.igiDocumentApprovalForward(igiDocId, "A", "A", req.getParameter("remarks"), EmpId, labcode, UserId);
			}
			
			// Transaction 
			service.addPfmsIGITransaction(result, "A", "RIN", null, Long.parseLong(EmpId));
			
			
			if (result > 0) {
				redir.addAttribute("result", "IGI Document Data Submitted Successfully");
			} else {
				redir.addAttribute("resultfail", "IGI Document Data Submit Unsuccessful");
			}

			return "redirect:/IGIDocumentList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocumentAdd.htm " + UserId, e);
			return "static/Error";

		}

	}

	@RequestMapping(value = "IGIDocumentDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiDocumentDetails(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside IGIDocumentDetails.htm " + UserId);
		try {
			String igiDocId = req.getParameter("igiDocId");
			
			PfmsIGIDocument igiDocument = service.getPfmsIGIDocumentById(igiDocId);
			req.setAttribute("igiDocument", igiDocument);
			req.setAttribute("version", igiDocument!=null ?igiDocument.getIGIVersion():"1.0");
			
			igiDocId = service.getFirstVersionIGIDocId()+"";
			req.setAttribute("igiDocId", igiDocId);
			req.setAttribute("igiDocumentSummaryList", service.getDocumentSummaryList(igiDocId, "A"));
			req.setAttribute("totalEmployeeList", projectservice.EmployeeList(labcode));

			req.setAttribute("memberList", service.getDocumentMemberList(igiDocId, "A"));
			req.setAttribute("employeeList", service.getDocmployeeListByDocId(labcode, igiDocId, "A"));
			req.setAttribute("shortCodesList", service.getIGIDocumentShortCodesList());
			req.setAttribute("shortCodesLinkedList", service.getIGIShortCodesLinkedListByType(igiDocId, "A"));
			req.setAttribute("labDetails", projectservice.LabListDetails(labcode));
			req.setAttribute("docTempAttributes", projectservice.DocTempAttributes());
			
			req.setAttribute("lablogo",  logoUtil.getLabLogoAsBase64String(labcode)); 
			req.setAttribute("drdologo", logoUtil.getDRDOLogoAsBase64String());
			
			req.setAttribute("igiInterfaceList", service.getIGIInterfaceListByLabCode(labcode));
			req.setAttribute("applicableDocsList", service.getStandardDocuments());
			req.setAttribute("igiApplicableDocsList", service.getIGIApplicableDocs(igiDocId, "A"));
			
			req.setAttribute("interfaceTypesList", service.getIGIInterfaceTypesList());
			req.setAttribute("interfaceContentList", service.getIGIInterfaceContentList());
			
			req.setAttribute("logicalInterfaceList", service.getIGILogicalInterfaces());
			req.setAttribute("logicalChannelList", service.getIGILogicalChannelList());

			req.setAttribute("igiDocumentIntroductionList", service.getIGIDocumentIntroductionList());
			
			req.setAttribute("igiLogicalInterfaceConnectionList", service.getIGILogicalInterfaceConnectionList());
			req.setAttribute("systemProductTreeAllList", service.getSystemProductTreeAllList());
			req.setAttribute("connectorMasterList", service.getConnectorMasterList());

			req.setAttribute("isPdf", req.getParameter("isPdf"));
			return "documents/IGIDocumentDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocumentDetails.htm " + UserId, e);
			return "static/Error";
		}

	}

	@RequestMapping(value = "IGIDocumentSummaryAdd.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiDocumentSummaryAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIDocumentSummaryAdd.htm " + UserId);
		try {
			String docType = req.getParameter("docType");
			String docId = req.getParameter("docId");
			String action = req.getParameter("action");
			
			long result = service.addIGIDocumentSummary(req, ses);
			if (result > 0) {
				redir.addAttribute("result", "Document Summary " + action + "ed successfully ");
			} else {
				redir.addAttribute("resultfail", "Document Summary " + action + " unsuccessful ");
			}
			
			if(docType.equalsIgnoreCase("A")) {
				redir.addAttribute("igiDocId", docId);
				return "redirect:/IGIDocumentDetails.htm";
			}else if(docType.equalsIgnoreCase("B")) {
				redir.addAttribute("icdDocId", docId);
				return "redirect:/ICDDocumentDetails.htm";
			}else if(docType.equalsIgnoreCase("C")) {
				redir.addAttribute("irsDocId", docId);
				return "redirect:/IRSDocumentDetails.htm";
			}else if(docType.equalsIgnoreCase("D")) {
				redir.addAttribute("iddDocId", docId);
				return "redirect:/IDDDocumentDetails.htm";
			}else {
				return "redirect:/IGIDocumentDetails.htm";
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocumentSummaryAdd.htm " + UserId);
			return "static/Error";
		}

	}

	@RequestMapping(value = "IGIDocumentMemberSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String IGIDocumentMemberSubmit(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIDocumentMemberSubmit.htm " + UserId);
		try {

			String docType = req.getParameter("docType");
			String docId = req.getParameter("docId");

			long result = service.addIGIDocumentMembers(req, ses);
			if (result > 0) {
				redir.addAttribute("result", "Members Added Successfully for Document Distribution");
			} else {
				redir.addAttribute("resultfail", "Members Add unsuccessful for Document Distribution");
			}

			if(docType.equalsIgnoreCase("A")) {
				redir.addAttribute("igiDocId", docId);
				return "redirect:/IGIDocumentDetails.htm";
			}else if(docType.equalsIgnoreCase("B")) {
				redir.addAttribute("icdDocId", docId);
				return "redirect:/ICDDocumentDetails.htm";
			}else if(docType.equalsIgnoreCase("C")) {
				redir.addAttribute("irsDocId", docId);
				return "redirect:/IRSDocumentDetails.htm";
			}else if(docType.equalsIgnoreCase("D")) {
				redir.addAttribute("iddDocId", docId);
				return "redirect:/IDDDocumentDetails.htm";
			}else {
				return "redirect:/IGIDocumentDetails.htm";
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocumentMemberSubmit.htm " + UserId);
			return "static/Error";
		}
	}

	@RequestMapping(value = "IGIDocumentMembersDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiDocumentMembersDelete(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIDocumentMembersDelete.htm " + UserId);
		try {

			String IgiMemeberId = req.getParameter("IgiMemeberId");
			String docType = req.getParameter("docType");
			String docId = req.getParameter("docId");
			
			long result = service.deleteIGIDocumentMembers(IgiMemeberId);

			if (result > 0) {
				redir.addAttribute("result", "Members Deleted Successfully for Document Distribution");
			} else {
				redir.addAttribute("resultfail", "Member deleting unsuccessful ");
			}

			if(docType.equalsIgnoreCase("A")) {
				redir.addAttribute("igiDocId", docId);
				return "redirect:/IGIDocumentDetails.htm";
			}else if(docType.equalsIgnoreCase("B")) {
				redir.addAttribute("icdDocId", docId);
				return "redirect:/ICDDocumentDetails.htm";
			}else if(docType.equalsIgnoreCase("C")) {
				redir.addAttribute("irsDocId", docId);
				return "redirect:/IRSDocumentDetails.htm";
			}else if(docType.equalsIgnoreCase("D")) {
				redir.addAttribute("iddDocId", docId);
				return "redirect:/IDDDocumentDetails.htm";
			}else {
				return "redirect:/IGIDocumentDetails.htm";
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocumentMembersDelete.htm " + UserId);
			return "static/Error";
		}
	}

	@RequestMapping(value = "IGIShortCodesDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiShortCodesDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIShortCodesDetails.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");

			req.setAttribute("shortCodesList", service.getIGIDocumentShortCodesList());
			req.setAttribute("shortCodesLinkedList", service.getIGIShortCodesLinkedListByType(docId, docType));
			req.setAttribute("docId", docId);
			req.setAttribute("docType", docType);
			req.setAttribute("shortCodeType", req.getParameter("shortCodeType"));
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			
			return "documents/IGIShortCodesDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIShortCodesDetails.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value="IGIShortCodesDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiShortCodesDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIShortCodesDetailsSubmit.htm " + UserId);
		try {
			
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String shortCodeType = req.getParameter("shortCodeType");
			String[] shortCodeIds = req.getParameterValues("shortCodeId");
			
			if(shortCodeIds!=null && shortCodeIds.length>0) {
				long result = 0;
				for(int i=0; i<shortCodeIds.length; i++) {
					IGIDocumentShortCodesLinked shortCodesLinked = IGIDocumentShortCodesLinked.builder()
																.ShortCodeId(shortCodeIds[i]!=null?Long.parseLong(shortCodeIds[i]):0)
																.DocId(Long.parseLong(docId))
																.DocType(docType)
																.CreatedBy(UserId)
																.CreatedDate(sdtf.format(new Date()))
																.IsActive(1)
																.build();
					result = service.addIGIDocumentShortCodesLinked(shortCodesLinked);
				}
				
				if (result > 0) {
					redir.addAttribute("result", (shortCodeType.equalsIgnoreCase("A")?"Abbreviations":"Acronyms")+" Submitted Successfully");
				} else {
					redir.addAttribute("resultfail", (shortCodeType.equalsIgnoreCase("A")?"Abbreviations":"Acronyms")+" Submit Unsuccessful");
				}
				
			}else {
				redir.addAttribute("resultfail", "Please select atleast one "+(shortCodeType.equalsIgnoreCase("A")?"Abbreviation":"Acronym"));
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("shortCodeType", shortCodeType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			
			return "redirect:/IGIShortCodesDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIShortCodesDetailsSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="IGIDocShortCodesExcelDownload.htm" ,method = {RequestMethod.POST,RequestMethod.GET})
	public void igiDocShortCodesExcelDownload(RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside IGIDocShortCodesExcelDownload.htm "+UserId);
		try{
			String shortCodeType = req.getParameter("shortCodeType"); 
			
			int rowNo=0;
			// Creating a worksheet
			Workbook workbook = new XSSFWorkbook();

			Sheet sheet = workbook.createSheet(shortCodeType.equalsIgnoreCase("A")?"Abbreviations":"Acronyms");
			sheet.setColumnWidth(0, 2000);
			sheet.setColumnWidth(1, 7000);
			sheet.setColumnWidth(2, 8000);

			XSSFFont font = ((XSSFWorkbook) workbook).createFont();
			font.setFontName("Times New Roman");
			font.setFontHeightInPoints((short) 14);
			font.setBold(true);
			
			XSSFFont font2 = ((XSSFWorkbook) workbook).createFont();
			font2.setFontName("Times New Roman");
			font2.setFontHeightInPoints((short) 11);
			font2.setBold(true);
			
			// style for table header
			CellStyle t_header_style = workbook.createCellStyle();
			t_header_style.setLocked(true);
			t_header_style.setFont(font2);
			t_header_style.setWrapText(true);
			t_header_style.setAlignment(HorizontalAlignment.CENTER);
			t_header_style.setVerticalAlignment(VerticalAlignment.CENTER);
			
			// style for table cells with center align
			CellStyle t_body_style2 = workbook.createCellStyle();
			t_body_style2.setWrapText(true);
			t_body_style2.setAlignment(HorizontalAlignment.CENTER);
			t_body_style2.setVerticalAlignment(VerticalAlignment.TOP);
			
			// Table in file header Row
			Row t_header_row = sheet.createRow(rowNo++);
			Cell cell= t_header_row.createCell(0); 
			cell.setCellValue("SN"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(1, CellType.STRING); 
			cell.setCellValue(shortCodeType.equalsIgnoreCase("A")?"Abbreviation":"Acronym"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(2, CellType.STRING); 
			cell.setCellValue("Full form"); 
			cell.setCellStyle(t_header_style);
			
			
//			List<IGIDocumentShortCodes> shortCodesList = service.getIGIDocumentShortCodesList();
//			shortCodesList = shortCodesList.stream().filter(e -> e.getShortCodeType().equalsIgnoreCase(shortCodeType)).collect(Collectors.toList());
//			
//			if(shortCodesList!=null && shortCodesList.size()>0) {
//				int slno=0;
//				for(IGIDocumentShortCodes shortcodes : shortCodesList) {
//					Row t_body_row = sheet.createRow(++slno);
//					cell= t_body_row.createCell(0); 
//					cell.setCellValue(slno); 
//					cell.setCellStyle(t_body_style2);
//					
//					cell= t_body_row.createCell(1); 
//					cell.setCellValue(shortcodes.getShortCode()); 
//					cell.setCellStyle(t_body_style2);
//					
//					cell= t_body_row.createCell(2); 
//					cell.setCellValue(shortcodes.getFullName()); 
//					cell.setCellStyle(t_body_style2);
//				}
//			}
			
			res.setContentType("application/vnd.ms-excel");
			res.setHeader("Content-Disposition", "attachment; filename="+(shortCodeType.equalsIgnoreCase("A")?"Abbreviations":"Acronyms")+"Excel.xls");

			// Write the workbook to the response output stream
			workbook.write(res.getOutputStream());
			workbook.close();
		
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside IGIDocShortCodesExcelDownload.htm "+UserId,e);
		}
	}
	
	@RequestMapping(value="IGIDocShortCodesExcelUpload.htm" ,method = {RequestMethod.POST,RequestMethod.GET})
	public String igiDocShortCodesExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside IGIDocShortCodesExcelUpload.htm "+UserId);
		try {
			String shortCodeType = req.getParameter("shortCodeType");
			String docType = req.getParameter("docType");
			String docId = req.getParameter("docId");
			
			long result = 0;
			
			if (req.getContentType() != null && req.getContentType().startsWith("multipart/")) {
				Part filePart = req.getPart("filename");
				InputStream fileData = filePart.getInputStream();
				Workbook workbook = new XSSFWorkbook(fileData);
				Sheet sheet  = workbook.getSheetAt(0);
				int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum(); 
				
				for (int i=1;i<=rowCount;i++) {
					int cellcount = sheet.getRow(i).getLastCellNum();
					IGIDocumentShortCodes igiDocumentShortCode = new IGIDocumentShortCodes();
					
					for(int j=1;j<cellcount;j++) {

						if(sheet.getRow(i).getCell(j)!=null) {
							if(j==1) {
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case BLANK:break;
								case NUMERIC:
									igiDocumentShortCode.setShortCode(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
									break;
								case STRING:
									igiDocumentShortCode.setShortCode(sheet.getRow(i).getCell(j).getStringCellValue());
									break;	 
								}
							}

							if(j==2) {
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case BLANK:break;
								case NUMERIC:
									igiDocumentShortCode.setFullName(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
									break;
								case STRING:
									igiDocumentShortCode.setFullName(sheet.getRow(i).getCell(j).getStringCellValue());
									break;	 
								}


							}	 
						}
					}
					
					if(igiDocumentShortCode.getShortCode()!=null && igiDocumentShortCode.getFullName()!=null) {
						
						igiDocumentShortCode.setShortCodeType(shortCodeType);
						igiDocumentShortCode.setCreatedBy(UserId);
						igiDocumentShortCode.setCreatedDate(sdtf.format(new Date()));
						igiDocumentShortCode.setIsActive(1);
						
						result = service.addIGIDocumentShortCodes(igiDocumentShortCode, docId, docType);
					}
					
				}
				
				if (result > 0) {
					redir.addAttribute("result", (shortCodeType.equalsIgnoreCase("A")?"Abbreviations":"Acronyms")+" Added Successfully");
				} else {
					redir.addAttribute("resultfail", (shortCodeType.equalsIgnoreCase("A")?"Abbreviations":"Acronyms")+" Add Unsuccessful");
				}
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("shortCodeType", shortCodeType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			
			return "redirect:/IGIShortCodesDetails.htm";
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocShortCodesExcelUpload.htm " + UserId, e);
			return "static/Error";
		}

	}

	@RequestMapping(value="IGINewShortCodesDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiNewShortCodesDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGINewShortCodesDetailsSubmit.htm " + UserId);
		try {
			
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String shortCodeType = req.getParameter("shortCodeType");
			String[] shortCodes = req.getParameterValues("shortCode");
			String[] fullNames = req.getParameterValues("fullName");
			
			if(shortCodes!=null && shortCodes.length>0) {
				long result = 0;
				for(int i=0; i<shortCodes.length; i++) {
					IGIDocumentShortCodes igiDocumentShortCode = new IGIDocumentShortCodes();
					igiDocumentShortCode.setShortCode(shortCodes[i]);
					igiDocumentShortCode.setFullName(fullNames!=null?fullNames[i]:"");
					igiDocumentShortCode.setShortCodeType(shortCodeType);
					igiDocumentShortCode.setCreatedBy(UserId);
					igiDocumentShortCode.setCreatedDate(sdtf.format(new Date()));
					igiDocumentShortCode.setIsActive(1);
					
					result = service.addIGIDocumentShortCodes(igiDocumentShortCode, docId, docType);
				}
				
				if (result > 0) {
					redir.addAttribute("result", (shortCodeType.equalsIgnoreCase("A")?"Abbreviations":"Acronyms")+" Added Successfully");
				} else {
					redir.addAttribute("resultfail", (shortCodeType.equalsIgnoreCase("A")?"Abbreviations":"Acronyms")+" Add Unsuccessful");
				}
				
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("shortCodeType", shortCodeType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			
			return "redirect:/IGIShortCodesDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGINewShortCodesDetailsSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "IGIShortCodesLinkedDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiShortCodesLinkedDelete(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIDocumentMembersDelete.htm " + UserId);
		try {

			String shortCodeLinkedId = req.getParameter("shortCodeLinkedId");
			String docType = req.getParameter("docType");
			String docId = req.getParameter("docId");
			String shortCodeType = req.getParameter("shortCodeType");
			
			long result = service.deleteIGIDocumentShortCodesLinked(shortCodeLinkedId);

			if (result > 0) {
				redir.addAttribute("result", (shortCodeType.equalsIgnoreCase("A")?"Abbreviation":"Acronym")+"Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", (shortCodeType.equalsIgnoreCase("A")?"Abbreviation":"Acronym")+"Delete unsuccessful");
			}

			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("shortCodeType", shortCodeType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			
			return "redirect:/IGIShortCodesDetails.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocumentMembersDelete.htm " + UserId);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="DuplicateShortCodeCheck.htm", method=RequestMethod.GET)
	public @ResponseBody String duplicateShortCodeCheck(HttpSession ses, HttpServletRequest req) throws Exception {
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside DuplicateShortCodeCheck.htm "+UserId);
		Gson json = new Gson();
		Long duplicate=null;
		try
		{	  
	          duplicate = service.getDuplicateIGIShortCodeCount(req.getParameter("shortCode"), req.getParameter("shortCodeType"));
	          
		}catch (Exception e) {
			logger.error(new Date() +"Inside DuplicateShortCodeCheck.htm "+UserId ,e);
			e.printStackTrace(); 
		}
		  
		 return json.toJson(duplicate);    
	}

	@RequestMapping(value = "IGIApplicableDocumentsDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiApplicableDocumentsDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIApplicableDocumentsDetails.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");

			req.setAttribute("applicableDocsList", service.getStandardDocuments());
			req.setAttribute("applicableDocsLinkedList", service.getIGIApplicableDocs(docId, docType));
			req.setAttribute("docId", docId);
			req.setAttribute("docType", docType);
			req.setAttribute("documentNo", req.getParameter("documentNo"));

			return "documents/IGIApplicableDocumentsDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIApplicableDocumentsDetails.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "IGIApplicableDocsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiApplicableDocsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIApplicableDocsSubmit.htm " + UserId);
		
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String[] applicableDocIds = req.getParameterValues("applicableDocId");
			
			long result = 0;
			if(applicableDocIds!=null && applicableDocIds.length>0) {
				result = service.addIGIApplicableDocs(docId, docType, applicableDocIds, UserId);
				
				if (result > 0) {
					redir.addAttribute("result", "Applicable Documents Submitted Successfully");
				} else {
					redir.addAttribute("resultfail", "Applicable Documents Submit Unsuccessful");
				}
				
			}else {
				redir.addAttribute("resultfail", "Please select atleast one Applicable Document");
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			
			return "redirect:/IGIApplicableDocumentsDetails.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIApplicableDocsSubmit.htm " + UserId, e);
			return "static/Error";
			
		}
		
	}

//	@RequestMapping(value="IGIApplicableDocumentsDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
//	public String igiApplicableDocumentsDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() + " Inside IGIApplicableDocumentsDetailsSubmit.htm " + UserId);
//		try {
//			
//			String docId = req.getParameter("docId");
//			String docType = req.getParameter("docType");
//			String[] documentName = req.getParameterValues("documentName");
//			
//			if(documentName!=null && documentName.length>0) {
//				long result = 0;
//				for(int i=0; i<documentName.length; i++) {
//					PfmsApplicableDocs igiDocumentShortCode = new PfmsApplicableDocs();
//					igiDocumentShortCode.setDocumentName(documentName[i]);
//					igiDocumentShortCode.setCreatedBy(UserId);
//					igiDocumentShortCode.setCreatedDate(sdtf.format(new Date()));
//					igiDocumentShortCode.setIsActive(1);
//					
//					result = service.addApplicableDocs(igiDocumentShortCode, docId, docType);
//				}
//				
//				if (result > 0) {
//					redir.addAttribute("result", "Applicable Documents Added Successfully");
//				} else {
//					redir.addAttribute("resultfail", "Applicable Documents Add Unsuccessful");
//				}
//				
//			}
//			
//			redir.addAttribute("docId", docId);
//			redir.addAttribute("docType", docType);
//			redir.addAttribute("documentNo", req.getParameter("documentNo"));
//			
//			return "redirect:/IGIApplicableDocumentsDetails.htm";
//
//		}catch (Exception e) {
//			e.printStackTrace();
//			logger.error(new Date() + " Inside IGIApplicableDocumentsDetailsSubmit.htm " + UserId, e);
//			return "static/Error";
//		}
//	}
	
	@RequestMapping(value = "IGIApplicableDocumentDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiApplicableDocumentDelete(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIApplicableDocumentDelete.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String igiApplicableDocId = req.getParameter("igiApplicableDocId");
			
			long result = service.deleteIGIApplicableDocument(igiApplicableDocId);

			if (result > 0) {
				redir.addAttribute("result", "Applicable Documents Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Applicable Documents Delete Unsuccessful");
			}

			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			
			return "redirect:/IGIApplicableDocumentsDetails.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIApplicableDocumentDelete.htm " + UserId);
			return "static/Error";
		}
	}

//	@RequestMapping(value = "IGIIntroductionSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
//	public String igiIntroductionSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() + " Inside IGIIntroductionSubmit.htm" + UserId);
//
//		try {
//			String igiDocId = req.getParameter("igiDocId");
//			PfmsIGIDocument pfmsIgiDocument = service.getPfmsIGIDocumentById(igiDocId);
//			pfmsIgiDocument.setIntroduction(req.getParameter("introduction"));
//			long result = service.addPfmsIGIDocument(pfmsIgiDocument);
//
//			if (result > 0) {
//				redir.addAttribute("result", "IGI Document Introduction Updated Successfully");
//			} else {
//				redir.addAttribute("resultfail", "IGI Document Introduction Update Unsuccessful");
//			}
//			redir.addAttribute("igiDocId", igiDocId);
//			return "redirect:/IGIDocumentDetails.htm";
//		} catch (Exception e) {
//			e.printStackTrace();
//			logger.error(new Date() + " Inside IGIIntroductionSubmit.htm " + UserId, e);
//			return "static/Error";
//
//		}
//
//	}

	@RequestMapping(value = "IGIIntroductionDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiIntroductionDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIIntroductionDetails.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String introductionId = req.getParameter("introductionId");

			req.setAttribute("docId", docId);
			req.setAttribute("docType", docType);
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("introductionId", introductionId!=null?introductionId:"0");
			req.setAttribute("igiDocumentIntroductionList", service.getIGIDocumentIntroductionList());
			return "documents/IGIIntroductionDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIIntroductionDetails.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "IGIIntroductionChapterAdd.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiIntroductionChapterAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIIntroductionChapterAdd.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String introductionId = req.getParameter("introductionId");
			String parentId = req.getParameter("parentId");
			String levelId = req.getParameter("levelId");
			String chapterName = req.getParameter("chapterName");
			
			IGIDocumentIntroduction introduction = Long.parseLong(introductionId)==0?new IGIDocumentIntroduction(): 
																					service.getIGIDocumentIntroductionById(introductionId);
			String action = "Add";
			if(Long.parseLong(introductionId)==0) {
				introduction.setParentId(parentId!=null?Long.parseLong(parentId):0L);
				introduction.setLevelId(levelId!=null?Integer.parseInt(levelId):0);
				introduction.setDocId(docId!=null?Long.parseLong(docId):0L);
				introduction.setDocType(docType);
				introduction.setCreatedBy(UserId);
				introduction.setCreatedDate(sdtf.format(new Date()));
				introduction.setIsActive(1);
			}else {
				introduction.setModifiedBy(UserId);
				introduction.setModifiedDate(sdtf.format(new Date()));
				action = "Edit";
			}
			
			introduction.setChapterName(chapterName);
			//introduction.setChapterContent(chapterContent);
			
			Long result = service.addIGIDocumentIntroduction(introduction);
			
			if (result > 0) {
				redir.addAttribute("result", "Introduction Chapter Name "+action+"ed Successfully");
			} else {
				redir.addAttribute("resultfail", "Introduction Chapter Name "+action+" Unsuccessful");
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("introductionId", result);
			
			return "redirect:/IGIIntroductionDetails.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIIntroductionChapterAdd.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "IGIIntroductionDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiIntroductionDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIIntroductionDetailsSubmit.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String introductionId = req.getParameter("introductionId");
			String chapterContent = req.getParameter("chapterContent");
			
			IGIDocumentIntroduction introduction = service.getIGIDocumentIntroductionById(introductionId);
			introduction.setChapterContent(chapterContent);
			
			Long result = service.addIGIDocumentIntroduction(introduction);
			
			if (result > 0) {
				redir.addAttribute("result", "Introduction Chapter Content Submitted Successfully");
			} else {
				redir.addAttribute("resultfail", "Introduction Chapter Content Submit Unsuccessful");
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("introductionId", introductionId);
			
			return "redirect:/IGIIntroductionDetails.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIIntroductionDetailsSubmit.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "IGIIntroductionChapterDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiIntroductionChapterDelete(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIIntroductionChapterDelete.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String introductionId = req.getParameter("introductionId");
			
			long result = service.deleteIGIIntroduction(introductionId);

			if (result > 0) {
				redir.addAttribute("result", "Chapter Details Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Chapter Details Delete Unsuccessful");
			}

			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			
			return "redirect:/IGIIntroductionDetails.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIIntroductionChapterDelete.htm " + UserId);
			return "static/Error";
		}
	}

	/* srikant controller start*/
	@RequestMapping(value = "InterfaceTypeMaster.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String InterfaceTypeMaster(HttpServletRequest req, HttpServletResponse res, HttpSession ses,
			RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() + "Inside InterfaceTypeMaster.htm" + UserId);
		try {
			req.setAttribute("InterfaceTypeMasterList", service.interfaceTypeMasterList());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside InterfaceTypeMaster.htm " + UserId, e);
			return "static/Error";

		}
		return "documents/InterfaceTypeMasterList";

	}
	
	@RequestMapping(value = "InterfaceTypeForm.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String InterfaceTypeMasterAddEdit( HttpServletRequest req, HttpServletResponse res, HttpSession ses,
			RedirectAttributes redir) throws Exception {
			String UserId = (String) ses.getAttribute("Username");
			
		logger.info(new Date() + "Inside InterfaceTypeForm.htm" + UserId);

		try {

			String interfaceTypeId = req.getParameter("interfaceTypeId");
			String action = req.getParameter("sub");
			IGIInterfaceTypes InterfaceType = null;
			List<IGIInterfaceContent> interfaceContentList = new ArrayList<IGIInterfaceContent>();
			if (action.equalsIgnoreCase("Edit")) {
				InterfaceType = service.getIGIInterfaceTypeById(interfaceTypeId);
				interfaceContentList = service.getIGIInterfaceContentList()
									   .stream()
									   .filter(e->(e.getInterfaceTypeId() == Long.parseLong(interfaceTypeId)) && e.getIsActive()==1)
									   .collect(Collectors.toList());
				}

			req.setAttribute("interfaceType", InterfaceType);
			req.setAttribute("interfaceContentList", interfaceContentList);

			return "documents/InterfaceTypeMasterAddEdit";
		} catch (Exception e) {

			e.printStackTrace();
			logger.error(new Date() + " Inside InterfaceTypeForm.htm " + UserId, e);
			return "static/Error";

		}

	}
	
	@RequestMapping(value="InterfaceTypeSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String interfaceTypeMasterAddEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date()+ " Inside InterfaceTypeSubmit.htm "+UserId);	
		try {
			InterfaceTypeAndContentDto dto = new InterfaceTypeAndContentDto();
			dto.setInterfaceTypeId(req.getParameter("interfaceTypeId"));
			dto.setInterfaceType(req.getParameter("interfaceType"));
			dto.setInterfaceTypeCode(req.getParameter("interfaceTypeCode"));
			dto.setInterfaceContent(req.getParameterValues("interfaceContent"));
			dto.setAction(req.getParameter("action"));
			dto.setCreatedBy(UserId);
			dto.setIsActive(1);
			dto.setCreatedDate(sdtf.format(new Date()));
			List<String> isDataCarryingList = new ArrayList<>();
			List<String> interfaceContentCodeList = new ArrayList<>(); 
			Enumeration<String> parameterNames = req.getParameterNames();
			while (parameterNames.hasMoreElements()) {
				String paramName = parameterNames.nextElement();
				if (paramName.startsWith("isDataCarrying_")) isDataCarryingList.add(req.getParameter(paramName));
				if (paramName.startsWith("interfaceContentCode_")) interfaceContentCodeList.add(req.getParameter(paramName));
			}
			dto.setIsDataCarrying(isDataCarryingList);
			dto.setInterfaceContentCode(interfaceContentCodeList);
			long result = service.addInterfaceTypeAndContentDetails(dto);
			String action = req.getParameter("action");
			if (result!=0) {
				redir.addAttribute("result", "Interface Type Details "+action+"ed Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Interface Type Details "+action+" Unsuccessful");	
			}
					
			return "redirect:/InterfaceTypeMaster.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside InterfaceTypeSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value = "InterfaceAddCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String InterfaceAddCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		Object[] interfaces = null;
		logger.info(new Date() +"Inside InterfaceAddCheck.htm "+UserId);
		try
		{	  
			String interfaceTypeCode=req.getParameter("interfaceTypeCode");
			String interfaceId=req.getParameter("interfaceId");
			interfaces =service.InterfaceAddCheck(interfaceTypeCode,interfaceId);
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +"Inside InterfaceAddCheck.htm "+UserId,e);
		}
		Gson json = new Gson();
		return json.toJson(interfaces); 
	}
	
	@RequestMapping(value = "InterfaceContentAddCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String InterfaceContentAddCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		Object[] interfaceContent = null;
		logger.info(new Date() +"Inside InterfaceContentAddCheck.htm "+UserId);
		try
		{	  
			String interfaceContentCode=req.getParameter("interfaceContentCode");
			String contentId=req.getParameter("contentId");
			interfaceContent =service.InterfaceContentAddCheck(interfaceContentCode,contentId);
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +"Inside InterfaceContentAddCheck.htm "+UserId,e);
		}
		Gson json = new Gson();
		return json.toJson(interfaceContent); 
	}

	
	/* srikant controller end*/
	
	@RequestMapping(value = "IGIInterfacesList.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String IgiInterfaces(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside IGIInterfacesList.htm " + UserId);
		try {
			List<IGIInterface> igiInterfaceList = service.getIGIInterfaceListByLabCode(labcode);
			req.setAttribute("igiInterfaceList", igiInterfaceList);
			req.setAttribute("igiDocId", req.getParameter("igiDocId"));
			String interfaceId = req.getParameter("interfaceId");
			interfaceId = interfaceId!=null?interfaceId:"0";
			
			String parentId = req.getParameter("parentId");
			parentId = parentId!=null?parentId:"0";
			
			if(!interfaceId.equalsIgnoreCase("0")) {
				Long interfaceid = Long.parseLong(interfaceId);
				req.setAttribute("igiInterfaceData", igiInterfaceList.stream().filter(e -> e.getInterfaceId().equals(interfaceid)).findFirst().orElse(null) );
			}
			
			if(!parentId.equalsIgnoreCase("0")) {
				Long parentid = Long.parseLong(parentId);
				req.setAttribute("igiInterfaceParentData", igiInterfaceList.stream().filter(e -> e.getInterfaceId().equals(parentid)).findFirst().orElse(null) );
			}
			
			req.setAttribute("interfaceTypesList", service.getIGIInterfaceTypesList());
			req.setAttribute("interfaceContentList", service.getIGIInterfaceContentList());
			req.setAttribute("connectorMasterList", service.getConnectorMasterList());
			req.setAttribute("interfaceId", interfaceId);
			req.setAttribute("parentId", parentId);
			req.setAttribute("documentNo", req.getParameter("documentNo"));

			return "documents/IGIInterfacesList";
		} catch (Exception e) {
			logger.error(new Date() + "Inside IGIInterfacesList.htm " + UserId);
			e.printStackTrace();
			return "static/Error";
		}

	}

	@RequestMapping(value = "IGIInterfaceDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiInterfaceDetailsSubmit(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside IGIInterfaceDetailsSubmit.htm" + UserId);
		
		try {
			String igiDocId = req.getParameter("igiDocId");
			String interfaceId = req.getParameter("interfaceId");
			String action = req.getParameter("action");
			String parentId = req.getParameter("parentId");
			
			IGIInterface igiInterface = interfaceId.equalsIgnoreCase("0")? new IGIInterface(): service.getIGIInterfaceById(interfaceId);
			igiInterface.setLabCode(LabCode);
			//igiInterface.setInterfaceCode(req.getParameter("interfaceCode"));
			//igiInterface.setInterfaceName(req.getParameter("interfaceName"));
			if(igiInterface.getParentId()==null) {
				igiInterface.setParentId(parentId!=null?Long.parseLong(parentId):0L);
			}
			if(igiInterface.getInterfaceId()==null && igiInterface.getParentId()>0) {
				igiInterface.setInterfaceCode(req.getParameter("interfaceCode"));
				igiInterface.setInterfaceName(req.getParameter("interfaceName"));
			}
			igiInterface.setParameterData(req.getParameter("parameterData"));
			igiInterface.setInterfaceContent(req.getParameter("interfaceContent"));
			igiInterface.setInterfaceType(req.getParameter("interfaceType"));
			igiInterface.setInterfaceSpeed(req.getParameter("interfaceSpeed"));
			igiInterface.setConnectorIdEOne(req.getParameter("connectorIdE1")!=null?Long.parseLong(req.getParameter("connectorIdE1")):0L);
			igiInterface.setConnectorIdETwo(req.getParameter("connectorIdE2")!=null?Long.parseLong(req.getParameter("connectorIdE2")):0L);
			igiInterface.setInterfaceDiagram(req.getParameter("interfaceDiagram"));
			igiInterface.setInterfaceDescription(req.getParameter("interfaceDescription"));
			igiInterface.setIGIDocId(Long.parseLong(igiDocId));
			igiInterface.setCableInfo(req.getParameter("cableInfo"));
			igiInterface.setCableConstraint(req.getParameter("cableConstraint"));
			igiInterface.setCableDiameter(req.getParameter("cableDiameter"));
			igiInterface.setCableDetails(req.getParameter("cableDetails"));
			igiInterface.setCableMaxLength(req.getParameter("cableMaxLength")!=null?Integer.parseInt(req.getParameter("cableMaxLength")): 0);
			igiInterface.setInterfaceLoss(req.getParameter("interfaceLoss")!=null?Integer.parseInt(req.getParameter("interfaceLoss")): 0);
			igiInterface.setCableBendingRadius(req.getParameter("cableBendingRadius")!=null?Double.parseDouble(req.getParameter("cableBendingRadius")): 0);
			if(interfaceId.equalsIgnoreCase("0")) {
				igiInterface.setCreatedBy(UserId);
				igiInterface.setCreatedDate(sdtf.format(new Date()));
				igiInterface.setIsActive(1);
			}else {
				igiInterface.setModifiedBy(UserId);
				igiInterface.setModifiedDate(sdtf.format(new Date()));
			}
			

			long result = service.addIGIInterface(igiInterface);
			
			if (result > 0) {
				redir.addAttribute("result", "Inteface Details "+action+"ed Successfully");
			} else {
				redir.addAttribute("resultfail", "Intefaces "+action+" Unsuccessful");
			}
			redir.addAttribute("igiDocId", igiDocId);
			redir.addAttribute("interfaceId", result);
			return "redirect:/IGIInterfacesList.htm";
		} catch (Exception e) {
			logger.error(new Date() + " Inside IGIInterfaceDetailsSubmit.htm " + UserId);
			e.printStackTrace();
			return "static/Error";
		}

	}

//	@RequestMapping(value="DuplicateInterfaceCodeCheck.htm", method=RequestMethod.GET)
//	public @ResponseBody String duplicateInterfaceCodeCheck(HttpSession ses, HttpServletRequest req) throws Exception {
//		
//		String UserId=(String)ses.getAttribute("Username");
//		logger.info(new Date() +" Inside DuplicateInterfaceCodeCheck.htm "+UserId);
//		Gson json = new Gson();
//		Long duplicate=null;
//		try
//		{	  
//	          duplicate = service.getDuplicateInterfaceCodeCount(req.getParameter("interfaceId"), req.getParameter("interfaceCode"));
//	          
//		}catch (Exception e) {
//			logger.error(new Date() +"Inside DuplicateInterfaceCodeCheck.htm "+UserId ,e);
//			e.printStackTrace(); 
//		}
//		  
//		 return json.toJson(duplicate);    
//	}

	@RequestMapping(value = "IGIDocTransStatus.htm", method = { RequestMethod.GET, RequestMethod.POST })
	public String igiDocTransStatus(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside IGIDocTransStatus.htm" + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			if (docId != null) {
				req.setAttribute("transactionList", service.igiTransactionList(docId, docType));
				req.setAttribute("docId", docId);
				req.setAttribute("docType", docType);
			}
			return "documents/IGIDocTransStatus";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocTransStatus.htm " + UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "IGIDocTransactionDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void igiDocTransactionDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside IGIDocTransactionDownload.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");

			if (docId != null) {
				req.setAttribute("docType", docType);
				req.setAttribute("transactionList", service.igiTransactionList(docId, docType));
			}

			String filename = "Doc_Transaction";
			String path = req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path", path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/IGIDocTransactionDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			HtmlConverter.convertToPdf(html, new FileOutputStream(path + File.separator + filename + ".pdf"));
			PdfWriter pdfw = new PdfWriter(path + File.separator + "merged.pdf");
			PdfReader pdf1 = new PdfReader(path + File.separator + filename + ".pdf");
			PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);
			pdfDocument.close();
			pdf1.close();
			pdfw.close();

			res.setContentType("application/pdf");
			res.setHeader("Content-disposition", "inline;filename=" + filename + ".pdf");
			File f = new File(path + "/" + filename + ".pdf");

			OutputStream out = res.getOutputStream();
			FileInputStream in = new FileInputStream(f);
			byte[] buffer = new byte[4096];
			int length;
			while ((length = in.read(buffer)) > 0) {
				out.write(buffer, 0, length);
			}
			in.close();
			out.flush();
			out.close();

			Path pathOfFile2 = Paths.get(path + File.separator + filename + ".pdf");
			Files.delete(pathOfFile2);

		} catch (Exception e) {
			logger.error(new Date() + " Inside IGIDocTransactionDownload.htm " + UserId, e);
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "IGIDocumentApprovalSubmit.htm", method = { RequestMethod.GET, RequestMethod.POST })
	public String igiDocumentApprovalSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + "Inside IGIDocumentApprovalSubmit.htm" + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String action = req.getParameter("Action");
			String remarks = req.getParameter("remarks");

			PfmsIGIDocument igiDocument = service.getPfmsIGIDocumentById(docId);
			String statusCode = igiDocument.getIGIStatusCode();


			List<String> igiforwardstatus = Arrays.asList("RIN", "RRR", "RRA", "REV");

			long result = service.igiDocumentApprovalForward(docId, docType, action, remarks, EmpId, labcode, UserId);

//			if (result != 0 && reqInitiation.getReqStatusCode().equalsIgnoreCase("RFA") && reqInitiation.getReqStatusCodeNext().equalsIgnoreCase("RAM")) {
//				// PDF Freeze
//				service.igiDocPdfFreeze(req, resp, docId, labcode);
//			}

			if (action.equalsIgnoreCase("A")) {
				if (igiforwardstatus.contains(statusCode)) {
					if (result != 0) {
						redir.addAttribute("result", "IGI Document Forwarded Successfully");
					} else {
						redir.addAttribute("resultfail", "IGI Document Forward Unsuccessful");
					}
					return "redirect:/IGIDocumentList.htm";
				} else if (statusCode.equalsIgnoreCase("RFW")) {
					if (result != 0) {
						redir.addAttribute("result", "IGI Document Recommende d Successfully");
					} else {
						redir.addAttribute("resultfail", "IGI Document Recommend Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				} else if (statusCode.equalsIgnoreCase("RFR")) {
					if (result != 0) {
						redir.addAttribute("result", "IGI Document Approved Successfully");
					} else {
						redir.addAttribute("resultfail", "IGI Document Approve Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				}
			} else if (action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if (result != 0) {
					redir.addAttribute("result", action.equalsIgnoreCase("R") ? "IGI Document Returned Successfully"
							: "IGI Document Disapproved Successfully");
				} else {
					redir.addAttribute("resultfail", action.equalsIgnoreCase("R") ? "IGI Document Return Unsuccessful"
							: "IGI Document Disapprove Unsuccessful");
				}
			}
			return "redirect:/DocumentApprovals.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocumentApprovalSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="IGIDocumentUserRevoke.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String igiDocumentUserRevoke(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside IGIDocumentUserRevoke.htm "+UserId);
		try {
			String igiDocId = req.getParameter("igiDocId");
            
			long count = service.igiDocumentUserRevoke(igiDocId, UserId, EmpId);
			
			if (count > 0) {
				redir.addAttribute("result", "IGI Document Revoked Successfully");
			}
			else {
				redir.addAttribute("resultfail", "IGI Document Revoke Unsuccessful");	
			}	

			return "redirect:/IGIDocumentList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside IGIDocumentUserRevoke.htm "+UserId, e);
			return "static/Error";			
		}

	}
	
	@RequestMapping(value="IGILogicalInterfacesList.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiLogicalInterfacesList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGILogicalInterfacesList.htm " + UserId);
		try {
			List<IGILogicalInterfaces> logicalInterfaceList = service.getIGILogicalInterfaces();
			
			String logicalInterfaceId = req.getParameter("logicalInterfaceId");
			logicalInterfaceId = logicalInterfaceId!=null?logicalInterfaceId:"0";
			
			if(!logicalInterfaceId.equalsIgnoreCase("0")) {
				long logicalInterfaceid = Long.parseLong(logicalInterfaceId);
				req.setAttribute("igiLogicalInterfaceData", logicalInterfaceList.stream().filter(e -> e.getLogicalInterfaceId()==logicalInterfaceid).findFirst().orElse(null) );
			}

			req.setAttribute("logicalInterfaceList", logicalInterfaceList);
			req.setAttribute("logicalChannelList", service.getIGILogicalChannelList());
			req.setAttribute("fieldMasterList", service.fieldMasterList());
			req.setAttribute("dataTypeMasterList", service.dataTypeMasterList());
			req.setAttribute("fieldDescriptionList", service.getIGIFieldDescriptionList());
			req.setAttribute("igiDocId", req.getParameter("igiDocId"));
			req.setAttribute("logicalInterfaceId", logicalInterfaceId);
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("logicalChannelId", req.getParameter("logicalChannelId"));
			req.setAttribute("fieldGroupList", service.getFieldGroupMasterList());
			
			return "documents/IGILogicalInterfaceList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGILogicalInterfacesList.htm " + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "IGILogicalInterfaceDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiLogicalInterfaceDetailsSubmit(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGILogicalInterfaceDetailsSubmit.htm" + UserId);
		
		try {
			String igiDocId = req.getParameter("igiDocId");
			String logicalInterfaceId = req.getParameter("logicalInterfaceId");
			String action = req.getParameter("action");
			String logicalChannelId = req.getParameter("logicalChannelId");
			String[] logicalChannel = logicalChannelId!=null?logicalChannelId.split("/"): null;
			
			IGILogicalInterfaces logicalInterface = logicalInterfaceId.equalsIgnoreCase("0")? new IGILogicalInterfaces(): service.getIGILogicalInterfaceById(logicalInterfaceId);

			logicalInterface.setMsgType(req.getParameter("msgType"));
			logicalInterface.setMsgName(req.getParameter("msgName"));
			logicalInterface.setLogicalChannelId(logicalChannel!=null?Long.parseLong(logicalChannel[0]):0L);
			logicalInterface.setDataRate(req.getParameter("dataRate"));
			logicalInterface.setMsgDescription(req.getParameter("msgDescription"));
			logicalInterface.setProtocals(req.getParameter("protocols"));
			logicalInterface.setAdditionalInfo(req.getParameter("additionalInfo"));
			String msgLength = req.getParameter("msgLength");
			logicalInterface.setMsgLength(msgLength!=null && !msgLength.isEmpty()? Integer.parseInt(msgLength): 0);
			logicalInterface.setMsgNo(req.getParameter("msgNo"));
			
			if(logicalInterface.getLogicalInterfaceId()==null) {
				int count = service.getLogicalInterfaceCountByType(logicalInterface.getLogicalChannelId()+"", logicalInterface.getMsgType());
				
				String seqCount = String.format("%03d", count + 1);
				String channelCode = logicalChannel!=null?logicalChannel[1]:"-";
				
				logicalInterface.setMsgCode(channelCode + "_" + logicalInterface.getMsgType().substring(0,3).toUpperCase() + "_" + seqCount );
				//String msgTypeCode = logicalInterface.getMsgType().equalsIgnoreCase("Command")?"Cmd": logicalInterface.getMsgType().substring(0,3);
				//logicalInterface.setMsgName(msgTypeCode+req.getParameter("msgName"));
				logicalInterface.setCreatedBy(UserId);
				logicalInterface.setCreatedDate(sdtf.format(new Date()));
				logicalInterface.setIsActive(1);
			}else {
				logicalInterface.setModifiedBy(UserId);
				logicalInterface.setModifiedDate(sdtf.format(new Date()));
				
				// Remove Existing Field Description
				service.removeIGIFieldDescription(logicalInterfaceId);
			}

			long result = service.addIGILogicalInterfaces(logicalInterface);
			
			// Adding Field Description
			String[] fieldGroupIds = req.getParameterValues("fieldGroupId");
			String[] fieldMasterIds = req.getParameterValues("fieldMasterId");
			
			for(int i=0; i<fieldMasterIds.length; i++) {
				IGIFieldDescription fieldDesc = new IGIFieldDescription();
				fieldDesc.setLogicalInterfaceId(result);
				fieldDesc.setFieldGroupId(fieldGroupIds!=null?Long.parseLong(fieldGroupIds[i]):0L);
				fieldDesc.setFieldMasterId(fieldMasterIds!=null?Long.parseLong(fieldMasterIds[i]):0L);
				fieldDesc.setCreatedBy(UserId);
				fieldDesc.setCreatedDate(sdtf.format(new Date()));
				fieldDesc.setIsActive(1);
				
				service.addIGIFieldDescription(fieldDesc);
			}
			
			if (result > 0) {
				redir.addAttribute("result", "Inteface Details "+action+"ed Successfully");
			} else {
				redir.addAttribute("resultfail", "Intefaces "+action+" Unsuccessful");
			}
			redir.addAttribute("igiDocId", igiDocId);
			redir.addAttribute("logicalInterfaceId", result);
			return "redirect:/IGILogicalInterfacesList.htm";
		} catch (Exception e) {
			logger.error(new Date() + " Inside IGILogicalInterfaceDetailsSubmit.htm " + UserId);
			e.printStackTrace();
			return "static/Error";
		}

	}

	@RequestMapping(value="IGILogicalChannelDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiLogicalChannelDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGILogicalChannelDetailsSubmit.htm " + UserId);
		try {
			
			String logicalChannelId = req.getParameter("logicalChannelId");
			String source = req.getParameter("source");
			String destination = req.getParameter("destination");
			String[] sourcesplit = source!=null?source.split("/"): null;
			String[] destsplit = destination!=null?destination.split("/"): null;
			IGILogicalChannel logicalChannel = Long.parseLong(logicalChannelId)!=0 ?service.getIGILogicalChannelById(logicalChannelId) 
																					: new IGILogicalChannel();
			logicalChannel.setDescription(req.getParameter("description"));
			String action = "Add";
			if(Long.parseLong(logicalChannelId)==0) {
				logicalChannel.setChannelCode(req.getParameter("channelCode"));
				String logicalChannelName = "";
				if(sourcesplit!=null && destsplit!=null) {
					
					int seqCount = service.getLogicalChannelCount();
					
					logicalChannelName = sourcesplit[1]+"_"+destsplit[1]+"_"+logicalChannel.getChannelCode()+"_L-"+(seqCount+1);
					logicalChannel.setSourceId(Long.parseLong(sourcesplit[0]));
					logicalChannel.setDestinationId(Long.parseLong(destsplit[0]));
				}
				logicalChannel.setLogicalChannel(logicalChannelName);
				logicalChannel.setCreatedBy(UserId);
				logicalChannel.setCreatedDate(sdtf.format(new Date()));
				logicalChannel.setIsActive(1);
			}else {
				logicalChannel.setModifiedBy(UserId);
				logicalChannel.setModifiedDate(sdtf.format(new Date()));
				action = "Edit";
			}
			
			long result = service.addIGILogicalChannel(logicalChannel);
			
			if (result > 0) {
				redir.addAttribute("result", "Logical Channel "+action+"ed Successfully");
			} else {
				redir.addAttribute("resultfail", "Logical Channel "+action+" Unsuccessful");
			}
			
			return "redirect:/LogicalChannelMaster.htm";
		}catch (Exception e) {
			logger.error(new Date() + " Inside IGILogicalChannelDetailsSubmit.htm " + UserId);
			e.printStackTrace();
			return "static/Error";
		}
	}

	@RequestMapping(value = "IGILogicalChannelDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiLogicalChannelDelete(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGILogicalChannelDelete.htm " + UserId);
		try {
			String logicalChannelId = req.getParameter("logicalChannelId");
			
			long result = service.deleteIGILogicalChannelById(logicalChannelId);

			if (result > 0) {
				redir.addAttribute("result", "Logical Channel Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Logical Channel Delete Unsuccessful");
			}

			return "redirect:/LogicalChannelMaster.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGILogicalChannelDelete.htm " + UserId);
			return "static/Error";
		}
	}

	@RequestMapping(value="LogicalChannelMaster.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String logicalChannelMasterList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside LogicalChannelMaster.htm " + UserId);

		try {
			String action = req.getParameter("action");
			if(action!=null && action.equalsIgnoreCase("Add")) {
				req.setAttribute("systemProductTreeAllList", service.getSystemProductTreeAllList());
				return "documents/LogicalChannelAddEdit";
			}else if(action!=null && action.equalsIgnoreCase("Edit")) {
				String logicalChannelId = req.getParameter("logicalChannelId");
				req.setAttribute("igiLogicalChannel", service.getIGILogicalChannelById(logicalChannelId));
				req.setAttribute("systemProductTreeAllList", service.getSystemProductTreeAllList());
				return "documents/LogicalChannelAddEdit";
			}else {
				req.setAttribute("logicalChannelList", service.getLogicalChannelList());
				return "documents/LogicalChannelList";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside LogicalChannelMaster.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "FieldMaster.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String fieldMaster(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside FieldMaster.htm" + UserId);
		try {
			String action = req.getParameter("action");
			req.setAttribute("fieldGroupList", service.getFieldGroupMasterList());
			req.setAttribute("fieldGroupId", req.getParameter("fieldGroupId"));
			
			if(action!=null && action.equalsIgnoreCase("Add")) {
				req.setAttribute("dataTypeMasterList", service.dataTypeMasterList());
				return "documents/FieldMasterAddEdit";
			}else if(action!=null && action.equalsIgnoreCase("Edit")) {
				String fieldMasterId = req.getParameter("fieldMasterId");
				req.setAttribute("dataTypeMasterList", service.dataTypeMasterList());
				req.setAttribute("fieldMaster", service.getFieldMasterById(fieldMasterId));
				req.setAttribute("fieldGroupLinkedList", service.getFieldGroupLinkedList(fieldMasterId));
				return "documents/FieldMasterAddEdit";
			}else {
				req.setAttribute("fieldMasterList", service.fieldMasterList());
				return "documents/FieldMasterList";
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside FieldMaster.htm " + UserId, e);
			return "static/Error";

		}
	}
	
	@RequestMapping(value="FieldMasterDetailsSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String fieldMasterDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date()+ " Inside FieldMasterDetailsSubmit.htm "+UserId);	
		try {
			
			String action =req.getParameter("action");
			String fieldMasterId =req.getParameter("fieldMasterId");
			String dataTypeMasterId =req.getParameter("dataTypeMasterId");

			FieldMaster field = fieldMasterId.equalsIgnoreCase("0") ? new FieldMaster() :  service.getFieldMasterById(fieldMasterId);
			
			field.setFieldName(req.getParameter("fieldName"));
			field.setFieldShortName(req.getParameter("fieldShortName"));
			field.setFieldCode(req.getParameter("fieldCode"));
			field.setFieldDesc(req.getParameter("fieldDesc"));
			field.setDataTypeMasterId(dataTypeMasterId!=null?Long.parseLong(dataTypeMasterId):0L);
			field.setTypicalValue(req.getParameter("typicalValue"));
			field.setFieldMinValue(req.getParameter("minValue"));
			field.setFieldMaxValue(req.getParameter("maxValue"));
			field.setInitValue(req.getParameter("initValue"));
			field.setQuantum(req.getParameter("quantum"));
			field.setFieldUnit(req.getParameter("unit"));
			field.setRemarks(req.getParameter("remarks"));

			if (fieldMasterId.equalsIgnoreCase("0")) {
				field.setCreatedBy(UserId);
				field.setCreatedDate(sdtf.format(new Date()));
				field.setIsActive(1);
			} else {
				field.setModifiedBy(UserId);
				field.setModifiedDate(sdtf.format(new Date()));
				
				// Remove Existing Linked Field Groups
				service.removeFieldGroupLinked(fieldMasterId);
				
			}
			
			long result = service.addFieldMaster(field);
			
			String[] fieldGroupIds = req.getParameterValues("fieldGroupId");

			if(fieldGroupIds!=null && fieldGroupIds.length>0) {
				for(int i=0; i<fieldGroupIds.length; i++) {
					if(fieldGroupIds[i]!=null && !fieldGroupIds[i].equalsIgnoreCase("0")) {
						FieldGroupLinked linked = new FieldGroupLinked();
						linked.setFieldMasterId(result);
						linked.setFieldGroupId(Long.parseLong(fieldGroupIds[i]));
						linked.setCreatedBy(UserId);
						linked.setCreatedDate(sdtf.format(new Date()));
						linked.setIsActive(1);
						
						service.addFieldGroupLinked(linked);
					}
				}
			}
			
			if (result!=0) {
				redir.addAttribute("result", "Field Master "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Field Master "+action+" Unsuccessful");	
			}
					
			return "redirect:/FieldMaster.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside FieldMasterDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value = "FieldNameDuplicateCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String fieldNameDuplicateCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		Long count = null;
		logger.info(new Date() +"Inside FieldNameDuplicateCheck.htm "+UserId);
		try
		{	  
			count = service.getDuplicateFieldNameCount(req.getParameter("fieldName"),req.getParameter("fieldMasterId"));
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside FieldNameDuplicateCheck.htm "+UserId,e);
		}
		Gson json = new Gson();
		return json.toJson(count); 
	}

	@RequestMapping(value = "DataTypeMaster.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String dataTypeMasterList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside DataTypeMaster.htm" + UserId);
		try {
			req.setAttribute("dataTypeMasterList", service.dataTypeMasterList());
			return "documents/DataTypeMasterList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside DataTypeMaster.htm" + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "DataTypeMasterDetailsSubmit.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String DataTypeMasterAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside DataTypeMasterAddSubmit.htm" + UserId);
		try {
			String dataTypeMasterId = req.getParameter("dataTypeMasterId");
			String dataLength=req.getParameter("dataLength");
			String action =req.getParameter("action");
			
			DataTypeMaster dataTypeMaster = dataTypeMasterId.equalsIgnoreCase("0") ? new DataTypeMaster() :  service.getDataTypeMasterById(Long.parseLong(dataTypeMasterId));
			
			dataTypeMaster.setDataTypePrefix(req.getParameter("dataTypePrefix"));
			dataTypeMaster.setDataLength(dataLength!=null && !dataLength.isEmpty() ? Integer.parseInt(dataLength): 0);	
			dataTypeMaster.setAliasName(req.getParameter("aliasName"));
			dataTypeMaster.setDataStandardName(req.getParameter("dataStandardName"));
			
			if (dataTypeMasterId.equalsIgnoreCase("0")) {
				dataTypeMaster.setCreatedBy(UserId);
				dataTypeMaster.setCreatedDate(sdtf.format(new Date()));
				dataTypeMaster.setIsActive(1);
			} else {
				dataTypeMaster.setModifiedBy(UserId);
				dataTypeMaster.setModifiedDate(sdtf.format(new Date()));
			}
			
			long result=service.addDataTypeMaster(dataTypeMaster);
			
			if (result!=0) {
				redir.addAttribute("result", "Data Type "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Data Type "+action+" Unsuccessful");	
			}
			return "redirect:/DataTypeMaster.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside DataTypeMasterAddSubmit.htm" + UserId, e);
			return "static/Error";
		}

	}

	@RequestMapping(value="IGILogicalInterfaceMatrixDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiLogicalInterfaceMatrixDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGILogicalInterfaceMatrixDetails.htm " + UserId);
		try {
			req.setAttribute("igiLogicalInterfaceConnectionList", service.getIGILogicalInterfaceConnectionList());
			req.setAttribute("systemProductTreeAllList", service.getSystemProductTreeAllList());
			req.setAttribute("igiDocId", req.getParameter("igiDocId"));
			return "documents/LogicalInterfaceMatrixDetails";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGILogicalInterfaceMatrixDetails.htm " + UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "IGIFieldGroupDetailsSubmit.htm", method = {RequestMethod.GET})
	public @ResponseBody String igiFieldGroupDetailsSubmit(HttpServletRequest req, HttpSession ses) throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIFieldGroupDetailsSubmit.htm "+Username);
		Gson json = new Gson();
		Object[] data = new Object[4];
		try {
			String groupName = req.getParameter("groupName");
			String groupCode = req.getParameter("groupCode");
			String groupType = req.getParameter("groupType");
			
			FieldGroupMaster fieldGroup = new FieldGroupMaster();
			fieldGroup.setGroupName(groupName);
			fieldGroup.setGroupCode(groupCode);
			fieldGroup.setGroupType(groupType);
			fieldGroup.setCreatedBy(Username);
			fieldGroup.setCreatedDate(sdtf.format(new Date()));
			fieldGroup.setIsActive(1);
			
			Long fieldGroupId = service.addFieldGroupMaster(fieldGroup);
			data[0] = fieldGroupId;
			data[1] = groupName;
			data[2] = groupCode;
			data[3] = groupType;
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside IGIFieldGroupDetailsSubmit.htm "+Username, e);
		}
		return json.toJson(data);
	}
	
	@RequestMapping(value="IGIFieldGroupEditSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiFieldGroupEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIFieldGroupEditSubmit.htm "+UserId);
		try {
			String fieldGroupId = req.getParameter("fieldGroupId");
			FieldGroupMaster fieldGroup = service.getFieldGroupMasterById(fieldGroupId!=null?Long.parseLong(fieldGroupId):0L);
			fieldGroup.setGroupName(req.getParameter("groupName"));
			fieldGroup.setGroupCode(req.getParameter("groupCode"));
			fieldGroup.setGroupType(req.getParameter("groupType"));
			fieldGroup.setModifiedBy(UserId);
			fieldGroup.setModifiedDate(sdtf.format(new Date()));
			fieldGroup.setIsActive(1);
			
			Long result = service.addFieldGroupMaster(fieldGroup);
			
			if (result!=0) {
				redir.addAttribute("result", "Field Group Master Edited Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Field Group Master Edit Unsuccessful");	
			}
			redir.addAttribute("fieldGroupId", fieldGroupId);
			
			return "redirect:/FieldMaster.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIFieldGroupEditSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "GroupNameDuplicateCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String groupNameDuplicateCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		Long count = null;
		logger.info(new Date() +"Inside GroupNameDuplicateCheck.htm "+UserId);
		try
		{	  
			count = service.getDuplicateGroupNameCount(req.getParameter("groupName"),req.getParameter("fieldGroupId"));
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside GroupNameDuplicateCheck.htm "+UserId,e);
		}
		Gson json = new Gson();
		return json.toJson(count); 
	}

	@RequestMapping(value = "GroupCodeDuplicateCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String groupCodeDuplicateCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		Long count = null;
		logger.info(new Date() +"Inside GroupCodeDuplicateCheck.htm "+UserId);
		try
		{	  
			count = service.getDuplicateGroupCodeCount(req.getParameter("groupCode"),req.getParameter("fieldGroupId"));
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +"Inside GroupCodeDuplicateCheck.htm "+UserId,e);
		}
		Gson json = new Gson();
		return json.toJson(count); 
	}
	
	@RequestMapping(value = "ConnectorMaster.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String connectorMasterList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside ConnectorMaster.htm" + UserId);
		try {
			req.setAttribute("connectorMasterList", service.getConnectorMasterList());
			req.setAttribute("connectorAttachList", service.getIGIConnectorAttachList());
			return "documents/ConnectorMasterList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ConnectorMaster.htm" + UserId, e);
			return "static/Error";
		}
		
	}

	@RequestMapping(value = "ConnectorMasterDetailsSubmit.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String connectorMasterAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside ConnectorMasterDetailsSubmit.htm.htm" + UserId);
		try {
			String connectorId = req.getParameter("connectorId");
			String pinCount = req.getParameter("pinCount");
			String action =req.getParameter("action");
			
			IGIConnector connector = connectorId.equalsIgnoreCase("0") ? new IGIConnector() :  service.getIGIConnectorById(Long.parseLong(connectorId));
			
			connector.setPartNo(req.getParameter("partNo"));
			connector.setConnectorMake(req.getParameter("connectorMake"));
			connector.setStandardName(req.getParameter("standardName"));
			connector.setProtection(req.getParameter("protection"));
			connector.setRefInfo(req.getParameter("refInfo"));
			connector.setRemarks(req.getParameter("remarks"));
			connector.setPinCount(pinCount!=null && !pinCount.isEmpty() ? Integer.parseInt(pinCount): 0);	

			if (connectorId.equalsIgnoreCase("0")) {
				connector.setCreatedBy(UserId);
				connector.setCreatedDate(sdtf.format(new Date()));
				connector.setIsActive(1);
			} else {
				connector.setModifiedBy(UserId);
				connector.setModifiedDate(sdtf.format(new Date()));
			}
			
			long result=service.addIGIConnector(connector);
			
			if (result!=0) {
				redir.addAttribute("result", "Connector Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Connector Details "+action+" Unsuccessful");	
			}
			return "redirect:/ConnectorMaster.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ConnectorMasterDetailsSubmit.htm.htm" + UserId, e);
			return "static/Error";
		}

	}
	
	@RequestMapping(value = "ConstantsMaster.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String constantsMaster(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside ConstantsMaster.htm" + UserId);
		try {
			req.setAttribute("constantsMasterList", service.getIGIConstantsMasterList());
			return "documents/ConstantsMasterList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ConstantsMaster.htm" + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "ConstantsMasterDetailsSubmit.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String constantsMasterAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside ConstantsMasterDetailsSubmit.htm" + UserId);
		try {
			String constantId = req.getParameter("constantId");
			String action =req.getParameter("action");
			
			IGIConstants constant = constantId.equalsIgnoreCase("0") ? new IGIConstants() :  service.getIGIConstantsById(Long.parseLong(constantId));
			
			constant.setGroupName(req.getParameter("groupName"));
			constant.setConstantName(req.getParameter("constantName"));
			constant.setConstantValue(req.getParameter("constantValue"));
			
			if (constantId.equalsIgnoreCase("0")) {
				constant.setCreatedBy(UserId);
				constant.setCreatedDate(sdtf.format(new Date()));
				constant.setIsActive(1);
			} else {
				constant.setModifiedBy(UserId);
				constant.setModifiedDate(sdtf.format(new Date()));
			}
			
			long result=service.addIGIConstants(constant);
			
			if (result!=0) {
				redir.addAttribute("result", "Constant Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Constant Details "+action+" Unsuccessful");	
			}
			return "redirect:/ConstantsMaster.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ConstantsMasterDetailsSubmit.htm" + UserId, e);
			return "static/Error";
		}
		
	}

	@RequestMapping(value = "IGIConnectorAttachmentSubmit.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String igiConnectorAttachmentSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir, @RequestPart(name = "attachment", required = false) MultipartFile[] attachment) {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + "Inside IGIConnectorAttachmentSubmit.htm" + UserId);
		try {
			String connectorId = req.getParameter("connectorId");
			long result = 0;
			for(int i=0;i<attachment.length ;i++) {
				IGIConnectorAttach connectorAttach = new IGIConnectorAttach();
				connectorAttach.setConnectorId(connectorId!=null?Long.parseLong(connectorId):0L);
				connectorAttach.setCreatedBy(UserId);
				connectorAttach.setCreatedDate(sdtf.format(new Date()));
				connectorAttach.setIsActive(1);
				result = service.addIGIConnectorAttach(connectorAttach, attachment[i], labcode);
			}
			
			if (result!=0) {
				redir.addAttribute("result", "Connector Images Submitted Successfully");
			}else {
				redir.addAttribute("resultfail", "Connector Images Submit Unsuccessful");	
			}
			
			return "redirect:/ConnectorMaster.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIConnectorAttachmentSubmit.htm" + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "IGIConnectorAttachmentDelete.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String igiConnectorAttachmentDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + "Inside IGIConnectorAttachmentDelete.htm" + UserId);
		try {
			String connectorAttachId = req.getParameter("connectorAttachId");
			
			IGIConnectorAttach connectorAttach = connectorAttachId.equalsIgnoreCase("0") ? new IGIConnectorAttach() : service.getIGIConnectorAttachById(connectorAttachId);
			connectorAttach.setModifiedBy(UserId);
			connectorAttach.setModifiedDate(sdtf.format(new Date()));
			connectorAttach.setIsActive(0);
			
			long result = service.addIGIConnectorAttach(connectorAttach, null, labcode);
			
			if (result!=0) {
				redir.addAttribute("result", "Connector Image Deleted Successfully");
			}else {
				redir.addAttribute("resultfail", "Connector Image Delete Unsuccessful");	
			}
			
			return "redirect:/ConnectorMaster.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIConnectorAttachmentDelete.htm" + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "IGIConnectorDrawingAttachDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void igiConnectorDrawingAttachDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside IGIConnectorDrawingAttachDownload.htm "+UserId);
		try
		{
			res.setContentType("application/pdf");	
			
			String fileName = req.getParameter("drawingAttach");

			String filePath = Paths.get(uploadpath, labcode, "IGI", "Connectors").toString(); 
			
			Path filepath = Paths.get(filePath, fileName);
			File my_file = filepath.toFile();
			
			res.setHeader("Content-disposition","inline; filename="+fileName);
	        String mimeType = getMimeType(my_file.getName()); 
	        res.setContentType(mimeType);
	        
	        OutputStream out = res.getOutputStream();
	        FileInputStream in = new FileInputStream(my_file);
	        byte[] buffer = new byte[4096];
	        int length;
	        while ((length = in.read(buffer)) > 0) {
	            out.write(buffer, 0, length);
	        }
	        in.close();
	        out.close();
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside IGIConnectorDrawingAttachDownload.htm "+UserId,e);
		}
	}
	
	/* ************************************************ IGI Document End ***************************************************** */
	
	/* ************************************************ ICD Document ***************************************************** */

	@RequestMapping(value = "ICDDocumentList.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdDocumentList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String LoginType = (String) ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside ICDDocumentList.htm " + UserId);

		try {
			String projectType = req.getParameter("projectType");
			projectType = projectType != null ? projectType : "M";
			String initiationId = "0";
			String projectId = "0";
			String productTreeMainId = req.getParameter("productTreeMainId");
			
			if (projectType.equalsIgnoreCase("M")) {

				projectId = req.getParameter("projectId");
				//productTreeMainId = req.getParameter("productTreeMainId");
				List<Object[]> projectList = projectservice.LoginProjectDetailsList(EmpId, LoginType, labcode);
				
				projectId = projectId != null ? projectId : (projectList.size() > 0 ? projectList.get(0)[0].toString() : "0");
				productTreeMainId = productTreeMainId != null ? productTreeMainId : "0";
				
				req.setAttribute("projectDetails", projectservice.getProjectDetails(labcode, projectId, "E"));
				req.setAttribute("projectList", projectList);
				req.setAttribute("productTreeAllList", service.getProductTreeAllList(projectId, "0"));
				
			}else {
				initiationId = req.getParameter("initiationId");
				//productTreeMainId = req.getParameter("productTreeMainId");
				List<Object[]> preProjectList = reqservice.getPreProjectList(LoginType, labcode, EmpId);
				initiationId = initiationId != null ? initiationId : (preProjectList.size() > 0 ? preProjectList.get(0)[0].toString() : "0");
				productTreeMainId = productTreeMainId != null ? productTreeMainId : "0";
				
				req.setAttribute("projectDetails", projectservice.getProjectDetails(labcode, initiationId, "P"));
				req.setAttribute("preProjectList", preProjectList);
				req.setAttribute("productTreeAllList", service.getProductTreeAllList("0", initiationId));
			}
			req.setAttribute("projectId", projectId);
			req.setAttribute("initiationId", initiationId);
			req.setAttribute("productTreeMainId", productTreeMainId);
			req.setAttribute("projectType", projectType);
			
			List<Object[]> icdDocumentList = service.getICDDocumentList(projectId, initiationId, productTreeMainId);
			req.setAttribute("icdDocumentList", icdDocumentList);

			if(icdDocumentList!=null && icdDocumentList.size()>0) {
				req.setAttribute("icdDocumentSummaryList", service.getDocumentSummaryList(icdDocumentList.get(icdDocumentList.size()-1)[0].toString(), "B"));
			}
			
			return "documents/ICDDocumentList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDDocumentList.htm " + UserId, e);
			return "static/Error";
		}

	}

	@RequestMapping(value = "ICDDocumentAdd.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdDocumentAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside ICDDocumentAdd.htm" + UserId);

		try {
			String projectType = req.getParameter("projectType");
			String projectId = req.getParameter("projectId");
			String initiationId = req.getParameter("initiationId");
			String productTreeMainId = req.getParameter("productTreeMainId");
			String isAmend = req.getParameter("isAmend");
			String icdDocId = req.getParameter("icdDocId");
			
			PfmsICDDocument icdDocument = PfmsICDDocument.builder()
											.ProjectId(projectId!=null?Long.parseLong(projectId):0L)
											.InitiationId(initiationId!=null?Long.parseLong(initiationId):0L)
											.ProductTreeMainId(productTreeMainId!=null?Long.parseLong(productTreeMainId):0L)
											.ICDVersion(req.getParameter("version"))
											.LabCode(labcode)
											.InitiatedBy(EmpId)
											.InitiatedDate(sdf.format(new Date()))
											.ICDStatusCode("RIN")
											.ICDStatusCodeNext("RIN")
											.CreatedBy(UserId)
											.CreatedDate(sdtf.format(new Date()))
											.IsActive(1)
										.build();
			
			long result = service.addPfmsICDDocument(icdDocument);
			
			if(isAmend!=null && isAmend.equalsIgnoreCase("Y")) {
				service.icdDocumentApprovalForward(icdDocId, "B", "A", req.getParameter("remarks"), EmpId, labcode, UserId);
			}
			
			// Transaction 
			service.addPfmsIGITransaction(result, "B", "RIN", null , Long.parseLong(EmpId));
			
			
			
			if (result > 0) {
				redir.addAttribute("result", "ICD Document Data Submitted Successfully");
			} else {
				redir.addAttribute("resultfail", "ICD Document Data Submit Unsuccessful");
			}
			redir.addAttribute("projectType", projectType);
			redir.addAttribute("projectId", projectId);
			redir.addAttribute("initiationId", initiationId);
			redir.addAttribute("productTreeMainId", productTreeMainId);
			return "redirect:/ICDDocumentList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDDocumentAdd.htm " + UserId, e);
			return "static/Error";

		}

	}
	
	@RequestMapping(value = "ICDDocumentDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdDocumentDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside ICDDocumentDetails.htm " + UserId);
		try {
			String icdDocId = req.getParameter("icdDocId");
			PfmsICDDocument icdDocument = service.getPfmsICDDocumentById(icdDocId);
			req.setAttribute("icdDocument", icdDocument);
			req.setAttribute("version", icdDocument!=null ?icdDocument.getICDVersion():"1.0");
			
			icdDocId = service.getFirstVersionICDDocId(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+"", icdDocument.getProductTreeMainId()+"")+"";
			
			String projectType = icdDocument.getProjectId()!=0?"E":"M";
			req.setAttribute("projectType", projectType);
			req.setAttribute("projectDetails", projectservice.getProjectDetails(labcode, (icdDocument.getProjectId()!=0?icdDocument.getProjectId()+"":icdDocument.getInitiationId()+"") , projectType));
			
			req.setAttribute("icdDocId", icdDocId);
			req.setAttribute("icdDocumentSummaryList", service.getDocumentSummaryList(icdDocId, "B"));
			req.setAttribute("totalEmployeeList", projectservice.EmployeeList(labcode));
			req.setAttribute("memberList", service.getDocumentMemberList(icdDocId, "B"));
			req.setAttribute("employeeList", service.getDocmployeeListByDocId(labcode, icdDocId, "B"));
			req.setAttribute("shortCodesList", service.getIGIDocumentShortCodesList());
			req.setAttribute("shortCodesLinkedList", service.getIGIShortCodesLinkedListByType(icdDocId, "B"));
			req.setAttribute("docTempAttributes", projectservice.DocTempAttributes());
			req.setAttribute("labDetails", projectservice.LabListDetails(labcode));
			req.setAttribute("lablogo",  logoUtil.getLabLogoAsBase64String(labcode)); 
			req.setAttribute("drdologo", logoUtil.getDRDOLogoAsBase64String());
			req.setAttribute("igiInterfaceList", service.getIGIInterfaceListByLabCode(labcode));
			req.setAttribute("applicableDocsList", service.getStandardDocuments());
			req.setAttribute("icdApplicableDocsList", service.getIGIApplicableDocs(icdDocId, "B"));
			req.setAttribute("interfaceTypesList", service.getIGIInterfaceTypesList());
			req.setAttribute("interfaceContentList", service.getIGIInterfaceContentList());
			req.setAttribute("isPdf", req.getParameter("isPdf"));
			req.setAttribute("igiDocumentIntroductionList", service.getIGIDocumentIntroductionList());
			req.setAttribute("mechanicalInterfacesList", service.getICDMechInterfaceConnectionList(icdDocId));
			req.setAttribute("connectorMasterList", service.getConnectorMasterList());
			req.setAttribute("allICDConnectorList", service.getAllICDConnectorList());
			req.setAttribute("filePath", uploadpath);
			
			String pdfForSystem = req.getParameter("pdfForSystem");
			String systemId = req.getParameter("systemId");
			List<Object[]> productTreeAllList = service.getProductTreeAllList(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+"");
			List<ICDConnectionDTO> icdConnectionsList = service.getICDConnectionsList(icdDocId);
			
			if (pdfForSystem != null && pdfForSystem.equalsIgnoreCase("Y")) {
			    icdConnectionsList = icdConnectionsList.stream()
			        				.filter(e -> Arrays.stream(e.getSubSystemIdsS1().split(",")).map(String::trim).anyMatch(id -> id.equals(systemId)) ||
			            						Arrays.stream(e.getSubSystemIdsS2().split(",")).map(String::trim).anyMatch(id -> id.equals(systemId)) )
			        				.collect(Collectors.toList());
			}
			
			// 1. All subsystem IDs (split and converted to Long)
			Set<Long> filterIds = icdConnectionsList.stream()
								    .flatMap(e -> Stream.of(e.getSubSystemIdsS1(), e.getSubSystemIdsS2()))
								    .filter(Objects::nonNull)
								    .flatMap(s -> Arrays.stream(s.split(",")))
								    .map(String::trim)
								    .filter(str -> !str.isEmpty())
								    .map(Long::valueOf)
								    .collect(Collectors.toSet());

			// 2. Internal: ElementTypes both must be "I", split values
			Set<Long> filterIdsInternal = icdConnectionsList.stream()
										    .filter(e -> allValuesAre("I", e.getElementTypesS1()))
										    .filter(e -> allValuesAre("I", e.getElementTypesS2()))
										    .flatMap(e -> Stream.of(e.getSubSystemIdsS1(), e.getSubSystemIdsS2()))
										    .filter(Objects::nonNull)
										    .flatMap(s -> Arrays.stream(s.split(",")))
										    .map(String::trim)
										    .filter(str -> !str.isEmpty())
										    .map(Long::valueOf)
										    .collect(Collectors.toSet());

			// 3. External: if either is "E", include
			Set<Long> filterIdsExternal = icdConnectionsList.stream()
										    .filter(e -> anyValueIs("E", e.getElementTypesS1()) || anyValueIs("E", e.getElementTypesS2()))
										    .flatMap(e -> Stream.of(e.getSubSystemIdsS1(), e.getSubSystemIdsS2()))
										    .filter(Objects::nonNull)
										    .flatMap(s -> Arrays.stream(s.split(",")))
										    .map(String::trim)
										    .filter(str -> !str.isEmpty())
										    .map(Long::valueOf)
										    .collect(Collectors.toSet());

			// Filter the productTreeAllList using the above IDs
			List<Object[]> productTreeList = productTreeAllList.stream().filter(arr -> filterIds.contains(Long.parseLong(arr[0].toString()))).collect(Collectors.toList());
			List<Object[]> productTreeListInternal = productTreeAllList.stream().filter(arr -> filterIdsInternal.contains(Long.parseLong(arr[0].toString()))).collect(Collectors.toList());
			List<Object[]> productTreeListExternal = productTreeAllList.stream().filter(arr -> filterIdsExternal.contains(Long.parseLong(arr[0].toString()))).collect(Collectors.toList());

			req.setAttribute("icdDocument", icdDocument);
			req.setAttribute("icdConnectionsList", icdConnectionsList);
			req.setAttribute("productTreeAllList", productTreeAllList);
			req.setAttribute("productTreeList", productTreeList);
			req.setAttribute("productTreeListInternal", productTreeListInternal);
			req.setAttribute("productTreeListExternal", productTreeListExternal);
			req.setAttribute("icdConnectorPinMapList", service.getICDConnectorPinMapListByICDDocId(icdDocId));
			req.setAttribute("icdSystemAttachList", service.getICDSystemAttachListByICDDocId(icdDocId));
			req.setAttribute("systemId", systemId);
			req.setAttribute("pdfForSystem", pdfForSystem);
			
			return "documents/ICDDocumentDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDDocumentDetails.htm " + UserId, e);
			return "static/Error";
		}

	}

	@RequestMapping(value = "ICDConnectionList.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionList(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside ICDConnectionList.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			//String projectId = req.getParameter("projectId");

			req.setAttribute("docId", docId);
			req.setAttribute("docType", docType);
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			req.setAttribute("igiInterfaceList", service.getIGIInterfaceListByLabCode(labcode));
			req.setAttribute("icdPurposeList", service.getAllICDPurposeList());
			req.setAttribute("icdConnectionsList", service.getICDConnectionsList(docId));
//			req.setAttribute("icdConnectionsList", new ArrayList<ICDConnectionDTO>());
			PfmsICDDocument icdDocument = service.getPfmsICDDocumentById(docId);
			req.setAttribute("icdDocument", icdDocument);
			req.setAttribute("productTreeAllList", service.getProductTreeAllList(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+""));
			
			return "documents/ICDConnectionList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionList.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "ICDConnectionDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside ICDConnectionDetails.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String icdConnectionId = req.getParameter("icdConnectionId");
			//String projectId = req.getParameter("projectId");
			
			req.setAttribute("docId", docId);
			req.setAttribute("docType", docType);
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			req.setAttribute("igiInterfaceList", service.getIGIInterfaceListByLabCode(labcode));
			req.setAttribute("icdPurposeList", service.getAllICDPurposeList());
			PfmsICDDocument icdDocument = service.getPfmsICDDocumentById(docId);
			req.setAttribute("icdDocument", icdDocument);
			req.setAttribute("productTreeAllList", service.getProductTreeAllList(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+""));
			req.setAttribute("icdConnectionsList", service.getICDConnectionsList(docId));
			req.setAttribute("icdConnectionId", icdConnectionId==null?"0":icdConnectionId);
			
			return "documents/ICDConnectionDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionDetails.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value="ICDConnectionDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart(name="drawingAttachment", required = false) MultipartFile drawingAttachment) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside ICDConnectionDetailsSubmit.htm " + UserId);
		try {
			
			String docId = req.getParameter("docId");
			String action = req.getParameter("action");
			String icdConnectionId = req.getParameter("icdConnectionId");
			String[] purposeId = req.getParameterValues("purposeId");
			String[] interfaceId = req.getParameterValues("interfaceId");
			String[] subSystemIdOne = req.getParameterValues("subSystemIdOne");
			String[] subSystemIdTwo = req.getParameterValues("subSystemIdTwo");
			
			ICDDocumentConnections connections = Long.parseLong(icdConnectionId)!=0 ? service.getICDDocumentConnectionsById(icdConnectionId) 
																					: new ICDDocumentConnections();
			if(connections.getICDConnectionId()==null) {
				connections.setICDDocId(Long.parseLong(docId));
				connections.setCreatedBy(UserId);
				connections.setCreatedDate(sdtf.format(new Date()));
				connections.setIsActive(1);
			}else {
				connections.setModifiedBy(UserId);
				connections.setModifiedDate(sdtf.format(new Date()));
			}
			
			connections.setDrawingNo(req.getParameter("drawingNo"));
			
			long result = service.addICDDocumentConnections(connections, drawingAttachment, labcode);
			
			// Add ICD Connection SubSystemOne
			addICDConnectionSystems(subSystemIdOne, result, UserId, "A");
			
			// Add ICD Connection SubSystemTwo
			addICDConnectionSystems(subSystemIdTwo, result, UserId, "B");
			
			// Add ICD Connection Interfaces
			addICDConnectionInterfaces(interfaceId, result, UserId);
			
			// Add ICD Connection Purpose
			addICDConnectionPurpose(purposeId, result+"", UserId);
			
			if (result > 0) {
				redir.addAttribute("result", "ICD Connections "+action+"ed Successfully");
			} else {
				redir.addAttribute("resultfail", "ICD Connections "+action+" Unsuccessful");
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			
			return "redirect:/ICDConnectionList.htm";

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionDetailsSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "ICDConnectionDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionDelete(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside ICDConnectionDelete.htm " + UserId);
		try {
			String conInterfaceId = req.getParameter("conInterfaceId");
			
			long result = service.deleteICDConnectionById(conInterfaceId);

			if (result > 0) {
				redir.addAttribute("result", "ICD Connection Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "ICD Connection Delete Unsuccessful");
			}

			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			
			return "redirect:/ICDConnectionList.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionDelete.htm " + UserId);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="ICDConnectionMatrixDetails.htm", method = {RequestMethod.POST, RequestMethod.GET})
	public String ICDConnectionMatrixDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside ICDConnectionMatrixDetails.htm "+UserId );
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");

			req.setAttribute("docId", docId);
			req.setAttribute("docType", docType);
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			req.setAttribute("igiInterfaceList", service.getIGIInterfaceListByLabCode(labcode));
			PfmsICDDocument icdDocument = service.getPfmsICDDocumentById(docId);
			List<Object[]> productTreeAllList = service.getProductTreeAllList(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+"");
			List<ICDConnectionDTO> icdConnectionsList = service.getICDConnectionsList(docId);
			
			// 1. All subsystem IDs (split and converted to Long)
			Set<Long> filterIds = icdConnectionsList.stream()
								    .flatMap(e -> Stream.of(e.getSubSystemIdsS1(), e.getSubSystemIdsS2()))
								    .filter(Objects::nonNull)
								    .flatMap(s -> Arrays.stream(s.split(",")))
								    .map(String::trim)
								    .filter(str -> !str.isEmpty())
								    .map(Long::valueOf)
								    .collect(Collectors.toSet());

			// 2. Internal: ElementTypes both must be "I", split values
			Set<Long> filterIdsInternal = icdConnectionsList.stream()
										    .filter(e -> allValuesAre("I", e.getElementTypesS1()))
										    .filter(e -> allValuesAre("I", e.getElementTypesS2()))
										    .flatMap(e -> Stream.of(e.getSubSystemIdsS1(), e.getSubSystemIdsS2()))
										    .filter(Objects::nonNull)
										    .flatMap(s -> Arrays.stream(s.split(",")))
										    .map(String::trim)
										    .filter(str -> !str.isEmpty())
										    .map(Long::valueOf)
										    .collect(Collectors.toSet());

			// 3. External: if either is "E", include
			Set<Long> filterIdsExternal = icdConnectionsList.stream()
										    .filter(e -> anyValueIs("E", e.getElementTypesS1()) || anyValueIs("E", e.getElementTypesS2()))
										    .flatMap(e -> Stream.of(e.getSubSystemIdsS1(), e.getSubSystemIdsS2()))
										    .filter(Objects::nonNull)
										    .flatMap(s -> Arrays.stream(s.split(",")))
										    .map(String::trim)
										    .filter(str -> !str.isEmpty())
										    .map(Long::valueOf)
										    .collect(Collectors.toSet());

			// Filter the productTreeAllList using the above IDs
			List<Object[]> productTreeList = productTreeAllList.stream().filter(arr -> filterIds.contains(Long.parseLong(arr[0].toString()))).collect(Collectors.toList());
			List<Object[]> productTreeListInternal = productTreeAllList.stream().filter(arr -> filterIdsInternal.contains(Long.parseLong(arr[0].toString()))).collect(Collectors.toList());
			List<Object[]> productTreeListExternal = productTreeAllList.stream().filter(arr -> filterIdsExternal.contains(Long.parseLong(arr[0].toString()))).collect(Collectors.toList());

			// Add to model for JSP
			req.setAttribute("icdDocument", icdDocument);
			req.setAttribute("icdConnectionsList", icdConnectionsList);
			req.setAttribute("productTreeAllList", productTreeAllList);
			req.setAttribute("productTreeList", productTreeList);
			req.setAttribute("productTreeListInternal", productTreeListInternal);
			req.setAttribute("productTreeListExternal", productTreeListExternal);
			
			return "documents/ICDConnectionMatrixDetails";
		}catch (Exception e) {
			e.printStackTrace();
			return "static/Error";
		}
	}

	private boolean allValuesAre(String expected, String csv) {
	    return csv != null && Arrays.stream(csv.split(","))
	        .map(String::trim)
	        .map(val -> val.contains("#") ? val.split("#")[1] : "")
	        .allMatch(type -> type.equals(expected));
	}

	private boolean anyValueIs(String expected, String csv) {
	    return csv != null && Arrays.stream(csv.split(","))
	        .map(String::trim)
	        .map(val -> val.contains("#") ? val.split("#")[1] : "")
	        .anyMatch(type -> type.equals(expected));
	}
	
	@RequestMapping(value = "ICDDocumentApprovalSubmit.htm", method = { RequestMethod.GET, RequestMethod.POST })
	public String icdDocumentApprovalSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + "Inside ICDDocumentApprovalSubmit.htm" + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String action = req.getParameter("Action");
			String remarks = req.getParameter("remarks");

			PfmsICDDocument icdDocument = service.getPfmsICDDocumentById(docId);
			String statusCode = icdDocument.getICDStatusCode();

			List<String> icdforwardstatus = Arrays.asList("RIN", "RRR", "RRA", "REV");

			long result = service.icdDocumentApprovalForward(docId, docType, action, remarks, EmpId, labcode, UserId);

//			if (result != 0 && reqInitiation.getReqStatusCode().equalsIgnoreCase("RFA") && reqInitiation.getReqStatusCodeNext().equalsIgnoreCase("RAM")) {
//				// PDF Freeze
//				service.igiDocPdfFreeze(req, resp, docId, labcode);
//			}

			if (action.equalsIgnoreCase("A")) {
				if (icdforwardstatus.contains(statusCode)) {
					if (result != 0) {
						redir.addAttribute("result", "ICD Document Forwarded Successfully");
					} else {
						redir.addAttribute("resultfail", "ICD Document Forward Unsuccessful");
					}
					redir.addAttribute("projectType", req.getParameter("projectType"));
					redir.addAttribute("projectId", req.getParameter("projectId"));
					redir.addAttribute("initiationId", req.getParameter("initiationId"));
					redir.addAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
					return "redirect:/ICDDocumentList.htm";
				} else if (statusCode.equalsIgnoreCase("RFW")) {
					if (result != 0) {
						redir.addAttribute("result", "ICD Document Recommende d Successfully");
					} else {
						redir.addAttribute("resultfail", "ICD Document Recommend Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				} else if (statusCode.equalsIgnoreCase("RFR")) {
					if (result != 0) {
						redir.addAttribute("result", "ICD Document Approved Successfully");
					} else {
						redir.addAttribute("resultfail", "ICD Document Approve Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				}
			} else if (action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if (result != 0) {
					redir.addAttribute("result", action.equalsIgnoreCase("R") ? "ICD Document Returned Successfully" : "ICD Document Disapproved Successfully");
				} else {
					redir.addAttribute("resultfail", action.equalsIgnoreCase("R") ? "ICD Document Return Unsuccessful" : "ICD Document Disapprove Unsuccessful");
				}
			}
			return "redirect:/DocumentApprovals.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDDocumentApprovalSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}
	
//	@RequestMapping(value="GetProductTreeListByLevel.htm", method=RequestMethod.GET)
//	public @ResponseBody String getProductTreeList(HttpSession ses, HttpServletRequest req) throws Exception {
//		
//		String UserId=(String)ses.getAttribute("Username");
//		logger.info(new Date() +" Inside GetProductTreeListByLevel.htm "+UserId);
//		Gson json = new Gson();
//		List<Object[]> productTreeAllList = new ArrayList<Object[]>();
//		
//		try
//		{	
//			String subSystemId = req.getParameter("subSystemId");
//			String levelId = req.getParameter("levelId");
//			
//			productTreeAllList = service.getProductTreeAllListByProjectId(req.getParameter("projectId"));
//			
//			productTreeAllList = productTreeAllList.stream().filter(e -> e[9].toString().equalsIgnoreCase(subSystemId!=null?subSystemId:"0") && e[10].toString().equalsIgnoreCase(levelId!=null?levelId:"0")).collect(Collectors.toList());
//	          
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside GetProductTreeListByLevel.htm "+UserId ,e);
//			e.printStackTrace(); 
//		}
//		  
//		 return json.toJson(productTreeAllList);    
//	}

	@RequestMapping(value="ICDDocumentUserRevoke.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String icdDocumentUserRevoke(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ICDDocumentUserRevoke.htm "+UserId);
		try {
			String icdDocId = req.getParameter("icdDocId");
            
			long count = service.icdDocumentUserRevoke(icdDocId, UserId, EmpId);
			
			if (count > 0) {
				redir.addAttribute("result", "ICD Document Revoked Successfully");
			}
			else {
				redir.addAttribute("resultfail", "ICD Document Revoke Unsuccessful");	
			}	

			redir.addAttribute("projectType", req.getParameter("projectType"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("initiationId", req.getParameter("initiationId"));
			redir.addAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
			return "redirect:/ICDDocumentList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ICDDocumentUserRevoke.htm "+UserId, e);
			return "static/Error";			
		}

	}
	

	private int addICDConnectionSystems(String[] subSystemId, Long icdConnectionId, String userId, String subSystemType) throws Exception {
		try {

			if(subSystemId!=null && subSystemId.length>0) {

				// Delete Existing SubSystems
				service.deleteICDConnectionSystemsByICDConnectionId(icdConnectionId+"", subSystemType);
				
				for(int i=0; i<subSystemId.length; i++) {

					ICDConnectionSystems systems = new ICDConnectionSystems();
					systems.setICDConnectionId(icdConnectionId);
					systems.setSubSystemType(subSystemType);
					systems.setSubSystemId(subSystemId!=null?Long.parseLong(subSystemId[i]):0);
					systems.setCreatedBy(userId);
					systems.setCreatedDate(sdtf.format(new Date()));
					systems.setIsActive(1);

					service.addICDConnectionSystems(systems);
				}
			}
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private int addICDConnectionInterfaces(String[] interfaceId, Long icdConnectionId, String userId) throws Exception {
		try {
			
			if(interfaceId!=null && interfaceId.length>0) {
				
				// Delete Existing Interfaces
				service.deleteICDConnectionInterfaceByICDConnectionId(icdConnectionId+"");
				
				for(int i=0; i<interfaceId.length; i++) {
					
					ICDConnectionInterfaces interfaces = new ICDConnectionInterfaces();
					interfaces.setICDConnectionId(icdConnectionId);
					interfaces.setInterfaceId(interfaceId!=null?Long.parseLong(interfaceId[i]):0);
					interfaces.setCreatedBy(userId);
					interfaces.setCreatedDate(sdtf.format(new Date()));
					interfaces.setIsActive(1);
					
					service.addICDConnectionInterfaces(interfaces);
				}
			}
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private int addICDConnectionPurpose(String[] purposeId, String icdConnectionId, String userId) throws Exception {
		try {
			
			if(purposeId!=null && purposeId.length>0) {
				
				// Delete Existing Purposes
				service.deleteICDConnectionPurposeByICDConnectionId(icdConnectionId);
				
				for(int i=0; i<purposeId.length; i++) {
					
					
					ICDConnectionPurpose purposes = new ICDConnectionPurpose();
					purposes.setICDConnectionId(Long.parseLong(icdConnectionId));
					purposes.setPurposeId(purposeId!=null?Long.parseLong(purposeId[i]):0);
					purposes.setCreatedBy(userId);
					purposes.setCreatedDate(sdtf.format(new Date()));
					purposes.setIsActive(1);
					
					service.addICDConnectionPurpose(purposes);
				}
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@RequestMapping(value="CheckICDConnectionExistence.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public  @ResponseBody String  checkICDConnectionExistence(HttpServletRequest req, HttpSession ses)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside CheckICDConnectionExistence.htm"+Username);
		Gson json = new Gson();
		int connectionCount =0;
		try {
			String docId = req.getParameter("docId");
			String subSystemOne = req.getParameter("subSystem1");
			String subSystemTwo = req.getParameter("subSystem2");
			
			String[] subSystemOnes  = subSystemOne!=null?subSystemOne.split("/"): null;
			String[] subSystemTwos  = subSystemTwo!=null?subSystemTwo.split("/"): null;
			
			connectionCount = service.getICDConnectionsCount(subSystemOnes!=null && !subSystemOnes[0].isEmpty()?Long.parseLong(subSystemOnes[0]):0, 
															subSystemTwos!=null && !subSystemTwos[0].isEmpty()?Long.parseLong(subSystemTwos[0]):0, 
															Long.parseLong(docId) );
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CheckICDConnectionExistence.htm"+Username, e);
		}
		return json.toJson(connectionCount);

	}
	
	@RequestMapping(value = "ICDConnectionDrawingAttachDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void icdConnectionDrawingAttachDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ICDConnectionDrawingAttachDownload.htm "+UserId);
		try
		{
			res.setContentType("application/pdf");	
			
			String fileName = req.getParameter("drawingAttach");

			String filePath = Paths.get(uploadpath, labcode, "ICD", "Connections").toString(); 
			
			Path filepath = Paths.get(filePath, fileName);
			File my_file = filepath.toFile();
			
			res.setHeader("Content-disposition","inline; filename="+fileName);
	        String mimeType = getMimeType(my_file.getName()); 
	        res.setContentType(mimeType);
	        
	        OutputStream out = res.getOutputStream();
	        FileInputStream in = new FileInputStream(my_file);
	        byte[] buffer = new byte[4096];
	        int length;
	        while ((length = in.read(buffer)) > 0) {
	            out.write(buffer, 0, length);
	        }
	        in.close();
	        out.close();
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ICDConnectionDrawingAttachDownload.htm "+UserId,e);
		}
	}

	@RequestMapping(value="ExternalElementsSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String externalElementsSubmit(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ExternalElementsSubmit.htm "+UserId);
		try {
			String projectId = req.getParameter("projectId");
			String projectType = req.getParameter("projectType");
			String[] levelName = req.getParameterValues("levelName");
			String[] levelCode = req.getParameterValues("levelCode");
			
			long result = 0;
			for(int i=0; i<levelName.length;i++) {
				ProductTreeDto dto=new ProductTreeDto();
		        dto.setProjectId(projectType.equalsIgnoreCase("E")?Long.parseLong(projectId): 0L);
		        dto.setParentLevelId(0L);
		        dto.setLevelId("1");
		        dto.setSubLevelId("1");
		        dto.setLevelName(levelName[i]);
		        dto.setLevelCode(levelCode[i]);
		        dto.setElementType("E");
		        dto.setCreatedBy(UserId);
		        dto.setInitiationId(!projectType.equalsIgnoreCase("E")?Long.parseLong(projectId): 0L);
		        
		        result+= prodservice.AddLevelName(dto);
			}
			
			if (result > 0) {
				redir.addAttribute("result", "External Elements Added Successfully");
			}else {
				redir.addAttribute("resultfail", "External Elements Add Unsuccessful");	
			}	
			
			redir.addAttribute("icdDocId", req.getParameter("docId"));
			return "redirect:/ICDDocumentDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ExternalElementsSubmit.htm "+UserId, e);
			return "static/Error";			
		}
	}

	@RequestMapping(value="ExternalElementDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String externalElementDelete(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ExternalElementDelete.htm "+UserId);
		try {
			String mainId = req.getParameter("mainId");
			mainId = mainId!=null?mainId:"0";
			ProductTree productTree = prodservice.getProductTreeById(Long.parseLong(mainId));
			productTree.setIsActive(0);
			
			long result = prodservice.LevelNameEdit(productTree);
			
			if (result > 0) {
				redir.addAttribute("result", "External Element Deleted Successfully");
			}else {
				redir.addAttribute("resultfail", "External Elements Delete Unsuccessful");	
			}	
			
			redir.addAttribute("icdDocId", req.getParameter("docId"));
			return "redirect:/ICDDocumentDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ExternalElementDelete.htm "+UserId, e);
			return "static/Error";			
		}
	}
	
	@RequestMapping(value = "PurposeMaster.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String purposeMasterList(HttpServletRequest req, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside PurposeMaster.htm" + UserId);
		try {
			req.setAttribute("purposeMasterList", service.getAllICDPurposeList());
			return "documents/PurposeMasterList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside PurposeMaster.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value="PurposeMasterDetailsSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String purposeMasterAddEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date()+ " Inside PurposeMasterDetailsSubmit.htm "+UserId);	
		try {
			
			String action =req.getParameter("action");
			String purposeId =req.getParameter("purposeId");
			
			ICDPurpose purpose = purposeId.equalsIgnoreCase("0") ? new ICDPurpose() : service.getICDPurposeById(purposeId);
			
			purpose.setPurpose(req.getParameter("purpose"));
			purpose.setPurposeCode(req.getParameter("purposeCode"));
			
			if (purposeId.equalsIgnoreCase("0")) {
				purpose.setCreatedBy(UserId);
				purpose.setCreatedDate(sdtf.format(new Date()));
				purpose.setIsActive(1);
			} else {
				purpose.setModifiedBy(UserId);
				purpose.setModifiedDate(sdtf.format(new Date()));
			}
			
			long result = service.addICDPurpose(purpose);
			
			if (result!=0) {
				redir.addAttribute("result", "Purpose "+action+"ed Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Purpose "+action+" Unsuccessful");	
			}
			
			return "redirect:/PurposeMaster.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside PurposeMasterDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}

	@RequestMapping(value="ICDMechanicalInterfacesList.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdMechanicalInterfacesList(HttpServletRequest req, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside ICDMechanicalInterfacesList.htm " + UserId);
		try {
			String icdDocId = req.getParameter("icdDocId");
			String mechInterfaceId = req.getParameter("mechInterfaceId");
			mechInterfaceId = mechInterfaceId!=null?mechInterfaceId:"0";
			
			List<ICDMechanicalInterfaces> mechanicalInterfacesList = service.getICDMechanicalInterfacesList();
			mechanicalInterfacesList.stream().filter(e-> e.getICDDocId()==Long.parseLong(icdDocId)).collect(Collectors.toList());
			
			if(!mechInterfaceId.equalsIgnoreCase("0")) {
				long mechInterfaceid = Long.parseLong(mechInterfaceId);
				req.setAttribute("icdMechanicalInterfaceData", mechanicalInterfacesList.stream().filter(e -> e.getMechInterfaceId()==mechInterfaceid).findFirst().orElse(null) );
			}
			
			req.setAttribute("icdDocId", icdDocId);
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			req.setAttribute("mechInterfaceId", mechInterfaceId);
			req.setAttribute("mechanicalInterfacesList", mechanicalInterfacesList);
			PfmsICDDocument icdDocument = service.getPfmsICDDocumentById(icdDocId);
			req.setAttribute("icdDocument", icdDocument);
			req.setAttribute("productTreeAllList", service.getProductTreeAllList(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+""));
			
			return "documents/ICDMechanicalInterfacesList";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDMechanicalInterfacesList.htm " + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="ICDMechanicalInterfaceDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdMechanicalInterfaceDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart(name="drawingOne", required = false) MultipartFile drawingOne,
			@RequestPart(name="drawingTwo", required = false) MultipartFile drawingTwo) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside ICDMechanicalInterfaceDetailsSubmit.htm " + UserId);
		try {
			String action = req.getParameter("action");
			String icdDocId = req.getParameter("icdDocId");
			String subSystemOne = req.getParameter("subSystemOne");
			String subSystemTwo = req.getParameter("subSystemTwo");
			String mechInterfaceId = req.getParameter("mechInterfaceId");
			long mechinterfaceid = Long.parseLong(mechInterfaceId);
			
			String[] subSystemOnes  = subSystemOne!=null?subSystemOne.split("/"): null;
			String[] subSystemTwos  = subSystemTwo!=null?subSystemTwo.split("/"): null;
			
			ICDMechanicalInterfaces mechInterface = mechinterfaceid!=0 ? service.getICDMechanicalInterfacesById(mechinterfaceid) : new ICDMechanicalInterfaces();
			
			mechInterface.setICDDocId(Long.parseLong(icdDocId));
			mechInterface.setInterfaceName(req.getParameter("interfaceName"));
			mechInterface.setPartOne(req.getParameter("partOne"));
			mechInterface.setPartTwo(req.getParameter("partTwo"));
			mechInterface.setDescription(req.getParameter("description"));
			mechInterface.setStandards(req.getParameter("standards"));
			mechInterface.setPrecautions(req.getParameter("precautions"));
			mechInterface.setInstructions(req.getParameter("instructions"));
			mechInterface.setRemarks(req.getParameter("remarks"));
			
			if(mechinterfaceid==0) {
				mechInterface.setSubSystemMainIdOne(subSystemOnes!=null?Long.parseLong(subSystemOnes[0]):0L);
				mechInterface.setSubSystemMainIdTwo(subSystemTwos!=null?Long.parseLong(subSystemTwos[0]):0L);
				mechInterface.setInterfaceCode(req.getParameter("interfaceCode"));
				long interfaceCount = service.getMechanicalInterfaceCount();
				String seqId = (subSystemOnes!=null?subSystemOnes[1]:"-") + "_" + (subSystemTwos!=null?subSystemTwos[1]:"-") + "_" + mechInterface.getInterfaceCode()+ "_M-"+ (interfaceCount+1);
				mechInterface.setInterfaceSeqId(seqId);
				mechInterface.setCreatedBy(UserId);
				mechInterface.setCreatedDate(sdtf.format(new Date()));
				mechInterface.setIsActive(1);
			}else {
				mechInterface.setModifiedBy(UserId);
				mechInterface.setModifiedDate(sdtf.format(new Date()));
			}
			
			Long result = service.addICDMechanicalInterfaces(mechInterface, drawingOne, drawingTwo, labcode);
		
			if (result!=0) {
				redir.addAttribute("result", "Interface Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Interface Details "+action+" Unsuccessful");	
			}
			
			redir.addAttribute("mechInterfaceId", result);
			redir.addAttribute("icdDocId", icdDocId);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			
			return "redirect:/ICDMechanicalInterfacesList.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDMechanicalInterfaceDetailsSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "ICDMechanicalDrawingAttachDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void icdMechanicalDrawingAttachDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ICDMechanicalDrawingAttachDownload.htm "+UserId);
		try
		{
			res.setContentType("application/pdf");	
			
			String fileName = req.getParameter("drawingAttach");

			String filePath = Paths.get(uploadpath, labcode, "ICD", "MechInterface").toString(); 
			
			Path filepath = Paths.get(filePath, fileName);
			File my_file = filepath.toFile();
			
			res.setHeader("Content-disposition","inline; filename="+fileName);
	        String mimeType = getMimeType(my_file.getName()); 
	        res.setContentType(mimeType);
	        
	        OutputStream out = res.getOutputStream();
	        FileInputStream in = new FileInputStream(my_file);
	        byte[] buffer = new byte[4096];
	        int length;
	        while ((length = in.read(buffer)) > 0) {
	            out.write(buffer, 0, length);
	        }
	        in.close();
	        out.close();
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ICDMechanicalDrawingAttachDownload.htm "+UserId,e);
		}
	}
	
	@RequestMapping(value="ICDConnectionPinDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionPinDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside ICDConnectionPinDetails.htm " + UserId);

		try {
			String icdConnectionId = req.getParameter("icdConnectionId");
			String docId = req.getParameter("docId");
			String tab = req.getParameter("tab");
			
			req.setAttribute("docId", docId);
			req.setAttribute("docType", req.getParameter("docType"));
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			req.setAttribute("icdConnectionId", icdConnectionId);
			req.setAttribute("tab", tab==null?"1":tab);
			req.setAttribute("icdDocumentConnections", service.getICDDocumentConnectionsById(icdConnectionId));
			req.setAttribute("icdConnectionsList", service.getICDConnectionsList(docId));
			PfmsICDDocument icdDocument = service.getPfmsICDDocumentById(docId);
			req.setAttribute("icdDocument", icdDocument);
			req.setAttribute("productTreeAllList", service.getProductTreeAllList(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+""));
			req.setAttribute("igiInterfaceList", service.getIGIInterfaceListByLabCode(labcode));
			req.setAttribute("connectorMasterList", service.getConnectorMasterList());
			req.setAttribute("icdConnectorList", service.getICDConnectorList(icdConnectionId));
			List<Object[]> icdConnectorPinList = service.getICDConnectorPinListByICDConnectionId(icdConnectionId);
			req.setAttribute("icdConnectorPinList", icdConnectorPinList);
			req.setAttribute("icdConnectorPinMapList", service.getICDConnectorPinMapListByICDDocId(docId).stream().filter(e->e.getICDConnectionId()==Long.parseLong(icdConnectionId)).collect(Collectors.toList()));
			String icdConnectorIdE1 = req.getParameter("icdConnectorIdE1");
			if(icdConnectorIdE1!=null) {
				req.setAttribute("pinListE1", icdConnectorPinList.stream().filter(e -> e[0].toString().equalsIgnoreCase(icdConnectorIdE1)).collect(Collectors.toList()) );
				req.setAttribute("icdConnectorIdE1", icdConnectorIdE1);
			}
			
			String icdConnectorIdE2 = req.getParameter("icdConnectorIdE2");
			
			if(icdConnectorIdE2!=null) {
				req.setAttribute("pinListE2", icdConnectorPinList.stream().filter(e -> e[0].toString().equalsIgnoreCase(icdConnectorIdE2)).collect(Collectors.toList()) );
				req.setAttribute("icdConnectorIdE2", icdConnectorIdE2);
			}

			String connectorPinMapId = req.getParameter("connectorPinMapId");
			if(connectorPinMapId!=null) {
				req.setAttribute("icdConnectorPinMapping", service.getICDConnectorPinMappingById(connectorPinMapId) );
				req.setAttribute("connectorPinMapId", connectorPinMapId);
			}
			
			return "documents/ICDConnectionPinDetails";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionPinDetails.htm " + UserId, e);
			return "static/Error";
		}

	}
	
	@RequestMapping(value="ICDConnectionPinDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionPinDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside ICDConnectionPinDetailsSubmit.htm " + UserId);

		try {
			String icdConnectorId = req.getParameter("icdConnectorId");
			String icdConnectionId = req.getParameter("icdConnectionId");
			String connectorNo = req.getParameter("connectorNo");
			String subSystemId = req.getParameter("subSystemId");
			String connectorId = req.getParameter("connectorId");
			String pinCount = req.getParameter("pinCount");
			String endNo = req.getParameter("endNo");
			String action = req.getParameter("action");
			
			boolean isNew = icdConnectorId.equalsIgnoreCase("0")? true: false;
			
			int totalPins = Integer.parseInt(pinCount);
			
			ICDConnectionConnectors connector = isNew? new ICDConnectionConnectors() : service.getICDConnectionConnectorsById(icdConnectorId);
			if(isNew) {
				connector.setICDConnectionId(icdConnectionId!=null?Long.parseLong(icdConnectionId):0L);
				connector.setConnectorNo(connectorNo!=null?Integer.parseInt(connectorNo):0);
				connector.setSystemType(req.getParameter("systemType"));
				connector.setSubSystemId(subSystemId!=null?Long.parseLong(subSystemId):0L);
				connector.setConnectorId(connectorId!=null?Long.parseLong(connectorId):0L);
				connector.setCreatedBy(UserId);
				connector.setCreatedDate(sdtf.format(new Date()));
				connector.setIsActive(1);
			}else {
				connector.setModifiedBy(UserId);
				connector.setModifiedDate(sdtf.format(new Date()));
				
				// Remove existing pin details
				//service.deleteICDConnectionConnectorPinDetails(icdConnectorId);
			}
			
			
			long result = service.addICDConnectionConnectors(connector);
			
			String[] pinNo = req.getParameterValues("pinNo");
			String[] interfaceId = req.getParameterValues("interfaceId");
			String[] constraints = req.getParameterValues("constraints");
			String[] description = req.getParameterValues("description");
			
			for(int i=0; i<totalPins; i++) {
				
				String periodicity = req.getParameter(("periodicity_"+endNo+"_")+(i+1));

				ICDConnectorPins pin = new ICDConnectorPins();
				pin.setICDConnectorId(result);
				pin.setPinNo(pinNo[i]);	
				pin.setInterfaceId(interfaceId!=null?Long.parseLong(interfaceId[i]):-2L);
				if(endNo.equalsIgnoreCase("E1")) {
					pin.setConstraints(constraints[i]);
					pin.setPeriodicity(periodicity);
					pin.setDescription(description[i]);
				}
				pin.setCreatedBy(UserId);
				pin.setCreatedDate(sdtf.format(new Date()));
				pin.setIsActive(1);
				
				service.addICDConnectorPins(pin);
			}
			

			if (result!=0) {
				redir.addAttribute("result", "Connector & Pin Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Connector & Pin Details "+action+" Unsuccessful");	
			}
			
			redir.addAttribute("icdConnectionId", icdConnectionId);
			redir.addAttribute("icdConnectorId"+endNo, result);
			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("tab", req.getParameter("tab"));
			
			return "redirect:/ICDConnectionPinDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionPinDetailsSubmit.htm " + UserId, e);
			return "static/Error";
		}

	}

	@RequestMapping(value = "ICDConnectionConnectorDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionConnectorDelete(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside ICDConnectionConnectorDelete.htm " + UserId);
		try {
			String icdConnectionId = req.getParameter("icdConnectionId");
			String icdConnectorId = req.getParameter("icdConnectorId");
			String endNo = req.getParameter("endNo");
			
			long result = service.deleteICDConnectionConnectorById(icdConnectorId);

			// Remove existing pin details
			service.deleteICDConnectionConnectorPinDetails(icdConnectorId);
			
			if (result > 0) {
				redir.addAttribute("result", "Connector Details Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Connector Details Delete Unsuccessful");
			}

			redir.addAttribute("icdConnectionId", icdConnectionId);
			redir.addAttribute("icdConnectorId"+endNo, 0L);
			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("tab", req.getParameter("tab"));
			
			return "redirect:/ICDConnectionPinDetails.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionConnectorDelete.htm " + UserId);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="ICDConnectionPinDetailsUpdate.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionPinDetailsUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside ICDConnectionPinDetailsUpdate.htm " + UserId);
		
		try {
			String icdConnectionId = req.getParameter("icdConnectionId");
			String connectorPinId = req.getParameter("connectorPinId");
			String endNo = req.getParameter("endNo");
			String interfaceId = req.getParameter("interfaceId");
			
			ICDConnectorPins pin = service.getICDConnectorPinsById(connectorPinId);
			pin.setInterfaceId(interfaceId!=null?Long.parseLong(interfaceId):0L);
			pin.setConstraints(req.getParameter("constraints"));
			pin.setPeriodicity(req.getParameter("periodicity"));
			pin.setDescription(req.getParameter("description"));
			pin.setCreatedBy(UserId);
			pin.setCreatedDate(sdtf.format(new Date()));
			pin.setIsActive(1);
			
			long result = service.addICDConnectorPins(pin);
			
			if (result!=0) {
				redir.addAttribute("result", "Pin Details Updated Successfully");
			}else {
				redir.addAttribute("resultfail", "Pin Details Update Unsuccessful");	
			}
			
			redir.addAttribute("icdConnectionId", icdConnectionId);
			redir.addAttribute("icdConnectorId"+endNo, req.getParameter("icdConnectorId"));
			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("tab", req.getParameter("tab"));
			
			return "redirect:/ICDConnectionPinDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionPinDetailsUpdate.htm " + UserId, e);
			return "static/Error";
		}
		
	}

	@RequestMapping(value="DuplicateConnectorNoCheck.htm", method=RequestMethod.GET)
	public @ResponseBody String duplicateConnectorNoCheck(HttpSession ses, HttpServletRequest req) throws Exception {
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside DuplicateConnectorNoCheck.htm "+UserId);
		Gson json = new Gson();
		Long duplicate=null;
		try
		{	  
	          duplicate = service.getDuplicateConnectorCount(req.getParameter("icdConnectionId"), 
	        		  req.getParameter("connectorNo"),
	        		  req.getParameter("systemType"),
	        		  req.getParameter("subSystemId"),
	        		  req.getParameter("icdConnectorId") );
	          
		}catch (Exception e) {
			logger.error(new Date() +"Inside DuplicateConnectorNoCheck.htm "+UserId ,e);
			e.printStackTrace(); 
		}
		  
		 return json.toJson(duplicate);    
	}

	@RequestMapping(value="ICDPinMappingDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdPinMappingDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside ICDPinMappingDetailsSubmit.htm " + UserId);
		try {
			String connectorPinMapId = req.getParameter("connectorPinMapId");
			String icdConnectionId = req.getParameter("icdConnectionId");
			String connectorPinIdFrom = req.getParameter("connectorPinIdFrom");
			String connectorPinIdTo = req.getParameter("connectorPinIdTo");
			String interfaceId = req.getParameter("interfaceId");
			String interfaceCode = req.getParameter("interfaceCode");
			String action = req.getParameter("action");
			
			boolean isNew = connectorPinMapId.equalsIgnoreCase("0")? true: false;

			ICDConnectorPinMapping pinMap = isNew? new ICDConnectorPinMapping() : service.getICDConnectorPinMappingById(connectorPinMapId);
			
			pinMap.setPinFunction(req.getParameter("pinFunction"));
			pinMap.setSignalName( req.getParameter("signalName"));
			pinMap.setCableMaxLength(req.getParameter("cableMaxLength")!=null?Integer.parseInt(req.getParameter("cableMaxLength")): 0);
			pinMap.setInterfaceLoss(req.getParameter("interfaceLoss")!=null?Integer.parseInt(req.getParameter("interfaceLoss")): 0);
			pinMap.setCableBendingRadius(req.getParameter("cableBendingRadius")!=null?Double.parseDouble(req.getParameter("cableBendingRadius")): 0);
			pinMap.setRemarks(req.getParameter("remarks"));
			
			String[] pinFrom =  connectorPinIdFrom!=null?connectorPinIdFrom.split("/") : null;
			String[] pinTo =  connectorPinIdTo!=null?connectorPinIdTo.split("/") : null;
			pinMap.setConnectorPinIdFrom(pinFrom!=null?Long.parseLong(pinFrom[0]):0L);
			pinMap.setConnectorPinIdTo(pinTo!=null?Long.parseLong(pinTo[0]):0L);
			pinMap.setInterfaceId(interfaceId!=null?Long.parseLong(interfaceId):0L);
			if(interfaceCode==null || (interfaceCode!=null && interfaceCode.isEmpty())) {
				if(pinMap.getInterfaceId()==-1) {
					interfaceCode = "NC";
				}else if(pinMap.getInterfaceId()==0) {
					interfaceCode = "GR";
				}
			}
			String connectionCode = "-";
			if(pinFrom!=null && pinTo!=null) {
				connectionCode = pinFrom[1]+"_"+pinFrom[2]+"-"+pinTo[1]+"_"+pinTo[2]+"-"+(interfaceCode);
			}
			pinMap.setConnectionCode(connectionCode);
			if(isNew) {
				
				pinMap.setICDConnectionId(Long.parseLong(icdConnectionId));
				pinMap.setCreatedBy(UserId);
				pinMap.setCreatedDate(sdtf.format(new Date()));
				pinMap.setIsActive(1);
			}else {
				pinMap.setModifiedBy(UserId);
				pinMap.setModifiedDate(sdtf.format(new Date()));
			}
			
			long result = service.addICDConnectorPinMapping(pinMap);

			if (result!=0) {
				redir.addAttribute("result", "Pin Map Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Pin Map Details "+action+" Unsuccessful");	
			}
			
			redir.addAttribute("icdConnectionId", icdConnectionId);
			redir.addAttribute("connectorPinMapId", result);
			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("tab", req.getParameter("tab"));
			
			return "redirect:/ICDConnectionPinDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDPinMappingDetailsSubmit.htm " + UserId, e);
			return "static/Error";
		}

	}
	
	@RequestMapping(value="ICDSystemDrawingDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdSystemDrawingDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
	
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside ICDSystemDrawingDetails.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			PfmsICDDocument icdDocument = service.getPfmsICDDocumentById(docId);
			
			List<Object[]> productTreeAllList = service.getProductTreeAllList(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+"");
			List<ICDConnectionDTO> icdConnectionsList = service.getICDConnectionsList(docId);
			
			Set<Long> filterIds = icdConnectionsList.stream()
								    .flatMap(e -> Stream.of(e.getSubSystemIdsS1(), e.getSubSystemIdsS2()))
								    .filter(Objects::nonNull)
								    .flatMap(s -> Arrays.stream(s.split(",")))
								    .map(String::trim)
								    .filter(str -> !str.isEmpty())
								    .map(Long::valueOf)
								    .collect(Collectors.toSet());
			
			// Filter the productTreeAllList using the above IDs
			List<Object[]> productTreeList = productTreeAllList.stream().filter(arr -> filterIds.contains(Long.parseLong(arr[0].toString()))).collect(Collectors.toList());

			req.setAttribute("icdDocument", icdDocument);
			req.setAttribute("icdConnectionsList", icdConnectionsList);
			req.setAttribute("productTreeList", productTreeList);
			req.setAttribute("icdSystemAttachList", service.getICDSystemAttachListByICDDocId(docId));
			
			req.setAttribute("docId", docId);
			req.setAttribute("docType", req.getParameter("docType"));
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("projectId", req.getParameter("projectId"));

			return "documents/ICDSystemDrawingDetails";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDSystemDrawingDetails.htm " + UserId, e);
			return "static/Error";
		}
	
	}
	
	@RequestMapping(value = "ICDSystemDrawingDetailsSubmit.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String icdSystemDrawingDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,@RequestPart(name = "attachment", required = false) MultipartFile attachment) {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + "Inside ICDSystemDrawingDetailsSubmit.htm" + UserId);
		try {
			String docId = req.getParameter("docId");
			String systemAttachId = req.getParameter("systemAttachId");
			String subSystemId = req.getParameter("subSystemId");
			
			ICDSystemAttach systemAttach = systemAttachId.equalsIgnoreCase("0") ? new ICDSystemAttach() :  service.getICDSystemAttachById(systemAttachId);
			systemAttach.setDescription(req.getParameter("description"));
			
			if (systemAttachId.equalsIgnoreCase("0")) {
				systemAttach.setICDDocId(docId!=null?Long.parseLong(docId):0L);
				systemAttach.setSubSystemId(subSystemId!=null?Long.parseLong(subSystemId):0L);
				systemAttach.setCreatedBy(UserId);
				systemAttach.setCreatedDate(sdtf.format(new Date()));
				systemAttach.setIsActive(1);
			} else {
				systemAttach.setModifiedBy(UserId);
				systemAttach.setModifiedDate(sdtf.format(new Date()));
			}
			
			long result=service.addICDSystemAttach(systemAttach, attachment, labcode);
			
			if (result!=0) {
				redir.addAttribute("result", "System Image Uploaded Successfully");
			}else {
				redir.addAttribute("resultfail", "System Image Upload Unsuccessful");	
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			
			return "redirect:/ICDSystemDrawingDetails.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDSystemDrawingDetailsSubmit.htm" + UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "ICDSystemDrawingAttachDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void icdSystemDrawingAttachDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ICDSystemDrawingAttachDownload.htm "+UserId);
		try
		{
			res.setContentType("application/pdf");	
			
			String fileName = req.getParameter("drawingAttach");

			String filePath = Paths.get(uploadpath, labcode, "ICD", "SubSystems").toString(); 
			
			Path filepath = Paths.get(filePath, fileName);
			File my_file = filepath.toFile();
			
			res.setHeader("Content-disposition","inline; filename="+fileName);
	        String mimeType = getMimeType(my_file.getName()); 
	        res.setContentType(mimeType);
	        
	        OutputStream out = res.getOutputStream();
	        FileInputStream in = new FileInputStream(my_file);
	        byte[] buffer = new byte[4096];
	        int length;
	        while ((length = in.read(buffer)) > 0) {
	            out.write(buffer, 0, length);
	        }
	        in.close();
	        out.close();
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ICDSystemDrawingAttachDownload.htm "+UserId,e);
		}
	}
	
	/* ************************************************ ICD Document End ***************************************************** */
	
	/* ************************************************ IRS Document ***************************************************** */
	
	@RequestMapping(value = "IRSDocumentList.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsDocumentList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String LoginType = (String) ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		
		logger.info(new Date() + " Inside IRSDocumentList.htm " + UserId);

		try {
			String projectType = req.getParameter("projectType");
			projectType = projectType != null ? projectType : "M";
			String initiationId = "0";
			String projectId = "0";
			String productTreeMainId = req.getParameter("productTreeMainId");
			
			if (projectType.equalsIgnoreCase("M")) {

				projectId = req.getParameter("projectId");
				//productTreeMainId = req.getParameter("productTreeMainId");
				List<Object[]> projectList = projectservice.LoginProjectDetailsList(EmpId, LoginType, labcode);
				
				projectId = projectId != null ? projectId : (projectList.size() > 0 ? projectList.get(0)[0].toString() : "0");
				productTreeMainId = productTreeMainId != null ? productTreeMainId : "0";
				
				req.setAttribute("projectDetails", projectservice.getProjectDetails(labcode, projectId, "E"));
				req.setAttribute("projectList", projectList);
				req.setAttribute("productTreeAllList", service.getProductTreeAllList(projectId, "0"));
				
			}else {
				initiationId = req.getParameter("initiationId");
				//productTreeMainId = req.getParameter("productTreeMainId");
				List<Object[]> preProjectList = reqservice.getPreProjectList(LoginType, labcode, EmpId);
				initiationId = initiationId != null ? initiationId : (preProjectList.size() > 0 ? preProjectList.get(0)[0].toString() : "0");
				productTreeMainId = productTreeMainId != null ? productTreeMainId : "0";
				
				req.setAttribute("projectDetails", projectservice.getProjectDetails(labcode, initiationId, "P"));
				req.setAttribute("preProjectList", preProjectList);
				req.setAttribute("productTreeAllList", service.getProductTreeAllList("0", initiationId));
			}
			req.setAttribute("projectId", projectId);
			req.setAttribute("initiationId", initiationId);
			req.setAttribute("productTreeMainId", productTreeMainId);
			req.setAttribute("projectType", projectType);
			
			List<Object[]> irsDocumentList = service.getIRSDocumentList(projectId, initiationId, productTreeMainId);
			req.setAttribute("irsDocumentList", irsDocumentList);
			
			if(irsDocumentList!=null && irsDocumentList.size()>0) {
				req.setAttribute("irsDocumentSummaryList", service.getDocumentSummaryList(irsDocumentList.get(irsDocumentList.size()-1)[0].toString(), "C"));
			}
			
			return "documents/IRSDocumentList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSDocumentList.htm " + UserId, e);
			return "static/Error";
		}

	}

	@RequestMapping(value = "IRSDocumentAdd.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsDocumentAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		
		logger.info(new Date() + " Inside IRSDocumentAdd.htm" + UserId);

		try {
			String projectType = req.getParameter("projectType");
			String projectId = req.getParameter("projectId");
			String initiationId = req.getParameter("initiationId");
			String productTreeMainId = req.getParameter("productTreeMainId");
			String isAmend = req.getParameter("isAmend");
			String irsDocId = req.getParameter("irsDocId");
			
			PfmsIRSDocument pfmsIRSDocument = PfmsIRSDocument.builder()
												.ProjectId(projectId!=null?Long.parseLong(projectId):0L)
												.InitiationId(initiationId!=null?Long.parseLong(initiationId):0L)
												.ProductTreeMainId(productTreeMainId!=null?Long.parseLong(productTreeMainId):0L)
												.IRSVersion(req.getParameter("version"))
												.LabCode(labcode)
												.InitiatedBy(EmpId)
												.InitiatedDate(sdf.format(new Date()))
												.IRSStatusCode("RIN")
												.IRSStatusCodeNext("RIN")
												.CreatedBy(UserId)
												.CreatedDate(sdtf.format(new Date()))
												.IsActive(1)
											.build();
			
			long result = service.addPfmsIRSDocument(pfmsIRSDocument);

			if(isAmend!=null && isAmend.equalsIgnoreCase("Y")) {
				service.irsDocumentApprovalForward(irsDocId, "C", "A", req.getParameter("remarks"), EmpId, labcode, UserId);
			}
			
			// Transaction 
			service.addPfmsIGITransaction(result, "C", "RIN", null, Long.parseLong(EmpId));
			
			
			if (result > 0) {
				redir.addAttribute("result", "IRS Document Data Submitted Successfully");
			} else {
				redir.addAttribute("resultfail", "IRS Document Data Submit Unsuccessful");
			}

			redir.addAttribute("projectType", projectType);
			redir.addAttribute("projectId", projectId);
			redir.addAttribute("initiationId", initiationId);
			redir.addAttribute("productTreeMainId", productTreeMainId);
			return "redirect:/IRSDocumentList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSDocumentAdd.htm " + UserId, e);
			return "static/Error";

		}

	}

	@RequestMapping(value = "IRSDocumentDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsDocumentDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		
		logger.info(new Date() + " Inside IRSDocumentDetails.htm " + UserId);
		
		try {
			String irsDocId = req.getParameter("irsDocId");
			PfmsIRSDocument irsDocument = service.getPfmsIRSDocumentById(irsDocId);
			req.setAttribute("irsDocument", irsDocument);
			req.setAttribute("version", irsDocument!=null ?irsDocument.getIRSVersion():"1.0");
			
			irsDocId = service.getFirstVersionIRSDocId(irsDocument.getProjectId()+"", irsDocument.getInitiationId()+"", irsDocument.getProductTreeMainId()+"")+"";
			
			String projectType = irsDocument.getProjectId()!=0?"E":"M";
			req.setAttribute("projectType", projectType);
			req.setAttribute("projectDetails", projectservice.getProjectDetails(labcode, (irsDocument.getProjectId()!=0?irsDocument.getProjectId()+"":irsDocument.getInitiationId()+"") , projectType));
			
			req.setAttribute("irsDocId", irsDocId);
			req.setAttribute("irsDocumentSummaryList", service.getDocumentSummaryList(irsDocId, "C"));
			req.setAttribute("totalEmployeeList", projectservice.EmployeeList(labcode));
			req.setAttribute("memberList", service.getDocumentMemberList(irsDocId, "C"));
			req.setAttribute("employeeList", service.getDocmployeeListByDocId(labcode, irsDocId, "C"));
			req.setAttribute("shortCodesList", service.getIGIDocumentShortCodesList());
			req.setAttribute("shortCodesLinkedList", service.getIGIShortCodesLinkedListByType(irsDocId, "C"));
			req.setAttribute("docTempAttributes", projectservice.DocTempAttributes());
			req.setAttribute("labDetails", projectservice.LabListDetails(labcode));
			req.setAttribute("lablogo",  logoUtil.getLabLogoAsBase64String(labcode)); 
			req.setAttribute("drdologo", logoUtil.getDRDOLogoAsBase64String());
			req.setAttribute("applicableDocsList", service.getStandardDocuments());
			req.setAttribute("irsApplicableDocsList", service.getIGIApplicableDocs(irsDocId, "C"));
			
			req.setAttribute("fieldDescriptionList", service.getIRSFieldDescriptionList(irsDocId));
			req.setAttribute("logicalInterfaceList", service.getIGILogicalInterfaces());
			req.setAttribute("logicalChannelList", service.getIGILogicalChannelList());

			req.setAttribute("irsSpecificationsList", service.getIRSDocumentSpecificationsList(irsDocId));
			
			req.setAttribute("igiDocumentIntroductionList", service.getIGIDocumentIntroductionList());

			req.setAttribute("isPdf", req.getParameter("isPdf"));
			
			return "documents/IRSDocumentDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSDocumentDetails.htm " + UserId, e);
			return "static/Error";
		}

	} 
	
	@RequestMapping(value = "IRSSpecificationsDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsSpecificationsDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSSpecificationsDetails.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String irsSpecificationId = req.getParameter("irsSpecificationId");
			irsSpecificationId = irsSpecificationId==null?"0":irsSpecificationId;

			PfmsIRSDocument irsDocument = service.getPfmsIRSDocumentById(docId);
			String icdDocId = service.getFirstVersionICDDocId(irsDocument.getProjectId()+"", irsDocument.getInitiationId()+"", irsDocument.getProductTreeMainId()+"")+"";
			req.setAttribute("docId", docId);
			req.setAttribute("docType", docType);
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			req.setAttribute("logicalInterfaceList", service.getIGILogicalInterfaces());
			req.setAttribute("irsDocument", irsDocument);
			req.setAttribute("dataCarryingConnectionList", service.getDataCarryingConnectionList(icdDocId));
			req.setAttribute("irsSpecificationsList", service.getIRSDocumentSpecificationsList(docId));
			req.setAttribute("irsSpecificationId", irsSpecificationId);
			req.setAttribute("irsDocSpecifications", service.getIRSDocumentSpecificationsById(irsSpecificationId));
			req.setAttribute("logicalChannelList", service.getIGILogicalChannelList());
			req.setAttribute("fieldMasterList", service.fieldMasterList());
			req.setAttribute("dataTypeMasterList", service.dataTypeMasterList());
			req.setAttribute("fieldDescriptionList", service.getIRSFieldDescriptionList(docId));
			req.setAttribute("fieldGroupList", service.getFieldGroupMasterList());
			req.setAttribute("arrayMasterList", service.getIRSArrayMasterListByIRSDocId(docId));

			return "documents/IRSSpecificationsDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSSpecificationsDetails.htm " + UserId, e);
			return "static/Error";
		}
		
	}

	@RequestMapping(value="IRSSpecificationsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsSpecificationsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSSpecificationsSubmit.htm " + UserId);
		try {
			
			String docId = req.getParameter("docId");
			String connectorPinMapId = req.getParameter("connectorPinMapId");
			String logicalInterfaceId = req.getParameter("logicalInterfaceId");
			String irsSpecificationId = req.getParameter("irsSpecificationId");
		
			boolean isNew = "0".equalsIgnoreCase(irsSpecificationId);
			
			IRSDocumentSpecifications specifications = isNew? new IRSDocumentSpecifications(): service.getIRSDocumentSpecificationsById(irsSpecificationId);
			
			specifications.setActionAtDest(req.getParameter("actionAtDest"));
			if(isNew) {
				specifications.setIRSDocId(Long.parseLong(docId));
				specifications.setConnectorPinMapId(connectorPinMapId!=null?Long.parseLong(connectorPinMapId):0L);
				specifications.setLogicalInterfaceId(logicalInterfaceId!=null?Long.parseLong(logicalInterfaceId):0L);
				specifications.setCreatedBy(UserId);
				specifications.setCreatedDate(sdtf.format(new Date()));
				specifications.setIsActive(1);
			}else {
				specifications.setModifiedBy(UserId);
				specifications.setModifiedDate(sdtf.format(new Date()));
			}
					
			long result = service.addIRSDocumentSpecifications(specifications);

			if(isNew && result>0) {
				
				// Handling IRS Field Description
				List<Object[]> fieldDescriptionList = service.getIGIFieldDescriptionList();
				fieldDescriptionList = fieldDescriptionList.stream().filter(e -> specifications.getLogicalInterfaceId()==(Long.parseLong(e[1].toString())) ).collect(Collectors.toList());
			    
				List<IRSFieldDescription> irsFieldDescriptionEntityList = service.getIRSFieldDescriptionEntityList(docId);
				int fieldSlNo = 0;
				for(Object[] obj : fieldDescriptionList) {
					
				    IRSFieldDescription irsFieldDescription = irsFieldDescriptionEntityList.stream().filter(e -> e.getFieldMasterId() == Long.parseLong(obj[2].toString())).findFirst().orElse(null);

					FieldMaster fieldMaster = service.getFieldMasterById(obj[2].toString());
					
					IRSFieldDescription fieldDesc = new IRSFieldDescription();
					fieldDesc.setIRSSpecificationId(result);
					fieldDesc.setLogicalInterfaceId(specifications.getLogicalInterfaceId());
					fieldDesc.setFieldGroupId(obj[12]!=null? Long.parseLong(obj[12].toString()): 0L);
					fieldDesc.setFieldMasterId(fieldMaster.getFieldMasterId());
					fieldDesc.setFieldName(fieldMaster.getFieldName());
					fieldDesc.setFieldShortName(fieldMaster.getFieldShortName());
					fieldDesc.setFieldCode(fieldMaster.getFieldCode());
					fieldDesc.setDataTypeMasterId(fieldMaster.getDataTypeMasterId());
					
					fieldDesc.setTypicalValue(irsFieldDescription!=null?irsFieldDescription.getTypicalValue():fieldMaster.getTypicalValue());
					fieldDesc.setFieldMinValue(irsFieldDescription!=null?irsFieldDescription.getFieldMinValue():fieldMaster.getFieldMinValue());
					fieldDesc.setFieldMaxValue(irsFieldDescription!=null?irsFieldDescription.getFieldMinValue():fieldMaster.getFieldMaxValue());
					fieldDesc.setInitValue(irsFieldDescription!=null?irsFieldDescription.getInitValue():fieldMaster.getInitValue());
					fieldDesc.setQuantum(irsFieldDescription!=null?irsFieldDescription.getQuantum():fieldMaster.getQuantum());
					fieldDesc.setFieldDesc(irsFieldDescription!=null?irsFieldDescription.getFieldDesc():fieldMaster.getFieldDesc());
					fieldDesc.setFieldUnit(irsFieldDescription!=null?irsFieldDescription.getFieldUnit():fieldMaster.getFieldUnit());
					fieldDesc.setRemarks(irsFieldDescription!=null?irsFieldDescription.getRemarks():fieldMaster.getRemarks());
					
					fieldDesc.setArrayMasterId(0L);
					fieldDesc.setFieldSlNo(++fieldSlNo);
					fieldDesc.setCreatedBy(UserId);
					fieldDesc.setCreatedDate(sdtf.format(new Date()));
					fieldDesc.setIsActive(1);
					
					service.addIRSFieldDescription(fieldDesc);
				}
			}
//			else {
//				addNewIRSFieldDescriptions(req, specifications, UserId);
//			}
			
			if (result> 0) {
				redir.addAttribute("result", "IRS Details Submitted Successfully");
			} else {
				redir.addAttribute("resultfail", "IRS Details Submit Unsuccessful");
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("irsSpecificationId", result);
			
			return "redirect:/IRSSpecificationsDetails.htm";

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSSpecificationsSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}


	@RequestMapping(value="IRSFieldDescUpdate.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsFieldDescUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSFieldDescUpdate.htm " + UserId);
		try {
			
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String irsSpecificationId = req.getParameter("irsSpecificationId");
			String fieldGroupId = req.getParameter("fieldGroupId");
			String groupVariable = req.getParameter("groupVariable");
			String irsFieldDescId = req.getParameter("irsFieldDescId");
			String arrayMasterId = req.getParameter("arrayMasterId");
		    
			IRSFieldDescription fieldDesc = service.getIRSFieldDescriptionById(irsFieldDescId);
			fieldDesc.setGroupVariable(groupVariable);
			fieldDesc.setArrayMasterId(arrayMasterId!=null?Long.parseLong(arrayMasterId):0L);
			
			long result = service.addIRSFieldDescription(fieldDesc);

			// Update the same values for all the fields for that particular group
			if(fieldGroupId!=null && Long.parseLong(fieldGroupId)>0) {
				service.updateIRSFieldDescription(groupVariable, arrayMasterId, irsSpecificationId, fieldGroupId);
			}
			
			if (result> 0) {
				redir.addAttribute("result", "Field Description Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "Field Description Update Unsuccessful");
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("irsSpecificationId", irsSpecificationId);
			
			if(docType.equalsIgnoreCase("D")) {
				redir.addAttribute("logicalInterfaceId", req.getParameter("logicalInterfaceId"));
				return "redirect:/IDDDesignDetails.htm";
			}
			
			return "redirect:/IRSSpecificationsDetails.htm";
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSFieldDescUpdate.htm " + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="IRSFieldDescDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsFieldDescDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSFieldDescDelete.htm " + UserId);
		try {
			
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String irsSpecificationId = req.getParameter("irsSpecificationId");
			String fieldGroupId = req.getParameter("fieldGroupId");
			String irsFieldDescId = req.getParameter("irsFieldDescId");
			
			IRSFieldDescription fieldDesc = service.getIRSFieldDescriptionById(irsFieldDescId);
			fieldDesc.setIsActive(0);
			
			long result = service.addIRSFieldDescription(fieldDesc);
			
			// Remove the same group fields
			if(fieldGroupId!=null && Long.parseLong(fieldGroupId)>0) {
				service.removeIRSFieldDescription(irsSpecificationId, fieldGroupId);
			}
			
			if (result> 0) {
				redir.addAttribute("result", "Field Description Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Field Description Delete Unsuccessful");
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("irsSpecificationId", irsSpecificationId);
			
			if(docType.equalsIgnoreCase("D")) {
				redir.addAttribute("logicalInterfaceId", req.getParameter("logicalInterfaceId"));
				return "redirect:/IDDDesignDetails.htm";
			}
			
			return "redirect:/IRSSpecificationsDetails.htm";
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSFieldDescDelete.htm " + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="IRSNewFieldDescSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsNewFieldDescSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSNewFieldDescSubmit.htm " + UserId);
		try {
			
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String irsSpecificationId = req.getParameter("irsSpecificationId");
			
			IRSDocumentSpecifications specifications = service.getIRSDocumentSpecificationsById(irsSpecificationId);
			
			int result = addNewIRSFieldDescriptions(req, specifications, UserId);

			if (result> 0) {
				redir.addAttribute("result", "Field Description Submitted Successfully");
			} else {
				redir.addAttribute("resultfail", "Field Description Submit Unsuccessful");
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("irsSpecificationId", irsSpecificationId);
			
			if(docType.equalsIgnoreCase("D")) {
				redir.addAttribute("logicalInterfaceId", req.getParameter("logicalInterfaceId"));
				return "redirect:/IDDDesignDetails.htm";
			}
			
			return "redirect:/IRSSpecificationsDetails.htm";
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSNewFieldDescSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}

	private int addNewIRSFieldDescriptions(HttpServletRequest req, IRSDocumentSpecifications spec, String userId) throws Exception {
	   
		try {
			// Remove Existing Field Description
			//service.removeIRSFieldDescription(String.valueOf(spec.getLogicalInterfaceId()));
   
		    String docId = req.getParameter("docId");
		    String slno = req.getParameter("slno");
		    int fieldSlNo = Integer.parseInt(slno);
		    String[] fieldGroupIds = req.getParameterValues("fieldGroupId");
		    String[] fieldMasterIds = req.getParameterValues("fieldMasterId");
		    String[] arrayMasterIds = req.getParameterValues("arrayMasterId");
		    String[] groupVariables = req.getParameterValues("groupVariable");

//		    System.out.println("fieldGroupIds size: "+fieldGroupIds.length);
//		    System.out.println("fieldMasterIds size: "+fieldMasterIds.length);
//		    System.out.println("fieldGroupIds: "+fieldGroupIds.toString());
//		    System.out.println("fieldMasterIds: "+fieldMasterIds.toString());
//		    
//		    for (int i = 0; i < fieldMasterIds.length; i++) {
//			    System.out.println("fieldMasterIds[i]: "+fieldMasterIds[i]);
//		    }
			List<IRSFieldDescription> irsFieldDescriptionEntityList = service.getIRSFieldDescriptionEntityList(docId);
			
		    for (int i = 0; i < fieldMasterIds.length; i++) {
				
				IRSFieldDescription fieldDesc = new IRSFieldDescription();
				fieldDesc.setIRSSpecificationId(spec.getIRSSpecificationId());
				fieldDesc.setLogicalInterfaceId(spec.getLogicalInterfaceId());
				fieldDesc.setFieldGroupId(fieldGroupIds!=null?Long.parseLong(fieldGroupIds[i]):0L);
				fieldDesc.setFieldMasterId(fieldMasterIds!=null?Long.parseLong(fieldMasterIds[i]):0L);

				IRSFieldDescription irsFieldDescription = irsFieldDescriptionEntityList.stream().filter(e -> e.getFieldMasterId().equals(fieldDesc.getFieldMasterId())).findFirst().orElse(null);
				
				FieldMaster fieldMaster = service.getFieldMasterById(fieldDesc.getFieldMasterId()+"");
				
				fieldDesc.setFieldName(fieldMaster.getFieldName());
				fieldDesc.setFieldShortName(fieldMaster.getFieldShortName());
				fieldDesc.setFieldCode(fieldMaster.getFieldCode());
				fieldDesc.setDataTypeMasterId(fieldMaster.getDataTypeMasterId());
				
				fieldDesc.setTypicalValue(irsFieldDescription!=null?irsFieldDescription.getTypicalValue():fieldMaster.getTypicalValue());
				fieldDesc.setFieldMinValue(irsFieldDescription!=null?irsFieldDescription.getFieldMinValue():fieldMaster.getFieldMinValue());
				fieldDesc.setFieldMaxValue(irsFieldDescription!=null?irsFieldDescription.getFieldMinValue():fieldMaster.getFieldMaxValue());
				fieldDesc.setInitValue(irsFieldDescription!=null?irsFieldDescription.getInitValue():fieldMaster.getInitValue());
				fieldDesc.setQuantum(irsFieldDescription!=null?irsFieldDescription.getQuantum():fieldMaster.getQuantum());
				fieldDesc.setFieldDesc(irsFieldDescription!=null?irsFieldDescription.getFieldDesc():fieldMaster.getFieldDesc());
				fieldDesc.setFieldUnit(irsFieldDescription!=null?irsFieldDescription.getFieldUnit():fieldMaster.getFieldUnit());
				fieldDesc.setRemarks(irsFieldDescription!=null?irsFieldDescription.getRemarks():fieldMaster.getRemarks());
				
				fieldDesc.setArrayMasterId(arrayMasterIds!=null?Long.parseLong(arrayMasterIds[i]):0L);
				fieldDesc.setGroupVariable(fieldDesc.getFieldGroupId()>0?groupVariables[i]:null);
				fieldDesc.setFieldSlNo(++fieldSlNo);
				fieldDesc.setCreatedBy(userId);
				fieldDesc.setCreatedDate(sdtf.format(new Date()));
				fieldDesc.setIsActive(1);
				
				service.addIRSFieldDescription(fieldDesc);
			}
		    return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@RequestMapping(value = "IRSSpecificationDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsSpecificationDelete(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSSpecificationDelete.htm " + UserId);
		try {
			
			long result = service.deleteIRSSpecifiactionById(req.getParameter("irsSpecificationId"));

			if (result > 0) {
				redir.addAttribute("result", "IRS Details Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "IRS Details Delete Unsuccessful");
			}

			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			
			return "redirect:/IRSSpecificationsDetails.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSSpecificationDelete.htm " + UserId);
			return "static/Error";
		}
	}

	@RequestMapping(value = "IRSDocumentApprovalSubmit.htm", method = { RequestMethod.GET, RequestMethod.POST })
	public String irsDocumentApprovalSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + "Inside IRSDocumentApprovalSubmit.htm" + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String action = req.getParameter("Action");
			String remarks = req.getParameter("remarks");

			PfmsIRSDocument irsDocument = service.getPfmsIRSDocumentById(docId);
			String statusCode = irsDocument.getIRSStatusCode();

			List<String> irsforwardstatus = Arrays.asList("RIN", "RRR", "RRA", "REV");

			long result = service.irsDocumentApprovalForward(docId, docType, action, remarks, EmpId, labcode, UserId);

//			if (result != 0 && reqInitiation.getReqStatusCode().equalsIgnoreCase("RFA") && reqInitiation.getReqStatusCodeNext().equalsIgnoreCase("RAM")) {
//				// PDF Freeze
//				service.igiDocPdfFreeze(req, resp, docId, labcode);
//			}

			if (action.equalsIgnoreCase("A")) {
				if (irsforwardstatus.contains(statusCode)) {
					if (result != 0) {
						redir.addAttribute("result", "IRS Document Forwarded Successfully");
					} else {
						redir.addAttribute("resultfail", "IRS Document Forward Unsuccessful");
					}
					redir.addAttribute("projectType", req.getParameter("projectType"));
					redir.addAttribute("projectId", req.getParameter("projectId"));
					redir.addAttribute("initiationId", req.getParameter("initiationId"));
					redir.addAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
					
					return "redirect:/IRSDocumentList.htm";
				} else if (statusCode.equalsIgnoreCase("RFW")) {
					if (result != 0) {
						redir.addAttribute("result", "IRS Document Recommende d Successfully");
					} else {
						redir.addAttribute("resultfail", "IRS Document Recommend Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				} else if (statusCode.equalsIgnoreCase("RFR")) {
					if (result != 0) {
						redir.addAttribute("result", "IRS Document Approved Successfully");
					} else {
						redir.addAttribute("resultfail", "IRS Document Approve Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				}
			} else if (action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if (result != 0) {
					redir.addAttribute("result", action.equalsIgnoreCase("R") ? "IRS Document Returned Successfully" : "IRS Document Disapproved Successfully");
				} else {
					redir.addAttribute("resultfail", action.equalsIgnoreCase("R") ? "IRS Document Return Unsuccessful" : "IRS Document Disapprove Unsuccessful");
				}
			}
			return "redirect:/DocumentApprovals.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSDocumentApprovalSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="IRSDocumentUserRevoke.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String irsDocumentUserRevoke(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside IRSDocumentUserRevoke.htm "+UserId);
		try {
			String irsDocId = req.getParameter("irsDocId");
            
			long count = service.irsDocumentUserRevoke(irsDocId, UserId, EmpId);
			
			if (count > 0) {
				redir.addAttribute("result", "IRS Document Revoked Successfully");
			}else {
				redir.addAttribute("resultfail", "IRS Document Revoke Unsuccessful");	
			}	

			redir.addAttribute("projectType", req.getParameter("projectType"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("initiationId", req.getParameter("initiationId"));
			redir.addAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
			return "redirect:/IRSDocumentList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside IRSDocumentUserRevoke.htm "+UserId, e);
			return "static/Error";			
		}

	}
	
	@RequestMapping(value="IRSFieldDescModify.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsFieldDescModify(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSFieldDescModify.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String irsDocId = req.getParameter("irsDocId");
			String docType = req.getParameter("docType");

			req.setAttribute("docId", docId);
			req.setAttribute("docType", docType);
			req.setAttribute("irsDocId", irsDocId);
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			req.setAttribute("irsSpecificationsList", service.getIRSDocumentSpecificationsList(irsDocId));
			req.setAttribute("fieldMasterList", service.fieldMasterList());
			req.setAttribute("dataTypeMasterList", service.dataTypeMasterList());
			req.setAttribute("fieldDescriptionList", service.getIRSFieldDescriptionList(irsDocId));
			req.setAttribute("fieldGroupList", service.getFieldGroupMasterList());
			
			return "documents/IRSFieldDescModify";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSFieldDescModify.htm " + UserId, e);
			return "static/Error";
		}
		
	}

	@RequestMapping(value="IRSFieldDescModifySubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsFieldDescModifySubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSFieldDescModifySubmit.htm " + UserId);
		try {
			String irsDocId = req.getParameter("irsDocId");

			String fieldMasterId = req.getParameter("fieldMasterId");
		    String typicalValue = req.getParameter("typicalValue");
		    String minValue = req.getParameter("minValue");
		    String maxValue = req.getParameter("maxValue");
		    String initValue = req.getParameter("initValue");
		    String quantum = req.getParameter("quantum");
		    String unit = req.getParameter("unit");
		    String description = req.getParameter("description");
		    String remarks = req.getParameter("remarks");

		    long result = 0;
		    List<IRSFieldDescription> irsFieldDescriptionEntityList = service.getIRSFieldDescriptionEntityList(irsDocId);
		    irsFieldDescriptionEntityList = irsFieldDescriptionEntityList.stream().filter(e -> e.getFieldMasterId() == Long.parseLong(fieldMasterId)).collect(Collectors.toList());
		    for (int i = 0; i < irsFieldDescriptionEntityList.size(); i++) {
				
				IRSFieldDescription fieldDesc = irsFieldDescriptionEntityList.get(i);
				
				fieldDesc.setTypicalValue(typicalValue);
				fieldDesc.setFieldMinValue(minValue);
				fieldDesc.setFieldMaxValue(maxValue);
				fieldDesc.setInitValue(initValue);
				fieldDesc.setQuantum(quantum);
				fieldDesc.setFieldUnit(unit);
				fieldDesc.setFieldDesc(description);
				fieldDesc.setRemarks(remarks);
				
				fieldDesc.setModifiedBy(UserId);
				fieldDesc.setModifiedDate(sdtf.format(new Date()));
				
				result = service.addIRSFieldDescription(fieldDesc);
			}
		    
		    if (result > 0) {
				redir.addAttribute("result", "Field Description Updated Successfully");
			}else {
				redir.addAttribute("resultfail", "Field Description Update Unsuccessful");	
			}	
		    
			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("irsDocId", irsDocId);
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			return "redirect:/IRSFieldDescModify.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSFieldDescModifySubmit.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "IRSArrayMaster.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsArrayMaster(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSArrayMaster.htm " + UserId);
		try {
			String irsDocId = req.getParameter("irsDocId");
			String arrayMasterId = req.getParameter("arrayMasterId");
			arrayMasterId = arrayMasterId==null?"0":arrayMasterId;
			
			req.setAttribute("arrayMasterList", service.getIRSArrayMasterListByIRSDocId(irsDocId));
			
			req.setAttribute("docId", req.getParameter("docId"));
			req.setAttribute("irsDocId", irsDocId);
			req.setAttribute("arrayMasterId", arrayMasterId);
			req.setAttribute("docType", req.getParameter("docType"));
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			return "documents/IRSArrayMaster";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSArrayMaster.htm " + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="IRSArrayMasterDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsArrayMasterDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSArrayMasterDetailsSubmit.htm " + UserId);
		try {
			String action = req.getParameter("action");
			String arrayMasterId = req.getParameter("arrayMasterId");
			String arrayValue = req.getParameter("arrayValue");
			String irsDocId = req.getParameter("irsDocId");
			
			boolean isNew = arrayMasterId.equalsIgnoreCase("0")? true: false;
			
			IRSArrayMaster arrayMaster = isNew?new IRSArrayMaster() : service.getIRSArrayMasterById(arrayMasterId);
			arrayMaster.setArrayName(req.getParameter("arrayName"));
			arrayMaster.setArrayValue(arrayValue!=null?Integer.parseInt(arrayValue):0);
			
			if(isNew) {
				arrayMaster.setIRSDocId(Long.parseLong(irsDocId));
				arrayMaster.setCreatedBy(UserId);
				arrayMaster.setCreatedDate(sdtf.format(new Date()));
				arrayMaster.setIsActive(1);
			}else {
				arrayMaster.setModifiedBy(UserId);
				arrayMaster.setModifiedDate(sdtf.format(new Date()));
			}
			
			long result = service.addIRSArrayMaster(arrayMaster);
			
			if (result!=0) {
				redir.addAttribute("result", "Array Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Array Details "+action+" Unsuccessful");	
			}
			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("irsDocId", irsDocId);
			redir.addAttribute("arrayMasterId", result);
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			return "redirect:/IRSArrayMaster.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSArrayMasterDetailsSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="IRSFieldDescSerialNoUpdate.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsFieldSerialNoUpdate(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside IRSFieldSerialNoUpdate.htm "+UserId);
		try
		{
			String docType = req.getParameter("docType");
			String irsSpecificationId = req.getParameter("irsSpecificationId");

			String[] newslno = req.getParameterValues("newslno");
			String[] irsFieldDescId = req.getParameterValues("irsFieldDescId");

			Set<String> s = new HashSet<String>(Arrays.asList(newslno));

			int result = 0;
			if (s.size() == newslno.length) {
				result = service.irsFieldDescSerialNoUpdate(newslno, irsFieldDescId);
			}
			
			if (result!=0) {
				redir.addAttribute("result", "Serial No Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "Serial No Update UnSuccessfull");
			}	

			redir.addAttribute("irsSpecificationId", irsSpecificationId);
			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("docType", docType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			
			if(docType.equalsIgnoreCase("D")) {
				redir.addAttribute("logicalInterfaceId", req.getParameter("logicalInterfaceId"));
				return "redirect:/IDDDesignDetails.htm";
			}
			
			return "redirect:/IRSSpecificationsDetails.htm";
		} catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside IRSFieldSerialNoUpdate.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	/* ************************************************ IRS Document End ***************************************************** */
	
	/* ************************************************ IDD Document ***************************************************** */
	
	@RequestMapping(value = "IDDDocumentList.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String iddDocumentList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String LoginType = (String) ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		
		logger.info(new Date() + " Inside IDDDocumentList.htm " + UserId);
		
		try {
			String projectType = req.getParameter("projectType");
			projectType = projectType != null ? projectType : "M";
			String initiationId = "0";
			String projectId = "0";
			String productTreeMainId = req.getParameter("productTreeMainId");
			
			if (projectType.equalsIgnoreCase("M")) {

				projectId = req.getParameter("projectId");
				//productTreeMainId = req.getParameter("productTreeMainId");
				List<Object[]> projectList = projectservice.LoginProjectDetailsList(EmpId, LoginType, labcode);
				
				projectId = projectId != null ? projectId : (projectList.size() > 0 ? projectList.get(0)[0].toString() : "0");
				productTreeMainId = productTreeMainId != null ? productTreeMainId : "0";
				
				req.setAttribute("projectDetails", projectservice.getProjectDetails(labcode, projectId, "E"));
				req.setAttribute("projectList", projectList);
				req.setAttribute("productTreeAllList", service.getProductTreeAllList(projectId, "0"));
				
			}else {
				initiationId = req.getParameter("initiationId");
				//productTreeMainId = req.getParameter("productTreeMainId");
				List<Object[]> preProjectList = reqservice.getPreProjectList(LoginType, labcode, EmpId);
				initiationId = initiationId != null ? initiationId : (preProjectList.size() > 0 ? preProjectList.get(0)[0].toString() : "0");
				productTreeMainId = productTreeMainId != null ? productTreeMainId : "0";
				
				req.setAttribute("projectDetails", projectservice.getProjectDetails(labcode, initiationId, "P"));
				req.setAttribute("preProjectList", preProjectList);
				req.setAttribute("productTreeAllList", service.getProductTreeAllList("0", initiationId));
			}
			req.setAttribute("projectId", projectId);
			req.setAttribute("initiationId", initiationId);
			req.setAttribute("productTreeMainId", productTreeMainId);
			req.setAttribute("projectType", projectType);
			
			List<Object[]> iddDocumentList = service.getIDDDocumentList(projectId, initiationId, productTreeMainId);
			req.setAttribute("iddDocumentList", iddDocumentList);
			
			if(iddDocumentList!=null && iddDocumentList.size()>0) {
				req.setAttribute("iddDocumentSummaryList", service.getDocumentSummaryList(iddDocumentList.get(iddDocumentList.size()-1)[0].toString(), "D"));
			}
			
			return "documents/IDDDocumentList";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IDDDocumentList.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "IDDDocumentAdd.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String iddDocumentAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside IDDDocumentAdd.htm" + UserId);
		
		try {
			String projectType = req.getParameter("projectType");
			String projectId = req.getParameter("projectId");
			String initiationId = req.getParameter("initiationId");
			String productTreeMainId = req.getParameter("productTreeMainId");
			String isAmend = req.getParameter("isAmend");
			String iddDocId = req.getParameter("iddDocId");
			
			PfmsIDDDocument pfmsIDDDocument = PfmsIDDDocument.builder()
												.ProjectId(Long.parseLong(projectId!=null?projectId:"0"))
												.InitiationId(Long.parseLong(initiationId!=null?initiationId:"0"))
												.ProductTreeMainId(productTreeMainId!=null?Long.parseLong(productTreeMainId):0L)
												.IDDVersion(req.getParameter("version"))
												.LabCode(labcode)
												.InitiatedBy(EmpId)
												.InitiatedDate(sdf.format(new Date()))
												.IDDStatusCode("RIN")
												.IDDStatusCodeNext("RIN")
												.CreatedBy(UserId)
												.CreatedDate(sdtf.format(new Date()))
												.IsActive(1)
											.build();
			
			long result = service.addPfmsIDDDocument(pfmsIDDDocument);
			
			if(isAmend!=null && isAmend.equalsIgnoreCase("Y")) {
				service.iddDocumentApprovalForward(iddDocId, "D", "A", req.getParameter("remarks"), EmpId, labcode, UserId);
			}
			
			// Transaction 
			service.addPfmsIGITransaction(result, "D", "RIN", null, Long.parseLong(EmpId));
			
			
			if (result > 0) {
				redir.addAttribute("result", "IDD Document Data Submitted Successfully");
			} else {
				redir.addAttribute("resultfail", "IDD Document Data Submit Unsuccessful");
			}
			
			redir.addAttribute("projectType", projectType);
			redir.addAttribute("projectId", projectId);
			redir.addAttribute("initiationId", initiationId);
			redir.addAttribute("productTreeMainId", productTreeMainId);
			return "redirect:/IDDDocumentList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IDDDocumentAdd.htm " + UserId, e);
			return "static/Error";
			
		}
		
	}
	
	@RequestMapping(value = "IDDDocumentDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String iddDocumentDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		
		logger.info(new Date() + " Inside IDDDocumentDetails.htm " + UserId);
		
		try {
			String iddDocId = req.getParameter("iddDocId");
			PfmsIDDDocument iddDocument = service.getPfmsIDDDocumentById(iddDocId);
			req.setAttribute("iddDocument", iddDocument);
			req.setAttribute("version", iddDocument!=null ?iddDocument.getIDDVersion():"1.0");
			
			iddDocId = service.getFirstVersionIDDDocId(iddDocument.getProjectId()+"", iddDocument.getInitiationId()+"", iddDocument.getProductTreeMainId()+"")+"";
			
			String projectType = iddDocument.getProjectId()!=0?"E":"M";
			req.setAttribute("projectType", projectType);
			req.setAttribute("projectDetails", projectservice.getProjectDetails(labcode, (iddDocument.getProjectId()!=0?iddDocument.getProjectId()+"":iddDocument.getInitiationId()+"") , projectType));
			
			req.setAttribute("iddDocId", iddDocId);
			req.setAttribute("iddDocumentSummaryList", service.getDocumentSummaryList(iddDocId, "D"));
			req.setAttribute("totalEmployeeList", projectservice.EmployeeList(labcode));
			req.setAttribute("memberList", service.getDocumentMemberList(iddDocId, "D"));
			req.setAttribute("employeeList", service.getDocmployeeListByDocId(labcode, iddDocId, "D"));
			req.setAttribute("shortCodesList", service.getIGIDocumentShortCodesList());
			req.setAttribute("shortCodesLinkedList", service.getIGIShortCodesLinkedListByType(iddDocId, "D"));
			req.setAttribute("docTempAttributes", projectservice.DocTempAttributes());
			req.setAttribute("labDetails", projectservice.LabListDetails(labcode));
			req.setAttribute("lablogo",  logoUtil.getLabLogoAsBase64String(labcode)); 
			req.setAttribute("drdologo", logoUtil.getDRDOLogoAsBase64String());
			req.setAttribute("applicableDocsList", service.getStandardDocuments());
			req.setAttribute("iddApplicableDocsList", service.getIGIApplicableDocs(iddDocId, "D"));
			req.setAttribute("igiDocumentIntroductionList", service.getIGIDocumentIntroductionList());

			req.setAttribute("isPdf", req.getParameter("isPdf"));
			
			String irsDocId = service.getFirstVersionIRSDocId(iddDocument.getProjectId()+"", iddDocument.getInitiationId()+"", iddDocument.getProductTreeMainId()+"")+"";
			req.setAttribute("irsSpecificationsList", service.getIRSDocumentSpecificationsList(irsDocId));
			
			req.setAttribute("fieldDescriptionList", service.getIRSFieldDescriptionList(irsDocId));
			req.setAttribute("logicalInterfaceList", service.getIGILogicalInterfaces());
			req.setAttribute("logicalChannelList", service.getIGILogicalChannelList());
			
			return "documents/IDDDocumentDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IDDDocumentDetails.htm " + UserId, e);
			return "static/Error";
		}

	}

	@RequestMapping(value = "IDDDesignDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String iddDesignDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IDDDesignDetails.htm " + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");

			PfmsIDDDocument iddDocument = service.getPfmsIDDDocumentById(docId);
			String irsDocId = service.getFirstVersionIRSDocId(iddDocument.getProjectId()+"", iddDocument.getInitiationId()+"", iddDocument.getProductTreeMainId()+"")+"";
			req.setAttribute("docId", docId);
			req.setAttribute("docType", docType);
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			req.setAttribute("iddDocument", iddDocument);
			
			String logicalInterfaceId = req.getParameter("logicalInterfaceId");
			List<Object[]> irsSpecificationsList = service.getIRSDocumentSpecificationsList(irsDocId);
			
			if(logicalInterfaceId==null && (irsSpecificationsList!=null && irsSpecificationsList.size()>0)) {
				logicalInterfaceId = irsSpecificationsList.get(0)[3].toString();
			}
			req.setAttribute("logicalInterfaceId", logicalInterfaceId);
			req.setAttribute("irsSpecificationsList", irsSpecificationsList);
			req.setAttribute("irsDocId", irsDocId);
			req.setAttribute("fieldMasterList", service.fieldMasterList());
			req.setAttribute("dataTypeMasterList", service.dataTypeMasterList());
			req.setAttribute("fieldDescriptionList", service.getIRSFieldDescriptionList(irsDocId));
			req.setAttribute("fieldGroupList", service.getFieldGroupMasterList());
			req.setAttribute("arrayMasterList", service.getIRSArrayMasterListByIRSDocId(irsDocId));

			return "documents/IDDDesignDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IDDDesignDetails.htm " + UserId, e);
			return "static/Error";
		}
		
	}

	@RequestMapping(value = "IDDDocumentApprovalSubmit.htm", method = { RequestMethod.GET, RequestMethod.POST })
	public String iddDocumentApprovalSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + "Inside IDDDocumentApprovalSubmit.htm" + UserId);
		try {
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String action = req.getParameter("Action");
			String remarks = req.getParameter("remarks");

			PfmsIDDDocument iddDocument = service.getPfmsIDDDocumentById(docId);
			String statusCode = iddDocument.getIDDStatusCode();

			List<String> iddforwardstatus = Arrays.asList("RIN", "RRR", "RRA", "REV");

			long result = service.iddDocumentApprovalForward(docId, docType, action, remarks, EmpId, labcode, UserId);

//			if (result != 0 && reqInitiation.getReqStatusCode().equalsIgnoreCase("RFA") && reqInitiation.getReqStatusCodeNext().equalsIgnoreCase("RAM")) {
//				// PDF Freeze
//				service.igiDocPdfFreeze(req, resp, docId, labcode);
//			}

			if (action.equalsIgnoreCase("A")) {
				if (iddforwardstatus.contains(statusCode)) {
					if (result != 0) {
						redir.addAttribute("result", "IRS Document Forwarded Successfully");
					} else {
						redir.addAttribute("resultfail", "IRS Document Forward Unsuccessful");
					}
					redir.addAttribute("projectType", req.getParameter("projectType"));
					redir.addAttribute("projectId", req.getParameter("projectId"));
					redir.addAttribute("initiationId", req.getParameter("initiationId"));
					redir.addAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
					
					return "redirect:/IDDDocumentList.htm";
				} else if (statusCode.equalsIgnoreCase("RFW")) {
					if (result != 0) {
						redir.addAttribute("result", "IRS Document Recommende d Successfully");
					} else {
						redir.addAttribute("resultfail", "IRS Document Recommend Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				} else if (statusCode.equalsIgnoreCase("RFR")) {
					if (result != 0) {
						redir.addAttribute("result", "IRS Document Approved Successfully");
					} else {
						redir.addAttribute("resultfail", "IRS Document Approve Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				}
			} else if (action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if (result != 0) {
					redir.addAttribute("result", action.equalsIgnoreCase("R") ? "IRS Document Returned Successfully" : "IRS Document Disapproved Successfully");
				} else {
					redir.addAttribute("resultfail", action.equalsIgnoreCase("R") ? "IRS Document Return Unsuccessful" : "IRS Document Disapprove Unsuccessful");
				}
			}
			return "redirect:/DocumentApprovals.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IDDDocumentApprovalSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="IDDDocumentUserRevoke.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String iddDocumentUserRevoke(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside IDDDocumentUserRevoke.htm "+UserId);
		try {
			String iddDocId = req.getParameter("iddDocId");
            
			long count = service.iddDocumentUserRevoke(iddDocId, UserId, EmpId);
			
			if (count > 0) {
				redir.addAttribute("result", "IDD Document Revoked Successfully");
			}
			else {
				redir.addAttribute("resultfail", "IDD Document Revoke Unsuccessful");	
			}	

			redir.addAttribute("projectType", req.getParameter("projectType"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			redir.addAttribute("initiationId", req.getParameter("initiationId"));
			redir.addAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
			return "redirect:/IDDDocumentList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside IDDDocumentUserRevoke.htm "+UserId, e);
			return "static/Error";			
		}

	}
	
	@RequestMapping(value = "IDDFieldDescriptionHFileDownload.htm", method = RequestMethod.GET)
	public ResponseEntity<byte[]> iddFieldDescriptionHFileDownload(HttpServletRequest req) throws Exception {
	    String logicalInterfaceId = req.getParameter("logicalInterfaceId");
	    String irsDocId = req.getParameter("irsDocId");

	    List<Object[]> fieldDescriptionList = service.getIRSFieldDescriptionList(irsDocId);
	    IGILogicalInterfaces logicalInterface = service.getIGILogicalInterfaceById(logicalInterfaceId);
	    
	    fieldDescriptionList = fieldDescriptionList.stream().filter(e -> logicalInterfaceId.equalsIgnoreCase(e[1].toString())).collect(Collectors.toList());

	    if (fieldDescriptionList == null || logicalInterface == null) {
	        return ResponseEntity.badRequest().body(null);
	    }
	    
	    String content = generateFieldDescHeaderContent(fieldDescriptionList, logicalInterface);
	    String fileName = logicalInterface.getMsgCode().replaceAll("[^a-zA-Z0-9_]", "_") + ".h";

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.TEXT_PLAIN);
	    headers.setContentDisposition(ContentDisposition.builder("attachment")
	        .filename(fileName)
	        .build());

	    return new ResponseEntity<>(content.getBytes(), headers, HttpStatus.OK);
	}
	
	public static String generateFieldDescHeaderContent(List<Object[]> fieldDescriptionList, IGILogicalInterfaces logicalInterface) {

		String messageCode = logicalInterface.getMsgName().toUpperCase();
		double messageLength = 0.00;
		
	    String sanitizedMessageCode = messageCode.replaceAll("[^a-zA-Z0-9_]", "_");
	    if (Character.isDigit(sanitizedMessageCode.charAt(0))) {
	        sanitizedMessageCode = "_" + sanitizedMessageCode;
	    }

	    StringBuilder sb = new StringBuilder();
	    
	    sb.append("// ").append(sanitizedMessageCode).append("  -  ").append("__MSG_LENGTH_PLACEHOLDER__").append("  bytes").append("\n\n");
	    
	    sb.append("#ifndef __").append(sanitizedMessageCode).append("_H\n");
	    sb.append("#define __").append(sanitizedMessageCode).append("_H\n\n");
	    
	    sb.append("#include <stdio.h>\n");
	    sb.append("#include <ltypes.h>\n");
	    sb.append("#include <constants.h>\n\n");
	    sb.append("typedef struct _TS").append(sanitizedMessageCode).append(" {\n");

	    Map<Long, List<Object[]>> groupedMap = fieldDescriptionList.stream().filter(e -> Long.parseLong(e[12].toString())!=0).collect(Collectors.groupingBy(e -> Long.parseLong(e[12].toString())));
	    List<Object[]> fieldList = fieldDescriptionList.stream().filter(e -> Long.parseLong(e[12].toString())==0).collect(Collectors.toList());
	    
	    // Calculate max length of fields / group name
	    int maxLength = fieldDescriptionList.stream()
	        .mapToInt(field -> {
	            if (Long.parseLong(field[12].toString()) == 0) {
	                return field[27] != null ? field[27].toString().length() : 4;
	            } else {
	                String grpName = field[23] != null ? field[23].toString().toUpperCase() : "UnknownGroup";
	                return ("_S" + grpName).length();
	            }
	        }).max().orElse(0);
		
	    // Include Group names
	    for (Map.Entry<Long, List<Object[]>> entry : groupedMap.entrySet()) {
	    	List<Object[]> groupRows = entry.getValue();
	    	Object[] rep = groupRows.get(0);

	    	String grpName = rep[23] != null ? rep[23].toString().toUpperCase() : "UnknownGroup";
	    	String grpVariable = rep[26] != null ? rep[26].toString() : "unknownVar";
	    	String arr = rep[21] != null ? "[" + rep[21] + "]" : "";

	    	String paddedName = String.format("%-" + (maxLength+6) + "s", "_S"+grpName);
	    	sb.append("    ").append(paddedName).append("s").append(grpVariable.toLowerCase()).append(arr).append(";\n");

	    	// Calculate no of bytes
	    	for (Object[] field : groupRows) {
	    		int dataLength = Integer.parseInt(field[4].toString());
	    		double lengthInBytes = dataLength * 0.125;

	    		if (field[21] != null) {
	    			int arrValue = Integer.parseInt(field[22].toString());
	    			messageLength += (lengthInBytes * arrValue);
	    		} else {
	    			messageLength += lengthInBytes;
	    		}
	    	}
	    }

	    // Include only fields which are not linked with any group
	    for (Object[] field : fieldList) {
	        int dataLength = Integer.parseInt(field[4].toString());
	        double lengthInBytes = dataLength * 0.125;
	        
	        String fieldName = field[8] != null ? field[8].toString().replaceAll("\\s+", "") : "unknownField";
            String cType = field[27] != null ? field[27]+"" : "void*";
            String arr = "";
         // Calculate no of bytes
            if(field[21] != null) {
            	arr = "[" + field[21] + "]";
            	int arrValue = Integer.parseInt(field[22].toString());
            	messageLength+=(lengthInBytes*arrValue);
            }else {
            	messageLength+=lengthInBytes;
            }
            
            String paddedName = String.format("%-" + (maxLength+6) + "s", cType);
            sb.append("    ").append(paddedName).append(field[11]+"").append(fieldName).append(arr).append(";\n");
	    }

	    sb.append("} _S").append(sanitizedMessageCode).append(";\n\n");

	    sb.append("#endif       // __").append(sanitizedMessageCode).append("_H\n");

	    String fullHeader = sb.toString();
	    fullHeader = fullHeader.replace("__MSG_LENGTH_PLACEHOLDER__", String.valueOf((int)messageLength));
	    
	    return fullHeader;
	}

//	public static String generateFieldDescHeaderContent(List<Object[]> fieldDescriptionList, IGILogicalInterfaces logicalInterface) {
//
//		String messageCode = logicalInterface.getMsgName();
//		double messageLength = 0.00;
//		
//	    String sanitizedMessageCode = messageCode.replaceAll("[^a-zA-Z0-9_]", "_");
//	    if (Character.isDigit(sanitizedMessageCode.charAt(0))) {
//	        sanitizedMessageCode = "_" + sanitizedMessageCode;
//	    }
//
//	    StringBuilder sb = new StringBuilder();
//	    StringBuilder sbmiddle = new StringBuilder(); // for typedef structs
//	    StringBuilder sblast = new StringBuilder();   // for main struct fields
//	    
//	    sb.append("// ").append(sanitizedMessageCode).append("  -  ").append("__MSG_LENGTH_PLACEHOLDER__").append("  bytes").append("\n\n");
//	    
////	    List<Long> fieldDescArrMasterIds =  fieldDescriptionList.stream().map(e -> e[20]!=null?Long.parseLong(e[20].toString()):0L).collect(Collectors.toList());
////	    arrayMasterList = arrayMasterList.stream().filter(e -> fieldDescArrMasterIds.contains(e.getArrayMasterId())).collect(Collectors.toList());
//	    
//	    sb.append("\n");
//
//	    sb.append("#ifndef ").append(sanitizedMessageCode.toUpperCase()).append("_H\n");
//	    sb.append("#define ").append(sanitizedMessageCode.toUpperCase()).append("_H\n\n");
//	    
////	    for (IRSArrayMaster arr : arrayMasterList) {
////	        sb.append("#define ").append(arr.getArrayName()).append(" ").append(arr.getArrayValue()).append("\n");
////	    }
////
////	    sb.append("\n");
//	    
//	    sb.append("#include <stdio.h>\n");
//	    sb.append("#include <ltypes.h>\n");
//	    sb.append("#include <constants.h>\n\n");
//
//	    Set<Long> processedGroups = new HashSet<>();
//
//	    for (Object[] field : fieldDescriptionList) {
//	    	
//	        Long groupId = Long.parseLong(field[12].toString());
//	        int dataLength = Integer.parseInt(field[4].toString());
//	        double lengthInBytes = dataLength * 0.125;
//	        
//	        if (groupId == 0) {
//	            String fieldName = field[8] != null ? field[8].toString().replaceAll("\\s+", "") : "unknownField";
//	            String cType = field[27] != null ? field[27]+"" : "void*";
//	            String arr = "";
//	            if(field[21] != null) {
//	            	arr = "[" + field[21] + "]";
//	            	int arrValue = Integer.parseInt(field[22].toString());
//	            	messageLength+=(lengthInBytes*arrValue);
//	            }else {
//	            	messageLength+=lengthInBytes;
//	            }
//	            
//	            sblast.append("    ").append(cType).append(" ").append(field[11]+"").append(fieldName).append(arr).append(";\n");
//	            
//	        } else if (groupId!=0) {
//	        	
//	        	List<Object[]> descByGroup = fieldDescriptionList.stream()
//		                .filter(e -> e[12].toString().equals(String.valueOf(groupId)))
//		                .collect(Collectors.toList());
//	        	
//	        	if(descByGroup.size() > 0 && descByGroup.get(0)[21]!=null) {
//	            	int arrValue = Integer.parseInt(field[22].toString());
//	            	messageLength+=(lengthInBytes*arrValue);
//	            }else {
//	            	messageLength+=lengthInBytes;
//	            }
//	        	
//	        	if(!processedGroups.contains(groupId)) {
//	        		processedGroups.add(groupId);
//	        		
//	        		String grpName = descByGroup.size() > 0 ? descByGroup.get(0)[23].toString().toUpperCase() : "UnknownGroup";
//		            String grpVariable = descByGroup.size() > 0 ? descByGroup.get(0)[26] + "" : "unknownVar";
//		            String arr = descByGroup.size() > 0 && descByGroup.get(0)[21]!=null ? "[" + descByGroup.get(0)[21] + "]" : "";
//		            
//		          //String arr = descByGroup.size() > 0 && descByGroup.get(0)[21]!=null ? "[" + descByGroup.get(0)[21] + "]" : "";
//
//		            sbmiddle.append("typedef struct TS").append(grpName).append(" {\n");
//		            
//		            for (Object[] desc : descByGroup) {
//		                String fieldName = desc[8] != null ? desc[8].toString().replaceAll("\\s+", "") : "unknownField";
//		                String cType = desc[27] != null ? desc[27]+"" : "void*";
//		                
//		                sbmiddle.append("    ").append(cType).append(" ").append(desc[11]+"").append(fieldName).append(";\n");
//		            }
//		            
//		            sbmiddle.append("} S").append(grpName).append(";\n\n");
//
//		            sblast.append("    S").append(grpName).append(" s").append(grpVariable.toLowerCase()).append(arr).append(";\n");
//	        	}
//	            
//	        }
//	    }
//
//	    // Now build the main struct
//	    sb.append(sbmiddle); // group typedefs first
//	    sb.append("typedef struct TS").append(sanitizedMessageCode.toUpperCase()).append(" {\n");
//	    sb.append(sblast);   // fields and group references
//	    sb.append("} S").append(sanitizedMessageCode.toUpperCase()).append(";\n\n");
//
//	    sb.append("#endif\n");
//
//	    String fullHeader = sb.toString();
//	    fullHeader = fullHeader.replace("__MSG_LENGTH_PLACEHOLDER__", String.valueOf((int)messageLength));
//	    
//	    return fullHeader;
//	}
	
	@RequestMapping(value = "IGIDataTypeMasterHFileDownload.htm", method = RequestMethod.GET)
	public ResponseEntity<byte[]> igiDataTypeMasterHFileDownload(HttpServletRequest req) throws Exception {
	    String logicalInterfaceId = req.getParameter("logicalInterfaceId");
	    String irsDocId = req.getParameter("irsDocId");

	    List<Object[]> dataTypeList = service.dataTypeMasterList();
	    List<Object[]> fieldDescriptionList = service.getIRSFieldDescriptionList(irsDocId);

	    fieldDescriptionList = fieldDescriptionList.stream()
	        .filter(e -> logicalInterfaceId.equalsIgnoreCase(e[1].toString()))
	        .collect(Collectors.toList());

	    Path tempDir = Files.createTempDirectory("headers_");
	    byte[] zipBytes;

	    try {
	        // 1. Generate group header files + includes
	        StringBuilder includesBuilder = new StringBuilder();
	        generateGroupHeaderFiles(fieldDescriptionList, tempDir, includesBuilder);

	        // 2. Generate ltypes.h
	        String ltypesContent = generateDataTypesHeaderContent(dataTypeList, includesBuilder.toString());
	        Files.write(tempDir.resolve("ltypes.h"), ltypesContent.getBytes());

	        // 3. Create ZIP in memory
	        ByteArrayOutputStream baos = new ByteArrayOutputStream();
	        try (ZipOutputStream zos = new ZipOutputStream(baos)) {
	            Files.walk(tempDir).filter(Files::isRegularFile).forEach(file -> {
	                try {
	                    zos.putNextEntry(new ZipEntry(file.getFileName().toString()));
	                    Files.copy(file, zos);
	                    zos.closeEntry();
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            });
	        }
	        zipBytes = baos.toByteArray();  // safe to delete files after this point

	    } finally {
	        // 4. Clean up temp files and folder
	        try {
	            Files.walk(tempDir)
	                .sorted(Comparator.reverseOrder()) // delete files before folder
	                .forEach(path -> {
	                    try {
	                        Files.deleteIfExists(path);
	                    } catch (IOException e) {
	                        e.printStackTrace();  // optional: log cleanup failure
	                    }
	                });
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

	    // 5. Send response
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	    headers.setContentDisposition(ContentDisposition.builder("attachment")
	        .filename("ltypes.zip")
	        .build());

	    return new ResponseEntity<>(zipBytes, headers, HttpStatus.OK);
	}


	private void generateGroupHeaderFiles(List<Object[]> fieldDescriptionList, Path tempDir, StringBuilder includesBuilder) throws IOException {
	    
		Map<Long, List<Object[]>> groupedMap = fieldDescriptionList.stream().filter(e -> Long.parseLong(e[12].toString()) != 0).collect(Collectors.groupingBy(e -> Long.parseLong(e[12].toString())));

	    int maxLengthGrp = fieldDescriptionList.stream().mapToInt(e -> e[27] != null ? e[27].toString().length() : 0).max().orElse(0);

	    for (Map.Entry<Long, List<Object[]>> entry : groupedMap.entrySet()) {
	        List<Object[]> groupRows = entry.getValue();
	        Object[] rep = groupRows.get(0);
	        String grpName = rep[23] != null ? rep[23].toString() : "UnknownGroup";
	        String fileName = grpName + ".h";

	        includesBuilder.append("#include <").append(fileName).append(">\n");

	        StringBuilder groupFileContent = new StringBuilder();
	        String grpNameUpper = grpName.toUpperCase();
	        groupFileContent.append("#ifndef __").append(grpNameUpper).append("_H\n");
	        groupFileContent.append("#define __").append(grpNameUpper).append("_H\n\n");
	        groupFileContent.append("typedef struct _TS").append(grpNameUpper).append(" {\n");

	        for (Object[] desc : groupRows) {
	            String fieldName = desc[8] != null ? desc[8].toString().replaceAll("\\s+", "") : "unknownField";
	            String cType = desc[27] != null ? desc[27].toString() : "void*";
	            String paddedName = String.format("%-" + (maxLengthGrp + 6) + "s", cType);
	            groupFileContent.append("    ").append(paddedName).append(desc[11]).append(fieldName).append(";\n");
	        }

	        groupFileContent.append("} _S").append(grpNameUpper).append(";\n\n");
	        groupFileContent.append("\n#endif       // __").append(grpNameUpper).append("_H\n");;

	        // Write group file
	        Files.write(tempDir.resolve(fileName), groupFileContent.toString().getBytes());
	    }
	}

	public static String generateDataTypesHeaderContent(List<Object[]> dataTypeList, String includeLines) {
	    StringBuilder sb = new StringBuilder();
	    StringBuilder sbOneByte = new StringBuilder();
	    StringBuilder sbSigned = new StringBuilder();
	    StringBuilder sbUnSigned = new StringBuilder();
	    StringBuilder sbRealNumber = new StringBuilder();
	    StringBuilder sbOthers = new StringBuilder();

	    sb.append("// Data Type Definitions\n");
	    sb.append("#ifndef __LTYPES_H\n");
	    sb.append("#define __LTYPES_H\n\n");

	    sb.append(includeLines).append("\n");

	    sbOneByte.append("// one byte type definitions\n");
	    sbSigned.append("// signed type definitions\n");
	    sbUnSigned.append("// unsigned type definitions\n");
	    sbRealNumber.append("// real number type definitions\n");

	    int maxLength = dataTypeList.stream().mapToInt(e -> e[4] != null ? e[4].toString().length() : 0).max().orElse(0);

	    for (Object[] obj : dataTypeList) {
	        String standardName = obj[4] != null ? obj[4].toString() : "";
	        int dataLength = obj[2] != null ? Integer.parseInt(obj[2].toString()) : 0;
	        double lengthInBytes = dataLength * 0.125;
	        String paddedName = String.format("%-" + (maxLength + 8) + "s", standardName);

	        if (lengthInBytes == 1.0 && !standardName.startsWith("signed")) {
	            sbOneByte.append("typedef ").append(paddedName).append(obj[3]).append(";\n");
	        } else if (standardName.startsWith("signed")) {
	            sbSigned.append("typedef ").append(paddedName).append(obj[3]).append(";\n");
	        } else if (standardName.startsWith("unsigned")) {
	            sbUnSigned.append("typedef ").append(paddedName).append(obj[3]).append(";\n");
	        } else if (standardName.startsWith("_")) {
	            sbOthers.append("typedef ").append(paddedName).append(obj[3]).append(";\n");
	        } else {
	            sbRealNumber.append("typedef ").append(paddedName).append(obj[3]).append(";\n");
	        }
	    }

	    sb.append(sbOneByte).append("\n")
	      .append(sbSigned).append("\n")
	      .append(sbUnSigned).append("\n")
	      .append(sbRealNumber).append("\n")
	      .append(sbOthers).append("\n");

	    sb.append("\n#endif       // __LTYPES_H\n");

	    return sb.toString();
	}
	
	@RequestMapping(value = "IGIConstantsHFileDownload.htm", method = RequestMethod.GET)
	public ResponseEntity<byte[]> igiConstantsHFileDownload(HttpServletRequest req) throws Exception {
		
	    String irsDocId = req.getParameter("irsDocId");

		List<IGIConstants> igiConstantsMasterList = service.getIGIConstantsMasterList();
	    List<IRSArrayMaster> arrayMasterList = service.getIRSArrayMasterListByIRSDocId(irsDocId);

		if ((igiConstantsMasterList == null || igiConstantsMasterList.size()<0) && (arrayMasterList == null || arrayMasterList.size()<0) ) {
			return ResponseEntity.badRequest().body(null);
		}
		
		String content = generateConstantsHeaderContent(igiConstantsMasterList, arrayMasterList);
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.TEXT_PLAIN);
		headers.setContentDisposition(ContentDisposition.builder("attachment")
				.filename("constants.h")
				.build());
		
		return new ResponseEntity<>(content.getBytes(), headers, HttpStatus.OK);
	}
	
	public static String generateConstantsHeaderContent(List<IGIConstants> igiConstantsMasterList, List<IRSArrayMaster> arrayMasterList) {
		StringBuilder sb = new StringBuilder();

		sb.append("// Constant Definitions\n");
		sb.append("#ifndef __CONSTANTS_H\n");
	    sb.append("#define __CONSTANTS_H\n\n");

		// Step 1: Find the maximum length of the array names
		int maxLength1 = arrayMasterList.stream().mapToInt(e -> e.getArrayName().length()).max().orElse(0);
		int maxLength2 = igiConstantsMasterList.stream().mapToInt(e -> e.getConstantName().length()).max().orElse(0);
		int maxLength = Math.max(maxLength1, maxLength2) + 6;
		
		// Step 2: Generate the aligned output
		for (IRSArrayMaster arr : arrayMasterList) {
		    String paddedName = String.format("%-" + maxLength + "s", arr.getArrayName());
		    sb.append("#define ").append(paddedName).append(arr.getArrayValue()).append("\n");
		}

	    sb.append("\n");
			
		for (IGIConstants con : igiConstantsMasterList) {
			String paddedName = String.format("%-" + maxLength + "s", con.getConstantName());
			sb.append("#define ").append(paddedName).append(con.getConstantValue()).append("\n");
		}
		
		sb.append("\n#endif       // __CONSTANTS_H\n");
		
		return sb.toString();
	}	
	
	private String redirectWithError(RedirectAttributes redir,String redirURL, String message) {
	    redir.addAttribute("resultfail", message);
	    return "redirect:/"+redirURL;
	}
	/* ************************************************ IDD Document End ***************************************************** */
	
}
