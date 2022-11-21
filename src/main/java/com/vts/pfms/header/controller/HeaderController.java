package com.vts.pfms.header.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.ArrayList;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.pfms.header.service.HeaderService;

@Controller
public class HeaderController {

	@Autowired
	HeaderService service;
	
	private static final Logger logger=LogManager.getLogger(HeaderController.class);
	
	@RequestMapping(value = "HeaderModuleList.htm" , method = RequestMethod.GET)
	public @ResponseBody String HeaderModuleList(HttpServletRequest request ,HttpSession ses) throws Exception {
		
		Gson json = new Gson();
		List<Object[]> HeaderModuleList = null;
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside HeaderModuleList.htm "+UserId);		
		try {
			String LoginType = ((String) ses.getAttribute("LoginType"));
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String LabCode = (String) ses.getAttribute("labcode");
			String ClusterId =(String)ses.getAttribute("clusterid");
			
			String DGName = service.LabMasterList(ClusterId).stream().filter(e-> "Y".equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()).get(0)[1].toString();

		     String IsDG = "No";
		     if(DGName.equalsIgnoreCase(LabCode))
		    	 IsDG = "Yes";
		     else
		    	 IsDG = "No";
		    	 
		    request.setAttribute("IsDG", "Yes");	
		    HeaderModuleList = service.FormModuleList(LoginType,LabCode);
		    request.setAttribute("ProjectInitiationList", service.ProjectIntiationList(EmpId,LoginType));
		    
		    
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside HeaderModuleList.htm "+UserId, e);
		}
			return json.toJson(HeaderModuleList);
		
		
	}
	
	
	@RequestMapping(value = "LoginTypeChange.htm", method = RequestMethod.POST)
	public String LoginTypeChange(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginTypeChange.htm "+UserId);		
		try {
			ses.setAttribute("LoginAs", req.getParameter("loginType"));
			String LoginType = (String) ses.getAttribute("LoginType");
			
			req.setAttribute("loginTypeList", service.loginTypeList(LoginType));
		
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside LoginTypeChange.htm "+UserId, e);
		}
		
		  
	  	  return "static/MainDashBoard";

	  	  
	}
	
	
	@RequestMapping(value = "NotificationList.htm" , method = RequestMethod.GET)
	public @ResponseBody String NotificationList(HttpServletRequest request ,HttpSession ses) throws Exception {
			
		 List<Object[]> NotificationList =null;
		 Gson json = new Gson();
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside NotificationList.htm "+UserId);		
		try {
		
			String EmpId= ((Long) ses.getAttribute("EmpId")).toString();
			
		    NotificationList = service.NotificationList(EmpId);
		    
		    
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside NotificationList.htm "+UserId, e);
		}
		    
		    
			return json.toJson(NotificationList);
		
		
	}
	
	
	
	@RequestMapping(value = "NotificationUpdate.htm" , method = RequestMethod.GET)
	public @ResponseBody String NotificationUpdate(HttpServletRequest request ,HttpSession ses) throws Exception {
		Gson json = new Gson();
		int count=0;
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside NotificationUpdate.htm "+UserId);		
		try {
			String NotificationId=request.getParameter("notificationid");
			String EmpId= ((Long) ses.getAttribute("EmpId")).toString();
			
		   count= service.NotificationUpdate(NotificationId);
		    
			
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside NotificationUpdate.htm "+UserId, e);
		}
			return json.toJson(count);
			
		
	}
	
	
	@RequestMapping(value = "NotificationListView.htm", method = RequestMethod.GET)
	public String  NotificationListView(HttpServletRequest req,HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside NotificationListView.htm "+UserId);		
		try {
		
		String EmpId= ((Long) ses.getAttribute("EmpId")).toString();		
		req.setAttribute("NotificationList", service.NotificationAllList(EmpId));
		
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside NotificationListView.htm "+UserId, e);
		}

		return "admin/NotificationListView";

	}
	
	@RequestMapping(value = "EmpNameHeader.htm" , method = RequestMethod.GET)
	public @ResponseBody String EmpNameHeader(HttpServletRequest request ,HttpSession ses) throws Exception {
		Object[] EmpNameHeader=null;
		Gson json = new Gson();
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside EmpNameHeader.htm "+UserId);		
		try {
		
			String LoginId= ((Long) ses.getAttribute("LoginId")).toString();
				
			EmpNameHeader= service.EmployeeDetailes(LoginId).get(0);
		 
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside EmpNameHeader.htm "+UserId, e);
		}
			return json.toJson(EmpNameHeader);
	}
	
