package com.vts.pfms.cars.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
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
import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;
import com.vts.pfms.cars.service.CARSService;
import com.vts.pfms.project.service.ProjectService;

@Controller
public class CARSController {

	private static final Logger logger = LogManager.getLogger(CARSController.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdf1 = fc.getSqlDateAndTimeFormat();
	
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
			if(carsInitiationId!=null && carsInitiationId!="0") {
				long carsiniid = Long.parseLong(carsInitiationId);
				CARSInitiation carsInitiation = service.getCARSInitiationById(carsiniid);
				req.setAttribute("CARSInitiationData", carsInitiation);
				req.setAttribute("RSQRMajorReqr", service.getCARSRSQRMajorReqrByCARSInitiationId(carsiniid));
				req.setAttribute("RSQRDeliverables", service.getCARSRSQRDeliverablesByCARSInitiationId(carsiniid));
				req.setAttribute("ProjectList", projectservice.LoginProjectDetailsList(carsInitiation.getEmpId()+"",Logintype,LabCode));
				req.setAttribute("EmpData", service.getEmpDetailsByEmpId(carsInitiation.getEmpId()+""));
				req.setAttribute("ApprovalEmpData", service.carsTransApprovalData(carsInitiationId));
				req.setAttribute("CARSRSQRRemarksHistory", service.carsRSQRRemarksHistory(carsInitiationId));
				req.setAttribute("GDEmpIds", service.getEmpGDEmpId(carsInitiation.getEmpId()+""));
				req.setAttribute("PDEmpIds", service.getEmpPDEmpId(carsInitiation.getFundsFrom()));
			}else {
				req.setAttribute("ProjectList", projectservice.LoginProjectDetailsList(EmpId,Logintype,LabCode));
				req.setAttribute("EmpData", service.getEmpDetailsByEmpId(EmpId));
			}
			
			req.setAttribute("carsInitiationId", carsInitiationId);
			
			String carsSoCId = req.getParameter("carsSoCId");
			if(carsSoCId!=null && carsSoCId!="0") {
				long carssocid = Long.parseLong(carsSoCId);
				req.setAttribute("CARSSoCData", service.getCARSSoCById(carssocid));
			}
			
			String TabId = req.getParameter("TabId");
			req.setAttribute("TabId", TabId!=null?TabId:"1");
			
			String attributes = req.getParameter("attributes");
			req.setAttribute("attributes", req.getParameter("attributes")!=null?attributes:"Introduction");
			
			req.setAttribute("isApproval", req.getParameter("isApproval"));
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
					                   .Duration(req.getParameter("duration"))
					                   .RSPAddress(req.getParameter("rspAddress"))
					                   .RSPCity(req.getParameter("rspCity"))
					                   .RSPState(req.getParameter("rspState"))
					                   .RSPPinCode(req.getParameter("rspPinCode"))
					                   .PITitle(req.getParameter("piTitle"))
					                   .PIName(req.getParameter("piName"))
					                   .PIDept(req.getParameter("piDept"))
					                   .PIMobileNo(req.getParameter("piMobileNo"))
					                   .PIEmail(req.getParameter("piEmail"))
					                   .CARSStatusCode("INI")
					                   .CARSStatusCodeNext("FWD")
					                   .CreatedBy(UserId)
					                   .CreatedDate(sdf1.format(new Date()))
					                   .IsActive(1)
					                   .build();
			long result = service.addCARSInitiation(initiation);
			if(result!=0) {
				redir.addAttribute("result", "CARS Initiation Added Successfully");
			}else {
				redir.addAttribute("resultfail", "CARS Initiation Add UnSuccessfull");
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
			initiation.setDuration(req.getParameter("duration"));
			initiation.setRSPAddress(req.getParameter("rspAddress"));
			initiation.setRSPCity(req.getParameter("rspCity"));
			initiation.setRSPState(req.getParameter("rspState"));
			initiation.setRSPPinCode(req.getParameter("rspPinCode"));
			initiation.setPITitle(req.getParameter("piTitle"));
			initiation.setPIName(req.getParameter("piName"));
			initiation.setPIDept(req.getParameter("piDept"));
			initiation.setPIMobileNo(req.getParameter("piMobileNo"));
			initiation.setPIEmail(req.getParameter("piEmail"));
			initiation.setModifiedBy(UserId);
			initiation.setModifiedDate(sdf1.format(new Date()));
			
			long result = service.editCARSInitiation(initiation);
			if(result!=0) {
				redir.addAttribute("result", "CARS Initiation Edited Successfully");
			}else {
				redir.addAttribute("resultfail", "CARS Initiation Edit UnSuccessfull");
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
		Object[] carsRSQR = service.carsRSQRDetails(carsInitiationId);
		long count=0l;
		if(carsRSQR==null) {
			count=service.carsRSQRDetailsSubmit(carsInitiationId,attributes,Details,UserId);
		}else {
			count=service.carsRSQRDetailsUpdate(carsInitiationId,attributes,Details,UserId);
			if (count > 0) {
				redir.addAttribute("result", attributes+" updated Successfully");
			} else {
				redir.addAttribute("resultfail", attributes+" update Unsuccessful");
			}
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("TabId","2");
			redir.addAttribute("attributes", attributes);
			return "redirect:/CARSInitiationDetails.htm";
		}
		if (count > 0) {
			redir.addAttribute("result", attributes+" added Successfully");
		} else {
			redir.addAttribute("resultfail", attributes+" add Unsuccessful");
		}
		redir.addAttribute("carsInitiationId", carsInitiationId);
		redir.addAttribute("TabId","2");
		redir.addAttribute("attributes", attributes);
		System.out.println("Inside Submission2: "+attributes);
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
		
		CARSRSQRDetailsDTO dto = new CARSRSQRDetailsDTO();
		dto.setCARSInitiationId(carsiniid);
		dto.setReqId(req.getParameterValues("reqId"));
		dto.setReqDescription(req.getParameterValues("reqDescription"));
		dto.setRelevantSpecs(req.getParameterValues("relevantSpecs"));
		dto.setValidationMethod(req.getParameterValues("validationMethod"));
		dto.setRemarks(req.getParameterValues("remarks"));
		dto.setUserId(UserId);
		
		List<CARSRSQRMajorRequirements> majorReqr = service.getCARSRSQRMajorReqrByCARSInitiationId(carsiniid);
		long count=0l;
		if(majorReqr!=null && majorReqr.size()==0) {
			count=service.carsRSQRMajorReqrDetailsSubmit(dto);
		}else {
			service.removeCARSRSQRMajorReqrDetails(carsiniid);
			count=service.carsRSQRMajorReqrDetailsSubmit(dto);
			if (count > 0) {
				redir.addAttribute("result", "RSQR Major Requirement Details updated Successfully");
			} else {
				redir.addAttribute("resultfail", "RSQR Major Requirement Details update Unsuccessful");
			}
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("attributes", attributes);
			redir.addAttribute("TabId","2");
			return "redirect:/CARSInitiationDetails.htm";
		}
		if (count > 0) {
			redir.addAttribute("result", "RSQR Major Requirement Details added Successfully");
		} else {
			redir.addAttribute("resultfail", "RSQR Major Requirement Details add Unsuccessful");
		}
		redir.addAttribute("carsInitiationId", carsInitiationId);
		redir.addAttribute("attributes", attributes);
		redir.addAttribute("TabId","2");
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
			
			CARSRSQRDetailsDTO dto = new CARSRSQRDetailsDTO();
			dto.setCARSInitiationId(carsiniid);
			dto.setDescription(req.getParameterValues("description"));
			dto.setDeliverableType(req.getParameterValues("deliverableType"));
			dto.setUserId(UserId);
			
			List<CARSRSQRDeliverables> deliverables = service.getCARSRSQRDeliverablesByCARSInitiationId(carsiniid);
			long count=0l;
			if(deliverables!=null && deliverables.size()==0) {
				count=service.carsRSQRDeliverableDetailsSubmit(dto);
			}else {
				service.removeCARSRSQRDeliverableDetails(carsiniid);
				count=service.carsRSQRDeliverableDetailsSubmit(dto);
				if (count > 0) {
					redir.addAttribute("result", "RSQR Deliverable Details updated Successfully");
				} else {
					redir.addAttribute("resultfail", "RSQR Deliverable Details update Unsuccessful");
				}
				redir.addAttribute("carsInitiationId", carsInitiationId);
				redir.addAttribute("attributes", attributes);
				redir.addAttribute("TabId","2");
				return "redirect:/CARSInitiationDetails.htm";
			}
			if (count > 0) {
				redir.addAttribute("result", "RSQR Deliverable Details added Successfully");
			} else {
				redir.addAttribute("resultfail", "RSQR Deliverable Details add Unsuccessful");
			}
			redir.addAttribute("carsInitiationId", carsInitiationId);
			redir.addAttribute("attributes", attributes);
			redir.addAttribute("TabId","2");
			return "redirect:/CARSInitiationDetails.htm";
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RSQRDeliverablesSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSRSQRDownload.htm")
	public void carsRSQRDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSRSQRDownload.htm "+UserId);		
		try {
			String carsInitiationId = req.getParameter("carsInitiationId");
			if(carsInitiationId!=null && carsInitiationId!="0") {
				long carsiniid = Long.parseLong(carsInitiationId);
				req.setAttribute("CARSInitiationData", service.getCARSInitiationById(carsiniid));
				req.setAttribute("RSQRMajorReqr", service.getCARSRSQRMajorReqrByCARSInitiationId(carsiniid));
				req.setAttribute("RSQRDeliverables", service.getCARSRSQRDeliverablesByCARSInitiationId(carsiniid));
				req.setAttribute("RSQRDetails", service.carsRSQRDetails(carsInitiationId));
			}
			String filename="RSQR";	
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
    		logger.error(new Date() +" Inside CARSRSQRDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	@RequestMapping(value="RSQRApprovalSubmit.htm")
	public String rsqrApprovalSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
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
			
			long count = service.rsqrApprovalForward(carsini,action,EmpId,UserId,remarks);
			
			if(action.equalsIgnoreCase("A")) {
				if(carsStatusCode.equalsIgnoreCase("INI") || carsStatusCode.equalsIgnoreCase("RGD") || carsStatusCode.equalsIgnoreCase("RPD")) {
					if(count!=0) {
						redir.addAttribute("result","RSQR Approval form forwarded Successfully");
					}else {
						redir.addAttribute("resultfail","RSQR Approval form forward Unsuccessful");
					}
					return "redirect:/CARSInitiationList.htm";
				}else if(carsStatusCode.equalsIgnoreCase("FWD")) {
					if(count!=0) {
						redir.addAttribute("result","RSQR Approval form Approved Successfully");
					}else {
						redir.addAttribute("resultfail","RSQR Approval form Approve Unsuccessful");
					}
					return "redirect:/CARSRSQRApprovals.htm";
				}
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if(count!=0) {
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
	public String MobileNumberTransStatus(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String Username = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CARSTransStatus.htm "+Username);
		try {
			String carsInitiationId = req.getParameter("carsInitiationId").trim();
			req.setAttribute("TransactionList", service.carsTransList(carsInitiationId)) ;				
			return "cars/CARSTransactionStatus";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CARSTransStatus.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CARSRSQRApprovals.htm")
	public String attndApprovals(HttpServletRequest req,HttpSession ses) throws Exception{
		String Username = (String)ses.getAttribute("Username");
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
			req.setAttribute("ApprovedList", service.carsRSQRApprovedList(EmpId,fromdate,todate));
			
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
				req.setAttribute("ApprovalEmpData", service.carsTransApprovalData(carsInitiationId));
				req.setAttribute("CARSRSQRRemarksHistory", service.carsRSQRRemarksHistory(carsInitiationId));
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
			String filename="CARS-RSQR_Approval";	
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
	
	public String getLabLogoAsBase64() throws IOException {

		String path = LabLogoPath + "\\images\\lablogos\\lrdelogo.png";
		try {
			return Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(path)));
		} catch (FileNotFoundException e) {
			System.err.println("File Not Found at Path " + path);
		}
		return "/print/.jsp";
	}
}
