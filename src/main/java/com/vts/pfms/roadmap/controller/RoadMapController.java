package com.vts.pfms.roadmap.controller;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.service.CARSService;
import com.vts.pfms.committee.service.CommitteeService;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.roadmap.dto.RoadMapApprovalDTO;
import com.vts.pfms.roadmap.dto.RoadMapDetailsDTO;
import com.vts.pfms.roadmap.model.AnnualTargets;
import com.vts.pfms.roadmap.model.RoadMap;
import com.vts.pfms.roadmap.model.RoadMapAnnualTargets;
import com.vts.pfms.roadmap.service.RoadMapService;

@Controller
public class RoadMapController {

	private static final Logger logger = LogManager.getLogger(RoadMapController.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	
	@Autowired
	ProjectService projectservice;
	
	@Autowired
	RoadMapService service;
	
	@Autowired
	CommitteeService committeeservice;
	
	@Autowired
	CARSService carsservice;
	
	@RequestMapping(value = "RoadMapList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String roadMapList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String LoginType = (String) ses.getAttribute("LoginType");
		logger.info(new Date() +"Inside RoadMapList.htm "+UserId);
		try {
			String pagination = req.getParameter("pagination");
			int pagin = Integer.parseInt(pagination!=null?pagination:"0");

			/* fetching actual data */
			List<Object[]> roadMapList = service.roadMapList();

			// adding values to this List<Object[]>
			List<Object[]> arrayList = new ArrayList<>();

			/* search action starts */
			String search = req.getParameter("search");
			if(search!="" && search!=null) {
				req.setAttribute("searchFactor", search);
				for(Object[] obj: roadMapList) {
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
			int p = roadMapList.size()/6;
			int extra = roadMapList.size()%6;
			if(arrayList.size()==0) arrayList=roadMapList;

			/* pagination process starts */

			if(pagin>0 && pagin<(p+(extra>0?1:0)))
			{
				req.setAttribute("pagination", pagin);
				arrayList = arrayList.subList(pagin*6, ((pagin*6)+6)<arrayList.size()?((pagin*6)+6):arrayList.size());
			}
			else
			{
				arrayList = arrayList.subList(0, arrayList.size()>=6?6:arrayList.size());
				req.setAttribute("pagination", 0);
				pagin=0;
			}

			req.setAttribute("roadMapList", arrayList);
			req.setAttribute("maxpagin", p+(extra>0?1:0) );
			req.setAttribute("EmpData", carsservice.getEmpDetailsByEmpId(EmpId));
			req.setAttribute("Director", carsservice.getLabDirectorData(labcode));
			/* pagination process ends */

			return "roadmap/RoadMapList";
		}
		catch (Exception e) {
			logger.error(new Date() +" Inside RoadMapList.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value = "RoadMapDetails.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String roadMapDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RoadMapDetails.htm "+UserId);
		
		try {
			String roadMapId = req.getParameter("roadMapId");
			if(roadMapId!=null && roadMapId!="0") {
				req.setAttribute("roadMapDetails", service.getRoadMapDetailsById(roadMapId));
//				req.setAttribute("roadMapAnnualTargetDetails", service.getRoadMapAnnualTargetDetails(roadMapId));
				req.setAttribute("aspFlag", req.getParameter("aspFlag"));
			}
			req.setAttribute("divisionList", service.divisionList(labcode));
			req.setAttribute("annualTargetsList", service.getAnnualTargetsFromMaster());
			
			return "roadmap/RoadMapDetails";
		}catch (Exception e) {
			logger.error(new Date() +" Inside RoadMapDetails.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value = "GetProjectListForRoadMap.htm", method = {RequestMethod.GET})
	public @ResponseBody String getProjectListForRoadMap(HttpServletRequest req, HttpSession ses) throws Exception{
		String Username=(String)ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + "Inside GetProjectListForRoadMap.htm"+Username);
		Gson json = new Gson();
		List<Object[]> getProjectList=null;
		try {
			String roadMapType = req.getParameter("roadMapType");
			if(roadMapType!=null && roadMapType.equalsIgnoreCase("E")) {
				getProjectList=service.getProjectList(labcode);
			}else {
				getProjectList=service.getPreProjectList(labcode);
			}
			
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetProjectListForRoadMap.htm "+Username, e);
			}
		return json.toJson(getProjectList);

	}
	
	@RequestMapping(value = "GetProjectDetailsForRoadMap.htm", method = {RequestMethod.GET})
	public @ResponseBody String getProjectDetailsForRoadMap(HttpServletRequest req, HttpSession ses) throws Exception{
		String Username=(String)ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + "Inside GetProjectDetailsForRoadMap.htm"+Username);
		Gson json = new Gson();
		Object[] getProjectDetails=null;
		try {
			String roadMapType = req.getParameter("roadMapType");
			String projectId = req.getParameter("projectId");
			String initiationId = req.getParameter("initiationId");
			getProjectDetails = service.getProjectDetails(labcode, roadMapType!=null&&roadMapType.equalsIgnoreCase("E")?projectId:initiationId, roadMapType);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetProjectDetailsForRoadMap.htm "+Username, e);
		}
		return json.toJson(getProjectDetails);
		
	}
	
	@RequestMapping(value="RoadMapDetailSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String roadMapDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String labcode=(String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + "Inside RoadMapDetailSubmit.htm"+UserId);
		try {
			String action = req.getParameter("Action");
			
			RoadMapDetailsDTO dto = new RoadMapDetailsDTO();
			dto.setRoadMapId(req.getParameter("roadMapId"));
			dto.setRoadMapType(req.getParameter("roadMapType"));
			dto.setProjectId(req.getParameter("projectId"));
			dto.setInitiationId(req.getParameter("initiationId"));
			dto.setProjectTitle(req.getParameter("projectTitle"));
			dto.setDivisionId(req.getParameter("divisionId"));
			dto.setStartDate(req.getParameter("startDate"));
			dto.setEndDate(req.getParameter("endDate"));
			dto.setAimObjectives(req.getParameter("aimObjectives"));
			dto.setScope(req.getParameter("scope"));
			dto.setReference(req.getParameter("references"));
			dto.setOtherReference(req.getParameter("otherReference"));
			dto.setProjectCost(req.getParameter("projectCost"));
			
			
			String[] annualYearList = req.getParameterValues("annualYear");
			
			List<String[]> list = new ArrayList<String[]>();
			for(int i=0;i<annualYearList.length;i++) {
				String[] annualTargetsList = req.getParameterValues("annualTargets"+annualYearList[i]);
				list.add(annualTargetsList);
			}
			
			dto.setAnnualYear(annualYearList);
			dto.setAnnualTargetList(list);
//			dto.setAnnualTarget(req.getParameterValues("annualTargets"));
			
			dto.setUsername(UserId);
			dto.setAction(action);
			dto.setEmpId(EmpId);
			
			dto.setLabCode(labcode);
			
			long result = service.addRoadMapDetails(dto);
			
			if(result!=0) {
				redir.addAttribute("result", "Road Map Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Road Map Details "+action+" UnSuccessful");
			}
			redir.addAttribute("roadMapId", result);
			return "redirect:/RoadMapDetailsPreview.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside RoadMapDetailSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="RoadMapDetailsDelete.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String roadMapDetailsDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside RoadMapDetailSubmit.htm"+UserId);
		try {
			int result = service.removeRoadMapDetails(req.getParameter("roadMapId"), UserId);
			if(result!=0) {
				redir.addAttribute("result", "Road Map Details Deleted Successfully");
			}else {
				redir.addAttribute("resultfail", "Road Map Details Delete UnSuccessful");
			}
			return "redirect:/RoadMapList.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside RoadMapDetailsDelete.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="RoadMapDetailsMoveToASP.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String roadMapDetailsMoveToASP(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + "Inside RoadMapDetailsMoveToASP.htm"+UserId);
		try {
			String[] roadMapIds = req.getParameterValues("roadMapId");
			long result = 0;
			for(String roadMapId: roadMapIds) {
				result = service.roadMapDetailsMoveToASP(roadMapId, UserId, EmpId);
			}
			
			if(result!=0) {
				redir.addAttribute("result", "Road Map details have been successfully moved to the ASP.");
			}else {
				redir.addAttribute("resultfail", "Road Map details failed to move to the ASP");
			}
			return "redirect:/RoadMapList.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside RoadMapDetailsMoveToASP.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="RoadMapDetailsPreview.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String roadMapDetailsPreview(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside RoadMapDetailsPreview.htm"+UserId);
		try {
			String roadMapId = req.getParameter("roadMapId");
			if(roadMapId!=null && roadMapId!="0") {
				req.setAttribute("roadMapDetails", service.getRoadMapDetailsById(roadMapId));
				req.setAttribute("roadMapApprovalEmpData", service.roadMapTransApprovalData(roadMapId));
				req.setAttribute("roadMapRemarksHistory", service.roadMapRemarksHistory(roadMapId));
				req.setAttribute("aspFlag", req.getParameter("aspFlag"));
				
			}
			req.setAttribute("isApproval", req.getParameter("isApproval"));
			return "roadmap/RoadMapPreview";
		}catch (Exception e) {
			logger.error(new Date() +" Inside RoadMapDetailsPreview.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}

	@RequestMapping(value="RoadMapTransStatus.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String roadMapTransStatus(HttpServletRequest req, HttpSession ses) throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date()+"Inside RoadMapTransStatus.htm"+UserId);
		try {
			String roadMapId = req.getParameter("roadMapId");
			if(roadMapId!=null) {
				req.setAttribute("transactionList", service.roadMapTransList(roadMapId));
				req.setAttribute("roadMapId", roadMapId);
			}
			return "roadmap/RoadMapTransStatus";
		}catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside RoadMapTransStatus.htm "+UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="RoadMapApprovalSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String roadMapApprovalSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+"Inside RoadMapTransStatus.htm"+UserId);
		try {
			String roadMapId = req.getParameter("roadMapId");
			String action = req.getParameter("Action");
			
			RoadMap roadMap = service.getRoadMapDetailsById(roadMapId);
			String roadMapStatusCode = roadMap.getRoadMapStatusCode();
			
			RoadMapApprovalDTO dto = new RoadMapApprovalDTO();
			dto.setRoadMapId(roadMapId);
			dto.setRemarks(req.getParameter("remarks"));
			dto.setAction(action);
			dto.setEmpId(EmpId);
			dto.setLabCode(labcode);
			dto.setUserId(UserId);
			long result = service.roadMapApprovalForward(dto);
			
			List<String> roadmapforward = Arrays.asList("RIN","RRD","RRA","RRV");
			if(action.equalsIgnoreCase("A")) {
				if(roadmapforward.contains(roadMapStatusCode)) {
					if(result!=0) {
						redir.addAttribute("result","Road Map form forwarded Successfully");
					}else {
						redir.addAttribute("resultfail","Road Map form forward Unsuccessful");
					}
					return "redirect:/RoadMapList.htm";
				}else if(roadMapStatusCode.equalsIgnoreCase("RFW")) {
					if(result!=0) {
						redir.addAttribute("result","Road Map form Recommended Successfully");
					}else {
						redir.addAttribute("resultfail","Road Map form Recommend Unsuccessful");
					}
					return "redirect:/RoadMapApprovals.htm";
				}
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if(result!=0) {
					redir.addAttribute("result",action.equalsIgnoreCase("R")?"Road Map form Returned Successfully":"Road Map form Disapproved Successfully");
				}else {
					redir.addAttribute("resultfail",action.equalsIgnoreCase("R")?"Road Map form Return Unsuccessful":"Road Map form Disapprove Unsuccessful");
				}
			}
			return "redirect:/RoadMapApprovals.htm";
			
		}catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside RoadMapApprovalSubmit.htm "+UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value="RoadMapDetailsRevoke.htm", method= {RequestMethod.POST,RequestMethod.GET})
	public String roadMapDetailsRevoke(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside RoadMapDetailsRevoke.htm "+UserId);
		try {
			String roadMapId = req.getParameter("roadMapId");
            
			long count = service.roadMapUserRevoke(roadMapId, UserId, EmpId);
			
			if (count > 0) {
				redir.addAttribute("result", "Road Map Revoked Successfully");
			}
			else {
				redir.addAttribute("resultfail", "Road Map Revoke Unsuccessful");	
			}	

			return "redirect:/RoadMapList.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside RoadMapDetailsRevoke.htm "+UserId, e);
			return "static/Error";			
		}

	}
	
	@RequestMapping(value="RoadMapApprovals.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String roadMapApprovals(HttpServletRequest req,HttpSession ses) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside RoadMapApprovals.htm "+Username);
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

			req.setAttribute("roadMapPendingList", service.roadMapPendingList(EmpId,labcode));
			req.setAttribute("roadMapApprovedList", service.roadMapApprovedList(EmpId,fromdate,todate));
			
			
			return "roadmap/RoadMapApprovals";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside RoadMapApprovals.htm "+Username, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="RoadMapPreviewDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void roadMapPreviewDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside RoadMapPreviewDownload.htm "+UserId);		
		try {
			String roadMapId = req.getParameter("roadMapId");
			if(roadMapId!=null && roadMapId!="0") {
				req.setAttribute("roadMapDetails", service.getRoadMapDetailsById(roadMapId));
				req.setAttribute("roadMapApprovalEmpData", service.roadMapTransApprovalData(roadMapId));
				req.setAttribute("roadMapRemarksHistory", service.roadMapRemarksHistory(roadMapId));
			}
			String filename="Road_Map_Preview";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/RoadMapPreviewDownload.jsp").forward(req, customResponse);
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
    		logger.error(new Date() +" Inside RoadMapPreviewDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	@RequestMapping(value="RoadMapTransactionDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void roadMapTransactionDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside RoadMapTransactionDownload.htm "+UserId);		
		try {
			String roadMapId = req.getParameter("roadMapId");
			if(roadMapId!=null) {
				req.setAttribute("roadMapDetails", service.getRoadMapDetailsById(roadMapId));
				req.setAttribute("transactionList", service.roadMapTransList(roadMapId));
			}
			
			String filename="Road_Map_Transaction";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/RoadMapTransactionDownload.jsp").forward(req, customResponse);
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
    		logger.error(new Date() +" Inside RoadMapTransactionDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}		
	}
	
	@RequestMapping(value="RoadMapReportDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void roadMapReportDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside RoadMapReportDownload.htm "+UserId);		
		try {
			
			req.setAttribute("roadMapList", service.getRoadMapList());
			req.setAttribute("startYear", req.getParameter("startYear"));
			req.setAttribute("endYear", req.getParameter("endYear"));
			
			String filename="Road_Map_Report";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/RoadMapReportDownload.jsp").forward(req, customResponse);
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
			logger.error(new Date() +" Inside RoadMapReportDownload.htm "+UserId, e);
			e.printStackTrace();
		}		
	}
	
	@RequestMapping(value = "RoadMapASPList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String roadMapASPList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String LoginType = (String) ses.getAttribute("LoginType");
		logger.info(new Date() +"Inside RoadMapASPList.htm "+UserId);
		try {
			String pagination = req.getParameter("pagination");
			int pagin = Integer.parseInt(pagination!=null?pagination:"0");

			/* fetching actual data */
			List<Object[]> roadMapASPList = service.roadMapASPList();

			// adding values to this List<Object[]>
			List<Object[]> arrayList = new ArrayList<>();

			/* search action starts */
			String search = req.getParameter("search");
			if(search!="" && search!=null) {
				req.setAttribute("searchFactor", search);
				for(Object[] obj: roadMapASPList) {
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
			int p = roadMapASPList.size()/6;
			int extra = roadMapASPList.size()%6;
			if(arrayList.size()==0) arrayList=roadMapASPList;

			/* pagination process starts */

			if(pagin>0 && pagin<(p+(extra>0?1:0)))
			{
				req.setAttribute("pagination", pagin);
				arrayList = arrayList.subList(pagin*6, ((pagin*6)+6)<arrayList.size()?((pagin*6)+6):arrayList.size());
			}
			else
			{
				arrayList = arrayList.subList(0, arrayList.size()>=6?6:arrayList.size());
				req.setAttribute("pagination", 0);
				pagin=0;
			}

			req.setAttribute("roadMapASPList", arrayList);
			req.setAttribute("maxpagin", p+(extra>0?1:0) );
			req.setAttribute("EmpData", carsservice.getEmpDetailsByEmpId(EmpId));
			req.setAttribute("Director", carsservice.getLabDirectorData(labcode));
			/* pagination process ends */

			return "roadmap/RoadMapASPList";
		}
		catch (Exception e) {
			logger.error(new Date() +" Inside RoadMapASPList.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="RoadMapDetailsMoveBackToRoadMap.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String roadMapDetailsMoveBackToRoadMap(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + "Inside RoadMapDetailsMoveBackToRoadMap.htm"+UserId);
		try {
			String[] roadMapIds = req.getParameterValues("roadMapId");
			long result = 0;
			for(String roadMapId: roadMapIds) {
				result = service.roadMapDetailsMoveBackToRoadMap(roadMapId, UserId, EmpId);
			}
			if(result!=0) {
				redir.addAttribute("result", "ASP have been successfully move back to the Road Map.");
			}else {
				redir.addAttribute("resultfail", "ASP failed to move back to the Road Map");
			}
			return "redirect:/RoadMapASPList.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside RoadMapDetailsMoveBackToRoadMap.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		} 
	}
	
	@RequestMapping(value="RoadMapReportExcelDownload.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public void roadMapReportExcelDownload(HttpServletRequest req, HttpSession ses,HttpServletResponse res) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String labcode=(String)ses.getAttribute("labcode");
		logger.info(new Date() + "Inside RoadMapReportExcelDownload.htm"+UserId);
		try {
			List<RoadMap> roadMapList = service.getRoadMapList();
			Integer startYear = Integer.parseInt(req.getParameter("startYear"));
			Integer endYear = Integer.parseInt(req.getParameter("endYear"));
			
			int rowNo=0;
			// Creating a worksheet
			Workbook workbook = new XSSFWorkbook();

			Sheet sheet = workbook.createSheet("Road_Map_Report");
			sheet.setColumnWidth(0, 2000);
			sheet.setColumnWidth(1, 10000);
			sheet.setColumnWidth(2, 20000);
			sheet.setColumnWidth(3, 5000);
			sheet.setColumnWidth(4, 5000);
			int slnoyrs = 4;
			for(int i=startYear;i<=endYear;i++) {
				sheet.setColumnWidth(++slnoyrs, 10000);
			}

			
			XSSFFont font = ((XSSFWorkbook) workbook).createFont();
			font.setFontName("Times New Roman");
			font.setFontHeightInPoints((short) 14);
			font.setBold(true);
			
			XSSFFont font2 = ((XSSFWorkbook) workbook).createFont();
			font2.setFontName("Times New Roman");
			font2.setFontHeightInPoints((short) 10);
			font2.setBold(true);
			
			// style for file header
			CellStyle file_header_Style = workbook.createCellStyle();
			file_header_Style.setLocked(true);
			file_header_Style.setFont(font);
			file_header_Style.setWrapText(true);
			file_header_Style.setAlignment(HorizontalAlignment.CENTER);
			file_header_Style.setVerticalAlignment(VerticalAlignment.CENTER);
			
			// style for table header
			CellStyle t_header_style = workbook.createCellStyle();
			t_header_style.setLocked(true);
			t_header_style.setFont(font2);
			t_header_style.setWrapText(true);
			t_header_style.setAlignment(HorizontalAlignment.CENTER);
			t_header_style.setVerticalAlignment(VerticalAlignment.CENTER);
			
			// style for table cells
			CellStyle t_body_style = workbook.createCellStyle();
			t_body_style.setWrapText(true);
			t_body_style.setAlignment(HorizontalAlignment.LEFT);
			t_body_style.setVerticalAlignment(VerticalAlignment.TOP);

			// style for table cells with center align
			CellStyle t_body_style2 = workbook.createCellStyle();
			t_body_style2.setWrapText(true);
			t_body_style2.setAlignment(HorizontalAlignment.CENTER);
			t_body_style2.setVerticalAlignment(VerticalAlignment.TOP);
			
			// File header Row
			Row file_header_row = sheet.createRow(rowNo++);
			sheet.addMergedRegion(new CellRangeAddress(0, 0,0, slnoyrs));   // Merging Header Cells 
			Cell cell= file_header_row.createCell(0);
			cell.setCellValue("Road Map Report");
			file_header_row.setHeightInPoints((3*sheet.getDefaultRowHeightInPoints()));
			cell.setCellStyle(file_header_Style);
			
			CellStyle file_header_Style2 = workbook.createCellStyle();
			file_header_Style2.setLocked(true);
			file_header_Style2.setFont(font2);
			file_header_Style2.setWrapText(true);
			file_header_Style2.setAlignment(HorizontalAlignment.RIGHT);
			file_header_Style2.setVerticalAlignment(VerticalAlignment.CENTER);	

			// Table in file header Row
			Row t_header_row = sheet.createRow(rowNo++);
			cell= t_header_row.createCell(0); 
			cell.setCellValue("SN"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(1); 
			cell.setCellValue("Title"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(2); 
			cell.setCellValue("Aim & Objects"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(3); 
			cell.setCellValue("Duration (in months)"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(4); 
			cell.setCellValue("Project Type"); 
			cell.setCellStyle(t_header_style);
			
			slnoyrs=4;
			for(int i=startYear;i<=endYear;i++) {
				cell= t_header_row.createCell(++slnoyrs); 
				cell.setCellValue(i); 
				cell.setCellStyle(t_header_style);
			}
			
			// Existing Project Annual Targets
			List<Object[]> projectList = service.getProjectList(labcode);
			List<Object[]> projectMilestoneActivityList = service.getProjectMilestoneActivityList(labcode);
			if(projectList!=null && projectList.size()>0) {
				int slno=0;
				for(Object[] obj : projectList) {
					List<Object[]> annualTargetsDetails = projectMilestoneActivityList!=null && projectMilestoneActivityList.size()>0? projectMilestoneActivityList.stream()
														  .filter(e -> (Long.parseLong(e[0].toString())==Long.parseLong(obj[0].toString())) && (Integer.parseInt(e[2].toString().substring(0,4))>=startYear) &&  (Integer.parseInt(e[3].toString().substring(0,4))<=endYear) )
														  .collect(Collectors.toList()) : new ArrayList<Object[]>();
							
					if(annualTargetsDetails.size()>0) {
						Row t_body_row = sheet.createRow(rowNo++);
						cell= t_body_row.createCell(0); 
						cell.setCellValue(++slno); 
						cell.setCellStyle(t_body_style2);

						cell= t_body_row.createCell(1); 
						cell.setCellValue(obj[3]!=null?obj[3].toString():"-"); 
						cell.setCellStyle(t_body_style);

						cell= t_body_row.createCell(2); 
						cell.setCellValue(obj[4]!=null?obj[4].toString():"-"); 
						cell.setCellStyle(t_body_style);

						cell= t_body_row.createCell(3); 
						cell.setCellValue(obj[5]!=null?obj[5].toString():"-"); 
						cell.setCellStyle(t_body_style2);
						
						cell= t_body_row.createCell(4); 
						cell.setCellValue("Existing"); 
						cell.setCellStyle(t_body_style2);


						slnoyrs=4;


						for(int i=startYear;i<=endYear;i++) {
							Integer year = i;
							List<String> targetsList =  annualTargetsDetails.stream()
														.filter(e-> year>=(Integer.parseInt(e[2].toString().substring(0,4))) && (year<=Integer.parseInt(e[3].toString().substring(0,4))) )
														.map(e -> e[1].toString())
														.collect(Collectors.toList());

							String annualTarget = targetsList.isEmpty() ? "NA" : String.join(", ", targetsList);

							cell = t_body_row.createCell(++slnoyrs);
							cell.setCellValue(annualTarget);
							cell.setCellStyle(targetsList.isEmpty() ? t_body_style2 : t_body_style);

						}
						
					}
				}
			}
			
			// Pre Project Annual Targets
			List<Object[]> preProjectList = service.getPreProjectList(labcode);
			List<Object[]> preProjectMilestoneActivityList = service.getPreProjectMilestoneActivityList();
			if(preProjectList!=null && preProjectList.size()>0) {
				int slno=0;
				for(Object[] obj : preProjectList) {
					List<Object[]> annualTargetsDetails = preProjectMilestoneActivityList!=null && preProjectMilestoneActivityList.size()>0? preProjectMilestoneActivityList.stream()
							.filter(e -> (Integer.parseInt(e[0].toString())==Integer.parseInt(obj[0].toString())) && (Integer.parseInt(e[2].toString().substring(0,4))>=startYear) &&  (Integer.parseInt(e[3].toString().substring(0,4))<=endYear) )
							.collect(Collectors.toList()) : new ArrayList<Object[]>();
							
							if(annualTargetsDetails.size()>0) {
								Row t_body_row = sheet.createRow(rowNo++);
								cell= t_body_row.createCell(0); 
								cell.setCellValue(++slno); 
								cell.setCellStyle(t_body_style2);
								
								cell= t_body_row.createCell(1); 
								cell.setCellValue(obj[3]!=null?obj[3].toString():"-"); 
								cell.setCellStyle(t_body_style);
								
								cell= t_body_row.createCell(2); 
								cell.setCellValue(obj[4]!=null?obj[4].toString():"-"); 
								cell.setCellStyle(t_body_style);
								
								cell= t_body_row.createCell(3); 
								cell.setCellValue(obj[5]!=null?obj[5].toString():"-"); 
								cell.setCellStyle(t_body_style2);
								
								cell= t_body_row.createCell(4); 
								cell.setCellValue("Initiation"); 
								cell.setCellStyle(t_body_style2);
								
								
								slnoyrs=4;
								
								for(int i=startYear;i<=endYear;i++) {

									Integer year = i;
									List<String> targetsList =  annualTargetsDetails.stream()
															    .filter(e-> year>=(Integer.parseInt(e[2].toString().substring(0,4))) && (year<=Integer.parseInt(e[3].toString().substring(0,4))) )
															    .map(e -> e[1].toString())
															    .collect(Collectors.toList());
									
									String annualTarget = targetsList.isEmpty() ? "NA" : String.join(", ", targetsList);

								    cell = t_body_row.createCell(++slnoyrs);
								    cell.setCellValue(annualTarget);
								    cell.setCellStyle(targetsList.isEmpty() ? t_body_style2 : t_body_style);
								    
								}
								
							}
					}
			}
			
			// New Project Annual Targets
			if(roadMapList!=null) {
				int slno=0;
				for(RoadMap roadMap : roadMapList) {
					
					List<RoadMapAnnualTargets> roadMapAnnualTargetDetails = roadMap.getRoadMapAnnualTargets().stream()
																			.filter(e -> Integer.parseInt(e.getAnnualYear())>=startYear && Integer.parseInt(e.getAnnualYear())<=endYear && e.getIsActive()==1)
																			.collect(Collectors.toList());
					
					if(roadMapAnnualTargetDetails.size()>0) {
						Row t_body_row = sheet.createRow(rowNo++);
						cell= t_body_row.createCell(0); 
						cell.setCellValue(++slno); 
						cell.setCellStyle(t_body_style2);

						cell= t_body_row.createCell(1); 
						cell.setCellValue(roadMap.getProjectTitle()); 
						cell.setCellStyle(t_body_style);

						cell= t_body_row.createCell(2); 
						cell.setCellValue(roadMap.getAimObjectives()); 
						cell.setCellStyle(t_body_style);

						cell= t_body_row.createCell(3); 
						cell.setCellValue(roadMap.getDuration()); 
						cell.setCellStyle(t_body_style2);

						cell= t_body_row.createCell(4); 
						cell.setCellValue("New"); 
						cell.setCellStyle(t_body_style2);
						
						slnoyrs=4;

						for(int i=startYear;i<=endYear;i++) {
							Integer year = i;
							
							List<String> targetsList =  roadMapAnnualTargetDetails.stream()
									 					.filter(e-> year==Integer.parseInt(e.getAnnualYear()))
									 					.map(e -> e.getAnnualTargets().getAnnualTarget())
									 					.collect(Collectors.toList());
							
							String annualTarget = targetsList.isEmpty() ? "NA" : String.join(", ", targetsList);

						    cell = t_body_row.createCell(++slnoyrs);
						    cell.setCellValue(annualTarget);
						    cell.setCellStyle(targetsList.isEmpty() ? t_body_style2 : t_body_style);
						}
						
					}
				}
			}
			
			String path = req.getServletContext().getRealPath("/view/temp");
			String fileLocation = path.substring(0, path.length() - 1) + "temp.xlsx";

			FileOutputStream outputStream = new FileOutputStream(fileLocation);
			workbook.write(outputStream);
			workbook.close();
			
			String filename="Road_Map_Report";
			
	        res.setContentType("Application/octet-stream");
	        res.setHeader("Content-disposition","attachment;filename="+filename+".xlsx");
	        File f=new File(fileLocation);
	         
	        
	        FileInputStream fis = new FileInputStream(f);
	        DataOutputStream os = new DataOutputStream(res.getOutputStream());
	        res.setHeader("Content-Length",String.valueOf(f.length()));
	        byte[] buffer = new byte[1024];
	        int len = 0;
	        while ((len = fis.read(buffer)) >= 0) {
	            os.write(buffer, 0, len);
	        } 
	        os.close();
	        fis.close();
		}catch (Exception e) {
			logger.error(new Date() +" Inside RoadMapReportExcelDownload.htm "+UserId, e);
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "AddOtherAnnualTargets.htm", method = {RequestMethod.GET})
	public @ResponseBody String addOtherAnnualTargets(HttpServletRequest req, HttpSession ses) throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside AddOtherAnnualTargets.htm"+Username);
		Gson json = new Gson();

		List<Object[]> dataList = new ArrayList<>();
		try {
			String[] others = req.getParameter("others").split(",");

			for(int i=0;i<others.length;i++) {
				AnnualTargets target = new AnnualTargets();
				target.setAnnualTarget(others[i]);
				target.setCreatedBy(Username);
				target.setCreatedDate(sdtf.format(new Date()));
				target.setIsActive(1);

				Long annualTargetId = service.addAnnualTargets(target);

				Object[] data = new Object[2];
				data[0] = annualTargetId;
				data[1] = others[i];

				dataList.add(data);
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside AddOtherAnnualTargets.htm "+Username, e);
		}
		return json.toJson(dataList);

	}
}
