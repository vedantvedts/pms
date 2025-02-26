package com.vts.pfms.milestone.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.pfms.Zipper;
import com.vts.pfms.committee.service.CommitteeService;
import com.vts.pfms.milestone.dto.FileDocAmendmentDto;
import com.vts.pfms.milestone.dto.FileProjectDocDto;
import com.vts.pfms.milestone.dto.FileUploadDto;
import com.vts.pfms.milestone.dto.MileEditDto;
import com.vts.pfms.milestone.dto.MilestoneActivityDto;
import com.vts.pfms.milestone.dto.MilestoneScheduleDto;
import com.vts.pfms.milestone.model.FileDocMaster;
import com.vts.pfms.milestone.model.FileRepMaster;
import com.vts.pfms.milestone.model.FileRepNew;
import com.vts.pfms.milestone.model.FileRepUploadNew;
import com.vts.pfms.milestone.model.MilestoneActivitySub;
import com.vts.pfms.milestone.service.MilestoneService;
import com.vts.pfms.print.model.ProjectTechnicalWorkData;


@Controller
public class MilestoneController {

	@Autowired CommitteeService committeservice;

	@Autowired
	MilestoneService service;

	private static final Logger logger=LogManager.getLogger(MilestoneController.class);
	@Value("${File_Size}")
	private String GlobalFileSize;

	@Value("${ApplicationFilesDrive}")
	private String FilePath;

