package com.vts.pfms.requirements.controller;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
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

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.font.FontProvider;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.project.controller.ProjectController;
import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;
import com.vts.pfms.project.model.PfmsInititationRequirement;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.requirements.model.Abbreviations;
import com.vts.pfms.requirements.model.DocMembers;
import com.vts.pfms.requirements.model.DocumentFreeze;
import com.vts.pfms.requirements.model.ReqDoc;
import com.vts.pfms.requirements.model.RequirementInitiation;
import com.vts.pfms.requirements.model.TestAcceptance;
import com.vts.pfms.requirements.model.TestApproach;
import com.vts.pfms.requirements.model.TestDetails;
import com.vts.pfms.requirements.model.TestPlanInitiation;
import com.vts.pfms.requirements.model.TestPlanSummary;
import com.vts.pfms.requirements.model.TestTools;
import com.vts.pfms.requirements.service.RequirementService;
import com.vts.pfms.utils.PMSLogoUtil;
@Controller
public class RequirementsController {
	@Autowired
	PMSLogoUtil LogoUtil;

	@Autowired
	ProjectService projectservice;

	@Autowired
	RequirementService service;

	@Value("${ApplicationFilesDrive}")
	String uploadpath;

	private static final Logger logger=LogManager.getLogger(ProjectController.class);

	FormatConverter fc=new FormatConverter();
	private SimpleDateFormat sdf2=fc.getRegularDateFormat();/*new SimpleDateFormat("dd-MM-yyyy");*/
	private SimpleDateFormat sdf1=fc.getSqlDateAndTimeFormat(); /* new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); */
	private SimpleDateFormat sdf3=fc.getSqlDateFormat();


	@RequestMapping(value="Requirements.htm")
	public String projectRequirementsList(HttpServletRequest req,HttpSession ses, HttpServletResponse res,RedirectAttributes redir)throws Exception

	{	
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String ) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LoginType=(String)ses.getAttribute("LoginType");

