package com.vts.pfms.requirements.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.admin.service.AdminService;
import com.vts.pfms.project.controller.ProjectController;
import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.requirements.service.RequirementService;
import com.vts.pfms.utils.PMSLogoUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
@Controller
public class RequirementsController {
	@Autowired
	PMSLogoUtil LogoUtil;
	
	@Autowired
	ProjectService service;

	@Autowired
	RequirementService reqService;
	
private static final Logger logger=LogManager.getLogger(ProjectController.class);
	
	FormatConverter fc=new FormatConverter();
	private SimpleDateFormat sdf2=fc.getRegularDateFormat();/*new SimpleDateFormat("dd-MM-yyyy");*/
	private SimpleDateFormat sdf1=fc.getSqlDateAndTimeFormat(); /* new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); */
	private SimpleDateFormat sdf3=fc.getSqlDateFormat();
	

	@RequestMapping(value="Requirements.htm")
	public String ProjectOverallRequirement(HttpServletRequest req,HttpSession ses, HttpServletResponse res,RedirectAttributes redir)throws Exception
	
	{	
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String ) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LoginType=(String)ses.getAttribute("LoginType");

		logger.info(new Date() +"Inside Requirements.htm"+UserId);
		try {
			req.setAttribute("ProjectType", "M");
			 List<Object[]> ProjectList = service.LoginProjectDetailsList(EmpId,LoginType,LabCode);
			req.setAttribute("ProjectList", ProjectList);
			String projectId=req.getParameter("projectId");
			System.out.println(projectId+"------");
			String initiationid="0";
			if(ProjectList.size()==0) {
				redir.addAttribute("resultfail","No Project is Assigned to you!");
					return  "redirect:/ProjectOverAllRequirement.htm";
			}
			if(projectId!=null) {
				req.setAttribute("projectId", projectId);
			}else {
				projectId=ProjectList.get(0)[0].toString();
				req.setAttribute("projectId", projectId);
			}
//			String projectshortName=proservice.LoginProjectDetailsList(EmpId,LoginType,LabCode).get(0)[17].toString();
		
			req.setAttribute("TotalEmployeeList", service.EmployeeList(LabCode));
			req.setAttribute("DocumentSummary", service.getDocumentSummary(initiationid,projectId));
			req.setAttribute("LabList", service.LabListDetails(LabCode));
			req.setAttribute("MemberList", service.reqMemberList(initiationid,projectId));
			req.setAttribute("EmployeeList", service.EmployeeList(LabCode,initiationid,projectId));
			req.setAttribute("AbbreviationDetails",service.getAbbreviationDetails(initiationid, projectId));
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside Requirements.htm "+UserId, e);
			return "static/Error";
		}
		return "requirements/requirements";
	}
	 @RequestMapping(value ="RequirementAppendixMain.htm",method = {RequestMethod.POST,RequestMethod.GET})//bharath
	 public String RequirementAppendixMain( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception{
		 
		 String UserId=(String)ses.getAttribute("Username");
		 String LabCode =(String) ses.getAttribute("labcode");
		 logger.info(new Date() +"Inside RequirementAppendix.htm "+UserId);
		 try {
				String initiationid = req.getParameter("initiationid");
				String ProjectId = req.getParameter("projectId");//bharath
				String projectcode=req.getParameter("projectcode");
				req.setAttribute("projectId", ProjectId);//bharath
				req.setAttribute("initiationid", initiationid);
		if(initiationid==null) {
			initiationid="0";
		}
		if(ProjectId==null) {
			ProjectId="0";
		}
//				List<Object[]>AppendixList= service.AppendixList(initiationid, ProjectId);
//				req.setAttribute("AppendixList", AppendixList);
			
				List<Object[]>AcronymsList= service.AcronymsList(initiationid, ProjectId);
				req.setAttribute("AcronymsList", AcronymsList);
				
				req.setAttribute("PerformanceList", service.getPerformanceList(initiationid, ProjectId));;
		 }
		 catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside RequirementAppendix.htm "+UserId,e);
		 }
		 return "requirements/RequirementAppendices";
	 }
	 @RequestMapping(value="ProjectRequiremntIntroductionMain.htm", method= {RequestMethod.GET, RequestMethod.POST})
		public String ProjectReqIntroductionMain(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) {
			String UserId = (String) ses.getAttribute("Username");

			logger.info(new Date() +"Inside ProjectRequiremntIntroductionMain.htm "+UserId);
			
			try {
				String initiationid = req.getParameter("initiationid");
				String project=req.getParameter("project");
				String ProjectId=req.getParameter("projectId");
				if(initiationid==null) {
					initiationid="0";
				}
				if(ProjectId==null) {
					ProjectId="0";
				}
				req.setAttribute("projectId", ProjectId);
				req.setAttribute("initiationid", initiationid);
				req.setAttribute("project", project);
				req.setAttribute("attributes", req.getParameter("attributes")==null?"Introduction":req.getParameter("attributes"));
			}catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside ProjectRequiremntIntroduction.htm "+UserId, e);
			}
			
			
			return "requirements/RequirementIntro";
		}