	@RequestMapping(value = "MilestoneActivityList.htm")
	public String MilestoneActivityList(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{

		String UserId = (String) ses.getAttribute("Username");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MilestoneActivityList.htm "+UserId);		
		try {
			String ProjectId=req.getParameter("ProjectId");
			if(ProjectId==null)  {
				Map md=model.asMap();
				ProjectId=(String)md.get("ProjectId");
			}	
			List<Object[] > projlist= service.LoginProjectDetailsList(EmpId,Logintype,LabCode);

			if(projlist.size()==0) 
			{				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}



			if(ProjectId==null) {
				try {
					Object[] pro=projlist.get(0);
					ProjectId=pro[0].toString();
				}catch (Exception e) {

				}
			}
			List<Object[]> main=service.MilestoneActivityList(ProjectId);
			req.setAttribute("MilestoneActivityList",main );
			req.setAttribute("ProjectList",projlist);
			req.setAttribute("ProjectId", ProjectId);
			if(ProjectId!=null) {
				req.setAttribute("ProjectDetails", service.ProjectDetails(ProjectId).get(0));
				int MainCount=1;
				for(Object[] objmain:main ) {
					int countA=1;
					List<Object[]>  MilestoneActivityA=service.MilestoneActivityLevel(objmain[0].toString(),"1");
					req.setAttribute(MainCount+"MilestoneActivityA", MilestoneActivityA);
					for(Object[] obj:MilestoneActivityA) {
						List<Object[]>  MilestoneActivityB=service.MilestoneActivityLevel(obj[0].toString(),"2");
						req.setAttribute(MainCount+"MilestoneActivityB"+countA, MilestoneActivityB);
						int countB=1;
						for(Object[] obj1:MilestoneActivityB) {
							List<Object[]>  MilestoneActivityC=service.MilestoneActivityLevel(obj1[0].toString(),"3");
							req.setAttribute(MainCount+"MilestoneActivityC"+countA+countB, MilestoneActivityC);
							int countC=1;
							for(Object[] obj2:MilestoneActivityC) {
								List<Object[]>  MilestoneActivityD=service.MilestoneActivityLevel(obj2[0].toString(),"4");
								req.setAttribute(MainCount+"MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
								int countD=1;
								for(Object[] obj3:MilestoneActivityD) {
									List<Object[]>  MilestoneActivityE=service.MilestoneActivityLevel(obj3[0].toString(),"5");
									req.setAttribute(MainCount+"MilestoneActivityE"+countA+countB+countC+countD, MilestoneActivityE);
									countD++;
								}
								countC++;
							}
							countB++;
						}
						countA++;
					}
					MainCount++;
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside MilestoneActivityList.htm "+UserId, e); 
			return "static/Error";

		}
		return "milestone/MilestoneActivityList";
	}

	@RequestMapping(value = "M-A-AssigneeList.htm")
	public String MilestoneActivityAssigneeList(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside M-A-AssigneeList.htm "+UserId);		
		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String Logintype= (String)ses.getAttribute("LoginType");
			String ProjectId=req.getParameter("ProjectId");
			if(ProjectId==null)  {
				Map md=model.asMap();
				ProjectId=(String)md.get("ProjectId");
			}	
			List<Object[] > projlist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
			if(ProjectId==null) {
				try {
					Object[] pro=projlist.get(0);
					ProjectId=pro[0].toString();
				}catch (Exception e) {

				}
			}

			req.setAttribute("ProjectList", projlist);
			List<Object[]> main=service.MilestoneActivityAssigneeList(ProjectId,EmpId);
			req.setAttribute("MilestoneActivityList",main );	
			req.setAttribute("ProjectId", ProjectId);
			if(ProjectId!=null) {
				req.setAttribute("ProjectDetails", service.ProjectDetails(ProjectId).get(0));
				int MainCount=1;
				for(Object[] objmain:main ) {
					int countA=1;
					List<Object[]>  MilestoneActivityA=service.MilestoneActivityLevel(objmain[0].toString(),"1");
					req.setAttribute(MainCount+"MilestoneActivityA", MilestoneActivityA);
					for(Object[] obj:MilestoneActivityA) {
						List<Object[]>  MilestoneActivityB=service.MilestoneActivityLevel(obj[0].toString(),"2");
						req.setAttribute(MainCount+"MilestoneActivityB"+countA, MilestoneActivityB);
						int countB=1;
						for(Object[] obj1:MilestoneActivityB) {
							List<Object[]>  MilestoneActivityC=service.MilestoneActivityLevel(obj1[0].toString(),"3");
							req.setAttribute(MainCount+"MilestoneActivityC"+countA+countB, MilestoneActivityC);
							int countC=1;
							for(Object[] obj2:MilestoneActivityC) {
								List<Object[]>  MilestoneActivityD=service.MilestoneActivityLevel(obj2[0].toString(),"4");
								req.setAttribute(MainCount+"MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
								int countD=1;
								for(Object[] obj3:MilestoneActivityD) {
									List<Object[]>  MilestoneActivityE=service.MilestoneActivityLevel(obj3[0].toString(),"5");
									req.setAttribute(MainCount+"MilestoneActivityE"+countA+countB+countC+countD, MilestoneActivityE);
									countD++;
								}
								countC++;
							}
							countB++;
						}
						countA++;
					}
					MainCount++;
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside M-A-AssigneeList.htm "+UserId, e); 
			return "static/Error";

		}

		return "milestone/MileAssigneeList";
	}



	@RequestMapping(value = "MilestoneActivityAdd.htm")
	public String MilestoneActivityAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MilestoneActivityAdd.htm "+UserId);
		try {
			String ProjectId=req.getParameter("ProjectId");
			req.setAttribute("EmployeeList", service.ProjectEmpList(ProjectId , LabCode));
			req.setAttribute("ProjectDetails", service.ProjectDetails(ProjectId).get(0));
			req.setAttribute("ActivityTypeList", service.ActivityTypeList());
			req.setAttribute("ProjectId", ProjectId);
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneActivityAdd.htm "+UserId, e); 
			return "static/Error";
		}
		return "milestone/MilestoneActivityAdd";

	}


	@RequestMapping(value = "MilestoneActivityAddSubmit.htm", method = RequestMethod.POST)
	public String MilestoneActivityAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MilestoneActivityAddSubmit.htm "+UserId);		
		try {


			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();

			MilestoneActivityDto mainDto=new MilestoneActivityDto();
			mainDto.setActivityType(req.getParameter("ActivityType"));
			mainDto.setProjectId(req.getParameter("ProjectId"));
			mainDto.setOicEmpId(req.getParameter("EmpId"));
			mainDto.setOicEmpId1(req.getParameter("EmpId1"));
			mainDto.setActivityName(req.getParameter("ActivityName"));
			mainDto.setMilestoneNo(req.getParameter("MilestoneNo"));
			mainDto.setStartDate(req.getParameter("ValidFrom"));
			mainDto.setEndDate(req.getParameter("ValidTo"));
			mainDto.setCreatedBy(UserId);
			long count =service.MilestoneActivityInsert(mainDto);

			if (count > 0) {
				redir.addFlashAttribute("MilestoneActivityId", String.valueOf(count));
				redir.addAttribute("result", "Milestone Activity  Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Milestone Activity Add Unsuccessful");
				return "redirect:/MilestoneActivityList.htm";
			}

		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneActivityAddSubmit.htm "+UserId, e); 
			return "static/Error";
		}	
		return "redirect:/MA-DetailsRedirect.htm";
	}

	@RequestMapping(value = "MilestoneActivityDetails.htm")
	public String MilestoneActivityDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MilestoneActivityDetails.htm "+UserId);		
		try {
			int countA=1;
			req.setAttribute("MilestoneActivity", service.MilestoneActivity(req.getParameter("MilestoneActivityId")).get(0));
			Object[] objd= service.MilestoneActivity(req.getParameter("MilestoneActivityId")).get(0);
			List<Object[]>  MilestoneActivityA=service.MilestoneActivityLevel(req.getParameter("MilestoneActivityId"),"1");
			req.setAttribute("MilestoneActivityA", MilestoneActivityA);
			for(Object[] obj:MilestoneActivityA) {
				List<Object[]>  MilestoneActivityB=service.MilestoneActivityLevel(obj[0].toString(),"2");
				req.setAttribute("MilestoneActivityB"+countA, MilestoneActivityB);
				int countB=1;
				for(Object[] obj1:MilestoneActivityB) {
					List<Object[]>  MilestoneActivityC=service.MilestoneActivityLevel(obj1[0].toString(),"3");
					req.setAttribute("MilestoneActivityC"+countA+countB, MilestoneActivityC);

					int countC=1;
					for(Object[] obj2:MilestoneActivityC) {
						List<Object[]>  MilestoneActivityD=service.MilestoneActivityLevel(obj2[0].toString(),"4");
						req.setAttribute("MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
						int countD=1;
						for(Object[] obj3:MilestoneActivityD) {
							List<Object[]>  MilestoneActivityE=service.MilestoneActivityLevel(obj3[0].toString(),"5");
							req.setAttribute("MilestoneActivityE"+countA+countB+countC+countD, MilestoneActivityE);
							countD++;
						}
						countC++;
					}
					countB++;
				}
				countA++;
			}	
			req.setAttribute("ActivityTypeList", service.ActivityTypeList());
			if("C".equalsIgnoreCase(req.getParameter("sub"))) {
				req.setAttribute("RevisionCount", service.MilestoneRevisionCount(req.getParameter("MilestoneActivityId")));
				return "milestone/MilestoneActivityPreview";
			}
			return "milestone/MilestoneActivityDetails";
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneActivityDetails.htm "+UserId, e); 
			return "static/Error";			
		}

	}

	@RequestMapping(value = "MilestoneActivitySubAdd.htm", method = RequestMethod.POST)
	public String MilestoneActivitySubAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MilestoneActivitySubAdd.htm "+UserId);		
		try {
			System.out.println("Hiiii------"+req.getParameter("ValidTo"));

			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			redir.addFlashAttribute("MilestoneActivityId", req.getParameter("MilestoneActivityId"));
			redir.addFlashAttribute("formname", req.getParameter("formname"));
			MilestoneActivityDto mainDto=new MilestoneActivityDto();
			mainDto.setActivityType(req.getParameter("ActivityType"));
			mainDto.setActivityName(req.getParameter("ActivityName"));
			mainDto.setActivityId(req.getParameter("ActivityId"));
			mainDto.setLevelId(req.getParameter("LevelId"));
			mainDto.setStartDate(req.getParameter("ValidFrom"));
			mainDto.setEndDate(req.getParameter("ValidTo"));
			mainDto.setWeightage(req.getParameter("Weightage"));
			mainDto.setOicEmpId(req.getParameter("OicEmpId"));
			mainDto.setOicEmpId1(req.getParameter("OicEmpId1"));
			mainDto.setCreatedBy(UserId);
			long count =service.MilestoneActivityLevelInsert(mainDto);

			if (count > 0) {
				redir.addAttribute("result", "Milestone Activity Sub Level  Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Milestone Activity Sub Level Add Unsuccessful");
			}

		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneActivitySubAdd.htm "+UserId, e); 
			return "static/Error";
		}


		return "redirect:/MA-DetailsRedirect.htm";
	}

	@RequestMapping(value = "MA-DetailsRedirect.htm", method = RequestMethod.GET)
	public String MADetailsRedirect(Model model,HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DetailsRedirect.htm "+UserId);		
		try {
			int countA=1;	
			String MainId=null;
			String FromName=null;
			Map md = model.asMap();
			for (Object modelKey : md.keySet()) {
				MainId = (String) md.get("MilestoneActivityId");
				FromName = (String) md.get("formname");   
			}
			if(MainId==null) {
				redir.addAttribute("resultfail", "Refresh Not Allowed");
				return "redirect:/MilestoneActivityList.htm";
			}
			req.setAttribute("MilestoneActivity", service.MilestoneActivity(MainId).get(0));
			List<Object[]>  MilestoneActivityA=service.MilestoneActivityLevel(MainId,"1");
			req.setAttribute("MilestoneActivityA", MilestoneActivityA);
			for(Object[] obj:MilestoneActivityA) {
				List<Object[]>  MilestoneActivityB=service.MilestoneActivityLevel(obj[0].toString(),"2");
				req.setAttribute("MilestoneActivityB"+countA, MilestoneActivityB);
				int countB=1;
				for(Object[] obj1:MilestoneActivityB) {
					List<Object[]>  MilestoneActivityC=service.MilestoneActivityLevel(obj1[0].toString(),"3");
					req.setAttribute("MilestoneActivityC"+countA+countB, MilestoneActivityC);

					int countC=1;
					for(Object[] obj2:MilestoneActivityC) {
						List<Object[]>  MilestoneActivityD=service.MilestoneActivityLevel(obj2[0].toString(),"4");
						req.setAttribute("MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
						int countD=1;
						for(Object[] obj3:MilestoneActivityD) {
							List<Object[]>  MilestoneActivityE=service.MilestoneActivityLevel(obj3[0].toString(),"5");
							req.setAttribute("MilestoneActivityE"+countA+countB+countC+countD, MilestoneActivityE);
							countD++;
						}
						countC++;
					}
					countB++;
				}
				countA++;
			}
			req.setAttribute("ActivityTypeList", service.ActivityTypeList());
			req.setAttribute("FromName",FromName);

		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside DetailsRedirect.htm "+UserId, e); 
			return "static/Error";
		}

		return "milestone/MilestoneActivityDetails";
	}



	@RequestMapping(value = "M-A-Assign-OIC.htm", method = RequestMethod.POST)
	public String AssignToOic(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside M-A-Assign-OIC.htm "+UserId);		
		try {


			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			redir.addFlashAttribute("MilestoneActivityId", req.getParameter("MilestoneActivityId"));
			redir.addFlashAttribute("Sub", req.getParameter("sub"));
			MilestoneActivityDto mainDto=new MilestoneActivityDto();
			mainDto.setActivityId(req.getParameter("MilestoneActivityId"));
			mainDto.setOicEmpId(EmpId);
			mainDto.setStatusRemarks(req.getParameter("Remarks"));
			mainDto.setActivityType(req.getParameter("sub"));
			mainDto.setRevisionNo(req.getParameter("RevId"));
			mainDto.setCreatedBy(UserId);

			long count =service.MilestoneActivityAssign(mainDto);

			if (count == 1) {
				if("Assign".equalsIgnoreCase(req.getParameter("sub"))) {
					redir.addAttribute("result", "Milestone Activity  Assigned   Successfuly.");
				}else if("Accept".equalsIgnoreCase(req.getParameter("sub"))) {
					redir.addAttribute("result", "Milestone Activity  Accepted And Base Line 0 Created   Successfuly.");	
				}else if("Back".equalsIgnoreCase(req.getParameter("sub"))) {
					redir.addAttribute("result", "Milestone Activity  Sent Back  Successfuly.");	
				}
			}else if(count==2) {
				redir.addAttribute("resultfail", "Milestone Activity Sub Level Total  Weightage less than 100%, Please Modify");
			}else if(count==3) {
				redir.addAttribute("resultfail", "Milestone Activity Sub Level Not Exist, Please Add One Sub Level");
			}else if(count==4) {
				redir.addAttribute("resultfail", "Milestone Activity Sub Level Total  Weightage less than 100%, Please Send Back");
			}
			else {
				redir.addAttribute("resultfail", "Milestone Activity Assign Unsuccessful");
			}
			if("Assign".equalsIgnoreCase(req.getParameter("sub"))) {
				redir.addFlashAttribute("ProjectId",req.getParameter("projectid"));
				return "redirect:/MilestoneActivityList.htm";
			}
			redir.addFlashAttribute("ProjectId",req.getParameter("projectid"));
			return "redirect:/M-A-AssigneeList.htm";

		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside M-A-Assign-OIC.htm "+UserId, e); 
			return "static/Error";
		}


	}

	@RequestMapping(value = "M-A-Set-BaseLine.htm", method = RequestMethod.POST)
	public String BaseLine(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside M-A-Set-BaseLine.htm "+UserId);		
		try {


			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			redir.addFlashAttribute("MilestoneActivityId", req.getParameter("MilestoneActivityId"));
			MilestoneActivityDto mainDto=new MilestoneActivityDto();
			mainDto.setActivityId(req.getParameter("MilestoneActivityId"));
			mainDto.setRevisionNo(req.getParameter("RevId"));
			mainDto.setCreatedBy(UserId);
			long count =service.MilestoneActivityRevision(mainDto);

			if (count > 0) {
				redir.addAttribute("result", "Milestone Activity Base Line "+req.getParameter("RevId")+"  Successful.");
			} else {
				redir.addAttribute("resultfail", "Milestone Activity Revision Unsuccessful");
			}

		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside M-A-Set-BaseLine.htm "+UserId, e); 
			return "static/Error";
		}


		return "redirect:/MA-PreviewRedirect.htm";
	}



	@RequestMapping(value = "MA-PreviewRedirect.htm", method = RequestMethod.GET)
	public String previewRedirect(Model model,HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MA-PreviewRedirect.htm "+UserId);		
		try {
			int countA=1;	
			String MainId=null;
			Map md = model.asMap();
			for (Object modelKey : md.keySet()) {
				MainId = (String) md.get(modelKey);

			}
			if(MainId==null) {
				redir.addAttribute("resultfail", "Refresh Not Allowed");
				return "redirect:/MilestoneActivityList.htm";
			}
			req.setAttribute("MilestoneActivity", service.MilestoneActivity(MainId).get(0));
			List<Object[]>  MilestoneActivityA=service.MilestoneActivityLevel(MainId,"1");
			req.setAttribute("MilestoneActivityA", MilestoneActivityA);
			for(Object[] obj:MilestoneActivityA) {
				List<Object[]>  MilestoneActivityB=service.MilestoneActivityLevel(obj[0].toString(),"2");
				req.setAttribute("MilestoneActivityB"+countA, MilestoneActivityB);
				int countB=1;
				for(Object[] obj1:MilestoneActivityB) {
					List<Object[]>  MilestoneActivityC=service.MilestoneActivityLevel(obj1[0].toString(),"3");
					req.setAttribute("MilestoneActivityC"+countA+countB, MilestoneActivityC);

					int countC=1;
					for(Object[] obj2:MilestoneActivityC) {
						List<Object[]>  MilestoneActivityD=service.MilestoneActivityLevel(obj2[0].toString(),"4");
						req.setAttribute("MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
						int countD=1;
						for(Object[] obj3:MilestoneActivityD) {
							List<Object[]>  MilestoneActivityE=service.MilestoneActivityLevel(obj3[0].toString(),"5");
							req.setAttribute("MilestoneActivityE"+countA+countB+countC+countD, MilestoneActivityE);
							countD++;
						}
						countC++;
					}
					countB++;
				}
				countA++;
			}
			req.setAttribute("RevisionCount", service.MilestoneRevisionCount(MainId));
			req.setAttribute("ActivityTypeList", service.ActivityTypeList());
			req.setAttribute("EmployeeList", service.EmployeeList());
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MA-PreviewRedirect.htm "+UserId, e); 
			return "static/Error";
		}

		return "milestone/MilestoneActivityPreview";
	}

	@RequestMapping(value = "MilestoneActivityEdit.htm")
	public String MilestoneActivityEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside MilestoneActivityEdit.htm "+UserId);

		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			MileEditDto mainDto=new MileEditDto();
			mainDto.setMilestoneActivityId(req.getParameter("MilestoneActivityId"));
			mainDto.setRevisionNo(req.getParameter("RevId"));
			mainDto.setActivityId(req.getParameter("ActivityId"));
			mainDto.setActivityType(req.getParameter("ActivityType"));


			req.setAttribute("EmployeeList", service.EmployeeList());
			req.setAttribute("ActivityTypeList", service.ActivityTypeList());
			req.setAttribute("EditData", service.MilestoneActivityEdit(mainDto).get(0));
			req.setAttribute("EditMain", mainDto);

		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneActivityEdit.htm "+UserId, e); 
			return "static/Error";

		}

		return "milestone/MilestoneActivityEdit";

	}


	@RequestMapping(value = "MilestoneActivityEditSubmit.htm", method = RequestMethod.POST)
	public String MilestoneActivityEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MilestoneActivityEditSubmit.htm "+UserId);		
		try {

			System.out.println(req.getParameter("Weightage")+"------------");
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			redir.addFlashAttribute("MilestoneActivityId", req.getParameter("MilestoneActivityId"));
			MileEditDto mainDto=new MileEditDto();
			mainDto.setMilestoneActivityId(req.getParameter("MilestoneActivityId"));
			mainDto.setRevisionNo(req.getParameter("RevId"));
			mainDto.setActivityId(req.getParameter("ActivityId"));
			mainDto.setActivityType(req.getParameter("ActivityType"));
			mainDto.setActivityTypeId(req.getParameter("ActivityTypeId"));
			mainDto.setOicEmpId(req.getParameter("EmpId"));
			mainDto.setOicEmpId1(req.getParameter("EmpId1"));
			mainDto.setActivityName(req.getParameter("ActivityName"));
			mainDto.setStartDate(req.getParameter("ValidFrom"));
			mainDto.setEndDate(req.getParameter("ValidTo"));
			mainDto.setWeightage(req.getParameter("Weightage"));
			mainDto.setCreatedBy(UserId);
			int count =service.MilestoneActivityUpdate(mainDto);

			if (count > 0) {
				redir.addAttribute("result", "Milestone Activity Updated  Successfuly.");
			} else {
				redir.addAttribute("resultfail", "Milestone Activity Update Unsuccessful");
			}

		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneActivityEditSubmit.htm "+UserId, e); 
			return "static/Error";
		}


		return "redirect:/MA-PreviewRedirect.htm";
	}

	@RequestMapping(value = "MilestoneActivityCompare.htm")
	public String MilestoneActivityCompare(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside MilestoneActivityCompare.htm "+UserId);

		try {
			int rev=service.MilestoneRevisionCount(req.getParameter("MilestoneActivityId"));
			int rev2=1;
			if(rev>1) {
				rev2=rev-1;
			}
			int countA=1;
			int count1A=1;
			req.setAttribute("MilestoneActivity", service.ActivityCompareMAin(req.getParameter("MilestoneActivityId"),"1","1").get(0));
			List<Object[]>  MilestoneActivityA=service.ActivityLevelCompare(req.getParameter("MilestoneActivityId"),"1","1","1");
			req.setAttribute("MilestoneActivityA", MilestoneActivityA);
			for(Object[] obj:MilestoneActivityA) {
				List<Object[]>  MilestoneActivityB=service.ActivityLevelCompare(obj[0].toString(),"1","1","2");
				req.setAttribute("MilestoneActivityB"+countA, MilestoneActivityB);
				int countB=1;
				for(Object[] obj1:MilestoneActivityB) {
					List<Object[]>  MilestoneActivityC=service.ActivityLevelCompare(obj1[0].toString(),"1","1","3");
					req.setAttribute("MilestoneActivityC"+countA+countB, MilestoneActivityC);
					int countC=1;
					for(Object[] obj2:MilestoneActivityC) {
						List<Object[]>  MilestoneActivityD=service.ActivityLevelCompare(obj2[0].toString(),"1","1","4");
						req.setAttribute("MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
						int countD=1;
						for(Object[] obj3:MilestoneActivityD) {
							List<Object[]>  MilestoneActivityE=service.ActivityLevelCompare(obj3[0].toString(),"1","1","5");
							req.setAttribute("MilestoneActivityE"+countA+countB+countC+countD, MilestoneActivityE);
							countD++;
						}
						countC++;
					}
					countB++;
				}
				countA++;
			}	

			req.setAttribute("MilestoneActivity1", service.ActivityCompareMAin(req.getParameter("MilestoneActivityId"),String.valueOf(rev2),"1").get(0));
			List<Object[]>  MilestoneActivity1A=service.ActivityLevelCompare(req.getParameter("MilestoneActivityId"),String.valueOf(rev2),"1","1");
			req.setAttribute("MilestoneActivity1A", MilestoneActivity1A);
			for(Object[] obj:MilestoneActivity1A) {
				List<Object[]>  MilestoneActivity1B=service.ActivityLevelCompare(obj[0].toString(),String.valueOf(rev2),"1","2");
				req.setAttribute("MilestoneActivity1B"+count1A, MilestoneActivity1B);
				int countB=1;
				for(Object[] obj1:MilestoneActivity1B) {
					List<Object[]>  MilestoneActivity1C=service.ActivityLevelCompare(obj1[0].toString(),String.valueOf(rev2),"1","3");
					req.setAttribute("MilestoneActivity1C"+count1A+countB, MilestoneActivity1C);
					int countC=1;
					for(Object[] obj2:MilestoneActivity1C) {
						List<Object[]>  MilestoneActivity1D=service.ActivityLevelCompare(obj2[0].toString(),String.valueOf(rev2),"1","4");
						req.setAttribute("MilestoneActivity1D"+count1A+countB+countC, MilestoneActivity1D);
						int countD=1;
						for(Object[] obj3:MilestoneActivity1D) {
							List<Object[]>  MilestoneActivity1E=service.ActivityLevelCompare(obj3[0].toString(),String.valueOf(rev2),"1","5");
							req.setAttribute("MilestoneActivity1E"+count1A+countB+countC+countD, MilestoneActivity1E);
							countD++;
						}
						countC++;
					}

					countB++;
				}
				count1A++;
			}	

			req.setAttribute("P", "0");		
			req.setAttribute("Count", service.MilestoneRevisionCount(req.getParameter("MilestoneActivityId")));	
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneActivityCompare.htm "+UserId, e); 
			return "static/Error";

		}

		return "milestone/MilestoneActivityCompare";

	}

	@RequestMapping(value = "MilestoneActivityCompareSubmit.htm")
	public String MilestoneActivityCompareSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside MilestoneActivityCompareSubmit.htm "+UserId);

		try {
			String rev=req.getParameter("FirstNo");
			String rev2=req.getParameter("SecondNo");
			int countA=1;
			int count1A=1;

			System.out.println(rev);
			System.out.println(rev2);

			req.setAttribute("MilestoneActivity", service.ActivityCompareMAin(req.getParameter("MilestoneActivityId"),rev,rev).get(0));
			List<Object[]>  MilestoneActivityA=service.ActivityLevelCompare(req.getParameter("MilestoneActivityId"),rev,rev,"1");
			req.setAttribute("MilestoneActivityA", MilestoneActivityA);
			for(Object[] obj:MilestoneActivityA) {
				List<Object[]>  MilestoneActivityB=service.ActivityLevelCompare(obj[0].toString(),rev,rev,"2");
				req.setAttribute("MilestoneActivityB"+countA, MilestoneActivityB);
				int countB=1;
				for(Object[] obj1:MilestoneActivityB) {
					List<Object[]>  MilestoneActivityC=service.ActivityLevelCompare(obj1[0].toString(),rev,rev,"3");
					req.setAttribute("MilestoneActivityC"+countA+countB, MilestoneActivityC);
					int countC=1;
					for(Object[] obj2:MilestoneActivityC) {
						List<Object[]>  MilestoneActivityD=service.ActivityLevelCompare(obj2[0].toString(),rev,rev,"4");
						req.setAttribute("MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
						int countD=1;
						for(Object[] obj3:MilestoneActivityD) {
							List<Object[]>  MilestoneActivityE=service.ActivityLevelCompare(obj3[0].toString(),rev,rev,"5");
							req.setAttribute("MilestoneActivityE"+countA+countB+countC+countD, MilestoneActivityE);
							countD++;
						}
						countC++;
					}
					countB++;
				}
				countA++;
			}	

			req.setAttribute("MilestoneActivity1", service.ActivityCompareMAin(req.getParameter("MilestoneActivityId"),rev2,rev).get(0));
			List<Object[]>  MilestoneActivity1A=service.ActivityLevelCompare(req.getParameter("MilestoneActivityId"),rev2,rev,"1");
			req.setAttribute("MilestoneActivity1A", MilestoneActivity1A);
			for(Object[] obj:MilestoneActivity1A) {
				List<Object[]>  MilestoneActivity1B=service.ActivityLevelCompare(obj[0].toString(),rev2,rev,"2");
				req.setAttribute("MilestoneActivity1B"+count1A, MilestoneActivity1B);
				int countB=1;
				for(Object[] obj1:MilestoneActivity1B) {
					List<Object[]>  MilestoneActivity1C=service.ActivityLevelCompare(obj1[0].toString(),rev2,rev,"3");
					req.setAttribute("MilestoneActivity1C"+count1A+countB, MilestoneActivity1C);
					int countC=1;
					for(Object[] obj2:MilestoneActivity1C) {
						List<Object[]>  MilestoneActivity1D=service.ActivityLevelCompare(obj2[0].toString(),rev2,rev,"4");
						req.setAttribute("MilestoneActivity1D"+count1A+countB+countC, MilestoneActivity1D);
						int countD=1;
						for(Object[] obj3:MilestoneActivity1D) {
							List<Object[]>  MilestoneActivity1E=service.ActivityLevelCompare(obj3[0].toString(),rev2,rev,"5");
							req.setAttribute("MilestoneActivity1E"+count1A+countB+countC+countD, MilestoneActivity1E);
							countD++;
						}
						countC++;
					}
					countB++;
				}
				count1A++;
			}	

			req.setAttribute("P", rev);	
			req.setAttribute("Count", service.MilestoneRevisionCount(req.getParameter("MilestoneActivityId")));	

		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneActivityCompareSubmit.htm "+UserId, e); 
			return "static/Error";

		}

		return "milestone/MilestoneActivityCompare";

	}

	@RequestMapping(value = "MilestoneUpdate.htm")
	public String MilestoneUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside MilestoneUpdate.htm "+UserId);

		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			req.setAttribute("MilestoneActivityList", service.MilestoneActivityEmpIdList(EmpId));


		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneUpdate.htm "+UserId, e); 
			return "static/Error";

		}

		return "milestone/MilestoneOicList";

	}

	@RequestMapping(value = "MilestoneActivityUpdate.htm")
	public String MilestoneActivityUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside MilestoneActivityUpdate.htm "+UserId);

		try {
			int rev=service.MilestoneRevisionCount(req.getParameter("MilestoneActivityId"))-1;
			int countA=1; 
			req.setAttribute("MilestoneActivity", service.ActivityCompareMAin(req.getParameter("MilestoneActivityId"),String.valueOf(rev),String.valueOf(rev-1)).get(0));
			List<Object[]>  MilestoneActivityA=service.ActivityLevelCompare(req.getParameter("MilestoneActivityId"),String.valueOf(rev),String.valueOf(rev-1),"1");
			req.setAttribute("MilestoneActivityA", MilestoneActivityA);
			for(Object[] obj:MilestoneActivityA) {
				List<Object[]>  MilestoneActivityB=service.ActivityLevelCompare(obj[0].toString(),String.valueOf(rev),String.valueOf(rev-1),"2");
				req.setAttribute("MilestoneActivityB"+countA, MilestoneActivityB);
				int countB=1;
				for(Object[] obj1:MilestoneActivityB) {
					List<Object[]>  MilestoneActivityC=service.ActivityLevelCompare(obj1[0].toString(),String.valueOf(rev),String.valueOf(rev-1),"3");
					req.setAttribute(countA+"MilestoneActivityC"+countB, MilestoneActivityC);
					countB++;
				}
				countA++;
			}	

			req.setAttribute("projectid", req.getParameter("projectid") );
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneActivityUpdate.htm "+UserId, e); 
			return "static/Error";

		}

		return "milestone/MilestoneActivityUpdate";

	}

