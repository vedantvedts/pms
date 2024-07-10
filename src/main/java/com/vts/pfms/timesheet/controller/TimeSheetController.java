package com.vts.pfms.timesheet.controller;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
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
import com.vts.pfms.header.service.HeaderService;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.timesheet.dto.TimeSheetDTO;
import com.vts.pfms.timesheet.model.TimeSheet;
import com.vts.pfms.timesheet.service.TimeSheetService;

@Controller
public class TimeSheetController {

	private static final Logger logger = LogManager.getLogger(TimeSheetController.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf = new SimpleDateFormat("dd-MM-yyyy");
	
	@Autowired
	TimeSheetService service;
	
	@Autowired
	HeaderService headerservice;
	
	@Autowired
	ProjectService projectservice;
	
	@RequestMapping(value="TimeSheetDashboard.htm", method= {RequestMethod.GET,RequestMethod.POST})
	public String timeSheetDashboard(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+" Inside TimeSheetDashboard.htm "+UserId);
		try {
			req.setAttribute("empList", service.getAllEmployeeList(labcode));
			req.setAttribute("projectList", projectservice.LoginProjectDetailsList(EmpId,Logintype,labcode));
			req.setAttribute("holidayList", service.getHolidayList());
			return "timesheet/TimeSheetDashboard";
		}catch (Exception e) {
			logger.error(new Date() +" Inside TimeSheetDashboard.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="TimeSheetList.htm", method= {RequestMethod.GET,RequestMethod.POST})
	public String timeSheetList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+" Inside TimeSheetList.htm "+UserId);
		try {
			String activityDate = req.getParameter("activityDate");
			activityDate = activityDate==null?rdf.format(new Date()):activityDate;
			String activityDateSql = fc.rdfTosdf(activityDate);
			req.setAttribute("activityDate", activityDate);
			req.setAttribute("activityDateSql", activityDateSql);
			req.setAttribute("todayScheduleList", headerservice.TodaySchedulesList(EmpId, activityDateSql));
			req.setAttribute("timeSheetData", service.getTimeSheetByDateAndEmpId(EmpId, activityDateSql));
			req.setAttribute("empActivityAssignList", service.getEmpActivityAssignList(EmpId));
			req.setAttribute("empAllTimeSheetList", service.getEmpAllTimeSheetList(EmpId, activityDateSql));
			req.setAttribute("milestoneActivityTypeList", service.getMilestoneActivityTypeList());
			req.setAttribute("projectList", projectservice.LoginProjectDetailsList(EmpId,Logintype,labcode));
			return "timesheet/TimeSheetList";
		}catch (Exception e) {
			logger.error(new Date() +" Inside TimeSheetList.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="TimeSheetDetailsSubmit.htm", method= {RequestMethod.GET,RequestMethod.POST})
	public String timeSheetDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+" Inside TimeSheetDetailsSubmit.htm "+UserId);
		try {
			String activityDate = req.getParameter("activityDate");
			activityDate = activityDate==null?rdf.format(new Date()):activityDate;
			
			TimeSheetDTO dto = TimeSheetDTO.builder()
							   .TimeSheetId(req.getParameter("timeSheetId"))
							   .EmpId(EmpId)
							   .PunchInTime(req.getParameter("punchInTime"))
							   .ActivityFromDate(activityDate)
							   .TotalDuration(req.getParameter("totalduration"))
							   .ActivityId(req.getParameterValues("activityId"))
							   .ProjectId(req.getParameterValues("projectId"))
							   .ProjectIdhidden(req.getParameterValues("projectIdhidden"))
							   .ActivityTypeId(req.getParameterValues("activityName"))
							   .ActivityDuration(req.getParameterValues("duration"))
							   .Remarks(req.getParameterValues("remarks"))
							   .Action(req.getParameter("Action"))
							   .UserId(UserId)
							   .build();
			
			Long result = service.timeSheetSubmit(dto);
			
			if(result!=0) {
				redir.addAttribute("result", "Time Sheet Details "+req.getParameter("Action")+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Time Sheet Details "+req.getParameter("Action")+" UnSuccessful");
			}
			
			redir.addAttribute("activityDate", activityDate);
			return "redirect:/TimeSheetList.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside TimeSheetDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="TimeSheetDetailsForward.htm", method= {RequestMethod.GET,RequestMethod.POST})
	public String timeSheetDetailsForward(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+" Inside TimeSheetDetailsForward.htm "+UserId);
		try {
			String[] timeSheetIds = req.getParameterValues("timeSheetId");
			String timeSheetId = timeSheetIds[0];
			String action = req.getParameter("action");
			String remarks = req.getParameter("remarks");
			
			TimeSheet timeSheet = service.getTimeSheetById(timeSheetId);
			String statusCode = timeSheet.getTimeSheetStatus();
			
			Long result = service.timeSheetDetailsForward(timeSheetIds, EmpId, action, UserId, remarks);
			
			if(action.equalsIgnoreCase("A")) {
				if(statusCode.equalsIgnoreCase("INI") || statusCode.equalsIgnoreCase("RBS") ) {
					if(result!=0) {
						redir.addAttribute("result","Time Sheet forwarded Successfully");
					}else {
						redir.addAttribute("resultfail","Time Sheet forwarded Successfully");
					}
					redir.addAttribute("activityDate", req.getParameter("activityDate"));
					return "redirect:/TimeSheetList.htm";
				}else if(statusCode.equalsIgnoreCase("FWD")) {
					if(result!=0) {
						redir.addAttribute("result","Time Sheet Approved Successfully");
					}else {
						redir.addAttribute("resultfail","Time Sheet Approve Unsuccessful");
					}
					return "redirect:/TimeSheetApprovals.htm";
				}
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if(result!=0) {
					redir.addAttribute("result",action.equalsIgnoreCase("R")?"Time Sheet Returned Successfully":"Time Sheet Rejected Successfully");
				}else {
					redir.addAttribute("resultfail",action.equalsIgnoreCase("R")?"Time Sheet Return Unsuccessful":"Time Sheet Reject Unsuccessful");
				}
			}
			
			return "redirect:/TimeSheetApprovals.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside TimeSheetDetailsForward.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="TimeSheetApprovals.htm", method= {RequestMethod.GET,RequestMethod.POST})
	public String timeSheetApprovals(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+" Inside TimeSheetApprovals.htm "+UserId);
		try {
			String activityWeekDate = req.getParameter("activityWeekDate");
			activityWeekDate = activityWeekDate==null?rdf.format(new Date()):activityWeekDate;
			String activityWeekDateSql = fc.rdfTosdf(activityWeekDate);
			
			req.setAttribute("employeesofSuperiorOfficer", service.getEmployeesofSuperiorOfficer(EmpId, labcode));
			req.setAttribute("timesheetDataForSuperior", service.getTimesheetDataForSuperior(EmpId, labcode, activityWeekDateSql));
			req.setAttribute("empActivityAssignList", service.getEmpActivityAssignList("A"));
			req.setAttribute("milestoneActivityTypeList", service.getMilestoneActivityTypeList());
			req.setAttribute("projectList", projectservice.LoginProjectDetailsList(EmpId,"A",labcode));
			req.setAttribute("activityWeekDate", activityWeekDate);
			req.setAttribute("activityWeekDateSql", activityWeekDateSql);
			
			return "timesheet/TimeSheetApprovals";
		}catch (Exception e) {
			logger.error(new Date() +" Inside TimeSheetApprovals.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "EmpActionAnalyticsCount.htm", method = {RequestMethod.GET})
	public @ResponseBody String empActionAnalyticsCount(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside EmpActionAnalyticsCount.htm "+UserId);
		Gson json = new Gson();
		Object[] empActionAnalyticsCounts = null;
		try {
			String empId = req.getParameter("empId");
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			String projectId = req.getParameter("projectId");
			empId = empId==null?EmpId:empId;
			projectId = projectId!=null?projectId:"A";
			
			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();

			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			empActionAnalyticsCounts = service.getActionAnalyticsCounts(empId, fromDate, toDate, projectId);
		}catch (Exception e) {
			logger.error(new Date() +" Inside EmpActionAnalyticsCount.htm "+UserId, e);
			e.printStackTrace();
		}
		return json.toJson(empActionAnalyticsCounts);
	}
	
	@RequestMapping(value = "EmpActivityWiseAnalyticsCount.htm", method = {RequestMethod.GET})
	public @ResponseBody String empActivityWiseAnalyticsCount(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside EmpActivityWiseAnalyticsCount.htm "+UserId);
		Gson json = new Gson();
		List<Object[]> empActivityWiseAnalyticsCount = new ArrayList<>();
		try {
			String empId = req.getParameter("empId");
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			String projectId = req.getParameter("projectId");
			empId = empId==null?EmpId:empId;
			projectId = projectId!=null?projectId:"A";
			
			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			empActivityWiseAnalyticsCount = service.empActivityWiseAnalyticsList(empId, fromDate, toDate, projectId);
		}catch (Exception e) {
			logger.error(new Date() +" Inside EmpActivityWiseAnalyticsCount.htm "+UserId, e);
			e.printStackTrace();
		}
		return json.toJson(empActivityWiseAnalyticsCount);
	}
	
	@RequestMapping(value = "ProjectActivityWiseAnalyticsCount.htm", method = {RequestMethod.GET})
	public @ResponseBody String projectActivityWiseAnalyticsCount(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside ProjectActivityWiseAnalyticsCount.htm "+UserId);
		Gson json = new Gson();
		List<Object[]> projectActivityWiseAnalyticsCount = new ArrayList<>();
		try {
			String projectId = req.getParameter("projectId");
			String empId = req.getParameter("empId");
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			projectId = projectId == null?"0":projectId;
			empId = empId == null?EmpId:empId;

			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			projectActivityWiseAnalyticsCount = service.projectActivityWiseAnalyticsList(empId, fromDate, toDate, projectId);
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectActivityWiseAnalyticsCount.htm "+UserId, e);
			e.printStackTrace();
		}
		return json.toJson(projectActivityWiseAnalyticsCount);
	}
	
	@RequestMapping(value = "ProjectActionAnalyticsCount.htm", method = {RequestMethod.GET})
	public @ResponseBody String projectActionAnalyticsCount(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() + " Inside ProjectActionAnalyticsCount.htm "+UserId);
		Gson json = new Gson();
		Object[] projectActionAnalyticsCount = null;
		try {
			String projectId = req.getParameter("projectId");
			String empId = req.getParameter("empId");
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			projectId = projectId == null?"0":projectId;
			empId = empId == null?"A":empId;
			
			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			projectActionAnalyticsCount = service.getActionAnalyticsCounts(empId, fromDate, toDate, projectId);
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectActionAnalyticsCount.htm "+UserId, e);
			e.printStackTrace();
		}
		return json.toJson(projectActionAnalyticsCount);
	}
	
	@RequestMapping(value = "EmpTimeSheetWorkingHrsList.htm", method = {RequestMethod.GET})
	public @ResponseBody String timeSheetEmpWorkingHrsList(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String LoginType=(String)ses.getAttribute("LoginType");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside EmpTimeSheetWorkingHrsList.htm "+UserId);
		Gson json = new Gson();
		List<Object[]> workingHrsList = null;
		try {

			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");

			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			workingHrsList = service.getAllEmpTimeSheetWorkingHrsList(labcode, LoginType, EmpId, fromDate, toDate);
		}catch (Exception e) {
			logger.error(new Date() +" Inside EmpTimeSheetWorkingHrsList.htm "+UserId, e);
			e.printStackTrace();
		}
		return json.toJson(workingHrsList);
	}
	
	@RequestMapping(value = "ProjectTimeSheetWorkingHrsList.htm", method = {RequestMethod.GET})
	public @ResponseBody String projectTimeSheetWorkingHrsList(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String LoginType=(String)ses.getAttribute("LoginType");
		logger.info(new Date() + " Inside ProjectTimeSheetWorkingHrsList.htm "+UserId);
		Gson json = new Gson();
		List<Object[]> workingHrsList = null;
		try {
			String projectId = req.getParameter("projectId");
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			projectId = projectId==null?"A":projectId;
			
			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			workingHrsList = service.getProjectTimeSheetWorkingHrsList(labcode, LoginType, projectId, fromDate, toDate);
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectTimeSheetWorkingHrsList.htm "+UserId, e);
			e.printStackTrace();
		}
		return json.toJson(workingHrsList);
	}
	
	@RequestMapping(value = "EmpExtraWorkingDayList.htm", method = {RequestMethod.GET})
	public @ResponseBody String empExtraWorkingDayList(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside EmpExtraWorkingDayList.htm "+UserId);
		Gson json = new Gson();
		List<Object[]> extraworkingDaysList = new ArrayList<>();
		List<Object[]> projectWiseExtraworkingDaysList = new ArrayList<>();
		List<List<Object[]>> list = new ArrayList<>();
		try {
			String empId = req.getParameter("empId");
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			empId = empId!=null?empId:EmpId;
			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.getYear()+"-01-01";
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			extraworkingDaysList = service.empExtraWorkingDaysList(empId, fromDate, toDate);
			projectWiseExtraworkingDaysList = service.projectWiseEmpExtraWorkingDaysList(empId, fromDate, toDate);
			list.add(extraworkingDaysList);
			list.add(projectWiseExtraworkingDaysList);
			
		}catch (Exception e) {
			logger.error(new Date() +" Inside EmpExtraWorkingDayList.htm "+UserId, e);
			e.printStackTrace();
		}
		return json.toJson(list);
	}
	
	@RequestMapping(value="ProjectTimeSheetExcelReport.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public void projectTimeSheetExcelReport(HttpServletRequest req, HttpSession ses,HttpServletResponse res) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String LoginType = (String)ses.getAttribute("LoginType");
		logger.info(new Date() + " Inside ProjectTimeSheetExcelReport.htm "+UserId);
		try {
			String projectId = req.getParameter("projectId");
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			String totalHrs = req.getParameter("totalHrs");
			String cadreType = req.getParameter("cadreType");
			String projectName = req.getParameter("projectName");
			
			projectId = projectId==null?"A":projectId;
			projectName = projectName!=null && !projectName.isEmpty()?projectName:"All";
			
			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			List<Object[]> workingHrsList = service.getProjectTimeSheetWorkingHrsList(labcode, LoginType, projectId, fromDate, toDate);
			
			int rowNo=0;
			// Creating a worksheet
			Workbook workbook = new XSSFWorkbook();

			Sheet sheet = workbook.createSheet("Project_Time_Sheet");
			sheet.setColumnWidth(0, 2000);
			sheet.setColumnWidth(1, 20000);
			sheet.setColumnWidth(2, 5000);
			sheet.setColumnWidth(3, 5000);

			XSSFFont font = ((XSSFWorkbook) workbook).createFont();
			font.setFontName("Times New Roman");
			font.setFontHeightInPoints((short) 14);
			font.setBold(true);
			
			XSSFFont font2 = ((XSSFWorkbook) workbook).createFont();
			font2.setFontName("Times New Roman");
			font2.setFontHeightInPoints((short) 11);
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
			
			// style for table cells with right align
			CellStyle t_body_style3 = workbook.createCellStyle();
			t_body_style3.setWrapText(true);
			t_body_style3.setAlignment(HorizontalAlignment.RIGHT);
			t_body_style3.setVerticalAlignment(VerticalAlignment.TOP);
			
			// File header Row
			Row file_header_row = sheet.createRow(rowNo++);
			sheet.addMergedRegion(new CellRangeAddress(0, 0,0, 3));   // Merging Header Cells 
			Cell cell= file_header_row.createCell(0);
			cell.setCellValue("Project Time Sheet");
			file_header_row.setHeightInPoints((3*sheet.getDefaultRowHeightInPoints()));
			cell.setCellStyle(file_header_Style);
			
			CellStyle file_header_Style2 = workbook.createCellStyle();
			file_header_Style2.setLocked(true);
			file_header_Style2.setFont(font2);
			file_header_Style2.setWrapText(true);
			file_header_Style2.setAlignment(HorizontalAlignment.RIGHT);
			file_header_Style2.setVerticalAlignment(VerticalAlignment.CENTER);	

			Row file_header_row2 = sheet.createRow(rowNo++);
			sheet.addMergedRegion(new CellRangeAddress(1, 1,0, 3));   // Merging Header Cells 
			cell= file_header_row2.createCell(0);
			cell.setCellValue("Project : "+projectName+"                                               "
					+ "Selected Period : "+fc.sdfTordf(fromDate)+"  to  "+fc.sdfTordf(toDate));
			cell.setCellStyle(file_header_Style2);
			
			// Table in file header Row
			Row t_header_row = sheet.createRow(rowNo++);
			cell= t_header_row.createCell(0); 
			cell.setCellValue("SN"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(1); 
			cell.setCellValue("Employee"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(2); 
			cell.setCellValue("Cadre"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(3); 
			cell.setCellValue("Total Hours"); 
			cell.setCellStyle(t_header_style);
			
			if(cadreType!=null && !cadreType.equalsIgnoreCase("All")) {
				workingHrsList = workingHrsList!=null && workingHrsList.size()>0? workingHrsList.stream()
						 		 .filter(e -> e[3]!=null && e[3].toString().equalsIgnoreCase(cadreType))
						 		 .collect(Collectors.toList()): new ArrayList<>();
			}
			
			if(workingHrsList!=null && workingHrsList.size()>0) {
				int slno=0;
				for(Object[] obj : workingHrsList) {
					Row t_body_row = sheet.createRow(rowNo++);
					cell= t_body_row.createCell(0); 
					cell.setCellValue(++slno); 
					cell.setCellStyle(t_body_style2);
					
					cell= t_body_row.createCell(1); 
					cell.setCellValue((obj[1]!=null?obj[1].toString():"-")+", "+(obj[2]!=null?obj[2].toString():"-")); 
					cell.setCellStyle(t_body_style);
					
					cell= t_body_row.createCell(2); 
					cell.setCellValue(obj[3]!=null?obj[3].toString():"-"); 
					cell.setCellStyle(t_body_style2);
					
					cell= t_body_row.createCell(3); 
					cell.setCellValue(obj[4]!=null?obj[4].toString():"-");
					cell.setCellStyle(t_body_style2);
					
				}
			}
			Row t_body_row2 = sheet.createRow(rowNo++);
			
			cell= t_body_row2.createCell(2); 
			cell.setCellValue("Total");
			cell.setCellStyle(t_body_style3);
			
			cell= t_body_row2.createCell(3); 
			cell.setCellValue(totalHrs);
			cell.setCellStyle(t_body_style2);
			
			
			String path = req.getServletContext().getRealPath("/view/temp");
			String fileLocation = path.substring(0, path.length() - 1) + "temp.xlsx";

			FileOutputStream outputStream = new FileOutputStream(fileLocation);
			workbook.write(outputStream);
			workbook.close();
			
			
			String filename="Project_Time_Sheet";
			
     
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
			logger.error(new Date() +" Inside ProjectTimeSheetExcelReport.htm "+UserId, e);
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="TimeSheetListExcelReport.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public void timeSheetListExcelReport(HttpServletRequest req, HttpSession ses,HttpServletResponse res) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String LoginType = (String)ses.getAttribute("LoginType");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside TimeSheetListExcelReport.htm "+UserId);
		try {

			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");

			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			List<Object[]> workingHrsList = service.getAllEmpTimeSheetWorkingHrsList(labcode, LoginType, EmpId, fromDate, toDate);
			

			int rowNo=0;
			// Creating a worksheet
			Workbook workbook = new XSSFWorkbook();

			Sheet sheet = workbook.createSheet("Time_Sheet_List");
			sheet.setColumnWidth(0, 2000);
			sheet.setColumnWidth(1, 20000);
			sheet.setColumnWidth(2, 5000);
			sheet.setColumnWidth(3, 5000);
			sheet.setColumnWidth(4, 5000);
			sheet.setColumnWidth(5, 5000);
			sheet.setColumnWidth(6, 5000);
			sheet.setColumnWidth(7, 5000);

			XSSFFont font = ((XSSFWorkbook) workbook).createFont();
			font.setFontName("Times New Roman");
			font.setFontHeightInPoints((short) 14);
			font.setBold(true);
			
			XSSFFont font2 = ((XSSFWorkbook) workbook).createFont();
			font2.setFontName("Times New Roman");
			font2.setFontHeightInPoints((short) 11);
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
			
			// style for table cells with right align
			CellStyle t_body_style3 = workbook.createCellStyle();
			t_body_style3.setWrapText(true);
			t_body_style3.setAlignment(HorizontalAlignment.RIGHT);
			t_body_style3.setVerticalAlignment(VerticalAlignment.TOP);
			
			// File header Row
			Row file_header_row = sheet.createRow(rowNo++);
			sheet.addMergedRegion(new CellRangeAddress(0, 0,0, 7));   // Merging Header Cells 
			Cell cell= file_header_row.createCell(0);
			cell.setCellValue("Time Sheet List");
			file_header_row.setHeightInPoints((3*sheet.getDefaultRowHeightInPoints()));
			cell.setCellStyle(file_header_Style);
			
			CellStyle file_header_Style2 = workbook.createCellStyle();
			file_header_Style2.setLocked(true);
			file_header_Style2.setFont(font2);
			file_header_Style2.setWrapText(true);
			file_header_Style2.setAlignment(HorizontalAlignment.RIGHT);
			file_header_Style2.setVerticalAlignment(VerticalAlignment.CENTER);	
			
			Row file_header_row2 = sheet.createRow(rowNo++);
			sheet.addMergedRegion(new CellRangeAddress(1, 1,0, 7));   // Merging Header Cells 
			cell= file_header_row2.createCell(0);
			cell.setCellValue("Selected Period : "+fc.sdfTordf(fromDate)+"  to  "+fc.sdfTordf(toDate));
			cell.setCellStyle(file_header_Style2);
			
			// Table in file header Row
			Row t_header_row = sheet.createRow(rowNo++);
			cell= t_header_row.createCell(0); 
			cell.setCellValue("SN"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(1); 
			cell.setCellValue("Employee"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(2); 
			cell.setCellValue("Total Hrs"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(3); 
			cell.setCellValue("No of Deficit"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(4); 
			cell.setCellValue("Deficit Hrs"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(5); 
			cell.setCellValue("No of Extra Hrs"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(6); 
			cell.setCellValue("Extra Hrs"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(7); 
			cell.setCellValue("Overall Hrs"); 
			cell.setCellStyle(t_header_style);

			if(workingHrsList!=null && workingHrsList.size()>0) {
				int slno=0;
				for(Object[] obj : workingHrsList) {
					Row t_body_row = sheet.createRow(rowNo++);
					cell= t_body_row.createCell(0); 
					cell.setCellValue(++slno); 
					cell.setCellStyle(t_body_style2);
					
					cell= t_body_row.createCell(1); 
					cell.setCellValue((obj[1]!=null?obj[1].toString():"-")+", "+(obj[2]!=null?obj[2].toString():"-")); 
					cell.setCellStyle(t_body_style);
					
					cell= t_body_row.createCell(2); 
					cell.setCellValue(obj[4]!=null?obj[4].toString():"-"); 
					cell.setCellStyle(t_body_style2);
					
					cell= t_body_row.createCell(3); 
					cell.setCellValue(obj[5]!=null?obj[5].toString():"-"); 
					cell.setCellStyle(t_body_style2);
					
					cell= t_body_row.createCell(4); 
					cell.setCellValue(obj[6]!=null?obj[6].toString():"-");
					cell.setCellStyle(t_body_style2);
					
					cell= t_body_row.createCell(5); 
					cell.setCellValue(obj[7]!=null?obj[7].toString():"-");
					cell.setCellStyle(t_body_style2);
					
					cell= t_body_row.createCell(6); 
					cell.setCellValue(obj[8]!=null?obj[8].toString():"-");
					cell.setCellStyle(t_body_style2);
					
					Duration duration = Duration.between(LocalTime.parse(obj[6].toString()), LocalTime.parse(obj[8].toString()));
				    
					long totalSeconds = Math.abs(duration.getSeconds());
			        long hours = totalSeconds / 3600;
			        long minutes = (totalSeconds % 3600) / 60;
			        long seconds = totalSeconds % 60;
			        
					cell= t_body_row.createCell(7); 
					cell.setCellValue(String.format("%s%02d:%02d:%02d", duration.isNegative() ? "-" : "",hours, minutes, seconds));
					cell.setCellStyle(t_body_style2);
					
				}
			}
			
			
			String path = req.getServletContext().getRealPath("/view/temp");
			String fileLocation = path.substring(0, path.length() - 1) + "temp.xlsx";

			FileOutputStream outputStream = new FileOutputStream(fileLocation);
			workbook.write(outputStream);
			workbook.close();
			
			
			String filename="Time_Sheet_List";
			
     
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
			logger.error(new Date() +" Inside TimeSheetListExcelReport.htm "+UserId, e);
			e.printStackTrace();
		}
	}

	@RequestMapping(value="TimeSheetExtraDaysExcelReport.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public void timeSheetExtraDaysExcelReport(HttpServletRequest req, HttpSession ses,HttpServletResponse res) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside TimeSheetExtraDaysExcelReport.htm "+UserId);
		try {
			String empId = req.getParameter("empId");
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			String employeeName = req.getParameter("employeeName");
			empId = empId!=null?empId:EmpId;
			
			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.getYear()+"-01-01";
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			List<Object[]> extraworkingDaysList = service.empExtraWorkingDaysList(empId, fromDate, toDate);
			List<Object[]> projectWiseExtraworkingDaysList = service.projectWiseEmpExtraWorkingDaysList(empId, fromDate, toDate);
			List<Object[]> holidayList = service.getHolidayList();
			
			int rowNo=0;
			// Creating a worksheet
			Workbook workbook = new XSSFWorkbook();

			Sheet sheet = workbook.createSheet("Extra_Days");
			sheet.setColumnWidth(0, 2000);
			sheet.setColumnWidth(1, 8000);
			sheet.setColumnWidth(2, 8000);
			sheet.setColumnWidth(3, 5000);
			sheet.setColumnWidth(4, 5000);
			sheet.setColumnWidth(5, 5000);
			sheet.setColumnWidth(6, 2000);
			sheet.setColumnWidth(7, 8000);
			sheet.setColumnWidth(8, 5000);

			XSSFFont font = ((XSSFWorkbook) workbook).createFont();
			font.setFontName("Times New Roman");
			font.setFontHeightInPoints((short) 14);
			font.setBold(true);
			
			XSSFFont font2 = ((XSSFWorkbook) workbook).createFont();
			font2.setFontName("Times New Roman");
			font2.setFontHeightInPoints((short) 11);
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
			
			// style for table cells with right align
			CellStyle t_body_style3 = workbook.createCellStyle();
			t_body_style3.setWrapText(true);
			t_body_style3.setAlignment(HorizontalAlignment.RIGHT);
			t_body_style3.setVerticalAlignment(VerticalAlignment.TOP);
			
			CellStyle file_header_Style2 = workbook.createCellStyle();
			file_header_Style2.setLocked(true);
			file_header_Style2.setFont(font2);
			file_header_Style2.setWrapText(true);
			file_header_Style2.setAlignment(HorizontalAlignment.RIGHT);
			file_header_Style2.setVerticalAlignment(VerticalAlignment.CENTER);	
			
			Row file_header_row2 = sheet.createRow(rowNo++);
			sheet.addMergedRegion(new CellRangeAddress(0, 0,0, 8));   // Merging Header Cells 
			Cell cell11= file_header_row2.createCell(0);
			cell11.setCellValue("Employee : "+employeeName+"                                               "
					+ "Selected Period : "+fc.sdfTordf(fromDate)+"  to  "+fc.sdfTordf(toDate));
			cell11.setCellStyle(file_header_Style2);
			
			// File header Row
			Row file_header_row = sheet.createRow(rowNo++);
			sheet.addMergedRegion(new CellRangeAddress(1, 1,0, 3));   // Merging Header Cells 
			Cell cell= file_header_row.createCell(0);
			cell.setCellValue("Extra Days");
			file_header_row.setHeightInPoints((3*sheet.getDefaultRowHeightInPoints()));
			cell.setCellStyle(file_header_Style);
			
			

			// Table in file header Row
			Row t_header_row = sheet.createRow(rowNo++);
			cell= t_header_row.createCell(0); 
			cell.setCellValue("SN"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(1); 
			cell.setCellValue("Date"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(2); 
			cell.setCellValue("Day"); 
			cell.setCellStyle(t_header_style);
			
			cell= t_header_row.createCell(3); 
			cell.setCellValue("Total Hours"); 
			cell.setCellStyle(t_header_style);
			
			
			if(extraworkingDaysList!=null && extraworkingDaysList.size()>0) {
				int slno=0;
				for(Object[] obj : extraworkingDaysList) {
					
					String holidayName = holidayList!=null && holidayList.size()>0? holidayList.stream()
										.filter(e -> e[1].equals(obj[4]))
										.map(e -> e[2].toString()).findFirst().orElse(null):null;
					
					Row t_body_row = sheet.createRow(rowNo++);
					cell= t_body_row.createCell(0); 
					cell.setCellValue(++slno); 
					cell.setCellStyle(t_body_style2);
					
					
					cell= t_body_row.createCell(1); 
					cell.setCellValue(obj[4]!=null?fc.sdfTordf(obj[4].toString()):"-"); 
					cell.setCellStyle(t_body_style2);
					
					cell= t_body_row.createCell(2); 
					cell.setCellValue(obj[4]!=null?LocalDate.parse(obj[4].toString()).getDayOfWeek()+""+(holidayName!=null?" ("+holidayName+") ":""):"-"); 
					cell.setCellStyle(t_body_style);
					
					cell= t_body_row.createCell(3); 
					cell.setCellValue(obj[5]!=null?obj[5]+":00":"-");
					cell.setCellStyle(t_body_style2);
					
				}
			}
			
			
			// File header2 Row
			sheet.addMergedRegion(new CellRangeAddress(1, 1,6, 8));   // Merging Header Cells 
			Cell cell2= file_header_row.createCell(6);
			cell2.setCellValue("Project Wise Extra Hrs");
			file_header_row.setHeightInPoints((3*sheet.getDefaultRowHeightInPoints()));
			cell2.setCellStyle(file_header_Style);
			
			// Table in file header Row
			cell2= t_header_row.createCell(6); 
			cell2.setCellValue("SN"); 
			cell2.setCellStyle(t_header_style);
			
			cell2= t_header_row.createCell(7); 
			cell2.setCellValue("Project"); 
			cell2.setCellStyle(t_header_style);
			
			cell2= t_header_row.createCell(8); 
			cell2.setCellValue("No of Hours"); 
			cell2.setCellStyle(t_header_style);
			
			rowNo=3;
			if(projectWiseExtraworkingDaysList!=null && projectWiseExtraworkingDaysList.size()>0) {
				int slno=0;
				for(Object[] obj : projectWiseExtraworkingDaysList) {
					
					Row t_body_row = sheet.getRow(rowNo++);
					cell2= t_body_row.createCell(6); 
					cell2.setCellValue(++slno); 
					cell2.setCellStyle(t_body_style2);
					
					cell2= t_body_row.createCell(7); 
					cell2.setCellValue(obj[2]!=null?obj[2].toString():"-"); 
					cell2.setCellStyle(t_body_style2);
					
					cell2= t_body_row.createCell(8); 
					cell2.setCellValue(obj[3]!=null?obj[3].toString():"-"); 
					cell2.setCellStyle(t_body_style2);
				}
			}
					
			
			String path = req.getServletContext().getRealPath("/view/temp");
			String fileLocation = path.substring(0, path.length() - 1) + "temp.xlsx";

			FileOutputStream outputStream = new FileOutputStream(fileLocation);
			workbook.write(outputStream);
			workbook.close();
			
			
			String filename="Extra_Days";
			
     
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
			logger.error(new Date() +" Inside TimeSheetExtraDaysExcelReport.htm "+UserId, e);
			e.printStackTrace();
		}
	}

	@RequestMapping(value="ProjectTimeSheetPdfReport.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public void projectTimeSheetPdfReport(HttpServletRequest req, HttpSession ses,HttpServletResponse res) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String LoginType = (String)ses.getAttribute("LoginType");
		logger.info(new Date() + " Inside ProjectTimeSheetPdfReport.htm "+UserId);
		try {
			String projectId = req.getParameter("projectId");
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			String projectName = req.getParameter("projectName");
			
			projectId = projectId==null?"A":projectId;
			projectName = projectName!=null && !projectName.isEmpty()?projectName:"All";
			
			req.setAttribute("fromDate", fromDate);
			req.setAttribute("toDate", toDate);
			req.setAttribute("projectName", projectName);
			req.setAttribute("totalHrs", req.getParameter("totalHrs"));
			req.setAttribute("cadreType", req.getParameter("cadreType"));
			
			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			req.setAttribute("workingHrsList", service.getProjectTimeSheetWorkingHrsList(labcode, LoginType, projectId, fromDate, toDate));
			
			String filename="Project_Time_Sheet";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/ProjectTimeSheetPdfReport.jsp").forward(req, customResponse);
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
			
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectTimeSheetPdfReport.htm "+UserId, e);
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="TimeSheetListPdfReport.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public void timeSheetListPdfReport(HttpServletRequest req, HttpSession ses,HttpServletResponse res) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String LoginType = (String)ses.getAttribute("LoginType");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside TimeSheetListPdfReport.htm "+UserId);
		try {
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			
			req.setAttribute("fromDate", fromDate);
			req.setAttribute("toDate", toDate);
			
			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			req.setAttribute("workingHrsList", service.getAllEmpTimeSheetWorkingHrsList(labcode, LoginType, EmpId, fromDate, toDate));
			
			String filename="Time_Sheet_List";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/TimeSheetListPdfReport.jsp").forward(req, customResponse);
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
			
		}catch (Exception e) {
			logger.error(new Date() +" Inside TimeSheetListPdfReport.htm "+UserId, e);
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="TimeSheetExtraDaysPdfReport.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public void timeSheetExtraDaysPdfReport(HttpServletRequest req, HttpSession ses,HttpServletResponse res) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside TimeSheetExtraDaysPdfReport.htm "+UserId);
		try {
			String empId = req.getParameter("empId");
			String fromDate = req.getParameter("fromDate");
			String toDate = req.getParameter("toDate");
			empId = empId!=null?empId:EmpId;
			
			req.setAttribute("fromDate", fromDate);
			req.setAttribute("toDate", toDate);
			req.setAttribute("employeeName", req.getParameter("employeeName"));
			
			LocalDate today=LocalDate.now();
			if(fromDate==null) {
				fromDate=today.minusMonths(1).toString();
				toDate = today.toString();
				
			}else{
				fromDate=fc.rdfTosdf(fromDate);
				toDate=fc.rdfTosdf(toDate);
			}
			
			req.setAttribute("extraworkingDaysList", service.empExtraWorkingDaysList(empId, fromDate, toDate));
			req.setAttribute("projectWiseExtraworkingDaysList", service.projectWiseEmpExtraWorkingDaysList(empId, fromDate, toDate));
			req.setAttribute("holidayList", service.getHolidayList());
			
			String filename="Extra_Days";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/TimeSheetExtraDaysPdfReport.jsp").forward(req, customResponse);
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
			
		}catch (Exception e) {
			logger.error(new Date() +" Inside TimeSheetExtraDaysPdfReport.htm "+UserId, e);
			e.printStackTrace();
		}
	}
	
}
