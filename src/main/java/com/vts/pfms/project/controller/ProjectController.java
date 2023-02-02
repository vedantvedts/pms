package com.vts.pfms.project.controller;

import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.print.model.ProjectTechnicalWorkData;
import com.vts.pfms.project.dto.PfmsInitiationAttachmentDto;
import com.vts.pfms.project.dto.PfmsInitiationAttachmentFileDto;
import com.vts.pfms.project.dto.PfmsInitiationAuthorityDto;
import com.vts.pfms.project.dto.PfmsInitiationAuthorityFileDto;
import com.vts.pfms.project.dto.PfmsInitiationCostDto;
import com.vts.pfms.project.dto.PfmsInitiationDetailDto;
import com.vts.pfms.project.dto.PfmsInitiationDto;
import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;
import com.vts.pfms.project.dto.PfmsProjectDataDto;
import com.vts.pfms.project.dto.PfmsRiskDto;
import com.vts.pfms.project.dto.ProjectAssignDto;
import com.vts.pfms.project.dto.ProjectMasterAttachDto;
import com.vts.pfms.project.dto.ProjectScheduleDto;
import com.vts.pfms.project.model.PfmsInitiationAttachmentFile;
import com.vts.pfms.project.model.PfmsInitiationAuthorityFile;
import com.vts.pfms.project.model.PfmsInitiationChecklistData;
import com.vts.pfms.project.model.ProjectAssign;
import com.vts.pfms.project.model.ProjectMain;
import com.vts.pfms.project.model.ProjectMaster;
import com.vts.pfms.project.model.ProjectMasterRev;
import com.vts.pfms.project.service.ProjectService;

@Controller
public class ProjectController 
{

	@Autowired
	ProjectService service;
	
	@Value("${File_Size}")
	String file_size;
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	                                                                                        
	private static final Logger logger=LogManager.getLogger(ProjectController.class);
	
	FormatConverter fc=new FormatConverter();
	private SimpleDateFormat sdf2=fc.getRegularDateFormat();/*new SimpleDateFormat("dd-MM-yyyy");*/
	private SimpleDateFormat sdf1=fc.getSqlDateAndTimeFormat(); /* new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); */
	private SimpleDateFormat sdf3=fc.getSqlDateFormat();
	
	@RequestMapping(value = "ProjectIntiationList.htm")
	public String ProjectIntiationList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String ) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectIntiationList.htm "+UserId);
		
		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String LoginType=(String)ses.getAttribute("LoginType");
	
			req.setAttribute("ProjectIntiationList", service.ProjectIntiationList(EmpId,LoginType,LabCode));
			req.setAttribute("projectapprovalflowempdata", service.ProjectApprovalFlowEmpData(EmpId,LabCode));
			return "project/ProjectIntiationList";
                                                                   
		}
		catch (Exception e) {
			logger.error(new Date() +" Inside ProjectIntiationList.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		} 
		
	}

	@RequestMapping(value = "ProjectIntiationListSubmit.htm", method = RequestMethod.POST)
	public String ProjectIntiationListSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectIntiationListSubmit.htm "+UserId);		
		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
				String Option = req.getParameter("sub");
				String IntiationId = req.getParameter("btSelectItem");
				String Logintype= (String)ses.getAttribute("LoginType");
				String LabCode = (String)ses.getAttribute("labcode");
				System.out.println(IntiationId+"---------------");
				if (Option.equalsIgnoreCase("add")) {
					req.setAttribute("ProjectTypeList", service.ProjectTypeList());	
					req.setAttribute("PfmsCategoryList", service.PfmsCategoryList());
					req.setAttribute("PfmsDeliverableList", service.PfmsDeliverableList());	
					req.setAttribute("InitiatedProjectList", service.InitiatedProjectList());
					req.setAttribute("NodalLabList", service.NodalLabList());
					req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
				}		
				if (Option.equalsIgnoreCase("Details")) {
					
					req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
					req.setAttribute("ProjectProgressCount", service.ProjectProgressCount(IntiationId));
					req.setAttribute("ScheduleList", service.ProjectIntiationScheduleList(IntiationId));
					req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(IntiationId));
					req.setAttribute("IntiationAttachment", service.ProjectIntiationAttachment(IntiationId));
					req.setAttribute("AuthorityAttachment", service.AuthorityAttachment(IntiationId));
					req.setAttribute("reqTypeList", service.RequirementTypeList());
					req.setAttribute("RequirementList", service.RequirementList(IntiationId));
											
					Map<String, List<Object[]>> BudgetItemMapList = new LinkedHashMap<String, List<Object[]>>();
		
					List<Object[]> ItemList = service.ProjectIntiationItemList(IntiationId);
					List<Object[]> BudgetHead = service.BudgetHead();
		
					for (Object[] obj : BudgetHead) {
						List<Object[]> addlist = new ArrayList<Object[]>();
						for (Object[] obj1 : ItemList) {
							if (obj[1].toString().equalsIgnoreCase(obj1[2].toString())) {
								addlist.add(obj1);
		
							}
						}
						if (addlist.size() > 0) {
							BudgetItemMapList.put(obj[1].toString(), addlist);
						}
		
					}
					req.setAttribute("BudgetItemMapList", BudgetItemMapList);
	
					return "project/ProjectIntiationDetailes";
			}
	
			if (Option.equalsIgnoreCase("status")) 
			{
				req.setAttribute("ProjectStatusList", service.ProjectStatusList(EmpId,Logintype,LabCode));
				req.setAttribute("projectapprovalflowempdata", service.ProjectApprovalFlowEmpData(EmpId,LabCode));
				return "project/ProjectStatusList";
			}
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectIntiationListSubmit.htm "+UserId, e);
			
    		return "static/Error";
		}

		return "project/ProjectIntiationAdd";
	}

	
	@RequestMapping(value = "InitiatedProjectDetails.htm", method = RequestMethod.GET)
	public @ResponseBody String InitiatedProjectDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		
	 	List<Object[]> InitiatedProjectDetails=null;
	 	String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside InitiatedProjectDetails.htm "+UserId);		
		try {
			
			InitiatedProjectDetails = service.InitiatedProjectDetails(req.getParameter("ProjectId"));
		
		}
		catch (Exception e) {
			e.printStackTrace();
			 logger.error(new Date() +" Inside InitiatedProjectDetails.htm "+UserId, e);
		}
	
		Gson convertedgson = new Gson();
		
		return convertedgson.toJson(InitiatedProjectDetails);

	}
	
	
	
	
	@RequestMapping(value = "ProjectIntiationDetailesLanding.htm", method = RequestMethod.GET)
	public String ProjectIntiationDetailesLanding(Model model, HttpServletRequest req, HttpSession ses,	RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectIntiationDetailesLanding.htm "+UserId);
		
		try {
			Map md = model.asMap();
			String IntiationId = (String) md.get("IntiationId");
			String TabId = (String) md.get("TabId");
			String Details = (String) md.get("details");
			String DetailsEdit = (String) md.get("detailsedit");
	
			req.setAttribute("DetailsEdit", DetailsEdit);
			req.setAttribute("Details", Details);
			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
		//	req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)));
			req.setAttribute("ProjectProgressCount", service.ProjectProgressCount(IntiationId));
			req.setAttribute("TabId", TabId);
			req.setAttribute("ScheduleList", service.ProjectIntiationScheduleList(IntiationId));
			req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(IntiationId));
			req.setAttribute("IntiationAttachment", service.ProjectIntiationAttachment(IntiationId));
			req.setAttribute("AuthorityAttachment", service.AuthorityAttachment(IntiationId));
			req.setAttribute("reqTypeList", service.RequirementTypeList());
			req.setAttribute("RequirementList", service.RequirementList(IntiationId));
			
			Map<String, List<Object[]>> BudgetItemMapList = new LinkedHashMap<String, List<Object[]>>();
	
			List<Object[]> ItemList = service.ProjectIntiationItemList(IntiationId);
			List<Object[]> BudgetHead = service.BudgetHead();
	
			for (Object[] obj : BudgetHead) {
				List<Object[]> addlist = new ArrayList<Object[]>();
				for (Object[] obj1 : ItemList) {
					if (obj[1].toString().equalsIgnoreCase(obj1[2].toString())) {
						addlist.add(obj1);
	
					}
				}
				if (addlist.size() > 0) {
					BudgetItemMapList.put(obj[1].toString(), addlist);
				}
	
			}
	
			req.setAttribute("BudgetItemMapList", BudgetItemMapList);
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectIntiationDetailesLanding.htm "+UserId, e);			
    		return "static/Error";
		}

		return "project/ProjectIntiationDetailes";
	}

	@RequestMapping(value = "ProjectShortNameCount.htm", method = RequestMethod.GET)
	public @ResponseBody String ProjectShortNameCount(HttpServletRequest req,HttpSession ses) throws Exception 
	{		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectShortNameCount.htm "+UserId);
		Gson json = new Gson();						
		Long ProjectShortNameCount = service.ProjectShortNameCount(req.getParameter("ProjectShortName"));			
		return json.toJson(ProjectShortNameCount);
	}

	@RequestMapping(value = "ProjectIntiationAdd.htm", method = RequestMethod.POST )
	public String ProjectIntiationAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String EmpName = (String) ses.getAttribute("EmpName");
		String LabCode =(String ) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectIntiationAdd.htm "+UserId);
		
		try {

			String Division = ((Long) ses.getAttribute("Division")).toString();
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			PfmsInitiationDto pfmsinitiationdto = new PfmsInitiationDto();
			pfmsinitiationdto.setEmpId(req.getParameter("PDD"));
			pfmsinitiationdto.setLabCode(LabCode);
			pfmsinitiationdto.setDivisionId(Division);
			pfmsinitiationdto.setProjectProgramme(req.getParameter("ProjectProgramme"));
			pfmsinitiationdto.setProjectTypeId(req.getParameter("ProjectType"));
			/* pfmsinitiationdto.setCategoryId(req.getParameter("Category")); */
			pfmsinitiationdto.setClassificationId(req.getParameter("Category"));
			pfmsinitiationdto.setProjectShortName(req.getParameter("ShortName"));
			pfmsinitiationdto.setProjectTitle(req.getParameter("ProjectTitle"));
			pfmsinitiationdto.setFeCost("0");
			pfmsinitiationdto.setReCost("0");
			pfmsinitiationdto.setProjectCost("0");
			/* pfmsinitiationdto.setProjectDuration(req.getParameter("Duration")); */
			pfmsinitiationdto.setIsPlanned(req.getParameter("IsPlanned"));
			//pfmsinitiationdto.setIsMultiLab(req.getParameter("IsMultiLab"));
			pfmsinitiationdto.setDeliverableId(req.getParameter("Deliverable"));
			pfmsinitiationdto.setNodalLab(req.getParameter("NodalLab"));
			pfmsinitiationdto.setRemarks(req.getParameter("Remarks"));
			pfmsinitiationdto.setIsMain(req.getParameter("ismain"));
			pfmsinitiationdto.setDuration(req.getParameter("PCDuration"));
			pfmsinitiationdto.setIndicativeCost(req.getParameter("IndicativeCost"));
			pfmsinitiationdto.setPCRemarks(req.getParameter("PCRemarks"));
			
			if(req.getParameter("ismain").equalsIgnoreCase("Y")) {
				pfmsinitiationdto.setMainId("0");
			}else {
			pfmsinitiationdto.setMainId(req.getParameter("initiationid"));
			}
			
			Long count = service.ProjectIntiationAdd(pfmsinitiationdto, UserId,EmpId,EmpName);
	
			
			if (count > 0) {
				redir.addAttribute("result", "Project Initiated Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Intiation Unsuccessful");
			}
	
			redir.addFlashAttribute("IntiationId", count.toString());
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectIntiationAdd.htm "+UserId, e);
			
    		return "static/Error";
		}

		return "redirect:/ProjectIntiationDetailesLanding.htm";

	}

	@RequestMapping(value = "ProjectIntiationEdit.htm", method = RequestMethod.POST)
	public String ProjectIntiationEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectIntiationEdit.htm "+UserId);
		
		try {

			String IntiationId = req.getParameter("IntiationId");
	
			req.setAttribute("ProjectTypeList", service.ProjectTypeList());
			req.setAttribute("PfmsCategoryList", service.PfmsCategoryList());
			req.setAttribute("PfmsDeliverableList", service.PfmsDeliverableList());
			req.setAttribute("ProjectEditData", service.ProjectEditData(IntiationId).get(0));
			req.setAttribute("IntiationId", IntiationId);
			req.setAttribute("NodalLabList", service.NodalLabList());
			req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
			
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectIntiationEdit.htm "+UserId, e);
			
    		return "static/Error";
		}


		return "project/ProjectIntiationEdit";
	}

	@RequestMapping(value = "ProjectIntiationEditSubmit.htm", method = RequestMethod.POST)
	public String ProjectIntiationEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectIntiationEditSubmit.htm "+UserId);
		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
		try {
			String option = req.getParameter("sub");
			if (option.equalsIgnoreCase("SUBMIT")) {
				PfmsInitiationDto pfmsinitiationdto = new PfmsInitiationDto();
				pfmsinitiationdto.setInitiationId(req.getParameter("IntiationId"));
				pfmsinitiationdto.setProjectProgramme(req.getParameter("ProjectProgramme"));
				pfmsinitiationdto.setProjectTypeId(req.getParameter("ProjectType"));
				/* pfmsinitiationdto.setCategoryId(req.getParameter("Category")); */
				pfmsinitiationdto.setClassificationId(req.getParameter("Category"));
				pfmsinitiationdto.setNodalLab(req.getParameter("NodalLab"));
				pfmsinitiationdto.setProjectTitle(req.getParameter("ProjectTitle"));
				pfmsinitiationdto.setIsPlanned(req.getParameter("IsPlanned"));
				pfmsinitiationdto.setIsMultiLab(req.getParameter("IsMultiLab"));
				pfmsinitiationdto.setDeliverableId(req.getParameter("Deliverable"));
				pfmsinitiationdto.setRemarks(req.getParameter("Remarks"));
				pfmsinitiationdto.setIsMain(req.getParameter("ismain"));
				pfmsinitiationdto.setEmpId(req.getParameter("PDD"));
				pfmsinitiationdto.setPCRemarks(req.getParameter("PCRemarks"));
				pfmsinitiationdto.setIndicativeCost(req.getParameter("IndicativeCost"));
				pfmsinitiationdto.setDuration(req.getParameter("PCDuration"));
	
				int count = service.ProjectIntiationEdit(pfmsinitiationdto, UserId);
	
				if (count > 0) {
					redir.addAttribute("result", "Project Initiation Edited Successfully");
				} else {
					redir.addAttribute("resultfail", "Project Intiation Edit Unsuccessful");
				}
			}
			
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectIntiationEditSubmit.htm "+UserId, e);
			
    		return "static/Error";
		}
			
		return "redirect:/ProjectIntiationDetailesLanding.htm";

	}

	@RequestMapping(value = "ProjectOtherDetailsAdd.htm", method = RequestMethod.POST)
	public String ProjectOtherDetailsAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectOtherDetailsAdd.htm "+UserId);
		
		try {

			String IntiationId = req.getParameter("IntiationId");
			req.setAttribute("IntiationId", IntiationId);
	
			
	
			req.setAttribute("details_param", req.getParameter("details_param"));
			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectOtherDetailsAdd.htm "+UserId, e);
			
    		return "static/Error";
		}

		return "project/ProjectOtherDetailsRequirementAdd";

	}

	@RequestMapping(value = "ProjectOtherDetailsAddSubmit.htm", method = RequestMethod.POST)
	public String ProjectOtherDetailsAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectOtherDetailsAddSubmit.htm "+UserId);
		
		try {

		
			String Option = req.getParameter("sub");
	
			if (Option.equalsIgnoreCase("SUBMIT")) {
	
				PfmsInitiationDetailDto pfmsinitiationdetaildto = new PfmsInitiationDetailDto();
				pfmsinitiationdetaildto.setInitiationId(req.getParameter("IntiationId"));
				pfmsinitiationdetaildto.setRequirements(req.getParameter("Requirements"));
				pfmsinitiationdetaildto.setObjective(req.getParameter("Objective"));
				pfmsinitiationdetaildto.setScope(req.getParameter("Scope"));
				pfmsinitiationdetaildto.setMultiLabWorkShare(req.getParameter("MultiLabWorkShare"));
				pfmsinitiationdetaildto.setEarlierWork(req.getParameter("EarlierWork"));
				pfmsinitiationdetaildto.setCompentencyEstablished(req.getParameter("CompentencyEstablished"));
				if(req.getParameter("needofproject").length()!=0) {
				pfmsinitiationdetaildto.setNeedOfProject(req.getParameter("needofproject"));}
				else {
					pfmsinitiationdetaildto.setNeedOfProject("-");
				}
				pfmsinitiationdetaildto.setTechnologyChallanges(req.getParameter("TechnologyChallanges"));
				pfmsinitiationdetaildto.setRiskMitigation(req.getParameter("RiskMitiagation"));
				pfmsinitiationdetaildto.setProposal(req.getParameter("Proposal"));
				pfmsinitiationdetaildto.setRealizationPlan(req.getParameter("RealizationPlan"));
				pfmsinitiationdetaildto.setReqBrief(req.getParameter("ReqBrief"));
				pfmsinitiationdetaildto.setObjBrief(req.getParameter("ObjBrief"));
				pfmsinitiationdetaildto.setScopeBrief(req.getParameter("ScopeBrief"));
				pfmsinitiationdetaildto.setMultiLabBrief(req.getParameter("MultiLabBrief"));
				pfmsinitiationdetaildto.setEarlierWorkBrief(req.getParameter("EarlierWorkBrief"));
				pfmsinitiationdetaildto.setCompentencyBrief(req.getParameter("CompentencyBrief"));
				if(req.getParameter("NeedOfProjectBrief").length()!=0) {
				pfmsinitiationdetaildto.setNeedOfProjectBrief(req.getParameter("NeedOfProjectBrief"));}
				else {
					pfmsinitiationdetaildto.setNeedOfProjectBrief("-");
				}
				pfmsinitiationdetaildto.setTechnologyBrief(req.getParameter("TechnologyBrief"));
				pfmsinitiationdetaildto.setRiskMitigationBrief(req.getParameter("RiskMitigationBrief"));
				pfmsinitiationdetaildto.setProposalBrief(req.getParameter("ProposalBrief"));
				pfmsinitiationdetaildto.setRealizationBrief(req.getParameter("RealizationBrief"));
				pfmsinitiationdetaildto.setWorldScenarioBrief(req.getParameter("WorldScenarioBrief"));
				
				Long count =    service.ProjectIntiationAdd(pfmsinitiationdetaildto, UserId);
	
				if (count > 0) {
					redir.addAttribute("result", "Project Details Added Successfully");
				} else {
					redir.addAttribute("resultfail", "Project Details Add Unsuccessful");
				}
				redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
				redir.addFlashAttribute("TabId", "1");
				return "redirect:/ProjectIntiationDetailesLanding.htm";
	
			}
	
			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
			redir.addFlashAttribute("TabId", "1");
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectOtherDetailsAddSubmit.htm "+UserId, e);
			
    		return "static/Error";
		}
		return "redirect:/ProjectIntiationDetailesLanding.htm";

	}
	@RequestMapping(value = "ProjectRequirementAdd.htm", method = RequestMethod.POST)
	public String ProjectRequirementAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String InitiationId=req.getParameter("IntiationId");
		try {
			req.setAttribute("RequirementTypeList", service.RequirementTypeList());
			req.setAttribute("InititationId", InitiationId);
		}catch(Exception e){
			e.printStackTrace();logger.error(new Date() +" Inside ProjectRequirementAdd.htm "+UserId, e);
			return "static/Error";
		}
		return "project/ProjectRequirementAdd";
	}
	
	@RequestMapping(value = "ProjectRequirementAddSubmit.htm", method=RequestMethod.POST)
	public String ProjectRequirementAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) {
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectRequirementAddSubmit.htm "+UserId);
		
		String option=req.getParameter("action");
		try {
		
			if(option.equalsIgnoreCase("SUBMIT")) 
			{
				String  r=req.getParameter("reqtype");
				String[]reqtype=r.split(" ");
				Long reqTypeId=Long.parseLong(reqtype[0]);
				Long a=	(Long)service.numberOfReqTypeId(req.getParameter("IntiationId"));
				String requirementId="";
				if(a<9L) {
				 requirementId=reqtype[2]+reqtype[1]+("000"+((a+1)*10));
				}else if(a==9L||a>=10L) {
					requirementId=reqtype[2]+reqtype[1]+("00"+((a+1)*10));
				}
				
				String RequirementDesc=req.getParameter("description");
				String RequirementBrief=req.getParameter("reqbrief");
				Long IntiationId=Long.parseLong(req.getParameter("IntiationId"));
				PfmsInitiationRequirementDto prd= new PfmsInitiationRequirementDto();
				prd.setInitiationId(IntiationId);
				prd.setReqTypeId(reqTypeId);
				prd.setRequirementId(requirementId);
				prd.setRequirementBrief(RequirementBrief);
				prd.setRequirementDesc(RequirementDesc);
				
				long count=service.ProjectRequirementAdd(prd,UserId);
				if (count > 0) {
					redir.addAttribute("result", "Project Requirement Added Successfully");
				} else {
					redir.addAttribute("resultfail", "Project Requirement Add Unsuccessful");
				}
				redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
				redir.addFlashAttribute("TabId", "6");
				return "redirect:/ProjectIntiationDetailesLanding.htm";
			}
			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
			redir.addFlashAttribute("TabId", "6");
		}
		catch(Exception e){
			e.printStackTrace();
			logger.error(new Date() +"Inside ProjectRequirementAddSubmit.htm  "+UserId, e);
	 		return "static/Error";
		}
		return "redirect:/ProjectIntiationDetailesLanding.htm";
	}
	
	
	 @RequestMapping(value = "ProjectRequirementUpdate.htm",
	 method=RequestMethod.POST) public String ProjectRequirementUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) {  
		 String UserId = (String) ses.getAttribute("Username"); 
		 logger.info(new Date() +"Inside ProjectRequirementUpdate.htm "+UserId);
	 String InitiationId=req.getParameter("IntiationId"); 
	 String option=req.getParameter("action"); 
	 long InitiationReqId=Long.parseLong(req.getParameter("InitiationReqId"));
	
	 
	System.out.println(InitiationId+"----------------"+InitiationReqId);
	 try {
		 req.setAttribute("InitiationId", InitiationId);
		 req.setAttribute("InitiationReqId", req.getParameter("InitiationReqId"));
		 req.setAttribute("RequirementTypeList", service.RequirementTypeList());
		 req.setAttribute("Requirement", service.Requirement(InitiationReqId));

	 }
	 catch(Exception e) {
		 e.printStackTrace(); 
		 logger.info(new Date() +"Inside ProjectRequirementUpdate.htm "+UserId);
		 return "static/Error";
	 }
	 
	 return "project/ProjectRequirementEdit";
	 
	 
}
	
	
	
	@RequestMapping(value = "ProjectLabInsert.htm", method = RequestMethod.POST)
	public String ProjectLabInsert(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectLabInsert.htm "+UserId);
		
		try {

			String IntiationId = req.getParameter("IntiationId");
	
			req.setAttribute("IntiationId", IntiationId);
	
			req.setAttribute("LabList", service.LabList(IntiationId));
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectLabInsert.htm "+UserId, e);
			
    		return "static/Error";
		}

		return "project/ProjectLabInsert";
	}

	@RequestMapping(value = "BudgetItemList.htm", method = RequestMethod.GET)
	public @ResponseBody String BudgetItemList(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		List<Object[]> BudgetItemList =null;
		logger.info(new Date() +"Inside BudgetItemList.htm "+UserId);
		
		try {

			 BudgetItemList = service.BudgetItem(req.getParameter("BudgetHead"));
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside BudgetItemList.htm "+UserId, e);
			
    		return "static/Error";
		}
		Gson json = new Gson();
		return json.toJson(BudgetItemList);

	}

	@RequestMapping(value = "ProjectCostAdd.htm", method = RequestMethod.POST)
	public String ProjectCostAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectCostAdd.htm "+UserId);
		
		try {
			String IntiationId = req.getParameter("IntiationId");
			Map<String, List<Object[]>> BudgetItemMap = new LinkedHashMap<String, List<Object[]>>();
			Map<String, List<Object[]>> BudgetItemMapList = new LinkedHashMap<String, List<Object[]>>();
	
			List<Object[]> ItemList = service.ProjectIntiationItemList(IntiationId);
			List<Object[]> BudgetHead = service.BudgetHead();
			
			Object[]bd=service.ProjectDetailes(Long.parseLong(IntiationId)).get(0);
			BigInteger projecttypeid=(BigInteger)bd[21];
			List<Object[]>BudgetHeadList=service.BudgetHeadList(projecttypeid);
	
			for (Object[] obj : BudgetHead) {
				BudgetItemMap.put(obj[1].toString(), service.BudgetItem(obj[0].toString()));
			}
	
			for (Object[] obj : BudgetHead) {
				List<Object[]> addlist = new ArrayList<Object[]>();
				for (Object[] obj1 : ItemList) {
					if (obj[1].toString().equalsIgnoreCase(obj1[2].toString())) {
						addlist.add(obj1);
	
					}
				}
				if (addlist.size() > 0) {
					BudgetItemMapList.put(obj[1].toString(), addlist);
				}
	
			}
	
			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
			req.setAttribute("BudgetItemMapList", BudgetItemMapList);
			req.setAttribute("IntiationId", IntiationId);
			req.setAttribute("BudgetHead", BudgetHead);
			req.setAttribute("ItemList", service.ProjectIntiationItemList(IntiationId));
			req.setAttribute("TotalIntiationCost", service.TotalIntiationCost(IntiationId));
			req.setAttribute("BudgetItemMap", BudgetItemMap);
			req.setAttribute("BudgetHeadList", BudgetHeadList);
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectCostAdd.htm "+UserId, e);
			
    		return "static/Error";
		}

		return "project/ProjectCostAdd";
	}
		

	
	@RequestMapping(value = "ProjectCostAddLanding.htm", method = RequestMethod.GET)
	public String ProjectCostAddLanding(Model model, HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectCostAddLanding.htm "+UserId);
		
		try {
			String IntiationId = null;
			Map md = model.asMap();
			for (Object modelKey : md.keySet()) {
				IntiationId = (String) md.get(modelKey);
	
			}
			
			Object[] bd=service.ProjectDetailes(Long.parseLong(IntiationId)).get(0);
			BigInteger projecttypeid=(BigInteger)bd[21];
			List<Object[]>BudgetHeadList=service.BudgetHeadList(projecttypeid);
			
			
			Map<String, List<Object[]>> BudgetItemMap = new LinkedHashMap<String, List<Object[]>>();
			Map<String, List<Object[]>> BudgetItemMapList = new LinkedHashMap<String, List<Object[]>>();
	
			List<Object[]> ItemList = service.ProjectIntiationItemList(IntiationId);
			List<Object[]> BudgetHead = service.BudgetHeadList(projecttypeid);
	
			for (Object[] obj : BudgetHead) {
				BudgetItemMap.put(obj[1].toString(), service.BudgetItem(obj[0].toString()));
			}
			for (Object[] obj : BudgetHead) {
				List<Object[]> addlist = new ArrayList<Object[]>();
				for (Object[] obj1 : ItemList) {
					if (obj[1].toString().equalsIgnoreCase(obj1[2].toString())) {
						addlist.add(obj1);
	
					}
				}
				if (addlist.size() > 0) {
					BudgetItemMapList.put(obj[1].toString(), addlist);
				}
			}
	
			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
			req.setAttribute("BudgetItemMapList", BudgetItemMapList);
			req.setAttribute("IntiationId", IntiationId);
			req.setAttribute("BudgetHead", BudgetHead);
			req.setAttribute("ItemList", service.ProjectIntiationItemList(IntiationId));
			req.setAttribute("TotalIntiationCost", service.TotalIntiationCost(IntiationId));
			req.setAttribute("BudgetItemMap", BudgetItemMap);
			req.setAttribute("BudgetHeadList", BudgetHeadList);
		
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectCostAddLanding.htm "+UserId, e);
			
    		return "static/Error";
		}
		return "project/ProjectCostAdd";
	}

	@RequestMapping(value = "ProjectCostAddSubmit.htm", method = RequestMethod.POST)
	public String ProjectCostAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectCostAddSubmit.htm "+UserId);
		
		String option = req.getParameter("sub");
		try {
	
			if (option.equalsIgnoreCase("SUBMIT")) {
			
	
				Object[] ProjectCost = service.ProjectCost(Long.parseLong(req.getParameter("IntiationId"))).get(0);
	
				PfmsInitiationCostDto pfmsinitiationcostdto = new PfmsInitiationCostDto();
	
				pfmsinitiationcostdto.setInitiationId(req.getParameter("IntiationId"));
				pfmsinitiationcostdto.setBudgetHeadId(req.getParameter("BudgetHead"));
				pfmsinitiationcostdto.setBudgetSancId(req.getParameter("Item"));
				pfmsinitiationcostdto.setItemCost(req.getParameter("Cost"));
				pfmsinitiationcostdto.setItemDetail(req.getParameter("ItemDetail"));
	
				Long count = service.ProjectIntiationCostAdd(pfmsinitiationcostdto, UserId, ProjectCost);
	
				if (count > 0) {
					redir.addAttribute("result", "Project Cost Added Successfully");
				} else {
					redir.addAttribute("resultfail", "Project Cost Add Unsuccessful");
				}
	
				redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
			
				return "redirect:/ProjectCostAddLanding.htm";
			} else {
				redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
				redir.addFlashAttribute("TabId", "2");
				return "redirect:/ProjectIntiationDetailesLanding.htm";
			}
			}catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside ProjectCostAddSubmit.htm "+UserId, e);
				
	    		//return "static/Error";
			}
		
		return "redirect:/maindashboard.htm";
	}

	@RequestMapping(value = "ProjectCostEdit.htm", method = RequestMethod.POST)
	public String ProjectCostEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectCostEdit.htm "+UserId);
		
		String option = req.getParameter("sub");
		try {

			Object[] ProjectDetailes = service.ProjectCostEditData(req.getParameter("InitiationCostId")).get(0);
	
			String IntiationId = req.getParameter("IntiationId");
	
			req.setAttribute("ProjectCostEditData", ProjectDetailes);
			req.setAttribute("BudgetItemList", service.BudgetItem(ProjectDetailes[2].toString()));
			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
			req.setAttribute("IntiationId", IntiationId);
			req.setAttribute("BudgetHead", service.BudgetHead());
			req.setAttribute("TotalIntiationCost", service.TotalIntiationCost(IntiationId));
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectCostEdit.htm "+UserId, e);
			
    		return "static/Error";
		}
		return "project/ProjectCostEdit";
	}

	@RequestMapping(value = "ProjectCostEditSubmit.htm", method = RequestMethod.POST)
	public String ProjectCostEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");	
		logger.info(new Date() +"Inside ProjectCostEditSubmit.htm "+UserId);
		
		try {

		
		Object[] ProjectCostEditData = service.ProjectCostEditData(req.getParameter("InitiationCostId")).get(0);
		Object[] ProjectDetailes = service.ProjectDetailes(Long.parseLong(req.getParameter("IntiationId"))).get(0);
		Double ProjectCost = Double.parseDouble(ProjectDetailes[8].toString());

		Double Totalcost = service.TotalIntiationCost(req.getParameter("IntiationId"));
		Totalcost = Totalcost + Double.parseDouble(req.getParameter("Cost")) - Double.parseDouble(ProjectCostEditData[5].toString());

		
		
		
			PfmsInitiationCostDto pfmsinitiationcostdto = new PfmsInitiationCostDto();
			pfmsinitiationcostdto.setInitiationCostId(req.getParameter("InitiationCostId"));
			pfmsinitiationcostdto.setInitiationId(req.getParameter("IntiationId"));
			// pfmsinitiationcostdto.setBudgetHeadId(req.getParameter("BudgetHead"));
			pfmsinitiationcostdto.setBudgetSancId(req.getParameter("Item"));
			pfmsinitiationcostdto.setItemCost(req.getParameter("Cost"));
			pfmsinitiationcostdto.setItemDetail(req.getParameter("ItemDetail"));
			
			
			int count = service.ProjectIntiationCostEdit(pfmsinitiationcostdto, UserId,req.getParameter("IntiationId"),req.getParameter("totalcost"));

			if (count > 0) {
				redir.addAttribute("result", "Project Cost Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Cost Update Unsuccessful");
			}
		
			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
		}
		catch(Exception e) {	    		
    		e.printStackTrace(); logger.error(new Date() +" Inside ProjectCostEditSubmit.htm "+UserId, e);
    		return "static/Error";
	
    	}	

		return "redirect:/ProjectCostAddLanding.htm";

	}

	@RequestMapping(value = "ProjectCostDeleteSubmit.htm", method = RequestMethod.POST)
	public String ProjectCostDeleteSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		String IntiationId =req.getParameter("IntiationId");

		logger.info(new Date() +"Inside ProjectCostDeleteSubmit.htm "+UserId);
		
		try {
		

			int count = service.ProjectIntiationCostDelete(req.getParameter("InitiationCostId"), UserId,IntiationId);
	
			if (count > 0) {
				redir.addAttribute("result", "Project Cost Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Cost Delete Unsuccessful");
			}
			
			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectCostDeleteSubmit.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
			
		}

		return "redirect:/ProjectCostAddLanding.htm";

	}

	@RequestMapping(value = "ProjectLabAdd.htm", method = RequestMethod.POST)
	public String ProjectLabAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectLabAdd.htm "+UserId);
		
		try {
			String IntiationId = req.getParameter("IntiationId");
	
			req.setAttribute("IntiationId", IntiationId);
	
			req.setAttribute("ProjectIntiationLabList", service.ProjectIntiationLabList(IntiationId));
			req.setAttribute("LabList", service.LabList(IntiationId));
			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectLabAdd.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}


		return "project/ProjectLabAdd";
	}

	@RequestMapping(value = "ProjectLabAddSubmit.htm", method = RequestMethod.POST)
	public String ProjectLabAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectLabAddSubmit.htm "+UserId);
		
		try {

			String option = req.getParameter("sub");
			if (option.equalsIgnoreCase("SUBMIT")) {
				
	
				int count = service.ProjectLabAdd(req.getParameterValues("Lid"), req.getParameter("IntiationId"), UserId);
	
				if (count > 0) {
					redir.addAttribute("result", "Project Lab Added Successfully");
				} else {
					redir.addAttribute("resultfail", "Project Lab Add Unsuccessful");
				}
			}
			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
			// redir.addFlashAttribute("TabId","0");
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectLabAddSubmit.htm "+UserId, e);
			
    		return "static/Error";
		}
		return "redirect:/ProjectIntiationDetailesLanding.htm";

	}

	@RequestMapping(value = "ProjectLabdeleteSubmit.htm", method = RequestMethod.POST)
	public String ProjectLabdeleteSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectLabdeleteSubmit.htm "+UserId);
		
		try {
		

		int count = service.ProjectLabDelete(req.getParameter("btSelectItem"), req.getParameter("IntiationId"), UserId);

		if (count > 0) {
			redir.addAttribute("result", "Project Lab Deleted Successfully");
		} else {
			redir.addAttribute("resultfail", "Project Lab Delete Unsuccessful");
		}

		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
		// redir.addFlashAttribute("TabId","0");
		
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectLabdeleteSubmit.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}
		return "redirect:/ProjectIntiationDetailesLanding.htm";

	}
	//ProjectScheduleAddLanding.htm
	@RequestMapping(value = "ProjectScheduleAdd.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public String ProjectScheduleAdd(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectScheduleAdd.htm "+UserId);
		
		try {
			String IntiationId = req.getParameter("IntiationId");
			
			if(IntiationId==null)
			{
				Map md=model.asMap();
				IntiationId=(String)md.get("IntiationId");				
			}	
			
	
			req.setAttribute("IntiationId", IntiationId);
	
			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
			req.setAttribute("ScheduleList", service.ProjectIntiationScheduleList(IntiationId));
			req.setAttribute("ProjectScheduleMonth", service.ProjectScheduleMonth(IntiationId));
			req.setAttribute("MilestoneTotalMonth",service.ProjectScheduleTotalMonthList(IntiationId));

			req.setAttribute("ScheduleTotalMonths",service.ProjectDurationMonth(IntiationId));
			
		
		
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectScheduleAdd.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}

		return "project/ProjectScheduleAdd";
	}

	@RequestMapping(value = "ProjectScheduleAddLanding.htm", method = RequestMethod.GET)
	public String ProjectScheduleAddLanding(Model model, HttpServletRequest req, HttpSession ses,
			RedirectAttributes redir) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectScheduleAddLanding.htm "+UserId);
		
		try {
		String IntiationId = null;
		Map md = model.asMap();
		for (Object modelKey : md.keySet()) {
			IntiationId = (String) md.get(modelKey);

		}

		req.setAttribute("IntiationId", IntiationId);

		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
		req.setAttribute("ScheduleList", service.ProjectIntiationScheduleList(IntiationId));
		req.setAttribute("ProjectScheduleMonth", service.ProjectScheduleMonth(IntiationId));
		req.setAttribute("ProjectDurationMonth", service.ProjectDurationMonth(IntiationId));
		//line added
		req.setAttribute("MilestoneTotalMonth",service.ProjectScheduleTotalMonthList(IntiationId));
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectScheduleAddLanding.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}
		return "project/ProjectScheduleAdd";
	}

	

	@RequestMapping(value = "ProjectScheduleAddSubmit.htm", method = RequestMethod.POST)
	public String ProjectScheduleAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectScheduleAddSubmit.htm "+UserId);
		
		try {

		String option = req.getParameter("sub");
		if (option.equalsIgnoreCase("SUBMIT")) {

			
			Object[] ProjectDetailes = service.ProjectDetailes(Long.parseLong(req.getParameter("IntiationId"))).get(0);
			Integer ProjectScheduleMonth = service.ProjectScheduleMonth(req.getParameter("IntiationId"));
			/*Line added*/Integer ProjectDurationMonth=  service.ProjectDurationMonth(req.getParameter("IntiationId"));
			Integer TotalMonthToAdd = 0;
			String s=req.getParameter("Milestonestarted");
			Integer totalExtendedBy=0;
			
			  String[]startedfrom=s.split("\\s"); Integer
			  milestonestarted=Integer.parseInt(startedfrom[0]); Integer
			  Milestonestartedfrom=Integer.parseInt(startedfrom[1]); Integer
			  MilestoneMonth=Integer.parseInt(req.getParameter("MilestoneMonth")); Integer
			  MilestoneTotalMonth=milestonestarted+MilestoneMonth;
			
			  
				/*
				 * String extndBy=req.getParameter("Milestonestarted");
				 * 
				 * Integer extendedBy=Integer.parseInt(extndBy);
				 * 
				 * int extended=0;
				 * 
				 * while(extendedBy>=0) {
				 * 
				 * }
				 */
			
			/*
			 * String[] montharray=req.getParameterValues("MilestoneMonth");
			 * 
			 * for (int i=0;i<montharray.length;i++) { TotalMonthToAdd = TotalMonthToAdd +
			 * Integer.parseInt(montharray[i]); }
			 */
			
			
			
			//Integer TotalMonth = TotalMonthToAdd + ProjectScheduleMonth;
			/* if(TotalMonth<=Integer.parseInt(ProjectDetailes[9].toString())) { */
			/*
			 * Long count =
			 * service.ProjectScheduleAdd(req.getParameterValues("MilestoneActivity"),
			 * req.getParameterValues("MilestoneMonth"),
			 * req.getParameterValues("MilestoneRemark"), req.getParameter("IntiationId"),
			 * UserId, ProjectDetailes,TotalMonth);
			 */
			 Long count=0L;
			  
			  if(MilestoneTotalMonth>=ProjectDurationMonth) {
			   count =
			  service.ProjectScheduleAdd(req.getParameterValues("MilestoneActivity"),
			  req.getParameterValues("MilestoneMonth"),MilestoneTotalMonth,Milestonestartedfrom,
			  req.getParameterValues("MilestoneRemark"), req.getParameter("IntiationId"),
			  UserId, ProjectDetailes,MilestoneTotalMonth);
			  }
			  else {
				   count =
						  service.ProjectScheduleAdd(req.getParameterValues("MilestoneActivity"),
						  req.getParameterValues("MilestoneMonth"),MilestoneTotalMonth,Milestonestartedfrom,
						  req.getParameterValues("MilestoneRemark"), req.getParameter("IntiationId"),
						  UserId, ProjectDetailes,ProjectDurationMonth);
			  }

			if (count > 0) {
				redir.addAttribute("result", "Project Schedule Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Schedule Add Unsuccessful");
			}

			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));

			return "redirect:/ProjectScheduleAddLanding.htm";

		} else {
			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
			redir.addFlashAttribute("TabId", "3");
			
		}
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectScheduleAddSubmit.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}
		return "redirect:/ProjectIntiationDetailesLanding.htm";
	}

	@RequestMapping(value = "ProjectScheduleEditSubmit.htm", method=RequestMethod.POST)
	public String ProjectScheduleEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectScheduleEditSubmit.htm "+UserId);
		try {
			
			String IntiationId = req.getParameter("IntiationId");
			String initiationscheduleid = req.getParameter("initiationscheduleid");  //pk
			String milestoneno = req.getParameter("milestoneno");
			String MilestoneActivityEdit = req.getParameter("MilestoneActivityEdit");
			String MilestoneFrom = req.getParameter("MilestoneFrom");
			String MilestoneMonthEdit = req.getParameter("MilestoneMonthEdit");
			String MilestoneRemarkEdit = req.getParameter("MilestoneRemarkEdit");
			
			
			ProjectScheduleDto scheduledto =  ProjectScheduleDto.builder()
												.InitiationScheduleId(initiationscheduleid)
												.InitiationId(IntiationId)
												.MileStoneActivity(MilestoneActivityEdit)
												.MileStoneMonth(MilestoneMonthEdit)
												.MileStoneRemark(MilestoneRemarkEdit)
												.MileStoneMonth(MilestoneMonthEdit)
												.Milestonestartedfrom(Integer.parseInt(MilestoneFrom))
												.ModifiedBy(UserId)
												.build();
			
			long count = service.ProjectScheduleEdit(scheduledto);
			
			
			
			redir.addFlashAttribute("IntiationId",IntiationId);
			return "redirect:/ProjectScheduleAdd.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ProjectScheduleEditSubmit.htm "+UserId, e);
			return "static/Error";
		}
		
	}
	

	
	
	