		logger.info(new Date() +"Inside Requirements.htm"+UserId);
		try {

			String projectType = req.getParameter("projectType");
			projectType = projectType!=null?projectType:"M";
			String initiationId = "0";
			String projectId = "0";
			String productTreeMainId = "0";
			if(projectType.equalsIgnoreCase("M")) {

				projectId=req.getParameter("projectId");
				productTreeMainId = req.getParameter("productTreeMainId");
				List<Object[]> projectList = projectservice.LoginProjectDetailsList(EmpId,LoginType,LabCode);
				projectId = projectId!=null?projectId: (projectList.size()>0?projectList.get(0)[0].toString():"0");

				List<Object[]> productTreeList = service.productTreeListByProjectId(projectId);
				//				productTreeMainId = productTreeMainId!=null?productTreeMainId: (productTreeList.size()>0?productTreeList.get(0)[0].toString():"0");
				productTreeMainId = productTreeMainId!=null?productTreeMainId:"0";
				req.setAttribute("projectDetails", projectservice.getProjectDetails(LabCode, projectId, "E"));
				req.setAttribute("ProjectList", projectList);
				req.setAttribute("projectId", projectId);
				req.setAttribute("productTreeList", productTreeList );
				req.setAttribute("productTreeMainId", productTreeMainId);
				req.setAttribute("initiationReqList", service.initiationReqList(projectId, productTreeMainId, "0"));
			}else {
				initiationId = req.getParameter("initiationId");
				List<Object[]> preProjectList = service.getPreProjectList(LoginType, LabCode, EmpId);
				initiationId = initiationId!=null?initiationId: (preProjectList.size()>0?preProjectList.get(0)[0].toString():"0");
				req.setAttribute("preProjectList", preProjectList);
				req.setAttribute("initiationId", initiationId);
				req.setAttribute("initiationReqList", service.initiationReqList("0", "0", initiationId));
			}

			req.setAttribute("projectType", projectType);
			req.setAttribute("requirementApprovalFlowData", service.getRequirementApprovalFlowData(initiationId, projectId, productTreeMainId));

		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside Requirements.htm "+UserId, e);
			return "static/Error";
		}
		return "requirements/ProjectRequirementsList";
	}

	@RequestMapping(value="ProjectRequirementDetails.htm")
	public String ProjectRequirementDetails(HttpServletRequest req,HttpSession ses, HttpServletResponse res,RedirectAttributes redir) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String ) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LoginType=(String)ses.getAttribute("LoginType");

		logger.info(new Date() +"Inside ProjectRequirementDetails.htm"+UserId);
		try {
			String reqInitiationId=req.getParameter("reqInitiationId");
			String projectType = null;
			String projectId = null;
			String initiationId = null;
			String productTreeMainId = null;
			RequirementInitiation reqInitiation = null;
			if(!reqInitiationId.equals("0")) {
				reqInitiation = service.getRequirementInitiationById(reqInitiationId);
				projectId = reqInitiation.getProjectId().toString();
				initiationId = reqInitiation.getInitiationId().toString();
				productTreeMainId = reqInitiation.getProductTreeMainId().toString();
				projectType = projectId.equals("0")?"I":"M";

				reqInitiationId = service.getFirstVersionReqInitiationId(initiationId, projectId, productTreeMainId)+"";
			}else {
				projectType = req.getParameter("projectType");
				projectId = req.getParameter("projectId");
				initiationId = req.getParameter("initiationId");
				productTreeMainId = req.getParameter("productTreeMainId");

				initiationId = initiationId!=null && !initiationId.isEmpty() ?initiationId:"0";
				projectId = projectId!=null && !projectId.isEmpty() ?projectId:"0";
				productTreeMainId = productTreeMainId!=null && !productTreeMainId.isEmpty() ?productTreeMainId:"0";
			}

			projectType = projectType==null?(projectId.equals("0")?"I":"M"):projectType;

			if(projectType!=null && projectType.equalsIgnoreCase("I")) {

				redir.addAttribute("initiationId", initiationId);
				redir.addAttribute("reqInitiationId", reqInitiationId);
				return "redirect:/ProjectOverAllRequirement.htm";
			}

			req.setAttribute("projectType", projectType);
			req.setAttribute("projectId", projectId);
			req.setAttribute("initiationId", initiationId);
			req.setAttribute("productTreeMainId", productTreeMainId);
			req.setAttribute("reqInitiationId", reqInitiationId);

			req.setAttribute("TotalEmployeeList", projectservice.EmployeeList(LabCode));
			req.setAttribute("DocumentSummary", projectservice.getDocumentSummary(reqInitiationId));
			req.setAttribute("LabList", projectservice.LabListDetails(LabCode));
			req.setAttribute("MemberList", projectservice.reqMemberList(reqInitiationId));
			req.setAttribute("EmployeeList", projectservice.EmployeeList(LabCode,reqInitiationId));
			req.setAttribute("AbbreviationDetails",projectservice.getAbbreviationDetails(reqInitiationId));
			req.setAttribute("ApplicableDocumentList", service.ApplicableDocumentList(reqInitiationId));
			req.setAttribute("ApplicableTotalDocumentList", service.ApplicableTotalDocumentList(reqInitiationId));

			req.setAttribute("projectDetails", projectservice.getProjectDetails(LabCode, projectId, "E"));
			req.setAttribute("reqInitiation", reqInitiation);

			req.setAttribute("result", req.getParameter("result"));
			req.setAttribute("resultfail", req.getParameter("resultfail"));
			return "requirements/ProjectRequirementDetails";
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectRequirementDetails.htm "+UserId, e);
			return "static/Error";
		}
	}



	@RequestMapping(value ="RequirementAppendixMain.htm",method = {RequestMethod.POST,RequestMethod.GET})//bharath
	public String RequirementAppendixMain( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception{

		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RequirementAppendix.htm "+UserId);
		try {
			req.setAttribute("projectId", req.getParameter("projectId"));//bharath
			req.setAttribute("initiationId", req.getParameter("initiationId"));
			req.setAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
			req.setAttribute("reqInitiationId", req.getParameter("reqInitiationId"));
			req.setAttribute("AcronymsList", projectservice.AcronymsList(req.getParameter("reqInitiationId")));
			req.setAttribute("PerformanceList", projectservice.getPerformanceList(req.getParameter("reqInitiationId")));;
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
			String productTreeMainId=req.getParameter("productTreeMainId");
			String reqInitiationId=req.getParameter("reqInitiationId");
			if(initiationid==null) {
				initiationid="0";
			}
			if(ProjectId==null) {
				ProjectId="0";
			}
			if(productTreeMainId==null) {
				productTreeMainId="0";
			}
			req.setAttribute("projectId", ProjectId);
			req.setAttribute("initiationid", initiationid);
			req.setAttribute("project", project);
			req.setAttribute("reqInitiationId", reqInitiationId);
			req.setAttribute("productTreeMainId", productTreeMainId);
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
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RequirementParaMain.htm "+UserId);
		try {
			String projectId = req.getParameter("projectId");
			String productTreeMainId = req.getParameter("productTreeMainId");
			String reqInitiationId = req.getParameter("reqInitiationId");
			req.setAttribute("projectId", projectId);
			req.setAttribute("productTreeMainId", productTreeMainId);
			req.setAttribute("reqInitiationId", reqInitiationId);
			req.setAttribute("ParaDetails", projectservice.ReqParaDetailsMain(reqInitiationId));
			req.setAttribute("SQRFile", projectservice.SqrFiles(reqInitiationId)); 
			req.setAttribute("paracounts", req.getParameter("paracounts")==null?"1":req.getParameter("paracounts"));
			req.setAttribute("projectDetails", projectservice.getProjectDetails(LabCode, projectId, "E"));
		}catch(Exception e) {
			logger.error(new Date() +" Inside RequirementParaMain.htm "+UserId, e);
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
			req.setAttribute("Otherrequirements", projectservice.projecOtherRequirements(initiationid,projectId)); //changed the code here pass the projectId
			req.setAttribute("RequirementList", projectservice.otherProjectRequirementList(initiationid,projectId)); // changed the code here pass the projectId
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
			String initiationId = req.getParameter("initiationId");
			String projectId = req.getParameter("projectId");
			String productTreeMainId =req.getParameter("productTreeMainId");
			String reqInitiationId =req.getParameter("reqInitiationId");
			if(initiationId==null) initiationId="0";
			if(projectId==null) projectId="0";
			if(productTreeMainId==null) productTreeMainId="0";

			req.setAttribute("initiationid", initiationId);
			req.setAttribute("projectId", projectId);
			req.setAttribute("productTreeMainId", productTreeMainId);
			req.setAttribute("reqInitiationId", reqInitiationId);
			req.setAttribute("Verifications", projectservice.getVerificationListMain(reqInitiationId));
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
			String reqInitiationId = req.getParameter("reqInitiationId");
			if(initiationid==null) {
				initiationid="0";
			}



			List<Object[]>requirementList=service.RequirementList(reqInitiationId);

			req.setAttribute("projectId", projectId);
			req.setAttribute("reqTypeList", projectservice.RequirementTypeList());
			req.setAttribute("ParaDetails", projectservice.ReqParaDetailsMain(projectId));
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
			String reqInitiationId = req.getParameter("reqInitiationId");
			if (projectId == null) {
				projectId = "0";
			}
			if (intiationId == null) {
				intiationId = "0";
			}



			Long a = (Long) projectservice.numberOfReqTypeId(intiationId, projectId);
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
			//					prd.setInitiationId(IntiationId);
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
			//					prd.setProjectId(Long.parseLong(projectId));
			prd.setReqInitiationId(Long.parseLong(reqInitiationId));
			long count = service.ProjectRequirementAdd(prd, UserId, LabCode);
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

	@RequestMapping(value="ProjectSpecifications.htm",method = {RequestMethod.GET,RequestMethod.POST})
	public String  ProjectSpecifications(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) {
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LoginType=(String)ses.getAttribute("LoginType");
		String LabCode =(String ) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectSpecifications.htm "+UserId);
		try {
			String projectType= req.getParameter("projectType");
			String projectId = req.getParameter("projectId");
			String initiationId = req.getParameter("initiationId");
			if(projectType==null) {
				projectType="M";
			}
			req.setAttribute("projectType", projectType);
			List<Object[]> MainProjectList = projectservice.LoginProjectDetailsList(EmpId,LoginType,LabCode);// main Project List
			List <Object[]> InitiationProjectList = projectservice.ProjectIntiationList(EmpId,LoginType,LabCode); // initiationProject
			if(projectType.equalsIgnoreCase("M")) {
				req.setAttribute("MainProjectList", MainProjectList);
				if(projectId==null) {
					projectId=MainProjectList.get(0)[0].toString();
					initiationId="0";
				}
			}else {
				req.setAttribute("InitiationProjectList", InitiationProjectList);
				if(initiationId==null) {
					initiationId=InitiationProjectList.get(0)[0].toString();
					projectId="0";
				}
			}
			req.setAttribute("projectId", projectId);
			req.setAttribute("initiationId", initiationId);

		}catch (Exception e) {
			e.printStackTrace();
		}


		return "requirements/Specification";
	}

	@RequestMapping(value="ProjectTestPlan.htm")
	public String projectTestPlanList(HttpServletRequest req,HttpSession ses, HttpServletResponse res,RedirectAttributes redir)throws Exception

	{	
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String ) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LoginType=(String)ses.getAttribute("LoginType");

		logger.info(new Date() +"Inside ProjectTestPlan.htm"+UserId);
		try {

			String projectType = req.getParameter("projectType");
			projectType = projectType!=null?projectType:"M";

			String initiationId = "0";
			String projectId = "0";
			String productTreeMainId = "0";
			if(projectType.equalsIgnoreCase("M")) {
				projectId=req.getParameter("projectId");
				productTreeMainId = req.getParameter("productTreeMainId");

				List<Object[]> projectList = projectservice.LoginProjectDetailsList(EmpId,LoginType,LabCode);
				projectId = projectId!=null?projectId: (projectList.size()>0?projectList.get(0)[0].toString():"0");

				List<Object[]> productTreeList = service.productTreeListByProjectId(projectId);
				//				productTreeMainId = productTreeMainId!=null?productTreeMainId: (productTreeList.size()>0?productTreeList.get(0)[0].toString():"0");
				productTreeMainId = productTreeMainId!=null?productTreeMainId:"0";
				req.setAttribute("projectDetails", projectservice.getProjectDetails(LabCode, projectId, "E"));
				req.setAttribute("ProjectList", projectList);
				req.setAttribute("projectId", projectId);
				req.setAttribute("productTreeList", productTreeList );
				req.setAttribute("productTreeMainId", productTreeMainId);
				req.setAttribute("initiationTestPlanList", service.initiationTestPlanList(projectId, productTreeMainId, "0"));
			}else {
				initiationId = req.getParameter("initiationId");
				List<Object[]> preProjectList = service.getPreProjectList(LoginType, LabCode, EmpId);
				initiationId = initiationId!=null?initiationId: (preProjectList.size()>0?preProjectList.get(0)[0].toString():"0");
				req.setAttribute("preProjectList", preProjectList);
				req.setAttribute("initiationId", initiationId);
				req.setAttribute("initiationTestPlanList", service.initiationTestPlanList("0", "0", initiationId));
			}

			req.setAttribute("projectType", projectType);

			req.setAttribute("testPlanApprovalFlowData", service.getTestPlanApprovalFlowData(initiationId, projectId, productTreeMainId));

		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectTestPlan.htm "+UserId, e);
			return "static/Error";
		}
		return "requirements/ProjectTestPlanList";
	}

	@RequestMapping(value="ProjectTestPlanDetails.htm")
	public String projectTestPlanDetails(HttpServletRequest req,HttpSession ses, HttpServletResponse res,RedirectAttributes redir)throws Exception
	{	
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String ) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LoginType=(String)ses.getAttribute("LoginType");
		logger.info(new Date() +"Inside ProjectTestPlanDetails.htm"+UserId);
		try {
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");
			String projectType = null;
			String projectId = null;
			String initiationId = null;
			String productTreeMainId = null;
			TestPlanInitiation testPlanInitiation = null;
			if(!testPlanInitiationId.equals("0")) {
				testPlanInitiation = service.getTestPlanInitiationById(testPlanInitiationId);
				projectId = testPlanInitiation.getProjectId().toString();
				initiationId = testPlanInitiation.getInitiationId().toString();
				productTreeMainId = testPlanInitiation.getProductTreeMainId().toString();
				projectType = projectId.equals("0")?"I":"M";

				testPlanInitiationId = service.getFirstVersionTestPlanInitiationId(initiationId, projectId, productTreeMainId)+"";
			}else {
				projectType = req.getParameter("projectType");
				projectId = req.getParameter("projectId");
				initiationId = req.getParameter("initiationId");
				productTreeMainId = req.getParameter("productTreeMainId");

				initiationId = initiationId!=null && !initiationId.isEmpty() ?initiationId:"0";
				projectId = projectId!=null && !projectId.isEmpty() ?projectId:"0";
				productTreeMainId = productTreeMainId!=null && !productTreeMainId.isEmpty() ?productTreeMainId:"0";
			}

			projectType = projectType==null?(projectId.equals("0")?"I":"M"):projectType;

			req.setAttribute("projectType", projectType);
			req.setAttribute("projectId", projectId);
			req.setAttribute("initiationId", initiationId);
			req.setAttribute("productTreeMainId", productTreeMainId);
			req.setAttribute("testPlanInitiationId", testPlanInitiationId);

			req.setAttribute("AbbreviationDetails",service.AbbreviationDetails(testPlanInitiationId, "0"));
			req.setAttribute("MemberList", service.DocMemberList(testPlanInitiationId, "0"));
			req.setAttribute("EmployeeList", projectservice.EmployeeList1(LabCode,testPlanInitiationId,"0"));
			req.setAttribute("TotalEmployeeList", projectservice.EmployeeList(LabCode));
			req.setAttribute("LabList", projectservice.LabListDetails(LabCode));
			req.setAttribute("DocumentSummary", service.getTestandSpecsDocumentSummary(testPlanInitiationId, "0"));
			req.setAttribute("TestContent", service.GetTestContentList(testPlanInitiationId));
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectTestPlanDetails.htm "+UserId, e);
			return "static/Error";
		}
		return "requirements/ProjectTestPlanDetails";
	}

	@RequestMapping(value="AbbreviationExcelUploads.htm" ,method = {RequestMethod.POST,RequestMethod.GET})
	public String DivisionmasterExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ExcelUploads.htm "+UserId);
		try{
			String action = req.getParameter("Action"); 
			String initiationId  = req.getParameter("initiationId");
			String projectId =req.getParameter("projectId");
			String productTreeMainId =req.getParameter("productTreeMainId");
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");
			String SpecsInitiationId= req.getParameter("SpecsInitiationId");

			if(initiationId==null) initiationId="0";
			if(projectId==null) projectId="0";	
			if(productTreeMainId==null) productTreeMainId="0";

			if("GenerateExcel".equalsIgnoreCase(action)) {
				XSSFWorkbook workbook = new XSSFWorkbook();
				XSSFSheet sheet =  workbook.createSheet("Abbreviation Details");
				XSSFRow row=sheet.createRow(0);
				CellStyle unlockedCellStyle = workbook.createCellStyle();
				unlockedCellStyle.setLocked(true);

				row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
				row.createCell(1).setCellValue("Abbreviation");sheet.setColumnWidth(1, 5000);
				row.createCell(2).setCellValue("Meaning");sheet.setColumnWidth(2, 5000);

				int r=0;

				row=sheet.createRow(++r);
				row.createCell(0).setCellValue(String.valueOf(r));
				row.createCell(1).setCellValue("");
				row.createCell(2).setCellValue("");

				res.setContentType("application/vnd.ms-excel");
				res.setHeader("Content-Disposition", "attachment; filename=Abbreviation Details.xls");	
				workbook.write(res.getOutputStream());
			}else if("UploadExcel".equalsIgnoreCase(action)) {
				if(ServletFileUpload.isMultipartContent(req)) {
					List<FileItem> multiparts = new ServletFileUpload( new DiskFileItemFactory()).parseRequest(new ServletRequestContext(req));
					Part filePart = req.getPart("filename");
					List<Abbreviations>iaList=new ArrayList<>();
					InputStream fileData = filePart.getInputStream();
					Workbook workbook = new XSSFWorkbook(fileData);
					Sheet sheet  = workbook.getSheetAt(0);
					int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum(); 

					if(SpecsInitiationId==null) {
						if(testPlanInitiationId.equals("0") ) {					
							testPlanInitiationId = Long.toString(service.testPlanInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null,null));
						}
					}
					if(testPlanInitiationId==null) {
						if(SpecsInitiationId.equals("0") ) {					
							SpecsInitiationId = Long.toString(service.SpecificationInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId));
						}
					}


					for (int i=1;i<=rowCount;i++) {

						int cellcount= sheet.getRow(i).getLastCellNum();
						Abbreviations iA= new Abbreviations();

						for(int j=1;j<cellcount;j++) {

							if(sheet.getRow(i).getCell(j)!=null) {
								if(j==1) {
									switch(sheet.getRow(i).getCell(j).getCellType()) {
									case Cell.CELL_TYPE_BLANK:break;
									case Cell.CELL_TYPE_NUMERIC:
										iA.setAbbreviations(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
										break;
									case Cell.CELL_TYPE_STRING:
										iA.setAbbreviations(sheet.getRow(i).getCell(j).getStringCellValue());
										break;	 
									}
								}

								if(j==2) {
									switch(sheet.getRow(i).getCell(j).getCellType()) {
									case Cell.CELL_TYPE_BLANK:break;
									case Cell.CELL_TYPE_NUMERIC:
										iA.setMeaning(String.valueOf((long)sheet.getRow(i).getCell(j).getNumericCellValue()));
										break;
									case Cell.CELL_TYPE_STRING:
										iA.setMeaning(sheet.getRow(i).getCell(j).getStringCellValue());
										break;	 
									}


								}	 
							}
						}



						//						iA.setInitiationId(Long.parseLong(initiationId));
						//						iA.setProjectId(Long.parseLong(projectId));//bharath
						iA.setTestPlanInitiationId(testPlanInitiationId==null?0L:Long.parseLong(testPlanInitiationId));
						iA.setSpecsInitiationId(SpecsInitiationId==null ?0L :Long.parseLong(SpecsInitiationId));
						iA.setAbbreviationType("T");
						if(iA.getAbbreviations()!=null && iA.getMeaning()!=null) {
							iaList.add(iA);
						}

					}
					long Count= service.addAbbreviations(iaList);
					if(Count>0) {
						redir.addAttribute("result","Abbreviations Added Successfully");
					}else {
						redir.addAttribute("resultfail","Abbreviations Add UnSuccessfully");//bharath
					}
					redir.addAttribute("initiationId",initiationId);
					redir.addAttribute("projectId",projectId);
					redir.addAttribute("productTreeMainId",productTreeMainId);
					if(SpecsInitiationId==null) {
						redir.addAttribute("testPlanInitiationId",testPlanInitiationId);
						return "redirect:/ProjectTestPlanDetails.htm";
					}else {
						redir.addAttribute("SpecsInitiationId", SpecsInitiationId);
						return "redirect:/ProjectSpecificationDetails.htm";
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			redir.addAttribute("resultfail", " Adding Unsuccessfully");
			logger.error(new Date() +"Inside ExcelUpload.htm "+UserId,e);//bharath
		}
		return "static/Error";
	}
	@RequestMapping(value="MemberSubmit.htm" ,method = {RequestMethod.POST,RequestMethod.GET})
	public String RequirementMemberSubmit( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	{

		String UserId=(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside RequirementMemberSubmit.htm "+UserId);
		try {
			String initiationId  = req.getParameter("initiationId");
			String projectId =req.getParameter("projectId");
			String productTreeMainId =req.getParameter("productTreeMainId");
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");
			String SpecsInitiationId= req.getParameter("SpecsInitiationId");
			if(initiationId==null) initiationId="0";
			if(projectId==null) projectId="0";	
			if(productTreeMainId==null) productTreeMainId="0";

			if(SpecsInitiationId==null) {
				if(testPlanInitiationId.equals("0") ) {					
					testPlanInitiationId = Long.toString(service.testPlanInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null,null));
				}
			}
			if(testPlanInitiationId==null) {
				if(SpecsInitiationId.equals("0") ) {					
					SpecsInitiationId = Long.toString(service.SpecificationInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId));
				}
			}


			String [] Assignee = req.getParameterValues("Assignee");
			DocMembers rm = new DocMembers();
			//			rm.setProjectId(Long.parseLong(projectId));
			//			rm.setInitiationId(Long.parseLong(initiationId));
			rm.setTestPlanInitiationId(testPlanInitiationId==null?0L:Long.parseLong(testPlanInitiationId));
			rm.setCreatedBy(UserId);
			rm.setCreatedDate(sdf1.format(new Date()));
			rm.setEmps(Assignee);
			rm.setMemeberType("T");
			rm.setSpecsInitiationId(SpecsInitiationId==null ?0L :Long.parseLong(SpecsInitiationId));
			long count = service.AddDocMembers(rm);
			if(count>0) {
				redir.addAttribute("result","Members Added Successfully for Document Distribution");
			}else{
				redir.addAttribute("resultfail","Document Summary adding unsuccessful ");
			}

			redir.addAttribute("initiationId",initiationId);
			redir.addAttribute("projectId",projectId);
			redir.addAttribute("productTreeMainId",productTreeMainId);
			if(SpecsInitiationId==null) {
				redir.addAttribute("testPlanInitiationId",testPlanInitiationId);
				return "redirect:/ProjectTestPlanDetails.htm";
			}else {
				redir.addAttribute("SpecsInitiationId", SpecsInitiationId);
				return "redirect:/ProjectSpecificationDetails.htm";
			}
		}catch (Exception e) {
			e.printStackTrace();

			logger.info(new Date() +"Inside RequirementMemberSubmit.htm "+UserId);
		}
		return "static/Error";
	}
	@RequestMapping(value="TestScope.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public String ProjectReqIntroduction(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside TestScope.htm "+UserId);

		try {
			req.setAttribute("initiationId", req.getParameter("initiationId"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			req.setAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
			req.setAttribute("testPlanInitiationId", req.getParameter("testPlanInitiationId"));

			req.setAttribute("attributes", req.getParameter("attributes")==null?"Introduction":req.getParameter("attributes"));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside TestScope.htm "+UserId, e);
		}
		return "requirements/TestScope";
	}
	@RequestMapping(value="TestScopeSubmit.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String RequiremnetIntroSubmit(HttpServletRequest req,HttpSession ses, RedirectAttributes redir) {
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside RequiremnetIntroSubmit.htm "+UserId);
		try {
			String initiationId  = req.getParameter("initiationId");
			String projectId =req.getParameter("projectId");
			String productTreeMainId =req.getParameter("productTreeMainId");
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");

			if(initiationId==null) initiationId="0";
			if(projectId==null) projectId="0";	
			if(productTreeMainId==null) productTreeMainId="0";

			if(testPlanInitiationId.equals("0") ) {					
				testPlanInitiationId = Long.toString(service.testPlanInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null,null));
			}

			String attributes=req.getParameter("attributes");
			String Details=req.getParameter("Details");
			Object[]TestScopeInto=service.TestScopeIntro(testPlanInitiationId);
			long count=0l;
			if(TestScopeInto==null) {
				// this is for add
				count=service.TestScopeIntroSubmit(testPlanInitiationId,attributes,Details,UserId);
			}else {
				// this is for edit 
				count=service.TestScopeUpdate(testPlanInitiationId,attributes,Details,UserId);

			}
			if (count > 0) {
				redir.addAttribute("result", attributes+" updated Successfully");
			} else {
				redir.addAttribute("resultfail", attributes+" update Unsuccessful");
			}
			redir.addAttribute("initiationId",initiationId);
			redir.addAttribute("projectId",projectId);
			redir.addAttribute("productTreeMainId",productTreeMainId);
			redir.addAttribute("testPlanInitiationId",testPlanInitiationId);
			redir.addAttribute("attributes",req.getParameter("attributes"));
			return "redirect:/TestScope.htm";
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "static/Error";
	}

	@RequestMapping(value="TestScopeIntroAjax.htm",method = {RequestMethod.GET})
	public @ResponseBody String RequirementIntroDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside RequirementIntro.htm "+UserId);
		Object[]TestScopeIntroDetails=null;
		try {
			String testPlanInitiationId=req.getParameter("testPlanInitiationId");
			//			String projectId=req.getParameter("projectId");
			//			String ProjectType=req.getParameter("ProjectType");

			TestScopeIntroDetails=service.TestScopeIntro(testPlanInitiationId);
		}
		catch(Exception e){
			e.printStackTrace();
			logger.error(new Date() +" Inside TestScopeIntroAjax.htm"+UserId, e);
		}
		Gson json = new Gson();
		return json.toJson(TestScopeIntroDetails);
	}
	@RequestMapping(value = "TestDocumentDownlod.htm" )
	public String testDocumentDownlod(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String ) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RequirementDocumentDownlod.htm "+UserId);
		try {
			Object[] DocTempAttributes =null;
			DocTempAttributes= projectservice.DocTempAttributes();
			req.setAttribute("DocTempAttributes", DocTempAttributes);

			String testPlanInitiationId = req.getParameter("testPlanInitiationId");

			TestPlanInitiation testPlanInitiation = service.getTestPlanInitiationById(testPlanInitiationId);
			testPlanInitiationId = service.getFirstVersionTestPlanInitiationId( testPlanInitiation.getInitiationId()+"", testPlanInitiation.getProjectId()+"", testPlanInitiation.getProductTreeMainId()+"")+"";

			String filename="ProjectRequirement";
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			req.setAttribute("lablogo",  LogoUtil.getLabLogoAsBase64String(LabCode)); 
			req.setAttribute("LabImage",  LogoUtil.getLabImageAsBase64String(LabCode)); 
			req.setAttribute("LabList", projectservice.LabListDetails(LabCode));
			req.setAttribute("uploadpath", uploadpath);
			req.setAttribute("TestScopeIntro",service.TestScopeIntro(testPlanInitiationId));
			req.setAttribute("MemberList", service.DocMemberList(testPlanInitiationId, "0"));
			req.setAttribute("TestDocumentSummary", service.getTestandSpecsDocumentSummary(testPlanInitiationId, "0"));
			req.setAttribute("AbbreviationDetails",service.AbbreviationDetails(testPlanInitiationId, "0"));
			req.setAttribute("TestContent", service.GetTestContentList(testPlanInitiationId));
			req.setAttribute("AcceptanceTesting", service.GetAcceptanceTestingList(testPlanInitiationId));
			req.setAttribute("TestSuite", service.TestTypeList());
			req.setAttribute("TestDetailsList", service.TestDetailsList(testPlanInitiationId) );
			req.setAttribute("TestTypeList", service.TestTypeList());
			req.setAttribute("StagesApplicable", service.StagesApplicable());

			File my_file=null;
			File my_file1=null;
			File my_file2=null;
			File my_file3=null;
			File my_file4=null;

			List<Object[]>list=	service.GetAcceptanceTestingList(testPlanInitiationId);
			String TestSetUp=null;
			String TestSetUpDiagram=null;
			String Testingtools=null;
			String TestVerification=null;
			String RoleResponsibility=null;

			for(Object[]obj:list) {
				if(obj[1].toString().equalsIgnoreCase("Test Set UP")) {
					TestSetUp=obj[2].toString();
					my_file=new File(uploadpath+obj[4]+File.separator+obj[3]);
					if(my_file!=null) {
						String htmlContent = convertExcelToHtml(new FileInputStream(my_file));
						req.setAttribute("htmlContent", htmlContent);
						req.setAttribute("TestSetUp", TestSetUp);
					}
				}
				if(obj[1].toString().equalsIgnoreCase("Test Set Up Diagram")) {

					TestSetUpDiagram=obj[2].toString();
					my_file1=new File(uploadpath+obj[4]+File.separator+obj[3]);
					if(my_file1!=null) {
						String htmlContentTestSetUpDiagram = convertExcelToHtml(new FileInputStream(my_file1));
						req.setAttribute("htmlContentTestSetUpDiagram", htmlContentTestSetUpDiagram);
						req.setAttribute("TestSetUpDiagram", TestSetUpDiagram);

					}
				}
				if(obj[1].toString().equalsIgnoreCase("Testing tools")) {
					Testingtools=obj[2].toString();
					my_file2=new File(uploadpath+obj[4]+File.separator+obj[3]);
					if(my_file2!=null) {
						String htmlContentTestingtools = convertExcelToHtml(new FileInputStream(my_file2));
						req.setAttribute("htmlContentTestingtools", htmlContentTestingtools);
						req.setAttribute("Testingtools", Testingtools);

					}
				}
				if(obj[1].toString().equalsIgnoreCase("Test Verification")) {
					TestVerification=obj[2].toString();
					my_file3=new File(uploadpath+obj[4]+File.separator+obj[3]);
					if(my_file3!=null) {
						String htmlContentTestVerification = convertExcelToHtml(new FileInputStream(my_file3));
						req.setAttribute("htmlContentTestVerification", htmlContentTestVerification);
						req.setAttribute("TestVerification", TestVerification);
					}
				}
				if(obj[1].toString().equalsIgnoreCase("Role & Responsibility")) {
					RoleResponsibility=obj[2].toString();
					my_file4=new File(uploadpath+obj[4]+File.separator+obj[3]);
					if(my_file4!=null) {
						String htmlContentRoleResponsibility = convertExcelToHtml(new FileInputStream(my_file4));
						req.setAttribute("htmlContentRoleResponsibility", htmlContentRoleResponsibility);
						req.setAttribute("RoleResponsibility", RoleResponsibility);
						System.out.println();
					}
				}

			}
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/TestPlanDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();
		}catch(Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside TestPlanDownload.jsp "+UserId,e);
		}
		return "print/TestPlanDownload";
	}
	public static String convertExcelToHtml(InputStream inputStream) throws Exception {
		Workbook workbook = new XSSFWorkbook(inputStream);
		Sheet sheet = workbook.getSheetAt(0); // Assuming you are working with the first sheet

		StringBuilder htmlContent = new StringBuilder("<table border='1' style='border-collapse: collapse;'>");

		for (Row row : sheet) {
			// Skip rows with all cells blank
			if (isRowEmpty(row)) {
				continue;
			}

			htmlContent.append("<tr style='border:1px solid black;'>");
			for (Cell cell : row) {
				htmlContent.append("<td style='border:1px solid black;'>").append(cell.toString()).append("</td>");
			}
			htmlContent.append("</tr>");
		}

		htmlContent.append("</table>");

		workbook.close();

		return htmlContent.toString();
	}
	private static boolean isRowEmpty(Row row) {
		for (Cell cell : row) {
			if (cell.getCellTypeEnum() != CellType.BLANK) {
				return false;
			}
		}
		return true;
	}

	@RequestMapping(value="TestPlanSummaryAdd.htm",method=RequestMethod.POST)
	public String RequirementSummaryAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {

		String UserId=(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		String Logintype= (String)ses.getAttribute("LoginType");

		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside TestPlanSummaryAdd.htm "+UserId);
		try {
			String initiationId  = req.getParameter("initiationId");
			String projectId =req.getParameter("projectId");
			String productTreeMainId =req.getParameter("productTreeMainId");
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");

			if(initiationId==null) initiationId="0";
			if(projectId==null) projectId="0";	
			if(productTreeMainId==null) productTreeMainId="0";	

			if(testPlanInitiationId.equals("0") ) {					
				testPlanInitiationId = Long.toString(service.testPlanInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null,null));
			}

			String action = req.getParameter("action");

			TestPlanSummary rs = action!=null && action.equalsIgnoreCase("Add") ? new TestPlanSummary() : service.getTestPlanSummaryById(req.getParameter("summaryId"));
			rs.setAbstract(req.getParameter("abstract"));
			rs.setAdditionalInformation(req.getParameter("information"));
			rs.setKeywords(req.getParameter("keywords"));
			rs.setDistribution(req.getParameter("distribution"));
			rs.setApprover(Long.parseLong(req.getParameter("approver")));;
			rs.setReviewer(req.getParameter("reviewer"));
			rs.setPreparedBy(req.getParameter("preparedBy"));
			rs.setTestPlanInitiationId(Long.parseLong(testPlanInitiationId));
			rs.setSpecsInitiationId(0L);
			if(action.equalsIgnoreCase("Add")) {
				rs.setCreatedBy(UserId);
				rs.setCreatedDate(sdf1.format(new Date()));
				rs.setIsActive(1);
			}else if(action.equalsIgnoreCase("Edit")) {

				rs.setSummaryId(Long.parseLong(req.getParameter("summaryId")));
				rs.setModifiedBy(UserId);
				rs.setModifiedDate(sdf1.format(new Date()));
			}

			long count = service.addTestPlanSummary(rs);
			if(count>0){
				redir.addAttribute("result","Document Summary "+action+"ed successfully ");
			}else{
				redir.addAttribute("resultfail","Document Summary "+action+" unsuccessful ");
			}

			redir.addAttribute("initiationId", initiationId);
			redir.addAttribute("projectId", projectId);
			redir.addAttribute("productTreeMainId", productTreeMainId);
			redir.addAttribute("testPlanInitiationId", testPlanInitiationId);
			return "redirect:/ProjectTestPlanDetails.htm";

		} catch (Exception e) {
			logger.info(new Date() +"Inside TestPlanSummaryAdd.htm "+UserId);
			return "static/Error";
		}

	}
	@RequestMapping(value="TestApprochAdd.htm",method=RequestMethod.POST)
	public String TestApprochAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {

		String UserId=(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		String Logintype= (String)ses.getAttribute("LoginType");

		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside TestApprochAdd.htm "+UserId);
		try {
			String initiationId  = req.getParameter("initiationId");
			String projectId =req.getParameter("projectId");
			String productTreeMainId =req.getParameter("productTreeMainId");
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");

			if(initiationId==null) initiationId="0";
			if(projectId==null) projectId="0";	
			if(productTreeMainId==null) productTreeMainId="0";

			if(testPlanInitiationId.equals("0") ) {					
				testPlanInitiationId = Long.toString(service.testPlanInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null,null));
			}

			TestApproach rs = new TestApproach();
			//			rs.setProjectId(Long.parseLong(projectId));
			//			rs.setInitiationId(Long.parseLong(initiationId));
			rs.setTestPlanInitiationId(Long.parseLong(testPlanInitiationId));
			rs.setTestApproach(req.getParameter("TestApproach"));
			rs.setCreatedBy(UserId);
			rs.setCreatedDate(sdf1.format(new Date()));
			rs.setIsActive(1);
			String action = req.getParameter("btn");
			req.setAttribute("attributes", req.getParameter("attributes")==null?"Introduction":req.getParameter("attributes"));

			long count=0l;
			if(action.equalsIgnoreCase("submit")) {
				count=service.addTestApproch(rs);
			} 
			if(count>0){
				redir.addAttribute("result","Test Approach added successfully ");
			}else{
				redir.addAttribute("resultfail","Test Approach add unsuccessful ");
			}

			redir.addAttribute("initiationId",initiationId);
			redir.addAttribute("projectId",projectId);
			redir.addAttribute("productTreeMainId",productTreeMainId);
			redir.addAttribute("testPlanInitiationId",testPlanInitiationId);
			return "redirect:/ProjectTestPlanDetails.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside Test ApproachAdd.htm "+UserId);
			return "static/Error";
		}
	}
	@RequestMapping(value="TestDocContentSubmit.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String TestDocContentSubmit(HttpServletRequest req,HttpSession ses, RedirectAttributes redir) {
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside TestDocContentSubmit.htm "+UserId);
		try {
			String initiationId  = req.getParameter("initiationId");
			String projectId =req.getParameter("projectId");
			String productTreeMainId =req.getParameter("productTreeMainId");
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");

			if(initiationId==null) initiationId="0";
			if(projectId==null) projectId="0";	
			if(productTreeMainId==null) productTreeMainId="0";

			if(testPlanInitiationId.equals("0") ) {					
				testPlanInitiationId = Long.toString(service.testPlanInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null,null));
			}

			String attributes=req.getParameter("attributes");
			String Details=req.getParameter("Details");
			String action = req.getParameter("Action");
			String UpdateAction=req.getParameter("UpdateAction");

			long count=0l;
			if("add".equalsIgnoreCase(action)) {
				count=service.TestDocContentSubmit(testPlanInitiationId,attributes,Details,UserId);
			} 
			else	{ 
				//this is for edit
				count=service.TestDocContentUpdate(UpdateAction,Details,UserId);
			}
			if (count > 0) {
				redir.addAttribute("result", attributes+" Submitted  Successfully");
			} else {
				redir.addAttribute("resultfail", attributes+" Submit Unsuccessful");
			}

			redir.addAttribute("attributes",req.getParameter("attributes"));
			redir.addAttribute("initiationId",initiationId);
			redir.addAttribute("projectId",projectId);
			redir.addAttribute("productTreeMainId",productTreeMainId);
			redir.addAttribute("testPlanInitiationId",testPlanInitiationId);
			return "redirect:/ProjectTestPlanDetails.htm";	

		}catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside TestDocContentSubmit.htm "+UserId);
			return "static/Error";
		}

	}
	@RequestMapping(value ="AccceptanceTesting.htm",method = {RequestMethod.POST,RequestMethod.GET})
	public String RequirementAppendix( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception{

		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside AccceptanceTesting.htm "+UserId);
		try {

			req.setAttribute("initiationId", req.getParameter("initiationId"));
			req.setAttribute("projectId", req.getParameter("projectId"));
			req.setAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
			req.setAttribute("testPlanInitiationId", req.getParameter("testPlanInitiationId"));

			req.setAttribute("AcceptanceTesting", service.GetAcceptanceTestingList(req.getParameter("testPlanInitiationId")));

		}
		catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside AccceptanceTesting.htm "+UserId,e);
		}
		return "requirements/AcceptanceTesting";
	}
	@RequestMapping(value="AcceptanceTestingUpload.htm",method= {RequestMethod.POST,RequestMethod.GET})
	public String TestVerificationUpload(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,@RequestParam("filenameC") MultipartFile FileAttach)throws Exception {

		String UserId=(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside AcceptanceTestingUpload.htm "+UserId);
		try {
			String initiationId  = req.getParameter("initiationId");
			String projectId =req.getParameter("projectId");
			String productTreeMainId =req.getParameter("productTreeMainId");
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");

			if(initiationId==null) initiationId="0";
			if(projectId==null) projectId="0";	
			if(productTreeMainId==null) productTreeMainId="0";

			if(testPlanInitiationId.equals("0") ) {					
				testPlanInitiationId = Long.toString(service.testPlanInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null,null));
			}

			String attributes=req.getParameter("attributes");
			String Details=req.getParameter("Details");
			String action=req.getParameter("Action");
			String UpdateActionid=req.getParameter("UpdateActionid");
			String filename=req.getParameter("filenameC");

			TestAcceptance re = new TestAcceptance();

			re.setAttributes(attributes);
			re.setAttributesDetailas(Details);
			//			re.setInitiationId(Long.parseLong(initiationId));//bharath
			//			re.setProjectId(Long.parseLong(projectId));
			re.setTestPlanInitiationId(Long.parseLong(testPlanInitiationId));
			re.setFile(FileAttach);

			long count=0l;
			if("add".equalsIgnoreCase(action)) {
				re.setCreatedBy(UserId);
				re.setCreatedDate(sdf1.format(new Date()));
				count = service.insertTestAcceptanceFile(re,LabCode);
			}
			else {
				count=service.TestAcceptancetUpdate(UpdateActionid,Details,UserId,FileAttach,LabCode);
			}
			if (count > 0) {
				redir.addAttribute("result"," Data & Document Uploaded Successfully");
			} else {
				redir.addAttribute("resultfail","Data & Document Uploaded UnSuccessfully");
			}
			redir.addAttribute("initiationId",initiationId);
			redir.addAttribute("projectId",projectId);
			redir.addAttribute("productTreeMainId",productTreeMainId);
			redir.addAttribute("testPlanInitiationId",testPlanInitiationId);
			return "redirect:/AccceptanceTesting.htm";
		} catch (Exception e) {
			e.printStackTrace();
			logger.info(new Date() +"Inside AcceptanceTestingUpload.htm.htm "+UserId);
			return "static/Error";
		}
	}

	@RequestMapping(value="TestSetUp.htm" ,method = {RequestMethod.POST,RequestMethod.GET})
	public String AccronymsExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ExcelUpload.htm "+UserId);

		try{
			String action = req.getParameter("Action"); 
			String initiationId=req.getParameter("initiationId");
			String projectId=req.getParameter("projectId");
			String ProjectType=req.getParameter("ProjectType");
			if("GenerateExcel".equalsIgnoreCase(action)) {

				XSSFWorkbook workbook = new XSSFWorkbook();
				XSSFSheet sheet =  workbook.createSheet("TestSetUp");
				XSSFRow row=sheet.createRow(0);

				CellStyle unlockedCellStyle = workbook.createCellStyle();
				unlockedCellStyle.setLocked(true);

				row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
				row.createCell(1).setCellValue("Test Type");sheet.setColumnWidth(1, 5000);
				row.createCell(2).setCellValue("Test Setup Name");sheet.setColumnWidth(2, 5000);

				int r=0;

				row=sheet.createRow(++r);
				row.createCell(0).setCellValue(String.valueOf(r));
				row.createCell(1).setCellValue("");
				row.createCell(2).setCellValue("");

				res.setContentType("application/vnd.ms-excel");
				res.setHeader("Content-Disposition", "attachment; filename=TestSetUp.xls");	
				workbook.write(res.getOutputStream());

			}
			if("GenerateExcelTestingTools".equalsIgnoreCase(action)) {

				XSSFWorkbook workbook = new XSSFWorkbook();
				XSSFSheet sheet =  workbook.createSheet("TestingTools");
				XSSFRow row=sheet.createRow(0);

				CellStyle unlockedCellStyle = workbook.createCellStyle();
				unlockedCellStyle.setLocked(true);

				row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
				row.createCell(1).setCellValue("Test Type");sheet.setColumnWidth(1, 5000);
				row.createCell(2).setCellValue("Test IDs");sheet.setColumnWidth(2, 5000);
				row.createCell(3).setCellValue("Test Tools");sheet.setColumnWidth(3, 5000);

				int r=0;

				row=sheet.createRow(++r);
				row.createCell(0).setCellValue(String.valueOf(r));
				row.createCell(1).setCellValue("");
				row.createCell(2).setCellValue("");
				row.createCell(3).setCellValue("");
				res.setContentType("application/vnd.ms-excel");
				res.setHeader("Content-Disposition", "attachment; filename=TestingTools.xls");	
				workbook.write(res.getOutputStream());

			}
			if("GenerateExcelDiagram".equalsIgnoreCase(action)) {

				XSSFWorkbook workbook = new XSSFWorkbook();
				XSSFSheet sheet =  workbook.createSheet("TestSetUpDiagram");
				XSSFRow row=sheet.createRow(0);

				CellStyle unlockedCellStyle = workbook.createCellStyle();
				unlockedCellStyle.setLocked(true);

				row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
				row.createCell(1).setCellValue("Diagram");sheet.setColumnWidth(1, 5000);


				int r=0;

				row=sheet.createRow(++r);
				row.createCell(0).setCellValue(String.valueOf(r));
				row.createCell(1).setCellValue("");
				row.createCell(2).setCellValue("");

				res.setContentType("application/vnd.ms-excel");
				res.setHeader("Content-Disposition", "attachment; filename=TestSetUpDiagram.xls");	
				workbook.write(res.getOutputStream());

			}
			if("GenerateTestVerificationTable".equalsIgnoreCase(action)) {

				XSSFWorkbook workbook = new XSSFWorkbook();
				XSSFSheet sheet =  workbook.createSheet("TestVerification");
				XSSFRow row=sheet.createRow(0);

				CellStyle unlockedCellStyle = workbook.createCellStyle();
				unlockedCellStyle.setLocked(true);

				row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
				row.createCell(1).setCellValue("MOP Name");sheet.setColumnWidth(1, 5000);
				row.createCell(2).setCellValue("MOP ID");sheet.setColumnWidth(2, 5000);
				row.createCell(3).setCellValue("Sub Parameters");sheet.setColumnWidth(3, 5000);
				row.createCell(4).setCellValue("Applicability(Y/N)");sheet.setColumnWidth(4, 5000);
				row.createCell(5).setCellValue("Test Name");sheet.setColumnWidth(5, 5000);
				row.createCell(6).setCellValue("Test ID");sheet.setColumnWidth(6, 5000);
				row.createCell(7).setCellValue("Test Type");sheet.setColumnWidth(7, 5000);
				int r=0;

				row=sheet.createRow(++r);
				row.createCell(0).setCellValue(String.valueOf(r));
				row.createCell(1).setCellValue("");
				row.createCell(2).setCellValue("");
				row.createCell(3).setCellValue("");
				row.createCell(4).setCellValue("");
				row.createCell(5).setCellValue("");
				row.createCell(6).setCellValue("");
				row.createCell(7).setCellValue("");
				res.setContentType("application/vnd.ms-excel");
				res.setHeader("Content-Disposition", "attachment; filename=TestVerification.xls");	
				workbook.write(res.getOutputStream());

			}
			if("GenerateTestRoleResponsibility".equalsIgnoreCase(action)) {

				XSSFWorkbook workbook = new XSSFWorkbook();
				XSSFSheet sheet =  workbook.createSheet("RoleResponsibility");
				XSSFRow row=sheet.createRow(0);

				CellStyle unlockedCellStyle = workbook.createCellStyle();
				unlockedCellStyle.setLocked(true);

				row.createCell(0).setCellValue("SN");sheet.setColumnWidth(0, 5000);
				row.createCell(1).setCellValue("Test Name");sheet.setColumnWidth(1, 5000);
				row.createCell(2).setCellValue("Role & Responsibility/Test Id");sheet.setColumnWidth(2, 5000);
				row.createCell(3).setCellValue("Names of individual");sheet.setColumnWidth(3, 5000);
				int r=0;
				row=sheet.createRow(++r);
				row.createCell(0).setCellValue(String.valueOf(r));
				row.createCell(1).setCellValue("");
				row.createCell(2).setCellValue("");
				row.createCell(3).setCellValue("");
				res.setContentType("application/vnd.ms-excel");
				res.setHeader("Content-Disposition", "attachment; filename=RoleResponsibility.xls");	
				workbook.write(res.getOutputStream());
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return "static/Error";

	}
	@RequestMapping(value = {"TestSetupFileDownload.htm"})
	public void ProjectDataSystemSpecsFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside  TestSetupFileDownload"+UserId);
		try
		{
			String ftype=req.getParameter("filename");
			String Testid=req.getParameter("UpdateActionid");
			System.out.println(Testid);
			res.setContentType("Application/octet-stream");	
			Object[] projectdatafiledata =service.AcceptanceTestingList(Testid);

			File my_file=null;


			my_file = new File(uploadpath+projectdatafiledata[4]+File.separator+projectdatafiledata[3]); 
			res.setHeader("Content-disposition","attachment; filename="+projectdatafiledata[3].toString()); 
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
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside  TestSetupFileDownload"+UserId,e);
		}
	}



	@RequestMapping(value ="RequirementList.htm",method = {RequestMethod.POST,RequestMethod.GET})
	public String RequirementList( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception{

		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside AccceptanceTesting.htm "+UserId);
		try {
			String initiationId = req.getParameter("initiationId");
			String projectId = req.getParameter("projectId");
			String productTreeMainId = req.getParameter("productTreeMainId");
			String reqInitiationId = req.getParameter("reqInitiationId");
			String project = req.getParameter("project");
			String InitiationReqId = req.getParameter("InitiationReqId");

			if(initiationId==null) {
				initiationId="0";
			}
			if(projectId==null) {
				projectId="0";
			}
			if(productTreeMainId==null) {
				productTreeMainId="0";
			}
			req.setAttribute("initiationId", initiationId);
			req.setAttribute("projectId", projectId);
			req.setAttribute("productTreeMainId", productTreeMainId);
			req.setAttribute("reqInitiationId", reqInitiationId);
			req.setAttribute("project", project);
			List<Object[]>requirementTypeList=service.requirementTypeList(reqInitiationId);	
			req.setAttribute("requirementTypeList", requirementTypeList);

			List<Object[]>RequirementList=service.RequirementList(reqInitiationId);

			req.setAttribute("RequirementList", RequirementList);

			if(InitiationReqId==null) {
				if(RequirementList!=null && RequirementList.size()>0) {
					InitiationReqId=RequirementList.get(0)[0].toString();
				}else {
					InitiationReqId ="0";
				}
			}



			req.setAttribute("InitiationReqId", InitiationReqId);
			req.setAttribute("subId", req.getParameter("subId"));
			req.setAttribute("VerificationMethodList", service.getVerificationMethodList());			
			req.setAttribute("ProjectParaDetails", service.getProjectParaDetails(reqInitiationId));

			req.setAttribute("reqInitiation", service.getRequirementInitiationById(reqInitiationId));
		}



		catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside RequirementList.htm "+UserId,e);
		}
		return "requirements/RequirementList";
	}

	//	   @RequestMapping(value="RequirementAddList.htm",method = {RequestMethod.GET})
	//		public @ResponseBody String RequirementAddList(HttpServletRequest req, HttpSession ses,@RequestParam("initiationId")String initiationId,@RequestParam("projectId")String projectId,@RequestParam("selectedValues")String selectedValues ) throws Exception {
	//			String UserId = (String)ses.getAttribute("Username");
	//			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	//			logger.info(new Date() +"Inside RequirementAddList.htm ");
	//			long count =0l;
	//			try {
	//				String productTreeMainId = req.getParameter("productTreeMainId");
	//				String reqInitiationId = req.getParameter("reqInitiationId");
	//
	//				if(productTreeMainId==null) {
	//					productTreeMainId="0";
	//				}
	//				if(reqInitiationId.equals("0") ) {					
	//					reqInitiationId = Long.toString(service.requirementInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId));
	//				}
	//				
	//				List<String>values=Arrays.asList(selectedValues.split(","));
	//				for(int i=0;i<values.size();i++) {
	//					PfmsInititationRequirement pir = new PfmsInititationRequirement();
	//					String []valuesArray = values.get(i).split("/");
	////					pir.setInitiationId(Long.parseLong(initiationId));
	////					pir.setProjectId(Long.parseLong(projectId));
	//					pir.setCategory("N");
	//					pir.setNeedType("N");
	//					pir.setReqMainId(Long.parseLong(valuesArray[0]));
	//					pir.setRequirementBrief(valuesArray[1]);
	//					pir.setRequirementId(valuesArray[2]);
	//					pir.setReqTypeId(0l);
	//					pir.setLinkedDocuments("");
	//					pir.setLinkedPara("");
	//					pir.setLinkedRequirements("");
	//					pir.setCreatedBy(UserId);
	//					pir.setParentId(0l);
	//					pir.setReqInitiationId(Long.parseLong(reqInitiationId));
	//					count =service.addPfmsInititationRequirement(pir);
	//				}
	//				
	//				
	//			}
	//			catch(Exception e){
	//				e.printStackTrace();
	//				logger.error(new Date() +" Inside RequirementAddList.htm", e);
	//			}
	//			Gson json = new Gson();
	//			return json.toJson(count);
	//		}

	@RequestMapping(value="RequirementAddList.htm",method = {RequestMethod.GET})
	public String RequirementAddList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside RequirementAddList.htm ");

		try {
			String initiationId = req.getParameter("initiationId");
			String projectId = req.getParameter("projectId");
			String productTreeMainId = req.getParameter("productTreeMainId");
			String reqInitiationId = req.getParameter("reqInitiationId");
			String selectedValues = req.getParameter("selectedValues");

			if(productTreeMainId==null) {
				productTreeMainId="0";
			}
			if(reqInitiationId.equals("0") ) {					
				reqInitiationId = Long.toString(service.requirementInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null, null));
			}
			long count =0l;
			List<String>values=Arrays.asList(selectedValues.split(","));
			for(int i=0;i<values.size();i++) {
				PfmsInititationRequirement pir = new PfmsInititationRequirement();
				String []valuesArray = values.get(i).split("/");
				//					pir.setInitiationId(Long.parseLong(initiationId));
				//					pir.setProjectId(Long.parseLong(projectId));
				pir.setCategory("N");
				pir.setNeedType("N");
				pir.setReqMainId(Long.parseLong(valuesArray[0]));
				pir.setRequirementBrief(valuesArray[1]);
				pir.setRequirementId(valuesArray[2]);
				pir.setReqTypeId(0l);
				pir.setLinkedDocuments("");
				pir.setLinkedPara("");
				pir.setLinkedRequirements("");
				pir.setCreatedBy(UserId);
				pir.setParentId(0l);
				pir.setReqInitiationId(Long.parseLong(reqInitiationId));
				count =service.addPfmsInititationRequirement(pir);
			}
			if(count>0) {
				redir.addAttribute("result","Requirement Details Added successfully");
			}else {
				redir.addAttribute("resultfail","Requirement Details Added successfully");
			}

			redir.addAttribute("initiationId", initiationId);
			//				redir.addAttribute("project", project);
			redir.addAttribute("projectId", projectId);
			//				redir.addAttribute("InitiationReqId", InitiationReqId);
			redir.addAttribute("reqInitiationId", reqInitiationId);

			return "redirect:/RequirementList.htm";  
		}
		catch(Exception e){
			e.printStackTrace();
			logger.error(new Date() +" Inside RequirementAddList.htm", e);
			return "static/Error";
		}

	}


	@RequestMapping(value ="RequirementEdit.htm",method = {RequestMethod.POST,RequestMethod.GET})
	public String RequirementEdit( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception{

		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RequirementEdit.htm "+UserId);
		try {
			String projectId=req.getParameter("projectId");
			String initiationid = req.getParameter("initiationid");
			String project = req.getParameter("project");
			String InitiationReqId = req.getParameter("InitiationReqId");
			String reqInitiationId = req.getParameter("reqInitiationId");


			String description= req.getParameter("description");
			String priority = req.getParameter("priority");
			String needtype  = req.getParameter("needtype");

			PfmsInititationRequirement pir = new PfmsInititationRequirement();
			pir.setRequirementDesc(description);
			pir.setNeedType(needtype);
			pir.setPriority(priority);
			pir.setModifiedBy(UserId);
			pir.setInitiationReqId(Long.parseLong(InitiationReqId));
			pir.setModifiedDate(sdf1.format(new Date()));

			long count =0;
			count = service.RequirementUpdate(pir);

			if(count>0) {
				redir.addAttribute("result","Requirement Details Added successfully");
			}else {
				redir.addAttribute("resultfail","Requirement Details Added successfully");
			}

			redir.addAttribute("initiationId", initiationid);
			redir.addAttribute("project", project);
			redir.addAttribute("projectId", projectId);
			redir.addAttribute("InitiationReqId", InitiationReqId);
			redir.addAttribute("reqInitiationId", reqInitiationId);

		}
		catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside RequirementEdit.htm "+UserId,e);
		}
		return "redirect:/RequirementList.htm";
	}

	@RequestMapping(value ="RequirementMainJsonValue.htm",method = {RequestMethod.POST,RequestMethod.GET})
	public @ResponseBody String RequirementMainJsonValue(@RequestParam("ReqMainId")String ReqMainId ) throws Exception {
		logger.info(new Date() +"Inside RequirementMainJsonValue.htm ");
		List<Object[]>ReqMainList= null;
		try {

			ReqMainList = service.getReqMainList(ReqMainId);

			if(ReqMainList.size()>1) {
				ReqMainList.remove(0);
			}
		}
		catch(Exception e){
			e.printStackTrace();
			logger.error(new Date() +" Inside RequirementMainJsonValue.htm", e);
		}
		Gson json = new Gson();
		return json.toJson(ReqMainList);
	}

	@RequestMapping(value ="RequirementSubAdd.htm",method = {RequestMethod.POST,RequestMethod.GET})
	public String RequirementSubAdd( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception{

		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside RequirementSubAdd.htm "+UserId);
		try {
			String projectId=req.getParameter("projectId");
			String initiationId = req.getParameter("initiationId");
			String project = req.getParameter("project");
			String InitiationReqId = req.getParameter("InitiationReqId");
			String productTreeMainId = req.getParameter("productTreeMainId");
			String reqInitiationId = req.getParameter("reqInitiationId");

			String description= req.getParameter("description");
			String priority = req.getParameter("priority");
			String needtype  = req.getParameter("needtype");

			String reqType = req.getParameter("reqType");
			String[]reqTypes=reqType.split("/");

			String ReqMainId=reqTypes[0];
			List<Object[]>reqTypeList=service.getreqTypeList(ReqMainId,InitiationReqId);
			int length=0;

			if(reqTypeList!=null && reqTypeList.size()>0) {
				length=reqTypeList.size();
			}

			String Demonstration = null;

			if(req.getParameterValues("Demonstration")!=null) {
				Demonstration = Arrays.asList(req.getParameterValues("Demonstration")).toString().replace("[","").replace("]", "");
			}


			String TestPlan = null;
			if(req.getParameterValues("TestPlan")!=null) {
				TestPlan = Arrays.asList(req.getParameterValues("TestPlan")).toString().replace("[","").replace("]", "");
			}


			String Analysis = null;
			if(req.getParameterValues("Analysis")!=null) {
				Analysis = Arrays.asList(req.getParameterValues("Analysis")).toString().replace("[","").replace("]", "");
			}




			String Inspection = null;
			if(req.getParameterValues("Inspection")!=null) {
				Inspection = Arrays.asList(req.getParameterValues("Inspection")).toString().replace("[","").replace("]", "");
			}


			String specialMethods = null;

			if(req.getParameterValues("specialMethods")!=null) {
				specialMethods = Arrays.asList(req.getParameterValues("specialMethods")).toString().replace("[","").replace("]", "");
			}

			String LinkedPara= null;

			if(req.getParameterValues("LinkedPara")!=null) {
				LinkedPara=Arrays.asList(req.getParameterValues("LinkedPara")).toString().replace("[","").replace("]", "");
			}

			System.out.println("LinkedPara  "+req.getParameterValues("LinkedPara"));





			String requirementId="";
			if (length < 9) {
				requirementId = reqTypes[1]+ ("_000" + ( (length+1) * 10));
			} else if (length < 99) {
				requirementId = reqTypes[1]+ ("_00" + ( (length+1) * 10));
			} else {
				requirementId = reqTypes[1]+ ("_0" + ( (length+1) * 10));
			}

			if(productTreeMainId==null) {
				productTreeMainId="0";
			}

			if(reqInitiationId.equals("0") ) {					
				reqInitiationId = Long.toString(service.requirementInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null, null));
			}

			PfmsInititationRequirement pir = new PfmsInititationRequirement();
			pir.setRequirementDesc(description);
			pir.setNeedType(needtype);
			pir.setPriority(priority);
			pir.setRequirementBrief(reqTypes[2]);
			pir.setCreatedBy(UserId);
			pir.setRequirementId(requirementId);
			//					pir.setInitiationId(Long.parseLong(initiationid));
			//					pir.setProjectId(Long.parseLong(projectId));
			pir.setReqMainId(Long.parseLong(ReqMainId));
			pir.setParentId(Long.parseLong(InitiationReqId));
			pir.setDemonstration(Demonstration);
			pir.setTest(TestPlan);
			pir.setAnalysis(Analysis);
			pir.setInspection(Inspection);
			pir.setSpecialMethods(specialMethods);
			pir.setConstraints(req.getParameter("Constraints"));
			pir.setRemarks(req.getParameter("remarks"));
			pir.setLinkedPara(LinkedPara);
			pir.setCriticality(req.getParameter("criticality"));
			pir.setReqInitiationId(Long.parseLong(reqInitiationId));
			long count =0;
			count=service.addPfmsInititationRequirement(pir);

			if(count>0) {
				redir.addAttribute("result",reqTypes[2]+" Added successfully");
			}else {
				redir.addAttribute("resultfail",reqTypes[2]+" Add unsuccessful");
			}

			redir.addAttribute("initiationId", initiationId);
			redir.addAttribute("project", project);
			redir.addAttribute("projectId", projectId);
			redir.addAttribute("productTreeMainId", productTreeMainId);
			redir.addAttribute("reqInitiationId", reqInitiationId);
			redir.addAttribute("InitiationReqId", InitiationReqId);
			redir.addAttribute("subId",count+"");

		}
		catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside RequirementEdit.htm "+UserId,e);
		}
		return "redirect:/RequirementList.htm";
	}

	@RequestMapping(value ="RequirementUpdate.htm",method = {RequestMethod.POST,RequestMethod.GET})
	public String RequirementUpdate( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception{

		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RequirementUpdate.htm "+UserId);
		try {
			String projectId=req.getParameter("projectId");
			String initiationid = req.getParameter("initiationId");
			String project = req.getParameter("project");
			String InitiationReqId = req.getParameter("InitiationReqId");
			String MainInitiationReqId = req.getParameter("MainInitiationReqId");
			String description= req.getParameter("description");
			String priority = req.getParameter("priority");
			String needtype  = req.getParameter("needtype");
			String reqInitiationId  = req.getParameter("reqInitiationId");

			String Demonstration = null;

			if(req.getParameterValues("Demonstration")!=null) {
				Demonstration = Arrays.asList(req.getParameterValues("Demonstration")).toString().replace("[","").replace("]", "");
			}

			String TestPlan = null;
			if(req.getParameterValues("TestPlan")!=null) {
				TestPlan = Arrays.asList(req.getParameterValues("TestPlan")).toString().replace("[","").replace("]", "");
			}

			String Analysis = null;
			if(req.getParameterValues("Analysis")!=null) {
				Analysis = Arrays.asList(req.getParameterValues("Analysis")).toString().replace("[","").replace("]", "");
			}

			String Inspection = null;
			if(req.getParameterValues("Inspection")!=null) {
				Inspection = Arrays.asList(req.getParameterValues("Inspection")).toString().replace("[","").replace("]", "");
			}

			String specialMethods = null;

			if(req.getParameterValues("specialMethods")!=null) {
				specialMethods = Arrays.asList(req.getParameterValues("specialMethods")).toString().replace("[","").replace("]", "");
			}

			String LinkedPara= null;

			if(req.getParameterValues("LinkedPara")!=null) {
				LinkedPara=Arrays.asList(req.getParameterValues("LinkedPara")).toString().replace("[","").replace("]", "");
			}

			System.out.println("LinkedPara  "+req.getParameterValues("LinkedPara"));

			PfmsInititationRequirement pir = service.getPfmsInititationRequirementById(InitiationReqId);
			pir.setRequirementDesc(description);
			pir.setNeedType(needtype);
			pir.setPriority(priority);
			pir.setModifiedBy(UserId);
			pir.setDemonstration(Demonstration);
			pir.setTest(TestPlan);
			pir.setAnalysis(Analysis);
			pir.setInspection(Inspection);
			pir.setSpecialMethods(specialMethods);
			pir.setConstraints(req.getParameter("Constraints"));
			pir.setRemarks(req.getParameter("remarks"));
			pir.setLinkedPara(LinkedPara);
			pir.setCriticality(req.getParameter("criticality"));
			pir.setReqInitiationId(Long.parseLong(reqInitiationId));
			long count =0;
			count=service.addOrUpdatePfmsInititationRequirement(pir);

			if(count>0) {
				redir.addAttribute("result","Requirements Updated successfully");
			}else {
				redir.addAttribute("resultfail","Requirements Updated  unsuccessful");
			}

			redir.addAttribute("initiationId", initiationid);
			redir.addAttribute("project", project);
			redir.addAttribute("projectId", projectId);
			redir.addAttribute("InitiationReqId",MainInitiationReqId );
			redir.addAttribute("subId",InitiationReqId);
			redir.addAttribute("reqInitiationId",reqInitiationId);

		}
		catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside RequirementUpdate.htm "+UserId,e);
		}
		return "redirect:/RequirementList.htm";
	}

	//	   @RequestMapping(value ="AddDocs.htm",method = {RequestMethod.POST,RequestMethod.GET})
	//			public @ResponseBody String AddDocs(RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses) throws Exception {
	//				logger.info(new Date() +"Inside AddDocs.htm ");
	//				List<Object[]>ReqMainList= null;
	//				long count=0;
	//				try {
	//				
	//					System.out.println("checkedValues"+req.getParameter("checkedValues"));
	//					String chkValue=req.getParameter("checkedValues");
	//					String []values=chkValue.split(",");
	//					
	//					String projectId = req.getParameter("projectId");
	//					String initiationId= req.getParameter("initiationid");
	//					
	//					if(projectId==null)projectId="0";
	//					if(initiationId==null)initiationId="0";
	//					
	//					
	//					
	//					List<ReqDoc>list= new ArrayList<>();
	//					
	//					for(int i=0;i<values.length;i++) {
	//						ReqDoc rc= new ReqDoc();
	//						
	//						rc.setDocId(Long.parseLong(values[i]));
	//						rc.setInitiationId(Long.parseLong(initiationId));
	//						rc.setProjectId(Long.parseLong(projectId));
	//						rc.setIsActive(1);
	//						list.add(rc);
	//					}
	//					
	//					count = service.addDocs(list);
	//					
	//					
	//				}
	//				catch(Exception e){
	//					e.printStackTrace();
	//					logger.error(new Date() +" Inside", e);
	//				}
	//				Gson json = new Gson();
	//				return json.toJson(count);
	//			}

	@RequestMapping(value ="AddRequirementDocs.htm",method = {RequestMethod.POST,RequestMethod.GET})
	public String addRequirementDocs(RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses) throws Exception {
		logger.info(new Date() +"Inside AddRequirementDocs.htm ");
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String ) ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		long count=0;
		try {

			System.out.println("checkedValues"+req.getParameter("checkedValues"));
			String chkValue=req.getParameter("checkedValues");
			String []values=chkValue.split(",");

			String projectId = req.getParameter("projectId");
			String initiationId= req.getParameter("initiationid");
			String productTreeMainId= req.getParameter("productTreeMainId");
			String reqInitiationId= req.getParameter("reqInitiationId");

			if(projectId==null)projectId="0";
			if(initiationId==null)initiationId="0";
			if(productTreeMainId==null)productTreeMainId="0";

			if(reqInitiationId.equals("0") ) {					
				reqInitiationId = Long.toString(service.requirementInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null, null));
			}

			List<ReqDoc>list= new ArrayList<>();

			for(int i=0;i<values.length;i++) {
				ReqDoc rc= new ReqDoc();

				rc.setDocId(Long.parseLong(values[i]));
				//				rc.setInitiationId(Long.parseLong(initiationId));
				//				rc.setProjectId(Long.parseLong(projectId));
				rc.setIsActive(1);
				rc.setReqInitiationId(Long.parseLong(reqInitiationId));
				list.add(rc);
			}

			count = service.addDocs(list);

			if(count>0) {
				redir.addAttribute("result","Applicable Dcouments Linked successfully");
			}else {
				redir.addAttribute("resultfail","Applicable Dcouments Link unsuccessful");
			}

			redir.addAttribute("initiationId", initiationId);
			redir.addAttribute("projectId", projectId);
			redir.addAttribute("reqInitiationId",reqInitiationId);
			if(!initiationId.equals("0")) {
				return "redirect:/ProjectOverAllRequirement.htm";
			}else {
				return "redirect:/ProjectRequirementDetails.htm";
			}

		}
		catch(Exception e){
			e.printStackTrace();
			logger.error(new Date() +" Inside", e);
			return "static/Error";
		}
	}

	@RequestMapping(value="SQRDownload.htm",method=RequestMethod.GET)
	public void sqrDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception  {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() + "Inside SQRDownload.htm " + UserId);

		try {

			String reqInitiationId =req.getParameter("reqInitiationId");

			Object[] sqrfile=projectservice.SqrFiles(reqInitiationId);

			File my_file = new File(uploadpath+ File.separator + File.separator +sqrfile[11]+File.separator+sqrfile[12]);
			if (my_file.exists()) {
				res.setContentType("application/octet-stream");
				res.setHeader("Content-Disposition", "attachment; filename=\"" + sqrfile[12] + "\"");

				FileInputStream fis = new FileInputStream(my_file);
				ServletOutputStream os = res.getOutputStream();

				byte[] buffer = new byte[4096];
				int bytesRead = -1;
				while ((bytesRead = fis.read(buffer)) != -1) {
					os.write(buffer, 0, bytesRead);
				}

				fis.close();
				os.close();
			} else {
				// Handle file not found case
				res.setStatus(HttpServletResponse.SC_NOT_FOUND);
			} }catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" SQRDownload.htm "+req.getUserPrincipal().getName(), e);
			}
	}

	@RequestMapping(value="ProjectRequirementTransStatus.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String projectRequirementTransStatus(HttpServletRequest req, HttpSession ses) throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date()+"Inside ProjectRequirementTransStatus.htm"+UserId);
		try {
			String reqInitiationId = req.getParameter("reqInitiationId");
			String docType = req.getParameter("docType");
			if(reqInitiationId!=null) {
				req.setAttribute("transactionList", service.projectDocTransList(reqInitiationId, docType));
				req.setAttribute("docInitiationId", reqInitiationId);
				req.setAttribute("docType", docType);
			}
			return "requirements/ProjectDocTransStatus";
		}catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside ProjectRequirementTransStatus.htm "+UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="ProjectDocTransactionDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void projectDocTransactionDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectDocTransactionDownload.htm "+UserId);		
		try {
			String docInitiationId = req.getParameter("docInitiationId");
			String docType = req.getParameter("docType");

			if(docInitiationId!=null) {
				Object[] projectDetails = null;
				long initiationId = 0L;
				long projectId = 0L;

				if(docType!=null && docType.equalsIgnoreCase("R")) {
					RequirementInitiation reqini = service.getRequirementInitiationById(docInitiationId);
					initiationId = reqini.getInitiationId();
					projectId = reqini.getProjectId();
				}else if(docType!=null && docType.equalsIgnoreCase("S")) {

				}else if(docType!=null && docType.equalsIgnoreCase("T")) {
					TestPlanInitiation testplan = service.getTestPlanInitiationById(docInitiationId);
					initiationId = testplan.getInitiationId();
					projectId = testplan.getProjectId();
				}

				projectDetails = projectservice.getProjectDetails(labcode, initiationId!=0?initiationId+"":projectId+"", initiationId!=0?"P":"E");
				req.setAttribute("projectDetails", projectDetails);
				req.setAttribute("transactionList", service.projectDocTransList(docInitiationId, "R"));
			}

			String filename="Doc_Transaction";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/ProjectDocTransactionDownload.jsp").forward(req, customResponse);
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
			logger.error(new Date() +" Inside ProjectDocTransactionDownload.htm "+UserId, e);
			e.printStackTrace();
		}		
	}

	@RequestMapping(value="ProjectRequirementApprovalSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String projectRequirementApprovalSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir, HttpServletResponse resp) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+"Inside ProjectRequirementApprovalSubmit.htm"+UserId);
		try {
			String reqInitiationId=req.getParameter("reqInitiationId");
			String action = req.getParameter("Action");
			String remarks = req.getParameter("remarks");

			RequirementInitiation reqInitiation = service.getRequirementInitiationById(reqInitiationId);
			String reqStatusCode = reqInitiation.getReqStatusCode();

			List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");

			long result = service.projectRequirementApprovalForward(reqInitiationId,action,remarks,EmpId,labcode,UserId);

			if(result!=0 && reqInitiation.getReqStatusCode().equalsIgnoreCase("RFA") && reqInitiation.getReqStatusCodeNext().equalsIgnoreCase("RAM")) {
				// Pdf Freeze
				service.requirementPdfFreeze(req, resp, reqInitiationId, labcode);
			}

			if(action.equalsIgnoreCase("A")) {
				if(reqforwardstatus.contains(reqStatusCode)) {
					if(result!=0) {
						redir.addAttribute("result","Requirment forwarded Successfully");
					}else {
						redir.addAttribute("resultfail","Requirment forward Unsuccessful");
					}
					redir.addAttribute("projectType", req.getParameter("projectType"));
					redir.addAttribute("projectId", req.getParameter("projectId"));
					redir.addAttribute("initiationId", req.getParameter("initiationId"));
					redir.addAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
					return "redirect:/Requirements.htm";
				}else if(reqStatusCode.equalsIgnoreCase("RFW")) {
					if(result!=0) {
						redir.addAttribute("result","Requirment Recommended Successfully");
					}else {
						redir.addAttribute("resultfail","Requirment Recommend Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				}else if(reqStatusCode.equalsIgnoreCase("RFR")) {
					if(result!=0) {
						redir.addAttribute("result","Requirment Approved Successfully");
					}else {
						redir.addAttribute("resultfail","Requirment Approve Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				}
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if(result!=0) {
					redir.addAttribute("result",action.equalsIgnoreCase("R")?"Requirment Returned Successfully":"Requirment Disapproved Successfully");
				}else {
					redir.addAttribute("resultfail",action.equalsIgnoreCase("R")?"Requirment Return Unsuccessful":"Requirment Disapprove Unsuccessful");
				}
			}
			return "redirect:/DocumentApprovals.htm";

		}catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside ProjectRequirementApprovalSubmit.htm "+UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="DocumentApprovals.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String documentApprovals(HttpServletRequest req,HttpSession ses) throws Exception{
		String Username = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside DocumentApprovals.htm "+Username);
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

			req.setAttribute("reqPendingList", service.projectRequirementPendingList(EmpId, labcode));
			req.setAttribute("reqApprovedList", service.projectRequirementApprovedList(EmpId,fromdate,todate));
			req.setAttribute("testPlanPendingList", service.projectTestPlanPendingList(EmpId, labcode));
			req.setAttribute("testPlanApprovedList", service.projectTestPlanApprovedList(EmpId,fromdate,todate));

			return "requirements/DocumentApprovals";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside DocumentApprovals.htm "+Username, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="TestDetails.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String TestDetails(HttpServletRequest req,HttpSession ses, RedirectAttributes redir) {
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside TestDetails "+UserId);
		try {
			String initiationId  = req.getParameter("initiationId");
			String projectId =req.getParameter("projectId");
			String productTreeMainId =req.getParameter("productTreeMainId");
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");

			req.setAttribute("TestTypeList", service.TestTypeList());
			req.setAttribute("StagesApplicable", service.StagesApplicable());
			req.setAttribute("VerificationMethodList", service.getVerificationMethodList());
			List<Object[]> TestDetailsList=service.TestDetailsList(testPlanInitiationId);
			if(TestDetailsList!=null && TestDetailsList.size()>0)
			{
				req.setAttribute("TestReqId", TestDetailsList.get(0)[0].toString());
			}
			
			String specsInitiationId = service.getFirstVersionSpecsInitiationId(initiationId, projectId, productTreeMainId)+"";
			
			req.setAttribute("specificationList", service.getSpecsList(specsInitiationId));
			req.setAttribute("TestDetailsList", service.TestDetailsList(testPlanInitiationId) );
			req.setAttribute("initiationId", initiationId);
			req.setAttribute("projectId", projectId);
			req.setAttribute("productTreeMainId", productTreeMainId);
			req.setAttribute("testPlanInitiationId", testPlanInitiationId);
			return "requirements/TestDetails";
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "static/Error";
	}

	@RequestMapping(value = "TestDetailsAddSubmit.htm", method=RequestMethod.POST)
	public String TestDetailsAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir  ) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside TestDetailsAddSubmit.htm "+UserId);
		try {
			String initiationId  = req.getParameter("initiationId");
			String projectId =req.getParameter("projectId");
			String productTreeMainId =req.getParameter("productTreeMainId");
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");

			if(initiationId==null) initiationId="0";
			if(projectId==null) projectId="0";	
			if(productTreeMainId==null) productTreeMainId="0";

			if(testPlanInitiationId.equals("0") ) {					
				testPlanInitiationId = Long.toString(service.testPlanInitiationAddHandling(initiationId,projectId,productTreeMainId,EmpId,UserId, null,null));
			}

			String action = req.getParameter("action");
			String testId = req.getParameter("testId");

			TestDetails Td = action!=null && action.equalsIgnoreCase("Edit")? service.getTestPlanDetailsById(testId):new TestDetails();

			//			Td.setInitiationId(Long.parseLong(initiationId));
			//			Td.setProjectId(Long.parseLong(projectId));
			//Td.setProjectId((long)0);

			Td.setTestPlanInitiationId(Long.parseLong(testPlanInitiationId));
			Td.setName(req.getParameter("name"));

			String StageApplicable="";
			if(req.getParameterValues("StageApplicable")!=null) 
			{
				String[] linkedreq= req.getParameterValues("StageApplicable");
				for(int i=0;i<linkedreq.length;i++) {
					StageApplicable=StageApplicable+linkedreq[i];
					if(i!=linkedreq.length-1) {
						StageApplicable=StageApplicable+",";
					}
				}
			}

			String Methodology="";
			if(req.getParameterValues("Methodology")!=null) 
			{
				String[] linkedreq= req.getParameterValues("Methodology");
				for(int i=0;i<linkedreq.length;i++) {
					Methodology=Methodology+linkedreq[i];
					if(i!=linkedreq.length-1) {
						Methodology=Methodology+",";
					}
				}
			}

			String ToolsSetup="";
			if(req.getParameterValues("ToolsSetup")!=null) 
			{
				String[] linkedreq= req.getParameterValues("ToolsSetup");
				for(int i=0;i<linkedreq.length;i++) {
					ToolsSetup=ToolsSetup+linkedreq[i];
					if(i!=linkedreq.length-1) {
						ToolsSetup=ToolsSetup+",";
					}
				}
			}

			Td.setObjective(req.getParameter("Objective"));
			Td.setDescription(req.getParameter("Description"));
			Td.setPreConditions(req.getParameter("PreConditions"));
			Td.setPostConditions(req.getParameter("PostConditions"));
			Td.setConstraints(req.getParameter("Constraints"));
			Td.setSafetyRequirements(req.getParameter("SafetyReq"));
			Td.setMethodology(Methodology);
			Td.setToolsSetup(ToolsSetup);
			Td.setPersonnelResources(req.getParameter("PersonnelResources"));
			Td.setEstimatedTimeIteration(req.getParameter("EstimatedTimeIteration"));
			Td.setIterations(req.getParameter("Iterations"));
			Td.setSchedule(req.getParameter("Schedule"));
			Td.setPass_Fail_Criteria(req.getParameter("PassFailCriteria"));
			Td.setRemarks(req.getParameter("remarks"));
			Td.setSpecificationId(req.getParameter("SpecId"));
			Td.setStageApplicable(StageApplicable);

			if(action!=null && action.equalsIgnoreCase("Edit")) {
				Td.setModifiedBy(UserId);
				Td.setModifiedDate(sdf1.format(new Date()));
			}else {

				String  Testtype="TEST";
				Long a=	(Long)service.numberOfTestTypeId(testPlanInitiationId);
				String TestDetailsId="";
				if(a<90L) {
					System.out.println("10"+ (a+10));
					TestDetailsId=Testtype+("000"+(a+10));
				}else if(a<990L) {
					TestDetailsId=Testtype+("00"+(a+10));
				}else {
					TestDetailsId=Testtype+("0"+(a+10));
				}
				Td.setTestDetailsId(TestDetailsId);
				Td.setTestCount((a.intValue()+10));

				Td.setCreatedBy(UserId);
				Td.setCreatedDate(sdf1.format(new Date()));
			}
			long count=service.TestDetailsAdd(Td);

			if (count > 0) {
				redir.addAttribute("result", "Test  Details "+action+"ed Successfully");
			} else {
				redir.addAttribute("resultfail", "Test Details "+action+" Unsuccessful");
			}
			redir.addAttribute("initiationId",initiationId);
			redir.addAttribute("projectId",projectId);
			redir.addAttribute("productTreeMainId",productTreeMainId);
			redir.addAttribute("testPlanInitiationId",testPlanInitiationId);
			return "redirect:/TestDetails.htm";
		}

		catch(Exception e){
			e.printStackTrace();
			logger.error(new Date() +"Inside TestDetailsAddSubmit.htm  "+UserId, e);
			return "static/Error";
		}

	}

	@RequestMapping(value="TestDetailsJson.htm",method=RequestMethod.GET)
	public @ResponseBody String TestDetailseJson(HttpSession ses, HttpServletRequest req) throws Exception {
		Gson json = new Gson();
		Object[] TestDetails=null;
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside TestDetailsJson.htm"+UserId);
		try {
			String testId=req.getParameter("testId");
			if(testId!=null && testId!="") {
				List<Object[]> TestDetailsList=service.TestType(testId);
				if(TestDetailsList!=null && TestDetailsList.size()>0)
				{
					TestDetails=TestDetailsList.get(0);
				}
			}

		}
		catch(Exception e){
			logger.error(new Date()+"Inside TestDetailsJson.htm"+ UserId, e);
			e.printStackTrace();
			return null;
		}
		return json.toJson(TestDetails);
	}

	//	@RequestMapping(value = "TestDetailsEditSubmit.htm", method = RequestMethod.POST)
	//	public String ProjectRequirementEditSubmit(HttpServletRequest req, RedirectAttributes redir, HttpSession ses ) {
	//		String UserId = (String) ses.getAttribute("Username");
	//		logger.info(new Date() +"Inside TestDetailsEditSubmit.htm "+UserId);
	//		String option=req.getParameter("action");
	//		try {
	//			if(option.equalsIgnoreCase("SUBMIT")) 
	//			{
	//				String TestId=req.getParameter("edittestId");
	//				String initiationId=req.getParameter("initiationId");
	//				String projectId=req.getParameter("projectId");
	//				String ProjectType=req.getParameter("ProjectType");
	//				String StageApplicable="";
	//				if(req.getParameterValues("StageApplicable")!=null) {
	//					String []linkedreq= req.getParameterValues("StageApplicable");
	//					for(int i=0;i<linkedreq.length;i++) {
	//						StageApplicable=StageApplicable+linkedreq[i];
	//						if(i!=linkedreq.length-1) {
	//							StageApplicable=StageApplicable+",";
	//						}
	//					}
	//				}
	//				String Methodology="";
	//				if(req.getParameterValues("Methodology")!=null) {
	//					String []linkedreq= req.getParameterValues("Methodology");
	//					for(int i=0;i<linkedreq.length;i++) {
	//						Methodology=Methodology+linkedreq[i];
	//						if(i!=linkedreq.length-1) {
	//							Methodology=Methodology+",";
	//						}
	//					}
	//				}
	//				String ToolsSetup="";
	//				if(req.getParameterValues("ToolsSetup")!=null) {
	//					String []linkedreq= req.getParameterValues("ToolsSetup");
	//					for(int i=0;i<linkedreq.length;i++) {
	//						ToolsSetup=ToolsSetup+linkedreq[i];
	//						if(i!=linkedreq.length-1) {
	//							ToolsSetup=ToolsSetup+",";
	//						}
	//					}
	//				}
	//				TestDetails Tdedit= new TestDetails();
	//				Tdedit.setName(req.getParameter("TestName"));
	//				Tdedit.setObjective(req.getParameter("Objective"));
	//				Tdedit.setDescription(req.getParameter("Description"));
	//				Tdedit.setPreConditions(req.getParameter("PreConditions"));
	//				Tdedit.setPostConditions(req.getParameter("PostConditions"));
	//				Tdedit.setConstraints(req.getParameter("Constraints"));
	//				Tdedit.setSafetyRequirements(req.getParameter("SafetyReq"));
	//				Tdedit.setMethodology(Methodology);
	//				Tdedit.setToolsSetup(ToolsSetup);
	//				Tdedit.setPersonnelResources(req.getParameter("PersonnelResources"));
	//				Tdedit.setEstimatedTimeIteration(req.getParameter("EstimatedTimeIteration"));
	//				Tdedit.setIterations(req.getParameter("Iterations"));
	//				Tdedit.setSchedule(req.getParameter("Schedule"));
	//				Tdedit.setPass_Fail_Criteria(req.getParameter("PassFailCriteria"));
	//				Tdedit.setStageApplicable(StageApplicable);
	//				Tdedit.setRemarks(req.getParameter("remarks"));
	//				long count=service.TestDetailasUpdate(Tdedit,UserId,TestId);
	//
	//				if (count > 0) {
	//					redir.addAttribute("ProjectType", ProjectType);
	//					redir.addAttribute("initiationId", initiationId);
	//					redir.addAttribute("projectId", projectId);
	//					redir.addAttribute("result", "Test  Details Edited Successfully");
	//					return "redirect:/TestDetails.htm";
	//				} else {
	//					redir.addAttribute("ProjectType", ProjectType);
	//					redir.addAttribute("initiationId", initiationId);
	//					redir.addAttribute("projectId", projectId);
	//					redir.addAttribute("resultfail", "Test Details Edited Unsuccessful");
	//					return "redirect:/TestDetails.htm";
	//				}
	//			}
	//		}
	//		catch(Exception e) {
	//			e.printStackTrace();
	//			logger.error(new Date() +"Inside TestDetailsEditSubmit.htm  "+UserId, e);
	//			return "static/Error";
	//		}
	//		return "redirect:/ProjectTestPlanDetails.htm";
	//	}

	// adding requirement type
	@RequestMapping(value="InsertTestType.htm",method=RequestMethod.GET)
	public @ResponseBody String insertReqType(HttpSession ses, HttpServletRequest req) throws Exception {
		Gson json=new Gson();
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date()+ "Inside InsertTestType.htm"+UserId);
		long count=-1;
		try {
			String TestTypes= req.getParameter("TestTypes");
			String TestTools= req.getParameter("TestTools");
			String TestSetupName=req.getParameter("TestSetupName");
			//			List<Object[]>TestSuiteList=service.TestTypeList();
			//			long result = TestSuiteList.stream()
			//					.filter(i -> i.length > 1 && i[1] != null && i[1].toString().equalsIgnoreCase(TestTypes))
			//					.count();
			//			if(result>0) {
			//				System.out.println("result@@@@@@@"+result);
			//				return json.toJson(count);
			//			}

			int result = service.getDuplicateCountofTestType(TestTypes);

			if(result>0) {
				return json.toJson(count);
			}

			TestTools pt= new TestTools();
			pt.setTestType(TestTypes);
			pt.setTestTools(TestTools);
			pt.setTestSetupName(TestSetupName);
			pt.setIsActive(1);
			count = service.insertTestType(pt);
		}
		catch(Exception e) {
			logger.error(new Date()+"Inside InsertTestType.htm"+UserId);
			e.printStackTrace();
		}
		return json.toJson(count);
	}

	//		
	/* Test Plan Pdf */
	@RequestMapping(value = "TestPlanDownlodPdf.htm" )
	public void TestPlanDocumentDownlodPdf(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String ) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside TestPlanDownlodPdf.htm "+UserId);
		try {
			Object[] DocTempAttributes =null;
			DocTempAttributes=projectservice.DocTempAttributes();
			req.setAttribute("DocTempAttributes", DocTempAttributes);
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");

			TestPlanInitiation ini = service.getTestPlanInitiationById(testPlanInitiationId);
			testPlanInitiationId = service.getFirstVersionTestPlanInitiationId(ini.getInitiationId()+"", ini.getProjectId()+"", ini.getProductTreeMainId()+"")+"";
			Object[] projectDetails = projectservice.getProjectDetails(LabCode, ini.getInitiationId()!=0?ini.getInitiationId()+"":ini.getProjectId()+"", ini.getInitiationId()!=0?"P":"E");
			req.setAttribute("projectShortName", projectDetails!=null?projectDetails[2]:"");

			String filename="TestPlan";
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			req.setAttribute("lablogo",  LogoUtil.getLabLogoAsBase64String(LabCode)); 
			req.setAttribute("LabImage",  LogoUtil.getLabImageAsBase64String(LabCode)); 
			req.setAttribute("LabList", projectservice.LabListDetails(LabCode));
			req.setAttribute("path",path);
			req.setAttribute("lablogo",  LogoUtil.getLabLogoAsBase64String(LabCode)); 
			req.setAttribute("LabImage",  LogoUtil.getLabImageAsBase64String(LabCode)); 
			req.setAttribute("LabList", projectservice.LabListDetails(LabCode));
			req.setAttribute("uploadpath", uploadpath);
			req.setAttribute("TestScopeIntro",service.TestScopeIntro(testPlanInitiationId));
			req.setAttribute("MemberList", service.DocMemberList(testPlanInitiationId, "0"));
			req.setAttribute("DocumentSummary", service.getTestandSpecsDocumentSummary(testPlanInitiationId, "0"));
			req.setAttribute("AbbreviationDetails",service.AbbreviationDetails(testPlanInitiationId, "0"));
			req.setAttribute("TestContent", service.GetTestContentList(testPlanInitiationId));
			req.setAttribute("AcceptanceTesting", service.GetAcceptanceTestingList(testPlanInitiationId));
			req.setAttribute("TestSuite", service.TestTypeList());
			req.setAttribute("TestDetailsList", service.TestDetailsList(testPlanInitiationId));
			req.setAttribute("StagesApplicable", service.StagesApplicable());
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/requirements/TestPlanPDFDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			ConverterProperties converterProperties = new ConverterProperties();
			FontProvider dfp = new DefaultFontProvider(true, true, true);
			converterProperties.setFontProvider(dfp);

			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"),converterProperties);
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
		}catch(Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside TestPalnDocumentPdfDownlod.htm "+UserId,e);
		}
	}

	@RequestMapping(value="ProjectTestPlanTransStatus.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String projectTestPlanTransStatus(HttpServletRequest req, HttpSession ses) throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date()+"Inside ProjectTestPlanTransStatus.htm"+UserId);
		try {
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");
			String docType = req.getParameter("docType");
			if(testPlanInitiationId!=null) {
				req.setAttribute("transactionList", service.projectDocTransList(testPlanInitiationId, docType));
				req.setAttribute("docInitiationId", testPlanInitiationId);
				req.setAttribute("docType", docType);
			}
			return "requirements/ProjectDocTransStatus";
		}catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside ProjectTestPlanTransStatus.htm "+UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="ProjectTestPlanApprovalSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String projectTestPlanApprovalSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir, HttpServletResponse resp) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+"Inside ProjectTestPlanApprovalSubmit.htm"+UserId);
		try {
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");
			String action = req.getParameter("Action");
			String remarks = req.getParameter("remarks");

			TestPlanInitiation testplan = service.getTestPlanInitiationById(testPlanInitiationId);
			String reqStatusCode = testplan.getReqStatusCode();

			List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");

			long result = service.projectTestPlanApprovalForward(testPlanInitiationId,action,remarks,EmpId,labcode,UserId);

			if(result!=0 && testplan.getReqStatusCode().equalsIgnoreCase("RFA") && testplan.getReqStatusCodeNext().equalsIgnoreCase("RAM")) {
				// Pdf Freeze
				service.testPlanPdfFreeze(req, resp, testPlanInitiationId, labcode);
			}

			if(action.equalsIgnoreCase("A")) {
				if(reqforwardstatus.contains(reqStatusCode)) {
					if(result!=0) {
						redir.addAttribute("result","Test Plan forwarded Successfully");
					}else {
						redir.addAttribute("resultfail","Test Plan forward Unsuccessful");
					}
					redir.addAttribute("projectType", req.getParameter("projectType"));
					redir.addAttribute("projectId", req.getParameter("projectId"));
					redir.addAttribute("initiationId", req.getParameter("initiationId"));
					redir.addAttribute("productTreeMainId", req.getParameter("productTreeMainId"));
					redir.addAttribute("testPlanInitiationId", testPlanInitiationId);
					return "redirect:/ProjectTestPlan.htm";
				}else if(reqStatusCode.equalsIgnoreCase("RFW")) {
					if(result!=0) {
						redir.addAttribute("result","Test Plan Recommended Successfully");
					}else {
						redir.addAttribute("resultfail","Test Plan Recommend Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				}else if(reqStatusCode.equalsIgnoreCase("RFR")) {
					if(result!=0) {
						redir.addAttribute("result","Test Plan Approved Successfully");
					}else {
						redir.addAttribute("resultfail","Test Plan Approve Unsuccessful");
					}
					return "redirect:/DocumentApprovals.htm";
				}
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")) {
				if(result!=0) {
					redir.addAttribute("result",action.equalsIgnoreCase("R")?"Test Plan Returned Successfully":"Test Plan Disapproved Successfully");
				}else {
					redir.addAttribute("resultfail",action.equalsIgnoreCase("R")?"Test Plan Return Unsuccessful":"Test Plan Disapprove Unsuccessful");
				}
			}
			return "redirect:/DocumentApprovals.htm";

		}catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside ProjectTestPlanApprovalSubmit.htm "+UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="ProjectTestPlanAmendSubmit.htm", method= {RequestMethod.POST, RequestMethod.GET})
	public String projectTestPlanAmendSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+"Inside ProjectTestPlanAmendSubmit.htm"+UserId);
		try {
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");
			String amendversion = req.getParameter("amendversion");
			String remarks = req.getParameter("remarks");

			TestPlanInitiation testplan = service.getTestPlanInitiationById(testPlanInitiationId);

			service.projectTestPlanApprovalForward(testPlanInitiationId, "A", remarks, EmpId, labcode, UserId);

			long result = service.testPlanInitiationAddHandling(testplan.getInitiationId()+"", testplan.getProjectId()+"", testplan.getProductTreeMainId()+"", EmpId, UserId, amendversion, remarks);

			if(result!=0) {
				redir.addAttribute("result","Test Plan Amended Successfully");
			}else {
				redir.addAttribute("resultfail","Test Plan Amend Unsuccessful");
			}
			redir.addAttribute("testPlanInitiationId", result);
			//			redir.addAttribute("projectType", testplan.getInitiationId()!=0?"I":"M");
			//			redir.addAttribute("initiationId", testplan.getInitiationId());
			//			redir.addAttribute("projectId", testplan.getProjectId());
			//			redir.addAttribute("productTreeMainId", testplan.getProductTreeMainId());

			return "redirect:/ProjectTestPlanDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside ProjectTestPlanAmendSubmit.htm "+UserId, e);
			return "static/Error";
		}
	}

	@RequestMapping(value="TestPlanDownlodPdfFreeze.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void testPlanDownlodPdfFreeze(HttpServletRequest req, HttpSession ses, HttpServletResponse res, HttpServletResponse resp) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside TestPlanDownlodPdfFreeze.htm "+UserId);		
		try {
			String testPlanInitiationId = req.getParameter("testPlanInitiationId");

			DocumentFreeze freeze = service.getDocumentFreezeByDocIdandDocType(testPlanInitiationId, "T");

			if(freeze!=null && freeze.getPdfFilePath()==null) {
				service.testPlanPdfFreeze(req, resp, testPlanInitiationId, labcode);
			}

			res.setContentType("application/pdf");
			res.setHeader("Content-disposition", "inline;filename= TestPlan.pdf");
			File f = new File(uploadpath + File.separator + freeze.getPdfFilePath());
			FileInputStream fis = new FileInputStream(f);
			DataOutputStream os = new DataOutputStream(res.getOutputStream());
			res.setHeader("Content-Length", String.valueOf(f.length()));
			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = fis.read(buffer)) >= 0) {
				os.write(buffer, 0, len);
			}
			os.close();
			fis.close();	

		}
		catch(Exception e) {	    		
			logger.error(new Date() +" Inside TestPlanDownlodPdfFreeze.htm "+UserId, e);
			e.printStackTrace();
		}		
	}

	@RequestMapping(value="RequirementDocumentDownlodPdfFreeze.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void requirementDocumentDownlodPdfFreeze(HttpServletRequest req, HttpSession ses, HttpServletResponse res, HttpServletResponse resp) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RequirementDocumentDownlodPdfFreeze.htm "+UserId);		
		try {
			String reqInitiationId = req.getParameter("reqInitiationId");

			DocumentFreeze freeze = service.getDocumentFreezeByDocIdandDocType(reqInitiationId, "T");

			if(freeze!=null && freeze.getPdfFilePath()==null) {
				service.requirementPdfFreeze(req, resp, reqInitiationId, labcode);
			}

			res.setContentType("application/pdf");
			res.setHeader("Content-disposition", "inline;filename= Requirement.pdf");
			File f = new File(uploadpath + File.separator + freeze.getPdfFilePath());
			FileInputStream fis = new FileInputStream(f);
			DataOutputStream os = new DataOutputStream(res.getOutputStream());
			res.setHeader("Content-Length", String.valueOf(f.length()));
			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = fis.read(buffer)) >= 0) {
				os.write(buffer, 0, len);
			}
			os.close();
			fis.close();	

		}
		catch(Exception e) {	    		
			logger.error(new Date() +" Inside RequirementDocumentDownlodPdfFreeze.htm "+UserId, e);
			e.printStackTrace();
		}		
	}

	@RequestMapping(value="ProjectRequirementAmendSubmit.htm", method= {RequestMethod.POST, RequestMethod.GET})
	public String projectRequirementAmendSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date()+"Inside ProjectRequirementAmendSubmit.htm"+UserId);
		try {
			String reqInitiationId = req.getParameter("reqInitiationId");
			String amendversion = req.getParameter("amendversion");
			String remarks = req.getParameter("remarks");

			RequirementInitiation testplan = service.getRequirementInitiationById(reqInitiationId);

			service.projectRequirementApprovalForward(reqInitiationId, "A", remarks, EmpId, labcode, UserId);

			long result = service.requirementInitiationAddHandling(testplan.getInitiationId()+"", testplan.getProjectId()+"", testplan.getProductTreeMainId()+"", EmpId, UserId, amendversion, remarks);

			if(result!=0) {
				redir.addAttribute("result","Requirement Amended Successfully");
			}else {
				redir.addAttribute("resultfail","Requirement Amend Unsuccessful");
			}
			redir.addAttribute("reqInitiationId", result);
			//			redir.addAttribute("projectType", testplan.getInitiationId()!=0?"I":"M");
			//			redir.addAttribute("initiationId", testplan.getInitiationId());
			//			redir.addAttribute("projectId", testplan.getProjectId());
			//			redir.addAttribute("productTreeMainId", testplan.getProductTreeMainId());

			return "redirect:/ProjectRequirementDetails.htm";
		}catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside ProjectRequirementAmendSubmit.htm "+UserId, e);
			return "static/Error";
		}
	}
}
