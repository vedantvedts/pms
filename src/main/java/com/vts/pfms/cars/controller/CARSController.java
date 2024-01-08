package com.vts.pfms.cars.controller;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.io.font.PdfEncodings;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.font.FontProvider;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.dto.CARSRSQRDetailsDTO;
import com.vts.pfms.cars.dto.RSQRForwardDTO;
import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSInitiationTrans;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;
import com.vts.pfms.cars.model.CARSSoC;
import com.vts.pfms.cars.model.CARSSoCMilestones;
import com.vts.pfms.cars.service.CARSService;
import com.vts.pfms.project.service.ProjectService;

@Controller
public class CARSController {

	private static final Logger logger = LogManager.getLogger(CARSController.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	
//	@Autowired
//	RestTemplate restTemplate;
	
	@Autowired
	CARSService service;
	
	@Autowired
	ProjectService projectservice;
	
	@Value("${ApplicationFilesDrive}")
	private String LabLogoPath;
	
	@Autowired
	Environment env;
	

	public String getLabLogoAsBase64() throws IOException {

		String path = LabLogoPath + "\\images\\lablogos\\lrdelogo.png";
		try {
			return Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(path)));
		} catch (FileNotFoundException e) {
			System.err.println("File Not Found at Path " + path);
		}
		return "/print/.jsp";
	}
	
	@RequestMapping(value="CARSInitiationList.htm")
	public String carsInitiationList(HttpServletRequest req, HttpSession ses) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+ " Inside CARSInitiationList.htm "+UserId);
		try {
			req.setAttribute("InitiationList", service.carsInitiationList(EmpId));
			return "cars/InitiationList";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CARSInitiationList.htm "+UserId,e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value="CARSInitiationDetails.htm")
	public String carsInitiationDetails(HttpServletRequest req, HttpSession ses) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date()+ " Inside CARSInitiationDetails.htm "+UserId);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			String TabId = req.getParameter("TabId");
			String isApproval = req.getParameter("isApproval");
			if(carsInitiationId==null) {
				String fromapprovals = req.getParameter("carsInitiationIdApprovals");
				if(fromapprovals!=null) {
					String[] split = fromapprovals.split("/");
					carsInitiationId = split[0];
					if(isApproval==null) {
						isApproval = split[1];
					}
					if(TabId==null) {
						TabId = split[2];
					}
				}
				
			}
			
			if(carsInitiationId!=null && carsInitiationId!="0") {
				long carsiniid = Long.parseLong(carsInitiationId);
				CARSInitiation carsInitiation = service.getCARSInitiationById(carsiniid);
				req.setAttribute("CARSInitiationData", carsInitiation);
				req.setAttribute("RSQRDetails", service.carsRSQRDetails(carsInitiationId));
				req.setAttribute("RSQRMajorReqr", service.getCARSRSQRMajorReqrByCARSInitiationId(carsiniid));
				req.setAttribute("RSQRDeliverables", service.getCARSRSQRDeliverablesByCARSInitiationId(carsiniid));
				req.setAttribute("ProjectList", projectservice.LoginProjectDetailsList(carsInitiation.getEmpId()+"",Logintype,LabCode));
				req.setAttribute("EmpData", service.getEmpDetailsByEmpId(carsInitiation.getEmpId()+""));
				req.setAttribute("RSQRApprovalEmpData", service.carsTransApprovalData(carsInitiationId,"RF"));
				req.setAttribute("SoCApprovalEmpData", service.carsTransApprovalData(carsInitiationId,"SF"));
				req.setAttribute("CARSRSQRRemarksHistory", service.carsRemarksHistoryByType(carsInitiationId,"RF"));
				req.setAttribute("GDEmpIds", service.getEmpGDEmpId(carsInitiation.getEmpId()+""));
				req.setAttribute("PDEmpIds", service.getEmpPDEmpId(carsInitiation.getFundsFrom()));
				
				req.setAttribute("CARSSoCData", service.getCARSSoCByCARSInitiationId(carsiniid));
				req.setAttribute("CARSSoCRemarksHistory", service.carsRemarksHistoryByType(carsInitiationId,"SF"));
				req.setAttribute("CARSSoCMilestones", service.getCARSSoCMilestonesByCARSInitiationId(carsiniid));
			}else {
				req.setAttribute("ProjectList", projectservice.LoginProjectDetailsList(EmpId,Logintype,LabCode));
				req.setAttribute("EmpData", service.getEmpDetailsByEmpId(EmpId));
			}
			
			req.setAttribute("carsInitiationId", carsInitiationId);
			
			req.setAttribute("TabId", TabId!=null?TabId:"1");
			
			String attributes = req.getParameter("attributes");
			req.setAttribute("attributes", req.getParameter("attributes")!=null?attributes:"Introduction");
			
			req.setAttribute("isApproval", isApproval);
			
			return "cars/InitiationDetails";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CARSInitiationDetails.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSInitiationAdd.htm")
	public String carsInitiationAddSubmit(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+ " Inside CARSInitiationAdd.htm "+UserId);
		try {
			CARSInitiation initiation = CARSInitiation.builder()
					                   .EmpId(Long.parseLong(EmpId))
					                   .InitiationTitle(req.getParameter("initiationTitle"))
					                   .InitiationAim(req.getParameter("initiationAim"))
					                   .Justification(req.getParameter("justification"))
					                   .FundsFrom(req.getParameter("fundsFrom"))
					                   .Amount(req.getParameter("amount"))
					                   .Duration(req.getParameter("duration"))
					                   .RSPInstitute(req.getParameter("rspInstitute"))
					                   .RSPAddress(req.getParameter("rspAddress"))
					                   .RSPCity(req.getParameter("rspCity"))
					                   .RSPState(req.getParameter("rspState"))
					                   .RSPPinCode(req.getParameter("rspPinCode"))
					                   .PITitle(req.getParameter("piTitle"))
					                   .PIName(req.getParameter("piName"))
					                   .PIDesig(req.getParameter("piDesig"))
					                   .PIDept(req.getParameter("piDept"))
					                   .PIMobileNo(req.getParameter("piMobileNo"))
					                   .PIEmail(req.getParameter("piEmail"))
					                   .PIFaxNo(req.getParameter("piFaxNo"))
					                   .CARSStatusCode("INI")
					                   .CARSStatusCodeNext("FWD")
					                   .CreatedBy(UserId)
					                   .CreatedDate(sdtf.format(new Date()))
					                   .IsActive(1)
					                   .build();
			long result = service.addCARSInitiation(initiation);
			if(result!=0) {
				redir.addAttribute("result", "CARS Initiation Added Successfully");
			}else {
				redir.addAttribute("resultfail", "CARS Initiation Add UnSuccessful");
			}
			redir.addAttribute("carsInitiationId", result);
			redir.addAttribute("TabId","1");
			
			return "redirect:/CARSInitiationDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CARSInitiationAdd.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSInitiationEdit.htm")
	public String carsInitiationEditSubmit(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date()+ " Inside CARSInitiationEdit.htm "+UserId);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			
			CARSInitiation initiation = service.getCARSInitiationById(Long.parseLong(carsInitiationId));
			initiation.setInitiationTitle(req.getParameter("initiationTitle"));
			initiation.setInitiationAim(req.getParameter("initiationAim"));
			initiation.setJustification(req.getParameter("justification"));
			initiation.setFundsFrom(req.getParameter("fundsFrom"));
			initiation.setAmount(req.getParameter("amount"));
			initiation.setDuration(req.getParameter("duration"));
			initiation.setRSPInstitute(req.getParameter("rspInstitute"));
			initiation.setRSPAddress(req.getParameter("rspAddress"));
			initiation.setRSPCity(req.getParameter("rspCity"));
			initiation.setRSPState(req.getParameter("rspState"));
			initiation.setRSPPinCode(req.getParameter("rspPinCode"));
			initiation.setPITitle(req.getParameter("piTitle"));
			initiation.setPIName(req.getParameter("piName"));
			initiation.setPIDesig(req.getParameter("piDesig"));
			initiation.setPIDept(req.getParameter("piDept"));
			initiation.setPIMobileNo(req.getParameter("piMobileNo"));
			initiation.setPIEmail(req.getParameter("piEmail"));
			initiation.setPIFaxNo(req.getParameter("piFaxNo"));
			initiation.setModifiedBy(UserId);
			initiation.setModifiedDate(sdtf.format(new Date()));
			
			long result = service.editCARSInitiation(initiation);
			if(result!=0) {
				redir.addAttribute("result", "CARS Initiation Edited Successfully");
			}else {
				redir.addAttribute("resultfail", "CARS Initiation Edit UnSuccessful");
			}
			redir.addAttribute("carsInitiationId", result);
			redir.addAttribute("TabId","1");
			
			return "redirect:/CARSInitiationDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CARSInitiationEdit.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="RSQRDetailsSubmit.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String RequiremnetIntroSubmit(HttpServletRequest req,HttpSession ses, RedirectAttributes redir) {
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside RSQRDetailsSubmit.htm "+UserId);
		try {
		String carsInitiationId=req.getParameter("carsInitiationId");
		String attributes=req.getParameter("attributes");
		String Details=req.getParameter("Details");
		String tab=req.getParameter("tab");
		if(tab!=null && tab.equalsIgnoreCase("5")) {
			Details=req.getParameter("Details2");
		}
		Object[] carsRSQR = service.carsRSQRDetails(carsInitiationId);
		long result=0l;
		if(carsRSQR==null) {
			result=service.carsRSQRDetailsSubmit(carsInitiationId,attributes,Details,UserId);
		}else {
			result=service.carsRSQRDetailsUpdate(carsInitiationId,attributes,Details,UserId);
			if (result > 0) {
				redir.addAttribute("result", attributes+" updated Successfully");
			} else {
				redir.addAttribute("resultfail", attributes+" update Unsuccessful");
			}
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("TabId",tab!=null?tab:"2");
			redir.addAttribute("attributes", attributes);
			return "redirect:/CARSInitiationDetails.htm";
		}
		if (result > 0) {
			redir.addAttribute("result", attributes+" added Successfully");
		} else {
			redir.addAttribute("resultfail", attributes+" add Unsuccessful");
		}
		redir.addAttribute("carsInitiationId", carsInitiationId);
		redir.addAttribute("TabId",tab!=null?tab:"2");
		redir.addAttribute("attributes", attributes);

		return "redirect:/CARSInitiationDetails.htm";
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RSQRDetailsSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="RSQRDetailsByAjax.htm",method = {RequestMethod.GET})
	public @ResponseBody String RequirementIntroDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside RSQRDetailsByAjax.htm "+UserId);
		Object[] rsqrDetails=null;
		try {
			rsqrDetails = service.carsRSQRDetails(req.getParameter("carsinitiationid"));
		}
		catch(Exception e){
			e.printStackTrace();
			logger.error(new Date() +" Inside RSQRDetailsByAjax.htm"+UserId, e);
		}
		Gson json = new Gson();
		return json.toJson(rsqrDetails);
	}
	
	@RequestMapping(value="RSQRMajorReqrSubmit.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String rsqrMajorReqrDetailsSubmit(HttpServletRequest req,HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside RSQRMajorReqrSubmit.htm "+UserId);
		try {
		String carsInitiationId = req.getParameter("carsInitiationId");
		String attributes=req.getParameter("attributes");
		long carsiniid = Long.parseLong(carsInitiationId);
		
		String tab=req.getParameter("tab");
		
		CARSRSQRDetailsDTO dto = new CARSRSQRDetailsDTO();
		dto.setCARSInitiationId(carsiniid);
		dto.setReqId(req.getParameterValues("reqId"));
		dto.setReqDescription(req.getParameterValues("reqDescription"));
		dto.setRelevantSpecs(req.getParameterValues("relevantSpecs"));
		dto.setValidationMethod(req.getParameterValues("validationMethod"));
		dto.setRemarks(req.getParameterValues("remarks"));
		dto.setUserId(UserId);
		
		List<CARSRSQRMajorRequirements> majorReqr = service.getCARSRSQRMajorReqrByCARSInitiationId(carsiniid);
		long result = 0l;
		if(majorReqr!=null && majorReqr.size()==0) {
			result = service.carsRSQRMajorReqrDetailsSubmit(dto);
		}else {
			service.removeCARSRSQRMajorReqrDetails(carsiniid);
			result = service.carsRSQRMajorReqrDetailsSubmit(dto);
			if (result > 0) {
				redir.addAttribute("result", "RSQR Major Requirement Details updated Successfully");
			} else {
				redir.addAttribute("resultfail", "RSQR Major Requirement Details update Unsuccessful");
			}
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("attributes", attributes);
			redir.addAttribute("TabId",tab!=null?tab:"2");
			return "redirect:/CARSInitiationDetails.htm";
		}
		if (result > 0) {
			redir.addAttribute("result", "RSQR Major Requirement Details added Successfully");
		} else {
			redir.addAttribute("resultfail", "RSQR Major Requirement Details add Unsuccessful");
		}
		redir.addAttribute("carsInitiationId", carsInitiationId);
		redir.addAttribute("attributes", attributes);
		redir.addAttribute("TabId",tab!=null?tab:"2");
		return "redirect:/CARSInitiationDetails.htm";
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RSQRMajorReqrSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="RSQRDeliverablesSubmit.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String rsqrDeliverableDetailsSubmit(HttpServletRequest req,HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside RSQRDeliverablesSubmit.htm "+UserId);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			String attributes=req.getParameter("attributes");
			long carsiniid = Long.parseLong(carsInitiationId);

			String tab=req.getParameter("tab");
			
			CARSRSQRDetailsDTO dto = new CARSRSQRDetailsDTO();
			dto.setCARSInitiationId(carsiniid);
			dto.setDescription(req.getParameterValues("description"));
			dto.setDeliverableType(req.getParameterValues("deliverableType"));
			dto.setUserId(UserId);
			
			List<CARSRSQRDeliverables> deliverables = service.getCARSRSQRDeliverablesByCARSInitiationId(carsiniid);
			long result = 0l;
			if(deliverables!=null && deliverables.size()==0) {
				result = service.carsRSQRDeliverableDetailsSubmit(dto);
			}else {
				service.removeCARSRSQRDeliverableDetails(carsiniid);
				result = service.carsRSQRDeliverableDetailsSubmit(dto);
				if (result > 0) {
					redir.addAttribute("result", "RSQR Deliverable Details updated Successfully");
				} else {
					redir.addAttribute("resultfail", "RSQR Deliverable Details update Unsuccessful");
				}
				redir.addAttribute("carsInitiationId", carsInitiationId);
				redir.addAttribute("attributes", attributes);
				redir.addAttribute("TabId",tab!=null?tab:"2");
				return "redirect:/CARSInitiationDetails.htm";
			}
			if (result > 0) {
				redir.addAttribute("result", "RSQR Deliverable Details added Successfully");
			} else {
				redir.addAttribute("resultfail", "RSQR Deliverable Details add Unsuccessful");
			}
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("attributes", attributes);
			redir.addAttribute("TabId",tab!=null?tab:"2");
			return "redirect:/CARSInitiationDetails.htm";
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RSQRDeliverablesSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}
	
