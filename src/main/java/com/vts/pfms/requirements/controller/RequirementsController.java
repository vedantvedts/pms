package com.vts.pfms.requirements.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.admin.service.AdminService;
import com.vts.pfms.project.controller.ProjectController;
import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.requirements.model.Abbreviations;
import com.vts.pfms.requirements.model.DocMembers;
import com.vts.pfms.requirements.model.TestAcceptance;
import com.vts.pfms.requirements.model.TestApproach;
import com.vts.pfms.requirements.model.TestPlanSummary;
import com.vts.pfms.requirements.service.RequirementService;
import com.vts.pfms.utils.PMSLogoUtil;
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
@Controller
public class RequirementsController {
	@Autowired
	PMSLogoUtil LogoUtil;
	
	@Autowired
	ProjectService service;

	@Autowired
	RequirementService reqService;
	
	@Autowired
	ProjectService proservice;
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
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
				 List<Object[]> MainProjectList = service.LoginProjectDetailsList(EmpId,LoginType,LabCode);// main Project List
				 List <Object[]> InitiationProjectList = service.ProjectIntiationList(EmpId,LoginType,LabCode); // initiationProject
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
public String TestPlanOverAll(HttpServletRequest req,HttpSession ses, HttpServletResponse res,RedirectAttributes redir)throws Exception
{	
	String UserId=(String)ses.getAttribute("Username");
	String LabCode =(String ) ses.getAttribute("labcode");
	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	String LoginType=(String)ses.getAttribute("LoginType");
	logger.info(new Date() +"Inside TestPlanOverAll.htm"+UserId);
	try {
		String ProjectType= req.getParameter("ProjectType");
		String projectId = req.getParameter("projectId");
		String initiationId = req.getParameter("initiationId");
		if(ProjectType==null) {
			ProjectType="M";
		}
		req.setAttribute("ProjectType", ProjectType);
		 List<Object[]> MainProjectList = proservice.LoginProjectDetailsList(EmpId,LoginType,LabCode);// main Project List
		 List <Object[]> InitiationProjectList = service.ProjectIntiationList(EmpId,LoginType,LabCode); // initiationProject
		 
		 if(ProjectType.equalsIgnoreCase("M") && MainProjectList.isEmpty()) {
				redir.addAttribute("resultfail","No Project is Assigned to you!");
				ProjectType="I";
		 }
		 
		 if(ProjectType.equalsIgnoreCase("M")) {
		req.setAttribute("MainProjectList", MainProjectList);
		if(projectId==null) {
			projectId=MainProjectList.get(0)[0].toString();
			initiationId="0";
		}
		}else {
			if(InitiationProjectList.isEmpty()) {
				redir.addAttribute("resultfail","No Project is Assigned to you!");
				return  "redirect:/MainDashBoard.htm";
			}
			
			req.setAttribute("InitiationProjectList", InitiationProjectList);
			if(initiationId==null) {
				initiationId=InitiationProjectList.get(0)[0].toString();
				projectId="0";
			}
		}
		req.setAttribute("projectId", projectId);
		req.setAttribute("initiationId", initiationId);
		req.setAttribute("AbbreviationDetails",reqService.AbbreviationDetails(initiationId, projectId));
		req.setAttribute("MemberList", reqService.DocMemberList(initiationId,projectId));
		req.setAttribute("EmployeeList", service.EmployeeList1(LabCode,initiationId, projectId));
		req.setAttribute("TotalEmployeeList", service.EmployeeList(LabCode));
		req.setAttribute("LabList", service.LabListDetails(LabCode));
		req.setAttribute("DocumentSummary", reqService.getTestPlanDocumentSummary(initiationId,projectId));
		req.setAttribute("TestContent", reqService.GetTestContentList(initiationId, projectId));
	}catch (Exception e) {
		e.printStackTrace(); 
		logger.error(new Date() +" Inside TestPlanOverAll.htm "+UserId, e);
		return "static/Error";
	}
	return "requirements/ProjectTestPlan";
}



@RequestMapping(value="AbbreviationExcelUploads.htm" ,method = {RequestMethod.POST,RequestMethod.GET})
public String DivisionmasterExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
{
	 String UserId=(String)ses.getAttribute("Username");
	 String LabCode =(String) ses.getAttribute("labcode");
	 logger.info(new Date() +"Inside ExcelUploads.htm "+UserId);
		 try{
			String action = req.getParameter("Action"); 
			String initiationId=req.getParameter("initiationId");
			String projectId=req.getParameter("projectId");
			String ProjectType=req.getParameter("ProjectType");
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
					    	 

					    	 
					    	iA.setInitiationId(Long.parseLong(initiationId));
					    	iA.setProjectId(Long.parseLong(projectId));//bharath
					    	iA.setAbbreviationType("T");
					    if(iA.getAbbreviations()!=null && iA.getMeaning()!=null) {
					    	iaList.add(iA);
					    }
					    	
					     }
					    long Count= reqService.addAbbreviations(iaList);
					    if(Count>0) {
					    	redir.addAttribute("ProjectType",ProjectType);
						    redir.addAttribute("initiationId",initiationId);
						    redir.addAttribute("projectId",projectId);
					    	redir.addAttribute("result","Abbreviations Added Successfully");
					    	return "redirect:/ProjectTestPlan.htm";
					    }else {
					    	redir.addAttribute("ProjectType",ProjectType);
						    redir.addAttribute("initiationId",initiationId);
						    redir.addAttribute("projectId",projectId);
					    	redir.addAttribute("resultfail","Abbreviations Add UnSuccessfully");//bharath
					    	return "redirect:/ProjectTestPlan.htm";
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
			String initiationId=req.getParameter("initiationId");
			String projectId=req.getParameter("projectId");
			String ProjectType=req.getParameter("ProjectType");
			String [] Assignee = req.getParameterValues("Assignee");
			DocMembers rm = new DocMembers();
			rm.setProjectId(Long.parseLong(projectId));
			rm.setInitiationId(Long.parseLong(initiationId));
			rm.setCreatedBy(UserId);
			rm.setCreatedDate(sdf1.format(new Date()));
			rm.setEmps(Assignee);
			rm.setMemeberType("T");
			long count = reqService.AddDocMembers(rm);
			  if(count>0) {
				  	redir.addAttribute("ProjectType",ProjectType);
				    redir.addAttribute("initiationId",initiationId);
				    redir.addAttribute("projectId",projectId);
			    	redir.addAttribute("result","Members Added Successfully for Document Distribution");
			    	return "redirect:/ProjectTestPlan.htm";
			   
			  }else{
				  redir.addAttribute("ProjectType",ProjectType);
				  redir.addAttribute("initiationId",initiationId);
				  redir.addAttribute("projectId",projectId);
				  redir.addAttribute("resultfail","Document Summary adding unsuccessful ");
				    	return "redirect:/ProjectTestPlan.htm";
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
			String initiationId=req.getParameter("initiationId");
			String projectId=req.getParameter("projectId");
			String ProjectType=req.getParameter("ProjectType");
			req.setAttribute("initiationId", initiationId);
			req.setAttribute("projectId", projectId);
			req.setAttribute("ProjectType", ProjectType);
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
		logger.info(new Date() +"Inside RequiremnetIntroSubmit.htm "+UserId);
		try {
		String initiationId=req.getParameter("initiationId");
		String projectId=req.getParameter("projectId");
		String ProjectType=req.getParameter("ProjectType");
		String attributes=req.getParameter("attributes");
		String Details=req.getParameter("Details");
		Object[]TestScopeInto=reqService.TestScopeIntro(initiationId, projectId);
		long count=0l;
		if(TestScopeInto==null) {
			// this is for add
			count=reqService.TestScopeIntroSubmit(initiationId,projectId,attributes,Details,UserId);
		}else {
//			this is for edit 
			count=reqService.TestScopeUpdate(initiationId,projectId,attributes,Details,UserId);
			
		}
		if (count > 0) {
			 redir.addAttribute("ProjectType",ProjectType);
			 redir.addAttribute("initiationId",initiationId);
			redir.addAttribute("projectId",projectId);
			redir.addAttribute("attributes",req.getParameter("attributes"));
			redir.addAttribute("result", attributes+" updated Successfully");
			return "redirect:/TestScope.htm";
		} else {
			 redir.addAttribute("ProjectType",ProjectType);
			 redir.addAttribute("initiationId",initiationId);
			 redir.addAttribute("projectId",projectId);
			 redir.addAttribute("attributes",req.getParameter("attributes"));
			redir.addAttribute("resultfail", attributes+" update Unsuccessful");
			return "redirect:/TestScope.htm";
		}
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
			String initiationId=req.getParameter("initiationId");
			String projectId=req.getParameter("projectId");
			String ProjectType=req.getParameter("ProjectType");

			TestScopeIntroDetails=reqService.TestScopeIntro(initiationId,projectId);
		}
		catch(Exception e){
			e.printStackTrace();
			logger.error(new Date() +" Inside TestScopeIntroAjax.htm"+UserId, e);
		}
		Gson json = new Gson();
		return json.toJson(TestScopeIntroDetails);
	}
@RequestMapping(value = "TestDocumentDownlod.htm" )
	public String RequirementDocumentDownlodMain(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String ) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RequirementDocumentDownlod.htm "+UserId);
		try {
		
			Object[] DocTempAttributes =null;
			DocTempAttributes=service.DocTempAttributes();
			req.setAttribute("DocTempAttributes", DocTempAttributes);
			String initiationId=req.getParameter("initiationId");
			String projectId=req.getParameter("projectId");
			String ProjectType=req.getParameter("ProjectType");
			
			
			String filename="ProjectRequirement";
			String path=req.getServletContext().getRealPath("/view/temp");
		  	req.setAttribute("path",path);
		  	req.setAttribute("lablogo",  LogoUtil.getLabLogoAsBase64String(LabCode)); 
		  	req.setAttribute("LabImage",  LogoUtil.getLabImageAsBase64String(LabCode)); 
		  	req.setAttribute("LabList", service.LabListDetails(LabCode));
		  	req.setAttribute("uploadpath", uploadpath);
		  	req.setAttribute("TestScopeIntro",reqService.TestScopeIntro(initiationId, projectId));
			req.setAttribute("MemberList", reqService.DocMemberList(initiationId,projectId));
		  	req.setAttribute("DocumentSummary", reqService.getTestPlanDocumentSummary(initiationId, projectId));
		 	req.setAttribute("AbbreviationDetails",reqService.AbbreviationDetails(initiationId, projectId));
		 	req.setAttribute("TestContent", reqService.GetTestContentList(initiationId, projectId));
		 	req.setAttribute("AcceptanceTesting", reqService.GetAcceptanceTestingList(initiationId, projectId));
			
		 	String projectShortName="";
		 	String projectTitle="";
		 	
		 	if(Long.parseLong(initiationId)>0) {
		 		Object[]ProjectDetailes= service.ProjectDetailes(Long.parseLong(initiationId)).get(0);
		 		projectShortName=ProjectDetailes[6].toString();
		 		projectTitle=ProjectDetailes[7].toString();
		 		req.setAttribute("projectShortName", projectShortName);
		 		req.setAttribute("projectTitle", projectTitle);
		 	}
		 	
		 	if(Long.parseLong(projectId)>0) {
		 		Object[]ProjectEditData=service.ProjectEditData1(projectId);
		 		projectShortName=ProjectEditData[3].toString();
		 		projectTitle=ProjectEditData[4].toString();
		 		req.setAttribute("projectShortName", projectShortName);
		 		req.setAttribute("projectTitle", projectTitle);
		 	}
		 	
		
			File my_file=null;
			File my_file1=null;
			File my_file2=null;
			File my_file3=null;
			File my_file4=null;
			
		List<Object[]>list=	reqService.GetAcceptanceTestingList(initiationId, projectId);
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
				req.setAttribute("Testingtools", Testingtools);
				my_file2=new File(uploadpath+obj[4]+File.separator+obj[3]);
				if(my_file2!=null) {
					String htmlContentTestingtools = convertExcelToHtml(new FileInputStream(my_file2));
					req.setAttribute("htmlContentTestingtools", htmlContentTestingtools);
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
		logger.info(new Date() +"Inside RequirementSummaryAdd.htm "+UserId);
		try {
			String initiationId=req.getParameter("initiationId");
			String projectId=req.getParameter("projectId");
			String ProjectType=req.getParameter("ProjectType");
			String []reviewerList = req.getParameterValues("Reviewer");
			String reviewer = "";
		for(int i=0;i<reviewerList.length;i++) {
			reviewer=reviewer+reviewerList[i];
			if(i!=reviewerList.length-1) {
				reviewer+="/";
			}
			
		}
		TestPlanSummary rs = new TestPlanSummary();
			rs.setProjectId(Long.parseLong(projectId));
			rs.setInitiationId(Long.parseLong(initiationId));
			rs.setAbstract(req.getParameter("abstract"));
			rs.setAdditionalInformation(req.getParameter("information"));
			rs.setKeywords(req.getParameter("keywords"));
			rs.setDistribution(req.getParameter("distribution"));
			rs.setApprover(Long.parseLong(req.getParameter("Approver")));;
			rs.setCreatedBy(UserId);
			rs.setCreatedDate(sdf1.format(new Date()));
			rs.setIsActive(1);
			rs.setReviewer(reviewer);
	
			String action = req.getParameter("btn");
			String result="Document Summary added successfully";
			long count=0l;
			if(action.equalsIgnoreCase("submit")) {
				count=reqService.addTestPlanSummary(rs);
			}else if(action.equalsIgnoreCase("edit")) {
				rs.setSummaryId(Long.parseLong(req.getParameter("summaryid")));
				rs.setModifiedBy(UserId);
				rs.setModifiedDate(sdf1.format(new Date()));
				count=reqService.editTestPlanSummary(rs);
				result ="Document Summary edited successfully";
			}
			 if(count>0){
				 redir.addAttribute("ProjectType",ProjectType);
				 redir.addAttribute("initiationId",initiationId);
				 redir.addAttribute("projectId",projectId);
				 redir.addAttribute("result","Document Summary adding successful ");
			    	return "redirect:/ProjectTestPlan.htm";
					
			    }else{
			    	redir.addAttribute("ProjectType",ProjectType);
					 redir.addAttribute("initiationId",initiationId);
					 redir.addAttribute("projectId",projectId);
			    	redir.addAttribute("resultfail","Document Summary adding unsuccessful ");
			    	return "redirect:/ProjectTestPlan.htm";
			    }
		
		} catch (Exception e) {
			 logger.info(new Date() +"Inside testplanSummaryAdd.htm "+UserId);
			 return "static/Error";
		}
		
}
   @RequestMapping(value="TestApprochAdd.htm",method=RequestMethod.POST)
	public String TestApprochAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		
		String UserId=(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		String Logintype= (String)ses.getAttribute("LoginType");
		
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside RequirementSummaryAdd.htm "+UserId);
		try {
			String initiationId=req.getParameter("initiationId");
			String projectId=req.getParameter("projectId");
			String ProjectType=req.getParameter("ProjectType");
			TestApproach rs = new TestApproach();
			rs.setProjectId(Long.parseLong(projectId));
			rs.setInitiationId(Long.parseLong(initiationId));
			rs.setTestApproach(req.getParameter("TestApproach"));
			rs.setCreatedBy(UserId);
			rs.setCreatedDate(sdf1.format(new Date()));
			rs.setIsActive(1);
			String action = req.getParameter("btn");
			req.setAttribute("attributes", req.getParameter("attributes")==null?"Introduction":req.getParameter("attributes"));
			String result="Test Approach added successfully";
			long count=0l;
			if(action.equalsIgnoreCase("submit")) {
				count=reqService.addTestApproch(rs);
			} 
			 if(count>0){
				 redir.addAttribute("ProjectType",ProjectType);
				 redir.addAttribute("initiationId",initiationId);
				 redir.addAttribute("projectId",projectId);
				 redir.addAttribute("result","Test Approach adding successful ");
			    	return "redirect:/ProjectTestPlan.htm";
			    }else{
			    	redir.addAttribute("ProjectType",ProjectType);
					redir.addAttribute("initiationId",initiationId);
					redir.addAttribute("projectId",projectId);
			    	redir.addAttribute("resultfail","Test Approach adding unsuccessful ");
			    	return "redirect:/ProjectTestPlan.htm";
			    }
		} catch (Exception e) {
			 logger.info(new Date() +"Inside Test ApproachAdd.htm "+UserId);
			 return "static/Error";
		}
}
   @RequestMapping(value="TestDocContentSubmit.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String TestDocContentSubmit(HttpServletRequest req,HttpSession ses, RedirectAttributes redir) {
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside RequiremnetIntroSubmit.htm "+UserId);
		try {
		String initiationId=req.getParameter("initiationId");
		String projectId=req.getParameter("projectId");
		String ProjectType=req.getParameter("ProjectType");
		String attributes=req.getParameter("attributes");
		String Details=req.getParameter("Details");
		String action = req.getParameter("Action");
		String UpdateAction=req.getParameter("UpdateAction");
		
		long count=0l;
		if("add".equalsIgnoreCase(action)) {
			count=reqService.TestDocContentSubmit(initiationId,projectId,attributes,Details,UserId);
					} 
		 	else	{ 
					 //this is for edit
			count=reqService.TestDocContentUpdate(UpdateAction,Details,UserId);
			}
		if (count > 0) {
			redir.addAttribute("ProjectType",ProjectType);
			redir.addAttribute("initiationId",initiationId);
			redir.addAttribute("projectId",projectId);
			redir.addAttribute("attributes",req.getParameter("attributes"));
			redir.addAttribute("result", attributes+"  Successfully");
			return "redirect:/ProjectTestPlan.htm";
		} else {
			 redir.addAttribute("ProjectType",ProjectType);
			 redir.addAttribute("initiationId",initiationId);
			 redir.addAttribute("projectId",projectId);
			 redir.addAttribute("attributes",req.getParameter("attributes"));
			 redir.addAttribute("resultfail", attributes+"  Unsuccessful");
			return "redirect:/ProjectTestPlan.htm";
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "static/Error";
}
   @RequestMapping(value ="AccceptanceTesting.htm",method = {RequestMethod.POST,RequestMethod.GET})
	 public String RequirementAppendix( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception{
		 
		 String UserId=(String)ses.getAttribute("Username");
		 String LabCode =(String) ses.getAttribute("labcode");
		 logger.info(new Date() +"Inside AccceptanceTesting.htm "+UserId);
		 try {
			 	String initiationId=req.getParameter("initiationId");
				String projectId=req.getParameter("projectId");
				String ProjectType=req.getParameter("ProjectType");
				req.setAttribute("initiationId",initiationId);
				req.setAttribute("projectId",projectId);
				req.setAttribute("ProjectType",ProjectType);
				
				req.setAttribute("AcceptanceTesting", reqService.GetAcceptanceTestingList(initiationId, projectId));
		
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
				String initiationId=req.getParameter("initiationId");
				String projectId=req.getParameter("projectId");
				String ProjectType=req.getParameter("ProjectType");
				String attributes=req.getParameter("attributes");
				String Details=req.getParameter("Details");
				String action=req.getParameter("Action");
				String UpdateActionid=req.getParameter("UpdateActionid");
				String filename=req.getParameter("filenameC");
				
				System.out.println(FileAttach.isEmpty()+"---controller");
				TestAcceptance re = new TestAcceptance();
				
				
				
				re.setAttributes(attributes);
				re.setAttributesDetailas(Details);
				re.setInitiationId(Long.parseLong(initiationId));//bharath
				re.setProjectId(Long.parseLong(projectId));
				re.setFile(FileAttach);
				re.setCreatedBy(UserId);
				re.setCreatedDate(sdf1.format(new Date()));
				long count=0l;
				if("add".equalsIgnoreCase(action)) {
					 count = reqService.insertTestAcceptanceFile(re,LabCode);
				}
				else {
					count=reqService.TestAcceptancetUpdate(UpdateActionid,Details,UserId,FileAttach,LabCode);
				}
				if (count > 0) {
					redir.addAttribute("ProjectType",ProjectType);
					redir.addAttribute("initiationId",initiationId);
					redir.addAttribute("projectId",projectId);
					redir.addAttribute("result"," Data & Document Uploaded Successfully");
					return "redirect:/AccceptanceTesting.htm";
				} else {
					 redir.addAttribute("ProjectType",ProjectType);
					 redir.addAttribute("initiationId",initiationId);
					 redir.addAttribute("projectId",projectId);
					 redir.addAttribute("resultfail","Data & Document Uploaded UnSuccessfully");
					return "redirect:/AccceptanceTesting.htm";
				}
			} catch (Exception e) {
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
				Object[] projectdatafiledata =reqService.AcceptanceTestingList(Testid);
				
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
}
