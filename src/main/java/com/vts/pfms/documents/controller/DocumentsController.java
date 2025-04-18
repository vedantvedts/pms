package com.vts.pfms.documents.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.stream.Collectors;

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
import com.vts.pfms.documents.dto.InterfaceTypeAndContentDto;
import com.vts.pfms.documents.dto.StandardDocumentsDto;
import com.vts.pfms.documents.model.ICDConnectionPurpose;
import com.vts.pfms.documents.model.ICDDocumentConnections;
import com.vts.pfms.documents.model.IGIDocumentIntroduction;
import com.vts.pfms.documents.model.IGIDocumentShortCodes;
import com.vts.pfms.documents.model.IGIDocumentShortCodesLinked;
import com.vts.pfms.documents.model.IGIInterface;
import com.vts.pfms.documents.model.IGIInterfaceContent;
import com.vts.pfms.documents.model.IGIInterfaceTypes;
import com.vts.pfms.documents.model.IGILogicalChannel;
import com.vts.pfms.documents.model.IGILogicalInterfaces;
import com.vts.pfms.documents.model.IRSDocumentSpecifications;
import com.vts.pfms.documents.model.PfmsApplicableDocs;
import com.vts.pfms.documents.model.PfmsICDDocument;
import com.vts.pfms.documents.model.PfmsIDDDocument;
import com.vts.pfms.documents.model.PfmsIGIDocument;
import com.vts.pfms.documents.model.PfmsIRSDocument;
import com.vts.pfms.documents.service.DocumentsService;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.requirements.service.RequirementService;
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
			req.setAttribute("applicableDocsList", service.getPfmsApplicableDocs());
			req.setAttribute("igiApplicableDocsList", service.getIGIApplicableDocs(igiDocId, "A"));
			
			req.setAttribute("interfaceTypesList", service.getIGIInterfaceTypesList());
			req.setAttribute("interfaceContentList", service.getIGIInterfaceContentList());
			
			req.setAttribute("logicalInterfaceList", service.getIGILogicalInterfaces());
			req.setAttribute("logicalChannelList", service.getIGILogicalChannelList());

			req.setAttribute("igiDocumentIntroductionList", service.getIGIDocumentIntroductionList());

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

			req.setAttribute("applicableDocsList", service.getPfmsApplicableDocs());
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

	@RequestMapping(value="IGIApplicableDocumentsDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiApplicableDocumentsDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIApplicableDocumentsDetailsSubmit.htm " + UserId);
		try {
			
			String docId = req.getParameter("docId");
			String docType = req.getParameter("docType");
			String[] documentName = req.getParameterValues("documentName");
			
			if(documentName!=null && documentName.length>0) {
				long result = 0;
				for(int i=0; i<documentName.length; i++) {
					PfmsApplicableDocs igiDocumentShortCode = new PfmsApplicableDocs();
					igiDocumentShortCode.setDocumentName(documentName[i]);
					igiDocumentShortCode.setCreatedBy(UserId);
					igiDocumentShortCode.setCreatedDate(sdtf.format(new Date()));
					igiDocumentShortCode.setIsActive(1);
					
					result = service.addApplicableDocs(igiDocumentShortCode, docId, docType);
				}
				
				if (result > 0) {
					redir.addAttribute("result", "Applicable Documents Added Successfully");
				} else {
					redir.addAttribute("resultfail", "Applicable Documents Add Unsuccessful");
				}
				
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", docType);
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			
			return "redirect:/IGIApplicableDocumentsDetails.htm";

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIApplicableDocumentsDetailsSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}
	
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
			igiInterface.setPartNoEOne(req.getParameter("partNoEOne"));
			igiInterface.setConnectorMakeEOne(req.getParameter("connectorMakeEOne"));
			igiInterface.setStandardEOne(req.getParameter("standardEOne"));
			igiInterface.setProtectionEOne(req.getParameter("protectionEOne"));
			igiInterface.setRefInfoEOne(req.getParameter("refInfoEOne"));
			igiInterface.setRemarksEOne(req.getParameter("remarksEOne"));
			igiInterface.setPartNoETwo(req.getParameter("partNoETwo"));
			igiInterface.setConnectorMakeETwo(req.getParameter("connectorMakeETwo"));
			igiInterface.setStandardETwo(req.getParameter("standardETwo"));
			igiInterface.setProtectionETwo(req.getParameter("protectionETwo"));
			igiInterface.setRefInfoETwo(req.getParameter("refInfoETwo"));
			igiInterface.setRemarksETwo(req.getParameter("remarksETwo"));
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

	@RequestMapping(value="DuplicateInterfaceCodeCheck.htm", method=RequestMethod.GET)
	public @ResponseBody String duplicateInterfaceCodeCheck(HttpSession ses, HttpServletRequest req) throws Exception {
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside DuplicateInterfaceCodeCheck.htm "+UserId);
		Gson json = new Gson();
		Long duplicate=null;
		try
		{	  
	          duplicate = service.getDuplicateInterfaceCodeCount(req.getParameter("interfaceId"), req.getParameter("interfaceCode"));
	          
		}catch (Exception e) {
			logger.error(new Date() +"Inside DuplicateInterfaceCodeCheck.htm "+UserId ,e);
			e.printStackTrace(); 
		}
		  
		 return json.toJson(duplicate);    
	}

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
				Long logicalInterfaceid = Long.parseLong(logicalInterfaceId);
				req.setAttribute("igiLogicalInterfaceData", logicalInterfaceList.stream().filter(e -> e.getLogicalInterfaceId().equals(logicalInterfaceid)).findFirst().orElse(null) );
			}

			req.setAttribute("logicalInterfaceList", logicalInterfaceList);
			req.setAttribute("logicalChannelList", service.getIGILogicalChannelList());
			req.setAttribute("igiDocId", req.getParameter("igiDocId"));
			req.setAttribute("logicalInterfaceId", logicalInterfaceId);
			req.setAttribute("documentNo", req.getParameter("documentNo"));
			req.setAttribute("logicalChannelId", req.getParameter("logicalChannelId"));

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
			
			if(logicalInterface.getLogicalInterfaceId()==null) {
				int count = service.getLogicalInterfaceCountByType(logicalInterface.getLogicalChannelId()+"", logicalInterface.getMsgType());
				
				String seqCount = String.format("%03d", count + 1);
				String channelCode = logicalChannel!=null?logicalChannel[1]:"-";
				
				logicalInterface.setMsgCode(channelCode + "_" + logicalInterface.getMsgType().substring(0,3).toUpperCase() + "_" + seqCount );
				
				logicalInterface.setCreatedBy(UserId);
				logicalInterface.setCreatedDate(sdtf.format(new Date()));
				logicalInterface.setIsActive(1);
			}else {
				logicalInterface.setModifiedBy(UserId);
				logicalInterface.setModifiedDate(sdtf.format(new Date()));
			}

			long result = service.addIGILogicalInterfaces(logicalInterface);
			
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
			IGILogicalChannel logicalChannel = Long.parseLong(logicalChannelId)!=0 ?service.getIGILogicalChannelById(logicalChannelId) 
																					: new IGILogicalChannel();
			logicalChannel.setLogicalChannel(req.getParameter("logicalChannel"));
			logicalChannel.setChannelCode(req.getParameter("channelCode"));
			logicalChannel.setDescription(req.getParameter("description"));
			String action = "Add";
			if(Long.parseLong(logicalChannelId)==0) {
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
			
			redir.addAttribute("igiDocId", req.getParameter("igiDocId"));
			redir.addAttribute("logicalInterfaceId", req.getParameter("logicalInterfaceId"));
			redir.addAttribute("logicalChannelId", result);
			
			return "redirect:/IGILogicalInterfacesList.htm";
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

			redir.addAttribute("igiDocId", req.getParameter("igiDocId"));
			redir.addAttribute("logicalInterfaceId", req.getParameter("logicalInterfaceId"));
			
			return "redirect:/IGILogicalInterfacesList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGILogicalChannelDelete.htm " + UserId);
			return "static/Error";
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
			req.setAttribute("applicableDocsList", service.getPfmsApplicableDocs());
			req.setAttribute("icdApplicableDocsList", service.getIGIApplicableDocs(icdDocId, "B"));
			req.setAttribute("icdConnectionsList", service.getICDConnectionsList(icdDocId));
			req.setAttribute("interfaceTypesList", service.getIGIInterfaceTypesList());
			req.setAttribute("interfaceContentList", service.getIGIInterfaceContentList());
			req.setAttribute("isPdf", req.getParameter("isPdf"));
			req.setAttribute("productTreeAllList", service.getProductTreeAllList(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+""));

			return "documents/ICDDocumentDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDDocumentDetails.htm " + UserId, e);
			return "static/Error";
		}

	}
	
	@RequestMapping(value = "ICDIntroductionSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdIntroductionSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside ICDIntroductionSubmit.htm" + UserId);

		try {
			String icdDocId = req.getParameter("icdDocId");
			PfmsICDDocument pfmsICDDocument = service.getPfmsICDDocumentById(icdDocId);
			pfmsICDDocument.setIntroduction(req.getParameter("introduction"));
			long result = service.addPfmsICDDocument(pfmsICDDocument);

			if (result > 0) {
				redir.addAttribute("result", "ICD Document Introduction Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "ICD Document Introduction Update Unsuccessful");
			}
			redir.addAttribute("icdDocId", icdDocId);
			return "redirect:/ICDDocumentDetails.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDIntroductionSubmit.htm " + UserId, e);
			return "static/Error";

		}

	}
	
	@RequestMapping(value = "ICDConnectionsDetails.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionMatrixDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside ICDConnectionsDetails.htm " + UserId);
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
			PfmsICDDocument icdDocument = service.getPfmsICDDocumentById(docId);
			req.setAttribute("icdDocument", icdDocument);
			req.setAttribute("productTreeAllList", service.getProductTreeAllList(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+""));
			
			return "documents/ICDConnectionsDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionsDetails.htm " + UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value="ICDConnectionMatrixSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionMatrixSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart(name="drawingAttachment", required = false) MultipartFile drawingAttachment) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + " Inside ICDConnectionMatrixSubmit.htm " + UserId);
		try {
			
			String docId = req.getParameter("docId");
			String icdConnectionId = req.getParameter("icdConnectionId");
			String[] purpose = req.getParameterValues("purpose");
			
			ICDDocumentConnections connections = Long.parseLong(icdConnectionId)!=0 ? service.getICDDocumentConnectionsById(icdConnectionId) 
																					: new ICDDocumentConnections();
			if(connections.getICDConnectionId()==null) {
				
				String subSystemOne = req.getParameter("subSystemOne");
				String subSystemTwo = req.getParameter("subSystemTwo");
				String superSubSystemOne = req.getParameter("superSubSystemOne");
				String superSubSystemTwo = req.getParameter("superSubSystemTwo");
				String interfaceId = req.getParameter("interfaceId");
				String[] interfaceIds = interfaceId!=null?interfaceId.split("/"):null;
				String isSubSystem = req.getParameter("isSubSystem");
				
				String[] subSystemOnes  = subSystemOne!=null?subSystemOne.split("/"): null;
				String[] subSystemTwos  = subSystemTwo!=null?subSystemTwo.split("/"): null;
				String[] superSubSystemOnes  = superSubSystemOne!=null?superSubSystemOne.split("/"): null;
				String[] superSubSystemTwos  = superSubSystemTwo!=null?superSubSystemTwo.split("/"): null;
				
				connections.setICDDocId(Long.parseLong(docId));
				connections.setSubSystemMainIdOne(subSystemOnes!=null?Long.parseLong(subSystemOnes[0]):0);
				connections.setSubSystemOne(subSystemOnes!=null?subSystemOnes[1]:null);
				connections.setSubSystemMainIdTwo(subSystemTwos!=null?Long.parseLong(subSystemTwos[0]):0); 
				connections.setSubSystemTwo(subSystemTwos!=null?subSystemTwos[1]:null);
				connections.setSuperSubSysMainIdOne(superSubSystemOnes!=null?Long.parseLong(superSubSystemOnes[0]):0);
				connections.setSuperSubSystemOne(superSubSystemOnes!=null?superSubSystemOnes[1]:null);
				connections.setSuperSubSysMainIdTwo(superSubSystemTwos!=null?Long.parseLong(superSubSystemTwos[0]):0);
				connections.setSuperSubSystemTwo(superSubSystemTwos!=null?superSubSystemTwos[1]:null);
				connections.setInterfaceId(interfaceIds!=null?Long.parseLong(interfaceIds[0]):0L);
				connections.setCreatedBy(UserId);
				connections.setCreatedDate(sdtf.format(new Date()));
				connections.setIsActive(1);
				
				String connectionCode = "";
				int connectionCount = service.getICDConnectionsCount(connections.getSubSystemMainIdOne(), connections.getSubSystemMainIdTwo(), 
						connections.getSuperSubSysMainIdOne(), connections.getSuperSubSysMainIdTwo(), connections.getICDDocId());

				if(isSubSystem.equalsIgnoreCase("N")) {
					connectionCode = connections.getSubSystemOne() + "_" + connections.getSubSystemTwo();
				}else {
					connectionCode = connections.getSuperSubSystemOne() + "_" + connections.getSuperSubSystemTwo();
				}

				connections.setConnectionCode((connectionCount+1) + "." + connectionCode+ "_" + (interfaceIds!=null?interfaceIds[1]:null));
				
			}else {
				connections.setModifiedBy(UserId);
				connections.setModifiedDate(sdtf.format(new Date()));
			}
			
			connections.setConstraints(req.getParameter("constraints"));
			connections.setPeriodicity(req.getParameter("periodicity"));
			connections.setDescription(req.getParameter("description"));
			connections.setDrawingNo(req.getParameter("drawingNo"));
			connections.setCableMaxLength(req.getParameter("cableMaxLength")!=null?Integer.parseInt(req.getParameter("cableMaxLength")): 0);
			connections.setInterfaceLoss(req.getParameter("interfaceLoss")!=null?Integer.parseInt(req.getParameter("interfaceLoss")): 0);
			connections.setCableBendingRadius(req.getParameter("cableBendingRadius")!=null?Double.parseDouble(req.getParameter("cableBendingRadius")): 0);
			
			long result = service.addICDDocumentConnections(connections, drawingAttachment, labcode);
			
			// Add ICD Connection Interfaces
			//addICDConnectionInterfaces(connections, interfaceId, result, isSubSystem, UserId);
			
			// Add ICD Connection Purpose
			addICDConnectionPurpose(purpose, result+"", UserId);
			
			if (result > 0) {
				redir.addAttribute("result", "ICD Connections Submitted Successfully");
			} else {
				redir.addAttribute("resultfail", "ICD Connections Submit Unsuccessful");
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			
			return "redirect:/ICDConnectionsDetails.htm";

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionMatrixSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "ICDConnectionDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionDelete(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside ICDConnectionDelete.htm " + UserId);
		try {
			String icdConnectionId = req.getParameter("icdConnectionId");
			
			long result = service.deleteICDConnectionById(icdConnectionId);

			if (result > 0) {
				redir.addAttribute("result", "ICD Connection Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "ICD Connection Delete Unsuccessful");
			}

			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			
			return "redirect:/ICDConnectionsDetails.htm";

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
			req.setAttribute("icdConnectionsList", service.getICDConnectionsList(docId));
			PfmsICDDocument icdDocument = service.getPfmsICDDocumentById(docId);
			req.setAttribute("icdDocument", icdDocument);
			req.setAttribute("productTreeAllList", service.getProductTreeAllList(icdDocument.getProjectId()+"", icdDocument.getInitiationId()+""));

			return "documents/ICDConnectionMatrixDetails";
		}catch (Exception e) {
			e.printStackTrace();
			return "static/Error";
		}
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
	
	@RequestMapping(value="ICDConnectionEditSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String icdConnectionEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart(name="drawingAttachment", required = false) MultipartFile drawingAttachment) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		
		logger.info(new Date() + " Inside ICDConnectionEditSubmit.htm " + UserId);
		
		try {
			
			String icdConnectionId = req.getParameter("icdConnectionId");
			ICDDocumentConnections connections = service.getICDDocumentConnectionsById(icdConnectionId);
			//connections.setPurpose(req.getParameter("purpose"));
			connections.setConstraints(req.getParameter("constraints"));
			connections.setPeriodicity(req.getParameter("periodicityEdit"));
			connections.setDescription(req.getParameter("description"));
			connections.setDrawingNo(req.getParameter("description"));
			connections.setModifiedBy(UserId);
			connections.setModifiedDate(sdtf.format(new Date()));
			connections.setIsActive(1);
			
			String[] purpose = req.getParameterValues("purpose");
			
			// Add ICD Connection Purpose
			addICDConnectionPurpose(purpose, icdConnectionId, UserId);
			
			long result = service.addICDDocumentConnections(connections, drawingAttachment, labcode);
			
			if (result > 0) {
				redir.addAttribute("result", "ICD Connection Details Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "ICD Connection Details Update Unsuccessful");
			}

			redir.addAttribute("docId", req.getParameter("docId"));
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			
			return "redirect:/ICDConnectionsDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside ICDConnectionEditSubmit.htm " + UserId, e);
			return "static/Error";
		}
	}
	

//	@RequestMapping(value="ICDAddNewConnectionSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
//	public String icdAddNewConnectionSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//		
//		logger.info(new Date() + " Inside ICDAddNewConnectionSubmit.htm " + UserId);
//		
//		try {
//			
//			String icdConnectionId = req.getParameter("icdConnectionId");
//			String isSubSystem = req.getParameter("isSubSystem");
//			ICDDocumentConnections connections = service.getICDDocumentConnectionsById(icdConnectionId);
//			
//			String[] interfaceId = req.getParameterValues("interfaceId");
//			
//			// Add ICD Connection Interfaces
//			int result = addICDConnectionInterfaces(connections, interfaceId, Long.parseLong(icdConnectionId), isSubSystem, UserId);
//			
//			if (result > 0) {
//				redir.addAttribute("result", "ICD Connection Details Updated Successfully");
//			} else {
//				redir.addAttribute("resultfail", "ICD Connection Details Update Unsuccessful");
//			}
//
//			redir.addAttribute("docId", req.getParameter("docId"));
//			redir.addAttribute("docType", req.getParameter("docType"));
//			redir.addAttribute("documentNo", req.getParameter("documentNo"));
//			redir.addAttribute("projectId", req.getParameter("projectId"));
//			
//			return "redirect:/ICDConnectionsDetails.htm";
//		}catch (Exception e) {
//			e.printStackTrace();
//			logger.error(new Date() + " Inside ICDAddNewConnectionSubmit.htm " + UserId, e);
//			return "static/Error";
//		}
//	}

//	private int addICDConnectionInterfaces(ICDDocumentConnections connections, String[] interfaceId, Long icdConnectionId, String isSubSystem, String userId) throws Exception {
//		try {
//			String connectionCode = "";
//			int connectionCount = service.getICDConnectionsCount(connections.getSubSystemMainIdOne(), connections.getSubSystemMainIdTwo(), 
//					connections.getSuperSubSysMainIdOne(), connections.getSuperSubSysMainIdTwo(), connections.getICDDocId());
//
//			if(isSubSystem.equalsIgnoreCase("N")) {
//				connectionCode = connections.getSubSystemOne() + "_" + connections.getSubSystemTwo();
//			}else {
//				connectionCode = connections.getSuperSubSystemOne() + "_" + connections.getSuperSubSystemTwo();
//			}
//
//			if(interfaceId!=null && interfaceId.length>0) {
//
//				for(int i=0; i<interfaceId.length; i++) {
//
//					String[] interfaceIds = interfaceId[i]!=null?interfaceId[i].split("/"):null;
//					ICDConnectionInterfaces interfaces = new ICDConnectionInterfaces();
//					interfaces.setICDConnectionId(icdConnectionId);
//					interfaces.setInterfaceId(interfaceIds!=null?Long.parseLong(interfaceIds[0]):0);
//					interfaces.setConnectionCode((connectionCount+(i+1)) + "." + connectionCode+ "_" + (interfaceIds!=null?interfaceIds[1]:null));
//					interfaces.setCreatedBy(userId);
//					interfaces.setCreatedDate(sdtf.format(new Date()));
//					interfaces.setIsActive(1);
//
//					service.addICDConnectionInterfaces(interfaces);
//				}
//			}
//
//			return 1;
//		}catch (Exception e) {
//			e.printStackTrace();
//			return 0;
//		}
//	}
	
	private int addICDConnectionPurpose(String[] purpose, String icdConnectionId, String userId) throws Exception {
		try {
			// Delete Existing Purposes
			service.deleteICDConnectionPurposeByICDConnectionId(icdConnectionId);
			
			if(purpose!=null && purpose.length>0) {
				
				for(int i=0; i<purpose.length; i++) {
					
					
					ICDConnectionPurpose purposes = new ICDConnectionPurpose();
					purposes.setICDConnectionId(Long.parseLong(icdConnectionId));
					purposes.setPurposeId(purpose!=null?Long.parseLong(purpose[i]):0);
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
	
//	@RequestMapping(value="CheckICDConnectionExistence.htm",method= {RequestMethod.GET,RequestMethod.POST})
//	public  @ResponseBody String  checkICDConnectionExistence(HttpServletRequest req, HttpSession ses)throws Exception{
//		String Username=(String)ses.getAttribute("Username");
//		logger.info(new Date() + "Inside CheckICDConnectionExistence.htm"+Username);
//		Gson json = new Gson();
//		int connectionCount =0;
//		try {
//			String docId = req.getParameter("docId");
//			String subSystemOne = req.getParameter("subSystem1");
//			String subSystemTwo = req.getParameter("subSystem2");
//			String superSubSystemOne = req.getParameter("superSubSystem1");
//			String superSubSystemTwo = req.getParameter("superSubSystem2");
//			
//			String[] subSystemOnes  = subSystemOne!=null?subSystemOne.split("/"): null;
//			String[] subSystemTwos  = subSystemTwo!=null?subSystemTwo.split("/"): null;
//			String[] superSubSystemOnes  = superSubSystemOne!=null?superSubSystemOne.split("/"): null;
//			String[] superSubSystemTwos  = superSubSystemTwo!=null?superSubSystemTwo.split("/"): null;
//			
//			connectionCount = service.getICDConnectionsCount(subSystemOnes!=null && !subSystemOnes[0].isEmpty()?Long.parseLong(subSystemOnes[0]):0, 
//															subSystemTwos!=null && !subSystemTwos[0].isEmpty()?Long.parseLong(subSystemTwos[0]):0, 
//															superSubSystemOnes!=null && !superSubSystemOnes[0].isEmpty()?Long.parseLong(superSubSystemOnes[0]):0, 
//															superSubSystemTwos!=null && !superSubSystemTwos[0].isEmpty()?Long.parseLong(superSubSystemTwos[0]):0, 
//															Long.parseLong(docId) );
//		} catch (Exception e) {
//			e.printStackTrace();
//			logger.error(new Date() +" Inside CheckICDConnectionExistence.htm"+Username, e);
//		}
//		return json.toJson(connectionCount);
//
//	}
	
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
			req.setAttribute("applicableDocsList", service.getPfmsApplicableDocs());
			req.setAttribute("irsApplicableDocsList", service.getIGIApplicableDocs(irsDocId, "C"));
			
			req.setAttribute("logicalInterfaceList", service.getIGILogicalInterfaces());
			req.setAttribute("logicalChannelList", service.getIGILogicalChannelList());

			req.setAttribute("irsSpecificationsList", service.getIRSDocumentSpecificationsList(irsDocId));
			
			req.setAttribute("isPdf", req.getParameter("isPdf"));
			
			return "documents/IRSDocumentDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSDocumentDetails.htm " + UserId, e);
			return "static/Error";
		}

	} 

	@RequestMapping(value = "IRSIntroductionSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String irsIntroductionSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IRSIntroductionSubmit.htm" + UserId);

		try {
			String irsDocId = req.getParameter("irsDocId");
			PfmsIRSDocument pfmsIRSDocument = service.getPfmsIRSDocumentById(irsDocId);
			pfmsIRSDocument.setIntroduction(req.getParameter("introduction"));
			long result = service.addPfmsIRSDocument(pfmsIRSDocument);

			if (result > 0) {
				redir.addAttribute("result", "IRS Document Introduction Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "IRS Document Introduction Update Unsuccessful");
			}
			redir.addAttribute("irsDocId", irsDocId);
			return "redirect:/IRSDocumentDetails.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSIntroductionSubmit.htm " + UserId, e);
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
			String icdConnectionId = req.getParameter("icdConnectionId");
			String logicalInterfaceId = req.getParameter("logicalInterfaceId");
			String irsSpecificationId = req.getParameter("irsSpecificationId");
		
			IRSDocumentSpecifications specifications = irsSpecificationId.equalsIgnoreCase("0")? new IRSDocumentSpecifications(): service.getIRSDocumentSpecificationsById(irsSpecificationId);
			specifications.setIRSDocId(Long.parseLong(docId));
			specifications.setICDConnectionId(icdConnectionId!=null?Long.parseLong(icdConnectionId):0L);
			specifications.setLogicalInterfaceId(logicalInterfaceId!=null?Long.parseLong(logicalInterfaceId):0L);
			specifications.setInfoName(req.getParameter("infoName"));
			specifications.setActionAtDest(req.getParameter("actionAtDest"));
			if(irsSpecificationId.equalsIgnoreCase("0")) {
				specifications.setCreatedBy(UserId);
				specifications.setCreatedDate(sdtf.format(new Date()));
				specifications.setIsActive(1);
			}else {
				specifications.setModifiedBy(UserId);
				specifications.setModifiedDate(sdtf.format(new Date()));
			}
					
			long result = service.addIRSDocumentSpecifications(specifications);

				
			if (result > 0) {
				redir.addAttribute("result", "IRS Details Submitted Successfully");
			} else {
				redir.addAttribute("resultfail", "IRS Details Submit Unsuccessful");
			}
			
			redir.addAttribute("docId", docId);
			redir.addAttribute("docType", req.getParameter("docType"));
			redir.addAttribute("documentNo", req.getParameter("documentNo"));
			redir.addAttribute("projectId", req.getParameter("projectId"));
			
			return "redirect:/IRSSpecificationsDetails.htm";

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IRSSpecificationsSubmit.htm " + UserId, e);
			return "static/Error";
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
			}
			else {
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

	@RequestMapping(value = "IDDIntroductionSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String iddIntroductionSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IDDIntroductionSubmit.htm" + UserId);

		try {
			String iddDocId = req.getParameter("iddDocId");
			PfmsIDDDocument pfmsIDDDocument = service.getPfmsIDDDocumentById(iddDocId);
			pfmsIDDDocument.setIntroduction(req.getParameter("introduction"));
			long result = service.addPfmsIDDDocument(pfmsIDDDocument);

			if (result > 0) {
				redir.addAttribute("result", "IDD Document Introduction Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "IDD Document Introduction Update Unsuccessful");
			}
			redir.addAttribute("iddDocId", iddDocId);
			return "redirect:/IDDDocumentDetails.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IDDIntroductionSubmit.htm " + UserId, e);
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
			req.setAttribute("igiInterfaceList", service.getIGIInterfaceListByLabCode(labcode));
			req.setAttribute("applicableDocsList", service.getPfmsApplicableDocs());
			req.setAttribute("iddApplicableDocsList", service.getIGIApplicableDocs(iddDocId, "D"));
			
			req.setAttribute("isPdf", req.getParameter("isPdf"));
			
			return "documents/IDDDocumentDetails";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IDDDocumentDetails.htm " + UserId, e);
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
	
	/* ************************************************ IDD Document End ***************************************************** */
	
}
