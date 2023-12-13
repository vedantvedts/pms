package com.vts.pfms.cars.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
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
				req.setAttribute("CARSInitiationData", service.getCARSInitiationById(carsiniid));
				req.setAttribute("RSQRMajorReqr", service.getCARSRSQRMajorReqrByCARSInitiationId(carsiniid));
				req.setAttribute("RSQRDeliverables", service.getCARSRSQRDeliverablesByCARSInitiationId(carsiniid));
			}
			req.setAttribute("carsInitiationId", carsInitiationId);
			String TabId = req.getParameter("TabId");
			req.setAttribute("TabId", TabId!=null?TabId:"1");
			req.setAttribute("ProjectList", projectservice.LoginProjectDetailsList(EmpId,Logintype,LabCode));
			String attributes = req.getParameter("attributes");
			req.setAttribute("attributes", attributes!=null?attributes:"Introduction");
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
			long count = service.rsqrApprovalForward(Long.parseLong(carsInitiationId),action,EmpId,UserId);
			
			if(count!=0) {
				redir.addAttribute("result","RSQR Approval form forwarded Successfully");
			}else {
				redir.addAttribute("resultfail","RSQR Approval form forward Unsuccessful");
			}
			return "redirect:/CARSInitiationList.htm";
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RSQRApprovalSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}
}
