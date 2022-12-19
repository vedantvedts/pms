package com.vts.pfms.admin.controller;

import java.awt.Desktop;
import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.bytecode.enhance.spi.interceptor.SessionAssociableInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.pfms.admin.dto.EmployeeDesigDto;
import com.vts.pfms.admin.dto.PfmsLoginRoleSecurityDto;
import com.vts.pfms.admin.dto.PfmsRtmddoDto;
import com.vts.pfms.admin.dto.UserManageAdd;
import com.vts.pfms.admin.model.DivisionMaster;
import com.vts.pfms.admin.model.Expert;
import com.vts.pfms.admin.service.AdminService;

@Controller
public class AdminController {
	@Autowired 
	AdminService service;
	
	private static final Logger logger=LogManager.getLogger(AdminController.class);
	
	@Value("${batchfilePath}")
	String batchfilepath;
	
	@RequestMapping(value = "LoginTypeList.htm" )
	public String ProjectIntiationList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginTypeList.htm "+UserId);		
		try {

			ProcessBuilder processBuilder = new ProcessBuilder("C:\\Users\\VTS\\Desktop\\EMS-DB Backup.bat");
			processBuilder.start();
			
			File file = new File("C:\\Users\\VTS\\Desktop\\EMS-DB Backup.bat");
		    Desktop.getDesktop().open(file);
			
			
			req.setAttribute("LoginTypeList",service.LoginTypeList());
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside LoginTypeList.htm "+UserId, e);
		}
		
	
		 return "admin/LoginList";
	}
	
	@RequestMapping(value="LoginTypeAdd.htm",method=RequestMethod.GET)
	public String LoginTypeAdd(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginTypeAdd.htm "+UserId);		
		try {
		
		req.setAttribute("EmployeeList",service.EmployeeList());
		req.setAttribute("RoleList",service.RoleList());
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside LoginTypeAdd.htm "+UserId, e);
		}
		
		
		return "admin/LoginTypeAdd";
	}
	
	@RequestMapping(value="LoginTypeAddSubmit.htm",method=RequestMethod.POST)
	public String LoginTypeAddSubmit(HttpServletRequest req,HttpSession ses, RedirectAttributes redir)throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginTypeAddSubmit.htm "+UserId);		
		try {
		
		
		PfmsLoginRoleSecurityDto loginrolesecurity= new PfmsLoginRoleSecurityDto();
		
		loginrolesecurity.setLoginId(req.getParameter("EmployeeId"));
		loginrolesecurity.setRoleId(req.getParameter("RoleId"));
		
		
		Long count=service.LoginTypeAddSubmit(loginrolesecurity,UserId);
		
		if(count>0) {
			redir.addAttribute("result","Login Type Added Successfully");
		}else {
			redir.addAttribute("resultfail","Login Type Add Unsuccessful");
			return "redirect:/LoginTypeAdd.htm";
		}
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside LoginTypeAddSubmit.htm "+UserId, e);
		}
		
		return "redirect:/LoginTypeList.htm";
		
	}
	
	@RequestMapping(value="LoginTypeEditRevoke.htm",method=RequestMethod.POST)
	public String LoginTypeEditRevoke(HttpServletRequest req,HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginTypeEditRevoke.htm "+UserId);		
		try {
		
		String Option=req.getParameter("sub");
		String LoginId=req.getParameter("LoginId");
		
		
		if(Option.equalsIgnoreCase("revoke")) {
			
			Long count=service.LoginTypeRevoke(LoginId,UserId);
			
			if(count>0) {
				redir.addAttribute("result","Login Type Inactivated Successfully");
			}else {
				redir.addAttribute("resultfail","Login Type Inactivation Unsuccessful");
				return "redirect:/LoginTypeAdd.htm";
			}
			
			return "redirect:/LoginTypeList.htm";
			
		}
		
		else if(Option.equalsIgnoreCase("edit")) {
			
			req.setAttribute("EmployeeList",service.EmployeeList());
			req.setAttribute("RoleList",service.RoleList());
			req.setAttribute("LoginTypeEditData", service.LoginTypeEditData(LoginId).get(0));
			
			return "admin/LoginTypeEdit";
		}
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside LoginTypeEditRevoke.htm "+UserId, e);
		}


		return "redirect:/LoginTypeList.htm";
	}
	
	@RequestMapping(value="LoginTypeEditSubmit.htm",method=RequestMethod.POST)
	public String LoginTypeEditSubmit(HttpServletRequest req,HttpSession ses, RedirectAttributes redir)throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginTypeEditSubmit.htm "+UserId);		
		try {
		
		String LoginId=req.getParameter("LoginId");
		
		
		PfmsLoginRoleSecurityDto loginrolesecurity= new PfmsLoginRoleSecurityDto();
		
		loginrolesecurity.setRoleId(req.getParameter("RoleId"));
		
		Long count=service.LoginTypeEditSubmit(loginrolesecurity,LoginId,UserId);
		
		if(count>0) {
			redir.addAttribute("result","Login Type Updated Successfully");
		}else {
			redir.addAttribute("resultfail","Login Type Edit Unsuccessful");
			return "redirect:/LoginTypeList.htm";
		}
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside LoginTypeEditSubmit.htm "+UserId, e);
		}
		
		return "redirect:/LoginTypeList.htm";
		
	}
	
	@RequestMapping(value = "NotificationView.htm",method=RequestMethod.GET )
	public String NotificationList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside NotificationView.htm "+UserId);		
		try {

			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			req.setAttribute("NotificationList",service.NotificationList( EmpId));
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside NotificationView.htm "+UserId, e);
		}
	
		 return "admin/NotificationList";
	}
	

	@Secured("ROLE_ADMIN")
	@RequestMapping(value = "Rtmddo.htm",method=RequestMethod.GET )
	public String Rtmddo(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside Rtmddo.htm"+UserId);		
		try {

			req.setAttribute("EmployeeList",service.EmployeeListAll());
			req.setAttribute("Rtmddo",service.Rtmddo().get(0));
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside Rtmddo.htm "+UserId, e);
		}
	
		 return "admin/Rtmddo";
	}
	
	@RequestMapping(value="RtmddoSubmit.htm",method=RequestMethod.POST)
	public String RtmddoSubmit(HttpServletRequest req,HttpSession ses, RedirectAttributes redir)throws Exception {
		 
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RtmddoSubmit.htm "+UserId);		
		try {
		
		
		
		
		PfmsRtmddoDto rtmddo= new PfmsRtmddoDto();
		
		rtmddo.setEmpId(req.getParameter("EmpId"));
		rtmddo.setValidFrom(req.getParameter("ValidFrom"));
		rtmddo.setValidTo(req.getParameter("ValidTo"));
		rtmddo.setType(req.getParameter("type"));
		rtmddo.setCreatedBy(UserId);
		rtmddo.setLabCode(LabCode);
		Long count=service.RtmddoInsert(rtmddo);
		
		if(count>0) {
			redir.addAttribute("result","Rtmddo Updated Successfully");
		}else {
			redir.addAttribute("resultfail","Rtmddo Edit Unsuccessful");
			
		}
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside RtmddoSubmit.htm "+UserId, e);
		}
		
		return "redirect:/Rtmddo2.htm";
		
	}

	@RequestMapping(value = "DelegationFlow.htm",method=RequestMethod.GET )
	public String DelegationFlow(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DelegationFlow.htm "+UserId);		

		
		 return "admin/DelegationFlow";
	}
	
	
	 @RequestMapping({ "Expert.htm" })
	    public String ExpertList(final HttpServletRequest req, final HttpSession ses, final RedirectAttributes redir) throws Exception {
	        final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside ExpertList.htm " + UserId);
	        try {
	            req.setAttribute("ExpertList", (Object)this.service.GetExpertList());
	            
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	            AdminController.logger.error(new Date() + " Inside DelegationFlow.htm " + UserId, (Throwable)e);
	        }
	        return "admin/ExpertList";
	    }
	    
	    @RequestMapping(value = { "ExpertAdd.htm" }, method = { RequestMethod.POST })
	    public String ExpertAdd(final HttpServletRequest req, final HttpSession ses) throws Exception {
	        final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside ExpertAdd.htm " + UserId);
	        
	        req.setAttribute("expno", service.GenExpertNo());
	        req.setAttribute("Designation", (Object)this.service.GetDesignation());
	        return "admin/ExpertAdd";
	    }
	    
	    @RequestMapping(value = { "checkExpert.htm" }, method = { RequestMethod.GET })
	    
	    public @ResponseBody String CheckExpert(final HttpServletRequest req, final HttpSession ses) throws Exception {
	        final Gson json = new Gson();
	        final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside CheckExpert.htm " + UserId);
	        final String expertNo = req.getParameter("project");
	        final String extensionNo = req.getParameter("project1");
	        final int[] reslut = this.service.checkAbility(expertNo, extensionNo);
	        return json.toJson((Object)reslut);
	    }
	    
	    @RequestMapping(value = { "ExpertAddSubmit.htm" }, method = { RequestMethod.POST })
	    public String ExpertAddSubmit(final HttpServletRequest req, final HttpSession ses, final RedirectAttributes redir) throws Exception {
	        final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside ExpertAddSubmit.htm " + UserId);
	        final Expert newExpert = new Expert();
	        newExpert.setTitle(req.getParameter("title"));
	        newExpert.setSalutation(req.getParameter("salutation"));
	        newExpert.setExpertNo(req.getParameter("expertno"));
	        newExpert.setExpertName(req.getParameter("expertname"));
	        newExpert.setDesigId(Long.valueOf(Long.parseLong(req.getParameter("designationId"))));
	        newExpert.setExtNo(req.getParameter("extensionnumber"));
	        newExpert.setMobileNo(Long.valueOf(Long.parseLong(req.getParameter("mobilenumber"))));
	        newExpert.setEmail(req.getParameter("email"));
	        newExpert.setOrganization(req.getParameter("organization"));
	        newExpert.setCreatedBy(UserId);
	        final Long result = this.service.addExpert(newExpert);
	        if (result > 0L) {
	            redir.addAttribute("result", (Object)"Expert Added Successfully");
	        }
	        else {
	            redir.addAttribute("resultfail", (Object)"Expert Added Unsuccessful");
	        }
	        return "redirect:/Expert.htm";
	    }
	    
	    @RequestMapping(value = { "ExpertEditRevoke.htm" }, method = { RequestMethod.POST })
	    public String ExpertEditRevoke(final HttpServletRequest req, final HttpSession ses, final RedirectAttributes redir) throws Exception {
	        final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside ExpertEditRevoke.htm " + UserId);
	        try {
	            final String Option = req.getParameter("sub");
	            final String expertId = req.getParameter("expertId");
	            if (Option.equalsIgnoreCase("revoke")) {
	                final Long count = this.service.ExpertRevoke(expertId, UserId);
	                if (count > 0L) {
	                    redir.addAttribute("result", (Object)"Expert Inactivated Successfully");
	                    return "redirect:/Expert.htm";
	                }
	                redir.addAttribute("resultfail", (Object)"Expert Inactivation Unsuccessful");
	                return "redirect:/Expert.htm";
	            }
	            else if (Option.equalsIgnoreCase("edit")) {
	                req.setAttribute("EditDetails", (Object)this.service.getEditDetails(expertId));
	                req.setAttribute("Designation", (Object)this.service.GetDesignation());
	                return "admin/ExpertEdit";
	            }
	        }
	        catch (Exception e) {
	            e.printStackTrace();
	            AdminController.logger.error(new Date() + " Inside ExpertEditRevoke.htm " + UserId, (Throwable)e);
	        }
	        return "redirect:/Expert.htm";
	    }
	    
	    @RequestMapping(value = { "CheckExtension.htm" }, method = { RequestMethod.GET })
	    public  @ResponseBody String CheckExtension(final HttpServletRequest req, final HttpSession ses) throws Exception {
	        final Gson json = new Gson();
	        final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside CheckExtension.htm " + UserId);
	        final String extensionNo = req.getParameter("project1");
	        final String ExpertId = req.getParameter("project");
	        final int reslut = this.service.checkAbility2(extensionNo, ExpertId);
	        return json.toJson((Object)reslut);
	    }
	    
	    @RequestMapping(value = { "ExpertEditSubmit.htm" }, method = { RequestMethod.POST })
	    public String ExpertEditSubmit(final HttpServletRequest req, final HttpSession ses, final RedirectAttributes redir) throws Exception {
	        final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside ExpertEditSubmit.htm " + UserId);
	        final Expert newExpert = new Expert();
	        newExpert.setTitle(req.getParameter("title"));
	        newExpert.setSalutation(req.getParameter("salutation"));
	        newExpert.setExpertId(Long.valueOf(Long.parseLong(req.getParameter("expertId"))));
	        newExpert.setExpertName(req.getParameter("expertname"));
	        newExpert.setDesigId(Long.valueOf(Long.parseLong(req.getParameter("designationId"))));
	        newExpert.setExtNo(req.getParameter("extensionnumber"));
	        newExpert.setMobileNo(Long.valueOf(Long.parseLong(req.getParameter("mobilenumber"))));
	        newExpert.setEmail(req.getParameter("email"));
	        newExpert.setOrganization(req.getParameter("organization"));
	        newExpert.setModifiedBy(UserId);
	        final Long result = this.service.editExpert(newExpert);
	        if (result > 0L) {
	            redir.addAttribute("result", (Object)"Expert Edited Successfully");
	        }
	        else {
	            redir.addAttribute("resultfail", (Object)"Expert Edit Unsuccessful");
	        }
	        return "redirect:/Expert.htm";
	    }
	    
	    @RequestMapping(value = "AuditStampingView.htm")
		public String AuditStampingList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
	    	final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside AuditStampingView.htm " + UserId);
	    	try
	    	{
				String loginid=req.getParameter("loginid");		
				String Fromdate=req.getParameter("Fromdate");
				String Todate=req.getParameter("Todate");
				String LabCode = (String)ses.getAttribute("labcode");
				req.setAttribute("usernamelist", service.UsernameList().stream().filter(e-> LabCode.equalsIgnoreCase(e[4].toString())).collect(Collectors.toList()));
			
				if(loginid == null) {
					loginid = ses.getAttribute("LoginId").toString();
					req.setAttribute("auditstampinglist", service.AuditStampingList(loginid,Fromdate, Todate));
					req.setAttribute("Fromdate", LocalDate.now().minusMonths(1).format(DateTimeFormatter.ofPattern("dd-MM-yyyy")));
					req.setAttribute("Todate", LocalDate.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy")));
				}else {
					req.setAttribute("auditstampinglist", service.AuditStampingList(loginid,Fromdate, Todate));
					req.setAttribute("Fromdate", Fromdate);
					req.setAttribute("Todate", Todate);
				}
				req.setAttribute("loginid", loginid);
				return "admin/AuditStampingList";
	    	}catch (Exception e) 
	    	{
	    		AdminController.logger.error(new Date() + "Inside AuditStampingView.htm " + e);
	    		e.printStackTrace();
	    		return "static/Error";
	    	}
		}
	    
	    @RequestMapping(value = "UserManagerList.htm", method = RequestMethod.GET)
		public String UserManagerList(HttpServletRequest req, HttpSession ses) throws Exception {
	    	final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside UserManagerList.htm " + UserId);
	    	String LabCode = (String) ses.getAttribute("labcode");
	    	
			req.setAttribute("UserManagerList", service.UserManagerList(LabCode));
			return "admin/UserManagerList";
		}
	    
	    @RequestMapping(value = "UserManager.htm", method = RequestMethod.POST)
		public String UserManagerAddEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
	    {
	    	final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside UserManager.htm " + UserId);
			String Userid = (String) ses.getAttribute("Username");
			String Option = req.getParameter("sub");
			String LoginId = req.getParameter("Lid");
			String LabCode = (String) ses.getAttribute("labcode");
			
			if (Option.equalsIgnoreCase("add")) 
			{
				req.setAttribute("DivisionList", service.DivisionList());
				req.setAttribute("RoleList", service.RoleList());
				req.setAttribute("EmpList", service.EmployeeList1(LabCode));
				req.setAttribute("LoginTypeList", service.LoginTypeList1());
				return "admin/UserManagerAdd";
			}
			else if (Option.equalsIgnoreCase("edit")) 
			{
				req.setAttribute("UserManagerEditData", service.UserManagerEditData(LoginId));
				req.setAttribute("DivisionList", service.DivisionList());
				req.setAttribute("RoleList", service.RoleList());
				req.setAttribute("EmpList", service.LoginEditEmpList(LabCode));
				req.setAttribute("LoginTypeList", service.LoginTypeList1());
				return "admin/UserManagerEdit";
			}
			else {
				int count = service.UserManagerDelete(LoginId, Userid);
				if (count > 0) {
					redir.addAttribute("result", "USER DELETE SUCCESSFULLY");
				} else {
					redir.addAttribute("resultfail", "USER DELETE UNSUCCESSFUL");
				}
				return "redirect:/UserManagerList.htm";
			}

	    }
	    @RequestMapping(value = "UserNamePresentCount.htm", method = RequestMethod.GET)
		public @ResponseBody String UserNamePresentCount(HttpServletRequest req, HttpSession ses) throws Exception {

	    	final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside UserNamePresentCount.htm " + UserId);
			int UserNamePresentCount = service.UserNamePresentCount(req.getParameter("UserName"));
			Gson json = new Gson();
			return json.toJson(UserNamePresentCount);

		}
	    
	    @RequestMapping(value = "UserManagerAddSubmit.htm", method = RequestMethod.POST)
		public String UserManagerAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
				throws Exception 
	    {
	    	final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside UserManagerAddSubmit.htm " + UserId);
	    	Object[] employeedata=service.EmployeeData(req.getParameter("Employee"));
			String Userid = (String) ses.getAttribute("Username");
			UserManageAdd UserManageAdd=new UserManageAdd();
			UserManageAdd.setDivision(employeedata[5].toString());
			UserManageAdd.setRole("1"); 
			UserManageAdd.setUserName(req.getParameter("UserName"));
			UserManageAdd.setLoginType(req.getParameter("LoginType"));
			UserManageAdd.setEmployee(req.getParameter("Employee"));
			Long count = 0L;
			try {
				count = service.UserManagerInsert(UserManageAdd, Userid);
			} catch (Exception e) {
				AdminController.logger.error(new Date() + "Inside AuditStampingView.htm " + e);
				e.printStackTrace();
				redir.addAttribute("resultfail", "SOME ERROR OCCURED OR USERNAME NOT AVAILABLE");
				return "redirect:/UserManagerList.htm";
			}
			if (count > 0) {
				redir.addAttribute("result", "USER ADD SUCCESSFULLY");
			} else {
				redir.addAttribute("resultfail", "USER ADD UNSUCCESSFUL");
			}
			return "redirect:/UserManagerList.htm";
		}
	    
	    @RequestMapping(value = "UserManagerEditSubmit.htm", method = RequestMethod.POST)
		public String UserManagerEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
				throws Exception {
	    	final String UserId = (String)ses.getAttribute("Username");
	        AdminController.logger.info(new Date() + "Inside AuditStampingView.htm " + UserId);
			UserManageAdd UserManageAdd=new UserManageAdd();
			UserManageAdd.setDivision(req.getParameter("Division"));
			UserManageAdd.setRole(req.getParameter("Role"));
			UserManageAdd.setUserName(req.getParameter("UserName"));
			UserManageAdd.setLoginType(req.getParameter("LoginType"));
			UserManageAdd.setEmployee(req.getParameter("Employee"));
			UserManageAdd.setLoginId(req.getParameter("LoginId"));
			UserManageAdd.setPfms(req.getParameter("pfmsLogin"));
			String Userid = (String) ses.getAttribute("Username");

			int count = service.UserManagerUpdate(UserManageAdd, Userid);

			if (count > 0) {
				redir.addAttribute("result", "USER EDIT SUCCESSFULLY");
			} else {
				redir.addAttribute("resultfail", "USER EDIT UNSUCCESSFUL");
			}

			return "redirect:/UserManagerList.htm";

		}
	    
	    @Secured("ROLE_ADMIN")
		@RequestMapping(value = "Rtmddo2.htm",method=RequestMethod.GET )
		public String Rtmddo2(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
			String UserId = (String) ses.getAttribute("Username");
			String LabCode =(String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside Rtmddo2.htm "+UserId);		
			try {

				req.setAttribute("EmployeeList",service.EmployeeListAll().stream().filter(e-> LabCode.equalsIgnoreCase(e[3].toString())).collect(Collectors.toList()) );
				req.setAttribute("RtmddoList",service.Rtmddo());
				req.setAttribute("presentEmpList", service.presentEmpList().stream().filter(e-> LabCode.equals(e[5].toString())).collect(Collectors.toList()));
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +" Inside Rtmddo2.htm "+UserId, e);
			}
		
			 return "admin/Rtmddo2";
		}
	    
	    
	    @RequestMapping(value = "DesignationMaster.htm",method= {RequestMethod.GET,RequestMethod.POST })
		public String DesignationMaster(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
	    	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside DesignationMaster.htm "+UserId);		
			try {
								
				req.setAttribute("designationlist", service.DesignationList());
				return "admin/DesignationList";
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside DesignationMaster.htm "+UserId, e);
					return "static/Error";
			}
	    }

	    
	    @RequestMapping(value = "DesignationEdit.htm",method=RequestMethod.POST )
		public String DesignationEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
	    	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside DesignationEdit.htm "+UserId);		
			try {
				
				String desigid=req.getParameter("desigid");
				req.setAttribute("designationdata", service.DesignationData(desigid));
				return "admin/DesignationEdit";
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside DesignationEdit.htm "+UserId, e);
					return "static/Error";
			}
	    }
	    
	    
	    @RequestMapping(value = "DesignationAdd.htm",method=RequestMethod.GET )
		public String DesignationAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
	    	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside DesignationAdd.htm "+UserId);		
			try {				
				

				
				return "admin/DesignationAdd";
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside DesignationAdd.htm "+UserId, e);
					return "static/Error";
			}
	    }
	    
	    @RequestMapping(value = "DesignationEditSubmit.htm",method=RequestMethod.POST )
		public String DesignationEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
	    	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside DesignationEditSubmit.htm "+UserId);		
			try {				
				String desigid=req.getParameter("desigid");
				String desigcode=req.getParameter("desigcode");
				String designation=req.getParameter("designation");
				String Limit=req.getParameter("limit");
				String olddesigsr=req.getParameter("olddesigsr");
				String desigsr=req.getParameter("desigsr");
				
				EmployeeDesigDto dto=new EmployeeDesigDto(); 
				dto.setDesigId(desigid);
				dto.setDesigCode(desigcode);
				dto.setDesignation(designation);
				dto.setDesigLimit(Limit);
				dto.setDesigSr(desigsr);
				dto.setOldDesigSr(olddesigsr);
				long count=service.DesignationEditSubmit(dto);
				
				if (count > 0) {
					redir.addAttribute("result", "Designation Updated Successfully");
				} else {
					redir.addAttribute("resultfail", "Designation Update Unsuccessfully");
				}				
				return "redirect:/DesignationMaster.htm";
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside DesignationEditSubmit.htm "+UserId, e);
					return "static/Error";
			}
	    }
	    
	    
	    
	    @RequestMapping(value = "DesignationAddSubmit.htm",method=RequestMethod.POST )
		public String DesignationAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
	    	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside DesignationAddSubmit.htm "+UserId);		
			try {				
				String desigcode=req.getParameter("desigcode");
				String designation=req.getParameter("designation");
				String Limit=req.getParameter("limit");
				
				EmployeeDesigDto dto=new EmployeeDesigDto(); 
				dto.setDesigCode(desigcode);
				dto.setDesignation(designation);
				dto.setDesigLimit(Limit);
				long count=service.DesignationAddSubmit(dto);
				if (count > 0) {
					redir.addAttribute("result", "Designation Added Successfully");
				} else {
					redir.addAttribute("resultfail", "Designation Adding Unsuccessfully");
				}

				
				return "redirect:/DesignationMaster.htm";
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside DesignationAddSubmit.htm "+UserId, e);
					return "static/Error";
			}
	    }
	    
	    @RequestMapping(value = "DesignationAddCheck.htm", method = RequestMethod.GET)
		  public @ResponseBody String DesignationAddCheck(HttpSession ses, HttpServletRequest req) throws Exception 
		  {
			String UserId=(String)ses.getAttribute("Username");
			Object[] DisDesc = null;
			logger.info(new Date() +"Inside DesignationAddCheck.htm "+UserId);
			try
			{	  
				String desigcode=req.getParameter("dcode");
				String designation=req.getParameter("dname");
				DisDesc =service.DesignationAddCheck(desigcode,designation);
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +"Inside DesignationAddCheck.htm "+UserId,e);
			}
			  Gson json = new Gson();
			  return json.toJson(DisDesc);           
			  
		}
	    
	    @RequestMapping(value = "DesignationEditCheck.htm", method = RequestMethod.GET)
		  public @ResponseBody String DesignationEditCheck(HttpSession ses, HttpServletRequest req) throws Exception 
		  {
			String UserId=(String)ses.getAttribute("Username");
			Object[] DisDesc = null;
			logger.info(new Date() +"Inside DesignationEditCheck.htm "+UserId);
			try
			{	  
				String desigcode=req.getParameter("dcode");
				String designation=req.getParameter("dname");
				String desigid=req.getParameter("desigid");
				DisDesc =service.DesignationEditCheck(desigcode,designation,desigid);
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +"Inside DesignationEditCheck.htm "+UserId,e);
			}
			  Gson json = new Gson();
			  return json.toJson(DisDesc); 
			  
		}
	
	   @RequestMapping(value = { "DivisionMaster.htm" }, method = { RequestMethod.GET })
		public String  DivisionMasterList(HttpServletRequest req, HttpSession ses) throws Exception {
			
		 final String UserId = (String)ses.getAttribute("Username");
		 String LabCode =(String) ses.getAttribute("labcode");
		 AdminController.logger.info(new Date() +" Inside DivisionMaster.htm " +  UserId );	
			
			req.setAttribute("DivisionMasterList", (Object)this.service.DivisionMasterList(LabCode));

			return "admin/DivisionList";
		}
	    
	    
	    @RequestMapping (value="DivisionMaster.htm", method= RequestMethod.POST)
		public String DivisionAddEdit(HttpServletRequest req, HttpSession ses, HttpServletResponse res,RedirectAttributes redir) throws Exception {
			
			String Userid = (String) ses.getAttribute("Username");
			String Option= req.getParameter("sub");
			String DivisionId= req.getParameter("Did");
			String LabCode = (String)ses.getAttribute("labcode");
			
			logger.info(new Date() +"Inside DivisionMaster.htm "+ Userid);	

			try {
				
			if(Option.equalsIgnoreCase("add")) {
				
				req.setAttribute("DivisionGroupListAdd", service.DivisionGroupList().stream().filter(e-> LabCode.equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()));
				req.setAttribute("DivisionHeadListAdd", service.DivisionHeadList().stream().filter( e-> LabCode.equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()));
				
				return "admin/DivisionMasterAdd";
			}
			
			
			else if(Option.equalsIgnoreCase("edit")) {
				
				req.setAttribute("DivisionMasterEditData", service.DivisionMasterEditData(DivisionId).get(0));
				req.setAttribute("DivisionGroupList",service.DivisionGroupList().stream().filter(e-> LabCode.equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()));
				req.setAttribute("DivisionHeadList", service.DivisionHeadList().stream().filter( e-> LabCode.equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()));

				
				
				return "admin/DivisionMasterEdit";
			}
			
			}
			catch(Exception e){
				
				redir.addAttribute("resultfail", "Technical Issue");
				logger.error(new Date() +" Inside DivisionMaster.htm "+ Userid, e);

			}
			
			return "redirect:/DivisionMaster.htm";	
		}
	    
	    
	    @RequestMapping(value = "DivisionAddCheck.htm", method = RequestMethod.GET)
		  public @ResponseBody String DivisionAddCheck(HttpSession ses, HttpServletRequest req) throws Exception 
		  {
			String UserId=(String)ses.getAttribute("Username");
			Object[] DisDesc = null;
			logger.info(new Date() +"Inside DivisionAddCheck.htm "+UserId);
			try
			{	  
				String dCode=req.getParameter("dcode");
			       String dName=req.getParameter("dname");
				DisDesc =service.DivisionAddCheck(dCode,dName);
				
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +"Inside DivisionAddCheck.htm "+UserId,e);
			}
			  Gson json = new Gson();
			  return json.toJson(DisDesc); 
			  
		}
	    
	    
	    @RequestMapping(value = "DivisionMasterAddSubmit.htm",method=RequestMethod.POST )
		public String DivisionAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
	    	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside DivisionMasterAddSubmit.htm "+UserId);		
			try {				
				String divisionCode=req.getParameter("dCode");
				String divisionName=req.getParameter("dName");
				String groupId=req.getParameter("grpId");
				String DivisionHeadName=req.getParameter("dHName");
		
				DivisionMaster dmo=new DivisionMaster(); 
				dmo.setDivisionCode(divisionCode);
				dmo.setDivisionName(divisionName);
			    dmo.setGroupId(Long.valueOf(Long.parseLong(groupId)));
				dmo.setDivisionHeadId(Long.valueOf(Long.parseLong(DivisionHeadName)));
				// dmo.setIsActive(1);
				long count=service.DivisionAddSubmit(dmo);
				if (count > 0) {
					redir.addAttribute("result", "Division Added Successfully");
				} else {
					redir.addAttribute("resultfail", "Division Adding Unsuccessfully");
				}

				return "redirect:/DivisionMaster.htm";
			}
			catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() +" Inside DivisionMasterAddSubmit.htm "+UserId, e);
					return "static/Error";
			}
	    }
	    
	    
	    @RequestMapping (value="DivisionMasterEditSubmit.htm" , method=RequestMethod.POST)

		public String DivisionMasterEdit(HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			
			String Userid = (String) ses.getAttribute("Username");
			
			logger.info(new Date() +" Inside DivisionMasterEditSubmit.htm "+Userid );
			
			try {
				
			DivisionMaster add= new DivisionMaster();
			add.setDivisionCode(req.getParameter("DivisionCode"));
			add.setDivisionName(req.getParameter("DivisionName"));
			add.setDivisionHeadId(Long.valueOf(Long.parseLong(req.getParameter("DivisionHeadName"))));
			add.setGroupId(Long.valueOf(Long.parseLong(req.getParameter("GroupId"))));
			add.setDivisionId(Long.valueOf(Long.parseLong(req.getParameter("DivisionId"))));
                   
			add.setIsActive(Integer.valueOf(req.getParameter("isActive")));
			    
			    
                      
			int count = service.DivisionMasterUpdate(add, Userid);
			
			if(count > 0 ) {
				redir.addAttribute("result", "Division Edited Successfully");
			}
			
			else {
				redir.addAttribute("result ", "Division Edit Unsuccessful");
			}
			
			}
			catch(Exception e){
				
				e.printStackTrace();
				redir.addAttribute("resultfail", "Technical Issue");
				logger.error(new Date() +" Inside DivisionMasterEditSubmit.htm "+Userid , e);
			}
			
			return "redirect:/DivisionMaster.htm";
		}
	    
	    
	    @RequestMapping(value = "Role.htm" )
		public String RoleFormAccess(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
				throws Exception {
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside Role.htm "+UserId);		
			try {
				

				req.setAttribute("LoginTypeRoles",service.LoginTypeRoles());
				req.setAttribute("FormDetailsList", service.FormDetailsList(req.getParameter("logintype"),req.getParameter("moduleid")));
				req.setAttribute("FormModulesList", service.FormModulesList());
				req.setAttribute("logintype", req.getParameter("logintype"));
				req.setAttribute("moduleid", req.getParameter("moduleid"));
				req.setAttribute("AllLabsList", service.AllLabList());
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +" Inside Role.htm "+UserId, e);
			}
			
		
			 return "admin/RoleFormAccess";
		}
	    
	    
	    @RequestMapping(value = "FormRoleActive.htm", method = RequestMethod.GET)
		public @ResponseBody String FormRoleActive(HttpSession ses, HttpServletRequest req, RedirectAttributes redir)
				throws Exception 
		{
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside FormRoleActive.htm "+UserId);
			try
			{
				String FormRoleAccessId = req.getParameter("formroleaccessid");
				service.FormRoleActive(FormRoleAccessId);
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +"Inside FormRoleActive.htm "+UserId,e);
			}

			return "admin/RoleFormAccess";
		}
	    
	    
	    @RequestMapping (value="LabHqChange.htm" , method = RequestMethod.GET)
	    public @ResponseBody String LabHqChange(HttpServletRequest req,HttpSession ses) throws Exception{
	    	
	    	String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside LabHqChange.htm "+UserId);
			try
			{
				String FormRoleAccessId = req.getParameter("formroleaccessid");
				String Value = req.getParameter("labhqvalue");
				service.LabHqChange(FormRoleAccessId,Value);
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +"Inside LabHqChange.htm "+UserId,e);
			}

			return "admin/RoleFormAccess";
	    	
	    }
	    
	    
	    
	    
	    @RequestMapping(value = "LoginType.htm", method = RequestMethod.GET)
		public String LoginType(HttpSession ses, HttpServletRequest req, RedirectAttributes redir)
				throws Exception 
		{
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside LoginType.htm "+UserId);
			try
			{
				List <Object[]> loginTypeList = service.LoginTypeList1();		
				req.setAttribute("loginTypeList", loginTypeList );
			}
			catch (Exception e) 
			{
				e.printStackTrace(); 
				logger.error(new Date() +"Inside LoginType.htm "+UserId,e);
				return "static/";
			}
			return "admin/LoginTypeList";
		}
	    
	    @RequestMapping(value = "RunBatchFile.htm")
		public String runBatchFile(HttpServletRequest req, HttpSession ses , RedirectAttributes redir) throws Exception
		{
	    	String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside RunBatchFile.htm "+UserId);
			try {
				
				if(batchfilepath!=null){
					File batchfile = new File(batchfilepath.split(" ")[0]);
					
					if(!batchfile.exists()){
						redir.addAttribute("resultfail", "Batch File Is Not Exist in the Given Path!");
						return "redirect:/MainDashBoard.htm";
					}else{
						ProcessBuilder processBuilder = new ProcessBuilder();
						processBuilder.command("cmd.exe", "/C",  batchfilepath);
						Process process = processBuilder.start();

						 if(process!=null  && process.waitFor() == 0 &&process.exitValue()== 0 )
					    {
							 redir.addAttribute("result", "Database Backup Successful");
							 return "redirect:/MainDashBoard.htm";
					    }else{
					    	redir.addAttribute("resultfail", "Database Backup UnSuccessful");
					    	return "redirect:/MainDashBoard.htm";
					    }
					}
				}else{
					redir.addAttribute("resultfail", "Batch File Path Does Not Exist !");
					return "redirect:/MainDashBoard.htm";
				}

			} catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside RunBatchFile.htm "+UserId,e);
				return "static/Error";
			}	
		}
	    
	    @Scheduled(cron ="0 0 */6 * * * ")
	    public String AutorunBatchFile() throws Exception
		{
			try {
				if(batchfilepath!=null) {
					File batchfile = new File(batchfilepath.split(" ")[0]);
					if(!batchfile.exists()){
						return "redirect:/MainDashBoard.htm";
					}else{
						ProcessBuilder processBuilder = new ProcessBuilder();
						processBuilder.command("cmd.exe", "/C",  batchfilepath);
						Process process = processBuilder.start();
						 if(process!=null  && process.waitFor() == 0 &&process.exitValue()== 0 )
					     {
							 return "redirect:/MainDashBoard.htm";
					     }else{
					    	return "redirect:/MainDashBoard.htm";
					     }
					}
				}else {
					return "redirect:/MainDashBoard.htm";
				}
			}catch(Exception e){
				e.printStackTrace(); 
				return "static/Error";
			}
		}
	    
	    @RequestMapping(value="OnBoardGroupMaster.htm")
	    public String OnBoardingGroupMaster()throws Exception
	    {
	    	try {
					
			} catch (Exception e) {
				e.printStackTrace();
			}
	    	return "admin/GroupMasterOnBoard";
	    }
	    
	    
	    
	    
	    
}