//	@RequestMapping(value = "ProjectScheduleEditSubmit.htm", method=RequestMethod.POST)
//	public String ProjectScheduleEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectScheduleEditSubmit.htm "+UserId);
//		
//		try {
//
//	      //Object[] ProjectDetailes=service.ProjectDetailes(Long.parseLong(req.getParameter("IntiationId"))).get(0);
//		     int msno=Integer.parseInt(req.getParameter("milestoneno"));
//	      int oldmonth=service.ProjectScheduleEditData(req.getParameter("IntiationId"));
//	      Integer ProjectScheduleMonth =service.ProjectScheduleMonth(req.getParameter("IntiationId"));
//	      
//	      int milestonemonthprevious=service.mileStonemonthprevious(req.getParameter("IntiationId"), req.getParameter("milestoneno"));
//	      
//	      int milestonemonthnow=Integer.parseInt(req.getParameter("MilestoneMonthEdit"));
//	      
//	      int monthextended=milestonemonthnow-milestonemonthprevious;
//	      
//	      int milestonenototalmonth=service.milestonenototalmonth(req.getParameter("IntiationId"), req.getParameter("milestoneno"));
//	      
//	      int newMilestoneTotalMonth=milestonenototalmonth+monthextended;
//	    
//	     // service.MilestoneTotalMonthUpdate(newMilestoneTotalMonth, req.getParameter("IntiationId"), req.getParameter("milestoneno"));
//	   
//	      List<Object[]>MileStonenoTotalMonthsList=service.MileStonenoTotalMonths(req.getParameter("IntiationId"), msno);
//	      
//	      List<Integer>list1=new ArrayList<Integer>();
//	      
//	      if(!MileStonenoTotalMonthsList.isEmpty()) {
//	    	  for(int i=0;i<MileStonenoTotalMonthsList.size();i++) {
//	    		  list1.add((Integer)MileStonenoTotalMonthsList.get(i)[0]);
//	    	  }
//				/* while(!MileStonenoTotalMonthsList.isEmpty()) */
//	      }
//	      
//	      System.out.println(list1.toString());
//			/*
//			 * Map<Integer, List<Object[]>> collect =
//			 * MileStonenoTotalMonthsList.stream().collect(Collectors.groupingBy(e->
//			 * Integer.valueOf(e[2].toString()) ,Collectors.toList() ));
//			 * 
//			 * List<String> keylist = new ArrayList<String>(); Set<String> iteratinglist =
//			 * new HashSet<String>();
//			 * 
//			 * int size=0;
//			 * 
//			 * while(size==0) {
//			 * 
//			 * if(iteratinglist.size()==0) iteratinglist.add(String.valueOf(msno));
//			 * keylist.addAll(collect.get(msno).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()));
//			 * iteratinglist.addAll(collect.get(msno).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()));
//			 * 
//			 * System.out.println(iteratinglist);
//			 * 
//			 * for(String j : iteratinglist) {
//			 * 
//			 * System.out.println(j); System.out.println(collect.get(Integer.valueOf(j)));
//			 * List<String> collect2 = collect.get(Integer.valueOf(j)).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList());
//			 * System.out.println(collect2.size() + "" + collect2);
//			 * keylist.addAll(collect.get(Integer.valueOf(j)).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()));
//			 * //iteratinglist.addAll(collect.get(msno).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()));
//			 * if(collect.get(Integer.valueOf(j)).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()).size()==0) size=1; }
//			 * 
//			 * }
//			 * 
//			 * 
//			 * System.out.println(iteratinglist); System.out.println("");
//			 * System.out.println(keylist);
//			 * 
//			 * 
//			 * 
//			 * for(Integer mno : collect.keySet() ) {
//			 * 
//			 * if(collect.containsKey(mno)) { List<Object[]> list = collect.get(mno);
//			 * List<String> collect2 = list.stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()); for(String i : collect2) {
//			 * milestonenototalmonth=service.milestonenototalmonth(req.getParameter(
//			 * "IntiationId"), i);
//			 * newMilestoneTotalMonth=milestonenototalmonth+monthextended;
//			 * service.MilestoneTotalMonthUpdate(newMilestoneTotalMonth,
//			 * req.getParameter("IntiationId"), i); } }
//			 * 
//			 * 
//			 * }
//			 */
//	      
////	      if(collect.containsKey(msno)) {
////			List<Object[]> list = collect.get(msno);
////			List<String> collect2 = list.stream().map(e-> e[0].toString()).collect(Collectors.toList());
////			for(String i : collect2) {
////				milestonenototalmonth=service.milestonenototalmonth(req.getParameter("IntiationId"), i);
////				newMilestoneTotalMonth=milestonenototalmonth+monthextended;
////			    service.MilestoneTotalMonthUpdate(newMilestoneTotalMonth, req.getParameter("IntiationId"), i);
//	      
//	      
//	      
//	   
//			/*
//			 * if(MileStonenoTotalMonthsList.isEmpty()) {
//			 * 
//			 * System.out.println(msno+"-----"+milestonemonthnow+"----"+
//			 * milestonemonthprevious+"--------"+monthextended+"------"+
//			 * newMilestoneTotalMonth+"-------"); }
//			 * 
//			 * Map<Integer,Integer>map=new LinkedHashMap<Integer,Integer>();
//			 * if(!MileStonenoTotalMonthsList.isEmpty()) { for(int
//			 * i=0;i<MileStonenoTotalMonthsList.size();i++) {
//			 * map.put((Integer)MileStonenoTotalMonthsList.get(i)[0],(Integer)
//			 * MileStonenoTotalMonthsList.get(i)[1]); }
//			 * 
//			 * }
//			 * 
//			 * System.out.println(map);
//			 */
//	      	
//	      //Integer TotalMonth=Integer.parseInt(req.getParameter("MilestoneMonthEdit"))+ProjectScheduleMonth-oldmonth;
//	   		Integer TotalMonth=service.ProjectDurationMonth(req.getParameter("IntiationId"));
//			/* if(TotalMonth<=Integer.parseInt(ProjectDetailes[9].toString())) { */
//		
//	      ProjectScheduleDto projectschedule=new ProjectScheduleDto();
//	      projectschedule.setMileStoneActivity(req.getParameter("MilestoneActivityEdit"));
//	      projectschedule.setMileStoneMonth(req.getParameter("MilestoneMonthEdit"));
//	      projectschedule.setMileStoneRemark(req.getParameter("MilestoneRemarkEdit"));
//	      projectschedule.setInitiationScheduleId(req.getParameter("initiationscheduleid"));	      
//	      projectschedule.setUserId(UserId);
//	      projectschedule.setTotalMonth(TotalMonth);
//	      projectschedule.setInitiationId(req.getParameter("IntiationId"));
//	      
//	      
//		int count = service.ProjectScheduleEdit(projectschedule);
//
//		
//		
//		
//		if (count >0 ) {
//			redir.addAttribute("result", "Project Schedule Edited Successfully");
//		} else {
//			redir.addAttribute("resultfail", "Project Schedule Edit Unsuccessful");
//		}
//		
//		
//		redir.addFlashAttribute("IntiationId",req.getParameter("IntiationId"));
//		}catch (Exception e) {
//			e.printStackTrace();
//			logger.error(new Date() +" Inside ProjectScheduleEditSubmit.htm "+UserId, e);
//			return "static/Error";
//		}
//	
//		return "redirect:/ProjectScheduleAddLanding.htm";
//
//}

	
	