//		bharath changes
			@RequestMapping(value = "RequirementParaMain.htm", method = {RequestMethod.GET,RequestMethod.POST})
			public String RequirementPara(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
				String UserId = (String) ses.getAttribute("Username");
				logger.info(new Date() +"Inside RequirementParaMain.htm "+UserId);
				try {
					String ProjectId = req.getParameter("projectId");
					req.setAttribute("projectId", ProjectId);
					req.setAttribute("ParaDetails", service.ReqParaDetailsMain(ProjectId));
					req.setAttribute("paracounts", req.getParameter("paracounts")==null?"1":req.getParameter("paracounts"));
				}catch(Exception e) {
					logger.error(new Date() +" Inside RequirementPara.htm "+UserId, e);
				}
				return "requirements/ProjectRequirementPara";
			}
	 
			@RequestMapping(value = "OtherMainRequirement.htm", method = {RequestMethod.GET,RequestMethod.POST})
			public String OtherMainRequirement(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
				String UserId = (String) ses.getAttribute("Username");
				logger.info(new Date() +"Inside OtherMainRequirement.htm "+UserId);
				try {
					String projectId = req.getParameter("projectId");
					req.setAttribute("projectId", projectId);
					String initiationid = req.getParameter("initiationid");
					if(initiationid==null) {
						initiationid="0";
					}
					req.setAttribute("Otherrequirements", service.projecOtherRequirements(initiationid,projectId)); //changed the code here pass the projectId
					req.setAttribute("RequirementList", service.otherProjectRequirementList(initiationid,projectId)); // changed the code here pass the projectId
					req.setAttribute("MainId", req.getParameter("MainId")==null?"1":req.getParameter("MainId"));
				}catch(Exception e) {
					logger.error(new Date() +" Inside OtherMainRequirement.htm "+UserId, e);
				}
				return "requirements/OtherRequirements";
			}
			
			@RequestMapping(value = "RequirementVerifyMain.htm" , method= {RequestMethod.POST,RequestMethod.GET})
			public String RequirementVerify(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
			{
				String UserId=(String)ses.getAttribute("Username");
				logger.info(new Date()+ "Inside RequirementVerifyMain.htm"+UserId);
				try {
					String initiationid= req.getParameter("initiationid");
					String ProjectId=req.getParameter("projectId");
					if(initiationid==null) {
						initiationid="0";
					}
					if(ProjectId==null) {
						ProjectId="0";
					}
					req.setAttribute("initiationid", initiationid);
					req.setAttribute("projectId", ProjectId);
					req.setAttribute("Verifications", service.getVerificationListMain(ProjectId));
					req.setAttribute("paracounts", req.getParameter("paracounts")==null?"1":req.getParameter("paracounts"));
					//req.setAttribute("verificationId",req.getParameter("verificationId"));
				}catch (Exception e) {
					
				}
				return "requirements/MainProjectVerification";
			}	
			
			 @RequestMapping(value="ProjectMainRequirement.htm", method= {RequestMethod.GET, RequestMethod.POST})
				public String ProjectMainRequirement(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) {
					String UserId = (String) ses.getAttribute("Username");
					logger.info(new Date() +"Inside ProjectMainRequirement.htm "+UserId);
				try {
					String projectId= req.getParameter("projectId");
					String initiationid = req.getParameter("initiationid");
					if(initiationid==null) {
						initiationid="0";
					}

					
					List<Object[]>requirementList=reqService.RequirementList(initiationid,projectId);
					
					req.setAttribute("projectId", projectId);
					req.setAttribute("reqTypeList", service.RequirementTypeList());
					req.setAttribute("ParaDetails", service.ReqParaDetailsMain(projectId));
					req.setAttribute("RequirementList", requirementList);
					String InitiationReqId = req.getParameter("InitiationReqId");
					if(InitiationReqId==null) {
					if(requirementList!=null && requirementList.size()>0) {
						InitiationReqId=requirementList.get(0)[0].toString();
					}
					}
					req.setAttribute("InitiationReqId", InitiationReqId);

				}catch(Exception e) {
					e.printStackTrace();
				}
					
					return "requirements/ProjectRequirement";
					
			 }
			 
			
			@RequestMapping(value = "ProjectRequirementSubmit.htm", method=RequestMethod.POST)
			public String ProjectRequirementAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
					throws Exception {

				String UserId = (String) ses.getAttribute("Username");
				logger.info(new Date() + "Inside ProjectRequirementSubmit.htm " + UserId);
				String LabCode = (String) ses.getAttribute("labcode");

				String option = req.getParameter("action");
				try {
					String r = req.getParameter("reqtype");
					String[] reqtype = r.split(" ");
					Long reqTypeId = Long.parseLong(reqtype[0]);

					String projectId = req.getParameter("projectId");
					String intiationId = req.getParameter("IntiationId");
					if (projectId == null) {
						projectId = "0";
					}
					if (intiationId == null) {
						intiationId = "0";
					}
					
					
					
					Long a = (Long) service.numberOfReqTypeId(intiationId, projectId);
					String requirementId = "";
					if (a < 90L) {
						requirementId = reqtype[2] + reqtype[1] + ("000" + (a + 10));
					} else if (a < 990L) {
						requirementId = reqtype[2] + reqtype[1] + ("00" + (a + 10));
					} else {
						requirementId = reqtype[2] + reqtype[1] + ("0" + (a + 10));
					}

					String needType = req.getParameter("needtype");

					String RequirementDesc = req.getParameter("description");
					String RequirementBrief = req.getParameter("reqbrief");
					String linkedRequirements = "";
					if (req.getParameterValues("linkedRequirements") != null) {
						String[] linkedreq = req.getParameterValues("linkedRequirements");

						for (int i = 0; i < linkedreq.length; i++) {
							linkedRequirements = linkedRequirements + linkedreq[i];
							if (i != linkedreq.length - 1) {
								linkedRequirements = linkedRequirements + ",";
							}
						}
					}
					String linkedPara = "";
					if (req.getParameterValues("LinkedPara") != null) {
						String[] linkedParaArray = req.getParameterValues("LinkedPara");

						for (int i = 0; i < linkedParaArray.length; i++) {
							linkedPara = linkedPara + linkedParaArray[i];
							if (i != linkedParaArray.length - 1) {
								linkedPara = linkedPara + ",";
							}
						}
					}

					String linkedAttachements = "";
					if (req.getParameterValues("linkedAttachements") != null) {
						String[] linkedreq = req.getParameterValues("linkedAttachements");

						for (int i = 0; i < linkedreq.length; i++) {
							linkedAttachements = linkedAttachements + linkedreq[i];
							if (i != linkedreq.length - 1) {
								linkedAttachements = linkedAttachements + ",";
							}
						}
					}
					Long IntiationId = Long.parseLong(intiationId);
					PfmsInitiationRequirementDto prd = new PfmsInitiationRequirementDto();
					prd.setInitiationId(IntiationId);
					prd.setReqTypeId(reqTypeId);
					prd.setRequirementId(requirementId);
					prd.setRequirementBrief(RequirementBrief);
					prd.setRequirementDesc(RequirementDesc);
					prd.setReqCount((a.intValue() + 10));
					prd.setPriority(req.getParameter("priority"));
					prd.setLinkedRequirements(linkedRequirements);
					prd.setLinkedPara(linkedPara);
					prd.setNeedType(needType);
					prd.setRemarks(req.getParameter("remarks"));
					prd.setCategory(req.getParameter("Category"));
					prd.setConstraints(req.getParameter("Constraints"));
					prd.setLinkedDocuments(linkedAttachements);
					prd.setProjectId(Long.parseLong(projectId));
					long count = reqService.ProjectRequirementAdd(prd, UserId, LabCode);
					long InitiationReqId = count;
					if (count > 0) {
						redir.addAttribute("result", "Project Requirement Added Successfully");
					} else {
						redir.addAttribute("resultfail", "Project Requirement Add Unsuccessful");
					}
					redir.addAttribute("projectId", projectId);
					redir.addAttribute("InitiationReqId", InitiationReqId);
					return "redirect:/ProjectMainRequirement.htm";

				} catch (Exception e) {
					e.printStackTrace();
					logger.error(new Date() + "Inside ProjectRequirementSubmit.htm  " + UserId, e);
					return "static/Error";
				}
				/* return "redirect:/ProjectRequirement.htm"; */
				
			}
			

		}

