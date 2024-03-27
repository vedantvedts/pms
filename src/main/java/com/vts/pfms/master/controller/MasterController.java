package com.vts.pfms.master.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.admin.controller.AdminController;
import com.vts.pfms.admin.service.AdminService;
import com.vts.pfms.master.dto.DivisionEmployeeDto;
import com.vts.pfms.master.dto.LabMasterAdd;
import com.vts.pfms.master.dto.OfficerMasterAdd;
import com.vts.pfms.master.model.DivisionGroup;
import com.vts.pfms.master.model.DivisionTd;
import com.vts.pfms.master.model.IndustryPartner;
import com.vts.pfms.master.model.IndustryPartnerRep;
import com.vts.pfms.master.model.MilestoneActivityType;
import com.vts.pfms.master.model.PfmsFeedback;
import com.vts.pfms.master.model.PfmsFeedbackAttach;
import com.vts.pfms.master.service.MasterService;


@Controller
public class MasterController {

	@Autowired
	MasterService service;

	@Autowired
	AdminService adminservice;

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	private static final Logger logger=LogManager.getLogger(MasterController.class);
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	@RequestMapping(value="Officer.htm", method=RequestMethod.GET)
	public String OfficerList(Model model, HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId= (String)ses.getAttribute("Username");
		String LabCode=(String)ses.getAttribute("labcode");
		logger.info(new Date() +" Inside Officer.htm "+UserId);
		String empType=req.getParameter("empType");
		String onboard=req.getParameter("Onboarding");
		if(onboard==null) {
			Map md=model.asMap();
			onboard=(String)md.get("Onboard");
		}
		req.setAttribute("Onboarding", onboard);
		req.setAttribute("OfficerList", service.OfficerList().stream().filter(e-> e[11]!=null).filter(e-> LabCode.equalsIgnoreCase(e[11].toString())).collect(Collectors.toList()));         
		req.setAttribute("AllOfficerList", service.OfficerList());         

		return "master/OfficerMasterList";
	}