//package com.vts.pfms.project.controller;
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectScheduleEditSubmit.htm "+UserId);
//		
//		try {
//
//	      //Object[] ProjectDetailes=service.ProjectDetailes(Long.parseLong(req.getParameter("IntiationId"))).get(0);
//		     int msno=Integer.parseInt(req.getParameter("milestoneno"));
//	      int oldmonth=service.ProjectScheduleEditData(req.getParameter("IntiationId"));
//	      Integer ProjectScheduleMonth =service.ProjectScheduleMonth(req.getParameter("IntiationId"));
//	      
//	      int milestonemonthprevious=service.mileStonemonthprevious(req.getParameter("IntiationId"), req.getParameter("milestoneno"));
//	      
//	      int milestonemonthnow=Integer.parseInt(req.getParameter("MilestoneMonthEdit"));
//	      
//	      int monthextended=milestonemonthnow-milestonemonthprevious;
//	      
//	      int milestonenototalmonth=service.milestonenototalmonth(req.getParameter("IntiationId"), req.getParameter("milestoneno"));
//	      
//	      int newMilestoneTotalMonth=milestonenototalmonth+monthextended;
//	    
//	     // service.MilestoneTotalMonthUpdate(newMilestoneTotalMonth, req.getParameter("IntiationId"), req.getParameter("milestoneno"));
//	   
//	      List<Object[]>MileStonenoTotalMonthsList=service.MileStonenoTotalMonths(req.getParameter("IntiationId"), msno);
//	      
//	      List<Integer>list1=new ArrayList<Integer>();
//	      
//	      if(!MileStonenoTotalMonthsList.isEmpty()) {
//	    	  for(int i=0;i<MileStonenoTotalMonthsList.size();i++) {
//	    		  list1.add((Integer)MileStonenoTotalMonthsList.get(i)[0]);
//	    	  }
//				/* while(!MileStonenoTotalMonthsList.isEmpty()) */
//	      }
//	      
//	      System.out.println(list1.toString());
//			/*
//			 * Map<Integer, List<Object[]>> collect =
//			 * MileStonenoTotalMonthsList.stream().collect(Collectors.groupingBy(e->
//			 * Integer.valueOf(e[2].toString()) ,Collectors.toList() ));
//			 * 
//			 * List<String> keylist = new ArrayList<String>(); Set<String> iteratinglist =
//			 * new HashSet<String>();
//			 * 
//			 * int size=0;
//			 * 
//			 * while(size==0) {
//			 * 
//			 * if(iteratinglist.size()==0) iteratinglist.add(String.valueOf(msno));
//			 * keylist.addAll(collect.get(msno).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()));
//			 * iteratinglist.addAll(collect.get(msno).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()));
//			 * 
//			 * System.out.println(iteratinglist);
//			 * 
//			 * for(String j : iteratinglist) {
//			 * 
//			 * System.out.println(j); System.out.println(collect.get(Integer.valueOf(j)));
//			 * List<String> collect2 = collect.get(Integer.valueOf(j)).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList());
//			 * System.out.println(collect2.size() + "" + collect2);
//			 * keylist.addAll(collect.get(Integer.valueOf(j)).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()));
//			 * //iteratinglist.addAll(collect.get(msno).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()));
//			 * if(collect.get(Integer.valueOf(j)).stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()).size()==0) size=1; }
//			 * 
//			 * }
//			 * 
//			 * 
//			 * System.out.println(iteratinglist); System.out.println("");
//			 * System.out.println(keylist);
//			 * 
//			 * 
//			 * 
//			 * for(Integer mno : collect.keySet() ) {
//			 * 
//			 * if(collect.containsKey(mno)) { List<Object[]> list = collect.get(mno);
//			 * List<String> collect2 = list.stream().map(e->
//			 * e[0].toString()).collect(Collectors.toList()); for(String i : collect2) {
//			 * milestonenototalmonth=service.milestonenototalmonth(req.getParameter(
//			 * "IntiationId"), i);
//			 * newMilestoneTotalMonth=milestonenototalmonth+monthextended;
//			 * service.MilestoneTotalMonthUpdate(newMilestoneTotalMonth,
//			 * req.getParameter("IntiationId"), i); } }
//			 * 
//			 * 
//			 * }
//			 */
//	      
////	      if(collect.containsKey(msno)) {
////			List<Object[]> list = collect.get(msno);
////			List<String> collect2 = list.stream().map(e-> e[0].toString()).collect(Collectors.toList());
////			for(String i : collect2) {
////				milestonenototalmonth=service.milestonenototalmonth(req.getParameter("IntiationId"), i);
////				newMilestoneTotalMonth=milestonenototalmonth+monthextended;
////			    service.MilestoneTotalMonthUpdate(newMilestoneTotalMonth, req.getParameter("IntiationId"), i);
//	      
//	      
//	      
//	   
//			/*
//			 * if(MileStonenoTotalMonthsList.isEmpty()) {
//			 * 
//			 * System.out.println(msno+"-----"+milestonemonthnow+"----"+
//			 * milestonemonthprevious+"--------"+monthextended+"------"+
//			 * newMilestoneTotalMonth+"-------"); }
//			 * 
//			 * Map<Integer,Integer>map=new LinkedHashMap<Integer,Integer>();
//			 * if(!MileStonenoTotalMonthsList.isEmpty()) { for(int
//			 * i=0;i<MileStonenoTotalMonthsList.size();i++) {
//			 * map.put((Integer)MileStonenoTotalMonthsList.get(i)[0],(Integer)
//			 * MileStonenoTotalMonthsList.get(i)[1]); }
//			 * 
//			 * }
//			 * 
//			 * System.out.println(map);
//			 */
//	      	
//	      //Integer TotalMonth=Integer.parseInt(req.getParameter("MilestoneMonthEdit"))+ProjectScheduleMonth-oldmonth;
//	   		Integer TotalMonth=service.ProjectDurationMonth(req.getParameter("IntiationId"));
//			/* if(TotalMonth<=Integer.parseInt(ProjectDetailes[9].toString())) { */
//		
//	      ProjectScheduleDto projectschedule=new ProjectScheduleDto();
//	      projectschedule.setMileStoneActivity(req.getParameter("MilestoneActivityEdit"));
//	      projectschedule.setMileStoneMonth(req.getParameter("MilestoneMonthEdit"));
//	      projectschedule.setMileStoneRemark(req.getParameter("MilestoneRemarkEdit"));
//	      projectschedule.setInitiationScheduleId(req.getParameter("initiationscheduleid"));	      
//	      projectschedule.setUserId(UserId);
//	      projectschedule.setTotalMonth(TotalMonth);
//	      projectschedule.setInitiationId(req.getParameter("IntiationId"));
//	      
//	      
//		int count = service.ProjectScheduleEdit(projectschedule);
//
//		
//		
//		
//		if (count >0 ) {
//			redir.addAttribute("result", "Project Schedule Edited Successfully");
//		} else {
//			redir.addAttribute("resultfail", "Project Schedule Edit Unsuccessful");
//		}
//		
//		
//		redir.addFlashAttribute("IntiationId",req.getParameter("IntiationId"));
//		}catch (Exception e) {
//			e.printStackTrace();
//			logger.error(new Date() +" Inside ProjectScheduleEditSubmit.htm "+UserId, e);
//			return "static/Error";
//		}
//	
//		return "redirect:/ProjectScheduleAddLanding.htm";
//
//}

	@RequestMapping(value = "ProjectScheduleDeleteSubmit.htm", method = RequestMethod.POST)
	public String ProjectScheduleDeleteSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectScheduleDeleteSubmit.htm "+UserId);
		
		try {

		Integer ProjectScheduleMonth = service.ProjectScheduleMonth(req.getParameter("IntiationId"));

		Integer TotalMonth = ProjectScheduleMonth - Integer.parseInt(req.getParameter("MilestoneMonthEdit"));

		String InitiationId = req.getParameter("IntiationId");
		
		
		Integer MilestoneScheduleMonth=service.MilestoneScheduleMonth(req.getParameter("initiationscheduleid"),req.getParameter("IntiationId"));
		
		Integer ProjectDurationMonth=service.ProjectDurationMonth(req.getParameter("IntiationId"));
		
	
		
		

		int count = service.ProjectScheduleDelete(req.getParameter("initiationscheduleid"), UserId, MilestoneScheduleMonth,
				InitiationId);

		if (count > 0) {
			redir.addAttribute("result", "Project Schedule Deleted Successfully");
		} else {
			redir.addAttribute("resultfail", "Project Schedule Delete Unsuccessful");
		}
		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectScheduleDeleteSubmit.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}

		return "redirect:/ProjectScheduleAddLanding.htm";

	}

	@RequestMapping(value = "ProjectInitiationDetailsEdit.htm", method = RequestMethod.POST)
	public String ProjectInitiationDetailsEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectInitiationDetailsEdit.htm "+UserId);
		
		try {

		String IntiationId = req.getParameter("IntiationId");
		String Details = req.getParameter("details");

		req.setAttribute("Details", Details);
		req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(IntiationId));
		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectInitiationDetailsEdit.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}

		return "project/ProjectInitiationDetailsEdit";
	}
	@RequestMapping(value = "ProjectInitiationDetailsSubmit.htm", method = RequestMethod.POST)
	public String ProjectInitiationDetailsSubmit(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectInitiationDetailsSubmit.htm "+UserId);
		
		try {
		String InitiationId = req.getParameter("IntiationId");
		String Details = req.getParameter("details");
//		

		String option = req.getParameter("sub");
		if (option.equalsIgnoreCase("SUBMIT")) {

			

			String Alert = "";

			PfmsInitiationDetailDto pfmsinitiationdetaildto = new PfmsInitiationDetailDto();

			if (Details.equalsIgnoreCase("requirement")) {
				/*
				 * if(req.getParameter("Requirements").length()!=0) {
				 * pfmsinitiationdetaildto.setRequirements(req.getParameter("Requirements"));}
				 * else { pfmsinitiationdetaildto.setRequirements("-"); }
				 */
				//edited
				if(req.getParameter("ReqBrief").length()!=0) {
				pfmsinitiationdetaildto.setReqBrief(req.getParameter("ReqBrief"));}
				else {
					pfmsinitiationdetaildto.setReqBrief("-");
				}
				
				Alert = "Requirement";
			}
			if (Details.equalsIgnoreCase("objective")) {
				if(req.getParameter("objective").length()!=0) {
				pfmsinitiationdetaildto.setObjective(req.getParameter("objective"));}
				else {
					pfmsinitiationdetaildto.setObjective("-");
				}
				if(req.getParameter("ObjBrief").length()!=0) {
				pfmsinitiationdetaildto.setObjBrief(req.getParameter("ObjBrief")); 
				}else {
					pfmsinitiationdetaildto.setObjBrief("-");
				}
				//edited
				Alert = "Objective";
			}
			if (Details.equalsIgnoreCase("scope")) {
				if(req.getParameter("scope").length()!=0) {
				pfmsinitiationdetaildto.setScope(req.getParameter("scope"));}
				else {
					pfmsinitiationdetaildto.setScope("-");
				}
				if(req.getParameter("ScopeBrief").length()!=0) {
				pfmsinitiationdetaildto.setScopeBrief(req.getParameter("ScopeBrief"));}
				else {
					pfmsinitiationdetaildto.setScopeBrief("-");
				}
				Alert = "Scope";
			}
			if (Details.equalsIgnoreCase("multilab")) {
				if(req.getParameter("multilab").length()!=0) {
				pfmsinitiationdetaildto.setMultiLabWorkShare(req.getParameter("multilab"));}
				else {
					pfmsinitiationdetaildto.setMultiLabWorkShare("-");
				}
				if(req.getParameter("MultiLabBrief").length()!=0) {
				pfmsinitiationdetaildto.setMultiLabBrief(req.getParameter("MultiLabBrief"));}
				else {
					pfmsinitiationdetaildto.setMultiLabBrief("-");
				}
				Alert = "Multi-Lab Work Share";
			}
			if (Details.equalsIgnoreCase("earlierwork")) {
				if(req.getParameter("earlierwork").length()!=0) {
				pfmsinitiationdetaildto.setEarlierWork(req.getParameter("earlierwork"));}
				else {
					pfmsinitiationdetaildto.setEarlierWork("-");
				}
				if(req.getParameter("EarlierWorkBrief").length()!=0) {
				pfmsinitiationdetaildto.setEarlierWorkBrief(req.getParameter("EarlierWorkBrief"));}
				else {
					pfmsinitiationdetaildto.setEarlierWorkBrief("-");
				}
				Alert = "Earlier Work";
			}
			if (Details.equalsIgnoreCase("competency")) {
				if(req.getParameter("competency").length()!=0) {
				pfmsinitiationdetaildto.setCompentencyEstablished(req.getParameter("competency"));}
				else {
					pfmsinitiationdetaildto.setCompentencyEstablished("-");
				}
				if(req.getParameter("CompentencyBrief").length()!=0) {
				pfmsinitiationdetaildto.setCompentencyBrief(req.getParameter("CompentencyBrief"));}
				else {
					pfmsinitiationdetaildto.setCompentencyBrief("-");
				}
				Alert = "Competency Established";
			}
			if (Details.equalsIgnoreCase("needofproject")) {
				if(req.getParameter("needofproject").length()!=0) {
				pfmsinitiationdetaildto.setNeedOfProject(req.getParameter("needofproject"));}
				else {
					
				}
				if(req.getParameter("NeedOfProjectBrief").length()!=0) {
				pfmsinitiationdetaildto.setNeedOfProjectBrief(req.getParameter("NeedOfProjectBrief"));}
				else {
					pfmsinitiationdetaildto.setNeedOfProjectBrief("-");
				}
				Alert = "Need of Project";
			}
			if (Details.equalsIgnoreCase("technology")) {
				if(req.getParameter("technology").length()!=0) {
				pfmsinitiationdetaildto.setTechnologyChallanges(req.getParameter("technology"));}
				else {
					pfmsinitiationdetaildto.setTechnologyChallanges("-");
				}
				if(req.getParameter("TechnologyBrief").length()!=0) {
				pfmsinitiationdetaildto.setTechnologyBrief(req.getParameter("TechnologyBrief"));}
				else {
					pfmsinitiationdetaildto.setTechnologyBrief("-");
				}
				Alert = "Technology Challenges";
			}
			if (Details.equalsIgnoreCase("riskmitigation")) {
				if(req.getParameter("riskmitigation").length()!=0) {
				pfmsinitiationdetaildto.setRiskMitigation(req.getParameter("riskmitigation"));}
				else {
					pfmsinitiationdetaildto.setRiskMitigation("-");
				}
				if(req.getParameter("RiskMitigationBrief").length()!=0) {
				pfmsinitiationdetaildto.setRiskMitigationBrief(req.getParameter("RiskMitigationBrief"));}
				else {
					pfmsinitiationdetaildto.setRiskMitigationBrief("-");
				}
				Alert = "Risk Mitigation";
			}
			if (Details.equalsIgnoreCase("proposal")) {
				if(req.getParameter("proposal").length()!=0) {
				pfmsinitiationdetaildto.setProposal(req.getParameter("proposal"));}
				else {
					pfmsinitiationdetaildto.setProposal("-");
				}
				if(req.getParameter("ProposalBrief").length()!=0) {
				pfmsinitiationdetaildto.setProposalBrief(req.getParameter("ProposalBrief"));}
				else {
					pfmsinitiationdetaildto.setProposalBrief("-");
				}
				Alert = "Proposal";
			}
			if (Details.equalsIgnoreCase("realization")) {
				if(req.getParameter("realization").length()!=0) {
				pfmsinitiationdetaildto.setRealizationPlan(req.getParameter("realization"));}
				else {
					pfmsinitiationdetaildto.setRealizationPlan("-");
				}
				if(req.getParameter("RealizationBrief").length()!=0) {
				pfmsinitiationdetaildto.setRealizationBrief(req.getParameter("RealizationBrief"));}
				else {
					pfmsinitiationdetaildto.setRealizationBrief("-");
				}
				Alert = "Realization Plan";
			}
			if (Details.equalsIgnoreCase("worldscenario")) {
				if(req.getParameter("worldscenario").length()!=0) {
				pfmsinitiationdetaildto.setWorldScenario(req.getParameter("worldscenario"));}
				else {
					pfmsinitiationdetaildto.setWorldScenario("-");
				}
				if(req.getParameter("WorldScenarioBrief").length()!=0) {
				pfmsinitiationdetaildto.setWorldScenarioBrief(req.getParameter("WorldScenarioBrief"));}
				else {
					pfmsinitiationdetaildto.setWorldScenarioBrief("-");
				}
				Alert = "World Scenario";
			}

			pfmsinitiationdetaildto.setInitiationId(InitiationId);

			Long count = 0L;

			count = service.ProjectInitiationDetailsUpdate(pfmsinitiationdetaildto, UserId, Details);

			if (count > 0) {
				redir.addAttribute("result", "Project Details (" + Alert + ") Edited Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Initiation Edit Unsuccessful");
			}

		}

		redir.addFlashAttribute("detailsedit", Details);
		redir.addFlashAttribute("details", Details);
		redir.addFlashAttribute("IntiationId", InitiationId);
		redir.addFlashAttribute("TabId", "1");
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectInitiationDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}
		return "redirect:/ProjectIntiationDetailesLanding.htm";
	}
	@RequestMapping(value = "ProjectRequirementEditSubmit.htm", method = RequestMethod.POST)
	public String ProjectRequirementEditSubmit(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectRequirementEditSubmit.htm "+UserId);
		String option=req.getParameter("action");
		try {
		
			if(option.equalsIgnoreCase("SUBMIT")) 
			{
		Long IntiationId=Long.parseLong(req.getParameter("IntiationId"));
		String InitiationReqId=req.getParameter("InitiationReqId");
		String  r=req.getParameter("reqtype");
		String[]reqtype=r.split(" ");
		Long reqTypeId=Long.parseLong(reqtype[0]);
		String requirementId="";
		String reqId=req.getParameter("requirementid").substring(5);		
		 requirementId=reqtype[2]+reqtype[1]+reqId;
		String RequirementDesc=req.getParameter("description");
		String RequirementBrief=req.getParameter("reqbrief");
		PfmsInitiationRequirementDto prd= new PfmsInitiationRequirementDto();
		prd.setInitiationId(IntiationId);
		prd.setReqTypeId(reqTypeId);
		prd.setRequirementId(requirementId);
		prd.setRequirementBrief(RequirementBrief);
		prd.setRequirementDesc(RequirementDesc);
		
		
		long count=service.RequirementUpdate(prd,UserId,InitiationReqId);
		if (count > 0) {
			redir.addAttribute("result", "Project Requirement Edited Successfully");
		} else {
			redir.addAttribute("resultfail", "Project Requirement Edited Unsuccessful");
		}
		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
		redir.addFlashAttribute("TabId", "6");
		return "redirect:/ProjectIntiationDetailesLanding.htm";
		
		}
			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
			redir.addFlashAttribute("TabId", "6");
		}
			catch(Exception e) {
				e.printStackTrace();
				logger.error(new Date() +"Inside ProjectRequirementEditSubmit.htm  "+UserId, e);
		 		return "static/Error";
			}
		return "redirect:/ProjectIntiationDetailesLanding.htm";
	}
	
	
	
	/*
	 * @RequestMapping(value = "Requirements.htm", method = RequestMethod.POST)
	 * public String Requirements(HttpServletRequest req, HttpSession ses,
	 * RedirectAttributes redir) { String UserId = (String)
	 * ses.getAttribute("Username");
	 * 
	 * logger.info(new Date() +"Inside Requirements.htm "+UserId); String
	 * initiationid=req.getParameter("IntiationId"); String
	 * reqid=req.getParameter("reqid");
	 * 
	 * }
	 */
	

	@RequestMapping(value = "ProjectAttachmentAdd.htm", method = RequestMethod.POST)
	public String ProjectAttachmentAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectAttachmentAdd.htm "+UserId);
		
		try {
		String IntiationId = req.getParameter("IntiationId");

		req.setAttribute("IntiationId", IntiationId);
		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
		req.setAttribute("filesize",file_size);
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectAttachmentAdd.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}

		return "project/ProjectAttachmentAdd";
	}
	
	@RequestMapping(value = "ProjectAttachmentAddSubmit.htm", method = RequestMethod.POST)
	public String ProjectAttachmentAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart("FileAttach") MultipartFile FileAttach) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectAttachmentAddSubmit.htm "+UserId);
		
		try {
		String option = req.getParameter("sub");
		if (option.equalsIgnoreCase("SUBMIT")) {

			PfmsInitiationAttachmentDto pfmsinitiationattachmentdto = new PfmsInitiationAttachmentDto();
			PfmsInitiationAttachmentFileDto pfmsinitiationattachmentfiledto = new PfmsInitiationAttachmentFileDto();
			pfmsinitiationattachmentdto.setFileName(req.getParameter("FileName"));
			pfmsinitiationattachmentdto.setInitiationId(req.getParameter("IntiationId"));
			pfmsinitiationattachmentdto.setFileNamePath(
					req.getParameter("FileName") + "." + FileAttach.getOriginalFilename().split("\\.")[1]);
			pfmsinitiationattachmentfiledto.setLabCode(LabCode);
			pfmsinitiationattachmentfiledto.setFileAttach(FileAttach);

			Long count = service.ProjectInitiationAttachmentAdd(pfmsinitiationattachmentdto,
					pfmsinitiationattachmentfiledto, UserId);

			if (count > 0) {
				redir.addAttribute("result", "Project Attachment Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Attachment Add Unsuccessful");
			}
			

		}

		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
		redir.addFlashAttribute("TabId", "4");
		}catch (Exception e) {
			
			
			
			logger.error(new Date() +" Inside ProjectAttachmentAddSubmit.htm "+UserId, e);
			e.printStackTrace();
    		

			
		}
		return "redirect:/ProjectIntiationDetailesLanding.htm";
	}

	@RequestMapping(value = "ProjectAttachmentDelete.htm", method = RequestMethod.POST)
	public String ProjectAttachmentDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectAttachmentDelete.htm "+UserId);
		
		try {

		int count = service.ProjectInitiationAttachmentDelete(req.getParameter("InitiationAttachmentId"), UserId);

		if (count > 0) {
			redir.addAttribute("result", "Project Attachment Deleted Successfully");
		} else {
			redir.addAttribute("resultfail", "Project Attachment Delete Unsuccessful");
		}

		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
		redir.addFlashAttribute("TabId", "4");
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectAttachmentDelete.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}
		return "redirect:/ProjectIntiationDetailesLanding.htm";
	}

	@RequestMapping(value = "ProjectAttachmentEdit.htm", method = RequestMethod.POST)
	public String ProjectAttachmentEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectAttachmentEdit.htm "+UserId);
		
		try {

		String IntiationId = req.getParameter("IntiationId");

		req.setAttribute("IntiationId", IntiationId);
		req.setAttribute("InitiationAttachmentId", req.getParameter("InitiationAttachmentId"));
		req.setAttribute("FileName",service.ProjectIntiationAttachmentFileName(req.getParameter("InitiationAttachmentId")));
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectAttachmentEdit.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}
		return "project/ProjectAttachmentEdit";
	}

	@RequestMapping(value = "ProjectAttachmentUpdate.htm", method = RequestMethod.POST)
	public String ProjectAttachmentUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectAttachmentUpdate.htm "+UserId);
		
		try {
		String option = req.getParameter("sub");
		if (option.equalsIgnoreCase("SUBMIT")) {
			

			int count = service.ProjectInitiationAttachmentUpdate(req.getParameter("InitiationAttachmentId"),
					req.getParameter("FileName"), UserId);

			if (count > 0) {
				redir.addAttribute("result", "Project Attachment Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Attachment Update Unsuccessful");
			}

		}

		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
		redir.addFlashAttribute("TabId", "4");
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectAttachmentUpdate.htm "+UserId, e);
			e.printStackTrace();
    		return "static/Error";
		}
		return "redirect:/ProjectIntiationDetailesLanding.htm";
	}

	@RequestMapping(value = "ProjectAttachDownload.htm", method = RequestMethod.GET)
	public void ProjectAttachDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectAttachDownload.htm "+UserId);
		
		try {
		  //String FilenamePath = service.ProjectIntiationAttachmentFileNamePath(req.getParameter("InitiationAttachmentId"));

			 res.setContentType("Application/octet-stream");	
				
			 PfmsInitiationAttachmentFile attachment=service.ProjectIntiationAttachmentFile(req.getParameter("InitiationAttachmentId" ));
			 Object[]  pfmsinitiation = service.ProjectIntiationFileName(attachment.getInitiationAttachmentId());
				File my_file=null;
			
				my_file = new File(uploadpath+attachment.getFilePath()+File.separator+attachment.getFileName()); 
		        res.setHeader("Content-disposition","attachment; filename="+pfmsinitiation[3].toString()); 
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

			
			logger.error(new Date() +" Inside ProjectAttachDownload.htm "+UserId, e);
			e.printStackTrace();
    		//return "static/Error";
		}

	}

	@RequestMapping(value = "ProjectAuthorityAdd.htm", method = RequestMethod.POST)
	public String ProjectAuthorityAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectAuthorityAdd.htm "+UserId);
		String LabCode = (String)ses.getAttribute("labcode");
		try {
		String IntiationId = req.getParameter("IntiationId");
		String Option=req.getParameter("option");
		
		req.setAttribute("IntiationId", IntiationId);
		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
		req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
		req.setAttribute("filesize",file_size);
		
		if(Option.equalsIgnoreCase("edit")) {
		req.setAttribute("ProjectAuthorityDetails", service.AuthorityAttachment(IntiationId).get(0));
		}
		
		req.setAttribute("Option", Option);
		
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectAuthorityAdd.htm "+UserId, e);
			e.printStackTrace();
    		
		}

		return "project/ProjectAuthorityAdd";
	}
	
	
	@RequestMapping(value = "ProjectAuthorityAddSubmit.htm", method = RequestMethod.POST)
	public String ProjectAuthorityAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart("FileAttach") MultipartFile FileAttach) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode"); 
		logger.info(new Date() +"Inside ProjectAuthorityAddSubmit.htm "+UserId);
		
		try {
		String option = req.getParameter("sub");
		if (option.equalsIgnoreCase("SUBMIT")) {

			PfmsInitiationAuthorityDto pfmsinitiationauthoritydto = new PfmsInitiationAuthorityDto();
			
			PfmsInitiationAuthorityFileDto pfmsinitiationauthorityfiledto = new PfmsInitiationAuthorityFileDto();
			
			pfmsinitiationauthoritydto.setAuthorityName(req.getParameter("authorityname"));
			pfmsinitiationauthoritydto.setInitiationId(req.getParameter("IntiationId"));
			pfmsinitiationauthoritydto.setLetterDate(req.getParameter("startdate"));
			pfmsinitiationauthoritydto.setLetterNo(req.getParameter("letterno"));
			pfmsinitiationauthorityfiledto.setFilePath(labcode);
			pfmsinitiationauthorityfiledto.setAttachFile(FileAttach);
			pfmsinitiationauthorityfiledto.setAttachementName(	req.getParameter("letterno") + "." + FileAttach.getOriginalFilename().split("\\.")[1]);
			
			Long count = service.ProjectInitiationAuthorityAdd(pfmsinitiationauthoritydto, UserId,pfmsinitiationauthorityfiledto);

			if (count > 0) {
				redir.addAttribute("result", "Project Authority Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Authority Add Unsuccessful");
			}

		}

		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
		redir.addFlashAttribute("TabId", "5");
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectAuthorityAddSubmit.htm "+UserId, e);
			e.printStackTrace();
    		//return "static/Error";
		}
		return "redirect:/ProjectIntiationDetailesLanding.htm";
	}
	
	
	@RequestMapping(value = "ProjectAuthorityDownload.htm", method = RequestMethod.GET)
	public void ProjectAuthorityDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectAuthorityDownload.htm "+UserId);
		try
		{
			PfmsInitiationAuthorityFile attachment=service.ProjectAuthorityDownload(req.getParameter("AuthorityFileId"));
			
			res.setContentType("application/octet-stream");
			
				File my_file=null;	
				my_file = new File(uploadpath+attachment.getFile()+File.separator+attachment.getAttachmentName()); 
		        res.setHeader("Content-disposition","attachment; filename="+attachment.getAttachmentName()); 
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
			
			e.printStackTrace(); logger.error(new Date() +"Inside ProjectAuthorityDownload.htm "+UserId,e);
		}
	}
	
	@RequestMapping(value="ProjectAuthorityEditSubmit.htm",method=RequestMethod.POST)
	public String ProjectAuthorityEditSubmit(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses,@RequestPart("FileAttach") MultipartFile FileAttach )throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String labCode =(String)ses.getAttribute("labcode"); 
		logger.info(new Date() +"Inside ProjectAuthorityEditSubmit.htm "+UserId);
		try
		{
			String option = req.getParameter("sub");
			if (option.equalsIgnoreCase("SUBMIT")) {
			PfmsInitiationAuthorityDto pfmsinitiationauthoritydto = new PfmsInitiationAuthorityDto();

			PfmsInitiationAuthorityFileDto pfmsinitiationauthorityfiledto = new PfmsInitiationAuthorityFileDto();

			pfmsinitiationauthoritydto.setAuthorityName(req.getParameter("authorityname"));
			pfmsinitiationauthoritydto.setInitiationId(req.getParameter("IntiationId"));
			pfmsinitiationauthoritydto.setLetterDate(req.getParameter("startdate"));
			pfmsinitiationauthoritydto.setLetterNo(req.getParameter("letterno"));
			
			
			pfmsinitiationauthorityfiledto.setAttachementName(req.getParameter("letterno"));
			pfmsinitiationauthorityfiledto.setAttachFile(FileAttach);
			pfmsinitiationauthorityfiledto.setFilePath(labCode);
			pfmsinitiationauthorityfiledto.setInitiationAuthorityFileId(req.getParameter("attachmentid"));
			
			
			long count = 0;
			count=	service.ProjectAuthorityUpdate(pfmsinitiationauthoritydto,pfmsinitiationauthorityfiledto,UserId);
			
				if (count > 0) {
					redir.addAttribute("result", "Authority Edited Successfully");
				} else {
					redir.addAttribute("resultfail", "Authority Edit Unsuccessful");
					
				}
			}
			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
			redir.addFlashAttribute("TabId", "5");
			}catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside ProjectAuthorityEditSubmit.htm "+UserId, e);
				e.printStackTrace();
			}
			return "redirect:/ProjectIntiationDetailesLanding.htm";
	}

	@RequestMapping(value = "PreviewPage.htm", method = RequestMethod.POST)
	public String PreviewPage(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside PreviewPage.htm "+UserId);
		
		try {
		String InitiationId = req.getParameter("InitiationId");

		

		req.setAttribute("ProjectDetailsPreview", service.ProjectDetailsPreview(Long.parseLong(InitiationId)).get(0));
		req.setAttribute("ScheduleList", service.ProjectIntiationScheduleList(InitiationId));
		req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(InitiationId));
		req.setAttribute("CostList", service.ProjectIntiationCostList(InitiationId));
		req.setAttribute("IntiationAttachment", service.ProjectIntiationAttachment(InitiationId));
		req.setAttribute("AuthorityAttachment", service.AuthorityAttachment(InitiationId));
		req.setAttribute("reqTypeList", service.RequirementTypeList());
		req.setAttribute("RequirementList", service.RequirementList(InitiationId));

		
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside PreviewPage.htm "+UserId, e);		
    		return "static/Error";
		}

		return "project/ProjectPreview";

	}

	@RequestMapping(value = "ProjectIntiationForward.htm", method = RequestMethod.POST)
	public String ProjectIntiationForward(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectIntiationForward.htm "+UserId);
		
		
		System.out.println(req.getParameter("labcode")+"----------------------");
		
		try {
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();


		String InitiationId = req.getParameter("InitiationId");
		String ProjectCode=req.getParameter("projectcode");
		String PDD=req.getParameter("pdd");

		Long ProjectForwardStatuscount = service.ProjectForwardStatus(InitiationId);
		if (ProjectForwardStatuscount > 0) {

			int count = service.ProjectIntiationStatusUpdate(InitiationId, UserId, PDD,ProjectCode);

			if (count > 0) {
				redir.addAttribute("result", "Project Forwarded Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Forward Unsuccessful");
			}
		} else {
			redir.addAttribute("resultfail", "Project Initiation Not Complete");
		}

		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectIntiationForward.htm "+UserId, e);
			e.printStackTrace();
    		//return "static/Error";
		}
		return "redirect:/ProjectIntiationList.htm";

	}
	
	@RequestMapping(value = "ProjectApprovalAd.htm", method = RequestMethod.GET)
	public String ProjectApprovalAd(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectApprovalAd.htm "+UserId);
		
		try {
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();

		req.setAttribute("ProjectActionList", service.ProjectActionList("3"));
		req.setAttribute("ProjectApproveAdList", service.ProjectApproveAdList(EmpId));

		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalAd.htm "+UserId, e);
			e.printStackTrace();
    		//return "static/Error";
		}

		return "project/ProjectApprovalAD";
	}
	
	@RequestMapping(value = "ProjectApprovalAdSubmit.htm", method = RequestMethod.POST)
	public String ProjectApprovalAdSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectApprovalAdSubmit.htm "+UserId);
		
		try {
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		
		String InitiationId = req.getParameter("IntiationId");
		String Remark = req.getParameter("Remark");
		String ProjectCode=req.getParameter("projectcode");
		String Status=req.getParameter("Status");
		String LabCode=req.getParameter("labcode");

		int count = service.ProjectApproveAd(InitiationId, Remark, UserId, EmpId,ProjectCode,Status,LabCode);

		if (count > 0) {
			redir.addAttribute("result", "Project Forwarded Successfully");
		} else {
			redir.addAttribute("resultfail", "Project Forward Unsuccessful");
		}
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalAdSubmit.htm "+UserId, e);
			e.printStackTrace();
    		//return "static/Error";
		}

		return "redirect:/ProjectApprovalAd.htm";

	}

	@RequestMapping(value = "ProjectApprovalPd.htm", method = RequestMethod.GET)
	public String ProjectApprovalPd(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectApprovalPd.htm "+UserId);		
		try {
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();

		req.setAttribute("ProjectActionList", service.ProjectActionList("1"));
		req.setAttribute("ProjectApprovePdList", service.ProjectApprovePdList(EmpId));

		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalPd.htm "+UserId, e);
			e.printStackTrace();
    		//return "static/Error";
		}

		return "project/ProjectApprovalPd";
	}

	@RequestMapping(value = "ProjectApprovalPdSubmit.htm", method = RequestMethod.POST)
	public String ProjectApprovalPdSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectApprovalPdSubmit.htm "+UserId);
		
		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			
			String InitiationId = req.getParameter("IntiationId");
			String Remark = req.getParameter("Remark");
			String ProjectCode=req.getParameter("projectcode");
			String Status=req.getParameter("Status");
			
			System.out.print(Status+"--------------------");
			
			int count = service.ProjectApprovePd(InitiationId, Remark, UserId, EmpId,ProjectCode,Status);
	
			if (count > 0) {
				redir.addAttribute("result", "Project Forwarded Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Forward Unsuccessful");
			}
			}catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalPdSubmit.htm "+UserId, e);
				e.printStackTrace();
	    		return "static/Error";
			}
		return "redirect:/ProjectApprovalPd.htm";
	}




	@RequestMapping(value = "ProjectApprovalTracking.htm", method = RequestMethod.GET)
	public String ProjectApprovalTracking(HttpSession ses, HttpServletRequest req, RedirectAttributes redir)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectApprovalTracking.htm "+UserId);
		
		try {
		String InitiationId = req.getParameter("Initiationid");

		req.setAttribute("ProjectApprovalTracking", service.ProjectApprovalTracking(InitiationId));
		req.setAttribute("InitiationId", InitiationId);
		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(InitiationId)).get(0));
		
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalTracking.htm "+UserId, e);
		}

		return "project/ProjectApprovalTracking";
	}

	


	@RequestMapping(value = "ProjectApprovalRtmddo.htm", method = RequestMethod.GET)
	public String ProjectApprovalRtmddo(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)
			throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectApprovalRtmddo.htm "+UserId);
		
		try {
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();

		req.setAttribute("ProjectActionList", service.ProjectActionList("2"));
		req.setAttribute("ProjectApproveRtmddoList", service.ProjectApproveRtmddoList(EmpId));
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalRtmddo.htm "+UserId, e);
		}

		return "project/ProjectApprovalRtmddo";
	}

	@RequestMapping(value = "ProjectApprovalRtmddoSubmit.htm", method = RequestMethod.POST)
	public String ProjectApprovalRtmddoSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectApprovalRtmddoSubmit.htm "+UserId);
		
		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();	
			String InitiationId = req.getParameter("IntiationId");
			String Remark = req.getParameter("Remark");
			String ProjectCode=req.getParameter("projectcode");
			String Status=req.getParameter("Status");
			
			int count = service.ProjectApproveRtmddo(InitiationId, Remark, UserId, EmpId,ProjectCode,Status);
			
			if (count > 0) {
				redir.addAttribute("result", "Project Forwarded Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Forward Unsuccessful");
			}
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalRtmddoSubmit.htm "+UserId, e);
		}
		return "redirect:/ProjectApprovalRtmddo.htm";
	}

	@RequestMapping(value = "ProjectApprovalTcc.htm", method = RequestMethod.GET)
	public String ProjectApprovalTcc(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectApprovalTcc.htm "+UserId);
		
		try {
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();

		req.setAttribute("ProjectActionList", service.ProjectActionList("4"));
		req.setAttribute("ProjectApproveTccList", service.ProjectApproveTccList(EmpId));
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalTcc.htm "+UserId, e);
		}

		return "project/ProjectApprovalTcc";
	}

	@RequestMapping(value = "ProjectApprovalTccSubmit.htm", method = RequestMethod.POST)
	public String ProjectApprovalTccSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside ProjectApprovalTccSubmit.htm "+UserId);
		
		try {
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		
		String InitiationId = req.getParameter("IntiationId");
		String Remark = req.getParameter("Remark");
		String ProjectCode=req.getParameter("projectcode");
		String Status=req.getParameter("Status");
		String Labcode=req.getParameter("labcode");

		int count = service.ProjectApproveTcc(InitiationId, Remark, UserId, EmpId,ProjectCode,Status,Labcode);
		if (count > 0) {
			redir.addAttribute("result", "Project Forwarded Successfully");
		} else {
			redir.addAttribute("resultfail", "Project Forward Unsuccessful");
		}

		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalTccSubmit.htm "+UserId, e);
		}
		return "redirect:/ProjectApprovalTcc.htm";

	}

	@RequestMapping(value = "TCCAdd.htm", method = RequestMethod.GET)
	public String TCCAdd(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside TCCAdd.htm "+UserId);
		
		try {
		req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside TCCAdd.htm "+UserId, e);
		}

		return "project/TCCAdd";
	}


	@RequestMapping(value = "TCCScheduleAdd.htm", method = RequestMethod.GET)
	public String TCCScheduleAdd(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside TCCScheduleAdd.htm "+UserId);
		return "project/TCCSchedule";
	}


	@RequestMapping(value ="ProjectMain.htm")
	public String ProjectMain(Model model, HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectMain.htm "+Username);
	try {
		String onboard=req.getParameter("Onboarding");
		
		if(onboard==null) {
			Map md=model.asMap();
			onboard=(String)md.get("Onboard");
		}
		req.setAttribute("ProjectMainList", service.ProjectMainList());
		req.setAttribute("Onboarding", onboard);
	}catch (Exception e) {
		e.printStackTrace(); logger.error(new Date() +" Inside ProjectMain.htm "+Username, e);
	}
		return "project/ProjectMainList";
 
	}
	
	@RequestMapping(value = "ProjectMainSubmit.htm")
	public String ProjectMainSubmit(HttpSession ses, HttpServletRequest req, RedirectAttributes redir) throws Exception {
		long count=0;
		long check=0;
		String Username = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectMainSubmit.htm  "+Username);
		try {
			  String sub=req.getParameter("action");
			  
			  if("add".equalsIgnoreCase(sub)) {
				  
				  req.setAttribute("ProjectTypeList", service.PfmsCategoryList());
				  req.setAttribute("SecurityClassificationList",service.ProjectTypeList());
				  req.setAttribute("OfficerList", service.OfficerList());
				  req.setAttribute("SecurityClassificationList",service.ProjectTypeList());
				  return "project/ProjectMainAdd";
			 }
	         if("submit".equalsIgnoreCase(sub) || "save".equalsIgnoreCase(sub)) 
	         {        	 
	     		 String pcode=req.getParameter("pcode");
	     		 String pname=req.getParameter("pname");
	     		 String desc=req.getParameter("desc");
	     		
	     		 String projectdirector=req.getParameter("projectdirector");
	     		 String ProjectsancAuthority=req.getParameter("ProjectsancAuthority");
	     		
	     		 String unicode=req.getParameter("unicode");
	     		 String sano=req.getParameter("sano");
	     		 String sadate=req.getParameter("sadate");
	     		 String tsancost=req.getParameter("tsancost");
	     		 String sancostre=req.getParameter("sancostre");
	     		 String sancostfe=req.getParameter("sancostfe");
	     		 String pdc=req.getParameter("pdc");
	     		 String BOR=req.getParameter("bor");
	     		 String projectType=req.getParameter("projecttype");
	     		 String isMainWC=req.getParameter("ismainwc");
	     		 String WCname=req.getParameter("wcname");
	     		 String Objective=req.getParameter("Objective");
	     		 String Deliverable=req.getParameter("Deliverable");
	     		 String NodalName=req.getParameter("Nodal");
	     		 String securityClassification=req.getParameter("securityClassification");
	     		 String scope=req.getParameter("scope");
	     		 
	     		 
	     		 ProjectMain protype=new ProjectMain();
	     		 protype.setIsMainWC(Integer.parseInt(isMainWC));
				 protype.setWorkCenter(WCname);
	          	 protype.setProjectCode(pcode);
	       	     protype.setProjectName(pname);
	       	     protype.setProjectDescription(desc);
	         	 protype.setUnitCode(unicode);
	         	 protype.setSanctionNo(sano);
	         	 protype.setBoardReference(BOR);
	             protype.setProjectTypeId(Long.parseLong(projectType));
	             protype.setCategoryId(Long.parseLong(securityClassification));
	             protype.setProjectDirector(Long.parseLong(projectdirector));
				 protype.setProjSancAuthority(ProjectsancAuthority);
				 protype.setSanctionDate(new java.sql.Date(sdf2.parse(sadate).getTime()));
				 protype.setTotalSanctionCost(Double.parseDouble(tsancost.trim()));
				 protype.setSanctionCostRE(Double.parseDouble(sancostre.trim()));
				 protype.setScope(scope);
				 
				 if(sancostfe!=null && sancostfe.length() >0)
				 {
					 protype.setSanctionCostFE(Double.parseDouble(sancostfe.trim()));
				 }
				 protype.setPDC(new java.sql.Date(sdf2.parse(pdc).getTime()));
				 protype.setObjective(Objective.trim());
				 protype.setDeliverable(Deliverable.trim());
	             protype.setLabParticipating(NodalName.trim());
				 protype.setRevisionNo(Long.parseLong("0"));
				 protype.setIsActive(1);
	
	       	     protype.setCreatedBy(Username);
	         	 protype.setCreatedDate(sdf1.format(new Date()));
	       	  
	        	
	        	count=service.ProjectMainAdd(protype);
	        	if("submit".equalsIgnoreCase(sub)) {
		        	if(count>0  ) 
		        	{
		        		redir.addAttribute("result","Project Main Added Successfully");
		  			}else
		  			{
		  				redir.addAttribute("resultfail","Project Main Adding  Unsuccessfully");
		  			}
		        	
		        	return "redirect:/ProjectMain.htm";
	        	}
	        	
	        	if("save".equalsIgnoreCase(sub)) {
		        	if(count>0  ) 
		        	{
		        		redir.addAttribute("result","Project Main Saved Successfully");
		        		redir.addAttribute("action","edit");
		        		redir.addAttribute("ProjectMainId",count);
		        		return "redirect:/ProjectMainSubmit.htm";
		  			}else
		  			{
		  				redir.addAttribute("resultfail","Project Main Saved Unsuccessfully");
		  				return "redirect:/Project.htm";
		  			}
	        	}
	        	
			  }
	         if("edit".equalsIgnoreCase(sub)) {
	        	  String ProjectMainId=req.getParameter("ProjectMainId");
	        	  req.setAttribute("ProjectMainId", ProjectMainId);
	        	  req.setAttribute("ProjectTypeList", service.PfmsCategoryList());
				  req.setAttribute("OfficerList", service.OfficerList());
				  req.setAttribute("ProjectMainEditData", service.ProjectMainEditData(ProjectMainId));
				  req.setAttribute("SecurityClassificationList",service.ProjectTypeList());
				  
	        	 return "project/ProjectMainEdit";
			  }
	         if("editsubmit".equalsIgnoreCase(sub)) {
	        	 String ProjectMainId=req.getParameter("ProjectMainId");
	        	 String pcode=req.getParameter("pcode");
	     		 String pname=req.getParameter("pname");
	     		 String desc=req.getParameter("desc");
	     		 String projectdirector=req.getParameter("projectdirector");
	     		 String ProjectsancAuthority=req.getParameter("ProjectsancAuthority");
	     		 String unicode=req.getParameter("unicode");
	     		 String sano=req.getParameter("sano");
	     		 String sadate=req.getParameter("sadate");
	     		 String tsancost=req.getParameter("tsancost");
	     		 String sancostre=req.getParameter("sancostre");
	     		 String sancostfe=req.getParameter("sancostfe");
	     		 String pdc=req.getParameter("pdc");
	     		 String BOR=req.getParameter("bor");
	     		 String projectType=req.getParameter("projecttype");
	     		 String securityClassification=req.getParameter("securityClassification");
	     		 String isMainWC=req.getParameter("ismainwc");
	     		 String WCname=req.getParameter("wcname");
	     		 String Objective=req.getParameter("Objective");
	     		 String Deliverable=req.getParameter("Deliverable");
	     		 String NodalLab=req.getParameter("Nodal");
	     		 String scope=req.getParameter("scope");
	     		
	     		 ProjectMain protype=new ProjectMain();
	     		 protype.setIsMainWC(Integer.parseInt(isMainWC));
				 protype.setWorkCenter(WCname);
	          	 protype.setProjectCode(pcode);
	       	     protype.setProjectName(pname);
	       	     protype.setProjectDescription(desc);
	         	 protype.setUnitCode(unicode);
	         	 protype.setSanctionNo(sano);
	         	 protype.setBoardReference(BOR);
	             protype.setProjectTypeId(Long.parseLong(projectType));
	             protype.setCategoryId(Long.parseLong(securityClassification));
	             protype.setProjectDirector(Long.parseLong(projectdirector));
				 protype.setProjSancAuthority(ProjectsancAuthority);
				 protype.setSanctionDate(new java.sql.Date(sdf2.parse(sadate).getTime()));
				 protype.setTotalSanctionCost(Double.parseDouble(tsancost.trim()));
				 protype.setSanctionCostRE(Double.parseDouble(sancostre.trim()));
				 protype.setScope(scope);
				 if(sancostfe!=null && sancostfe.length() >0)
				 {
					 protype.setSanctionCostFE(Double.parseDouble(sancostfe.trim()));
				 }
				 protype.setPDC(new java.sql.Date(sdf2.parse(pdc).getTime()));
				 protype.setObjective(Objective.trim());
				 protype.setDeliverable(Deliverable.trim());
				 protype.setLabParticipating(NodalLab.trim());
				 protype.setRevisionNo(Long.parseLong("0"));
				 protype.setIsActive(1);
	       	     protype.setModifiedBy(Username);
	         	 protype.setModifiedDate(sdf1.format(new Date()));
	         	 protype.setProjectMainId(Long.parseLong(ProjectMainId));
	       	  
	        	 count=service.ProjectMainEdit(protype);
	        	 if(count>0) {
	  				redir.addAttribute("result","Project Main Edited Successfully");
	  			
	  			}
	  			else
	  			{
	  				redir.addAttribute("resultfail","Project Main Editing  Unsuccessfully");
	  				
	  			}
	        	 
	        	
	        	 return "redirect:/ProjectMain.htm";
			  }
	         if("close".equalsIgnoreCase(sub)) {
	        	 String ProjectMainId=req.getParameter("ProjectMainId");
	        	 ProjectMain protype=new ProjectMain();
	        	 protype.setProjectMainId(Long.parseLong(ProjectMainId));
	        	 protype.setModifiedBy(Username);
	        	 protype.setModifiedDate(sdf1.format(new Date()));
	        	 count=service.ProjectMainClose(protype);
	        	 if(count>0) {
	  				redir.addAttribute("result","Project Closed Successfully");
	  			
	  			}else
	  			{
	  				redir.addAttribute("resultfail","Project Closing  Unsuccessfully");
	  				
	  			}
	         }
		
	}catch (Exception e) {
		e.printStackTrace(); logger.error(new Date() +" Inside ProjectMainSubmit.htm  "+Username, e);
	}
		return "redirect:/ProjectMain.htm";
	}
	
	@RequestMapping(value = "ProjectList.htm")
	public String ProjectList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses.getAttribute("Username");
		String LabCode=(String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectList.htm "+Username);
	try {
		
		req.setAttribute("ProjectList", service.ProjectList().stream().filter(e-> e[14]!=null).filter(e->LabCode.equalsIgnoreCase(e[14].toString())).collect(Collectors.toList()) );
		
	}catch (Exception e) {
		e.printStackTrace(); logger.error(new Date() +" Inside ProjectList.htm "+Username, e);
	}
		return "project/ProjectList";

	}
	
	
	@RequestMapping(value = "ProjectSubmit.htm")
	public String ProjectSubmit(HttpSession ses, HttpServletRequest req, RedirectAttributes redir) throws Exception 
	{
		long count=0;
		
		String Username = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectSubmit.htm "+Username);
		try {      	
		  String sub=req.getParameter("action");
		 
		  if("add".equalsIgnoreCase(sub)) 
		  {
			  
			  req.setAttribute("ProjectMainListNotAdded", service.ProjectTypeMainListNotAdded());
			  req.setAttribute("ProjectTypeMainList", service.ProjectTypeMainList());
			  List<Object[]> ProjectMainList=service.ProjectTypeMainList();
			  List<Object[]> ProjectCatSecDetalis=new ArrayList<>();
			  if(ProjectMainList.size()>0 && ProjectMainList!=null)
			  {
				  ProjectCatSecDetalis=service.getProjectCatSecDetalis(ProjectMainList.get(0)[0].toString());
			  }
			  req.setAttribute("ProjectCatSecDetalis", ProjectCatSecDetalis);
			  req.setAttribute("OfficerList", service.OfficerList().stream().filter(e-> LabCode.equalsIgnoreCase(e[9].toString())).collect(Collectors.toList()));
			  req.setAttribute("CategoryList", service.ProjectCategoryList());
        	  req.setAttribute("ProjectTypeList", service.PfmsCategoryList());
			  return "project/ProjectAdd";
		  }
         if("submit".equalsIgnoreCase(sub)) 
         {
        	 
     		 String pcode=req.getParameter("pcode");
     		 String pname=req.getParameter("pname");
     		 String desc=req.getParameter("desc");
     		
     		 String projectdirector=req.getParameter("projectdirector");
     		 String ProjectsancAuthority=req.getParameter("ProjectsancAuthority");
     		
     		 String unicode=req.getParameter("unicode");
     		 String sano=req.getParameter("sano");
     		 String sadate=req.getParameter("sadate");
     		 String tsancost=req.getParameter("tsancost");
     		 String sancostre=req.getParameter("sancostre");
     		 String sancostfe=req.getParameter("sancostfe");
     		 String pdc=req.getParameter("pdc");
     		 String BOR=req.getParameter("bor");
     		 String projectType=req.getParameter("projecttype");
     		 
     		 String enduser= req.getParameter("enduser");
     		 String projectshortname = req.getParameter("projectshortname");
     		 
//     		 Object[] promaindata=service.ProjectMainEditData(projectType);
//     		 
//     		 String isMainWC=promaindata[16].toString();//req.getParameter("ismainwc");
     		 
     		 String WCname=req.getParameter("wcname");
     		 String Objective=req.getParameter("Objective");
     		 String Deliverable=req.getParameter("Deliverable");
    		 String projectTypeID=req.getParameter("projectTypeID");

     		 ProjectMaster protype=new ProjectMaster();
//     		 protype.setIsMainWC(Integer.parseInt(isMainWC));
     		 protype.setProjectShortName(projectshortname);
     		 protype.setEndUser(enduser);
     		 protype.setIsMainWC(0);
     		 protype.setWorkCenter(WCname);
          	 protype.setProjectCode(pcode);
       	     protype.setProjectName(pname);
       	     protype.setProjectDescription(desc);
         	 protype.setUnitCode(unicode);
         	 protype.setSanctionNo(sano);
         	 protype.setBoardReference(BOR);
             protype.setProjectMainId(Long.parseLong(projectType));
             protype.setProjectDirector(Long.parseLong(projectdirector));
             protype.setProjectCategory(Long.parseLong(req.getParameter("projectcategory")));
             protype.setProjectType(Long.parseLong(projectTypeID));
			 protype.setProjSancAuthority(ProjectsancAuthority);
			 protype.setSanctionDate(new java.sql.Date(sdf2.parse(sadate).getTime()));
			 protype.setTotalSanctionCost(Double.parseDouble(tsancost.trim()));
			 protype.setSanctionCostRE(Double.parseDouble(sancostre.trim()));
			 if(sancostfe!=null && sancostfe.length() >0)
			  {
			 protype.setSanctionCostFE(Double.parseDouble(sancostfe.trim()));
			  }
			 protype.setPDC(new java.sql.Date(sdf2.parse(pdc).getTime()));
			 protype.setObjective(Objective.trim());
			 protype.setDeliverable(Deliverable.trim());
			 protype.setRevisionNo(Long.parseLong("0"));
			 protype.setIsActive(1);
       	     protype.setCreatedBy(Username);
         	 protype.setCreatedDate(sdf1.format(new Date()));
         	 protype.setLabCode(LabCode);
        	
        	 count=service.ProjectMasterAdd(protype);
        	 if(count>0) {
  				redir.addAttribute("result","Project  Added Successfully");
  			}else
  			{
  				redir.addAttribute("resultfail","Project  Adding  Unsuccessfully");
  			}
        	 
        	
        	 return "redirect:/ProjectList.htm";
		  }
         if("edit".equalsIgnoreCase(sub)) {
        	 String ProjectId=req.getParameter("ProjectId");
        	 req.setAttribute("ProjectId", ProjectId);
       	     req.setAttribute("ProjectTypeMainList", service.ProjectTypeMainList());
			 req.setAttribute("OfficerList", service.OfficerList());
			 req.setAttribute("CategoryList", service.ProjectCategoryList());
			 req.setAttribute("ProjectEditData", service.ProjectEditData1(ProjectId));
        	 req.setAttribute("ProjectTypeList", service.PfmsCategoryList());
        	  
        	  
        	 return "project/ProjectEdit";
		  }else if("editsubmit".equalsIgnoreCase(sub)) {
        	 String ProjectId=req.getParameter("ProjectId");
        	 String pcode=req.getParameter("pcode");
     		 String pname=req.getParameter("pname");
     		 String desc=req.getParameter("desc");
     		
     		 String projectdirector=req.getParameter("projectdirector");
     		 String ProjectsancAuthority=req.getParameter("ProjectsancAuthority");
     		
     		 String enduser= req.getParameter("enduser");
     		 String projectshortname = req.getParameter("projectshortname");
     		 
     		 String unicode=req.getParameter("unicode");
     		 String sano=req.getParameter("sano");
     		 String sadate=req.getParameter("sadate");
     		 String tsancost=req.getParameter("tsancost");
     		 String sancostre=req.getParameter("sancostre");
     		 String sancostfe=req.getParameter("sancostfe");
     		 String pdc=req.getParameter("pdc");
     		 String BOR=req.getParameter("bor");
     		 String projectType=req.getParameter("projecttype");
     		 String isMainWC=req.getParameter("ismainwc");
     		 String WCname=req.getParameter("wcname");
     		 String Objective=req.getParameter("Objective");
     		 String Deliverable=req.getParameter("Deliverable");
     		 String projectTypeID=req.getParameter("projectTypeID");
     		 ProjectMaster protype=new ProjectMaster();
//     		 protype.setIsMainWC(Integer.parseInt(isMainWC));
//			 protype.setWorkCenter(WCname);
     		 protype.setProjectShortName(projectshortname);
     		 protype.setEndUser(enduser);
          	 protype.setProjectCode(pcode);
       	     protype.setProjectName(pname);
       	     protype.setProjectDescription(desc);
         	 protype.setUnitCode(unicode);
         	 protype.setSanctionNo(sano);
         	 protype.setBoardReference(BOR);
             protype.setProjectMainId(Long.parseLong(projectType));
             protype.setProjectDirector(Long.parseLong(projectdirector));
             protype.setProjectCategory(Long.parseLong(req.getParameter("projectcategory")));
             protype.setProjectType(Long.parseLong(projectTypeID));
			 protype.setProjSancAuthority(ProjectsancAuthority);
			 protype.setSanctionDate(new java.sql.Date(sdf2.parse(sadate).getTime()));
			 protype.setTotalSanctionCost(Double.parseDouble(tsancost.trim()));
			 protype.setSanctionCostRE(Double.parseDouble(sancostre.trim()));
			 if(sancostfe!=null && sancostfe.length() >0)
			  {
			 protype.setSanctionCostFE(Double.parseDouble(sancostfe.trim()));
			  }
			 protype.setPDC(new java.sql.Date(sdf2.parse(pdc).getTime()));
			 protype.setObjective(Objective.trim());
			 protype.setDeliverable(Deliverable.trim());
			 protype.setRevisionNo(Long.parseLong("0"));
			 protype.setIsActive(1);
			 protype.setModifiedBy(Username);
         	 protype.setModifiedDate(sdf1.format(new Date()));
         	 protype.setProjectId(Long.parseLong(ProjectId));
        	 count=service.ProjectEdit(protype);
        	 if(count>0) {
  				redir.addAttribute("result","Project  Edited Successfully");
	  		}else
	  		{
	  			redir.addAttribute("resultfail","Project Editing  Unsuccessfully");
	  		}       	
        	 return "redirect:/ProjectList.htm";
		  }
         
         if("close".equalsIgnoreCase(sub)) {
        	 String ProjectId=req.getParameter("ProjectId");
        	 String ProjectType=req.getParameter("ProjectType");
        	 ProjectMaster protype=new ProjectMaster();
        	 protype.setProjectId(Long.parseLong(ProjectId));
        	 protype.setModifiedBy(Username);
        	 protype.setModifiedDate(sdf1.format(new Date()));
        	 count=service.ProjectClose(protype);
        	 if(count>0) {
  				redir.addAttribute("result","Project Closed Successfully");
  			
  			}else
  			{
  				redir.addAttribute("resultfail","Project Closing  Unsuccessfully");
  				
  			}
        	 	 return "redirect:/ProjectList.htm";
		  }else if("mainaddsubmit".equalsIgnoreCase(sub))
		  {
			  String projectmainid=req.getParameter("projectmainid");
			  
			  count=0;
			  count=service.ProjectMainToMaster(projectmainid, Username,LabCode);
			  if(count>0) {
	  				redir.addAttribute("result","Project Added Successfully");
	  			
	  			}else
	  			{
	  				redir.addAttribute("resultfail","Project Added Unsuccessfully");
	  			}
		  }
		
	}catch (Exception e) {
		
		e.printStackTrace(); logger.error(new Date() +" Inside ProjectSubmit.htm "+Username, e);
	}
		return "redirect:/ProjectList.htm";
	}
	
	@RequestMapping(value = "ProjectAssign.htm")
	public String ProjectAssign(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String Username = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		logger.info(new Date() +"Inside ProjectAssign.htm "+Username);
	try {
		return "redirect:/ProjectProSubmit.htm";
	}catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date() +" Inside ProjectAssign.htm "+Username, e);
		return "ststic/Error";
	}
		
	}
	
	
	@RequestMapping(value = "ProjectProSubmit.htm",method ={RequestMethod.POST,RequestMethod.GET})
	public String ProjectEmpSubmit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {

		String Username = (String) ses .getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		String ProjectId=null; 
		logger.info(new Date() +"Inside ProjectProSubmit.htm "+Username);
		try {
		if(req.getParameter("ProjectId")!=null) {

			ProjectId=(String)req.getParameter("ProjectId");
		}else {
	
		 Map md = model.asMap();
		    for (Object modelKey : md.keySet()) {
		    	String	RedirData = (String) md.get(modelKey);
		    	ProjectId=RedirData;
		    }
		}
		List<Object[]> ProjectList = service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
		if(ProjectId==null) {
	
			ProjectId=ProjectList.get(0)[0].toString();
		}

		req.setAttribute("ProjectAssignList", service.ProjectAssignList(ProjectId));
		req.setAttribute("ProjectList", ProjectList);
		req.setAttribute("OfficerList", service.UserList(ProjectId).stream().filter(e->e[2]!=null ).filter(e-> LabCode.equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()));
		req.setAttribute("ProjectCode", service.ProjectData(ProjectId));
		req.setAttribute("ProjectId", ProjectId);
	}catch (Exception e) {
     
		e.printStackTrace(); logger.error(new Date() +" Inside ProjectProSubmit.htm "+Username, e);
	}
		return "project/ProjectAssign";

	}
	
	@RequestMapping(value = "ProjectAssignSubmit.htm", method = RequestMethod.POST)
	public String ProjectAssignSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		long count=0;
		String Username = (String) ses .getAttribute("Username");
		String ProjectId= req.getParameter("ProjectId");
		String EmpId[]= req.getParameterValues("EmpId");
		ProjectAssignDto proAssigndto=new ProjectAssignDto();
		logger.info(new Date() +"Inside ProjectAssignSubmit.htm "+Username);
	try {
		
		proAssigndto.setProjectId(ProjectId);
		proAssigndto.setCreatedBy(Username);
		proAssigndto.setCreatedDate(sdf1.format(new Date()));
		proAssigndto.setEmpId(EmpId);
    	count=service.ProjectAssignAdd(proAssigndto);
    	 if(count>0) {
				redir.addAttribute("result","Project Assigned Successfully");
			}else
			{
				redir.addAttribute("resultfail","Project Assign  Unsuccessfully");
			} 
    	 
    	 redir.addFlashAttribute("ProjectId", req.getParameter("ProjectId"));
	}catch (Exception e) {
		e.printStackTrace(); 
		logger.error(new Date() +" Inside ProjectAssignSubmit.htm "+Username, e);
	}
		return "redirect:/ProjectProSubmit.htm";
	}
	
	@RequestMapping(value = "ProjectRevokeSubmit.htm", method = RequestMethod.POST)
	public String ProjectRevokeSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		long count=0;
		String Username = (String) ses .getAttribute("Username");
		String ProjectEmployeeId= (String)req.getParameter("ProjectEmployeeId");
		ProjectAssign proAssign=new ProjectAssign();
		logger.info(new Date() +"Inside ProjectRevokeSubmit.htm "+Username);
	try {
		
		proAssign.setProjectEmployeeId(Long.parseLong(ProjectEmployeeId));
		proAssign.setModifiedBy(Username);
		proAssign.setModifiedDate(sdf1.format(new Date()));
		proAssign.setIsActive(0);
    	 count=service.ProjectRevoke(proAssign);
    	 if(count>0) {
				redir.addAttribute("result","Project Revoked Successfully");
			}else
			{
				redir.addAttribute("resultfail","Project Revoke  Unsuccessfully");
			}
    	 
    	 redir.addFlashAttribute("ProjectId", req.getParameter("ProjectId"));
	}catch (Exception e) {
		e.printStackTrace(); logger.error(new Date() +" Inside ProjectRevokeSubmit.htm "+Username, e);
	}
	return "redirect:/ProjectProSubmit.htm";

	}
	

	

	@RequestMapping(value = "ApprovalStatusList.htm", method = RequestMethod.GET)
	public @ResponseBody String ApprovalStatusList(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		List<Object[]> StatusList =null;
		logger.info(new Date() +"Inside ApprovalStatusList.htm "+UserId);
		
		try {

			StatusList = service.ApprovalStutusList(req.getParameter("InitiationId"));
		}catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ApprovalStatusList.htm "+UserId, e);
		}
		Gson json = new Gson();
		return json.toJson(StatusList);

	}
	
	
	@RequestMapping(value = "ProjectData.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ProjectData(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LoginType=(String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectData.htm "+Username);
		try 
		{
			String projectid=req.getParameter("projectid");	
			
			if(projectid==null)
			{
				Map md=model.asMap();
				projectid=(String)md.get("projectid");				
			}	
			List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,LoginType,LabCode);
			
			  if(projectlist.size()==0) 
		        {				
					redir.addAttribute("resultfail", "No Project is Assigned to you.");
					return "redirect:/MainDashBoard.htm";
				}
			
			
			if(projectid==null) 
			{
				projectid=projectlist.get(0)[0].toString();
			}
			Object[] projectdatadetails=service.ProjectDataDetails(projectid);
			
			if(projectdatadetails!=null && projectdatadetails.length>0)
			{
//				String configimgb64;
//				try
//				{
//					configimgb64 = Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[3])));
//				}catch (FileNotFoundException e) {
//					configimgb64=null;
//				}
//				String producttree;
//				
//				try
//				{
//						producttree=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[5])));
//				}catch (FileNotFoundException e) {
//					producttree=null;
//				}
//				String pearlimg;
//				try
//				{
//					pearlimg=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[6])));
//				}catch (FileNotFoundException e) {
//					pearlimg=null;
//				}
				
//				req.setAttribute("configimgb64", configimgb64);
//				req.setAttribute("producttree", producttree);
//				req.setAttribute("pearlimg", pearlimg);
				
				req.setAttribute("projectdatadetails", projectdatadetails);
				req.setAttribute("projectstagelist", service.ProjectStageDetailsList());
				req.setAttribute("projectid", projectid);
				req.setAttribute("projectlist", projectlist);
				req.setAttribute("filesize",file_size);
				return "project/ProjectDataView" ;
			}
								
			req.setAttribute("projectstagelist", service.ProjectStageDetailsList());
			req.setAttribute("projectid", projectid);
			req.setAttribute("projectlist", projectlist);
			req.setAttribute("filesize",file_size);
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ProjectData.htm "+Username, e);
			return "static/Error";
		}
		return "project/ProjectDataCollect";		
	}
	
	
	
	@RequestMapping(value = "ProjectDataSubmit.htm", method = RequestMethod.POST)
	public String ProjectDataSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestParam(name = "systemconfig" ,required = false) MultipartFile systemconfigimg,
			@RequestParam(name ="systemspecsfile" ,required = false) MultipartFile systemspecsfile,
			@RequestParam(name ="producttreeimg" ,required = false) MultipartFile producttreeimg,
			@RequestParam(name ="pearlimg",required = false) MultipartFile pearlimg)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectDataSubmit.htm "+Username);
		try 
		{								
			String projectid=req.getParameter("projectid");
			String proclimit = req.getParameter("proclimit");
			String pmrcdate=req.getParameter("pmrcdate");
			String ebdate=	req.getParameter("ebdate");
			PfmsProjectDataDto projectdatadto=new PfmsProjectDataDto();
			
			projectdatadto.setProjectId(projectid);
			projectdatadto.setSystemConfigImg(systemconfigimg);
			projectdatadto.setSystemSpecsFile(systemspecsfile);
			projectdatadto.setProductTreeImg(producttreeimg);
			projectdatadto.setPEARLImg(pearlimg);
			projectdatadto.setProcLimit(proclimit);
			projectdatadto.setCurrentStageId(req.getParameter("projectstageid"));
			projectdatadto.setLastPmrcDate(new java.sql.Date(sdf2.parse(pmrcdate).getTime()));
			projectdatadto.setLastEBDate(new java.sql.Date(sdf2.parse(ebdate).getTime()));
			
			projectdatadto.setCreatedBy(Username);
			projectdatadto.setLabcode(LabCode);
//			String fileName = producttreeimg.getOriginalFilename();
//			String prefix = fileName.substring(fileName.lastIndexOf("."));
//			 
//			File file = null;
//			try {
//			 
//			     file = File.createTempFile(fileName, prefix);
//			     producttreeimg.transferTo(file);
//			} catch (Exception e) {
//			     e.printStackTrace();
//			            
//			}
//			
//			
//			BufferedImage bimg = ImageIO.read(file);
//			int width          = bimg.getWidth();
//			int height         = bimg.getHeight();
//			
			
			long count=service.ProjectDataSubmit(projectdatadto);
			
			if(count>0) 
			{
				redir.addAttribute("result","Project Data Added Successfully");
			}
			else
			{
				redir.addAttribute("resultfail","Project Data adding  Unsuccessful");
			}
			
			redir.addFlashAttribute("projectid",projectid);
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectDataSubmit.htm "+Username, e);
		}
		return "redirect:/ProjectData.htm";
		
	}
	
	
	
	@RequestMapping(value = {"ProjectDataSystemSpecsFileDownload.htm"})
	public void ProjectDataSystemSpecsFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectDataSystemSpecsFileDownload.htm "+UserId);
		try
		{
			String ftype=req.getParameter("filename");
			String projectdataid=req.getParameter("projectdataid");
			res.setContentType("Application/octet-stream");	
			Object[] projectdatafiledata=service.ProjectDataSpecsFileData(projectdataid);
			File my_file=null;
			int index=3;
			if(ftype.equalsIgnoreCase("sysconfig")) 
			{
				index=4;
			}else if(ftype.equalsIgnoreCase("protree"))
			{
				index=5;
			}else if(ftype.equalsIgnoreCase("pearl"))
			{
				index=6;
			}else if(ftype.equalsIgnoreCase("sysspecs"))
			{
				index=3;
			}
		
			my_file = new File(uploadpath+projectdatafiledata[2]+File.separator+projectdatafiledata[index]); 
	        res.setHeader("Content-disposition","attachment; filename="+projectdatafiledata[index].toString()); 
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
				logger.error(new Date() +"Inside ProjectDataSystemSpecsFileDownload.htm "+UserId,e);
		}
	}
	@RequestMapping(value = "ProjectDataEditSubmit.htm", method = RequestMethod.POST)
	public String ProjectDataEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestParam(name = "systemconfig" ,required = false) MultipartFile systemconfigimg,
			@RequestParam(name ="systemspecsfile" ,required = false) MultipartFile systemspecsfile,
			@RequestParam(name ="producttreeimg" ,required = false) MultipartFile producttreeimg,
			@RequestParam(name ="pearlimg",required = false) MultipartFile pearlimg)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectDataEditSubmit.htm "+Username);
		try 
		{		
			long count=0;
			
			String rev=req.getParameter("rev");
			String proclimit = req.getParameter("proclimit");
			String projectid=req.getParameter("projectid");
			String revisionno=req.getParameter("revisionno");
			String pmrcdate=req.getParameter("pmrcdate");
			String ebdate=req.getParameter("ebdate");
			PfmsProjectDataDto projectdatadto=new PfmsProjectDataDto();
			projectdatadto.setProjectDataId(req.getParameter("projectdataid"));
			projectdatadto.setProjectId(projectid);
			projectdatadto.setSystemConfigImg(systemconfigimg);			
			projectdatadto.setSystemSpecsFile(systemspecsfile);
			projectdatadto.setProductTreeImg(producttreeimg);
			projectdatadto.setPEARLImg(pearlimg);
			projectdatadto.setCurrentStageId(req.getParameter("projectstageid"));
			projectdatadto.setProcLimit(proclimit);
			projectdatadto.setLastPmrcDate(new java.sql.Date(sdf2.parse(pmrcdate).getTime()));
			projectdatadto.setLastEBDate(new java.sql.Date(sdf2.parse(ebdate).getTime()));
		
		
			projectdatadto.setModifiedBy(Username);
			if(rev!=null && rev.equals("1"))
			{
				revisionno=String.valueOf(Long.parseLong(revisionno)+1);
				service.ProjectDataRevSubmit(projectdatadto);
			}
			projectdatadto.setRevisionNo(revisionno);
			projectdatadto.setLabcode(LabCode);
			count=service.ProjectDataEditSubmit(projectdatadto);
			
			if(count>0) 
			{	if(rev!=null && rev.equals("1"))
				{
					redir.addAttribute("result","Project Data Revised Successfully");
				}else {
					redir.addAttribute("result","Project Data Updated Successfully");
				}
			}
			else
			{
				if(rev!=null && rev.equals("1"))
				{
					redir.addAttribute("resultfail","Project Data Revised  Unsuccessfully");
				}else {
					redir.addAttribute("resultfail","Project Data Update  Unsuccessfully");
				}
			}
			
			redir.addFlashAttribute("projectid",projectid);
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectDataEditSubmit.htm "+Username, e);
		}
		return "redirect:/ProjectData.htm";
		
	}
	@RequestMapping(value = "ProjectDataRevList.htm", method = RequestMethod.POST)
	public String ProjectDataRevSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LoginType=(String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectDataRevList.htm "+Username);
		try 
		{			
			String projectid=req.getParameter("projectid");
			String projectdatarevid=req.getParameter("projectdatarevid");
			List<Object[]> ProjectDataRevList = service.ProjectDataRevList(projectid);
			Object[] ProjectDataRevDataRaw=null;
			if(projectdatarevid==null && ProjectDataRevList.size()>0)
			{
				projectdatarevid =ProjectDataRevList.get(0)[0].toString();
			}
			if( ProjectDataRevList.size()>0) 
			{				
				ProjectDataRevDataRaw=service.ProjectDataRevData(projectdatarevid);
			}
			
			
			String[] projectdatarevdata=new String[6];
			if(ProjectDataRevDataRaw!=null)
			{
//				try {
//					projectdatarevdata[0]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ProjectDataRevDataRaw[2]+File.separator+ProjectDataRevDataRaw[3])));
//				}catch (FileNotFoundException e) {
//					projectdatarevdata[0]=null;
//				}
//				try {
//					projectdatarevdata[1]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ProjectDataRevDataRaw[2]+File.separator+ProjectDataRevDataRaw[5])));;
//				}catch (FileNotFoundException e) {
//					projectdatarevdata[1]=null;
//				}
//				
//				try {
//					projectdatarevdata[2]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ProjectDataRevDataRaw[2]+File.separator+ProjectDataRevDataRaw[6])));;
//				}catch (FileNotFoundException e) {
//					projectdatarevdata[2]=null;
//				}
				projectdatarevdata[3]=ProjectDataRevDataRaw[0].toString();
				projectdatarevdata[4]=sdf2.format(sdf3.parse(ProjectDataRevDataRaw[11].toString()));	
				projectdatarevdata[5]=	ProjectDataRevDataRaw[10].toString();
			}
			req.setAttribute("projectdatarevid",projectdatarevid);
			req.setAttribute("projectdatarevlist",ProjectDataRevList);
			req.setAttribute("projectdatarevdata", projectdatarevdata);
			req.setAttribute("projectlist",service.LoginProjectDetailsList(EmpId,LoginType,LabCode));
			req.setAttribute("projectid", projectid);
			return "project/ProjectDataRevView";
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectDataRevList.htm "+Username, e);
			return "static/Error";
		}
		
		
	}
	
	

	
	@RequestMapping(value = "ProjectRisk.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ProjectRisk(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectRisk.htm "+Username);
		try 
		{			
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String Logintype= (String)ses.getAttribute("LoginType");
			String projectid=req.getParameter("projectid");	
			if(projectid==null)
			{
				Map md=model.asMap();
				projectid=(String)md.get("projectid");				
			}	
			List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
			
			if(projectlist.size()==0) 
		    {	
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return 	"redirect:/MainDashBoard.htm";
			}
			
			
			if(projectid==null) 
			{
				projectid="0";
			}
			
			List<Object[]> riskdatalist=service.ProjectRiskDataList(projectid, LabCode);
			
			req.setAttribute("riskdatapresentlist",service.RiskDataPresentList(projectid,LabCode));
			req.setAttribute("riskdatalist", riskdatalist);
			req.setAttribute("projectid", projectid);
			req.setAttribute("projectlist", projectlist);
			
			return "project/ProjectRisk";
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectRisk.htm "+Username, e);
			return "static/Error";
		}	
	}
	
	
	@RequestMapping(value = "ProjectRiskData.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ProjectRiskDate(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		
		logger.info(new Date() +"Inside ProjectRiskData.htm "+Username);
		try 
		{
			String actionmainid=req.getParameter("actionmainid");
			if(actionmainid==null)
			{
				Map md=model.asMap();
				actionmainid=(String)md.get("actionmainid");				
			}
			List<Object[]> projectlist=service.getProjectList();
				
			Object[] riskdata=service.ProjectRiskData(actionmainid);
			String projectid=riskdata[2].toString();
			
			req.setAttribute("projectriskmatrixrevlist",service.ProjectRiskMatrixRevList(actionmainid));
			req.setAttribute("riskmatrixdata",service.ProjectRiskMatrixData(actionmainid));
			req.setAttribute("risktypelist",service.RiskTypeList());
			req.setAttribute("riskdata", riskdata);
			req.setAttribute("projectid", projectid);
			req.setAttribute("projectlist", projectlist);
			
			return "project/ProjectRiskData";
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectRiskData.htm "+Username, e);
			return "static/Error";
		}
	}
	
	
	@RequestMapping(value = "ProjectRiskDataSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ProjectRiskDataSubmit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectRiskDataSubmit.htm "+Username);
		try 
		{						
			String actionmainid=req.getParameter("actionmainid");			
			Object[] riskdata=service.ProjectRiskData(actionmainid);
			String projectid=riskdata[2].toString();
			
			PfmsRiskDto dto=new PfmsRiskDto();
			
			dto.setDescription(riskdata[1].toString());
			dto.setSeverity(req.getParameter("severity"));
			dto.setProbability(req.getParameter("probability"));
			dto.setMitigationPlans(req.getParameter("mitigationplans"));
			dto.setImpact(req.getParameter("Impact"));
			dto.setCategory(req.getParameter("category"));
			dto.setRiskTypeId(req.getParameter("risk_type"));
			dto.setActionMainId(riskdata[0].toString());
			dto.setProjectId(projectid);
			dto.setCreatedBy(Username);		
			dto.setLabCode(LabCode);
			long count=service.ProjectRiskDataSubmit(dto);
			
			if(count>0) 
			{
				redir.addAttribute("result","Project Risk Data Added Successfully");
			}
			else
			{
				redir.addAttribute("resultfail","Project Risk Data Adding Unsuccessfully");
			}		
			redir.addFlashAttribute("actionmainid", actionmainid);			
			return "redirect:/ProjectRiskData.htm";
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectRiskDataSubmit.htm "+Username, e);
			return "static/Error";
		}
	}
	
	
	
	@RequestMapping(value = "ProjectRiskDataEdit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ProjectRiskDataEdit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		logger.info(new Date() +"Inside ProjectRiskDataEdit.htm "+Username);
		try 
		{						
			String actionmainid=req.getParameter("actionmainid");			
			Object[] riskdata=service.ProjectRiskData(actionmainid);
			String projectid=riskdata[2].toString();
			String rev=req.getParameter("rev");
			String revisionno=req.getParameter("revisionno");
			
			PfmsRiskDto dto=new PfmsRiskDto();
			dto.setRiskId(req.getParameter("riskid"));
			dto.setDescription(riskdata[1].toString());
			dto.setSeverity(req.getParameter("severity"));
			dto.setProbability(req.getParameter("probability"));
			dto.setMitigationPlans(req.getParameter("mitigationplans"));
			dto.setImpact(req.getParameter("Impact"));
			dto.setCategory(req.getParameter("category"));
			dto.setRiskTypeId(req.getParameter("risk_type"));
			dto.setActionMainId(riskdata[0].toString());			
			dto.setProjectId(projectid);
			dto.setModifiedBy(Username);			
			
			if(rev!=null && rev.equals("1"))
			{
				revisionno=String.valueOf(Long.parseLong(revisionno)+1);
				service.ProjectRiskDataRevSubmit(dto);
			}
			dto.setRevisionNo(revisionno);
			long count=service.ProjectRiskDataEdit(dto);
			
			if(count>0) 
			{
				if(rev!=null && rev.equals("1"))
				{
					redir.addAttribute("result","Project Risk Data Revised Successfully");
				}else {
					redir.addAttribute("result","Project Risk Data Edited Successfully");
				}
			}
			else
			{
				if(rev!=null && rev.equals("1"))
				{
					redir.addAttribute("resultfail","Project Risk Data Revision Unsuccessfully");
				}else {
					redir.addAttribute("resultfail","Project Risk Data Editing Unsuccessfully");
				}
			}
			
		
			redir.addFlashAttribute("actionmainid", actionmainid);
			
			
			return "redirect:/ProjectRiskData.htm";
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectRiskDataEdit.htm "+Username, e);
			return "static/Error";
		}	
		
	}
	
	
	@RequestMapping(value = "projectCatSencDetalis", method = RequestMethod.GET)
	public @ResponseBody String getCompEmp(HttpServletRequest request,HttpSession ses) throws Exception {
		String Username = (String) ses .getAttribute("Username");
		logger.info(new Date() +"Inside projectCatSencDetalis "+Username);
	   String companyId=request.getParameter("project");
	   List<Object[]> ProjectCatSecDetalis=new ArrayList<>();
       ProjectCatSecDetalis=service.getProjectCatSecDetalis(companyId);
	   Gson json = new Gson();
	   
	   return json.toJson(ProjectCatSecDetalis);
	}
	
	
	@RequestMapping(value = "ProjectMasterRev.htm", method = {RequestMethod.POST})
	public String ProjectMasterRevisison(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		logger.info(new Date() +"Inside ProjectMasterRev.htm "+Username);
		try 
		{	
			String projectid=req.getParameter("ProjectId");
			req.setAttribute("projectid", projectid);
			req.setAttribute("ProjectTypeMainList", service.ProjectTypeMainList());
			req.setAttribute("OfficerList", service.OfficerList());
			req.setAttribute("CategoryList", service.ProjectCategoryList());
			req.setAttribute("ProjectEditData", service.ProjectEditData1(projectid));
			req.setAttribute("ProjectTypeList", service.PfmsCategoryList());
			return "project/ProjectMasterRev";
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectMasterRev.htm "+Username, e);
			return "static/Error";
		}	
		
	}
	 
	@RequestMapping(value = "ProjectMasterRevSubmit.htm", method = {RequestMethod.POST})
	public String ProjectMasterRevSubmit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		logger.info(new Date() +"Inside ProjectMasterRevSubmit.htm "+Username);
		try 
		{	
			
			String ProjectId=req.getParameter("projectid");
			String pcode=req.getParameter("pcode");
			String pname=req.getParameter("pname");
			String desc=req.getParameter("desc");
			
			String ProjectMainId=req.getParameter("ProjectMainId");
			String projectdirector=req.getParameter("projectdirector");
			String ProjectsancAuthority=req.getParameter("ProjectsancAuthority");
			String unicode=req.getParameter("unicode");
			String sano=req.getParameter("sano");
			String sadate=req.getParameter("sadate");
			String tsancost=req.getParameter("tsancost");
			String sancostre=req.getParameter("sancostre");
			String sancostfe=req.getParameter("sancostfe");
			String pdc=req.getParameter("pdc");
			String BOR=req.getParameter("bor");
			
			String projectshortcode = req.getParameter("projectshortname");
			String enduser = req.getParameter("enduser");
			
//			String projectType=req.getParameter("projecttype");
//			String isMainWC=req.getParameter("ismainwc");
//			String WCname=req.getParameter("wcname");
			String Objective=req.getParameter("Objective");
			String Deliverable=req.getParameter("Deliverable");
			String projectTypeID=req.getParameter("projectTypeID");
			ProjectMaster protype=new ProjectMaster();
		//	 protype.setIsMainWC(Integer.parseInt(isMainWC));
		//	 protype.setWorkCenter(WCname);
		 	protype.setProjectCode(pcode);
			protype.setProjectName(pname);
			protype.setProjectDescription(desc);
			protype.setUnitCode(unicode);
			protype.setSanctionNo(sano);
			protype.setBoardReference(BOR);
			protype.setProjectMainId(Long.parseLong(ProjectMainId));
			protype.setProjectDirector(Long.parseLong(projectdirector));
			protype.setProjectCategory(Long.parseLong(req.getParameter("projectcategory")));
			protype.setProjectType(Long.parseLong(projectTypeID));
			protype.setProjSancAuthority(ProjectsancAuthority);
			protype.setSanctionDate(new java.sql.Date(sdf2.parse(sadate).getTime()));
			protype.setTotalSanctionCost(Double.parseDouble(tsancost.trim()));
			protype.setSanctionCostRE(Double.parseDouble(sancostre.trim()));
			if(sancostfe!=null && sancostfe.length() >0)
			{
			protype.setSanctionCostFE(Double.parseDouble(sancostfe.trim()));
			}
			protype.setPDC(new java.sql.Date(sdf2.parse(pdc).getTime()));
			protype.setObjective(Objective.trim());
			protype.setDeliverable(Deliverable.trim());
			protype.setProjectShortName(projectshortcode);
			protype.setEndUser(enduser);
						
			protype.setIsActive(1);
			protype.setModifiedBy(Username);
			protype.setModifiedDate(sdf1.format(new Date()));
			protype.setProjectId(Long.parseLong(ProjectId));
			
			ProjectMasterRev rev = service.ProjectMasterREVSubmit(ProjectId, Username,req.getParameter("remarks"));
			long count=0;
			if(rev.getProjectRevId() >0) {
				 protype.setRevisionNo(rev.getRevisionNo()+1); 
				 count=service.ProjectEdit(protype);
			}
			if(count>0) 
			{
				redir.addAttribute("result","Project  Revision Successfully");
			}else
			{
				redir.addAttribute("resultfail","Project Revision  Unsuccessfully");
			}       	
			return "redirect:/ProjectList.htm";
 
	 
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectMasterRevSubmit.htm "+Username, e);
			return "static/Error";
		}	
	}
	
	
	@RequestMapping(value = "ProjectMasterRevView.htm")
	public String ProjectMasterRevView(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String Username = (String) ses .getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectMasterRevView.htm "+Username);
		try 
		{	
			String projectid=req.getParameter("ProjectId");
			req.setAttribute("projectid", projectid);
			req.setAttribute("projectslist", service.LoginProjectDetailsList(EmpId,Logintype,LabCode));			
			req.setAttribute("ProjectMasterRevList", service.ProjectRevList(projectid));
			return "project/ProjectMasterRevView";
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectMasterRevView.htm "+Username, e);
			return "static/Error";
		}	
		
	}
	
	
	@RequestMapping(value = "ProjectMasterAttach.htm", method = {RequestMethod.POST,RequestMethod.GET} )
	public String ProjectMasterAttach(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{		
		String Username = (String) ses .getAttribute("Username");
		logger.info(new Date() +"Inside ProjectMasterAttach.htm "+Username);
		try 
		{	
			String projectid = req.getParameter("ProjectId");
			
			if(projectid==null) {
				Map md=model.asMap();
				projectid=(String)md.get("ProjectId");
			}	
			
			if(projectid==null) {
				return "redirect:/ProjectList.htm";
			}
			
			Object[] projectdata=service.ProjectData(projectid);
			
			
			req.setAttribute("AttachList",service.ProjectMasterAttachList(projectid));
			req.setAttribute("filesize", file_size);
			req.setAttribute("projectid", projectid);
			req.setAttribute("projectdata", projectdata);
			return "project/ProjectAttachments";
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +" Inside ProjectMasterAttach.htm "+Username, e);
			return "static/Error";
		}	
	}
	
	
	
	@RequestMapping(value = "ProjectMasterAttachAdd.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public String ProjectMasterAttachAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,	@RequestPart("attachment") MultipartFile[] FileAttach) throws Exception 
	{

		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectMasterAttachAdd.htm "+UserId);
		
		try {
			String filenames[] = req.getParameterValues("filename");
			String ProjectId = req.getParameter("ProjectId");			
			
			ProjectMasterAttachDto dto= new ProjectMasterAttachDto();  
			
			dto.setProjectId(ProjectId);
			dto.setFileName(filenames);
			dto.setFiles(FileAttach);
			dto.setCreatedBy(UserId);
			dto.setLabCode(LabCode);
			
			
			long count=service.ProjectMasterAttachAdd(dto);
			
			if (count > 0) {
				redir.addAttribute("result", "Project Attachment(s) Upload Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Attachment(s) Upload Unsuccessful");
			}
			
			redir.addFlashAttribute("ProjectId", ProjectId);
			return "redirect:/ProjectMasterAttach.htm";
		}
		catch (Exception e) 
		{
			logger.error(new Date() +" Inside ProjectMasterAttachAdd.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "ProjectMasterAttachDownload.htm", method = {RequestMethod.POST,RequestMethod.GET} )
	public void ProjectMasterAttachDownload(HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception
	{	
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectMasterAttachDownload.htm "+UserId);
		try
		{
			String attachid=req.getParameter("attachid");
			
			Object[] attachmentdata=service.ProjectMasterAttachData(attachid);
			
			File my_file=null;
			my_file = new File(uploadpath+ attachmentdata[2]+File.separator+attachmentdata[3]);
			
			res.setContentType("Application/octet-stream");	
	        res.setHeader("Content-disposition","attachment; filename="+attachmentdata[3].toString()); 
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
		}catch 
		(Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside ProjectMasterAttachDownload.htm "+UserId,e);
		}
	}
	
	@RequestMapping(value = "ProjectMasterAttachDelete.htm", method = {RequestMethod.POST,RequestMethod.GET} )
	public String ProjectMasterAttachDelete(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
	{	
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectMasterAttachDelete.htm "+UserId);
		try
		{
			String attachid=req.getParameter("attachid");
			String projectid=req.getParameter("projectid");
			int count=service.ProjectMasterAttachDelete(attachid);
	

			if (count > 0) {
				redir.addAttribute("result", "Project Attachment Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Project Attachment Delete Unsuccessful");
			}
			redir.addFlashAttribute("ProjectId", projectid);
			return "redirect:/ProjectMasterAttach.htm";
			
		}catch 
		(Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside ProjectMasterAttachDelete.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "TechnicalWorkDataAdd.htm", method = {RequestMethod.POST} )
	public String TechnicalWorkDataAdd(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
	{	
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside TechnicalWorkDataAdd.htm "+UserId);
		try
		{
			String attachid=req.getParameter("attachid");
			String projectid=req.getParameter("projectid");
			String RelevantPoints=req.getParameter("RelevantPoints");
			String committeeid = req.getParameter("committeeid");
			
			ProjectTechnicalWorkData modal = new ProjectTechnicalWorkData();
			
			modal.setRelatedPoints(RelevantPoints);
			modal.setProjectId(Long.parseLong(projectid));
			modal.setAttachmentId(Long.parseLong(attachid));
			modal.setCreatedBy(UserId);
			if(Long.parseLong(req.getParameter("TechDataId"))>0) {
				service.TechnicalWorkDataEdit(modal,req.getParameter("TechDataId"));
			}
			long count=service.TechnicalWorkDataAdd(modal);
	

			if (count > 0) {
				redir.addAttribute("result", "Data Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Data Adding  Unsuccessful");
			}
			redir.addFlashAttribute("projectid", projectid);
			redir.addFlashAttribute("committeeid", committeeid);
			return "redirect:/ProjectBriefingPaper.htm";
			
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside TechnicalWorkDataAdd.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "IntiationChecklist.htm", method = {RequestMethod.POST} )
	public String IntiationChecklist(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
	{	
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside IntiationChecklist.htm "+UserId);
		try
		{
			String initiationid = req.getParameter("initiationid");
			req.setAttribute("checklist", service.InitiationCheckList(initiationid));	
			req.setAttribute("initiationid", initiationid);
			req.setAttribute("initiationdata", service.InitiatedProjectDetails(initiationid).get(0));
			return "project/InitiationChecklist";
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside IntiationChecklist.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	
	@RequestMapping(value = "IntiationChecklistUpdate.htm", method = RequestMethod.GET)
	public @ResponseBody String IntiationChecklistUpdate(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		long checklistitemid = 0;
		logger.info(new Date() +"Inside IntiationChecklistUpdate.htm "+UserId);
		
		try {
			String initiationid= req.getParameter("initiationid");
			String checklistid= req.getParameter("checklistid");
			
			PfmsInitiationChecklistData cldata = new PfmsInitiationChecklistData(); 
			cldata.setInitiationId(Long.parseLong(initiationid));
			cldata.setChecklistId(Long.parseLong(checklistid));
			cldata.setCreatedBy(UserId);
			 checklistitemid  = service.IntiationChecklistUpdate(cldata);
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside IntiationChecklistUpdate.htm "+UserId, e);		
		}		
		Gson json = new Gson();
		return json.toJson(checklistitemid);

	}
	
	@RequestMapping(value = "IntiationChecklistDownload.htm", method = {RequestMethod.POST} )
	public void IntiationChecklistDownload(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
	{	
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside IntiationChecklistDownload.htm "+UserId);
		try
		{
			String initiationid = req.getParameter("initiationid");
			String clno = req.getParameter("clno");
			req.setAttribute("checklist", service.InitiationCheckList(initiationid));	
			req.setAttribute("initiationid", initiationid);
			req.setAttribute("clno", clno);
			req.setAttribute("initiationdata", service.InitiatedProjectDetails(initiationid).get(0));
			
			String filename = "Checklist-0"+clno;
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/project/InitiationChecklistDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();
			byte[] data = html.getBytes();
			InputStream fis1=new ByteArrayInputStream(data);
			PdfDocument pdfDoc = new PdfDocument(new PdfWriter(path+"/"+filename+".pdf"));	
		    pdfDoc.setTagged();
	        HtmlConverter.convertToPdf(fis1,pdfDoc);
	        res.setContentType("application/pdf");
	        res.setHeader("Content-disposition","attachment;filename="+filename+".pdf"); 
	        File f=new File(path+"/"+filename+".pdf");
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
	        
	        
	        Path pathOfFile2= Paths.get(path+"/"+filename+".pdf"); 
	        Files.delete(pathOfFile2);		
			
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside IntiationChecklistDownload.htm "+UserId,e);
		}
	}
	
	@RequestMapping(value = "ActionTreeDemo.htm")
	public String ActionTree(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActionTreeDemo.htm "+UserId);
		
		try {
			return "static/ActionTree";
			
		}catch (Exception e) {

			e.printStackTrace(); 
			logger.error(new Date() +" Inside ActionTreeDemo.htm "+UserId, e);		
			return "ststic/Error";
			
		}		
		

	}

//package com.vts.pfms.project.controller;

//import java.io.ByteArrayInputStream;
//import java.io.DataOutputStream;
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.InputStream;
//import java.io.OutputStream;
//import java.nio.file.Files;
//import java.nio.file.Path;
//import java.nio.file.Paths;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.LinkedHashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.stream.Collectors;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.apache.logging.log4j.LogManager;
//import org.apache.logging.log4j.Logger;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.util.FileCopyUtils;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RequestPart;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.google.gson.Gson;
//import com.itextpdf.html2pdf.HtmlConverter;
//import com.itextpdf.kernel.pdf.PdfDocument;
//import com.itextpdf.kernel.pdf.PdfWriter;
//import com.vts.pfms.CharArrayWriterResponse;
//import com.vts.pfms.FormatConverter;
//import com.vts.pfms.print.model.ProjectTechnicalWorkData;
//import com.vts.pfms.project.dto.PfmsInitiationAttachmentDto;
//import com.vts.pfms.project.dto.PfmsInitiationAttachmentFileDto;
//import com.vts.pfms.project.dto.PfmsInitiationAuthorityDto;
//import com.vts.pfms.project.dto.PfmsInitiationAuthorityFileDto;
//import com.vts.pfms.project.dto.PfmsInitiationCostDto;
//import com.vts.pfms.project.dto.PfmsInitiationDetailDto;
//import com.vts.pfms.project.dto.PfmsInitiationDto;
//import com.vts.pfms.project.dto.PfmsProjectDataDto;
//import com.vts.pfms.project.dto.PfmsRiskDto;
//import com.vts.pfms.project.dto.ProjectAssignDto;
//import com.vts.pfms.project.dto.ProjectMasterAttachDto;
//import com.vts.pfms.project.dto.ProjectScheduleDto;
//import com.vts.pfms.project.model.PfmsInitiationAttachmentFile;
//import com.vts.pfms.project.model.PfmsInitiationAuthorityFile;
//import com.vts.pfms.project.model.PfmsInitiationChecklistData;
//import com.vts.pfms.project.model.ProjectAssign;
//import com.vts.pfms.project.model.ProjectMain;
//import com.vts.pfms.project.model.ProjectMaster;
//import com.vts.pfms.project.model.ProjectMasterRev;
//import com.vts.pfms.project.service.ProjectService;
//
//@Controller
//public class ProjectController 
//{
//
//	@Autowired
//	ProjectService service;
//	
//	@Value("${File_Size}")
//	String file_size;
//	
//	@Value("${ApplicationFilesDrive}")
//	String uploadpath;
//	                                                                                        
//	private static final Logger logger=LogManager.getLogger(ProjectController.class);
//	
//	FormatConverter fc=new FormatConverter();
//	private SimpleDateFormat sdf2=fc.getRegularDateFormat();/*new SimpleDateFormat("dd-MM-yyyy");*/
//	private SimpleDateFormat sdf1=fc.getSqlDateAndTimeFormat(); /* new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); */
//	private SimpleDateFormat sdf3=fc.getSqlDateFormat();
//	
//	@RequestMapping(value = "ProjectIntiationList.htm")
//	public String ProjectIntiationList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		String LabCode =(String ) ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectIntiationList.htm "+UserId);
//		
//		try {
//			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//			String LoginType=(String)ses.getAttribute("LoginType");
//	
//			req.setAttribute("ProjectIntiationList", service.ProjectIntiationList(EmpId,LoginType,LabCode));
//			req.setAttribute("projectapprovalflowempdata", service.ProjectApprovalFlowEmpData(EmpId,LabCode));
//			return "project/ProjectIntiationList";
//                                                                   
//		}
//		catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectIntiationList.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		} 
//		
//	}
//
//	@RequestMapping(value = "ProjectIntiationListSubmit.htm", method = RequestMethod.POST)
//	public String ProjectIntiationListSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)	throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectIntiationListSubmit.htm "+UserId);		
//		try {
//			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//				String Option = req.getParameter("sub");
//				String IntiationId = req.getParameter("btSelectItem");
//				String Logintype= (String)ses.getAttribute("LoginType");
//				String LabCode = (String)ses.getAttribute("labcode");
//		
//				if (Option.equalsIgnoreCase("add")) {
//					req.setAttribute("ProjectTypeList", service.ProjectTypeList());
//					req.setAttribute("PfmsCategoryList", service.PfmsCategoryList());
//					req.setAttribute("PfmsDeliverableList", service.PfmsDeliverableList());	
//					req.setAttribute("InitiatedProjectList", service.InitiatedProjectList());
//					req.setAttribute("NodalLabList", service.NodalLabList());
//					req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
//				}		
//				if (Option.equalsIgnoreCase("Details")) {
//					
//					req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//					req.setAttribute("ProjectProgressCount", service.ProjectProgressCount(IntiationId));
//					req.setAttribute("ScheduleList", service.ProjectIntiationScheduleList(IntiationId));
//					req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(IntiationId));
//					req.setAttribute("IntiationAttachment", service.ProjectIntiationAttachment(IntiationId));
//					req.setAttribute("AuthorityAttachment", service.AuthorityAttachment(IntiationId));
//														
//					Map<String, List<Object[]>> BudgetItemMapList = new LinkedHashMap<String, List<Object[]>>();
//		
//					List<Object[]> ItemList = service.ProjectIntiationItemList(IntiationId);
//					List<Object[]> BudgetHead = service.BudgetHead();
//		
//					for (Object[] obj : BudgetHead) {
//						List<Object[]> addlist = new ArrayList<Object[]>();
//						for (Object[] obj1 : ItemList) {
//							if (obj[1].toString().equalsIgnoreCase(obj1[2].toString())) {
//								addlist.add(obj1);
//		
//							}
//						}
//						if (addlist.size() > 0) {
//							BudgetItemMapList.put(obj[1].toString(), addlist);
//						}
//		
//					}
//					req.setAttribute("BudgetItemMapList", BudgetItemMapList);
//	
//					return "project/ProjectIntiationDetailes";
//			}
//	
//			if (Option.equalsIgnoreCase("status")) 
//			{
//				req.setAttribute("ProjectStatusList", service.ProjectStatusList(EmpId,Logintype,LabCode));
//				req.setAttribute("projectapprovalflowempdata", service.ProjectApprovalFlowEmpData(EmpId,LabCode));
//				return "project/ProjectStatusList";
//			}
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectIntiationListSubmit.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//
//		return "project/ProjectIntiationAdd";
//	}
//
//	
//	@RequestMapping(value = "InitiatedProjectDetails.htm", method = RequestMethod.GET)
//	public @ResponseBody String InitiatedProjectDetails(HttpServletRequest req, HttpSession ses) throws Exception {
//		
//	 	List<Object[]> InitiatedProjectDetails=null;
//	 	String UserId =(String)ses.getAttribute("Username");
//		logger.info(new Date() +"Inside InitiatedProjectDetails.htm "+UserId);		
//		try {
//			
//			InitiatedProjectDetails = service.InitiatedProjectDetails(req.getParameter("ProjectId"));
//		
//		}
//		catch (Exception e) {
//			e.printStackTrace();
//			 logger.error(new Date() +" Inside InitiatedProjectDetails.htm "+UserId, e);
//		}
//	
//		Gson convertedgson = new Gson();
//		
//		return convertedgson.toJson(InitiatedProjectDetails);
//
//	}
//	
//	
//	
//	
//	@RequestMapping(value = "ProjectIntiationDetailesLanding.htm", method = RequestMethod.GET)
//	public String ProjectIntiationDetailesLanding(Model model, HttpServletRequest req, HttpSession ses,	RedirectAttributes redir) throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectIntiationDetailesLanding.htm "+UserId);
//		
//		try {
//			Map md = model.asMap();
//			String IntiationId = (String) md.get("IntiationId");
//			String TabId = (String) md.get("TabId");
//			String Details = (String) md.get("details");
//			String DetailsEdit = (String) md.get("detailsedit");
//	
//			req.setAttribute("DetailsEdit", DetailsEdit);
//			req.setAttribute("Details", Details);
//			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//			req.setAttribute("ProjectProgressCount", service.ProjectProgressCount(IntiationId));
//			req.setAttribute("TabId", TabId);
//			req.setAttribute("ScheduleList", service.ProjectIntiationScheduleList(IntiationId));
//			req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(IntiationId));
//			req.setAttribute("IntiationAttachment", service.ProjectIntiationAttachment(IntiationId));
//			req.setAttribute("AuthorityAttachment", service.AuthorityAttachment(IntiationId));
//
//			
//			Map<String, List<Object[]>> BudgetItemMapList = new LinkedHashMap<String, List<Object[]>>();
//	
//			List<Object[]> ItemList = service.ProjectIntiationItemList(IntiationId);
//			List<Object[]> BudgetHead = service.BudgetHead();
//	
//			for (Object[] obj : BudgetHead) {
//				List<Object[]> addlist = new ArrayList<Object[]>();
//				for (Object[] obj1 : ItemList) {
//					if (obj[1].toString().equalsIgnoreCase(obj1[2].toString())) {
//						addlist.add(obj1);
//	
//					}
//				}
//				if (addlist.size() > 0) {
//					BudgetItemMapList.put(obj[1].toString(), addlist);
//				}
//	
//			}
//	
//			req.setAttribute("BudgetItemMapList", BudgetItemMapList);
//		}catch (Exception e) {
//			e.printStackTrace(); 
//			logger.error(new Date() +" Inside ProjectIntiationDetailesLanding.htm "+UserId, e);			
//    		return "static/Error";
//		}
//
//		return "project/ProjectIntiationDetailes";
//	}
//
//	@RequestMapping(value = "ProjectShortNameCount.htm", method = RequestMethod.GET)
//	public @ResponseBody String ProjectShortNameCount(HttpServletRequest req,HttpSession ses) throws Exception 
//	{		
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectShortNameCount.htm "+UserId);
//		Gson json = new Gson();						
//		Long ProjectShortNameCount = service.ProjectShortNameCount(req.getParameter("ProjectShortName"));			
//		return json.toJson(ProjectShortNameCount);
//	}
//
//	@RequestMapping(value = "ProjectIntiationAdd.htm", method = RequestMethod.POST )
//	public String ProjectIntiationAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		String EmpName = (String) ses.getAttribute("EmpName");
//		String LabCode =(String ) ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectIntiationAdd.htm "+UserId);
//		
//		try {
//
//			String Division = ((Long) ses.getAttribute("Division")).toString();
//			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//			PfmsInitiationDto pfmsinitiationdto = new PfmsInitiationDto();
//			pfmsinitiationdto.setEmpId(req.getParameter("PDD"));
//			pfmsinitiationdto.setLabCode(LabCode);
//			pfmsinitiationdto.setDivisionId(Division);
//			pfmsinitiationdto.setProjectProgramme(req.getParameter("ProjectProgramme"));
//			pfmsinitiationdto.setProjectTypeId(req.getParameter("ProjectType"));
//			pfmsinitiationdto.setCategoryId(req.getParameter("Category"));
//			pfmsinitiationdto.setProjectShortName(req.getParameter("ShortName"));
//			pfmsinitiationdto.setProjectTitle(req.getParameter("ProjectTitle"));
//			pfmsinitiationdto.setFeCost("0");
//			pfmsinitiationdto.setReCost("0");
//			pfmsinitiationdto.setProjectCost("0");
//			/* pfmsinitiationdto.setProjectDuration(req.getParameter("Duration")); */
//			pfmsinitiationdto.setIsPlanned(req.getParameter("IsPlanned"));
//			//pfmsinitiationdto.setIsMultiLab(req.getParameter("IsMultiLab"));
//			//pfmsinitiationdto.setDeliverableId(req.getParameter("Deliverable"));
//			pfmsinitiationdto.setNodalLab(req.getParameter("NodalLab"));
//			pfmsinitiationdto.setRemarks(req.getParameter("Remarks"));
//			pfmsinitiationdto.setIsMain(req.getParameter("ismain"));
//			pfmsinitiationdto.setDuration(req.getParameter("PCDuration"));
//			pfmsinitiationdto.setIndicativeCost(req.getParameter("IndicativeCost"));
//			pfmsinitiationdto.setPCRemarks(req.getParameter("PCRemarks"));
//			
//			if(req.getParameter("ismain").equalsIgnoreCase("Y")) {
//				pfmsinitiationdto.setMainId("0");
//			}else {
//			pfmsinitiationdto.setMainId(req.getParameter("initiationid"));
//			}
//			
//			Long count = service.ProjectIntiationAdd(pfmsinitiationdto, UserId,EmpId,EmpName);
//	
//			
//			if (count > 0) {
//				redir.addAttribute("result", "Project Initiated Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Intiation Unsuccessful");
//			}
//	
//			redir.addFlashAttribute("IntiationId", count.toString());
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectIntiationAdd.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//
//	}
//
//	@RequestMapping(value = "ProjectIntiationEdit.htm", method = RequestMethod.POST)
//	public String ProjectIntiationEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectIntiationEdit.htm "+UserId);
//		
//		try {
//
//			String IntiationId = req.getParameter("IntiationId");
//	
//			req.setAttribute("ProjectTypeList", service.ProjectTypeList());
//			req.setAttribute("PfmsCategoryList", service.PfmsCategoryList());
//			req.setAttribute("PfmsDeliverableList", service.PfmsDeliverableList());
//			req.setAttribute("ProjectEditData", service.ProjectEditData(IntiationId).get(0));
//			req.setAttribute("IntiationId", IntiationId);
//			req.setAttribute("NodalLabList", service.NodalLabList());
//			req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
//			
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectIntiationEdit.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//
//
//		return "project/ProjectIntiationEdit";
//	}
//
//	@RequestMapping(value = "ProjectIntiationEditSubmit.htm", method = RequestMethod.POST)
//	public String ProjectIntiationEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectIntiationEditSubmit.htm "+UserId);
//		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//		try {
//			String option = req.getParameter("sub");
//			if (option.equalsIgnoreCase("SUBMIT")) {
//				PfmsInitiationDto pfmsinitiationdto = new PfmsInitiationDto();
//				pfmsinitiationdto.setInitiationId(req.getParameter("IntiationId"));
//				pfmsinitiationdto.setProjectProgramme(req.getParameter("ProjectProgramme"));
//				pfmsinitiationdto.setProjectTypeId(req.getParameter("ProjectType"));
//				pfmsinitiationdto.setCategoryId(req.getParameter("Category"));
//				pfmsinitiationdto.setNodalLab(req.getParameter("NodalLab"));
//				pfmsinitiationdto.setProjectTitle(req.getParameter("ProjectTitle"));
//				pfmsinitiationdto.setIsPlanned(req.getParameter("IsPlanned"));
//				pfmsinitiationdto.setIsMultiLab(req.getParameter("IsMultiLab"));
//				pfmsinitiationdto.setDeliverableId(req.getParameter("Deliverable"));
//				pfmsinitiationdto.setRemarks(req.getParameter("Remarks"));
//				pfmsinitiationdto.setIsMain(req.getParameter("ismain"));
//				pfmsinitiationdto.setEmpId(req.getParameter("PDD"));
//				pfmsinitiationdto.setPCRemarks(req.getParameter("PCRemarks"));
//				pfmsinitiationdto.setIndicativeCost(req.getParameter("IndicativeCost"));
//				pfmsinitiationdto.setDuration(req.getParameter("PCDuration"));
//	
//				int count = service.ProjectIntiationEdit(pfmsinitiationdto, UserId);
//	
//				if (count > 0) {
//					redir.addAttribute("result", "Project Initiation Edited Successfully");
//				} else {
//					redir.addAttribute("resultfail", "Project Intiation Edit Unsuccessful");
//				}
//			}
//			
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectIntiationEditSubmit.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//			
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//
//	}
//
//	@RequestMapping(value = "ProjectOtherDetailsAdd.htm", method = RequestMethod.POST)
//	public String ProjectOtherDetailsAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectOtherDetailsAdd.htm "+UserId);
//		
//		try {
//
//			String IntiationId = req.getParameter("IntiationId");
//			req.setAttribute("IntiationId", IntiationId);
//	
//			
//	
//			req.setAttribute("details_param", req.getParameter("details_param"));
//			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectOtherDetailsAdd.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//
//		return "project/ProjectOtherDetailsRequirementAdd";
//
//	}
//
//	@RequestMapping(value = "ProjectOtherDetailsAddSubmit.htm", method = RequestMethod.POST)
//	public String ProjectOtherDetailsAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception
//	{
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectOtherDetailsAddSubmit.htm "+UserId);
//		
//		try {
//
//		
//			String Option = req.getParameter("sub");
//	
//			if (Option.equalsIgnoreCase("SUBMIT")) {
//	
//				PfmsInitiationDetailDto pfmsinitiationdetaildto = new PfmsInitiationDetailDto();
//				pfmsinitiationdetaildto.setInitiationId(req.getParameter("IntiationId"));
//				pfmsinitiationdetaildto.setRequirements(req.getParameter("Requirements"));
//				pfmsinitiationdetaildto.setObjective(req.getParameter("Objective"));
//				pfmsinitiationdetaildto.setScope(req.getParameter("Scope"));
//				pfmsinitiationdetaildto.setMultiLabWorkShare(req.getParameter("MultiLabWorkShare"));
//				pfmsinitiationdetaildto.setEarlierWork(req.getParameter("EarlierWork"));
//				pfmsinitiationdetaildto.setCompentencyEstablished(req.getParameter("CompentencyEstablished"));
//				if(req.getParameter("needofproject").length()!=0) {
//				pfmsinitiationdetaildto.setNeedOfProject(req.getParameter("needofproject"));}
//				else {
//					pfmsinitiationdetaildto.setNeedOfProject("-");
//				}
//				pfmsinitiationdetaildto.setTechnologyChallanges(req.getParameter("TechnologyChallanges"));
//				pfmsinitiationdetaildto.setRiskMitigation(req.getParameter("RiskMitiagation"));
//				pfmsinitiationdetaildto.setProposal(req.getParameter("Proposal"));
//				pfmsinitiationdetaildto.setRealizationPlan(req.getParameter("RealizationPlan"));
//				pfmsinitiationdetaildto.setReqBrief(req.getParameter("ReqBrief"));
//				pfmsinitiationdetaildto.setObjBrief(req.getParameter("ObjBrief"));
//				pfmsinitiationdetaildto.setScopeBrief(req.getParameter("ScopeBrief"));
//				pfmsinitiationdetaildto.setMultiLabBrief(req.getParameter("MultiLabBrief"));
//				pfmsinitiationdetaildto.setEarlierWorkBrief(req.getParameter("EarlierWorkBrief"));
//				pfmsinitiationdetaildto.setCompentencyBrief(req.getParameter("CompentencyBrief"));
//				if(req.getParameter("NeedOfProjectBrief").length()!=0) {
//				pfmsinitiationdetaildto.setNeedOfProjectBrief(req.getParameter("NeedOfProjectBrief"));}
//				else {
//					pfmsinitiationdetaildto.setNeedOfProjectBrief("-");
//				}
//				pfmsinitiationdetaildto.setTechnologyBrief(req.getParameter("TechnologyBrief"));
//				pfmsinitiationdetaildto.setRiskMitigationBrief(req.getParameter("RiskMitigationBrief"));
//				pfmsinitiationdetaildto.setProposalBrief(req.getParameter("ProposalBrief"));
//				pfmsinitiationdetaildto.setRealizationBrief(req.getParameter("RealizationBrief"));
//				pfmsinitiationdetaildto.setWorldScenarioBrief(req.getParameter("WorldScenarioBrief"));
//				
//				Long count =    service.ProjectIntiationAdd(pfmsinitiationdetaildto, UserId);
//	
//				if (count > 0) {
//					redir.addAttribute("result", "Project Details Added Successfully");
//				} else {
//					redir.addAttribute("resultfail", "Project Details Add Unsuccessful");
//				}
//				redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//				redir.addFlashAttribute("TabId", "1");
//				return "redirect:/ProjectIntiationDetailesLanding.htm";
//	
//			}
//	
//			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//			redir.addFlashAttribute("TabId", "1");
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectOtherDetailsAddSubmit.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//
//	}
//
//	@RequestMapping(value = "ProjectLabInsert.htm", method = RequestMethod.POST)
//	public String ProjectLabInsert(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
//	{
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectLabInsert.htm "+UserId);
//		
//		try {
//
//			String IntiationId = req.getParameter("IntiationId");
//	
//			req.setAttribute("IntiationId", IntiationId);
//	
//			req.setAttribute("LabList", service.LabList(IntiationId));
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectLabInsert.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//
//		return "project/ProjectLabInsert";
//	}
//
//	@RequestMapping(value = "BudgetItemList.htm", method = RequestMethod.GET)
//	public @ResponseBody String BudgetItemList(HttpServletRequest req, HttpSession ses) throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//		List<Object[]> BudgetItemList =null;
//		logger.info(new Date() +"Inside BudgetItemList.htm "+UserId);
//		
//		try {
//
//			 BudgetItemList = service.BudgetItem(req.getParameter("BudgetHead"));
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside BudgetItemList.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//		Gson json = new Gson();
//		return json.toJson(BudgetItemList);
//
//	}
//
//	@RequestMapping(value = "ProjectCostAdd.htm", method = RequestMethod.POST)
//	public String ProjectCostAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
//	{
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectCostAdd.htm "+UserId);
//		
//		try {
//			String IntiationId = req.getParameter("IntiationId");
//			Map<String, List<Object[]>> BudgetItemMap = new LinkedHashMap<String, List<Object[]>>();
//			Map<String, List<Object[]>> BudgetItemMapList = new LinkedHashMap<String, List<Object[]>>();
//	
//			List<Object[]> ItemList = service.ProjectIntiationItemList(IntiationId);
//			List<Object[]> BudgetHead = service.BudgetHead();
//	
//			for (Object[] obj : BudgetHead) {
//				BudgetItemMap.put(obj[1].toString(), service.BudgetItem(obj[0].toString()));
//			}
//	
//			for (Object[] obj : BudgetHead) {
//				List<Object[]> addlist = new ArrayList<Object[]>();
//				for (Object[] obj1 : ItemList) {
//					if (obj[1].toString().equalsIgnoreCase(obj1[2].toString())) {
//						addlist.add(obj1);
//	
//					}
//				}
//				if (addlist.size() > 0) {
//					BudgetItemMapList.put(obj[1].toString(), addlist);
//				}
//	
//			}
//	
//			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//			req.setAttribute("BudgetItemMapList", BudgetItemMapList);
//			req.setAttribute("IntiationId", IntiationId);
//			req.setAttribute("BudgetHead", BudgetHead);
//			req.setAttribute("ItemList", service.ProjectIntiationItemList(IntiationId));
//			req.setAttribute("TotalIntiationCost", service.TotalIntiationCost(IntiationId));
//			req.setAttribute("BudgetItemMap", BudgetItemMap);
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectCostAdd.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//
//		return "project/ProjectCostAdd";
//	}
//
//	@RequestMapping(value = "ProjectCostAddLanding.htm", method = RequestMethod.GET)
//	public String ProjectCostAddLanding(Model model, HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectCostAddLanding.htm "+UserId);
//		
//		try {
//			String IntiationId = null;
//			Map md = model.asMap();
//			for (Object modelKey : md.keySet()) {
//				IntiationId = (String) md.get(modelKey);
//	
//			}
//	
//			Map<String, List<Object[]>> BudgetItemMap = new LinkedHashMap<String, List<Object[]>>();
//			Map<String, List<Object[]>> BudgetItemMapList = new LinkedHashMap<String, List<Object[]>>();
//	
//			List<Object[]> ItemList = service.ProjectIntiationItemList(IntiationId);
//			List<Object[]> BudgetHead = service.BudgetHead();
//	
//			for (Object[] obj : BudgetHead) {
//				BudgetItemMap.put(obj[1].toString(), service.BudgetItem(obj[0].toString()));
//			}
//			for (Object[] obj : BudgetHead) {
//				List<Object[]> addlist = new ArrayList<Object[]>();
//				for (Object[] obj1 : ItemList) {
//					if (obj[1].toString().equalsIgnoreCase(obj1[2].toString())) {
//						addlist.add(obj1);
//	
//					}
//				}
//				if (addlist.size() > 0) {
//					BudgetItemMapList.put(obj[1].toString(), addlist);
//				}
//			}
//	
//			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//			req.setAttribute("BudgetItemMapList", BudgetItemMapList);
//			req.setAttribute("IntiationId", IntiationId);
//			req.setAttribute("BudgetHead", BudgetHead);
//			req.setAttribute("ItemList", service.ProjectIntiationItemList(IntiationId));
//			req.setAttribute("TotalIntiationCost", service.TotalIntiationCost(IntiationId));
//			req.setAttribute("BudgetItemMap", BudgetItemMap);
//		
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectCostAddLanding.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//		return "project/ProjectCostAdd";
//	}
//
//	@RequestMapping(value = "ProjectCostAddSubmit.htm", method = RequestMethod.POST)
//	public String ProjectCostAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectCostAddSubmit.htm "+UserId);
//		
//		String option = req.getParameter("sub");
//		try {
//	
//			if (option.equalsIgnoreCase("SUBMIT")) {
//			
//	
//				Object[] ProjectCost = service.ProjectCost(Long.parseLong(req.getParameter("IntiationId"))).get(0);
//	
//				PfmsInitiationCostDto pfmsinitiationcostdto = new PfmsInitiationCostDto();
//	
//				pfmsinitiationcostdto.setInitiationId(req.getParameter("IntiationId"));
//				pfmsinitiationcostdto.setBudgetHeadId(req.getParameter("BudgetHead"));
//				pfmsinitiationcostdto.setBudgetSancId(req.getParameter("Item"));
//				pfmsinitiationcostdto.setItemCost(req.getParameter("Cost"));
//				pfmsinitiationcostdto.setItemDetail(req.getParameter("ItemDetail"));
//	
//				Long count = service.ProjectIntiationCostAdd(pfmsinitiationcostdto, UserId, ProjectCost);
//	
//				if (count > 0) {
//					redir.addAttribute("result", "Project Cost Added Successfully");
//				} else {
//					redir.addAttribute("resultfail", "Project Cost Add Unsuccessful");
//				}
//	
//				redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//			
//				return "redirect:/ProjectCostAddLanding.htm";
//			} else {
//				redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//				redir.addFlashAttribute("TabId", "2");
//				return "redirect:/ProjectIntiationDetailesLanding.htm";
//			}
//			}catch (Exception e) {
//				e.printStackTrace(); logger.error(new Date() +" Inside ProjectCostAddSubmit.htm "+UserId, e);
//				
//	    		//return "static/Error";
//			}
//		
//		return "redirect:/maindashboard.htm";
//	}
//
//	@RequestMapping(value = "ProjectCostEdit.htm", method = RequestMethod.POST)
//	public String ProjectCostEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectCostEdit.htm "+UserId);
//		
//		String option = req.getParameter("sub");
//		try {
//
//			Object[] ProjectDetailes = service.ProjectCostEditData(req.getParameter("InitiationCostId")).get(0);
//	
//			String IntiationId = req.getParameter("IntiationId");
//	
//			req.setAttribute("ProjectCostEditData", ProjectDetailes);
//			req.setAttribute("BudgetItemList", service.BudgetItem(ProjectDetailes[2].toString()));
//			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//			req.setAttribute("IntiationId", IntiationId);
//			req.setAttribute("BudgetHead", service.BudgetHead());
//			req.setAttribute("TotalIntiationCost", service.TotalIntiationCost(IntiationId));
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectCostEdit.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//		return "project/ProjectCostEdit";
//	}
//
//	@RequestMapping(value = "ProjectCostEditSubmit.htm", method = RequestMethod.POST)
//	public String ProjectCostEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		String UserId = (String) ses.getAttribute("Username");	
//		logger.info(new Date() +"Inside ProjectCostEditSubmit.htm "+UserId);
//		
//		try {
//
//		
//		Object[] ProjectCostEditData = service.ProjectCostEditData(req.getParameter("InitiationCostId")).get(0);
//		Object[] ProjectDetailes = service.ProjectDetailes(Long.parseLong(req.getParameter("IntiationId"))).get(0);
//		Double ProjectCost = Double.parseDouble(ProjectDetailes[8].toString());
//
//		Double Totalcost = service.TotalIntiationCost(req.getParameter("IntiationId"));
//		Totalcost = Totalcost + Double.parseDouble(req.getParameter("Cost")) - Double.parseDouble(ProjectCostEditData[5].toString());
//
//		
//		
//		
//			PfmsInitiationCostDto pfmsinitiationcostdto = new PfmsInitiationCostDto();
//			pfmsinitiationcostdto.setInitiationCostId(req.getParameter("InitiationCostId"));
//			pfmsinitiationcostdto.setInitiationId(req.getParameter("IntiationId"));
//			// pfmsinitiationcostdto.setBudgetHeadId(req.getParameter("BudgetHead"));
//			pfmsinitiationcostdto.setBudgetSancId(req.getParameter("Item"));
//			pfmsinitiationcostdto.setItemCost(req.getParameter("Cost"));
//			pfmsinitiationcostdto.setItemDetail(req.getParameter("ItemDetail"));
//			
//			
//			int count = service.ProjectIntiationCostEdit(pfmsinitiationcostdto, UserId,req.getParameter("IntiationId"),req.getParameter("totalcost"));
//
//			if (count > 0) {
//				redir.addAttribute("result", "Project Cost Updated Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Cost Update Unsuccessful");
//			}
//		
//			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//		}
//		catch(Exception e) {	    		
//    		e.printStackTrace(); logger.error(new Date() +" Inside ProjectCostEditSubmit.htm "+UserId, e);
//    		return "static/Error";
//	
//    	}	
//
//		return "redirect:/ProjectCostAddLanding.htm";
//
//	}
//
//	@RequestMapping(value = "ProjectCostDeleteSubmit.htm", method = RequestMethod.POST)
//	public String ProjectCostDeleteSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//		String IntiationId =req.getParameter("IntiationId");
//
//		logger.info(new Date() +"Inside ProjectCostDeleteSubmit.htm "+UserId);
//		
//		try {
//		
//
//			int count = service.ProjectIntiationCostDelete(req.getParameter("InitiationCostId"), UserId,IntiationId);
//	
//			if (count > 0) {
//				redir.addAttribute("result", "Project Cost Deleted Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Cost Delete Unsuccessful");
//			}
//			
//			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectCostDeleteSubmit.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//			
//		}
//
//		return "redirect:/ProjectCostAddLanding.htm";
//
//	}
//
//	@RequestMapping(value = "ProjectLabAdd.htm", method = RequestMethod.POST)
//	public String ProjectLabAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectLabAdd.htm "+UserId);
//		
//		try {
//			String IntiationId = req.getParameter("IntiationId");
//	
//			req.setAttribute("IntiationId", IntiationId);
//	
//			req.setAttribute("ProjectIntiationLabList", service.ProjectIntiationLabList(IntiationId));
//			req.setAttribute("LabList", service.LabList(IntiationId));
//			req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectLabAdd.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//
//
//		return "project/ProjectLabAdd";
//	}
//
//	@RequestMapping(value = "ProjectLabAddSubmit.htm", method = RequestMethod.POST)
//	public String ProjectLabAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectLabAddSubmit.htm "+UserId);
//		
//		try {
//
//			String option = req.getParameter("sub");
//			if (option.equalsIgnoreCase("SUBMIT")) {
//				
//	
//				int count = service.ProjectLabAdd(req.getParameterValues("Lid"), req.getParameter("IntiationId"), UserId);
//	
//				if (count > 0) {
//					redir.addAttribute("result", "Project Lab Added Successfully");
//				} else {
//					redir.addAttribute("resultfail", "Project Lab Add Unsuccessful");
//				}
//			}
//			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//			// redir.addFlashAttribute("TabId","0");
//		}catch (Exception e) {
//			e.printStackTrace(); 
//			logger.error(new Date() +" Inside ProjectLabAddSubmit.htm "+UserId, e);
//			
//    		return "static/Error";
//		}
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//
//	}
//
//	@RequestMapping(value = "ProjectLabdeleteSubmit.htm", method = RequestMethod.POST)
//	public String ProjectLabdeleteSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectLabdeleteSubmit.htm "+UserId);
//		
//		try {
//		
//
//		int count = service.ProjectLabDelete(req.getParameter("btSelectItem"), req.getParameter("IntiationId"), UserId);
//
//		if (count > 0) {
//			redir.addAttribute("result", "Project Lab Deleted Successfully");
//		} else {
//			redir.addAttribute("resultfail", "Project Lab Delete Unsuccessful");
//		}
//
//		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//		// redir.addFlashAttribute("TabId","0");
//		
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectLabdeleteSubmit.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//
//	}
//
//	@RequestMapping(value = "ProjectScheduleAdd.htm", method = RequestMethod.POST)
//	public String ProjectScheduleAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectScheduleAdd.htm "+UserId);
//		
//		try {
//		String IntiationId = req.getParameter("IntiationId");
//
//		req.setAttribute("IntiationId", IntiationId);
//
//		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//		req.setAttribute("ScheduleList", service.ProjectIntiationScheduleList(IntiationId));
//		req.setAttribute("ProjectScheduleMonth", service.ProjectScheduleMonth(IntiationId));
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectScheduleAdd.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//
//		return "project/ProjectScheduleAdd";
//	}
//
//	@RequestMapping(value = "ProjectScheduleAddLanding.htm", method = RequestMethod.GET)
//	public String ProjectScheduleAddLanding(Model model, HttpServletRequest req, HttpSession ses,
//			RedirectAttributes redir) throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectScheduleAddLanding.htm "+UserId);
//		
//		try {
//		String IntiationId = null;
//		Map md = model.asMap();
//		for (Object modelKey : md.keySet()) {
//			IntiationId = (String) md.get(modelKey);
//
//		}
//
//		req.setAttribute("IntiationId", IntiationId);
//
//		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//		req.setAttribute("ScheduleList", service.ProjectIntiationScheduleList(IntiationId));
//		req.setAttribute("ProjectScheduleMonth", service.ProjectScheduleMonth(IntiationId));
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectScheduleAddLanding.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//		return "project/ProjectScheduleAdd";
//	}
//
//	
//
//	@RequestMapping(value = "ProjectScheduleAddSubmit.htm", method = RequestMethod.POST)
//	public String ProjectScheduleAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectScheduleAddSubmit.htm "+UserId);
//		
//		try {
//
//		String option = req.getParameter("sub");
//		if (option.equalsIgnoreCase("SUBMIT")) {
//
//			
//			Object[] ProjectDetailes = service.ProjectDetailes(Long.parseLong(req.getParameter("IntiationId"))).get(0);
//			Integer ProjectScheduleMonth = service.ProjectScheduleMonth(req.getParameter("IntiationId"));
//			Integer TotalMonthToAdd = 0;
//			String[] montharray=req.getParameterValues("MilestoneMonth");
//			
//			for (int i=0;i<montharray.length;i++) {
//				TotalMonthToAdd = TotalMonthToAdd + Integer.parseInt(montharray[i]);
//			}
//			Integer TotalMonth = TotalMonthToAdd + ProjectScheduleMonth;
//			/* if(TotalMonth<=Integer.parseInt(ProjectDetailes[9].toString())) { */
//			Long count = service.ProjectScheduleAdd(req.getParameterValues("MilestoneActivity"),
//					req.getParameterValues("MilestoneMonth"), req.getParameterValues("MilestoneRemark"),
//					req.getParameter("IntiationId"), UserId, ProjectDetailes,TotalMonth);
//
//			if (count > 0) {
//				redir.addAttribute("result", "Project Schedule Added Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Schedule Add Unsuccessful");
//			}
//
//			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//
//			return "redirect:/ProjectScheduleAddLanding.htm";
//
//		} else {
//			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//			redir.addFlashAttribute("TabId", "3");
//			
//		}
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectScheduleAddSubmit.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//	}
//
//	
//	
//	@RequestMapping(value = "ProjectScheduleEditSubmit.htm", method=RequestMethod.POST)
//	public String ProjectScheduleEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectScheduleEditSubmit.htm "+UserId);
//		
//		try {
//
//	      //Object[] ProjectDetailes=service.ProjectDetailes(Long.parseLong(req.getParameter("IntiationId"))).get(0);
//	      int oldmonth=service.ProjectScheduleEditData(req.getParameter("initiationscheduleid"));
//	      Integer ProjectScheduleMonth =service.ProjectScheduleMonth(req.getParameter("IntiationId"));
//
//	      Integer TotalMonth=Integer.parseInt(req.getParameter("MilestoneMonthEdit"))+ProjectScheduleMonth-oldmonth;
//	      	    
//			/* if(TotalMonth<=Integer.parseInt(ProjectDetailes[9].toString())) { */
//		
//	      ProjectScheduleDto projectschedule=new ProjectScheduleDto();
//	      projectschedule.setMileStoneActivity(req.getParameter("MilestoneActivityEdit"));
//	      projectschedule.setMileStoneMonth(req.getParameter("MilestoneMonthEdit"));
//	      projectschedule.setMileStoneRemark(req.getParameter("MilestoneRemarkEdit"));
//	      projectschedule.setInitiationScheduleId(req.getParameter("initiationscheduleid"));	      
//	      projectschedule.setUserId(UserId);
//	      projectschedule.setTotalMonth(TotalMonth);
//	      projectschedule.setInitiationId(req.getParameter("IntiationId"));
//	      
//	      
//		int count = service.ProjectScheduleEdit(projectschedule);
//
//		
//		
//		
//		if (count >0 ) {
//			redir.addAttribute("result", "Project Schedule Edited Successfully");
//		} else {
//			redir.addAttribute("resultfail", "Project Schedule Edit Unsuccessful");
//		}
//		
//		
//		redir.addFlashAttribute("IntiationId",req.getParameter("IntiationId"));
//		}catch (Exception e) {
//			e.printStackTrace();
//			logger.error(new Date() +" Inside ProjectScheduleEditSubmit.htm "+UserId, e);
//			return "static/Error";
//		}
//	
//		return "redirect:/ProjectScheduleAddLanding.htm";
//
//}
//
//	@RequestMapping(value = "ProjectScheduleDeleteSubmit.htm", method = RequestMethod.POST)
//	public String ProjectScheduleDeleteSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectScheduleDeleteSubmit.htm "+UserId);
//		
//		try {
//
//		Integer ProjectScheduleMonth = service.ProjectScheduleMonth(req.getParameter("IntiationId"));
//
//		Integer TotalMonth = ProjectScheduleMonth - Integer.parseInt(req.getParameter("MilestoneMonthEdit"));
//
//		String InitiationId = req.getParameter("IntiationId");
//
//		int count = service.ProjectScheduleDelete(req.getParameter("initiationscheduleid"), UserId, TotalMonth,
//				InitiationId);
//
//		if (count > 0) {
//			redir.addAttribute("result", "Project Schedule Deleted Successfully");
//		} else {
//			redir.addAttribute("resultfail", "Project Schedule Delete Unsuccessful");
//		}
//		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectScheduleDeleteSubmit.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//
//		return "redirect:/ProjectScheduleAddLanding.htm";
//
//	}
//
//	@RequestMapping(value = "ProjectInitiationDetailsEdit.htm", method = RequestMethod.POST)
//	public String ProjectInitiationDetailsEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectInitiationDetailsEdit.htm "+UserId);
//		
//		try {
//
//		String IntiationId = req.getParameter("IntiationId");
//		String Details = req.getParameter("details");
//
//		req.setAttribute("Details", Details);
//		req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(IntiationId));
//		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectInitiationDetailsEdit.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//
//		return "project/ProjectInitiationDetailsEdit";
//	}
//	@RequestMapping(value = "ProjectInitiationDetailsSubmit.htm", method = RequestMethod.POST)
//	public String ProjectInitiationDetailsSubmit(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)
//			throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectInitiationDetailsSubmit.htm "+UserId);
//		
//		try {
//		String InitiationId = req.getParameter("IntiationId");
//		String Details = req.getParameter("details");
////		
//
//		String option = req.getParameter("sub");
//		if (option.equalsIgnoreCase("SUBMIT")) {
//
//			
//
//			String Alert = "";
//
//			PfmsInitiationDetailDto pfmsinitiationdetaildto = new PfmsInitiationDetailDto();
//
//			if (Details.equalsIgnoreCase("requirement")) {
//				if(req.getParameter("Requirements").length()!=0) {
//				pfmsinitiationdetaildto.setRequirements(req.getParameter("Requirements"));}
//				else {
//					pfmsinitiationdetaildto.setRequirements("-");
//				}
//				//edited
//				if(req.getParameter("ReqBrief").length()!=0) {
//				pfmsinitiationdetaildto.setReqBrief(req.getParameter("ReqBrief"));}
//				else {
//					pfmsinitiationdetaildto.setReqBrief("-");
//				}
//				
//				Alert = "Requirement";
//			}
//			if (Details.equalsIgnoreCase("objective")) {
//				if(req.getParameter("objective").length()!=0) {
//				pfmsinitiationdetaildto.setObjective(req.getParameter("objective"));}
//				else {
//					pfmsinitiationdetaildto.setObjective("-");
//				}
//				if(req.getParameter("ObjBrief").length()!=0) {
//				pfmsinitiationdetaildto.setObjBrief(req.getParameter("ObjBrief")); 
//				}else {
//					pfmsinitiationdetaildto.setObjBrief("-");
//				}
//				//edited
//				Alert = "Objective";
//			}
//			if (Details.equalsIgnoreCase("scope")) {
//				if(req.getParameter("scope").length()!=0) {
//				pfmsinitiationdetaildto.setScope(req.getParameter("scope"));}
//				else {
//					pfmsinitiationdetaildto.setScope("-");
//				}
//				if(req.getParameter("ScopeBrief").length()!=0) {
//				pfmsinitiationdetaildto.setScopeBrief(req.getParameter("ScopeBrief"));}
//				else {
//					pfmsinitiationdetaildto.setScopeBrief("-");
//				}
//				Alert = "Scope";
//			}
//			if (Details.equalsIgnoreCase("multilab")) {
//				if(req.getParameter("multilab").length()!=0) {
//				pfmsinitiationdetaildto.setMultiLabWorkShare(req.getParameter("multilab"));}
//				else {
//					pfmsinitiationdetaildto.setMultiLabWorkShare("-");
//				}
//				if(req.getParameter("MultiLabBrief").length()!=0) {
//				pfmsinitiationdetaildto.setMultiLabBrief(req.getParameter("MultiLabBrief"));}
//				else {
//					pfmsinitiationdetaildto.setMultiLabBrief("-");
//				}
//				Alert = "Multi-Lab Work Share";
//			}
//			if (Details.equalsIgnoreCase("earlierwork")) {
//				if(req.getParameter("earlierwork").length()!=0) {
//				pfmsinitiationdetaildto.setEarlierWork(req.getParameter("earlierwork"));}
//				else {
//					pfmsinitiationdetaildto.setEarlierWork("-");
//				}
//				if(req.getParameter("EarlierWorkBrief").length()!=0) {
//				pfmsinitiationdetaildto.setEarlierWorkBrief(req.getParameter("EarlierWorkBrief"));}
//				else {
//					pfmsinitiationdetaildto.setEarlierWorkBrief("-");
//				}
//				Alert = "Earlier Work";
//			}
//			if (Details.equalsIgnoreCase("competency")) {
//				if(req.getParameter("competency").length()!=0) {
//				pfmsinitiationdetaildto.setCompentencyEstablished(req.getParameter("competency"));}
//				else {
//					pfmsinitiationdetaildto.setCompentencyEstablished("-");
//				}
//				if(req.getParameter("CompentencyBrief").length()!=0) {
//				pfmsinitiationdetaildto.setCompentencyBrief(req.getParameter("CompentencyBrief"));}
//				else {
//					pfmsinitiationdetaildto.setCompentencyBrief("-");
//				}
//				Alert = "Competency Established";
//			}
//			if (Details.equalsIgnoreCase("needofproject")) {
//				if(req.getParameter("needofproject").length()!=0) {
//				pfmsinitiationdetaildto.setNeedOfProject(req.getParameter("needofproject"));}
//				else {
//					
//				}
//				if(req.getParameter("NeedOfProjectBrief").length()!=0) {
//				pfmsinitiationdetaildto.setNeedOfProjectBrief(req.getParameter("NeedOfProjectBrief"));}
//				else {
//					pfmsinitiationdetaildto.setNeedOfProjectBrief("-");
//				}
//				Alert = "Need of Project";
//			}
//			if (Details.equalsIgnoreCase("technology")) {
//				if(req.getParameter("technology").length()!=0) {
//				pfmsinitiationdetaildto.setTechnologyChallanges(req.getParameter("technology"));}
//				else {
//					pfmsinitiationdetaildto.setTechnologyChallanges("-");
//				}
//				if(req.getParameter("TechnologyBrief").length()!=0) {
//				pfmsinitiationdetaildto.setTechnologyBrief(req.getParameter("TechnologyBrief"));}
//				else {
//					pfmsinitiationdetaildto.setTechnologyBrief("-");
//				}
//				Alert = "Technology Challenges";
//			}
//			if (Details.equalsIgnoreCase("riskmitigation")) {
//				if(req.getParameter("riskmitigation").length()!=0) {
//				pfmsinitiationdetaildto.setRiskMitigation(req.getParameter("riskmitigation"));}
//				else {
//					pfmsinitiationdetaildto.setRiskMitigation("-");
//				}
//				if(req.getParameter("RiskMitigationBrief").length()!=0) {
//				pfmsinitiationdetaildto.setRiskMitigationBrief(req.getParameter("RiskMitigationBrief"));}
//				else {
//					pfmsinitiationdetaildto.setRiskMitigationBrief("-");
//				}
//				Alert = "Risk Mitigation";
//			}
//			if (Details.equalsIgnoreCase("proposal")) {
//				if(req.getParameter("proposal").length()!=0) {
//				pfmsinitiationdetaildto.setProposal(req.getParameter("proposal"));}
//				else {
//					pfmsinitiationdetaildto.setProposal("-");
//				}
//				if(req.getParameter("ProposalBrief").length()!=0) {
//				pfmsinitiationdetaildto.setProposalBrief(req.getParameter("ProposalBrief"));}
//				else {
//					pfmsinitiationdetaildto.setProposalBrief("-");
//				}
//				Alert = "Proposal";
//			}
//			if (Details.equalsIgnoreCase("realization")) {
//				if(req.getParameter("realization").length()!=0) {
//				pfmsinitiationdetaildto.setRealizationPlan(req.getParameter("realization"));}
//				else {
//					pfmsinitiationdetaildto.setRealizationPlan("-");
//				}
//				if(req.getParameter("RealizationBrief").length()!=0) {
//				pfmsinitiationdetaildto.setRealizationBrief(req.getParameter("RealizationBrief"));}
//				else {
//					pfmsinitiationdetaildto.setRealizationBrief("-");
//				}
//				Alert = "Realization Plan";
//			}
//			if (Details.equalsIgnoreCase("worldscenario")) {
//				if(req.getParameter("worldscenario").length()!=0) {
//				pfmsinitiationdetaildto.setWorldScenario(req.getParameter("worldscenario"));}
//				else {
//					pfmsinitiationdetaildto.setWorldScenario("-");
//				}
//				if(req.getParameter("WorldScenarioBrief").length()!=0) {
//				pfmsinitiationdetaildto.setWorldScenarioBrief(req.getParameter("WorldScenarioBrief"));}
//				else {
//					pfmsinitiationdetaildto.setWorldScenarioBrief("-");
//				}
//				Alert = "World Scenario";
//			}
//
//			pfmsinitiationdetaildto.setInitiationId(InitiationId);
//
//			Long count = 0L;
//
//			count = service.ProjectInitiationDetailsUpdate(pfmsinitiationdetaildto, UserId, Details);
//
//			if (count > 0) {
//				redir.addAttribute("result", "Project Details (" + Alert + ") Edited Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Initiation Edit Unsuccessful");
//			}
//
//		}
//
//		redir.addFlashAttribute("detailsedit", Details);
//		redir.addFlashAttribute("details", Details);
//		redir.addFlashAttribute("IntiationId", InitiationId);
//		redir.addFlashAttribute("TabId", "1");
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectInitiationDetailsSubmit.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//	}
//	
//
//	@RequestMapping(value = "ProjectAttachmentAdd.htm", method = RequestMethod.POST)
//	public String ProjectAttachmentAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectAttachmentAdd.htm "+UserId);
//		
//		try {
//		String IntiationId = req.getParameter("IntiationId");
//
//		req.setAttribute("IntiationId", IntiationId);
//		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//		req.setAttribute("filesize",file_size);
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectAttachmentAdd.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//
//		return "project/ProjectAttachmentAdd";
//	}
//	
//	@RequestMapping(value = "ProjectAttachmentAddSubmit.htm", method = RequestMethod.POST)
//	public String ProjectAttachmentAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
//			@RequestPart("FileAttach") MultipartFile FileAttach) throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//		String LabCode = (String) ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectAttachmentAddSubmit.htm "+UserId);
//		
//		try {
//		String option = req.getParameter("sub");
//		if (option.equalsIgnoreCase("SUBMIT")) {
//
//			PfmsInitiationAttachmentDto pfmsinitiationattachmentdto = new PfmsInitiationAttachmentDto();
//			PfmsInitiationAttachmentFileDto pfmsinitiationattachmentfiledto = new PfmsInitiationAttachmentFileDto();
//			pfmsinitiationattachmentdto.setFileName(req.getParameter("FileName"));
//			pfmsinitiationattachmentdto.setInitiationId(req.getParameter("IntiationId"));
//			pfmsinitiationattachmentdto.setFileNamePath(
//					req.getParameter("FileName") + "." + FileAttach.getOriginalFilename().split("\\.")[1]);
//			pfmsinitiationattachmentfiledto.setLabCode(LabCode);
//			pfmsinitiationattachmentfiledto.setFileAttach(FileAttach);
//
//			Long count = service.ProjectInitiationAttachmentAdd(pfmsinitiationattachmentdto,
//					pfmsinitiationattachmentfiledto, UserId);
//
//			if (count > 0) {
//				redir.addAttribute("result", "Project Attachment Added Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Attachment Add Unsuccessful");
//			}
//
//		}
//
//		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//		redir.addFlashAttribute("TabId", "4");
//		}catch (Exception e) {
//			
//			
//			
//			logger.error(new Date() +" Inside ProjectAttachmentAddSubmit.htm "+UserId, e);
//			e.printStackTrace();
//    		
//
//			
//		}
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//	}
//
//	@RequestMapping(value = "ProjectAttachmentDelete.htm", method = RequestMethod.POST)
//	public String ProjectAttachmentDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectAttachmentDelete.htm "+UserId);
//		
//		try {
//
//		int count = service.ProjectInitiationAttachmentDelete(req.getParameter("InitiationAttachmentId"), UserId);
//
//		if (count > 0) {
//			redir.addAttribute("result", "Project Attachment Deleted Successfully");
//		} else {
//			redir.addAttribute("resultfail", "Project Attachment Delete Unsuccessful");
//		}
//
//		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//		redir.addFlashAttribute("TabId", "4");
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectAttachmentDelete.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//	}
//
//	@RequestMapping(value = "ProjectAttachmentEdit.htm", method = RequestMethod.POST)
//	public String ProjectAttachmentEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectAttachmentEdit.htm "+UserId);
//		
//		try {
//
//		String IntiationId = req.getParameter("IntiationId");
//
//		req.setAttribute("IntiationId", IntiationId);
//		req.setAttribute("InitiationAttachmentId", req.getParameter("InitiationAttachmentId"));
//		req.setAttribute("FileName",service.ProjectIntiationAttachmentFileName(req.getParameter("InitiationAttachmentId")));
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectAttachmentEdit.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//		return "project/ProjectAttachmentEdit";
//	}
//
//	@RequestMapping(value = "ProjectAttachmentUpdate.htm", method = RequestMethod.POST)
//	public String ProjectAttachmentUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectAttachmentUpdate.htm "+UserId);
//		
//		try {
//		String option = req.getParameter("sub");
//		if (option.equalsIgnoreCase("SUBMIT")) {
//			
//
//			int count = service.ProjectInitiationAttachmentUpdate(req.getParameter("InitiationAttachmentId"),
//					req.getParameter("FileName"), UserId);
//
//			if (count > 0) {
//				redir.addAttribute("result", "Project Attachment Updated Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Attachment Update Unsuccessful");
//			}
//
//		}
//
//		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//		redir.addFlashAttribute("TabId", "4");
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectAttachmentUpdate.htm "+UserId, e);
//			e.printStackTrace();
//    		return "static/Error";
//		}
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//	}
//
//	@RequestMapping(value = "ProjectAttachDownload.htm", method = RequestMethod.GET)
//	public void ProjectAttachDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
//			throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectAttachDownload.htm "+UserId);
//		
//		try {
//		  //String FilenamePath = service.ProjectIntiationAttachmentFileNamePath(req.getParameter("InitiationAttachmentId"));
//
//			 res.setContentType("Application/octet-stream");	
//				
//			 PfmsInitiationAttachmentFile attachment=service.ProjectIntiationAttachmentFile(req.getParameter("InitiationAttachmentId" ));
//			 Object[]  pfmsinitiation = service.ProjectIntiationFileName(attachment.getInitiationAttachmentId());
//				File my_file=null;
//			
//				my_file = new File(uploadpath+attachment.getFilePath()+File.separator+attachment.getFileName()); 
//		        res.setHeader("Content-disposition","attachment; filename="+pfmsinitiation[3].toString()); 
//		        OutputStream out = res.getOutputStream();
//		        FileInputStream in = new FileInputStream(my_file);
//		        byte[] buffer = new byte[4096];
//		        int length;
//		        while ((length = in.read(buffer)) > 0){
//		           out.write(buffer, 0, length);
//		        }
//		        in.close();
//		        out.flush();
//		        out.close();
//
//		}catch (Exception e) {
//
//			
//			logger.error(new Date() +" Inside ProjectAttachDownload.htm "+UserId, e);
//			e.printStackTrace();
//    		//return "static/Error";
//		}
//
//	}
//
//	@RequestMapping(value = "ProjectAuthorityAdd.htm", method = RequestMethod.POST)
//	public String ProjectAuthorityAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectAuthorityAdd.htm "+UserId);
//		String LabCode = (String)ses.getAttribute("labcode");
//		try {
//		String IntiationId = req.getParameter("IntiationId");
//		String Option=req.getParameter("option");
//		
//		req.setAttribute("IntiationId", IntiationId);
//		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(IntiationId)).get(0));
//		req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
//		req.setAttribute("filesize",file_size);
//		
//		if(Option.equalsIgnoreCase("edit")) {
//		req.setAttribute("ProjectAuthorityDetails", service.AuthorityAttachment(IntiationId).get(0));
//		}
//		
//		req.setAttribute("Option", Option);
//		
//		}catch (Exception e) {
//			logger.error(new Date() +" Inside ProjectAuthorityAdd.htm "+UserId, e);
//			e.printStackTrace();
//    		
//		}
//
//		return "project/ProjectAuthorityAdd";
//	}
//	
//	
//	@RequestMapping(value = "ProjectAuthorityAddSubmit.htm", method = RequestMethod.POST)
//	public String ProjectAuthorityAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
//			@RequestPart("FileAttach") MultipartFile FileAttach) throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//		String labcode = (String)ses.getAttribute("labcode"); 
//		logger.info(new Date() +"Inside ProjectAuthorityAddSubmit.htm "+UserId);
//		
//		try {
//		String option = req.getParameter("sub");
//		if (option.equalsIgnoreCase("SUBMIT")) {
//
//			PfmsInitiationAuthorityDto pfmsinitiationauthoritydto = new PfmsInitiationAuthorityDto();
//			
//			PfmsInitiationAuthorityFileDto pfmsinitiationauthorityfiledto = new PfmsInitiationAuthorityFileDto();
//			
//			pfmsinitiationauthoritydto.setAuthorityName(req.getParameter("authorityname"));
//			pfmsinitiationauthoritydto.setInitiationId(req.getParameter("IntiationId"));
//			pfmsinitiationauthoritydto.setLetterDate(req.getParameter("startdate"));
//			pfmsinitiationauthoritydto.setLetterNo(req.getParameter("letterno"));
//			pfmsinitiationauthorityfiledto.setFilePath(labcode);
//			pfmsinitiationauthorityfiledto.setAttachFile(FileAttach);
//			pfmsinitiationauthorityfiledto.setAttachementName(	req.getParameter("letterno") + "." + FileAttach.getOriginalFilename().split("\\.")[1]);
//			
//			Long count = service.ProjectInitiationAuthorityAdd(pfmsinitiationauthoritydto, UserId,pfmsinitiationauthorityfiledto);
//
//			if (count > 0) {
//				redir.addAttribute("result", "Project Authority Added Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Authority Add Unsuccessful");
//			}
//
//		}
//
//		redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//		redir.addFlashAttribute("TabId", "5");
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectAuthorityAddSubmit.htm "+UserId, e);
//			e.printStackTrace();
//    		//return "static/Error";
//		}
//		return "redirect:/ProjectIntiationDetailesLanding.htm";
//	}
//	
//	
//	@RequestMapping(value = "ProjectAuthorityDownload.htm", method = RequestMethod.GET)
//	public void ProjectAuthorityDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
//			throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectAuthorityDownload.htm "+UserId);
//		try
//		{
//			PfmsInitiationAuthorityFile attachment=service.ProjectAuthorityDownload(req.getParameter("AuthorityFileId"));
//			
//			res.setContentType("application/octet-stream");
//			
//				File my_file=null;	
//				my_file = new File(uploadpath+attachment.getFile()+File.separator+attachment.getAttachmentName()); 
//		        res.setHeader("Content-disposition","attachment; filename="+attachment.getAttachmentName()); 
//		        OutputStream out = res.getOutputStream();
//		        FileInputStream in = new FileInputStream(my_file);
//		        byte[] buffer = new byte[4096];
//		        int length;
//		        while ((length = in.read(buffer)) > 0){
//		           out.write(buffer, 0, length);
//		        }
//		        in.close();
//		        out.flush();
//		        out.close();
//		}catch (Exception e) {
//			
//			e.printStackTrace(); logger.error(new Date() +"Inside ProjectAuthorityDownload.htm "+UserId,e);
//		}
//	}
//	
//	@RequestMapping(value="ProjectAuthorityEditSubmit.htm",method=RequestMethod.POST)
//	public String ProjectAuthorityEditSubmit(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses,@RequestPart("FileAttach") MultipartFile FileAttach )throws Exception
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		String labCode =(String)ses.getAttribute("labcode"); 
//		logger.info(new Date() +"Inside ProjectAuthorityEditSubmit.htm "+UserId);
//		try
//		{
//			String option = req.getParameter("sub");
//			if (option.equalsIgnoreCase("SUBMIT")) {
//			PfmsInitiationAuthorityDto pfmsinitiationauthoritydto = new PfmsInitiationAuthorityDto();
//
//			PfmsInitiationAuthorityFileDto pfmsinitiationauthorityfiledto = new PfmsInitiationAuthorityFileDto();
//
//			pfmsinitiationauthoritydto.setAuthorityName(req.getParameter("authorityname"));
//			pfmsinitiationauthoritydto.setInitiationId(req.getParameter("IntiationId"));
//			pfmsinitiationauthoritydto.setLetterDate(req.getParameter("startdate"));
//			pfmsinitiationauthoritydto.setLetterNo(req.getParameter("letterno"));
//			
//			
//			pfmsinitiationauthorityfiledto.setAttachementName(req.getParameter("letterno"));
//			pfmsinitiationauthorityfiledto.setAttachFile(FileAttach);
//			pfmsinitiationauthorityfiledto.setFilePath(labCode);
//			pfmsinitiationauthorityfiledto.setInitiationAuthorityFileId(req.getParameter("attachmentid"));
//			
//			
//			long count = 0;
//			count=	service.ProjectAuthorityUpdate(pfmsinitiationauthoritydto,pfmsinitiationauthorityfiledto,UserId);
//			
//				if (count > 0) {
//					redir.addAttribute("result", "Authority Edited Successfully");
//				} else {
//					redir.addAttribute("resultfail", "Authority Edit Unsuccessful");
//					
//				}
//			}
//			redir.addFlashAttribute("IntiationId", req.getParameter("IntiationId"));
//			redir.addFlashAttribute("TabId", "5");
//			}catch (Exception e) {
//				e.printStackTrace(); logger.error(new Date() +" Inside ProjectAuthorityEditSubmit.htm "+UserId, e);
//				e.printStackTrace();
//	    		
//			}
//			return "redirect:/ProjectIntiationDetailesLanding.htm";
//	}
//
//	@RequestMapping(value = "PreviewPage.htm", method = RequestMethod.POST)
//	public String PreviewPage(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside PreviewPage.htm "+UserId);
//		
//		try {
//		String InitiationId = req.getParameter("InitiationId");
//
//		
//
//		req.setAttribute("ProjectDetailsPreview", service.ProjectDetailsPreview(Long.parseLong(InitiationId)).get(0));
//		req.setAttribute("ScheduleList", service.ProjectIntiationScheduleList(InitiationId));
//		req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(InitiationId));
//		req.setAttribute("CostList", service.ProjectIntiationCostList(InitiationId));
//		req.setAttribute("IntiationAttachment", service.ProjectIntiationAttachment(InitiationId));
//		req.setAttribute("AuthorityAttachment", service.AuthorityAttachment(InitiationId));
//
//		
//		}
//		catch (Exception e) 
//		{
//			e.printStackTrace(); 
//			logger.error(new Date() +" Inside PreviewPage.htm "+UserId, e);		
//    		return "static/Error";
//		}
//
//		return "project/ProjectPreview";
//
//	}
//
//	@RequestMapping(value = "ProjectIntiationForward.htm", method = RequestMethod.POST)
//	public String ProjectIntiationForward(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectIntiationForward.htm "+UserId);
//		
//		try {
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//
//
//		String InitiationId = req.getParameter("InitiationId");
//		String ProjectCode=req.getParameter("projectcode");
//		String PDD=req.getParameter("pdd");
//
//		Long ProjectForwardStatuscount = service.ProjectForwardStatus(InitiationId);
//		if (ProjectForwardStatuscount > 0) {
//
//			int count = service.ProjectIntiationStatusUpdate(InitiationId, UserId, PDD,ProjectCode);
//
//			if (count > 0) {
//				redir.addAttribute("result", "Project Forwarded Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Forward Unsuccessful");
//			}
//		} else {
//			redir.addAttribute("resultfail", "Project Initiation Not Complete");
//		}
//
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectIntiationForward.htm "+UserId, e);
//			e.printStackTrace();
//    		//return "static/Error";
//		}
//		return "redirect:/ProjectIntiationList.htm";
//
//	}
//	
//	@RequestMapping(value = "ProjectApprovalAd.htm", method = RequestMethod.GET)
//	public String ProjectApprovalAd(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)
//			throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectApprovalAd.htm "+UserId);
//		
//		try {
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//
//		req.setAttribute("ProjectActionList", service.ProjectActionList("3"));
//		req.setAttribute("ProjectApproveAdList", service.ProjectApproveAdList(EmpId));
//
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalAd.htm "+UserId, e);
//			e.printStackTrace();
//    		//return "static/Error";
//		}
//
//		return "project/ProjectApprovalAD";
//	}
//	
//	@RequestMapping(value = "ProjectApprovalAdSubmit.htm", method = RequestMethod.POST)
//	public String ProjectApprovalAdSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectApprovalAdSubmit.htm "+UserId);
//		
//		try {
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//		
//		String InitiationId = req.getParameter("IntiationId");
//		String Remark = req.getParameter("Remark");
//		String ProjectCode=req.getParameter("projectcode");
//		String Status=req.getParameter("Status");
//		int count = service.ProjectApproveAd(InitiationId, Remark, UserId, EmpId,ProjectCode,Status);
//
//		if (count > 0) {
//			redir.addAttribute("result", "Project Forwarded Successfully");
//		} else {
//			redir.addAttribute("resultfail", "Project Forward Unsuccessful");
//		}
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalAdSubmit.htm "+UserId, e);
//			e.printStackTrace();
//    		//return "static/Error";
//		}
//
//		return "redirect:/ProjectApprovalAd.htm";
//
//	}
//
//	@RequestMapping(value = "ProjectApprovalPd.htm", method = RequestMethod.GET)
//	public String ProjectApprovalPd(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)
//			throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectApprovalPd.htm "+UserId);		
//		try {
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//
//		req.setAttribute("ProjectActionList", service.ProjectActionList("1"));
//		req.setAttribute("ProjectApprovePdList", service.ProjectApprovePdList(EmpId));
//
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalPd.htm "+UserId, e);
//			e.printStackTrace();
//    		//return "static/Error";
//		}
//
//		return "project/ProjectApprovalPd";
//	}
//
//	@RequestMapping(value = "ProjectApprovalPdSubmit.htm", method = RequestMethod.POST)
//	public String ProjectApprovalPdSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectApprovalPdSubmit.htm "+UserId);
//		
//		try {
//			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//			
//			String InitiationId = req.getParameter("IntiationId");
//			String Remark = req.getParameter("Remark");
//			String ProjectCode=req.getParameter("projectcode");
//			String Status=req.getParameter("Status");
//			
//			int count = service.ProjectApprovePd(InitiationId, Remark, UserId, EmpId,ProjectCode,Status);
//	
//			if (count > 0) {
//				redir.addAttribute("result", "Project Forwarded Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Forward Unsuccessful");
//			}
//			}catch (Exception e) {
//				e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalPdSubmit.htm "+UserId, e);
//				e.printStackTrace();
//	    		return "static/Error";
//			}
//		return "redirect:/ProjectApprovalPd.htm";
//	}
//
//
//
//
//	@RequestMapping(value = "ProjectApprovalTracking.htm", method = RequestMethod.GET)
//	public String ProjectApprovalTracking(HttpSession ses, HttpServletRequest req, RedirectAttributes redir)
//			throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectApprovalTracking.htm "+UserId);
//		
//		try {
//		String InitiationId = req.getParameter("Initiationid");
//
//		req.setAttribute("ProjectApprovalTracking", service.ProjectApprovalTracking(InitiationId));
//		req.setAttribute("InitiationId", InitiationId);
//		req.setAttribute("ProjectDetailes", service.ProjectDetailes(Long.parseLong(InitiationId)).get(0));
//		
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalTracking.htm "+UserId, e);
//		}
//
//		return "project/ProjectApprovalTracking";
//	}
//
//	
//
//
//	@RequestMapping(value = "ProjectApprovalRtmddo.htm", method = RequestMethod.GET)
//	public String ProjectApprovalRtmddo(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)
//			throws Exception {
//		
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectApprovalRtmddo.htm "+UserId);
//		
//		try {
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//
//		req.setAttribute("ProjectActionList", service.ProjectActionList("2"));
//		req.setAttribute("ProjectApproveRtmddoList", service.ProjectApproveRtmddoList(EmpId));
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalRtmddo.htm "+UserId, e);
//		}
//
//		return "project/ProjectApprovalRtmddo";
//	}
//
//	@RequestMapping(value = "ProjectApprovalRtmddoSubmit.htm", method = RequestMethod.POST)
//	public String ProjectApprovalRtmddoSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectApprovalRtmddoSubmit.htm "+UserId);
//		
//		try {
//			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();	
//			String InitiationId = req.getParameter("IntiationId");
//			String Remark = req.getParameter("Remark");
//			String ProjectCode=req.getParameter("projectcode");
//			String Status=req.getParameter("Status");
//			
//			int count = service.ProjectApproveRtmddo(InitiationId, Remark, UserId, EmpId,ProjectCode,Status);
//			
//			if (count > 0) {
//				redir.addAttribute("result", "Project Forwarded Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Forward Unsuccessful");
//			}
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalRtmddoSubmit.htm "+UserId, e);
//		}
//		return "redirect:/ProjectApprovalRtmddo.htm";
//	}
//
//	@RequestMapping(value = "ProjectApprovalTcc.htm", method = RequestMethod.GET)
//	public String ProjectApprovalTcc(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)
//			throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectApprovalTcc.htm "+UserId);
//		
//		try {
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//
//		req.setAttribute("ProjectActionList", service.ProjectActionList("4"));
//		req.setAttribute("ProjectApproveTccList", service.ProjectApproveTccList(EmpId));
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalTcc.htm "+UserId, e);
//		}
//
//		return "project/ProjectApprovalTcc";
//	}
//
//	@RequestMapping(value = "ProjectApprovalTccSubmit.htm", method = RequestMethod.POST)
//	public String ProjectApprovalTccSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		
//		String UserId = (String) ses.getAttribute("Username");
//
//		logger.info(new Date() +"Inside ProjectApprovalTccSubmit.htm "+UserId);
//		
//		try {
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//		
//		String InitiationId = req.getParameter("IntiationId");
//		String Remark = req.getParameter("Remark");
//		String ProjectCode=req.getParameter("projectcode");
//		String Status=req.getParameter("Status");
//		int count = service.ProjectApproveTcc(InitiationId, Remark, UserId, EmpId,ProjectCode,Status);
//
//		if (count > 0) {
//			redir.addAttribute("result", "Project Forwarded Successfully");
//		} else {
//			redir.addAttribute("resultfail", "Project Forward Unsuccessful");
//		}
//
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectApprovalTccSubmit.htm "+UserId, e);
//		}
//		return "redirect:/ProjectApprovalTcc.htm";
//
//	}
//
//	@RequestMapping(value = "TCCAdd.htm", method = RequestMethod.GET)
//	public String TCCAdd(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside TCCAdd.htm "+UserId);
//		
//		try {
//		req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside TCCAdd.htm "+UserId, e);
//		}
//
//		return "project/TCCAdd";
//	}
//
//
//	@RequestMapping(value = "TCCScheduleAdd.htm", method = RequestMethod.GET)
//	public String TCCScheduleAdd(HttpServletRequest req, HttpSession ses) throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside TCCScheduleAdd.htm "+UserId);
//		return "project/TCCSchedule";
//	}
//
//
//	@RequestMapping(value ="ProjectMain.htm")
//	public String ProjectMain(Model model, HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectMain.htm "+Username);
//	try {
//		 String onboard=req.getParameter("Onboarding");
//			if(onboard==null) {
//				Map md=model.asMap();
//				onboard=(String)md.get("Onboard");
//			}
//		req.setAttribute("Onboarding", onboard);
//		req.setAttribute("ProjectMainList", service.ProjectMainList());
//		
//	}catch (Exception e) {
//		e.printStackTrace(); logger.error(new Date() +" Inside ProjectMain.htm "+Username, e);
//	}
//		return "project/ProjectMainList";
// 
//	}
//	
//	@RequestMapping(value = "ProjectMainSubmit.htm")
//	public String ProjectMainSubmit(HttpSession ses, HttpServletRequest req, RedirectAttributes redir) throws Exception {
//		long count=0;
//		long check=0;
//		String Username = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectMainSubmit.htm  "+Username);
//		try {
//			  String sub=req.getParameter("action");
//			  
//			  if("add".equalsIgnoreCase(sub)) {
//				  
//				  req.setAttribute("ProjectTypeList", service.PfmsCategoryList());
//				  req.setAttribute("SecurityClassificationList",service.ProjectTypeList());
//				  req.setAttribute("OfficerList", service.OfficerList());
//				  req.setAttribute("SecurityClassificationList",service.ProjectTypeList());
//				  return "project/ProjectMainAdd";
//			 }
//	         if("submit".equalsIgnoreCase(sub) || "save".equalsIgnoreCase(sub)) 
//	         {        	 
//	     		 String pcode=req.getParameter("pcode");
//	     		 String pname=req.getParameter("pname");
//	     		 String desc=req.getParameter("desc");
//	     		
//	     		 String projectdirector=req.getParameter("projectdirector");
//	     		 String ProjectsancAuthority=req.getParameter("ProjectsancAuthority");
//	     		
//	     		 String unicode=req.getParameter("unicode");
//	     		 String sano=req.getParameter("sano");
//	     		 String sadate=req.getParameter("sadate");
//	     		 String tsancost=req.getParameter("tsancost");
//	     		 String sancostre=req.getParameter("sancostre");
//	     		 String sancostfe=req.getParameter("sancostfe");
//	     		 String pdc=req.getParameter("pdc");
//	     		 String BOR=req.getParameter("bor");
//	     		 String projectType=req.getParameter("projecttype");
//	     		 String isMainWC=req.getParameter("ismainwc");
//	     		 String WCname=req.getParameter("wcname");
//	     		 String Objective=req.getParameter("Objective");
//	     		 String Deliverable=req.getParameter("Deliverable");
//	     		 String NodalName=req.getParameter("Nodal");
//	     		 String securityClassification=req.getParameter("securityClassification");
//	     		 String scope=req.getParameter("scope");
//	     		 
//	     		 
//	     		 ProjectMain protype=new ProjectMain();
//	     		 protype.setIsMainWC(Integer.parseInt(isMainWC));
//				 protype.setWorkCenter(WCname);
//	          	 protype.setProjectCode(pcode);
//	       	     protype.setProjectName(pname);
//	       	     protype.setProjectDescription(desc);
//	         	 protype.setUnitCode(unicode);
//	         	 protype.setSanctionNo(sano);
//	         	 protype.setBoardReference(BOR);
//	             protype.setProjectTypeId(Long.parseLong(projectType));
//	             protype.setCategoryId(Long.parseLong(securityClassification));
//	             protype.setProjectDirector(Long.parseLong(projectdirector));
//				 protype.setProjSancAuthority(ProjectsancAuthority);
//				 protype.setSanctionDate(new java.sql.Date(sdf2.parse(sadate).getTime()));
//				 protype.setTotalSanctionCost(Double.parseDouble(tsancost.trim()));
//				 protype.setSanctionCostRE(Double.parseDouble(sancostre.trim()));
//				 protype.setScope(scope);
//				 
//				 if(sancostfe!=null && sancostfe.length() >0)
//				 {
//					 protype.setSanctionCostFE(Double.parseDouble(sancostfe.trim()));
//				 }
//				 protype.setPDC(new java.sql.Date(sdf2.parse(pdc).getTime()));
//				 protype.setObjective(Objective.trim());
//				 protype.setDeliverable(Deliverable.trim());
//	             protype.setLabParticipating(NodalName.trim());
//				 protype.setRevisionNo(Long.parseLong("0"));
//				 protype.setIsActive(1);
//	
//	       	     protype.setCreatedBy(Username);
//	         	 protype.setCreatedDate(sdf1.format(new Date()));
//	       	  
//	        	
//	        	count=service.ProjectMainAdd(protype);
//	        	if("submit".equalsIgnoreCase(sub)) {
//		        	if(count>0  ) 
//		        	{
//		        		redir.addAttribute("result","Project Main Added Successfully");
//		  			}else
//		  			{
//		  				redir.addAttribute("resultfail","Project Main Adding  Unsuccessfully");
//		  			}
//		        	
//		        	return "redirect:/ProjectMain.htm";
//	        	}
//	        	
//	        	if("save".equalsIgnoreCase(sub)) {
//		        	if(count>0  ) 
//		        	{
//		        		redir.addAttribute("result","Project Main Saved Successfully");
//		        		redir.addAttribute("action","edit");
//		        		redir.addAttribute("ProjectMainId",count);
//		        		return "redirect:/ProjectMainSubmit.htm";
//		  			}else
//		  			{
//		  				redir.addAttribute("resultfail","Project Main Saved Unsuccessfully");
//		  				return "redirect:/Project.htm";
//		  			}
//	        	}
//	        	
//			  }
//	         if("edit".equalsIgnoreCase(sub)) {
//	        	  String ProjectMainId=req.getParameter("ProjectMainId");
//	        	  req.setAttribute("ProjectMainId", ProjectMainId);
//	        	  req.setAttribute("ProjectTypeList", service.PfmsCategoryList());
//				  req.setAttribute("OfficerList", service.OfficerList());
//				  req.setAttribute("ProjectMainEditData", service.ProjectMainEditData(ProjectMainId));
//				  req.setAttribute("SecurityClassificationList",service.ProjectTypeList());
//				  
//	        	 return "project/ProjectMainEdit";
//			  }
//	         if("editsubmit".equalsIgnoreCase(sub)) {
//	        	 String ProjectMainId=req.getParameter("ProjectMainId");
//	        	 String pcode=req.getParameter("pcode");
//	     		 String pname=req.getParameter("pname");
//	     		 String desc=req.getParameter("desc");
//	     		 String projectdirector=req.getParameter("projectdirector");
//	     		 String ProjectsancAuthority=req.getParameter("ProjectsancAuthority");
//	     		 String unicode=req.getParameter("unicode");
//	     		 String sano=req.getParameter("sano");
//	     		 String sadate=req.getParameter("sadate");
//	     		 String tsancost=req.getParameter("tsancost");
//	     		 String sancostre=req.getParameter("sancostre");
//	     		 String sancostfe=req.getParameter("sancostfe");
//	     		 String pdc=req.getParameter("pdc");
//	     		 String BOR=req.getParameter("bor");
//	     		 String projectType=req.getParameter("projecttype");
//	     		 String securityClassification=req.getParameter("securityClassification");
//	     		 String isMainWC=req.getParameter("ismainwc");
//	     		 String WCname=req.getParameter("wcname");
//	     		 String Objective=req.getParameter("Objective");
//	     		 String Deliverable=req.getParameter("Deliverable");
//	     		 String NodalLab=req.getParameter("Nodal");
//	     		 String scope=req.getParameter("scope");
//	     		
//	     		 ProjectMain protype=new ProjectMain();
//	     		 protype.setIsMainWC(Integer.parseInt(isMainWC));
//				 protype.setWorkCenter(WCname);
//	          	 protype.setProjectCode(pcode);
//	       	     protype.setProjectName(pname);
//	       	     protype.setProjectDescription(desc);
//	         	 protype.setUnitCode(unicode);
//	         	 protype.setSanctionNo(sano);
//	         	 protype.setBoardReference(BOR);
//	             protype.setProjectTypeId(Long.parseLong(projectType));
//	             protype.setCategoryId(Long.parseLong(securityClassification));
//	             protype.setProjectDirector(Long.parseLong(projectdirector));
//				 protype.setProjSancAuthority(ProjectsancAuthority);
//				 protype.setSanctionDate(new java.sql.Date(sdf2.parse(sadate).getTime()));
//				 protype.setTotalSanctionCost(Double.parseDouble(tsancost.trim()));
//				 protype.setSanctionCostRE(Double.parseDouble(sancostre.trim()));
//				 protype.setScope(scope);
//				 if(sancostfe!=null && sancostfe.length() >0)
//				 {
//					 protype.setSanctionCostFE(Double.parseDouble(sancostfe.trim()));
//				 }
//				 protype.setPDC(new java.sql.Date(sdf2.parse(pdc).getTime()));
//				 protype.setObjective(Objective.trim());
//				 protype.setDeliverable(Deliverable.trim());
//				 protype.setLabParticipating(NodalLab.trim());
//				 protype.setRevisionNo(Long.parseLong("0"));
//				 protype.setIsActive(1);
//	       	     protype.setModifiedBy(Username);
//	         	 protype.setModifiedDate(sdf1.format(new Date()));
//	         	 protype.setProjectMainId(Long.parseLong(ProjectMainId));
//	       	  
//	        	 count=service.ProjectMainEdit(protype);
//	        	 if(count>0) {
//	  				redir.addAttribute("result","Project Main Edited Successfully");
//	  			
//	  			}
//	  			else
//	  			{
//	  				redir.addAttribute("resultfail","Project Main Editing  Unsuccessfully");
//	  				
//	  			}
//	        	 
//	        	
//	        	 return "redirect:/ProjectMain.htm";
//			  }
//	         if("close".equalsIgnoreCase(sub)) {
//	        	 String ProjectMainId=req.getParameter("ProjectMainId");
//	        	 ProjectMain protype=new ProjectMain();
//	        	 protype.setProjectMainId(Long.parseLong(ProjectMainId));
//	        	 protype.setModifiedBy(Username);
//	        	 protype.setModifiedDate(sdf1.format(new Date()));
//	        	 count=service.ProjectMainClose(protype);
//	        	 if(count>0) {
//	  				redir.addAttribute("result","Project Closed Successfully");
//	  			
//	  			}else
//	  			{
//	  				redir.addAttribute("resultfail","Project Closing  Unsuccessfully");
//	  				
//	  			}
//	         }
//		
//	}catch (Exception e) {
//		e.printStackTrace(); logger.error(new Date() +" Inside ProjectMainSubmit.htm  "+Username, e);
//	}
//		return "redirect:/ProjectMain.htm";
//	}
//	
//	@RequestMapping(value = "ProjectList.htm")
//	public String ProjectList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses.getAttribute("Username");
//		String LabCode=(String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectList.htm "+Username);
//	try {
//		
//		req.setAttribute("ProjectList", service.ProjectList().stream().filter(e-> e[14]!=null).filter(e->LabCode.equalsIgnoreCase(e[14].toString())).collect(Collectors.toList()) );
//		
//	}catch (Exception e) {
//		e.printStackTrace(); logger.error(new Date() +" Inside ProjectList.htm "+Username, e);
//	}
//		return "project/ProjectList";
//
//	}
//	
//	
//	@RequestMapping(value = "ProjectSubmit.htm")
//	public String ProjectSubmit(HttpSession ses, HttpServletRequest req, RedirectAttributes redir) throws Exception 
//	{
//		long count=0;
//		
//		String Username = (String) ses.getAttribute("Username");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectSubmit.htm "+Username);
//		try {      	
//		  String sub=req.getParameter("action");
//		 
//		  if("add".equalsIgnoreCase(sub)) 
//		  {
//			  
//			  req.setAttribute("ProjectMainListNotAdded", service.ProjectTypeMainListNotAdded());
//			  req.setAttribute("ProjectTypeMainList", service.ProjectTypeMainList());
//			  List<Object[]> ProjectMainList=service.ProjectTypeMainList();
//			  List<Object[]> ProjectCatSecDetalis=new ArrayList<>();
//			  if(ProjectMainList.size()>0 && ProjectMainList!=null)
//			  {
//				  ProjectCatSecDetalis=service.getProjectCatSecDetalis(ProjectMainList.get(0)[0].toString());
//			  }
//			  req.setAttribute("ProjectCatSecDetalis", ProjectCatSecDetalis);
//			  req.setAttribute("OfficerList", service.OfficerList().stream().filter(e-> LabCode.equalsIgnoreCase(e[9].toString())).collect(Collectors.toList()));
//			  req.setAttribute("CategoryList", service.ProjectCategoryList());
//        	  req.setAttribute("ProjectTypeList", service.PfmsCategoryList());
//			  return "project/ProjectAdd";
//		  }
//         if("submit".equalsIgnoreCase(sub)) 
//         {
//        	 
//     		 String pcode=req.getParameter("pcode");
//     		 String pname=req.getParameter("pname");
//     		 String desc=req.getParameter("desc");
//     		
//     		 String projectdirector=req.getParameter("projectdirector");
//     		 String ProjectsancAuthority=req.getParameter("ProjectsancAuthority");
//     		
//     		 String unicode=req.getParameter("unicode");
//     		 String sano=req.getParameter("sano");
//     		 String sadate=req.getParameter("sadate");
//     		 String tsancost=req.getParameter("tsancost");
//     		 String sancostre=req.getParameter("sancostre");
//     		 String sancostfe=req.getParameter("sancostfe");
//     		 String pdc=req.getParameter("pdc");
//     		 String BOR=req.getParameter("bor");
//     		 String projectType=req.getParameter("projecttype");
//     		 
//     		 String enduser= req.getParameter("enduser");
//     		 String projectshortname = req.getParameter("projectshortname");
//     		 
////     		 Object[] promaindata=service.ProjectMainEditData(projectType);
////     		 
////     		 String isMainWC=promaindata[16].toString();//req.getParameter("ismainwc");
//     		 
//     		 String WCname=req.getParameter("wcname");
//     		 String Objective=req.getParameter("Objective");
//     		 String Deliverable=req.getParameter("Deliverable");
//    		 String projectTypeID=req.getParameter("projectTypeID");
//
//     		 ProjectMaster protype=new ProjectMaster();
////     		 protype.setIsMainWC(Integer.parseInt(isMainWC));
//     		 protype.setProjectShortName(projectshortname);
//     		 protype.setEndUser(enduser);
//     		 protype.setIsMainWC(0);
//     		 protype.setWorkCenter(WCname);
//          	 protype.setProjectCode(pcode);
//       	     protype.setProjectName(pname);
//       	     protype.setProjectDescription(desc);
//         	 protype.setUnitCode(unicode);
//         	 protype.setSanctionNo(sano);
//         	 protype.setBoardReference(BOR);
//             protype.setProjectMainId(Long.parseLong(projectType));
//             protype.setProjectDirector(Long.parseLong(projectdirector));
//             protype.setProjectCategory(Long.parseLong(req.getParameter("projectcategory")));
//             protype.setProjectType(Long.parseLong(projectTypeID));
//			 protype.setProjSancAuthority(ProjectsancAuthority);
//			 protype.setSanctionDate(new java.sql.Date(sdf2.parse(sadate).getTime()));
//			 protype.setTotalSanctionCost(Double.parseDouble(tsancost.trim()));
//			 protype.setSanctionCostRE(Double.parseDouble(sancostre.trim()));
//			 if(sancostfe!=null && sancostfe.length() >0)
//			  {
//			 protype.setSanctionCostFE(Double.parseDouble(sancostfe.trim()));
//			  }
//			 protype.setPDC(new java.sql.Date(sdf2.parse(pdc).getTime()));
//			 protype.setObjective(Objective.trim());
//			 protype.setDeliverable(Deliverable.trim());
//			 protype.setRevisionNo(Long.parseLong("0"));
//			 protype.setIsActive(1);
//       	     protype.setCreatedBy(Username);
//         	 protype.setCreatedDate(sdf1.format(new Date()));
//         	 protype.setLabCode(LabCode);
//        	
//        	 count=service.ProjectMasterAdd(protype);
//        	 if(count>0) {
//  				redir.addAttribute("result","Project  Added Successfully");
//  			}else
//  			{
//  				redir.addAttribute("resultfail","Project  Adding  Unsuccessfully");
//  			}
//        	 
//        	
//        	 return "redirect:/ProjectList.htm";
//		  }
//         if("edit".equalsIgnoreCase(sub)) {
//        	 String ProjectId=req.getParameter("ProjectId");
//        	 req.setAttribute("ProjectId", ProjectId);
//       	     req.setAttribute("ProjectTypeMainList", service.ProjectTypeMainList());
//			 req.setAttribute("OfficerList", service.OfficerList());
//			 req.setAttribute("CategoryList", service.ProjectCategoryList());
//			 req.setAttribute("ProjectEditData", service.ProjectEditData1(ProjectId));
//        	 req.setAttribute("ProjectTypeList", service.PfmsCategoryList());
//        	  
//        	  
//        	 return "project/ProjectEdit";
//		  }else if("editsubmit".equalsIgnoreCase(sub)) {
//        	 String ProjectId=req.getParameter("ProjectId");
//        	 String pcode=req.getParameter("pcode");
//     		 String pname=req.getParameter("pname");
//     		 String desc=req.getParameter("desc");
//     		
//     		 String projectdirector=req.getParameter("projectdirector");
//     		 String ProjectsancAuthority=req.getParameter("ProjectsancAuthority");
//     		
//     		 String enduser= req.getParameter("enduser");
//     		 String projectshortname = req.getParameter("projectshortname");
//     		 
//     		 String unicode=req.getParameter("unicode");
//     		 String sano=req.getParameter("sano");
//     		 String sadate=req.getParameter("sadate");
//     		 String tsancost=req.getParameter("tsancost");
//     		 String sancostre=req.getParameter("sancostre");
//     		 String sancostfe=req.getParameter("sancostfe");
//     		 String pdc=req.getParameter("pdc");
//     		 String BOR=req.getParameter("bor");
//     		 String projectType=req.getParameter("projecttype");
//     		 String isMainWC=req.getParameter("ismainwc");
//     		 String WCname=req.getParameter("wcname");
//     		 String Objective=req.getParameter("Objective");
//     		 String Deliverable=req.getParameter("Deliverable");
//     		 String projectTypeID=req.getParameter("projectTypeID");
//     		 ProjectMaster protype=new ProjectMaster();
////     		 protype.setIsMainWC(Integer.parseInt(isMainWC));
////			 protype.setWorkCenter(WCname);
//     		 protype.setProjectShortName(projectshortname);
//     		 protype.setEndUser(enduser);
//          	 protype.setProjectCode(pcode);
//       	     protype.setProjectName(pname);
//       	     protype.setProjectDescription(desc);
//         	 protype.setUnitCode(unicode);
//         	 protype.setSanctionNo(sano);
//         	 protype.setBoardReference(BOR);
//             protype.setProjectMainId(Long.parseLong(projectType));
//             protype.setProjectDirector(Long.parseLong(projectdirector));
//             protype.setProjectCategory(Long.parseLong(req.getParameter("projectcategory")));
//             protype.setProjectType(Long.parseLong(projectTypeID));
//			 protype.setProjSancAuthority(ProjectsancAuthority);
//			 protype.setSanctionDate(new java.sql.Date(sdf2.parse(sadate).getTime()));
//			 protype.setTotalSanctionCost(Double.parseDouble(tsancost.trim()));
//			 protype.setSanctionCostRE(Double.parseDouble(sancostre.trim()));
//			 if(sancostfe!=null && sancostfe.length() >0)
//			  {
//			 protype.setSanctionCostFE(Double.parseDouble(sancostfe.trim()));
//			  }
//			 protype.setPDC(new java.sql.Date(sdf2.parse(pdc).getTime()));
//			 protype.setObjective(Objective.trim());
//			 protype.setDeliverable(Deliverable.trim());
//			 protype.setRevisionNo(Long.parseLong("0"));
//			 protype.setIsActive(1);
//			 protype.setModifiedBy(Username);
//         	 protype.setModifiedDate(sdf1.format(new Date()));
//         	 protype.setProjectId(Long.parseLong(ProjectId));
//        	 count=service.ProjectEdit(protype);
//        	 if(count>0) {
//  				redir.addAttribute("result","Project  Edited Successfully");
//	  		}else
//	  		{
//	  			redir.addAttribute("resultfail","Project Editing  Unsuccessfully");
//	  		}       	
//        	 return "redirect:/ProjectList.htm";
//		  }
//         
//         if("close".equalsIgnoreCase(sub)) {
//        	 String ProjectId=req.getParameter("ProjectId");
//        	 String ProjectType=req.getParameter("ProjectType");
//        	 ProjectMaster protype=new ProjectMaster();
//        	 protype.setProjectId(Long.parseLong(ProjectId));
//        	 protype.setModifiedBy(Username);
//        	 protype.setModifiedDate(sdf1.format(new Date()));
//        	 count=service.ProjectClose(protype);
//        	 if(count>0) {
//  				redir.addAttribute("result","Project Closed Successfully");
//  			
//  			}else
//  			{
//  				redir.addAttribute("resultfail","Project Closing  Unsuccessfully");
//  				
//  			}
//        	 	 return "redirect:/ProjectList.htm";
//		  }else if("mainaddsubmit".equalsIgnoreCase(sub))
//		  {
//			  String projectmainid=req.getParameter("projectmainid");
//			  
//			  count=0;
//			  count=service.ProjectMainToMaster(projectmainid, Username,LabCode);
//			  if(count>0) {
//	  				redir.addAttribute("result","Project Added Successfully");
//	  			
//	  			}else
//	  			{
//	  				redir.addAttribute("resultfail","Project Added Unsuccessfully");
//	  			}
//		  }
//		
//	}catch (Exception e) {
//		
//		e.printStackTrace(); logger.error(new Date() +" Inside ProjectSubmit.htm "+Username, e);
//	}
//		return "redirect:/ProjectList.htm";
//	}
//	
//	@RequestMapping(value = "ProjectAssign.htm")
//	public String ProjectAssign(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		String Username = (String) ses.getAttribute("Username");
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//		String Logintype= (String)ses.getAttribute("LoginType");
//		logger.info(new Date() +"Inside ProjectAssign.htm "+Username);
//	try {
//		return "redirect:/ProjectProSubmit.htm";
//	}catch (Exception e) {
//		e.printStackTrace();
//		logger.error(new Date() +" Inside ProjectAssign.htm "+Username, e);
//		return "ststic/Error";
//	}
//		
//	}
//	
//	
//	@RequestMapping(value = "ProjectProSubmit.htm",method ={RequestMethod.POST,RequestMethod.GET})
//	public String ProjectEmpSubmit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//
//		String Username = (String) ses .getAttribute("Username");
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//		String Logintype= (String)ses.getAttribute("LoginType");
//		String LabCode = (String)ses.getAttribute("labcode");
//		String ProjectId=null; 
//		logger.info(new Date() +"Inside ProjectProSubmit.htm "+Username);
//		try {
//		if(req.getParameter("ProjectId")!=null) {
//
//			ProjectId=(String)req.getParameter("ProjectId");
//		}else {
//	
//		 Map md = model.asMap();
//		    for (Object modelKey : md.keySet()) {
//		    	String	RedirData = (String) md.get(modelKey);
//		    	ProjectId=RedirData;
//		    }
//		}
//		List<Object[]> ProjectList = service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
//		if(ProjectId==null) {
//	
//			ProjectId=ProjectList.get(0)[0].toString();
//		}
//
//		req.setAttribute("ProjectAssignList", service.ProjectAssignList(ProjectId));
//		req.setAttribute("ProjectList", ProjectList);
//		req.setAttribute("OfficerList", service.UserList(ProjectId).stream().filter(e->e[2]!=null ).filter(e-> LabCode.equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()));
//		req.setAttribute("ProjectCode", service.ProjectData(ProjectId));
//		req.setAttribute("ProjectId", ProjectId);
//	}catch (Exception e) {
//     
//		e.printStackTrace(); logger.error(new Date() +" Inside ProjectProSubmit.htm "+Username, e);
//	}
//		return "project/ProjectAssign";
//
//	}
//	
//	@RequestMapping(value = "ProjectAssignSubmit.htm", method = RequestMethod.POST)
//	public String ProjectAssignSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		long count=0;
//		String Username = (String) ses .getAttribute("Username");
//		String ProjectId= req.getParameter("ProjectId");
//		String EmpId[]= req.getParameterValues("EmpId");
//		ProjectAssignDto proAssigndto=new ProjectAssignDto();
//		logger.info(new Date() +"Inside ProjectAssignSubmit.htm "+Username);
//	try {
//		
//		proAssigndto.setProjectId(ProjectId);
//		proAssigndto.setCreatedBy(Username);
//		proAssigndto.setCreatedDate(sdf1.format(new Date()));
//		proAssigndto.setEmpId(EmpId);
//    	count=service.ProjectAssignAdd(proAssigndto);
//    	 if(count>0) {
//				redir.addAttribute("result","Project Assigned Successfully");
//			}else
//			{
//				redir.addAttribute("resultfail","Project Assign  Unsuccessfully");
//			} 
//    	 
//    	 redir.addFlashAttribute("ProjectId", req.getParameter("ProjectId"));
//	}catch (Exception e) {
//		e.printStackTrace(); 
//		logger.error(new Date() +" Inside ProjectAssignSubmit.htm "+Username, e);
//	}
//		return "redirect:/ProjectProSubmit.htm";
//	}
//	
//	@RequestMapping(value = "ProjectRevokeSubmit.htm", method = RequestMethod.POST)
//	public String ProjectRevokeSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
//			throws Exception {
//		long count=0;
//		String Username = (String) ses .getAttribute("Username");
//		String ProjectEmployeeId= (String)req.getParameter("ProjectEmployeeId");
//		ProjectAssign proAssign=new ProjectAssign();
//		logger.info(new Date() +"Inside ProjectRevokeSubmit.htm "+Username);
//	try {
//		
//		proAssign.setProjectEmployeeId(Long.parseLong(ProjectEmployeeId));
//		proAssign.setModifiedBy(Username);
//		proAssign.setModifiedDate(sdf1.format(new Date()));
//		proAssign.setIsActive(0);
//    	 count=service.ProjectRevoke(proAssign);
//    	 if(count>0) {
//				redir.addAttribute("result","Project Revoked Successfully");
//			}else
//			{
//				redir.addAttribute("resultfail","Project Revoke  Unsuccessfully");
//			}
//    	 
//    	 redir.addFlashAttribute("ProjectId", req.getParameter("ProjectId"));
//	}catch (Exception e) {
//		e.printStackTrace(); logger.error(new Date() +" Inside ProjectRevokeSubmit.htm "+Username, e);
//	}
//	return "redirect:/ProjectProSubmit.htm";
//
//	}
//	
//
//	
//
//	@RequestMapping(value = "ApprovalStatusList.htm", method = RequestMethod.GET)
//	public @ResponseBody String ApprovalStatusList(HttpServletRequest req, HttpSession ses) throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//		List<Object[]> StatusList =null;
//		logger.info(new Date() +"Inside ApprovalStatusList.htm "+UserId);
//		
//		try {
//
//			StatusList = service.ApprovalStutusList(req.getParameter("InitiationId"));
//		}catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ApprovalStatusList.htm "+UserId, e);
//		}
//		Gson json = new Gson();
//		return json.toJson(StatusList);
//
//	}
//	
//	
//	@RequestMapping(value = "ProjectData.htm", method = {RequestMethod.GET,RequestMethod.POST})
//	public String ProjectData(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//		String LoginType=(String)ses.getAttribute("LoginType");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectData.htm "+Username);
//		try 
//		{
//			String projectid=req.getParameter("projectid");	
//			
//			if(projectid==null)
//			{
//				Map md=model.asMap();
//				projectid=(String)md.get("projectid");				
//			}	
//			List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,LoginType,LabCode);
//			
//			  if(projectlist.size()==0) 
//		        {				
//					redir.addAttribute("resultfail", "No Project is Assigned to you.");
//					return "redirect:/MainDashBoard.htm";
//				}
//			
//			
//			if(projectid==null) 
//			{
//				projectid=projectlist.get(0)[0].toString();
//			}
//			Object[] projectdatadetails=service.ProjectDataDetails(projectid);
//			
//			if(projectdatadetails!=null && projectdatadetails.length>0)
//			{
////				String configimgb64;
////				try
////				{
////					configimgb64 = Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[3])));
////				}catch (FileNotFoundException e) {
////					configimgb64=null;
////				}
////				String producttree;
////				
////				try
////				{
////						producttree=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[5])));
////				}catch (FileNotFoundException e) {
////					producttree=null;
////				}
////				String pearlimg;
////				try
////				{
////					pearlimg=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[6])));
////				}catch (FileNotFoundException e) {
////					pearlimg=null;
////				}
//				
////				req.setAttribute("configimgb64", configimgb64);
////				req.setAttribute("producttree", producttree);
////				req.setAttribute("pearlimg", pearlimg);
//				
//				req.setAttribute("projectdatadetails", projectdatadetails);
//				req.setAttribute("projectstagelist", service.ProjectStageDetailsList());
//				req.setAttribute("projectid", projectid);
//				req.setAttribute("projectlist", projectlist);
//				req.setAttribute("filesize",file_size);
//				return "project/ProjectDataView" ;
//			}
//								
//			req.setAttribute("projectstagelist", service.ProjectStageDetailsList());
//			req.setAttribute("projectid", projectid);
//			req.setAttribute("projectlist", projectlist);
//			req.setAttribute("filesize",file_size);
//		}
//		catch (Exception e) {
//			e.printStackTrace();
//			logger.error(new Date() +" Inside ProjectData.htm "+Username, e);
//			return "static/Error";
//		}
//		return "project/ProjectDataCollect";		
//	}
//	
//	
//	
//	@RequestMapping(value = "ProjectDataSubmit.htm", method = RequestMethod.POST)
//	public String ProjectDataSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
//			@RequestParam(name = "systemconfig" ,required = false) MultipartFile systemconfigimg,
//			@RequestParam(name ="systemspecsfile" ,required = false) MultipartFile systemspecsfile,
//			@RequestParam(name ="producttreeimg" ,required = false) MultipartFile producttreeimg,
//			@RequestParam(name ="pearlimg",required = false) MultipartFile pearlimg)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectDataSubmit.htm "+Username);
//		try 
//		{								
//			String projectid=req.getParameter("projectid");
//			String proclimit = req.getParameter("proclimit");
//			String pmrcdate=req.getParameter("pmrcdate");
//			String ebdate=	req.getParameter("ebdate");
//			PfmsProjectDataDto projectdatadto=new PfmsProjectDataDto();
//			
//			projectdatadto.setProjectId(projectid);
//			projectdatadto.setSystemConfigImg(systemconfigimg);
//			projectdatadto.setSystemSpecsFile(systemspecsfile);
//			projectdatadto.setProductTreeImg(producttreeimg);
//			projectdatadto.setPEARLImg(pearlimg);
//			projectdatadto.setProcLimit(proclimit);
//			projectdatadto.setCurrentStageId(req.getParameter("projectstageid"));
//			projectdatadto.setLastPmrcDate(new java.sql.Date(sdf2.parse(pmrcdate).getTime()));
//			projectdatadto.setLastEBDate(new java.sql.Date(sdf2.parse(ebdate).getTime()));
//			
//			projectdatadto.setCreatedBy(Username);
//			projectdatadto.setLabcode(LabCode);
////			String fileName = producttreeimg.getOriginalFilename();
////			String prefix = fileName.substring(fileName.lastIndexOf("."));
////			 
////			File file = null;
////			try {
////			 
////			     file = File.createTempFile(fileName, prefix);
////			     producttreeimg.transferTo(file);
////			} catch (Exception e) {
////			     e.printStackTrace();
////			            
////			}
////			
////			
////			BufferedImage bimg = ImageIO.read(file);
////			int width          = bimg.getWidth();
////			int height         = bimg.getHeight();
////			
//			
//			long count=service.ProjectDataSubmit(projectdatadto);
//			
//			if(count>0) 
//			{
//				redir.addAttribute("result","Project Data Added Successfully");
//			}
//			else
//			{
//				redir.addAttribute("resultfail","Project Data adding  Unsuccessful");
//			}
//			
//			redir.addFlashAttribute("projectid",projectid);
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectDataSubmit.htm "+Username, e);
//		}
//		return "redirect:/ProjectData.htm";
//		
//	}
//	
//	
//	
//	@RequestMapping(value = {"ProjectDataSystemSpecsFileDownload.htm"})
//	public void ProjectDataSystemSpecsFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectDataSystemSpecsFileDownload.htm "+UserId);
//		try
//		{
//			String ftype=req.getParameter("filename");
//			String projectdataid=req.getParameter("projectdataid");
//			res.setContentType("Application/octet-stream");	
//			Object[] projectdatafiledata=service.ProjectDataSpecsFileData(projectdataid);
//			File my_file=null;
//			int index=3;
//			if(ftype.equalsIgnoreCase("sysconfig")) 
//			{
//				index=4;
//			}else if(ftype.equalsIgnoreCase("protree"))
//			{
//				index=5;
//			}else if(ftype.equalsIgnoreCase("pearl"))
//			{
//				index=6;
//			}else if(ftype.equalsIgnoreCase("sysspecs"))
//			{
//				index=3;
//			}
//		
//			my_file = new File(uploadpath+projectdatafiledata[2]+File.separator+projectdatafiledata[index]); 
//	        res.setHeader("Content-disposition","attachment; filename="+projectdatafiledata[index].toString()); 
//	        OutputStream out = res.getOutputStream();
//	        FileInputStream in = new FileInputStream(my_file);
//	        byte[] buffer = new byte[4096];
//	        int length;
//	        while ((length = in.read(buffer)) > 0){
//	           out.write(buffer, 0, length);
//	        }
//	        in.close();
//	        out.flush();
//	        out.close();
//		}catch (Exception e) {
//				e.printStackTrace(); 
//				logger.error(new Date() +"Inside ProjectDataSystemSpecsFileDownload.htm "+UserId,e);
//		}
//	}
//	@RequestMapping(value = "ProjectDataEditSubmit.htm", method = RequestMethod.POST)
//	public String ProjectDataEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
//			@RequestParam(name = "systemconfig" ,required = false) MultipartFile systemconfigimg,
//			@RequestParam(name ="systemspecsfile" ,required = false) MultipartFile systemspecsfile,
//			@RequestParam(name ="producttreeimg" ,required = false) MultipartFile producttreeimg,
//			@RequestParam(name ="pearlimg",required = false) MultipartFile pearlimg)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectDataEditSubmit.htm "+Username);
//		try 
//		{		
//			long count=0;
//			
//			String rev=req.getParameter("rev");
//			String proclimit = req.getParameter("proclimit");
//			String projectid=req.getParameter("projectid");
//			String revisionno=req.getParameter("revisionno");
//			String pmrcdate=req.getParameter("pmrcdate");
//			String ebdate=req.getParameter("ebdate");
//			PfmsProjectDataDto projectdatadto=new PfmsProjectDataDto();
//			projectdatadto.setProjectDataId(req.getParameter("projectdataid"));
//			projectdatadto.setProjectId(projectid);
//			projectdatadto.setSystemConfigImg(systemconfigimg);			
//			projectdatadto.setSystemSpecsFile(systemspecsfile);
//			projectdatadto.setProductTreeImg(producttreeimg);
//			projectdatadto.setPEARLImg(pearlimg);
//			projectdatadto.setCurrentStageId(req.getParameter("projectstageid"));
//			projectdatadto.setProcLimit(proclimit);
//			projectdatadto.setLastPmrcDate(new java.sql.Date(sdf2.parse(pmrcdate).getTime()));
//			projectdatadto.setLastEBDate(new java.sql.Date(sdf2.parse(ebdate).getTime()));
//		
//		
//			projectdatadto.setModifiedBy(Username);
//			if(rev!=null && rev.equals("1"))
//			{
//				revisionno=String.valueOf(Long.parseLong(revisionno)+1);
//				service.ProjectDataRevSubmit(projectdatadto);
//			}
//			projectdatadto.setRevisionNo(revisionno);
//			projectdatadto.setLabcode(LabCode);
//			count=service.ProjectDataEditSubmit(projectdatadto);
//			
//			if(count>0) 
//			{	if(rev!=null && rev.equals("1"))
//				{
//					redir.addAttribute("result","Project Data Revised Successfully");
//				}else {
//					redir.addAttribute("result","Project Data Updated Successfully");
//				}
//			}
//			else
//			{
//				if(rev!=null && rev.equals("1"))
//				{
//					redir.addAttribute("resultfail","Project Data Revised  Unsuccessfully");
//				}else {
//					redir.addAttribute("resultfail","Project Data Update  Unsuccessfully");
//				}
//			}
//			
//			redir.addFlashAttribute("projectid",projectid);
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectDataEditSubmit.htm "+Username, e);
//		}
//		return "redirect:/ProjectData.htm";
//		
//	}
//	@RequestMapping(value = "ProjectDataRevList.htm", method = RequestMethod.POST)
//	public String ProjectDataRevSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//		String LoginType=(String)ses.getAttribute("LoginType");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectDataRevList.htm "+Username);
//		try 
//		{			
//			String projectid=req.getParameter("projectid");
//			String projectdatarevid=req.getParameter("projectdatarevid");
//			List<Object[]> ProjectDataRevList = service.ProjectDataRevList(projectid);
//			Object[] ProjectDataRevDataRaw=null;
//			if(projectdatarevid==null && ProjectDataRevList.size()>0)
//			{
//				projectdatarevid =ProjectDataRevList.get(0)[0].toString();
//			}
//			if( ProjectDataRevList.size()>0) 
//			{				
//				ProjectDataRevDataRaw=service.ProjectDataRevData(projectdatarevid);
//			}
//			
//			
//			String[] projectdatarevdata=new String[6];
//			if(ProjectDataRevDataRaw!=null)
//			{
////				try {
////					projectdatarevdata[0]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ProjectDataRevDataRaw[2]+File.separator+ProjectDataRevDataRaw[3])));
////				}catch (FileNotFoundException e) {
////					projectdatarevdata[0]=null;
////				}
////				try {
////					projectdatarevdata[1]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ProjectDataRevDataRaw[2]+File.separator+ProjectDataRevDataRaw[5])));;
////				}catch (FileNotFoundException e) {
////					projectdatarevdata[1]=null;
////				}
////				
////				try {
////					projectdatarevdata[2]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ProjectDataRevDataRaw[2]+File.separator+ProjectDataRevDataRaw[6])));;
////				}catch (FileNotFoundException e) {
////					projectdatarevdata[2]=null;
////				}
//				projectdatarevdata[3]=ProjectDataRevDataRaw[0].toString();
//				projectdatarevdata[4]=sdf2.format(sdf3.parse(ProjectDataRevDataRaw[11].toString()));	
//				projectdatarevdata[5]=	ProjectDataRevDataRaw[10].toString();
//			}
//			req.setAttribute("projectdatarevid",projectdatarevid);
//			req.setAttribute("projectdatarevlist",ProjectDataRevList);
//			req.setAttribute("projectdatarevdata", projectdatarevdata);
//			req.setAttribute("projectlist",service.LoginProjectDetailsList(EmpId,LoginType,LabCode));
//			req.setAttribute("projectid", projectid);
//			return "project/ProjectDataRevView";
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectDataRevList.htm "+Username, e);
//			return "static/Error";
//		}
//		
//		
//	}
//	
//	
//	@RequestMapping(value = "ProjectDataSystemSpecsRevFileDownload.htm", method = RequestMethod.POST)
//	public void ProjectDataSystemSpecsRevFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
//			throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectDataSystemSpecsRevFileDownload.htm "+UserId);
//		try
//		{
//			String ftype=req.getParameter("filename");
//			String projectdatarevid=req.getParameter("projectdatarevid");
//			Object[] projectdatafiledata=service.ProjectDataSpecsRevFileData(projectdatarevid);
//			 
//			int index=3;
//			if(ftype.equalsIgnoreCase("sysconfig")) 
//			{
//				index=4;
//			}else if(ftype.equalsIgnoreCase("protree"))
//			{
//				index=5;
//			}else if(ftype.equalsIgnoreCase("pearl"))
//			{
//				index=6;
//			}else if(ftype.equalsIgnoreCase("sysspecs"))
//			{
//				index=3;
//			}
//			
//	        res.setContentType("Application/octet-stream"); 
//	        File my_file = new File(uploadpath+projectdatafiledata[2]+File.separator+projectdatafiledata[index]); 
//	        res.setHeader("Content-disposition","attachment; filename="+projectdatafiledata[index].toString()); 
//	 
//	        	 
//	        OutputStream out = res.getOutputStream();
//	        FileInputStream in = new FileInputStream(my_file);
//	        byte[] buffer = new byte[4096];
//	        int length;
//	        while ((length = in.read(buffer)) > 0){
//	           out.write(buffer, 0, length);
//	        }
//	        in.close();
//	        out.flush();
//	        out.close();
//		}catch (Exception e) {
//				 e.printStackTrace(); logger.error(new Date() +"Inside ProjectDataSystemSpecsRevFileDownload.htm "+UserId,e);
//		}
//	}
//	
//	@RequestMapping(value = "ProjectRisk.htm", method = {RequestMethod.GET,RequestMethod.POST})
//	public String ProjectRisk(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectRisk.htm "+Username);
//		try 
//		{			
//			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//			String Logintype= (String)ses.getAttribute("LoginType");
//			String projectid=req.getParameter("projectid");	
//			if(projectid==null)
//			{
//				Map md=model.asMap();
//				projectid=(String)md.get("projectid");				
//			}	
//			List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
//			
//			if(projectlist.size()==0) 
//		    {	
//				redir.addAttribute("resultfail", "No Project is Assigned to you.");
//				return 	"redirect:/MainDashBoard.htm";
//			}
//			
//			
//			if(projectid==null) 
//			{
//				projectid="0";
//			}
//			
//			List<Object[]> riskdatalist=service.ProjectRiskDataList(projectid, LabCode);
//			
//			req.setAttribute("riskdatapresentlist",service.RiskDataPresentList(projectid,LabCode));
//			req.setAttribute("riskdatalist", riskdatalist);
//			req.setAttribute("projectid", projectid);
//			req.setAttribute("projectlist", projectlist);
//			
//			return "project/ProjectRisk";
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectRisk.htm "+Username, e);
//			return "static/Error";
//		}	
//	}
//	
//	
//	@RequestMapping(value = "ProjectRiskData.htm", method = {RequestMethod.GET,RequestMethod.POST})
//	public String ProjectRiskDate(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		
//		logger.info(new Date() +"Inside ProjectRiskData.htm "+Username);
//		try 
//		{
//			String actionmainid=req.getParameter("actionmainid");
//			if(actionmainid==null)
//			{
//				Map md=model.asMap();
//				actionmainid=(String)md.get("actionmainid");				
//			}
//			List<Object[]> projectlist=service.getProjectList();
//				
//			Object[] riskdata=service.ProjectRiskData(actionmainid);
//			String projectid=riskdata[2].toString();
//			
//			req.setAttribute("projectriskmatrixrevlist",service.ProjectRiskMatrixRevList(actionmainid));
//			req.setAttribute("riskmatrixdata",service.ProjectRiskMatrixData(actionmainid));
//			req.setAttribute("risktypelist",service.RiskTypeList());
//			req.setAttribute("riskdata", riskdata);
//			req.setAttribute("projectid", projectid);
//			req.setAttribute("projectlist", projectlist);
//			
//			return "project/ProjectRiskData";
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectRiskData.htm "+Username, e);
//			return "static/Error";
//		}
//	}
//	
//	
//	@RequestMapping(value = "ProjectRiskDataSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
//	public String ProjectRiskDataSubmit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectRiskDataSubmit.htm "+Username);
//		try 
//		{						
//			String actionmainid=req.getParameter("actionmainid");			
//			Object[] riskdata=service.ProjectRiskData(actionmainid);
//			String projectid=riskdata[2].toString();
//			
//			PfmsRiskDto dto=new PfmsRiskDto();
//			
//			dto.setDescription(riskdata[1].toString());
//			dto.setSeverity(req.getParameter("severity"));
//			dto.setProbability(req.getParameter("probability"));
//			dto.setMitigationPlans(req.getParameter("mitigationplans"));
//			dto.setImpact(req.getParameter("Impact"));
//			dto.setCategory(req.getParameter("category"));
//			dto.setRiskTypeId(req.getParameter("risk_type"));
//			dto.setActionMainId(riskdata[0].toString());
//			dto.setProjectId(projectid);
//			dto.setCreatedBy(Username);		
//			dto.setLabCode(LabCode);
//			long count=service.ProjectRiskDataSubmit(dto);
//			
//			if(count>0) 
//			{
//				redir.addAttribute("result","Project Risk Data Added Successfully");
//			}
//			else
//			{
//				redir.addAttribute("resultfail","Project Risk Data Adding Unsuccessfully");
//			}		
//			redir.addFlashAttribute("actionmainid", actionmainid);			
//			return "redirect:/ProjectRiskData.htm";
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectRiskDataSubmit.htm "+Username, e);
//			return "static/Error";
//		}
//	}
//	
//	
//	
//	@RequestMapping(value = "ProjectRiskDataEdit.htm", method = {RequestMethod.GET,RequestMethod.POST})
//	public String ProjectRiskDataEdit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectRiskDataEdit.htm "+Username);
//		try 
//		{						
//			String actionmainid=req.getParameter("actionmainid");			
//			Object[] riskdata=service.ProjectRiskData(actionmainid);
//			String projectid=riskdata[2].toString();
//			String rev=req.getParameter("rev");
//			String revisionno=req.getParameter("revisionno");
//			
//			PfmsRiskDto dto=new PfmsRiskDto();
//			dto.setRiskId(req.getParameter("riskid"));
//			dto.setDescription(riskdata[1].toString());
//			dto.setSeverity(req.getParameter("severity"));
//			dto.setProbability(req.getParameter("probability"));
//			dto.setMitigationPlans(req.getParameter("mitigationplans"));
//			dto.setImpact(req.getParameter("Impact"));
//			dto.setCategory(req.getParameter("category"));
//			dto.setRiskTypeId(req.getParameter("risk_type"));
//			dto.setActionMainId(riskdata[0].toString());			
//			dto.setProjectId(projectid);
//			dto.setModifiedBy(Username);			
//			
//			if(rev!=null && rev.equals("1"))
//			{
//				revisionno=String.valueOf(Long.parseLong(revisionno)+1);
//				service.ProjectRiskDataRevSubmit(dto);
//			}
//			dto.setRevisionNo(revisionno);
//			long count=service.ProjectRiskDataEdit(dto);
//			
//			if(count>0) 
//			{
//				if(rev!=null && rev.equals("1"))
//				{
//					redir.addAttribute("result","Project Risk Data Revised Successfully");
//				}else {
//					redir.addAttribute("result","Project Risk Data Edited Successfully");
//				}
//				projectdatarevdata[3]=ProjectDataRevDataRaw[0].toString();
//				projectdatarevdata[4]=sdf2.format(sdf3.parse(ProjectDataRevDataRaw[11].toString()));	
//				projectdatarevdata[5]=	ProjectDataRevDataRaw[10].toString();
//			}
//			req.setAttribute("projectdatarevid",projectdatarevid);
//			req.setAttribute("projectdatarevlist",ProjectDataRevList);
//			req.setAttribute("projectdatarevdata", projectdatarevdata);
//			req.setAttribute("projectlist",service.LoginProjectDetailsList(EmpId,LoginType,LabCode));
//			req.setAttribute("projectid", projectid);
//			return "project/ProjectDataRevView";
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectDataRevList.htm "+Username, e);
//			return "static/Error";
//		}
//		
//		
//	}
	
	
	@RequestMapping(value = "ProjectDataSystemSpecsRevFileDownload.htm", method = RequestMethod.POST)
	public void ProjectDataSystemSpecsRevFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectDataSystemSpecsRevFileDownload.htm "+UserId);
		try
		{
			String ftype=req.getParameter("filename");
			String projectdatarevid=req.getParameter("projectdatarevid");
			Object[] projectdatafiledata=service.ProjectDataSpecsRevFileData(projectdatarevid);
			 
			int index=3;
			if(ftype.equalsIgnoreCase("sysconfig")) 
			{
				index=4;
			}else if(ftype.equalsIgnoreCase("protree"))
			{
				index=5;
			}else if(ftype.equalsIgnoreCase("pearl"))
			{
				index=6;
			}else if(ftype.equalsIgnoreCase("sysspecs"))
			{
				index=3;
			}
			
	        res.setContentType("Application/octet-stream"); 
	        File my_file = new File(uploadpath+projectdatafiledata[2]+File.separator+projectdatafiledata[index]); 
	        res.setHeader("Content-disposition","attachment; filename="+projectdatafiledata[index].toString()); 
	 
	        	 
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
				 e.printStackTrace(); logger.error(new Date() +"Inside ProjectDataSystemSpecsRevFileDownload.htm "+UserId,e);
		}
	}
	

	

}
//			}
//			else
//			{
//				if(rev!=null && rev.equals("1"))
//				{
//					redir.addAttribute("resultfail","Project Risk Data Revision Unsuccessfully");
//				}else {
//					redir.addAttribute("resultfail","Project Risk Data Editing Unsuccessfully");
//				}
//			}
//			
//		
//			redir.addFlashAttribute("actionmainid", actionmainid);
//			
//			
//			return "redirect:/ProjectRiskData.htm";
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectRiskDataEdit.htm "+Username, e);
//			return "static/Error";
//		}	
//		
//	}
//	
//	
//	@RequestMapping(value = "projectCatSencDetalis", method = RequestMethod.GET)
//	public @ResponseBody String getCompEmp(HttpServletRequest request,HttpSession ses) throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		logger.info(new Date() +"Inside projectCatSencDetalis "+Username);
//	   String companyId=request.getParameter("project");
//	   List<Object[]> ProjectCatSecDetalis=new ArrayList<>();
//       ProjectCatSecDetalis=service.getProjectCatSecDetalis(companyId);
//	   Gson json = new Gson();
//	   
//	   return json.toJson(ProjectCatSecDetalis);
//	}
//	
//	
//	@RequestMapping(value = "ProjectMasterRev.htm", method = {RequestMethod.POST})
//	public String ProjectMasterRevisison(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectMasterRev.htm "+Username);
//		try 
//		{	
//			String projectid=req.getParameter("ProjectId");
//			req.setAttribute("projectid", projectid);
//			req.setAttribute("ProjectTypeMainList", service.ProjectTypeMainList());
//			req.setAttribute("OfficerList", service.OfficerList());
//			req.setAttribute("CategoryList", service.ProjectCategoryList());
//			req.setAttribute("ProjectEditData", service.ProjectEditData1(projectid));
//			req.setAttribute("ProjectTypeList", service.PfmsCategoryList());
//			return "project/ProjectMasterRev";
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectMasterRev.htm "+Username, e);
//			return "static/Error";
//		}	
//		
//	}
//	 
//	@RequestMapping(value = "ProjectMasterRevSubmit.htm", method = {RequestMethod.POST})
//	public String ProjectMasterRevSubmit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectMasterRevSubmit.htm "+Username);
//		try 
//		{	
//			
//			String ProjectId=req.getParameter("projectid");
//			String pcode=req.getParameter("pcode");
//			String pname=req.getParameter("pname");
//			String desc=req.getParameter("desc");
//			
//			String ProjectMainId=req.getParameter("ProjectMainId");
//			String projectdirector=req.getParameter("projectdirector");
//			String ProjectsancAuthority=req.getParameter("ProjectsancAuthority");
//			String unicode=req.getParameter("unicode");
//			String sano=req.getParameter("sano");
//			String sadate=req.getParameter("sadate");
//			String tsancost=req.getParameter("tsancost");
//			String sancostre=req.getParameter("sancostre");
//			String sancostfe=req.getParameter("sancostfe");
//			String pdc=req.getParameter("pdc");
//			String BOR=req.getParameter("bor");
//			
//			String projectshortcode = req.getParameter("projectshortname");
//			String enduser = req.getParameter("enduser");
//			
////			String projectType=req.getParameter("projecttype");
////			String isMainWC=req.getParameter("ismainwc");
////			String WCname=req.getParameter("wcname");
//			String Objective=req.getParameter("Objective");
//			String Deliverable=req.getParameter("Deliverable");
//			String projectTypeID=req.getParameter("projectTypeID");
//			ProjectMaster protype=new ProjectMaster();
//		//	 protype.setIsMainWC(Integer.parseInt(isMainWC));
//		//	 protype.setWorkCenter(WCname);
//		 	protype.setProjectCode(pcode);
//			protype.setProjectName(pname);
//			protype.setProjectDescription(desc);
//			protype.setUnitCode(unicode);
//			protype.setSanctionNo(sano);
//			protype.setBoardReference(BOR);
//			protype.setProjectMainId(Long.parseLong(ProjectMainId));
//			protype.setProjectDirector(Long.parseLong(projectdirector));
//			protype.setProjectCategory(Long.parseLong(req.getParameter("projectcategory")));
//			protype.setProjectType(Long.parseLong(projectTypeID));
//			protype.setProjSancAuthority(ProjectsancAuthority);
//			protype.setSanctionDate(new java.sql.Date(sdf2.parse(sadate).getTime()));
//			protype.setTotalSanctionCost(Double.parseDouble(tsancost.trim()));
//			protype.setSanctionCostRE(Double.parseDouble(sancostre.trim()));
//			if(sancostfe!=null && sancostfe.length() >0)
//			{
//			protype.setSanctionCostFE(Double.parseDouble(sancostfe.trim()));
//			}
//			protype.setPDC(new java.sql.Date(sdf2.parse(pdc).getTime()));
//			protype.setObjective(Objective.trim());
//			protype.setDeliverable(Deliverable.trim());
//			protype.setProjectShortName(projectshortcode);
//			protype.setEndUser(enduser);
//						
//			protype.setIsActive(1);
//			protype.setModifiedBy(Username);
//			protype.setModifiedDate(sdf1.format(new Date()));
//			protype.setProjectId(Long.parseLong(ProjectId));
//			
//			ProjectMasterRev rev = service.ProjectMasterREVSubmit(ProjectId, Username,req.getParameter("remarks"));
//			long count=0;
//			if(rev.getProjectRevId() >0) {
//				 protype.setRevisionNo(rev.getRevisionNo()+1); 
//				 count=service.ProjectEdit(protype);
//			}
//			if(count>0) 
//			{
//				redir.addAttribute("result","Project  Revision Successfully");
//			}else
//			{
//				redir.addAttribute("resultfail","Project Revision  Unsuccessfully");
//			}       	
//			return "redirect:/ProjectList.htm";
// 
//	 
//		}
//		catch (Exception e) {
//			e.printStackTrace(); 
//			logger.error(new Date() +" Inside ProjectMasterRevSubmit.htm "+Username, e);
//			return "static/Error";
//		}	
//	}
//	
//	
//	@RequestMapping(value = "ProjectMasterRevView.htm")
//	public String ProjectMasterRevView(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
//		String Username = (String) ses .getAttribute("Username");
//		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//		String Logintype= (String)ses.getAttribute("LoginType");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectMasterRevView.htm "+Username);
//		try 
//		{	
//			String projectid=req.getParameter("ProjectId");
//			req.setAttribute("projectid", projectid);
//			req.setAttribute("projectslist", service.LoginProjectDetailsList(EmpId,Logintype,LabCode));			
//			req.setAttribute("ProjectMasterRevList", service.ProjectRevList(projectid));
//			return "project/ProjectMasterRevView";
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectMasterRevView.htm "+Username, e);
//			return "static/Error";
//		}	
//		
//	}
//	
//	
//	@RequestMapping(value = "ProjectMasterAttach.htm", method = {RequestMethod.POST,RequestMethod.GET} )
//	public String ProjectMasterAttach(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
//	{		
//		String Username = (String) ses .getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectMasterAttach.htm "+Username);
//		try 
//		{	
//			String projectid = req.getParameter("ProjectId");
//			
//			if(projectid==null) {
//				Map md=model.asMap();
//				projectid=(String)md.get("ProjectId");
//			}	
//			
//			if(projectid==null) {
//				return "redirect:/ProjectList.htm";
//			}
//			
//			Object[] projectdata=service.ProjectData(projectid);
//			
//			
//			req.setAttribute("AttachList",service.ProjectMasterAttachList(projectid));
//			req.setAttribute("filesize", file_size);
//			req.setAttribute("projectid", projectid);
//			req.setAttribute("projectdata", projectdata);
//			return "project/ProjectAttachments";
//		}
//		catch (Exception e) {
//			e.printStackTrace(); logger.error(new Date() +" Inside ProjectMasterAttach.htm "+Username, e);
//			return "static/Error";
//		}	
//	}
//	
//	
//	
//	@RequestMapping(value = "ProjectMasterAttachAdd.htm", method = {RequestMethod.POST,RequestMethod.GET})
//	public String ProjectMasterAttachAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,	@RequestPart("attachment") MultipartFile[] FileAttach) throws Exception 
//	{
//
//		String UserId = (String) ses.getAttribute("Username");
//		String LabCode = (String)ses.getAttribute("labcode");
//		logger.info(new Date() +"Inside ProjectMasterAttachAdd.htm "+UserId);
//		
//		try {
//			String filenames[] = req.getParameterValues("filename");
//			String ProjectId = req.getParameter("ProjectId");			
//			
//			ProjectMasterAttachDto dto= new ProjectMasterAttachDto();  
//			
//			dto.setProjectId(ProjectId);
//			dto.setFileName(filenames);
//			dto.setFiles(FileAttach);
//			dto.setCreatedBy(UserId);
//			dto.setLabCode(LabCode);
//			
//			
//			long count=service.ProjectMasterAttachAdd(dto);
//			
//			if (count > 0) {
//				redir.addAttribute("result", "Project Attachment(s) Upload Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Attachment(s) Upload Unsuccessful");
//			}
//			
//			redir.addFlashAttribute("ProjectId", ProjectId);
//			return "redirect:/ProjectMasterAttach.htm";
//		}
//		catch (Exception e) 
//		{
//			logger.error(new Date() +" Inside ProjectMasterAttachAdd.htm "+UserId, e);
//			e.printStackTrace();
//			return "static/Error";
//		}
//	}
//	
//	@RequestMapping(value = "ProjectMasterAttachDownload.htm", method = {RequestMethod.POST,RequestMethod.GET} )
//	public void ProjectMasterAttachDownload(HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception
//	{	
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectMasterAttachDownload.htm "+UserId);
//		try
//		{
//			String attachid=req.getParameter("attachid");
//			
//			Object[] attachmentdata=service.ProjectMasterAttachData(attachid);
//			
//			File my_file=null;
//			my_file = new File(uploadpath+ attachmentdata[2]+File.separator+attachmentdata[3]);
//			
//			res.setContentType("Application/octet-stream");	
//	        res.setHeader("Content-disposition","attachment; filename="+attachmentdata[3].toString()); 
//	        OutputStream out = res.getOutputStream();
//	        FileInputStream in = new FileInputStream(my_file);
//	        byte[] buffer = new byte[4096];
//	        int length;
//	        while ((length = in.read(buffer)) > 0){
//	           out.write(buffer, 0, length);
//	        }
//	        in.close();
//	        out.flush();
//	        out.close();
//		}catch 
//		(Exception e) {
//			e.printStackTrace(); 
//			logger.error(new Date() +"Inside ProjectMasterAttachDownload.htm "+UserId,e);
//		}
//	}
//	
//	@RequestMapping(value = "ProjectMasterAttachDelete.htm", method = {RequestMethod.POST,RequestMethod.GET} )
//	public String ProjectMasterAttachDelete(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
//	{	
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectMasterAttachDelete.htm "+UserId);
//		try
//		{
//			String attachid=req.getParameter("attachid");
//			String projectid=req.getParameter("projectid");
//			int count=service.ProjectMasterAttachDelete(attachid);
//	
//
//			if (count > 0) {
//				redir.addAttribute("result", "Project Attachment Deleted Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Project Attachment Delete Unsuccessful");
//			}
//			redir.addFlashAttribute("ProjectId", projectid);
//			return "redirect:/ProjectMasterAttach.htm";
//			
//		}catch 
//		(Exception e) {
//			e.printStackTrace(); 
//			logger.error(new Date() +"Inside ProjectMasterAttachDelete.htm "+UserId,e);
//			return "static/Error";
//		}
//	}
//	
//	@RequestMapping(value = "TechnicalWorkDataAdd.htm", method = {RequestMethod.POST} )
//	public String TechnicalWorkDataAdd(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
//	{	
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside TechnicalWorkDataAdd.htm "+UserId);
//		try
//		{
//			String attachid=req.getParameter("attachid");
//			String projectid=req.getParameter("projectid");
//			String RelevantPoints=req.getParameter("RelevantPoints");
//			String committeeid = req.getParameter("committeeid");
//			
//			ProjectTechnicalWorkData modal = new ProjectTechnicalWorkData();
//			
//			modal.setRelatedPoints(RelevantPoints);
//			modal.setProjectId(Long.parseLong(projectid));
//			modal.setAttachmentId(Long.parseLong(attachid));
//			modal.setCreatedBy(UserId);
//			if(Long.parseLong(req.getParameter("TechDataId"))>0) {
//				service.TechnicalWorkDataEdit(modal,req.getParameter("TechDataId"));
//			}
//			long count=service.TechnicalWorkDataAdd(modal);
//	
//
//			if (count > 0) {
//				redir.addAttribute("result", "Data Added Successfully");
//			} else {
//				redir.addAttribute("resultfail", "Data Adding  Unsuccessful");
//			}
//			redir.addFlashAttribute("projectid", projectid);
//			redir.addFlashAttribute("committeeid", committeeid);
//			return "redirect:/ProjectBriefingPaper.htm";
//			
//		}catch (Exception e) {
//			e.printStackTrace(); 
//			logger.error(new Date() +"Inside TechnicalWorkDataAdd.htm "+UserId,e);
//			return "static/Error";
//		}
//	}
//	
//	@RequestMapping(value = "IntiationChecklist.htm", method = {RequestMethod.POST} )
//	public String IntiationChecklist(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
//	{	
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside IntiationChecklist.htm "+UserId);
//		try
//		{
//			String initiationid = req.getParameter("initiationid");
//			req.setAttribute("checklist", service.InitiationCheckList(initiationid));	
//			req.setAttribute("initiationid", initiationid);
//			req.setAttribute("initiationdata", service.InitiatedProjectDetails(initiationid).get(0));
//			return "project/InitiationChecklist";
//		}
//		catch (Exception e) {
//			e.printStackTrace(); 
//			logger.error(new Date() +"Inside IntiationChecklist.htm "+UserId,e);
//			return "static/Error";
//		}
//	}
//	
//	
//	@RequestMapping(value = "IntiationChecklistUpdate.htm", method = RequestMethod.GET)
//	public @ResponseBody String IntiationChecklistUpdate(HttpServletRequest req, HttpSession ses) throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//		long checklistitemid = 0;
//		logger.info(new Date() +"Inside IntiationChecklistUpdate.htm "+UserId);
//		
//		try {
//			String initiationid= req.getParameter("initiationid");
//			String checklistid= req.getParameter("checklistid");
//			
//			PfmsInitiationChecklistData cldata = new PfmsInitiationChecklistData(); 
//			cldata.setInitiationId(Long.parseLong(initiationid));
//			cldata.setChecklistId(Long.parseLong(checklistid));
//			cldata.setCreatedBy(UserId);
//			 checklistitemid  = service.IntiationChecklistUpdate(cldata);
//		}catch (Exception e) {
//			e.printStackTrace(); 
//			logger.error(new Date() +" Inside IntiationChecklistUpdate.htm "+UserId, e);		
//		}		
//		Gson json = new Gson();
//		return json.toJson(checklistitemid);
//
//	}
//	
//	@RequestMapping(value = "IntiationChecklistDownload.htm", method = {RequestMethod.POST} )
//	public void IntiationChecklistDownload(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
//	{	
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside IntiationChecklistDownload.htm "+UserId);
//		try
//		{
//			String initiationid = req.getParameter("initiationid");
//			String clno = req.getParameter("clno");
//			req.setAttribute("checklist", service.InitiationCheckList(initiationid));	
//			req.setAttribute("initiationid", initiationid);
//			req.setAttribute("clno", clno);
//			req.setAttribute("initiationdata", service.InitiatedProjectDetails(initiationid).get(0));
//			
//			String filename = "Checklist-0"+clno;
//			String path=req.getServletContext().getRealPath("/view/temp");
//			req.setAttribute("path",path);
//			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
//			req.getRequestDispatcher("/view/project/InitiationChecklistDownload.jsp").forward(req, customResponse);
//			String html = customResponse.getOutput();
//			byte[] data = html.getBytes();
//			InputStream fis1=new ByteArrayInputStream(data);
//			PdfDocument pdfDoc = new PdfDocument(new PdfWriter(path+"/"+filename+".pdf"));	
//		    pdfDoc.setTagged();
//	        HtmlConverter.convertToPdf(fis1,pdfDoc);
//	        res.setContentType("application/pdf");
//	        res.setHeader("Content-disposition","attachment;filename="+filename+".pdf"); 
//	        File f=new File(path+"/"+filename+".pdf");
//	        FileInputStream fis = new FileInputStream(f);
//	        DataOutputStream os = new DataOutputStream(res.getOutputStream());
//	        res.setHeader("Content-Length",String.valueOf(f.length()));
//	        byte[] buffer = new byte[1024];
//	        int len = 0;
//	        while ((len = fis.read(buffer)) >= 0) {
//	            os.write(buffer, 0, len);
//	        } 
//	        os.close();
//	        fis.close();
//	        
//	        
//	        Path pathOfFile2= Paths.get(path+"/"+filename+".pdf"); 
//	        Files.delete(pathOfFile2);		
//			
//		}
//		catch (Exception e) {
//			e.printStackTrace(); 
//			logger.error(new Date() +"Inside IntiationChecklistDownload.htm "+UserId,e);
//		}
//	}
//	
//	@RequestMapping(value = "ActionIssue.htm")
//	public String ActionIssue(Model model , HttpServletRequest req, HttpSession ses ,RedirectAttributes redir) throws Exception {
//
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ActionIssue.htm "+UserId);
//		
//		try {
//			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//			String LabCode = (String)ses.getAttribute("labcode");
//			String Logintype= (String)ses.getAttribute("LoginType");
//			String projectid=req.getParameter("projectid");	
//			if(projectid==null)
//			{
//				Map md=model.asMap();
//				projectid=(String)md.get("projectid");				
//			}	
//			List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
//			
//			if(projectlist.size()==0) 
//		    {	
//				redir.addAttribute("resultfail", "No Project is Assigned to you.");
//				return 	"redirect:/MainDashBoard.htm";
//			}
//			
//			
//			if(projectid==null) 
//			{
//				projectid="0";
//			}
//			
//			List<Object[]> issuedatalist=service.GetIssueList(projectid,"", LabCode);
//			
//			req.setAttribute("issuedatapresentlist",service.IsuueDataPresentList(projectid,LabCode));
//			req.setAttribute("issuedatalist", issuedatalist);
//			req.setAttribute("projectid", projectid);
//			req.setAttribute("projectlist", projectlist);
//			
//			
//				return "Issue/Issuelist";
//		}catch(Exception e){
//
//			e.printStackTrace(); 
//			logger.error(new Date() +" Inside ActionIssue.htm "+UserId, e);		
//			return "ststic/Error";	
//		}		
//		
//
//	}
//	@RequestMapping(value = "IssueUpdate.htm" , method = RequestMethod.POST)
//	public String IssueUpdate(Model model , HttpServletRequest req, HttpSession ses ,RedirectAttributes redir) throws Exception {
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside IssueUpdate.htm "+UserId);
//		
//		try{
//			
//
//			String actionmainid=req.getParameter("actionmainid");
//			if(actionmainid==null)
//			{
//				Map md=model.asMap();
//				actionmainid=(String)md.get("actionmainid");				
//			}
//			List<Object[]> projectlist=service.getProjectList();
//				
//			//Object[] riskdata=service.ProjectRiskData(actionmainid);
//			//String projectid=riskdata[2].toString();
//			
//			req.setAttribute("projectriskmatrixrevlist",service.ProjectRiskMatrixRevList(actionmainid));
//			req.setAttribute("riskmatrixdata",service.ProjectRiskMatrixData(actionmainid));
//			req.setAttribute("risktypelist",service.RiskTypeList());
//			//req.setAttribute("riskdata", riskdata);
//			//req.setAttribute("projectid", projectid);
//			req.setAttribute("projectlist", projectlist);
//			
//			return "Issue/IssueUpdate";
//		
//		}catch(Exception e){
//			e.printStackTrace();
//			logger.error(new Date() +" Inside IssueUpdate.htm "+UserId, e);		
//		}
//		return "Issue/IssueUpdate";
//	}
//	
//
//}
