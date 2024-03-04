package com.vts.pfms.committee.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.committee.dto.CommitteeScheduleDto;
import com.vts.pfms.committee.dto.EmpAccessCheckDto;
import com.vts.pfms.committee.model.RODMaster;
import com.vts.pfms.committee.service.CommitteeService;
import com.vts.pfms.committee.service.RODServiceImpl;
import com.vts.pfms.mail.MailService;

@Controller
public class RODController {
	
	private static final Logger logger = LogManager.getLogger(RODController.class);
			
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	
	@Autowired 
	CommitteeService committeeservice;
	
	@Autowired
	MailService mailService;
	
	@Value("${File_Size}")
	String file_size;
	
	@Autowired
	RODServiceImpl service;
	
	@RequestMapping(value="RecordofDiscussion.htm")
	public String RecordofDiscussion(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{		
		
		String UserId=(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RecordofDiscussion.htm "+UserId);
		try {
			String Logintype= (String)ses.getAttribute("LoginType");
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String projectId=req.getParameter("projectId");
			String rodNameId=req.getParameter("rodNameId");
			
			List<Object[]> projectdetailslist=committeeservice.LoginProjectDetailsList(EmpId,Logintype,LabCode);
			
			if(projectdetailslist.size()==0) 
			{				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}
			
			if(rodNameId==null)
			{
				rodNameId="all";
			}			
			
			
			if(projectId==null || projectId.equals("null"))
			{
				projectId=projectdetailslist.get(0)[0].toString();
			}
			if(rodNameId==null || rodNameId.equals("all"))
			{				
				req.setAttribute("RODProjectschedulelist", service.rodProjectScheduleListAll(projectId));
			} 
			else 
			{
				req.setAttribute("RODMasterDetails", service.getRODMasterDetails(rodNameId));
				req.setAttribute("RODProjectschedulelist", service.rodProjectScheduleListAll(projectId, rodNameId));				
			}
			
			List<Object[]> rodNameslist = service.rodNamesList();
			
			
			req.setAttribute("projectId",projectId);
			req.setAttribute("rodNameId",rodNameId);
			req.setAttribute("Projectdetails",projectdetailslist.get(0));
			req.setAttribute("ProjectsList",projectdetailslist);
			req.setAttribute("RODNameslist",rodNameslist);
			
			return "rod/RODProjectSchedule";
		}			
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside RecordofDiscussion.htm "+UserId,e);
			return "static/Error";
		}
		
	}
	
//	@RequestMapping(value="AddNewRODName.htm", method=RequestMethod.GET)
//	public @ResponseBody String addNewRODName(HttpSession ses, HttpServletRequest req) throws Exception {
//		String UserId=(String)ses.getAttribute("Username");
//		
//		logger.info(new Date() +"Inside AddNewRODName.htm "+UserId);
//		Gson json = new Gson();
//		
//		long result = 0;
//		try
//		{	
//			RODMaster master = new RODMaster();
//			master.setRODName(req.getParameter("rodName"));
//			master.setCreatedBy(UserId);
//			master.setCreatedDate(sdtf.format(new Date()));
//			master.setIsActive(1);
//			
//			result = service.addNewRODName(master);
//			
//		}catch (Exception e) {
//			logger.error(new Date() +"Inside AddNewRODName.htm "+UserId ,e);
//		    e.printStackTrace(); 
//		}
//		  
//		return json.toJson(result);
//	}
	
	@RequestMapping(value="AddNewRODName.htm", method=RequestMethod.POST)
	public String addNewRODName(HttpSession ses, HttpServletRequest req,RedirectAttributes redir) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside AddNewRODName.htm "+UserId);
		
		try
		{	
			String projectId=req.getParameter("projectId");
			
			RODMaster master = new RODMaster();
			master.setRODName(req.getParameter("rodName"));
			master.setCreatedBy(UserId);
			master.setCreatedDate(sdtf.format(new Date()));
			master.setIsActive(1);
			
			long result = service.addNewRODName(master);
			if(result!=0) {
				redir.addAttribute("projectId", projectId);
				redir.addAttribute("rodNameId", result);
			}
			
			return "redirect:/RecordofDiscussion.htm";
		}catch (Exception e) {
			logger.error(new Date() +"Inside AddNewRODName.htm "+UserId ,e);
		    e.printStackTrace(); 
		    return "static/Error";
		}
		  
	}
	
