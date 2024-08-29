package com.vts.pfms.ccm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.PfmsFileUtils;
import com.vts.pfms.ccm.model.CCMAchievements;
import com.vts.pfms.ccm.service.CCMService;
import com.vts.pfms.committee.dto.CommitteeMembersEditDto;
import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.committee.model.CommitteeScheduleAgenda;
import com.vts.pfms.committee.service.CommitteeService;
import com.vts.pfms.print.service.PrintService;
import com.vts.pfms.utils.PMSLogoUtil;

@Controller
public class CCMController {

	private static final Logger logger = LogManager.getLogger(CCMController.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf = fc.getRegularDateFormat();
	
	@Autowired
	CCMService service;
	
	@Autowired
	CommitteeService committeeservice;
	
	@Autowired
	PrintService printservice;
	
	@Autowired
	PfmsFileUtils pfmsFileUtils;
	
	@Autowired
	PMSLogoUtil LogoUtil;
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Value("${File_Size}")
	String file_size;
	
	@RequestMapping(value="CCMModules.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public String ccmModules(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +" Inside CCMModules.htm "+UserId);
		try {
			
			req.setAttribute("committeeId", String.valueOf(service.getCommitteeIdByCommitteeCode("CCM")));
			req.setAttribute("committeeMainId", String.valueOf(service.getCommitteeMainIdByCommitteeCode("CCM")));
			return "ccm/CCMModules";
		}catch (Exception e) {
			logger.error(new Date() +" Inside CCMModules.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CCMCommitteeConstitution.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public String ccmCommitteeConstitution(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +" Inside CCMCommitteeConstitution.htm "+UserId);
		try {
			String committeeMainId = req.getParameter("committeeMainId");
			String committeeId = req.getParameter("committeeId");
			
			req.setAttribute("allLabList", committeeservice.AllLabList());
			req.setAttribute("employeeList", committeeservice.EmployeeListWithoutMembers(committeeMainId,labcode));
			req.setAttribute("employeeList1", committeeservice.EmployeeListNoMembers(labcode,committeeMainId));
			req.setAttribute("expertList", committeeservice.ExternalMembersNotAddedCommittee(committeeMainId));
			req.setAttribute("committeeMembersAll", committeeservice.CommitteeAllMembersList(committeeMainId));
			req.setAttribute("committeeMainId", committeeMainId);
			req.setAttribute("committeeId", committeeId);
			
			return "ccm/CCMCommitteeConstitution";
		}catch (Exception e) {
			logger.error(new Date() +" Inside CCMCommitteeConstitution.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CCMCommitteeSubmit.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public String ccmCommitteeSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +" Inside CCMCommitteeConstitution.htm "+UserId);
		try {
			String action = req.getParameter("action");
			
			CommitteeMembersEditDto dto=new CommitteeMembersEditDto();
			
			dto.setChairperson(req.getParameter("chairperson"));
			dto.setSecretary(req.getParameter("Secretary"));
			dto.setProxysecretary(req.getParameter("proxysecretary"));
			dto.setSesLabCode(labcode);
			dto.setCpLabCode(req.getParameter("CpLabCode"));
			dto.setCommitteemainid(req.getParameter("committeemainid"));
			dto.setChairpersonmemid(req.getParameter("cpmemberid"));
			dto.setSecretarymemid(req.getParameter("msmemberid"));
			dto.setProxysecretarymemid(req.getParameter("psmemberid"));			
			dto.setModifiedBy(UserId);		
			dto.setCo_chairperson(req.getParameter("co_chairperson"));
			dto.setComemberid(req.getParameter("comemberid"));
			dto.setMsLabCode(req.getParameter("msLabCode"));
			dto.setCommitteeId(req.getParameter("committeeId"));
			long result = service.ccmCommitteeMainMembersSubmit(dto, action);
			
			if(result!=0) {
				redir.addAttribute("result", "Committee Main Members "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Committee Main Members "+action+" UnSuccessful");
			}
			
			redir.addAttribute("committeeMainId", result);
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			return "redirect:/CCMCommitteeConstitution.htm";
			
		}catch (Exception e) {
			logger.error(new Date() +" Inside CCMCommitteeConstitution.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CCMSchedule.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public String ccmSchedule(Model model, HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		String labcode = (String)ses.getAttribute("labcode");
		String Logintype= (String)ses.getAttribute("LoginType");
		logger.info(new Date() +" Inside CCMSchedule.htm "+UserId);
		try {
			
			String tabId = req.getParameter("tabId");
			String monthyear = req.getParameter("monthyear");
			String monthyeartext = "";
			String ccmScheduleId = req.getParameter("ccmScheduleId");
			
			LocalDate selectedDate = monthyear==null?LocalDate.now():LocalDate.parse(fc.calendarDateTosdf(monthyear));
			monthyeartext = selectedDate.getMonth()+" "+selectedDate.getYear();
			
			String selectedMonthStartDate = selectedDate.with(TemporalAdjusters.firstDayOfMonth()).toString();
			String selectedMonthEndDate = selectedDate.with(TemporalAdjusters.lastDayOfMonth()).toString();
			
			req.setAttribute("ccmScheduleList", service.getScheduleListByYear(selectedDate.getYear()+""));
			req.setAttribute("tabId", tabId==null?"1":tabId);
			req.setAttribute("monthyear", monthyear==null?fc.sdfTocalendarDate(selectedDate.toString()):monthyear);
			req.setAttribute("monthyeartext", monthyeartext);
			req.setAttribute("selectedDate", selectedDate);
			req.setAttribute("selectedMonthStartDate", selectedMonthStartDate);
			req.setAttribute("selectedMonthEndDate", selectedMonthEndDate);
			
			req.setAttribute("allLabList", committeeservice.AllLabList());
			req.setAttribute("labEmpList", committeeservice.PreseneterForCommitteSchedule(labcode));
			req.setAttribute("labcode", labcode);
			req.setAttribute("committeeMainId", req.getParameter("committeeMainId"));
			req.setAttribute("committeeId", req.getParameter("committeeId"));
			req.setAttribute("committeeFlag", req.getParameter("committeeFlag"));
			
			if(ccmScheduleId!=null) {
				req.setAttribute("agendaList", service.getCCMScheduleAgendaListByCCMScheduleId(ccmScheduleId));
				req.setAttribute("ccmScheduleId", ccmScheduleId);
				Map md=model.asMap();
				if(Logintype.equalsIgnoreCase("A") || Logintype.equalsIgnoreCase("Z") || Logintype.equalsIgnoreCase("C")|| Logintype.equalsIgnoreCase("I")) 
				{
					if(md.get("otp")!=null) {
						req.setAttribute("otp", md.get("otp"));
					}
				}
				
				req.setAttribute("committeeinvitedlist", committeeservice.CommitteeAtendance(ccmScheduleId));	
			}
			
			return "ccm/CCMSchedule";
		}catch (Exception e) {
			logger.error(new Date() +" Inside CCMSchedule.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CCMScheduleDetailsSubmit.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public String ccmScheduleDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside CCMScheduleDetailsSubmit.htm "+UserId);
		try {
			
			String ccmScheduleId = req.getParameter("ccmScheduleId");
			String meetingDate = req.getParameter("meetingDate");
			String action = req.getParameter("action");
			
			CommitteeSchedule schedule = service.getCCMScheduleById(ccmScheduleId);
			
			schedule.setScheduleDate(new java.sql.Date(rdf.parse(meetingDate.substring(0,10)).getTime()));
			schedule.setScheduleStartTime(meetingDate.substring(11,16));
			schedule.setMeetingVenue(req.getParameter("meetingVenue"));
			schedule.setModifiedBy(UserId);
			schedule.setModifiedDate(sdtf.format(new Date()));
			
			long result = service.addCCMSchedule(schedule);
			
			if(result!=0) {
				redir.addAttribute("result", "Schedule Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Schedule Details "+action+" UnSuccessful");
			}
			
			redir.addAttribute("ccmScheduleId", ccmScheduleId);
			redir.addAttribute("tabId", req.getParameter("tabId"));
			redir.addAttribute("monthyear", req.getParameter("monthyear"));
			return "redirect:/CCMSchedule.htm";
		}catch (Exception e) {
			logger.error(new Date() +" Inside CCMScheduleDetailsSubmit.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CCMAgendaDetailsSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String ccmAgendaDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
	        @RequestParam Map<String, MultipartFile> fileMap) throws Exception {
	    String UserId = (String)ses.getAttribute("Username");
	    String labcode = (String)ses.getAttribute("labcode");
	    logger.info(new Date() + " Inside CCMAgendaDetailsSubmit.htm " + UserId);

	    try {
	    	
	    	String ccmScheduleId = req.getParameter("ccmScheduleId");
	    	if(ccmScheduleId.equalsIgnoreCase("0")) {
				String meetingDate = req.getParameter("meetingDate");
				
				CommitteeSchedule schedule = new CommitteeSchedule();
				schedule.setScheduleDate(new java.sql.Date(rdf.parse(meetingDate.substring(0,10)).getTime()));
				schedule.setScheduleStartTime(meetingDate.substring(11,16));
				schedule.setMeetingVenue(req.getParameter("meetingVenue"));
				schedule.setLabCode(labcode);
				schedule.setCommitteeId(Long.parseLong(req.getParameter("committeeId")));
				schedule.setCommitteeMainId(Long.parseLong(req.getParameter("committeeMainId")));
				schedule.setConfidential(4);
				schedule.setScheduleType("C");
				schedule.setScheduleFlag("MSC");
				schedule.setCreatedBy(UserId);
				schedule.setCreatedDate(sdtf.format(new Date()));
				schedule.setIsActive(1);
				
				ccmScheduleId = String.valueOf(service.addCCMSchedule(schedule));
				
	    	}
			
	        long result = service.addCCMAgendaDetails(req, ses, fileMap, ccmScheduleId);

	        if (result != 0) {
	            redir.addAttribute("result", "Agenda Details submitted successfully");
	        } else {
	            redir.addAttribute("resultfail", "Agenda Details submission unsuccessful");
	        }

	        redir.addAttribute("ccmScheduleId", ccmScheduleId);
			redir.addAttribute("tabId", req.getParameter("tabId"));
			redir.addAttribute("monthyear", req.getParameter("monthyear"));
			redir.addAttribute("committeeMainId", req.getParameter("committeeMainId"));
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
	        return "redirect:/CCMSchedule.htm";

	    } catch (Exception e) {
	        logger.error(new Date() + " Inside CCMAgendaDetailsSubmit.htm " + UserId, e);
	        e.printStackTrace();
	        return "static/Error";
	    }
	}

	@RequestMapping(value = "CCMScheduleAgendaFileDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void projectClosureACPTrialResultsFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CCMScheduleAgendaFileDownload.htm "+UserId);
		try
		{
			String scheduleAgendaId =req.getParameter("scheduleAgendaId");
			String count =req.getParameter("count");
			String subCount =req.getParameter("subCount");
			CommitteeScheduleAgenda agenda = service.getCCMScheduleAgendaById(scheduleAgendaId);
			res.setContentType("Application/octet-stream");	
			

			String file = agenda.getFileName();
			String fileExtention = "."+ (file.split("\\.")[1]);
			String filePath = uploadpath+labcode +"\\CCM\\";
			String fileName = "Annex-"+(count)+(subCount!=null && !subCount.equalsIgnoreCase("0")?("-"+subCount):"");
			
			if(fileExtention.equalsIgnoreCase(".pdf"))
			pfmsFileUtils.addWatermarktoCCMPdf(filePath +File.separator+ file,filePath +File.separator+ file+"(1)", fileName);
			
			File my_file = null;
			Path filepath = Paths.get(filePath, file);
			my_file = filepath.toFile();
	        res.setHeader("Content-disposition","inline; filename="+fileName+fileExtention);
	        String mimeType = getEnoteMimeType(my_file.getName()); 
	        res.setContentType(mimeType);
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
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +"Inside CCMScheduleAgendaFileDownload.htm "+UserId,e);
		}
	}
	
	@RequestMapping(value = "CCMScheduleAgendaEdit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String ccmScheduleAgendaEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,  
			@RequestPart(name="attachment", required = false) MultipartFile attachment) throws Exception {
		
		String UserId = (String)ses.getAttribute("Username");
	    String labcode = (String)ses.getAttribute("labcode");
	    logger.info(new Date() + " Inside CCMScheduleAgendaEdit.htm " + UserId);
		try {
			
			CommitteeScheduleAgenda agenda = service.getCCMScheduleAgendaById(req.getParameter("scheduleAgendaId"));
			int orgDuration = agenda.getDuration();
			//agenda.setAgendaPriority(Integer.parseInt(req.getParameter("agendaPriority")));
			agenda.setAgendaItem(req.getParameter("agendaItem"));
			agenda.setPresentorLabCode(req.getParameter("prepsLabCode"));
			agenda.setPresenterId(Long.parseLong(req.getParameter("presenterId")));
			agenda.setDuration(Integer.parseInt(req.getParameter("duration")));
			agenda.setModifiedBy(UserId);
			agenda.setModifiedDate(sdtf.format(new Date()));
			
			long result = service.addCCMScheduleAgenda(agenda, attachment, labcode, orgDuration);
			
			if (result != 0) {
				redir.addAttribute("result", "Agenda Details Updated successfully");
			} else {
				redir.addAttribute("resultfail", "Agenda Details Update unsuccessful");
			}
			 
			redir.addAttribute("ccmScheduleId", req.getParameter("ccmScheduleId"));
			redir.addAttribute("tabId", req.getParameter("tabId"));
			redir.addAttribute("monthyear", req.getParameter("monthyear"));
			redir.addAttribute("committeeMainId", req.getParameter("committeeMainId"));
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			return "redirect:/CCMSchedule.htm";
		}catch (Exception e) {
	        logger.error(new Date() + " Inside CCMScheduleAgendaEdit.htm " + UserId, e);
	        e.printStackTrace();
	        return "static/Error";
	    }
	}
	
	@RequestMapping(value="CCMMainAgendaPriorityUpdate.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String ccmScheduleAgendaEdit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
	    logger.info(new Date() + " Inside CCMScheduleAgendaEdit.htm " + UserId);
		try {
			
			String[] scheduleAgendaId = req.getParameter("scheduleAgendaId")!=null?req.getParameter("scheduleAgendaId").split(","):null;
			String[] agendaPriority = req.getParameter("agendaPriority")!=null?req.getParameter("agendaPriority").split(","):null;
			
			Long result = service.ccmAgendaPriorityUpdate(scheduleAgendaId, agendaPriority);
			
			if (result != 0) {
				redir.addAttribute("result", "Main Agenda Priority Updated successfully");
			} else {
				redir.addAttribute("resultfail", "Main Agenda Priority Update unsuccessful");
			}
			
			redir.addAttribute("ccmScheduleId", req.getParameter("ccmScheduleId"));
			redir.addAttribute("tabId", req.getParameter("tabId"));
			redir.addAttribute("monthyear", req.getParameter("monthyear"));
			redir.addAttribute("committeeMainId", req.getParameter("committeeMainId"));
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			return "redirect:/CCMSchedule.htm";
		}catch (Exception e) {
	        logger.error(new Date() + " Inside CCMScheduleAgendaEdit.htm " + UserId, e);
	        e.printStackTrace();
	        return "static/Error";
	    }
	}
	
	@RequestMapping(value = "CCMScheduleAgendaDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String ccmScheduleAgendaDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CCMScheduleAgendaDelete.htm "+UserId);
		try
		{
			String scheduleAgendaId = req.getParameter("scheduleAgendaId");
			String ccmScheduleId = req.getParameter("ccmScheduleId");
			String agendaPriority = req.getParameter("agendaPriority");
	
			long result = service.ccmScheduleAgendaDelete(scheduleAgendaId, UserId, ccmScheduleId, agendaPriority);
			if (result != 0) {
				redir.addAttribute("result", " Agenda Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Agenda Delete Unsuccessful");
			}
	
			redir.addAttribute("ccmScheduleId", ccmScheduleId);
			redir.addAttribute("tabId", req.getParameter("tabId"));
			redir.addAttribute("monthyear", req.getParameter("monthyear"));
			redir.addAttribute("committeeMainId", req.getParameter("committeeMainId"));
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			return "redirect:/CCMSchedule.htm";
		}catch (Exception e) {
	        logger.error(new Date() + " Inside CCMScheduleAgendaEdit.htm " + UserId, e);
	        e.printStackTrace();
	        return "static/Error";
	    }
	}
	
	@RequestMapping(value = "CCMScheduleSubAgendaSubmit.htm", method = {RequestMethod.POST, RequestMethod.GET})
	public String ccmScheduleSubAgendaSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
			@RequestPart(name="attachment", required = false) MultipartFile[] attachments) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CCMScheduleSubAgendaSubmit.htm "+UserId);
		try
		{
			
			long result = service.addCCMAgendaDetails(req, ses, attachments);
			
			if (result != 0) {
				redir.addAttribute("result", "Sub Agenda Details Submitted successfully");
			} else {
				redir.addAttribute("resultfail", "Sub Agenda Details Submitted unsuccessful");
			}
			
			redir.addAttribute("ccmScheduleId", req.getParameter("ccmScheduleId"));
			redir.addAttribute("tabId", req.getParameter("tabId"));
			redir.addAttribute("monthyear", req.getParameter("monthyear"));
			redir.addAttribute("committeeMainId", req.getParameter("committeeMainId"));
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			return "redirect:/CCMSchedule.htm";
		}catch (Exception e) {
	        logger.error(new Date() + " Inside CCMScheduleSubAgendaSubmit.htm " + UserId, e);
	        e.printStackTrace();
	        return "static/Error";
	    }
	}
	
	@RequestMapping(value = "CCMScheduleSubAgendaDelete.htm", method = {RequestMethod.POST, RequestMethod.GET})
	public String ccmScheduleSubAgendaDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CCMScheduleSubAgendaDelete.htm "+UserId);
		try
		{
			String scheduleAgendaId = req.getParameter("scheduleAgendaId");
			String ccmScheduleId = req.getParameter("ccmScheduleId");
			String agendaPriority = req.getParameter("agendaPriority");
			String parentScheduleAgendaId = req.getParameter("parentScheduleAgendaId");
			
			int result = service.ccmScheduleSubAgendaDelete(scheduleAgendaId, UserId, ccmScheduleId, agendaPriority, parentScheduleAgendaId);
			if (result != 0) {
				redir.addAttribute("result", "Sub Agenda Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Sub Agenda Delete Unsuccessful");
			}
			
			redir.addAttribute("ccmScheduleId", ccmScheduleId);
			redir.addAttribute("tabId", req.getParameter("tabId"));
			redir.addAttribute("monthyear", req.getParameter("monthyear"));
			redir.addAttribute("committeeMainId", req.getParameter("committeeMainId"));
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			return "redirect:/CCMSchedule.htm";
		}catch (Exception e) {
	        logger.error(new Date() + " Inside CCMScheduleSubAgendaDelete.htm " + UserId, e);
	        e.printStackTrace();
	        return "static/Error";
	    }
	}
	
	@RequestMapping(value="CCMScheduleAgendaPdfDownload.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public void ccmScheduleAgendaPdfDownload(HttpServletRequest req, HttpSession ses,HttpServletResponse res) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() + " Inside CCMScheduleAgendaPdfDownload.htm "+UserId);
		try {
			String ccmScheduleId = req.getParameter("ccmScheduleId");
			
			if(ccmScheduleId!=null) {
				req.setAttribute("ccmScheduleData", service.getCCMScheduleById(ccmScheduleId));
				req.setAttribute("agendaList", service.getCCMScheduleAgendaListByCCMScheduleId(ccmScheduleId));
				req.setAttribute("ccmScheduleId", ccmScheduleId);
			}
			
			String filename="CCM_Agenda";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/CCMScheduleAgendaDownload.jsp").forward(req, customResponse);
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
			
		}catch (Exception e) {
			logger.error(new Date() +" Inside CCMScheduleAgendaPdfDownload.htm "+UserId, e);
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="CCMAgendaPresentation.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ccmAgendaPresentation(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)	throws Exception 
	{
    	String UserId = (String) ses.getAttribute("Username");
    	String labcode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside CCMAgendaPresentation.htm "+UserId);		
    	try {
    		String ccmScheduleId = req.getParameter("ccmScheduleId");

    		req.setAttribute("ccmScheduleData", service.getCCMScheduleById(ccmScheduleId));
	    	req.setAttribute("labInfo", printservice.LabDetailes(labcode));
	    	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(labcode));
	    	req.setAttribute("drdologo", LogoUtil.getDRDOLogoAsBase64String());
	    	req.setAttribute("agendaList", service.getCCMScheduleAgendaListByCCMScheduleId(ccmScheduleId));
	    	
	    	return "ccm/CCMAgendaPresentation";
    	}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside CCMAgendaPresentation.htm  "+UserId, e); 
			return "static/Error";
			
		}
	}
	
    private String getEnoteMimeType(String filename) {
	    String extension = filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
	    switch (extension) {
	        case "pdf":
	            return "application/pdf";
	        case "doc":
	            return "application/msword";
	        case "docx":
	            return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
	        case "xls":
	            return "application/vnd.ms-excel";
	        case "xlsx":
	            return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
	        case "png":
	            return "application/png";
	        default:
	            return "application/octet-stream";
	    }
	}
	
    @RequestMapping(value="CCMPresentation.htm", method= {RequestMethod.POST, RequestMethod.GET})
    public String ccmPresentation(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
    	String UserId = (String) ses.getAttribute("Username");
    	String labcode = (String)ses.getAttribute("labcode");
    	String clusterid = (String)ses.getAttribute("clusterid");
    	logger.info(new Date()+" Inside CCMPresentation.htm "+UserId);
    	try {
    		String committeeId = req.getParameter("committeeId");
    		String tabName = req.getParameter("tabName")!=null?req.getParameter("tabName"):"ATR";
    		
			/* ----------------------- ATR Start -------------------------- */
    		if(tabName.equalsIgnoreCase("ATR")) {
    			
    			Long scheduleId = service.getSecondLatestScheduleId("C");
    			scheduleId = scheduleId!=null?scheduleId:0L;
    			List<Object[]> ReviewMeetingList = printservice.ReviewMeetingList("0", "CCM");
    			Map<Integer,String> mapCCM = new HashMap<>();
         		int ccmCount=0;

         		for (Object []obj:ReviewMeetingList) {
         			mapCCM.put(++ccmCount, obj[3].toString());
         		}
         		
    			req.setAttribute("committeeData", printservice.getCommitteeData(committeeId));
    			req.setAttribute("ccmActions", printservice.LastPMRCActions("0", committeeId));
        		req.setAttribute("latestScheduleMinutesIds", service.getLatestScheduleMinutesIds(scheduleId+""));
        		req.setAttribute("ccmSchedule", service.getCCMScheduleById(scheduleId+""));
         		req.setAttribute("mapCCM", mapCCM);
         		
    		}
    		/* -----------------------  ATR End -------------------------- */
    		
    		/* ----------------------- DMC Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("DMC")) {
    			
    			String committeeIdDMC = service.getCommitteeIdByCommitteeCode("DMC")+"";
    			if(committeeIdDMC==null || (committeeIdDMC!=null && committeeIdDMC.isEmpty())) {
    				committeeIdDMC = "0";
    			}
    			Long scheduleId = service.getLatestScheduleId("D");
    			scheduleId = scheduleId!=null?scheduleId:0L;
    			List<Object[]> ReviewMeetingList = printservice.ReviewMeetingList("0", "DMC");
    			Map<Integer,String> mapDMC = new HashMap<>();
         		int ccmCount=0;

         		for (Object []obj:ReviewMeetingList) {
         			mapDMC.put(++ccmCount, obj[3].toString());
         		}
         		
    			req.setAttribute("committeeData", printservice.getCommitteeData(committeeIdDMC));
    			req.setAttribute("dmcActions", printservice.LastPMRCActions("0", committeeIdDMC));
        		req.setAttribute("latestScheduleMinutesIds", service.getLatestScheduleMinutesIds(scheduleId+""));
        		req.setAttribute("dmcSchedule", service.getCCMScheduleById(scheduleId+""));
         		req.setAttribute("mapDMC", mapDMC);
    			req.setAttribute("committeeIdDMC", committeeIdDMC);
    			req.setAttribute("committeeMainId", service.getCommitteeMainIdByCommitteeCode("DMC")+"");
    			
    		}
    		/* ----------------------- DMC End -------------------------- */

    		/* ----------------------- EB Calendar Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("EB Calendar")) {
    			
    		}
    		/* ----------------------- EB Calendar End -------------------------- */
    		
    		/* ----------------------- PMRC Calendar Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("PMRC Calendar")) {
    			
    		}
    		/* ----------------------- PMRC Calendar End -------------------------- */
    		
    		/* ----------------------- ASP Status Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("ASP Status")) {
    			
    		}
    		/* ----------------------- ASP Status End -------------------------- */
    		
    		/* ----------------------- Project Closure Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("Project Closure")) {
    			
    		}
    		/* ----------------------- Project Closure End -------------------------- */
    		
    		/* ----------------------- Cash Out Go Status Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("Cash Out Go Status")) {
    			
    		}
    		/* ----------------------- Cash Out Go Status End -------------------------- */
    		
    		/* ----------------------- Test & Trials Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("Test & Trials")) {
    			
    		}
    		/* ----------------------- Test & Trials End -------------------------- */
    		
    		/* ----------------------- Achievements Start -------------------------- */
    		else if (tabName.equalsIgnoreCase("Achievements")) {
    			Long scheduleId = service.getLatestScheduleId("C");
    			req.setAttribute("ccmAchievementsList", service.getCCMAchievementsByScheduleId(scheduleId));
    			req.setAttribute("scheduleId", scheduleId+"");
    		}
    		/* ----------------------- Achievements End -------------------------- */
    		
    		req.setAttribute("clusterLabList", service.getClusterLabListByClusterId(clusterid));
    		req.setAttribute("committeeId", committeeId);
    		req.setAttribute("tabName", tabName);
    		req.setAttribute("filesize",file_size);
    		
    		return "ccm/CCMPresentation";
    	}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMPresentation.htm  "+UserId, e); 
			return "static/Error";
		}
    }
    
    @RequestMapping(value="DCMScheduleDetailsSubmit.htm", method= {RequestMethod.POST, RequestMethod.GET})
    public String dcmScheduleDetailsSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
	    String UserId = (String)ses.getAttribute("Username");
	    String labcode = (String)ses.getAttribute("labcode");
	    logger.info(new Date() + " Inside DCMScheduleDetailsSubmit.htm " + UserId);
	    
	    try {
	    	String meetingDate = req.getParameter("meetingDate");
	    	String action = req.getParameter("action");
	    	String committeeScheduleId = req.getParameter("committeeScheduleId");
			
			CommitteeSchedule schedule = action!=null && action.equalsIgnoreCase("Edit")?service.getCCMScheduleById(committeeScheduleId):new CommitteeSchedule();
			schedule.setScheduleDate(new java.sql.Date(rdf.parse(meetingDate).getTime()));
			
			if(action!=null && action.equalsIgnoreCase("Add")) {
				schedule.setScheduleStartTime("10:00:00");
				schedule.setMeetingVenue("NIL");
				schedule.setLabCode(labcode);
				schedule.setCommitteeId(Long.parseLong(req.getParameter("committeeIdDMC")));
				schedule.setCommitteeMainId(Long.parseLong(req.getParameter("committeeMainId")));
				schedule.setConfidential(4);
				schedule.setScheduleType("D");
				schedule.setScheduleFlag("MKV");
				schedule.setCreatedBy(UserId);
				schedule.setCreatedDate(sdtf.format(new Date()));
				schedule.setIsActive(1);
			}else {
				schedule.setModifiedBy(UserId);
				schedule.setModifiedDate(sdtf.format(new Date()));
			}
			
			long result = service.addCCMSchedule(schedule);
			if(result!=0) {
				redir.addAttribute("result", "Schedule Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Schedule Details "+action+" UnSuccessful");
			}
			
			redir.addAttribute("committeescheduleid", String.valueOf(result));
			redir.addAttribute("dmcFlag", "Y");
			redir.addAttribute("committeeId", req.getParameter("committeeIdDMC"));
			
			return "redirect:/CommitteeScheduleMinutes.htm";
	    }catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside DCMScheduleDetailsSubmit.htm  "+UserId, e); 
			return "static/Error";
		}
    }
    
    @RequestMapping(value="CCMAchievementSubmit.htm", method= {RequestMethod.POST, RequestMethod.GET})
    public String ccmAchievementSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
    	String UserId = (String)ses.getAttribute("Username");
	    String labcode = (String)ses.getAttribute("labcode");
	    logger.info(new Date() + " Inside CCMAchievementSubmit.htm " + UserId);
	    
	    try {
	    	String action = req.getParameter("action");
	    	String achievementId = req.getParameter("achievementId");
	    	
	    	CCMAchievements  achmnts = action.equalsIgnoreCase("Add")? new CCMAchievements() : service.getCCMAchievementsById(achievementId);
	    	achmnts.setScheduleId(Long.parseLong(req.getParameter("scheduleId")));
	    	achmnts.setAchievement(req.getParameter("achievement"));
	    	if(action.equalsIgnoreCase("Add")) {
	    		achmnts.setLabCode(req.getParameter("labCode"));
	    		achmnts.setCreatedBy(UserId);
	    		achmnts.setCreatedDate(sdtf.format(new Date()));
	    		achmnts.setIsActive(1);
	    	}else {
	    		achmnts.setModifiedBy(UserId);
	    		achmnts.setModifiedDate(sdtf.format(new Date()));
	    	}

			long result = service.addCCMAchievements(achmnts);
			
			if(result!=0) {
				redir.addAttribute("result", "Achievement Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", "Achievement Details "+action+" UnSuccessful");
			}
			
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			redir.addAttribute("tabName", "Achievements");
			
	    	return "redirect:/CCMPresentation.htm";
	    }catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMAchievementSubmit.htm  "+UserId, e); 
			return "static/Error";
		}
    }

	@RequestMapping(value = "CCMAchievementDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String ccmAchievementDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CCMAchievementDelete.htm "+UserId);
		try
		{
			String achievementId = req.getParameter("achievementId");
	
			int result = service.ccmAchievementDelete(achievementId);
			
			if (result != 0) {
				redir.addAttribute("result", " Achievement Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Achievement Delete Unsuccessful");
			}
	
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			redir.addAttribute("tabName", "Achievements");
			
	    	return "redirect:/CCMPresentation.htm";
		}catch (Exception e) {
	        logger.error(new Date() + " Inside CCMAchievementDelete.htm " + UserId, e);
	        e.printStackTrace();
	        return "static/Error";
	    }
	}
	
}