	@RequestMapping(value = "DivisionNameHeader.htm" , method = RequestMethod.GET)
	public @ResponseBody String DivisionNameHeader(HttpServletRequest request ,HttpSession ses) throws Exception {
		
		String DivisionName=null;
		Gson json = new Gson();
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DivisionNameHeader.htm "+UserId);		
		try {
		String Division= ((Long) ses.getAttribute("Division")).toString();
			
		 DivisionName= service.DivisionName(Division);
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside DivisionNameHeader.htm "+UserId, e);
		}
		    
			return json.toJson(DivisionName);
	}
	
	@RequestMapping(value = "UserManualDoc.htm", method = RequestMethod.GET)
	public void UserManualDoc(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside UserManualDoc.htm "+UserId);		
		try {

			String path = req.getServletContext().getRealPath("/UserManual/" + "User Manual-PFMS.pdf");
	
			res.setContentType("application/pdf");
			res.setHeader("Content-Disposition", String.format("inline; filename=\"" + req.getParameter("path") + "\""));
	
			File my_file = new File(path);
	
			OutputStream out = res.getOutputStream();
			FileInputStream in = new FileInputStream(my_file);
			byte[] buffer = new byte[4096];
			int length;
			while ((length = in.read(buffer)) > 0) {
				out.write(buffer, 0, length);
			}
			in.close();
			out.flush();
			out.close();
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside UserManualDoc.htm "+UserId, e);
		}
	}
	
	@RequestMapping(value = "WorkFlow.htm", method = RequestMethod.GET)
	public void WorkFlow(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside WorkFlow.htm "+UserId);		
		try {

		String path = req.getServletContext().getRealPath("/UserManual/" + "PFMS Work Flow.pdf");

		res.setContentType("application/pdf");
		res.setHeader("Content-Disposition", String.format("inline; filename=\"" + req.getParameter("path") + "\""));

		File my_file = new File(path);

		OutputStream out = res.getOutputStream();
		FileInputStream in = new FileInputStream(my_file);
		byte[] buffer = new byte[4096];
		int length;
		while ((length = in.read(buffer)) > 0) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.flush();
		out.close();
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside WorkFlow.htm "+UserId, e);
		}
	}
	
	
	@RequestMapping(value = "MilestoneManual.htm", method = RequestMethod.GET)
	public void MilestoneManual(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MilestoneManual.htm "+UserId);		
		try {

		String path = req.getServletContext().getRealPath("/UserManual/" + "MilestoneManual.pdf");

		res.setContentType("application/pdf");
		res.setHeader("Content-Disposition", String.format("inline; filename=\"" + req.getParameter("path") + "\""));

		File my_file = new File(path);

		OutputStream out = res.getOutputStream();
		FileInputStream in = new FileInputStream(my_file);
		byte[] buffer = new byte[4096];
		int length;
		while ((length = in.read(buffer)) > 0) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.flush();
		out.close();
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside MilestoneManual.htm "+UserId, e);
		}
	}
	
	@RequestMapping(value = "PasswordChange.htm", method = RequestMethod.GET)
	public String PasswordChange(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside PasswordChange.htm "+UserId);	
		return "admin/PasswordChange";
	}
	
	@RequestMapping(value = "PasswordChange.htm", method = RequestMethod.POST)
	public String PasswordChangeSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside PasswordChange.htm "+UserId);		
		try {
		String Username = (String) ses.getAttribute("Username");  
		String NewPassword =req.getParameter("NewPassword");
		String OldPassword =req.getParameter("OldPassword");
		int count=service.PasswordChange(OldPassword, NewPassword, Username);
		
		if (count > 0) 
		{
			redir.addAttribute("result", "Password Changed Successfully");
		} 
		else 
		{
			redir.addAttribute("resultfail", "Password Change Unsuccessfull ");
		}
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside PasswordChange.htm "+UserId, e);
		}

