package com.vts.pfms.projectclosure.controller;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.introspect.VisibilityChecker;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.utils.PdfMerger;

import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.service.CARSService;
import com.vts.pfms.master.dto.ProjectFinancialDetails;


import com.vts.pfms.pfts.controller.JasperJdbcConnection;
import com.vts.pfms.print.service.PrintService;
import com.vts.pfms.project.model.ProjectMaster;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.projectclosure.dto.ProjectClosureACPDTO;
import com.vts.pfms.projectclosure.dto.ProjectClosureApprovalForwardDTO;
import com.vts.pfms.projectclosure.model.ProjectClosure;
import com.vts.pfms.projectclosure.model.ProjectClosureACP;
import com.vts.pfms.projectclosure.model.ProjectClosureACPTrialResults;
import com.vts.pfms.projectclosure.model.ProjectClosureSoC;
import com.vts.pfms.projectclosure.service.ProjectClosureService;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;

import com.vts.pfms.projectclosure.model.ProjectClosureCheckList;

@Controller
public class ProjectClosureController {
	private static final Logger logger = LogManager.getLogger(ProjectClosureController.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
	
	@Autowired
	ProjectClosureService service;
	
	@Autowired
	ProjectService projectservice;
	
	@Autowired
	PrintService printservice;
	
	@Autowired
	CARSService carsservice;
	
	@Autowired
	RestTemplate restTemplate;
	
	@Autowired
	private JasperJdbcConnection jdbcJasper;
	
	@Value("${server_uri}")
    private String uri;
	
	@Value("${ApplicationFilesDrive}")
	private String LabLogoPath;
	
	@Autowired
	Environment env;
	
	@RequestMapping(value = "ProjectClosureList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String projectClosureList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String LoginType = (String) ses.getAttribute("LoginType");
		logger.info(new Date() +"Inside ProjectClosureList.htm "+UserId);
		try {
			String pagination = req.getParameter("pagination");
			int pagin = Integer.parseInt(pagination!=null?pagination:"0");

			/* fetching actual data */
			List<Object[]> closureList = service.projectClosureList(EmpId, labcode, LoginType);

			// adding values to this List<Object[]>
			List<Object[]> arrayList = new ArrayList<>();

			/* search action starts */
			String search = req.getParameter("search");
			if(search!="" && search!=null) {
				req.setAttribute("searchFactor", search);
				for(Object[] obj: closureList) {
					for(Object value:obj) {
						if(value instanceof String)
							if (((String)(value)).toLowerCase().contains(search.toLowerCase()) ) {
                                  arrayList.add(obj);
								continue;
							}
					}
				}
				if (arrayList.size()==0)req.setAttribute("resultfail", "search result is empty!");
			}
			else if(req.getParameter("clicked")!=null) {
				req.setAttribute("resultfail", "search is empty!");
			}

			/* search action ends */
			int p = closureList.size()/3;
			int extra = closureList.size()%3;
			if(arrayList.size()==0) arrayList=closureList;

			/* pagination process starts */

			if(pagin>0 && pagin<(p+(extra>0?1:0)))
			{
				req.setAttribute("pagination", pagin);
				arrayList = arrayList.subList(pagin*3, ((pagin*3)+3)<arrayList.size()?((pagin*3)+3):arrayList.size());
			}
			else
			{
				arrayList = arrayList.subList(0, arrayList.size()>=3?3:arrayList.size());
				req.setAttribute("pagination", 0);
				pagin=0;
			}

			req.setAttribute("ClosureList", arrayList);
			req.setAttribute("maxpagin", p+(extra>0?1:0) );
			/* pagination process ends */

			return "project/ProjectClosureList";
		}
		catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureList.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="ProjectClosureSoCDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String projectClosureSoCDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date()+ " Inside ProjectClosureSoCDetails.htm "+UserId);
		try {
			String closureId = req.getParameter("closureId");
			String socTabId = req.getParameter("socTabId");
			String isApproval = req.getParameter("isApproval");
			
			if(closureId==null) {
				String fromapprovals = req.getParameter("closureSoCApprovals");
				if(fromapprovals!=null) {
					String[] split = fromapprovals.split("/");
					closureId = split[0];
					if(isApproval==null) {
						isApproval = split[1];
					}
					if(socTabId==null) {
						socTabId = split[2];
					}
				}
				
			}
			
			if(closureId!=null) {
				ProjectClosure closure = service.getProjectClosureById(closureId);
				String projectId = closure.getProjectId()+"";
				req.setAttribute("ProjectClosureDetails", closure);
				req.setAttribute("ProjectDetails", service.getProjectMasterByProjectId(projectId));
				req.setAttribute("ProjectClosureSoCData", service.getProjectClosureSoCByProjectId(closureId));
				Object[] PDData = carsservice.getEmpPDEmpId(projectId);
				req.setAttribute("PDData", PDData);
				req.setAttribute("GDDetails", service.getEmpGDDetails(PDData!=null?PDData[1].toString():"0"));
				req.setAttribute("ProjectOriginalRevDetails", service.projectOriginalAndRevisionDetails(projectId));
				req.setAttribute("ProjectExpenditureDetails", service.projectExpenditureDetails(projectId));
				req.setAttribute("SoCRemarksHistory", service.projectClosureRemarksHistoryByType(closureId,"SF","S"));
				req.setAttribute("SoCApprovalEmpData", service.projectClosureApprovalDataByType(closureId,"SF","S"));
			}
			req.setAttribute("Director", carsservice.getLabDirectorData(labcode));
			req.setAttribute("AD", carsservice.getApprAuthorityDataByType(labcode, "AD"));
			req.setAttribute("GDDPandC", carsservice.getApprAuthorityDataByType(labcode, "DO-RTMD"));
			req.setAttribute("EmpData", carsservice.getEmpDetailsByEmpId(EmpId));
			
			req.setAttribute("LabList", carsservice.getLabList(labcode));
			
			req.setAttribute("closureId", closureId);
			req.setAttribute("isApproval", isApproval);
			req.setAttribute("socTabId", socTabId!=null?socTabId:"1");
			return "project/ProjectClosureSoCDetails";
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureSoCDetails.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="ProjectClosureSoCDetailsSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String projectClosureSoCDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart(name="monitoringCommitteeAttach", required = false) MultipartFile monitoringCommitteeAttach,
			@RequestPart(name="lessonsLearnt", required = false) MultipartFile lessonsLearnt) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		try {
			String closureId = req.getParameter("closureId");
			String action = req.getParameter("Action");
			
//			String expndAsOn = req.getParameter("expndAsOn");
//			String totalExpnd = req.getParameter("totalExpnd");
//			String totalExpndFE = req.getParameter("totalExpndFE");
			
			ProjectClosureSoC soc = (action!=null && action.equalsIgnoreCase("Add"))?new ProjectClosureSoC() : service.getProjectClosureSoCByProjectId(closureId);
			
			soc.setClosureId(Long.parseLong(closureId));
//			soc.setClosureCategory(req.getParameter("closureCategory"));
			soc.setQRNo(req.getParameter("qrNo"));
//			soc.setExpndAsOn(fc.RegularToSqlDate(expndAsOn));
//			soc.setTotalExpnd(totalExpnd!=null?String.format("%.2f", Double.parseDouble(totalExpnd)*10000000 ):null );
//			soc.setTotalExpndFE(totalExpndFE!=null?String.format("%.2f", Double.parseDouble(totalExpndFE)*10000000 ):null );
			soc.setPresentStatus(req.getParameter("presentStatus"));
			soc.setReason(req.getParameter("reason"));
			soc.setRecommendation(req.getParameter("recommendation"));
			soc.setMonitoringCommittee(req.getParameter("monitoringCommittee"));
			soc.setDMCDirection(req.getParameter("dmcDirection"));
			soc.setOtherRelevant(req.getParameter("otherRelevant"));
			
			long result=0l;
			if(action!=null && action.equalsIgnoreCase("Add")) {
				
				soc.setCreatedBy(UserId);
				soc.setCreatedDate(sdtf.format(new Date()));
				soc.setIsActive(1);
				
				result = service.addProjectClosureSoC(soc, EmpId, monitoringCommitteeAttach, lessonsLearnt);
				
			}else if(action!=null && action.equalsIgnoreCase("Edit")) {
				soc.setModifiedBy(UserId);
				soc.setModifiedDate(sdtf.format(new Date()));
				
				result = service.editProjectClosureSoC(soc, monitoringCommitteeAttach, lessonsLearnt);
				
				if (result > 0) {
					redir.addAttribute("result", "Closure SoC Details Updated Successfully");
				} else {
					redir.addAttribute("resultfail", "Closure SoC Details Update Unsuccessful");
				}
				redir.addAttribute("closureId", closureId);
				redir.addAttribute("socTabId","2");
				return "redirect:/ProjectClosureSoCDetails.htm";
			}
			if (result > 0) {
				redir.addAttribute("result", "Closure SoC Details Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Closure SoC Details Add Unsuccessful");
			}
			redir.addAttribute("closureId", closureId);
			redir.addAttribute("socTabId","2");
			
			return "redirect:/ProjectClosureSoCDetails.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureSoCDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="ProjectClosureSoCApprovalSubmit.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public String projectClosureSoCApprovalSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ProjectClosureSoCApprovalSubmit.htm "+UserId);
		try {
			String closureId = req.getParameter("closureId");
			String action = req.getParameter("Action");
			
			ProjectClosure closure = service.getProjectClosureById(closureId);
			String statusCode = closure.getClosureStatusCode();
			
			ProjectClosureApprovalForwardDTO dto = new ProjectClosureApprovalForwardDTO();
//			dto.setClosureSoCId(Long.parseLong(closureSoCId));
			dto.setClosureId(closureId);
			dto.setAction(action);
			dto.setEmpId(EmpId);
			dto.setRemarks(req.getParameter("remarks"));
			dto.setLabcode(labcode);
			dto.setApproverLabCode(req.getParameter("LabCode"));
			dto.setApproverEmpId(req.getParameter("approverEmpId"));
			dto.setApprovalDate(req.getParameter("approvalDate"));
			
			long result = service.projectClosureSoCApprovalForward(dto);
			
			List<String> forwardstatus = Arrays.asList("SIN","SRG","SRA","SRP","SRD","SRC","SRV");
			List<String> approvestatus = Arrays.asList("SAP","SAD");
			
			if(action.equalsIgnoreCase("A")) {
				if(forwardstatus.contains(statusCode)) {
					if(result!=0) {
						redir.addAttribute("result","Project Closure SoC form forwarded Successfully");
					}else {
						redir.addAttribute("resultfail","Project Closure SoC form forward Unsuccessful");
					}
				}else if(approvestatus.contains(statusCode)) {
					if(result!=0) {
						redir.addAttribute("result","Project Closure SoC form Approved Successfully");
					}else {
						redir.addAttribute("resultfail","Project Closure SoC form Approve Unsuccessful");
					}
					return "redirect:/ProjectClosureApprovals.htm";
				}else {
					if(result!=0) {
						redir.addAttribute("result","Project Closure SoC form Recommended Successfully");
					}else {
						redir.addAttribute("resultfail","Project Closure SoC form Recommend Unsuccessful");
					}
					return "redirect:/ProjectClosureApprovals.htm";
				}
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if(result!=0) {
					redir.addAttribute("result",action.equalsIgnoreCase("R")?"Project Closure SoC form Returned Successfully":"Project Closure SoC form Disapproved Successfully");
				}else {
					redir.addAttribute("resultfail",action.equalsIgnoreCase("R")?"Project Closure SoC form Return Unsuccessful":"Project Closure SoC form Disapprove Unsuccessful");
				}
				return "redirect:/ProjectClosureApprovals.htm";
			}
			return "redirect:/ProjectClosureList.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureSoCDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="ProjectClosureApprovals.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String projectClosureApprovals(HttpServletRequest req,HttpSession ses) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ProjectClosureApprovals.htm "+Username);
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

			req.setAttribute("SoCPendingList", service.projectClosureSoCPendingList(EmpId, labcode));
			req.setAttribute("SoCApprovedList", service.projectClosureSoCApprovedList(EmpId,fromdate,todate));
			req.setAttribute("ACPPendingList", service.projectClosureACPPendingList(EmpId, labcode));
			req.setAttribute("ACPApprovedList", service.projectClosureACPApprovedList(EmpId,fromdate,todate));
			
			return "project/ProjectClosureApprovals";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ProjectClosureApprovals.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="ProjectClosureSoCDownload.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void projectClosureSoCDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectClosureSoCDownload.htm "+UserId);		
		try {
			String closureId = req.getParameter("closureId");
			if(closureId!=null) {
				ProjectClosure closure = service.getProjectClosureById(closureId);
				String projectId = closure.getProjectId()+"";
				req.setAttribute("ProjectClosureDetails", closure);
				req.setAttribute("ProjectDetails", service.getProjectMasterByProjectId(projectId));
				req.setAttribute("ProjectClosureSoCData", service.getProjectClosureSoCByProjectId(closureId));
				req.setAttribute("ProjectOriginalRevDetails", service.projectOriginalAndRevisionDetails(projectId));
				req.setAttribute("ProjectExpenditureDetails", service.projectExpenditureDetails(projectId));
				req.setAttribute("SoCApprovalEmpData", service.projectClosureApprovalDataByType(closureId,"SF","S"));
			}
			String filename="SoC";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/ProjectClosureSoCDownload.jsp").forward(req, customResponse);
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
    		logger.error(new Date() +" Inside ProjectClosureSoCDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}

	@RequestMapping(value = "ProjectClosureSoCTransStatus.htm" , method={RequestMethod.POST,RequestMethod.GET})
	public String projectClosureSoCTransStatus(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String Username = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectClosureSoCTransStatus.htm "+Username);
		try {
			String closureId = req.getParameter("closureId");
			req.setAttribute("TransactionList", service.projectClosureTransListByType(closureId, "S", "S")) ;
			req.setAttribute("TransFlag", "S");
			req.setAttribute("closureId", closureId);
			return "project/ProjectClosureTransStatus";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ProjectClosureSoCTransStatus.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="ProjectClosureTransactionDownload.htm")
	public void projectClosureTransactionDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectClosureTransactionDownload.htm "+UserId);		
		try {
			String closureId = req.getParameter("closureId");
			String TransFlag = req.getParameter("TransFlag");
			
//			if(TransFlag!=null && TransFlag.equalsIgnoreCase("S")) {
//				req.setAttribute("TransactionList", service.projectClosureTransListByType(projectId, "S", "S")) ;
//			}else if(TransFlag!=null && TransFlag.equalsIgnoreCase("A")) {
//				req.setAttribute("TransactionList", service.projectClosureTransListByType(projectId, "A", "A")) ;
//			}
			req.setAttribute("TransactionList", service.projectClosureTransListByType(closureId, TransFlag, TransFlag)) ;
			ProjectClosure closure = service.getProjectClosureById(closureId);
			String projectId = closure.getProjectId()+"";
			req.setAttribute("ProjectDetails", service.getProjectMasterByProjectId(projectId));
			String filename="Closure-Transaction";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/ProjectClosureTransactionDownload.jsp").forward(req, customResponse);
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
    		logger.error(new Date() +" Inside ProjectClosureTransactionDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	@RequestMapping(value = {"ProjectClosureSoCFileDownload.htm"}, method = { RequestMethod.POST, RequestMethod.GET })
	public void projectClosureSoCFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectClosureSoCFileDownload.htm "+UserId);
		try
		{
			String ftype=req.getParameter("filename");
			String closureId=req.getParameter("closureId");
			res.setContentType("Application/octet-stream");	
			 ProjectClosureSoC soc = service.getProjectClosureSoCByProjectId(closureId);
			File my_file=null;
			String file = ftype.equalsIgnoreCase("monitoringcommitteefile") ?soc.getMonitoringCommitteeAttach(): soc.getLessonsLearnt();
			my_file = new File(LabLogoPath+"Project-Closure\\SoC\\"+File.separator+file); 
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
				logger.error(new Date() +"Inside ProjectClosureSoCFileDownload.htm "+UserId,e);
		}
	}
	
	@RequestMapping(value="ProjectClosureSoCRevoke.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String projectClosureSoCRevoke(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ProjectClosureSoCRevoke.htm "+UserId);
		try {
			String closureId = req.getParameter("closureId");
		
			long count = service.projectClosureSoCRevoke(closureId, UserId, EmpId, labcode);
			
			if (count > 0) {
				redir.addAttribute("result", "Project Closure Approval form Revoked Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Project Closure Approval form Revoke Unsuccessful");	
			}	

			return "redirect:/ProjectClosureList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ProjectClosureSoCRevoke.htm "+UserId, e);
			return "static/Error";			
		}

	}
	
	@RequestMapping(value="ProjectClosureACPDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String projectClosureACPDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date()+ " Inside ProjectClosureACPDetails.htm "+UserId);
		try {
			String closureId = req.getParameter("closureId");
			String acpTabId = req.getParameter("acpTabId");
			String isApproval = req.getParameter("isApproval");
			String details = req.getParameter("details");
			
			if(closureId==null) {
				String fromapprovals = req.getParameter("closureACPApprovals");
				if(fromapprovals!=null) {
					String[] split = fromapprovals.split("/");
					closureId = split[0];
					if(isApproval==null) {
						isApproval = split[1];
					}
					if(acpTabId==null) {
						acpTabId = split[2];
					}
				}
				
			}
			
			
			if(closureId!=null) {
				ProjectClosure closure = service.getProjectClosureById(closureId);
				String projectId = closure.getProjectId()+"";
				ProjectMaster projectMasterDetails= service.getProjectMasterByProjectId(projectId);
				String projectCode = projectMasterDetails.getProjectCode();
				req.setAttribute("ProjectClosureDetails", closure);
				req.setAttribute("ProjectDetails", projectMasterDetails);
				req.setAttribute("ProjectOriginalRevDetails", service.projectOriginalAndRevisionDetails(projectId));
				req.setAttribute("ProjectExpenditureDetails", service.projectExpenditureDetails(projectId));
				req.setAttribute("ProjectClosureACPData", service.getProjectClosureACPByProjectId(closureId));
				req.setAttribute("ACPProjectsData", service.getProjectClosureACPProjectsByProjectId(closureId));
				req.setAttribute("ACPConsultanciesData", service.getProjectClosureACPConsultanciesByProjectId(closureId));
				req.setAttribute("ACPTrialResultsData", service.getProjectClosureACPTrialResultsByProjectId(closureId));
				req.setAttribute("ACPAchivementsData", service.getProjectClosureACPAchievementsByProjectId(closureId));
				
				Object[] PDData = carsservice.getEmpPDEmpId(projectId);
				req.setAttribute("PDData", PDData);
				req.setAttribute("GDDetails", service.getEmpGDDetails(PDData!=null?PDData[1].toString():"0"));
				req.setAttribute("ACPRemarksHistory", service.projectClosureRemarksHistoryByType(closureId,"AF","A"));
				req.setAttribute("ACPApprovalEmpData", service.projectClosureApprovalDataByType(closureId,"AF","A"));
				
				/*-------------------------------------------------------------------------------------------------- */
				List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
				
				final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectCode+"&rupess="+10000000;
		 		HttpHeaders headers = new HttpHeaders();
		 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		    	headers.set("labcode", labcode);
		 		String jsonResult=null;
				try {
					HttpEntity<String> entity = new HttpEntity<String>(headers);
					ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
					jsonResult=response.getBody();						
				}catch(Exception e) {
					req.setAttribute("errorMsg", "errorMsg");
				}
				ObjectMapper mapper = new ObjectMapper();
				mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
				mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
				List<ProjectFinancialDetails> projectDetails=null;
				if(jsonResult!=null) {
					try {
						projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
						financialDetails.add(projectDetails);
						req.setAttribute("financialDetails",projectDetails);
					} catch (JsonProcessingException e) {
						e.printStackTrace();
					}
				}
				
				req.setAttribute("financialDetails",financialDetails);
				List<String> Pmainlist = printservice.ProjectsubProjectIdList(projectId);
				req.setAttribute("projectidlist",Pmainlist);
				/*-------------------------------------------------------------------------------------------------- */
			}
			req.setAttribute("Director", carsservice.getLabDirectorData(labcode));
			req.setAttribute("AD", carsservice.getApprAuthorityDataByType(labcode, "AD"));
			req.setAttribute("GDDPandC", carsservice.getApprAuthorityDataByType(labcode, "DO-RTMD"));
			req.setAttribute("LAO", carsservice.getApprAuthorityDataByType(labcode, "Lab Accounts Officer"));
			req.setAttribute("EmpData", carsservice.getEmpDetailsByEmpId(EmpId));
			
			req.setAttribute("LabList", carsservice.getLabList(labcode));
			
			req.setAttribute("details", details);
			req.setAttribute("closureId", closureId);
			req.setAttribute("isApproval", isApproval);
			req.setAttribute("acpTabId", acpTabId!=null?acpTabId:"1");
			return "project/ProjectClosureACPDetails";
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureACPDetails.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="ProjectClosureACPDetailsSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String projectClosureACPDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart(name="monitoringCommitteeAttach", required = false) MultipartFile monitoringCommitteeAttach,
			@RequestPart(name="labCertificateAttach", required = false) MultipartFile labCertificateAttach) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date()+ " Inside ProjectClosureACPDetailsSubmit.htm "+UserId);	
		try {
			String closureId = req.getParameter("closureId");
			String details = req.getParameter("details");
			
			String action = req.getParameter("Action");
		
			ProjectClosureACPDTO dto = new ProjectClosureACPDTO();
			dto.setUserId(UserId);
			dto.setEmpId(EmpId);
			dto.setClosureId(Long.parseLong(closureId));
			dto.setDetails(details);
			dto.setACPAim(req.getParameter("acpAim"));
			dto.setACPObjectives(req.getParameter("acpObjectives"));
			dto.setFacilitiesCreated(req.getParameter("facilitiesCreated"));
			dto.setMonitoringCommittee(req.getParameter("monitoringCommittee"));
			dto.setExpndAsOn(req.getParameter("expndAsOn"));
			dto.setTotalExpnd(req.getParameter("totalExpnd"));
			dto.setTotalExpndFE(req.getParameter("totalExpndFE"));
			dto.setPrototyes(req.getParameter("noofprototypes"));
			dto.setTechReportNo(req.getParameter("techReportNo"));
			long result = service.projectClosureACPDetailsSubmit(dto, labCertificateAttach, monitoringCommitteeAttach);
			
			if (result!=0) {
				redir.addAttribute("result", "Closure Details "+action+"ed Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Closure Details "+action+" Unsuccessful");	
			}	
			
			redir.addAttribute("closureId", closureId);
			redir.addAttribute("details", details);
			redir.addAttribute("acpTabId", "1");
			
			return "redirect:/ProjectClosureACPDetails.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureACPDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="ProjectClosureACPProjectDetailsSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String projectClosureACPSubProjectDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date()+ " Inside ProjectClosureACPSubProjectDetailsSubmit.htm "+UserId);	
		try {
			String closureId = req.getParameter("closureId");
			String details = req.getParameter("details");
			
			String action = req.getParameter("Action");
		
			ProjectClosureACPDTO dto = new ProjectClosureACPDTO();
			dto.setUserId(UserId);
			dto.setEmpId(EmpId);
			dto.setClosureId(Long.parseLong(closureId));
			dto.setDetails(details);
			dto.setAcpProjectTypeFlag(req.getParameter("acpProjectTypeFlag"));
			dto.setACPProjectType(req.getParameterValues("acpProjectType"));
			dto.setACPProjectName(req.getParameterValues("acpProjectName"));
			dto.setACPProjectNo(req.getParameterValues("acpProjectNo"));
			dto.setProjectAgency(req.getParameterValues("projectAgency"));
			dto.setProjectCost(req.getParameterValues("projectCost"));
			dto.setProjectStatus(req.getParameterValues("projectStatus"));
			dto.setProjectAchivements(req.getParameterValues("projectAchivements"));
			
			long result = service.addProjectClosureProjectDetailsSubmit(dto);
			
			if (result!=0) {
				redir.addAttribute("result", "Closure Details "+action+"ed Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Closure Details "+action+" Unsuccessful");	
			}	
			
			redir.addAttribute("closureId", closureId);
			redir.addAttribute("details", details);
			redir.addAttribute("acpTabId", "1");
			
			return "redirect:/ProjectClosureACPDetails.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureACPSubProjectDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="ProjectClosureACPConsultancyDetailsSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String projectClosureACPConsultancyDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date()+ " Inside ProjectClosureACPConsultancyDetailsSubmit.htm "+UserId);	
		try {
			String closureId = req.getParameter("closureId");
			String details = req.getParameter("details");
			
			String action = req.getParameter("Action");
		
			ProjectClosureACPDTO dto = new ProjectClosureACPDTO();
			dto.setUserId(UserId);
			dto.setEmpId(EmpId);
			dto.setClosureId(Long.parseLong(closureId));
			dto.setDetails(details);
			dto.setConsultancyAim(req.getParameterValues("consultancyAim"));
			dto.setConsultancyAgency(req.getParameterValues("consultancyAgency"));
			dto.setConsultancyCost(req.getParameterValues("consultancyCost"));
			dto.setConsultancyDate(req.getParameterValues("consultancyDate"));
			
			long result = service.addProjectClosureConsultancyDetailsSubmit(dto);
			
			if (result!=0) {
				redir.addAttribute("result", "Closure Details "+action+"ed Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Closure Details "+action+" Unsuccessful");	
			}	
			
			redir.addAttribute("closureId", closureId);
			redir.addAttribute("details", details);
			redir.addAttribute("acpTabId", "1");
			
			return "redirect:/ProjectClosureACPDetails.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureACPConsultancyDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="ProjectClosureACPTrialResultsSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String projectClosureACPTrialResultsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart(name="attachment", required = false) MultipartFile[] attachment) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date()+ " Inside ProjectClosureACPTrialResultsSubmit.htm "+UserId);	
		try {
			String closureId = req.getParameter("closureId");
			String details = req.getParameter("details");
			
			String action = req.getParameter("Action");
		
			ProjectClosureACPDTO dto = new ProjectClosureACPDTO();
			dto.setUserId(UserId);
			dto.setEmpId(EmpId);
			dto.setClosureId(Long.parseLong(closureId));
			dto.setDetails(details);
			dto.setAttatchmentName(req.getParameterValues("attatchmentname"));
			dto.setTrialResults(req.getParameter("trialResults"));
			dto.setDescription(req.getParameterValues("description"));
			dto.setAttachment(attachment);
			
			service.projectClosureACPDetailsSubmit(dto, null, null);
			
			long result = service.projectClosureACPTrialResultsSubmit(dto);
			
			if (result!=0) {
				redir.addAttribute("result", "Closure Details "+action+"ed Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Closure Details "+action+" Unsuccessful");	
			}	
			
			redir.addAttribute("closureId", closureId);
			redir.addAttribute("details", details);
			redir.addAttribute("acpTabId", "1");
			
			return "redirect:/ProjectClosureACPDetails.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureACPTrialResultsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value = {"ProjectClosureACPTrialResultsFileDownload.htm"}, method = { RequestMethod.POST, RequestMethod.GET })
	public void projectClosureACPTrialResultsFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectClosureACPTrialResultsFileDownload.htm "+UserId);
		try
		{
			String attachmentfile=req.getParameter("attachmentfile");
			ProjectClosureACPTrialResults result = service.getProjectClosureACPTrialResultsById(attachmentfile);
			res.setContentType("Application/octet-stream");	
			
			File my_file=null;
			String file = result.getAttachment();
			my_file = new File(LabLogoPath+"Project-Closure\\ACP\\Trial-Results\\"+File.separator+file); 
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
				logger.error(new Date() +"Inside ProjectClosureACPTrialResultsFileDownload.htm "+UserId,e);
		}
	}
	
	@RequestMapping(value="ProjectClosureACPAchievementDetailsSubmit.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String projectClosureACPAchievementDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date()+ " Inside ProjectClosureACPAchievementDetailsSubmit.htm "+UserId);	
		try {
			String closureId = req.getParameter("closureId");
			String details = req.getParameter("details");
			
			String action = req.getParameter("Action");
		
			ProjectClosureACPDTO dto = new ProjectClosureACPDTO();
			dto.setUserId(UserId);
			dto.setEmpId(EmpId);
			dto.setClosureId(Long.parseLong(closureId));
			dto.setDetails(details);
			dto.setEnvisaged(req.getParameterValues("envisaged"));
			dto.setAchieved(req.getParameterValues("achieved"));
			dto.setRemarks(req.getParameterValues("remarks"));
			
			long result = service.projectClosureACPAchievementDetailsSubmit(dto);
			
			if (result!=0) {
				redir.addAttribute("result", "Closure Details "+action+"ed Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Closure Details "+action+" Unsuccessful");	
			}	
			
			redir.addAttribute("closureId", closureId);
			redir.addAttribute("details", details);
			redir.addAttribute("acpTabId", "1");
			
			return "redirect:/ProjectClosureACPDetails.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureACPAchievementDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value = {"ProjectClosureACPFileDownload.htm"}, method = { RequestMethod.POST, RequestMethod.GET })
	public void projectClosureACPFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectClosureACPFileDownload.htm "+UserId);
		try
		{
			String ftype=req.getParameter("filename");
			String closureId=req.getParameter("closureId");
			res.setContentType("Application/octet-stream");	
			ProjectClosureACP acp = service.getProjectClosureACPByProjectId(closureId);
			File my_file=null;
			String file = ftype.equalsIgnoreCase("monitoringcommitteefile") ?acp.getMonitoringCommitteeAttach(): acp.getCertificateFromLab();
			my_file = new File(LabLogoPath+"Project-Closure\\ACP\\"+File.separator+file); 
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
				logger.error(new Date() +"Inside ProjectClosureACPFileDownload.htm "+UserId,e);
		}
	}
	

	@RequestMapping(value="ProjectClosureACPApprovalSubmit.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public String projectClosureACPApprovalSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ProjectClosureACPApprovalSubmit.htm "+UserId);
		try {
			String closureId = req.getParameter("closureId");
			String action = req.getParameter("Action");
			
			ProjectClosure closure = service.getProjectClosureById(closureId);
			String statusCode = closure.getClosureStatusCode();
			
			ProjectClosureApprovalForwardDTO dto = new ProjectClosureApprovalForwardDTO();
			dto.setClosureId(closureId);
			dto.setAction(action);
			dto.setEmpId(EmpId);
			dto.setRemarks(req.getParameter("remarks"));
			dto.setLabcode(labcode);
			dto.setApproverLabCode(req.getParameter("LabCode"));
			dto.setApproverEmpId(req.getParameter("approverEmpId"));
			dto.setApprovalDate(req.getParameter("approvalDate"));
			
			long result = service.projectClosureACPApprovalForward(dto);
			
			List<String> forwardstatus = Arrays.asList("AIN","ARG","ARA","ARP","ARL","ARD","ARO","ARN","ARC","ARV");
			List<String> approvestatus = Arrays.asList("AAP","AAL","AAD","ARO");
			
			if(action.equalsIgnoreCase("A")) {
				if(forwardstatus.contains(statusCode)) {
					if(result!=0) {
						redir.addAttribute("result","Administrative Closure form forwarded Successfully");
					}else {
						redir.addAttribute("resultfail","Administrative Closure form forward Unsuccessful");
					}
				}else if(approvestatus.contains(statusCode)) {
					if(result!=0) {
						redir.addAttribute("result","Administrative Closure form Approved Successfully");
					}else {
						redir.addAttribute("resultfail","Administrative Closure form Approve Unsuccessful");
					}
					return "redirect:/ProjectClosureApprovals.htm";
				}else {
					if(result!=0) {
						redir.addAttribute("result","Administrative Closure form Recommended Successfully");
					}else {
						redir.addAttribute("resultfail","Administrative Closure form Recommend Unsuccessful");
					}
					return "redirect:/ProjectClosureApprovals.htm";
				}
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if(result!=0) {
					redir.addAttribute("result",action.equalsIgnoreCase("R")?"Administrative Closure form Returned Successfully":"Administrative Closure form Disapproved Successfully");
				}else {
					redir.addAttribute("resultfail",action.equalsIgnoreCase("R")?"Administrative Closure form Return Unsuccessful":"Administrative Closure form Disapprove Unsuccessful");
				}
				return "redirect:/ProjectClosureApprovals.htm";
			}
			return "redirect:/ProjectClosureList.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureACPApprovalSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="ProjectClosureACPDownload.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void projectClosureACPDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectClosureACPDownload.htm "+UserId);		
		try {
			String closureId = req.getParameter("closureId");
			if(closureId!=null) {
				ProjectClosure closure = service.getProjectClosureById(closureId);
				String projectId = closure.getProjectId()+"";
				ProjectMaster projectMasterDetails= service.getProjectMasterByProjectId(projectId);
				String projectCode = projectMasterDetails.getProjectCode();
				req.setAttribute("ProjectClosureDetails", closure);
				req.setAttribute("ProjectDetails", projectMasterDetails);
				req.setAttribute("ProjectOriginalRevDetails", service.projectOriginalAndRevisionDetails(projectId));
				req.setAttribute("ProjectExpenditureDetails", service.projectExpenditureDetails(projectId));
				req.setAttribute("ProjectClosureACPData", service.getProjectClosureACPByProjectId(closureId));
				req.setAttribute("ACPProjectsData", service.getProjectClosureACPProjectsByProjectId(closureId));
				req.setAttribute("ACPConsultanciesData", service.getProjectClosureACPConsultanciesByProjectId(closureId));
				req.setAttribute("ACPTrialResultsData", service.getProjectClosureACPTrialResultsByProjectId(closureId));
				req.setAttribute("ACPAchivementsData", service.getProjectClosureACPAchievementsByProjectId(closureId));
				
				req.setAttribute("ACPApprovalEmpData", service.projectClosureApprovalDataByType(closureId,"AF","A"));
				
				/*-------------------------------------------------------------------------------------------------- */
				List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
				
				final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectCode+"&rupess="+10000000;
		 		HttpHeaders headers = new HttpHeaders();
		 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		    	headers.set("labcode", labcode);
		 		String jsonResult=null;
				try {
					HttpEntity<String> entity = new HttpEntity<String>(headers);
					ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
					jsonResult=response.getBody();						
				}catch(Exception e) {
					req.setAttribute("errorMsg", "errorMsg");
				}
				ObjectMapper mapper = new ObjectMapper();
				mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
				mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
				List<ProjectFinancialDetails> projectDetails=null;
				if(jsonResult!=null) {
					try {
						projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
						financialDetails.add(projectDetails);
						req.setAttribute("financialDetails",projectDetails);
					} catch (JsonProcessingException e) {
						e.printStackTrace();
					}
				}
				
				req.setAttribute("financialDetails",financialDetails);
				List<String> Pmainlist = printservice.ProjectsubProjectIdList(projectId);
				req.setAttribute("projectidlist",Pmainlist);
				/*-------------------------------------------------------------------------------------------------- */
			}
			String filename="Administrative-Closure";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/ProjectClosureACPDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
			
			CharArrayWriterResponse customResponse1 = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/project/ProjectExpndStatusTable.jsp").forward(req, customResponse1);
			String html1 = customResponse1.getOutput();        
	        
	        HtmlConverter.convertToPdf(html1,new FileOutputStream(path+File.separator+filename+"1.pdf")); 
	        
	        PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
	        PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
	        PdfReader pdf2=new PdfReader(path+File.separator+filename+"1.pdf");
	        
	        PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	       	        
	        PdfDocument pdfDocument2 = new PdfDocument(pdf2);
	        PdfMerger merger = new PdfMerger(pdfDocument);
	        
	        merger.merge(pdfDocument2, 1, pdfDocument2.getNumberOfPages());
            
            pdfDocument2.close();
	        pdfDocument.close();
	        merger.close();
	        pdf2.close();
	        pdf1.close();	       
	        pdfw.close();
	    
	        res.setContentType("application/pdf");
	        res.setHeader("Content-disposition","inline;filename="+filename+".pdf");
	        File f=new File(path +File.separator+ "merged.pdf");
	         
	        
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
	       
	       
	        Path pathOfFile2= Paths.get( path+File.separator+filename+"1.pdf"); 
	        Files.delete(pathOfFile2);		
	        pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
	        Files.delete(pathOfFile2);	
	        pathOfFile2= Paths.get(path +File.separator+ "merged.pdf"); 
	        Files.delete(pathOfFile2);		

		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectClosureACPDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	

	@RequestMapping(value = "ProjectClosureACPTransStatus.htm" , method={RequestMethod.POST,RequestMethod.GET})
	public String projectClosureACPTransStatus(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String Username = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectClosureACPTransStatus.htm "+Username);
		try {
			String closureId = req.getParameter("closureId");
			req.setAttribute("TransactionList", service.projectClosureTransListByType(closureId, "A", "A")) ;
			req.setAttribute("TransFlag", "A");
			req.setAttribute("closureId", closureId);
			return "project/ProjectClosureTransStatus";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ProjectClosureACPTransStatus.htm "+Username, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="ProjectClosureSubmit.htm" , method={RequestMethod.POST})
	public String projectClosureSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String Username = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ProjectClosureSubmit.htm "+Username);
		try {
			String projectId = req.getParameter("projectId");
			String closureId = req.getParameter("closureId");
			String closureCategory = req.getParameter("closureCategory");
			
			System.out.println("closureId: "+closureId+"  projectId: "+projectId);
			ProjectClosure closure = closureId.equalsIgnoreCase("0") ? new ProjectClosure(): service.getProjectClosureById(closureId);
			closure.setProjectId(Long.parseLong(projectId));
			closure.setClosureCategory(closureCategory);
			closure.setApprovalFor(closureCategory!=null && closureCategory.equalsIgnoreCase("Completed Successfully")?"ACR":"SoC");
			closure.setClosureStatusCode(closure.getApprovalFor().equalsIgnoreCase("SoC")?"SIN":"AIN");
			closure.setClosureStatusCodeNext(closure.getApprovalFor().equalsIgnoreCase("SoC")?"SIN":"AIN");
			
			long result = 0L;
			if(closureId.equals("0")) {
				closure.setApprStatus("N");
				closure.setForwardedBy("0");
				closure.setCreatedBy(Username);
				closure.setCreatedDate(sdtf.format(new Date()));
				closure.setIsActive(1);
				
				result = service.addProjectClosure(closure, EmpId, labcode);
			}else {
				closure.setModifiedBy(Username);
				closure.setModifiedDate(sdtf.format(new Date()));
				
				result = service.editProjectClosure(closure);
			}
			
			if (result!=0) {
				redir.addAttribute("result", "Closure Category Details Submitted Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Closure Category Details Submit Unsuccessful");	
			}	
			
			return "redirect:/ProjectClosureList.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ProjectClosureSubmit.htm "+Username, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="ProjectClosureACPRevoke.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String projectClosureACPRevoke(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ProjectClosureACPRevoke.htm "+UserId);
		try {
			String closureId = req.getParameter("closureId");
		
			long count = service.projectClosureACPRevoke(closureId, UserId, EmpId ,labcode);
			
			if (count > 0) {
				redir.addAttribute("result", "Administrative Closure Approval form Revoked Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Administrative Closure Approval form Revoke Unsuccessful");	
			}	

			return "redirect:/ProjectClosureList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ProjectClosureSoCRevoke.htm "+UserId, e);
			return "static/Error";			
		}

	}
	
	@RequestMapping(value="ProjectClosureCheckList.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String ProjectClosureCheckList(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ProjectClosureCheckList.htm "+UserId);
		try {
			
			String closureId = req.getParameter("closureId");
			//System.out.println("closureId----"+closureId);
			String socTabId = req.getParameter("chlistTabId");
//			String isApproval = req.getParameter("isApproval");
//			
//			if(closureId==null) {
//				String fromapprovals = req.getParameter("closureSoCApprovals");
//				if(fromapprovals!=null) {
//					String[] split = fromapprovals.split("/");
//					closureId = split[0];
//					if(isApproval==null) {
//						isApproval = split[1];
//					}
//					if(socTabId==null) {
//						socTabId = split[2];
//					}
//				}
//				
//			}
//			
			if(closureId!=null) {
				ProjectClosure closure = service.getProjectClosureById(closureId);
				String projectId = closure.getProjectId()+"";
				req.setAttribute("ProjectClosureDetails", closure);
				req.setAttribute("ProjectDetails", service.getProjectMasterByProjectId(projectId));
				req.setAttribute("ProjectClosureCheckListData", service.getProjectClosureCheckListByProjectId(closureId));
				Object[] PDData = carsservice.getEmpPDEmpId(projectId);
				req.setAttribute("PDData", PDData);
				req.setAttribute("GDDetails", service.getEmpGDDetails(PDData!=null?PDData[1].toString():"0"));
				req.setAttribute("ProjectOriginalRevDetails", service.projectOriginalAndRevisionDetails(projectId));
				req.setAttribute("ProjectExpenditureDetails", service.projectExpenditureDetails(projectId));
				req.setAttribute("SoCRemarksHistory", service.projectClosureRemarksHistoryByType(closureId,"SF","S"));
				req.setAttribute("SoCApprovalEmpData", service.projectClosureApprovalDataByType(closureId,"SF","S"));
			}
//			req.setAttribute("Director", carsservice.getLabDirectorData(labcode));
//			req.setAttribute("AD", carsservice.getApprAuthorityDataByType(labcode, "AD"));
//			req.setAttribute("GDDPandC", carsservice.getApprAuthorityDataByType(labcode, "DO-RTMD"));
//			req.setAttribute("EmpData", carsservice.getEmpDetailsByEmpId(EmpId));
//			
//			req.setAttribute("LabList", carsservice.getLabList(labcode));
//			
			req.setAttribute("closureId", closureId);
//			req.setAttribute("isApproval", isApproval);
			req.setAttribute("chlistTabId", socTabId!=null?socTabId:"1");
			
			
			return "project/ProjectClosureCheckListAdd";
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ProjectClosureCheckList.htm "+UserId, e);
			return "static/Error";			
		}

	}
	

	
	
	
	@RequestMapping(value="ProjectClosureCheckListDetailsSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ProjectClosureCheckListDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart(name="QARMilestone", required = false) MultipartFile QARMilestoneAttach,
			@RequestPart(name="QARCostBreakup", required = false) MultipartFile QARCostBreakupAttach,
			@RequestPart(name="QARNCItems", required = false) MultipartFile QARNCItemsAttach,
	        @RequestPart(name="EquipProcuredAttach", required = false) MultipartFile EquipProcuredAttach,
	        @RequestPart(name="EquipProcuredBeforePDCAttach", required = false) MultipartFile EquipProcuredBeforePDCAttach,
	        @RequestPart(name="EquipBoughtOnChargeAttach",required = false) MultipartFile EquipBoughtOnChargeAttach,
	        @RequestPart(name="BudgetExpenditureAttach",required = false) MultipartFile BudgetExpenditureAttach,
	        @RequestPart(name="SPActualposition",required=false) MultipartFile SPActualpositionAttach,
	        @RequestPart(name="SPGeneralSpecific",required=false) MultipartFile SPGeneralSpecificAttach,
	        @RequestPart(name="CRAttach",required=false) MultipartFile CRAttach
			) throws Exception{
		
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		
		try {
			String closureId = req.getParameter("closureId");
			String action = req.getParameter("Action");
			//System.out.println("action---"+action);
			
			ProjectClosureCheckList clist = (action!=null && action.equalsIgnoreCase("Add"))?new ProjectClosureCheckList() : service.getProjectClosureCheckListByProjectId(closureId);
			
			ProjectClosure projectClosure = service.getProjectClosureById(closureId);
			clist.setProjectClosure(projectClosure);
			//clist.setCl
			clist.setQARHQrsSentDate(sdf.format(rdf.parse(req.getParameter("QARHQrsSentDate"))));
			clist.setQARSentDate(sdf.format(rdf.parse(req.getParameter("QARSentDate"))));
			clist.setQARObjective(req.getParameter("QARObjective"));
			//clist.setQARMilestone(req.getParameter("QARMilestone"));
			clist.setQARPDCDate(sdf.format(rdf.parse(req.getParameter("QARPDCDate"))));
			
			clist.setQARProposedCost(Double.parseDouble(req.getParameter("QARProposedCost")));
			//clist.setQARCostBreakup(req.getParameter("QARCostBreakup"));
			clist.setSCRequested(sdf.format(rdf.parse(req.getParameter("SCRequested"))));
			clist.setSCGranted(sdf.format(rdf.parse(req.getParameter("SCGranted"))));
			
			String SCRevisionCost=req.getParameter("SCRevisionCost");
			clist.setSCRevisionCost(Double.parseDouble(SCRevisionCost!=null && !SCRevisionCost.isEmpty()? SCRevisionCost:"0"));
			clist.setSCReason(req.getParameter("SCReason"));
			clist.setPDCRequested(sdf.format(rdf.parse(req.getParameter("PDCRequested"))));
			clist.setPDCGranted(sdf.format(rdf.parse(req.getParameter("PDCGranted"))));
			
			String PDCRevised=req.getParameter("PDCRevised");
			clist.setPDCRevised(Double.parseDouble(PDCRevised!=null && !PDCRevised.isEmpty()? PDCRevised:"0"));
			clist.setPDCReason(req.getParameter("PDCReason"));
			//System.out.println("PRMaintained--"+req.getParameter("PRMaintained"));
			clist.setPRMaintained(req.getParameter("PRMaintained")!=null?"Yes":"No");
			
			clist.setPRSanctioned(req.getParameter("PRSanctioned")!=null?"Yes":"No");
			clist.setPECVerified(req.getParameter("PECVerified")!=null?"Yes":"No");
			//System.out.println("SRMaintained--"+req.getParameter("SRMaintained"));
			clist.setSRMaintained(req.getParameter("SRMaintained")!=null?"Yes":"No");
			
			clist.setCSProcedure(req.getParameter("CSProcedure"));
			clist.setCSDrawn(req.getParameter("CSDrawn")!=null?"Yes":"No");
			clist.setCSReason(req.getParameter("CSReason"));
			
			String CSamountdebited=req.getParameter("CSamountdebited");
			clist.setCSamountdebited(CSamountdebited!=null ? "Yes":"No");
			clist.setNCSProcedure(req.getParameter("NCSProcedure"));
			clist.setNCSDrawn(req.getParameter("NCSDrawn")!=null?"Yes":"No");
			clist.setNCSReason(req.getParameter("NCSReason"));
			
			String NCSamountdebited=req.getParameter("NCSamountdebited");
			clist.setNCSamountdebited(NCSamountdebited!=null ? "Yes":"No");
			clist.setNCSDistributed(req.getParameter("NCSDistributed")!=null?"Yes":"No");
			clist.setNCSIncorporated(req.getParameter("NCSIncorporated")!=null?"Yes":"No");
			
			clist.setEquipPurchased(req.getParameter("EquipPurchased")!=null?"Yes":"No");
			clist.setEquipReason(req.getParameter("EquipReason"));
			clist.setEquipProcuredBeforePDC(req.getParameter("EquipProcuredBeforePDC")!=null?"Yes":"No");
			clist.setEquipBoughtOnCharge(req.getParameter("EquipBoughtOnCharge")!=null?"Yes":"No");
			clist.setBudgetAllocation(req.getParameter("BudgetAllocation")!=null?"Yes":"No");
			clist.setBudgetMechanism(req.getParameter("BudgetMechanism"));
			
			clist.setBudgetFinancialProgress(req.getParameter("BudgetFinancialProgress")!=null?"Yes":"No");
			clist.setBudgetexpenditureReports(req.getParameter("BudgetexpenditureReports")!=null?"Yes":"No");
			clist.setBudgetexpenditureIncurred(req.getParameter("BudgetexpenditureIncurred")!=null?"Yes":"No");
			clist.setLogBookMaintained(req.getParameter("LogBookMaintained")!=null?"Yes":"No");
			clist.setJobCardsMaintained(req.getParameter("JobCardsMaintained")!=null?"Yes":"No");
			clist.setSPdemand(req.getParameter("SPdemand")!=null?"Yes":"No");
			
			clist.setCWIncluded(req.getParameter("CWIncluded")!=null?"Yes":"No");
			clist.setCWAdminApp(req.getParameter("CWAdminApp")!=null?"Yes":"No");
			clist.setCWMinorWorks(req.getParameter("CWMinorWorks")!=null?"Yes":"No");
			clist.setCWRevenueWorks(req.getParameter("CWRevenueWorks")!=null?"Yes":"No");
			clist.setCWDeviation(req.getParameter("CWDeviation")!=null?"Yes":"No");
			clist.setCWExpenditure(req.getParameter("CWExpenditure")!=null?"Yes":"No");
			clist.setNoOfVehicleSanctioned(req.getParameter("NoOfVehicleSanctioned"));
			clist.setVehicleAvgRun(req.getParameter("VehicleAvgRun"));
			clist.setVehicleAvgFuel(req.getParameter("VehicleAvgFuel"));
			clist.setProjectClosedDate(sdf.format(rdf.parse(req.getParameter("ProjectClosedDate"))));
			clist.setReportDate(sdf.format(rdf.parse(req.getParameter("ReportDate"))));
			clist.setDelayReason(req.getParameter("ProjectDelayReason"));
			clist.setCRObjective(req.getParameter("CRObjective")!=null?"Yes":"No");
			clist.setCRspinoff(req.getParameter("CRspinoff")!=null?"Yes":"No");
			clist.setCRReason(req.getParameter("PDCNotMeetReason")!=null?"Yes":"No");
			clist.setCRcostoverin(req.getParameter("CRcostoverin"));
			clist.setNonConsumableItemsReturned(req.getParameter("NonConsumableItemsReturned")!=null?"Yes":"No");
			clist.setConsumableItemsReturned(req.getParameter("ConsumableItemsReturned")!=null?"Yes":"No");
			clist.setRemarks(req.getParameter("OverAllReason"));
			
			

			long result=0l;
			if(action!=null && action.equalsIgnoreCase("Add")) {
				
				clist.setCreatedBy(UserId);
				clist.setCreatedDate(sdtf.format(new Date()));
				clist.setIsActive(1);
				
				result = service.addProjectClosureCheckList(clist,EmpId,QARMilestoneAttach,QARCostBreakupAttach,QARNCItemsAttach,EquipProcuredAttach,EquipProcuredBeforePDCAttach,EquipBoughtOnChargeAttach,BudgetExpenditureAttach,SPActualpositionAttach,SPGeneralSpecificAttach,CRAttach);
				
			}else if(action!=null && action.equalsIgnoreCase("Edit")) {
				clist.setModifiedBy(UserId);
				clist.setModifiedDate(sdtf.format(new Date()));
				
				result = service.editProjectClosureCheckList(clist,EmpId,QARMilestoneAttach,QARCostBreakupAttach,QARNCItemsAttach,EquipProcuredAttach,EquipProcuredBeforePDCAttach,EquipBoughtOnChargeAttach,BudgetExpenditureAttach,SPActualpositionAttach,SPGeneralSpecificAttach,CRAttach);
				
				if (result > 0) {
					redir.addAttribute("result", "Closure CheckList Details Updated Successfully");
				} else {
					redir.addAttribute("resultfail", "Closure CheckList Details Update Unsuccessful");
				}
				
				redir.addAttribute("closureId", closureId);
				redir.addAttribute("chlistTabId","1");
				return "redirect:/ProjectClosureCheckList.htm";
			}
			
			if (result > 0) {
				redir.addAttribute("result", "Closure CheckList Details Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Closure CheckList Details Add Unsuccessful");
			}
			redir.addAttribute("closureId", closureId);
			redir.addAttribute("chlistTabId","1");
			
			return "redirect:/ProjectClosureCheckList.htm";
			
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureCheckListDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value = {"ProjectClosureChecklistFileDownload.htm"})
	public void ProjectClosureChecklistFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectClosureChecklistFileDownload.htm "+UserId);
		try
		{
			String ftype=req.getParameter("filename");
			String closureId=req.getParameter("closureId");
			res.setContentType("Application/octet-stream");	
			ProjectClosureCheckList clist= service.getProjectClosureCheckListByProjectId(closureId);
			File my_file=null;
			String file = ftype.equalsIgnoreCase("QARMilestonefile") ? clist.getQARMilestone():ftype.equalsIgnoreCase("QARCostBreakupfile")? clist.getQARCostBreakup(): ftype.equalsIgnoreCase("QARNCItemsfile")? clist.getQARNCItems():ftype.equalsIgnoreCase("EquipProcuredfile")? clist.getEquipProcured(): ftype.equalsIgnoreCase("EquipProcuredBeforePDCfile")? clist.getEquipProcuredBeforePDCAttach(): ftype.equalsIgnoreCase("EquipBoughtOnChargefile")? clist.getEquipBoughtOnChargeAttach() : ftype.equalsIgnoreCase("BudgetExpenditurefile")? clist.getBudgetExpenditureAttach(): ftype.equalsIgnoreCase("SPActualpositionfile")? clist.getSPActualpositionAttach(): ftype.equalsIgnoreCase("SPGeneralSpecificfile")? clist.getSPGeneralSpecificAttach(): ftype.equalsIgnoreCase("CRAttachfile")? clist.getCRAttach():"";
			my_file = new File(LabLogoPath+"Project-Closure\\Check-List\\"+File.separator+file); 
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
				logger.error(new Date() +"Inside ProjectClosureChecklistFileDownload.htm "+UserId,e);
		}
	}
	
	
	@RequestMapping(value="ProjectClosureCheckListDownload.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void ProjectClosureCheckListDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectClosureCheckListDownload.htm "+UserId);		
		try {
			String closureId = req.getParameter("closureId");
			
			if(closureId!=null) {
				req.setAttribute("ProjectClosureCheckListData", service.getProjectClosureCheckListByProjectId(closureId));
				
				req.setAttribute("closureId", closureId);
				
				ProjectClosure closure = service.getProjectClosureById(closureId);
				String projectId = closure.getProjectId()+"";
				System.out.println("projectId---"+projectId);
				req.setAttribute("ProjectClosureDetails", closure);
				req.setAttribute("ProjectDetails", service.getProjectMasterByProjectId(projectId));
				req.setAttribute("projectId", projectId);
				
				//req.setAttribute("ProjectClosureSoCData", service.getProjectClosureSoCByProjectId(closureId));
				//req.setAttribute("ProjectOriginalRevDetails", service.projectOriginalAndRevisionDetails(projectId));
				//req.setAttribute("ProjectExpenditureDetails", service.projectExpenditureDetails(projectId));
				//req.setAttribute("SoCApprovalEmpData", service.projectClosureApprovalDataByType(closureId,"SF","S"));
			}
			String filename="Check-List";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/ProjectClosureCheckListDownload.jsp").forward(req, customResponse);
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
    		logger.error(new Date() +" Inside ProjectClosureCheckListDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	
	@RequestMapping(value = "ProjectDetailsAllotExp.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void ProjectDetailsAllotExp(HttpServletRequest req,HttpServletResponse resp,HttpSession ses,RedirectAttributes redir)throws Exception {
		String Username = (String) ses.getAttribute("Username");
		//String Client_name = (ses.getAttribute("client_name")).toString();
		String labcode = (String) ses.getAttribute("labcode");
		System.out.println("labcode---"+labcode);
	    logger.info(new Date() + "Inside ProjectDetailsAllotExp.htm " + Username);
		try {
		String ProjectIdsel=req.getParameter("ProjectIdSel");
	    req.setAttribute("LabCode", labcode);
		 //String ProjectCode=null;
		if(ProjectIdsel!=null) {
		 long ProjectId=0;
		 String[] prjArr=ProjectIdsel.split("#");
			ProjectId=Integer.parseInt(prjArr[0]);
			//ProjectCode="PMS";
		 String Amount=(String)req.getParameter("Amount");
		 int InRupeeValue=0;
		 if (Amount.equalsIgnoreCase("R")) {
			 InRupeeValue = 1;
		 } else if (Amount.equalsIgnoreCase("L")) {
			 InRupeeValue = 100000;
		 } else if (Amount.equalsIgnoreCase("C")) {
			 InRupeeValue = 10000000;
	}
			
		 
		 final String localUri2=uri+"/pfms_serv/GetBudgetDetails.htm?projectId="+ProjectId+"&inRuppes="+100000;
			HttpHeaders headers = new HttpHeaders();
			headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
	 		String jsonResult2=null;
			try {
				HttpEntity<String> entity = new HttpEntity<String>(headers);
				ResponseEntity<String> response=restTemplate.exchange(localUri2, HttpMethod.GET, entity, String.class);
				jsonResult2=response.getBody();						
			}catch(Exception e) {
				req.setAttribute("errorMsg", "errorMsg");
			}
			ObjectMapper mapper2 = new ObjectMapper();
			mapper2.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
			mapper2.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
			List<Object[]> ProjectAllotAndExpeList=null;
			//System.out.println("jsonResult2"+jsonResult2);
			if(jsonResult2!=null) {
				try {
					ProjectAllotAndExpeList = mapper2.readValue(jsonResult2, new TypeReference<List<Object[]>>(){});
					
				} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}
		 
			final String localUri3=uri+"/pfms_serv/GetProjectDetails.htm?projectId="+ProjectId+"&inRuppes="+100000;
			HttpHeaders headers1 = new HttpHeaders();
			headers1.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
	 		String jsonResult3=null;
			try {
				HttpEntity<String> entity = new HttpEntity<String>(headers);
				ResponseEntity<String> response=restTemplate.exchange(localUri3, HttpMethod.GET, entity, String.class);
				jsonResult3=response.getBody();						
			}catch(Exception e) {
				req.setAttribute("errorMsg", "errorMsg");
			}
			ObjectMapper mapper3 = new ObjectMapper();
			mapper3.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
			mapper3.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
			List<Object[]> ProjectDetails=null;
			//System.out.println("jsonResult2"+jsonResult2);
			if(jsonResult3!=null) {
				try {
					ProjectDetails = mapper2.readValue(jsonResult3, new TypeReference<List<Object[]>>(){});
					
				} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}
			
			
		 
//			List<String> GetPdc=(List<String>)reportService.GetPdc(ProjectId);
//			String AllPdc="";
//			if (GetPdc != null) {
//				for (String pdc : GetPdc) {
//					AllPdc = AllPdc + ", " + pdc;
//				}
//			}
			
			//List<Object[]> ProjectAllotAndExpeList=BudgetDetails;
			
			Map<String, Map<String, String>> AllotExpListDetailList = new TreeMap<String, Map<String, String>>();
			
			String Year=null;
			String AllotmentCost=null;
			String RevOrCap = null;
			String ExpAginestAllotment = null;
			String ExpAginestNonAllotment = null;
			String BudgetHeadCode = null;
			
			
			/*initializing variables for calculating total allotment of all years*/
			BigDecimal TotalRevAlotment = BigDecimal.ZERO;
			BigDecimal TotalCapAlotment = BigDecimal.ZERO;
			BigDecimal TotalBelAlotment = BigDecimal.ZERO;
			BigDecimal TotalIafAlotment = BigDecimal.ZERO;
			BigDecimal TotalRdrAlotment = BigDecimal.ZERO;
			BigDecimal TotalAtvAlotment = BigDecimal.ZERO;
			BigDecimal TotalNavAlotment = BigDecimal.ZERO;
			BigDecimal TotalAdAlotment = BigDecimal.ZERO;
			BigDecimal TotalArmAlotment = BigDecimal.ZERO;
			BigDecimal TotalIsrAlotment = BigDecimal.ZERO;
			

			/*initializing variables for calculating total allotment expenditure of all years*/
			BigDecimal TotalRevAllotment = BigDecimal.ZERO;
		    BigDecimal TotalCapAllotment = BigDecimal.ZERO;
			BigDecimal TotalBelAllotment = BigDecimal.ZERO;
			BigDecimal TotalIafAllotment = BigDecimal.ZERO;
			BigDecimal TotalRdrAllotment = BigDecimal.ZERO;
			BigDecimal TotalAtvAllotment = BigDecimal.ZERO;
			BigDecimal TotalNavAllotment = BigDecimal.ZERO;
			BigDecimal TotalAdAllotment = BigDecimal.ZERO;
			BigDecimal TotalArmAllotment = BigDecimal.ZERO;
			BigDecimal TotalIsrAllotment = BigDecimal.ZERO;
			
			/*initializing variables for total non allotment expenditure of all years*/
			BigDecimal TotalRevNonAllotment = BigDecimal.ZERO;
			BigDecimal TotalCapNonAllotment = BigDecimal.ZERO;
			BigDecimal TotalBelNonAllotment = BigDecimal.ZERO;
			BigDecimal TotalIafNonAllotment = BigDecimal.ZERO;
			BigDecimal TotalRdrNonAllotment = BigDecimal.ZERO;
			BigDecimal TotalAtvNonAllotment = BigDecimal.ZERO;
			BigDecimal TotalNavNonAllotment = BigDecimal.ZERO;
			BigDecimal TotalAdNonAllotment = BigDecimal.ZERO;
			BigDecimal TotalArmNonAllotment = BigDecimal.ZERO;
			BigDecimal TotalIsrNonAllotment = BigDecimal.ZERO;
			
			Map<String, BigDecimal> AllotmentMap = new HashMap<String, BigDecimal>();
			
			if (ProjectAllotAndExpeList != null) {
				for (Object[] obj : ProjectAllotAndExpeList) {
					Year = "";
					AllotmentCost = "0.0";
					ExpAginestAllotment = "0.0";
					ExpAginestNonAllotment = "0.0";
					
					if (obj[0] != null)
						Year = obj[0].toString();
					if (obj[1] != null)
						AllotmentCost = obj[1].toString();
					if (obj[2] != null)
						RevOrCap = obj[2].toString();
					if (obj[3] != null)
						ExpAginestAllotment = obj[3].toString();
					if (obj[4] != null)
						ExpAginestNonAllotment = obj[4].toString();
					if (obj[5] != null)
						BudgetHeadCode = obj[5].toString();
					
				    int size = AllotExpListDetailList.size();
				    
				    Map<String, String> innerMap = AllotExpListDetailList.get(Year);
				    if (innerMap == null) {
						innerMap = new HashMap<String, String>();
					}
				    if ("1".equals(RevOrCap)) {
						innerMap.put("REV_allotmentCost", AllotmentCost);
						innerMap.put("REV_expAginestAllotment", ExpAginestAllotment);
						innerMap.put("REV_expAginestNonAllotment", ExpAginestNonAllotment);

						TotalRevAllotment = TotalRevAllotment.add(new BigDecimal(ExpAginestAllotment));
						TotalRevNonAllotment = TotalRevNonAllotment.add(new BigDecimal(ExpAginestNonAllotment));
						TotalRevAlotment = TotalRevAlotment.add(new BigDecimal(AllotmentCost));
					
					
					} else if ("2".equals(RevOrCap)) {
						innerMap.put("CAP_allotmentCost", AllotmentCost);
						innerMap.put("CAP_expAginestAllotment", ExpAginestAllotment);
						innerMap.put("CAP_expAginestNonAllotment", ExpAginestNonAllotment);

						TotalCapAllotment = TotalCapAllotment.add(new BigDecimal(ExpAginestAllotment));
						TotalCapNonAllotment = TotalCapNonAllotment.add(new BigDecimal(ExpAginestNonAllotment));
						TotalCapAlotment = TotalCapAlotment.add(new BigDecimal(AllotmentCost));
					
					
					} else if ("8".equals(RevOrCap)) {
						innerMap.put("BEL_allotmentCost", AllotmentCost);
						innerMap.put("BEL_expAginestAllotment", ExpAginestAllotment);
						innerMap.put("BEL_expAginestNonAllotment", ExpAginestNonAllotment);

						TotalBelAllotment = TotalBelAllotment.add(new BigDecimal(ExpAginestAllotment));
						TotalBelNonAllotment = TotalBelNonAllotment.add(new BigDecimal(ExpAginestNonAllotment));
						TotalBelAlotment = TotalBelAlotment.add(new BigDecimal(AllotmentCost));
					
					} else if ("9".equals(RevOrCap)) {
						innerMap.put("IAF_allotmentCost", AllotmentCost);
						innerMap.put("IAF_expAginestAllotment", ExpAginestAllotment);
						innerMap.put("IAF_expAginestNonAllotment", ExpAginestNonAllotment);

						TotalIafAllotment = TotalIafAllotment.add(new BigDecimal(ExpAginestAllotment));
						TotalIafNonAllotment = TotalIafNonAllotment.add(new BigDecimal(ExpAginestNonAllotment));
						TotalIafAlotment = TotalIafAlotment.add(new BigDecimal(AllotmentCost));
					
					
					} else if ("10".equals(RevOrCap)) {
						innerMap.put("RDR_allotmentCost", AllotmentCost);
						innerMap.put("RDR_expAginestAllotment", ExpAginestAllotment);
						innerMap.put("RDR_expAginestNonAllotment", ExpAginestNonAllotment);

						TotalRdrAllotment = TotalRdrAllotment.add(new BigDecimal(ExpAginestAllotment));
					    TotalRdrNonAllotment = TotalRdrNonAllotment.add(new BigDecimal(ExpAginestNonAllotment));
						TotalRdrAlotment = TotalRdrAlotment.add(new BigDecimal(AllotmentCost));
						
	                } else if ("11".equals(RevOrCap)) {
						
						innerMap.put("ATV_allotmentCost", AllotmentCost);
						innerMap.put("ATV_expAginestAllotment", ExpAginestAllotment);
						innerMap.put("ATV_expAginestNonAllotment", ExpAginestNonAllotment);
						
						TotalAtvAllotment = TotalAtvAllotment.add(new BigDecimal(ExpAginestAllotment));
						TotalAtvNonAllotment = TotalAtvNonAllotment.add(new BigDecimal(ExpAginestNonAllotment));
						TotalAtvAlotment = TotalAtvAlotment.add(new BigDecimal(AllotmentCost));

					}else if ("12".equals(RevOrCap)) {
						
						innerMap.put("NAV_allotmentCost", AllotmentCost);
						innerMap.put("NAV_expAginestAllotment", ExpAginestAllotment);
						innerMap.put("NAV_expAginestNonAllotment", ExpAginestNonAllotment);
						
						TotalNavAllotment = TotalNavAllotment.add(new BigDecimal(ExpAginestAllotment));
						TotalNavNonAllotment = TotalNavNonAllotment.add(new BigDecimal(ExpAginestNonAllotment));
						TotalNavAlotment = TotalNavAlotment.add(new BigDecimal(AllotmentCost));

	               }else if ("13".equals(RevOrCap)) {
						
						innerMap.put("AD_allotmentCost", AllotmentCost);
						innerMap.put("AD_expAginestAllotment", ExpAginestAllotment);
						innerMap.put("AD_expAginestNonAllotment", ExpAginestNonAllotment);
						
						TotalAdAllotment = TotalAdAllotment.add(new BigDecimal(ExpAginestAllotment));
						TotalAdNonAllotment = TotalAdNonAllotment.add(new BigDecimal(ExpAginestNonAllotment));
						TotalAdAlotment = TotalAdAlotment.add(new BigDecimal(AllotmentCost));

	               }else if ("14".equals(RevOrCap)) {
						
						innerMap.put("ARM_allotmentCost", AllotmentCost);
						innerMap.put("ARM_expAginestAllotment", ExpAginestAllotment);
						innerMap.put("ARM_expAginestNonAllotment", ExpAginestNonAllotment);
						
						TotalArmAllotment = TotalArmAllotment.add(new BigDecimal(ExpAginestAllotment));
						TotalArmNonAllotment = TotalArmNonAllotment.add(new BigDecimal(ExpAginestNonAllotment));
						TotalArmAlotment = TotalArmAlotment.add(new BigDecimal(AllotmentCost));

	               }else if ("15".equals(RevOrCap)) {
						
						innerMap.put("ISR_allotmentCost", AllotmentCost);
						innerMap.put("ISR_expAginestAllotment", ExpAginestAllotment);
						innerMap.put("ISR_expAginestNonAllotment", ExpAginestNonAllotment);
						
						TotalIsrAllotment = TotalIsrAllotment.add(new BigDecimal(ExpAginestAllotment));
						TotalIsrNonAllotment = TotalIsrNonAllotment.add(new BigDecimal(ExpAginestNonAllotment));
						TotalIsrAlotment = TotalIsrAlotment.add(new BigDecimal(AllotmentCost));

					} 
					
					
					AllotExpListDetailList.put(Year, innerMap);
				}
			}
			AllotmentMap.put("totalRevNonAllotment", TotalRevNonAllotment);
			AllotmentMap.put("totalCapNonAllotment", TotalCapNonAllotment);
			AllotmentMap.put("totalBelNonAllotment", TotalBelNonAllotment);
			AllotmentMap.put("totalIafNonAllotment", TotalIafNonAllotment);
			AllotmentMap.put("totalRdrNonAllotment", TotalRdrNonAllotment);
			AllotmentMap.put("totalAtvNonAllotment", TotalAtvNonAllotment);
			AllotmentMap.put("totalNavNonAllotment", TotalNavNonAllotment);
			AllotmentMap.put("totalAdNonAllotment", TotalAdNonAllotment);
			AllotmentMap.put("totalArmNonAllotment", TotalArmNonAllotment);
			AllotmentMap.put("totalIsrNonAllotment", TotalIsrNonAllotment);
			
			AllotmentMap.put("totalRevAllotment", TotalRevAllotment);
			AllotmentMap.put("totalCapAllotment", TotalCapAllotment);
			AllotmentMap.put("totalBelAllotment", TotalBelAllotment);
			AllotmentMap.put("totalIafAllotment", TotalIafAllotment);
			AllotmentMap.put("totalRdrAllotment", TotalRdrAllotment);
			AllotmentMap.put("totalAtvAllotment", TotalAtvAllotment);
			AllotmentMap.put("totalNavAllotment", TotalNavAllotment);
			AllotmentMap.put("totalAdAllotment", TotalAdAllotment);
			AllotmentMap.put("totalArmAllotment", TotalArmAllotment);
			AllotmentMap.put("totalIsrAllotment", TotalIsrAllotment);
			
			
			AllotmentMap.put("totalRevAlotment", TotalRevAlotment);
			AllotmentMap.put("totalCapAlotment", TotalCapAlotment);
			AllotmentMap.put("totalBelAlotment", TotalBelAlotment);
			AllotmentMap.put("totalIafAlotment", TotalIafAlotment);
			AllotmentMap.put("totalRdrAlotment", TotalRdrAlotment);
			AllotmentMap.put("totalAtvAlotment", TotalAtvAlotment);
			AllotmentMap.put("totalNavAlotment", TotalNavAlotment);
			AllotmentMap.put("totalAdAlotment", TotalAdAlotment);
			AllotmentMap.put("totalArmAlotment", TotalArmAlotment);
			AllotmentMap.put("totalIsrAlotment", TotalIsrAlotment);
			
			
			AllotmentMap.put("totalRevenue", TotalRevAllotment.add(TotalRevNonAllotment));
			AllotmentMap.put("totalCapital", TotalCapAllotment.add(TotalCapNonAllotment));
			AllotmentMap.put("totalBel", TotalBelAllotment.add(TotalBelNonAllotment));
			AllotmentMap.put("totalIaf", TotalIafAllotment.add(TotalIafNonAllotment));
			AllotmentMap.put("totalRdr", TotalRdrAllotment.add(TotalRdrNonAllotment));
			AllotmentMap.put("totalAtv", TotalAtvAllotment.add(TotalAtvNonAllotment));
			AllotmentMap.put("totalNav", TotalNavAllotment.add(TotalNavNonAllotment));
			AllotmentMap.put("totalAd", TotalAdAllotment.add(TotalAdNonAllotment));
			AllotmentMap.put("totalArm", TotalArmAllotment.add(TotalArmNonAllotment));
			AllotmentMap.put("totalIsr", TotalIsrAllotment.add(TotalIsrNonAllotment));
			
			req.setAttribute("ProjectDetails", ProjectDetails);
			
			req.setAttribute("AllotExpListDetailList", AllotExpListDetailList);
			req.setAttribute("AllotmentMap", AllotmentMap);
			req.setAttribute("GetPdc", "");
			req.setAttribute("Amount", Amount);
			req.setAttribute("ProjectId", ProjectId);
			req.setAttribute("BudgetHeadCode", BudgetHeadCode);
		}
			    String filename="ProjectSanctionDetailsPrint";
				String path=req.getServletContext().getRealPath("/view/temp");
		        CharArrayWriterResponse customResponse = new CharArrayWriterResponse(resp);
				req.getRequestDispatcher("/view/print/projectDetailsWithAllotExpen.jsp").forward(req, customResponse);
				String html = customResponse.getOutput();        
		        HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf")) ; 
		        resp.setContentType("application/pdf");
		        resp.setHeader("Content-disposition","inline;filename="+filename+".pdf");
		        File f=new File(path +File.separator+ filename+".pdf");
		        FileInputStream fis = new FileInputStream(f);
		        DataOutputStream os = new DataOutputStream(resp.getOutputStream());
		        resp.setHeader("Content-Length",String.valueOf(f.length()));
		        byte[] buffer = new byte[1024];
		        int len = 0;
		        while ((len = fis.read(buffer)) >= 0) {
		            os.write(buffer, 0, len);
		        } 
		        os.close();
		        fis.close();
		        Path pathOfFile= Paths.get( path+File.separator+filename+".pdf"); 
		        Files.delete(pathOfFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	@RequestMapping(value = "ProjectExpenditureReportPrint.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ProjectExpenditureReportPrint(HttpServletRequest req,HttpServletResponse resp,HttpSession ses) throws Exception {
		String UserName=(String)ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		String ProjectIdDetails=req.getParameter("ProjectIdSel");
		String BudgetHeadIdSel=req.getParameter("BudgetHeadIdSel");
		String ItemTypeSel=req.getParameter("ItemTypeSel");
		String FromDate=req.getParameter("FromDate");
		String ToDate=req.getParameter("toDate");
		String Action=(String)req.getParameter("action");
		int ProjectId=0;
		String ProjectCode=null;
		String itemTypeCode = "A";
		String itemTypeDes =null;
		int BudgetHeadIdSel1=0;
		String BudgetHeadIdSelList=null;
		String BudgetHeadDescription=null;
		if(BudgetHeadIdSel!=null) {
		String[] arr1=BudgetHeadIdSel.split("#");
		BudgetHeadIdSelList=arr1[0];
		BudgetHeadDescription="All";
		}
		BudgetHeadIdSel1=Integer.parseInt(BudgetHeadIdSelList);
		if(ProjectIdDetails!=null)
  			{
  				String[] arr=ProjectIdDetails.split("#");
  				ProjectId=Integer.parseInt(arr[0]);
  				ProjectCode="PMS";
  			}
			if(ItemTypeSel!=null) {
				 itemTypeCode = ItemTypeSel.split("#")[0];
				 itemTypeDes = ItemTypeSel.split("#")[1];
			}
			BudgetHeadIdSel1=Integer.parseInt(BudgetHeadIdSelList);
			String FromDate1=sdf.format(rdf.parse("01-03-2024"));
			String ToDate1=sdf.format(rdf.parse("19-04-2024"));
			//List<Object[]> ProjectExpenditureCardList=null;
			
			//List<Object[]> ProjectProgressive=reportService.ProjectProgressive(ProjectId,FromDate1,BudgetHeadIdSel1);
			
			
			final String localUri2=uri+"/pfms_serv/GetIbasProjectProgressiveDetails.htm?projectId="+ProjectId+"&FromDate=2024-03-01+&BudgetHeadId=0";
			HttpHeaders headers = new HttpHeaders();
			headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
	 		String jsonResult2=null;
			try {
				HttpEntity<String> entity = new HttpEntity<String>(headers);
				ResponseEntity<String> response=restTemplate.exchange(localUri2, HttpMethod.GET, entity, String.class);
				jsonResult2=response.getBody();						
			}catch(Exception e) {
				req.setAttribute("errorMsg", "errorMsg");
			}
			ObjectMapper mapper2 = new ObjectMapper();
			mapper2.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
			mapper2.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
			List<Object[]> ProjectProgressive=null;
			//System.out.println("jsonResult2"+jsonResult2);
			if(jsonResult2!=null) {
				try {
					ProjectProgressive = mapper2.readValue(jsonResult2, new TypeReference<List<Object[]>>(){});
					
				} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
		}
			
			BigDecimal REAmount=new BigDecimal(0.0);
			BigDecimal FEAmount=new BigDecimal(0.0);
			BigDecimal TotalReFe=new BigDecimal(0.0);
			
			
			
			
			for(Object[] obj:ProjectProgressive) {
				REAmount=REAmount.add(new BigDecimal(obj[0].toString()));
				FEAmount=FEAmount.add(new BigDecimal(obj[1].toString()));
				TotalReFe=REAmount.add(FEAmount);
				
			}
		logger.info(new Date() + " Inside ProjectExpenditureReportPrint.htm " + UserName);
		try {
//			List<Object[]> labInfoList=reportService.GetLabInfo(Client_name);
//			String labCode = null;
//		    String labName = null;
//		    String labUnitCode = null;
//		    String labPin = null;
//			String labAddress=null;
//		    String labCity=null;
//		    String  subtitle=null;
//		    String projectDirector = null;
//		    for(Object[] obj : labInfoList) {
//			     labCode = String.valueOf(obj[0].toString());
//			     labName = String.valueOf(obj[1].toString());
//			     labUnitCode= String.valueOf(obj[2].toString());
//			     labAddress = String.valueOf(obj[3].toString());
//			     labCity = String.valueOf(obj[4].toString());
//			     labPin = String.valueOf(obj[5].toString());
		   // } 
//		    projectDirector=reportService.GetProjectDirector(ProjectId);
//		    if(projectDirector==null) {
//				projectDirector="--";
//			}
//		    subtitle = "     From " + FromDate + "  To " + ToDate
//					+ "                                                                                                                                                                                                                                                                               Project Director :  "
//					+ projectDirector + " ";
		    String fileName;
			String initial="Initial of AO/SAO";
			if (BudgetHeadIdSel1 == 0) 
			{
				//ProjectExpenditureCardList=reportService.ProjectExpenditureCardList(ProjectId,FromDate1,ToDate1,BudgetHeadIdSel1,itemTypeCode,Client_name);
				
				final String localUri3=uri+"/pfms_serv/GetIbasDateOfEntryPECD.htm?projectId="+ProjectId+"&FromDate=2024-03-01+&ToDate=2024-04-19+&BudgetHeadId=0+&progressivetotalRE"+REAmount+"&progressivetotalFE"+FEAmount+"&LabCode"+LabCode;
				HttpHeaders headers1 = new HttpHeaders();
				headers1.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		 		String jsonResult3=null;
				try {
					HttpEntity<String> entity = new HttpEntity<String>(headers1);
					ResponseEntity<String> response=restTemplate.exchange(localUri3, HttpMethod.GET, entity, String.class);
					jsonResult3=response.getBody();						
				}catch(Exception e) {
					req.setAttribute("errorMsg", "errorMsg");
				}
				ObjectMapper mapper3 = new ObjectMapper();
				mapper3.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
				mapper3.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
				List<Object[]> ProjectExpenditureCardList=null;
				//System.out.println("jsonResult2"+jsonResult2);
				if(jsonResult3!=null) {
					try {
						ProjectExpenditureCardList = mapper3.readValue(jsonResult3, new TypeReference<List<Object[]>>(){});
						
					} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
			}
				
				
				System.out.println("REAmount---"+REAmount);
				System.out.println("FEAmount---"+FEAmount);
				System.out.println("ProjectExpenditureCardList----"+ProjectExpenditureCardList.size());
				
				System.out.println("itemTypeCode---"+itemTypeCode);
				if(ProjectExpenditureCardList!=null && ProjectExpenditureCardList.size()>0) 
				{
					if("A".equals(itemTypeCode)) 
					{
						System.out.println("Inside **** projectExpenditureCard");
						fileName = "/jasperReports/projectExpenditureCard1.jrxml";
					}
					else 
					{
						fileName = "/jasperReports/projectExpenditureCard1.jrxml";
					}
			    }
				else 
				{
					fileName = "/jasperReports/projectExpenditureCard1.jrxml";
			    }
			
	
			//else 
			//{
				 //ProjectExpenditureCardList=reportService.ProjectExpenditureCardList(ProjectId,FromDate1,ToDate1,BudgetHeadIdSel1,itemTypeCode,Client_name);
//				 if(ProjectExpenditureCardList!=null) 
//				 {
//					 if ("A".equals(itemTypeCode)) 
//					 {
//						 System.out.println("Inside **** projectExpenditureCard1");
//						fileName = "/jasperReports/projectExpenditureCard1.jrxml";
//					 } 
//					 else 
//					 {
//						fileName = "/jasperReports/ProjectExpenditureCardWithItemTypeAndHead.jrxml";
//						System.out.println("Inside **** ProjectExpenditureCardWithItemTypeAndHead");
//					 } 
//				 }
//				 else 
//				 {
//					fileName = "/jasperReports/projectExpenditureCardForNoData.jrxml";
//				 }
			//}
			
				
			InputStream ProjectExpenditureCardStream = getClass().getResourceAsStream(fileName);
			JasperReport jasperDesign = JasperCompileManager.compileReport(ProjectExpenditureCardStream);
			Connection conn = jdbcJasper.GetJasperJdbcConnection();
			
			  
			  Map<String, Object> parameters = new HashMap<String,Object>();
			  parameters.put("ReportTitle", "" + LabCode + "");
			  parameters.put("ReportSubTitle", "");
			  parameters.put("projectId", ProjectId);
			  parameters.put("budgetHeadId", BudgetHeadIdSel1);
			  parameters.put("fromdate", FromDate1);
			  parameters.put("todate",ToDate1);
			  parameters.put("budgetHeadSesc", BudgetHeadDescription);
			  parameters.put("progressiveRE", REAmount);
			  parameters.put("progressiveFE", FEAmount);
			  parameters.put("progressivetotal", TotalReFe);
			  parameters.put("labCode", LabCode);
			 
			  
			  parameters.put("fdate", FromDate);
			  parameters.put("tdate", ToDate);
			  parameters.put("itemtype", itemTypeCode);
			  parameters.put("Initial",initial);
			 //JasperPrint print = JasperFillManager.fillReport(jasperDesign, parameters, conn);
			 
			 //if("pdf".equalsIgnoreCase(Action)) {
					
				
				 byte[] bytes = JasperRunManager.runReportToPdf(jasperDesign, parameters,  conn);
				  resp.setContentType("application/pdf");
		          resp.setContentLength(bytes.length);
		          ServletOutputStream outStream = resp.getOutputStream();
		          outStream.write(bytes, 0, bytes.length);
		          outStream.flush();
		          outStream.close();
//			 }else if("Excel".equalsIgnoreCase(Action)) {
//				 
//				  JRXlsxExporter exporter = new JRXlsxExporter();
//			        SimpleXlsxReportConfiguration reportConfigXLS = new SimpleXlsxReportConfiguration();
//			        reportConfigXLS.setSheetNames(new String[] { "sheet1" });
//			        exporter.setConfiguration(reportConfigXLS);
//			        exporter.setExporterInput(new SimpleExporterInput(print));
//			        exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(resp.getOutputStream()));
//			        resp.setHeader("Content-Disposition", "attachment;filename=PEC Report.xlsx");
//			        resp.setContentType("application/octet-stream");
//			        exporter.exportReport();
//			 }
			 
			}
			}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ProjectExpenditureReportPrint.htm "+UserName, e);
			return "static/error";
		}
			
		return null;
	}
	
		
}
