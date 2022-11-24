package com.vts.pfms.committee.controller;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Hex;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.committee.dao.ActionSelfDao;
import com.vts.pfms.committee.dto.ActionAssignDto;
import com.vts.pfms.committee.dto.ActionMainDto;
import com.vts.pfms.committee.dto.ActionSubDto;
import com.vts.pfms.committee.dto.MeetingExcelDto;
import com.vts.pfms.committee.model.ActionAssign;
import com.vts.pfms.committee.model.ActionAttachment;
import com.vts.pfms.committee.model.ActionMain;
import com.vts.pfms.committee.service.ActionService;
import com.vts.pfms.milestone.dto.MileEditDto;


@Controller
public class ActionController {
	
//	@Autowired
//	private Configuration configuration;
	
	@Autowired
	ActionService service;
	
	@Value("${File_Size}")
	String file_size;
	
	private static final Logger logger=LogManager.getLogger(ActionController.class);
	FormatConverter fc=new FormatConverter();
	@RequestMapping(value = "ActionLaunch.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ActionLaunch(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ActionLaunch.htm "+UserId);		
		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String Logintype= (String)ses.getAttribute("LoginType");

			String action=req.getParameter("Action");
			if(action!=null && "ReAssign".equalsIgnoreCase(action)) {
				String ActionAssignid = req.getParameter("ActionAssignid");
				String projectid = req.getParameter("ProjectId");
				Object[]  projectdata = service.GetProjectData(projectid);
				Object[]  actiondata = service.GetActionReAssignData(ActionAssignid);
				req.setAttribute("actiondata", actiondata);
				req.setAttribute("ProjectData", projectdata);
			}
			