		return "redirect:/PasswordChange.htm";
		
	}
	
	@RequestMapping (value="GanttChart.htm")
	public String GanttChart(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside GanttChart.htm "+UserId);		
		try {
		
			List<Object[] > ProjectList= service.ProjectList();
			String ProjectId=req.getParameter("ProjectId");
			
			if(ProjectId==null) {
				Object[] FirstProjectId=  ProjectList.get(0);
				ProjectId= FirstProjectId[0].toString();
				
			}
		
		req.setAttribute("ProjectDetails", service.ProjectDetails(ProjectId).get(0));	
		req.setAttribute("ProjectList", ProjectList);	
		req.setAttribute("ProjectId", ProjectId);	
		req.setAttribute("ganttchartlist", service.GanttChartList(ProjectId));
		
		return "admin/GanttChart";
		
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GanttChart.htm "+UserId, e);
			return "static/Error";
		
		}
	}
	
	
	@RequestMapping (value="GanttChartSub.htm", method=RequestMethod.POST)
	public String GanttChartSub(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside GanttChartSub.htm "+UserId);		
		try {
		
			List<Object[] > ProjectList= service.ProjectList();
			String ProjectId=req.getParameter("ProjectId");
			
			if(ProjectId==null) {
				Object[] FirstProjectId=  ProjectList.get(0);
				ProjectId= FirstProjectId[0].toString();
				
			}
					
			req.setAttribute("ProjectDetails", service.ProjectDetails(ProjectId).get(0));	
			req.setAttribute("ProjectList", ProjectList);	
			req.setAttribute("ProjectId", ProjectId);	
			
			if(ProjectId!=null) {
				List<Object[]> main=service.MilestoneActivityList(ProjectId);
				List<Object[]> MilestoneActivityA=new ArrayList<Object[]>();
				List<Object[]> MilestoneActivityB=new ArrayList<Object[]>();
				List<Object[]> MilestoneActivityC=new ArrayList<Object[]>();
				List<Object[]> MilestoneActivityD=new ArrayList<Object[]>();
				List<Object[]> MilestoneActivityE=new ArrayList<Object[]>();
				
					for(Object[] objmain:main ) {
						List<Object[]>  MilestoneActivityA1=service.MilestoneActivityLevel(objmain[0].toString(),"1");
						MilestoneActivityA.addAll(MilestoneActivityA1);
						
						for(Object[] obj:MilestoneActivityA1) {
							List<Object[]>  MilestoneActivityB1=service.MilestoneActivityLevel(obj[0].toString(),"2");
							MilestoneActivityB.addAll(MilestoneActivityB1);
							
							for(Object[] obj1:MilestoneActivityB1) {
								List<Object[]>  MilestoneActivityC1=service.MilestoneActivityLevel(obj1[0].toString(),"3");
								MilestoneActivityC.addAll(MilestoneActivityC1);
								
								for(Object[] obj2:MilestoneActivityC1) {
									List<Object[]>  MilestoneActivityD1=service.MilestoneActivityLevel(obj2[0].toString(),"4");
									MilestoneActivityD.addAll( MilestoneActivityD1);
									
									for(Object[] obj3:MilestoneActivityD1) {
										List<Object[]>  MilestoneActivityE1=service.MilestoneActivityLevel(obj3[0].toString(),"5");
										MilestoneActivityE.addAll( MilestoneActivityE1);
									}
								}
							}
						}
					}
				req.setAttribute("MilestoneActivityMain", main);
				req.setAttribute("MilestoneActivityE", MilestoneActivityE);
				req.setAttribute("MilestoneActivityD", MilestoneActivityD);
				req.setAttribute("MilestoneActivityC", MilestoneActivityC);
				req.setAttribute("MilestoneActivityB", MilestoneActivityB);
				req.setAttribute("MilestoneActivityA", MilestoneActivityA);
							
			}
		
		
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GanttChartSub.htm "+UserId, e);
			return "static/Error";
	}
		
		
		return "admin/GanttChartSub";
	}
	
	
	@RequestMapping(value = "HeaderMenu.htm", method = RequestMethod.GET)
	public @ResponseBody String HeaderSchedulesList(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		List<Object[]> HeaderSchedulesList =null;
		String LabCode = (String) ses.getAttribute("labcode"); 
		logger.info(new Date() +"Inside HeaderSchedulesList.htm "+UserId);

		try {
			HeaderSchedulesList = service.HeaderSchedulesList(req.getParameter("logintype"),req.getParameter("formmoduleid"),LabCode);
					 
		}catch (Exception e) {
			logger.error(new Date() +" Inside HeaderSchedulesList.htm "+UserId, e);
			e.printStackTrace();
		}
		Gson json = new Gson();
		return json.toJson(HeaderSchedulesList);

	}
	

	
}