	@RequestMapping(value = "M-A-Update.htm")
	public String MileActivityUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String Labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside M-A-Update.htm "+UserId);

		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			MileEditDto mainDto = new MileEditDto();
			mainDto.setMilestoneActivityId(req.getParameter("MilestoneActivityId"));
			mainDto.setActivityId(req.getParameter("ActivityId"));
			mainDto.setProjectId(req.getParameter("ProjectId"));
			mainDto.setActivityType(req.getParameter("ActivityType"));

			req.setAttribute("StatusList", service.StatusList());
			req.setAttribute("EmpList", service.ProjectEmpList(req.getParameter("ProjectId") ,Labcode));
			req.setAttribute("EditData", service.MilestoneActivityEdit(mainDto).get(0));
			req.setAttribute("EditMain", mainDto);
			req.setAttribute("SubList", service.MilestoneActivitySub(mainDto));
			if(req.getParameter("ActivityType").equals("M")) {
				req.setAttribute("ActionList", service.ActionList("M",req.getParameter("MilestoneActivityId")));
			}else
			{
				req.setAttribute("ActionList", service.ActionList("A",req.getParameter("ActivityId")));	
			}
			req.setAttribute("projectdetails",service.ProjectDetails(req.getParameter("ProjectId")).get(0));
			req.setAttribute("AllLabsList", committeservice.AllLabList());

