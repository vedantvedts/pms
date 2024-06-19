package com.vts.pfms.timesheet.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.header.service.HeaderService;
import com.vts.pfms.timesheet.dto.TimeSheetDTO;
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
	
	@RequestMapping(value="TimeSheetDashboard.htm", method= {RequestMethod.GET,RequestMethod.POST})
	public String timeSheetDashboard(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date()+" Inside TimeSheetDashboard.htm "+UserId);
		try {
			
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
		String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+" Inside TimeSheetList.htm "+UserId);
		try {
			String activityDate = req.getParameter("activityDate");
			activityDate = activityDate==null?rdf.format(new Date()):activityDate;
			String activityDateSql = fc.RegularToSqlDate(activityDate);
			req.setAttribute("activityDate", activityDate);
			req.setAttribute("todayScheduleList", headerservice.TodaySchedulesList(EmpId, activityDateSql));
			req.setAttribute("timeSheetData", service.getTimeSheetByDateAndEmpId(EmpId, activityDateSql));
			req.setAttribute("empActivityAssignList", service.getEmpActivityAssignList(EmpId));
			req.setAttribute("empAllTimeSheetList", service.getEmpAllTimeSheetList(EmpId, activityDateSql));
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
							   .ActivityName(req.getParameterValues("activityName"))
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
		logger.info(new Date()+" Inside TimeSheetList.htm "+UserId);
		try {
			String timeSheetId = req.getParameter("timeSheetId");
			String action = req.getParameter("action");
			
			Long result = service.timeSheetDetailsForward(timeSheetId, EmpId, action, UserId);
			
			if(result!=0) {
				redir.addAttribute("result","Time Sheet Details forwarded Successfully");
			}else {
				redir.addAttribute("resultfail","Time Sheet Details forward Unsuccessful");
			}
			
			redir.addAttribute("activityDate", req.getParameter("activityDate"));
			return "redirect:/TimeSheetList.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside TimeSheetDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
}
