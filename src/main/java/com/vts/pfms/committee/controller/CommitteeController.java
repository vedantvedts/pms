package com.vts.pfms.committee.controller;

import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFFooter;
import org.apache.poi.xwpf.usermodel.XWPFHeader;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;

import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblGrid;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblGridCol;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblWidth;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTcPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTVMerge;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTblWidth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailAuthenticationException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.introspect.VisibilityChecker;
import com.google.gson.Gson;
import com.ibm.icu.math.BigDecimal;
import com.ibm.icu.text.DecimalFormat;
import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.utils.PdfMerger;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.font.FontProvider;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.Zipper;
import com.vts.pfms.committee.dto.CommitteeConstitutionApprovalDto;
import com.vts.pfms.committee.dto.CommitteeDto;
import com.vts.pfms.committee.dto.CommitteeInvitationDto;
import com.vts.pfms.committee.dto.CommitteeMainDto;
import com.vts.pfms.committee.dto.CommitteeMembersDto;
import com.vts.pfms.committee.dto.CommitteeMembersEditDto;
import com.vts.pfms.committee.dto.CommitteeMinutesAttachmentDto;
import com.vts.pfms.committee.dto.CommitteeMinutesDetailsDto;
import com.vts.pfms.committee.dto.CommitteeScheduleAgendaDto;
import com.vts.pfms.committee.dto.CommitteeScheduleDto;
import com.vts.pfms.committee.dto.CommitteeSubScheduleDto;
import com.vts.pfms.committee.dto.EmpAccessCheckDto;
import com.vts.pfms.committee.model.Committee;
import com.vts.pfms.committee.model.CommitteeDefaultAgenda;
import com.vts.pfms.committee.model.CommitteeDivision;
import com.vts.pfms.committee.model.CommitteeInitiation;
import com.vts.pfms.committee.model.CommitteeMeetingDPFMFrozen;
import com.vts.pfms.committee.model.CommitteeMinutesAttachment;
import com.vts.pfms.committee.model.CommitteeProject;
import com.vts.pfms.committee.model.CommitteeScheduleAgendaDocs;
import com.vts.pfms.committee.service.CommitteeService;
import com.vts.pfms.mail.CustomJavaMailSender;
import com.vts.pfms.master.dto.ProjectFinancialDetails;
import com.vts.pfms.model.TotalDemand;
import com.vts.pfms.print.controller.PrintController;
import com.vts.pfms.print.service.PrintService;
import com.vts.pfms.utils.PMSLogoUtil;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTSectPr;

import org.apache.poi.util.Units;
import org.apache.poi.wp.usermodel.HeaderFooterType;

@Controller
public class CommitteeController {

	@Autowired CommitteeService service;
	
//	@Autowired 
//	private JavaMailSender javaMailSender;
	
	@Autowired
	CustomJavaMailSender cm;
	
	@Autowired 
	BCryptPasswordEncoder encoder;
	
	@Autowired
	PrintService printservice;
	
	@Autowired 
	RestTemplate restTemplate;

	@Value("${server_uri}")
	private String uri;
	
	@Autowired
	Environment env;
	
	@Value("${ApplicationFilesDrive}")
	private String ApplicationFilesDrive;
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Value("${File_Size}")
	String file_size;
	
	@Value("#{${CommitteeCodes}}")
	private List<String> SplCommitteeCodes;
	
	@Autowired
	PrintController pt;
	
	@Autowired
	PMSLogoUtil LogoUtil;
	  SimpleDateFormat inputFormat = new SimpleDateFormat("ddMMMyyyy");
      SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
	FormatConverter fc=new FormatConverter(); 
	SimpleDateFormat sdf3=fc.getRegularDateFormat();
	SimpleDateFormat sdf=fc.getRegularDateFormatshort();
	SimpleDateFormat sdf1=fc.getSqlDateFormat(); int addcount=0; 
	Format  format = com.ibm.icu.text.NumberFormat.getCurrencyInstance(new Locale("en", "in"));
	
	private static final Logger logger=LogManager.getLogger(CommitteeController.class);
	
	@RequestMapping(value = "CommitteeAdd.htm")
	public String CommitteeAddPage(HttpServletRequest req, HttpSession ses) throws Exception
	{	
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeAdd.htm "+UserId);
		String projectid=req.getParameter("projectid");
		String projectappliacble=req.getParameter("projectappliacble");
		
		if(Long.parseLong(projectid)>0)
		{
			req.setAttribute("projectdetails",service.projectdetails(projectid));
		}		
		req.setAttribute("projectid",projectid);
		req.setAttribute("projectappliacble",projectappliacble);
		req.setAttribute("projectslist",service.ProjectList(LabCode));		
		return "committee/CommitteeAdd";
	}
	
	

	
	@RequestMapping(value = "CommitteeAddSubmit.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String CommitteeAddSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeAddSubmit.htm "+UserId);		
		try {		
				String projectid=req.getParameter("projectid").trim();
				CommitteeDto committeeDto=new CommitteeDto();
				
				committeeDto.setCommitteeName(req.getParameter("committeename").trim());
				committeeDto.setCommitteeShortName(req.getParameter("committeeshortname").trim());
				committeeDto.setCreatedBy(UserId);
				committeeDto.setCommitteeType(req.getParameter("committeetype"));
				committeeDto.setProjectApplicable(req.getParameter("projectapplicable"));
				committeeDto.setTechNonTech(req.getParameter("technontech"));
				committeeDto.setPeriodicNon(req.getParameter("periodic"));
				committeeDto.setDescription(req.getParameter("description").trim());
				committeeDto.setTermsOfReference(req.getParameter("TOR").trim());
				committeeDto.setIsGlobal(projectid);
				if(req.getParameter("periodic").equalsIgnoreCase("P"))
				{
					committeeDto.setPeriodicDuration(req.getParameter("periodicduration"));
				}else
				{
					committeeDto.setPeriodicDuration("0");
				}
				
				committeeDto.setGuidelines(req.getParameter("guidelines"));
				committeeDto.setLabCode(LabCode);
				long count=0;
				
				count=service.CommitteeAdd(committeeDto);
				long count1=0;
				if(Long.parseLong(projectid)>0) {
					String ProjectId=req.getParameter("projectid");
					String[] Committee=new String[1];
					Committee[0]=String.valueOf(count);
					count1=service.ProjectCommitteeAdd(ProjectId,Committee,UserId);
				}
				if (count > 0) 
				{
					redir.addAttribute("result", "Committee Added Successfully");
					redir.addAttribute("projectappliacble",req.getParameter("projectapplicable"));
					redir.addAttribute("projectid", projectid);
					
					return "redirect:/CommitteeList.htm";					
				} 
				else if(count==-1)
				{
					redir.addAttribute("resultfail", "Committee short name already exists ");
				}
				else if(count==-2) 
				{
					redir.addAttribute("resultfail", "Committee "+committeeDto.getCommitteeName()+" already exists,  ");
				}
				else  
				{
					redir.addAttribute("resultfail", "Committee Adding Failed!! Tryagain");
				}
				redir.addAttribute("projectid", projectid);		
				
				return "redirect:/CommitteeAdd.htm";
		}
		catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +" Inside CommitteeAddSubmit.htm "+UserId, e);
				return "static/Error";
		}
	}
	
	
	@RequestMapping(value = "CommitteeList.htm")
	public String CommitteeList(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");		
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeList.htm "+UserId);
		try {		
			String projectid=req.getParameter("projectid");
			if(projectid==null)
			{			
				Map md=model.asMap();
				projectid=(String)md.get("projectid");
			}
			if(projectid==null)
			{
				projectid="0";
			}			
			String projectappliacble=req.getParameter("projectappliacble");
			if(projectappliacble==null)
			{			
				Map md=model.asMap();
				projectappliacble=(String)md.get("projectappliacble");				
			}
			
			if(projectappliacble==null)
			{
				projectappliacble="N";
			}
			
			if(Long.parseLong(projectid)>0)
			{
				req.setAttribute("projectdetails",service.projectdetails(projectid));
			}
			List<Object[]> committeelist= service.CommitteeListActive(projectid,projectappliacble,LabCode);			
			req.setAttribute("projectappliacble",projectappliacble);
			req.setAttribute("projectslist",service.ProjectList(LabCode));
			req.setAttribute("projectid",projectid);
			req.setAttribute("committeelist",committeelist);
			return "committee/CommitteeList";
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside CommitteeList.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CommitteeEdit.htm")
	public String CommitteeEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");		
		logger.info(new Date() +"Inside CommitteeEdit.htm "+UserId);
		String LabCode =(String) ses.getAttribute("labcode");
		try {
			String committeeid=req.getParameter("committeeid");
			Object[] CommitteeDetails=service.CommitteeDetails(committeeid);			
			String projectid=CommitteeDetails[12].toString();
			if(Long.parseLong(projectid)>0)
			{
				req.setAttribute("projectdetails",service.projectdetails(projectid));
			}
			req.setAttribute("committeedetails",CommitteeDetails );	
			req.setAttribute("projectslist",service.ProjectList(LabCode));		
			return "committee/CommitteeEdit";
		}
		catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeEdit.htm "+UserId,e);
				return "static/Error";
		}		
	}
	
	@RequestMapping(value="CommitteeEditSubmit.htm", method= {RequestMethod.GET,RequestMethod.POST})
	public String CommitteeEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");		
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeEditSubmit.htm "+UserId);		
		try {	
				CommitteeDto committeeDto=new CommitteeDto();
				committeeDto.setCommitteeId(Long.parseLong(req.getParameter("committeeid")));
				committeeDto.setCommitteeName(req.getParameter("committeename"));
				committeeDto.setCommitteeShortName(req.getParameter("committeeshortname"));
				committeeDto.setModifiedBy(UserId);
				committeeDto.setCommitteeType(req.getParameter("committeetype"));
				committeeDto.setProjectApplicable(req.getParameter("projectapplicable"));
				committeeDto.setTechNonTech(req.getParameter("technontech"));
				committeeDto.setPeriodicNon(req.getParameter("periodic"));
				committeeDto.setDescription(req.getParameter("description"));
				committeeDto.setTermsOfReference(req.getParameter("TOR"));
				committeeDto.setIsGlobal(req.getParameter("projectid"));
				committeeDto.setLabCode(LabCode);
				if(req.getParameter("periodic").equalsIgnoreCase("P"))
				{
					committeeDto.setPeriodicDuration(req.getParameter("periodicduration"));
				}
				else
				{
					committeeDto.setPeriodicDuration("0");
				}				
				committeeDto.setGuidelines(req.getParameter("guidelines"));
				
				long count=0;
				count=service.CommitteeEditSubmit(committeeDto);				
				if (count > 0) 
				{
					redir.addAttribute("result", "Committee Updated Successfully");
					redir.addAttribute("projectappliacble",req.getParameter("projectapplicable"));
					redir.addAttribute("projectid", req.getParameter("projectid"));
					return "redirect:/CommitteeList.htm";
				} 
				else if(count==-1)
				{
					redir.addAttribute("resultfail", "Committee Short Name Already Exists ");
				}
				else if(count==-2)
				{
					redir.addAttribute("resultfail", "Committee "+committeeDto.getCommitteeName()+" Already Exists  ");
				}
				else 
				{
					redir.addAttribute("resultfail", "Committee Update Failed ");
				}
				
				redir.addAttribute("committeemainid", req.getParameter("committeeid"));
				redir.addAttribute("committeeid", req.getParameter("committeeid"));
		}
		catch (Exception e) 
		{
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeEditSubmit.htm "+UserId,e);
		}
		return "redirect:/CommitteeEdit.htm";
	}	
	 @RequestMapping(value = "CommitteeNamesCheck.htm", method = RequestMethod.GET)
	  public @ResponseBody String CommitteeNamesCheck(HttpSession ses, HttpServletRequest req) throws Exception 
	  {
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		Object[] DisDesc = null;
		logger.info(new Date() +"Inside CommitteeNamesCheck.htm "+UserId);
		try
		{	  
			String name=req.getParameter("fname");
			String sname=req.getParameter("sname");
			String isglobal=req.getParameter("isglobal");			
			DisDesc =service.CommitteeNamesCheck(name,sname,isglobal,LabCode);
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeNamesCheck.htm "+UserId,e);
		}
		  Gson json = new Gson();
		  return json.toJson(DisDesc); 
		  
	}

	@RequestMapping(value = "CommitteeDetails.htm")
	public String CommitteDetails(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		
		logger.info(new Date() +"Inside CommitteeDetails.htm "+UserId);
		try
		{
			String CommitteeId=req.getParameter("committeeid");
			if(CommitteeId==null)  {
				Map md=model.asMap();
				CommitteeId=(String)md.get("committeeid");
			}
			
			String divisionid=req.getParameter("divisionid");
			if(divisionid==null)  {
				Map md=model.asMap();
				divisionid=(String)md.get("divisionid");
			}
			
			String projectid=req.getParameter("projectid");
			if(projectid==null)  {
				Map md=model.asMap();
				projectid=(String)md.get("projectid");
			}		
			String initiationid=req.getParameter("initiationid");
	
			if(initiationid==null)  {
				Map md=model.asMap();
				initiationid=(String)md.get("initiationid");
				System.out.println(initiationid+"---initiationid1");
			}	
			
			if(projectid==null && divisionid==null && CommitteeId==null )				
			{
				redir.addAttribute("resultfail", "Refresh Not Allowed ! Try again.");
				return "redirect:/MainDashBoard.htm";
			}
			
			List<Object[]> projectdetailslist=service.ProjectList(LabCode);
			if(Long.parseLong(projectid)>0 && (projectdetailslist.size()==0 || projectdetailslist==null) && !projectid.equals("0")) 
			{
				redir.addAttribute("resultfail", "No Project is Assigned To You.");
				return "redirect:/MainDashBoard.htm";
			}
			
			req.setAttribute("committeereplist", service.CommitteeRepList());
			req.setAttribute("committeedata", service.CommitteeName(CommitteeId));
			req.setAttribute("employeelist", service.EmployeeList(LabCode));
			req.setAttribute("projectlist", projectdetailslist);
			req.setAttribute("initiationid", initiationid);
			req.setAttribute("projectid", projectid);
			req.setAttribute("divisionid", divisionid);
			req.setAttribute("divisionslist",service.divisionList());			
			req.setAttribute("initiationdata", service.Initiationdetails(initiationid));
			req.setAttribute("AllLabsList", service.AllLabList());
			
			req.setAttribute("LabCode", LabCode);
			return "committee/CommitteeDetailsAdd";
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside CommitteeDetails.htm "+UserId,e);
			return "static/Error";
		}		
	}
	
	@RequestMapping(value="CommitteeDetailsSubmit.htm",method=RequestMethod.POST)
	public String CommitteeDetailsSubmit(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses )throws Exception
	{
		String Username=(String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabId =(String)ses.getAttribute("labid");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeDetailsSubmit.htm "+Username);
		try
		{
			CommitteeMainDto committeemaindto=new CommitteeMainDto();
			committeemaindto.setCommitteeId(req.getParameter("committeeid"));
			committeemaindto.setValidFrom(req.getParameter("Fromdate"));
			committeemaindto.setChairperson(req.getParameter("chairperson"));		
			committeemaindto.setSecretary(req.getParameter("Secretary"));
			committeemaindto.setProxySecretary(req.getParameter("proxysecretary"));
			committeemaindto.setCreatedBy(Username);
			committeemaindto.setCpLabCode(req.getParameter("CpLabCode"));
			committeemaindto.setDivisionId(req.getParameter("divisionid"));
			committeemaindto.setProjectId(req.getParameter("projectid"));
			committeemaindto.setInitiationId(req.getParameter("initiationid"));
			committeemaindto.setReps(req.getParameterValues("repids"));
			committeemaindto.setCreatedByEmpid(EmpId);	
			committeemaindto.setCreatedByEmpidLabid(LabId);
			committeemaindto.setPreApproved(req.getParameter("preApproved"));
			committeemaindto.setLabCode(LabCode);
			// new line//
			committeemaindto.setMsLabCode(req.getParameter("msLabCode"));
			committeemaindto.setCo_Chairperson(req.getParameter("cochairperson"));
			
			long mainid =service.CommitteeDetailsSubmit(committeemaindto);
			
			if (mainid > 0) {
				redir.addAttribute("result", "Committee Created Successfully");
			} else {
				redir.addAttribute("resultfail", "Committee Create Unsuccessful");
				if(Long.parseLong(req.getParameter("projectid"))>0) {
					return "redirect:/ProjectMaster.htm";
				}else if(Long.parseLong(req.getParameter("divisionid"))>0) {
					return "redirect:/DivisionCommitteeMaster.htm";
				}else if(Long.parseLong(req.getParameter("initiationid"))>0) {
					return "redirect:/InitiationCommitteeMaster.htm";
				}else {
					return "redirect:/CommitteeList.htm";
				}
				
			}
			redir.addFlashAttribute("committeeid",req.getParameter("committeeid"));
			redir.addFlashAttribute("projectid",req.getParameter("projectid"));
			redir.addFlashAttribute("divisionid",req.getParameter("divisionid"));
			redir.addFlashAttribute("initiationid",req.getParameter("initiationid"));
			
			redir.addFlashAttribute("committeemainid",String.valueOf(mainid));
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +"Inside CommitteeDetailsSubmit.htm "+Username,e);
		}
		return"redirect:/CommitteeMainMembers.htm"; 
	}
	
	@RequestMapping(value="CommitteeMainMembers.htm")
	public String CommitteeMainMembers(Model model,HttpServletRequest req,RedirectAttributes redir,HttpSession ses) throws Exception 
	{			
		String Username=(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeMainMembers.htm "+Username);
		try
		{		
			String initiationid=null;
			String CommitteeId=null;
			String projectid=null;
			String divisionid=null;
			String committeemainid=req.getParameter("committeemainid");		
			if(committeemainid==null) {
				Map md=model.asMap();
				committeemainid=(String)md.get("committeemainid");
			}		
			if(committeemainid==null)
			{
					CommitteeId	=req.getParameter("committeeid");		
					if(CommitteeId==null) {
						Map md=model.asMap();
						CommitteeId=(String)md.get("committeeid");
					}			
					
					projectid=req.getParameter("projectid");		
					if(projectid==null) {
						Map md=model.asMap();
						projectid=(String)md.get("projectid");
					}	
					
					divisionid=req.getParameter("divisionid");		
					if(divisionid==null) {
						Map md=model.asMap();
						divisionid=(String)md.get("divisionid");
					}
					
					initiationid=req.getParameter("initiationid");		
					if(initiationid==null) {
						Map md=model.asMap();
						initiationid=(String)md.get("initiationid");
					}					
					committeemainid=String.valueOf(service.LastCommitteeId(CommitteeId, projectid, divisionid,initiationid));
			}
			
			Object[] proposedcommitteeid = service.GetProposedCommitteeMainId(CommitteeId, projectid, divisionid, initiationid);
			
			if(committeemainid==null || committeemainid.equals("0"))
			{
				if(proposedcommitteeid!=null)
				{
					committeemainid=proposedcommitteeid[0].toString();
				}
			}
			Object[] committeedata=service.CommitteMainData(committeemainid);	
			
			if(committeedata==null )
			{		
				redir.addAttribute("resultfail", "No Active Committee Is Present, Constitute New Committee");
				redir.addFlashAttribute("committeeid", CommitteeId);			
				redir.addFlashAttribute("projectid", projectid);	
				redir.addFlashAttribute("divisionid", divisionid);	
				redir.addFlashAttribute("initiationid", initiationid);		
				redir.addAttribute("noactive","true");
				return "redirect:/CommitteeDetails.htm";				
			}
			
			CommitteeId=committeedata[1].toString();
			projectid=committeedata[2].toString();
			divisionid=committeedata[3].toString();
			initiationid=committeedata[4].toString();
			
			committeemainid=committeedata[0].toString();	
			List<Object[]> employeelist=service.EmployeeListWithoutMembers(committeemainid,LabCode);
			List<Object[]> employeelist1=service.EmployeeListNoMembers(LabCode,committeemainid);					
			List<Object[]> ExpertList = service.ExternalMembersNotAddedCommittee(committeemainid); 
			Object[] proposedcommitteemainid =  service.ProposedCommitteeMainId(committeemainid);
			List<Object[]> committeemembersall= service.CommitteeAllMembersList(committeemainid);
			Object[] chairperson =null;
			for(int i=0;i<committeemembersall.size();i++)
			{	
				if(committeemembersall.get(i)[8].toString().equalsIgnoreCase("CC")){
					chairperson=committeemembersall.get(i);
				}
			}
			System.out.println(committeemainid+"committeemainid");
			req.setAttribute("committeemembersall",committeemembersall);
			req.setAttribute("committeerepnotaddedlist", service.CommitteeRepNotAddedList(committeemainid));
			req.setAttribute("committeeMemberreplist", service.CommitteeMemberRepList(committeemainid));
			req.setAttribute("employeelist", employeelist);
			req.setAttribute("employeelist1", employeelist1);	
			req.setAttribute("committeedata", committeedata);			
			req.setAttribute("expertlist", ExpertList);
			req.setAttribute("AllLabList", service.AllLabList());
			req.setAttribute("divisionid", divisionid);
			req.setAttribute("proposedcommitteemainid",proposedcommitteemainid );
			req.setAttribute("committeeapprovaldata",service.CommitteeMainApprovalData(committeemainid));
			req.setAttribute("clusterlist", service.ClusterList());
			
			if( Long.parseLong(projectid)>0) {
				req.setAttribute("projectdata", service.projectdetails(projectid));
			}
			if( Long.parseLong(divisionid)>0) {
				req.setAttribute("divisiondata", service.DivisionData(divisionid) );
			}
			if(Long.parseLong(initiationid)>0) {
				req.setAttribute("initiationdata", service.Initiationdetails(initiationid) );
			}
			
			req.setAttribute("LabCode", LabCode);
			
			return "committee/CommitteeMembers";
		}
		catch (Exception e) {
			e.printStackTrace();			
			logger.error(new Date() +"Inside CommitteeMainMembers.htm "+Username ,e);
			return "static/Error";
		}
	}	
	
	@RequestMapping(value="CommitteeMainMembersSubmit.htm")
	public String CommitteeMainMembersSubmit(Model model,HttpServletRequest req,RedirectAttributes redir,HttpSession ses) throws Exception 
	{		
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeMainMembersSubmit.htm "+Username);
		try
		{	
			CommitteeMembersDto dto=new CommitteeMembersDto();
			dto.setCommitteeMainId(req.getParameter("committeemainid"));
			dto.setInternalMemberIds(req.getParameterValues("InternalMemberIds"));
			dto.setInternalLabCode(req.getParameter("InternalLabCode"));
			dto.setExternalMemberIds(req.getParameterValues("ExternalMemberIds"));
			dto.setExternalLabCode(req.getParameter("Ext_LabCode"));
			dto.setExpertMemberIds(req.getParameterValues("ExpertMemberIds"));
			
			dto.setCreatedBy(Username);
			
			long count=service.CommitteeMembersInsert(dto);
			if (count > 0) {
				redir.addAttribute("result", "Committee Members Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Committee Members Add Unsuccessful");	
			}			
			redir.addFlashAttribute("committeemainid", req.getParameter("committeemainid"));
			return "redirect:/CommitteeMainMembers.htm";
		}
		catch (Exception e) {
			e.printStackTrace();			
			logger.error(new Date() +"Inside CommitteeMainMembersSubmit.htm "+Username ,e);
			return "static/Error";
		}
	}
	
	
	@RequestMapping(value="CommitteeRepMemberAdd.htm",method=RequestMethod.POST)
	public String CommitteeRepMemberAdd(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses )throws Exception
	{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeRepMemberAdd.htm "+Username);
		try
		{
			String committeemainid=req.getParameter("committeemainid");
			String[] repids=req.getParameterValues("repids");
			
			service.CommitteeRepMemberAdd(repids,committeemainid,Username);
			
			redir.addFlashAttribute("committeemainid",committeemainid );
			return"redirect:/CommitteeMainMembers.htm";
		}
		catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeRepMemberAdd.htm "+Username,e);
				return "static/Error";
				
		}
		
	} 
	
	
	@RequestMapping(value="CommitteeMemberDelete.htm",method=RequestMethod.POST)
	public String CommitteeMemberDelete(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses )throws Exception
	{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeMemberDelete.htm "+Username);
		try
		{
			String committeememberid=req.getParameter("committeememberid");
			
			int count=0;
			count=service.CommitteeMemberDelete(committeememberid, Username);
			
			if (count > 0) {
				redir.addAttribute("result", "Committee Member Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Committee Member Delete Unsuccessful");	
			}
			redir.addFlashAttribute("committeemainid",req.getParameter("committeemainid"));	
		}
		catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +"Inside CommitteeMemberDelete.htm "+Username,e);
		}
		return"redirect:/CommitteeMainMembers.htm";
	} 

	@RequestMapping(value="CommitteeMainMembersAddSubmit.htm",method=RequestMethod.POST)
	public String CommitteeMainMembersAddSubmit(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses )throws Exception
	{
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeMainMembersAddSubmit.htm "+UserId);
		try
		{
			String committeemainid=req.getParameter("committeemainid");
			String committeeid=req.getParameter("committeeid");
			
			String[] Member=req.getParameterValues("Member");
			long count=0;
			count=service.CommitteeMainMembersAddSubmit( committeemainid,Member,UserId);
			
			if (count > 0) {
				redir.addAttribute("result", "Committee Members Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Committee Member Adding Failed");	
			}
			
			
			redir.addFlashAttribute("projectid",req.getParameter("projectid"));	
			redir.addFlashAttribute("committeeid",committeeid);
			redir.addFlashAttribute("divisionid","0");
			
		} catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside CommitteeMainMembersAddSubmit.htm "+UserId,e);
		}
		return "redirect:/CommitteeMainMembers.htm";
	}
	
	@RequestMapping(value="MasterScheduleListSelect.htm",method=RequestMethod.GET)
	public String MasterScheduleListSelect(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MasterScheduleListSelect.htm "+UserId);
		try
		{		
			
			List<Object[]> committeeactivelist=service.CommitteeMainList(labcode);
			if(committeeactivelist.size()==0)
			{
				redir.addAttribute("resultfail", "No Committee is Constituted, Constitute a Non-Project Committee ");
				redir.addFlashAttribute("id","N");			 
			}			
			req.setAttribute("CommitteeList", committeeactivelist);
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside MasterScheduleListSelect.htm "+UserId,e);
		}
		return "committee/CommitteeScheduleSelect";
	}
	
	@RequestMapping(value="CommitteeScheduleList.htm")
	public String CommitteeScheduleList(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeScheduleList.htm "+UserId);
		try
		{
			String committeeid=req.getParameter("committeeid");
			if(committeeid!=null)
			{
				req.setAttribute("initiationid","0");
				req.setAttribute("committeeid",committeeid);
				req.setAttribute("committeedetails",service.CommitteeDetails(committeeid));
				req.setAttribute("committeeschedulelist",service.CommitteeScheduleListNonProject(committeeid) );
			}		
			req.setAttribute("CommitteeList", service.CommitteeMainList(labcode));
			return "committee/CommitteeScheduleSelect";
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside CommitteeScheduleList.htm "+UserId,e);
			return "static/Error";
		}		
	}
	
	
	@RequestMapping(value="CommitteeScheduleAddSubmit.htm",method=RequestMethod.POST)
	public String CommitteeScheduleAddSubmit(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeScheduleAddSubmit.htm "+UserId);
		try
		{
			String committeeid=req.getParameter("committeeid");			
			String projectid=req.getParameter("projectid");
			String divisionid=req.getParameter("divisionid");
			String initiationid=req.getParameter("initiationid");
			
			CommitteeScheduleDto committeescheduledto = new CommitteeScheduleDto(); 
			committeescheduledto.setCommitteeId(Long.parseLong(req.getParameter("committeeid")));
			committeescheduledto.setScheduleDate(req.getParameter("startdate"));
			committeescheduledto.setScheduleStartTime(req.getParameter("starttime"));
			committeescheduledto.setCreatedBy(UserId);
			committeescheduledto.setScheduleFlag("MSC");			
			committeescheduledto.setProjectId(projectid);
			committeescheduledto.setDivisionId(divisionid);
			committeescheduledto.setInitiationId(initiationid);
			committeescheduledto.setLabCode(labcode);
			
			if(projectid!=null && Long.parseLong(projectid)>0) 
			{
				Object[] projectdetails=service.projectdetails(projectid);				
				committeescheduledto.setConfidential(projectdetails[10].toString());
			}else {
				committeescheduledto.setConfidential("5");
			}
					
			
			long count=0;
			count=service.CommitteeScheduleAddSubmit(committeescheduledto);
			redir.addAttribute("committeeid",committeeid);
			
			String CommitteeName=req.getParameter("committeename");
			
			if(count>0)
			{
				redir.addAttribute("result", CommitteeName + " Schedule Added Successfully !");
			}
			else 
			{
				redir.addAttribute("resultfail", "Schedule Adding Failed, Try Again");	
			}			
			redir.addFlashAttribute("scheduleid", String.valueOf(count));
			return "redirect:/CommitteeScheduleAgenda.htm";
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside CommitteeScheduleAddSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="ScheduleDefAgendaAdd.htm",method= {RequestMethod.POST})
	public String ScheduleDefAgendaAdd(Model model,HttpServletRequest req,HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ScheduleDefAgendaAdd.htm "+UserId);
		try
		{
			List<String> defagendaid=Arrays.asList(req.getParameterValues("defagendaid"));
			List<String> defagendaid1=Arrays.asList(req.getParameterValues("defagendaid1"));
			String AgendaItem[]=req.getParameterValues("agendaitem");
			String Duration[]=req.getParameterValues("duration");
			String ProjectId[]=req.getParameterValues("projectid");
			String Remarks[]= req.getParameterValues("remarks");
			String presenters[]=req.getParameterValues("presenterid");
			String PresLabCode[]=req.getParameterValues("PresLabCode");
			
			List<CommitteeScheduleAgendaDto> scheduleagendadtos=new ArrayList<CommitteeScheduleAgendaDto>();

			
			for(int i=0;i<defagendaid1.size();i++) 
			{
				if(defagendaid.contains(defagendaid1.get(i))) 
				{
					CommitteeScheduleAgendaDto scheduleagendadto = new CommitteeScheduleAgendaDto();
					scheduleagendadto.setScheduleId(req.getParameter("scheduleid"));
					scheduleagendadto.setScheduleSubId("1");
					scheduleagendadto.setAgendaItem(AgendaItem[i]);
					scheduleagendadto.setPresentorLabCode(PresLabCode[i]);
					scheduleagendadto.setPresenterId(presenters[i]);
					scheduleagendadto.setDuration(Duration[i]);
					scheduleagendadto.setProjectId(ProjectId[i]);
					scheduleagendadto.setRemarks(Remarks[i]);
					scheduleagendadto.setCreatedBy(UserId);
					scheduleagendadto.setIsActive("1");
					scheduleagendadto.setDocLinkIds(req.getParameterValues("attachid_"+defagendaid1.get(i)));
					scheduleagendadtos.add(scheduleagendadto);
				}
			}
			
			long count=service.CommitteeAgendaSubmit(scheduleagendadtos);
			
			if (count > 0) {
				redir.addAttribute("result", "Agendas Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Agendas Add Unsuccessful");
			}
			
			
			redir.addFlashAttribute("scheduleid",req.getParameter("scheduleid"));
			return "redirect:/CommitteeScheduleAgenda.htm";
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside ScheduleDefAgendaAdd.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CommitteeScheduleAgenda.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String CommitteeScheduleAgenda(Model model,HttpServletRequest req,HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =ses.getAttribute("labcode").toString().trim();
		logger.info(new Date() +"Inside CommitteeScheduleAgenda.htm "+UserId);
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
			Object[] scheduledata=service.CommitteeScheduleEditData(CommitteeScheduleId);
			List<Object[]> committeeagendalist = service.AgendaList(CommitteeScheduleId);
			
			String projectid = scheduledata[9].toString();
			req.setAttribute("AllLabList", service.AllLabList());
			req.setAttribute("scheduledata",scheduledata);
			req.setAttribute("projectlist", service.ProjectList(LabCode));
			req.setAttribute("committeeagendalist", committeeagendalist);
			req.setAttribute("labdata", service.LabDetails(scheduledata[24].toString()));			
			req.setAttribute("filesize",file_size);
			req.setAttribute("projectid",projectid);
			req.setAttribute("filerepmasterlistall",service.FileRepMasterListAll(projectid,LabCode));
			req.setAttribute("AgendaDocList",service.AgendaLinkedDocList(CommitteeScheduleId));
			
			req.setAttribute("LabCode",LabCode);
			req.setAttribute("LabEmpList",service.PreseneterForCommitteSchedule(LabCode.trim()));
			Object[] DefaultAgendasCount = service.getDefaultAgendasCount(scheduledata[0].toString(), LabCode);
			if(Integer.parseInt(DefaultAgendasCount[0].toString())>0 && committeeagendalist.size()==0 && req.getParameter("skip")==null)
			{
				List<Object[]> defAgendaList = service.DefaultAgendaList(scheduledata[0].toString(),LabCode);
				req.setAttribute("defAgendaList",defAgendaList);
				
				return "committee/ScheduleDefaultAgendas";
			}
			return "committee/CommitteeScheduleAgenda";
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside CommitteeScheduleAgenda.htm "+UserId,e);
			return "static/Error";
		}
	}
	

@RequestMapping(value = "CommitteeAgendaPresenterList.htm", method = RequestMethod.GET)
	public @ResponseBody String CommitteeAgendaPresenterList(HttpServletRequest req,HttpSession ses) throws Exception 
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside CommitteeAgendaPresenterList.htm"+ UserId);
		
		List<Object[]> EmployeeList = new ArrayList<Object[]>();
		
		try {
			String CsLabCode =req.getParameter("PresLabCode");
			if(CsLabCode.trim().equalsIgnoreCase("@EXP")) 
			{
				EmployeeList = service.ClusterExpertsListForCommitteeSchdule();
			}
			else
			{
				EmployeeList = service.PreseneterForCommitteSchedule(CsLabCode.trim());
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CommitteeAgendaPresenterList.htm "+UserId, e);
		}
		
		Gson json = new Gson();
		return json.toJson(EmployeeList);	
	}
	
	
	
	@RequestMapping(value="AgendaUnlinkDoc.htm",method= RequestMethod.GET)
	public @ResponseBody String AgendaUnlinkDoc(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		int ret=0;
		logger.info(new Date() +"Inside AgendaUnlinkDoc.htm "+UserId);
		try
		{
			CommitteeScheduleAgendaDocs agendadoc = new CommitteeScheduleAgendaDocs();
			agendadoc.setAgendaDocid(Long.parseLong(req.getParameter("AttachDocid")));
			agendadoc.setModifiedBy(UserId);
			ret= service.AgendaUnlinkDoc(agendadoc);
		}catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +"Inside AgendaUnlinkDoc.htm "+UserId,e);
			
		}
		Gson json = new Gson();
		return json.toJson(ret); 
		
	}
	
	
	@RequestMapping(value="CommitteeScheduleView.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String CommitteeScheduleView(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
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
//			String MemberType=null;
//			if(req.getParameter("membertype")!=null) {
//				MemberType=(String)req.getParameter("membertype");
//			}
			String CommitteeScheduleId=null;
			
			if(req.getParameter("scheduleid")!=null) {
				CommitteeScheduleId=(String)req.getParameter("scheduleid");
			}
			else {
				CommitteeScheduleId=(String)md.get("scheduleid");
			}
			System.out.println(CommitteeScheduleId+"-----");
			int committeecons=0;
			Object[] committeescheduleeditdata=service.CommitteeScheduleEditData(CommitteeScheduleId);
			String projectid= committeescheduleeditdata[9].toString();
			String committeeid=committeescheduleeditdata[0].toString();
			String divisionid=committeescheduleeditdata[16].toString();
			String initiationid=committeescheduleeditdata[17].toString();
			Long committeemainid=null;
			if(Long.parseLong(initiationid)>0) {
				 committeemainid=service.LastCommitteeId(committeeid, projectid, divisionid,initiationid);
			}else
			{
				committeemainid=service.LastCommitteeId(committeeid, projectid, divisionid,initiationid);
			}
			
			if(committeemainid==null || committeemainid==0)
			{
				committeecons=0;			
			}
			else
			{
				committeecons=1;				
			}
			if(Integer.parseInt(projectid)>0)
			{
				req.setAttribute("projectdetails", service.projectdetails(projectid));
			}
			if(Integer.parseInt(divisionid)>0)
			{
				req.setAttribute("divisiondetails", service.DivisionData(divisionid));
			}
			if(Integer.parseInt(initiationid)>0)
			{
				req.setAttribute("initiationdetails", service.Initiationdetails(initiationid));
			}
			
			if(Logintype.equalsIgnoreCase("A") || Logintype.equalsIgnoreCase("Z") || Logintype.equalsIgnoreCase("C")|| Logintype.equalsIgnoreCase("I")) 
			{
				if(md.get("otp")!=null) {
					req.setAttribute("otp", md.get("otp"));
				}
			}
			
//			req.setAttribute("membertype", MemberType);
			req.setAttribute("userview",UserView);			
			req.setAttribute("ReturnData", service.AgendaReturnData(CommitteeScheduleId));
			req.setAttribute("committeescheduleeditdata", committeescheduleeditdata);
			req.setAttribute("committeeagendalist", service.AgendaList(CommitteeScheduleId));
			req.setAttribute("committeeinvitedlist", service.CommitteeAtendance(CommitteeScheduleId));	
			req.setAttribute("employeelist", service.EmployeeList(LabCode));
			req.setAttribute("pfmscategorylist", service.PfmsCategoryList());
			req.setAttribute("logintype", Logintype);
			req.setAttribute("committeecons", committeecons); 
			req.setAttribute("AgendaDocList",service.AgendaLinkedDocList(CommitteeScheduleId));
			req.setAttribute("SplCommitteeCodes",SplCommitteeCodes);
			
			int useraccess=service.ScheduleCommitteeEmpCheck
					(new EmpAccessCheckDto(Logintype,CommitteeScheduleId,EmpId,
							committeescheduleeditdata[1], committeecons,
							committeescheduleeditdata[13].toString()));
			req.setAttribute("useraccess", useraccess);
			return "committee/CommitteeScheduleView";
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +"Inside CommitteeScheduleView.htm "+UserId,e);
			return "static/Error";
		}
		
	}
	
	
	@RequestMapping(value="CommitteeAgendaSubmit.htm",method=RequestMethod.POST)
	public String CommitteeAgendaSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception  //,@RequestPart("FileAttach") MultipartFile[] FileAttach
		{ 		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeAgendaSubmit.htm "+UserId);
		try
		{
			String AgendaItem[]=req.getParameterValues("agendaitem");
			String Duration[]=req.getParameterValues("duration");
			String ProjectId[]=req.getParameterValues("projectid");
			String Remarks[]= req.getParameterValues("remarks");
			String presenters[]=req.getParameterValues("presenterid");
			String PresLabCode[]=req.getParameterValues("PresLabCode");
			ArrayList<String[]> docids = new ArrayList<String[]>();
			for(int i=0 ; i<AgendaItem.length ;i++) {
				docids.add( req.getParameterValues("attachid_"+i));
			}
			List<CommitteeScheduleAgendaDto> scheduleagendadtos=new ArrayList<CommitteeScheduleAgendaDto>();
			for(int i=0;i<AgendaItem.length;i++) 
			{
				CommitteeScheduleAgendaDto scheduleagendadto = new CommitteeScheduleAgendaDto();
				scheduleagendadto.setScheduleId(req.getParameter("scheduleid"));
				scheduleagendadto.setScheduleSubId("1");
				scheduleagendadto.setAgendaItem(AgendaItem[i]);
				scheduleagendadto.setPresentorLabCode(PresLabCode[i]);
				scheduleagendadto.setPresenterId(presenters[i]);
				scheduleagendadto.setDuration(Duration[i]);
				scheduleagendadto.setProjectId(ProjectId[i]);
				scheduleagendadto.setRemarks(Remarks[i]);
				scheduleagendadto.setCreatedBy(UserId);
				scheduleagendadto.setIsActive("1");
//				scheduleagendadto.setAgendaAttachment(FileAttach[i].getBytes());
//				scheduleagendadto.setAttachmentName(FileAttach[i].getOriginalFilename());
				scheduleagendadto.setDocLinkIds(docids.get(i));
				scheduleagendadtos.add(scheduleagendadto);
			}
			
			long count=service.CommitteeAgendaSubmit(scheduleagendadtos);
			
			if (count > 0) {
				redir.addAttribute("result", "Agenda Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Agenda Add Unsuccessful");
			}
			redir.addAttribute("scheduleid", req.getParameter("scheduleid"));
		}
		catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeAgendaSubmit.htm "+UserId,e);
		}
		return"redirect:/CommitteeScheduleAgenda.htm";
	}
	
	@RequestMapping(value="CommitteeScheduleAgendaEdit.htm",method=RequestMethod.POST)
	public String CommitteeScheduleAgendaEdit(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses )throws Exception  //,@RequestPart("FileAttach") MultipartFile FileAttach
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeScheduleAgendaEdit.htm "+UserId);
		try
		{
			String agendaitem= req.getParameter("agendaitem");
			String projectid=req.getParameter("projectid");
			String remarks=req.getParameter("remarks");
			String presentorid=req.getParameter("presenterid");
			String duration=req.getParameter("duration");
			String PresLabCode=req.getParameter("PresLabCode");
			
//			String docid=req.getParameter("editattachid");
			CommitteeScheduleAgendaDto scheduleagendadto = new CommitteeScheduleAgendaDto();
			scheduleagendadto.setPresentorLabCode(PresLabCode);
			scheduleagendadto.setScheduleAgendaId(req.getParameter("committeescheduleagendaid"));
			scheduleagendadto.setScheduleId(req.getParameter("scheduleid"));
			scheduleagendadto.setScheduleSubId("1");
			scheduleagendadto.setAgendaItem(agendaitem);
			scheduleagendadto.setPresenterId(presentorid);
			scheduleagendadto.setDuration(duration);
			scheduleagendadto.setProjectId(projectid);
			scheduleagendadto.setRemarks(remarks);
			scheduleagendadto.setModifiedBy(UserId);
			scheduleagendadto.setDocLinkIds( req.getParameterValues("attachid"));
//			scheduleagendadto.setAgendaAttachment(FileAttach.getBytes());
//			scheduleagendadto.setAttachmentName(FileAttach.getOriginalFilename());
//			scheduleagendadto.setDocId(docid);
			String agendaattachmentid=req.getParameter("committeeattachmentid");
			
			
			
			long count = 0;
			count=	service.CommitteeScheduleAgendaEdit(scheduleagendadto,agendaattachmentid);
			
			if (count > 0) {
				redir.addAttribute("result", "Agenda Edited Successfully");
			} else {
				redir.addAttribute("resultfail", "Agenda Edit Unsuccessful");
				
			}
			
			redir.addAttribute("scheduleid", req.getParameter("scheduleid"));
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeScheduleAgendaEdit.htm "+UserId,e);
		}
		return"redirect:/CommitteeScheduleAgenda.htm";
	}
	
	
	@RequestMapping(value="CommitteeAgendaPriorityUpdate.htm",method=RequestMethod.GET)
	public String CommitteeAgendaPriorityUpdate(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeAgendaPriorityUpdate.htm "+UserId);
			try
			{
				String[] priority=req.getParameterValues("priority");
				String[] agendaid=req.getParameterValues("agendaid");
		
				Set<String> s = new HashSet<String>(Arrays.asList(priority));
		
				if (s.size() == priority.length) {
					service.CommitteeAgendaPriorityUpdate(agendaid, priority);
		
					redir.addAttribute("result", "Agenda Priority Updated Successfully");
					redir.addFlashAttribute("scheduleid", req.getParameter("scheduleid"));
					
				} else {
					redir.addAttribute("resultfail", "Agenda Priority Updated UnSuccessfull");
					redir.addAttribute("scheduleid", req.getParameter("scheduleid"));
				}		
				return"redirect:/CommitteeScheduleAgenda.htm";
			}
			catch (Exception e) {
				
			e.printStackTrace();
			logger.error(new Date() +"Inside CommitteeAgendaPriorityUpdate.htm "+UserId,e);
			return "static/Error";
		}	
			
	}
	
	
	@RequestMapping(value = "CommitteeAgendaDelete.htm", method = RequestMethod.POST)
	public String TccAgendaDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeAgendaDelete.htm "+UserId);
		try
		{
			String Committeescheduleagendaid = req.getParameter("committeescheduleagendaid");
			String attachmentid = req.getParameter("committeeattachmentid");
			String scheduleid = req.getParameter("scheduleid");
			String AgendaPriority = req.getParameter("AgendaPriority");
	
			int count = 0;
	
			count = service.CommitteeAgendaDelete(Committeescheduleagendaid, attachmentid, UserId, scheduleid, AgendaPriority);
			if (count > 0) {
				redir.addAttribute("result", " Agenda Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Agenda Delete Unsuccessful");
			}
	
			redir.addAttribute("scheduleid", req.getParameter("scheduleid"));
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeAgendaDelete.htm "+UserId,e);
		}
		return"redirect:/CommitteeScheduleAgenda.htm";
		}
	
	@RequestMapping(value="CommitteeMainEditSubmit.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String CommitteeMainEditSubmit(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses )throws Exception
	{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeMainEditSubmit.htm "+Username);
		try
		{		
			CommitteeMembersEditDto dto=new CommitteeMembersEditDto();
			dto.setChairperson(req.getParameter("chairperson"));
			dto.setSecretary(req.getParameter("Secretary"));
			dto.setProxysecretary(req.getParameter("proxysecretary"));
			dto.setSesLabCode((String) ses.getAttribute("labcode"));
			dto.setCpLabCode(req.getParameter("CpLabCode"));
			dto.setCommitteemainid(req.getParameter("committeemainid"));
			dto.setChairpersonmemid(req.getParameter("cpmemberid"));
			dto.setSecretarymemid(req.getParameter("msmemberid"));
			dto.setProxysecretarymemid(req.getParameter("psmemberid"));			
			dto.setModifiedBy(Username);		
			dto.setCo_chairperson(req.getParameter("co_chairperson"));
			dto.setComemberid(req.getParameter("comemberid"));
			dto.setMsLabCode(req.getParameter("msLabCode"));
			long count =service.CommitteeMainMemberUpdate(dto);		
			
//			CommitteeMainDto committeemaindto=new CommitteeMainDto();
//			committeemaindto.setProxySecretary(req.getParameter("proxysecretary"));
//			committeemaindto.setCommitteeMainId(req.getParameter("committeemainid"));
//			committeemaindto.setChairperson(req.getParameter("chairperson"));
//			committeemaindto.setSecretary(req.getParameter("Secretary"));
//			committeemaindto.setModifiedBy(Username);
//			committeemaindto.setCpLabId(req.getParameter("cplabid"));		
//			
//			long count = service.CommitteeMainEdit(committeemaindto);
//			
			if (count > 0) {
				redir.addAttribute("result", "Committee Edited Successfully");
			} else {
				redir.addAttribute("resultfail", "Committee Edit Unsuccessful");
				
			}
			
			redir.addFlashAttribute("committeemainid",req.getParameter("committeemainid"));
						
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeMainEditSubmit.htm "+Username,e);
		}
		return "redirect:/CommitteeMainMembers.htm";
	}

	@RequestMapping(value="CommitteeScheduleUpdate.htm",method=RequestMethod.POST)
	public String CommitteeScheduleUpdate(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception{
		
		String UserId=(String)ses.getAttribute("Username");
		
		logger.info(new Date() +"Inside CommitteeScheduleUpdate.htm "+UserId);
		try
		{		
			CommitteeScheduleDto committeescheduledto=new CommitteeScheduleDto(); 
			committeescheduledto.setScheduleDate(req.getParameter("committeedate"));
			committeescheduledto.setScheduleStartTime(req.getParameter("committeetime"));
			committeescheduledto.setScheduleId(Long.parseLong(req.getParameter("scheduleid")));
			committeescheduledto.setCreatedBy(UserId);
			
			long count = service.CommitteeScheduleUpdate(committeescheduledto);
			
			if (count > 0) {
				redir.addAttribute("result", "Committee Schedule Edited Successfully");
			} else {
				redir.addAttribute("resultfail", "Committee Schedule Edit Unsuccessful");
			}
	
			redir.addFlashAttribute("scheduleid",req.getParameter("scheduleid"));
		}
		catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeScheduleUpdate.htm "+    UserId,e);
		}
		
		return "redirect:/CommitteeScheduleView.htm";
	}
	

	@RequestMapping(value="CommitteeVenueUpdate.htm")
	public String CommitteeVenueUpdate(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception{
		
		String UserId=(String)ses.getAttribute("Username");		
		logger.info(new Date() +"Inside CommitteeVenueUpdate.htm "+UserId);
		try
		{
			CommitteeScheduleDto committeescheduledto=new CommitteeScheduleDto(); 
			committeescheduledto.setScheduleId(Long.parseLong(req.getParameter("scheduleid")));
			committeescheduledto.setMeetingVenue(req.getParameter("venue"));
			committeescheduledto.setConfidential(req.getParameter("isconfidential"));
			committeescheduledto.setReferrence(req.getParameter("reference"));
			committeescheduledto.setPMRCDecisions(req.getParameter("decisions"));		
			int count=0;
			count = service.UpdateMeetingVenue(committeescheduledto);
			
			if (count > 0) {
				redir.addAttribute("result", "Committee Schedule Edited Successfully");
			} else {
				redir.addAttribute("resultfail", "Committee Schedule Edit Unsuccessful");				
			}			
			redir.addFlashAttribute("scheduleid",req.getParameter("scheduleid"));		
		}
		catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeVenueUpdate.htm "+   UserId,e);
		} 
		return "redirect:/CommitteeScheduleView.htm";
	}
	
	@RequestMapping(value="CommitteeScheduleMinutes.htm",method= {RequestMethod.GET,RequestMethod.POST})
	public String CommitteeScheduleMinutes(Model model,HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeScheduleMinutes.htm "+UserId);
		try
		{
			String CommitteeScheduleId=null;
			String specname=null;
			String MemberType=null;
			String formname=null;
			String unit1=null;
			
			Map md = model.asMap();
			specname = (String) md.get("specname");
			formname=(String)md.get("formname");
			unit1=(String)md.get("unit1");
			
			
			if(req.getParameter("committeescheduleid")!=null) {
				CommitteeScheduleId=req.getParameter("committeescheduleid");
			}
			else {
				CommitteeScheduleId=(String)md.get("committeescheduleid");
			}
			if(CommitteeScheduleId==null) {
				return "redirect:/CommitteeScheduleMinutes.htm";
			}
			
			if(req.getParameter("membertype")!=null) {
				MemberType=req.getParameter("membertype");
			}
			else {
				MemberType=(String)md.get("membertype");
			}
			
			
			req.setAttribute("SplCommitteeCodes", SplCommitteeCodes);
			req.setAttribute("unit1", unit1);
			req.setAttribute("formname", formname);
			req.setAttribute("membertype",MemberType);
			req.setAttribute("specname", specname);
			req.setAttribute("committscheduleid", CommitteeScheduleId);
			req.setAttribute("committeescheduleeditdata", service.CommitteeScheduleEditData(CommitteeScheduleId));
			req.setAttribute("minutesspeclist", service.CommitteeMinutesSpecList(CommitteeScheduleId));
			req.setAttribute("committeeagendalist", service.AgendaList(CommitteeScheduleId));
			req.setAttribute("minutesoutcomelist", service.MinutesOutcomeList());
			req.setAttribute("minutesattachmentlist",service.MinutesAttachmentList(CommitteeScheduleId));
			req.setAttribute("committeescheduledata",service.CommitteeActionList(CommitteeScheduleId));
			req.setAttribute("filesize",file_size);
			
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeScheduleMinutes.htm "+
		UserId,e);
		}		
		return "committee/CommitteeScheduleMinutes";
	}
	
	@RequestMapping(value="CommitteeMinutesSubmit.htm", method=RequestMethod.POST)
	public String CommitteeMinutesSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		
		String UserId=(String)ses.getAttribute("Username");

		
		logger.info(new Date() +"Inside CommitteeMinutesSubmit.htm "+UserId);
		try
		{
		
			CommitteeMinutesDetailsDto committeeminutesdetailsdto = new CommitteeMinutesDetailsDto();
			committeeminutesdetailsdto.setScheduleId(req.getParameter("scheduleid"));
			committeeminutesdetailsdto.setScheduleSubId(req.getParameter("schedulesubid"));
			committeeminutesdetailsdto.setMinutesId(req.getParameter("minutesid"));
			committeeminutesdetailsdto.setMinutesSubId(req.getParameter("scheduleagendaid"));
			committeeminutesdetailsdto.setMinutesSubOfSubId(req.getParameter("agendasubid"));
			committeeminutesdetailsdto.setMinutesUnitId(req.getParameter("minutesunitid"));
			committeeminutesdetailsdto.setStatusFlag(req.getParameter("statusflag"));
			committeeminutesdetailsdto.setDetails(req.getParameter("NoteText"));
			committeeminutesdetailsdto.setIDARCK(req.getParameter("darc"));
			committeeminutesdetailsdto.setCreatedBy(UserId);
			committeeminutesdetailsdto.setRemarks(req.getParameter("remarks"));
			committeeminutesdetailsdto.setAgendaSubHead(req.getParameter("OutComeAirHead"));
			
			long count = service.CommitteeMinutesInsert(committeeminutesdetailsdto);
	
			String SpecName = req.getParameter("specname");
			String CommitteeName= req.getParameter("committeename");
			
			
			if (count > 0) {
				redir.addAttribute("result", CommitteeName + " Schedule Minutes (" + SpecName + ") Added Successfully");
				redir.addAttribute("unit1",req.getParameter("unit1"));
				redir.addAttribute("unit1",req.getParameter("unit2"));
				

				
			} else {
				redir.addAttribute("resultfail", " Schedule Minutes Add Unsuccessful");
			}
			
			redir.addFlashAttribute("committeescheduleid", req.getParameter("scheduleid"));
			redir.addFlashAttribute("specname", req.getParameter("specname"));
			redir.addFlashAttribute("membertype",req.getParameter("membertype"));
			redir.addFlashAttribute("formname", req.getParameter("formname"));
			redir.addFlashAttribute("unit1",req.getParameter("unit1"));

		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeMinutesSubmit.htm "+ 
		UserId,e);
		}
		
		return "redirect:/CommitteeScheduleMinutes.htm";
	}
	
	
	  @RequestMapping(value = "CommitteeMinutesSpecAdd.htm", method = RequestMethod.GET)
	  public @ResponseBody String CommitteeMinutesSpecAdd(HttpSession ses, HttpServletRequest req) throws Exception 
	  {
		String UserId=(String)ses.getAttribute("Username");
		Object[] DisDesc = null;
		logger.info(new Date() +"Inside CommitteeMinutesSpecAdd.htm "+UserId);
		try
		{
		  CommitteeMinutesDetailsDto minutesdetailsdto = new CommitteeMinutesDetailsDto();
		  
		  minutesdetailsdto.setMinutesId(req.getParameter("minutesid"));
		  minutesdetailsdto.setMinutesSubId(req.getParameter("agendasubid"));
		  minutesdetailsdto.setMinutesSubOfSubId(req.getParameter("scheduleagendaid"));
		  
		  
		  DisDesc = service.CommitteeMinutesSpecDesc(minutesdetailsdto);
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside CommitteeMinutesSpecAdd.htm "+UserId,e);
		}
		  Gson json = new Gson();
		  return json.toJson(DisDesc); 
		}
		  
		@RequestMapping(value = "CommitteeMinutesSpecEdit.htm", method = RequestMethod.GET)
		public @ResponseBody String CommitteeMinutesSpecEdit(HttpSession ses, HttpServletRequest req) throws Exception 
		{
			Object[] DisDesc = null;
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside CommitteeMinutesSpecEdit.htm "+UserId);
			try
			{
				String Username = (String) ses.getAttribute("Username");
				CommitteeMinutesDetailsDto committeeminutesdetailsdto = new CommitteeMinutesDetailsDto();
				committeeminutesdetailsdto.setScheduleMinutesId(req.getParameter("scheduleminutesid"));
				DisDesc = service.CommitteeMinutesSpecEdit(committeeminutesdetailsdto);
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +"Inside CommitteeMinutesSpecEdit.htm "+UserId,e);
			}
			Gson json = new Gson();
			return json.toJson(DisDesc);
		}
	  
	  @RequestMapping(value="CommitteeMinutesEditSubmit.htm", method=RequestMethod.POST)
	  public String CommitteeMinutesEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	  {
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside CommitteeMinutesEditSubmit.htm "+UserId);
			try
			{
				
				CommitteeMinutesDetailsDto committeeminutesdetailsdto = new CommitteeMinutesDetailsDto();
				committeeminutesdetailsdto.setScheduleId(req.getParameter("scheduleidedit"));
				committeeminutesdetailsdto.setScheduleSubId(req.getParameter("schedulesubid"));
				committeeminutesdetailsdto.setMinutesId(req.getParameter("minutesidedits"));
				committeeminutesdetailsdto.setDetails(req.getParameter("NoteText"));
				committeeminutesdetailsdto.setIDARCK(req.getParameter("darc"));
				committeeminutesdetailsdto.setModifiedBy(UserId);
				committeeminutesdetailsdto.setScheduleMinutesId(req.getParameter("schedulminutesid"));
				committeeminutesdetailsdto.setRemarks(req.getParameter("remarks"));
				
	
				long count = service.CommitteeMinutesUpdate(committeeminutesdetailsdto);
				
				String SpecName = req.getParameter("specname");
				String CommitteeName= req.getParameter("committeename");
	
				if (count > 0) {
					redir.addAttribute("result", CommitteeName + " Schedule Minutes (" + SpecName + ") Added Successfully");
					redir.addAttribute("membertype",req.getParameter("membertype"));
				} else {
					redir.addAttribute("resultfail", " Schedule Minutes Update Unsuccessful");
				}
				
				redir.addFlashAttribute("committeescheduleid", req.getParameter("scheduleid"));
				redir.addFlashAttribute("specname", req.getParameter("specname"));
				redir.addFlashAttribute("formname", req.getParameter("formname"));
				redir.addFlashAttribute("unit1",req.getParameter("unit1"));
				redir.addFlashAttribute("unit2",req.getParameter("unit2"));
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +"Inside CommitteeMinutesEditSubmit.htm "+UserId,e);
			}
			
			return "redirect:/CommitteeScheduleMinutes.htm";
		}
	  
	  @RequestMapping(value="CommitteeMinutesDeleteSubmit.htm", method=RequestMethod.POST)
	  public String CommitteeMinutesDeleteSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
			
			
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside CommitteeMinutesDeleteSubmit.htm "+UserId);
			try
			{
				
				CommitteeMinutesDetailsDto committeeminutesdetailsdto = new CommitteeMinutesDetailsDto();
				committeeminutesdetailsdto.setScheduleId(req.getParameter("scheduleidedit"));
				committeeminutesdetailsdto.setScheduleSubId(req.getParameter("schedulesubid"));
				committeeminutesdetailsdto.setMinutesId(req.getParameter("minutesidedits"));
				committeeminutesdetailsdto.setDetails(req.getParameter("NoteText"));
				committeeminutesdetailsdto.setIDARCK(req.getParameter("darc"));
				committeeminutesdetailsdto.setModifiedBy(UserId);
				committeeminutesdetailsdto.setScheduleMinutesId(req.getParameter("schedulminutesid"));
				committeeminutesdetailsdto.setRemarks(req.getParameter("remarks"));
				
				long count = service.CommitteeMinutesDelete(req.getParameter("schedulminutesid"));
				
				String SpecName = req.getParameter("specname");
				String CommitteeName= req.getParameter("committeename");
	
				if (count > 0) {
					redir.addAttribute("result", CommitteeName + " Schedule Minutes (" + SpecName + ") Deleted Successfully");
					redir.addAttribute("membertype",req.getParameter("membertype"));
					
				} else {
					redir.addAttribute("resultfail", " Schedule Minutes Delete Unsuccessful");
				}
				
				redir.addFlashAttribute("committeescheduleid", req.getParameter("scheduleid"));
				
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +"Inside CommitteeMinutesDeleteSubmit.htm "+UserId,e);
			}
			
			return "redirect:/CommitteeScheduleMinutes.htm";
		}
	  
	  
	  
	  @RequestMapping(value = "CommitteeSubScheduleSubmit.htm", method = RequestMethod.POST)
		public String CommitteeSubScheduleSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside CommitteeSubScheduleSubmit.htm "+UserId);
			try
			{
			
				String scheduleid=req.getParameter("scheduleid");
						
				CommitteeSubScheduleDto committeesubscheduledto= new CommitteeSubScheduleDto();
				committeesubscheduledto.setScheduleId(scheduleid);
				committeesubscheduledto.setScheduleDate(req.getParameter("subscheduledate"));
				committeesubscheduledto.setScheduleStartTime(req.getParameter("starttime"));
				committeesubscheduledto.setCreatedBy(UserId);
				long count=0;
				count=service.CommitteeSubScheduleSubmit(committeesubscheduledto);
				
				if (count > 0) {
					redir.addAttribute("result", " SubSchedule  Added Successfully");
				} else {
					redir.addAttribute("resultfail", "SubSchedule Adding Unsuccessful");
				}
	
				redir.addAttribute("scheduleid",scheduleid );
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +"Inside CommitteeSubScheduleSubmit.htm "+UserId,e);
			}
			
			return "redirect:/CommitteeSubSchedule.htm";
		}
		
		
	@RequestMapping(value = "CommitteeSubSchedule.htm", method = RequestMethod.POST)
		public String CommitteeSubSchedule(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside CommitteeSubSchedule.htm "+UserId);
			try
			{
				req.setAttribute("scheduleid",req.getParameter("scheduleid") );
				
				req.setAttribute("subschedulelist", service.CommitteeSubScheduleList(req.getParameter("scheduleid")));
			}
			catch (Exception e) {
					e.printStackTrace(); logger.error(new Date() +"Inside CommitteeSubSchedule.htm "+UserId,e);
			}
			
				return "committee/CommitteeSubSchedule";
		}
		
	@RequestMapping(value="CommitteeInvitations.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public String CommitteeInvitations(Model model, HttpServletRequest req, HttpServletResponse res, RedirectAttributes redir,HttpSession ses) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeInvitations.htm "+UserId);
		try
		{
			String committeescheduleid=req.getParameter("committeescheduleid");						
			if (committeescheduleid == null) 
			{
				Map md = model.asMap();
				committeescheduleid = (String) md.get("committeescheduleid");
			}
			
			Object[] committeescheduledata =service.CommitteeScheduleData(committeescheduleid );
			
			String committeeid=committeescheduledata[7].toString();
			String projectid=committeescheduledata[11].toString();
			String divisionid=committeescheduledata[13].toString();
			String initiationid=committeescheduledata[14].toString();
			
			List<Object[]> committeeinvitedlist = service.CommitteeAtendance(committeescheduleid);
						
			if(committeeinvitedlist.size()==0) 
			{	
				String committeemainid="0";
				if(Long.parseLong(initiationid)>0) {
					committeemainid=String.valueOf(service.LastCommitteeId(committeeid, projectid, divisionid,initiationid));
				}else {
					committeemainid=String.valueOf(service.LastCommitteeId(committeeid, projectid, divisionid,"0"));
				}
				
				
				req.setAttribute("committeemainid",committeemainid);
				req.setAttribute("committeeallmemberlist",service.CommitteeAllMembersList(committeemainid) );
				req.setAttribute("committeescheduleid", committeescheduleid);
				req.setAttribute("committeescheduledata",committeescheduledata );				
				req.setAttribute("agendalist",service.AgendaList(committeescheduleid) );
				req.setAttribute("labid", service.LabDetails(committeescheduledata[15].toString())[13].toString());
				return "committee/CommitteeInvitation";
			}
			else
			{
				List<Object[]> EmployeeList = service.EmployeeListNoInvitedMembers(committeescheduleid,LabCode);
				List<Object[]> ExpertList = service.ExternalMembersNotInvited(committeescheduleid);
	
				req.setAttribute("committeereplist", service.CommitteeMemberRepList(committeescheduledata[1].toString()));
				req.setAttribute("committeeinvitedlist", committeeinvitedlist);
				req.setAttribute("EmployeeList", EmployeeList);
				req.setAttribute("ExpertList", ExpertList);
				req.setAttribute("committeescheduleid", committeescheduleid);
				req.setAttribute("committeescheduledata",committeescheduledata );
				req.setAttribute("agendalist",service.AgendaList(committeescheduleid) );
				req.setAttribute("clusterlablist", service.AllLabList());
				req.setAttribute("labid", service.LabDetails(committeescheduledata[15].toString())[13].toString());
				return "committee/ViewCommitteeInvitation";
			}
			
			
		}
		catch (Exception e) 
		{			
				e.printStackTrace();
				logger.error(new Date() +"Inside CommitteeInvitations.htm "+UserId,e);
				return "static/Error";
		}
		
	}
	
	
	@RequestMapping(value = "CommitteeInvitationCreate.htm", method = RequestMethod.POST)
	public String CommitteeInvitationCreate(HttpServletRequest req, HttpServletResponse res, RedirectAttributes redir,
			HttpSession ses) throws Exception {
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeInvitationCreate.htm "+UserId);
		try
		{
			String committeescheduleid = req.getParameter("committeescheduleid");
			String Committeeidmainid = req.getParameter("Committeeidmainid");
			String reptype=req.getParameter("rep");
			ArrayList<String> emplist = new ArrayList<String>();
			ArrayList<String> labCodelist = new ArrayList<String>();
			if(req.getParameter("chairperson") != null ) 
			{
				String empids[] =req.getParameterValues("empid");
				String Labcode[] =req.getParameterValues("Labcode");
				emplist = new ArrayList<String>(Arrays.asList(empids));
				labCodelist = new ArrayList<String>(Arrays.asList(Labcode));		
				service.UpdateComitteeMainid(Committeeidmainid, committeescheduleid);
			}
			else 
			{
				
				if(req.getParameterValues("internalmember")!=null && req.getParameterValues("internalmember").length!=0) {
					String members[] =req.getParameterValues("internalmember");
					String labcode =req.getParameter("internallabcode");
					emplist.addAll(Arrays.asList(members));
					System.out.println("emplist"+emplist);
					
					for(String member : members )
					{
						labCodelist.add(labcode);
					}
				}
				
				if(req.getParameterValues("externalmember")!=null && req.getParameterValues("externalmember").length!=0) {
					String members[] =req.getParameterValues("externalmember");
					String labid =req.getParameter("externallabid");
					emplist.addAll(Arrays.asList(members));
					for(String member : members )
					{
						labCodelist.add(labid);
					}
				}
				if(req.getParameterValues("expertmember")!=null && req.getParameterValues("expertmember").length!=0) {
					String members[] =req.getParameterValues("expertmember");
					String labid =req.getParameter("expertlabid");
					emplist.addAll(Arrays.asList(members));
					for(String member : members )
					{
						labCodelist.add(labid);
					}
				}
			}
			CommitteeInvitationDto committeeinvitationdto = new CommitteeInvitationDto();

			committeeinvitationdto.setCommitteeScheduleId(committeescheduleid);
			committeeinvitationdto.setCreatedBy(UserId);
			committeeinvitationdto.setEmpIdList(emplist);
			committeeinvitationdto.setLabCodeList(labCodelist);
			committeeinvitationdto.setReptype(reptype);
			
		
			long count =  service.CommitteeInvitationCreate(committeeinvitationdto);
			
			if (count > 0) {				
				redir.addAttribute("result", " Member(s) Invited Successfully");
			} else {
				redir.addAttribute("resultfail", " Member(s) Invite Unsuccessful");
			}
	
			redir.addAttribute("committeescheduleid", committeescheduleid);
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeInvitationCreate.htm "+UserId,e);
		}

		return "redirect:/CommitteeInvitations.htm";
	}
		
	@RequestMapping(value="CommitteeMinutesViewAll.htm", method = {RequestMethod.POST,RequestMethod.GET})
		public String CommitteeMinutesViewAll(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId=(String)ses.getAttribute("Username");
			String LabCode =(String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside CommitteeMinutesViewAll.htm "+UserId);
			try
			{		
				String committeescheduleid = req.getParameter("committeescheduleid");			
				Object[] scheduleeditdata=service.CommitteeScheduleEditData(committeescheduleid);
				String projectid= scheduleeditdata[9].toString();
				if(projectid!=null && Integer.parseInt(projectid)>0)
					
				{
					req.setAttribute("projectdetails", service.projectdetails(projectid));
				}
				String divisionid= scheduleeditdata[16].toString();
				if(divisionid!=null && Integer.parseInt(divisionid)>0)
				{
					req.setAttribute("divisiondetails", service.DivisionData(divisionid));
				}
				String initiationid= scheduleeditdata[17].toString();
				if(initiationid!=null && Integer.parseInt(initiationid)>0)
				{
					req.setAttribute("initiationdetails", service.Initiationdetails(initiationid));
				}
				List<Object[]> actionlist= service.MinutesViewAllActionList(committeescheduleid);
				HashMap< String, ArrayList<Object[]>> actionsdata=new LinkedHashMap<String, ArrayList<Object[]>>();
				
				for(Object obj[] : actionlist) {
						
						ArrayList<Object[]> values=new ArrayList<Object[]>(); 
						for(Object obj1[] : actionlist ) {
							if(obj1[0].equals(obj[0])) {
								values.add(obj1);
							}
						}
						if(!actionsdata.containsKey(obj[0].toString())) {
							actionsdata.put(obj[0].toString(), values);
						}
				} 
					
				req.setAttribute("committeeminutesspeclist",service.CommitteeScheduleMinutes(committeescheduleid) );
				req.setAttribute("committeescheduleeditdata", scheduleeditdata);
				req.setAttribute("CommitteeAgendaList", service.AgendaList(committeescheduleid));
				req.setAttribute("committeeminutes",service.CommitteeMinutesSpecdetails());
				req.setAttribute("committeeminutessub",service.CommitteeMinutesSub());
				req.setAttribute("committeeinvitedlist", service.CommitteeAtendance(committeescheduleid));			
				req.setAttribute("actionlist",actionsdata);
				req.setAttribute("labdetails", service.LabDetails(scheduleeditdata[24].toString()));
				req.setAttribute("isprint", "N");	    
				req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(scheduleeditdata[24].toString()));
				req.setAttribute("meetingcount",service.MeetingNo(scheduleeditdata));
				req.setAttribute("labInfo", service.LabDetailes(LabCode));
			}
			catch (Exception e) 
			{
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeMinutesViewAll.htm "+UserId,e);
			}				
			return "committee/CommitteeMinutesViewAll";
		}
	
	@RequestMapping(value="MeetingAgendaApproval.htm", method=RequestMethod.POST)
	public String MeetingAgendaApproval(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MeetingAgendaApproval.htm "+UserId);
		String Option = req.getParameter("sub");
		try
		{		
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();			
			String CommitteeScheduleId=req.getParameter("committeescheduleid");			
			int count = service.MeetingAgendaApproval(CommitteeScheduleId, UserId, EmpId,Option);	
			if (count > 0) {
				redir.addAttribute("result", "Meeting Agenda Forwarded Successfully");
			} else {
				redir.addAttribute("resultfail", "Meeting Agenda Forward Unsuccessful");
			}
			
			redir.addAttribute("scheduleid", CommitteeScheduleId);
			return "redirect:/CommitteeScheduleView.htm";
		}
		catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside MeetingAgendaApproval.htm "+UserId,e);
				return "static/Error";
		}		
	}
	
	@RequestMapping(value = "MeetingApprovalAgenda.htm")
	public String MeetingApprovalAgenda(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)	throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside MeetingApprovalAgenda.htm "+UserId);
		try
		{
		
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	
			req.setAttribute("MeetingApprovalAgList", service.MeetingApprovalAgendaList(EmpId));
			req.setAttribute("MeetingApprovalMinutes", service.MeetingApprovalMinutesList(EmpId));

		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside MeetingApprovalAgenda.htm "+UserId,e);
		}

		return "committee/ComMeetingApprovalAgList";
	}
	
	@RequestMapping(value = "MeetingApprovalAgendaDetails.htm", method = RequestMethod.POST)
	public String MeetingApprovalAgendaDetails(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)	throws Exception {
		
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MeetingApprovalAgendaDetails.htm "+UserId);
		try
		{		
			String ScheduleId=req.getParameter("scheduleid");
			Object[] ScheduletData =service.CommitteeScheduleEditData(ScheduleId);
			
			req.setAttribute("empscheduledata", service.EmpScheduleData(EmpId, ScheduleId));			
			req.setAttribute("committeename", req.getParameter("committeename"));			
			req.setAttribute("agendalist",  service.AgendaList(ScheduleId));			
			req.setAttribute("scheduledata",ScheduletData);			
			req.setAttribute("committeedata", service.CommitteeMainList(labcode) );			
			req.setAttribute("invitedlist",service.CommitteeAtendance(ScheduleId));
			req.setAttribute("AgendaDocList",service.AgendaLinkedDocList(ScheduleId));
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside MeetingApprovalAgendaDetails.htm "+UserId,e);
		}

		return "committee/ComMeetingApprovalAgDetails";
	}
	
	@RequestMapping(value="MeetingAgendaApprovalSubmit.htm", method=RequestMethod.POST)
	public String MeetingAgendaApprovalSubmit(HttpServletRequest req,RedirectAttributes redir, HttpSession ses) throws Exception{
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside MeetingAgendaApprovalSubmit.htm "+UserId);
		try
		{
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			
			String ScheduleId=req.getParameter("scheduleid");
			String Option=req.getParameter("sub");
			String Remarks=req.getParameter("Remark");
			
			
	
			if(Option.equalsIgnoreCase("back")) {
				
				return "redirect:/MeetingApprovalAgenda.htm";
			}
			else {
	
			int count = service.MeetingAgendaApprovalSubmit(ScheduleId, Remarks, UserId, EmpId,Option);
	
			if (count > 0) {
				
				if(Option.equalsIgnoreCase("approve")) {
					
					redir.addAttribute("result", "Meeting Approved Successfully");
				}
				
				if(Option.equalsIgnoreCase("return")) {
					
					redir.addAttribute("result", "Meeting Returned Successfully");
				}
		
			} 
			
			else {
				
				redir.addAttribute("resultfail", "Meeting Forward Unsuccessful");
			}
	
			}
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside MeetingAgendaApprovalSubmit.htm "+UserId,e);
		}

		return "redirect:/MeetingApprovalAgenda.htm";
	}
	
	
	
	
	@RequestMapping(value = "CommitteeInvitationDelete.htm", method = RequestMethod.POST)
	public String CommitteeInvitationDelete(HttpServletRequest req, HttpServletResponse res, RedirectAttributes redir,
			HttpSession ses) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeInvitationDelete.htm "+UserId);
		try
		{
			
					
			String committeeinvitationid = req.getParameter("committeeinvitationid");
			String committeescheduleid = req.getParameter("committeescheduleid");
			
			long count = 0;
			count = service.CommitteeInvitationDelete(committeeinvitationid);
	
			if (count > 0) {
				redir.addAttribute("result", "Member Removed Successfully");
			} else {
				redir.addAttribute("resultfail", "Member Removal Unsuccessful");
			}
	
			redir.addAttribute("committeescheduleid", committeescheduleid);
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeInvitationDelete.htm "+UserId,e);
		}
		return "redirect:/CommitteeInvitations.htm";
	}
	
	@RequestMapping(value = "CommitteeAttendance.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public String CommitteeAttendance(Model model, HttpServletResponse res, HttpServletRequest req, HttpSession ses,
			RedirectAttributes redir) throws Exception 
	{
		String LabCode =(String) ses.getAttribute("labcode");
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeAttendance.htm "+UserId);
		try
		{
			String committeescheduleid = null;
	
			if (req.getParameter("committeescheduleid") != null) {
				committeescheduleid = (String) req.getParameter("committeescheduleid");
			} else {
				Map md = model.asMap();
				committeescheduleid = (String) md.get("committeescheduleid");
			}
			
			Object[] committeescheduledata =service.CommitteeScheduleData(committeescheduleid);
					
			List<Object[]> committeeinvitedlist = service.CommitteeAtendance(committeescheduleid);
			List<Object[]> EmployeeList = service.EmployeeListNoInvitedMembers(committeescheduleid,LabCode);
			List<Object[]> ExpertList = service.ExternalMembersNotInvited(committeescheduleid);
			
			req.setAttribute("committeereplist", service.CommitteeMemberRepList(committeescheduledata[1].toString()));
			req.setAttribute("EmployeeList", EmployeeList);
			req.setAttribute("ExpertList", ExpertList);
			req.setAttribute("committeeinvitedlist", committeeinvitedlist);
			req.setAttribute("committeescheduleid", committeescheduleid);
			req.setAttribute("committeescheduledata",committeescheduledata );
			req.setAttribute("LabCode", LabCode);
			req.setAttribute("clusterlablist", service.AllLabList());
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeAttendance.htm "+UserId,e);
		}		
		return "committee/CommitteeAttendance";
	}
	
	@RequestMapping(value = "CommitteeAttendanceSubmit.htm", method = RequestMethod.POST)
	public String CommitteeAttendanceSubmit(HttpServletRequest req, HttpServletResponse res, RedirectAttributes redir,
			HttpSession ses) throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeAttendanceSubmit.htm "+UserId);
		try
		{
			String committeescheduleid = req.getParameter("committeescheduleid");
			String Committeeidmainid = req.getParameter("Committeeidmainid");
			
			String InternalMember[] = req.getParameterValues("internalmember");
			String ExternalMember[] = req.getParameterValues("externalmember");
			
			String LabId[] =req.getParameterValues("LabId");
			String LabId1[] =req.getParameterValues("LabId1");
			String InternalLabId[] =req.getParameterValues("InternalLabId");
			String ExternalMemberLab[] =req.getParameterValues("ExternalMemberLab");
			String reptype=req.getParameter("rep");
			
			
			if (InternalMember != null) {
				Set<String> s1 = new HashSet<String>(Arrays.asList(InternalMember));
				if (s1.size() < InternalMember.length) {
	
					redir.addAttribute("resultfail","Cannot Invite Same Members Multiple times, Check Internal Members Selection");
					redir.addAttribute("committeescheduleid", committeescheduleid);
					return "redirect:/CommitteeInvitations.htm";
				}
			}
	
			if (ExternalMember != null) {
				Set<String> s2 = new HashSet<String>(Arrays.asList(ExternalMember));
				if (s2.size() < ExternalMember.length) {
	
					redir.addAttribute("resultfail",
							"Cannot Invite Same Members Multiple times, Check External Members Selection");
					redir.addAttribute("committeescheduleid", committeescheduleid);
					return "redirect:/CommitteeInvitations.htm";
				}
			}
	
			ArrayList<String> emplist = new ArrayList<String>();
			ArrayList<String> lablist = new ArrayList<String>();
	
			if (req.getParameter("chairperson") != null) 
			{	
				
				String Member[] = req.getParameterValues("member");				
				String externalmemberlab[]=req.getParameterValues("externalmemberlab");
				String expertmember[]=req.getParameterValues("expertmember");
				
				String internallabid1[] =req.getParameterValues("internallabid");
				String expertlabid[]=req.getParameterValues("expertlabid");
				String externallabid[] =req.getParameterValues("externallabid");
				
				emplist.add(req.getParameter("chairperson")+",CC");	
				
				emplist.add(req.getParameter("secretary")+",CS");
				
				if(Long.parseLong(req.getParameter("proxysecretary"))>0)
				{// proxy secretary
					emplist.add(req.getParameter("proxysecretary")+",PS");
				}
				if(Member!=null && Member.length>0) 
				{
					emplist.addAll(Arrays.asList(Member));
				}				
				lablist.addAll(Arrays.asList(internallabid1));
				
				if(externalmemberlab!=null && externalmemberlab.length>0)
				{
					emplist.addAll(Arrays.asList(externalmemberlab));
					lablist.addAll(Arrays.asList(externallabid));
				}
				
				if(expertmember!=null && expertmember.length>0)
				{
					emplist.addAll(Arrays.asList(expertmember));
					lablist.addAll(Arrays.asList(expertlabid));
				}			
			}else {
				
				
				
				if (InternalMember != null) {
					
					for(int i=0;i<InternalMember.length;i++) {
						lablist.addAll(Arrays.asList(InternalLabId));
					}
					
					emplist.addAll(Arrays.asList(InternalMember));
				}
				if (ExternalMember != null) {
					
					for(int i=0;i<ExternalMember.length;i++) {
						lablist.addAll(Arrays.asList(LabId1));
					}
					
					emplist.addAll(Arrays.asList(ExternalMember));
				}
		
				if (ExternalMemberLab != null) {
					
					for(int i=0;i<ExternalMemberLab.length;i++) {
						lablist.addAll(Arrays.asList(LabId));
					}
					
					emplist.addAll(Arrays.asList(ExternalMemberLab));
					
				}
			}
			
			CommitteeInvitationDto committeeinvitationdto = new CommitteeInvitationDto();
	
			committeeinvitationdto.setCommitteeScheduleId(committeescheduleid);
			committeeinvitationdto.setCreatedBy(UserId);
			committeeinvitationdto.setEmpIdList(emplist);
			//committeeinvitationdto.setCommitteeScheduleId(req.getParameter("scheduleid"));
			committeeinvitationdto.setLabCodeList(lablist);
			committeeinvitationdto.setReptype(reptype);
			
			if(req.getParameter("chairperson") != null )
			{
				service.UpdateComitteeMainid(Committeeidmainid, committeescheduleid);
			}
			long count =  service.CommitteeInvitationCreate(committeeinvitationdto);
	
			if (count > 0) {				
				
				redir.addAttribute("result", " Member(s) Invited Successfully");
			} else {
				redir.addAttribute("resultfail", " Member(s) Invite Unsuccessful");
			}
	
			redir.addAttribute("committeescheduleid", committeescheduleid);

		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeAttendanceSubmit.htm "+UserId,e);
		}
		return "redirect:/CommitteeAttendance.htm";
	}

	
	@RequestMapping(value = "CommitteeAttendanceToggle.htm", method = RequestMethod.GET)
	public @ResponseBody String AttendanceToggle(HttpSession ses, HttpServletRequest req, RedirectAttributes redir)
			throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeAttendanceToggle.htm "+UserId);
		try
		{
			String Invitationid = req.getParameter("invitationid");
			service.CommitteeAttendanceToggle(Invitationid);
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeAttendanceToggle.htm "+UserId,e);
		}

		return "committee/CommitteeAttendance";
	}
	

	
	
	@RequestMapping(value="ProjectBasedSchedule.htm")
	public String ProjectBasedSchedule(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{		
		
		String UserId=(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectBasedSchedule.htm "+UserId);
		try {
			String Logintype= (String)ses.getAttribute("LoginType");
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String projectid=req.getParameter("projectid");
			String committeeid=req.getParameter("committeeid");
			
			List<Object[]> projectdetailslist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
			
			if(projectdetailslist.size()==0) 
			{				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}
			
			if(committeeid==null)
			{
				committeeid="all";
			}			
			
			if(projectdetailslist.size()==0) {
				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");

				return "redirect:/MainDashBoard.htm";
			}
			if(projectid==null || projectid.equals("null"))
			{
				projectid=projectdetailslist.get(0)[0].toString();
			}
			if(committeeid==null || committeeid.equals("all"))
			{				
				req.setAttribute("Projectschedulelist", service.ProjectScheduleListAll(projectid));
			} 
			else 
			{
				req.setAttribute("committeedetails",service.CommitteeDetails(committeeid));
				req.setAttribute("Projectschedulelist",service.ProjectCommitteeScheduleListAll(projectid, committeeid));				
			}
			
			List<Object[]> projapplicommitteelist=service.ProjectApplicableCommitteeList(projectid);
			
			
			req.setAttribute("projectid",projectid);
			req.setAttribute("committeeid",committeeid);
			req.setAttribute("Projectdetails",projectdetailslist.get(0));
			req.setAttribute("ProjectsList",projectdetailslist);
			req.setAttribute("projapplicommitteelist",projapplicommitteelist);
		}			
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +"Inside ProjectBasedSchedule.htm "+UserId,e);
		}
		return "committee/CommitteeProjectSchedule";
	}
	
	
	

	@RequestMapping(value="KickOffMeeting.htm",method=RequestMethod.POST)
	public String KickOffMeeting(HttpServletRequest req,HttpSession ses,RedirectAttributes redir, HttpServletResponse res) throws Exception{
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside KickOffMeeting.htm "+UserId);
		String CommitteeScheduleId=req.getParameter("committeescheduleid");
		
		 try {
				
			String ret = pt.freezeBriefingPaper(req, res, ses, redir);
			Object[] obj= service.KickOffMeeting(req, redir);
		    req=(HttpServletRequest)obj[0];
		    redir=(RedirectAttributes)obj[1];
		    
		    if(ret.equalsIgnoreCase("static/Error"))
		    {
		    	redir.addAttribute("resultfail", "Briefing Paper Freezing Failed !!");
		    }
		    
		 }catch (Exception e) {			
		 	e.printStackTrace(); 
		 	logger.error(new Date() +"Inside KickOffMeeting.htm "+UserId,e);
		 	
		 	
		}
		redir.addFlashAttribute("scheduleid",CommitteeScheduleId);
		return "redirect:/CommitteeScheduleView.htm";
	}
	

	@RequestMapping(value="MySchedules.htm")
	public String MySchedules(HttpServletRequest req,RedirectAttributes redir,HttpSession ses) throws Exception{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside MySchedules.htm "+UserId);
		try
		{

		String EmpId= ((Long) ses.getAttribute("EmpId")).toString();
	
		req.setAttribute("userschedulelist", service.UserSchedulesList(EmpId,"%%"));
		}catch(Exception e) {	    		
    		logger.error(new Date() +" Inside MySchedules.htm "+UserId, e);
    		e.printStackTrace();
    	}	
		return "committee/UserSchedules";
	
	}
	
	@RequestMapping(value="CommitteeUserScheduleView.htm",method=RequestMethod.GET)
	public String CommitteeUserScheduleView(HttpServletRequest req,RedirectAttributes redir,HttpSession ses, HttpServletResponse res) throws Exception{
		
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside CommitteeUserScheduleView.htm "+UserId);
		try
		{
		String EmpId= ((Long) ses.getAttribute("EmpId")).toString();
		String ScheduleId=req.getParameter("scheduleid");
		
		Object[] MemberType=service.UserSchedulesList(EmpId,"%%").get(0);
		
		redir.addAttribute("scheduleid", ScheduleId);
		redir.addAttribute("userview", MemberType[4].toString());
		redir.addAttribute("membertype",req.getParameter("membertype"));

		}catch(Exception e) {	    		
    		logger.error(new Date() +" Inside CommitteeUserScheduleView.htm "+UserId, e);
    		e.printStackTrace();	
    	}	
		
		return "redirect:/CommitteeScheduleView.htm";
		
	}
	
	
	@RequestMapping(value="CommitteeMinutesViewAllDownload.htm")
	public void CommitteeMinutesViewAllDownload(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res) throws Exception
	{

		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeMinutesViewAllDownload.htm "+UserId);
		try
		{
			String committeescheduleid = req.getParameter("committeescheduleid");			
			Object[] scheduleeditdata=service.CommitteeScheduleEditData(committeescheduleid);
			String projectid= scheduleeditdata[9].toString();
			
			if(projectid!=null && Integer.parseInt(projectid)>0)
				
			{
				req.setAttribute("projectdetails", service.projectdetails(projectid));
			}
			String divisionid= scheduleeditdata[16].toString();
			if(divisionid!=null && Integer.parseInt(divisionid)>0)
			{
				req.setAttribute("divisiondetails", service.DivisionData(divisionid));
			}
			String initiationid= scheduleeditdata[17].toString();
			if(initiationid!=null && Integer.parseInt(initiationid)>0)
			{
				req.setAttribute("initiationdetails", service.Initiationdetails(initiationid));
			}
			
			List<Object[]> actionlist= service.MinutesViewAllActionList(committeescheduleid);
			HashMap< String, ArrayList<Object[]>> actionsdata=new LinkedHashMap<String, ArrayList<Object[]>>();
			
			for(Object obj[] : actionlist) {
					
					ArrayList<Object[]> values=new ArrayList<Object[]>(); 
					for(Object obj1[] : actionlist ) {
						if(obj1[0].equals(obj[0])) {
							values.add(obj1);
						}
					}
					if(!actionsdata.containsKey(obj[0].toString())) {
						actionsdata.put(obj[0].toString(), values);
					}
				} 
			
			req.setAttribute("committeeminutesspeclist",service.CommitteeScheduleMinutes(committeescheduleid) );
			req.setAttribute("committeescheduleeditdata", scheduleeditdata);
			req.setAttribute("CommitteeAgendaList", service.AgendaList(committeescheduleid));
			req.setAttribute("committeeminutes",service.CommitteeMinutesSpecdetails());
			req.setAttribute("committeeminutessub",service.CommitteeMinutesSub());
			req.setAttribute("committeeinvitedlist", service.CommitteeAtendance(committeescheduleid));

			req.setAttribute("actionlist",  actionsdata);
			req.setAttribute("labdetails", service.LabDetails(scheduleeditdata[24].toString()));
			req.setAttribute("isprint", "Y");	
			req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(scheduleeditdata[24].toString()));
			req.setAttribute("labInfo", service.LabDetailes(LabCode));
			String committeeId=scheduleeditdata[0].toString();
			String scheduledate=scheduleeditdata[2].toString();
					
			List<Object[]>ActionDetails=service.actionDetailsForNonProject(committeeId,scheduledate);
			List<Object[]>actionSubDetails=new ArrayList();
			if(ActionDetails.size()>0) {
				actionSubDetails=ActionDetails.stream().filter(i -> LocalDate.parse(i[9].toString()).isBefore(LocalDate.parse(scheduledate))).collect(Collectors.toList());
			}
			Set<Integer>committeeCount=new TreeSet<>();
			for(Object[]obj:ActionDetails) {
				committeeCount.add(Integer.parseInt(obj[7].toString()));
			}
			int count=0;
			Map<Integer,Integer>committeeCountMap= new HashMap<>();
			for(Integer i:committeeCount) {
				committeeCountMap.put(++count, i);
			}
			
			req.setAttribute("committeeCountMap", committeeCountMap);
			req.setAttribute("ActionDetails", actionSubDetails);
			
			req.setAttribute("meetingcount",service.MeetingNo(scheduleeditdata));
			
			String filename=scheduleeditdata[11].toString().replace("/", "-");
			
			
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			
			
			
			
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/committee/CommitteeMinutesViewAll.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();
			
			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
	        
			req.setAttribute("tableactionlist",  actionsdata);
	        CharArrayWriterResponse customResponse1 = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/committee/ActionDetailsTable.jsp").forward(req, customResponse1);
			String html1 = customResponse1.getOutput();        
	        
	        HtmlConverter.convertToPdf(html1,new FileOutputStream(path+File.separator+filename+"1.pdf")); 
	         
	        
	        PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
	        PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
	        PdfReader pdf2=new PdfReader(path+File.separator+filename+"1.pdf");
	        
	        PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	       	        
	        PdfDocument pdfDocument2 = new PdfDocument(pdf2);
	        PdfMerger merger = new PdfMerger(pdfDocument);
	        
	        merger.merge(pdfDocument2, 1, pdfDocument2.getNumberOfPages());
            
            pdfDocument2.close();
	        pdfDocument.close();
	        merger.close();
	        pdf2.close();
	        pdf1.close();	       
	        pdfw.close();
	    
	        res.setContentType("application/pdf");
	        res.setHeader("Content-disposition","inline;filename="+filename+".pdf");
	        File f=new File(path +File.separator+ "merged.pdf");
	         
	        
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
	       
	       
	        Path pathOfFile2= Paths.get( path+File.separator+filename+"1.pdf"); 
	        Files.delete(pathOfFile2);		
	        pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
	        Files.delete(pathOfFile2);	
	        pathOfFile2= Paths.get(path +File.separator+ "merged.pdf"); 
	        Files.delete(pathOfFile2);	
	        
		}catch(Exception e) {	    		
			logger.error(new Date() +" Inside CommitteeMinutesViewAllDownload.htm "+UserId, e);
			e.printStackTrace();
		}	
	}

	
	@RequestMapping(value="ProjectMaster.htm")
	public String ProjectCommitteeMaster( Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectMaster.htm "+UserId);
		try {
			String LoginType=(String)ses.getAttribute("LoginType");
			String projectid=req.getParameter("projectid");
			if(projectid==null)  {
				Map md=model.asMap();
				projectid=(String)md.get("projectid");
			}
			String loginid= ses.getAttribute("LoginId").toString();
			List<Object[]> projectdetailslist=null;
			
			projectdetailslist=service.LoginProjectDetailsList(EmpId,LoginType,LabCode);
			
			
			if(projectdetailslist.size()==0) {				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}
			if(projectid==null || projectid.equals("null"))
			{
				projectid=projectdetailslist.get(0)[0].toString();
			}
			List<Object[]> projectmasterlist=service.ProjectMasterList(projectid);
			req.setAttribute("ProjectCommitteeFormationCheckList", service.ProjectCommitteeFormationCheckList(projectid));
			req.setAttribute("projectid",projectid);
			req.setAttribute("initiationid","0");	
			req.setAttribute("divisionid","0");	
			req.setAttribute("Projectdetails",projectdetailslist.get(0));
			req.setAttribute("ProjectsList",projectdetailslist);
			req.setAttribute("projectmasterlist",projectmasterlist);
			req.setAttribute("committeelist", service.ProjectCommitteesListNotAdded(projectid, LabCode));
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +"Inside ProjectMaster.htm "+UserId,e);
		}
		return "committee/CommitteeProjectMaster";
	}
	
	@RequestMapping(value="ProjectCommitteeAdd.htm",method = RequestMethod.POST)
	public String ProjectCommitteeAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectCommitteeAdd.htm "+UserId);
		try {
			
			String ProjectId=req.getParameter("projectid");
			String[] Committee=req.getParameterValues("committeeid");
			
			long count=service.ProjectCommitteeAdd(ProjectId,Committee,UserId);
			
			if (count > 0) {
				redir.addAttribute("result", " Committee Added Successfully");
				redir.addAttribute("projectid",ProjectId);
			} else {
				redir.addAttribute("result", " Committee Add Unsucessful");
			}
						
		}
		
		catch (Exception e) {
				e.printStackTrace(); 
			logger.error(new Date() +"Inside ProjectCommitteeAdd.htm "+UserId,e);
		}

		return "redirect:/ProjectMaster.htm";
	}
	
	
	@RequestMapping(value="ProjectCommitteeDelete.htm",method = RequestMethod.POST)
	public String ProjectCommitteeDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectCommitteeDelete.htm "+UserId);
		try {
			String ProjectId=req.getParameter("projectid");
			if(req.getParameter("sub")!=null) {
				
				String Option=req.getParameter("sub");
				
				if(!Option.equalsIgnoreCase("remove")) 
				{
					redir.addFlashAttribute("initiationid","0");
					redir.addFlashAttribute("projectid",ProjectId);
					redir.addFlashAttribute("divisionid","0");
					redir.addFlashAttribute("committeeid",req.getParameter("sub"));
					return "redirect:/CommitteeMainMembers.htm";
				}
				else {
					String[] CommitteeProject=req.getParameterValues("committeeprojectid");	
					
					long count=service.ProjectCommitteeDelete(CommitteeProject,UserId);					
					if (count > 0) {						
						redir.addAttribute("result", " Committee Removed Successfully");
						redir.addFlashAttribute("projectid",ProjectId);
					} else {
						redir.addAttribute("result", " Committee Remove Unsucessful");
					}					
				}		
				
			}			
			return "redirect:/ProjectMaster.htm";
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside ProjectCommitteeDelete.htm "+UserId,e);
			return "static/Error";
		}
		
	}
	
	
	@RequestMapping(value="CommitteeAutoSchedule.htm",method = { RequestMethod.POST,RequestMethod.GET})
	public String CommitteeAutoSchedule(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeAutoSchedule.htm "+UserId);
		try
		{	
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String LoginType=(String)ses.getAttribute("LoginType");
				
			List<Object[]> projectdetailslist=null;
			projectdetailslist=service.LoginProjectDetailsList(EmpId,LoginType,LabCode);
			
			if(projectdetailslist.size()==0) {				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}
			
			String projectid=null;
			String projectname=null;
			String initiationid=null;
			String divisionid=null;
			String projectstatus=null;
			if(req.getParameter("projectid")!=null) {
				projectid=req.getParameter("projectid");
				projectname=req.getParameter("projectname");
				initiationid=req.getParameter("initiationid");
				divisionid=req.getParameter("divisionid");	
				projectstatus=req.getParameter("projectstatus");
			}else if(projectid==null || projectid.equals("null")) {
				projectid=projectdetailslist.get(0)[0].toString();
				projectname=projectdetailslist.get(0)[1].toString();
				initiationid="0";
				divisionid="0";
				projectstatus="C";
				
				
			}
	
			
			List<Object[]> projectmasterlist = null;
			if(Long.parseLong(projectid)>0) 
			{
				projectmasterlist = service.ProjectMasterList(projectid);
			}
			req.setAttribute("projectid",projectid );
			req.setAttribute("projectmasterlist",projectmasterlist );
			req.setAttribute("projectname",projectname );
			req.setAttribute("divisionid",divisionid );
			req.setAttribute("initiationid",initiationid );
			
			for(Object[] obj : projectmasterlist ) {
				if(obj[6].toString().equalsIgnoreCase("N")) {		
					return "committee/CommitteeAutoSchedule";
				}
			}		
			List<Object[]> CommitteeAutoScheduleList= service.CommitteeAutoScheduleList(projectid,divisionid,initiationid,projectstatus);
			if(CommitteeAutoScheduleList.size()>0) {
				redir.addAttribute("projectname",projectname);
				redir.addAttribute("projectid",projectid);
				redir.addAttribute("divisionid",divisionid);
				redir.addAttribute("initiationid",initiationid);
				redir.addAttribute("projectstatus",projectstatus);
				return "redirect:/CommitteeAutoScheduleList.htm";
			}		
		}catch(Exception e) {	    		
			logger.error(new Date() +" Inside CommitteeAutoSchedule.htm "+UserId, e);
			e.printStackTrace();
		}	
		return "committee/CommitteeAutoSchedule";
	}
	
	@RequestMapping(value="CommitteeAutoScheduleSubmit.htm",method = RequestMethod.POST)
	public String CommitteeAutoScheduleSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeAutoScheduleSubmit.htm "+UserId);
		try
		{
		
		long count=0;
		String projectid=req.getParameter("projectid");
		String divisionid=req.getParameter("divisionid");
		String initiationid=req.getParameter("initiationid");
		Object[] projectdetails=service.projectdetails(projectid);
		String PDC=service.projectdetails(projectid)[9].toString();
		List<Object[]> ProjectMasterList= service.ProjectMasterList(projectid);	
		LocalDate EndDatePDC=LocalDate.parse(PDC);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");	
		if (EndDatePDC.isBefore(LocalDate.now()) ) {
			redir.addAttribute("resultfail", "PDC of Project is Expired");
			redir.addFlashAttribute("projectid", projectid);
			return "redirect:/ProjectMaster.htm";
		}
		for(int i=0;i<ProjectMasterList.size();i++) 
		{
			if(ProjectMasterList.get(i)[6].toString().equalsIgnoreCase("N"))
			{
				String CommitteeId=ProjectMasterList.get(i)[2].toString();
				String PeriodicDuration=service.CommitteeName(CommitteeId)[4].toString();
				
				if(!PeriodicDuration.equalsIgnoreCase("0")) 
				{					
					LocalDate StartDate=LocalDate.parse(req.getParameter("startdate"), formatter);
					LocalDate EndDate=LocalDate.parse(PDC);
										
					while(StartDate.isBefore(EndDate) || StartDate.isEqual(EndDate))
					{	  	
						CommitteeScheduleDto committeescheduledto=new CommitteeScheduleDto(); 
						committeescheduledto.setCommitteeId(Long.parseLong(CommitteeId));
						committeescheduledto.setScheduleDate(req.getParameter("startdate"));
						committeescheduledto.setScheduleStartTime(req.getParameter("starttime"));
						committeescheduledto.setCreatedBy(UserId);
						committeescheduledto.setScheduleFlag("MSC");
						committeescheduledto.setProjectId(projectid);
						committeescheduledto.setConfidential(projectdetails[10].toString());
						committeescheduledto.setDivisionId(divisionid);
						committeescheduledto.setInitiationId(initiationid);
						String formattedString2 = StartDate.format(formatter);
						committeescheduledto.setScheduleDate(formattedString2);
						committeescheduledto.setLabCode(labcode);
						
						count=service.CommitteeScheduleAddSubmit(committeescheduledto);
						service.CommitteeProjectUpdate(projectid,CommitteeId);
						
						StartDate=StartDate.plusDays(Long.parseLong(PeriodicDuration));
						
					}
				}
				else if(PeriodicDuration.equalsIgnoreCase("0")) {
					
					CommitteeScheduleDto committeescheduledto=new CommitteeScheduleDto(); 
					committeescheduledto.setCommitteeId(Long.parseLong(CommitteeId));
					committeescheduledto.setScheduleDate(req.getParameter("startdate"));
					committeescheduledto.setScheduleStartTime(req.getParameter("starttime"));
					committeescheduledto.setCreatedBy(UserId);
					committeescheduledto.setScheduleFlag("MSC");
					committeescheduledto.setProjectId(projectid);
					committeescheduledto.setScheduleDate(req.getParameter("startdate"));
					committeescheduledto.setConfidential(projectdetails[10].toString());
					committeescheduledto.setDivisionId(divisionid);
					committeescheduledto.setInitiationId(initiationid);
					committeescheduledto.setLabCode(labcode);
					count=service.CommitteeScheduleAddSubmit(committeescheduledto);
					service.CommitteeProjectUpdate(projectid,CommitteeId);
				}
			
				if (count > 0) {
					redir.addAttribute("result", "Committee Auto-Scheduled Successfully");
				} else {
					redir.addAttribute("resultfail", " Committee Auto-Schedule Unsucessful");
				}			
			}
		}
	
		redir.addAttribute("projectid", projectid);
		redir.addAttribute("divisionid", divisionid);
		redir.addAttribute("initiationid", initiationid);
		redir.addAttribute("projectname",service.projectdetails(projectid)[1].toString());
		}catch(Exception e) {	    		
			logger.error(new Date() +" Inside CommitteeAutoScheduleSubmit.htm "+UserId, e);
			e.printStackTrace();
		}	
		return "redirect:/CommitteeAutoScheduleList.htm";
	}
	
	
	@RequestMapping(value="CommitteeAutoScheduleList.htm")
	public String CommitteeAutoScheduleList( Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CommitteeAutoScheduleList.htm "+UserId);
		try
		{
				List<Object[]> CommitteeAutoScheduleList=null;
				String committeeid=req.getParameter("committeeid");
				String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
				String LoginType=(String)ses.getAttribute("LoginType");
				List<Object[]> projectdetailslist = null; 
				projectdetailslist= service.LoginProjectDetailsList(EmpId, LoginType,LabCode);
				if(projectdetailslist.size()==0) {				
					redir.addAttribute("resultfail", "No Project is Assigned to you.");
					return "redirect:/MainDashBoard.htm";
				}
				if(committeeid==null)
				{
					Map md=model.asMap();
					committeeid=(String)md.get("committeeid");
				}
				String divisionid=req.getParameter("divisionid");
				if(divisionid==null)  {
		
					Map md=model.asMap();
					divisionid=(String)md.get("divisionid");
				}		
				
				String initiationid=req.getParameter("initiationid");
				if(initiationid==null)  
				{
					Map md=model.asMap();
					initiationid=(String)md.get("initiationid");
				}
				
				String projectid=req.getParameter("projectid");
				if(projectid==null)  {
		
					Map md=model.asMap();
					projectid=(String)md.get("projectid");
				}
				if(projectid==null) {
					projectid=projectdetailslist.get(0)[0].toString();
					divisionid="0";
					initiationid="0";
				}
				
					
				String projectstatus=req.getParameter("projectstatus");
				if(projectstatus==null)  
				{					
					Map md=model.asMap();
					projectstatus=(String)md.get("projectstatus");
				}	
				
				if(projectstatus==null) 
				{
					projectstatus="A";
				}
				
				
				if(committeeid==null || committeeid.equals("all") )
				{
					committeeid="all";
					CommitteeAutoScheduleList= service.CommitteeAutoScheduleList(projectid,divisionid,initiationid,projectstatus);	
				}
				else
				{
					CommitteeAutoScheduleList= service.CommitteeAutoScheduleList(projectid, committeeid,divisionid,initiationid,projectstatus);
				}
				if(Long.parseLong(projectid)>0) 
				{
					req.setAttribute("committeelist",service.ProjectApplicableCommitteeList(projectid));
					req.setAttribute("ProjectName", service.projectdetails(projectid)[4].toString());
				}
				else if(Long.parseLong(divisionid)>0)
				{	
					req.setAttribute("committeelist",service.DivisionCommitteeMainList(divisionid));
					req.setAttribute("ProjectName", service.DivisionData(divisionid)[2].toString());
				}
				else if(Long.parseLong(initiationid)>0)
				{	
					req.setAttribute("committeelist",service.InitiationCommitteeMainList(initiationid)); 
					req.setAttribute("ProjectName", service.Initiationdetails(initiationid)[2].toString());
				}
		
				
				req.setAttribute("committeeid",committeeid);
				req.setAttribute("projectstatus",projectstatus);
				req.setAttribute("divisionid",divisionid);
				req.setAttribute("projectid",projectid);
				req.setAttribute("initiationid",initiationid);
				req.setAttribute("ProjectsList", projectdetailslist);
				req.setAttribute("CommitteeAutoScheduleList", CommitteeAutoScheduleList);	
	
		}catch(Exception e) {	    		
			logger.error(new Date() +" Inside CommitteeAutoScheduleList.htm "+UserId, e);
			e.printStackTrace();
		}	
		return "committee/CommitteeAutoScheduleList";
	}
	
	
	@RequestMapping(value="CommitteeAutoScheduleEdit.htm")
	public String CommitteeAutoScheduleEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeAutoScheduleEdit.htm "+UserId);
		try
		{
		String scheduleid=req.getParameter("scheduleid");		
		Object[] scheduledata=service.CommitteeScheduleEditData(scheduleid);
		String projectid=scheduledata[9].toString();
		
		req.setAttribute("projectname",req.getParameter("projectname"));
		req.setAttribute("scheduledata",scheduledata);
		req.setAttribute("projectid",projectid);
		req.setAttribute("projectstatus",req.getParameter("projectstatus"));
		
		}catch(Exception e) {	    		
			logger.error(new Date() +" Inside CommitteeAutoScheduleEdit.htm "+UserId, e);
			e.printStackTrace();
		}	
		return "committee/CommitteeAutoScheduleEdit";
	}
	
	@RequestMapping(value="CommitteeAutoScheduleUpdate.htm")
	public String CommitteeAutoScheduleUpdate(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception
	{		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeAutoScheduleUpdate.htm "+UserId);
		try
		{				
			CommitteeScheduleDto committeescheduledto=new CommitteeScheduleDto(); 
			committeescheduledto.setScheduleDate(req.getParameter("startdate"));
			committeescheduledto.setScheduleStartTime(req.getParameter("starttime"));
			committeescheduledto.setScheduleId(Long.parseLong(req.getParameter("scheduleid")));
			committeescheduledto.setModifiedBy(UserId);
			
			long count = service.CommitteeScheduleUpdate(committeescheduledto);
			
			if (count > 0) {
				redir.addAttribute("result", "Committee Schedule Edited Successfully");
			} else {
				redir.addAttribute("resultfail", "Committee Schedule Edit Unsuccessful");
				
			}	
			String committeeid=req.getParameter("committeeid");
			String projectid=req.getParameter("projectid");
			String divisionid=req.getParameter("divisionid");
			String initiationid=req.getParameter("initiationid");
			
			redir.addFlashAttribute("committeeid",committeeid);
			redir.addFlashAttribute("projectid",projectid);
			redir.addFlashAttribute("divisionid",divisionid);
			redir.addFlashAttribute("initiationid",initiationid);
			
			if((projectid!=null && Long.parseLong(projectid)>0) ||(divisionid!=null && Long.parseLong(divisionid)>0) || (initiationid!=null && Long.parseLong(initiationid)>0) )
			{	
				redir.addFlashAttribute("committeeid",committeeid);
				return "redirect:/CommitteeAutoScheduleList.htm"; 
			}
			
		}catch(Exception e) {	    		
			logger.error(new Date() +" Inside CommitteeAutoScheduleUpdate.htm "+UserId, e);
			e.printStackTrace();
		}	
		return "redirect:/NonProjectCommitteeAutoSchedule.htm";
		
	}
	
	@RequestMapping(value="MinutesAttachment.htm",method=RequestMethod.POST)
	public String MinutesAttachment(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,@RequestPart("FileAttach") MultipartFile FileAttach) throws Exception{
				
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MinutesAttachment.htm "+UserId);
		try
		{			
			CommitteeMinutesAttachmentDto dto= new CommitteeMinutesAttachmentDto();
			dto.setScheduleId(req.getParameter("ScheduleId"));
			dto.setMinutesAttachment(FileAttach);
			dto.setAttachmentName(FileAttach.getOriginalFilename());
			dto.setCreatedBy(UserId);
			dto.setMinutesAttachmentId(req.getParameter("attachmentid"));
			dto.setLabCode(LabCode);
			Long count = service.MinutesAttachmentAdd(dto);

			if (count > 0) {
				redir.addAttribute("result", "Minutes Attachment Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Minutes Attachment Add Unsuccessful");
			}
		
		}
		
		catch (Exception e) {
			e.printStackTrace(); 
		logger.error(new Date() +"Inside MinutesAttachment.htm "+UserId,e);
	}
			
		redir.addFlashAttribute("committeescheduleid", req.getParameter("ScheduleId"));
		redir.addFlashAttribute("specname", "Introduction");
		redir.addFlashAttribute("unit1","unit1");
		return "redirect:/CommitteeScheduleMinutes.htm";	
	}
	
	@RequestMapping(value="MinutesAttachmentDelete.htm",method=RequestMethod.POST)
	public String MinutesAttachmentDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{	
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MinutesAttachmentDelete.htm "+UserId);
		try
		{			
			String attachid=req.getParameter("attachmentid");			
			int count = service.MinutesAttachmentDelete(attachid);
			if (count > 0) {
				redir.addAttribute("result", "Minutes Attachment Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Minutes Attachment Delete Unsuccessful");
			}		
		}
		
		catch (Exception e) {
			e.printStackTrace(); 
		logger.error(new Date() +"Inside MinutesAttachmentDelete.htm "+UserId,e);
	}
			
		redir.addFlashAttribute("committeescheduleid", req.getParameter("ScheduleId"));
		redir.addFlashAttribute("specname", "Introduction");
		redir.addFlashAttribute("unit1","unit1");
		return "redirect:/CommitteeScheduleMinutes.htm";	
	}
	
	
	@RequestMapping(value = "MinutesAttachDownload.htm", method = RequestMethod.GET)
	public void MinutesAttachDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception 
	{
			 String UserId = (String) ses.getAttribute("Username");
				logger.info(new Date() +"Inside MinutesAttachDownload.htm "+UserId);		
				try { 
						res.setContentType("Application/octet-stream");	
						CommitteeMinutesAttachment attachment = service.MinutesAttachDownload(req.getParameter("attachmentid"));

						File my_file=null;
					
						my_file = new File(uploadpath+attachment.getFilePath()+File.separator+attachment.getAttachmentName()); 
				        res.setHeader("Content-disposition","attachment; filename="+attachment.getAttachmentName().toString()); 
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
				e.printStackTrace(); logger.error(new Date() +"Inside MinutesAttachDownload.htm"+UserId,e);
		}
	}

	
	@RequestMapping(value="MeetingMinutesApproval.htm", method=RequestMethod.POST)
	public String MeetingMinutesApproval(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		String Option=req.getParameter("sub");
		
		logger.info(new Date() +"Inside MeetingMinutesApproval.htm "+UserId);
		try
		{
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String CommitteeScheduleId=req.getParameter("committeescheduleid");
			int count = service.MeetingMinutesApproval(CommitteeScheduleId, UserId, EmpId,Option);
			if (count == -1) {
				redir.addAttribute("resultfail", "Please Assign All Actions To Forward Minutes For Approval");
			}
			else if (count > 0) {
				redir.addAttribute("result", "Meeting Minutes Forwarded Successfully");
			} else {
				redir.addAttribute("resultfail", "Meeting Minutes Forward Unsuccessful");
			}
			redir.addAttribute("scheduleid", CommitteeScheduleId);
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"MeetingMinutesApproval.htm "+UserId,e);
		}			
		
		return "redirect:/CommitteeScheduleView.htm";
	}
	
//	@RequestMapping(value = "MeetingApprovalMinutes.htm", method = RequestMethod.GET)
//	public String MeetingApprovalMinutes(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)	throws Exception 
//	{
//		String UserId=(String)ses.getAttribute("Username");
//		logger.info(new Date() +"Inside MeetingApprovalMinutes.htm "+UserId);
//		try
//		{
//		
//			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//	
//			req.setAttribute("MeetingApprovalMinutes", service.MeetingApprovalMinutesList(EmpId));
//		}
//		catch (Exception e) {
//				e.printStackTrace(); logger.error(new Date() +"Inside MeetingApprovalAgenda.htm "+UserId,e);
//		}
//
//		return "committee/ComMeetingApprovalMinList";
//	}
//	
	@RequestMapping(value = "MeetingApprovalMinutesDetails.htm", method = RequestMethod.POST)
	public String MeetingApprovalMinutesDetails(HttpServletRequest req, RedirectAttributes redir, HttpSession ses)	throws Exception {
		
		String UserId=(String)ses.getAttribute("Username");
		
		logger.info(new Date() +"Inside MeetingApprovalMinutesDetails.htm "+UserId);
		try
		{	
			String committeescheduleid=req.getParameter("scheduleid");
			
			Object[] committeescheduleeditdata=service.CommitteeScheduleEditData(committeescheduleid);
			String projectid= committeescheduleeditdata[9].toString();
			if(projectid!=null && Integer.parseInt(projectid)>0)
				
			{
				req.setAttribute("projectdetails", service.projectdetails(projectid));
			}
			String divisionid= committeescheduleeditdata[16].toString();
			if(divisionid!=null && Integer.parseInt(divisionid)>0)
			{
				req.setAttribute("divisiondetails", service.DivisionData(divisionid));
			}
			String initiationid= committeescheduleeditdata[17].toString();
			if(initiationid!=null && Integer.parseInt(initiationid)>0)
			{
				req.setAttribute("initiationdetails", service.Initiationdetails(initiationid));
			}
			List<Object[]> actionlist= service.MinutesViewAllActionList(committeescheduleid);
			HashMap< String, ArrayList<Object[]>> actionsdata=new LinkedHashMap<String, ArrayList<Object[]>>();
			
			for(Object obj[] : actionlist) {
					
					ArrayList<Object[]> values=new ArrayList<Object[]>(); 
					for(Object obj1[] : actionlist ) {
						if(obj1[0].equals(obj[0])) {
							values.add(obj1);
						}
					}
					if(!actionsdata.containsKey(obj[0].toString())) {
						actionsdata.put(obj[0].toString(), values);
					}
			} 
				
			req.setAttribute("committeeminutesspeclist",service.CommitteeScheduleMinutes(committeescheduleid) );
			req.setAttribute("committeescheduleeditdata", committeescheduleeditdata);
			req.setAttribute("CommitteeAgendaList", service.AgendaList(committeescheduleid));
			req.setAttribute("committeeminutes",service.CommitteeMinutesSpecdetails());
			req.setAttribute("committeeminutessub",service.CommitteeMinutesSub());
			req.setAttribute("committeeinvitedlist", service.CommitteeAtendance(committeescheduleid));			
			req.setAttribute("actionlist",actionsdata);
			req.setAttribute("labdetails", service.LabDetails(committeescheduleeditdata[24].toString()));
			req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(committeescheduleeditdata[24].toString()));
		
			
			return "committee/ComMeetingApprovalMinDetails";
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside MeetingApprovalMinutesDetails.htm "+UserId,e);
			return "static/Error";
		}

		
	}

	@RequestMapping(value="MeetingMinutesApprovalSubmit.htm", method=RequestMethod.POST)
	public String MeetingMinutesApprovalSubmit(HttpServletRequest req,RedirectAttributes redir,HttpServletResponse res, HttpSession ses) throws Exception{
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside MeetingMinutesApprovalSubmit.htm "+UserId);
		try
		{
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			
			String ScheduleId=req.getParameter("committeescheduleid");
			String Option=req.getParameter("sub");
			String Remarks=req.getParameter("Remark");
			
			if(Option.equalsIgnoreCase("approve")) {
				getMinutesFrozen(req, ses, res, redir);
			}
			int count = service.MeetingMinutesApprovalSubmit(ScheduleId, Remarks, UserId, EmpId,Option);		
			if (count > 0) {					
				if(Option.equalsIgnoreCase("approve")) {						
					redir.addAttribute("result", "Meeting Minutes Approved Successfully");
				}					
				if(Option.equalsIgnoreCase("return")) {						
					redir.addAttribute("result", "Meeting Minutes Returned Successfully");
				}			
			}else {					
				redir.addAttribute("resultfail", "Meeting Minutes Forward Unsuccessful");
			}
	
		}catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside MeetingMinutesApprovalSubmit.htm "+UserId,e);
		}

		return "redirect:/MeetingApprovalAgenda.htm";
	}

	
	@RequestMapping(value = "MeetingSearch.htm")
	public String ActionSearch(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String LabCode =(String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MeetingSearch.htm "+UserId);
		try
		{
			String EmpId= ((Long) ses.getAttribute("EmpId")).toString();
			String LoginType=(String)ses.getAttribute("LoginType");
	
			if(req.getParameter("search")!=null) {
			
				if(LoginType.equalsIgnoreCase("P")|| LoginType.equalsIgnoreCase("Y") || LoginType.equalsIgnoreCase("Z") || LoginType.equalsIgnoreCase("A")  || LoginType.equalsIgnoreCase("C")|| LoginType.equalsIgnoreCase("I")) 
				{
					req.setAttribute("meetingsearch", service.MeetingSearchList(req.getParameter("search") ,LabCode));
				}
				else {
					req.setAttribute("meetingsearch", service.UserSchedulesList(EmpId,req.getParameter("search")));
				}
			}
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside MeetingSearch.htm "+UserId,e);
		}
		
		return "committee/MeetingSearch";
	}

	@RequestMapping(value="CommitteeConstitutionLetter.htm")   
	public String CommitteeConstitutionLetter(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeConstitutionLetter.htm "+UserId);
		try
		{

			String committeemainid=req.getParameter("committeemainid");	
			
			Object[] committeemaindata= service.CommitteMainData(committeemainid);
			String committeeid=committeemaindata[1].toString();
			String projectid=committeemaindata[2].toString() ;
			String divisionid=committeemaindata[3].toString() ;
			String initiationid=committeemaindata[4].toString() ;
			String labCode=committeemaindata[10].toString();
			if(Long.parseLong(projectid)>0)
			{	
				req.setAttribute("projectdata", service.projectdetails(projectid));
				req.setAttribute("committeedescription", service.ProjectCommitteeDescriptionTOR(projectid,committeeid));
			}
			if(Long.parseLong(divisionid)>0)
			{	
				req.setAttribute("divisiondata", service.DivisionData(divisionid));
				req.setAttribute("committeedescription", service.DivisionCommitteeDescriptionTOR(divisionid,committeeid));
			}	
			if(Long.parseLong(initiationid)>0)
			{	
				req.setAttribute("initiationdata", service.Initiationdetails(initiationid));
				req.setAttribute("committeedescription", service.InitiationCommitteeDescriptionTOR(initiationid,committeeid));
			}	
			
			Object[] committeeedata=service.CommitteeDetails(committeeid);		
			List<Object[]> committeeallmemberslist=service.CommitteeAllMembers(committeemainid);
			
			req.setAttribute("committeeallmemberslist",committeeallmemberslist );
			req.setAttribute("committeemaindata", committeemaindata);
			req.setAttribute("committeeedata",committeeedata);
			req.setAttribute("projectid",projectid);		
			req.setAttribute("labdetails", service.LabDetails(labCode));
			req.setAttribute("email","N");
			return "committee/CommitteeConstitutionLetter" ;
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside CommitteeConstitutionLetter.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	
	
	@RequestMapping(value="CommitteeConstitutionLetterDownload.htm")   
	public void CommitteeConstitutionLetterDownload(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res) throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteeConstitutionLetterDownload.htm "+UserId);
		try
		{
		String committeemainid=req.getParameter("committeemainid");	
		
		Object[] committeemaindata= service.CommitteMainData(committeemainid);
		String committeeid=committeemaindata[1].toString();
		String projectid=committeemaindata[2].toString() ;
		String divisionid=committeemaindata[3].toString() ;
		String initiationid=committeemaindata[4].toString() ;
		if(Long.parseLong(projectid)>0)
		{	
			req.setAttribute("projectdata", service.projectdetails(projectid));
			req.setAttribute("committeedescription", service.ProjectCommitteeDescriptionTOR(projectid,committeeid));
		}
		if(Long.parseLong(divisionid)>0)
		{	
			req.setAttribute("divisiondata", service.DivisionData(divisionid));
			req.setAttribute("committeedescription", service.DivisionCommitteeDescriptionTOR(divisionid,committeeid));
		}	
		if(Long.parseLong(initiationid)>0)
		{	
			req.setAttribute("initiationdata", service.Initiationdetails(initiationid));
			req.setAttribute("committeedescription", service.InitiationCommitteeDescriptionTOR(initiationid,committeeid));
		}	
		
		Object[] committeeedata=service.CommitteeDetails(committeeid);		
		List<Object[]> committeeallmemberslist=service.CommitteeAllMembers(committeemainid);
		
		req.setAttribute("committeeallmemberslist",committeeallmemberslist );
		req.setAttribute("committeemaindata", committeemaindata);
		req.setAttribute("committeeedata",committeeedata);
		req.setAttribute("projectid",projectid);		
		req.setAttribute("labdetails", service.LabDetails(committeeedata[13].toString()));
		req.setAttribute("email","N");
		
		
		String filename=committeeedata[1]+" Formation Letter";		
		
		String path=req.getServletContext().getRealPath("/view/temp");
		req.setAttribute("path",path); 
		CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
		req.getRequestDispatcher("/view/committee/CommitteeConstitutionLetter.jsp").forward(req, customResponse);
		String html = customResponse.getOutput();
		byte[] data = html.getBytes();
		InputStream fis1=new ByteArrayInputStream(data);
		PdfDocument pdfDoc = new PdfDocument(new PdfWriter(path+"/"+filename+".pdf"));	
		
		Document document = new Document(pdfDoc, PageSize.A4);
		//document.setMargins(50, 100, 150, 50);
		document.setMargins(50, 50, 50, 50);
		ConverterProperties converterProperties = new ConverterProperties();
		FontProvider dfp = new DefaultFontProvider(true, true, true);
		converterProperties.setFontProvider(dfp);
	    HtmlConverter.convertToPdf(fis1,pdfDoc,converterProperties);
	    document.close();
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
	    fis.close();
	    os.close();
	    
	     
	        
	    Path pathOfFile2= Paths.get(path+"/"+filename+".pdf"); 
	    Files.delete(pathOfFile2);		
			
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside CommitteeConstitutionLetterDownload.htm "+UserId,e);
		}
		
		
	}
	
	@RequestMapping(value="MeetingInvitationLetterDownload.htm")
	public void MeetingInvitationLetterDownload(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res) throws Exception
	{

	String UserId=(String)ses.getAttribute("Username");
	logger.info(new Date() +"Inside MeetingInvitationLetterDownload.htm "+UserId);
	try
	{			
		String scheduleid=req.getParameter("committeescheduleid");		
		String invitationid=req.getParameter("invitationid");				
		Object[] scheduledata=service.CommitteeScheduleEditData(scheduleid);
		String projectid=scheduledata[9].toString();
								
		if(projectid==null || Long.parseLong(projectid)==0)
		{					
			projectid="0";
		}
		else if(Long.parseLong(projectid)>0)
		{						
			req.setAttribute("projectdata", service.projectdetails(projectid));
		}			
	
		List<Object[]> invitedlist=service.CommitteeAtendance(scheduleid);
						
		Object[] tomemberdata=null;
		for(int i=0;i<invitedlist.size();i++) {
								
			if(invitedlist.get(i)[1].toString().equalsIgnoreCase(invitationid))
			{
				tomemberdata=invitedlist.get(i);
				break;
			}			
		}		
		req.setAttribute("scheduledata", scheduledata);
		req.setAttribute("labdetails", service.LabDetails(scheduledata[24].toString()));
		req.setAttribute("tomember",tomemberdata );
		req.setAttribute("projectid",projectid);		
			
		String filename=tomemberdata[6]+" ("+tomemberdata[9]+")";
			
			
		String path=req.getServletContext().getRealPath("/view/temp");
		req.setAttribute("path",path); 
		CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
		req.getRequestDispatcher("/view/committee/MeetingInvitationLetterView.jsp").forward(req, customResponse);
		String html = customResponse.getOutput();
		byte[] data = html.getBytes();
		InputStream fis1=new ByteArrayInputStream(data);
		PdfDocument pdfDoc = new PdfDocument(new PdfWriter(path+"/"+filename+".pdf"));	
		
		Document document = new Document(pdfDoc, PageSize.A4);
		//document.setMargins(50, 100, 150, 50);
		document.setMargins(50, 50, 50, 50);
		ConverterProperties converterProperties = new ConverterProperties();
		FontProvider dfp = new DefaultFontProvider(true, true, true);
		converterProperties.setFontProvider(dfp);
	    HtmlConverter.convertToPdf(fis1,pdfDoc,converterProperties);
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
	    fis.close();
	    os.close();
	    
	     
	        
	    Path pathOfFile2= Paths.get(path+"/"+filename+".pdf"); 
	    Files.delete(pathOfFile2);		
		
	    	document.close();
	
	
	}
	catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +"Inside MeetingInvitationLetterDownload.htm "+UserId,e);
	}
	}
	
	

	
	@RequestMapping(value="MeetingInvitationLetter.htm")
	public String MeetingInvitationLetter(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside MeetingInvitationLetter.htm "+UserId);
		try
		{	
		
		String scheduleid=req.getParameter("committeescheduleid");
	
		String invitationid=req.getParameter("invitationid");
		
		Object[] scheduledata=service.CommitteeScheduleEditData(scheduleid);
		String projectid=scheduledata[9].toString();
		
		
		if(projectid==null || Long.parseLong(projectid)==0)
		{
			
			projectid="0";
		}
		else if(Long.parseLong(projectid)>0)
		{			
			req.setAttribute("projectdata", service.projectdetails(projectid));
		}
		
		
		
		List<Object[]> invitedlist=service.CommitteeAtendance(scheduleid);
				
		Object[] tomemberdata=null;
		for(int i=0;i<invitedlist.size();i++) {
			
			
			if(invitedlist.get(i)[1].toString().equalsIgnoreCase(invitationid))
			{
				tomemberdata=invitedlist.get(i);
				break;
			}			
		}		
		req.setAttribute("scheduledata", scheduledata);
		req.setAttribute("labdetails", service.LabDetails(scheduledata[24].toString()));
		req.setAttribute("tomember",tomemberdata );
		req.setAttribute("projectid",projectid);
		

		
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside MeetingInvitationLetter.htm "+UserId,e);
		}
		return "committee/MeetingInvitationLetterView" ;
	}
	
	
	
	
	@RequestMapping(value="MeetingTabularMinutes.htm")
	public String MeetingTabularMinutes(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{

	String UserId=(String)ses.getAttribute("Username");
	String LabCode =(String) ses.getAttribute("labcode");
	logger.info(new Date() +"Inside MeetingTabularMinutes.htm "+UserId);
	try
	{		
			String committeescheduleid = req.getParameter("committeescheduleid");
			Object[] committeescheduleeditdata=service.CommitteeScheduleEditData(committeescheduleid);
									
			String projectid= committeescheduleeditdata[9].toString();
			if(projectid!=null && Integer.parseInt(projectid)>0)
			{
				req.setAttribute("projectdetails", service.projectdetails(projectid));
			}
			String divisionid= committeescheduleeditdata[16].toString();
			if(divisionid!=null && Integer.parseInt(divisionid)>0)
			{
				req.setAttribute("divisiondetails", service.DivisionData(divisionid));
			}
			String initiationid= committeescheduleeditdata[17].toString();
			if(initiationid!=null && Integer.parseInt(initiationid)>0)
			{
				req.setAttribute("initiationdetails", service.Initiationdetails(initiationid));
			}
			
			List<Object[]> actionlist= service.MinutesViewAllActionList(committeescheduleid);
			HashMap< String, ArrayList<Object[]>> actionsdata=new LinkedHashMap<String, ArrayList<Object[]>>();
			
			for(Object obj[] : actionlist) {
					
					ArrayList<Object[]> values=new ArrayList<Object[]>(); 
					for(Object obj1[] : actionlist ) {
						if(obj1[0].equals(obj[0])) {
							values.add(obj1);
						}
					}
					if(!actionsdata.containsKey(obj[0].toString())) {
						actionsdata.put(obj[0].toString(), values);
					}
			} 
				
			req.setAttribute("actionsdata",actionsdata );
			req.setAttribute("committeeminutesspeclist",service.CommitteeScheduleMinutes(committeescheduleid) );
			req.setAttribute("committeescheduleeditdata", committeescheduleeditdata);
			req.setAttribute("committeeminutes",service.CommitteeMinutesSpecdetails());
			req.setAttribute("committeeinvitedlist", service.CommitteeAtendance(committeescheduleid));
			req.setAttribute("projectid", projectid);				
			req.setAttribute("actionlist", service.MinutesViewAllActionList(committeescheduleid));
			req.setAttribute("labdetails", service.LabDetails(committeescheduleeditdata[24].toString()));
			req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(committeescheduleeditdata[24].toString()));
			req.setAttribute("isprint", "N");
			req.setAttribute("meetingcount",service.MeetingNo(committeescheduleeditdata));
			req.setAttribute("labInfo", service.LabDetailes(LabCode));
		}
		catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +"Inside MeetingTabularMinutes.htm "+UserId,e);
		}		
		return "committee/MeetingTabularMinutes";
	}
	

	@RequestMapping(value="MeetingTabularMinutesDownload.htm")
	public void MeetingTabularMinutesDownload(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res) throws Exception
	{

	String UserId=(String)ses.getAttribute("Username");
	String LabCode =(String) ses.getAttribute("labcode");
	logger.info(new Date() +"Inside MeetingTabularMinutesDownload.htm "+UserId);
	try
	{
			String committeescheduleid = req.getParameter("committeescheduleid");
			Object[] committeescheduleeditdata=service.CommitteeScheduleEditData(committeescheduleid);
			String projectid= committeescheduleeditdata[9].toString();
			if(projectid!=null && Integer.parseInt(projectid)>0)
			{
				req.setAttribute("projectdetails", service.projectdetails(projectid));
			}
			String divisionid= committeescheduleeditdata[16].toString();
			if(divisionid!=null && Integer.parseInt(divisionid)>0)
			{
				req.setAttribute("divisiondetails", service.DivisionData(divisionid));
			}
			String initiationid= committeescheduleeditdata[17].toString();
			if(initiationid!=null && Integer.parseInt(initiationid)>0)
			{
				req.setAttribute("initiationdetails", service.Initiationdetails(initiationid));
			}
			
			List<Object[]> actionlist= service.MinutesViewAllActionList(committeescheduleid);
			HashMap< String, ArrayList<Object[]>> actionsdata=new LinkedHashMap<String, ArrayList<Object[]>>();
			
			for(Object obj[] : actionlist) {
					
					ArrayList<Object[]> values=new ArrayList<Object[]>(); 
					for(Object obj1[] : actionlist ) {
						if(obj1[0].equals(obj[0])) {
							values.add(obj1);
						}
					}
					if(!actionsdata.containsKey(obj[0].toString())) {
						actionsdata.put(obj[0].toString(), values);
					}
			} 
			
			req.setAttribute("actionsdata",actionsdata );
			
			req.setAttribute("committeeminutesspeclist",service.CommitteeScheduleMinutes(committeescheduleid) );
			req.setAttribute("committeescheduleeditdata", committeescheduleeditdata);
			//req.setAttribute("CommitteeAgendaList", service.CommitteeAgendaList(committeescheduleid));
			req.setAttribute("committeeminutes",service.CommitteeMinutesSpecdetails());
			//req.setAttribute("committeeminutessub",service.CommitteeMinutesSub());
			req.setAttribute("committeeinvitedlist", service.CommitteeAtendance(committeescheduleid));
			req.setAttribute("projectid", projectid);				
			req.setAttribute("actionlist", service.MinutesViewAllActionList(committeescheduleid));
			req.setAttribute("labdetails", service.LabDetails(committeescheduleeditdata[24].toString()));
			req.setAttribute("isprint", "Y");
			req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(committeescheduleeditdata[24].toString()));
			req.setAttribute("meetingcount",service.MeetingNo(committeescheduleeditdata));
			req.setAttribute("labInfo", service.LabDetailes(LabCode));
			
			String filename=committeescheduleeditdata[11].toString().replace("/", "-");
			
			
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			
			
			
			
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/committee/MeetingTabularMinutes.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();
			
			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
			req.setAttribute("tableactionlist",  actionsdata);
	        CharArrayWriterResponse customResponse1 = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/committee/ActionDetailsTable.jsp").forward(req, customResponse1);
			String html1 = customResponse1.getOutput();        
	        
	        HtmlConverter.convertToPdf(html1,new FileOutputStream(path+File.separator+filename+"1.pdf")); 
	         
	        
	        PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
	        PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
	        PdfReader pdf2=new PdfReader(path+File.separator+filename+"1.pdf");
	        
	        PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	       	        
	        PdfDocument pdfDocument2 = new PdfDocument(pdf2);
	        PdfMerger merger = new PdfMerger(pdfDocument);
	        
	        merger.merge(pdfDocument2, 1, pdfDocument2.getNumberOfPages());
            
            pdfDocument2.close();
	        pdfDocument.close();
	        merger.close();
	        pdf2.close();
	        pdf1.close();	       
	        pdfw.close();
	        
	        
	        
	    
	        res.setContentType("application/pdf");
	        res.setHeader("Content-disposition","inline;filename="+filename+".pdf");
	        File f=new File(path +File.separator+ "merged.pdf");
	         
	        
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
	       
	        Path pathOfFile2= Paths.get( path+File.separator+filename+"1.pdf"); 
	        Files.delete(pathOfFile2);		
	        pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
	        Files.delete(pathOfFile2);	
	        pathOfFile2= Paths.get(path +File.separator+ "merged.pdf"); 
	        Files.delete(pathOfFile2);	

	
	}
	catch (Exception e) {
			e.printStackTrace(); logger.error(new Date() +"Inside MeetingTabularMinutesDownload.htm "+UserId,e);
	}
	}
	
	// commented on 07-12-2023
//	@RequestMapping(value="EmailMeetingInvitationLetter.htm",method=RequestMethod.POST)
//	public String EmailMeetingInvitationLetter(HttpServletRequest req,HttpSession ses,RedirectAttributes redir,HttpServletResponse res) throws Exception{
//		
//		String UserId=(String)ses.getAttribute("Username");
//		logger.info(new Date() +"Inside EmailMeetingInvitationLetter.htm "+UserId);		
//		 try {			 
//			 	String scheduleid=req.getParameter("committeescheduleid");
////			 	String memberid=req.getParameter("memberid");
//				Object[] scheduledata=service.CommitteeScheduleEditData(scheduleid);
//				String projectid=scheduledata[9].toString();
////				String committeeid=scheduledata[0].toString();				
//				if(projectid==null || Long.parseLong(projectid)==0)
//				{					
//					projectid="0";
//				}
//				else if(Long.parseLong(projectid)>0)
//				{						
//					req.setAttribute("projectdata", service.projectdetails(projectid));
//				}			
//				List<Object[]> invitedlist=service.CommitteeAllAttendance(scheduleid);				
//				req.setAttribute("scheduledata", scheduledata);
//				req.setAttribute("labdetails", service.LabDetails(scheduledata[24].toString()));
//				req.setAttribute("tomember",invitedlist.get(0) );
//				req.setAttribute("projectid",projectid);
//				
//				//String path=req.getServletContext().getRealPath("/view/temp");
//				//req.setAttribute("path",path);
//				CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
//				req.getRequestDispatcher("/view/committee/MeetingInvitationLetterView.jsp").forward(req, customResponse);
//				String msgstring = customResponse.getOutput();
//						 
//				 MimeMessage msg = javaMailSender.createMimeMessage();
//				 MimeMessageHelper helper = new MimeMessageHelper(msg, true);
//				 helper.setTo("dinesh.vedts@gmail.com");
//				 helper.setCc("bandarudinesh1997@gmail.com");
//				 helper.setSubject("Meeting Invitation");
//				 helper.setText(msgstring);
//				 javaMailSender.send(msg);
//					 
//		        
//		 }		 
//		 catch (Exception e) {			
//		 	e.printStackTrace(); logger.error(new Date() +"Inside EmailMeetingInvitationLetter.htm "+UserId,e);
//		}
//			
//		return "redirect:/CommitteeScheduleView.htm";
//	}
//	
	@RequestMapping(value = "MeetingReports.htm", method = {RequestMethod.POST, RequestMethod.GET})
	public String MeetingReports(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId=(String)ses.getAttribute("Username");
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MeetingReports.htm "+UserId);		
		 try 
		 {
			String LoginType =(String)ses.getAttribute("LoginType");
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			
			String projectid=req.getParameter("projectid");
			String divisionid=req.getParameter("divisionid");
			String initiationid=req.getParameter("initiationid");
			String term=req.getParameter("term");
			String typeid=req.getParameter("typeid");
			if(term==null)
			{
				term="T";
			}
			
			if(typeid==null || typeid.equals("A") )
			{
				projectid="A";divisionid="A";initiationid="A";typeid="A";
			}
			
			req.setAttribute("initiationlist",service.InitiatedProjectDetailsList());
			req.setAttribute("divisionlist",service.LoginDivisionList(EmpId)); 
			req.setAttribute("ProjectList", service.LoginProjectDetailsList(EmpId,LoginType,LabCode));
			req.setAttribute("Term", term);
			req.setAttribute("typeid", typeid);
			req.setAttribute("projectid",projectid );
			req.setAttribute("divisionid",divisionid );
			req.setAttribute("initiationid",initiationid );
			req.setAttribute("MeetingReports", service.MeetingReports(EmpId,term,projectid,divisionid,initiationid, LoginType,LabCode));
		 }		 
		 catch (Exception e) {
		 	e.printStackTrace(); 
		 	logger.error(new Date() +"Inside MeetingReports.htm "+UserId,e);
		}
		return "committee/MeetingReports";
	}
	
//	@RequestMapping(value = "MeetingReportSubmit.htm", method = RequestMethod.POST)
//	public String MeetingReportSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
//	{
//		String UserId=(String)ses.getAttribute("Username");
//		String LoginType =(String)ses.getAttribute("LoginType");
//		logger.info(new Date() +"Inside MeetingReportSubmit.htm "+UserId);		
//		try {
//			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();		
//			String loginid= ses.getAttribute("LoginId").toString();
//			
//			req.setAttribute("initiationlist",service.InitiatedProjectDetailsList());
//			req.setAttribute("divisionlist",service.LoginDivisionList(EmpId)); 
//			req.setAttribute("ProjectList", service.LoginProjectDetailsList(loginid));
//			req.setAttribute("MeetingReports", service.MeetingReports(EmpId,req.getParameter("Term"),req.getParameter("projectid"),LoginType ));
//			req.setAttribute("Term", req.getParameter("Term"));
//			req.setAttribute("Project", req.getParameter("projectid"));
//		}		 
//		catch (Exception e) {			
//		 	e.printStackTrace();
//		 	logger.error(new Date() +"Inside MeetingReportSubmit.htm "+UserId,e);
//		}
//		return "committee/MeetingReports";
//	}
	//commented for testing
	
	
	
	
//	@RequestMapping(value="SendFormationLetter.htm",method=RequestMethod.POST)
//	public String SendFormationLetter1(HttpServletRequest req,HttpSession ses,RedirectAttributes redir,HttpServletResponse res) throws Exception
//	{
//		String UserId=(String)ses.getAttribute("Username");
//		System.out.println("Hiiiii");
//		logger.info(new Date() +"Inside SendFormationLetter.htm "+UserId);
//		try
//		{
//			String committeemainid=req.getParameter("committeemainid");	
//			Object[] committeemaindata= service.CommitteMainData(committeemainid);
//			String committeeid=committeemaindata[1].toString();
//			String projectid=committeemaindata[2].toString() ;
//			String divisionid=committeemaindata[3].toString() ;
//			String initiationid=committeemaindata[4].toString() ;
//			if(Long.parseLong(projectid)>0)
//			{	
//				req.setAttribute("projectdata", service.projectdetails(projectid));
//				req.setAttribute("committeedescription", service.ProjectCommitteeDescriptionTOR(projectid,committeeid));
//			}
//			if(Long.parseLong(divisionid)>0)
//			{	
//				req.setAttribute("divisiondata", service.DivisionData(divisionid));
//				req.setAttribute("committeedescription", service.DivisionCommitteeDescriptionTOR(divisionid,committeeid));
//			}	
//			if(Long.parseLong(initiationid)>0)
//			{	
//				req.setAttribute("initiationdata", service.Initiationdetails(initiationid));
//				req.setAttribute("committeedescription", service.InitiationCommitteeDescriptionTOR(initiationid,committeeid));
//			}	
//			
//			Object[] committeeedata=service.CommitteeDetails(committeeid);		
//			List<Object[]> committeeallmemberslist=service.CommitteeAllMembers(committeemainid);
//			
//			req.setAttribute("committeeallmemberslist",committeeallmemberslist );
//			req.setAttribute("committeemaindata", committeemaindata);
//			req.setAttribute("committeeedata",committeeedata);
//			req.setAttribute("projectid",projectid);
//			req.setAttribute("labdetails", service.LabDetails(committeeedata[13].toString()));
//			req.setAttribute("email","Y");
//			
//			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
//			req.getRequestDispatcher("/view/committee/CommitteeConstitutionLetter.jsp").forward(req, customResponse);
//			String Message= customResponse.getOutput();
//			
//			
//			MimeMessage msg = javaMailSender.createMimeMessage();
//			MimeMessageHelper helper = new MimeMessageHelper(msg, true);
//			
//			ArrayList<String> emails= new ArrayList<String>();			
//			
//			for(Object[] obj : committeeallmemberslist ) 
//			{				
//				if(obj[6]!=null && obj[8].toString().equals("CC") || obj[8].toString().equals("CS") || obj[8].toString().equals("CI") || obj[8].toString().equals("CW")) 
//				{				 
//					emails.add(obj[6].toString());				 
//				}
//			}
//			String [] Email = emails.toArray(new String[emails.size()]);
//			for(String s:Email) {
//				System.out.println();
//			}
//			helper.setTo(Email);	
//			helper.setSubject( committeemaindata[7] + " " +" Committee Formation Letter");
//			helper.setText( Message , true);
//			 
//			if(Email!=null && Email.length>0) {
//				javaMailSender.send(msg); 
//			}
//			if (Email.length>0) 
//			{
//				redir.addAttribute("result", " Committee Formation Letter Sent Successfully !! ");
//			}
//		
//		redir.addFlashAttribute("committeemainid",committeemaindata[0].toString());
//		
//		}
//		catch (Exception e) 
//		{
//			e.printStackTrace(); 
//			logger.error(new Date() +"Inside SendFormationLetter.htm "+UserId,e);
//		}
//		return "redirect:/CommitteeMainMembers.htm";
//	}
	
// new method for committee formation
	@RequestMapping(value="SendFormationLetter.htm",method=RequestMethod.POST)
	public String SendFormationLetter1(HttpServletRequest req,HttpSession ses,RedirectAttributes redir,HttpServletResponse res) throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside SendFormationLetter.htm "+UserId);
		try
		{
			System.out.println("Method2");
			String committeemainid=req.getParameter("committeemainid");	
			Object[] committeemaindata= service.CommitteMainData(committeemainid);
			String committeeid=committeemaindata[1].toString();
			String projectid=committeemaindata[2].toString() ;
			String divisionid=committeemaindata[3].toString() ;
			String initiationid=committeemaindata[4].toString() ;
			if(Long.parseLong(projectid)>0)
			{	
				req.setAttribute("projectdata", service.projectdetails(projectid));
				req.setAttribute("committeedescription", service.ProjectCommitteeDescriptionTOR(projectid,committeeid));
			}
			if(Long.parseLong(divisionid)>0)
			{	
				req.setAttribute("divisiondata", service.DivisionData(divisionid));
				req.setAttribute("committeedescription", service.DivisionCommitteeDescriptionTOR(divisionid,committeeid));
			}	
			if(Long.parseLong(initiationid)>0)
			{	
				req.setAttribute("initiationdata", service.Initiationdetails(initiationid));
				req.setAttribute("committeedescription", service.InitiationCommitteeDescriptionTOR(initiationid,committeeid));
			}	
			
			Object[] committeeedata=service.CommitteeDetails(committeeid);		
			List<Object[]> committeeallmemberslist=service.CommitteeAllMembers(committeemainid);
			
			req.setAttribute("committeeallmemberslist",committeeallmemberslist );
			req.setAttribute("committeemaindata", committeemaindata);
			req.setAttribute("committeeedata",committeeedata);
			req.setAttribute("projectid",projectid);
			req.setAttribute("labdetails", service.LabDetails(committeeedata[13].toString()));
			req.setAttribute("email","Y");
			
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/committee/CommitteeConstitutionLetter.jsp").forward(req, customResponse);
			String Message= customResponse.getOutput();
			
			

			
			ArrayList<String> emails= new ArrayList<String>();			
			
			for(Object[] obj : committeeallmemberslist ) 
			{				
				if(obj[6]!=null && obj[8].toString().equals("CC") || obj[8].toString().equals("CS") || obj[8].toString().equals("CI") || obj[8].toString().equals("CW")) 
				{				 
					emails.add(obj[6].toString());				 
				}
			}
			String [] Email = emails.toArray(new String[emails.size()]);
			String subject=committeemaindata[8] + " " +" Committee Formation Letter";
			
			if(Email!=null && Email.length>0) {
				
				for(String email:Email) {
					cm.sendScheduledEmailAsync(email, subject, Message, true);
				}
			}
			if (Email.length>0) 
			{
				redir.addAttribute("result", " Committee Formation Letter Sent Successfully !! ");
			}
		
		redir.addFlashAttribute("committeemainid",committeemaindata[0].toString());
		
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +"Inside SendFormationLetter.htm "+UserId,e);
		}
		return "redirect:/CommitteeMainMembers.htm";
	}
	
	
	

//	@RequestMapping(value="SendInvitationLetter.htm",method=RequestMethod.POST)
//	public String SendInvitationLetter(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception
//	{		
//		String UserId=(String)ses.getAttribute("Username");
//		logger.info(new Date() +"Inside SendInvitationLetter.htm "+UserId);
//		
//		try {
//			String committeescheduleid=req.getParameter("committeescheduleid");
//			 
//			List<Object[]> committeeinvitedlist=service.CommitteeAtendance(committeescheduleid);
//			
//			
//			
//			Object[] scheduledata=service.CommitteeScheduleEditData(committeescheduleid);
//			SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
//			ArrayList<String> emails= new ArrayList<String>();
//			ArrayList<String> membertypes=new ArrayList<String>(Arrays.asList("CC","CS","PS","CI","I","P"));
//
//			for(Object[] obj : committeeinvitedlist) 
//			{	 
//				if(membertypes.contains(obj[3].toString()) && obj[9].toString().equals("N")) 
//				{
//					if(obj[8]!=null) {
//						emails.add(obj[8].toString());
//					}
//				}
//			}
//			
//			String LabCode =(String) ses.getAttribute("labcode");
//			String ProjectName="General Type";
//			if(!scheduledata[9].toString().equalsIgnoreCase("0")) 
//			{
//				ProjectName= service.projectdetails(scheduledata[9].toString())[1].toString();
//			}
//			 
//			String [] Email = emails.toArray(new String[emails.size()]);
//			 
//			MimeMessage msg = javaMailSender.createMimeMessage();
//			MimeMessageHelper helper = new MimeMessageHelper(msg, true);
//			helper.setTo(Email);
//			String Message="Sir/Madam<br><p>&emsp;&emsp;&emsp;&emsp;&emsp;This is to inform you that Meeting is Scheduled for the  <b>"+ scheduledata[7]  + "(" + scheduledata[8] + ")" +"</b> committee of <b>"+ ProjectName +"</b> and further details about the meeting is mentioned below. </p> <table style=\"align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse:collapse;\" >"
//			 		+ "<tr><th colspan=\"2\" style=\"text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px\">Meeting Details </th></tr>"
//			 		 + "<tr><td style=\"border: 1px solid black; padding: 5px;text-align: left\"> Date :  </td>"
//			 		 + "<td style=\"border: 1px solid black; padding: 5px;text-align: left\">" + sdf.format(scheduledata[2])+","+LocalDate.parse(scheduledata[2].toString()).getDayOfWeek()+"</td></tr>"
//			 		 
//			 		 +"<tr>"
//					 + "<td style=\"border: 1px solid black; padding: 5px;text-align: left\"> Time : </td>"
//					 + "<td style=\"border: 1px solid black; padding: 5px;text-align: left\">" + scheduledata[3]  + "</td></tr>"
//					 +"<tr>"
//					 +"<td style=\"border: 1px solid black; padding: 5px;text-align: left\"> Venue</td>"
//					 +"<td style=\"border: 1px solid black; padding: 5px;text-align: left\">"+ scheduledata[12] +"</td>"
//					 +"</tr>"
//					 +"<p style=\"font-weight:bold;font-size:13px;\">[Note:This is an autogenerated e-mail.Reply to this will not be attended please.]</p>"
//					 +"<p>Regards</p>"
//					 +"<p>"+LabCode+ "- PMS Team"+"</p>"
//					 ;
//					 
//			if (Email.length>0) {
//				
//				try{
//					helper.setSubject( scheduledata[8] + " " +" Committee Invitation Letter");
//					helper.setText( Message , true);
//					javaMailSender.send(msg); 
//					service.UpdateCommitteeInvitationEmailSent(committeescheduleid);
//					redir.addAttribute("result", " Committee Invitation Letter Sent Successfully !! ");
//				}catch (MailAuthenticationException e) {
//					redir.addAttribute("resultfail", " Host Email Authentication Failed, Unable to Send Invitations !!");
//				}
//				
//			} 
//			 
//			 redir.addFlashAttribute("committeescheduleid",committeescheduleid);
//			 
//			
//		 }
//		 catch (Exception e) {
//				
//			 	e.printStackTrace(); 
//			 	logger.error(new Date() +"Inside SendInvitationLetter.htm "+UserId,e);
//			}			 
//		 return "redirect:/CommitteeInvitations.htm";
//		 }
//	
	// new method sending email 

	@RequestMapping(value="SendInvitationLetter.htm",method=RequestMethod.POST)
	public String SendInvitationLetter(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception
	{		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside SendInvitationLetter.htm "+UserId);
		
		try {
			String committeescheduleid=req.getParameter("committeescheduleid");
			 
			List<Object[]> committeeinvitedlist=service.CommitteeAtendance(committeescheduleid);
			
			
			
			Object[] scheduledata=service.CommitteeScheduleEditData(committeescheduleid);
			SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
			ArrayList<String> emails= new ArrayList<String>();
			ArrayList<String> membertypes=new ArrayList<String>(Arrays.asList("CC","CS","PS","CI","I","P"));

			for(Object[] obj : committeeinvitedlist) 
			{	 
				if(membertypes.contains(obj[3].toString()) && obj[9].toString().equals("N")) 
				{
					if(obj[8]!=null) {
						emails.add(obj[8].toString());
					}
				}
			}
			
			String LabCode =(String) ses.getAttribute("labcode");
			String ProjectName="General Type";
			if(!scheduledata[9].toString().equalsIgnoreCase("0")) 
			{
				ProjectName= service.projectdetails(scheduledata[9].toString())[1].toString();
			}
			 
			String [] Email = emails.toArray(new String[emails.size()]);
			String Message="Sir/Madam<br><p>&emsp;&emsp;&emsp;&emsp;&emsp;This is to inform you that Meeting is Scheduled for the  <b>"+ scheduledata[7]  + "(" + scheduledata[8] + ")" +"</b> committee of <b>"+ ProjectName +"</b> and further details about the meeting is mentioned below. </p> <table style=\"align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 15px; max-width: 650px; font-size: 16px; border-collapse:collapse;\" >"
			 		+ "<tr><th colspan=\"2\" style=\"text-align: left; font-weight: 700; width: 650px;border: 1px solid black; padding: 5px; padding-left: 15px\">Meeting Details </th></tr>"
			 		 + "<tr><td style=\"border: 1px solid black; padding: 5px;text-align: left\"> Date :  </td>"
			 		 + "<td style=\"border: 1px solid black; padding: 5px;text-align: left\">" + sdf.format(scheduledata[2])+","+LocalDate.parse(scheduledata[2].toString()).getDayOfWeek()+"</td></tr>"
			 		 
			 		 +"<tr>"
					 + "<td style=\"border: 1px solid black; padding: 5px;text-align: left\"> Time : </td>"
					 + "<td style=\"border: 1px solid black; padding: 5px;text-align: left\">" + scheduledata[3]  + "</td></tr>"
					 +"<tr>"
					 +"<td style=\"border: 1px solid black; padding: 5px;text-align: left\"> Venue</td>"
					 +"<td style=\"border: 1px solid black; padding: 5px;text-align: left\">"+ scheduledata[12] +"</td>"
					 +"</tr>"
					 +"<p style=\"font-weight:bold;font-size:13px;\">[Note:This is an autogenerated e-mail.Reply to this will not be attended please.]</p>"
					 +"<p>Regards</p>"
					 +"<p>"+LabCode+ "- PMS Team"+"</p>"
					 ;
					 
			if (Email.length>0) {
				
				try{
					String subject=scheduledata[8] + " " +" Committee Invitation Letter";
					for(String email:Email) {
						cm.sendScheduledEmailAsync(email, subject, Message, true);
					}
					
					
					service.UpdateCommitteeInvitationEmailSent(committeescheduleid);
					redir.addAttribute("result", " Committee Invitation Letter Sent Successfully !! ");
				}catch (MailAuthenticationException e) {
					redir.addAttribute("resultfail", " Host Email Authentication Failed, Unable to Send Invitations !!");
				}
				
			} 
			 
			 redir.addFlashAttribute("committeescheduleid",committeescheduleid);
			 
			
		 }
		 catch (Exception e) {
				
			 	e.printStackTrace(); 
			 	logger.error(new Date() +"Inside SendInvitationLetter.htm "+UserId,e);
			}			 
		 return "redirect:/CommitteeInvitations.htm";
		 }
	
	
	
	
	@RequestMapping(value = "TotalMeetingReport.htm", method = {RequestMethod.GET })
	public String TotalMeetingReport(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception 
	{
		String UserId =(String)ses.getAttribute("Username");
		String LoginType =(String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside TotalMeetingReport.htm "+UserId);
		try {
		
		FormatConverter fc=new FormatConverter();
		SimpleDateFormat sdf=fc.getRegularDateFormat();
		SimpleDateFormat sdf1=fc.getSqlDateFormat();
		
		String fdate=req.getParameter("fdate");
		String tdate=req.getParameter("tdate");
		String Emp=req.getParameter("EmpId");
		String Project=req.getParameter("Project");
		if(fdate==null)
		{
			fdate=LocalDate.now().toString();
			Emp="A";
			Project="";
		}else
		{
			fdate=sdf1.format(sdf.parse(fdate));
		}		
		if(tdate==null)
		{
			tdate=LocalDate.now().plusMonths(1).toString();
		}
		else 
		{	
			tdate=sdf1.format(sdf.parse(tdate));				
		}
		req.setAttribute("tdate",tdate);
		req.setAttribute("fdate",fdate);
		
		String loginid= ses.getAttribute("LoginId").toString();
		req.setAttribute("ProjectList", service.LoginProjectDetailsList(EmpId,LoginType,LabCode));
		req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
		req.setAttribute("Project",Project);
		req.setAttribute("Employee", Emp);
		req.setAttribute("EmpId", EmpId);
		req.setAttribute("LoginType", LoginType);
		List<Object[]> TotalMeetingReportListAll= service.MeetingReportListAll(fdate,tdate,Project);
		req.setAttribute("TotalMeetingReportListAll", TotalMeetingReportListAll );
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside TotalMeetingReport.htm "+UserId, e);
		}
		return "committee/TotalMeetingReport";
	}
	
	@RequestMapping(value = "TotalMeetingReport.htm", method = { RequestMethod.POST})
	public String TotalMeetingReportSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {
		String UserId =(String)ses.getAttribute("Username");
		String LoginType =(String)ses.getAttribute("LoginType");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside TotalMeetingReport.htm "+UserId);		
		try {
		
		FormatConverter fc=new FormatConverter();
		SimpleDateFormat sdf=fc.getRegularDateFormat();
		SimpleDateFormat sdf1=fc.getSqlDateFormat();
		
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String fdate=req.getParameter("fdate");
		String tdate=req.getParameter("tdate");
		String Emp=req.getParameter("EmpId");
		String Project=req.getParameter("Project");
		
		fdate=sdf1.format(sdf.parse(fdate));

		tdate=sdf1.format(sdf.parse(tdate));				
	
		req.setAttribute("tdate",tdate);
		req.setAttribute("fdate",fdate);
		
		String loginid= ses.getAttribute("LoginId").toString();
		req.setAttribute("ProjectList", service.LoginProjectDetailsList(loginid,LoginType,LabCode));
		req.setAttribute("EmployeeList", service.EmployeeList(LabCode));
		req.setAttribute("Project",Project);
		req.setAttribute("Employee", Emp);
		req.setAttribute("EmpId", EmpId);
		req.setAttribute("LoginType", LoginType);
		
		List<Object[]> TotalMeetingReportListAll= service.MeetingReportListAll(fdate,tdate,Project);
		req.setAttribute("TotalMeetingReportListAll", TotalMeetingReportListAll );
		
		if(!Emp.toString().equalsIgnoreCase("A")) {
			
			TotalMeetingReportListAll= service.MeetingReportListEmp(fdate,tdate,Project,Emp);
			
			req.setAttribute("TotalMeetingReportListAll", TotalMeetingReportListAll );
		}

		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside TotalMeetingReport.htm "+UserId, e);
		}
		return "committee/TotalMeetingReport";
	}

	
	@RequestMapping(value = "ExternalEmployeeListFormation.htm", method = RequestMethod.GET)
	public @ResponseBody String ExternalEmployeeListFormation(HttpServletRequest req,HttpSession ses) throws Exception {

		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside ExternalEmployeeListFormation.htm"+ UserId);
		
		List<Object[]> ExternalEmployeeList= new ArrayList<Object[]>();
		
		ExternalEmployeeList = service.ExternalEmployeeListFormation(req.getParameter("CpLabCode"),req.getParameter("committeemainid"));
			
		Gson json = new Gson();
		return json.toJson(ExternalEmployeeList);	
	}
	
	@RequestMapping(value = "ChairpersonEmployeeListFormation.htm", method = RequestMethod.GET)
	public @ResponseBody String ChairpersonEmployeeListFormation(HttpServletRequest req,HttpSession ses) throws Exception 
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside ChairpersonEmployeeListFormation.htm"+ UserId);
		
		List<Object[]> EmployeeList = new ArrayList<Object[]>();
		
		try {
			String CpLabCode =req.getParameter("CpLabCode");
			String committeemainid = req.getParameter("committeemainid");
			if(CpLabCode.trim().equalsIgnoreCase("@EXP")) 
			{
				EmployeeList = service.ClusterExpertsList(committeemainid);
			}
			else
			{
				EmployeeList = service.ChairpersonEmployeeListFormation(CpLabCode.trim(),committeemainid);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside ChairpersonEmployeeListFormation.htm "+UserId, e);
		}
		
		Gson json = new Gson();
		return json.toJson(EmployeeList);	
	}
	
	
	
	@RequestMapping(value = "ExternalEmployeeListInvitations.htm", method = RequestMethod.GET)
	public @ResponseBody String ExternalEmployeeListInvitations(HttpServletRequest req,HttpSession ses) throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside ExternalEmployeeListInvitations.htm"+ UserId);
		
		List<Object[]> ExternalEmployeeList = new ArrayList<Object[]>();
		
		String LabCode =req.getParameter("LabCode");
	
		ExternalEmployeeList = service.ExternalEmployeeListInvitations(LabCode,req.getParameter("scheduleid"));
	 
		Gson json = new Gson();
		return json.toJson(ExternalEmployeeList);	
	}
	
	@RequestMapping(value = "MeetingsStatusReports.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String MeetingsStatusReports(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)
			throws Exception {	
		
		String UserId =(String)ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside MeetingsStatusReports.htm "+UserId);		
		try {
			String projectid=req.getParameter("projectid");
			if(projectid==null)
			{
				projectid="0";
				
			}
			String loginid= ses.getAttribute("LoginId").toString();
			String Logintype= (String)ses.getAttribute("LoginType");
			
			if(Logintype.equals("A") || Logintype.equals("Z") || Logintype.equals("Y") || Logintype.equalsIgnoreCase("C")|| Logintype.equalsIgnoreCase("I"))
			{	//all projects for admin, associate director and director
				req.setAttribute("projectslist", service.allprojectdetailsList());
			} 
			else if(Logintype.equals("P"))
			{
				List<Object[]> projectlist= service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
				if(projectlist.size()==0) {
					
					redir.addAttribute("resultfail", "No Project is Assigned to you.");

					return "redirect:/MainDashBoard.htm";
				}
				req.setAttribute("projectslist",projectlist );
			}
			req.setAttribute("projectid",projectid);
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside MeetingsStatusReports.htm "+UserId, e);
		}
		return "committee/MeetingsStatusReports";
	}
	
	 @RequestMapping(value = "MeetingsCount.htm", method = RequestMethod.GET)
		public @ResponseBody String MeetingsCount(HttpServletRequest req, HttpSession ses) throws Exception {
		 Gson json = new Gson();
		 Object[] ItemDescriptionSearchLedger=null;
		 String UserId =(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside MeetingsCount.htm "+UserId);		
			try {		
					
					ItemDescriptionSearchLedger =   service.ProjectBasedMeetingStatusCount(req.getParameter("projectid"));
						
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside MeetingsCount.htm "+UserId, e);
			}
			return json.toJson(ItemDescriptionSearchLedger);

		}
	 
	 @RequestMapping(value = "MeetingStatusWiseReport.htm", method = {RequestMethod.GET,RequestMethod.POST})
	 public String MeetingStatusWiseReport(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	 {
		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside MeetingStatusWiseReport.htm "+UserId);		
		try {
			String projectid=req.getParameter("projectid");
			String statustype=req.getParameter("statustype");
			List<Object[]> meetingstatuslist= service.PfmsMeetingStatusWiseReport(projectid,statustype);
			req.setAttribute("meetingstatuslist",meetingstatuslist);
			req.setAttribute("projectid",projectid);
			req.setAttribute("statustype",statustype);
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside MeetingStatusWiseReport.htm "+UserId, e);
		}
		 
		 return "committee/MeetingsStatusWiseList";
	 }
	 
	 
	 @RequestMapping(value = "ProjectCommitteeDescriptionTOREdit.htm")
	 public String ProjectCommitteeDescriptionTOREdit(Model model,HttpServletRequest req,HttpServletResponse res,HttpSession ses)
	 {
		 	String UserId =(String)ses.getAttribute("Username");
		 	Object[] ProjectCommitteeDescriptionTOR=null;
			logger.info(new Date() +"Inside ProjectCommitteeDescriptionTOREdit.htm "+UserId);		
			try {
				
				String committeemainid=req.getParameter("committeemainid");
				if(committeemainid==null) {
					Map md=model.asMap();
					committeemainid=(String)md.get("committeemainid");
				}	
				Object[] committeemaindata= service.CommitteMainData(committeemainid);
				String committeeid=committeemaindata[1].toString();
				String projectid=committeemaindata[2].toString() ;
				String divisionid=committeemaindata[3].toString() ;
				String initiationid=committeemaindata[4].toString() ;
						
								
				if(projectid!=null && Long.parseLong(projectid)>0)
				{
					ProjectCommitteeDescriptionTOR=service.ProjectCommitteeDescriptionTOR(projectid, committeeid);
				}
				else if(divisionid!=null && Long.parseLong(divisionid)>0)
				{
					ProjectCommitteeDescriptionTOR=service.DivisionCommitteeDescriptionTOR(divisionid, committeeid);
				}
				if(Long.parseLong(initiationid)>0)
				{					
					ProjectCommitteeDescriptionTOR = service.InitiationCommitteeDescriptionTOR(initiationid,committeeid);
				}
				req.setAttribute("committeeprojectdata",ProjectCommitteeDescriptionTOR);
				req.setAttribute("committeemaindata",committeemaindata);
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside ProjectCommitteeDescriptionTOREdit.htm "+UserId, e);
			}
		 return "committee/CommitteeProjectDescriptionTOREdit";
	 }
	 
	 
	 @RequestMapping(value = "ProjectCommitteeDescriptionTOREditSubmit.htm")
	 public String ProjectCommitteeDescriptionTOREditSubmit(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir)
	 {
		 	String UserId =(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside ProjectCommitteeDescriptionTOREditSubmit.htm "+UserId);		
			try {
				String committeemainid=req.getParameter("committeemainid");
				Object[] committeemaindata= service.CommitteMainData(committeemainid);
				String committeeid=committeemaindata[1].toString();
				String projectid=committeemaindata[2].toString() ;
				String divisionid=committeemaindata[3].toString() ;
				String initiationid=committeemaindata[4].toString() ;
				int count=0;
				if(Long.parseLong(projectid)>0)
				{
					CommitteeProject  committeeproject = new CommitteeProject();
					committeeproject.setCommitteeProjectId(Long.parseLong(req.getParameter("committeeprojectid")));
					committeeproject.setDescription(req.getParameter("description"));
					committeeproject.setTermsOfReference(req.getParameter("TOR"));
					committeeproject.setModifiedBy(UserId);			
					
					count= service.ProjectCommitteeDescriptionTOREdit(committeeproject);
				}else if(Long.parseLong(divisionid)>0)
				{
					CommitteeDivision committeedivision = new CommitteeDivision(); 
					committeedivision.setCommitteeDivisionId(Long.parseLong(req.getParameter("committeeprojectid")));
					committeedivision.setDescription(req.getParameter("description"));
					committeedivision.setTermsOfReference(req.getParameter("TOR"));
					committeedivision.setModifiedBy(UserId);
					count= service.DivisionCommitteeDescriptionTOREdit(committeedivision);
				}else if(Long.parseLong(initiationid)>0)
				{
					CommitteeInitiation committeeinitiation = new CommitteeInitiation(); 
					committeeinitiation.setCommitteeInitiationId(Long.parseLong(req.getParameter("committeeprojectid")));
					committeeinitiation.setDescription(req.getParameter("description"));
					committeeinitiation.setTermsOfReference(req.getParameter("TOR"));
					committeeinitiation.setModifiedBy(UserId);
					count= service.InitiationCommitteeDescriptionTOREdit(committeeinitiation);
				}
				
				if (count > 0) {
					redir.addAttribute("result", "Description and Terms of Reference Edited Successfully");
				} else {
					redir.addAttribute("resultfail", "Description and Terms of Reference Edit unSuccessfull");
				}
				redir.addFlashAttribute("committeemainid",committeemainid);
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside ProjectCommitteeDescriptionTOREditSubmit.htm "+UserId, e);
			}
		 return "redirect:/ProjectCommitteeDescriptionTOREdit.htm";
	 }
	 
	 @RequestMapping(value = "AgendasFromPreviousMeetingsAdd.htm")
	 public String AgendasFromPreviousMeetingsAdd(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir)
	 {
		 	String UserId =(String)ses.getAttribute("Username");
		 	String LabCode =(String)ses.getAttribute("labcode");
			logger.info(new Date() +"Inside AgendasFromPreviousMeetingsAdd.htm "+UserId);		
			try {
				String scheduleidto = req.getParameter("scheduleidto");
				String meetingid = req.getParameter("meetingid");
				String scheduleidfrom=req.getParameter("scheduleidfrom");
				String search = req.getParameter("search");
				
				if(search!=null)
				{
					req.setAttribute("meetingsearch", service.MeetingSearchList(search,LabCode));					
				}
				
				if(scheduleidfrom!=null)
				{
					req.setAttribute("committeescheduledata1",service.CommitteeScheduleEditData(scheduleidfrom));
					req.setAttribute("agendalist",service.AgendaList(scheduleidfrom));
					req.setAttribute("meetingid",meetingid);
				}			
				
				req.setAttribute("scheduleidto",scheduleidto);
				req.setAttribute("committeescheduleeditdata",service.CommitteeScheduleEditData(scheduleidto));
				
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside AgendasFromPreviousMeetingsAdd.htm "+UserId, e);
			}
		 return "committee/CommitteePreviousAgendasAdd";
	 }
	 
	 
	 
	 @RequestMapping(value = "CommitteePreviousAgendaAddSubmit.htm")
	 public String CommitteePreviousAgendaAddSubmit(HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir)
	 {
		String UserId =(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CommitteePreviousAgendaAddSubmit.htm "+UserId);		
		try {
			String scheduleidto=req.getParameter("scheduleidto");
			//String scheduleidfrom=req.getParameter("scheduleidfrom");
			String[] fromagendaids=req.getParameterValues("fromagendaid");
				
				
			long count=service.CommitteePreviousAgendaAdd(scheduleidto, fromagendaids, UserId);
			if (count > 0) {
				redir.addAttribute("result", "Agenda From Previous Meeting Added Successfull");
			} else {
				redir.addAttribute("resultfail", "Agenda From Previous Meeting Add Unsuccessfull");
			}			
				redir.addFlashAttribute("scheduleid",scheduleidto);				
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CommitteePreviousAgendaAddSubmit.htm "+UserId, e);
		}
		return "redirect:/CommitteeScheduleAgenda.htm";
	 }
	 
	 
	@RequestMapping(value = "NonProjectCommitteeAutoSchedule.htm")
	public String NonProjectCommitteeAutoSchedule(Model model,HttpServletRequest req,HttpServletResponse res,HttpSession ses,RedirectAttributes redir)
	{	
		String UserId =(String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode"); 
		logger.info(new Date() +"Inside NonProjectCommitteeAutoSchedule.htm "+UserId);		
		try {
			String fromdate=req.getParameter("fromdate");			
			String committeeid = req.getParameter("committeeid");
			String Dashboard="nondashboard";

			if(committeeid==null) {
				Map md=model.asMap();
				committeeid=(String)md.get("committeeid");
			}	
			
			
			Object[] committeedata= service.CommitteeDetails(committeeid);
	/*------------------------------------------------------------------------------------------*/		
			if(fromdate!=null)
			{
				String todate=req.getParameter("todate");
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
				LocalDate StartDate=LocalDate.parse(fromdate, formatter);
				LocalDate EndDate=LocalDate.parse(todate, formatter);
				long count=0;
		
				while(StartDate.isBefore(EndDate) )
				{	  	
						CommitteeScheduleDto committeescheduledto=new CommitteeScheduleDto(); 
						committeescheduledto.setCommitteeId(Long.parseLong(committeeid));
						committeescheduledto.setScheduleDate(req.getParameter("startdate"));
						committeescheduledto.setScheduleStartTime(req.getParameter("starttime"));
						committeescheduledto.setCreatedBy(UserId);
						committeescheduledto.setScheduleFlag("MSC");
						committeescheduledto.setProjectId("0");
						committeescheduledto.setConfidential("5");
						committeescheduledto.setDivisionId("0");
						committeescheduledto.setInitiationId("0");
						committeescheduledto.setLabCode(labcode);
						
						String formatteddate = StartDate.format(formatter);
						committeescheduledto.setScheduleDate(formatteddate);

						count=service.CommitteeScheduleAddSubmit(committeescheduledto);
						
						StartDate=StartDate.plusDays(Long.parseLong(committeedata[8].toString()));
						
						if(committeedata[7].toString().equalsIgnoreCase("N"))
						{
							break;	
						}						
				}
					if (count > 0) {
						req.setAttribute("result", "Auto Scheduling Successfully ");
					} else {
						req.setAttribute("resultfail", "Auto Scheduling Unsuccessful ");
					}	
			}
 /*------------------------------------------------------------------------------------------*/	
			if(req.getParameter("dashboardlink")!=null) {
				
				Dashboard=req.getParameter("dashboardlink");
			}

			req.setAttribute("committeeid", committeeid);
			req.setAttribute("committeelist", service.CommitteeMainList(labcode));
			req.setAttribute("dashboard", Dashboard);
			req.setAttribute("startdate",service.CommitteeLastScheduleDate(committeeid));
			req.setAttribute("CommitteeAutoScheduleList", service.CommitteeAutoScheduleList("0", committeeid,"0","0"));
			req.setAttribute("committeedata", committeedata);
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside NonProjectCommitteeAutoSchedule.htm "+UserId, e);
		}
		return "committee/CommitteeAutoScheduleNP";
	}
	
	@RequestMapping(value="DivisionCommitteeMaster.htm")
	public String DivisionCommitteeMaster( Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode"); 
		logger.info(new Date() +"Inside DivisionCommitteeMaster.htm "+UserId);
		try {
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();		
			String divisionid=req.getParameter("divisionid");
			if(divisionid==null)  {
				Map md=model.asMap();
				divisionid=(String)md.get("divisionid");
			}	
			
			List<Object[]> divisionlist=service.LoginDivisionList(EmpId);
			if(divisionlist.size()==0) {				
				redir.addAttribute("resultfail", " No Division is Assigned to You");
				return "redirect:/MainDashBoard.htm";
			}
			
			if(divisionid==null || divisionid.equals("null"))
			{
				divisionid=divisionlist.get(0)[0].toString();
			}			
			List<Object[]> CommitteedivisionAssigned=service.CommitteedivisionAssigned(divisionid);
		
			req.setAttribute("CommitteeFormationCheckList", service.DivisionCommitteeFormationCheckList(divisionid));
			req.setAttribute("divisionid",divisionid);
			req.setAttribute("initiationid","0");
			req.setAttribute("projectid","0");
			req.setAttribute("divisionlist",divisionlist);
			req.setAttribute("CommitteedivisionAssigned",CommitteedivisionAssigned);
			req.setAttribute("CommitteedivisionNotAssigned", service.CommitteedivisionNotAssigned(divisionid, LabCode ));
		}
			
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside DivisionCommitteeMaster.htm "+UserId,e);
			return "ststic/Error";
		}

		return "committee/CommitteeDivisionMaster";
	}
	
	@RequestMapping(value="DivisionCommitteeAdd.htm",method = RequestMethod.POST)
	public String DivisionCommitteeAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside DivisionCommitteeAdd.htm "+UserId);
		try {
			
			String divisionid=req.getParameter("divisionid");
			String[] Committee=req.getParameterValues("committeeid");
			
			long count=service.DivisionCommitteeAdd(divisionid,Committee,UserId);
			
			if (count > 0) {
				redir.addAttribute("result", " Committee Added Successfully");
				redir.addAttribute("divisionid",divisionid);
			} else {
				redir.addAttribute("result", " Committee Add Unsucessful");
			}
						
		}
		
		catch (Exception e) {
				e.printStackTrace(); 
			logger.error(new Date() +"Inside DivisionCommitteeAdd.htm "+UserId,e);
		}

		return "redirect:/DivisionCommitteeMaster.htm";
	}
	
	
	@RequestMapping(value="DivisionCommitteeDelete.htm",method = RequestMethod.POST)
	public String DivisionCommitteeDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside DivisionCommitteeDelete.htm "+UserId);
		try {
			String divisionid=req.getParameter("divisionid");
			if(req.getParameter("sub")!=null) {
				
				String Option=req.getParameter("sub");
				
				if(!Option.equalsIgnoreCase("remove")) 
				{
					redir.addFlashAttribute("initiationid",req.getParameter("initiationid"));
					redir.addFlashAttribute("divisionid",divisionid);
					redir.addFlashAttribute("projectid","0");
					redir.addFlashAttribute("committeeid",req.getParameter("sub"));
					return "redirect:/CommitteeMainMembers.htm";
					
				}
				else 
				{
					String[] committeedivisionids=req.getParameterValues("committeedivisionid");	
					
					long count=service.DivisionCommitteeDelete(committeedivisionids,UserId);					
					if (count > 0) {						
						redir.addAttribute("result", " Committee Removed Successfully");
						redir.addFlashAttribute("divisionid",divisionid);
					} else {
						redir.addAttribute("result", " Committee Removal Unsucessful");
					}					
				}				
			}						
		}
		
		catch (Exception e) {
				e.printStackTrace(); 
			logger.error(new Date() +"Inside DivisionCommitteeDelete.htm "+UserId,e);
		}
		return "redirect:/DivisionCommitteeMaster.htm";
	}
	
	
	
	
	@RequestMapping(value="DivisionBasedSchedule.htm")
	public String DivisionBasedSchedule(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{		
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside DivisionBasedSchedule.htm "+UserId);
		try {
			String divisionid=req.getParameter("divisionid");
			String committeeid=req.getParameter("committeeid");
			List<Object[]> divisiondetailslist=service.LoginDivisionList(EmpId);
			
			if(committeeid==null)
			{
				committeeid="all";
			}			
			
			if(divisiondetailslist.size()==0) {
				
				redir.addAttribute("resultfail", "No Division is Available .");

				return "redirect:/MainDashBoard.htm";
			}
			if(divisionid==null || divisionid.equals("null"))
			{
				divisionid=divisiondetailslist.get(0)[0].toString();
			}
			
			if(committeeid==null || committeeid.equals("all"))
			{				
				req.setAttribute("divisionchedulelist", service.DivisionScheduleListAll(divisionid));
			} 
			else 
			{
				req.setAttribute("committeedetails",service.CommitteeDetails(committeeid));
				req.setAttribute("divisionchedulelist",service.DivisionCommitteeScheduleList(divisionid, committeeid));				
			}
			
			List<Object[]> projapplicommitteelist=service.DivisionCommitteeMainList(divisionid);
			
			req.setAttribute("initiationid","0");
			req.setAttribute("divisionid",divisionid);
			req.setAttribute("committeeid",committeeid);
			req.setAttribute("Projectdetails",divisiondetailslist.get(0));
			req.setAttribute("divisionslist",divisiondetailslist);
			req.setAttribute("projapplicommitteelist",projapplicommitteelist);
		}
			
		catch (Exception e) {
				e.printStackTrace(); 
			logger.error(new Date() +"Inside DivisionBasedSchedule.htm "+UserId,e);
		}
		return "committee/CommitteeDivisionSchedule";
	}
	
	
	@RequestMapping(value="DivCommitteeAutoSchedule.htm",method = RequestMethod.POST)
	public String DivCommitteeAutoSchedule(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DivCommitteeAutoSchedule.htm "+UserId);
		try
		{			
			String projectid=req.getParameter("projectid");
			String divisionid=req.getParameter("divisionid");
			String initiationid=req.getParameter("initiationid");
			
			
			
			List<Object[]> masterlist = null;
			if(Long.parseLong(divisionid)>0)
			{
				masterlist = service.DivisionMasterList(divisionid);
			}
			
			if(Long.parseLong(initiationid)>0)
			{
				masterlist = service.InitiaitionMasterList(initiationid);
			}
			
			req.setAttribute("divisionmasterlist",masterlist );
			
			req.setAttribute("divisiondata",service.DivisionData(divisionid) );
			req.setAttribute("initiationdata",service.Initiationdetails(initiationid) );
			req.setAttribute("projectid",projectid );
			req.setAttribute("divisionid",divisionid );
			req.setAttribute("initiationid",initiationid );
			for(Object[] obj : masterlist ) {
				if(obj[6].toString().equalsIgnoreCase("N")) 
				{							
					return "committee/DivCommitteeAutoSchedule";
				}
			}
			
				redir.addAttribute("projectid",projectid);
				redir.addAttribute("divisionid",divisionid);
				redir.addAttribute("initiationid",initiationid);
				return "redirect:/CommitteeAutoScheduleList.htm";
			
		}catch(Exception e) {	    		
			logger.error(new Date() +" Inside DivCommitteeAutoSchedule.htm" +UserId, e);
			e.printStackTrace();
			return "static/Error";
		}	
	}
	
	
	@RequestMapping(value="DivCommitteeAutoScheduleSubmit.htm",method = RequestMethod.POST)
	public String DivCommitteeAutoScheduleSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode"); 
		logger.info(new Date() +"Inside DivCommitteeAutoScheduleSubmit.htm "+UserId);
		try
		{		
			long count=0;
			long count1=0;
			String projectid=req.getParameter("projectid");
			String divisionid=req.getParameter("divisionid");
			String initiationid=req.getParameter("initiationid");
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
			LocalDate StartDate1=LocalDate.parse(req.getParameter("startdate"), formatter);
			LocalDate EndDate=LocalDate.parse(req.getParameter("enddate"),formatter);
			List<Object[]> masterlist= new ArrayList<Object[]>();
			if(Long.parseLong(divisionid)>0) {
				masterlist= service.DivisionMasterList(divisionid);
			}else if(Long.parseLong(initiationid)>0)
			{
				masterlist= service.InitiationMasterList(initiationid);
			}
			for(int i=0;i<masterlist.size();i++) {
				LocalDate StartDate=StartDate1;
				if(masterlist.get(i)[6].toString().equalsIgnoreCase("N")) {
					String CommitteeId=masterlist.get(i)[2].toString();
					String PeriodicDuration=masterlist.get(i)[5].toString();
					if(Long.parseLong(PeriodicDuration)>0) 
					{					
						while (StartDate.isBefore(EndDate) ) /* || StartDate.isBefore(EndDate) */
						{
							CommitteeScheduleDto committeescheduledto=new CommitteeScheduleDto(); 
							committeescheduledto.setCommitteeId(Long.parseLong(CommitteeId));
							committeescheduledto.setScheduleDate(req.getParameter("startdate"));
							committeescheduledto.setScheduleStartTime(req.getParameter("starttime"));
							committeescheduledto.setCreatedBy(UserId);
							committeescheduledto.setScheduleFlag("MSC");
							committeescheduledto.setProjectId(projectid);
							committeescheduledto.setConfidential("5");
							committeescheduledto.setDivisionId(divisionid);
							committeescheduledto.setInitiationId(initiationid);
							String formattedString2 = StartDate.format(formatter);
							committeescheduledto.setScheduleDate(formattedString2);
							committeescheduledto.setLabCode(labcode);
							count=service.CommitteeScheduleAddSubmit(committeescheduledto);
							
							if(Long.parseLong(divisionid)>0) {
								count1=service.CommitteeDivisionUpdate(divisionid,CommitteeId);
							}else if(Long.parseLong(initiationid)>0)
							{
								count1=service.CommitteeInitiationUpdate(initiationid,CommitteeId);
							}							
							StartDate=StartDate.plusDays(Long.parseLong(PeriodicDuration));
						}
					}
					
					if(Long.parseLong(PeriodicDuration)==0) {
						
						CommitteeScheduleDto committeescheduledto=new CommitteeScheduleDto(); 
						committeescheduledto.setCommitteeId(Long.parseLong(CommitteeId));
						committeescheduledto.setScheduleDate(req.getParameter("startdate"));
						committeescheduledto.setScheduleStartTime(req.getParameter("starttime"));
						committeescheduledto.setCreatedBy(UserId);
						committeescheduledto.setScheduleFlag("MSC");
						committeescheduledto.setProjectId(projectid);
						committeescheduledto.setScheduleDate(req.getParameter("startdate"));
						committeescheduledto.setConfidential("5");
						committeescheduledto.setDivisionId(divisionid);
						committeescheduledto.setInitiationId(initiationid);
						committeescheduledto.setLabCode(labcode);
						count=service.CommitteeScheduleAddSubmit(committeescheduledto);
						if(Long.parseLong(divisionid)>0) {
							count1=service.CommitteeDivisionUpdate(divisionid,CommitteeId);
						}else if(Long.parseLong(initiationid)>0)
						{
							count1=service.CommitteeInitiationUpdate(initiationid,CommitteeId);
						}
					}
					
					if (count > 0) {
						redir.addAttribute("result", "Committee Auto-Scheduled Successfully");
					} else {
						redir.addAttribute("result", " Committee Auto-Schedule Unsucessful");
					}			
				}		
		}
			
			
			redir.addAttribute("initiationid",initiationid);
			redir.addAttribute("projectid", projectid);
			redir.addAttribute("divisionid", divisionid);
			return "redirect:/CommitteeAutoScheduleList.htm";
		}catch(Exception e) {	    		
			logger.error(new Date() +" Inside DivCommitteeAutoScheduleSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}	
		
	}
	
	
	
	@RequestMapping(value="InitiationCommitteeMaster.htm")
	public String InitiationCommitteeMaster( Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode"); 
		logger.info(new Date() +"Inside InitiationCommitteeMaster.htm "+UserId);
		try {
			String initiationid=req.getParameter("initiationid");
		
			List<Object[]> projectdetailslist=service.InitiatedProjectDetailsList();
			if(projectdetailslist.size()==0) {		
				redir.addAttribute("resultfail", "No Project is Initiated.");
				return "redirect:/MainDashBoard.htm";
			}
			if(initiationid==null || initiationid.equals("null"))
			{
				initiationid=projectdetailslist.get(0)[0].toString();
			}	
			System.out.println(initiationid+"-----");
			List<Object[]> projectmasterlist=service.InitiationMasterList(initiationid);
			req.setAttribute("ProjectCommitteeFormationCheckList", service.InitiationCommitteeFormationCheckList(initiationid));
			req.setAttribute("initiationid",initiationid);
			req.setAttribute("projectid","0");
			req.setAttribute("divisionid","0");
			req.setAttribute("Projectdetails",projectdetailslist.get(0));
			req.setAttribute("ProjectsList",projectdetailslist);
			req.setAttribute("projectmasterlist",projectmasterlist);
			req.setAttribute("committeelist", service.InitiationCommitteesListNotAdded(initiationid,LabCode));
			return "committee/CommitteeInitiationMaster";
		}
		catch (Exception e) {
				e.printStackTrace(); 
			logger.error(new Date() +"Inside InitiationCommitteeMaster.htm "+UserId,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="InvitationSerialNoUpdate.htm",method=RequestMethod.POST)
	public String InvitationSerialNoUpdate(HttpServletRequest req,HttpServletResponse res, RedirectAttributes redir, HttpSession ses)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside InvitationSerialNoUpdate.htm "+UserId);
			try
			{
				String committeescheduleid = req.getParameter("scheduleid");
				
				String[] newslno=req.getParameterValues("newslno");
				String[] invitationid=req.getParameterValues("invitationid");
		
				Set<String> s = new HashSet<String>(Arrays.asList(newslno));
				
				if (s.size() == newslno.length) 
				{
					service.InvitationSerialnoUpdate(newslno, invitationid);
					redir.addAttribute("result", "Serial No Updated Successfully");
					
				} else {
					redir.addAttribute("resultfail", "Agenda Priority Updated UnSuccessfull");
					
				}	
								
				redir.addAttribute("committeescheduleid", committeescheduleid);
				return "redirect:/CommitteeAttendance.htm";
			}
			catch (Exception e)
			{
				e.printStackTrace(); 
				logger.error(new Date() +"Inside InvitationSerialNoUpdate.htm "+UserId,e);
				return "static/Error";
			}
	}
	
	
	 @RequestMapping(value = "CommitteeMemberRepDelete.htm", method = RequestMethod.GET)
	  public @ResponseBody String CommitteeMemberRepDelete(HttpSession ses, HttpServletRequest req) throws Exception 
	  {
		String UserId=(String)ses.getAttribute("Username");
		int ret= 0;
		logger.info(new Date() +"Inside CommitteeMemberRepDelete.htm "+UserId);
		try
		{	  
			String memberrepid=req.getParameter("memrepid");
			ret=service.CommitteeMemberRepDelete(memberrepid);
		}
		catch (Exception e) {
				e.printStackTrace(); logger.error(new Date() +"Inside CommitteeMemberRepDelete.htm "+UserId,e);
		}
		  Gson json = new Gson();
		  return json.toJson(ret); 
		  
	}
	
	 @RequestMapping(value = "CommitteeRepNotAddedList.htm", method = RequestMethod.GET)
		public @ResponseBody String CommitteeRepNotAddedList(HttpServletRequest req,HttpSession ses) throws Exception {

			String UserId = (String)ses.getAttribute("Username");
			logger.info(new Date() +" Inside CommitteeRepNotAddedList.htm"+ UserId);		
			List<Object[]> CommitteeRepNotAddedList = service.CommitteeRepNotAddedList(req.getParameter("committeemainid"));
			Gson json = new Gson();
			return json.toJson(CommitteeRepNotAddedList);	
		}
		
	 @RequestMapping(value="InitiationCommitteeAdd.htm",method = RequestMethod.POST)
		public String InitiationCommitteeAdd(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
			
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside InitiationCommitteeAdd.htm "+UserId);
			try {
				
				String ProjectId=req.getParameter("projectid");
				String initiationid=req.getParameter("initiationid");
				String[] Committee=req.getParameterValues("committeeid");
				
				long count=service.InitiationCommitteeAdd(initiationid,Committee,UserId);
				
				if (count > 0) {
					redir.addAttribute("result", " Committee Added Successfully");					
				} else {
					redir.addAttribute("result", " Committee Add Unsucessful");
				}							
				redir.addAttribute("projectid",ProjectId);
				redir.addAttribute("initiationid",initiationid);
				return "redirect:/InitiationCommitteeMaster.htm";
			}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside InitiationCommitteeAdd.htm "+UserId,e);
				return "static/Error";
			}
		}
	 
		@RequestMapping(value="InitiationCommitteeDelete.htm",method = RequestMethod.POST)
		public String InitiationCommitteeDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception{
			
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside InitiationCommitteeDelete.htm "+UserId);
			try {
				String initiationid=req.getParameter("initiationid");
				if(req.getParameter("sub")!=null) {
					
					String Option=req.getParameter("sub");					
					if(!Option.equalsIgnoreCase("remove")) 
					{
						redir.addFlashAttribute("projectid","0");
						redir.addFlashAttribute("divisionid","0");
						redir.addFlashAttribute("initiationid",initiationid);						
						redir.addFlashAttribute("committeeid",req.getParameter("sub"));
						return "redirect:/CommitteeMainMembers.htm";
					}
					else {
						String[] CommitteeProject=req.getParameterValues("committeeprojectid");	
						
						long count=service.InitiationCommitteeDelete(CommitteeProject,UserId);					
						if (count > 0) {						
							redir.addAttribute("result", " Committee Removed Successfully");
							
						} else {
							redir.addAttribute("result", " Committee Remove Unsucessful");
						}					
					}
				}
				System.out.println(initiationid+"************");
				redir.addAttribute("projectid","0");
				redir.addAttribute("initiationid",initiationid);
				return "redirect:/InitiationCommitteeMaster.htm";
			}
			catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside InitiationCommitteeDelete.htm "+UserId,e);
				return "static/Error";
			}
			
		}
		
		@RequestMapping(value="InitiationBasedSchedule.htm")
		public String InitiationBasedSchedule(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{		
			
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside InitiationBasedSchedule.htm "+UserId);
			try {				
				String initiationid=req.getParameter("initiationid");
				String committeeid=req.getParameter("committeeid");
				List<Object[]> InitiatedProjectDetailsList=service.InitiatedProjectDetailsList();
				
				if(committeeid==null)
				{
					committeeid="all";
				}			
				
				if(InitiatedProjectDetailsList.size()==0) {
					
					redir.addAttribute("resultfail", "No Project Initiation Available .");

					return "redirect:/MainDashBoard.htm";
				}
				if(initiationid==null || initiationid.equals("null"))
				{
					initiationid=InitiatedProjectDetailsList.get(0)[0].toString();
				}
				if(committeeid==null || committeeid.equals("all"))
				{				
					req.setAttribute("divisionchedulelist", service.InitiationScheduleListAll(initiationid));
				} 
				else 
				{
					req.setAttribute("committeedetails",service.CommitteeDetails(committeeid));
					req.setAttribute("divisionchedulelist",service.InitiationCommitteeScheduleList(initiationid, committeeid));				
				}
				
				List<Object[]> initiationcommitteemainlist=service.InitiationCommitteeMainList(initiationid);				
				req.setAttribute("initiationid",initiationid );
				req.setAttribute("divisionid","0");
				req.setAttribute("committeeid",committeeid);
				req.setAttribute("Projectdetails",InitiatedProjectDetailsList.get(0));
				req.setAttribute("divisionslist",InitiatedProjectDetailsList);
				req.setAttribute("projapplicommitteelist",initiationcommitteemainlist);
			}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside InitiationBasedSchedule.htm "+UserId,e);
				return "static/Error";
			}
			return "committee/CommitteeInitiationSchedule";
		}
		
		@RequestMapping(value="CommitteeMainApproval.htm")
		public String CommitteeMainApproval(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{	
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside CommitteeMainApproval.htm "+UserId);
			try 
			{
				String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
				String LabId =(String)ses.getAttribute("labid"); 
				String redirect=req.getParameter("redirect");
				String operation=req.getParameter("operation");
				String committeemainid=req.getParameter("committeemainid");
				String remark=req.getParameter("remarks");
				String approvalauthority=req.getParameter("approvalauthority");
				long ret=0;
				CommitteeConstitutionApprovalDto approvaldto = new CommitteeConstitutionApprovalDto(); 
				approvaldto.setCommitteeMainId(committeemainid);
				approvaldto.setRemarks(remark);
				approvaldto.setActionBy(UserId);
				approvaldto.setEmpid(EmpId);
				approvaldto.setEmpLabid(LabId);
				approvaldto.setApprovalAuthority(approvalauthority);
				approvaldto.setConstitutionStatus(req.getParameter("newconstitutionstatus"));
				approvaldto.setOperation(operation);
				
				ret=service.CommitteeMainApprove(approvaldto);
				if(ret==-1)
				{
					redir.addAttribute("resultfail", "Approval Authority Data Not Found");			
					redir.addFlashAttribute("committeemainid",committeemainid);
					return "redirect:/ComConstitutionApprovalDetails.htm";
				}
											
				if (ret > 0) {						
					redir.addAttribute("result", " Committee "+operation+" Successfully");					
				} else {
					redir.addAttribute("resultfail", " Committee "+operation+" Unsucessful");
				}		
				if(redirect!=null && redirect.equals("1"))
				{
					if (ret > 0) 
					{						
						redir.addAttribute("result", " Committee Forwarded Successfully");					
					} else {
						redir.addAttribute("resultfail", " Committee Forwarding Unsucessful");
					}		
					redir.addFlashAttribute("committeemainid",committeemainid);
					return "redirect:/CommitteeMainMembers.htm";					
				}
				
				return "redirect:/CommitteeMainApprovalList.htm";
			}			
			catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeMainApproval.htm "+UserId,e);
				return "static/Error";
			}
		}
		
		@RequestMapping(value="CommitteeMainApprovalList.htm")
		public String CommitteeMainApprovalList(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{	
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside CommitteeMainApprovalList.htm "+UserId);
			try 
			{
				String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
				String LabId =(String)ses.getAttribute("labid"); 
				String loginid= ses.getAttribute("LoginId").toString();
				req.setAttribute("approvallist", service.ProposedCommitteesApprovalList(loginid,EmpId));
				return "committee/ComConstitutionApprovalList";
			}
			catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeMainApprovalList.htm "+UserId,e);
				return "static/Error";
			}
		}
		

		
		@RequestMapping(value="ComConstitutionApprovalDetails.htm")
		public String ComConstitutionApprovalDetails(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside ComConstitutionApprovalDetails.htm "+UserId);
			try 
			{
				String committeemainid=req.getParameter("committeemainid");		
				if(committeemainid==null) 
				{
					Map md=model.asMap();
					committeemainid=(String)md.get("committeemainid");
				}	
				String initiationid=null;
				String CommitteeId=null;
				String projectid=null;
				String divisionid=null;
				Object[] committeedata=service.CommitteMainData(committeemainid);	
				
								
				CommitteeId=committeedata[1].toString();
				projectid=committeedata[2].toString();
				divisionid=committeedata[3].toString();
				initiationid=committeedata[4].toString();
				
				committeemainid=committeedata[0].toString();	
				Object[] proposedcommitteemainid =  service.ProposedCommitteeMainId(committeemainid);
				
				req.setAttribute("committeemembersall",service.CommitteeAllMembersList(committeemainid));
				req.setAttribute("committeeMemberreplist", service.CommitteeMemberRepList(committeemainid));
				req.setAttribute("committeedata", committeedata);			
				req.setAttribute("divisionid", divisionid);
				req.setAttribute("proposedcommitteemainid",proposedcommitteemainid );
				req.setAttribute("committeeapprovaldata",service.CommitteeMainApprovalData(committeemainid));
				req.setAttribute("approvalstatuslist",service.ApprovalStatusList(committeemainid) );
				req.setAttribute("constitutionapprovalflow", service.ConstitutionApprovalFlow(committeemainid));
				
				if( Long.parseLong(projectid)>0) {
					req.setAttribute("projectdata", service.projectdetails(projectid));
				}
				if( Long.parseLong(divisionid)>0) {
					req.setAttribute("divisiondata", service.DivisionData(divisionid) );
				}
				if(Long.parseLong(initiationid)>0) {
					req.setAttribute("initiationdata", service.Initiationdetails(initiationid) );
				}
				
				return "committee/ComConstitutionApprovalDetails";
			}
			catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside ComConstitutionApprovalDetails.htm "+UserId,e);
				return "static/Error";
			}
		}
		
		@RequestMapping(value="ComConstitutionApprovalHistory.htm")
		public String ComConstitutionApprovalHistory(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside ComConstitutionApprovalHistory.htm "+UserId);
			try 
			{
				String committeemainid=req.getParameter("committeemainid");		
				if(committeemainid==null) {
					Map md=model.asMap();
					committeemainid=(String)md.get("committeemainid");
				}	
				
				Object[] committeedata=service.CommitteMainData(committeemainid);	
				String CommitteeId=committeedata[1].toString();
				String projectid=committeedata[2].toString();
				String divisionid=committeedata[3].toString();
				String initiationid=committeedata[4].toString();
				
				
				
				if( Long.parseLong(projectid)>0) {
					req.setAttribute("projectdata", service.projectdetails(projectid));
				}
				if( Long.parseLong(divisionid)>0) {
					req.setAttribute("divisiondata", service.DivisionData(divisionid) );
				}
				if(Long.parseLong(initiationid)>0) {
					req.setAttribute("initiationdata", service.Initiationdetails(initiationid) );
				}
				req.setAttribute("committeedata", committeedata);	
				req.setAttribute("historydata",service.ComConstitutionApprovalHistory(committeemainid) );
				return "committee/ComConApprovalTracking";					
			}
			catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside ComConstitutionApprovalHistory.htm "+UserId,e);
				return "static/Error";
			}
		}
		
		
		@RequestMapping(value="CommitteeScheduleDelete.htm")
		public String CommitteeScheduleDelete(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId=(String)ses.getAttribute("Username");
			logger.info(new Date() +"Inside CommitteeScheduleDelete.htm "+UserId);
			try 
			{
				String scheduleid=req.getParameter("scheduleid");
				CommitteeScheduleDto dto=new CommitteeScheduleDto();
				dto.setScheduleId(Long.parseLong(scheduleid));
				dto.setModifiedBy(UserId);
				Object[] scheduledata=service.CommitteeScheduleEditData(scheduleid);
				String projectid= scheduledata[9].toString();
				String divisionid= scheduledata[16].toString();
				String initiationid= scheduledata[17].toString();
				
				
				
				int count=service.CommitteeScheduleDelete(dto);
				
				if (count > 0) 
				{						
					redir.addAttribute("result", " Meeting Schedule Deleted  Successfully");					
				} 
				else 
				{
					redir.addAttribute("resultfail", " Meeting Delete Unsucessful");
				}		
				
				if(Long.parseLong(projectid)>0 )
				{
					return "redirect:/ProjectBasedSchedule.htm" ;
				}
				else if( Long.parseLong(divisionid)>0)
				{
					return "redirect:/DivisionBasedSchedule.htm" ;
				}
				else if( Long.parseLong(initiationid)>0)
				{
					return "redirect:/InitiationBasedSchedule.htm" ;
				}
				else 
				{
					return "redirect:/CommitteeScheduleList.htm" ;
				}
			
			}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeScheduleDelete.htm "+UserId,e);
				return "static/Error";
			}
		}
		

			@RequestMapping(value="CommitteeMinutesNewDownload.htm", method = {RequestMethod.POST,RequestMethod.GET})
			public void CommitteeMinutesNewDownload(HttpServletRequest req,HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception
			{
				String UserId=(String)ses.getAttribute("Username");
				String LabCode =(String) ses.getAttribute("labcode");
				logger.info(new Date() +"Inside CommitteeMinutesNewDownload.htm "+UserId);
				try
				{		
					String committeescheduleid = req.getParameter("committeescheduleid");			
					Object[] committeescheduleeditdata=service.CommitteeScheduleEditData(committeescheduleid);
					String projectid= committeescheduleeditdata[9].toString();
					String committeeid=committeescheduleeditdata[0].toString();
					if(Long.parseLong(projectid) >0 && committeescheduleeditdata[22].toString().equals("Y")) 
					{
						CommitteeMeetingDPFMFrozen dpfm = service.getFrozenDPFMMinutes(committeescheduleid);
						//CommitteeProjectBriefingFrozen CPF=service.getFrozenCommitteeMOM(committeescheduleid);
						
					
					
						 res.setContentType("application/pdf"); res.setHeader("Content-Disposition",
						  "inline; name="+ dpfm.getDPFMFileName()+".pdf; filename"+
						 dpfm.getDPFMFileName()); File f=new File(uploadpath+dpfm.getFrozenDPFMPath()
						  +dpfm.getDPFMFileName());
						 
						  OutputStream out = res.getOutputStream(); 
						  FileInputStream in = new FileInputStream(f); 
						  byte[] buffer = new byte[4096]; 
						  int length; 
						  while((length = in.read(buffer)) > 0) 
						  { 
							  out.write(buffer, 0, length);
							  }
						  in.close(); 
						  out.close();
						
						// newly updated by sankha 12-10
						/*
						 * res.setContentType("application/pdf"); res.setHeader("Content-Disposition",
						 * "inline; name="+ CPF.getMoM()+".pdf; filename"+ CPF.getMoM()); File f=new
						 * File(uploadpath+CPF.getFrozenBriefingPath() +CPF.getMoM()); OutputStream out
						 * = res.getOutputStream(); FileInputStream in = new FileInputStream(f); byte[]
						 * buffer = new byte[4096]; int length; while ((length = in.read(buffer)) > 0) {
						 * out.write(buffer, 0, length); } in.close(); out.close();
						 */
						
					}
					else 
					{
		
						Object[] projectdetails = null;
						
						if(projectid!=null && Integer.parseInt(projectid)>0)
						{
						projectdetails = service.projectdetails(projectid);
							req.setAttribute("projectdetails", projectdetails);
						}
						String divisionid= committeescheduleeditdata[16].toString();
						if(divisionid!=null && Integer.parseInt(divisionid)>0)
						{
							req.setAttribute("divisiondetails", service.DivisionData(divisionid));
						}
						String initiationid= committeescheduleeditdata[17].toString();
						if(initiationid!=null && Integer.parseInt(initiationid)>0)
						{
							req.setAttribute("initiationdetails", service.Initiationdetails(initiationid));
						}
						
						Committee committee = printservice.getCommitteeData(committeeid);
						
						HashMap< String, ArrayList<Object[]>> actionsdata=new LinkedHashMap<String, ArrayList<Object[]>>();
						long lastid=service.getLastPmrcId(projectid, committeeid, committeescheduleid);
						
						//****************************envi download start**********************************
			    		List<Object[]> envisagedDemandlist  = new ArrayList<Object[]>();
			    		envisagedDemandlist=service.getEnvisagedDemandList(projectid);
			    		req.setAttribute("envisagedDemandlist", envisagedDemandlist);
						
						req.setAttribute("committeeminutesspeclist",service.CommitteeScheduleMinutes(committeescheduleid) );
						req.setAttribute("committeescheduleeditdata", committeescheduleeditdata);
						req.setAttribute("committeeminutes",service.CommitteeMinutesSpecNew());
						req.setAttribute("committeeinvitedlist", service.CommitteeAtendance(committeescheduleid));			
						req.setAttribute("labdetails", service.LabDetails(committeescheduleeditdata[24].toString()));
						req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(committeescheduleeditdata[24].toString()));
						req.setAttribute("meetingcount",service.MeetingNo(committeescheduleeditdata));
					//	req.setAttribute("milestonedatalevel6", printservice.BreifingMilestoneDetails(projectid,committee.getCommitteeShortName().trim()));
						req.setAttribute("milestonedatalevel6", printservice.BreifingMilestoneDetails(projectid,committeeid));
		
		//				req.setAttribute("committeeminutessub",service.CommitteeMinutesSub());
		//				req.setAttribute("CommitteeAgendaList", service.CommitteeAgendaList(committeescheduleid));
						String LevelId= "2";
			    		Object[] MileStoneLevelId = printservice.MileStoneLevelId(projectid,committeeid);
						if( MileStoneLevelId!= null) {
							LevelId= MileStoneLevelId[0].toString();
						}
						req.setAttribute("levelid", LevelId);
						req.setAttribute("labInfo", service.LabDetailes(LabCode));
					/*---------------------------------------------------------------------------------------------------------------*/
		//				if(Long.parseLong(projectid) >0 && committeescheduleeditdata[22].toString().equals("N") ) {
							
							 final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectdetails[4].toString()+"&rupess="+10000000;
						 		HttpHeaders headers = new HttpHeaders();
						 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
						 		headers.set("labcode", LabCode);
						 		String jsonResult=null;
								try {
									HttpEntity<String> entity = new HttpEntity<String>(headers);
									ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
									jsonResult=response.getBody();						
								}catch(Exception e) {
									req.setAttribute("errorMsg", "errorMsg");
								}
								ObjectMapper mapper = new ObjectMapper();
								mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
								mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
								List<ProjectFinancialDetails> projectDetails=null;
								if(jsonResult!=null) {
									try {
										projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
										req.setAttribute("financialDetails",projectDetails);
									} catch (JsonProcessingException e) {
										e.printStackTrace();
									}
								}
				 	
								final String localUri2=uri+"/pfms_serv/getTotalDemand";
		
						 		String jsonResult2=null;
								try {
									HttpEntity<String> entity = new HttpEntity<String>(headers);
									ResponseEntity<String> response=restTemplate.exchange(localUri2, HttpMethod.POST, entity, String.class);
									jsonResult2=response.getBody();						
								}catch(Exception e) {
									req.setAttribute("errorMsg", "errorMsg");
								}
								ObjectMapper mapper2 = new ObjectMapper();
								mapper2.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
								mapper2.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
								List<TotalDemand> totaldemand=null;
								if(jsonResult2!=null) {
									try {
										totaldemand = mapper2.readValue(jsonResult2, new TypeReference<List<TotalDemand>>(){});
										req.setAttribute("TotalProcurementDetails",totaldemand);
									} catch (JsonProcessingException e) {
									e.printStackTrace();
								}
							}
		
						 	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(projectid);
						 	List<Object[]> procurementOnDemand=null;
						 	List<Object[]> procurementOnSanction=null;
			 	
						
						 	 if(procurementStatusList!=null){
						 		Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
						 		Collection<?> keys = map.keySet();
					 		for(Object key:keys){
						 		    if(key.toString().equals("D")) {
						 		    	procurementOnDemand=map.get(key);
						 		    }else if(key.toString().equals("S")) {
						 		    	procurementOnSanction=map.get(key);
						 		    }
						 		 }
						 	}
						 	List<Object[]> actionlist= service.MinutesViewAllActionList(committeescheduleid);
							
						 	for(Object obj[] : actionlist) {
									
								ArrayList<Object[]> values=new ArrayList<Object[]>();
								for(Object obj1[] : actionlist ) {
									if(obj1[0].equals(obj[0])) {
											values.add(obj1);
									}
								}
								if(!actionsdata.containsKey(obj[0].toString())) {
									actionsdata.put(obj[0].toString(), values);
								}
						} 
						
						 	req.setAttribute("lastpmrcactions", service.LastPMRCActions(lastid,committeeid,projectid,committeescheduleeditdata[22]+""));
//							req.setAttribute("actionlist",actionsdata);
						 	req.setAttribute("procurementOnDemand", procurementOnDemand);
						 	req.setAttribute("procurementOnSanction", procurementOnSanction);
						 	req.setAttribute("ActionPlanSixMonths", service.ActionPlanSixMonths(projectid));
						 	req.setAttribute("projectdatadetails", service.ProjectDataDetails(projectid));
						 	// new code
						 	List<Object[]>totalMileStones=service.totalProjectMilestones(projectid);//get all the milestones details based on projectid
						 	List<Object[]>first=null;   //store the milestones with levelid 1
						 	List<Object[]>second=null;	// store the milestones with levelid 2
						 	List<Object[]>three= null; // store the milestones with levelid 3
						 	Map<Integer,String> treeMapLevOne = new TreeMap<>();  // store the milestoneid with level id 1 and counts 
						 	Map<Integer,String>treeMapLevTwo= new TreeMap<>(); // store the milestonidid with level id 2 and counts
						 	Map<Integer,String>treeMapLevThree= new TreeMap<>();  // store the milestoneid with level id 3 and counts 
						 	 TreeSet<Integer> AllMilestones = new TreeSet<>();   // store the number of milestone in sorted order
						 	 if(!totalMileStones.isEmpty()) {
						 	 for(Object[]obj:totalMileStones){
						 	 AllMilestones.add(Integer.parseInt(obj[22].toString())); // getting the milestones from list
						 	 }
						 	 for(Integer mile:AllMilestones) {
						 	 int count=1;
						 	 first=totalMileStones.stream().
					 			   filter(i->i[26].toString().equalsIgnoreCase("1") && i[22].toString().equalsIgnoreCase(mile+""))
					 				.map(objectArray -> new Object[]{objectArray[0], objectArray[2]})
					 				.collect(Collectors.toList());
						 		for(Object[]obj:first) {
						 		treeMapLevOne.put(Integer.parseInt(obj[1].toString()),"A"+(count++));// to get the first level
						 		}
						 	}
						 	for (Map.Entry<Integer,String> entry : treeMapLevOne.entrySet()) {
						 		int count=1;
						 		second=totalMileStones.stream().
						 			   filter(i->i[26].toString().equalsIgnoreCase("2") && i[2].toString().equalsIgnoreCase(entry.getKey()+""))
						 			    .map(objectArray -> new Object[] {entry.getKey(),objectArray[3]})
						 			   .collect(Collectors.toList());
						 	for(Object[]obj:second) {
						 		treeMapLevTwo.put(Integer.parseInt(obj[1].toString()),entry.getValue()+"-B"+(count++));
						 	}
						 	}
						 	for(Map.Entry<Integer,String>entry: treeMapLevTwo.entrySet()) {
						 		int count=1;
						 		three=totalMileStones.stream().
						 				filter(i->i[26].toString().equalsIgnoreCase("3") && i[3].toString().equalsIgnoreCase(entry.getKey()+""))
						 				.map(objectArray -> new Object[] {entry.getKey(),objectArray[4]})
						 				.collect(Collectors.toList());
						 		for(Object[]obj:three) {
									treeMapLevThree.put(Integer.parseInt(obj[1].toString()), "C"+(count++)); 
						 			
						 		}
						 	}
						 	 }
									 	 req.setAttribute("treeMapLevOne", treeMapLevOne);
									 	 req.setAttribute("treeMapLevTwo", treeMapLevTwo);
									 	 // new code end
					//code on 06-10-2023				 	 
									 	List<List<Object[]>> ReviewMeetingList = new ArrayList<List<Object[]>>();
								    	List<List<Object[]>> ReviewMeetingListPMRC = new ArrayList<List<Object[]>>();
								    	ReviewMeetingList.add(printservice.ReviewMeetingList(projectid, "EB"));
							    		ReviewMeetingListPMRC.add(printservice.ReviewMeetingList(projectid, "PMRC")); 
							    		Map<Integer,String> mappmrc = new HashMap<>();
							    		Map<Integer,String> mapEB = new HashMap<>();
							    		int pmrccount=0;
							     		for (Object []obj:ReviewMeetingListPMRC.get(0)) {
							     			mappmrc.put(++pmrccount,obj[3].toString());
							     		}
							     	
							    		int ebcount=0;
							    	
							    		for (Object []obj:ReviewMeetingList.get(0)) {
							    		mapEB.put(++ebcount,obj[3].toString());
							    		}
							    		req.setAttribute("mappmrc", mappmrc);
								    	req.setAttribute("mapEB", mapEB);
								    	
								    	
									 	 //
									 	 String filename=committeescheduleeditdata[11].toString().replace("/", "-");
									 	 String path=req.getServletContext().getRealPath("/view/temp");
									 	 req.setAttribute("path",path);
									 	 CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
									 	 req.getRequestDispatcher("/view/committee/CommitteeMinutesNew.jsp").forward(req, customResponse);
									 	 String html = customResponse.getOutput();
									 	 HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
									 	 req.setAttribute("tableactionlist",  actionsdata);
									 	 CharArrayWriterResponse customResponse1 = new CharArrayWriterResponse(res);
									 	 req.getRequestDispatcher("/view/committee/ActionDetailsTable.jsp").forward(req, customResponse1);
									 	 String html1 = customResponse1.getOutput();        
									 	 HtmlConverter.convertToPdf(html1,new FileOutputStream(path+File.separator+filename+"1.pdf")); 
									 	 PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
									 	 PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
									 	 PdfReader pdf2=new PdfReader(path+File.separator+filename+"1.pdf");
								        
									     PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	       	        
									     PdfDocument pdfDocument2 = new PdfDocument(pdf2);
									     PdfMerger merger = new PdfMerger(pdfDocument);
						        
								        merger.merge(pdfDocument2, 1, pdfDocument2.getNumberOfPages());
								            
							            pdfDocument2.close();
								        pdfDocument.close();
								        merger.close();
								        pdf2.close();
								        pdf1.close();	       
								        pdfw.close();
									    
								        res.setContentType("application/pdf");
										res.setHeader("Content-Disposition", "inline; name="+ filename+".pdf; filename"+ filename+".pdf");
								        File f=new File(path +File.separator+ "merged.pdf");
						         
			
								        OutputStream out = res.getOutputStream();
										FileInputStream in = new FileInputStream(f);
										byte[] buffer = new byte[4096];
										int length;
									while ((length = in.read(buffer)) > 0) {
										out.write(buffer, 0, length);
									}
									in.close();
									out.close();
									
							        Path pathOfFile2= Paths.get( path+File.separator+filename+"1.pdf"); 
							        Files.delete(pathOfFile2);		
							        pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
							        Files.delete(pathOfFile2);	
							        pathOfFile2= Paths.get(path +File.separator+ "merged.pdf"); 
							        Files.delete(pathOfFile2);
						        
					}
				}
				catch (Exception e) 
				{
					e.printStackTrace(); 
					logger.error(new Date() +"Inside CommitteeMinutesNewDownload.htm "+UserId,e);
				}
				
				
			}
		
		
		@RequestMapping(value="EmployeeScheduleReports.htm", method = {RequestMethod.POST,RequestMethod.GET})
		public String EmployeeScheduleReports(Model model,HttpServletRequest req,HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId=(String)ses.getAttribute("Username");
			String Logintype= (String)ses.getAttribute("LoginType");
			logger.info(new Date() +"Inside EmployeeScheduleReports.htm "+UserId);
			try
			{
				String rtype=req.getParameter("rtype");
				String empid=req.getParameter("empid");
				if(empid==null)
				{
					empid = ((Long) ses.getAttribute("EmpId")).toString();
					rtype = "D";
				}				
				List<Object[]> employeeScheduleList=service.EmployeeScheduleReports(req,empid, rtype);
				List<Object[]> employeeList=service.EmployeeDropdown(empid, Logintype, "0");
				
				req.setAttribute("rtype", rtype);
				req.setAttribute("empid", empid);
				req.setAttribute("employeeList", employeeList);
				req.setAttribute("employeeScheduleList", employeeScheduleList);
				return "committee/EmployeeReports";
			}
			catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside EmployeeScheduleReports.htm "+UserId,e);
				return "static/Error";
			}
			
		
		}
		
		@RequestMapping(value="EmployeeScheduleReportDownload.htm", method = {RequestMethod.POST,RequestMethod.GET})
		public void EmployeeScheduleReportDownload(Model model,HttpServletRequest req,HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId=(String)ses.getAttribute("Username");
			String LabCode =(String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside EmployeeScheduleReportDownload.htm "+UserId);
			try
			{
				String rtype=req.getParameter("rtype");
				String empid=req.getParameter("empid");
				
				if(empid==null)
				{
					empid = ((Long) ses.getAttribute("EmpId")).toString();
					rtype = "D";
				}				
				List<Object[]> employeeScheduleList=service.EmployeeScheduleReports(req,empid, rtype);
				List<Object[]> employeeList=service.EmployeeList(LabCode);
				
								
				req.setAttribute("rtype", rtype);
				req.setAttribute("empid", empid);
				req.setAttribute("employeeList", employeeList);
				req.setAttribute("employeeScheduleList", employeeScheduleList);
				
				
				String filename="employeereport "+empid;
				String path=req.getServletContext().getRealPath("/view/temp");
				req.setAttribute("path",path);
				
				
			
		        
		        CharArrayWriterResponse customResponse1 = new CharArrayWriterResponse(res);
				req.getRequestDispatcher("/view/committee/EmployeeReportDownload.jsp").forward(req, customResponse1);
				String html1 = customResponse1.getOutput();        
		        
		        HtmlConverter.convertToPdf(html1,new FileOutputStream(path+File.separator+filename+".pdf")); 
		         
		        res.setContentType("application/pdf");
		        res.setHeader("Content-disposition","attachment;filename="+filename+".pdf");
		        File f=new File(path +File.separator+ filename+".pdf");
		         
		        
		        FileInputStream fis = new FileInputStream(f);
		        DataOutputStream os = new DataOutputStream(res.getOutputStream());
		        res.setHeader("Content-Length",String.valueOf(f.length()));
		        byte[] buffer = new byte[1024];
		        int len = 0;
		        while ((len = fis.read(buffer)) >= 0) {
		            os.write(buffer, 0, len);
		        } 
		        fis.close();
		        os.close();
		       
		       
		       
		        Path pathOfFile= Paths.get( path+File.separator+filename+".pdf"); 
		        Files.delete(pathOfFile);		
		        	
				
			}
			catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside EmployeeScheduleReportDownload.htm "+UserId,e);
			}
			
		
		}
	
		@RequestMapping(value = "AgendaDocLinkDownload.htm", method = RequestMethod.GET)
		public void AgendaDocLinkDownload(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
		{
			String UserId = (String) ses.getAttribute("Username");

			logger.info(new Date() +"Inside AgendaDocLinkDownload.htm "+UserId);
			
			try {	
				String filerepid=req.getParameter("filerepid");
                Object[] obj=service.AgendaDocLinkDownload(filerepid);
                String path=req.getServletContext().getRealPath("/view/temp");
                Zipper zip=new Zipper();
                zip.unpack(ApplicationFilesDrive+ obj[2].toString()+obj[3].toString()+obj[7].toString()+"-"+obj[6].toString()+".zip",path,obj[5].toString());
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
                fis.close();
                os.close();
                
                Path pathOfFile2= Paths.get(path+"/"+obj[4]); 
                Files.delete(pathOfFile2);

			}
			catch (Exception e) {
				
				e.printStackTrace();  
				logger.error(new Date() +" Inside AgendaDocLinkDownload.htm "+UserId, e); 
				
			}

		}
		
		
		@RequestMapping(value = "PreDefinedAgendas.htm")
		public String PreDefinedAgendas(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
		{
			String UserId = (String) ses.getAttribute("Username");
			String LabCode =(String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside PreDefinedAgendas.htm "+UserId);			
			try {	
				String committeeid=req.getParameter("committeeid");
				if(committeeid==null)
				{			
					Map md=model.asMap();
					committeeid=(String)md.get("committeeid");
				}
				
				List<Object[]> committeeslist = service.ProjectCommitteesList(LabCode);
				
				if(committeeslist.size()>0 &&  committeeid==null)
				{
					committeeid=committeeslist.get(0)[0].toString();
				}
				if(committeeid==null)
				{
					committeeid="0";
				}

				List<Object[]> DefAgendas =  service.DefaultAgendaList(committeeid,LabCode);
				
				req.setAttribute("DefAgendas", DefAgendas);
				req.setAttribute("committeeid", committeeid);
				req.setAttribute("committeeslist",committeeslist);
				
				return "committee/PreDefAgendas";
			}
			catch (Exception e) {
				
				e.printStackTrace();  
				logger.error(new Date() +" Inside PreDefinedAgendas.htm "+UserId, e); 
				return "static/Error";
			}

		}
		
		
		@RequestMapping(value = "PreDefinedAgendaEdit.htm", method = RequestMethod.POST)
		public String PreDefinedAgendaEdit(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res,RedirectAttributes redir)throws Exception 
		{
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside PreDefinedAgendaEdit.htm "+UserId);			
			try {	
				String committeeid=req.getParameter("committeeid");
				String agendaitem=req.getParameter("agendaitem");
				String remarks=req.getParameter("remarks");
				String duration=req.getParameter("duration");
				String agendaid=req.getParameter("agendaid");
				
				CommitteeDefaultAgenda agenda = new CommitteeDefaultAgenda();
				
				agenda.setDefaultAgendaId(Long.parseLong(agendaid));
				agenda.setDuration(Integer.parseInt(duration));
				agenda.setAgendaItem(agendaitem);
				agenda.setRemarks(remarks);
				agenda.setModifiedBy(UserId);
				
				int count = service.PreDefAgendaEdit(agenda);
				
				if(count > 0) 
				{						
					redir.addAttribute("result", " Agenda Updated Successfully");					
				} 
				else 
				{
					redir.addAttribute("resultfail", " Agenda Update Unsucessful");
				}		
				
				redir.addFlashAttribute("committeeid", committeeid);
				return "redirect:/PreDefinedAgendas.htm";
			}
			catch (Exception e) {
				
				e.printStackTrace();  
				logger.error(new Date() +" Inside PreDefinedAgendaEdit.htm "+UserId, e); 
				return "static/Error";
			}

		}
		
		@RequestMapping(value = "PreDefinedAgendaAdd.htm", method = RequestMethod.POST)
		public String PreDefinedAgendaAdd(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res,RedirectAttributes redir)throws Exception 
		{
			String UserId = (String) ses.getAttribute("Username");
			String LabCode =(String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside PreDefinedAgendaAdd.htm "+UserId);			
			try {	
				String committeeid=req.getParameter("committeeid");
				String agendaitem=req.getParameter("agendaitem");
				String remarks=req.getParameter("remarks");
				String duration=req.getParameter("duration");
				
				CommitteeDefaultAgenda agenda = new CommitteeDefaultAgenda();
				
				agenda.setLabCode(LabCode);
				agenda.setDuration(Integer.parseInt(duration));
				agenda.setAgendaItem(agendaitem);
				agenda.setRemarks(remarks);
				agenda.setCommitteeId(Long.parseLong(committeeid));
				agenda.setCreatedBy(UserId);
				
				long count = service.PreDefAgendaAdd(agenda);
				
				if(count > 0) 
				{						
					redir.addAttribute("result", " Agenda Added Successfully");					
				} 
				else 
				{
					redir.addAttribute("resultfail", " Agenda Adding Unsucessful");
				}		
				
				redir.addFlashAttribute("committeeid", committeeid);
				return "redirect:/PreDefinedAgendas.htm";
			}
			catch (Exception e) {				
				e.printStackTrace();  
				logger.error(new Date() +" Inside PreDefinedAgendaAdd.htm "+UserId, e); 
				return "static/Error";
			}

		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		@RequestMapping(value = "PreDefinedAgendaDelete.htm", method = RequestMethod.POST)
		public String PreDefinedAgendaDelete(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res,RedirectAttributes redir)throws Exception 
		{
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside PreDefinedAgendaDelete.htm "+UserId);			
			try {	
				String committeeid=req.getParameter("committeeid");
				String agendaid=req.getParameter("agendaid");
				
				int count = service.PreDefAgendaDelete(agendaid);
				
				if(count > 0) 
				{						
					redir.addAttribute("result", " Agenda Deleted Successfully");					
				} 
				else 
				{
					redir.addAttribute("resultfail", " Agenda Delete Unsucessful");
				}		
				
				redir.addFlashAttribute("committeeid", committeeid);
				return "redirect:/PreDefinedAgendas.htm";
			}
			catch (Exception e) {
				
				e.printStackTrace();  
				logger.error(new Date() +" Inside PreDefinedAgendaDelete.htm "+UserId, e); 
				return "static/Error";
			}

		}
		
		
		@RequestMapping(value = "getMinutesFrozen.htm")
		public String getMinutesFrozen(HttpServletRequest req, HttpSession ses,HttpServletResponse res,RedirectAttributes redir) throws Exception 
		{	
			String UserId = (String) ses.getAttribute("Username");
			long EmpId = (Long) ses.getAttribute("EmpId");
			String LabCode =(String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside getMinutesFrozen.htm "+UserId);		
		    try { 

				String committeescheduleid = req.getParameter("committeescheduleid");			
				Object[] committeescheduleeditdata=service.CommitteeScheduleEditData(committeescheduleid);
				String projectid= committeescheduleeditdata[9].toString();
				String committeeid=committeescheduleeditdata[0].toString();
				
				String IsFrozen=req.getParameter("IsFrozen");
				if(IsFrozen.equalsIgnoreCase("Y")) {
					
				int count=	service.MomFreezingUpdate(committeescheduleid);
				if(count > 0) 
				{				
					
					redir.addAttribute("result", "DPFM unfreezed Successfully");	
					redir.addFlashAttribute("committeescheduleid", committeescheduleid);
					return "redirect:/CommitteeScheduleMinutes.htm";
				} 
				}
				
				Object[] projectdetails = null;
				
				if(projectid!=null && Integer.parseInt(projectid)>0)
				{
				projectdetails = service.projectdetails(projectid);
					req.setAttribute("projectdetails", projectdetails);
				}
				String divisionid= committeescheduleeditdata[16].toString();
				if(divisionid!=null && Integer.parseInt(divisionid)>0)
				{
					req.setAttribute("divisiondetails", service.DivisionData(divisionid));
				}
				String initiationid= committeescheduleeditdata[17].toString();
				if(initiationid!=null && Integer.parseInt(initiationid)>0)
				{
					req.setAttribute("initiationdetails", service.Initiationdetails(initiationid));
				}
				
				Committee committee = printservice.getCommitteeData(committeeid);
				
				HashMap< String, ArrayList<Object[]>> actionsdata=new LinkedHashMap<String, ArrayList<Object[]>>();
				long lastid=service.getLastPmrcId(projectid, committeeid, committeescheduleid);
				
				req.setAttribute("committeeminutesspeclist",service.CommitteeScheduleMinutes(committeescheduleid) );
				req.setAttribute("committeescheduleeditdata", committeescheduleeditdata);
				req.setAttribute("committeeminutes",service.CommitteeMinutesSpecNew());
				req.setAttribute("committeeinvitedlist", service.CommitteeAtendance(committeescheduleid));			
				req.setAttribute("labdetails", service.LabDetails(committeescheduleeditdata[24].toString()));
				req.setAttribute("isprint", "Y");	
				req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(committeescheduleeditdata[24].toString()));
				req.setAttribute("meetingcount",service.MeetingNo(committeescheduleeditdata));
				req.setAttribute("milestonedatalevel6", printservice.BreifingMilestoneDetails(projectid,committeeid));

//				req.setAttribute("committeeminutessub",service.CommitteeMinutesSub());
//				req.setAttribute("CommitteeAgendaList", service.CommitteeAgendaList(committeescheduleid));
				String LevelId= "2";
	    		Object[] MileStoneLevelId = printservice.MileStoneLevelId(projectid,committeeid);
				if( MileStoneLevelId!= null) {
					LevelId= MileStoneLevelId[0].toString();
				}
				req.setAttribute("levelid", LevelId);
				req.setAttribute("labInfo", service.LabDetailes(LabCode));
			/*---------------------------------------------------------------------------------------------------------------*/
//				if(Long.parseLong(projectid) >0 && committeescheduleeditdata[22].toString().equals("N") ) {
					
					 final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectdetails[4].toString()+"&rupess="+10000000;
				 		HttpHeaders headers = new HttpHeaders();
				 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
				 		headers.set("labcode", LabCode);
				 		String jsonResult=null;
						try {
							HttpEntity<String> entity = new HttpEntity<String>(headers);
							ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
							jsonResult=response.getBody();						
						}catch(Exception e) {
							req.setAttribute("errorMsg", "errorMsg");
						}
						ObjectMapper mapper = new ObjectMapper();
						mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
						mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
						List<ProjectFinancialDetails> projectDetails=null;
						if(jsonResult!=null) {
							try {
								projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
							req.setAttribute("financialDetails",projectDetails);
							} catch (JsonProcessingException e) {
								e.printStackTrace();
							}
						}
		 	
						final String localUri2=uri+"/pfms_serv/getTotalDemand";

				 		String jsonResult2=null;
						try {
							HttpEntity<String> entity = new HttpEntity<String>(headers);
							ResponseEntity<String> response=restTemplate.exchange(localUri2, HttpMethod.POST, entity, String.class);
							jsonResult2=response.getBody();						
						}catch(Exception e) {
							req.setAttribute("errorMsg", "errorMsg");
						}
						ObjectMapper mapper2 = new ObjectMapper();
						mapper2.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
						mapper2.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
						List<TotalDemand> totaldemand=null;
						if(jsonResult2!=null) {
							try {
								totaldemand = mapper2.readValue(jsonResult2, new TypeReference<List<TotalDemand>>(){});
								req.setAttribute("TotalProcurementDetails",totaldemand);
							} catch (JsonProcessingException e) {
								e.printStackTrace();
							}
						}
	
					 	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(projectid);
					 	List<Object[]> procurementOnDemand=null;
					 	List<Object[]> procurementOnSanction=null;
		 	
					
					 	 if(procurementStatusList!=null){
					 		Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
					 		Collection<?> keys = map.keySet();
				 		for(Object key:keys){
					 		    if(key.toString().equals("D")) {
					 		    	procurementOnDemand=map.get(key);
					 		    }else if(key.toString().equals("S")) {
					 		    	procurementOnSanction=map.get(key);
					 		    }
					 		 }
					 	}
					 	List<Object[]> actionlist= service.MinutesViewAllActionList(committeescheduleid);
						
					 	for(Object obj[] : actionlist) {
								
							ArrayList<Object[]> values=new ArrayList<Object[]>();
							for(Object obj1[] : actionlist ) {
								if(obj1[0].equals(obj[0])) {
										values.add(obj1);
								}
							}
							if(!actionsdata.containsKey(obj[0].toString())) {
								actionsdata.put(obj[0].toString(), values);
							}
					} 
					
					 	req.setAttribute("lastpmrcactions", service.LastPMRCActions(lastid,committeeid,projectid,committeescheduleeditdata[22]+""));
						req.setAttribute("actionlist",actionsdata);
					 	req.setAttribute("procurementOnDemand", procurementOnDemand);
					 	req.setAttribute("procurementOnSanction", procurementOnSanction);
					 	req.setAttribute("ActionPlanSixMonths", service.ActionPlanSixMonths(projectid));
					 	
				
					 	
					 	//new code added
					 	List<Object[]>totalMileStones=service.totalProjectMilestones(projectid);
					 	List<Object[]>first=null;
					 	List<Object[]>second=null;
					 	Map<Integer,String> treeMapLevOne = new TreeMap<>();
					 	Map<Integer,String>treeMapLevTwo= new TreeMap<>();
					 	 TreeSet<Integer> AllMilestones = new TreeSet<>();
					 	 if(!totalMileStones.isEmpty()) {
					 	 for(Object[]obj:totalMileStones) {
					 	 AllMilestones.add(Integer.parseInt(obj[22].toString()));
					 	 }
					 	 for(Integer mile:AllMilestones) {
					 	 int count=1;
					 	 first=totalMileStones.stream().
				 			   filter(i->i[26].toString().equalsIgnoreCase("1") && i[22].toString().equalsIgnoreCase(mile+""))
				 				.map(objectArray -> new Object[]{objectArray[0], objectArray[2]})
				 					.collect(Collectors.toList());
					 		for(Object[]obj:first) {
					 		treeMapLevOne.put(Integer.parseInt(obj[1].toString()),"A"+(count++));// to get the first level
					 		}
					 	}
					 	for (Map.Entry<Integer,String> entry : treeMapLevOne.entrySet()) {
					 		int count=1;
					 		second=totalMileStones.stream().
					 			   filter(i->i[26].toString().equalsIgnoreCase("2") && i[2].toString().equalsIgnoreCase(entry.getKey()+""))
					 			    .map(objectArray -> new Object[] {entry.getKey(),objectArray[3]})
					 			   .collect(Collectors.toList());
					 	for(Object[]obj:second) {
					 		treeMapLevTwo.put(Integer.parseInt(obj[1].toString()),entry.getValue()+"-B"+(count++));
					 	}
					 	}
					 	 }
					 	 req.setAttribute("treeMapLevOne", treeMapLevOne);
					 	 req.setAttribute("treeMapLevTwo", treeMapLevTwo);
					 	
					 	// new code added end
//					 	req.setAttribute("milestonesubsystems", service.MilestoneSubsystems(projectid));
//				}
//				else if(committeescheduleeditdata[22].toString().equals("Y") ){
//					List<Object[]> procurementStatusList=(List<Object[]>)service.getMinutesProcure(committeescheduleid);
//				 	List<Object[]> procurementOnDemand=null;
//				 	List<Object[]> procurementOnSanction=null;
//		 						
//				 	 if(procurementStatusList!=null){
//				 		Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
//				 		Collection<?> keys = map.keySet();
//				 		for(Object key:keys){
//				 		    if(key.toString().equals("D")) {
//				 		    	procurementOnDemand=map.get(key);
//				 		    }else if(key.toString().equals("S")) {
//				 		    	procurementOnSanction=map.get(key);
//				 		    }
//				 		 }
//				 	}
//				 	 
//				 	req.setAttribute("lastpmrcactions", service.LastPMRCActions(Long.parseLong(committeescheduleid),committeeid,projectid,committeescheduleeditdata[22]+""));
//				 	req.setAttribute("financialDetails",service.getMinutesFinance(committeescheduleid));
////					req.setAttribute("milestonesubsystems", service.getMinutesSubMile(committeescheduleid));
//					req.setAttribute("ActionPlanSixMonths", service.getMinutesMile(committeescheduleid));
//					req.setAttribute("procurementOnDemand", procurementOnDemand);
//				 	req.setAttribute("procurementOnSanction", procurementOnSanction);
//				 	List<Object[]> actionlist= service.getMinutesAction(committeescheduleid);
//					
//					
//					for(Object obj[] : actionlist) {
//							
//							ArrayList<Object[]> values=new ArrayList<Object[]>(); 
//							for(Object obj1[] : actionlist ) {
//								if(obj1[0].equals(obj[0])) {
//									values.add(obj1);
//								}
//						}
//							if(!actionsdata.containsKey(obj[0].toString())) {
//								actionsdata.put(obj[0].toString(), values);
//							}
//					} 
//					req.setAttribute("actionlist",actionsdata);
//				}
			/*---------------------------------------------------------------------------------------------------------------*/			
							List<List<Object[]>> ReviewMeetingList = new ArrayList<List<Object[]>>();
					    	List<List<Object[]>> ReviewMeetingListPMRC = new ArrayList<List<Object[]>>();
					    	ReviewMeetingList.add(printservice.ReviewMeetingList(projectid, "EB"));
				    		ReviewMeetingListPMRC.add(printservice.ReviewMeetingList(projectid, "PMRC")); 
				    		Map<Integer,String> mappmrc = new HashMap<>();
				     		int pmrccount=0;
				     		for (Object []obj:ReviewMeetingListPMRC.get(0)) {
				     			mappmrc.put(++pmrccount,obj[3].toString());
				     		}
				     		for(Map.Entry<Integer, String>entry:mappmrc.entrySet()) {
				     			System.out.println("hiii");
				     			System.out.println(entry.getKey()+"-------"+entry.getValue());
				     		}
				    		int ebcount=0;
				    		Map<Integer,String> mapEB = new HashMap<>();
				    		for (Object []obj:ReviewMeetingList.get(0)) {
				    		mapEB.put(++ebcount,obj[3].toString());
				    		}
				    		req.setAttribute("mappmrc", mappmrc);
					    	req.setAttribute("mapEB", mapEB);
					 	 
					 	 
				String filename=committeescheduleeditdata[11].toString().replace("/", "-");
				String path=req.getServletContext().getRealPath("/view/temp");
				req.setAttribute("path",path);
				
				CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
				req.getRequestDispatcher("/view/committee/CommitteeMinutesNew.jsp").forward(req, customResponse);
				String html = customResponse.getOutput();
				
				HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
				req.setAttribute("tableactionlist",  actionsdata);
		        CharArrayWriterResponse customResponse1 = new CharArrayWriterResponse(res);
				req.getRequestDispatcher("/view/committee/ActionDetailsTable.jsp").forward(req, customResponse1);
				String html1 = customResponse1.getOutput();        
		        
		        HtmlConverter.convertToPdf(html1,new FileOutputStream(path+File.separator+filename+"1.pdf")); 
			         
			        
		        PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
		        PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
		        PdfReader pdf2=new PdfReader(path+File.separator+filename+"1.pdf");
		        
		        PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	       	        
		        PdfDocument pdfDocument2 = new PdfDocument(pdf2);
		        PdfMerger merger = new PdfMerger(pdfDocument);
			        
		        merger.merge(pdfDocument2, 1, pdfDocument2.getNumberOfPages());
		            
	            pdfDocument2.close();
		        pdfDocument.close();
		        merger.close();
		        pdf2.close();
		        pdf1.close();	       
		        pdfw.close();
			    
		        File dpfm_file=new File(path +File.separator+ "merged.pdf");
		        
		        	// new code by sankha on 12-10-2023
					/*
					 * CommitteeProjectBriefingFrozen briefing =
					 * CommitteeProjectBriefingFrozen.builder()
					 * .ScheduleId(Long.parseLong(committeescheduleid)) .FreezeByEmpId(EmpId)
					 * .momFile(dpfm_file) .LabCode(LabCode) .IsActive(1) .build();
					 * 
					 * long result=service.doMomFreezing(briefing);
					 */

					
					  CommitteeMeetingDPFMFrozen dpfm = CommitteeMeetingDPFMFrozen.builder()
					  .ScheduleId(Long.parseLong(committeescheduleid)) .FreezeByEmpId(EmpId)
					  .dpfmfile(dpfm_file) .MeetingId(committeescheduleeditdata[11].toString())
					 .LabCode(LabCode) .IsActive(1) .build(); 
					  long count  =service.FreezeDPFMMinutes(dpfm);
				if(count > 0) 
				{				
					service.updateMinutesFrozen(committeescheduleid);
					redir.addAttribute("result", "DPFM Frozen Successfully");					
				} 
				else 
				{
					redir.addAttribute("resultfail", "DPFM Freezing Unsucessful");
				}		
				Path pathOfFile2= Paths.get( path+File.separator+filename+"1.pdf"); 
			    Files.delete(pathOfFile2);		
			    pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
			    Files.delete(pathOfFile2);	
			    pathOfFile2= Paths.get(path +File.separator+ "merged.pdf"); 
			    Files.delete(pathOfFile2);
			        
				redir.addFlashAttribute("committeescheduleid", committeescheduleid);
				return "redirect:/CommitteeScheduleMinutes.htm"; 
		    }
		    catch(Exception e) {	    		
	    		logger.error(new Date() +" Inside getMinutesFrozen.htm "+UserId, e);
	    		e.printStackTrace();
	    		return "static/Error";
	    	}
			
		}
		
		
//		@RequestMapping(value = "getMinutesFrozen.htm", method = RequestMethod.POST)
//		public String getMinutesFrozen(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception 
//		{	
//			String UserId = (String) ses.getAttribute("Username");
//			logger.info(new Date() +"Inside getMinutesFrozen.htm "+UserId);		
//		    try { 
//		    	long result=0;
//		    	int ibasserviceon = 0;
//		    	String committeescheduleid = req.getParameter("committeescheduleid");
//		    	Object[] committeescheduleeditdata=service.CommitteeScheduleEditData(committeescheduleid);
//				String projectid= committeescheduleeditdata[9].toString();
//				String committeeid=committeescheduleeditdata[0].toString();
//		    	if(Long.parseLong(projectid) >0 ) {
//					
//		    			Object[] projectdetails = service.projectdetails(projectid);
//		    			
//		    		 	final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectdetails[4].toString()+"&rupess="+10000000;
//				 		HttpHeaders headers = new HttpHeaders();
//				 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
//				    	 
//				 		String jsonResult=null;
//						try {
//							HttpEntity<String> entity = new HttpEntity<String>(headers);
//							ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
//							jsonResult=response.getBody();						
//						}
//						catch(HttpClientErrorException  | ResourceAccessException e) 
//						{
//							e.printStackTrace();
//							ibasserviceon++;
//							redir.addAttribute("errorMsg", "Not Freezed as IBAS Server is not Responding !!");
//
//						}
//						catch(Exception e) {
//							
//							e.printStackTrace();
//							req.setAttribute("errorMsg", "errorMsg");
//						}
//						ObjectMapper mapper = new ObjectMapper();
//						mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
//						mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
//						List<ProjectFinancialDetails> projectDetails=null;
//						if(jsonResult!=null) {
//							try {
//								/*
//								 * projectDetails = mapper.readValue(jsonResult,
//								 * mapper.getTypeFactory().constructCollectionType(List.class,
//								 * ProjectFinancialDetails.class));
//								 */
//								projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
//							} catch (JsonProcessingException e) {
//								e.printStackTrace();
//							}
//						}
//				
//						
//				if(ibasserviceon==0) {
//					
//				if(projectDetails!=null) {
//
//				for (ProjectFinancialDetails finance:projectDetails) {
//					MinutesFinanceList fin=new MinutesFinanceList();
//					fin.setBudgetHeadDescription(finance.getBudgetHeadDescription());
//					fin.setCommiteeScheduleId(Long.parseLong(committeescheduleid));
//					fin.setBudgetHeadId(finance.getBudgetHeadId());
//					fin.setTotalSanction(finance.getTotalSanction());
//					fin.setReSanction(finance.getReSanction());
//					fin.setFeSanction(finance.getFeSanction());
//					fin.setReExpenditure(finance.getReExpenditure());
//					fin.setFeExpenditure(finance.getFeExpenditure());
//					fin.setReOutCommitment(finance.getReOutCommitment());
//					fin.setFeOutCommitment(finance.getFeOutCommitment());
//					fin.setReDipl(finance.getReDipl());
//					fin.setFeDipl(finance.getFeDipl());
//					fin.setReBalance(finance.getReBalance());
//					fin.setFeBalance(finance.getFeBalance());
//					fin.setProjectId(finance.getProjectId());
//					
//					
//					fin.setCreatedBy(UserId);		
//					result=service.insertMinutesFinance(fin);
//				}	
//				
//				}
//		    	
//		    	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(projectid);
//		    	for(Object[] obj:procurementStatusList) 
//		    	{
//			    	MinutesProcurementList procure=new MinutesProcurementList();
//			    	procure.setDemandDate(obj[3].toString());
//			    	procure.setCommiteeScheduleId(Long.parseLong(committeescheduleid));
//			    	procure.setDemandNo(obj[1].toString());
//			    	procure.setDpDate(obj[4]!=null? obj[4].toString() : null );
//			    	procure.setOrderNo(obj[2]!=null? obj[2].toString() : null );
//			    	procure.setEstimatedCost(Double.parseDouble(obj[5].toString()));
//			    	procure.setItemNomenclature(obj[8].toString());
//			    	procure.setOrderCost(Double.parseDouble(obj[6]!=null?obj[6].toString():"0.00"));
//			    	procure.setPftsFileId(Long.parseLong(obj[0].toString()));
//			    	procure.setPftsStageName(obj[10].toString());
//			    	procure.setPftsStatus(obj[9].toString());
//			    	procure.setRemarks(obj[11]!=null? obj[11].toString() : null );
//			    	procure.setVendorName(obj[12]!=null? obj[12].toString() : null );  
//			    	procure.setPftsStatusId(Long.parseLong(obj[13].toString()));
//			    	procure.setRevisedDp(obj[7]!=null? obj[7].toString() : null );
//			    	procure.setCreatedBy(UserId);	
//			    	result = service.insertMinutesProcurement(procure);
//		    	}
//		    	
//		    	long lastid=service.getLastPmrcId(projectid, committeeid, committeescheduleid);	
//		    	List<Object[]> actionlist= service.MinutesViewAllActionList(committeescheduleid);
//		    	if(actionlist.size()>0) {
//		    	for(Object[] obj:actionlist) {
//		    		MinutesActionList action=new MinutesActionList();
//
//		    		if(obj[9]!=null) 
//		    		{
//				    	action.setActionDate(obj[4]!=null? obj[4].toString() : null );
//				    	action.setActionFlag(obj[10]!=null? obj[10].toString() : null );
//				    	action.setActionItem(obj[8]!=null? obj[8].toString() : null );
//			    		action.setActionNo(obj[3]!=null? obj[3].toString() : null );
//			    		action.setActionStatus(obj[9]!=null? obj[9].toString() : null );
//			    		action.setAssignee(Long.parseLong(obj[7]+""));
//			    		action.setAssigneeDesig(obj[14]!=null? obj[14].toString() : null );
//			    		action.setAssigneeName(obj[13]!=null? obj[13].toString() : null );
//			    		action.setAssignerDesig(obj[12]!=null? obj[12].toString() : null );
//			    		action.setAssignor(Long.parseLong(obj[6]+""));
//			    		action.setAssignorName(obj[11]!=null? obj[11].toString() : null);
//			    		action.setEndDate(obj[5]!=null? obj[5].toString() : null);
//		    		
//		    		}
//		    		action.setDetails(obj[1]!=null? obj[1].toString() : null);
//		    		action.setIdrck(obj[2].toString());
//		    		action.setSchduleMinutesId(Long.parseLong(obj[0].toString()));
//		    		action.setCommiteeScheduleId(Long.parseLong(committeescheduleid));
//		    		action.setCreatedBy(UserId);	
//		    		result=service.insertMinutesAction(action);
//		    	 }	
//		    	}
//		    	List<Object[]> Milelist= service.MilestoneSubsystems(projectid);
//		    	for(Object[] obj:Milelist) {
//		    		MinutesSubMile submile=new MinutesSubMile();
//		    		submile.setActivityName(obj[2]!=null? obj[2].toString() : null);
//		    		submile.setActivityShort(obj[6]!=null? obj[6].toString() : null);
//		    		submile.setActivityStatusId(Long.parseLong(obj[5].toString()));
//		    		submile.setCommitteeScheduleId(Long.parseLong(committeescheduleid));
//		    		submile.setCreatedBy(UserId);
//		    		submile.setEndDate(obj[4]!=null? obj[4].toString() : null);
//		    		submile.setActivityId(Long.parseLong(obj[0].toString()));
//		    		submile.setMilestoneNo(obj[8]!=null? obj[8].toString() : null);
//		    		submile.setOrgEndDate(obj[3]!=null? obj[3].toString() : null);
//		    		submile.setParentActivityId(Long.parseLong(obj[1].toString()));
//		    		submile.setProgress(obj[7]!=null?Integer.parseInt(obj[7].toString()):0);
//		    		submile.setStatusRemarks(obj[9]!=null? obj[9].toString() : null);
//		    		result=service.insertMinutesSubMile(submile);
//		    	}
//		    	List<Object[]> actionsixlist= service.ActionPlanSixMonths(projectid);
//		    	for(Object[] obj:actionsixlist) {
//		    		MinutesMileActivity mile=MinutesMileActivity.builder()
//		    		.MinutesMileId(null)
//		    		.CommitteeScheduleId(Long.parseLong(committeescheduleid))
//		    		.MilestoneNo(Integer.parseInt(obj[0]+""))
//    				.MainId(Long.parseLong(obj[1]+""))
//    				.AId(Long.parseLong(obj[2]+""))
//    				.BId(Long.parseLong(obj[3]+""))
//    				.CId(Long.parseLong(obj[4]+""))
//    				.DId(Long.parseLong(obj[5]+""))
//    				.EId(Long.parseLong(obj[6]+""))
//    				.StartDate(obj[7]!=null? obj[7].toString() : null)
//    				.EndDate(obj[8]!=null? obj[8].toString() : null)
//    				.MileStoneMain(obj[9]!=null? obj[9].toString() : null)
//    				.MileStoneA(obj[10]!=null? obj[10].toString() : null)
//    				.MileStoneB(obj[11]!=null? obj[11].toString() : null)
//    				.MileStoneC(obj[12]!=null? obj[12].toString() : null)
//    				.MileStoneD(obj[13]!=null? obj[13].toString() : null)
//    				.MileStoneE(obj[14]!=null? obj[14].toString() : null)
//    				.ActivityType(obj[15]!=null? obj[15].toString() : null)
//    				.ProgressStatus(Integer.parseInt(obj[16]+""))
//    				.Weightage(Integer.parseInt(obj[17]+""))
//    				.DateOfCompletion(obj[18]!=null ? obj[18].toString() : null)
//    				.Activitystatus(obj[19]+"")
//    				.ActivitystatusId(Integer.parseInt(obj[20]+""))
//    				.RevisionNo(Integer.parseInt(obj[21]+""))
//    				.OicEmpId(Long.parseLong(obj[23]+""))
//    				.EmpName(obj[24]!=null? obj[24].toString() : null)
//    				.Designation(obj[25]!=null? obj[25].toString() : null)
//    				.LevelId(Integer.parseInt(obj[26]!=null? obj[26].toString() : null))
//    				.ActivityShort(obj[27]!=null? obj[27].toString() : null)
//    				.StatusRemarks( obj[28]!=null ? obj[28].toString() : null)
//    				.CreatedBy(UserId)
//    				.build();
//		    		
//		    		result=service.insertMinutesMileActivity(mile);		
//		    	}
//		    	
//		    	List<Object[]> lastpmrcactionlist= service.LastPMRCActions(lastid,committeeid,projectid,committeescheduleeditdata[22]+"");
//		    	for(Object[] obj:lastpmrcactionlist) {
//		    		MinutesLastPmrc lastpmrc=new MinutesLastPmrc();
//		    		lastpmrc.setActionFlag(obj[16]!=null? obj[16].toString() : null);
//		    		lastpmrc.setActionNo(obj[5]!=null? obj[5].toString() : null);
//		    		lastpmrc.setActionStatus(obj[10]!=null? obj[10].toString() : null);
//		    		lastpmrc.setAssignee(obj[11]!=null?Long.parseLong(obj[11]+""):0);
//		    		lastpmrc.setAssigneeDesig(obj[13]!=null? obj[13].toString() : null);
//		    		lastpmrc.setAssigneeName(obj[12]!=null? obj[12].toString() : null);
//		    		lastpmrc.setCommiteeScheduleId(Long.parseLong(committeescheduleid));
//		    		lastpmrc.setDetails(obj[2]!=null? obj[2].toString() : null);
//		    		if(obj[17]!=null) {
//		    		lastpmrc.setEndDate(obj[17].toString());
//		    		}
//		    		lastpmrc.setIdrck(obj[3].toString());
//		    		lastpmrc.setMinutesId(obj[0]!=null?Long.parseLong(obj[0]+""):0);
//		    		lastpmrc.setActionMainId(obj[4]!=null? obj[4].toString() : null);
//		    		if(obj[6]!=null) {
//		    		lastpmrc.setPdcOrg(obj[6]!=null? obj[6].toString() : null);
//		    		}
//		    		if(obj[7]!=null) {
//		    		lastpmrc.setPDC1(obj[7]!=null? obj[7].toString() : null);
//		    		}
//		    		if(obj[8]!=null) {
//		    		lastpmrc.setPDC2(obj[8]!=null? obj[8].toString() : null);
//		    		}
//		    		lastpmrc.setRevision(obj[9]!=null?Integer.parseInt(obj[9].toString()):0);
//		    		if(obj[14]!=null) {
//		    		lastpmrc.setLastDate(obj[14]!=null? obj[14].toString() : null);
//		    		}
//		    		lastpmrc.setProgress(obj[18]!=null?Integer.parseInt(obj[18].toString()):0);
//		    		lastpmrc.setCreatedBy(UserId);	
//		    		result=service.insertMinutesLastPmrc(lastpmrc);
//		    		
//		    	}
//		    	if(result>0) {
//		    			int count=service.updateMinutesFrozen(committeescheduleid);
//		    		
//		    		}
//		    	
//				}
//		    	
//		    	}
//		    	
//		    	redir.addFlashAttribute("committeescheduleid", committeescheduleid);
//				redir.addFlashAttribute("specname", req.getParameter("specname"));
//				redir.addFlashAttribute("membertype",req.getParameter("membertype"));
//				redir.addFlashAttribute("formname", req.getParameter("formname"));
//				redir.addFlashAttribute("unit1",req.getParameter("unit1"));
//		    	return "redirect:/CommitteeScheduleMinutes.htm";
//		    }
//		    catch(Exception e) {	    		
//	    		logger.error(new Date() +" Inside getMinutesFrozen.htm "+UserId, e);
//	    		e.printStackTrace();
//	    		return "static/Error";
//		
//	    	}
//			
//		}
		
		
		@PostMapping(value = "/FrozenProjectBriefingPaper.htm")
		public void FrozenProjectBriefingPaper(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception 
		{
			String UserId = (String) ses.getAttribute("Username");
			String LabCode = (String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside FrozenProjectBriefingPaper.htm "+UserId);		
			try {

				String path = ApplicationFilesDrive+LabCode+"\\Frozen\\BriefingPaper_P"+req.getParameter("projectid")+"_C"+req.getParameter("committeeid")+"_S"+req.getParameter("scheduleid")+".pdf";
		
				res.setContentType("application/pdf");
				res.setHeader("Content-Disposition", String.format("inline; filename=BriefingPaper.pdf"));
		
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
					logger.error(new Date() +" Inside FrozenProjectBriefingPaper.htm "+UserId, e);
			}
		}
		
		
		@RequestMapping(value="CommitteeMinutesNewDfm.htm", method = {RequestMethod.POST,RequestMethod.GET})
		public void CommitteeMinutesNewDfm(HttpServletRequest req,HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId=(String)ses.getAttribute("Username");
			String LabCode =(String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside CommitteeMinutesNewDfm.htm"+UserId);
			try
			{		
				String committeescheduleid = req.getParameter("committeescheduleid");			
				Object[] committeescheduleeditdata=service.CommitteeScheduleEditData(committeescheduleid);
				String projectid= committeescheduleeditdata[9].toString();
				String committeeid=committeescheduleeditdata[0].toString();
				
				if(Long.parseLong(projectid) >0 && committeescheduleeditdata[22].toString().equals("Y") ) 
				{
					CommitteeMeetingDPFMFrozen dpfm = service.getFrozenDPFMMinutes(committeescheduleid);
					res.setContentType("application/pdf");
					res.setHeader("Content-Disposition", "inline; name="+ dpfm.getDPFMFileName()+".pdf; filename"+ dpfm.getDPFMFileName());
			        File f=new File(uploadpath+dpfm.getFrozenDPFMPath() +dpfm.getDPFMFileName());
				         

				        OutputStream out = res.getOutputStream();
						FileInputStream in = new FileInputStream(f);
						byte[] buffer = new byte[4096];
						int length;
						while ((length = in.read(buffer)) > 0) {
							out.write(buffer, 0, length);
						}
						in.close();
						out.close();
					
					
					
				}
				else 
				{
	
					Object[] projectdetails = null;
					
					if(projectid!=null && Integer.parseInt(projectid)>0)
					{
					projectdetails = service.projectdetails(projectid);
						req.setAttribute("projectdetails", projectdetails);
					}
					String divisionid= committeescheduleeditdata[16].toString();
					if(divisionid!=null && Integer.parseInt(divisionid)>0)
					{
						req.setAttribute("divisiondetails", service.DivisionData(divisionid));
					}
					String initiationid= committeescheduleeditdata[17].toString();
					if(initiationid!=null && Integer.parseInt(initiationid)>0)
					{
						req.setAttribute("initiationdetails", service.Initiationdetails(initiationid));
					}
					
					Committee committee = printservice.getCommitteeData(committeeid);
					
					HashMap< String, ArrayList<Object[]>> actionsdata=new LinkedHashMap<String, ArrayList<Object[]>>();
					long lastid=service.getLastPmrcId(projectid, committeeid, committeescheduleid);
					
					req.setAttribute("committeeminutesspeclist",service.CommitteeScheduleMinutes(committeescheduleid) );
					req.setAttribute("committeescheduleeditdata", committeescheduleeditdata);
					req.setAttribute("committeeminutes",service.CommitteeMinutesSpecNew());
					req.setAttribute("committeeinvitedlist", service.CommitteeAtendance(committeescheduleid));			
					req.setAttribute("labdetails", service.LabDetails(committeescheduleeditdata[24].toString()));
					req.setAttribute("isprint", "Y");	
					req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(committeescheduleeditdata[24].toString()));
					req.setAttribute("meetingcount",service.MeetingNo(committeescheduleeditdata));
					req.setAttribute("milestonedatalevel6", printservice.BreifingMilestoneDetails(projectid,committee.getCommitteeShortName().trim()));
	
	//				req.setAttribute("committeeminutessub",service.CommitteeMinutesSub());
	//				req.setAttribute("CommitteeAgendaList", service.CommitteeAgendaList(committeescheduleid));
					String LevelId= "2";
		    		Object[] MileStoneLevelId = printservice.MileStoneLevelId(projectid,committeeid);
					if( MileStoneLevelId!= null) {
						LevelId= MileStoneLevelId[0].toString();
					}
					req.setAttribute("levelid", LevelId);
					req.setAttribute("labInfo", service.LabDetailes(LabCode));
				/*---------------------------------------------------------------------------------------------------------------*/
	//				if(Long.parseLong(projectid) >0 && committeescheduleeditdata[22].toString().equals("N") ) {
						
						 final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectdetails[4].toString()+"&rupess="+10000000;
					 		HttpHeaders headers = new HttpHeaders();
					 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
					 		headers.set("labcode", LabCode);
					 		String jsonResult=null;
							try {
								HttpEntity<String> entity = new HttpEntity<String>(headers);
								ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
								jsonResult=response.getBody();						
							}catch(Exception e) {
								req.setAttribute("errorMsg", "errorMsg");
							}
							ObjectMapper mapper = new ObjectMapper();
							mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
							mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
							List<ProjectFinancialDetails> projectDetails=null;
							if(jsonResult!=null) {
								try {
									projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
								req.setAttribute("financialDetails",projectDetails);
								} catch (JsonProcessingException e) {
									e.printStackTrace();
								}
							}
			 	
							final String localUri2=uri+"/pfms_serv/getTotalDemand";
	
					 		String jsonResult2=null;
							try {
								HttpEntity<String> entity = new HttpEntity<String>(headers);
								ResponseEntity<String> response=restTemplate.exchange(localUri2, HttpMethod.POST, entity, String.class);
								jsonResult2=response.getBody();						
							}catch(Exception e) {
								req.setAttribute("errorMsg", "errorMsg");
							}
							ObjectMapper mapper2 = new ObjectMapper();
							mapper2.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
							mapper2.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
							List<TotalDemand> totaldemand=null;
							if(jsonResult2!=null) {
								try {
									totaldemand = mapper2.readValue(jsonResult2, new TypeReference<List<TotalDemand>>(){});
									req.setAttribute("TotalProcurementDetails",totaldemand);
								} catch (JsonProcessingException e) {
									e.printStackTrace();
								}
							}
		
						 	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(projectid);
						 	List<Object[]> procurementOnDemand=null;
						 	List<Object[]> procurementOnSanction=null;
			 	
						
						 	 if(procurementStatusList!=null){
						 		Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
						 		Collection<?> keys = map.keySet();
					 		for(Object key:keys){
						 		    if(key.toString().equals("D")) {
						 		    	procurementOnDemand=map.get(key);
						 		    }else if(key.toString().equals("S")) {
						 		    	procurementOnSanction=map.get(key);
						 		    }
						 		 }
						 	}
						 	List<Object[]> actionlist= service.MinutesViewAllActionList(committeescheduleid);
							
						 	for(Object obj[] : actionlist) {
									
								ArrayList<Object[]> values=new ArrayList<Object[]>();
								for(Object obj1[] : actionlist ) {
									if(obj1[0].equals(obj[0])) {
											values.add(obj1);
									}
								}
								if(!actionsdata.containsKey(obj[0].toString())) {
									actionsdata.put(obj[0].toString(), values);
								}
						} 
						
						 	req.setAttribute("lastpmrcactions", service.LastPMRCActions(lastid,committeeid,projectid,committeescheduleeditdata[22]+""));
							req.setAttribute("actionlist",actionsdata);
						 	req.setAttribute("procurementOnDemand", procurementOnDemand);
						 	req.setAttribute("procurementOnSanction", procurementOnSanction);
						 	req.setAttribute("ActionPlanSixMonths", service.ActionPlanSixMonths(projectid));
	//					 	req.setAttribute("milestonesubsystems", service.MilestoneSubsystems(projectid));
	//				}
					
	//				else if(committeescheduleeditdata[22].toString().equals("Y") ){
	//					List<Object[]> procurementStatusList=(List<Object[]>)service.getMinutesProcure(committeescheduleid);
	//				 	List<Object[]> procurementOnDemand=null;
	//				 	List<Object[]> procurementOnSanction=null;
	//		 						
	//				 	 if(procurementStatusList!=null){
	//				 		Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
	//				 		Collection<?> keys = map.keySet();
	//				 		for(Object key:keys){
	//				 		    if(key.toString().equals("D")) {
	//				 		    	procurementOnDemand=map.get(key);
	//				 		    }else if(key.toString().equals("S")) {
	//				 		    	procurementOnSanction=map.get(key);
	//				 		    }
	//				 		 }
	//				 	}
	//				 	 
	//				 	req.setAttribute("lastpmrcactions", service.LastPMRCActions(Long.parseLong(committeescheduleid),committeeid,projectid,committeescheduleeditdata[22]+""));
	//				 	req.setAttribute("financialDetails",service.getMinutesFinance(committeescheduleid));
	////					req.setAttribute("milestonesubsystems", service.getMinutesSubMile(committeescheduleid));
	//					req.setAttribute("ActionPlanSixMonths", service.getMinutesMile(committeescheduleid));
	//					req.setAttribute("procurementOnDemand", procurementOnDemand);
	//				 	req.setAttribute("procurementOnSanction", procurementOnSanction);
	//				 	List<Object[]> actionlist= service.getMinutesAction(committeescheduleid);
	//					
	//					
	//					for(Object obj[] : actionlist) {
	//							
	//							ArrayList<Object[]> values=new ArrayList<Object[]>(); 
	//							for(Object obj1[] : actionlist ) {
	//								if(obj1[0].equals(obj[0])) {
	//									values.add(obj1);
	//								}
	//						}
	//							if(!actionsdata.containsKey(obj[0].toString())) {
	//								actionsdata.put(obj[0].toString(), values);
	//							}
	//					} 
	//					req.setAttribute("actionlist",actionsdata);
	//				}
				/*---------------------------------------------------------------------------------------------------------------*/			
					String filename=committeescheduleeditdata[11].toString().replace("/", "-");
						
						
					String path=req.getServletContext().getRealPath("/view/temp");
					req.setAttribute("path",path);
					
					CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
					req.getRequestDispatcher("/view/committee/CommitteeMinutesNewDfm.jsp").forward(req, customResponse);
					String html = customResponse.getOutput();
					
					HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
					req.setAttribute("tableactionlist",  actionsdata);
			        CharArrayWriterResponse customResponse1 = new CharArrayWriterResponse(res);
					req.getRequestDispatcher("/view/committee/ActionDetailsTable1.jsp").forward(req, customResponse1);
					String html1 = customResponse1.getOutput();        
			        
			        HtmlConverter.convertToPdf(html1,new FileOutputStream(path+File.separator+filename+"1.pdf")); 
				         
				        
			        PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
			        PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
			        PdfReader pdf2=new PdfReader(path+File.separator+filename+"1.pdf");
			        
			        PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	       	        
			        PdfDocument pdfDocument2 = new PdfDocument(pdf2);
			        PdfMerger merger = new PdfMerger(pdfDocument);
				        
			        merger.merge(pdfDocument2, 1, pdfDocument2.getNumberOfPages());
			            
		            pdfDocument2.close();
			        pdfDocument.close();
			        merger.close();
			        pdf2.close();
			        pdf1.close();	       
			        pdfw.close();
				    
			        res.setContentType("application/pdf");
					res.setHeader("Content-Disposition", "inline; name="+ filename+".pdf; filename"+ filename+".pdf");
			        File f=new File(path +File.separator+ "merged.pdf");
				         
	
				        OutputStream out = res.getOutputStream();
						FileInputStream in = new FileInputStream(f);
						byte[] buffer = new byte[4096];
						int length;
						while ((length = in.read(buffer)) > 0) {
							out.write(buffer, 0, length);
						}
						in.close();
						out.close();
						
				        Path pathOfFile2= Paths.get( path+File.separator+filename+"1.pdf"); 
				        Files.delete(pathOfFile2);		
				        pathOfFile2= Paths.get( path+File.separator+filename+".pdf"); 
				        Files.delete(pathOfFile2);	
				        pathOfFile2= Paths.get(path +File.separator+ "merged.pdf"); 
				        Files.delete(pathOfFile2);
				        
					}
				}
				catch (Exception e) 
				{
					e.printStackTrace(); 
					logger.error(new Date() +"Inside CommitteeMinutesNewDfm.htm "+UserId,e);
				}
				
				
			}
		
//anil's code for minutes word file
		
		
		
		
		private static void createParagraph(XWPFDocument doc, String[] texts, String alignment, boolean[] bolds, int[] fontSizes, int spacingAfter) {
			XWPFParagraph paragraph = doc.createParagraph();
			if (texts.length != bolds.length || texts.length != fontSizes.length) {
		        throw new IllegalArgumentException("Lengths of texts, bolds, and fontSizes arrays must match.");
		    }

		    if (texts.length > 0) {
		        for (int i = 0; i < texts.length; i++) {
		            XWPFRun run = paragraph.createRun();
		            run.setText(texts[i]+"      ");
		            run.setFontSize(fontSizes[i]);
		            run.setBold(bolds[i]);
		        }
		    }

		    if ("CENTER".equals(alignment)) {
		        paragraph.setAlignment(ParagraphAlignment.CENTER);
		    } else if ("LEFT".equals(alignment)) {
		        paragraph.setAlignment(ParagraphAlignment.LEFT);
		    }
		    
		    // Set the spacing after the paragraph
		    paragraph.setSpacingAfter(spacingAfter);
		}
		
		private static void createParagraph(XWPFDocument doc, String text, String alignment, boolean isBold, int fontSize, int spacingAfter) {
			XWPFParagraph paragraph = doc.createParagraph();
			XWPFRun run = paragraph.createRun();
		    run.setText(text);
		    run.setFontSize(fontSize);
		    if (isBold) {
		        run.setBold(true);
		    }
		    if ("CENTER".equals(alignment)) {
		        paragraph.setAlignment(ParagraphAlignment.CENTER);
		    } else if ("LEFT".equals(alignment)) {
		        paragraph.setAlignment(ParagraphAlignment.LEFT);
		    } else if ("RIGHT".equals(alignment)) {
		        paragraph.setAlignment(ParagraphAlignment.RIGHT);
		    }
		    
		    // Set the spacing after the paragraph
		    paragraph.setSpacingAfter(spacingAfter);
		}

		
		private static int setTableRowData(XWPFTable table, int row, int length, String[] cellTexts) {
		    XWPFTableRow tableRow = table.getRow(row);
		    int rowIndex;

		    if (tableRow == null) {
		        // If the row doesn't exist, create a new row
		        tableRow = table.createRow();
		        rowIndex = table.getRows().indexOf(tableRow);
		    } else {
		        rowIndex = row;
		    }

		    for (int i = 0; i < length; i++) {
		        XWPFTableCell cell = tableRow.getCell(i);

		        if (cell == null) {
		            // If the cell doesn't exist, create a new cell
		            cell = tableRow.createCell();
		        }

		        cell.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);

		        XWPFParagraph paragraphAT = cell.getParagraphs().get(0);
		        XWPFRun runAT = null;

		        if (paragraphAT.getRuns().isEmpty()) {
		            runAT = paragraphAT.createRun();
		        } else {
		            runAT = paragraphAT.getRuns().get(0);
		        }

		        if (cellTexts[i] != null) {
		            runAT.setText(cellTexts[i]);
		            runAT.setBold(true);
		        }

		        paragraphAT.setAlignment(ParagraphAlignment.CENTER);
		        runAT.setBold(true);
		    }

		    return rowIndex;
		}


		private static void mergrColums(XWPFTable table,int numCellsToMerge,int row) {
			XWPFTableCell cell = table.getRow(row).getCell(0);
			   for (int i = 1; i < numCellsToMerge; i++) {
				   cell.getCTTc().addNewTcPr().addNewGridSpan().setVal(BigInteger.valueOf(numCellsToMerge));
	            }

	            // Get the row and cells in the same row for the next columns
	            XWPFTableRow sameRow = table.getRow(table.getNumberOfRows() - 1);
	            for (int i = 1; i < numCellsToMerge; i++) {
	                XWPFTableCell nextCell = sameRow.getCell(1);
	                sameRow.getCtRow().removeTc(sameRow.getTableCells().indexOf(nextCell));
	            }
		}
		
		private static void setTableWidth(XWPFTable table,int totalTableWidth,int[] percentageColumnWidths) {
            // Get the table properties and set the width
            CTTblPr tblPr = table.getCTTbl().getTblPr();
            if (tblPr == null) {
                tblPr = table.getCTTbl().addNewTblPr();
            }
            CTTblWidth tblWidth = tblPr.getTblW();
            if (tblWidth == null) {
                tblWidth = tblPr.addNewTblW();
            }
            tblWidth.setType(STTblWidth.PCT);
            tblWidth.setW(BigInteger.valueOf(totalTableWidth));

            // Set the column widths
            CTTblGrid tblGrid = table.getCTTbl().addNewTblGrid();
            for (int width : percentageColumnWidths) {
                CTTblGridCol tblGridCol = tblGrid.addNewGridCol();
                tblGridCol.setW(BigInteger.valueOf((width * totalTableWidth) / 100));
            }
		}
		
		private static void setTableHeader(XWPFTableRow thirdRow) {
			  // Get the merged cell (the first cell in the first row)
	         XWPFTableCell mergedCell = thirdRow.getCell(0);
	         mergedCell.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);

	         // Set cell color (if needed)
	         mergedCell.setColor("auto");

	         // Get the paragraph within the merged cell
	         XWPFParagraph paragraphTable = mergedCell.getParagraphs().get(0);

	         String formattedText = "NA : Not Assigned  AA : Activity Assigned  OG : On Going  DO : Delay - On Going  RC : Review & Close  FD : Forwarded With Delay  CO : Completed  CD : Completed with Delay  IA : InActive  DD : Delayed days";

	         String[] wordAndFormat = formattedText.split("\\s+");

	         for (int i = 0; i < wordAndFormat.length; i++) {
	             String text = wordAndFormat[i];
	             XWPFRun run3 = paragraphTable.createRun();
	             run3.setFontSize(9); 
	             // Check if the text is a word (not a formatting code)
	             if (!text.matches(".*:[\\s\\w]*")) {
	                 // Apply red color to specific words
	                 if (text.equals("NA") || text.equals("AA") || text.equals("OG") ||
	                     text.equals("DO") || text.equals("RC") || text.equals("FD") ||
	                     text.equals("CO") || text.equals("CD") || text.equals("IA") ||
	                     text.equals("DD")) {
	                     run3.setColor("FF0000"); // Red color
	                 } else {
	                     run3.setColor("000000"); // Black color (default)
	                 }
	             }
	             // Add a space after "NA : Not Assigned" except for the last item
	             if ((text.equals("Assigned") && i < wordAndFormat.length - 1) || text.equals("Going") || text.equals("Close") || text.equals("ForwardedWithDelay") || text.equals("InActive") || text.equals("Delayeddays") || text.equals("Completed")) {
	                 text += "  ";
	             }
	             run3.setText(text);
	            
	         }

	         // Set the alignment of the paragraph to center
	         paragraphTable.setAlignment(ParagraphAlignment.CENTER);
	 
		}
		private static void mergeColums(XWPFTable table,int rowNo,int startIdx,int endIdx ) {
			XWPFTableRow futureRow = table.getRow(rowNo);
	         XWPFTableCell lastCell5 = futureRow.getCell(startIdx);
		       //  XWPFTableCell lastCell2 = seventhRow.getCell(6);

		      // Merge the last two cells
		      CTTcPr tcPr3 = lastCell5.getCTTc().addNewTcPr();
		      tcPr3.addNewGridSpan().setVal(BigInteger.valueOf(2));
		         
		      futureRow.getCtRow().removeTc(endIdx);
		}	
		private static void mergeRows(XWPFTable table,int rowNo1,int rowNo2,int startIdx,int endIdx) {
	         XWPFTableCell firstCellFirstRow = table.getRow(rowNo1).getCell(startIdx);
	         XWPFTableCell firstCellSecondRow = table.getRow(rowNo2).getCell(endIdx);

	         // Merge the cells by setting the vMerge property
	         CTTcPr tcPrFirstCellFirstRow = firstCellFirstRow.getCTTc().isSetTcPr() ? firstCellFirstRow.getCTTc().getTcPr() : firstCellFirstRow.getCTTc().addNewTcPr();
	         CTTcPr tcPrFirstCellSecondRow = firstCellSecondRow.getCTTc().isSetTcPr() ? firstCellSecondRow.getCTTc().getTcPr() : firstCellSecondRow.getCTTc().addNewTcPr();

	         CTVMerge vMerge = tcPrFirstCellFirstRow.isSetVMerge() ? tcPrFirstCellFirstRow.getVMerge() : tcPrFirstCellFirstRow.addNewVMerge();
	         vMerge.setVal(STMerge.RESTART);

	         vMerge = tcPrFirstCellSecondRow.isSetVMerge() ? tcPrFirstCellSecondRow.getVMerge() : tcPrFirstCellSecondRow.addNewVMerge();
	         vMerge.setVal(STMerge.CONTINUE);
		}
		

		
		private static void createCell2(XWPFTableRow row, String value, int cell) {
		    XWPFTableCell cell2 = row.getCell(cell);
		    if (value != null) {
		        String[] lines = value.split("\n");
		        for (int i = 0; i < lines.length; i++) {
		            if (i > 0) {
		                cell2.addParagraph().createRun().addBreak();
		            }
		            cell2.addParagraph().createRun().setText(lines[i]);
		        }

		    } else {
		        cell2.setText("-");
		    }
		    cell2.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
		}
		private static void createCell(XWPFTableRow row, String value, int cell) {
		    XWPFTableCell cell2 = row.getCell(cell);
		    if (value != null) {
		    	cell2.setText(value);
		    } else {
		        cell2.setText("-");
		    }
		    cell2.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
		}
		
		
	
		
		

	@RequestMapping(value="CommitteeMinutesNewWordDownload.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public void CommitteeMinutesNewWordDownload(HttpServletRequest req,HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception
	{	
			long startTime = System.currentTimeMillis();
			String UserId=(String)ses.getAttribute("Username");
			String LabCode =(String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside CommitteeMinutesNewDownload.htm "+UserId);
			
			Object [] divisiondetails=null;
			Object [] initiationdetails=null;
			Object[] membersec=null; 
			int meetingcount=0;
			int count1=0;
			try
			{		
				String committeescheduleid = req.getParameter("committeescheduleid");	
				Object[] committeescheduleeditdata=service.CommitteeScheduleEditData(committeescheduleid);
				String projectid= committeescheduleeditdata[9].toString();
				String committeeid=committeescheduleeditdata[0].toString();

	
					Object[] projectdetails = null;
					
					if(projectid!=null && Integer.parseInt(projectid)>0)
					{
					projectdetails = service.projectdetails(projectid);
					}
					String divisionid= committeescheduleeditdata[16].toString();
					if(divisionid!=null && Integer.parseInt(divisionid)>0)
					{
						divisiondetails=service.DivisionData(divisionid);
					}
					String initiationid= committeescheduleeditdata[17].toString();
					if(initiationid!=null && Integer.parseInt(initiationid)>0)
					{
						initiationdetails=service.Initiationdetails(initiationid);
					}
					List<Object[]> envisagedDemandlist  = new ArrayList<Object[]>();
		    		envisagedDemandlist=service.getEnvisagedDemandList(projectid);
					
					HashMap< String, ArrayList<Object[]>> actionsdata=new LinkedHashMap<String, ArrayList<Object[]>>();
					long lastid=service.getLastPmrcId(projectid, committeeid, committeescheduleid);
					List<Object[]> speclists =service.CommitteeScheduleMinutes(committeescheduleid);

					List<Object[]> committeeminutes =service.CommitteeMinutesSpecNew();
					List<Object[]> invitedlist = service.CommitteeAtendance(committeescheduleid);
					Object[] labdetails = service.LabDetails(committeescheduleeditdata[24].toString());
					String labLogo=LogoUtil.getLabLogoAsBase64String(committeescheduleeditdata[24].toString());
					
					byte[] imageBytes = DatatypeConverter.parseBase64Binary(labLogo);
					
					

					// Save the image to a file or use an InputStream, as needed
					ByteArrayInputStream imageStream = new ByteArrayInputStream(imageBytes);
					meetingcount=service.MeetingNo(committeescheduleeditdata);
					List<Object[]> MilestoneDetails6 = printservice.BreifingMilestoneDetails(projectid,committeeid);
					String LevelId= "2";
		    		Object[] MileStoneLevelId = printservice.MileStoneLevelId(projectid,committeeid);
					if( MileStoneLevelId!= null) {
						LevelId= MileStoneLevelId[0].toString();
					}
					
					LinkedHashMap< String, ArrayList<Object[]>> actionlist2 = (LinkedHashMap< String, ArrayList<Object[]>>) actionsdata;
						
						 final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectdetails[4].toString()+"&rupess="+10000000;
					 		HttpHeaders headers = new HttpHeaders();
					 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
					 		headers.set("labcode", LabCode);
					 		String jsonResult=null;
							try {
								HttpEntity<String> entity = new HttpEntity<String>(headers);
								ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
								jsonResult=response.getBody();						
							}catch(Exception e) {
								req.setAttribute("errorMsg", "errorMsg");
							}
							ObjectMapper mapper = new ObjectMapper();
							mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
							mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
							List<ProjectFinancialDetails> projectDetails=null;
							if(jsonResult!=null) {
								try {
									projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
								} catch (JsonProcessingException e) {
									e.printStackTrace();
								}
							}
			 	
							final String localUri2=uri+"/pfms_serv/getTotalDemand";
	
					 		String jsonResult2=null;
							try {
								HttpEntity<String> entity = new HttpEntity<String>(headers);
								ResponseEntity<String> response=restTemplate.exchange(localUri2, HttpMethod.POST, entity, String.class);
								jsonResult2=response.getBody();						
							}catch(Exception e) {
								req.setAttribute("errorMsg", "errorMsg");
							}
							ObjectMapper mapper2 = new ObjectMapper();
							mapper2.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
							mapper2.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
							List<TotalDemand> totaldemand=null;
							if(jsonResult2!=null) {
								try {
									totaldemand = mapper2.readValue(jsonResult2, new TypeReference<List<TotalDemand>>(){});
								} catch (JsonProcessingException e) {
								e.printStackTrace();
							}
						}
	
					 	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(projectid);
					 	List<Object[]> procurementOnDemand=null;
					 	List<Object[]> procurementOnSanction=null;
		 	
					
					 	 if(procurementStatusList!=null){
					 		Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
					 		Collection<?> keys = map.keySet();
				 		for(Object key:keys){
					 		    if(key.toString().equals("D")) {
					 		    	procurementOnDemand=map.get(key);
					 		    }else if(key.toString().equals("S")) {
					 		    	procurementOnSanction=map.get(key);
					 		    }
					 		 }
					 	}
					 	List<Object[]> actionlist= service.MinutesViewAllActionList(committeescheduleid);
						
					 	for(Object obj[] : actionlist) {
								
							ArrayList<Object[]> values=new ArrayList<Object[]>();
							for(Object obj1[] : actionlist ) {
								if(obj1[0].equals(obj[0])) {
										values.add(obj1);
								}
							}
							if(!actionsdata.containsKey(obj[0].toString())) {
								actionsdata.put(obj[0].toString(), values);
							}
					} 
					 	List<Object[]> lastpmrcactions = service.LastPMRCActions(lastid,committeeid,projectid,committeescheduleeditdata[22]+"");
	
					 	List<Object[]> ActionPlanSixMonths =service.ActionPlanSixMonths(projectid);
					 	Object[] projectdatadetails =service.ProjectDataDetails(projectid);
					 	DecimalFormat df=new DecimalFormat("####################.##");
					 	List<Object[]>totalMileStones=service.totalProjectMilestones(projectid);//get all the milestones details based on projectid
					 	List<Object[]>first=null;   //store the milestones with levelid 1
					 	List<Object[]>second=null;	// store the milestones with levelid 2
					 	List<Object[]>three= null; // store the milestones with levelid 3
					 	Map<Integer,String> treeMapLevOne = new TreeMap<>();  // store the milestoneid with level id 1 and counts 
					 	Map<Integer,String>treeMapLevTwo= new TreeMap<>(); // store the milestonidid with level id 2 and counts
					 	Map<Integer,String>treeMapLevThree= new TreeMap<>();  // store the milestoneid with level id 3 and counts 
					 	 TreeSet<Integer> AllMilestones = new TreeSet<>();   // store the number of milestone in sorted order
					 	 if(!totalMileStones.isEmpty()) {
					 	 for(Object[]obj:totalMileStones){
					 	 AllMilestones.add(Integer.parseInt(obj[22].toString())); // getting the milestones from list
					 	 }
					 	 for(Integer mile:AllMilestones) {
					 	 int count=1;
					 	 first=totalMileStones.stream().
				 			   filter(i->i[26].toString().equalsIgnoreCase("1") && i[22].toString().equalsIgnoreCase(mile+""))
				 				.map(objectArray -> new Object[]{objectArray[0], objectArray[2]})
				 				.collect(Collectors.toList());
					 		for(Object[]obj:first) {
					 		treeMapLevOne.put(Integer.parseInt(obj[1].toString()),"A"+(count++));// to get the first level
					 		}
					 	}
					 	for (Map.Entry<Integer,String> entry : treeMapLevOne.entrySet()) {
					 		int count=1;
					 		second=totalMileStones.stream().
					 			   filter(i->i[26].toString().equalsIgnoreCase("2") && i[2].toString().equalsIgnoreCase(entry.getKey()+""))
					 			    .map(objectArray -> new Object[] {entry.getKey(),objectArray[3]})
					 			   .collect(Collectors.toList());
					 	for(Object[]obj:second) {
					 		treeMapLevTwo.put(Integer.parseInt(obj[1].toString()),"B"+(count++));
					 	}
					 	}
					 	for(Map.Entry<Integer,String>entry: treeMapLevTwo.entrySet()) {
					 		int count=1;
					 		three=totalMileStones.stream().
					 				filter(i->i[26].toString().equalsIgnoreCase("3") && i[3].toString().equalsIgnoreCase(entry.getKey()+""))
					 				.map(objectArray -> new Object[] {entry.getKey(),objectArray[4]})
					 				.collect(Collectors.toList());
					 		for(Object[]obj:three) {
								treeMapLevThree.put(Integer.parseInt(obj[1].toString()), "C"+(count++)); 
					 			
					 		}
					 	}
					 	 }
								 	if(invitedlist.size()>0){
								 	 ArrayList<String> membertypes=new ArrayList<String>(Arrays.asList("CC","CS","PS","CI","CW","CO","CH"));

								 	int memPresent=0,memAbscent=0,ParPresent=0,parAbscent=0;
								 	int j=0;
								 	for(Object[] temp : invitedlist){

								 		if(temp[4].toString().equals("P") &&  membertypes.contains( temp[3].toString()) )
								 		{ 
								 			memPresent++;
								 		}
								 		else if(temp[4].toString().equals("N") &&  membertypes.contains( temp[3].toString()) )
								 		{
								 			memAbscent++;
								 		}
								 		else if( temp [4].toString().equals("P") && !membertypes.contains( temp[3].toString()) )
								 		{ 
								 			ParPresent++;
								 		}
								 		else if( temp [4].toString().equals("N") && !membertypes.contains( temp[3].toString()) )
								 		{ 
								 			parAbscent++;
								 		}
								 	}
								 	List<List<Object[]>> ReviewMeetingList = new ArrayList<List<Object[]>>();
							    	List<List<Object[]>> ReviewMeetingListPMRC = new ArrayList<List<Object[]>>();
							    	ReviewMeetingList.add(printservice.ReviewMeetingList(projectid, "EB"));
						    		ReviewMeetingListPMRC.add(printservice.ReviewMeetingList(projectid, "PMRC")); 
						    		Map<Integer,String> mappmrc = new HashMap<>();
						     		int pmrccount=0;
						     		for (Object []obj:ReviewMeetingListPMRC.get(0)) {
						     			mappmrc.put(++pmrccount,obj[3].toString());
						     		}
						    		int ebcount=0;
						    		Map<Integer,String> mapEB = new HashMap<>();
						    		for (Object []obj:ReviewMeetingList.get(0)) {
						    		mapEB.put(++ebcount,obj[3].toString());
						    		}

								 	 
								 	String filename = committeescheduleeditdata[11].toString().replace("/", "-");

								 	XWPFDocument doc = new XWPFDocument();
							

								 	try {
						
								 		

								 		createParagraph(doc, "MINUTES OF MEETING", "CENTER", true, 24,1000);
								 		createParagraph(doc, committeescheduleeditdata[7].toString().toUpperCase() + "  (" + committeescheduleeditdata[8].toString().toUpperCase() + (meetingcount > 0 ? "  #" + meetingcount : "") + ")","CENTER", false, 18,10);
								 		createParagraph(doc, "For", "CENTER", false, 14,10);
								 		createParagraph(doc, "Project : "+projectdetails[1]+" ("+projectdetails[4]+")", "CENTER", false, 17,600);
								 		createParagraph(doc, "Meeting Id", "CENTER", true, 14,4);
								 		createParagraph(doc, committeescheduleeditdata[11].toString() , "CENTER", false, 16,500);

								 		
								 		String[] texts = {"Meeting Date", "Meeting Time"};
								 		String[] texts2 = {"                                               "+sdf3.format(sdf1.parse(committeescheduleeditdata[2].toString()))+"    ", committeescheduleeditdata[3].toString()};
								 		boolean[] bolds = {false, false};
								 		int[] fontSizes = {14, 14};

								 		createParagraph(doc, texts, "CENTER", bolds, fontSizes,10);
								 		createParagraph(doc, texts2, "LEFT", bolds, fontSizes,500);
								 		
								 		createParagraph(doc, "Meeting Venue" , "CENTER", true, 16,5);// image logo
								 		createParagraph(doc, committeescheduleeditdata[12].toString() , "CENTER", false, 16,1250);
								 		
								 		XWPFParagraph paragraphP = doc.createParagraph();
								 		XWPFRun runP = paragraphP.createRun();

								 		 int formatP = XWPFDocument.PICTURE_TYPE_PNG;   // Use the appropriate picture type for XWPFDocument
								            runP.addPicture(imageStream, formatP, "Lab Logo", Units.toEMU(100), Units.toEMU(100));
								            paragraphP.setAlignment(ParagraphAlignment.CENTER);
								            
								            createParagraph(doc, "" , "CENTER", false, 16,1250);
								            
								 		createParagraph(doc, labdetails[2].toString()+" ("+labdetails[1]+")" , "CENTER", false, 16,10);
								 		createParagraph(doc, labdetails[4].toString()+" "+labdetails[5].toString()+" "+labdetails[6] , "CENTER", false, 16,10);


						            XWPFParagraph pageBreak = doc.createParagraph();
							            pageBreak.setPageBreak(true);
							        
							            
							            createParagraph(doc, "ATTENDANCE", "CENTER", true, 18,10);
							            XWPFTable table = doc.createTable(2, 4);
							            int[] percentageColumnWidths = {8, 40, 25, 27};

							            int totalTableWidth = 5000; 

							            String[] cellTexts = {"SN", "Name, Designation", "Estt. / Agency", "Role"};

							            setTableRowData(table,0,cellTexts.length,cellTexts);
							            
							            setTableWidth(table,totalTableWidth,percentageColumnWidths);

							            String[] cellTextsRow2 = {"Members Present",null,null, null};
							            setTableRowData(table,1,cellTextsRow2.length,cellTextsRow2);
							            
							            int numCellsToMerge = 4;
							            mergrColums(table,numCellsToMerge,1);
							    
							          int memPresentCount=1;
							          int memAbsentCount=0;
							          int parPresentCount=0;
							          int parAbsentCount=0;

							            if(memPresent > 0){
							            	for(int i=0;i<invitedlist.size();i++) {
							            		if(invitedlist.get(i)[4].toString().equals("P") && membertypes.contains( invitedlist.get(i)[3].toString()) )
							            	 	{ j++;
							            	 	XWPFTableRow thirdRow = table.createRow();
							            	 	createCell(thirdRow,String.valueOf(j),0);
							            	 	createCell(thirdRow,invitedlist.get(i)[6]+" "+invitedlist.get(i)[7],1);
							            	 	createCell(thirdRow, invitedlist.get(i)[11].toString(),2);

							            	 	XWPFTableCell thirdRowCell4 = thirdRow.getCell(3);
							            	 	if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {
							            	 		thirdRowCell4.setText( "Chairperson" );
							            	 	}else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ) {
							            	 		membersec=invitedlist.get(i);
							            	 		thirdRowCell4.setText( "Member Secretary" );
							            	 	}
							            	 	else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CH") ) {
							            	 		thirdRowCell4.setText( "Co-Chairperson" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) {
							            	 		thirdRowCell4.setText( "Member Secretary (Proxy)" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI") || invitedlist.get(i)[3].toString().equalsIgnoreCase("I") ) {
							            	 		thirdRowCell4.setText( "Internal" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("W")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("E")) {
							            	 		thirdRowCell4.setText( "External" );
							            	 	}else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ) {
							            	 		thirdRowCell4.setText( "Presenter" );
							            	 	}else {
							            	 		thirdRowCell4.setText( "REP_"+invitedlist.get(i)[3].toString() );
							            	 	}
							            	 	
							            	 	thirdRowCell4.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.TOP);
							            	 	
							            	 	}
							            		memPresentCount++;
							            	}
							            	memAbsentCount=memPresentCount+1;
							            }
							            if(memAbscent > 0){
							            	
							            	  String[] memAbsentData = {"Following Members Could not Attend due to Prior Commitments",null,null, null};
									            int memAbsentRow = setTableRowData(table,memPresentCount+1,memAbsentData.length,memAbsentData);
									            mergrColums(table,numCellsToMerge,memAbsentRow);

									         memAbsentCount=memAbsentRow+1;
								        	int count=0;
								        	for(int i=0;i<invitedlist.size();i++)
								        	 {
								        		if(invitedlist.get(i)[4].toString().equals("N")&& membertypes.contains( invitedlist.get(i)[3].toString()) )
								        	 	{count++; j++;
								        	 	XWPFTableRow thirdRow = table.createRow();
								        	 	
								        	 	createCell(thirdRow,String.valueOf(j),0);
							            	 	createCell(thirdRow,invitedlist.get(i)[6]+" "+invitedlist.get(i)[7],1);
							            	 	createCell(thirdRow, invitedlist.get(i)[11].toString(),2);
							            	 	

							            	 	XWPFTableCell thirdRowCell4 = thirdRow.getCell(3);
							            	 	if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {
							            	 		thirdRowCell4.setText( "Chairperson" );
							            	 	}else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ) {
							            	 		membersec=invitedlist.get(i);
							            	 		thirdRowCell4.setText( "Member Secretary" );
							            	 	}
							            	 	else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CH") ) {
							            	 		thirdRowCell4.setText( "Co-Chairperson" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) {
							            	 		thirdRowCell4.setText( "Member Secretary (Proxy)" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI") || invitedlist.get(i)[3].toString().equalsIgnoreCase("I") ) {
							            	 		thirdRowCell4.setText( "Internal" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("W")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("E")) {
							            	 		thirdRowCell4.setText( "External" );
							            	 	}else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ) {
							            	 		thirdRowCell4.setText( "Presenter" );
							            	 	}else {
							            	 		thirdRowCell4.setText( "REP_"+invitedlist.get(i)[3].toString() );
							            	 	}
							            	 	
							            	 	thirdRowCell4.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.TOP);
							            	 	
							            	 	}
								        		memAbsentCount++;
								        	 	}
								        	if(count==0){
								        	       String[] memAbsentNil = {"Nil",null,null, null};
										            setTableRowData(table,1,memAbsentNil.length,memAbsentNil);
										            mergrColums(table,numCellsToMerge,memAbsentCount);
										            memAbsentCount++;
								        		
								        	}
								        	 }
							            
							            if(ParPresent > 0){
					
								            String[] cellTextsRow3 = {"Other Invitees / Participants",null,null, null};
								            int rowIndex = setTableRowData(table,memAbsentCount,cellTextsRow3.length,cellTextsRow3);
								            mergrColums(table,numCellsToMerge,rowIndex);
								            parPresentCount=rowIndex+1;

								        	for(int i=0;i<invitedlist.size();i++)
								        	 {
								        		if(invitedlist.get(i)[4].toString().equals("P") && !membertypes.contains( invitedlist.get(i)[3].toString()) )
								        	 	{
								        			addcount++; j++;
								        	 	XWPFTableRow thirdRow = table.createRow();
								        	 	
								        	 	createCell(thirdRow,String.valueOf(j),0);
							            	 	createCell(thirdRow,invitedlist.get(i)[6]+" "+invitedlist.get(i)[7],1);
							            	 	createCell(thirdRow, invitedlist.get(i)[11].toString(),2);
							          
							            	 	XWPFTableCell thirdRowCell4 = thirdRow.getCell(3);
							            	 	if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {
							            	 		thirdRowCell4.setText( "Chairperson" );
							            	 	}else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ) {
							            	 		membersec=invitedlist.get(i);
							            	 		thirdRowCell4.setText( "Member Secretary" );
							            	 	}
							            	 	else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CH") ) {
							            	 		thirdRowCell4.setText( "Co-Chairperson" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) {
							            	 		thirdRowCell4.setText( "Member Secretary (Proxy)" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI") || invitedlist.get(i)[3].toString().equalsIgnoreCase("I") ) {
							            	 		thirdRowCell4.setText( "Internal" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("W")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("E")) {
							            	 		thirdRowCell4.setText( "External" );
							            	 	}else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ) {
							            	 		thirdRowCell4.setText( "Presenter" );
							            	 	}else {
							            	 		thirdRowCell4.setText( "REP_"+invitedlist.get(i)[3].toString() );
							            	 	}
							            	 	
							            	 	thirdRowCell4.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.TOP);
							            	 	
							            	 	}
								        		parPresentCount++;
								        	 	}
								        	if(addcount==0){
								        		  String[] ParPresentNil = {"Nil",null,null, null};
										            setTableRowData(table,1,ParPresentNil.length,ParPresentNil);
										            mergrColums(table,numCellsToMerge,parPresentCount);
										            parPresentCount++;
								        		
								        	}
								        	 }
							            if(parAbscent > 0){

								            String[] cellTextsRow3 = {"Other Invitees / Participants Absent",null,null, null};
								            int rowIndex = setTableRowData(table,parPresentCount,cellTextsRow3.length,cellTextsRow3);
								            mergrColums(table,numCellsToMerge,rowIndex);
								            parAbsentCount=rowIndex+1;
					
								        	//int count=0;
								        	for(int i=0;i<invitedlist.size();i++)
								        	 {
								        		if(invitedlist.get(i)[4].toString().equals("N")&& !membertypes.contains( invitedlist.get(i)[3].toString()) )
								        	 	{
								        			count1++; j++;
								        	 	XWPFTableRow thirdRow = table.createRow();
								        	 	createCell(thirdRow,String.valueOf(j),0);
							            	 	createCell(thirdRow,invitedlist.get(i)[6]+" "+invitedlist.get(i)[7],1);
							            	 	createCell(thirdRow, invitedlist.get(i)[11].toString(),2);
								        	 	
							            	 	XWPFTableCell thirdRowCell4 = thirdRow.getCell(3);
							            	 	if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CC")) {
							            	 		thirdRowCell4.setText( "Chairperson" );
							            	 	}else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CS") ) {
							            	 		membersec=invitedlist.get(i);
							            	 		thirdRowCell4.setText( "Member Secretary" );
							            	 	}
							            	 	else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CH") ) {
							            	 		thirdRowCell4.setText( "Co-Chairperson" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("PS") ) {
							            	 		thirdRowCell4.setText( "Member Secretary (Proxy)" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CI") || invitedlist.get(i)[3].toString().equalsIgnoreCase("I") ) {
							            	 		thirdRowCell4.setText( "Internal" );
							            	 	}
							            		else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("CW")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("CO")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("W")|| invitedlist.get(i)[3].toString().equalsIgnoreCase("E")) {
							            	 		thirdRowCell4.setText( "External" );
							            	 	}else if(invitedlist.get(i)[3].toString().equalsIgnoreCase("P") ) {
							            	 		thirdRowCell4.setText( "Presenter" );
							            	 	}else {
							            	 		thirdRowCell4.setText( "REP_"+invitedlist.get(i)[3].toString() );
							            	 	}
							            	 	
							            	 	thirdRowCell4.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.TOP);
							            	 	
							            	 	}
								        		parAbsentCount++;
								        	 	}
								        	if(count1==0){
								        		  String[] ParPresentNil = {"Nil",null,null, null};
										            setTableRowData(table,1,ParPresentNil.length,ParPresentNil);
										            mergrColums(table,numCellsToMerge,parAbsentCount);
										            parAbsentCount++;
								        		
								        	}
								        	 }
							            XWPFParagraph pageBreak2 = doc.createParagraph();
							            pageBreak2.setPageBreak(true);
							            
							            for (Object[] committeemin : committeeminutes) { 
							            	if (committeemin[0].toString().equals("1") ) {
							            		
							            		createParagraph(doc,committeemin[0]+".    "+committeemin[1], "LEFT", true, 11,10);
							            		
							            		int count = 0;

												for (Object[] speclist : speclists)
												{
													if (speclist[3].toString().equals(committeemin[0].toString())) 
													{
														count++;
														createParagraph(doc,speclist[1].toString().replace("<p>", "").replace("</p>", "").replace("&nbsp;", " "), "LEFT", false, 10,100);
													break;
													}
												}if (count == 0) 
												{
													createParagraph(doc,"NIL", "CENTER", false, 10,10);
												}
							            	}else if (committeemin[0].toString().equals("2")) {
							            		createParagraph(doc,committeemin[0]+".    "+committeemin[1], "LEFT", true, 11,10);
							            		
							            		int count = 0;

												for (Object[] speclist : speclists)
												{
													if (speclist[3].toString().equals(committeemin[0].toString())) 
													{
														count++;
														createParagraph(doc,speclist[1].toString().replace("<p>", "").replace("</p>", "").replace("&nbsp;", " "), "LEFT", false, 10,100);
													break;
													}
												}if (count == 0) 
												{
													createParagraph(doc,"NIL", "CENTER", false, 10,10);
												}
					
							            	}else if (committeemin[0].toString().equals("3")) {
							            		createParagraph(doc,"3 (a) Record of Discussions and Action Points of Current Meeting.", "LEFT", true, 11,20);
							            		createParagraph(doc,"             Item Code/Type : A: Action, C: Comment, D: Decision, R: Recommendation", "LEFT", false, 10,30);
							             		

						            		XWPFTable table32 = doc.createTable(1, 3);
						            		
						            		int[] table32ColumnWidths = {7, 10, 83};


						            		String[] table32cellTexts = {"SN", "Type", "Item"};
						            		
						            		setTableRowData(table32,0,table32cellTexts.length,table32cellTexts);
						            		setTableWidth(table32,totalTableWidth,table32ColumnWidths);

						            		 int countcm=0;
												long tempagenda=0;
												for(int k=0;k<speclists.size();k++)
												{ 	if(Integer.parseInt(speclists.get(k)[3].toString())==3||Integer.parseInt(speclists.get(k)[3].toString())==5){
													countcm++;
													if(tempagenda!=Long.parseLong(speclists.get(k)[6].toString())){

								         // Create a new row for the second row
								            XWPFTableRow tableSecondRow = table32.createRow();

								            // Get the cell within the second row and the first column
								            XWPFTableCell tableSecondRowCell = tableSecondRow.getCell(0);

								            tableSecondRowCell.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);

								            // Set cell color (if needed)
								            tableSecondRowCell.setColor("auto");

								            // Get the paragraph within the cell
								            XWPFParagraph paragraphTable32 = tableSecondRowCell.getParagraphs().get(0);

								         // Create a new run within the paragraph
								            XWPFRun run32 = paragraphTable32.createRun();

								            // Set the text for the run
								            run32.setText(speclists.get(k)[10].toString());

								            // Apply bold formatting to the run
								            run32.setBold(true);

								            // Set the alignment of the paragraph to center
								            paragraphTable32.setAlignment(ParagraphAlignment.CENTER);


								            // Merge the second cell with the next cells in the same row
								            int numCellsToMergeInTable = 3; // Specify the number of cells to merge (including the initial cell)
								            for (int i = 1; i < numCellsToMergeInTable; i++) {
								            	tableSecondRowCell.getCTTc().addNewTcPr().addNewGridSpan().setVal(BigInteger.valueOf(numCellsToMergeInTable));
								            }

								            // Get the row and cells in the same row for the next columns
								            XWPFTableRow sameRowTable32 = table32.getRow(table32.getNumberOfRows() - 1);
								            for (int i = 1; i < numCellsToMergeInTable; i++) {
								                XWPFTableCell nextCel32 = sameRowTable32.getCell(1);
								                sameRowTable32.getCtRow().removeTc(sameRowTable32.getTableCells().indexOf(nextCel32));
								            }
								            tempagenda=Long.parseLong(speclists.get(k)[6].toString());
													}
													XWPFTableRow thirdRow = table32.createRow();
													
													createCell(thirdRow,Integer.toString(countcm),0);
													createCell(thirdRow,speclists.get(k)[7].toString(),1);
													createCell(thirdRow,speclists.get(k)[1].toString(),2);
												}
												}
												if(countcm==0){
													 String[] minutessDetails = {"No Minutes details Added",null,null};
											            setTableRowData(table32,1,minutessDetails.length,minutessDetails);
											            numCellsToMerge=3;
											            mergrColums(table32,numCellsToMerge,1);
												}
												
												XWPFParagraph pageBreak3 = doc.createParagraph();
									            pageBreak3.setPageBreak(true);
									            
	// <!-- -------------------------------------------------------members----------------------------- ---------------------------------------------------------->								            
									            createParagraph(doc,committeemin[0] + "(b) " + committeemin[1], "LEFT", true, 11,30);
									            XWPFTable table33 = doc.createTable(1, 6); 
									         
									         XWPFTableRow thirdRow = table33.getRow(0);

									         setTableHeader(thirdRow);

									         mergrColums(table33,6,0);
									    
									         String[] table33cellTexts = {"SN","ID", "Action Point", "PDC", "Responsibility", "Status"};
									         int[] table33ColumnWidths = {8, 16, 33, 20, 15, 8};
									         setTableRowData( table33,1,table33cellTexts.length, table33cellTexts);
									         setTableWidth(table33,totalTableWidth,table33ColumnWidths);
									         if(lastpmrcactions.size()==0){
									             // Get the cell within the second row and the first column
										            String[] pmrcActionNil = {"No Data",null,null,null,null,null};
										            setTableRowData(table33,2,pmrcActionNil.length,pmrcActionNil);
										            numCellsToMerge=6;
										            mergrColums(table33,numCellsToMerge,2);


									         }		else if(lastpmrcactions.size()>0)
												{
													int i=1;String key2="";
													//int maxRowsPerPage = 6; // Adjust this based on your document's layout
											
										
											
													for(Object[] obj:lastpmrcactions){

														XWPFTableRow fifthRow = table33.createRow();
														// Create cells in the fourth row
											        	for (int k = 0; k < 5; k++) {
											        		fifthRow.createCell();
											        	}

														// Create cells for each column
														XWPFTableCell cell1 = fifthRow.getCell(0); // First column
														cell1.setText(String.valueOf(i));
														cell1.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);

												

														// Create seventhRowCell1 and set its text
														XWPFTableCell seventhRowCell1 = fifthRow.getCell(1);
														StringBuilder cellTextBuilder = new StringBuilder();
														if(obj[5]==null) {
															seventhRowCell1.setText("-");
														}else {

															if(committeescheduleeditdata[8].toString().equalsIgnoreCase("PMRC")) {
																for (Map.Entry<Integer, String> entry : mappmrc.entrySet()) {
																	Date date = inputFormat.parse(obj[5].toString().split("/")[3]);
																	 String formattedDate = outputFormat.format(date);
																	 if(entry.getValue().equalsIgnoreCase(formattedDate)){
																		 key2=entry.getKey().toString();
															 		} 
																	 }
																}else{ 
																 for (Map.Entry<Integer, String> entry : mapEB.entrySet()) {
																	Date date = inputFormat.parse(obj[5].toString().split("/")[3]);
																	 String formattedDate = outputFormat.format(date);
																	 if(entry.getValue().equalsIgnoreCase(formattedDate)){
																		 key2=entry.getKey().toString();
																	 }
															 }
																}
														    cellTextBuilder.append(committeescheduleeditdata[8].toString().toUpperCase()+"-"+key2+"/"+obj[5].toString().split("/")[4]);
				
														}

														seventhRowCell1.setText(cellTextBuilder.toString());
														seventhRowCell1.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);

														XWPFTableCell cell3 = fifthRow.getCell(2);
														//cell3.setText(obj[2].toString());

														// Create a paragraph for cell6
														XWPFParagraph paragraph6 = cell3.addParagraph();
														paragraph6.setAlignment(ParagraphAlignment.BOTH);

														 //Now set alignment on the paragraph
														XWPFRun run6 = paragraph6.createRun();
														run6.setText(obj[2].toString());
														String PDC="";
														// Create eigthRowCell1 and set its text
														XWPFTableCell eigthRowCell1 = fifthRow.getCell(3);
														if (obj[8]!= null && !LocalDate.parse(obj[8].toString()).equals(LocalDate.parse(obj[7].toString()))) {
															PDC+= sdf.format(sdf1.parse(obj[8].toString()));
														} 
														if(obj[7]!= null && !LocalDate.parse(obj[7].toString()).equals(LocalDate.parse(obj[6].toString())) ) {
															PDC+= sdf.format(sdf1.parse(obj[7].toString()));
														}
														if(obj[6]!= null) {
															PDC+= sdf.format(sdf1.parse(obj[6].toString()));
														}
														
														 eigthRowCell1.setText(PDC);
//														} else if (obj[3].toString().equals("I")) {
//														    eigthRowCell1.setText("I");
//														} else if (obj[3].toString().equals("R")) {
//														    eigthRowCell1.setText("R");
//														} else if (obj[3].toString().equals("D")) {
//														    eigthRowCell1.setText("D");
//														} else if (obj[3].toString().equals("C")) {
//														    eigthRowCell1.setText("C");
//														} else if (obj[3].toString().equals("K")) {
//														    eigthRowCell1.setText("K");
//														}
														eigthRowCell1.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);

									            	 	
									            		//XWPFTableRow ninthRow = table33.createRow();
									            	 	XWPFTableCell ninthRowCell1 = fifthRow.getCell(4);
									            	 	if(obj[4]!= null){
									            	 	ninthRowCell1.setText( obj[12].toString());
									            	 	}else {
									            	 		ninthRowCell1.setText("NA");
									            	 	}
									            	 	ninthRowCell1.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
									            	 	
									            	 	XWPFTableCell tenthRowCell1 = fifthRow.getCell(5);
									            	 	if (obj[4] != null) {
									            	 	    String actionstatus = obj[10].toString();
									            	 	  
									            	 	    LocalDate pdcorg = LocalDate.parse(obj[6].toString());
									            	 	    LocalDate lastdate = obj[14] != null ? LocalDate.parse(obj[14].toString()) : null;
									            	 	    LocalDate today = LocalDate.now();
									            	 	    String cellText = "";

									            	 	    if (lastdate != null && actionstatus.equalsIgnoreCase("C")) {
									            	 	        if (actionstatus.equals("C") && (pdcorg.isAfter(lastdate) || pdcorg.equals(lastdate))) {
									            	 	            cellText = "CO";
									            	 	        } else if (actionstatus.equals("C") && pdcorg.isBefore(lastdate)) {
									            	 	            cellText = "CD (" + ChronoUnit.DAYS.between(pdcorg, lastdate) + ")";
									            	 	        }
									            	 	    } else {
									            	 	        if (actionstatus.equals("F") && (pdcorg.isAfter(lastdate) || pdcorg.isEqual(lastdate))) {
									            	 	            cellText = "RC";
									            	 	        } else if (actionstatus.equals("F") && pdcorg.isBefore(lastdate)) {
									            	 	            cellText = "FD";
									            	 	        } else if (pdcorg.isAfter(today) || pdcorg.isEqual(today)) {
									            	 	            cellText = "OG";
									            	 	        } else if (pdcorg.isBefore(today)) {
									            	 	            cellText = "DO (" + ChronoUnit.DAYS.between(pdcorg, today) + ")";
									            	 	        }
									            	 	    }

									            	 	   // tenthRowCell1.setText(cellText);

									            	 	    // Create paragraph and run
									            	 	    XWPFParagraph paragraph10 = tenthRowCell1.getParagraphs().get(0);
									            	 	    paragraph10.setAlignment(ParagraphAlignment.BOTH);
									            	 	    XWPFRun run10 = paragraph10.createRun();
									            	 	    run10.setColor("FF0000");
									            	 	   run10.setText(cellText);
									            	 	} else {
									            	 	    tenthRowCell1.setText("NA");
									            	 	}
									            	 	tenthRowCell1.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);


									            	 	i++;
									            	 	
													}
												}
									           
						            	}else if(committeemin[0].toString().equals("4") ) {
						            		createParagraph(doc,"", "LEFT", true, 11,30);
						            		 createParagraph(doc,committeemin[0] + ". " + committeemin[1], "LEFT", true, 11,30);
						            		 
						            		XWPFTable table4 = doc.createTable(1, 7);
									         
									      // Create a new row with the desired number of cells
									         XWPFTableRow thirdRow = table4.getRow(0);
									         setTableHeader(thirdRow);

									         mergrColums(table4,7,0);

									     
									         String[] table43cellTexts = {"MS", "L", "System/Subsystem/Activities ", "PDC", "Progress", "Status","Remarks"};
									         int[] table43ColumnWidths = {8, 8, 35, 12, 15, 10,12};
									         setTableRowData( table4,1,table43cellTexts.length, table43cellTexts);
									         setTableWidth(table4,totalTableWidth,table43ColumnWidths);
		
									         if(MilestoneDetails6 !=null && MilestoneDetails6.size()>0){ 

													int milcountC=1;
													int milcountD=1;
													int milcountE=1;
													for(Object[] obj : MilestoneDetails6){
														if(Integer.parseInt(obj[21].toString())<= Integer.parseInt(LevelId) ){
															XWPFTableRow fourthRow = table4.createRow();
															   for (int i = 1; i < 7; i++) {
																   fourthRow.createCell();
															   }
																	XWPFTableCell cell1 = fourthRow.getCell(0); // First column
																	cell1.setText("M"+obj[0]);
																	cell1.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
																	
																	XWPFTableCell cell2 = fourthRow.getCell(1);
																	if(obj[21].toString().equals("0")) {
					
																		milcountC=1;
																		milcountD=1;
																		milcountE=1;
																	}else if(obj[21].toString().equals("1")) { 
																		for(Map.Entry<Integer,String>entry:treeMapLevOne.entrySet()){
																			if(entry.getKey().toString().equalsIgnoreCase(obj[2].toString())){
																				cell2.setText(entry.getValue());
																			}
																			
																			}}else if(obj[21].toString().equals("2")) { 
																				for(Map.Entry<Integer,String>entry:treeMapLevTwo.entrySet()){
																					if(entry.getKey().toString().equalsIgnoreCase(obj[3].toString())){
																						cell2.setText(entry.getValue());
																					}
																					}}else if(obj[21].toString().equals("3")) {
																						cell2.setText("C-"+milcountC);
																						milcountC+=1;
																						milcountD=1;
																						milcountE=1;
																						}else if(obj[21].toString().equals("4")) {
																							cell2.setText("D-"+milcountD);
																							milcountD+=1;
																							milcountE=1;
																							}else if(obj[21].toString().equals("5")) {
																								cell2.setText("E-"+milcountE);
																								milcountE++;
																	}
																	cell2.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
																	
																	XWPFTableCell cell3 = fourthRow.getCell(2);
																	if(obj[21].toString().equals("0")) {
																		cell3.setText(obj[10].toString());
																	}else if(obj[21].toString().equals("1")) {
																		cell3.setText(obj[11].toString());
																	}else if(obj[21].toString().equals("2")) {
																		cell3.setText(obj[12].toString());
																	}else if(obj[21].toString().equals("3")) {
																		cell3.setText(obj[13].toString());
																	}else if(obj[21].toString().equals("4")) {
																		cell3.setText(obj[14].toString());
																	}else if(obj[21].toString().equals("5")) {
																		cell3.setText(obj[15].toString());
																	}
																	cell3.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
																	
																	createCell(fourthRow,sdf.format(sdf1.parse(obj[9].toString()))+"\n"+sdf.format(sdf1.parse(obj[8].toString())),3);
																	createCell(fourthRow,obj[17].toString(),4);
																	

																	
																	XWPFTableCell cell6 = fourthRow.getCell(5);
																	String cellText = "";
																	cellText+=obj[22].toString();
																	if ( obj[19].toString().equalsIgnoreCase("5") && obj[24] != null) {
																		cellText+="("+ChronoUnit.DAYS.between(LocalDate.parse(obj[9].toString()), LocalDate.parse(obj[24].toString()))+")";
																	} else if (obj[19].toString().equalsIgnoreCase("4")) {
																		cellText+="("+ChronoUnit.DAYS.between(LocalDate.parse(obj[9].toString()), LocalDate.now())+")";
																	}
																	cell6.setText(cellText);
																	cell6.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);

								
																	
																	XWPFTableCell cell7 = fourthRow.getCell(6);
																	if(obj[23]!=null){
																		cell7.setText(obj[23].toString());
																		cell7.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
																		XWPFParagraph paragraph47 = cell7.getParagraphs().get(0);
																		paragraph47.setAlignment(ParagraphAlignment.LEFT);
																		
																	
														}
																	}}
														   } else{
													           String[] pmrcActionNil = {"No SubSystems",null,null,null,null,null,null};
													            setTableRowData(table4,2,pmrcActionNil.length,pmrcActionNil);
													            numCellsToMerge=7;
													            mergrColums(table4,numCellsToMerge,2);															
													}
													}else if (committeemin[0].toString().equals("5") ){
									        
								    				XWPFParagraph pageBreak3 = doc.createParagraph();
										            pageBreak3.setPageBreak(true);
										       	 createParagraph(doc,committeemin[0] + ". " + committeemin[1], "LEFT", true, 11,30);
									        	 createParagraph(doc,"(In \u20B9 Lakhs)", "RIGHT", false, 10,30);
										            
										      		XWPFTable table5 = doc.createTable(1, 7);
							

											         String thirdRowDetails="Demand Details ( > \u20B9 ";
												        
											         if (projectdatadetails != null && projectdatadetails[13] != null) {
											        	 thirdRowDetails+=	 projectdatadetails[13].toString().replaceAll("\\.\\d+$", "")+")";
											         }else {
											        	 thirdRowDetails+=	 "- )";
											         }
											         
											         String[] pmrcActionNil = {thirdRowDetails,null,null,null,null,null,null};
											            setTableRowData(table5,0,pmrcActionNil.length,pmrcActionNil);
											            numCellsToMerge=7;
											            mergrColums(table5,numCellsToMerge,0);
	
	
											            
												         String[] table43cellTexts = {"SN", "Demand No", "Demand Date", "Nomenclature", "Est. Cost", "Status","Remarks"};
												         int[] table51ColumnWidths = {6, 10, 10, 37, 15, 10,12};
												         setTableRowData( table5, 1, table43cellTexts.length, table43cellTexts);
												         setTableWidth(table5,totalTableWidth,table51ColumnWidths);
												         int demandetails=2;
												         int futureCount=0;
												            
												            int k=0;
														    if(procurementOnDemand!=null &&  procurementOnDemand.size()>0){
														    Double estcost=0.0;
														    for(Object[] obj : procurementOnDemand){ 
														    	k++;
																XWPFTableRow fourthRow = table5.createRow();
																// Create cells in the fourth row
													        	for (int i = 0; i < 6; i++) {
													        		fourthRow.createCell();
													        	}
													        	
													           	createCell(fourthRow,String.valueOf(k),0);
													        	createCell(fourthRow,obj[1].toString(),1);
													        	createCell(fourthRow,sdf.format(sdf1.parse(obj[3].toString())),2);
													        	createCell(fourthRow,obj[8].toString(),3);
													        	createCell(fourthRow,format.format(new BigDecimal(obj[5].toString())).substring(1),4);
													        	createCell(fourthRow,obj[10].toString(),5);
													        	createCell(fourthRow,obj[11].toString(),6);

														    	estcost += Double.parseDouble(obj[5].toString());
														    	demandetails++;
														    }
														    
														    String[] DemandDetailsTotal = {"            Total                    "+df.format(estcost),null,null,null,null,null,null};
													          demandetails = setTableRowData(table5,demandetails,DemandDetailsTotal.length,DemandDetailsTotal);
													       //  numCellsToMerge=6;
													         mergrColums(table5,numCellsToMerge+1,demandetails);
														    }else {
														         String[] DemandDetailsNil = {"Nil",null,null,null,null,null,null};
														          demandetails = setTableRowData(table5,demandetails,DemandDetailsNil.length,DemandDetailsNil);
														        // numCellsToMerge=6;
														         mergrColums(table5,numCellsToMerge,demandetails);
														    }
														    
														    
														    String[] futureDemand = {"Future Demand",null,null,null,null,null,null};
												             futureCount = setTableRowData(table5,demandetails+1,futureDemand.length,futureDemand);
												            mergrColums(table5,7,futureCount);
												            futureCount+=1;
												            
												            String[] futureDemand2 = {"SN", "Nomenclature",null, "Est. Cost-Lakh ₹", "Status", "Remarks", null};
													         int[] futureDemandWidths = {6, 10, 15, 20, 15, 10,14};
													          futureCount = setTableRowData( table5, futureCount, futureDemand2.length, futureDemand2);
													         setTableWidth(table5,totalTableWidth,futureDemandWidths);
													         
													         mergeColums(table5,futureCount,5,6);
													         mergeColums(table5,futureCount,1,2);
													         
													         int a=0;
															    if(envisagedDemandlist!=null &&  envisagedDemandlist.size()>0){
															    Double estcost=0.0;
															    for(Object[] obj : envisagedDemandlist){ 
															    	a++;
															    	futureCount++;
															    	XWPFTableRow fourthRow = table5.createRow();
																	// Create cells in the fourth row
														        	for (int i = 0; i < 6; i++) {
														        		fourthRow.createCell();
														        	}
														        	createCell(fourthRow,String.valueOf(a),0);
														        	createCell(fourthRow,obj[3].toString(),1);
														        	createCell(fourthRow,null,2);
														        	createCell(fourthRow,format.format(new BigDecimal(obj[2].toString())).substring(1),3);
														        	createCell(fourthRow,obj[6].toString(),4);
														        	createCell(fourthRow,obj[4].toString(),5);
														        	createCell(fourthRow,"",6);
															    	
															    	estcost += Double.parseDouble(obj[2].toString());
															    	
															    	  mergeColums(table5,futureCount,5,6);
																      mergeColums(table5,futureCount,1,2);
															    	
															    }
															    String[] futureDemandTotal = {"            Total         "+df.format(estcost),null,null,null,null,null,null};
															    futureCount =    setTableRowData(table5,futureCount+1,futureDemandTotal.length,futureDemandTotal);
														        
														         mergrColums(table5,7,futureCount);
															    }else {
															        String[] DemandDetailsNil = {"Nil",null,null,null,null,null,null};
															        futureCount = setTableRowData(table5,futureCount+1,DemandDetailsNil.length,DemandDetailsNil);
															         numCellsToMerge=7;
															         mergrColums(table5,numCellsToMerge,futureCount);
															    }

												            String text55="Orders Placed ( > \u20B9 ";
												            if (projectdatadetails != null && projectdatadetails[13] != null) {
												            	text55+=projectdatadetails[13].toString().replaceAll("\\.\\d+$", "")+")";
												            }else {
												            	text55+="- )";
												            }
												            
												            String[] orderPlced = {text55,null,null,null,null,null,null};
												            int setTableRowData = setTableRowData(table5,futureCount+1,orderPlced.length,orderPlced);
												            mergrColums(table5,numCellsToMerge,setTableRowData);
												            
												            XWPFTableRow sisthRow = table5.createRow();
													         String[] table53cellTexts1 = {"SN", "Demand No", "Demand Date", "Nomenclature", "Est. Cost", "Status","Remarks"};
													         
													          setTableRowData = setTableRowData(table5,setTableRowData+1,table53cellTexts1.length,table53cellTexts1);

													     
						
													         XWPFTableRow seventhRow = table5.createRow();

													         String[] table53cellTexts2 = {"", "Supply Order No", "DP Date", "Vendor Name", "Rev DP", "SO Cost-Lakh", ""};

													         setTableRowData = setTableRowData(table5,setTableRowData+1,table53cellTexts2.length,table53cellTexts2);
													         

													         
													         int Row7 = table5.getRows().indexOf(seventhRow);
													         int Row6 = table5.getRows().indexOf(sisthRow);
													         mergeRows(table5,Row6,Row7,0,0);
													         mergeColums( table5,Row7,5,6);

											
													         
													         if(procurementOnSanction!=null && procurementOnSanction.size()>0){
														    	  k=0;
														    	  Double estcost=0.0;
																  Double socost=0.0;
																  String demand="";
														  	 	   for(Object[] obj:procurementOnSanction){ 
														  	 		 if(obj[2]!=null){ 
														  	 			XWPFTableRow fourthRow = table5.createRow();
														  	 		    if(!obj[1].toString().equals(demand)){
														  	 			k++;
														  	 			List<Object[]> list = procurementOnSanction.stream().filter(e-> e[0].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
														  	 		
																		// Create cells in the fourth row
															        	for (int i = 0; i < 6; i++) {
															        		fourthRow.createCell();
															        	}
															        	
															           	createCell(fourthRow,String.valueOf(k),0);
															        	createCell(fourthRow,obj[1].toString(),1);
															        	createCell(fourthRow,sdf.format(sdf1.parse(obj[3].toString())),2);
															        	createCell(fourthRow,obj[8].toString(),3);
															        	createCell(fourthRow,format.format(new BigDecimal(obj[5].toString())).substring(1),4);
															        	createCell(fourthRow,obj[10].toString(),5);
															        	createCell(fourthRow,obj[11].toString(),6);
																		
																		demand=obj[1].toString();
																		setTableRowData++;
														  	 		    }
														  	 			XWPFTableRow fifthRow1 = table5.createRow();
																		// Create cells in the fourth row
															        	for (int i = 0; i < 6; i++) {
															        		fifthRow1.createCell();
															        	}
															        	
															         	createCell(fifthRow1,"",0);
															        	createCell(fifthRow1,obj[2].toString(),1);
															        	if(obj[4]!=null) {
																        	createCell(fifthRow1,sdf.format(sdf1.parse(obj[4].toString())),2);
																        	}else {
																        		createCell(fifthRow1,"-",2);
																        	}
															        	createCell(fifthRow1,obj[12].toString(),3);
															        	if(obj[7]!=null) {
															        	createCell(fifthRow1,sdf.format(sdf1.parse(obj[7].toString())),4);
															        	}else {
															        		createCell(fifthRow1,"-",4);
															        	}
															        	createCell(fifthRow1,format.format(new BigDecimal(obj[6].toString())).substring(1),5);
															        	createCell(fifthRow1,"",6);
															        	
															        	setTableRowData++;

																         int Row41 = table5.getRows().indexOf(fourthRow);
																         int Row42 = table5.getRows().indexOf(fifthRow1);
																         
																         
																         mergeRows(table5,Row41,Row42,0,0);
																         
																         mergeColums( table5,Row42,5,6 );
								
														  	 		    }
														  	 		Double value = 0.00;
														  	 		if(obj[6]!=null){
														  	 			value=Double.parseDouble(obj[6].toString());
														  	 		}
														  	 		
														  	 		estcost += Double.parseDouble(obj[5].toString());
														  	 		socost +=  value;
														  	 		
														  	 		 }
														  	 	   String[] orderTotal= {"                                                                                                                     Total                                                  "+df.format(estcost),null,null,null,null,null,null};
														  	 	
														  	 	setTableRowData=setTableRowData(table5,setTableRowData+1,orderTotal.length,orderTotal);
														  	 	mergrColums( table5, 7, setTableRowData);
													         }else {
														         String[] OrderDetailsNil = {"Nil",null,null,null,null,null,null};
														         setTableRowData= setTableRowData(table5,setTableRowData+1,OrderDetailsNil.length,OrderDetailsNil);
														         numCellsToMerge=7;
														         mergrColums(table5,numCellsToMerge,setTableRowData);
													         }
//													         
													         createParagraph(doc, "", "CENTER", false, 10, 30);
													         
													         XWPFTable table52 = doc.createTable(1,5);
													         
													         String[] heading = {"Total Summary of Procurement",null,null,null,null};
													         setTableRowData(table52,0,heading.length,heading);
													         numCellsToMerge=5;
													         mergrColums(table52,numCellsToMerge,0);
													         
													         
													         String[] table43cellTexts52 = {"No. of Demand", "Est. Cost", "No. of Orders", "SO Cost", "Expenditure"};
													         int[] table53ColumnWidths52 = {20, 20, 20, 20, 20};
													         setTableRowData(table52,1,table43cellTexts52.length,table43cellTexts52);
											
													         setTableWidth( table52,totalTableWidth,table53ColumnWidths52);


														         if(totaldemand!=null && totaldemand.size()>0){ 
																	 for(TotalDemand obj:totaldemand){
																		 if(obj.getProjectId().equalsIgnoreCase(projectid)){
																			 XWPFTableRow summaryData2 = table52.createRow();
																			 for (int i = 0; i < 4; i++) {
																				 summaryData2.createCell();
																	        	}
																				createCell(summaryData2,obj.getDemandCount(),0);
																	        	createCell(summaryData2,obj.getEstimatedCost(),1);
																	        	createCell(summaryData2,obj.getSupplyOrderCount(),2);
																	        	createCell(summaryData2,obj.getTotalOrderCost(),3);
																	        	createCell(summaryData2,obj.getTotalExpenditure(),4);
																		 }}}else{
																			 String[] summaryNil = {"Nil",null,null,null,null};
																	         setTableRowData(table52,2,summaryNil.length,summaryNil);
																	      
																	         mergrColums(table52,numCellsToMerge,2);
																		 }
														    	
									         }else if (committeemin[0].toString().equals("6") ) {
									        	 
							            	XWPFParagraph pageBreak3 = doc.createParagraph();
								            pageBreak3.setPageBreak(true);
								            
								            createParagraph(doc,committeemin[0] + ". " + committeemin[1], "LEFT", true, 11,100);
								            createParagraph(doc,"(Amount in Crores)", "RIGHT", false, 10,50);
								            
								            if(Long.parseLong(projectid) >0 && projectDetails!=null) {
								            	XWPFTable table6 = doc.createTable(2,14);
								            	
								            	  String[] table6cellTexts = {"Head", "", "Sanction", "", "Expenditure", "", "Out Commitment", "", "Balance", "","DIPL", "","Notional Balance", ""};
											         int[] table6ColumnWidths = {3,10,7,7,7,8,7,7,7,7,7,8,7,7};
											         
								            	
								            	setTableRowData(table6, 0,  table6cellTexts.length,table6cellTexts);
								            	setTableWidth(table6,totalTableWidth, table6ColumnWidths);
								            	for(int i=12,k=13;k>=1;i-=2,k-=2) {
								            	mergeColums(table6,0, i, k );
								            	}
//					
		         
		         String[]   table62cellTexts = {"SN", "Head", "RE", "FE", "RE", "FE", "RE", "FE", "RE", "FE","RE", "FE","RE", "FE"};
		         setTableRowData(table6, 1,  table62cellTexts.length,table62cellTexts);
		         double totReSanctionCost=0,totFESanctionCost=0;
					double totREExpenditure=0,totFEExpenditure=0;
					double totRECommitment=0,totFECommitment=0,totalREDIPL=0,totalFEDIPL=0;
					double totReBalance=0,totFeBalance=0,btotalRe=0,btotalFe=0;
					int count=1;
					int rowCount=1;
					if(projectDetails!=null){
						for(ProjectFinancialDetails projectFinancialDetail:projectDetails){
							XWPFTableRow thirdRow6 = table6.createRow();
							 for (int i = 0; i < 7; i++) {
								 thirdRow6.createCell();
					         }
							 
							 createCell(thirdRow6,String.valueOf(count++),0);
				        	 createCell(thirdRow6,projectFinancialDetail.getBudgetHeadDescription(),1);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getReSanction()),2);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getFeSanction()),3);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getReExpenditure()),4);
					       	 createCell(thirdRow6,df.format(projectFinancialDetail.getFeExpenditure()),5);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getReOutCommitment()),6);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getFeOutCommitment()),7);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getReBalance()+projectFinancialDetail.getReDipl()),8);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getFeBalance()+projectFinancialDetail.getFeDipl()),9);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getReDipl()),10);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getFeDipl()),11);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getReBalance()),12);
				        	 createCell(thirdRow6,df.format(projectFinancialDetail.getFeBalance()),13);
				        	 
				        	 totReSanctionCost+=(projectFinancialDetail.getReSanction());
				        	 totFESanctionCost+=(projectFinancialDetail.getFeSanction());
				        	 totREExpenditure+=(projectFinancialDetail.getReExpenditure());
				        	 totFEExpenditure+=(projectFinancialDetail.getFeExpenditure());
				        	 totRECommitment+=(projectFinancialDetail.getReOutCommitment());
				        	 totFECommitment+=(projectFinancialDetail.getFeOutCommitment());
				        	 btotalRe+=(projectFinancialDetail.getReBalance()+projectFinancialDetail.getReDipl());
				        	 btotalFe+=(projectFinancialDetail.getFeBalance()+projectFinancialDetail.getFeDipl());
				        	 totalREDIPL+=(projectFinancialDetail.getReDipl());
				        	 totalFEDIPL+=(projectFinancialDetail.getFeDipl());
				        	 totReBalance+=(projectFinancialDetail.getReBalance());
				        	 totFeBalance+=(projectFinancialDetail.getFeBalance());
	
							
							rowCount++;
								
						}
					}
					XWPFTableRow totalRow = table6.createRow();
					 for (int i = 0; i < 7; i++) {
						 totalRow.createCell();
			         }
					 
					 createCell(totalRow,"Total",0);
		        	 createCell(totalRow,"",1);
		        	 createCell(totalRow,df.format(totReSanctionCost),2);
		        	 createCell(totalRow,df.format(totFESanctionCost),3);
		        	 createCell(totalRow,df.format(totREExpenditure),4);
			       	 createCell(totalRow,df.format(totFEExpenditure),5);
		        	 createCell(totalRow,df.format(totRECommitment),6);
		        	 createCell(totalRow,df.format(totFECommitment),7);
		        	 createCell(totalRow,df.format(btotalRe),8);
		        	 createCell(totalRow,df.format(btotalFe),9);
		        	 createCell(totalRow,df.format(totalREDIPL),10);
		        	 createCell(totalRow,df.format(totalFEDIPL),11);
		        	 createCell(totalRow,df.format(totReBalance),12);
		        	 createCell(totalRow,df.format(totFeBalance),13);
		        	 
					mergeColums(table6,rowCount+1, 0, 1 );
					
					XWPFTableRow fifthRow6 = table6.createRow();
					 for (int i = 0; i < 7; i++) {
						 fifthRow6.createCell();
			         }
					 createCell(fifthRow6,"GrandTotal",0);
		        	 createCell(fifthRow6,"",1);
		        	 createCell(fifthRow6,df.format(totReSanctionCost+totFESanctionCost),2);
		        	 createCell(fifthRow6,"",3);
		        	 createCell(fifthRow6,df.format(totREExpenditure+totFEExpenditure),4);
			       	 createCell(fifthRow6,"",5);
		        	 createCell(fifthRow6,df.format(totRECommitment+totFECommitment),6);
		        	 createCell(fifthRow6,"",7);
		        	 createCell(fifthRow6,df.format(btotalRe+btotalFe),8);
		        	 createCell(fifthRow6,"",9);
		        	 createCell(fifthRow6,df.format(totalREDIPL+totalFEDIPL),10);
		        	 createCell(fifthRow6,"",11);
		        	 createCell(fifthRow6,df.format(totReBalance+totFeBalance),12);
		        	 createCell(fifthRow6,"",13);
					 
					for(int i=12,k=13;k>=1;i-=2,k-=2) {
		            	mergeColums(table6,rowCount+2, i, k );
		            	}
            }else {
            	createParagraph(doc,"Data Unavailable", "CENTER", true, 11,100);
            }
	         
	         }else if (committeemin[0].toString().equals("7") ) {
	        	 createParagraph(doc,committeemin[0] + ". " + committeemin[1], "LEFT", true, 11,100);
	        	 
	        	 XWPFTable table7 = doc.createTable(1,9);
	        	 
	        	 
	        	 // Create a new row with the desired number of cells
		         XWPFTableRow thirdRow = table7.getRow(0);

		         setTableHeader(thirdRow);
		         mergrColums(table7,9,0);
		         
		         String[] table7cellTexts = {"SN", "MS", "L ", "Action Plan", "Responsibility","PDC","Progress", "Status","Remarks"};
		       //  int[] table7ColumnWidths = {8, 8, 25, 12, 15, 15,7,5,5};
		         totalTableWidth=5000;
		         setTableRowData( table7,1,table7cellTexts.length, table7cellTexts);
		     //    setTableWidth(table7,totalTableWidth,table7ColumnWidths);
				
										         
	         if(ActionPlanSixMonths.size()>0){ 
					long count=1;

					int countC=1;
					int countD=1;
					int countE=1;
					String mainMileStone=null;
	
					if(!ActionPlanSixMonths.isEmpty()){
						mainMileStone=ActionPlanSixMonths.get(0)[0].toString();
	
						
						for(Object[] obj:ActionPlanSixMonths){
							
							if(Integer.parseInt(obj[26].toString())<= Integer.parseInt(LevelId) ){
								 XWPFTableRow fourthRow = table7.createRow();
								 for (int i = 0; i < 8; i++) {
						        		fourthRow.createCell();
						        	}
								 createCell(fourthRow,String.valueOf(count),0);
	
									
									XWPFTableCell cell2 = fourthRow.getCell(1); 
									if(!obj[0].toString().equalsIgnoreCase(mainMileStone)||count1==1){
										
									}
									cell2.setText("M"+obj[22].toString());
									cell2.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
									
									XWPFTableCell cell3 = fourthRow.getCell(2); // First column
									if(obj[26].toString().equals("0")) {
							
										countC=1;
										countD=1;
										countE=1;
									}else if(obj[26].toString().equals("1")) {    
									for (Map.Entry<Integer,String> entry : treeMapLevOne.entrySet()) {
									if(entry.getKey().toString().equalsIgnoreCase(obj[2].toString())){
										cell3.setText(entry.getValue());
									}
									}
			
								    countC=1;
									countD=1;
									countE=1;
								}else if(obj[26].toString().equals("2")) { 
									for(Map.Entry<Integer, String>entry:treeMapLevTwo.entrySet()){
									if(entry.getKey().toString().equalsIgnoreCase(obj[3].toString())){
										cell3.setText(entry.getValue());
									}
										}
									countC=1;
									countD=1;
									countE=1;
									}else if(obj[26].toString().equals("3")) { 
										cell3.setText("C-"+countC);
										countC+=1;
										countD=1;
										countE=1;
										}else if(obj[26].toString().equals("4")) {
											cell3.setText("D-"+countD);
										countD+=1;
										countE=1;
										}else if(obj[26].toString().equals("5")) {
											cell3.setText("E-"+countE);
											countE++;
									}
									
									cell3.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
									
									XWPFTableCell cell4 = fourthRow.getCell(3); // First column
									if(obj[26].toString().equals("0")) {
									cell4.setText(obj[9].toString());
									}else if(obj[26].toString().equals("1")) { 
										cell4.setText(obj[10].toString());
									}else if(obj[26].toString().equals("2")) { 
										cell4.setText(obj[11].toString());
									}else if(obj[26].toString().equals("3")) { 
										cell4.setText(obj[12].toString());
									}else if(obj[26].toString().equals("4")) { 
										cell4.setText(obj[13].toString());
									}else if(obj[26].toString().equals("5")) { 
										cell4.setText(obj[14].toString());
									}
									cell4.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
									
									 createCell(fourthRow,obj[24].toString(),4);
									
									XWPFTableCell cell6 = fourthRow.getCell(5); 
									String cell76=sdf.format(sdf1.parse(obj[8].toString()));
									if(!LocalDate.parse(obj[8].toString()).equals(LocalDate.parse(obj[29].toString()))){ 
										cell76+="\n"+sdf.format(sdf1.parse(obj[29].toString()));
									}
									cell6.setText(cell76);
									cell6.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
									
									createCell(fourthRow,obj[16].toString(),6);
									
									XWPFTableCell cell7 = fourthRow.getCell(7); // First column
									String cell77=obj[27].toString();
									if (obj[20].toString().equalsIgnoreCase("5") && obj[18] != null) {
										cell77+="("+ChronoUnit.DAYS.between(LocalDate.parse(obj[29].toString()), LocalDate.parse(obj[18].toString()))+")";
									}else if (obj[20].toString().equalsIgnoreCase("4")) {
										cell77+="("+ChronoUnit.DAYS.between(LocalDate.parse(obj[29].toString()), LocalDate.now())+")";
									}
									cell7.setText(cell77);
									cell7.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
									
									XWPFTableCell cell8 = fourthRow.getCell(8); // First column
									if(obj[28]!=null){
									cell8.setText(obj[28].toString());
									count1++;mainMileStone=obj[0].toString();
									}else {
										cell8.setText("-");
									}
									cell8.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
									
									
																		
																	
																}
							count++;	}
														}
										         }else {
										             String[] pmrcActionNil = {"Nil",null,null,null,null,null,null,null,null};
											            setTableRowData(table7,2,pmrcActionNil.length,pmrcActionNil);
											            numCellsToMerge=9;
											            mergrColums(table7,numCellsToMerge,2);
										         }
	         						XWPFParagraph pageBreak8 = doc.createParagraph();
	         								pageBreak8.setPageBreak(true); 
									         }else if (committeemin[0].toString().equals("8") || committeemin[0].toString().equals("9") || committeemin[0].toString().equals("10")) {
									        	
										            createParagraph(doc,committeemin[0] + ". " + committeemin[1], "LEFT", true, 11,100);
										            int count = 0;
													
													for (Object[] speclist : speclists)
													{
														if(speclist[3].toString().equals("4") && committeemin[0].toString().equals("8") ) {
															count++;
															createParagraph(doc,speclist[1].toString().replace("<p>", "").replace("</p>", "").replace("&nbsp;", " "), "LEFT", false, 10,150);
														}else if(speclist[3].toString().equals("5") && committeemin[0].toString().equals("9"))
														{
															if(speclist[7].toString().equalsIgnoreCase("R")){ count++;
															createParagraph(doc,"               "+committeemin[0] + ". " +count+"   "+speclist[9], "LEFT", false, 10,50);
															createParagraph(doc,speclist[1].toString().replace("<p>", "").replace("</p>", "").replace("&nbsp;", " "), "LEFT", false, 10,150);
															}
														}
														else if(speclist[3].toString().equals("6") && committeemin[0].toString().equals("10")) 
														{
															count++;
															createParagraph(doc,speclist[1].toString().replace("<p>", "").replace("</p>", "").replace("&nbsp;", " "), "LEFT", false, 10,100);
														}
													}if(count == 0)
													{
														createParagraph(doc,"NIL", "CENTER", false, 10,100);
													}
										            
									         }
							            	
							            	
							            }
							            
							            createParagraph(doc,"           These Minutes are issued with the approval of the Chairperson.", "LEFT", false, 10,150);
							            createParagraph(doc,"Date :", "LEFT", false, 10,100);
							            createParagraph(doc,"Time :", "LEFT", false, 10,100);
							            if(membersec!=null){
							            	createParagraph(doc, membersec[6].toString()+", "+membersec[7].toString(), "RIGHT", false, 10,100);
							            	createParagraph(doc,"(Member Secretary)", "RIGHT", false, 10,150);
							            	createParagraph(doc,"NOTE :  Action item details are enclosed as Annexure - AI.", "LEFT", false, 10,100);
							            }
							            
							            if(actionsdata.size()>=0){
							            	   XWPFParagraph pageBreak8 = doc.createParagraph();
									            pageBreak8.setPageBreak(true); 
							            	createParagraph(doc,"Annexure - AI", "CENTER", true, 12,150);
							            	createParagraph(doc,"ACTION ITEM DETAILS", "CENTER", true, 18,150);
							            	
							            XWPFTable tableA=	doc.createTable(1,5);
							            
							            String[] tableAcellTexts = {"SN", "Action Id ", "Item", "Responsibility","PDC"};
								         int[] tableAColumnWidths = {10, 15, 40, 15, 20};
								         
								         setTableRowData( tableA,0,tableAcellTexts.length, tableAcellTexts);
								         setTableWidth(tableA,totalTableWidth,tableAColumnWidths);
								         AtomicInteger count = new AtomicInteger(1);

								    	actionlist2.forEach((key, values) -> {
								     	    	
								     	    	XWPFTableRow firstRow = tableA.createRow();
								     	    	
								     	    	int currentCount = count.getAndIncrement();
												 
								     	  	 createCell(firstRow,String.valueOf(currentCount),0);
								     	  	int count2=0;
								     	  	for(Object obj[]:values){
								     	  		count2++;
								     	  		if(count2==1) {
								     	  		if(obj[3]!=null) {
													 createCell(firstRow,obj[3].toString(),1);
								     	  		}else {
								     	  			createCell(firstRow,"-",1);
								     	  		}
								     	  		}else if(count2==values.size() ){
								     	  			if(obj[3]!=null) {
														 createCell2(firstRow,obj[3].toString(),1);
									     	  		}else {
									     	  			createCell(firstRow,"-",1);
									     	  		}
								     	  		}
													
								     	  	}
								     	   createCell(firstRow,values.get(0)[1].toString(),2);
											 int count3=0;
											 for(Object obj[]:values){
												 if(obj[13]!=null){
													 String data=obj[13]+" "+obj[14] ;
													 if(count3>=0 && count3<values.size()-1){
														data+=", ";
													 }
													 createCell(firstRow,data,3);
												 }
												 count3++;
												 }
											 if( values.get(0)[5]!=null){ 
												 try {
													createCell(firstRow,sdf.format(sdf1.parse(values.get(0)[5].toString())),4);
												} catch (ParseException e) {
													// TODO Auto-generated catch block
													e.printStackTrace();
												}
											 } else {
												 createCell(firstRow,"-",4);
											 }
											});
							            }
								 	    String minutesFilePath = env.getProperty("ApplicationFilesDrive");
								 	    String outputPath = minutesFilePath + "/" + filename + ".docx";
								 	    FileOutputStream out = new FileOutputStream(outputPath);
								 	    doc.write(out);
								 	    out.close();

								 	    // Set response headers
								 	    res.setContentType("application/msword");
								 	    res.setHeader("Content-Disposition", "inline; filename=" + filename + ".docx");

								 	    // Stream the Word document to the response
								 	    FileInputStream in = new FileInputStream(outputPath);
								 	    byte[] buffer = new byte[4096];
								 	    int length;
								 	    while ((length = in.read(buffer)) > 0) {
								 	        res.getOutputStream().write(buffer, 0, length);
								 	    }
								 	    in.close();

								 	} catch (Exception e) {
								 	    e.printStackTrace();
								 	}


								 	long endTime = System.currentTimeMillis();
								 	long executionTime = endTime - startTime;
								 	System.out.println("executionTime---------- "+executionTime);
				
			}
								 	
				}
			catch (Exception e) 
			{
				e.printStackTrace(); 
				logger.error(new Date() +"Inside CommitteeMinutesNewWordDownload.htm "+UserId,e);
			}
		}			
	
		
}