//	@RequestMapping(value="CARSRSQRDownload.htm")
//	public void carsRSQRDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside CARSRSQRDownload.htm "+UserId);		
//		try {
//			String carsInitiationId = req.getParameter("carsInitiationId");
//			if(carsInitiationId!=null && carsInitiationId!="0") {
//				long carsiniid = Long.parseLong(carsInitiationId);
//				req.setAttribute("CARSInitiationData", service.getCARSInitiationById(carsiniid));
//				req.setAttribute("RSQRMajorReqr", service.getCARSRSQRMajorReqrByCARSInitiationId(carsiniid));
//				req.setAttribute("RSQRDeliverables", service.getCARSRSQRDeliverablesByCARSInitiationId(carsiniid));
//				req.setAttribute("RSQRDetails", service.carsRSQRDetails(carsInitiationId));
//			}
//			String filename="RSQR";	
//			String path=req.getServletContext().getRealPath("/view/temp");
//			req.setAttribute("path",path);
//			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
//			req.getRequestDispatcher("/view/print/CARSRSQRDownload.jsp").forward(req, customResponse);
//			String html = customResponse.getOutput();
//
//			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
//			PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
//			PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
//			PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	
//			pdfDocument.close();
//			pdf1.close();	       
//			pdfw.close();
//
//			res.setContentType("application/pdf");
//			res.setHeader("Content-disposition","inline;filename="+filename+".pdf"); 
//			File f=new File(path+"/"+filename+".pdf");
//
//			OutputStream out = res.getOutputStream();
//			FileInputStream in = new FileInputStream(f);
//			byte[] buffer = new byte[4096];
//			int length;
//			while ((length = in.read(buffer)) > 0) {
//				out.write(buffer, 0, length);
//			}
//			in.close();
//			out.flush();
//			out.close();
//
//			Path pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
//			Files.delete(pathOfFile2);		
//
//		}
//	    catch(Exception e) {	    		
//    		logger.error(new Date() +" Inside CARSRSQRDownload.htm "+UserId, e);
//    		e.printStackTrace();
//    	}		
//	}
	
	@RequestMapping(value="RSQRApprovalSubmit.htm")
	public String rsqrApprovalSubmit(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir) throws Exception{
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside RSQRApprovalSubmit.htm "+UserId);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			String action = req.getParameter("Action");
			String remarks = req.getParameter("remarks");
			long carsini = Long.parseLong(carsInitiationId);
			
			CARSInitiation cars = service.getCARSInitiationById(carsini);
			String carsStatusCode = cars.getCARSStatusCode();
			
			RSQRForwardDTO dto = new RSQRForwardDTO();
			dto.setCarsinitiationid(carsini);
			dto.setAction(action);
			dto.setEmpId(EmpId);
			dto.setRemarks(remarks);
			long result = service.rsqrApprovalForward(dto,req,res);
			
			if(action.equalsIgnoreCase("A")) {
				if(carsStatusCode.equalsIgnoreCase("INI") || carsStatusCode.equalsIgnoreCase("REV") || 
				   carsStatusCode.equalsIgnoreCase("RGD") || carsStatusCode.equalsIgnoreCase("RPD")) {
					if(result!=0) {
						redir.addAttribute("result","RSQR Approval form forwarded Successfully");
					}else {
						redir.addAttribute("resultfail","RSQR Approval form forward Unsuccessful");
					}
					return "redirect:/CARSInitiationList.htm";
				}else if(carsStatusCode.equalsIgnoreCase("FWD")) {
					if(result!=0) {
						redir.addAttribute("result","RSQR Approval form Approved Successfully");
					}else {
						redir.addAttribute("resultfail","RSQR Approval form Approve Unsuccessful");
					}
					return "redirect:/CARSRSQRApprovals.htm";
				}
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if(result!=0) {
					redir.addAttribute("result",action.equalsIgnoreCase("R")?"RSQR Approval form Returned Successfully":"RSQR Approval form Disapproved Successfully");
				}else {
					redir.addAttribute("resultfail",action.equalsIgnoreCase("R")?"RSQR Approval form Return Unsuccessful":"RSQR Approval form Disapprove Unsuccessful");
				}
			}
			return "redirect:/CARSRSQRApprovals.htm";
			
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RSQRApprovalSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "CARSTransStatus.htm" , method={RequestMethod.POST,RequestMethod.GET})
	public String carsTransStatus(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String Username = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSTransStatus.htm "+Username);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			req.setAttribute("TransactionList", service.carsTransListByType(carsInitiationId,"A")) ;
			req.setAttribute("TransFlag", "A");
			req.setAttribute("carsInitiationId", carsInitiationId);
			return "cars/CARSTransactionStatus";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSTransStatus.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSRSQRApprovals.htm")
	public String carsRSQRApprovals(HttpServletRequest req,HttpSession ses) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside CARSRSQRApprovals.htm "+Username);
		try {

			String fromdate = req.getParameter("fromdate");
			String todate = req.getParameter("todate");

			LocalDate today=LocalDate.now();

			if(fromdate==null) 
			{
				fromdate=today.withDayOfMonth(1).toString();
				todate = today.toString();

			}else
			{
				fromdate=fc.RegularToSqlDate(fromdate);
				todate=fc.RegularToSqlDate(todate);
			}

			req.setAttribute("fromdate", fromdate);
			req.setAttribute("todate", todate);
			req.setAttribute("tab", req.getParameter("tab"));

			req.setAttribute("PendingList", service.carsRSQRPendingList(EmpId));
			req.setAttribute("ApprovedList", service.carsRSQRApprovedList(EmpId,fromdate,todate,"B"));
			req.setAttribute("DPandCSoCPendingList", service.carsDPandCSoCPendingList(EmpId, labcode));
			req.setAttribute("DPandCSoCApprovedList", service.carsDPCSoCApprovedList(EmpId, fromdate, todate));
			
			return "cars/RSQRApprovals";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSRSQRApprovals.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSRSQRApprovalDownload.htm")
	public void carsRSQRApprovalDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSRSQRApprovalDownload.htm "+UserId);		
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			if(carsInitiationId!=null && carsInitiationId!="0") {
				long carsiniid = Long.parseLong(carsInitiationId);
				CARSInitiation carsInitiation = service.getCARSInitiationById(carsiniid);
				req.setAttribute("CARSInitiationData", carsInitiation);
				req.setAttribute("EmpData", service.getEmpDetailsByEmpId(carsInitiation.getEmpId()+""));
				req.setAttribute("RSQRApprovalEmpData", service.carsTransApprovalData(carsInitiationId, "RF"));
				req.setAttribute("CARSRSQRRemarksHistory", service.carsRemarksHistoryByType(carsInitiationId,"RF"));
			}
			String filename="CARS-RSQR_Approval";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/CARSRSQRApprovalDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
			PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
			PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
			PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	
			pdfDocument.close();
			pdf1.close();	       
			pdfw.close();

			res.setContentType("application/pdf");
			res.setHeader("Content-disposition","inline;filename="+filename+".pdf"); 
			File f=new File(path+"/"+filename+".pdf");

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

			Path pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
			Files.delete(pathOfFile2);		

		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside CARSRSQRApprovalDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	@RequestMapping(value="CARSInvForSoODownload.htm")
	public void carsInvForSoODownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSInvForSoODownload.htm "+UserId);		
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			if(carsInitiationId!=null && carsInitiationId!="0") {
				long carsiniid = Long.parseLong(carsInitiationId);
				CARSInitiation carsInitiation = service.getCARSInitiationById(carsiniid);
				req.setAttribute("CARSInitiationData", carsInitiation);
				req.setAttribute("EmpData", service.getEmpDetailsByEmpId(carsInitiation.getEmpId()+""));
				req.setAttribute("DPandC", service.getEmpDataByLoginType("E"));
			}
			req.setAttribute("lablogo", getLabLogoAsBase64());
			String filename="Inv_for_SoO";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			
			//Path for Hindi font
			String fontPath = req.getServletContext().getRealPath("/view/pfp/NotoSansDevanagari-Regular.ttf");
			req.setAttribute("fontPath", fontPath);
			PdfFont hindiFont = PdfFontFactory.createFont(fontPath, PdfEncodings.IDENTITY_H, true);
			
			req.getRequestDispatcher("/view/print/CARSInvForSoODownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			// Hindi font converter
			ConverterProperties converterProperties = new ConverterProperties();
			FontProvider fontProvider = new DefaultFontProvider();
			fontProvider.addFont(fontPath, PdfEncodings.IDENTITY_H);
			converterProperties.setFontProvider(fontProvider);
			
//			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"),converterProperties);
//			
//			PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
//			PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
//			PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	
//			
//			pdfDocument.close();
//			pdf1.close();	       
//			pdfw.close();

			try (PdfWriter writer = new PdfWriter(path + File.separator + filename + ".pdf");
					PdfDocument pdfDoc = new PdfDocument(writer);
					Document document = HtmlConverter.convertToDocument(html, pdfDoc, converterProperties)) {
	                document.setFont(hindiFont);
	            }
			
			res.setContentType("application/pdf");
			res.setHeader("Content-disposition","inline;filename="+filename+".pdf"); 
			File f=new File(path+"/"+filename+".pdf");

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

			Path pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
			Files.delete(pathOfFile2);		

		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside CARSInvForSoODownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	@RequestMapping(value="CARSSoCAdd.htm")
	public String carsSocAddSubmit(HttpServletRequest req,HttpSession ses,RedirectAttributes redir,
			@RequestPart(name="SoOUpload", required = false) MultipartFile SoOFile,
			@RequestPart(name="FRUpload", required = false) MultipartFile FRFile,
			@RequestPart(name="ExecutionPlan", required = false) MultipartFile ExecutionPlanFile) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside CARSSoCAdd.htm "+Username);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			CARSSoC soc = new CARSSoC();
			soc.setCARSInitiationId(Long.parseLong(carsInitiationId));
			soc.setSoCDuration(req.getParameter("socDuration"));
			soc.setAlignment(req.getParameter("alignment"));
			soc.setTimeReasonability(req.getParameter("timeReasonability"));
			soc.setCostReasonability(req.getParameter("costReasonability"));
			soc.setRSPSelection(req.getParameter("rspSelection"));
			soc.setSoCCriterion(req.getParameter("socCriterion"));
			soc.setCreatedBy(Username);
			soc.setCreatedDate(sdtf.format(new Date()));
			soc.setIsActive(1);
			
			long result = service.addCARSSoC(soc, SoOFile, FRFile, ExecutionPlanFile);
			
			if(result!=0) {
				redir.addAttribute("result", "CARS SoC Added Successfully");
				
				// Transactions happend in the approval flow.
				CARSInitiationTrans transaction = CARSInitiationTrans.builder()
												  .CARSInitiationId(soc.getCARSInitiationId())
												  .CARSStatusCode("SIN")
												  .ActionBy(EmpId)
												  .ActionDate(sdtf.format(new Date()))
												  .build();
				service.addCARSInitiationTransaction(transaction);
			}else {
				redir.addAttribute("resultfail", "CARS SoC Add UnSuccessful");
			}
			
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("carsSoCId",result);
			redir.addAttribute("TabId","4");
			return "redirect:/CARSInitiationDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSSoCAdd.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSSoCEdit.htm")
	public String carsSocEditSubmit(HttpServletRequest req,HttpSession ses,RedirectAttributes redir,
			@RequestPart(name="SoOUpload", required = false) MultipartFile SoOFile,
			@RequestPart(name="FRUpload", required = false) MultipartFile FRFile,
			@RequestPart(name="ExecutionPlan", required = false) MultipartFile ExecutionPlanFile) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSSoCEdit.htm "+Username);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			String carsSocId = req.getParameter("carsSocId");
			
			CARSSoC soc = service.getCARSSoCById(Long.parseLong(carsSocId));
			soc.setSoCDuration(req.getParameter("socDuration"));
			soc.setAlignment(req.getParameter("alignment"));
			soc.setTimeReasonability(req.getParameter("timeReasonability"));
			soc.setCostReasonability(req.getParameter("costReasonability"));
			soc.setRSPSelection(req.getParameter("rspSelection"));
			soc.setSoCCriterion(req.getParameter("socCriterion"));
			soc.setModifiedBy(Username);
			soc.setModifiedDate(sdtf.format(new Date()));
			
			long result = service.editCARSSoC(soc, SoOFile, FRFile, ExecutionPlanFile);
			
			if(result!=0) {
				redir.addAttribute("result", "CARS SoC Edit Successfully");
			}else {
				redir.addAttribute("resultfail", "CARS SoC Edit UnSuccessful");
			}
			
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("carsSoCId",result);
			redir.addAttribute("TabId","4");
			return "redirect:/CARSInitiationDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSSoCEdit.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = {"CARSSoCFileDownload.htm"})
	public void carsSoCFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSSoCFileDownload.htm "+UserId);
		try
		{
			String ftype=req.getParameter("filename");
			String carsSocId=req.getParameter("carsSocId");
			res.setContentType("Application/octet-stream");	
			CARSSoC soc = service.getCARSSoCById(Long.parseLong(carsSocId));
			File my_file=null;
			String file = ftype.equalsIgnoreCase("soofile")?soc.getSoOUpload():
				         (ftype.equalsIgnoreCase("frfile")?soc.getFRUpload(): 
				         (ftype.equalsIgnoreCase("momfile")?soc.getMoMUpload():soc.getExecutionPlan() ) );
			my_file = new File(LabLogoPath+"CARS\\SoC\\"+File.separator+file); 
	        res.setHeader("Content-disposition","attachment; filename="+file); 
	        OutputStream out = res.getOutputStream();
	        FileInputStream in = new FileInputStream(my_file);
	        byte[] buffer = new byte[4096];
	        int length;
	        while ((length = in.read(buffer)) > 0){
	           out.write(buffer, 0, length);
	        }
	        in.close();
	        out.flush();
	        out.close();
		}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CARSSoCFileDownload.htm "+UserId,e);
		}
	}
	
	@RequestMapping(value="CARSRSQRDownload.htm")
	public void carsRSQRDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSRSQRDownload.htm "+UserId);		
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			
			Object[] carsRSQRDetails = service.carsRSQRDetails(carsInitiationId);
			
			if(carsRSQRDetails[10]==null) {
				service.carsRSQRFormFreeze(req, res, Long.parseLong(carsInitiationId));
			}
			
			res.setContentType("application/pdf");
			res.setHeader("Content-disposition", "inline;filename= RSQR.pdf");
			File f = new File(LabLogoPath + File.separator + carsRSQRDetails[10]+"");
			FileInputStream fis = new FileInputStream(f);
			DataOutputStream os = new DataOutputStream(res.getOutputStream());
			res.setHeader("Content-Length", String.valueOf(f.length()));
			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = fis.read(buffer)) >= 0) {
				os.write(buffer, 0, len);
			}
			os.close();
			fis.close();	

		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside CARSRSQRDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	@RequestMapping(value="CARSFinalRSQRDownload.htm")
	public void carsFinalRSQRDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSFinalRSQRDownload.htm "+UserId);		
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			if(carsInitiationId!=null && carsInitiationId!="0") {
				long carsiniid = Long.parseLong(carsInitiationId);
				req.setAttribute("CARSInitiationData", service.getCARSInitiationById(carsiniid));
				req.setAttribute("RSQRMajorReqr", service.getCARSRSQRMajorReqrByCARSInitiationId(carsiniid));
				req.setAttribute("RSQRDeliverables", service.getCARSRSQRDeliverablesByCARSInitiationId(carsiniid));
				req.setAttribute("RSQRDetails", service.carsRSQRDetails(carsInitiationId));
			}
			String filename="Final-RSQR";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/CARSRSQRDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
			PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
			PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
			PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	
			pdfDocument.close();
			pdf1.close();	       
			pdfw.close();

			res.setContentType("application/pdf");
			res.setHeader("Content-disposition","inline;filename="+filename+".pdf"); 
			File f=new File(path+"/"+filename+".pdf");

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

			Path pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
			Files.delete(pathOfFile2);		

		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside CARSFinalRSQRDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	@RequestMapping(value="SoCApprovalSubmit.htm")
	public String socApprovalSubmit(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir) throws Exception{
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside SoCApprovalSubmit.htm "+UserId);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			String action = req.getParameter("Action");
			String remarks = req.getParameter("remarks");
			long carsini = Long.parseLong(carsInitiationId);
			
			CARSInitiation cars = service.getCARSInitiationById(carsini);
			String statusCode = cars.getCARSStatusCode();
			
			RSQRForwardDTO dto = new RSQRForwardDTO();
			dto.setCarsinitiationid(carsini);
			dto.setAction(action);
			dto.setEmpId(EmpId);
			dto.setRemarks(remarks);
			long result = service.socApprovalForward(dto);
			
			if(action.equalsIgnoreCase("A")) {
				if(statusCode.equalsIgnoreCase("AGD") || statusCode.equalsIgnoreCase("APD") || statusCode.equalsIgnoreCase("SRV") || 
						   statusCode.equalsIgnoreCase("SRG") || statusCode.equalsIgnoreCase("SRP")) {
					if(result!=0) {
						redir.addAttribute("result","SoC form forwarded Successfully");
					}else {
						redir.addAttribute("resultfail","SoC form forward Unsuccessful");
					}
					return "redirect:/CARSInitiationList.htm";
				}else if(statusCode.equalsIgnoreCase("SFU")) {
					if(result!=0) {
						redir.addAttribute("result","SoC form Approved Successfully");
					}else {
						redir.addAttribute("resultfail","SoC form Approve Unsuccessful");
					}
					return "redirect:/CARSRSQRApprovals.htm";
				}
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if(result!=0) {
					redir.addAttribute("result",action.equalsIgnoreCase("R")?"SoC form Returned Successfully":"SoC form Disapproved Successfully");
				}else {
					redir.addAttribute("resultfail",action.equalsIgnoreCase("R")?"SoC form Return Unsuccessful":"SoC form Disapprove Unsuccessful");
				}
			}
			return "redirect:/CARSRSQRApprovals.htm";
			
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside SoCApprovalSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "CARSRSQRTransStatus.htm" , method={RequestMethod.POST,RequestMethod.GET})
	public String carsRSQRTransStatus(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String Username = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside carsRSQRTransStatus.htm "+Username);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			req.setAttribute("TransactionList", service.carsTransListByType(carsInitiationId,"R")) ;
			req.setAttribute("TransFlag", "R");
			req.setAttribute("carsInitiationId", carsInitiationId);
			return "cars/CARSTransactionStatus";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside carsRSQRTransStatus.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "CARSSoCTransStatus.htm" , method={RequestMethod.POST,RequestMethod.GET})
	public String carsSoCTransStatus(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String Username = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSSoCTransStatus.htm "+Username);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			req.setAttribute("TransactionList", service.carsTransListByType(carsInitiationId,"S")) ;
			req.setAttribute("TransFlag", "S");
			req.setAttribute("carsInitiationId", carsInitiationId);
			return "cars/CARSTransactionStatus";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSSoCTransStatus.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSSoCDownload.htm")
	public void carsSoCDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSSoCDownload.htm "+UserId);		
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			if(carsInitiationId!=null && carsInitiationId!="0") {
				long carsiniid = Long.parseLong(carsInitiationId);
				CARSInitiation carsInitiation = service.getCARSInitiationById(carsiniid);
				req.setAttribute("CARSInitiationData", carsInitiation);
				req.setAttribute("RSQRDetails", service.carsRSQRDetails(carsInitiationId));
				req.setAttribute("EmpData", service.getEmpDetailsByEmpId(carsInitiation.getEmpId()+""));
				req.setAttribute("SoCApprovalEmpData", service.carsTransApprovalData(carsInitiationId, "SF"));
				req.setAttribute("CARSSoCData", service.getCARSSoCByCARSInitiationId(carsiniid));
				req.setAttribute("CARSSoCRemarksHistory", service.carsRemarksHistoryByType(carsInitiationId,"SF"));
				
				req.setAttribute("PDEmpIds", service.getEmpPDEmpId(carsInitiation.getFundsFrom()));
			}
			String filename="CARS-SoC";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/CARSSoCDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
			PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
			PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
			PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	
			pdfDocument.close();
			pdf1.close();	       
			pdfw.close();

			res.setContentType("application/pdf");
			res.setHeader("Content-disposition","inline;filename="+filename+".pdf"); 
			File f=new File(path+"/"+filename+".pdf");

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

			Path pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
			Files.delete(pathOfFile2);		

		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside CARSSoCDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	@RequestMapping(value="CARSUserRevoke.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String carsUserRevoke(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside CARSUserRevoke.htm "+UserId);
		try {
			String carsUserRevoke = req.getParameter("carsUserRevoke");
			String[] split = carsUserRevoke.split("/");
			String carsInitiationId = split[0];
			String carsStatusCode = split[1];
            String status = carsStatusCode.equalsIgnoreCase("FWD")?"RSQR":"SoC";
            
			long count = service.carsUserRevoke(carsInitiationId, UserId, EmpId,carsStatusCode);
			
			if (count > 0) {
				redir.addAttribute("result", "CARS "+status+" Revoked Successfully");
			}
			else {
				redir.addAttribute("resultfail", "CARS "+status+" Revoke Unsuccessful");	
			}	

			return "redirect:/CARSInitiationList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSUserRevoke.htm "+UserId, e);
			return "static/Error";			
		}

	}
	
	@RequestMapping(value="CARSSoCMilestoneSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String carsSoCMitlestoneSubmit(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSSoCMilestoneSubmit.htm "+UserId);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			long carsiniid = Long.parseLong(carsInitiationId);

			CARSRSQRDetailsDTO dto = new CARSRSQRDetailsDTO();
			dto.setCARSInitiationId(carsiniid);
			dto.setMilestoneNo(req.getParameterValues("milestoneno"));
			dto.setTaskDesc(req.getParameterValues("taskDesc"));
			dto.setMonths(req.getParameterValues("months"));
			dto.setDeliverables(req.getParameterValues("deliverables"));
			dto.setPaymentTerms(req.getParameterValues("paymentTerms"));
			dto.setUserId(UserId);
			
			List<CARSSoCMilestones> milestones = service.getCARSSoCMilestonesByCARSInitiationId(carsiniid);
			long result = 0l;
			if(milestones!=null && milestones.size()==0) {
				result = service.carsSoCMilestonesDetailsSubmit(dto);
			}else {
				service.removeCARSSoCMilestonesDetails(carsiniid);
				result = service.carsSoCMilestonesDetailsSubmit(dto);
				if (result > 0) {
					redir.addAttribute("result", "SoC Milestone Details updated Successfully");
				} else {
					redir.addAttribute("resultfail", "SoC Milestone Details update Unsuccessful");
				}
				redir.addAttribute("carsInitiationId", carsInitiationId);
				redir.addAttribute("TabId","6");
				return "redirect:/CARSInitiationDetails.htm";
			}
			if (result > 0) {
				redir.addAttribute("result", "SoC Milestone Details added Successfully");
			} else {
				redir.addAttribute("resultfail", "SoC Milestone Details add Unsuccessful");
			}
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("TabId","6");
			return "redirect:/CARSInitiationDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSSoCMilestoneSubmit.htm "+UserId, e);
			return "static/Error";			
		}
	}
	
	@RequestMapping(value="CARSSoCMilestonesDownload.htm")
	public void carsSoCMilestonesDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSSoCMilestonesDownload.htm "+UserId);		
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			if(carsInitiationId!=null && carsInitiationId!="0") {
				long carsiniid = Long.parseLong(carsInitiationId);
				CARSInitiation carsInitiation = service.getCARSInitiationById(carsiniid);
				req.setAttribute("CARSInitiationData", carsInitiation);
				req.setAttribute("EmpData", service.getEmpDetailsByEmpId(carsInitiation.getEmpId()+""));
				req.setAttribute("CARSSoCMilestones", service.getCARSSoCMilestonesByCARSInitiationId(carsiniid));
			}
			String filename="CARS-SoC-Milestones";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/CARSSoCMilestonesDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
			PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
			PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
			PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	
			pdfDocument.close();
			pdf1.close();	       
			pdfw.close();

			res.setContentType("application/pdf");
			res.setHeader("Content-disposition","inline;filename="+filename+".pdf"); 
			File f=new File(path+"/"+filename+".pdf");

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

			Path pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
			Files.delete(pathOfFile2);		

		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside CARSSoCMilestonesDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}

	@RequestMapping(value="CARSRSQRApprovedList.htm")
	public String carsRSQRApprovedList(HttpServletRequest req,HttpSession ses) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside CARSRSQRApprovedList.htm "+Username);
		try {
			String TabId = req.getParameter("TabId");
			String PageLoad = req.getParameter("PageLoad");

			if(PageLoad!=null && PageLoad.equalsIgnoreCase("S")) {
				String socfromdate = req.getParameter("socfromdate");
				String soctodate = req.getParameter("soctodate");

				LocalDate today=LocalDate.now();

				if(socfromdate == null) 
				{
					socfromdate =today.withDayOfMonth(1).toString();
					soctodate = today.toString();

				}else
				{
					socfromdate = fc.RegularToSqlDate(socfromdate);
					soctodate = fc.RegularToSqlDate(soctodate);
				}

				req.setAttribute("socfromdate", socfromdate);
				req.setAttribute("soctodate", soctodate);
				req.setAttribute("MoMUploadedList", service.carsSoCMoMUploadedList(socfromdate,soctodate));

				req.setAttribute("TabId", TabId!=null?TabId:"2");

			}

			String fromdate = req.getParameter("fromdate");
			String todate = req.getParameter("todate");

			LocalDate today = LocalDate.now();

			if(fromdate == null) 
			{
				fromdate = today.withDayOfMonth(1).toString();
				todate = today.toString();

			}else
			{
				fromdate = fc.RegularToSqlDate(fromdate);
				todate = fc.RegularToSqlDate(todate);
			}

			req.setAttribute("fromdate", fromdate);
			req.setAttribute("todate", todate);

			req.setAttribute("ApprovedList", service.carsRSQRApprovedList(EmpId,fromdate,todate,"A"));

			if(PageLoad==null) {
				req.setAttribute("socfromdate", fromdate);
				req.setAttribute("soctodate", todate);
				req.setAttribute("MoMUploadedList", service.carsSoCMoMUploadedList(fromdate,todate));
				req.setAttribute("TabId", TabId!=null?TabId:"1");
			}

			return "cars/AllCARSList";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSRSQRApprovedList.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="InvForSoODateSubmit.htm")
	public String invForSoODateSubmit(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside InvForSoODateSubmit.htm "+Username);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			String calendardate = req.getParameter("calendardate");
			int result = service.invForSoODateSubmit(carsInitiationId, fc.RegularToSqlDate(calendardate));
			if(result!=0) {
				redir.addAttribute("result","Inv for SoO Date Submitted Successfully");
			}else {
				redir.addAttribute("resultfail","Inv for SoO Date Submit Unsuccessful");
			}
			return "redirect:/CARSRSQRApprovedList.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside InvForSoODateSubmit.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSDPCSoCDetails.htm")
	public String carsDPCSoCDetails(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CARSDPCSoCDetails.htm "+Username);
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		try {
			
			String carsInitiationId = req.getParameter("carsInitiationId");
			String dpcTabId = req.getParameter("dpcTabId");
			String isApproval = req.getParameter("isApproval");
			if(carsInitiationId==null) {
				String fromapprovals = req.getParameter("carsInitiationIdSoCApprovals");
				if(fromapprovals!=null) {
					String[] split = fromapprovals.split("/");
					carsInitiationId = split[0];
					if(isApproval==null) {
						isApproval = split[1];
					}
					if(dpcTabId==null) {
						dpcTabId = split[2];
					}
				}
				
			}
			if(carsInitiationId!=null && carsInitiationId!="0") {
				long carsiniid = Long.parseLong(carsInitiationId);
				CARSInitiation carsInitiation = service.getCARSInitiationById(carsiniid);
				req.setAttribute("CARSInitiationData", carsInitiation);
				req.setAttribute("CARSSoCData", service.getCARSSoCByCARSInitiationId(carsiniid));
				req.setAttribute("CARSSoCMilestones", service.getCARSSoCMilestonesByCARSInitiationId(carsiniid));
				req.setAttribute("CARSDPCSoCRemarksHistory", service.carsRemarksHistoryByType(carsInitiationId,"DF"));
				req.setAttribute("DPCSoCApprovalEmpData", service.carsTransApprovalData(carsInitiationId, "DF"));
				req.setAttribute("PDEmpIds", service.getEmpPDEmpId(carsInitiation.getFundsFrom()));
			}
			req.setAttribute("EmpData", service.getEmpDetailsByEmpId(EmpId));
			req.setAttribute("dpcTabId", dpcTabId!=null?dpcTabId:"1");
			
			req.setAttribute("GHDPandC", service.getApprAuthorityDataByType(labcode, "GH-DP&C"));
			req.setAttribute("GDDPandC", service.getApprAuthorityDataByType(labcode, "DO-RTMD"));
			req.setAttribute("ChairmanRPB", service.getApprAuthorityDataByType(labcode, "Chairman RPB"));
			req.setAttribute("MMFDAG", service.getApprAuthorityDataByType(labcode, "MMFD AG"));
			req.setAttribute("GDDFandMM", service.getApprAuthorityDataByType(labcode, "GD DF&MM"));
			req.setAttribute("Director", service.getLabDirectorData(labcode));
			
			req.setAttribute("isApproval", isApproval);
			return "cars/DPCSoCDetails";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSDPCSoCDetails.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSDPCSoCEdit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String carsDPCSoCEditSubmit(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSDPCSoCEdit.htm "+Username);
		try{
			
			String carsInitiationId = req.getParameter("carsInitiationId");
			String carsSocId = req.getParameter("carsSocId");
			String Action = req.getParameter("Action");
			
			CARSSoC soc = service.getCARSSoCById(Long.parseLong(carsSocId));
			soc.setDPCIntroduction(req.getParameter("dpcIntroduction"));
			soc.setDPCExpenditure(req.getParameter("dpcExpenditure"));
			soc.setDPCAdditional(req.getParameter("dpcAdditional"));
			soc.setModifiedBy(Username);
			soc.setModifiedDate(sdtf.format(new Date()));
			
			long result = service.editCARSSoC(soc);
			if(result!=0) {
				redir.addAttribute("result", "CARS D-P&C SoC Details "+Action+" Successfully");
			}else {
				redir.addAttribute("resultfail", "CARS D-P&C SoC Details "+Action+" UnSuccessful");
			}
			
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("carsSoCId",result);
			redir.addAttribute("dpcTabId","1");
			
			return "redirect:/CARSDPCSoCDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSDPCSoCEdit.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="DPCSoCApprovalSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String dpcSoCApprovalSubmit(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside DPCSoCApprovalSubmit.htm "+Username);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			String remarks = req.getParameter("remarks");
			String action = req.getParameter("Action");
			
			long carsini = Long.parseLong(carsInitiationId);
			
			CARSInitiation cars = service.getCARSInitiationById(carsini);
			String statusCode = cars.getCARSStatusCode();
			
			RSQRForwardDTO dto = new RSQRForwardDTO();
			dto.setCarsinitiationid(carsini);
			dto.setAction(action);
			dto.setEmpId(EmpId);
			dto.setRemarks(remarks);
			dto.setLabcode(labcode);
			long result = service.dpcSoCApprovalForward(dto);
			
			List<String> forwardstatus = Arrays.asList("SFG","SFP","SID","SGR","SPR","SRC","SRM","SRF","SRR","SRI","RDG","SRD");
			List<String> approvestatus = Arrays.asList("SDF","SAD","SAI","ADG");

			if(action.equalsIgnoreCase("A")) {
				if(forwardstatus.contains(statusCode)) {
					if(result!=0) {
						redir.addAttribute("result","SoC form forwarded Successfully");
					}else {
						redir.addAttribute("resultfail","SoC form forward Unsuccessful");
					}
				}else if(approvestatus.contains(statusCode)) {
					if(result!=0) {
						redir.addAttribute("result","SoC form Approved Successfully");
					}else {
						redir.addAttribute("resultfail","SoC form Approve Unsuccessful");
					}
					return "redirect:/CARSRSQRApprovals.htm";
				}else {
					if(result!=0) {
						redir.addAttribute("result","SoC form Recommended Successfully");
					}else {
						redir.addAttribute("resultfail","SoC form Recommend Unsuccessful");
					}
					return "redirect:/CARSRSQRApprovals.htm";
				}
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if(result!=0) {
					redir.addAttribute("result",action.equalsIgnoreCase("R")?"SoC form Returned Successfully":"SoC form Disapproved Successfully");
				}else {
					redir.addAttribute("resultfail",action.equalsIgnoreCase("R")?"SoC form Return Unsuccessful":"SoC form Disapprove Unsuccessful");
				}
			}
			
			redir.addAttribute("PageLoad", "S");
			return "redirect:/CARSRSQRApprovedList.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside DPCSoCApprovalSubmit.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSTransactionDownload.htm")
	public void carsTransactionDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSTransactionDownload.htm "+UserId);		
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			String TransFlag = req.getParameter("TransFlag");
			
			if(TransFlag!=null && TransFlag.equalsIgnoreCase("R")) {
				req.setAttribute("TransactionList", service.carsTransListByType(carsInitiationId, TransFlag)) ;
			}else if(TransFlag!=null && TransFlag.equalsIgnoreCase("S")) {
				req.setAttribute("TransactionList", service.carsTransListByType(carsInitiationId, TransFlag)) ;
			}else if(TransFlag!=null && TransFlag.equalsIgnoreCase("D")){
				req.setAttribute("TransactionList", service.carsTransListByType(carsInitiationId, TransFlag)) ;
			}else {
				req.setAttribute("TransactionList", service.carsTransListByType(carsInitiationId, TransFlag)) ;
			}
			req.setAttribute("CARSInitiationData", service.getCARSInitiationById(Long.parseLong(carsInitiationId)));
			
			String filename="CARS-Transaction";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/CARSTransactionDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
			PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
			PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
			PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	
			pdfDocument.close();
			pdf1.close();	       
			pdfw.close();

			res.setContentType("application/pdf");
			res.setHeader("Content-disposition","inline;filename="+filename+".pdf"); 
			File f=new File(path+"/"+filename+".pdf");

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

			Path pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
			Files.delete(pathOfFile2);		

		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside CARSTransactionDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	@RequestMapping(value="CARSDPCSoCDownload.htm")
	public void carsDPCSoCDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSTransactionDownload.htm "+UserId);		
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");

			if(carsInitiationId!=null && carsInitiationId!="0") {
				long carsiniid = Long.parseLong(carsInitiationId);
				CARSInitiation carsInitiation = service.getCARSInitiationById(carsiniid);
				req.setAttribute("CARSInitiationData", carsInitiation);
				req.setAttribute("CARSSoCData", service.getCARSSoCByCARSInitiationId(carsiniid));
				req.setAttribute("CARSSoCMilestones", service.getCARSSoCMilestonesByCARSInitiationId(carsiniid));
				req.setAttribute("DPCSoCApprovalEmpData", service.carsTransApprovalData(carsInitiationId, "DF"));
			}
			
			String filename="CARS-DPCSoC";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/CARSDPCSoCDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
			PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
			PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
			PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	
			pdfDocument.close();
			pdf1.close();	       
			pdfw.close();

			res.setContentType("application/pdf");
			res.setHeader("Content-disposition","inline;filename="+filename+".pdf"); 
			File f=new File(path+"/"+filename+".pdf");

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

			Path pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
			Files.delete(pathOfFile2);		

		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside CARSTransactionDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}

	@RequestMapping(value="CARSSoCDPCRevoke.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String carsSoCDPCRevoke(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside CARSSoCDPCRevoke.htm "+UserId);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
		
            
			long count = service.carsSoCDPCRevoke(carsInitiationId, UserId, EmpId);
			
			if (count > 0) {
				redir.addAttribute("result", "CARS SoC Revoked Successfully");
			}
			else {
				redir.addAttribute("resultfail", "CARS SoC Revoke Unsuccessful");	
			}	

			redir.addAttribute("PageLoad", "S");
			return "redirect:/CARSRSQRApprovedList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSSoCDPCRevoke.htm "+UserId, e);
			return "static/Error";			
		}

	}
	
	@RequestMapping(value = "CARSDPCSoCTransStatus.htm" , method={RequestMethod.POST,RequestMethod.GET})
	public String carsDPCSoCTransStatus(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String Username = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSDPCSoCTransStatus.htm "+Username);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			req.setAttribute("TransactionList", service.carsTransListByType(carsInitiationId, "D")) ;
			req.setAttribute("TransFlag", "D");
			req.setAttribute("carsInitiationId", carsInitiationId);
			return "cars/CARSTransactionStatus";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSDPCSoCTransStatus.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSSoCMoMUpload.htm")
	public String carsSocMoMUpload(HttpServletRequest req,HttpSession ses,RedirectAttributes redir,
			@RequestPart(name="MoMUpload", required = false) MultipartFile MoMFile) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSSoCMoMUpload.htm "+Username);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			String carsSocId = req.getParameter("carsSocId");
		
			long result = service.carsSoCUploadMoM(MoMFile, carsSocId);
			
			if(result!=0) {
				redir.addAttribute("result", "MoM Uploaded Successfully");
			}else {
				redir.addAttribute("resultfail", "MoM Upload UnSuccessful");
			}
			
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("carsSoCId",carsSocId);
			redir.addAttribute("TabId","8");
			return "redirect:/CARSInitiationDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSSoCMoMUpload.htm "+Username, e);
			return "static/Error";
		}
	}
}