			req.setAttribute("startdate", req.getParameter("startdate"));

		}catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside M-A-Update.htm "+UserId, e); 
			return "static/Error";
		}

		return "milestone/MileActivityUpdate";

	}


	@RequestMapping(value = "M-A-UpdateSubmit.htm", method = RequestMethod.POST)   
	public String MileActivityUpdateSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart("FileAttach") MultipartFile FileAttach)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside M-A-UpdateSubmit.htm "+UserId);		
		try {

			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			redir.addFlashAttribute("MilestoneActivityId", req.getParameter("MilestoneActivityId"));
			redir.addFlashAttribute("ActivityId", req.getParameter("ActivityId"));
			redir.addFlashAttribute("ActivityType", req.getParameter("ActivityType"));
			redir.addFlashAttribute("ProjectId", req.getParameter("ProjectId"));
			MileEditDto mainDto=new MileEditDto();
			mainDto.setMilestoneActivityId(req.getParameter("MilestoneActivityId"));
			mainDto.setActivityId(req.getParameter("ActivityId"));
			mainDto.setActivityType(req.getParameter("ActivityType"));
			mainDto.setEndDate(req.getParameter("EndDate"));
			mainDto.setProgressStatus(req.getParameter("Progress"));
			mainDto.setDateOfCompletion(req.getParameter("DOC"));
			mainDto.setFileName(req.getParameter("FileName"));
			mainDto.setFileNamePath(FileAttach.getOriginalFilename());
			mainDto.setFilePath(FileAttach.getBytes());
			mainDto.setStatusRemarks(req.getParameter("Remarks"));
			mainDto.setCreatedBy(UserId);
			mainDto.setProgressDate(req.getParameter("progressDate"));
			int count =service.ActivityProgressUpdate(mainDto);

			if (count > 0) {
				redir.addAttribute("result", "Milestone Activity  Updated  Successfuly.");
			} else {
				redir.addAttribute("resultfail", "Milestone Activity Update Unsuccessful");
			}

		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside M-A-UpdateSubmit.htm "+UserId, e); 
			return "static/Error";
		}



		return "redirect:/MA-UpdateRedirect.htm";
	}

	@RequestMapping(value = "MA-UpdateRedirect.htm", method = RequestMethod.GET)
	public String UpdateRedirect(Model model,HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode"); 
		logger.info(new Date() +"Inside MA-UpdateRedirect.htm"+UserId);		
		try {

			String MainId=null;
			String SubId=null;
			String Type=null;
			String Project=null;
			Map md = model.asMap();
			MainId = (String) md.get("MilestoneActivityId");
			SubId = (String) md.get("ActivityId");
			Type = (String) md.get("ActivityType");     
			Project = (String) md.get("ProjectId");   
			if(MainId==null) {
				redir.addAttribute("resultfail", "Refresh Not Allowed");
				return "redirect:/MilestoneUpdate.htm";
			}
			MileEditDto mainDto=new MileEditDto();
			mainDto.setMilestoneActivityId(MainId);
			mainDto.setActivityId(SubId);
			mainDto.setActivityType(Type);
			mainDto.setProjectId(Project);
			req.setAttribute("StatusList", service.StatusList());
			req.setAttribute("EmpList", service.ProjectEmpList(Project , LabCode));
			req.setAttribute("EditData", service.MilestoneActivityEdit(mainDto).get(0));
			req.setAttribute("EditMain", mainDto);
			req.setAttribute("SubList", service.MilestoneActivitySub(mainDto));
			req.setAttribute("ActionList", service.ActionList(Type,SubId));
			req.setAttribute("projectdetails",service.ProjectDetails(Project).get(0));
			req.setAttribute("AllLabsList", committeservice.AllLabList());
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MA-UpdateRedirect.htm "+UserId, e); 
			return "static/Error";

		}

		return "milestone/MileActivityUpdate";

	}

	@RequestMapping(value = "MilestoneReports.htm")
	public String MilestoneReports(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside MilestoneReports.htm "+UserId);

		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			req.setAttribute("MilestoneList", service.MilestoneReportsList(EmpId));

		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneReports.htm "+UserId, e); 
			return "static/Error";

		}

		return "milestone/MilestoneReports";

	}

	@RequestMapping(value = "MilestoneTotalWeightage.htm", method = RequestMethod.GET)
	public @ResponseBody String MilestoneTotalWeightage(HttpServletRequest req,HttpSession ses) throws Exception {

		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside MilestoneTotalWeightage.htm "+ UserId);		
		String MilestoneActivityId=req.getParameter("MilestoneActivityId");		
		int totalweightage = service.MilestoneTotalWeightage(MilestoneActivityId);
		Gson json = new Gson();
		return json.toJson(totalweightage);	
	}

	@RequestMapping(value = "ActivityAttachDownload.htm", method = RequestMethod.GET)
	public void ActivityAttachDownload(HttpServletRequest	 req, HttpSession ses, HttpServletResponse res) throws Exception 
	{	 
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ActivityAttachDownload..htm "+UserId);		
		try { 

			MilestoneActivitySub attachment=service.ActivityAttachmentDownload(req.getParameter("ActivitySubId" ));

			res.setContentType("application/octet-stream");
			res.setHeader("Content-Disposition", String.format("inline; filename=\"" + attachment.getAttachName()));
			res.setContentLength((int)attachment.getAttachFile().length);

			InputStream inputStream = new ByteArrayInputStream(attachment.getAttachFile()); 
			OutputStream outputStream = res.getOutputStream(); 
			FileCopyUtils.copy(inputStream, outputStream);

			inputStream.close(); 
			outputStream.close();
		}
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside ActivityAttachDownload..htm "+UserId, e); 
		}

	}


	@RequestMapping(value = "WeightageSum.htm", method = RequestMethod.GET)
	public @ResponseBody String WeightageSum(HttpServletRequest req, HttpSession ses) throws Exception {
		Gson json = new Gson();
		int ActivitySum=0;
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside WeightageSum.htm "+UserId);		
		try {

			ActivitySum =service.WeightageSum(req.getParameter("Id"),req.getParameter("ActivityId"),req.getParameter("Type"),req.getParameter("LevelId"));

		}
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside WeightageSum.htm "+UserId, e); 
		}

		return json.toJson(ActivitySum);

	}

	@RequestMapping(value = "encryptFile.htm", method = RequestMethod.GET)
	public static void encryptFile(HttpSession ses) throws IOException, NoSuchPaddingException,
	NoSuchAlgorithmException, InvalidAlgorithmParameterException, InvalidKeyException,
	BadPaddingException, IllegalBlockSizeException {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside encryptFile.htm "+UserId);	
		KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
		keyGenerator.init(128);
		SecretKey key = keyGenerator.generateKey();
		String algorithm = "AES/CBC/PKCS5Padding";
		final byte[] bytes = new byte[16]; 
		new SecureRandom().nextBytes(bytes);
		IvParameterSpec iv =new IvParameterSpec(bytes);
		Cipher cipher = Cipher.getInstance(algorithm);
		cipher.init(Cipher.ENCRYPT_MODE, key, iv);
		FileInputStream inputStream = new FileInputStream("D:\\D_test.txt\\");
		FileOutputStream outputStream = new FileOutputStream("D:\\D_testenn.txt\\");
		byte[] buffer = new byte[64];
		int bytesRead;
		while ((bytesRead = inputStream.read(buffer)) != -1) {
			byte[] output = cipher.update(buffer, 0, bytesRead);
			if (output != null) {
				outputStream.write(output);
			}
		}
		byte[] outputBytes = cipher.doFinal();
		if (outputBytes != null) {
			outputStream.write(outputBytes);
		}
		inputStream.close();
		outputStream.close();
	}
	@RequestMapping(value = "decryptFile.htm", method = RequestMethod.GET)
	public static void decryptFile2(HttpSession ses) throws  Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside decryptFile.htm "+UserId);	
		String sourceFile = "D:\\D_testenn.txt\\";
		FileOutputStream fos = new FileOutputStream("D:\\compressed.zip\\");
		ZipOutputStream zipOut = new ZipOutputStream(fos);
		File fileToZip = new File(sourceFile);
		FileInputStream fis = new FileInputStream(fileToZip);
		ZipEntry zipEntry = new ZipEntry(fileToZip.getName());
		zipOut.putNextEntry(zipEntry);
		byte[] bytes = new byte[1024];
		int length;
		while((length = fis.read(bytes)) >= 0) {
			zipOut.write(bytes, 0, length);
		}
		zipOut.close();
		fis.close();
		fos.close();
		String fileZip1 = "D:\\compressed.zip\\";
		File destDir1 = new File("D:\\Test\\");
		byte[] buffer1 = new byte[1024];
		ZipInputStream zis1 = new ZipInputStream(new FileInputStream(fileZip1));
		ZipEntry zipEntry1 = zis1.getNextEntry();
		while (zipEntry1 != null) {
			File newFile = newFile(destDir1, zipEntry1);
			if (zipEntry1.isDirectory()) {
				if (!newFile.isDirectory() && !newFile.mkdirs()) {
					throw new IOException("Failed to create directory " + newFile);
				}
			} else {
				// fix for Windows-created archives
				File parent = newFile.getParentFile();
				if (!parent.isDirectory() && !parent.mkdirs()) {
					throw new IOException("Failed to create directory " + parent);
				}

				// write file content
				FileOutputStream fos1 = new FileOutputStream(newFile);
				int len;
				while ((len = zis1.read(buffer1)) > 0) {
					fos1.write(buffer1, 0, len);
				}
				fos1.close();
			}
			zipEntry1 = zis1.getNextEntry();
		}
		zis1.closeEntry();
		zis1.close();

	}

	public static File newFile(File destinationDir, ZipEntry zipEntry) throws IOException {
		File destFile = new File(destinationDir, zipEntry.getName());

		String destDirPath = destinationDir.getCanonicalPath();
		String destFilePath = destFile.getCanonicalPath();

		if (!destFilePath.startsWith(destDirPath + File.separator)) {
			throw new IOException("Entry is outside of the target dir: " + zipEntry.getName());
		}

		return destFile;
	}

	//@RequestMapping(value = "decryptFile.htm", method = RequestMethod.GET)
	public void decryptFile(HttpSession ses) throws  IOException, NoSuchPaddingException, NoSuchAlgorithmException,
	InvalidAlgorithmParameterException, InvalidKeyException,
	BadPaddingException, IllegalBlockSizeException {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside decryptFile.htm "+UserId);	
		KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
		keyGenerator.init(128);
		SecretKey key = keyGenerator.generateKey();
		String algorithm = "AES/CBC/PKCS5Padding";
		final byte[] bytes = new byte[16];
		new SecureRandom().nextBytes(bytes);
		IvParameterSpec iv =new IvParameterSpec(bytes);
		Cipher cipher = Cipher.getInstance(algorithm);
		cipher.init(Cipher.DECRYPT_MODE, key ,iv);
		FileInputStream inputStream = new FileInputStream("D:\\D_testenn.txt\\");
		FileOutputStream outputStream = new FileOutputStream("D:\\D_testde.txt\\");
		byte[] buffer = new byte[64];
		int bytesRead;
		while ((bytesRead = inputStream.read(buffer)) != -1) {
			byte[] output = cipher.update(buffer, 0, bytesRead);
			if (output != null) {
				outputStream.write(output);

			}
		}
		byte[] outputBytes = cipher.doFinal(buffer, 0, bytesRead);
		if (outputBytes != null) {
			outputStream.write(outputBytes);
		}
		inputStream.close();
		outputStream.close();
	}


	@RequestMapping(value = "TestingFileRepo.htm")
	public String TestingFileRepo(HttpServletRequest req, HttpSession ses, RedirectAttributes redir, Model model)throws Exception 
	{
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside TestingFileRepo.htm "+UserId);
		try {
			String ProjectId=req.getParameter("projectid");
			Map md = model.asMap();
			if(ProjectId==null) {
				ProjectId= (String) md.get("projectid");
			}
			if(ProjectId==null){
				ProjectId=service.LoginProjectDetailsList(EmpId, Logintype,LabCode).get(0)[0].toString();
			}

			String MainSystemValue= (String) md.get("MainSystemValue");
			String s1= (String) md.get("s1");
			String s2= (String) md.get("s2");
			String s3= (String) md.get("s3");
			String s4= (String) md.get("s4");
			String sublevel= (String) md.get("sublevel");
			String doclev1= (String) md.get("doclev1");
			String doclev2= (String) md.get("doclev2");
			String doclev3= (String) md.get("doclev3");
			if(doclev1==null) {
				doclev1=doclev2=doclev3="0";
			}

			req.setAttribute("MainSystemValue", MainSystemValue);
			req.setAttribute("s1", s1);
			req.setAttribute("s2", s2);
			req.setAttribute("s3", s3);
			req.setAttribute("s4", s4);
			req.setAttribute("sublevel", sublevel);

			req.setAttribute("doclev1", doclev1);
			req.setAttribute("doclev2", doclev2);
			req.setAttribute("doclev3", doclev3);
			req.setAttribute("GlobalFileSize", GlobalFileSize);
			req.setAttribute("ProjectId", ProjectId);
			req.setAttribute("ProjectList", service.LoginProjectDetailsList(EmpId, Logintype,LabCode));
			req.setAttribute("filerepmasterlistall",service.FileRepMasterListAll(ProjectId,LabCode ));
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside TestingFileRepo.htm "+UserId, e); 
			return "static/Error";
		}
		return "filerepo/FileRepoUpload";
	}

	//	 	@RequestMapping(value = "MainSystemList.htm", method = RequestMethod.GET)
	//		public @ResponseBody String MainSystemList(HttpServletRequest req, HttpSession ses) throws Exception {
	//
	//			String UserId = (String) ses.getAttribute("Username");
	//			List<Object[]> MainSystemList =null;
	//			logger.info(new Date() +"Inside MainSystemList.htm "+UserId);
	//			
	//			try {
	//				MainSystemList=service.MainSystem();
	//								
	//			}catch (Exception e) {
	//				
	//				e.printStackTrace();  logger.error(new Date() +" Inside MainSystemList.htm "+UserId, e); return "static/Error";
	//			}
	//			Gson json = new Gson();
	//			return json.toJson(MainSystemList);
	//
	//		}

	@RequestMapping(value = "SubSystemL1List.htm", method = RequestMethod.GET)
	public @ResponseBody String SubSystemL1List(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		List<Object[]> SubSystemL1List =null;
		logger.info(new Date() +"Inside SubSystemL1List.htm "+UserId);

		try {
			SubSystemL1List=service.MainSystemLevel(req.getParameter("MainSystem"));
		}catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside SubSystemL1List.htm "+UserId, e); 
		}
		Gson json = new Gson();
		return json.toJson(SubSystemL1List);
	}



	@RequestMapping(value = "DocumentStageList.htm", method = RequestMethod.GET)
	public @ResponseBody String DocumentStageList(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		List<Object[]> DocumentStageList =null;
		logger.info(new Date() +"Inside DocumentStageList.htm "+UserId);

		try {
			DocumentStageList=service.DocumentStageList(req.getParameter("documenttype"),req.getParameter("levelid"));
		}catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside DocumentStageList.htm "+UserId, e); 
		}
		Gson json = new Gson();
		return json.toJson(DocumentStageList);
	}


	@RequestMapping(value="FileSubAddNew.htm",method = RequestMethod.POST)
	public String FileSubAddNew(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,@RequestPart("FileAttach") MultipartFile FileAttach)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileSubAddNew.htm "+UserId);
		try {

			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();				 
			String ProjectId=req.getParameter("projectidvalue");
			long release=Long.parseLong(req.getParameter("Rev"));
			long version=Long.parseLong(req.getParameter("Ver"));

			if(req.getParameter("isnewver").equalsIgnoreCase("N")) 
			{
				release=release+1;
			}
			else if(req.getParameter("isnewver").equalsIgnoreCase("Y")) 
			{
				release=0;
				version=version+1;
			}
			FileRepNew fileRepo=new FileRepNew();
			fileRepo.setProjectId(Long.parseLong(ProjectId));
			fileRepo.setFileRepMasterId(Long.parseLong(req.getParameter("mainsystemval")));
			fileRepo.setCreatedBy(UserId);
			fileRepo.setDocumentId(Long.parseLong(req.getParameter("documenttitle")));
			fileRepo.setReleaseDoc(release);
			fileRepo.setVersionDoc(version);
			List<Object[]> VersionCheckList=new ArrayList<Object[]>();
			int sublevel=Integer.parseInt(req.getParameter("sublevel"));


			fileRepo.setSubL1(Long.parseLong(req.getParameter("s"+sublevel) != "" ? req.getParameter("s"+sublevel): "0" ));
			VersionCheckList=service.VersionCheckList(ProjectId,req.getParameter("s"+sublevel),req.getParameter("documenttitle"));


			FileUploadDto filedto=new FileUploadDto();

			if(VersionCheckList.size()>0) {
				filedto.setFileId(VersionCheckList.get(0)[3].toString());
			}else 
			{
				long result=service.FileSubInsertNew(fileRepo);
				filedto.setFileId(Long.toString(result));
			}

			filedto.setFileName(req.getParameter("FileName"));
			filedto.setProjectId(ProjectId);
			filedto.setIS(FileAttach.getInputStream());
			filedto.setFileNamePath(FileAttach.getOriginalFilename());
			filedto.setPathName(req.getParameter("Path"));
			filedto.setRel(String.valueOf(release));
			filedto.setVer(String.valueOf(version));
			filedto.setUserId(UserId);
			filedto.setDescription(req.getParameter("description"));
			filedto.setSubL1(String.valueOf(sublevel));
			filedto.setDocid(req.getParameter("documenttitle"));
			filedto.setLabCode(LabCode);
			long count=service.FileUploadNew(filedto);

			if (count > 0) {
				redir.addAttribute("result", "Document Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Document Add Unsuccessful");
			}

			redir.addFlashAttribute("MainSystemValue", req.getParameter("mainsystemval"));
			redir.addFlashAttribute("s1", req.getParameter("s1"));
			redir.addFlashAttribute("s2", req.getParameter("s2"));
			redir.addFlashAttribute("s3", req.getParameter("s3"));
			redir.addFlashAttribute("s4", req.getParameter("s4"));
			redir.addFlashAttribute("sublevel", req.getParameter("sublevel"));
			redir.addFlashAttribute("projectid", req.getParameter("projectidvalue"));
			redir.addFlashAttribute("doclev1", req.getParameter("doclev1"));
			redir.addFlashAttribute("doclev2", req.getParameter("doclev2"));
			redir.addFlashAttribute("doclev3", req.getParameter("documenttitle"));
		}
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside FileSubAddNew.htm "+UserId, e); 
			return "static/Error";

		}

		return "redirect:/TestingFileRepo.htm";

	}

	@RequestMapping(value = "VersionCheckList.htm", method = RequestMethod.GET)
	public @ResponseBody String VersionCheckList(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		List<Object[]> VersionCheckList =null;
		logger.info(new Date() +"Inside VersionCheckList.htm "+UserId);

		try {
			VersionCheckList=service.VersionCheckList(req.getParameter("projectid"),req.getParameter("subsysteml1"),req.getParameter("documenttitle"));

		}catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside VersionCheckList.htm "+UserId, e);
		}
		Gson json = new Gson();
		return json.toJson(VersionCheckList);

	}







	@RequestMapping(value = "MilestoneSchedulesList.htm")
	public String MilestoneSchedulesList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MilestoneSchedulesList.htm "+UserId);		
		try {

			List<Object[] > ProjectList= service.ProjectList();
			String ProjectId=req.getParameter("ProjectId");

			if(ProjectId==null) {
				Object[] FirstProjectId=  ProjectList.get(0);
				ProjectId= FirstProjectId[0].toString();

			}

			req.setAttribute("ProjectDetails", service.ProjectDetails(ProjectId).get(0));
			req.setAttribute("MilestoneScheduleList", service.MilestoneScheduleList(ProjectId));
			req.setAttribute("ProjectList", ProjectList);
			req.setAttribute("ProjectId", ProjectId);

		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside MilestoneSchedulesList.htm "+UserId, e); 
			return "static/Error";
		}

		return "milestone/MilestoneScheduleList";
	}

	@RequestMapping(value = "MilestoneScheduleAdd.htm")
	public String MilestoneScheduleAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MilestoneScheduleAdd.htm "+UserId);
		try {
			req.setAttribute("ActivityTypeList", service.ActivityTypeList());
			req.setAttribute("ProjectDetails", service.ProjectDetails(req.getParameter("ProjectId")).get(0));
			req.setAttribute("ProjectId", req.getParameter("ProjectId"));
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneScheduleAdd.htm "+UserId, e); 
			return "static/Error";
		}
		return "milestone/MilestoneScheduleAdd";
	}

	@RequestMapping(value = "MilestoneScheduleAddSubmit.htm", method = RequestMethod.POST)
	public String MilestoneScheduleAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{			
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MilestoneScheduleAddSubmit.htm "+UserId);		
		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();

			MilestoneScheduleDto mainDto=new MilestoneScheduleDto();
			mainDto.setProjectId(req.getParameter("ProjectId"));
			mainDto.setMilestoneNo(req.getParameter("MilestoneNo"));
			mainDto.setActivityType(req.getParameter("ActivityType"));
			mainDto.setActivityName(req.getParameter("ActivityName"));
			mainDto.setStartDate(req.getParameter("ValidFrom"));
			mainDto.setEndDate(req.getParameter("ValidTo"));
			mainDto.setCreatedBy(UserId);
			long count =service.MilestoneScheduleInsert(mainDto);

			if (count > 0)
			{ 
				redir.addAttribute("result", "Milestone Schedule Added Successfully");

			} 
			else {
				redir.addAttribute("resultfail", "Milestone Schedule Add Unsuccessful");

				return "redirect:/MilestoneSchedulesList.htm"; }

		}

		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside MilestoneScheduleAddSubmit.htm "+UserId, e); 
			return "static/Error";

		}

		return "redirect:/MilestoneSchedulesList.htm";

	}

	@RequestMapping(value = "MilestoneExcelFile.htm", method = RequestMethod.POST)
	public void MilestoneExcelFile(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception 
	{

		String Username = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside  MilestoneExcelFile.htm "+Username);
		try {
			String name="NoData";
			String header="NoData";
			List<Object[]> bookData=service.MilestoneExcel(req.getParameter("ProjectId"));
			Object[] value=null;
			if(bookData!=null&&bookData.size()>0) {
				name="MilestoneExcelFile"+new SimpleDateFormat("ddMMyyyy").format(new Date())+".csv";
				header="Meeting Alert List";
			}

			Workbook  wb=new XSSFWorkbook();  



			Sheet sheet=wb.createSheet("MilestoneExcelFile"); 
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

			//				  	Center and Border Style
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


			//					Side Borders

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



			//					Content zero
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
			Cell r10cell8 = row10.createCell(7);
			Cell r10cell9 = row10.createCell(8);
			Cell r10cell10 = row10.createCell(9);


			r10cell1.setCellValue("Main Activity Id");
			r10cell1.setCellStyle(wrapname);
			r10cell2.setCellValue("Parent Id");
			r10cell2.setCellStyle(wrapname);
			r10cell3.setCellValue("Activity Name");
			r10cell3.setCellStyle(wrapname);
			r10cell4.setCellValue("Activity Type");
			r10cell4.setCellStyle(wrapname);	       
			r10cell5.setCellValue("Activity Status");
			r10cell5.setCellStyle(wrapname);
			r10cell6.setCellValue("Progress");
			r10cell6.setCellStyle(wrapname);
			r10cell7.setCellValue("Weightage");
			r10cell7.setCellStyle(wrapname);
			r10cell8.setCellValue("Startdate");
			r10cell8.setCellStyle(wrapname);
			r10cell9.setCellValue("PDC");
			r10cell9.setCellStyle(wrapname);
			r10cell10.setCellValue("OIC Name");
			r10cell10.setCellStyle(wrapname);

			if(!bookData.isEmpty()){     

				for(Object[] hlo :bookData) {			        	
					if(hlo[16].toString().equals("0")) {
						service.excelCellValuesSet(sheet, hlo, wrapname, ++rowCount);
						/*----------------------------------------------------------------------------------------*/	
						for(Object[] hlo1 :bookData) {			        	
							if(hlo1[16].toString().equals("1") && hlo1[1].toString().equals(hlo[0].toString())) {
								service.excelCellValuesSet(sheet, hlo1, wrapname, ++rowCount);
								/*----------------------------------------------------------------------------------------*/ 		
								for(Object[] hlo2 :bookData) {			        	
									if(hlo2[16].toString().equals("2") && hlo2[1].toString().equals(hlo1[0].toString())) {
										service.excelCellValuesSet(sheet, hlo2, wrapname, ++rowCount);
										/*----------------------------------------------------------------------------------------*/							        		
										for(Object[] hlo3 :bookData) {			        	
											if(hlo3[16].toString().equals("3") && hlo3[1].toString().equals(hlo2[0].toString())) {
												service.excelCellValuesSet(sheet, hlo3, wrapname, ++rowCount);
												/*----------------------------------------------------------------------------------------*/		
												for(Object[] hlo4 :bookData) {			        	
													if(hlo4[16].toString().equals("4") && hlo4[1].toString().equals(hlo3[0].toString())) {
														service.excelCellValuesSet(sheet, hlo4, wrapname, ++rowCount);
														/*----------------------------------------------------------------------------------------*/
														for(Object[] hlo5 :bookData) {			        	
															if(hlo5[16].toString().equals("5") && hlo5[1].toString().equals(hlo4[0].toString())) {
																service.excelCellValuesSet(sheet, hlo5, wrapname, ++rowCount);
															}
														}
														/*----------------------------------------------------------------------------------------*/
													}
												}
												/*----------------------------------------------------------------------------------------*/
											}
										}
										/*----------------------------------------------------------------------------------------*/							        		
									}
								}
								/*----------------------------------------------------------------------------------------*/	

							}
						}
						/*----------------------------------------------------------------------------------------*/						
					}
				}}




			sheet.autoSizeColumn(0);
			sheet.autoSizeColumn(1);
			sheet.setColumnWidth(2,5000);
			sheet.setColumnWidth(3,5000);
			sheet.setColumnWidth(4,5000);
			sheet.autoSizeColumn(5);
			sheet.autoSizeColumn(6);
			sheet.autoSizeColumn(7);
			sheet.autoSizeColumn(8);
			sheet.setColumnWidth(9,4000);


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
			logger.error(new Date() +"Inside MilestoneExcelFile.htm"+Username, e);

		}
	}	


	@RequestMapping(value = "FileRepMaster.htm")
	public String FileRepMaster(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileRepMaster.htm "+UserId);

		try {
			List<Object[] > projectslist= service.LoginProjectDetailsList(EmpId,Logintype,LabCode);				
			String projectid=req.getParameter("projectid");
			Map md = model.asMap();
			if(projectid==null) {		
				md = model.asMap();
				projectid = (String) md.get("projectid");   
			}
			if(projectid==null) {
				try {
					projectid=projectslist.get(0)[0].toString();
				}
				catch(Exception e) {
					e.printStackTrace();
				}
			}


			String FromName=null;

			FromName = (String) md.get("formname");   
			req.setAttribute("FromName",FromName);
			req.setAttribute("projectslist", projectslist);
			req.setAttribute("projectid",projectid);		
			req.setAttribute("filerepmasterlistall",service.FileRepMasterListAll(projectid,LabCode));
		}		
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside FileRepMaster.htm "+UserId, e); 
			return "static/Error";
		}
		return "filerepo/FileRepMaster";

	}


	@RequestMapping(value="FileRepMasterSubAdd.htm",method = RequestMethod.POST)
	public String FileMasterSubAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileMasterSubAdd.htm "+UserId);

		try {
			FileRepMaster fileRepo=new FileRepMaster();
			fileRepo.setLabCode(LabCode);
			fileRepo.setProjectId(Long.parseLong(req.getParameter("projectid")));
			fileRepo.setLevelName(req.getParameter("MasterSubName").trim());
			fileRepo.setParentLevelId(Long.parseLong(req.getParameter("FileMasterId")));
			fileRepo.setLevelId(Long.parseLong(req.getParameter("LevelId"))+1);
			fileRepo.setCreatedBy(UserId);
			long result=service.FileRepMasterSubInsert(fileRepo);
			if (result > 0) {
				redir.addAttribute("result", "File Rep Master Sub Added Successfully");
			} else {
				redir.addAttribute("resultfail", "File Rep Master Sub Add Unsuccessful");
			}
			redir.addFlashAttribute("formname", req.getParameter("formname"));
			redir.addFlashAttribute("projectid", req.getParameter("projectid"));
		}
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside FileMasterSubAdd.htm "+UserId, e); 
			return "static/Error";

		}
		return "redirect:/FileRepMaster.htm";
	}

	@RequestMapping(value="FileRepMasterAdd.htm",method = RequestMethod.POST)
	public String FileRepMasterAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileRepMasterAdd.htm "+UserId);

		try {
			FileRepMaster fileRepo=new FileRepMaster();
			fileRepo.setLabCode(LabCode);
			fileRepo.setLevelName(req.getParameter("MasterName").trim());
			fileRepo.setProjectId(Long.parseLong(req.getParameter("projectid")));
			fileRepo.setCreatedBy(UserId);
			long result=service.RepMasterInsert(fileRepo);
			if (result > 0) {
				redir.addAttribute("result", "File Master Added Successfully");
			} else {
				redir.addAttribute("resultfail", "File Master Add Unsuccessful");

			}
			redir.addFlashAttribute("formname", req.getParameter("formname"));
			redir.addFlashAttribute("projectid", req.getParameter("projectid"));
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside FileRepMasterAdd.htm "+UserId, e); 
			return "static/Error";
		}
		return "redirect:/FileRepMaster.htm";
	}


	@RequestMapping(value = "ProjectEmpListFetch.htm", method = RequestMethod.GET)
	public @ResponseBody String ProjectEmpListFetch(HttpServletRequest req,HttpSession ses) throws Exception {

		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside ProjectEmpListFetch.htm "+ UserId);	
		String projectid = req.getParameter("projectid");
		String LabCode =(String) ses.getAttribute("labcode");

		List<Object[]> EmployeeList=null;
		if(Long.parseLong(projectid)>0)
		{
			EmployeeList=service.ProjectEmpList(projectid , LabCode);
		}else if(Long.parseLong(projectid)==0)
		{
			EmployeeList=service.AllEmpNameDesigList(LabCode);
		}
		Gson json = new Gson();
		return json.toJson(EmployeeList);	
	}

	@RequestMapping(value = "ProjectEmpListEdit.htm", method = RequestMethod.GET)
	public @ResponseBody String ProjectEmpListEdit(HttpServletRequest req,HttpSession ses) throws Exception {

		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside ProjectEmpListEdit.htm "+ UserId);	
		String projectid=req.getParameter("projectid");
		String labcode = (String) ses.getAttribute("labcode");
		String empid=req.getParameter("EmpId");
		List<Object[]> EmployeeList=null;
		if(Long.parseLong(projectid)>0)
		{
			EmployeeList=service.ProjectEmpListEdit(projectid,empid);
		}else if(Long.parseLong(projectid)==0)
		{
			EmployeeList=service.AllEmpNameDesigList(labcode);
		}

		Gson json = new Gson();
		return json.toJson(EmployeeList);	
	}



	@RequestMapping(value = "AllFilesList.htm", method = RequestMethod.GET)
	public @ResponseBody String AllFilesList(HttpServletRequest req,HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside AllFilesList.htm "+UserId);
		List<Object[]> DocumentTitleList=new ArrayList<Object[]>();
		try {				
			String ProjectId=req.getParameter("projectid");
			String Sub=req.getParameter("subid");

			System.out.println("Sub   "+Sub);
			DocumentTitleList=service.DocumentTitleList(ProjectId,Sub,LabCode);
		}
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside AllFilesList.htm "+UserId, e); 
		}			
		Gson json = new Gson();
		return json.toJson(DocumentTitleList);	
	}

	@RequestMapping(value = "FileHistoryList.htm", method = RequestMethod.GET)
	public @ResponseBody String FileHistoryList(HttpServletRequest req,HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside FileHistoryList.htm "+UserId);
		List<Object[]> FileHistoryList=new ArrayList<Object[]>();
		try {				
			String filerepid=req.getParameter("filerepid");
			FileHistoryList=service.FileHistoryList(filerepid);
		}
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside FileHistoryList.htm "+UserId, e); 
		}			
		Gson json = new Gson();
		return json.toJson(FileHistoryList);	
	}

	@RequestMapping(value = "FileHistoryListAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String FileHistoryListAjax(HttpServletRequest req,HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");

		logger.info(new Date() +"Inside FileHistoryListAjax.htm "+UserId);
		List<Object[]> FileHistoryList=new ArrayList<Object[]>();
		try {				
			String ProjectId,MainSystem,SubLevelValue=null;

			ProjectId=req.getParameter("projectid");
			MainSystem=req.getParameter("mainsystemval");				
			SubLevelValue=req.getParameter("sublevel");				
			String Sub = req.getParameter("s"+SubLevelValue);													
			FileHistoryList=service.DocumentTitleList(ProjectId,Sub,LabCode);
		}
		catch (Exception e) 
		{				
			e.printStackTrace();  
			logger.error(new Date() +" Inside FileHistoryListAjax.htm "+UserId, e); 
		}			
		Gson json = new Gson();
		return json.toJson(FileHistoryList);	
	} 


	@RequestMapping(value = "FileDocMasterListAll.htm", method = RequestMethod.GET)
	public @ResponseBody String FileDocMasterListAll(HttpServletRequest req,HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileDocMasterListAll.htm "+UserId);
		List<Object[]> FileDocMasterListAll=new ArrayList<Object[]>();
		try 
		{	String projectid=req.getParameter("projectid");		
		FileDocMasterListAll= service.FileDocMasterListAll(projectid,LabCode);
		}
		catch (Exception e) 
		{
			e.printStackTrace();  
			logger.error(new Date() +" Inside FileDocMasterListAll.htm "+UserId, e); 
		}			
		Gson json = new Gson();
		return json.toJson(FileDocMasterListAll);	
	}


	@RequestMapping(value="ProjectDocumets.htm")
	public String ProjectDocumets(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectDocumets.htm "+UserId);
		try {
			String projectid=req.getParameter("projectid");
			Map md = model.asMap();
			if(projectid==null) {
				projectid= (String) md.get("projectid");
			}
			if(projectid==null){
				projectid="0";
			}
			req.setAttribute("DocumentTypeList",service.DocumentTypeList(projectid, LabCode));
			req.setAttribute("projectid", projectid);
			req.setAttribute("projectslist", service.LoginProjectDetailsList(EmpId, Logintype ,LabCode));
			return "filerepo/ProjectDocument";
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectDocumets.htm "+UserId, e); 
			return "static/Error";
		}
	}

	@RequestMapping(value="ProjectDocumetsSubmit.htm", method = RequestMethod.POST )
	public String ProjectDocumetsSubmit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ProjectDocumetsSubmit.htm "+UserId);
		try {
			String projectid=req.getParameter("projectid");
			String[] documentids=req.getParameterValues("documentid");				

			FileProjectDocDto dto=new FileProjectDocDto();
			dto.setProjectid(projectid);
			dto.setFileUploadMasterId(documentids);
			dto.setCreatedBy(UserId);
			long count = service.ProjectDocumetsAdd(dto);

			if (count > 0) {
				redir.addAttribute("result", "Adding File(s) to Project Successfully");
			} else {
				redir.addAttribute("resultfail", "Adding File(s) to Project Unsuccessful");

			}

			redir.addFlashAttribute("projectid", projectid);
			return "redirect:/ProjectDocumets.htm";
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectDocumetsSubmit.htm "+UserId, e); 
			return "static/Error";
		}
	}

	@RequestMapping(value="AddDocAmendment.htm",method = RequestMethod.POST)
	public String AddDocAmmendment(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,@RequestPart("AmendFileAttach") MultipartFile FileAttach)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside AddDocAmendment.htm "+UserId);
		try {
			//								
			FileDocAmendmentDto amenddoc=new FileDocAmendmentDto(); 
			amenddoc.setFileRepUploadId(req.getParameter("uploaddocid"));
			amenddoc.setFileName(FileAttach.getOriginalFilename());
			amenddoc.setFilePass(req.getParameter("Path"));
			amenddoc.setCreatedBy(UserId);
			amenddoc.setDescription(req.getParameter("Amenddescription"));
			amenddoc.setProjectId(req.getParameter("projectidvalue"));
			amenddoc.setInStream(FileAttach.getInputStream());
			amenddoc.setLabCode(LabCode);
			long count=service.FileAmmendUploadNew(amenddoc);

			if (count > 0) {
				redir.addAttribute("result", "Document Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Document Add Unsuccessful");
			}

			redir.addFlashAttribute("MainSystemValue", req.getParameter("mainsystemval"));
			redir.addFlashAttribute("s1", req.getParameter("s1"));
			redir.addFlashAttribute("s2", req.getParameter("s2"));
			redir.addFlashAttribute("s3", req.getParameter("s3"));
			redir.addFlashAttribute("s4", req.getParameter("s4"));
			redir.addFlashAttribute("sublevel", req.getParameter("sublevel"));
			redir.addFlashAttribute("projectid", req.getParameter("projectidvalue"));
			redir.addFlashAttribute("doclev1", req.getParameter("doclev1"));
			redir.addFlashAttribute("doclev2", req.getParameter("doclev2"));
			redir.addFlashAttribute("doclev3", req.getParameter("documenttitle"));

			return "redirect:/TestingFileRepo.htm";
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside AddDocAmendment.htm "+UserId, e); 
			return "static/Error";
		}
	}

	@RequestMapping(value = "AmendmentData.htm", method = RequestMethod.GET)
	public @ResponseBody String AmendmentData(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		List<Object[]> AmendmentData =null;
		logger.info(new Date() +"Inside AmendmentData.htm "+UserId);

		try {
			AmendmentData=service.DocumentAmendment(req.getParameter("DocUploadId"));
			if(AmendmentData.size()==0) {
				AmendmentData=null;
			}
		}catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside AmendmentData.htm "+UserId, e);
		}
		Gson json = new Gson();
		return json.toJson(AmendmentData);

	}

	@RequestMapping(value = "AmendmentFilesZipDownload.htm", method = RequestMethod.POST)
	public void AmendmentFilesZipDownload(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside AmendmentFilesZipDownload.htm "+UserId);
		try { 	

			List<String> amendlist=new ArrayList<String>();

			String Id=req.getParameter("Amendfileid");
			String path=req.getServletContext().getRealPath("/view/temp");
			Zipper zip=new Zipper();
			Object[] obj=service.FileDeatils(Id).get(0);                            	
			List<Object[]> amendmentsdata= service.DocumentAmendment(Id);
			for(Object[] amend:amendmentsdata) {
				zip.unpack(FilePath+amend[5].toString()+amend[2].toString()+amend[1].toString()+"-"+amend[4].toString()+".zip",path,amend[6].toString());
				amendlist.add(path+"/"+amend[7]);
			}

			amendlist.forEach(item->{
				if(item instanceof String){
				}
			});           

			res.setContentType("APPLICATION/OCTET-STREAM");
			res.setHeader("Content-Disposition","attachment; filename="+obj[3]+"-Amendments.zip");

			ArrayList<File> files = new ArrayList<File>();
			amendlist.forEach(item->{
				files.add(new File(item));

			});
			ServletOutputStream out = res.getOutputStream();
			ZipOutputStream zos = new ZipOutputStream(new BufferedOutputStream(out));                

			for (File file : files) {

				zos.putNextEntry(new ZipEntry(file.getName()));

				FileInputStream fis = null;
				try {
					fis = new FileInputStream(file);

				} catch (FileNotFoundException fnfe) 
				{

					zos.write(("ERRORld not find file " + file.getName()).getBytes());
					zos.closeEntry();
					continue;
				}

				BufferedInputStream fif = new BufferedInputStream(fis);

				// Write the contents of the file
				int data = 0;
				while ((data = fif.read()) != -1) 
				{        				
					zos.write(data);
				}
				fif.close();
				zos.closeEntry();
			}

			zos.close();
			for(File file:files)
			{
				file.delete();
			}



		}
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside AmendmentFilesZipDownload.htm "+UserId, e); 

		}

	}


	@RequestMapping(value = "FileUnpack.htm", method = RequestMethod.POST)
	public void FileUnpack(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside FileUnpack.htm "+UserId);

		try {	
			String Id=req.getParameter("FileUploadId");
			Object[] obj=service.FileDeatils(Id).get(0);
			String path=req.getServletContext().getRealPath("/view/temp");
			Zipper zip=new Zipper();
			String tecdata = obj[2].toString().replaceAll("[/\\\\]", ",");
			String[] fileParts = tecdata.split(",");
			String zipName = String.format(obj[3].toString()+obj[7].toString()+"-"+obj[6].toString()+".zip");
			Path techPath = Paths.get(FilePath, fileParts[0],fileParts[1],fileParts[2],fileParts[3],fileParts[4],zipName);
			zip.unpack(techPath.toString(), path,obj[5].toString());

			res.setContentType("application/pdf");
			res.setHeader("Content-disposition","attachment;filename="+obj[4]); 
			File f=new File(path+"/"+obj[4]);
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
			Path pathOfFile2= Paths.get(path+"/"+obj[4]); 
			Files.delete(pathOfFile2);

		}
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside FileUnpack.htm "+UserId, e); 

		}

	}


	@RequestMapping(value = "AmendFileUnpack.htm", method = RequestMethod.POST)
	public void AmendFileUnpack(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside AmendFileUnpack.htm "+UserId);

		try {	
			String Id=req.getParameter("amendfileid");
			Object[] obj	=service.DocumentAmendmentData(Id);
			String path=req.getServletContext().getRealPath("/view/temp");
			Zipper zip=new Zipper();
			zip.unpack(FilePath+obj[5].toString()+obj[2].toString()+obj[1].toString()+"-"+obj[4].toString()+".zip",path,obj[6].toString());
			res.setContentType("application/pdf");
			res.setHeader("Content-disposition","attachment;filename="+obj[7]); 
			File f=new File(path+"/"+obj[7]);
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

			Path pathOfFile2= Paths.get(path+"/"+obj[7]); 
			Files.delete(pathOfFile2);

		}
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside AmendFileUnpack.htm "+UserId, e); 

		}

	}


	@RequestMapping(value = "DocumentsZipDownload.htm", method = RequestMethod.POST)
	public void DocumentsZipDownload(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocumentsZipDownload.htm "+UserId);
		try { 	
			String repmasterid=req.getParameter("filerepmasterid");


			List<String> DocsList=new ArrayList<String>();				

			String path=req.getServletContext().getRealPath("/view/temp");

			Object[] repmasterdata=service.RepMasterData(repmasterid);   
			List<Object[]> DocsData= service.RepMasterAllDocLists(repmasterid);


			Zipper zip=new Zipper();

			for(Object[] Doc:DocsData) 
			{   Path uploadPath = Paths.get(FilePath, Doc[2].toString(),(Doc[3].toString()+Doc[7].toString()+"-"+Doc[6].toString()+".zip"));
			zip.unpack(uploadPath.toString(),path,Doc[5].toString());
			File OFile=new File(path+"/"+Doc[4]);
			File NFile=new File(path+"/"+Doc[13]+"-"+Doc[14]+"-"+Doc[4]);
			OFile.renameTo(NFile);
			DocsList.add(path+"/"+Doc[13]+"-"+Doc[14]+"-"+Doc[4]);
			}


			res.setContentType("APPLICATION/OCTET-STREAM");
			res.setHeader("Content-Disposition","attachment; filename="+repmasterdata[2]+"-Docs.zip");

			ArrayList<File> files = new ArrayList<File>();
			DocsList.forEach(item->{
				files.add(new File(item));
			});
			ServletOutputStream out = res.getOutputStream();
			ZipOutputStream zos = new ZipOutputStream(new BufferedOutputStream(out));                

			for (File file : files) 
			{
				zos.putNextEntry(new ZipEntry(file.getName()));
				FileInputStream fis = null;
				try 
				{
					fis = new FileInputStream(file);
				}
				catch (FileNotFoundException fnfe) 
				{
					zos.write(("ERRORld not find file " + file.getName()).getBytes());
					zos.closeEntry();
					continue;
				}
				BufferedInputStream fif = new BufferedInputStream(fis);
				// Write the contents of the file
				int data = 0;
				while ((data = fif.read()) != -1) 
				{        				
					zos.write(data);
				}
				fif.close();
				zos.closeEntry();
			}

			zos.close();
			for(File file:files)
			{
				file.delete();
			}

		}
		catch (Exception e) {

			e.printStackTrace();  
			logger.error(new Date() +" Inside DocumentsZipDownload.htm "+UserId, e); 

		}

	}

	@RequestMapping(value = "ProjectModuleNameEdit.htm", method = RequestMethod.POST)
	public String ProjectModuleNameEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectModuleNameEdit.htm "+UserId);		
		try {

			String filerepmasterid = req.getParameter("filerepmasterid");
			String levelname = req.getParameter("levelname").trim();
			int count = service.fileRepMasterEditSubmit(filerepmasterid, levelname);

			if (count > 0) {
				redir.addAttribute("result", "Module Name Updated  Successfuly.");
			} else {
				redir.addAttribute("resultfail", "Module Name Update Unsuccessful");
			}

			redir.addFlashAttribute("formname", req.getParameter("formname"));
			redir.addFlashAttribute("projectid", req.getParameter("projectid"));
			return "redirect:/FileRepMaster.htm";
		}
		catch (Exception e) 
		{
			e.printStackTrace();  
			logger.error(new Date() +" Inside ProjectModuleNameEdit.htm "+UserId, e); 
			return "static/Error";
		}
	}

	@RequestMapping(value = "FileListInRepo.htm", method = RequestMethod.GET)
	public String FileListInRepo(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileListInRepo.htm "+UserId);		
		try {
			req.setAttribute("docmasterlist", service.fileDocMasterList(LabCode));
			return "filerepo/DocumentsList";
		}
		catch (Exception e) 
		{
			e.printStackTrace();  
			logger.error(new Date() +" Inside FileListInRepo.htm "+UserId, e); 
			return "static/Error";
		}
	}

	@RequestMapping(value = "FileLevelSubLevelAdd.htm", method = RequestMethod.POST)
	public String FileLevelSubLevelAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileLevelSubLevelAdd.htm "+UserId);		
		try {
			FileDocMaster docmaster = new FileDocMaster();
			docmaster.setLabCode(LabCode);
			docmaster.setLevelId(Integer.parseInt(req.getParameter("levelid")));
			docmaster.setParentLevelId(Integer.parseInt(req.getParameter("parentlevel")));
			docmaster.setLevelName(req.getParameter("levelname").trim());
			docmaster.setCreatedBy(UserId);

			long count = service.FileDocMasterAdd(docmaster);

			if (count > 0) {
				redir.addAttribute("result", "File Level Added Successfully");
			} else {
				redir.addAttribute("resultfail", "File Level Add Unsuccessful");
			}

			return "redirect:/FileListInRepo.htm";
		}
		catch (Exception e) 
		{
			e.printStackTrace();  
			logger.error(new Date() +" Inside FileLevelSubLevelAdd.htm "+UserId, e); 
			return "static/Error";
		}
	}


	@RequestMapping(value = "FileLevelSublevelNameCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String FileLevelSublevelNameCheck(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileLevelSublevelNameCheck.htm "+UserId);

		String levelname= req.getParameter("levelname");			
		List<FileDocMaster> FileLevelSublevelName = service.FileLevelSublevelNameCheck(levelname.trim(),LabCode);

		return String.valueOf(FileLevelSublevelName.size());
	}

	@RequestMapping(value = "FileNameCheck.htm", method = RequestMethod.GET)
	public @ResponseBody String FileNameCheck(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileNameCheck.htm "+UserId);

		String levelname= req.getParameter("levelname");
		String shortname= req.getParameter("shortname"); 
		String docid= req.getParameter("docid");
		String parentlevelid= req.getParameter("parentlevelid");

		Object[] FileLevelSublevelName = service.fileNameCheck(levelname.trim(), shortname.trim(), docid.trim(),parentlevelid,LabCode);

		Gson json = new Gson();
		return json.toJson(FileLevelSublevelName);
	}

	@RequestMapping(value = "FileNameAdd.htm", method = RequestMethod.POST)
	public String FileNameAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileNameAdd.htm "+UserId);		
		try {
			FileDocMaster docmaster = new FileDocMaster();
			docmaster.setLabCode(LabCode);
			docmaster.setLevelId(3);
			docmaster.setParentLevelId(Integer.parseInt(req.getParameter("parentlevel")));
			docmaster.setLevelName(req.getParameter("levelname").trim());
			docmaster.setDocShortName(req.getParameter("docshortname").trim());
			docmaster.setDocId(Long.parseLong(req.getParameter("docid")));
			docmaster.setCreatedBy(UserId);

			long count = service.FileDocMasterAdd(docmaster);

			if (count > 0) {
				redir.addAttribute("result", "File Name Added Successfully");
			} else {
				redir.addAttribute("resultfail", "File Name Add Unsuccessful");
			}

			return "redirect:/FileListInRepo.htm";
		}
		catch (Exception e) 
		{
			e.printStackTrace();  
			logger.error(new Date() +" Inside FileNameAdd.htm "+UserId, e); 
			return "static/Error";
		}
	}

	@RequestMapping(value = "FileRepMasterListAllAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String FileRepMasterListAllAjax(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside FileRepMasterListAllAjax.htm "+UserId);

		String projectid= req.getParameter("projectid");	
		List<Object[]> FileLevelSublevelName = service.FileRepMasterListAll(projectid,LabCode);

		Gson json = new Gson();
		return json.toJson(FileLevelSublevelName);
	}


	@RequestMapping(value = "MileRemarkUpdate.htm", method = RequestMethod.POST)
	public String MileRemarkUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MileRemarkUpdate.htm "+UserId);		
		try {

			MilestoneActivityDto mainDto=new MilestoneActivityDto();
			mainDto.setActivityId(req.getParameter("MileId"));
			mainDto.setStatusRemarks(req.getParameter("Remarks"));
			mainDto.setFinancaOutlay(Double.parseDouble(req.getParameter("financialoutlay")));
			mainDto.setCreatedBy(UserId);
			long count =service.MilestoneRemarkUpdate(mainDto);

			if (count > 0) {

				redir.addAttribute("result", "Milestone Remark Updated   Successfuly.");

			} else {
				redir.addAttribute("resultfail", "Milestone Remark Update Unsuccessful");
			}

			redir.addFlashAttribute("ProjectId",req.getParameter("projectid"));
			return "redirect:/M-A-AssigneeList.htm";

		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside MileRemarkUpdate.htm "+UserId, e); 
			return "static/Error";
		}


	}


	@RequestMapping(value = "MainMilestoneDOCUpdate.htm", method = RequestMethod.POST)
	public String MainMilestoneDOCUpdate(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MainMilestoneDOCUpdate.htm "+UserId);		
		try {
			String MainId = req.getParameter("MSMainid");
			String DateOfCompletion = req.getParameter("DateOfCompletion");
			long count =service.MainMilestoneDOCUpdate(MainId, DateOfCompletion, UserId) ;

			if (count > 0) {
				redir.addAttribute("result", "Milestone Completion Date Updated Successfuly.");
			} else {
				redir.addAttribute("resultfail", "Milestone Completion Date Update Unsuccessful");
			}
			redir.addFlashAttribute("ProjectId",req.getParameter("projectid"));
			return "redirect:/MilestoneActivityList.htm";

		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside MainMilestoneDOCUpdate.htm "+UserId, e); 
			return "static/Error";
		}
	}

	//prakarsh--------------------------------------------------------------------------------
	@RequestMapping(value = "IsActive.htm", method = RequestMethod.GET)
	public @ResponseBody  String SetIsActive(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside IsActive.htm "+UserId);	
		try {
			String project=req.getParameter("Project");
			String FileParentId=req.getParameter("FileParentId");


			String flag=req.getParameter("Flag");

			if(flag.equalsIgnoreCase("B")) {
				service.IsActive(project, FileParentId);
			}else if(flag.equalsIgnoreCase("A")) {
				int count=   service.IsFileInActive(project,FileParentId);
				service.IsActive(project, FileParentId);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		Gson json = new Gson();
		return json.toJson(1);
	}


	//ajax call controller
	@RequestMapping(value = "IsActive1.htm", method = RequestMethod.GET)
	public @ResponseBody String DocumentLinkList(HttpServletRequest req,HttpSession ses) throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside ExternalEmployeeListInvitations.htm"+ UserId);
		String project=req.getParameter("Project");
		String FileParentId=req.getParameter("FileParentId");

		List<Object[]> DocumentLinkList = new ArrayList<Object[]>();

		DocumentLinkList = service.FileRepUploadId(project,FileParentId);
		req.setAttribute("FileRepUploadId", DocumentLinkList);
		Gson json = new Gson();
		return json.toJson(DocumentLinkList);	
	}

	//document lsit edit controller
	@RequestMapping(value = "DocumentListNameEdit.htm", method = RequestMethod.GET)
	public String DocumentListNameEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectModuleNameEdit.htm "+UserId);		
		try {

			String filerepmasterid = req.getParameter("filerepmasterid");
			System.out.println("filerepmasterid--"+filerepmasterid);
			String levelname = req.getParameter("levelname").trim();
			System.out.println("levelname---"+levelname);
			int count = service.DocumentListNameEdit(filerepmasterid, levelname);

			if (count > 0) {
				redir.addAttribute("result", "Module Name Updated  Successfuly.");
			} else {
				redir.addAttribute("resultfail", "Module Name Update Unsuccessful");
			}

			redir.addFlashAttribute("formname", req.getParameter("formname"));
			redir.addFlashAttribute("projectid", req.getParameter("projectid"));
			return "redirect:/FileListInRepo.htm";
		}
		catch (Exception e) 
		{
			e.printStackTrace();  
			logger.error(new Date() +" Inside ProjectModuleNameEdit.htm "+UserId, e); 
			return "static/Error";
		}
	}

	//filedownlaod avaialable check controller
	@RequestMapping(value = "FileRepoSize.htm", method = RequestMethod.GET)
	public @ResponseBody String FileDownloadAvailable(HttpServletRequest req,HttpSession ses) throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside FileDownloadAvailable.htm"+ UserId);
		String repmasterid=req.getParameter("FileRepMasterId");

		List<Object[]> DocsData= service.RepMasterAllDocLists(repmasterid);

		int DocsDatasize=DocsData.size();
		Gson json = new Gson();
		return json.toJson(DocsDatasize);	
	}	
	@RequestMapping(value = "MSProjectMilestone.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MSProjectMilestone(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{


		String UserId = (String) ses.getAttribute("Username");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MSProjectMilestone.htm "+UserId);

		try {

			String ProjectId=req.getParameter("ProjectId");

			List<Object[] > projlist= service.LoginProjectDetailsList(EmpId,Logintype,LabCode);

			if(projlist.size()==0) 
			{				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}



			if(ProjectId==null) {
				try {
					Object[] pro=projlist.get(0);
					ProjectId=pro[0].toString();
				}catch (Exception e) {

				}
			}

			List<Object[]>mstaskList = service.getMsprojectTaskList(ProjectId);

			req.setAttribute("ProjectList",projlist);
			req.setAttribute("ProjectId", ProjectId);
			req.setAttribute("ProjectDetails", service.ProjectDetails(ProjectId).get(0));
			req.setAttribute("mstaskList",mstaskList);


		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside MSProjectMilestone.htm "+UserId, e); 
			return "static/Error";
		}


		return "milestone/MSprojectMilestone";
	}

	@RequestMapping(value = "MSprojectGanttChart.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MSprojectGanttChart(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{


		String UserId = (String) ses.getAttribute("Username");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MSprojectGanttChart.htm "+UserId);


		try {
			String ProjectId=req.getParameter("ProjectId");
			List<Object[]>mstaskList = service.getMsprojectTaskList(ProjectId);
			req.setAttribute("ProjectId", ProjectId);
			req.setAttribute("ProjectDetails", service.ProjectDetails(ProjectId).get(0));
			req.setAttribute("mstaskList",mstaskList);

		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside MSprojectGanttChart.htm "+UserId, e); 
			return "static/Error";
		}

		return "milestone/MsProjectGantChart";

	}

	@RequestMapping(value = "MSprojectCriticalPath.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MSprojectCriticalPath(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{


		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MSprojectCriticalPath.htm "+UserId);


		try {
			String ProjectId=req.getParameter("ProjectId");
			List<Object[]> mstaskList = service.getMsprojectTaskList(ProjectId);
			List<Object[]> msCriticalPathList = mstaskList!=null && mstaskList.size()>0?mstaskList.stream().filter(e -> Integer.parseInt(e[16].toString())==1).collect(Collectors.toList()):new ArrayList<>();
			req.setAttribute("ProjectId", ProjectId);
			req.setAttribute("ProjectDetails", service.ProjectDetails(ProjectId).get(0));
			req.setAttribute("msCriticalPathList", msCriticalPathList);

		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside MSprojectCriticalPath.htm "+UserId, e); 
			return "static/Error";
		}

		return "milestone/MsProjectCriticalPath";

	}

	@PostMapping(value = "DocFileUpload.htm")
	public @ResponseBody String DocFileUploadAjax(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res,
			@RequestParam(name = "file", required = false) MultipartFile file,
			@RequestParam("FileRepId") String fileRepId,
			@RequestParam("projectid") String projectid,
			@RequestParam("mainLevelId") String mainLevelId,
			@RequestParam("subLevelId") String subLevelId,
			@RequestParam("docId") String docId,
			@RequestParam("FileNameUI") String fileNameUI,
			@RequestParam("FileVersion") String fileVersion,
			@RequestParam("HeaderValue") String fileValue,
			@RequestParam("FileRelease") String fileRelease )throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside DocFileUpload.htm "+UserId);
		try {

			String agendaid = req.getParameter("agendaid");

			FileUploadDto upload = new FileUploadDto();
			upload.setFileId(fileRepId);
			upload.setFileRepMasterId(mainLevelId);
			upload.setSubL1(subLevelId);
			upload.setDocid(docId);
			upload.setFileName(fileNameUI);
			upload.setIS(file.getInputStream());
			upload.setFileNamePath(file.getOriginalFilename());
			upload.setPathName(fileValue);
			upload.setRel(fileRelease);
			upload.setVer(fileVersion);
			upload.setProjectId(projectid);
			upload.setUserId(UserId);
			upload.setLabCode(LabCode);
			upload.setAgendaId(agendaid);

			long result = service.DocFileUploadAjax(upload);

			Gson json = new Gson();
			return json.toJson(result);

		} catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocFileUpload.htm "+UserId, e); 
			return "static/Error";
		}
	}

	@RequestMapping(value = "getAttachmentId.htm", method = RequestMethod.GET)
	public @ResponseBody String getAttachmentId(HttpServletRequest req,HttpSession ses) throws Exception {

		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside getAttachmentId.htm "+ UserId);		
		String projectid=req.getParameter("projectid");		
		List<Object[]> attach = service.getAttachmentId(projectid);
		Gson json = new Gson();
		if(attach!=null && attach.size()>0) {
			return json.toJson(attach.get(0));
		}
		return json.toJson("");
	}

	@RequestMapping(value = "submitCheckboxFile.htm", method = RequestMethod.GET)
	public @ResponseBody String submitCheckboxFile(HttpServletRequest req,HttpSession ses) throws Exception {

		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside submitCheckboxFile.htm "+ UserId);		
		String techDataId=req.getParameter("techDataId");	
		String attachid=req.getParameter("attachid");
		String projectid=req.getParameter("projectid");
		long result = service.submitCheckboxFile(UserId,techDataId,attachid,projectid);
		Gson json = new Gson();
		return json.toJson(result);	
	}


	@RequestMapping(value = "ProjectDocsList.htm", method = RequestMethod.GET)
	public @ResponseBody String ProjectDocsList(HttpServletRequest req,HttpSession ses)
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectDocsList.htm "+UserId);
		try {
			String projectid=req.getParameter("projectid");		
			List<Object[]> projectdoclist = service.FileDocMasterListAll(projectid,LabCode);
			Gson json = new Gson();
			if(projectdoclist!=null && projectdoclist.size()>0) {
				return json.toJson(projectdoclist);
			}
			return json.toJson("");
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectDocsList.htm "+UserId, e); 
		}
		return "";
	}

	@RequestMapping(value = "MSprojectProcurementList.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String msprojectProcurementList(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MSprojectProcurementList.htm "+UserId);

		try {
			String ProjectId=req.getParameter("ProjectId");
			List<Object[]> msProjectList = service.getMsprojectTaskList(ProjectId);
			List<Object[]> msProcurementList = msProjectList!=null && msProjectList.size()>0?msProjectList.stream().filter(e -> Integer.parseInt(e[20].toString())==1).collect(Collectors.toList()):new ArrayList<>();
			req.setAttribute("ProjectId", ProjectId);
			req.setAttribute("projectDetails", service.ProjectDetails(ProjectId).get(0));
			req.setAttribute("msProcurementList", msProcurementList);

		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside MSprojectProcurementList.htm "+UserId, e); 
			return "static/Error";
		}

		return "milestone/MSprojectProcurementList";

	}
	
	@RequestMapping(value = "MSprojectProcurementStatus.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String msprojectProcurementStatus(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MSprojectProcurementStatus.htm "+UserId);
		
		try {
			String projectId = req.getParameter("ProjectId");
			req.setAttribute("ProjectId", projectId);
			req.setAttribute("projectDetails", service.ProjectDetails(projectId).get(0));
			req.setAttribute("msProcurementStatusList", service.getMsprojectProcurementStatusList(projectId));
			
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside MSprojectProcurementStatus.htm "+UserId, e); 
			return "static/Error";
		}
		
		return "milestone/MSprojectProcurementStatus";
		
	}

	@RequestMapping(value = "MSprojectProcurementGanttChart.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String msprojectProcurementGanttChart(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MSprojectProcurementGanttChart.htm "+UserId);
		
		try {
			String ProjectId=req.getParameter("ProjectId");
			List<Object[]> mstaskList = service.getMsprojectTaskList(ProjectId);
			List<Object[]> msProcurementList = mstaskList!=null && mstaskList.size()>0?mstaskList.stream().filter(e -> Integer.parseInt(e[20].toString())==1).collect(Collectors.toList()):new ArrayList<>();
			req.setAttribute("ProjectId", ProjectId);
			req.setAttribute("projectDetails", service.ProjectDetails(ProjectId).get(0));
			req.setAttribute("msProcurementList", msProcurementList);
			
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside MSprojectProcurementGanttChart.htm "+UserId, e); 
			return "static/Error";
		}
		
		return "milestone/MSprojectProcurementGanttChart";
		
	}
	
}
