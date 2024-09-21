package com.vts.pfms.ccm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
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
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.PfmsFileUtils;
import com.vts.pfms.ccm.model.CCMAchievements;
import com.vts.pfms.ccm.model.CCMClosureStatus;
import com.vts.pfms.ccm.model.CCMPresentationSlides;
import com.vts.pfms.ccm.service.CCMService;
import com.vts.pfms.committee.dto.CommitteeMembersEditDto;
import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.committee.model.CommitteeScheduleAgenda;
import com.vts.pfms.committee.service.CommitteeService;
import com.vts.pfms.login.PFMSCCMData;
import com.vts.pfms.print.model.ProjectOverallFinance;
import com.vts.pfms.print.service.PrintService;
import com.vts.pfms.roadmap.service.RoadMapService;
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
	RoadMapService roadmapservice;
	
	@Autowired
	PfmsFileUtils pfmsFileUtils;
	
	@Autowired
	PMSLogoUtil LogoUtil;
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Value("${File_Size}")
	String file_size;

    private String getMimeType(String filename) {
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
	        case "mp4":
	        	return "video/mp4";
	        default:
	            return "application/octet-stream";
	    }
	}
    
	@RequestMapping(value="CCMModules.htm", method= {RequestMethod.GET, RequestMethod.POST})
	public String ccmModules(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
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
			//String filePath = uploadpath+labcode +"\\CCM\\";
			String filePath = Paths.get(uploadpath, labcode, "CCM").toString();
			String fileName = "Annex-"+(count)+(subCount!=null && !subCount.equalsIgnoreCase("0")?("-"+subCount):"");
			
			if(fileExtention.equalsIgnoreCase(".pdf"))
			pfmsFileUtils.addWatermarktoCCMPdf(filePath +File.separator+ file,filePath +File.separator+ file+"(1)", fileName);
			
			File my_file = null;
			Path filepath = Paths.get(filePath, file);
			my_file = filepath.toFile();
	        res.setHeader("Content-disposition","inline; filename="+fileName+fileExtention);
	        String mimeType = getMimeType(my_file.getName()); 
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
    	String clusterid = (String)ses.getAttribute("clusterid");
		logger.info(new Date() +"Inside CCMAgendaPresentation.htm "+UserId);		
    	try {
    		String ccmScheduleId = req.getParameter("ccmScheduleId");
    		String ccmCommitteeId = req.getParameter("committeeId");
    		
    		CommitteeSchedule ccmSchedule = service.getCCMScheduleById(ccmScheduleId);
    		req.setAttribute("ccmScheduleData", ccmSchedule);
	    	req.setAttribute("labInfo", printservice.LabDetailes(labcode));
	    	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(labcode));
	    	req.setAttribute("drdologo", LogoUtil.getDRDOLogoAsBase64String());
	    	req.setAttribute("clusterLabs", LogoUtil.getClusterLabsAsBase64String());
	    	req.setAttribute("thankYouImg", LogoUtil.getThankYouImageAsBase64String());
	    	req.setAttribute("agendaList", service.getCCMScheduleAgendaListByCCMScheduleId(ccmScheduleId));
	    	req.setAttribute("ccmPresentationSlides", service.getCCMPresentationSlidesByScheduleId(ccmScheduleId));
	    	req.setAttribute("ccmScheduleId", ccmScheduleId);
	    	req.setAttribute("ccmCommitteeId", ccmCommitteeId);
	    	
	    	LocalDate now = LocalDate.now();
	    	LocalDate scheduleDate = LocalDate.parse(ccmSchedule.getScheduleDate().toString());
			
	    	req.setAttribute("previousMonth", scheduleDate.minusMonths(1).getMonth().toString());
			req.setAttribute("currentMonth", scheduleDate.getMonth().toString());
			req.setAttribute("year", scheduleDate.getYear());
	    	/* ----------------------- ATR Start -------------------------- */
    			
			List<Object[]> ccmMeetingList = printservice.ReviewMeetingList("0", "CCM");
			Map<Integer,String> mapCCM = new HashMap<>();
     		int ccmCount=0;

     		for (Object []obj:ccmMeetingList) {
     			mapCCM.put(++ccmCount, obj[3].toString());
     		}
     		
			req.setAttribute("ccmCommitteeData", printservice.getCommitteeData(ccmCommitteeId));
			req.setAttribute("ccmActions", printservice.LastPMRCActions("0", ccmCommitteeId));
			Long lastScheduleId = service.getLastScheduleIdFromCurrentScheduleId(ccmScheduleId);
    		req.setAttribute("ccmLatestScheduleMinutesIds", service.getLatestScheduleMinutesIds(lastScheduleId+""));
    		req.setAttribute("ccmPreviousScheduleMinutesIds", service.getPreviousScheduleMinutesIds(lastScheduleId+""));
    		req.setAttribute("atrScheduleData", service.getCCMScheduleById(lastScheduleId+""));
     		req.setAttribute("mapCCM", mapCCM);

    		/* -----------------------  ATR End -------------------------- */
     		
     		/* ----------------------- DMC Start -------------------------- */
    			
			String committeeIdDMC = service.getCommitteeIdByCommitteeCode("DMC")+"";
			if(committeeIdDMC==null || (committeeIdDMC!=null && committeeIdDMC.isEmpty())) {
				committeeIdDMC = "0";
			}
			Long scheduleId = service.getLatestScheduleId("D");
			scheduleId = scheduleId!=null?scheduleId:0L;
			List<Object[]> dmcMeetingList = printservice.ReviewMeetingList("0", "DMC");
			Map<Integer,String> mapDMC = new HashMap<>();
     		int dmcCount=0;

     		for (Object []obj:dmcMeetingList) {
     			mapDMC.put(++dmcCount, obj[3].toString());
     		}
     		
			req.setAttribute("dmcCommitteeData", printservice.getCommitteeData(committeeIdDMC));
			req.setAttribute("dmcActions", printservice.LastPMRCActions("0", committeeIdDMC));
    		//req.setAttribute("dmcLatestScheduleMinutesIds", service.getLatestScheduleMinutesIds(scheduleId+""));
    		req.setAttribute("dmcSchedule", service.getCCMScheduleById(scheduleId+""));
     		req.setAttribute("mapDMC", mapDMC);
			req.setAttribute("committeeIdDMC", committeeIdDMC);
			req.setAttribute("committeeMainId", service.getCommitteeMainIdByCommitteeCode("DMC")+"");
    			
    		/* ----------------------- DMC End -------------------------- */
			
			/* ----------------------- EB Calendar Start -------------------------- */
			
			req.setAttribute("ebCalendarData", service.getEBPMRCCalendarData(scheduleDate.withDayOfMonth(1).toString(), "EB", clusterid));
    		
    		/* ----------------------- EB Calendar End -------------------------- */
    		
    		/* ----------------------- PMRC Calendar Start -------------------------- */

			req.setAttribute("pmrcCalendarData", service.getEBPMRCCalendarData(scheduleDate.withDayOfMonth(1).toString(), "PMRC", clusterid));
    		
    		/* ----------------------- PMRC Calendar End -------------------------- */
			
			/* ----------------------- Closure Status Start -------------------------- */
			
    		req.setAttribute("closureStatusList", service.getClosureStatusList(ccmScheduleId));
    		
			/* ----------------------- Cash Out Go Status Start -------------------------- */
    	
			req.setAttribute("cashOutGoList", service.getCashOutGoList());
			
			
			int monthValue = now.getMonthValue();
			int quarter = 1;
			
			if(monthValue>=7 && monthValue<=9) {
				quarter = 2;
			}else if(monthValue>=10 && monthValue<=12) {
				quarter = 3;
			}else if(monthValue>=1 && monthValue<=3) {
				quarter = 4;
			}
			
			req.setAttribute("quarter", quarter);
    		
    		/* ----------------------- Cash Out Go Status End -------------------------- */
			
			/* ----------------------- Test & Trials Start -------------- */
    		
    		req.setAttribute("ccmTestAndTrialsList", service.getCCMAchievementsByScheduleId(Long.parseLong(ccmScheduleId), "T"));
    		
    		/* ----------------------- Test & Trials End -------------------------- */
    		
    		/* ----------------------- Achievements Start -------------------------- */
    		
    		req.setAttribute("ccmAchievementsList", service.getCCMAchievementsByScheduleId(Long.parseLong(ccmScheduleId), "A"));
    		
    		/* ----------------------- Achievements End -------------------------- */

    		/* ----------------------- Others Start -------------------------- */
    		req.setAttribute("ccmOtherssList", service.getCCMAchievementsByScheduleId(Long.parseLong(ccmScheduleId), "O"));
    		/* ----------------------- Others End -------------------------- */
    		
	    	return "ccm/CCMAgendaPresentation";
    	}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside CCMAgendaPresentation.htm  "+UserId, e); 
			return "static/Error";
			
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
    		
    		Long ccmScheduleId = service.getLatestScheduleId("C");
    		
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
        		req.setAttribute("currentScheduleMinutesIds", service.getLatestScheduleMinutesIds(ccmScheduleId+""));
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
         		int dmcCount=0;

         		for (Object []obj:ReviewMeetingList) {
         			mapDMC.put(++dmcCount, obj[3].toString());
         		}
       
    			req.setAttribute("committeeData", printservice.getCommitteeData(committeeIdDMC));
    			req.setAttribute("dmcActions", printservice.LastPMRCActions("0", committeeIdDMC));
        		//req.setAttribute("latestScheduleMinutesIds", service.getLatestScheduleMinutesIds(scheduleId+""));
        		req.setAttribute("dmcSchedule", service.getCCMScheduleById(scheduleId+""));
         		req.setAttribute("mapDMC", mapDMC);
    			req.setAttribute("committeeIdDMC", committeeIdDMC);
    			req.setAttribute("committeeMainId", service.getCommitteeMainIdByCommitteeCode("DMC")+"");
    			
    		}
    		/* ----------------------- DMC End -------------------------- */

    		/* ----------------------- EB Calendar Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("EB Calendar")) {
    			LocalDate now = LocalDate.now();
    			req.setAttribute("ebCalendarData", service.getEBPMRCCalendarData(now.withDayOfMonth(1).toString(), "EB", clusterid));
    			req.setAttribute("previousMonth", now.minusMonths(1).getMonth().toString());
    			req.setAttribute("currentMonth", now.getMonth().toString());
    			req.setAttribute("year", now.getYear());
    		}
    		/* ----------------------- EB Calendar End -------------------------- */
    		
    		/* ----------------------- PMRC Calendar Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("PMRC Calendar")) {
    			LocalDate now = LocalDate.now();
    			req.setAttribute("pmrcCalendarData", service.getEBPMRCCalendarData(now.withDayOfMonth(1).toString(), "PMRC", clusterid));
    			req.setAttribute("previousMonth", now.minusMonths(1).getMonth().toString());
    			req.setAttribute("currentMonth", now.getMonth().toString());
    			req.setAttribute("year", now.getYear());
    		}
    		/* ----------------------- PMRC Calendar End -------------------------- */
    		
    		/* ----------------------- ASP Status Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("ASP Status")) {
    			
    		}
    		/* ----------------------- ASP Status End ---------------------------- */
    		
    		/* ----------------------- Closure Status Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("Closure Status")) {
    			String labCode = req.getParameter("labCode");
    			labCode = labCode!=null?labCode:labcode;
    			req.setAttribute("closureStatusList", service.getClosureStatusList(ccmScheduleId+"").get(labCode));
    			req.setAttribute("labCode", labCode);
    		}
    		/* ----------------------- Closure Status End -------------------------- */
    		
    		/* ----------------------- Cash Out Go Status Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("Cash Out Go Status")) {
    			
    			String labCode = req.getParameter("labCode");
    			labCode = labCode!=null?labCode:labcode;
    			req.setAttribute("cashOutGoList", service.getCashOutGoList().get(labCode));
    			req.setAttribute("labCode", labCode);
    			
    			LocalDate now = LocalDate.now();
    			int monthValue = now.getMonthValue();
    			int quarter = 1;
    			
    			if(monthValue>=7 && monthValue<=9) {
    				quarter = 2;
    			}else if(monthValue>=10 && monthValue<=12) {
    				quarter = 3;
    			}else if(monthValue>=1 && monthValue<=3) {
    				quarter = 4;
    			}
    			
    			req.setAttribute("quarter", quarter);
    		}
    		/* ----------------------- Cash Out Go Status End -------------------------- */
    		
    		/* ----------------------- Test & Trials Start -------------------------- */
    		else if(tabName.equalsIgnoreCase("Test & Trials")) {
    			req.setAttribute("ccmAchievementsList", service.getCCMAchievementsByScheduleId(ccmScheduleId, "T"));
    		}
    		/* ----------------------- Test & Trials End -------------------------- */
    		
    		/* ----------------------- Achievements Start -------------------------- */
    		else if (tabName.equalsIgnoreCase("Achievements")) {
    			req.setAttribute("ccmAchievementsList", service.getCCMAchievementsByScheduleId(ccmScheduleId, "A"));
    		}
    		/* ----------------------- Achievements End -------------------------- */
    		
    		/* ----------------------- Others Start -------------------------- */
    		else if (tabName.equalsIgnoreCase("Others")) {
    			req.setAttribute("ccmAchievementsList", service.getCCMAchievementsByScheduleId(ccmScheduleId, "O"));
    		}
    		/* ----------------------- Others End -------------------------- */
    		
    		req.setAttribute("clusterLabList", service.getClusterLabListByClusterId(clusterid));
    		req.setAttribute("committeeId", committeeId);
    		req.setAttribute("tabName", tabName);
    		req.setAttribute("filesize",file_size);
    		req.setAttribute("ccmScheduleId", ccmScheduleId+"");
    		
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
    public String ccmAchievementSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,
    		 @RequestParam(name="attachment1", required = false)MultipartFile imageattch , 
    		 @RequestParam(name="attachment2", required = false)MultipartFile pdfattach, 
    		 @RequestParam(name="attachment3", required = false)MultipartFile videoAttach) throws Exception {
    	String UserId = (String)ses.getAttribute("Username");
	    String clusterid = (String)ses.getAttribute("clusterid");
	    logger.info(new Date() + " Inside CCMAchievementSubmit.htm " + UserId);
	    
	    try {
	    	String action = req.getParameter("action");
	    	String achievementId = req.getParameter("achievementId");
	    	String topicType = req.getParameter("topicType");
	    	String tabName = topicType.equalsIgnoreCase("A")?"Achievements":(topicType.equalsIgnoreCase("T")?"Test & Trials":"Others");
	    	
	    	CCMAchievements  achmnts = action.equalsIgnoreCase("Add")? new CCMAchievements() : service.getCCMAchievementsById(achievementId);
	    	achmnts.setScheduleId(Long.parseLong(req.getParameter("scheduleId")));
	    	achmnts.setAchievement(req.getParameter("achievement"));
	    	if(action.equalsIgnoreCase("Add")) {
	    		achmnts.setLabCode(req.getParameter("labCode"));
	    		achmnts.setTopicType(topicType);
	    		achmnts.setCreatedBy(UserId);
	    		achmnts.setCreatedDate(sdtf.format(new Date()));
	    		achmnts.setIsActive(1);
	    	}else {
	    		achmnts.setModifiedBy(UserId);
	    		achmnts.setModifiedDate(sdtf.format(new Date()));
	    	}

			long result = service.addCCMAchievements(achmnts, imageattch, pdfattach, videoAttach, clusterid);
			
			if(result!=0) {
				redir.addAttribute("result", tabName+" Details "+action+"ed Successfully");
			}else {
				redir.addAttribute("resultfail", tabName+" Details "+action+" UnSuccessful");
			}
			
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			redir.addAttribute("tabName",  tabName);
			
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
	
	@RequestMapping(value="CCMCashOutGoStatusExcel.htm" ,method = {RequestMethod.POST,RequestMethod.GET})
	public void ccmCashOutGoStatusExcel( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CCMCashOutGoStatusExcel.htm "+UserId);
		try {
			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFSheet sheet = workbook.createSheet("CCM Cash Out Go Status");
			XSSFRow row = sheet.createRow(0);

			// Create a bold font style for headers
			Font headerFont = workbook.createFont();
			headerFont.setBold(true);

			// Create a cell style for headers
			CellStyle headerCellStyle = workbook.createCellStyle();
			headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
			headerCellStyle.setFont(headerFont);

			// Create a cell style for center alignment and text wrapping
			CellStyle centerWrapCellStyle = workbook.createCellStyle();
			centerWrapCellStyle.setAlignment(HorizontalAlignment.CENTER);
			centerWrapCellStyle.setWrapText(true);
			centerWrapCellStyle.setFont(headerFont);

			// Create and style cells
			Cell cell0 = row.createCell(0);
			cell0.setCellValue("SN");
			cell0.setCellStyle(headerCellStyle);
			sheet.setColumnWidth(0, 2000);

			Cell cell1 = row.createCell(1);
			cell1.setCellValue("Project Code");
			cell1.setCellStyle(headerCellStyle);
			sheet.setColumnWidth(1, 7000);

			Cell cell2 = row.createCell(2, CellType.STRING);
			cell2.setCellValue("Budget Head");
			cell2.setCellStyle(centerWrapCellStyle);
			sheet.setColumnWidth(2, 8000);

			Cell cell3 = row.createCell(3);
			cell3.setCellValue("Allotment \n(In Rs)");
			cell3.setCellStyle(headerCellStyle);
			cell3.setCellStyle(centerWrapCellStyle);
			sheet.setColumnWidth(3, 5000);
			
			Cell cell4 = row.createCell(4);
			cell4.setCellValue("Expenditure \n(In Rs)");
			cell4.setCellStyle(headerCellStyle);
			cell4.setCellStyle(centerWrapCellStyle);
			sheet.setColumnWidth(4, 5000);
			
			Cell cell5 = row.createCell(5);
			cell5.setCellValue("Balance \n(In Rs)");
			cell5.setCellStyle(headerCellStyle);
			cell5.setCellStyle(centerWrapCellStyle);
			sheet.setColumnWidth(5, 5000);
			
			Cell cell6 = row.createCell(6);
			cell6.setCellValue("COG Q1 \n(In Rs)");
			cell6.setCellStyle(headerCellStyle);
			cell6.setCellStyle(centerWrapCellStyle);
			sheet.setColumnWidth(6, 5000);
			
			Cell cell7 = row.createCell(7);
			cell7.setCellValue("COG Q2 \n(In Rs)");
			cell7.setCellStyle(headerCellStyle);
			cell7.setCellStyle(centerWrapCellStyle);
			sheet.setColumnWidth(7, 5000);
			
			Cell cell8 = row.createCell(8);
			cell8.setCellValue("COG Q3 \n(In Rs)");
			cell8.setCellStyle(headerCellStyle);
			cell8.setCellStyle(centerWrapCellStyle);
			sheet.setColumnWidth(8, 5000);
			
			Cell cell9 = row.createCell(9);
			cell9.setCellValue("COG Q4 \n(In Rs)");
			cell9.setCellStyle(headerCellStyle);
			cell9.setCellStyle(centerWrapCellStyle);
			sheet.setColumnWidth(9, 5000);
			
			Cell cell10 = row.createCell(10);
			cell10.setCellValue("Addl(-)/Surr(+) \n(In Rs)");
			cell10.setCellStyle(headerCellStyle);
			cell10.setCellStyle(centerWrapCellStyle);
			sheet.setColumnWidth(10, 5000);

			res.setContentType("application/vnd.ms-excel");
			res.setHeader("Content-Disposition", "attachment; filename=CCMCashOutGoStatusExcel.xls");

			// Write the workbook to the response output stream
			workbook.write(res.getOutputStream());
			workbook.close();
		}catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	@RequestMapping(value="CCMCashOutGoStatusExcelUpload.htm" ,method = {RequestMethod.POST,RequestMethod.GET})
	public String ccmCashOutGoStatusExcelUpload( RedirectAttributes redir,HttpServletRequest req ,HttpServletResponse res ,HttpSession ses)throws Exception
	{

		String UserId = (String) ses.getAttribute("Username");
		String clusterid = (String)ses.getAttribute("clusterid");
		logger.info(new Date()+" Inside CCMCashOutGoStatusExcelUpload.htm "+UserId);
		try {
			String labCode = req.getParameter("labCode");
			Double emptyCost = 0.00;
			if(ServletFileUpload.isMultipartContent(req)) {
				List<FileItem> multiparts = new ServletFileUpload( new DiskFileItemFactory()).parseRequest(new ServletRequestContext(req));	
				Part filePart = req.getPart("filename");
				List<ProjectOverallFinance>list = new ArrayList<>();
				InputStream fileData = filePart.getInputStream();

				Long count =0l;
				Workbook workbook = new XSSFWorkbook(fileData);
				Sheet sheet  = workbook.getSheetAt(0);
				int rowCount=sheet.getLastRowNum()-sheet.getFirstRowNum(); 

				for (int i=1;i<=rowCount;i++) {
					
					PFMSCCMData ccmData = new PFMSCCMData();
					ccmData.setClusterId(Long.parseLong(clusterid));
					ccmData.setLabCode(labCode);
					ccmData.setProjectId(-1L);
					ccmData.setBudgetHeadId(-1L);
					
					int cellcount= sheet.getRow(i).getLastCellNum();

					Row row = sheet.getRow(i);
					DecimalFormat df = new DecimalFormat("#");

					for(int j=1;j<cellcount;j++) {
						Cell cell = row.getCell(j);

						if(cell!=null) {
							if(j==1) {
								
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:
									break;
								case Cell.CELL_TYPE_NUMERIC:
									ccmData.setProjectCode(df.format(sheet.getRow(i).getCell(j).getNumericCellValue()));
									break;
								case Cell.CELL_TYPE_STRING:
									ccmData.setProjectCode(sheet.getRow(i).getCell(j).getStringCellValue());
									break;	 
								}
							}

							if(j==2) {

								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:
									break;
								case Cell.CELL_TYPE_NUMERIC:
									break;
								case Cell.CELL_TYPE_STRING:
									ccmData.setBudgetHeadDescription(sheet.getRow(i).getCell(j).getStringCellValue());
									break;	 

								}
							}

							if(j==3) {
								
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								
								case Cell.CELL_TYPE_BLANK:
									break;
								case Cell.CELL_TYPE_NUMERIC:
									ccmData.setAllotmentCost( BigDecimal.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()) );
									break;
								case Cell.CELL_TYPE_STRING:
									ccmData.setAllotmentCost( BigDecimal.valueOf(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue())) );
									break;	 
								}
								
							}

							if(j==4) {
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:
									break;
								case Cell.CELL_TYPE_NUMERIC:
									ccmData.setExpenditure( BigDecimal.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()) );
									break;
								case Cell.CELL_TYPE_STRING:
									ccmData.setExpenditure( BigDecimal.valueOf(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue())) );
									break;		 
								}
							}
							
							if(j==5) {
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:
									break;
								case Cell.CELL_TYPE_NUMERIC:
									ccmData.setBalance( BigDecimal.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()) );
									break;
								case Cell.CELL_TYPE_STRING:
									ccmData.setBalance( BigDecimal.valueOf(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue())) );
									break;		 
								}
								
							}
							
							if(j==6) {
								
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:
									break;
								case Cell.CELL_TYPE_NUMERIC:
									ccmData.setQ1CashOutGo( BigDecimal.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()) );
									break;
								case Cell.CELL_TYPE_STRING:
									ccmData.setQ1CashOutGo( BigDecimal.valueOf(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue())) );
									break;		 
								}
								
							}
							
							if(j==7) {
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:
									break;
								case Cell.CELL_TYPE_NUMERIC:
									ccmData.setQ2CashOutGo( BigDecimal.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()) );
									break;
								case Cell.CELL_TYPE_STRING:
									ccmData.setQ2CashOutGo( BigDecimal.valueOf(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue())) );
									break;		 
								}
							}
							
							if(j==8) {
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:
									break;
								case Cell.CELL_TYPE_NUMERIC:
									ccmData.setQ3CashOutGo( BigDecimal.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()) );
									break;
								case Cell.CELL_TYPE_STRING:
									ccmData.setQ3CashOutGo( BigDecimal.valueOf(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue())) );
									break;		 
								}
							}
							
							if(j==9) {
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:
									break;
								case Cell.CELL_TYPE_NUMERIC:
									ccmData.setQ4CashOutGo( BigDecimal.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()) );
									break;
								case Cell.CELL_TYPE_STRING:
									ccmData.setQ4CashOutGo( BigDecimal.valueOf(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue())) );
									break;		 
								}
							}
							
							if(j==10) {
								switch(sheet.getRow(i).getCell(j).getCellType()) {
								case Cell.CELL_TYPE_BLANK:
									break;
								case Cell.CELL_TYPE_NUMERIC:
									ccmData.setRequired( BigDecimal.valueOf(sheet.getRow(i).getCell(j).getNumericCellValue()) );
									break;
								case Cell.CELL_TYPE_STRING:
									ccmData.setRequired( BigDecimal.valueOf(Double.parseDouble(sheet.getRow(i).getCell(j).getStringCellValue())) );
									break;		 
								}
							}
							
						}
					}

					if(ccmData.getAllotmentCost()==null) ccmData.setAllotmentCost( BigDecimal.valueOf(emptyCost) );
					if(ccmData.getExpenditure()==null) ccmData.setExpenditure( BigDecimal.valueOf(emptyCost) );
					if(ccmData.getBalance()==null) ccmData.setBalance( BigDecimal.valueOf(emptyCost) );
					if(ccmData.getQ1CashOutGo()==null) ccmData.setQ1CashOutGo( BigDecimal.valueOf(emptyCost) );
					if(ccmData.getQ2CashOutGo()==null) ccmData.setQ1CashOutGo( BigDecimal.valueOf(emptyCost) );
					if(ccmData.getQ3CashOutGo()==null) ccmData.setQ1CashOutGo( BigDecimal.valueOf(emptyCost) );
					if(ccmData.getQ4CashOutGo()==null) ccmData.setQ1CashOutGo( BigDecimal.valueOf(emptyCost) );
					if(ccmData.getRequired()==null) ccmData.setRequired( BigDecimal.valueOf(emptyCost) );
					
					ccmData.setCreatedDate(sdf.format(new Date()));

					if(ccmData.getProjectCode()!=null) {
						count=count+service.addPFMSCCMData(ccmData);
					}
				}
				if(count>0) {
					redir.addAttribute("result","CCM Cash Out Go Added Successfully ");
				}else {
					redir.addAttribute("resultfail","Something went worng");
				}

			}
			
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			redir.addAttribute("tabName", req.getParameter("tabName"));
			redir.addAttribute("labCode", labCode);
			
			return "redirect:/CCMPresentation.htm";
		} catch (Exception e) {
			logger.error(new Date()+" Inside CCMCashOutGoStatusExcelUpload.htm "+UserId, e);
			e.printStackTrace();
			return "static/Error";
		}

	}
	
	@RequestMapping(value = "CCMAchievementsAttachmentDownload.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public void ccmAchievementsAttachmentDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		String clusterid = (String) ses.getAttribute("clusterid");
		logger.info(new Date() +"Inside CCMAchievementsAttachmentDownload.htm "+UserId);
		try
		{
			res.setContentType("application/pdf");	
			
			String achievementId =req.getParameter("achievementId");
			String attachmentName =req.getParameter("attachmentName");
			CCMAchievements achmnts = service.getCCMAchievementsById(achievementId);
			
			List<Object[]> clusterLabList = service.getClusterLabListByClusterId(clusterid);
			String clusterLabCode = clusterLabList!=null && clusterLabList.size()>0 ?clusterLabList.stream().filter(e -> e[3].toString().equalsIgnoreCase("Y")).collect(Collectors.toList()).get(0)[2].toString():"";
			
			String fileName = attachmentName.equalsIgnoreCase("pdf")?achmnts.getAttachmentName():(attachmentName.equalsIgnoreCase("video")?achmnts.getVideoName():achmnts.getImageName());
			//String filePath = uploadpath+clusterLabCode +"\\CCM\\Achievements\\";
			String filePath = Paths.get(uploadpath, clusterLabCode, "CCM", "Achievements").toString(); 
			File my_file = null;
			
			Path filepath = null;
			if(attachmentName.equalsIgnoreCase("video")) {
				filepath = Paths.get(filePath);
		        my_file = new File(filepath+File.separator+fileName); 
			}else {
				filepath = Paths.get(filePath, fileName);
				my_file = filepath.toFile();
			}
			
			res.setHeader("Content-disposition","inline; filename="+fileName);
	        String mimeType = getMimeType(my_file.getName()); 
	        res.setContentType(mimeType);
	        
	        OutputStream out = res.getOutputStream();
	        FileInputStream in = new FileInputStream(my_file);
	        byte[] buffer = new byte[4096];
	        int length;
	        while ((length = in.read(buffer)) > 0) {
	            out.write(buffer, 0, length);
	        }
	        in.close();
	        out.close();
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside CCMAchievementsAttachmentDownload.htm "+UserId,e);
		}
	}
	
	@RequestMapping(value="CCMPresentationSlidesSubmit.htm", method= {RequestMethod.POST, RequestMethod.GET})
	public String ccmPresentationSlidesSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CCMPresentationSlidesSubmit.htm "+UserId);
		try {
			String[] topicNames = req.getParameterValues("topicName");
			String action = req.getParameter("action");
			String ccmScheduleId = req.getParameter("ccmScheduleId");
			String ccmPresSlideId = req.getParameter("ccmPresSlideId");
			
			CCMPresentationSlides slide = ccmPresSlideId.equalsIgnoreCase("0")? new CCMPresentationSlides():service.getCCMPresentationSlidesById(ccmPresSlideId);
			slide.setScheduleId(Long.parseLong(ccmScheduleId));
			slide.setSlideName(topicNames!=null?String.join(",", topicNames):null);
			slide.setFreezeStatus(action.equalsIgnoreCase("Save & Freeze")?"Y":"N");
			
			if(ccmPresSlideId.equalsIgnoreCase("0")) {
	    		slide.setCreatedBy(UserId);
	    		slide.setCreatedDate(sdtf.format(new Date()));
	    		slide.setIsActive(1);
	    	}else {
	    		slide.setModifiedBy(UserId);
	    		slide.setModifiedDate(sdtf.format(new Date()));
	    	}
			
			long result = service.addCCMPresentationSlides(slide);
			if(result>0) {
				redir.addAttribute("result","Presentation Slides Added Successfully ");
			}else {
				redir.addAttribute("resultfail","Presentation Slides Add Unsuccessful");
			}
			
			
			redir.addAttribute("previewFlag", "Y");
			redir.addAttribute("ccmScheduleId", ccmScheduleId);
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			return "redirect:/CCMAgendaPresentation.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMPresentationSlidesSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}

	@RequestMapping(value = "GetProjectListByLabCode.htm", method = {RequestMethod.GET})
	public @ResponseBody String GetProjectListByLabCode(HttpServletRequest req, HttpSession ses) throws Exception{
		String Username=(String)ses.getAttribute("Username");
		String labcode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + "Inside GetProjectListForRoadMap.htm"+Username);
		Gson json = new Gson();
		List<Object[]> getProjectList=null;
		try {
			String labCode = req.getParameter("labCode");
			getProjectList=roadmapservice.getProjectList(labCode!=null?labCode:labcode);
			} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside GetProjectListByLabCode.htm "+Username, e);
			}
		return json.toJson(getProjectList);

	}
	
	@RequestMapping(value = "CCMClosureStatusSubmit.htm", method = {RequestMethod.GET, RequestMethod.POST})
	public String ccmClosureStatusSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside CCMClosureStatusSubmit.htm "+UserId);
		try {
			
			long result = service.addCCMClosureStatus(req, ses);
			
			if(result!=0) {
				redir.addAttribute("result", "Closure Status Details Submitted Successfully");
			}else {
				redir.addAttribute("resultfail", "Closure Status Details Submit UnSuccessful");
			}
			
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			redir.addAttribute("tabName",  req.getParameter("tabName"));
			
			return "redirect:/CCMPresentation.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMPresentationSlidesSubmit.htm "+UserId,e);
			return "static/Error";
		}
	}

	@RequestMapping(value="CCMClosureStatusEditSubmit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String ccmClosureStatusEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CCMClosureStatusDelete.htm "+UserId);
		try {
			
			CCMClosureStatus  closure = service.getCCMClosureStatusById(req.getParameter("ccmClosureId"));
			closure.setRecommendation(req.getParameter("recommendation"));
			closure.setTCRStatus(req.getParameter("tcrStatus"));
			closure.setACRStatus(req.getParameter("acrStatus"));
			closure.setActivityStatus(req.getParameter("activityStatus"));
			closure.setModifiedBy(UserId);
			closure.setModifiedDate(sdtf.format(new Date()));
            
			long result = service.addCCMClosureStatus(closure);
			
			if (result != 0) {
				redir.addAttribute("result", "Closure Status Edited Successfully");
			} else {
				redir.addAttribute("resultfail", "Closure Status Edit Unsuccessful");
			}
			
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			redir.addAttribute("tabName", req.getParameter("tabName"));
			
			return "redirect:/CCMPresentation.htm";
		}catch (Exception e) {
			logger.error(new Date() + " Inside CCMClosureStatusEditSubmit.htm " + UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}

	@RequestMapping(value = "CCMClosureStatusDelete.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String ccmClosureStatusDelete(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside CCMClosureStatusDelete.htm "+UserId);
		try
		{
			String ccmClosureId = req.getParameter("ccmClosureId");
			
			int result = service.ccmClosureStatusDelete(ccmClosureId);
			
			if (result != 0) {
				redir.addAttribute("result", "Closure Status Deleted Successfully");
			} else {
				redir.addAttribute("resultfail", "Closure Status Delete Unsuccessful");
			}
			
			redir.addAttribute("committeeId", req.getParameter("committeeId"));
			redir.addAttribute("tabName", req.getParameter("tabName"));
			
			return "redirect:/CCMPresentation.htm";
		}catch (Exception e) {
			logger.error(new Date() + " Inside CCMClosureStatusDelete.htm " + UserId, e);
			e.printStackTrace();
			return "static/Error";
		}
	}
	
}