	@RequestMapping(value="OfficerAdd.htm", method=RequestMethod.POST)
	public String OfficerAdd(HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{		
		String UserId= (String)ses.getAttribute("Username");
		String LabCode =(String)ses.getAttribute("labcode");
		logger.info(new Date() +" Inside OfficerAdd.htm "+UserId);

		try {
			req.setAttribute("DesignationList", service.DesignationList());
			req.setAttribute("OfficerDivisionList", adminservice.DivisionMasterList(LabCode));
			req.setAttribute("LabList", service.LabList());
			return "master/OfficerMasterAdd";

		}catch (Exception e){
			e.printStackTrace();
			logger.error(new Date() +" Inside OfficerAdd.htm "+UserId , e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "EmpNoCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String EmpNoCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		int len=0;
		logger.info(new Date() +"Inside EmpNoCheck.htm "+UserId);
		try
		{	 
			List<Object[]> DisDesc = null;
			String empno=req.getParameter("empno");					
			DisDesc= service.empNoCheckAjax(empno);
			len=DisDesc.size();
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +"Inside EmpNoCheck.htm "+UserId,e);
		}

		return String.valueOf(len);

	}


	@RequestMapping(value = "ExpEmpNoCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String ExpEmpNoCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		int len=0;
		logger.info(new Date() +"Inside ExpEmpNoCheck.htm "+UserId);
		try
		{	 
			List<Object[]> DisDesc = null;
			String empno=req.getParameter("empno");	
			DisDesc= service.extEmpNoCheckAjax(empno);
			len=DisDesc.size();
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside ExpEmpNoCheck.htm "+UserId,e);
		}

		return String.valueOf(len);

	}


	@RequestMapping(value="Officer.htm", method=RequestMethod.POST)
	public String OfficerListAddEdit(HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{

		String UserId= (String)ses.getAttribute("Username");
		String LabCode =(String)ses.getAttribute("labcode");
		logger.info(new Date() +" Inside Officer.htm "+UserId);

		try {
			String Option=req.getParameter("sub");
			String OfficerId=req.getParameter("Did");		
			if(Option.equalsIgnoreCase("edit")) 
			{		
				req.setAttribute("OfficerEditData", service.OfficerEditData(OfficerId).get(0));
				req.setAttribute("DesignationList", service.DesignationList());
				req.setAttribute("OfficerDivisionList", adminservice.DivisionMasterList(LabCode));
				req.setAttribute("LabList", service.LabList());	
				return "master/OfficerMasterEdit";
			}
			else if(Option.equalsIgnoreCase("updateSeniority")) 
			{
				req.setAttribute("officersDetalis",service.getOfficerDetalis(OfficerId));
				return "master/UpdateSeniority";
			}
			else if(Option.equalsIgnoreCase("delete")) 
			{	
				int count= service.OfficerMasterDelete(OfficerId, UserId);
				if(count>0) {
					redir.addAttribute("result", "Officer Deleted Successfully ");
				}else {
					redir.addAttribute("resultfail","Officer Delete Unsuccessful");
				}	
			}

		}catch (Exception e){
			e.printStackTrace();
			logger.error(new Date() +" Inside Officer.htm "+UserId , e);
			return "static/Error";
		}

		return "redirect:/Officer.htm";
	}




	@RequestMapping (value="OfficerMasterAddSubmit.htm", method=RequestMethod.POST)
	public String OfficerAddSubmit (HttpSession ses, HttpServletRequest  req, HttpServletResponse res, RedirectAttributes redir) throws Exception{

		String UserId= (String)ses.getAttribute("Username");
		String LabCode =(String)ses.getAttribute("labcode");
		logger.info(new Date() +" Inside OfficerMasterAddSubmit.htm "+UserId);
		Integer labid= Integer.parseInt(ses.getAttribute("labid").toString());
		try {
			String EmpNo=req.getParameter("EmpNo");
			List<String> EmpNoCheck=service.EmpNoCheck();
			boolean check=EmpNoCheck.contains(EmpNo);			
			if(check) {
				redir.addAttribute("resultfail","Emp No Already Exists" );
				return "redirect:/Officer.htm";
			}			
			OfficerMasterAdd officermasteradd= new OfficerMasterAdd();
			officermasteradd.setLabId(req.getParameter("labId"));
			officermasteradd.setEmpNo(req.getParameter("EmpNo").toUpperCase());
			officermasteradd.setTitle(req.getParameter("title"));
			officermasteradd.setSalutation(req.getParameter("salutation"));
			String name=req.getParameter("EmpName");			
			String words[]=name.split("\\s");  
			String capitalizeWord="";  
			for(String w:words){  
				String first=w.substring(0,1);  
				String afterfirst=w.substring(1);  
				capitalizeWord+=first.toUpperCase()+afterfirst+" ";  
			}	
			name = name.substring(0,1).toUpperCase() + name.substring(1);
			officermasteradd.setEmpName(capitalizeWord);
			officermasteradd.setDesignation(req.getParameter("Designation"));
			officermasteradd.setExtNo(req.getParameter("ExtNo"));
			officermasteradd.setEmail(req.getParameter("Email"));
			officermasteradd.setDivision(req.getParameter("Division"));
			officermasteradd.setDronaEmail(req.getParameter("DronaEmail"));
			officermasteradd.setInternalEmail(req.getParameter("InternetEmail"));
			officermasteradd.setMobileNo(req.getParameter("mobilenumber"));
			officermasteradd.setSrNo("0");
			officermasteradd.setLabCode(LabCode);

			long count=0;

			try {
				count= service.OfficerMasterInsert(officermasteradd, UserId);	
			}
			catch(Exception e){
				e.printStackTrace();
				return "redirect:/Officer.htm";
			}
			if(count>0) {
				redir.addAttribute("result", "Officer Added Successfully ");
			}else {
				redir.addAttribute("resultfail", "Officer Add Unsuccessful");
			}
		}
		catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside OfficerMasterAddSubmit.htm "+UserId , e);
			return "static/Error";
		}
		return "redirect:/Officer.htm";
	}


	@RequestMapping (value="OfficerMasterEditSubmit.htm", method=RequestMethod.POST)
	public String OfficerMasterEditSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{

		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside OfficerMasterEditSubmit.htm "+UserId);
		try {

			OfficerMasterAdd officermasteradd= new OfficerMasterAdd();
			officermasteradd.setTitle(req.getParameter("title"));
			officermasteradd.setSalutation(req.getParameter("salutation"));
			officermasteradd.setLabId(req.getParameter("labId"));
			officermasteradd.setEmpNo(req.getParameter("EmpNo"));
			officermasteradd.setEmpName(req.getParameter("EmpName"));
			officermasteradd.setDesignation(req.getParameter("Designation"));
			officermasteradd.setExtNo(req.getParameter("ExtNo"));
			officermasteradd.setMobileNo(req.getParameter("mobilenumber"));
			officermasteradd.setEmail(req.getParameter("Email"));
			officermasteradd.setDivision(req.getParameter("Division"));
			officermasteradd.setEmpId(req.getParameter("OfficerId"));
			officermasteradd.setDronaEmail(req.getParameter("DronaEmail"));
			officermasteradd.setInternalEmail(req.getParameter("InternetEmail"));

			int count= service.OfficerMasterUpdate(officermasteradd, UserId);				

			if(count>0) {
				redir.addAttribute("result", "Officer Edited Successfully ");
			}
			else {			
				redir.addAttribute("resultfail", "Officer Edit Unsuccessful");
			}
		}
		catch (Exception e){

			e.printStackTrace();
			logger.error(new Date() +" Inside OfficerMasterEditSubmit.htm "+UserId , e);
			return "static/Error";
		}		
		return "redirect:/Officer.htm";
	}



	@RequestMapping(value="UpdateSenioritySubmit",method=RequestMethod.POST)
	public String updateSenoSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside UpdateSenioritySubmit "+UserId);
		String empid= req.getParameter("empid");
		String newSeniorityNumber=req.getParameter("UpdatedSrNo");
		int result= service.updateSeniorityNumber(empid,newSeniorityNumber);
		if(result>0) {
			redir.addAttribute("result", "Officer Edited Successfully ");
		}
		else {
			redir.addAttribute("resultfail", "Officer Edit Unsuccessful");
		}

		return "redirect:/Officer.htm";
	}

	@RequestMapping(value="OfficerExtList.htm", method=RequestMethod.GET)
	public String OfficerExtList(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{

		String UserId= (String)ses.getAttribute("Username");
		String LabCode= (String)ses.getAttribute("labcode");
		logger.info(new Date() +" Inside OfficerExtList.htm "+UserId);
		try {

			req.setAttribute("OfficerList", service.ExternalOfficerList(LabCode));

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside OfficerExtList.htm "+UserId , e);
			return "static/Error";
		}

		return "master/OfficerExtList";
	}

	@RequestMapping(value="OfficerExtAdd.htm", method=RequestMethod.POST)
	public String OfficerExtAdd(HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{		
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside OfficerExtAdd.htm "+UserId);

		try {
			List<Object[]> OfficerDivisionList = service.OfficerDivisionList();
			req.setAttribute("DesignationList", service.DesignationList());
			req.setAttribute("OfficerDivisionList", OfficerDivisionList);
			req.setAttribute("LabList", service.LabList());

			return "master/OfficerExtAdd";

		}catch (Exception e){
			e.printStackTrace();
			logger.error(new Date() +" Inside OfficerExtAdd.htm "+UserId , e);
			return "static/Error";
		}
	}

	@RequestMapping (value="OfficerExtAddSubmit.htm", method=RequestMethod.POST)
	public String OfficerExtAddSubmit (HttpSession ses, HttpServletRequest  req, HttpServletResponse res, RedirectAttributes redir) throws Exception
	{
		String UserId= (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +" Inside OfficerExtAddSubmit.htm "+UserId);
		try {
			String EmpNo=req.getParameter("EmpNo");
			List<String> EmpNoCheck=service.EmpExtNoCheck();
			boolean check=EmpNoCheck.contains(EmpNo);			
			if(check) {
				redir.addAttribute("resultfail","Emp No Already Exists" );
				return "redirect:/OfficerExtList.htm";
			}			
			OfficerMasterAdd officermasteradd= new OfficerMasterAdd();
			officermasteradd.setLabId(req.getParameter("labId"));
			officermasteradd.setEmpNo(req.getParameter("EmpNo").toUpperCase());
			String name=req.getParameter("EmpName");			
			String words[]=name.split("\\s");  
			String capitalizeWord="";  
			for(String w:words){  
				String first=w.substring(0,1);  
				String afterfirst=w.substring(1);  
				capitalizeWord+=first.toUpperCase()+afterfirst+" ";  
			}	
			name = name.substring(0,1).toUpperCase() + name.substring(1);
			officermasteradd.setTitle(req.getParameter("title"));
			officermasteradd.setSalutation(req.getParameter("salutation"));
			officermasteradd.setEmpName(capitalizeWord);
			officermasteradd.setDesignation(req.getParameter("Designation"));
			officermasteradd.setExtNo(req.getParameter("ExtNo"));
			officermasteradd.setEmail(req.getParameter("Email"));
			officermasteradd.setDivision(req.getParameter("Division"));
			officermasteradd.setDronaEmail(req.getParameter("DronaEmail"));
			officermasteradd.setInternalEmail(req.getParameter("InternetEmail"));
			officermasteradd.setMobileNo(req.getParameter("mobilenumber"));
			officermasteradd.setSrNo("0");
			officermasteradd.setLabCode(labcode);
			long count=0;

			try {
				count= service.OfficerExtInsert(officermasteradd, UserId);	
			}
			catch(Exception e){
				e.printStackTrace();
				return "redirect:/OfficerExtList.htm";
			}
			if(count>0) {
				redir.addAttribute("result", "External Officer Added Successfully ");
			}else {
				redir.addAttribute("resultfail", "External Officer Add Unsuccessful");
			}
			return "redirect:/OfficerExtList.htm";
		}
		catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside OfficerExtAddSubmit.htm "+UserId , e);
			return "static/Error";
		}

	}

	@RequestMapping(value="OfficerExtEdit.htm", method=RequestMethod.POST)
	public String OfficerExtEdit(HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{		
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside OfficerExtEdit.htm "+UserId);

		try {
			String Option=req.getParameter("sub");
			String OfficerId=req.getParameter("Did");		
			if(Option.equalsIgnoreCase("edit")) 
			{		
				req.setAttribute("OfficerEditData", service.ExternalOfficerEditData(OfficerId).get(0));
				req.setAttribute("DesignationList", service.DesignationList());
				req.setAttribute("OfficerDivisionList", service.OfficerDivisionList());
				req.setAttribute("LabList", service.LabList());	
				return "master/OfficerExtEdit";
			}
			else if(Option.equalsIgnoreCase("delete")) 
			{	
				int count= service.OfficerExtDelete(OfficerId, UserId);
				if(count>0) {
					redir.addAttribute("result", "External Officer Deleted Successfully ");
				}else {
					redir.addAttribute("resultfail","External Officer Delete Unsuccessful");
				}	
			}

		}catch (Exception e){
			e.printStackTrace();
			logger.error(new Date() +" Inside OfficerExtEdit.htm "+UserId , e);
			return "static/Error";
		}

		return "redirect:/OfficerExtList.htm";
	}

	@RequestMapping (value="OfficerExtEditSubmit.htm", method=RequestMethod.POST)
	public String OfficerExtEditSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{

		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside OfficerExtEditSubmit.htm "+UserId);
		try {
			OfficerMasterAdd officermasteradd= new OfficerMasterAdd();
			officermasteradd.setLabId(req.getParameter("labId"));
			officermasteradd.setEmpNo(req.getParameter("EmpNo"));
			officermasteradd.setEmpName(req.getParameter("EmpName"));
			officermasteradd.setDesignation(req.getParameter("Designation"));
			officermasteradd.setExtNo(req.getParameter("ExtNo"));
			officermasteradd.setMobileNo(req.getParameter("mobilenumber"));
			officermasteradd.setEmail(req.getParameter("Email"));
			officermasteradd.setDivision(req.getParameter("Division"));
			officermasteradd.setEmpId(req.getParameter("OfficerId"));
			officermasteradd.setDronaEmail(req.getParameter("DronaEmail"));
			officermasteradd.setInternalEmail(req.getParameter("InternetEmail"));	
			officermasteradd.setTitle(req.getParameter("title"));
			officermasteradd.setSalutation(req.getParameter("salutation"));
			int count= service.OfficerExtUpdate(officermasteradd, UserId);							
			if(count>0) {
				redir.addAttribute("result", "External Officer Edited Successfully ");
			}
			else {			
				redir.addAttribute("resultfail", "External Officer Edit Unsuccessful");
			}
			return "redirect:/OfficerExtList.htm";
		}
		catch (Exception e){

			e.printStackTrace();
			logger.error(new Date() +" Inside OfficerExtEditSubmit.htm "+UserId , e);
			return "static/Error";
		}		

	}

	@RequestMapping(value="DivisionEmployee.htm",method= {RequestMethod.POST,RequestMethod.GET})
	public String DivisionEmployee(Model model,HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir)throws Exception {

		String UserId= (String)ses.getAttribute("Username");
		String LabCode =(String)ses.getAttribute("labcode");
		logger.info(new Date() +" Inside DivisionEmployee.htm "+UserId);
		try {
			String divisionid=req.getParameter("divisionid");


			if(divisionid==null)
			{			
				Map md=model.asMap();
				divisionid=(String)md.get("divisionid");
			}

			List<Object[]>  divisionlist = adminservice.DivisionMasterList(LabCode);
			if(divisionlist==null || divisionlist.size()==0)
			{
				redir.addAttribute("resultfail", "No Divisions Found");
				return "redirect:/MainDashBoard.htm";
			}
			if(divisionid==null)
			{
				divisionid =divisionlist.get(0)[0].toString();
			}		
			req.setAttribute("divisiondata", service.DivisionData(divisionid));
			req.setAttribute("divisionlist", divisionlist);
			req.setAttribute("divisionemplist", service.DivisionEmpList(divisionid));	
			req.setAttribute("empoyeelist",service.DivisionNonEmpList(divisionid).stream().filter(e-> LabCode.equalsIgnoreCase(e[3].toString())).collect(Collectors.toList()));
			return "master/DivisionAssign";

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside DivisionEmployee.htm "+UserId , e);
			return "static/Error";
		}
	}


	@RequestMapping(value="DivsionEmployeeRevoke.htm",method= {RequestMethod.POST,RequestMethod.GET})
	public String DivsionEmployeeRevoke(Model model,HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir)throws Exception 
	{		
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside DivsionEmployeeRevoke.htm "+UserId);
		try {
			String divisionid=req.getParameter("divisionid");
			String divisionempid=req.getParameter("divisionempid");
			DivisionEmployeeDto dto=new DivisionEmployeeDto();
			dto.setDivisionEmployeeId(divisionempid);
			dto.setModifiedBy(UserId);
			int ret=service.DivsionEmployeeRevoke(dto);

			if(ret>0) {
				redir.addAttribute("result", "Employee Revoke Successfully ");
			}
			else {
				redir.addAttribute("resultfail", "Employee Revoke Unsuccessful");
			}

			redir.addFlashAttribute("divisionid",divisionid);
			return "redirect:/DivisionEmployee.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside DivsionEmployeeRevoke.htm "+UserId , e);
			return "static/Error";
		}

	}


	@RequestMapping(value="DivisionAssignSubmit.htm",method= {RequestMethod.POST,RequestMethod.GET})
	public String DivisionAssignSubmit(Model model,HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir)throws Exception 
	{		
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside DivisionAssignSubmit.htm "+UserId);
		try {
			String divisionid=req.getParameter("divisionid");
			String employeeid[]=req.getParameterValues("employeeid");

			DivisionEmployeeDto dto=new DivisionEmployeeDto();
			dto.setDivisionId(divisionid);
			dto.setEmpId(employeeid);
			dto.setCreatedBy(UserId);
			long ret=service.DivisionAssignSubmit(dto);

			if(ret>0) {
				redir.addAttribute("result", "Employee Assigned Successfully ");
			}
			else {
				redir.addAttribute("resultfail", "Employee Assign Unsuccessful");
			}


			redir.addFlashAttribute("divisionid",divisionid);
			return "redirect:/DivisionEmployee.htm";

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside DivisionAssignSubmit.htm "+UserId , e);
			return "static/Error";
		}		
	}


	@RequestMapping(value="MilestoneActivityTypes.htm",method= {RequestMethod.POST,RequestMethod.GET})
	public String MilestoneActivityTypes(Model model,HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir)throws Exception 
	{		
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside MilestoneActivityTypes.htm "+UserId);
		try {		


			req.setAttribute("activitylist", service.ActivityList());
			return "master/MilestoneActivityType";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside MilestoneActivityTypes.htm "+UserId , e);
			return "static/Error";
		}		
	}

	@RequestMapping(value = "AddActivityCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String AddActivityCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		Object[] DisDesc = null;
		logger.info(new Date() +"Inside AddActivityCheck.htm "+UserId);
		try
		{	  
			String activitytype=req.getParameter("activitytype");					
			DisDesc= service.ActivityNameCheck(activitytype);
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +"Inside AddActivityCheck.htm "+UserId,e);
		}
		Gson json = new Gson();
		return json.toJson(DisDesc); 

	}

	@RequestMapping(value="ActivityAddSubmit.htm",method= {RequestMethod.POST})
	public String ActivityAddSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir)throws Exception 
	{		
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside ActivityAddSubmit.htm "+UserId);
		try {		

			String activitytype=req.getParameter("activitytype");

			MilestoneActivityType model =new MilestoneActivityType();
			model.setActivityType(activitytype);
			model.setCreatedBy(UserId);
			long count =service.ActivityAddSubmit(model);

			if(count>0) {
				redir.addAttribute("result", "Activity Type Added Successfully ");
			}
			else {
				redir.addAttribute("resultfail", "Activity Type Adding Unsuccessful");
			}

			return "redirect:/MilestoneActivityTypes.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActivityAddSubmit.htm "+UserId , e);
			return "static/Error";
		}		
	}

	@RequestMapping(value="GroupMaster.htm",method= {RequestMethod.GET})
	public String GroupMaster(Model model, HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir)throws Exception {

		String UserId= (String)ses.getAttribute("Username");
		String LabCode =(String)ses.getAttribute("labcode");

		logger.info(new Date() +" Inside GroupMaster.htm "+UserId);
		try 
		{
			String onboard=req.getParameter("Onboarding");

			if(onboard==null) {
				Map md=model.asMap();
				onboard=(String)md.get("Onboard");
			}

			req.setAttribute("groupslist",service.GroupsList(LabCode) );
			req.setAttribute("Onboarding", onboard);
			return "master/GroupsList";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GroupMaster.htm "+UserId , e);
			return "static/Error";
		}
	}

	@RequestMapping (value="GroupMaster.htm", method= RequestMethod.POST)
	public String GroupMaster(HttpServletRequest req, HttpSession ses, HttpServletResponse res,RedirectAttributes redir) throws Exception {

		String Userid = (String) ses.getAttribute("Username");
		String Option= req.getParameter("sub");
		String LabCode = (String)ses.getAttribute("labcode");


		logger.info(new Date() +"Inside GroupMaster.htm "+ Userid);	

		try {

			if(Option.equalsIgnoreCase("add")) {

				req.setAttribute("groupheadlist",service.GroupHeadList(LabCode));
				req.setAttribute("tdaddlist", service.TDListAdd().stream().filter(e-> LabCode.equalsIgnoreCase(e[3].toString())).collect(Collectors.toList()));
				return "master/GroupMasterAdd";
			}


			else if(Option.equalsIgnoreCase("edit")) {

				String groupid=req.getParameter("groupid");
				req.setAttribute("groupsdata", service.GroupsData(groupid));
				req.setAttribute("groupheadlist",service.GroupHeadList(LabCode));
				req.setAttribute("tdaddlist", service.TDListAdd().stream().filter(e-> LabCode.equalsIgnoreCase(e[3].toString())).collect(Collectors.toList()));
				return "master/GroupMasterEdit";
			}

		}
		catch(Exception e){

			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside GroupMaster.htm "+ Userid, e);

		}

		return "redirect:/GroupMaster.htm";	
	}
	@RequestMapping(value = "GroupMasterAddSubmit.htm",method=RequestMethod.POST )
	public String GroupMasterAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside GroupMaster.htm "+UserId);	
		String LabCode= (String)ses.getAttribute("labcode");

		try {				
			String groupCode=req.getParameter("gCode");
			String groupName=req.getParameter("gName");
			String GroupHeadName=req.getParameter("ghempid");
			String tdid=req.getParameter("tdId");

			DivisionGroup dgm=new DivisionGroup();
			dgm.setGroupCode(groupCode);
			dgm.setGroupName(groupName);
			dgm.setGroupHeadId(Long.parseLong(GroupHeadName));
			dgm.setCreatedBy(UserId);
			dgm.setLabCode(LabCode);
			dgm.setTDId(tdid);

			long count=service.GroupAddSubmit(dgm);
			if (count > 0) {
				redir.addAttribute("result", "Group Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Group Adding Unsuccessfully");
			}

			return "redirect:/GroupMaster.htm";
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GroupMaster.htm "+UserId, e);
			return "static/Error";
		}
	}



	@RequestMapping (value="GroupMasterEditSubmit.htm" , method=RequestMethod.POST)

	public String GroupMasterEditSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception
	{

		String Userid = (String) ses.getAttribute("Username");

		logger.info(new Date() +" Inside GroupMasterEditSubmit.htm "+Userid );

		try {

			DivisionGroup model= new DivisionGroup();
			model.setGroupCode(req.getParameter("groupcode"));
			model.setGroupName(req.getParameter("groupname"));
			model.setTDId(req.getParameter("tdId"));
			model.setGroupHeadId(Long.parseLong(req.getParameter("ghempid")));
			model.setGroupId(Long.parseLong(req.getParameter("groupid")));                 
			model.setIsActive(Integer.valueOf(req.getParameter("isActive")));
			model.setModifiedBy(Userid);    



			int count = service.GroupMasterUpdate(model);

			if(count > 0 ) {
				redir.addAttribute("result", "Group Edited Successfully");
			}

			else {
				redir.addAttribute("result ", "Group Edit Unsuccessful");
			}

		}
		catch(Exception e){

			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside GroupMasterEditSubmit.htm "+Userid , e);
		}

		return "redirect:/GroupMaster.htm";
	}



	@RequestMapping(value = "groupAddCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String DivisionAddCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		Object[] DisDesc = null;
		logger.info(new Date() +"Inside groupAddCheck.htm "+UserId);
		try
		{	  
			String gCode=req.getParameter("gcode");
			DisDesc =service.GroupAddCheck(gCode);
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +"Inside groupAddCheck.htm "+UserId,e);
		}
		Gson json = new Gson();
		return json.toJson(DisDesc); 
	}

	@RequestMapping (value= "LabDetails.htm", method= RequestMethod.GET)
	public String LabMasterList(HttpServletRequest req,HttpSession ses) throws Exception{

		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +" Inside LabDetails.htm " +  UserId );			
		req.setAttribute("labmasterdata", service.LabMasterList().stream().filter(e-> LabCode.equalsIgnoreCase(e[1].toString())).collect(Collectors.toList()) );			
		return "master/LabDetails";
	}
	@RequestMapping (value="LabDetails.htm" , method= RequestMethod.POST)
	public String LabMasterAddEdit(HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{

		String Option =req.getParameter("sub");
		String LabId= req.getParameter("Did");
		String Userid= (String) ses.getAttribute("Username");

		logger.info(new Date() +" Inside LabDetails.htm "+Userid);

		try {
			if(Option.equalsIgnoreCase("add")) {

				req.setAttribute("employeelist", service.EmployeeList());
				return "master/LabMasterAdd";
			}

			else if(Option.equalsIgnoreCase("edit")) {

				req.setAttribute("LabMasterEditData", service.LabMasterEditData(LabId).get(0));
				req.setAttribute("employeelist", service.EmployeeList());
				req.setAttribute("lablist", service.LabsList() );
				return "master/LabMasterEdit";
			}
		}
		catch(Exception e){

			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside LabDetails.htm "+Userid , e);

		}

		return "redirect:/LabDetails.htm";
	}


	@RequestMapping(value="LabMasterEditSubmit.htm" , method= RequestMethod.POST)
	public String LabMasterEdit (HttpServletResponse res, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
	{		
		String Userid= (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside LabMasterEditSubmit.htm "+Userid);

		try {
			LabMasterAdd labmasteredit = new LabMasterAdd();

			labmasteredit.setLabCode(req.getParameter("LabCode").trim());
			labmasteredit.setLabName(req.getParameter("LabName"));
			labmasteredit.setLabUnitCode(req.getParameter("LabUnitCode"));
			labmasteredit.setLabAddress(req.getParameter("LabAddress"));
			labmasteredit.setLabCity(req.getParameter("LabCity"));
			labmasteredit.setLabPin(req.getParameter("LabPin"));
			labmasteredit.setLabMasterId(req.getParameter("LabMasterId"));
			labmasteredit.setLabTelephone(req.getParameter("LabTelephone"));
			labmasteredit.setLabFaxNo(req.getParameter("LabFaxNo"));
			labmasteredit.setLabEmail(req.getParameter("LabEmail"));
			labmasteredit.setLabAuthority(req.getParameter("LabAuthority"));
			labmasteredit.setLabAuthorityId(req.getParameter("LabAuthorityName"));
			labmasteredit.setLabRfpEmail(req.getParameter("LabRFPEmail"));
			String[] labid=req.getParameter("labid").split(",");
			labmasteredit.setLabId(labid[0]);
			labmasteredit.setClusterId(labid[1]);
			int count = service.LabMasterUpdate(labmasteredit,Userid);

			if(count > 0) {
				redir.addAttribute("result" , "Lab Details Edited Successfully ");
			}
			else {
				redir.addAttribute("resultfail", "Lab Details Edit Unsuccessful");
			}
		}
		catch (Exception e)
		{				
			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside LabMasterEditSubmit.htm "+Userid , e);				
		}			
		return "redirect:/LabDetails.htm";
	}

	@RequestMapping(value = "FeedBack.htm", method = RequestMethod.GET)
	public String FeedBack(HttpServletRequest req, HttpSession ses) throws Exception {
		String Userid= (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		String logintype=(String)ses.getAttribute("LoginType");
		logger.info(new Date() +" Inside FeedBack.htm "+Userid);
		req.setAttribute("fromdate", new FormatConverter().SqlToRegularDate( LocalDate.now().minusMonths(1).toString()));
		req.setAttribute("todate",new FormatConverter().SqlToRegularDate( LocalDate.now().toString()));
		if(logintype!=null && logintype.equalsIgnoreCase("A")) {
			List<Object[]> list = service.FeedbackListForUser(LabCode,"A");
			List<Object[]> Attch = service.GetfeedbackAttch(); 
			if(list!=null && list.size()>0) {
				req.setAttribute("FeedbackList", list);
				req.setAttribute("Attchment", Attch);
				req.setAttribute("feedbacktype", "A");
				return "master/FeedbackList";
			}else {
				req.setAttribute("FeedbackList", list);
				return "master/FeedBack";
			}
		}else {
			String empid =  String.valueOf((Long) ses.getAttribute("EmpId"));
			List<Object[]> list = service.FeedbackListForUser(LabCode , empid);
			List<Object[]> Attch = service.GetfeedbackAttchForUser( empid); 
			if(list!=null && list.size()>0) {
				req.setAttribute("FeedbackList", list);
				req.setAttribute("Attchment", Attch);
				req.setAttribute("feedbacktype", "A");
				return "master/FeedbackList";
			}else {
				req.setAttribute("FeedbackList", list);
				return "master/FeedBack";
			}
		}

	}

	@RequestMapping(value = "FeedbackAttachDownload.htm", method = RequestMethod.GET)
	public void FeedbackAttachDownload(HttpServletRequest	 req, HttpSession ses, HttpServletResponse res) throws Exception 
	{	 
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionAttachDownload.htm "+UserId);		
		try { 

			res.setContentType("Application/octet-stream");	
			System.out.println(req.getParameter("attachid"));
			PfmsFeedbackAttach attach=service.FeedbackAttachmentDownload(req.getParameter("attachid"));

			File my_file=null;

			my_file = new File(uploadpath+attach.getPath()+File.separator+attach.getFileName()); 
			res.setHeader("Content-disposition","attachment; filename="+attach.getFileName().toString()); 
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

		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ActionAttachDownload.htm "+UserId, e);
		}
	}


	@RequestMapping(value = "FeedBackPage.htm", method = RequestMethod.GET)
	public String FeedBackpage(HttpServletRequest req, HttpSession ses) throws Exception {
		String Userid= (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		String logintype=(String)ses.getAttribute("LoginType");
		logger.info(new Date() +" Inside FeedBack.htm "+Userid);
		if(logintype!=null && logintype.equalsIgnoreCase("A")) {
			List<Object[]> list = service.FeedbackListForUser(LabCode,"A");
			req.setAttribute("FeedbackList", list);
		}else {
			String empid =  String.valueOf((Long) ses.getAttribute("EmpId"));
			List<Object[]> list = service.FeedbackListForUser(LabCode , empid);
			req.setAttribute("FeedbackList", list);
		}
		return "master/FeedBack";

	}

	@RequestMapping(value = "FeedBackAdd.htm", method = RequestMethod.POST)
	public String FeedBackAdd(Model model,HttpServletRequest req, HttpSession ses,RedirectAttributes redir,
			@RequestPart("FileAttach") MultipartFile FileAttach)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +" Inside FeedBackAdd.htm "+UserId);
		try {
			Long EmpId = (Long) ses.getAttribute("EmpId");
			String Feedback=req.getParameter("Feedback");
			String feedbacktype=req.getParameter("feedbacktype");
			if(!FileAttach.isEmpty()){

			}
			if(Feedback ==null || Feedback.trim().equalsIgnoreCase("")) {			
				redir.addAttribute("resultfail", "Feedback Field is Empty, Please Enter Feedback");
				return "redirect:/FeedBack.htm";
			}
			if(feedbacktype==null) {
				redir.addAttribute("resultfail", "Please Select the FeedbackType");
				return "redirect:/FeedBack.htm";
			}
			PfmsFeedback feedback=new PfmsFeedback();
			feedback.setEmpId(EmpId);
			feedback.setStatus("O");
			feedback.setFeedbackType(feedbacktype);
			feedback.setFeedback(Feedback);
			feedback.setCreatedBy(UserId);
			feedback.setCreatedDate(sdf1.format(new Date()));
			feedback.setIsActive(1);

			Long Feedbackid=service.FeedbackInsert(feedback , FileAttach,LabCode);

			if (Feedbackid>0) {
				redir.addAttribute("result", " Feedback Add Successful");
			} else {
				redir.addAttribute("resultfail", "Feedback Add UnSuccessful");
			}
		} catch (Exception e) {
			e.printStackTrace();
			redir.addAttribute("resultfail", "Feedback Add UnSuccessful");
		}

		return "redirect:/FeedBack.htm";
	}



	@RequestMapping(value = "FeedbackList.htm" , method= {RequestMethod.GET,RequestMethod.POST})
	public String FeedbackList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside FeedbackList.htm "+UserId);

		try {
			String LabCode =(String) ses.getAttribute("labcode");
			String empid =  String.valueOf((Long) ses.getAttribute("EmpId"));
			String logintype=(String)ses.getAttribute("LoginType");
			String fromdate = req.getParameter("Fromdate");
			String todate = req.getParameter("Todate");
			String feedbacktype = req.getParameter("feedbacktype");
			if(feedbacktype==null) {
				feedbacktype="A";
			}
			if(logintype!=null && logintype.equalsIgnoreCase("A")) {
				List<Object[]> Attch = service.GetfeedbackAttch(); 
				req.setAttribute("FeedbackList", service.FeedbackList(fromdate,todate,"A" ,LabCode,feedbacktype));
				req.setAttribute("Attchment", Attch);
			}else {
				List<Object[]> Attch = service.GetfeedbackAttchForUser( empid); 
				req.setAttribute("FeedbackList", service.FeedbackList(fromdate,todate,empid,LabCode,feedbacktype));
				req.setAttribute("Attchment", Attch);
			}
			req.setAttribute("fromdate", fromdate);
			req.setAttribute("todate", todate);
			req.setAttribute("feedbacktype", feedbacktype);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside FeedbackList.htm "+UserId,e);
		}
		return "master/FeedbackList";
	}

	@RequestMapping(value = "FeedbackContent.htm", method = RequestMethod.GET)
	public @ResponseBody String FeedbackContent(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		Object[] arr = null;
		logger.info(new Date() +"Inside FeedbackContent.htm "+UserId);
		try
		{	  
			String feedbackid=req.getParameter("feedbackid");					
			arr= service.FeedbackContent(feedbackid);
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside FeedbackContent.htm "+UserId,e);
		}
		Gson json = new Gson();
		return json.toJson(arr); 

	}

	@RequestMapping( value = "CloseFeedBack.htm" , method = RequestMethod.POST)
	public String CloseFeedback(HttpSession ses, HttpServletRequest req ,RedirectAttributes redir)throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CloseFeedBack.htm "+UserId);
		try {
			String feedbackid = req.getParameter("feedbackid");
			String remarks = req.getParameter("Remarks");
			int count = service.CloseFeedback(feedbackid , remarks,UserId);
			if(count > 0) {
				redir.addAttribute("result" , "Feedback Closed Successfully ");
			}else {
				redir.addAttribute("resultfail", "Feedback Close Unsuccessful");
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside CloseFeedBack.htm "+UserId,e);
		}
		return "redirect:/FeedBack.htm";
	}



	@RequestMapping(value="TDMaster.htm",method= {RequestMethod.GET})
	public String TDMaster(Model model, HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir)throws Exception {

		String UserId= (String)ses.getAttribute("Username");
		String LabCode =(String)ses.getAttribute("labcode");

		logger.info(new Date() +" Inside TDMaster.htm "+UserId);
		try 
		{
			req.setAttribute("TDList",service.TDList(LabCode));
			return "master/TDList";

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside TDMaster.htm "+UserId , e);
			return "static/Error";
		}

	}
	@RequestMapping (value="TDMaster.htm", method= RequestMethod.POST)
	public String TDMaster(HttpServletRequest req, HttpSession ses, HttpServletResponse res,RedirectAttributes redir) throws Exception {

		String Userid = (String) ses.getAttribute("Username");
		String Option= req.getParameter("sub");
		String LabCode = (String)ses.getAttribute("labcode");


		logger.info(new Date() +"Inside TDMaster.htm "+ Userid);	

		try {

			if(Option.equalsIgnoreCase("add")) {

				req.setAttribute("tdheadlist",service.TDHeadList(LabCode));

				return "master/TDMasterAdd";
			}


			else if(Option.equalsIgnoreCase("edit")) {

				String tdid=req.getParameter("tdid");
				req.setAttribute("tdsdata", service.TDsData(tdid));
				req.setAttribute("tdheadlist",service.TDHeadList(LabCode));

				return "master/TDMasterEdit";
			}

		}
		catch(Exception e){

			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside TDMaster.htm "+ Userid, e);

		}

		return "redirect:/TDMaster.htm";	
	}

	@RequestMapping(value = "TDMasterAddSubmit.htm",method=RequestMethod.POST )
	public String TDMasterAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		String LabCode= (String)ses.getAttribute("labcode");

		logger.info(new Date() +"Inside TDMasterAddSubmit.htm "+UserId);	


		try {				
			String tdCode=req.getParameter("tCode");
			String tdName=req.getParameter("tName");
			String tdHeadName=req.getParameter("tdempid");

			DivisionTd dtd=new DivisionTd();
			dtd.setTdCode(tdCode);
			dtd.setTdName(tdName);
			dtd.setTdHeadId(Long.parseLong(tdHeadName));
			dtd.setCreatedBy(UserId);
			dtd.setLabCode(LabCode);

			long count=service.TDAddSubmit(dtd);
			if (count > 0) {
				redir.addAttribute("result", "TD Added Successfully");
			} else {
				redir.addAttribute("resultfail", "TD Adding Unsuccessfully");
			}

			return "redirect:/TDMaster.htm";
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside TDMasterAddSubmit.htm "+UserId, e);
			return "static/Error";
		}
	}


	@RequestMapping(value = "tdAddCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String TDAddCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		Object[] TDCheck = null;
		logger.info(new Date() +"Inside tdAddCheck.htm "+UserId);
		try
		{	  
			String tCode=req.getParameter("tcode");
			TDCheck =service.TDAddCheck(tCode);
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +"Inside tdAddCheck.htm "+UserId,e);
		}
		Gson json = new Gson();
		return json.toJson(TDCheck); 
	}


	@RequestMapping (value="TDMasterEditSubmit.htm" , method=RequestMethod.POST)

	public String TDMasterEditSubmit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception
	{

		String Userid = (String) ses.getAttribute("Username");

		logger.info(new Date() +" Inside TDMasterEditSubmit.htm "+Userid );

		try {

			DivisionTd model= new DivisionTd();
			model.setTdCode(req.getParameter("tdcode"));
			model.setTdName(req.getParameter("tdname"));
			model.setTdHeadId(Long.parseLong(req.getParameter("tdempid")));
			model.setTdId(Long.parseLong(req.getParameter("tdid")));                 
			model.setIsActive(Integer.valueOf(req.getParameter("isActive")));
			model.setModifiedBy(Userid);    

			int count = service.TDMasterUpdate(model);

			if(count > 0 ) {
				redir.addAttribute("result", "TD Edited Successfully");
			}

			else {
				redir.addAttribute("result ", "TD Edit Unsuccessful");
			}

		}
		catch(Exception e){

			e.printStackTrace();
			redir.addAttribute("resultfail", "Technical Issue");
			logger.error(new Date() +" Inside TDMasterEditSubmit.htm "+Userid , e);
		}

		return "redirect:/TDMaster.htm";
	}


	@RequestMapping(value = "ActivityTypeEdit.htm", method = { RequestMethod.POST })
	public String ActivityTypeEdit(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir)throws Exception 
	{
		System.out.println("in ActivityTypeEdit");
		logger.info(new Date() +"Inside ActivityTypeEdit.htm ");
		try {
			boolean flag=true;
			if(req.getParameter("Delete")==null)flag=false; // if Edit, flag false
			List<Object[]> activityList = service.ActivityList();

			String ActivityID = req.getParameter("ActivityID");
			boolean Editflag = true;// cannot be false if deleting
			if(flag && ActivityID!=null)service.DeleteActivityType(ActivityID); // only Deletes, flag is true
			else	{		// else updates
				String toActivity = req.getParameter("toActivity").toString();

				for (Object[] objects : activityList) {
					System.out.println("objects[1] "+objects[1]+" toActivity "+toActivity);
					if(objects[1].toString().equals(toActivity))Editflag=false;
				}
				if(Editflag)
					service.UpdateActivityType(toActivity, ActivityID);
			}

			redir.addAttribute("result", flag?"Deleted Activity Type Succesfully":Editflag?"Edited Activity Type Succesfully":"");
			if(!Editflag)redir.addAttribute("result","Activity Type Already Exists!");
			return "redirect:/MilestoneActivityTypes.htm";		
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ActivityTypeEdit.htm ", e); 
			return "static/Error";
		}
	}


	@RequestMapping(value="IndustryPartner.htm")
	public String industryPartner(final HttpServletRequest req, final HttpSession ses, final RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside IndustryPartner.htm " + UserId);
		try {
			String action = req.getParameter("Action");
			if(action!=null && action.equalsIgnoreCase("Add")) {
				req.setAttribute("IndustryNamesList", service.getIndustryPartnerList());
				
				return "master/IndustryPartnerAddEdit";
				
			}else if(action!=null && action.equalsIgnoreCase("Edit")) {
				String industryPartnerRepId = req.getParameter("industryPartnerRepId");
				req.setAttribute("IndustryPartnerDetails", service.industryPartnerDetailsByIndustryPartnerRepId(industryPartnerRepId));
				req.setAttribute("IndustryNamesList", service.getIndustryPartnerList());
				
				return "master/IndustryPartnerAddEdit";
				
			}else {
				//req.setAttribute("IndustryPartnerList", service.industryPartnerList());
				
				String pagination = req.getParameter("pagination");
				int pagin = Integer.parseInt(pagination!=null?pagination:"0");

				/* fetching actual data */
				List<Object[]> IndustryPartnerList = service.industryPartnerList();

				// adding values to this List<Object[]>
				List<Object[]> arrayList = new ArrayList<>();

				/* search action starts */
				String search = req.getParameter("search");
				if(search!="" && search!=null) {
					req.setAttribute("searchFactor", search);
					for(Object[] obj: IndustryPartnerList) {
						for(Object value:obj) {
							if(value instanceof String)
								if (((String)(value)).contains(search) ) {
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
				int p = IndustryPartnerList.size()/6;
				int extra = IndustryPartnerList.size()%6;
				if(arrayList.size()==0) arrayList=IndustryPartnerList;

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

				req.setAttribute("IndustryPartnerList", arrayList);
				req.setAttribute("maxpagin", p+(extra>0?1:0) );
				/* pagination process ends */
				
				return "master/IndustryPartnerList";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IndustryPartner.htm " + UserId, (Throwable) e);
			return "static/Error"; 
		}
		
	}

	@RequestMapping(value="IndustryPartnerSubmit.htm")
	public String industryPartnerSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside IndustryPartnerSubmit.htm " + UserId);
		try {
			String action = req.getParameter("Action");
			String industryPartnerId = req.getParameter("industryPartnerId");
			industryPartnerId = industryPartnerId!=null?industryPartnerId : req.getParameter("industryPartnerId2");
			
			boolean addnew = industryPartnerId!=null && industryPartnerId.equalsIgnoreCase("addNew")?true:false;
			IndustryPartner partner = addnew ? new IndustryPartner() : service.getIndustryPartnerById(industryPartnerId);
			if(addnew || action.equalsIgnoreCase("Edit")) {
				partner.setIndustryName(addnew?req.getParameter("industryPartnerName2"):req.getParameter("industryPartnerName"));
			}
			
			partner.setIndustryAddress(addnew?req.getParameter("industryPartnerAddress2"):req.getParameter("industryPartnerAddress"));
			partner.setIndustryCity(addnew?req.getParameter("industryPartnerCity2"):req.getParameter("industryPartnerCity"));
			partner.setIndustryPinCode(addnew?req.getParameter("industryPartnerPinCode2"):req.getParameter("industryPartnerPinCode"));
			
			if(addnew) {
				partner.setCreatedBy(UserId);
				partner.setCreatedDate(sdf1.format(new Date()));
				partner.setIsActive(1);
				
			}else {
				partner.setModifiedBy(UserId);
				partner.setModifiedDate(sdf1.format(new Date()));
			}
			
			String industryPartnerRepId = req.getParameter("industryPartnerRepId");
			List<IndustryPartnerRep> partnerReplist = new ArrayList<>();
			
			String[] repName = req.getParameterValues("repName");
			String[] repDesignation = req.getParameterValues("repDesignation");
			String[] repMobileNo = req.getParameterValues("repMobileNo");
			String[] repEmail = req.getParameterValues("repEmail");
			
			for(int i=0;i<repName.length;i++) {
				IndustryPartnerRep partnerRep = action!=null && action.equalsIgnoreCase("Add")? new IndustryPartnerRep() : service.getIndustryPartnerRepById(industryPartnerRepId);
				partnerRep.setRepName(repName[i]);
				partnerRep.setRepDesignation(repDesignation[i]);
				partnerRep.setRepMobileNo(repMobileNo[i]);
				partnerRep.setRepEmail(repEmail[i]);
				if(action!=null && action.equalsIgnoreCase("Add")) {
					partnerRep.setCreatedBy(UserId);
					partnerRep.setCreatedDate(sdf1.format(new Date()));
					partnerRep.setIsActive(1);
				}else {
					partnerRep.setModifiedBy(UserId);
					partnerRep.setModifiedDate(sdf1.format(new Date()));
				}
				partnerRep.setIndustryPartner(partner);
				partnerReplist.add(partnerRep);
			}
			
			partner.setRep(partnerReplist);
			
			long result = service.addIndustryPartner(partner);
			
			if(result!=0) {
				redir.addAttribute("result", "Industry Partner Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Industry Partner Details "+action+" UnSuccessful");
			}
			
			return "redirect:/IndustryPartner.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IndustryPartnerSubmit.htm " + UserId, e);
			return "static/Error"; 
		}
	}
	
	@RequestMapping(value = "IndustryPartnerRepRevoke.htm")
	public String industryPartnerRepRevoke(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside IndustryPartnerRepRevoke.htm " + UserId);
		try {
			String industryPartnerRepId = req.getParameter("industryPartnerRepId");
			int result = service.revokeIndustryPartnerRep(industryPartnerRepId);
			
			if(result!=0) {
				redir.addAttribute("result", "Industry Partner Revoked Successfully");
			}else {
				redir.addAttribute("resultfail", "Industry Partner Revoke UnSuccessful");
			}
			
			return "redirect:/IndustryPartner.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + " Inside IndustryPartnerRepRevoke.htm " + UserId, e);
			return "static/Error"; 
		}
	}
	
	@RequestMapping(value = "IndustryPartnerRepDetails.htm", method = RequestMethod.GET)
	public @ResponseBody String industryPartnerRepDetails(HttpServletRequest req,HttpSession ses) throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside IndustryPartnerRepDetails.htm"+ UserId);
		
		List<Object[]> industryPartnerRepDetails = new ArrayList<Object[]>();
		
		String industryPartnerId =req.getParameter("industryPartnerId");
		String industryPartnerRepId =req.getParameter("industryPartnerRepId");
	
		industryPartnerRepDetails = service.industryPartnerRepDetails(industryPartnerId, industryPartnerRepId!=null?industryPartnerRepId:"0");
	 
		Gson json = new Gson();
		return json.toJson(industryPartnerRepDetails);	
	}
	
}