	@RequestMapping(value="RODScheduleAddSubmit.htm",method=RequestMethod.POST)
	public String RODScheduleAddSubmit(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RODScheduleAddSubmit.htm "+UserId);
		try
		{
			String projectid=req.getParameter("projectId");
			String rodNameId=req.getParameter("rodNameId");
			
			CommitteeScheduleDto committeescheduledto = new CommitteeScheduleDto(); 
			committeescheduledto.setCommitteeId(Long.parseLong(req.getParameter("committeeId")));
			committeescheduledto.setScheduleDate(req.getParameter("startdate"));
			committeescheduledto.setScheduleStartTime(req.getParameter("starttime"));
			committeescheduledto.setCreatedBy(UserId);
			committeescheduledto.setScheduleFlag("MSC");			
			committeescheduledto.setProjectId(projectid);
			committeescheduledto.setDivisionId(req.getParameter("divisionId"));
			committeescheduledto.setInitiationId(req.getParameter("initiationId"));
			committeescheduledto.setRodNameId(rodNameId);
			committeescheduledto.setLabCode(labcode);
			
			if(projectid!=null && Long.parseLong(projectid)>0) 
			{
				Object[] projectdetails=committeeservice.projectdetails(projectid);				
				committeescheduledto.setConfidential(projectdetails[10].toString());
			}else {
				committeescheduledto.setConfidential("5");
			}
					
			
			long count=0;
			count=service.RODScheduleAddSubmit(committeescheduledto);
			redir.addAttribute("rodNameId",rodNameId);
			
			String rodName=req.getParameter("rodName");
			
			if(count>0)
			{
				redir.addAttribute("result", rodName + " Schedule Added Successfully !");
			}
			else 
			{
				redir.addAttribute("resultfail", "Schedule Adding Failed, Try Again");	
			}			
			redir.addFlashAttribute("scheduleid", String.valueOf(count));
			return "redirect:/RODScheduleAgenda.htm";
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside RODScheduleAddSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="RODScheduleAgenda.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String RODScheduleAgenda(Model model,HttpServletRequest req,HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =ses.getAttribute("labcode").toString().trim();
		logger.info(new Date() +"Inside RODScheduleAgenda.htm "+UserId);
		try
		{
			String CommitteeScheduleId= null;			
			if (req.getParameter("scheduleid") != null) 
			{
				CommitteeScheduleId = (String) req.getParameter("scheduleid");
			} 
			else
			{
				Map md=model.asMap();
				CommitteeScheduleId=(String)md.get("scheduleid");
			}
			Object[] scheduledata= service.RODScheduleEditData(CommitteeScheduleId);
			List<Object[]> committeeagendalist = committeeservice.AgendaList(CommitteeScheduleId);
			
			String projectid = scheduledata[9].toString();
			req.setAttribute("AllLabList", committeeservice.AllLabList());
			req.setAttribute("scheduledata",scheduledata);
			req.setAttribute("projectlist", committeeservice.ProjectList(LabCode));
			req.setAttribute("rodagendalist", committeeagendalist);
			req.setAttribute("labdata", committeeservice.LabDetails(scheduledata[24].toString()));			
			req.setAttribute("filesize",file_size);
			req.setAttribute("projectid",projectid);
			req.setAttribute("filerepmasterlistall",committeeservice.FileRepMasterListAll(projectid,LabCode));
			req.setAttribute("AgendaDocList",committeeservice.AgendaLinkedDocList(CommitteeScheduleId));
			
			req.setAttribute("LabCode",LabCode);
			req.setAttribute("LabEmpList",committeeservice.PreseneterForCommitteSchedule(LabCode.trim()));
			
			return "rod/RODScheduleAgenda";
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside RODScheduleAgenda.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="RODScheduleView.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String RODScheduleView(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeScheduleView.htm "+UserId);
		try
		{
			String UserView=null;
			Map md=model.asMap();
			if(req.getParameter("userview")!=null) {
				UserView=(String)req.getParameter("userview");
			}
			String CommitteeScheduleId=null;
			
			if(req.getParameter("scheduleid")!=null) {
				CommitteeScheduleId=(String)req.getParameter("scheduleid");
			}
			else {
				CommitteeScheduleId=(String)md.get("scheduleid");
			}
			System.out.println(CommitteeScheduleId+"-----");
//			int committeecons=0;
			Object[] rodcheduleeditdata=service.RODScheduleEditData(CommitteeScheduleId);
			String projectid= rodcheduleeditdata[9].toString();
			String rodnameid=rodcheduleeditdata[0].toString();
			String divisionid=rodcheduleeditdata[16].toString();
			String initiationid=rodcheduleeditdata[17].toString();
//			Long committeemainid=null;
//			
//			
//			if(committeemainid==null || committeemainid==0)
//			{
//				committeecons=0;			
//			}
//			else
//			{
//				committeecons=1;				
//			}
			if(Integer.parseInt(projectid)>0)
			{
				req.setAttribute("projectdetails", committeeservice.projectdetails(projectid));
			}
			if(Integer.parseInt(divisionid)>0)
			{
				req.setAttribute("divisiondetails", committeeservice.DivisionData(divisionid));
			}
			if(Integer.parseInt(initiationid)>0)
			{
				req.setAttribute("initiationdetails", committeeservice.Initiationdetails(initiationid));
			}
			
			if(Logintype.equalsIgnoreCase("A") || Logintype.equalsIgnoreCase("Z") || Logintype.equalsIgnoreCase("C")|| Logintype.equalsIgnoreCase("I")) 
			{
				if(md.get("otp")!=null) {
					req.setAttribute("otp", md.get("otp"));
				}
			}
			
//			req.setAttribute("membertype", MemberType);
			req.setAttribute("userview",UserView);			
			req.setAttribute("ReturnData", committeeservice.AgendaReturnData(CommitteeScheduleId));
			req.setAttribute("committeescheduleeditdata", rodcheduleeditdata);
			req.setAttribute("committeeagendalist", committeeservice.AgendaList(CommitteeScheduleId));
			req.setAttribute("committeeinvitedlist", committeeservice.CommitteeAtendance(CommitteeScheduleId));	
			req.setAttribute("employeelist", committeeservice.EmployeeList(LabCode));
			req.setAttribute("pfmscategorylist", committeeservice.PfmsCategoryList());
			req.setAttribute("logintype", Logintype);
//			req.setAttribute("committeecons", committeecons); 
			req.setAttribute("AgendaDocList",committeeservice.AgendaLinkedDocList(CommitteeScheduleId));
			
//			int useraccess=service.ScheduleCommitteeEmpCheck
//					(new EmpAccessCheckDto(Logintype,CommitteeScheduleId,EmpId,
//							rodcheduleeditdata[1], committeecons,
//							rodcheduleeditdata[13].toString()));
//			req.setAttribute("useraccess", useraccess);
			return "rod/RODScheduleView";
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +"Inside RODScheduleView.htm "+UserId,e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "RODAgendasFromPreviousMeetingsAdd.htm")
	 public String RODAgendasFromPreviousMeetingsAdd(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir)
	 {
		 	String UserId =(String)ses.getAttribute("Username");
		 	String LabCode =(String)ses.getAttribute("labcode");
			logger.info(new Date() +"Inside RODAgendasFromPreviousMeetingsAdd.htm "+UserId);		
			try {
				String scheduleidto = req.getParameter("scheduleidto");
				String meetingid = req.getParameter("meetingid");
				String scheduleidfrom=req.getParameter("scheduleidfrom");
				String search = req.getParameter("search");
				
				if(search!=null)
				{
					req.setAttribute("meetingsearch", committeeservice.MeetingSearchList(search,LabCode));					
				}
				
				if(scheduleidfrom!=null)
				{
					req.setAttribute("committeescheduledata1",service.RODScheduleEditData(scheduleidfrom));
					req.setAttribute("agendalist",committeeservice.AgendaList(scheduleidfrom));
					req.setAttribute("meetingid",meetingid);
				}			
				
				req.setAttribute("scheduleidto",scheduleidto);
				req.setAttribute("committeescheduleeditdata",service.RODScheduleEditData(scheduleidto));
				
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside RODAgendasFromPreviousMeetingsAdd.htm "+UserId, e);
			}
		 return "rod/RODPreviousAgendasAdd";
	 }
}
