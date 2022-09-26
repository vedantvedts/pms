package com.vts.pfms.pfts.controller;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.pfts.model.PftsDemandImms;
import com.vts.pfms.pfts.model.PftsEventCreator;
import com.vts.pfms.pfts.model.PftsFileEvents;
import com.vts.pfms.pfts.model.PftsFileMilestone;
import com.vts.pfms.pfts.model.PftsFileStage;
import com.vts.pfms.pfts.model.PftsFileTracking;
import com.vts.pfms.pfts.model.PftsFileTrackingTransaction;
import com.vts.pfms.pfts.service.FileStatusService;


@Controller
public class FileStatusController {
		
	private static final Logger logger=LogManager.getLogger(FileStatusController.class);
	FormatConverter fc=new FormatConverter();
	private SimpleDateFormat sdf1	= 	fc.getSqlDateAndTimeFormat();  //new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat sdf	= 	fc.getRegularDateFormat();     //new SimpleDateFormat("dd-MM-yyyy");
	private SimpleDateFormat sdf2	=	fc.getDateMonthShortName();   //new SimpleDateFormat("dd-MMM-yyyy");
	private SimpleDateFormat sdf3	=	fc.getSqlDateFormat();	
	
	@Autowired
	FileStatusService service;
	
//	@RequestMapping(value = "FileCurrentStatus.htm")
//	public String FileStatusEventSearch() throws Exception  {
//		return "pfts/FileSearch";
//	}
	
	
	@RequestMapping(value = "FileSearch.htm")
	public ModelAndView FileStatusEventSearchList(Model model,HttpServletRequest req, HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception  
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside FileSearch.htm "+UserId);
		try {
			Map md=model.asMap();
			//String category=request.getParameter("Category");
			String action=req.getParameter("action");
			if(action==null)
			{			
				action=(String)md.get("action");				
			}
			String searchData=req.getParameter("SearchData");
			if(searchData==null)
			{			
				searchData=(String)md.get("SearchData");				
			}
			if(action!=null && searchData!=null && !searchData.equals("")) {
				List<PftsDemandImms> demandSearchList=null;
				if(action.equalsIgnoreCase("DemandNo")) {
					demandSearchList= service.getResultAsDemandNo(searchData);
				}
				else if(action.equalsIgnoreCase("FileNo")) {
					demandSearchList= service.getResultAsFileNo(searchData);
				}else if(action.equalsIgnoreCase("Item")) {
					demandSearchList=service.getResultAsPerItemSearch(searchData.trim());
				}
				
				if(demandSearchList!=null && demandSearchList.size()==1) {
					PftsDemandImms demObj=demandSearchList.get(0);
					String demandNo=demObj.getDemandNo();
					int demandId=demObj.getDemandId();
					return new ModelAndView("forward:/New-Event.htm?demandNo="+demandNo+"&demandId="+demandId);
				}
				
				req.setAttribute("action", action);
				req.setAttribute("searchData", searchData);
				req.setAttribute("demandDetails", demandSearchList);
			}
			return new ModelAndView ("pfts/FileSearch");
		}
		catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside FileSearch.htm "+UserId , e);
			return new ModelAndView ("static/Error");
		}
	}
	
	@RequestMapping(value = "New-Event.htm")
	public ModelAndView newStatusEvent(Model model,HttpServletRequest request, HttpSession ses, RedirectAttributes redir) throws Exception  
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +" Inside New-Event.htm "+UserId);
		try {
			ModelAndView mv = new ModelAndView("pfts/FileSearch");
			Map md=model.asMap();
			String demandIdNo=request.getParameter("demandIdNo");
			if(demandIdNo==null) 
			{				
				demandIdNo=(String)md.get("demandIdNo");
			}
			String msg=request.getParameter("msg");
			String demandNo=request.getParameter("demandNo");
			if(demandNo==null) 
			{				
				demandNo=(String)md.get("demandNo");
			}
			String demandId=request.getParameter("demandId");
			if(demandId==null) 
			{				
				demandId=(String)md.get("demandId");
			}
		
			if(demandIdNo == null && demandNo==null && demandId==null) 
			{
				redir.addAttribute("resultfail","Refresh Not Allowed");
				return new ModelAndView("redirect:/FileSearch.htm");
			}
			
			if(demandIdNo!=null) {
				String[] arr=demandIdNo.split("##");
				demandNo=arr[0];
				demandId=arr[1];
			}else {
				demandIdNo=demandNo+"##"+demandId;
			}
			
			
			
			String userType=(String)ses.getAttribute("LoginType");
			if(demandIdNo!=null) {
				List<PftsDemandImms> demandDetails=service.getResultAsDemandNo(demandNo);
				List<Object[]> eventStatusDetails=service.getEventStatus(demandNo);
				List<PftsFileEvents> eventList=service.getEvent(userType);
				List<PftsEventCreator> eventCreatorList=service.getEventCreator(userType.charAt(0));
				List<Object[]> soList=service.getSupplyOrderFromMilestone(demandNo);
				List<Object[]> openedSoList=service.getSupplyOrderForFileClose(demandNo);
				List<java.sql.Date> eventDateList=service.getEventDate(demandNo);
				
				List<PftsFileStage> fileStageList=null;
				try{
					fileStageList=service.getDetailsOfFileStage();
				}catch(Exception e) {
					e.printStackTrace();
				}
				
				String eventDate="";
				if(eventDateList!=null && eventDateList.size()>0) {
				Date eventsqlDate=eventDateList.get(0);
				eventDate=sdf.format(eventsqlDate);
				}
				List<Boolean> fileCloseResult=service.checkIsActiveFromMilestone(demandNo);
				int isActive=2;
				if(fileCloseResult!=null && fileCloseResult.size()>0) {
					boolean res=fileCloseResult.get(0);
					if(res==true) {
						isActive=1;
					}else {
						isActive=0;
					}
				}
				request.setAttribute("eventDate", eventDate);
				request.setAttribute("fileStageList", fileStageList);
				request.setAttribute("fileCloseResult", isActive);
				request.setAttribute("demandDetails", demandDetails);
				request.setAttribute("eventList", eventList);
				request.setAttribute("soList", soList);
				request.setAttribute("openedSoList", openedSoList);
				request.setAttribute("eventCreatorList", eventCreatorList);
				request.setAttribute("eventStatusDetails", eventStatusDetails);
				request.setAttribute("demandId", demandId);
				request.setAttribute("demandNo", demandNo);
				request.setAttribute("demandIdNo", demandIdNo);
				
			}
			return mv;
		}
		catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside New-Event.htm "+UserId , e);
			return new ModelAndView("static/Error");
		}
	}
	
	@RequestMapping(value = "getFileEventAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String getFileEventAjax(HttpServletRequest req, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		List<PftsFileEvents> eventlist =null;
		logger.info(new Date() +"Inside getFileEventAjax.htm "+UserId);
		try {			
			String filestageId=req.getParameter("filestageId");
			eventlist=service.getEventAsperFilestageId(filestageId);			
		}catch (Exception e) {			
			e.printStackTrace();  
			logger.error(new Date() +" Inside getFileEventAjax.htm "+UserId, e);
		}
		Gson json = new Gson();
		return json.toJson(eventlist);
	}
	
	
	@RequestMapping(value = "Add-Event.htm",method = RequestMethod.POST)
	public ModelAndView AddEvent(HttpServletRequest request, HttpSession ses, RedirectAttributes redir) throws Exception 
	{

		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside Add-Event.htm "+UserId);
		try 
		{
			String userType=(String)ses.getAttribute("LoginType");
			String employeeNo=(String)ses.getAttribute("EmpNo");
			//String demandId=request.getParameter("demandId");
			String demandIdNo=request.getParameter("demandIdNo");
			String demandNo=null;
			String demandId=null;
			if(demandIdNo!=null) {
				String[] arr=demandIdNo.split("##");
				demandNo=arr[0];
				demandId=arr[1];
			}
			SimpleDateFormat format		=	new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat parseEvent	=	new SimpleDateFormat ("dd-MM-yyyy");
			SimpleDateFormat formatEvent	=	new SimpleDateFormat ("yyyy-MM-dd");
			
			
			//String group=request.getParameter("group");
			String statusEvent=request.getParameter("statusEvent");
			String eventdate=request.getParameter("date");
			//String fileReceiveddate=request.getParameter("fileReceiveddate");
			Date parseDate=parseEvent.parse(eventdate);
			String date=formatEvent.format(parseDate);
			//Date parsefileReceiveddate=parseEvent.parse(fileReceiveddate);
			
			String remarks=request.getParameter("remarks");
			Date currentdate =new Date();
			PftsFileTracking eventStatusDto=new PftsFileTracking();
			PftsFileMilestone fileMilestoneDto=new PftsFileMilestone();
			PftsFileTrackingTransaction transactionDto=new PftsFileTrackingTransaction();
			BigInteger filetrackingId=null;
//			try {
			filetrackingId=service.getFiletrackingId(demandNo);
//			}catch (Exception e) {
//				e.printStackTrace();
//			}
			
			//eventStatusDto.setEventCreatorId(Integer.parseInt(group));
			eventStatusDto.setDemandNo(demandNo);
			eventStatusDto.setForwardedBy(employeeNo);
			eventStatusDto.setForwardedTo(employeeNo);
			eventStatusDto.setAckDate(format.format(currentdate));
			eventStatusDto.setRemarks(remarks);
			eventStatusDto.setEventId(Integer.parseInt(statusEvent));
			//eventStatusDto.setDemandNo(demandNo);
			eventStatusDto.setCreatedBy(employeeNo);
			eventStatusDto.setCreatedDate(format.format(currentdate));
			eventStatusDto.setAckFlag(1);
			eventStatusDto.setEventDate(date);
			eventStatusDto.setActionDate(formatEvent.format(currentdate));
			eventStatusDto.setStatusId(1);
			
			transactionDto.setForwardedBy(employeeNo);
			transactionDto.setForwardedTo(employeeNo);
			transactionDto.setEventId(Integer.parseInt(statusEvent));
			transactionDto.setEventCreatorId(1);
			transactionDto.setAckDate(format.format(currentdate));
			transactionDto.setRemarks(remarks);
			transactionDto.setActionBy(employeeNo);
			transactionDto.setActionDate(format.format(currentdate));
			transactionDto.setAckFlag(1);
			transactionDto.setEventDate(date);
			
			List<Object[]> mileStoneList=service.checkFileMileStone(demandNo);
			//code for fileMilestoneDto
			fileMilestoneDto.setDemandNo(demandNo);
			fileMilestoneDto.setCaseWorker(employeeNo);
			fileMilestoneDto.setFileReceivedDate(date);
			fileMilestoneDto.setIsActive(1);
			if(mileStoneList!=null && mileStoneList.size()>0) {
				try {
					String fileMilestone=service.getFileMileStone(statusEvent);
					service.updateFileMileStone(fileMilestoneDto, fileMilestone);
				}catch (Exception e) {
					e.printStackTrace();
				}
			}else {
				service.addFileMileStone(fileMilestoneDto);
			}
			
			long status=0;
			//int ftstatus=0;
			if(filetrackingId!=null) {
				int trackId=filetrackingId.intValue();
				transactionDto.setFileTrackingId(trackId);
				status= service.addupdateEventStatus(eventStatusDto, trackId, transactionDto);
			}else{
				status=service.addEventStatus(eventStatusDto);
				if(status>0) {
				BigInteger trackingId=service.getFiletrackingId(demandNo);
				int trackId=trackingId.intValue();
				transactionDto.setFileTrackingId(trackId);
				service.addTransactionEvent(transactionDto);
				}
			    
			}				
				
				redir.addFlashAttribute("demandIdNo",demandIdNo);
				if(status>0) {
					redir.addAttribute("result", "Transaction Successful");
				}else {
					redir.addAttribute("resultfail", "Transaction Unsuccessful");
				}			
			    return new ModelAndView("redirect:/New-Event.htm");
		}
		catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside Add-Event.htm "+UserId , e);
			return new ModelAndView("static/Error");
		}
	}
	
	
	@RequestMapping(value = "editStatusEvent-page.htm",method=RequestMethod.POST)
	public ModelAndView editStatusEventPage(HttpServletRequest request, HttpSession ses) throws Exception  
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside editStatusEvent-page.htm "+UserId);
		try 
		{
			String userType=(String)ses.getAttribute("LoginType");
			ModelAndView mv = new ModelAndView("pfts/EditEventStatus");
			String demandNo=request.getParameter("demandNo");
			String eventStatusId=request.getParameter("EventStatusId");
			String demandIdNo=request.getParameter("demandIdNo");
			
			List<Object[]> fileTrackingList=service.getEventStatusasPerFileTrackingId(Integer.parseInt(eventStatusId));
			List<PftsFileEvents> eventList=service.getEvent(userType);
			List<java.sql.Date> eventDateList=service.getEventDate(demandNo);
			String eventDate="";
			if(eventDateList!=null && eventDateList.size()>0) {
				if(eventDateList.size()>1) {
				Date eventsqlDate=eventDateList.get(1);
				eventDate=sdf.format(eventsqlDate);
				}else if(eventDateList.size()==1) {
					Date eventsqlDate=eventDateList.get(0);
					eventDate=sdf.format(eventsqlDate);
				}
			}
			
			request.setAttribute("fileTrackingList", fileTrackingList);
			request.setAttribute("eventList", eventList);
			request.setAttribute("demandIdNo", demandIdNo);
			request.setAttribute("eventDate", eventDate);
			return mv;
		}catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside editStatusEvent-page.htm "+UserId , e);
			return new ModelAndView("static/Error");
		}
	}
	
	
	
	@RequestMapping(value = "editStatusEvent.htm",method=RequestMethod.POST)
	public ModelAndView editStatusEvent(HttpServletRequest request, HttpSession ses, RedirectAttributes redir) throws Exception 
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside editStatusEvent.htm "+UserId);
		try 
		{
			
			String employeeNo=(String)ses.getAttribute("EmpNo");
			ModelAndView mv = new ModelAndView("redirect:/New-Event.htm");
			String EventId=request.getParameter("EventId");
			String EventDate=request.getParameter("EventDate");
			String demandIdNo=request.getParameter("demandIdNo");
			String fileTrackingTransactionId=request.getParameter("fileTrackingTransactionId");
			String remarks=request.getParameter("remarks");
			String fileTrackingId=request.getParameter("fileTrackingId");
			Date date=sdf.parse(EventDate);
			String eDate=sdf3.format(date);
			Date dateC=new Date();
			
			int status=service.updateEventStatusas(Integer.parseInt(fileTrackingTransactionId), Integer.parseInt(EventId), eDate,employeeNo,sdf1.format(dateC),remarks, Integer.parseInt(fileTrackingId));
			String msg=null;
			if(status!=0) {
				redir.addAttribute("result", "Even Status Update Successful");
			}else {
				redir.addAttribute("resultfail", "Even Status Update Unsuccessful");
			}			
			//mv =  new ModelAndView("redirect:/New-Event.htm?demandIdNo="+demandIdNo);
			redir.addFlashAttribute("demandIdNo", demandIdNo);
			return mv;
		}catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside editStatusEvent.htm "+UserId , e);
			return new ModelAndView("static/Error");
		}
	}
	
	@RequestMapping(value = "fileClose.htm",method=RequestMethod.POST)
	public String fileClose(HttpServletRequest request,HttpSession ses,HttpServletResponse response, RedirectAttributes redir) throws Exception  
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside fileClose.htm "+UserId);
		try 
		{
			String employeeNo=(String)ses.getAttribute("EmpNo");
			String demandId=request.getParameter("demandId");
			String demandNo=request.getParameter("demandNo");
			String fileTrackingId=request.getParameter("fileTrackingId");
			String orderCloseId=request.getParameter("orderCloseId");
			
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat formatDT=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date currentDate=new Date();
			PftsFileTrackingTransaction tranDto=new PftsFileTrackingTransaction();
			PftsFileTracking trackDto=new PftsFileTracking();
			tranDto.setFileTrackingId(Integer.parseInt(fileTrackingId));
			tranDto.setForwardedBy(employeeNo);
			tranDto.setForwardedTo(employeeNo);
			tranDto.setEventId(27);
			tranDto.setEventCreatorId(1);
			tranDto.setEventDate(format.format(currentDate));
			tranDto.setAckFlag(1);
			tranDto.setAckDate(formatDT.format(currentDate));
			tranDto.setRemarks("File Closed");
			tranDto.setActionBy(employeeNo);
			tranDto.setActionDate(formatDT.format(currentDate));
			
			trackDto.setFileTrackingId(Integer.parseInt(fileTrackingId));
			trackDto.setEventId(27);
			trackDto.setEventDate(format.format(currentDate));
			trackDto.setAckDate(formatDT.format(currentDate));
			trackDto.setRemarks("File Closed");
			trackDto.setActionDate(format.format(currentDate));
			trackDto.setCreatedBy(employeeNo);
			trackDto.setCreatedDate(formatDT.format(currentDate));
			trackDto.setStatusId(0);
			trackDto.setDemandNo(demandNo);
			trackDto.setForwardedBy(employeeNo);
			trackDto.setForwardedTo(employeeNo);
			
			int status=service.fileClosed(tranDto,trackDto,Integer.parseInt(orderCloseId));
			if(status!=0) {
				redir.addAttribute("result","File Closed Successfully");
			}else {
				redir.addAttribute("resultfail","File Closing UnSuccessful");
			}
			
			////code for jsp page
			redir.addFlashAttribute("demandId", demandId);
			redir.addFlashAttribute("demandNo", demandNo);
			
			return "redirect:/New-Event.htm";
		}catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside fileClose.htm "+UserId , e);
			return "static/Error";
		}
	}
	
	
	@RequestMapping(value = "fileCloseNoOrder.htm")
	public String fileCloseNoOrder(HttpServletRequest request,HttpSession ses,HttpServletResponse response, RedirectAttributes redir) throws Exception  
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside fileCloseNoOrder.htm "+UserId);
		try 
		{
			String userType=(String)ses.getAttribute("LoginType");
			String employeeNo=(String)ses.getAttribute("EmpNo");
			String demandId=request.getParameter("demandId");
			String demandNo=request.getParameter("demandNo");
			String fileTrackingId=request.getParameter("fileTrackingId");
			//String orderCloseId=request.getParameter("orderCloseId");
			String demandIdNo=demandNo+"##"+demandId;
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat parseEvent=new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat formatDT=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date currentDate=new Date();
			PftsFileTrackingTransaction tranDto=new PftsFileTrackingTransaction();
			PftsFileTracking trackDto=new PftsFileTracking();
			tranDto.setFileTrackingId(Integer.parseInt(fileTrackingId));
			tranDto.setForwardedBy(employeeNo);
			tranDto.setForwardedTo(employeeNo);
			tranDto.setEventId(27);
			tranDto.setEventCreatorId(1);
			tranDto.setEventDate(format.format(currentDate));
			tranDto.setAckFlag(1);
			tranDto.setAckDate(formatDT.format(currentDate));
			tranDto.setRemarks("File Closed");
			tranDto.setActionBy(employeeNo);
			tranDto.setActionDate(formatDT.format(currentDate));
			
			trackDto.setFileTrackingId(Integer.parseInt(fileTrackingId));
			trackDto.setEventId(27);
			trackDto.setEventDate(format.format(currentDate));
			trackDto.setAckDate(formatDT.format(currentDate));
			trackDto.setRemarks("File Closed");
			trackDto.setActionDate(format.format(currentDate));
			trackDto.setCreatedBy(employeeNo);
			trackDto.setCreatedDate(formatDT.format(currentDate));
			trackDto.setStatusId(0);
			trackDto.setDemandNo(demandNo);
			trackDto.setForwardedBy(employeeNo);
			trackDto.setForwardedTo(employeeNo);
			
			int status=service.fileClosedNoOrder(tranDto,trackDto,demandNo);
			
			if(status!=0) {
				redir.addAttribute("result","File Closed Successfully");
			}else {
				redir.addAttribute("resultfail","File Closing UnSuccessful");
			}
			redir.addFlashAttribute("demandIdNo",demandIdNo);
			return "redirect:/New-Event.htm"; 
		}catch (Exception e)
		{			
			e.printStackTrace();
			logger.error(new Date() +" Inside fileCloseNoOrder.htm "+UserId , e);
			return"static/Error";
		}
	}	
	
	
	
}
		
		
