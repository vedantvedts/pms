package com.vts.pfms.documents.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

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
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
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
import com.vts.pfms.FormatConverter;
import com.vts.pfms.documents.dto.StandardDocumentsDto;
import com.vts.pfms.documents.model.IGIInterface;
import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentShortCodes;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.PfmsIGIDocument;
import com.vts.pfms.documents.service.DocumentsService;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.utils.PMSLogoUtil;

@Controller
public class DocumentsController {

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Autowired
	DocumentsService service;
	
	@Autowired
	ProjectService projectservice;
	
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
			req.setAttribute("IGIDocumentList", service.IgiDocumentList());
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

		String version = req.getParameter("version");

		try {

			PfmsIGIDocument pfmsIgiDocument = new PfmsIGIDocument();
			pfmsIgiDocument.setIGIVersion(version);
			pfmsIgiDocument.setLabCode(labcode);
			pfmsIgiDocument.setInitiatedBy(EmpId);
			pfmsIgiDocument.setInitiatedDate(sdf.format(new Date()));
			pfmsIgiDocument.setIGIStatusCode("INI");
			pfmsIgiDocument.setIGIStatusCodeNext("INI");
			pfmsIgiDocument.setCreatedBy(UserId);
			pfmsIgiDocument.setCreatedDate(sdtf.format(new Date()));
			pfmsIgiDocument.setIsActive(1);
			long result = service.addPfmsIgiDocument(pfmsIgiDocument);

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
			
			req.setAttribute("igiDocId", igiDocId);
			req.setAttribute("igiDocumentSummaryList", service.igiDocumentSummaryList(igiDocId));
			req.setAttribute("totalEmployeeList", projectservice.EmployeeList(labcode));

			req.setAttribute("memberList", service.igiDocumentMemberList(igiDocId));
			req.setAttribute("employeeList", service.getDocmployeeListByIGIDocId(labcode, igiDocId));
			req.setAttribute("shortCodesList", service.getIGIDocumentShortCodesList());
			
			PfmsIGIDocument igiDocument = service.getPfmsIGIDocumentById(igiDocId);
			req.setAttribute("igiDocument", igiDocument);
			req.setAttribute("labDetails", projectservice.LabListDetails(labcode));
			req.setAttribute("docTempAttributes", projectservice.DocTempAttributes());
			req.setAttribute("version", igiDocument!=null ?igiDocument.getIGIVersion():"1.0");
			req.setAttribute("lablogo",  logoUtil.getLabLogoAsBase64String(labcode)); 
			req.setAttribute("drdologo", logoUtil.getDRDOLogoAsBase64String());
			
			req.setAttribute("igiInterfaceList", service.getIGIInterfaceListByLabCode(labcode));
			req.setAttribute("applicableDocsList", service.getPfmsApplicableDocs());
			req.setAttribute("igiApplicableDocsList", service.getIGIApplicableDocs("A"));
			
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
			String igiDocId = req.getParameter("igiDocId");
			String action = req.getParameter("action");
			IGIDocumentSummary rs = action != null && action.equalsIgnoreCase("Add") ? new IGIDocumentSummary()
					: service.getIgiDocumentSummaryById(req.getParameter("summaryId"));
			rs.setAbstract(req.getParameter("abstract"));
			rs.setAdditionalInformation(req.getParameter("information"));
			rs.setKeywords(req.getParameter("keywords"));
			rs.setDistribution(req.getParameter("distribution"));
			rs.setApprover(Long.parseLong(req.getParameter("approver")));
			;
			rs.setReviewer(req.getParameter("reviewer"));
			rs.setPreparedBy(req.getParameter("preparedBy"));
			rs.setIGIDocId(Long.parseLong(igiDocId));
			rs.setReleaseDate(fc.rdfTosdf(req.getParameter("pdc")));
			if (action.equalsIgnoreCase("Add")) {
				rs.setCreatedBy(UserId);
				rs.setCreatedDate(sdtf.format(new Date()));
				rs.setIsActive(1);
			} else if (action.equalsIgnoreCase("Edit")) {

				rs.setSummaryId(Long.parseLong(req.getParameter("summaryId")));
				rs.setModifiedBy(UserId);
				rs.setModifiedDate(sdtf.format(new Date()));
			}

			long result = service.addIgiDocumentSummary(rs);
			if (result > 0) {
				redir.addAttribute("result", "IGI Document Summary " + action + "ed successfully ");
			} else {
				redir.addAttribute("resultfail", "IGI Document Summary " + action + " unsuccessful ");
			}

			redir.addAttribute("igiDocId", igiDocId);

			return "redirect:/IGIDocumentDetails.htm";

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

			String igiDocId = req.getParameter("igiDocId");

			String[] Assignee = req.getParameterValues("Assignee");
			IGIDocumentMembers rm = new IGIDocumentMembers();

			rm.setCreatedBy(UserId);
			rm.setCreatedDate(sdtf.format(new Date()));
			rm.setEmps(Assignee);
			rm.setIGIDocId(Long.parseLong(igiDocId));

			long result = service.addIGIDocumentMembers(rm);
			if (result > 0) {
				redir.addAttribute("result", "Members Added Successfully for Document Distribution");
			} else {
				redir.addAttribute("resultfail", "Members adding unsuccessful ");
			}

			redir.addAttribute("igiDocId", igiDocId);
			return "redirect:/IGIDocumentDetails.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocumentMemberSubmit.htm " + UserId);
			return "static/Error";
		}
	}

	@RequestMapping(value = "IGIDocumentMembersDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String DeleteIgiDocument(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIDocumentMembersDelete.htm " + UserId);
		try {

			String IgiMemeberId = req.getParameter("IgiMemeberId");
			long result = service.deleteIGIDocumentMembers(IgiMemeberId);

			if (result > 0) {
				redir.addAttribute("result", "Members Deleted Successfully for Document Distribution");
			} else {
				redir.addAttribute("resultfail", "Member deleting unsuccessful ");
			}

			redir.addAttribute("igiDocId", req.getParameter("igiDocId"));

			return "redirect:/IGIDocumentDetails.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocumentMembersDelete.htm " + UserId);
			return "static/Error";
		}
	}

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
			
			if(!interfaceId.equalsIgnoreCase("0")) {
				Long interfaceid = Long.parseLong(interfaceId);
				req.setAttribute("igiInterfaceData", igiInterfaceList.stream().filter(e -> e.getInterfaceId().equals(interfaceid)).findFirst().orElse(null) );
			}
			req.setAttribute("interfaceId", interfaceId);
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
		
			IGIInterface igiInterface = interfaceId.equalsIgnoreCase("0")? new IGIInterface(): service.getIGIInterfaceById(interfaceId);
			igiInterface.setLabCode(LabCode);
			igiInterface.setInterfaceCode(req.getParameter("interfaceCode"));
			igiInterface.setInterfaceName(req.getParameter("interfaceName"));
			igiInterface.setDataType(req.getParameter("dataType"));
			igiInterface.setSignalType(req.getParameter("signalType"));
			igiInterface.setInterfaceType(req.getParameter("interfaceType"));
			igiInterface.setInterfaceSpeed(req.getParameter("interfaceSpeed"));
			igiInterface.setConnector(req.getParameter("connector"));
			igiInterface.setProtection(req.getParameter("protection"));
			igiInterface.setInterfaceDiagram(req.getParameter("interfaceDiagram"));
			igiInterface.setInterfaceDescription(req.getParameter("interfaceDescription"));
			igiInterface.setParentId(0L);
			igiInterface.setIGIDocId(Long.parseLong(igiDocId));
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
		BigInteger duplicate=null;
		try
		{	  
	          duplicate = service.getDuplicateInterfaceCodeCount(req.getParameter("interfaceId"), req.getParameter("interfaceCode"));
	          
		}catch (Exception e) {
			logger.error(new Date() +"Inside DuplicateInterfaceCodeCheck.htm "+UserId ,e);
			e.printStackTrace(); 
		}
		  
		 return json.toJson(duplicate);    
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
			
			
			cell.setCellStyle(t_header_style);
			
			List<IGIDocumentShortCodes> shortCodesList = service.getIGIDocumentShortCodesList();
			shortCodesList = shortCodesList.stream().filter(e -> e.getShortCodeType().equalsIgnoreCase(shortCodeType)).collect(Collectors.toList());
			
			if(shortCodesList!=null && shortCodesList.size()>0) {
				int slno=0;
				for(IGIDocumentShortCodes shortcodes : shortCodesList) {
					Row t_body_row = sheet.createRow(++slno);
					cell= t_body_row.createCell(0); 
					cell.setCellValue(slno); 
					cell.setCellStyle(t_body_style2);
					
					cell= t_body_row.createCell(1); 
					cell.setCellValue(shortcodes.getShortCode()); 
					cell.setCellStyle(t_body_style2);
					
					cell= t_body_row.createCell(2); 
					cell.setCellValue(shortcodes.getFullName()); 
					cell.setCellStyle(t_body_style2);
				}
			}
			
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
			String igiDocId = req.getParameter("igiDocId");
			String shortCodeType = req.getParameter("shortCodeType");
			
			// Delete Previous Short Codes
			service.deleteIGIDocumentShortCodesByType(shortCodeType);
			
			if(ServletFileUpload.isMultipartContent(req)) {
				Part filePart = req.getPart("filename");
				InputStream fileData = filePart.getInputStream();
				Workbook workbook = new XSSFWorkbook(fileData);
				Sheet sheet  = workbook.getSheetAt(0);
				int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum(); 
				
				List<IGIDocumentShortCodes> shortCodesList = new ArrayList<IGIDocumentShortCodes>();
				
				for (int i=1;i<=rowCount;i++) {
					int cellcount = sheet.getRow(i).getLastCellNum();
					IGIDocumentShortCodes igiDocumentShortCode = new IGIDocumentShortCodes();
					
					for(int j=1;j<cellcount;j++) {

						if(sheet.getRow(i).getCell(j)!=null) {
							if(j==1) {
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:break;
								case Cell.CELL_TYPE_NUMERIC:
									igiDocumentShortCode.setShortCode(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
									break;
								case Cell.CELL_TYPE_STRING:
									igiDocumentShortCode.setShortCode(sheet.getRow(i).getCell(j).getStringCellValue());
									break;	 
								}
							}

							if(j==2) {
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:break;
								case Cell.CELL_TYPE_NUMERIC:
									igiDocumentShortCode.setFullName(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
									break;
								case Cell.CELL_TYPE_STRING:
									igiDocumentShortCode.setFullName(sheet.getRow(i).getCell(j).getStringCellValue());
									break;	 
								}


							}	 
						}
					}
					
					if(igiDocumentShortCode.getShortCode()!=null && igiDocumentShortCode.getFullName()!=null) {
						
						igiDocumentShortCode.setShortCodeType(shortCodeType);
						igiDocumentShortCode.setIGIDocId(Long.parseLong(igiDocId));
						igiDocumentShortCode.setCreatedBy(UserId);
						igiDocumentShortCode.setCreatedDate(sdtf.format(new Date()));
						igiDocumentShortCode.setIsActive(1);
						
						shortCodesList.add(igiDocumentShortCode);
					}
					
				}
				
				long result = service.addIGIDocumentShortCodes(shortCodesList);
				
				if (result > 0) {
					redir.addAttribute("result", (shortCodeType.equalsIgnoreCase("A")?"Abbreviations":"Acronyms")+" Added Successfully");
				} else {
					redir.addAttribute("resultfail", (shortCodeType.equalsIgnoreCase("A")?"Abbreviations":"Acronyms")+" Add Unsuccessful");
				}
			}
			redir.addAttribute("igiDocId", igiDocId);
			return "redirect:/IGIDocumentDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIDocShortCodesExcelUpload.htm " + UserId, e);
			return "static/Error";
		}

	}
	
	@RequestMapping(value = "IGIIntroductionSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiIntroductionSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIIntroductionSubmit.htm" + UserId);

		try {
			String igiDocId = req.getParameter("igiDocId");
			PfmsIGIDocument pfmsIgiDocument = service.getPfmsIGIDocumentById(igiDocId);
			pfmsIgiDocument.setIntroduction(req.getParameter("introduction"));
			long result = service.addPfmsIgiDocument(pfmsIgiDocument);

			if (result > 0) {
				redir.addAttribute("result", "IGI Document Introduction Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "IGI Document Introduction Update Unsuccessful");
			}
			redir.addAttribute("igiDocId", igiDocId);
			return "redirect:/IGIDocumentDetails.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIIntroductionSubmit.htm " + UserId, e);
			return "static/Error";

		}

	}
	
	@RequestMapping(value = "IGIApplicableDocsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiApplicableDocsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIApplicableDocsSubmit.htm " + UserId);
		
		try {
			String igiDocId = req.getParameter("igiDocId");
			String docFlag = req.getParameter("docFlag");
			String[] applicableDocIds = req.getParameterValues("applicableDocId");
			
			long result = 0;
			if(applicableDocIds!=null && applicableDocIds.length>0) {
				result = service.addIGIApplicableDocs(igiDocId, docFlag, applicableDocIds, UserId);
			}else {
				redir.addAttribute("resultfail", "Please select atleast one Applicable Document");
				redir.addAttribute("igiDocId", igiDocId);
				return "redirect:/IGIDocumentDetails.htm";
			}
			
			if (result > 0) {
				redir.addAttribute("result", "Applicable Documents Submitted Successfully");
			} else {
				redir.addAttribute("resultfail", "Applicable Documents Submit Unsuccessful");
			}
			redir.addAttribute("igiDocId", igiDocId);
			return "redirect:/IGIDocumentDetails.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIApplicableDocsSubmit.htm " + UserId, e);
			return "static/Error";
			
		}
		
	}
	
	@RequestMapping(value = "IGIApplicableDocumentDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String igiApplicableDocumentDelete(RedirectAttributes redir, HttpServletRequest req, HttpServletResponse res, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + " Inside IGIApplicableDocumentDelete.htm " + UserId);
		try {

			String igiApplicableDocId = req.getParameter("igiApplicableDocId");
			long result = service.deleteIGIApplicableDocument(igiApplicableDocId);

			if (result > 0) {
				redir.addAttribute("result", "Applicable Documents Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Applicable Documents Delete Unsuccessful");
			}

			redir.addAttribute("igiDocId", req.getParameter("igiDocId"));

			return "redirect:/IGIDocumentDetails.htm";

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IGIApplicableDocumentDelete.htm " + UserId);
			return "static/Error";
		}
	}
	/* ************************************************ IGI Document End ***************************************************** */
}
