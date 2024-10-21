package com.vts.pfms.documents.controller;

import java.awt.Desktop;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
import com.vts.pfms.admin.controller.AdminController;
import com.vts.pfms.documents.dto.StandardDocumentsDto;
import com.vts.pfms.documents.service.DocumentsService;

@Controller
public class DocumentsController {

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Autowired
	DocumentsService service;
	
	private static final Logger logger = LogManager.getLogger(AdminController.class);
	private SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	private SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	private SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	
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
			dto.setCreatedDate(sdf1.format(new Date()));
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
				    redir.addAttribute("result", "Attachment Deleted Successfully..&#128077;");
			}else {
					redir.addAttribute("resultFail", "Attachment Deleted UnSuccessful..&#128078;");
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside StandardDocumentDelete.htm" + UserId, e);
		}

		return "redirect:/StandardDocuments.htm";
	}
}
