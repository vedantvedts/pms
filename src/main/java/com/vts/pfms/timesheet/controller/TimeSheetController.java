package com.vts.pfms.timesheet.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.header.service.HeaderService;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.timesheet.dto.ActionAnalyticsDTO;
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
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date() + " Inside ProjectTimeSheetWorkingHrsList.htm "+UserId);
		Gson json = new Gson();
		List<Object[]> workingHrsList = null;
		try {
			String projectId = req.getParameter("projectId");
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
		List<Object[]> extraworkingDaysList = null;
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
		}catch (Exception e) {
			logger.error(new Date() +" Inside EmpExtraWorkingDayList.htm "+UserId, e);
			e.printStackTrace();
		}
		return json.toJson(extraworkingDaysList);
	}
}