			req.setAttribute("ProjectList", service.LoginProjectDetailsList(EmpId,Logintype,LabCode));  
			req.setAttribute("AssignedList", service.AssignedList(EmpId));
			req.setAttribute("EmployeeListModal", service.EmployeeList(LabCode));
			req.setAttribute("AllLabList", service.AllLabList());
			req.setAttribute("LabCode", LabCode);
			
		
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside ActionLaunch.htm "+UserId, e);
		}
		return "action/ActionLaunch";
	}

	@RequestMapping(value = "ActionStatus.htm" , method = RequestMethod.POST)
	public String ActionStatus (HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionStatus.htm "+UserId);	
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionStatus.htm "+UserId, e);
		}
		return "action/ActionStatus";
	}
	
	
	@RequestMapping(value = "ActionAssigneeEmpList.htm", method = RequestMethod.GET)
	public @ResponseBody String ActionAssigneeEmpList(HttpServletRequest req,HttpSession ses) throws Exception 
	{
		String UserId = (String)ses.getAttribute("Username");
		String clusterid =(String) ses.getAttribute("clusterid");
		logger.info(new Date() +" Inside ActionAssigneeEmpList.htm "+ UserId);
		
		List<Object[]> EmployeeList = new ArrayList<Object[]>();
		
		try {
			String CpLabCode = req.getParameter("LabCode");
			
			if(CpLabCode.trim().equalsIgnoreCase("@EXP")) 
			{
				EmployeeList = service.ClusterExpertsList();
			}
			else
			{
				String CpLabClusterId = service.LabInfoClusterLab(CpLabCode)[1].toString(); 
				
				if(Long.parseLong(clusterid) == Long.parseLong(CpLabClusterId)) 
				{
					EmployeeList = service.LabEmployeeList(CpLabCode.trim());
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionAssigneeEmpList.htm "+UserId, e);
		}
		
		Gson json = new Gson();
		return json.toJson(EmployeeList);	
	}
	
	
	
	
	@RequestMapping(value = "ActionAssigneeEmployeeList.htm", method = RequestMethod.GET)
	public @ResponseBody String ActionAssigneeEmployeeList(HttpServletRequest req,HttpSession ses) throws Exception 
	{
		String UserId = (String)ses.getAttribute("Username");
		String clusterid =(String) ses.getAttribute("clusterid");
		logger.info(new Date() +" Inside ActionAssigneeEmployeeList.htm"+ UserId);
		
		List<Object[]> EmployeeList = new ArrayList<Object[]>();
		
		try {
			String CpLabCode = req.getParameter("LabCode");
			String mainid = req.getParameter("MainId");

			if(mainid!=null && mainid!="" && !"0".equalsIgnoreCase(mainid)){
				
				if(CpLabCode.trim().equalsIgnoreCase("@EXP")) 
				{
					EmployeeList = service.ClusterExpertsList();
					
				}else{
					String CpLabClusterId = service.LabInfoClusterLab(CpLabCode)[1].toString(); 
					if(Long.parseLong(clusterid) == Long.parseLong(CpLabClusterId)) 
					{
						EmployeeList = service.LabEmployeeList(CpLabCode.trim());
					}
				}
			}else {
				if(CpLabCode.trim().equalsIgnoreCase("@EXP")) 
				{
					EmployeeList = service.ClusterExpertsList();
				}else{
					String CpLabClusterId = service.LabInfoClusterLab(CpLabCode)[1].toString(); 
					if(Long.parseLong(clusterid) == Long.parseLong(CpLabClusterId)) 
					{
						EmployeeList = service.LabEmployeeList(CpLabCode.trim());
					}
				}
				
			}

		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionAssigneeEmployeeList.htm "+UserId, e);
		}
		
		Gson json = new Gson();
		return json.toJson(EmployeeList);	
	}
	
	@RequestMapping(value = "ActionDetailsAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String ActionDetailsAjax(HttpServletRequest req, HttpSession ses) throws Exception {
		Gson json = new Gson();
		Object[] ActionDetails=null;
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionDetailsAjax.htm "+UserId);		
		try {
			
			ActionDetails =   service.ActionDetailsAjax(req.getParameter("actionid"),req.getParameter("assignid") );
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionDetailsAjax.htm "+UserId, e);
		}
		return json.toJson(ActionDetails);
	}
	
	
	
	@RequestMapping(value = "ActionSubmit.htm", method = RequestMethod.POST)
	public String ActionSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ActionSubmit.htm "+UserId);	
		try {

			ActionMainDto mainDto=new ActionMainDto();
			
			
			mainDto.setMainId(req.getParameter("MainActionId"));
			mainDto.setActionItem(req.getParameter("ActionItem"));
			mainDto.setActionLinkId(req.getParameter("OldActionNoId"));
			mainDto.setProjectId(req.getParameter("ProjectId"));
			mainDto.setActionDate(req.getParameter("MainPDC"));
			mainDto.setScheduleMinutesId(req.getParameter("scheduleminutesid"));
			mainDto.setActionStatus("A");
			mainDto.setType(req.getParameter("Type"));
			mainDto.setPriority(req.getParameter("MainPriority"));
			mainDto.setCategory(req.getParameter("MainCategory"));
			
			if(req.getParameter("Atype")!="" && req.getParameter("Atype")!=null) {
				mainDto.setActionType(req.getParameter("Atype"));
			}else {
				mainDto.setActionType("N");
			}
			mainDto.setLabName((String)ses.getAttribute("labcode"));
			mainDto.setActivityId("0");
			mainDto.setCreatedBy(UserId);
			mainDto.setMeetingDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			String actionlevel = req.getParameter("ActionLevel");
			
			if(actionlevel !="" &&actionlevel!=null) {
				long level = Long.parseLong(actionlevel)+1;
				mainDto.setActionLevel(level);
				
			}else {
				mainDto.setActionLevel(1L);
			}
			mainDto.setActionParentId(req.getParameter("ActionParentid"));
			ActionAssignDto assign = new ActionAssignDto();
			
			assign.setActionDate(req.getParameter("MainPDC"));
			assign.setAssigneeList(req.getParameterValues("Assignee"));
			assign.setAssignor((Long) ses.getAttribute("EmpId"));
			assign.setAssigneeLabCode(req.getParameter("AssigneeLabCode"));
			assign.setAssignorLabCode(LabCode);
			assign.setRevision(0);
			assign.setActionFlag("N");		
			assign.setActionStatus("A");
			assign.setCreatedBy(UserId);
			assign.setIsActive(1);
			assign.setMeetingDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			long count =service.ActionMainInsert(mainDto , assign);
			if (count > 0) {
				redir.addAttribute("result", "Action Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Action Add Unsuccessful");
			}
		
		}catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside ActionSubmit.htm "+UserId, e);
		}
		return "redirect:/ActionLaunch.htm";
	}
	
	@RequestMapping(value = "AssigneeList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String AssigneeList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside AssigneeList.htm "+UserId);		
		try {
			
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();	
		System.out.println(service.AssigneeList(EmpId).size());
		req.setAttribute("AssigneeList", service.AssigneeList(EmpId));
		
		}catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside AssigneeList.htm "+UserId, e);
		}
		return "action/AssigneeList";
	}

	
	@RequestMapping(value = "ActionSubLaunch.htm", method = RequestMethod.POST)
	public String ActionSubLaunch(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionSubLaunch.htm "+UserId);		
		try {		
			String AssignerName=req.getParameter("Assigner");
			req.setAttribute("Assignee", service.AssigneeData(req.getParameter("ActionMainId") ,req.getParameter("ActionAssignid")).get(0));
			req.setAttribute("SubList", service.SubList(req.getParameter("ActionAssignid")));
			req.setAttribute("LinkList", service.SubList(""));
			req.setAttribute("AssignerName", AssignerName);
			req.setAttribute("actiono", req.getParameter("ActionNo"));
			req.setAttribute("filesize",file_size);
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionSubLaunch.htm "+UserId, e);
		}
		return "action/AssigneeUpdate";
	}
	
	@RequestMapping(value = "SubSubmit.htm", method = RequestMethod.POST)
	public String SubSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart("FileAttach") MultipartFile FileAttach) throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside SubSubmit.htm "+UserId);		
		try {
			
			
			redir.addFlashAttribute("ActionMainId", req.getParameter("ActionMainId"));
			redir.addFlashAttribute("ActionAssignId", req.getParameter("ActionAssignId"));
			ActionSubDto subDto=new ActionSubDto();
			subDto.setFileName(req.getParameter("FileName"));
			subDto.setFileNamePath(FileAttach.getOriginalFilename());
			subDto.setFilePath(FileAttach.getBytes());
            subDto.setCreatedBy(UserId);
            subDto.setActionAssignId(req.getParameter("ActionAssignId"));
            subDto.setRemarks(req.getParameter("Remarks"));
            subDto.setProgress(req.getParameter("Progress"));
            subDto.setProgressDate(req.getParameter("AsOnDate"));
			Long count=service.ActionSubInsert(subDto);
            
			if (count > 0) {
				redir.addAttribute("result", "Action  Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "Action Update Unsuccessful");
			}

		
		
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside SubSubmit.htm "+UserId, e);
		}

		return "redirect:/ActionSubLaunchRedirect.htm";
	}
	
	@RequestMapping(value = "ActionSubLaunchRedirect.htm", method = RequestMethod.GET)
	public String ActionSubLaunchRedirect(Model model,HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionSubLaunchRedirect.htm "+UserId);		
		try {
			  String MainId=null;
			  String AssignId=null;
				 Map md = model.asMap();
				   
				    	
				    	MainId = (String) md.get("ActionMainId");
				    	AssignId = (String)md.get("ActionAssignId");
				    
				    if(MainId==null|| AssignId==null) {
				    	 redir.addAttribute("resultfail", "Refresh Not Allowed");
				    	return "redirect:/AssigneeList.htm";
				    }
				
		    Object[] data=service.AssigneeData(MainId ,AssignId).get(0);
		    
		   
		     String AssignerName=data[1]+", "+data[2]; 		     
		     
		     
		     req.setAttribute("Assignee", data);
		     req.setAttribute("SubList", service.SubList(data[19].toString()));
		     req.setAttribute("AssignerName", AssignerName);
			 req.setAttribute("LinkList", service.SubList(""));
			 req.setAttribute("actiono",data[10].toString() );
			 req.setAttribute("filesize",file_size);
			 List<Object[]> AssigneeDetails=service.AssigneeDetails(data[19].toString());
			 
			 if(AssigneeDetails.size()>0) 
			 {
				 req.setAttribute("AssigneeDetails", AssigneeDetails.get(0));
			 }else
			 {
				 req.setAttribute("AssigneeDetails", null);
			 }
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside ActionSubLaunchRedirect.htm "+UserId, e);
		}
		return "action/AssigneeUpdate";
	}
	
	 @RequestMapping(value = "ActionAttachDownload.htm", method = RequestMethod.GET)
	 public void ActionAttachDownload(HttpServletRequest	 req, HttpSession ses, HttpServletResponse res) throws Exception 
	 {	 
		 String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside ActionAttachDownload.htm "+UserId);		
			try { 
		 
				  ActionAttachment attachment=service.ActionAttachmentDownload(req.getParameter("ActionSubId" ));
		
				  res.setContentType("application/octet-stream");
				  res.setHeader("Content-Disposition", String.format("inline; filename=\"" + attachment.getAttachName()));
				  res.setContentLength((int)attachment.getActionAttach().length);
				  
				  InputStream inputStream = new ByteArrayInputStream(attachment.getActionAttach()); 
				  OutputStream outputStream = res.getOutputStream(); 
				  FileCopyUtils.copy(inputStream, outputStream);
				  
				 inputStream.close(); 
				 outputStream.close();
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionAttachDownload.htm "+UserId, e);
			}
	 }
	 
	 @RequestMapping(value = "ActionSubDelete.htm", method = RequestMethod.POST)
		public String TCCMemberDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

		 String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside ActionSubDelete.htm "+UserId);		
			try { 

			int count = service.ActionSubDelete(req.getParameter("ActionSubId"), UserId);

			if (count > 0) {
				redir.addAttribute("result", "Action Sub Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Action Sub Delete Unsuccessful");

			}
			redir.addFlashAttribute("ActionMainId", req.getParameter("ActionMainId"));
			
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionSubDelete.htm "+UserId, e);
			}

			return "redirect:/ActionSubLaunchRedirect.htm";

		}
	 
	 @RequestMapping(value = "ActionForward.htm", method = RequestMethod.POST)
		public String ActionForward(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		 String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside ActionForward.htm "+UserId);		
			try { 
				
			
			int count = service.ActionForward(req.getParameter("ActionMainId"),req.getParameter("ActionAssignId"), UserId);

			if (count > 0) {
				redir.addAttribute("result", "Action Forwarded Successfully");
			} else {
				redir.addAttribute("resultfail", "Action Forward Unsuccessful");

			}
			redir.addFlashAttribute("ActionAssignId", req.getParameter("ActionAssignId"));
			
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionForward.htm "+UserId, e);
			}

			return "redirect:/AssigneeList.htm";

		}
	 
	 @RequestMapping(value = "ActionForwardList.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String ForwardList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
				throws Exception {
		 
		 	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside ActionForwardList.htm "+UserId);		
			try { 
				String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
				
				req.setAttribute("ForwardList", service.ForwardList(EmpId));
			
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionForwardList.htm "+UserId, e);
			}
			return "action/ForwardList";
		}

	 @RequestMapping(value = "ForwardSub.htm", method = RequestMethod.POST)
		public String ForwardSub(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
				throws Exception {
		 String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside ForwardSub.htm "+UserId);		
			try { 
			String AssigneeName=req.getParameter("Assignee");
			req.setAttribute("actionno", req.getParameter("ActionNo"));
			req.setAttribute("Assignee", service.AssigneeData(req.getParameter("ActionMainId"),req.getParameter("ActionAssignId")).get(0));
			req.setAttribute("SubList", service.SubList(req.getParameter("ActionAssignId")));
			req.setAttribute("AssigneeName", AssigneeName);
			req.setAttribute("LinkList", service.SubList(req.getParameter("ActionLinkId")));
			
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ForwardSub.htm "+UserId, e);
			}
			return "action/ForwardSub";
		}
	
	 
	 @RequestMapping(value = "SendBackSubmit.htm", method = RequestMethod.POST)
		public String SendBackSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

		 	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside SendBackSubmit.htm "+UserId);		
			try { 
				
				int count = service.ActionSendBack(req.getParameter("ActionMainId"),req.getParameter("Remarks"), UserId,req.getParameter("ActionAssignId"));
	
				if (count > 0) {
					redir.addAttribute("result", "Action Sent Back Successfully");
				} else {
					redir.addAttribute("resultfail", "Action SendBack Unsuccessful");
	
				}
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside SendBackSubmit.htm "+UserId, e);
			}
			

			return "redirect:/ActionForwardList.htm";

		}
	 
	 
	 @RequestMapping(value = "CloseSubmit.htm", method = RequestMethod.POST)
		public String CloseSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

		 	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside CloseSubmit.htm "+UserId);		
			try { 

			int count = service.ActionClosed(req.getParameter("ActionMainId"),req.getParameter("Remarks"), UserId,req.getParameter("ActionAssignId"));

			if (count > 0) {
				redir.addAttribute("result", "Action Closed Successfully");
			} else {
				redir.addAttribute("resultfail", "Action Closed Unsuccessful");

			}
			if ("C".equalsIgnoreCase(req.getParameter("sub"))) {
				return "redirect:/ActionLaunch.htm";
			}
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside CloseSubmit.htm "+UserId, e);
			}
		

			return "redirect:/ActionForwardList.htm";
		}
	 
	 
	 @RequestMapping(value = "ActionStatusList.htm")
		public String ActionStatusList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
				throws Exception {
		 
		 	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside ActionStatusList.htm "+UserId);		
			try {
				 	FormatConverter fc=new FormatConverter();
					SimpleDateFormat sdf=fc.getRegularDateFormat();
					SimpleDateFormat sdf1=fc.getSqlDateFormat();
					
					String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
					String fdate=req.getParameter("fdate");
					String tdate=req.getParameter("tdate");
					if(fdate==null)
					{
						if(LocalDate.now().getMonthValue()<=3)
						{
							fdate=fc.getPreviousFinancialYearStartDateSqlFormat();
						}
						else if(LocalDate.now().getMonthValue()>=3)
						{
							fdate=fc.getFinancialYearStartDateSqlFormat();
						}
					}else
					{
						
						fdate=sdf1.format(sdf.parse(fdate));		    
					}
					
					if(tdate==null)
					{
						tdate=LocalDate.now().toString();
					}
					else 
					{
						tdate=sdf1.format(sdf.parse(tdate));				
					}
					
					
					
					req.setAttribute("tdate",tdate);
					req.setAttribute("fdate",fdate);
					req.setAttribute("StatusList", service.StatusList(EmpId,fdate,tdate));
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionStatusList.htm "+UserId, e);
			}
			return "action/ActionStatusList";
		}
	 
	 @RequestMapping(value = "ActionList.htm", method = RequestMethod.GET)
		public String ActionList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
				throws Exception {
		 
		 	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside ActionList.htm "+UserId);		
			try {
				String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
				req.setAttribute("ActionList", service.ActionList(EmpId));			
			}catch(Exception e){
				e.printStackTrace();
				logger.error(new Date() +" Inside ActionList.htm "+UserId, e);
		   }
			return "action/ActionList";
		}
	 
	 

		@RequestMapping(value="CommitteeAction.htm",method= {RequestMethod.GET,RequestMethod.POST})
		public String CommitteeAction(Model model,HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception{
			
			
			
		 	String UserId = (String) ses.getAttribute("Username");
		 	String LabCode = (String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside CommitteeAction.htm "+UserId);		
			try {
			
			String CommitteeScheduleId=null;
			String specname=null;
			String MinutesBack=null;
			
			if(req.getParameter("ScheduleId")!=null) {
				
				CommitteeScheduleId=req.getParameter("ScheduleId");
			}
			else {
				Map md=model.asMap();
				CommitteeScheduleId=(String)md.get("ScheduleId");
				MinutesBack=(String)md.get("minutesback");
			}
			if(CommitteeScheduleId==null) {
				return "redirect:/ActionList.htm";
			}
			
			Map md = model.asMap();
			specname = (String) md.get("specname");
			
			if(req.getParameter("minutesback")!=null) {
				MinutesBack=req.getParameter("minutesback");
			}
			Object[] committeescheduleeditdata=service.CommitteeScheduleEditData(CommitteeScheduleId);
			String projectid =committeescheduleeditdata[9].toString();
		
			req.setAttribute("minutesback", MinutesBack);
			req.setAttribute("specname", specname);
			req.setAttribute("committeescheduleeditdata", committeescheduleeditdata);
			req.setAttribute("AllLabList", service.AllLabList());
			req.setAttribute("labcode", LabCode);
			if(Long.parseLong(projectid)>0)
			{
				req.setAttribute("EmployeeList", service.ProjectEmpList(projectid));
			}else
			{
				req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
			}
			
			req.setAttribute("committeescheduledata",service.CommitteeActionList(CommitteeScheduleId));
			
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside CommitteeAction.htm "+UserId, e);
			}
			

			return "action/CommitteeScheduleActions";
		}
		
		
		@RequestMapping(value = "CommitteeActionSubmit.htm", method = RequestMethod.POST)
		public String CommitteeActionSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
				throws Exception {
			
			String UserId = (String) ses.getAttribute("Username");
			String LabCode = (String)ses.getAttribute("labcode");
			logger.info(new Date() +"Inside CommitteeActionSubmit.htm "+UserId);		
			try {
			
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			
			ActionMainDto mainDto=new ActionMainDto();
			mainDto.setMainId(req.getParameter("MainActionId"));
			mainDto.setActionItem(req.getParameter("Item"));
			mainDto.setProjectId(req.getParameter("ProjectId"));
			mainDto.setActionLinkId(req.getParameter("OldActionNo"));
			mainDto.setActionDate(req.getParameter("DateCompletion"));
			mainDto.setScheduleMinutesId(req.getParameter("scheduleminutesid"));
			mainDto.setType(req.getParameter("Type"));
			mainDto.setPriority(req.getParameter("Priority"));
			mainDto.setCategory(req.getParameter("Category"));
			mainDto.setActionStatus("A");
			mainDto.setActionType("S");
			mainDto.setActivityId("0");
			mainDto.setCreatedBy(UserId);
			mainDto.setMeetingDate(req.getParameter("meetingdate"));
			mainDto.setScheduleId(req.getParameter("ScheduleId"));
			String actionlevel = req.getParameter("ActionLevel");
			
			if(actionlevel !="" &&actionlevel!=null) {
				long level = Long.parseLong(actionlevel)+1;
				mainDto.setActionLevel(level);
				
			}else {
				mainDto.setActionLevel(1L);
			}
			mainDto.setActionParentId(req.getParameter("ActionParentid"));
			
		ActionAssignDto assign = new ActionAssignDto();
			
			assign.setActionDate(req.getParameter("DateCompletion"));
			assign.setAssigneeList(req.getParameterValues("Assignee"));
			assign.setAssignor((Long) ses.getAttribute("EmpId"));
			assign.setAssigneeLabCode(req.getParameter("AssigneeLabCode"));
			assign.setAssignorLabCode(LabCode);
			assign.setRevision(0);
			assign.setActionFlag("N");		
			assign.setActionStatus("A");
			assign.setCreatedBy(UserId);
			assign.setIsActive(1);
			assign.setMeetingDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			long count =service.ActionMainInsert(mainDto,assign);

			if (count > 0) {
				redir.addAttribute("result", "Action Added Successfully For " +req.getParameter("ScheduleSpec"));
			} else {
				redir.addAttribute("resultfail", "Action Add Unsuccessful");
			}
			redir.addFlashAttribute("ScheduleId", req.getParameter("ScheduleId"));
			redir.addFlashAttribute("specname", req.getParameter("specname"));
			redir.addFlashAttribute("minutesback", req.getParameter("minutesback"));
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside CommitteeActionSubmit.htm "+UserId, e);
			}
		
		
		return "redirect:/CommitteeAction.htm";
		}

		
		@RequestMapping(value = "ScheduleActionList.htm", method = RequestMethod.GET)
		public @ResponseBody String ItemDescriptionSearchLedger(HttpServletRequest req, HttpSession ses) throws Exception {
			Gson json = new Gson();
			List<Object[]> ItemDescriptionSearchLedger=new ArrayList<Object[]>();
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside ScheduleActionList.htm "+UserId);		
			try {
			
			
			
			try {
			ItemDescriptionSearchLedger =   service.ScheduleActionList(req.getParameter("ScheduleMinutesId"));
			}catch (Exception e) {
				
			}
			
			
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside ScheduleActionList.htm "+UserId, e);
			}
			
			return json.toJson(ItemDescriptionSearchLedger);

		}
		
		 @RequestMapping(value = "AgendaView.htm", method = RequestMethod.POST)
			public String AgendaView(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
			 
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside AgendaView.htm "+UserId);		
			try {

			
				req.setAttribute("Content",service.MeetingContent(req.getParameter("ActionMainId")).get(0) );
				
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside AgendaView.htm "+UserId, e);
			}
				return "action/AgendaView";

			}
		 
		 @RequestMapping(value = "ActionNoSearch.htm", method = RequestMethod.GET)
			public @ResponseBody String ActionNoSearch(HttpServletRequest req, HttpSession ses) throws Exception {

			 	
			 	List<Object[]> DisDesc = null;
			 	String UserId =(String)ses.getAttribute("Username");
				logger.info(new Date() +"Inside ActionNoSearch.htm "+UserId);		
				try {
					
					DisDesc = service.ActionNoSearch(req.getParameter("ActionSearch"));
				
				}
				catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionNoSearch.htm "+UserId, e);
				}
				Gson json = new Gson();
				return json.toJson(DisDesc);

			}
		 
		 @RequestMapping(value = "ScheduleActionItem.htm", method = RequestMethod.GET)
			public @ResponseBody String ScheduleActionItem(HttpServletRequest req, HttpSession ses) throws Exception {
			
			 String UserId = (String) ses.getAttribute("Username");
				logger.info(new Date() +"Inside ScheduleActionItem.htm "+UserId);		
				Gson json = new Gson();			 
				String ItemDescriptionSearchLedger=null;
				try {
						ItemDescriptionSearchLedger =   service.ScheduleActionItem(req.getParameter("ScheduleMinutesId"));					
				}
				catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ScheduleActionItem.htm "+UserId, e);
				}
				return json.toJson(ItemDescriptionSearchLedger);
			}
		 
		 
			@RequestMapping(value = "ActionReports.htm", method = RequestMethod.GET)
			public String ActionReports(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)	throws Exception 
			{
				String UserId =(String)ses.getAttribute("Username");
				String LabCode = (String)ses.getAttribute("labcode");
				logger.info(new Date() +"Inside ActionReports.htm "+UserId);		
				try {
					String Logintype= (String)ses.getAttribute("LoginType");
					String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
					
					req.setAttribute("Term", "A");
					req.setAttribute("Project", "A");
					req.setAttribute("Type", "A");
					req.setAttribute("ProjectList", service.LoginProjectDetailsList(EmpId, Logintype,LabCode));
					req.setAttribute("StatusList", service.ActionReports(EmpId,"A","A","A", LabCode));	

				}
				catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionReports.htm "+UserId, e);
				}

				return "action/ActionReports";
			}
			
			@RequestMapping(value = "ActionReportSubmit.htm", method = RequestMethod.POST)
			public String ActionReportSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
					throws Exception {
				String UserId =(String)ses.getAttribute("Username");
				String LabCode = (String)ses.getAttribute("labcode");
				logger.info(new Date() +"Inside ActionReportSubmit.htm "+UserId);		
				try {
				
				String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
				
				String Project = "A";
				if(req.getParameter("Project")!=null) {
					Project = req.getParameter("Project");
				}
				String Type = "A";
				
				
				
				if(req.getParameter("Type")!=null) {
					Type = req.getParameter("Type");
//					if(Type.equalsIgnoreCase("A")||Type.equalsIgnoreCase("C")|| Type.equalsIgnoreCase("C")||Type.equalsIgnoreCase("D")|| Type.equalsIgnoreCase("E") ) {
//						Type="M";
//					}
					
				}
				req.setAttribute("ProjectList", service.projectdetailsList(EmpId));
				req.setAttribute("StatusList", service.ActionReports(EmpId,req.getParameter("Term"),Project,Type,LabCode));	
				req.setAttribute("Term", req.getParameter("Term"));
				req.setAttribute("Project",Project);
				req.setAttribute("Type",Type);

				}
				catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionReportSubmit.htm "+UserId, e);
				}			
			
				return "action/ActionReports";
			}
			
			
			@RequestMapping(value = "ActionSearch.htm", method = RequestMethod.GET)
			public String ActionSearch(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
					throws Exception {
				String UserId =(String)ses.getAttribute("Username");
				logger.info(new Date() +"Inside ActionSearch.htm "+UserId);		
				try {
					req.setAttribute("Position", "ASN");
				}
				catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionSearch.htm "+UserId, e);
				}	
				
				return "action/ActionSearch";
			}
			
			@RequestMapping(value = "ActionSearchSubmit.htm", method = RequestMethod.POST)
			public String ActionSearchSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
					throws Exception {
				String UserId =(String)ses.getAttribute("Username");
				logger.info(new Date() +"Inside ActionSearchSubmit.htm "+UserId);		
				try {
				
					String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
								
					req.setAttribute("StatusList", service.ActionSearch(EmpId,req.getParameter("ActionNo"),req.getParameter("Position")));
					req.setAttribute("Position",req.getParameter("Position"));
				
				}
				catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionSearchSubmit.htm "+UserId, e);
				}
				return "action/ActionSearch";
			}
			
			@RequestMapping(value = "ActionPDReports.htm", method = {RequestMethod.GET,RequestMethod.POST})
			public String ActionPDReports(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
					throws Exception {	
				
				String UserId =(String)ses.getAttribute("Username");
				String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
				String LabCode = (String)ses.getAttribute("labcode");
				logger.info(new Date() +"Inside ActionPDReports.htm "+UserId);		
				try {
					String ProjectId=req.getParameter("ProjectId");
					if(ProjectId==null)
					{
						ProjectId="0";
					}
					String Logintype= (String)ses.getAttribute("LoginType");	
					
					req.setAttribute("StatusList", service.LoginProjectDetailsList(EmpId,Logintype,LabCode));					
					req.setAttribute("ProjectId",ProjectId);
				}
				catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside ActionPDReports.htm "+UserId, e);
					return "static/Error";
				}
				return "action/ActionPDReports";
			}
			
			
			 @RequestMapping(value = "ActionCount.htm", method = RequestMethod.GET)
				public @ResponseBody String ActionCount(HttpServletRequest req, HttpSession ses) throws Exception {
				 Gson json = new Gson();
				 Object[] ItemDescriptionSearchLedger=null;
				 String UserId =(String)ses.getAttribute("Username");
					logger.info(new Date() +"Inside ActionCount.htm "+UserId);		
					try {
				 
					
					try {
					ItemDescriptionSearchLedger =   service.ActionCountList(req.getParameter("ProjectId")).get(0);
					}catch (Exception e) {
						
					}
					
					
					
					}
					catch (Exception e) {
						e.printStackTrace();
						logger.error(new Date() +" Inside ActionCount.htm "+UserId, e);
					}
					return json.toJson(ItemDescriptionSearchLedger);

				}
			 
				@RequestMapping(value = "ActionWiseReport.htm", method = RequestMethod.POST)
				public String ActionWiseReport(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
						throws Exception {
					String UserId =(String)ses.getAttribute("Username");
					logger.info(new Date() +"Inside ActionWiseReport.htm "+UserId);		
					try {
										
					req.setAttribute("StatusList", service.ActionWiseReports(req.getParameter("ActionType"),req.getParameter("ProjectId")));	
					req.setAttribute("ProjectId",req.getParameter("ProjectId"));
					req.setAttribute("ActionType",req.getParameter("ActionType"));
					}
					catch (Exception e) {
						e.printStackTrace();
						logger.error(new Date() +" Inside ActionWiseReport.htm "+UserId, e);
					}
				
					return "action/ActionWiseReports";
				} 
				
				
				@RequestMapping(value = "ActionPdcReport.htm", method = { RequestMethod.GET, RequestMethod.POST})
				public String ActionPdcReport(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
						throws Exception {
					String UserId =(String)ses.getAttribute("Username");
					String Logintype= (String)ses.getAttribute("LoginType");
					String LabCode = (String)ses.getAttribute("labcode");
					logger.info(new Date() +"Inside ActionPdcReport.htm "+UserId);		
					try {
					
					FormatConverter fc=new FormatConverter();
					Calendar c= Calendar.getInstance();
					c.add(Calendar.DATE, 30);
					Date d=c.getTime();
					String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
					String fdate=req.getParameter("fdate");
					String tdate=req.getParameter("tdate");
					String Emp=req.getParameter("EmpId");
					String Project=req.getParameter("Project");
					String Position=req.getParameter("Position");
					if(fdate==null)
					{
						    fdate=fc.getRegularDateFormat().format(new Date());
							tdate=fc.getRegularDateFormat().format(d);
							Emp="A";
							Project="A";Position="A";
						
					}
					req.setAttribute("tdate",tdate);
					req.setAttribute("fdate",fdate);
					
					req.setAttribute("ProjectList", service.LoginProjectDetailsList(EmpId,Logintype,LabCode));
					req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
					req.setAttribute("Project",Project);
					req.setAttribute("Employee", Emp);
					req.setAttribute("Position",Position );
					req.setAttribute("StatusList", service.ActionPdcReports(Emp, Project, Position,fdate, tdate));
					
					}
					catch (Exception e) {
						e.printStackTrace();
						logger.error(new Date() +" Inside ActionPdcReport.htm "+UserId, e);
					}
					return "action/ActionPdcReport";
				}
				
				
				 @RequestMapping(value = "ExtendPdc.htm", method = RequestMethod.POST)
					public String ExtendPdc(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

					 	String UserId = (String) ses.getAttribute("Username");
						logger.info(new Date() +"Inside ExtendPdc.htm "+UserId);		
						try { 

						int count = service.ActionExtendPdc(req.getParameter("ActionMainId"),req.getParameter("ExtendPdc"), UserId ,req.getParameter("ActionAssignId"));

						if (count > 0) {
							redir.addAttribute("result", "Action PDC Extended Successfully");
						} else {
							redir.addAttribute("resultfail", "Action PDC Extend Unsuccessful");

						}
						String fwd=req.getParameter("froward");
						if(fwd!=null && fwd.equalsIgnoreCase("Y")) {
							return "redirect:/ActionForwardList.htm";
						}
						
						
						}
						catch (Exception e) {
								e.printStackTrace();
								logger.error(new Date() +" Inside ExtendPdc.htm "+UserId, e);
						}
					

						return "redirect:/ActionLaunch.htm";
					}
				 
					@RequestMapping(value = "CloseAction.htm", method = RequestMethod.POST)
					public String CloseAction(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
							throws Exception {
						String UserId =(String)ses.getAttribute("Username");
						logger.info(new Date() +"Inside CloseAction.htm "+UserId);		
						try {
						req.setAttribute("sub",req.getParameter("sub"));
						req.setAttribute("ActionMainId",req.getParameter("ActionMainId"));
						req.setAttribute("ActionAssignId",req.getParameter("ActionAssignId"));
						req.setAttribute("Assignee", service.AssigneeData(req.getParameter("ActionMainId") , req.getParameter("ActionAssignId")).get(0));
						}
						catch (Exception e) {
							e.printStackTrace();
							logger.error(new Date() +" Inside CloseAction.htm "+UserId, e);
						}
					
						return "action/CloseAction";
					} 	
		 
					@RequestMapping(value = "ActionSelfList.htm", method = {RequestMethod.GET,RequestMethod.POST})
					public String ActionSelf(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
						
						String UserId = (String) ses.getAttribute("Username");
						logger.info(new Date() +"Inside ActionSelfList.htm "+UserId);		
						try {
						String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
						
						

						req.setAttribute("AssignedList", service.ActionSelfList(EmpId));
						
						}
						catch (Exception e) {
								e.printStackTrace();
								logger.error(new Date() +" Inside ActionSelfList.htm "+UserId, e);
						}
						

						return "action/ActionSelf";
					}	
					
					 @RequestMapping(value = "ActionDetails.htm", method = RequestMethod.POST)
						public String ActionDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
								throws Exception {
						 String UserId = (String) ses.getAttribute("Username");
							logger.info(new Date() +"Inside ActionDetails.htm "+UserId);		
							try { 
							String AssigneeName=req.getParameter("Assignee");
							
							
							req.setAttribute("Assignee", service.SearchDetails(req.getParameter("ActionMainId"),req.getParameter("ActionAssignId")).get(0));
							req.setAttribute("SubList", service.SubList(req.getParameter("ActionAssignId")));
							req.setAttribute("AssigneeName", AssigneeName);
							req.setAttribute("LinkList", service.SubList(req.getParameter("ActionLinkId")));
							req.setAttribute("ActionNo", req.getParameter("ActionNo"));
							
							}
							catch (Exception e) {
									e.printStackTrace();
									logger.error(new Date() +" Inside ActionDetails.htm "+UserId, e);
							}
							return "action/ActionDetails";
						}
					 
					 @RequestMapping(value = "ActionWiseAllReport.htm", method = RequestMethod.POST)
						public String ActionWiseAllReport(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
								throws Exception {
							String UserId =(String)ses.getAttribute("Username");
							logger.info(new Date() +"Inside ActionWiseAllReport.htm "+UserId);		
							try {												
							String Logintype= (String)ses.getAttribute("LoginType");
							String ActionType=req.getParameter("ActionType");	
							String ProjectId=req.getParameter("ProjectId");
	
							
							if(ProjectId==null) {
								ProjectId="A";
							}

							if(Logintype.equalsIgnoreCase("Y") || Logintype.equalsIgnoreCase("Z") || Logintype.equalsIgnoreCase("A") )                             
							{
								req.setAttribute("StatusList", service.ActionWiseAllReport(ActionType,"0",ProjectId));
							}
							else if(Logintype.equalsIgnoreCase("P") )
							{
								String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
								req.setAttribute("StatusList", service.ActionWiseAllReport(ActionType,EmpId,ProjectId));
							}
							
								
							req.setAttribute("ProjectId",req.getParameter("ProjectId"));
							req.setAttribute("ActionType",req.getParameter("ActionType"));
							req.setAttribute("ProjectList", service.ProjectList());
							
							}
							catch (Exception e) {
								e.printStackTrace();
								logger.error(new Date() +" Inside ActionWiseAllReport.htm "+UserId, e);
							}						
							return "action/ActionWiseAllReports";
						} 
					 
					 
					 
	@RequestMapping(value = "ActionSelfReminderAdd.htm")
	public String ActionSelfAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionSelfReminderAdd.htm "+UserId);		
		try {	
			FormatConverter fc=new FormatConverter();
			SimpleDateFormat sdf=fc.getRegularDateFormat();
			SimpleDateFormat sdf1=fc.getSqlDateFormat();
			
			String empid = ((Long) ses.getAttribute("EmpId")).toString();
			String fromdate = req.getParameter("fromdate");
			String todate = req.getParameter("todate");	
			
			if(fromdate==null)
			{				
				fromdate=LocalDate.now().minusDays(30).toString();
				todate=LocalDate.now().toString();
			}else
			{
				fromdate=sdf1.format(sdf.parse(fromdate));
				todate=sdf1.format(sdf.parse(todate));				
			}
			
			req.setAttribute("empid", empid);
			req.setAttribute("actionselflist", service.ActionSelfReminderList(empid,fromdate,todate));
						
			fromdate=sdf.format(sdf1.parse(fromdate));
			todate=sdf.format(sdf1.parse(todate));
			
			
			req.setAttribute("todate",todate);
			req.setAttribute("fromdate",fromdate);
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionSelfReminderAdd.htm "+UserId, e);
		}	
		return "action/ActionSelfAdd";
	}
	
	
	@RequestMapping(value = "ActionSelfReminderAddSubmit.htm")
	public String ActionSelfAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId =(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ActionSelfReminderAddSubmit.htm "+UserId);		
		try {	
			String empid=req.getParameter("empid");
			String actiondate=req.getParameter("actiondate");
			String actiontime=req.getParameter("actiontime");
			String actiontype=req.getParameter("actiontype");
			String actionitem=req.getParameter("actionitem");
			ActionSelfDao actionselfdao=new ActionSelfDao();
			actionselfdao.setActionDate(actiondate);
			actionselfdao.setActionTime(actiontime);
			actionselfdao.setActionType(actiontype);
			actionselfdao.setEmpId(empid);
			actionselfdao.setActionItem(actionitem);
			actionselfdao.setCreatedBy(UserId);
			actionselfdao.setLabCode(LabCode);
			long count=0;
			count=service.ActionSelfReminderAddSubmit(actionselfdao);
			if (count > 0) {
				redir.addAttribute("result", "Reminder Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Reminder Add Unsuccessful");
				
				return "redirect:/CommitteeList.htm";
			}			
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionSelfReminderAddSubmit.htm "+UserId, e);
		}	
		return "redirect:/ActionSelfReminderAdd.htm";
	}
				
	@RequestMapping(value = "ActionSelfReminderDelete.htm")
	public String ActionSelfReminderDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionSelfReminderDelete.htm "+UserId);		
		try {	
			int count=0;
			count=service.ActionSelfReminderDelete(req.getParameter("actionid"));
			if (count > 0) {
				redir.addAttribute("result", "Reminder Removed Successfully");
			} else {
				redir.addAttribute("resultfail", "Reminder Removal Unsuccessful");			
			}	
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionSelfReminderDelete.htm "+UserId, e);
		}	
		return "redirect:/ActionSelfReminderAdd.htm";
	}
		
	@RequestMapping(value = "MilActionSubmit.htm", method = RequestMethod.POST)
	public String MilActionSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MilActionSubmit.htm "+UserId);		
		try {
		
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		redir.addFlashAttribute("MilestoneActivityId", req.getParameter("MilestoneActivityId"));
		redir.addFlashAttribute("ActivityId", req.getParameter("ActivityId"));
		redir.addFlashAttribute("ProjectId", req.getParameter("ProjectId"));
		redir.addFlashAttribute("ActivityType", req.getParameter("ActivityType"));
		
		ActionMainDto mainDto=new ActionMainDto();
		mainDto.setMainId(req.getParameter("MainActionId"));
		mainDto.setActionItem(req.getParameter("Item"));
		mainDto.setProjectId(req.getParameter("ProjectId"));
		mainDto.setActionLinkId(req.getParameter("OldActionNo"));
		mainDto.setActionDate(req.getParameter("DateCompletion"));
		mainDto.setScheduleMinutesId(req.getParameter("MilestoneActivityId"));
		mainDto.setActionType("A");
		mainDto.setActionStatus("A");
		mainDto.setCategory(req.getParameter("Category"));
		mainDto.setPriority(req.getParameter("Priority"));
		mainDto.setActivityId(req.getParameter("ActivityId"));
		mainDto.setType("A");
		mainDto.setCreatedBy(UserId);
		mainDto.setMeetingDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		String actionlevel = req.getParameter("ActionLevel");
		if(actionlevel!=null) {
			long level = Long.parseLong(actionlevel)+1;
			mainDto.setActionLevel(level);
			
		}else{
			mainDto.setActionLevel(1L);
		}
		
		ActionAssignDto assign = new ActionAssignDto();
		
		assign.setActionDate(req.getParameter("DateCompletion"));
		assign.setAssigneeList(req.getParameterValues("Assignee"));
		assign.setAssignor((Long) ses.getAttribute("EmpId"));
		assign.setAssigneeLabCode(req.getParameter("AssigneeLabCode"));
		assign.setAssignorLabCode(LabCode);
		assign.setRevision(0);
		assign.setActionFlag("N");		
		assign.setActionStatus("A");
		assign.setCreatedBy(UserId);

		long count =service.ActionMainInsert(mainDto , assign);

		if (count > 0) {
			redir.addAttribute("result", "Action Added Successfully ");
		} else {
			redir.addAttribute("resultfail", "Action Add Unsuccessful");
		}
		
		
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside MilActionSubmit.htm "+UserId, e);
		}
	
	
	return "redirect:/MA-UpdateRedirect.htm";
	}	
	
	
	@RequestMapping(value = "submitMessage.htm")
	public void submitMessage(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside submitMessage.htm "+UserId);		
		try {	
			// Url that will be called to submit the message
			URL sendUrl = new URL("https://www.smsidea.co.in/smsstatuswithid.aspx");
			HttpURLConnection httpConnection = (HttpURLConnection) sendUrl
			.openConnection();
			// This method sets the method type to POST so that will be send as a POST
			httpConnection.setRequestMethod("POST");
			// This method is set as true wince we intend to send input to the server.
			httpConnection.setDoInput(true);
			// This method implies that we intend to receive data from server.
			httpConnection.setDoOutput(true);
			// Implies do not use cached data
			httpConnection.setUseCaches(false);
			// Data that will be sent over the stream to the server.
			DataOutputStream dataStreamToServer = new DataOutputStream(
			httpConnection.getOutputStream());
			dataStreamToServer.writeBytes("mobile="
			+ URLEncoder.encode("9343146866", "UTF-8") + "&pass="
			+ URLEncoder.encode("Vts@12345", "UTF-8") + "&senderid="
			+ URLEncoder.encode("TSTMSG", "UTF-8") + "&to="
			+ URLEncoder.encode("8763259755", "UTF-8") + "&msg="
			+ URLEncoder.encode("Hi , You have a meeting at 8pm", "UTF-8"));
			dataStreamToServer.flush();
			dataStreamToServer.close();
			// Here take the output value of the server.
			BufferedReader dataStreamFromUrl = new BufferedReader(
			new InputStreamReader(httpConnection.getInputStream()));
			String dataFromUrl = "", dataBuffer = "";
			// Writing information from the stream to the buffer
			while ((dataBuffer = dataStreamFromUrl.readLine()) != null) {
			dataFromUrl += dataBuffer;
			}
			/**
			* Now dataFromUrl variable contains the Response received from the
			* server so we can parse the response and process it accordingly.
			*/
			dataStreamFromUrl.close();	
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside submitMessage.htm "+UserId, e);
		}	
		
	}
	
	@RequestMapping(value = "AlertExcelFile.htm", method = RequestMethod.GET)
	public void AlertExcelFile(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception 
	{

		String Username = (String) ses.getAttribute("Username");
		
		logger.info(new Date() +"Inside  AlertExcelFile.htm "+Username);
			try {
				String name="NoData";
				String header="NoData";
			List<Object[]> bookData= service.getActionAlertList();
			if(bookData!=null && bookData.size()>0) {
			name="ActionMeetingAlertList"+new SimpleDateFormat("ddMMyyyy").format(new Date())+".csv";
			header="Action Alert List";
			}
			Workbook  wb=new XSSFWorkbook();  
	
	
			
			Sheet sheet=wb.createSheet("ActionAlertExcel"); 
		     int rowCount=0;
		     
		     
	
				
		
				  
				  	CellStyle heading = wb.createCellStyle();
				  	Font headingfont = wb.createFont();
				  	headingfont.setColor(IndexedColors.LIGHT_BLUE.getIndex());
				  	headingfont.setUnderline(HSSFFont.U_SINGLE);
				  	headingfont.setBold(true);
				  	headingfont.setFontHeightInPoints((short)15);
				  	heading.setFont(headingfont);
				  	heading.setAlignment(HorizontalAlignment.CENTER);
				  	
				  	CellStyle center = wb.createCellStyle();
				  	center.setAlignment(HorizontalAlignment.CENTER);
				  	
				  	CellStyle blue = wb.createCellStyle();
				  	Font bluefont = wb.createFont();
				  	bluefont.setColor(IndexedColors.BLUE.getIndex());
				  	blue.setFont(bluefont);
				  	blue.setAlignment(HorizontalAlignment.CENTER);
				  	blue.setBorderLeft(BorderStyle.THIN);
				  	blue.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	blue.setBorderRight(BorderStyle.THIN);
				  	blue.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	
				  	CellStyle red = wb.createCellStyle();
				  	Font redfont = wb.createFont();
				  	redfont.setColor(IndexedColors.RED.getIndex());
				  	red.setAlignment(HorizontalAlignment.CENTER);
				  	red.setFont(redfont);
				  	red.setBorderLeft(BorderStyle.THIN);
				  	red.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	red.setBorderRight(BorderStyle.THIN);
				  	red.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	
				  	CellStyle brown = wb.createCellStyle();
				  	Font brownfont = wb.createFont();
				  	brownfont.setColor(IndexedColors.BROWN.getIndex());
				  	brown.setFont(brownfont);
					CellStyle rhs = wb.createCellStyle();
				    rhs.setAlignment(HorizontalAlignment.RIGHT);
				    rhs.setBorderBottom(BorderStyle.THIN);
				    rhs.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				    rhs.setBorderLeft(BorderStyle.THIN);
				    rhs.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				    rhs.setBorderRight(BorderStyle.THIN);
				    rhs.setRightBorderColor(IndexedColors.BLACK.getIndex());
				    rhs.setBorderTop(BorderStyle.THIN);
				    rhs.setTopBorderColor(IndexedColors.BLACK.getIndex());
				  	CellStyle  wrapname	 = wb.createCellStyle();
				  	wrapname.setWrapText(true);
				  	wrapname.setBorderBottom(BorderStyle.THIN);
				  	wrapname.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				  	wrapname.setBorderLeft(BorderStyle.THIN);
				  	wrapname.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	wrapname.setBorderRight(BorderStyle.THIN);
				  	wrapname.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	wrapname.setBorderTop(BorderStyle.THIN);
				  	wrapname.setTopBorderColor(IndexedColors.BLACK.getIndex());
				  	String clr="33FFFF";
				    byte[] rgbB = Hex.decodeHex(clr); // get byte array from hex string
				    XSSFColor color = new XSSFColor(rgbB, null);
				    XSSFCellStyle aqua = (XSSFCellStyle)  wb.createCellStyle();
				  	aqua.setFillForegroundColor(color);
				  	aqua.setFillPattern(FillPatternType.SOLID_FOREGROUND);
				  	aqua.setBorderBottom(BorderStyle.THIN);
				  	aqua.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				  	aqua.setBorderLeft(BorderStyle.THIN);
				  	aqua.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	aqua.setBorderRight(BorderStyle.THIN);
				  	aqua.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	aqua.setBorderTop(BorderStyle.THIN);
				  	aqua.setTopBorderColor(IndexedColors.BLACK.getIndex());
				  	
				  	CellStyle  wrap	 = wb.createCellStyle();
				  	wrap.setVerticalAlignment(VerticalAlignment.TOP);
				  	wrap.setAlignment(HorizontalAlignment.CENTER);
				  	wrap.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
				  	wrap.setFillPattern(FillPatternType.SOLID_FOREGROUND);
				  	wrap.setBorderBottom(BorderStyle.THIN);
				  	wrap.setBottomBorderColor(IndexedColors.BLACK.getIndex());
			        wrap.setBorderLeft(BorderStyle.THIN);
			        wrap.setLeftBorderColor(IndexedColors.BLACK.getIndex());
			        wrap.setBorderRight(BorderStyle.THIN);
			        wrap.setRightBorderColor(IndexedColors.BLACK.getIndex());
			        wrap.setBorderTop(BorderStyle.THIN);
			        wrap.setTopBorderColor(IndexedColors.BLACK.getIndex());
				  	wrap.setWrapText(true);
				  	
				  	CellStyle  wrapcontent	 = wb.createCellStyle();
				  	wrapcontent.setVerticalAlignment(VerticalAlignment.TOP);
				  	wrapcontent.setWrapText(true);
	
				  	
				  	
				  	CellStyle  vertical	 = wb.createCellStyle();
				  	vertical.setBorderBottom(BorderStyle.THIN);
				  	vertical.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				  	vertical.setBorderLeft(BorderStyle.THIN);
				  	vertical.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	vertical.setBorderRight(BorderStyle.THIN);
				  	vertical.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	vertical.setBorderTop(BorderStyle.THIN);
				  	vertical.setTopBorderColor(IndexedColors.BLACK.getIndex());
				  	vertical.setVerticalAlignment(VerticalAlignment.TOP);
				  	
	//			  	Center and Border Style
				  	CellStyle  cb = wb.createCellStyle();
				  	cb.setBorderBottom(BorderStyle.THIN);
				  	cb.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				  	cb.setBorderLeft(BorderStyle.THIN);
				  	cb.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	cb.setBorderRight(BorderStyle.THIN);
				  	cb.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	cb.setBorderTop(BorderStyle.THIN);
				  	cb.setTopBorderColor(IndexedColors.BLACK.getIndex());
				  	cb.setAlignment(HorizontalAlignment.CENTER);
				  	cb.setVerticalAlignment(VerticalAlignment.TOP);
	
				  	
	//				Side Borders
				  	
				  	CellStyle  sb = wb.createCellStyle();
				  	sb.setBorderLeft(BorderStyle.THIN);
				  	sb.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	sb.setBorderRight(BorderStyle.THIN);
				  	sb.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	sb.setAlignment(HorizontalAlignment.CENTER);
				  	
				  	CellStyle  lsb = wb.createCellStyle();
				  	lsb.setBorderLeft(BorderStyle.THIN);
				  	lsb.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	lsb.setAlignment(HorizontalAlignment.CENTER);
				  	
				  	CellStyle  rsb = wb.createCellStyle();
				  	rsb.setBorderRight(BorderStyle.THIN);
				  	rsb.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	
					CellStyle  bsb = wb.createCellStyle();
					bsb.setBorderBottom(BorderStyle.THIN);
				  	bsb.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				  	bsb.setFont(redfont);
				  	
				  	CellStyle  top = wb.createCellStyle();
				  	top.setBorderTop(BorderStyle.THIN);
				  	top.setTopBorderColor(IndexedColors.BLACK.getIndex());
				  	top.setFont(redfont);
				  	top.setAlignment(HorizontalAlignment.CENTER);
				  	
				  	CellStyle  leftandside = wb.createCellStyle();
				  	leftandside.setBorderRight(BorderStyle.THIN);
				  	leftandside.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	leftandside.setBorderBottom(BorderStyle.THIN);
				  	leftandside.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				  	leftandside.setAlignment(HorizontalAlignment.CENTER);
				  	
				  	CellStyle  bnt = wb.createCellStyle();
				  	bnt.setBorderBottom(BorderStyle.THIN);
				  	bnt.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				  	bnt.setBorderTop(BorderStyle.THIN);
				  	bnt.setTopBorderColor(IndexedColors.BLACK.getIndex());
				  	
				  	CellStyle  bns = wb.createCellStyle();
				  	bns.setBorderBottom(BorderStyle.THIN);
				  	bns.setBottomBorderColor(IndexedColors.BLACK.getIndex());
				  	bns.setBorderRight(BorderStyle.THIN);
				  	bns.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	bns.setBorderLeft(BorderStyle.THIN);
				  	bns.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	
				  	CellStyle  tns = wb.createCellStyle();
				  	tns.setBorderTop(BorderStyle.THIN);
				  	tns.setTopBorderColor(IndexedColors.BLACK.getIndex());
				  	tns.setBorderRight(BorderStyle.THIN);
				  	tns.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	tns.setBorderLeft(BorderStyle.THIN);
				  	tns.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	tns.setAlignment(HorizontalAlignment.CENTER);
				  	tns.setVerticalAlignment(VerticalAlignment.TOP);
				  	
				  	
	
	//				Content zero
				  	CellStyle  zero = wb.createCellStyle();
				  	zero.setFont(redfont);	
				  	zero.setBorderLeft(BorderStyle.THIN);
				  	zero.setLeftBorderColor(IndexedColors.BLACK.getIndex());
				  	zero.setBorderRight(BorderStyle.THIN);
				  	zero.setRightBorderColor(IndexedColors.BLACK.getIndex());
				  	zero.setBorderTop(BorderStyle.THIN);
				  	zero.setTopBorderColor(IndexedColors.BLACK.getIndex());
				  	zero.setAlignment(HorizontalAlignment.RIGHT);
				  	zero.setVerticalAlignment(VerticalAlignment.TOP);
				    //Row cell = sheet.createRow(rowCount);
				    //cell.setHeightInPoints(80);
				          
			      
				  	 Row row10 = sheet.createRow(rowCount);
				        Cell r10cell1 = row10.createCell(0);
				        Cell r10cell2 = row10.createCell(1);
				        Cell r10cell3 = row10.createCell(2);
				        Cell r10cell4 = row10.createCell(3);
				        Cell r10cell5 = row10.createCell(4);
				        Cell r10cell6 = row10.createCell(5);
				        Cell r10cell7 = row10.createCell(6);
				        
				        r10cell1.setCellValue("MobileNo");
				        r10cell1.setCellStyle(wrapname);
				        r10cell2.setCellValue("Actions");
				        r10cell2.setCellStyle(wrapname);
	
	
	
				      
			            double total=0.00;
				        int count1=1;
	
				        if(!bookData.isEmpty()){
					        for(Object[] hlo :bookData) {
					        	
					        	 List<Object[]> Today=service.getActionToday(hlo[0].toString(), hlo[3].toString());
					 			   List<Object[]> Tommo=service.getActionTommo(hlo[0].toString(), hlo[3].toString());
					               String AiMsg="";
					               int tocount=1;
					               if(Today.size()>0) {
					            	   for(Object[] tod :Today) {
					            		   if(tocount>1) {
					            		   AiMsg=AiMsg.concat(", ");
					            	
					            		   }
					            		   String Pro=null;
					            		   if(!"0".equalsIgnoreCase(tod[1].toString())) {
					            			   Pro="P"+tod[1].toString();
					            		   }else {
					            			   Pro="G";
					            		   }
					            		   String[] str=tod[0].toString().split("/"); 
					            		   AiMsg=AiMsg.concat(Pro+"-"+str[str.length-1]);
	
					            		 tocount++; 
					            	   }
					            	  
					            	   
					               }else {
					            	   AiMsg=AiMsg.concat("T0");
					               }
					               
					               String AiMsgt="";
					               int tmcount=1;
					               if(Tommo.size()>0) {
					            	   for(Object[] tod :Tommo) {
					            		   if(tmcount>1) {
					            		   AiMsgt=AiMsgt.concat(", ");
	
					            		   }
					            		   String Pro=null;
					            		   if(!"0".equalsIgnoreCase(tod[1].toString())) {
					            			   Pro="P"+tod[1].toString();
					            		   }else {
					            			   Pro="G";
					            		   }
					            		   String[] str=tod[0].toString().split("/"); 
					            		   AiMsgt=AiMsgt.concat(Pro+"-"+str[str.length-1]);
					            		 tmcount++; 
					            	   }
					            	  
					            	   
					               }else {
					            	   AiMsgt=AiMsgt.concat("t0");
					               }
					              
					               if(hlo[2]!=null) {
					    		    Row row1 = sheet.createRow(++rowCount);
					 			
					 			    Cell cellsn1 = row1.createCell(0);
								    cellsn1.setCellValue(hlo[2].toString());
								    cellsn1.setCellStyle(wrapname);
					                 Cell cell11 = row1.createCell(1);
					                 cell11.setCellValue(hlo[3].toString()+"-"+hlo[4].toString()+"/C"+hlo[6].toString()+"/D"+hlo[7].toString()+"/P"+hlo[5].toString()+"/"+AiMsg+"/"+AiMsgt);
					                 cell11.setCellStyle(wrapname);  
					               
	
					               }
									
					            
									 count1++;}}
				        
				        
				        ++rowCount;
				   
				         sheet.autoSizeColumn(0);
					     sheet.setColumnWidth(1,8000);
					     sheet.setColumnWidth(2,25000);
					     sheet.setColumnWidth(3,5000);
					     sheet.setColumnWidth(4,8000);
					     sheet.setColumnWidth(5,8000);
					     sheet.setColumnWidth(6,5000);
		        
		        
		
	
		        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
		        wb.write(outByteStream);
		        byte [] outArray = outByteStream.toByteArray();
			
		        res.setContentType("application/ms-excel");
		        res.setHeader("Content-Disposition", "attachment; filename="+name);
		        
		        OutputStream outStream = res.getOutputStream();
		        outStream.write(outArray);
		        outStream.flush();
		        outStream.close();
			    wb.close();
			    outByteStream.close();
			 }
	        catch (Exception e) {
	        	e.printStackTrace();
			    logger.error(new Date() +"Inside AlertExcelFile.htm "+Username, e);
//			    return "static/Error";
		
	        }
	
	}
	
	
	@RequestMapping(value = "MeetingExcelFile.htm", method = RequestMethod.GET)
	public String MeetingExcelFile(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {

		String Username = (String) ses.getAttribute("Username");
		
		logger.info(new Date() +"Inside  MeetingExcelFile.htm "+Username);
		try {
			
		List<Object[]> bookData= service.getMeetingAlertList();
	
	      List<MeetingExcelDto> dto=new ArrayList<MeetingExcelDto>();
            
	        int count1=1;

	        if(!bookData.isEmpty()){
		        for(Object[] hlo :bookData) {
		        	
		 			   List<Object[]> Today=service.getMeetingToday(hlo[0].toString());
		 			   List<Object[]> Tommo=service.getMeetingTommo(hlo[0].toString());
		               if(Today.size()>0) {
		            	   for(Object[] tod :Today) {
								/*
								 * if(tocount>1) { AiMsg=AiMsg.concat(","); TimeMsg=TimeMsg.concat(",");
								 * VenueMsg=VenueMsg.concat(","); }
								 */
		            		   String AiMsg="";
		            		   String Pro=null;
		            		   if(!"0".equalsIgnoreCase(tod[0].toString())) {
		            			   Pro="P"+tod[0].toString();
		            		   }else {
		            			   Pro="G";
		            		   }
		            		   String[] str=tod[1].toString().split("/"); 
		            		   AiMsg=AiMsg.concat(Pro+"-"+str[str.length-3]);
		            		   //TimeMsg=TimeMsg.concat(tod[3].toString());
		            		   //VenueMsg=VenueMsg.concat(tod[4].toString());
		            		   
		            		   
		            		   if(hlo[2]!=null) {
		   		    		    MeetingExcelDto Mdto=new MeetingExcelDto();
		   		 			
		   		 			    
		   					   Mdto.setMobileNo(hlo[2].toString());
		   		               Mdto.setMeetings(AiMsg+" "+tod[3].toString());
		   		               Mdto.setVenue(tod[4].toString());
                               dto.add(Mdto);
		   		               

		   		               }
		            	   }
		            	  
		            	   
		               }
		               
		               if(Tommo.size()>0) {
		            	   for(Object[] tod :Tommo) {
		            		   String AiMsgt="";
		            		   //if(tmcount>1) {
		            		   //AiMsgt=AiMsgt.concat(",");
		            		   //TimeMsgt=TimeMsgt.concat(",");
		            		   //VenueMsgt=VenueMsgt.concat(",");
		            		   //}
		            		   String Pro=null;
		            		   if(!"0".equalsIgnoreCase(tod[0].toString())) {
		            			   Pro="P"+tod[0].toString();
		            		   }else {
		            			   Pro="G";
		            		   }
		            		   String[] str=tod[1].toString().split("/"); 
		            		   AiMsgt=AiMsgt.concat(Pro+"-"+str[str.length-3]);
		            		   //TimeMsgt=TimeMsgt.concat(tod[3].toString());
		            		   //VenueMsgt=VenueMsgt.concat(tod[4].toString());
		            		   
		            		   if(hlo[2]!=null) {
		            			   MeetingExcelDto Mdto=new MeetingExcelDto();
				   		 			
			   		 			    
			   					   Mdto.setMobileNo(hlo[2].toString());
			   		               Mdto.setMeetings(AiMsgt+" "+tod[3].toString());
			   		               Mdto.setVenue(tod[4].toString());
	                               dto.add(Mdto);  
		   		              
		   		               }
		            		   
		            		   
		            	   }
		            	  
		            	   
		               }
		              
		            
						
		            
						 count1++;}}
	        
	        
	       req.setAttribute("MeetingList", dto);
	       

	

		 }
	        catch (Exception e) {
			    logger.error(new Date() +"Inside MeetingExcelFile.htm "+Username, e);
		        }
		
		return "action/MeetingExcel";
	
	}
	
	/*
	 * @RequestMapping(value = "MeetingExcelFile2.htm", method = RequestMethod.GET)
	 * public void MeetingExcelFile2(HttpServletRequest req, HttpSession ses,
	 * HttpServletResponse res) throws Exception {
	 * 
	 * String Username = (String) ses.getAttribute("Username");
	 * 
	 * logger.info(new Date() +"Inside  IccExcelSheet"+Username); try {
	 * WritableWorkbook myFirstWbook = null;
	 * 
	 * String EXCEL_FILE_LOCATION = "E:\\MyFirstExcel.xls"; WorkbookSettings ws =
	 * new WorkbookSettings(); ws.setEncoding("Cp1252"); myFirstWbook
	 * =jxl.Workbook.createWorkbook(new File(EXCEL_FILE_LOCATION),ws);
	 * 
	 * // create an Excel sheet WritableSheet excelSheet =
	 * myFirstWbook.createSheet("Sheet 1", 0);
	 * 
	 * // add something into the Excel sheet Label label = new Label(0, 0,
	 * "Test Count"); excelSheet.addCell(label);
	 * 
	 * jxl.write.Number number = new jxl.write.Number(0, 1, 1);
	 * excelSheet.addCell(number);
	 * 
	 * label = new Label(1, 0, "Result"); excelSheet.addCell(label);
	 * 
	 * label = new Label(1, 1, "Passed"); excelSheet.addCell(label);
	 * 
	 * number = new jxl.write.Number(0, 2, 2); excelSheet.addCell(number);
	 * 
	 * label = new Label(1, 2, "Passed 2"); excelSheet.addCell(label);
	 * 
	 * myFirstWbook.write(); myFirstWbook.close();
	 * 
	 * 
	 * } catch (Exception e) { logger.error(new Date()
	 * +"Inside IccExcelSheet"+Username, e); e.printStackTrace(); }
	 * 
	 * }
	 */
	
	
	@RequestMapping(value = "ProjectEmpListFetchAction.htm", method = RequestMethod.GET )
	public @ResponseBody String ProjectEmpListFetchAction(HttpServletRequest req,HttpSession ses) throws Exception 
	{		
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside ProjectEmpListFetchAction.htm "+ UserId);	
		String projectid=req.getParameter("projectid");
		List<Object[]> EmployeeList=null;
		if(projectid.equalsIgnoreCase("A"))
		{
			EmployeeList=service.AllEmpNameDesigList();
		}else if(Long.parseLong(projectid)>=0)
		{
			EmployeeList=service.EmployeeDropdown(EmpId,Logintype,projectid);
		}
		
		Gson json = new Gson();
		return json.toJson(EmployeeList);
	}
		
	
	
	@RequestMapping(value = "ActionMonitor.htm")
	public String ActionMonitor(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionMonitor.htm "+UserId);		
		try {	
			
			String Logintype= (String)ses.getAttribute("LoginType");
			String fdate=req.getParameter("fdate");
			String tdate=req.getParameter("tdate");
			String assigneeid=req.getParameter("assigneeid");
			
			if(fdate==null) 
			{	
				
			}
			
			req.setAttribute("fdate", fdate);
		    req.setAttribute("tdate", tdate);
		    req.setAttribute("assigneeid", assigneeid);
		    req.setAttribute("Logintype", Logintype);
			return "action/ActionMonitoring";
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionMonitor.htm "+UserId, e);
			return "static/Error";
		}	
		
	}
	
	@RequestMapping(value = "ActionEditSubmit.htm", method = RequestMethod.POST)
	public String ActionEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionEditSubmit.htm "+UserId);	
		int count =0;
		try {
			
			ActionMain main=new ActionMain();
			main.setActionMainId(Long.parseLong(req.getParameter("actionmainid")));
			main.setActionItem(req.getParameter("actionitem"));
			main.setModifiedBy(UserId);
			ActionAssign assign=new ActionAssign();
			assign.setAssigneeLabCode(req.getParameter("modelAssigneeLabCode"));
			assign.setAssignee(Long.parseLong(req.getParameter("Assignee")));
			assign.setActionAssignId(Long.parseLong(req.getParameter("actionassigneid")));
			assign.setModifiedBy(UserId);
			
			 count =service.ActionMainEdit(main);
			 count = service.ActionAssignEdit(assign);
			
			if(count>0) {
				service.ActionExtendPdc(req.getParameter("actionmainid"),req.getParameter("newPDC"), UserId , req.getParameter("actionassigneid"));
			}
	
			if (count > 0) {
				redir.addAttribute("result", "Action Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "Action Update Unsuccessful");
			}
			return "redirect:/ActionLaunch.htm";
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside ActionEditSubmit.htm "+UserId, e);
				return "static/Error";
		}
		
	}
	
	
	@RequestMapping(value = "M-A-Update123.htm")
	public String MileActivityUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String Labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside M-A-Update123.htm "+UserId);
		
		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	        MileEditDto mainDto = new MileEditDto();
			mainDto.setMilestoneActivityId(req.getParameter("MilestoneActivityId"));
			mainDto.setActivityId(req.getParameter("ActivityId"));
			mainDto.setProjectId(req.getParameter("ProjectId"));
			mainDto.setActivityType(req.getParameter("ActivityType"));
			
//			req.setAttribute("StatusList", service.StatusList());
//			req.setAttribute("EmpList", service.ProjectEmpList(req.getParameter("ProjectId") ,Labcode));
//			req.setAttribute("EditData", service.MilestoneActivityEdit(mainDto).get(0));
//			req.setAttribute("EditMain", mainDto);
//			req.setAttribute("SubList", service.MilestoneActivitySub(mainDto));
//			if(req.getParameter("ActivityType").equals("M")) {
//				req.setAttribute("ActionList", service.ActionList("M",req.getParameter("MilestoneActivityId")));
//			}else
//			{
//				req.setAttribute("ActionList", service.ActionList("A",req.getParameter("ActivityId")));	
//			}
//			req.setAttribute("projectdetails",service.ProjectDetails(req.getParameter("ProjectId")).get(0));
//			req.setAttribute("AllLabsList", committeservice.AllLabList());
			
			
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside M-A-Update123.htm "+UserId, e); 
			return "static/Error";
		}

		return "milestone/MileActivityUpdate";

	}
	
	
	@RequestMapping(value = "ActionTree.htm")
	public String ActionTree(HttpServletRequest req, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionTree.htm "+UserId);
		try {
			String ActionAssignId = req.getParameter("ActionAssignId"); 
			
			req.setAttribute("actionslist", service.ActionSubLevelsList(ActionAssignId));
			return "action/ActionTree";
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ActionTree.htm "+UserId, e);		
			return "static/Error";
			
		}		
		
	}
	
	
}
