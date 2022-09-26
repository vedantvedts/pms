package com.vts.pfms.pfts.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.pfts.model.PftsDemandImms;
import com.vts.pfms.pfts.service.FileTrackingService;


@Controller
public class FileTrackingController {
		
	private static final Logger logger=LogManager.getLogger(FileTrackingController.class);
	FormatConverter fc=new FormatConverter();
	private SimpleDateFormat sdf1	= 	fc.getSqlDateAndTimeFormat();  //new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat sdf	= 	fc.getRegularDateFormat();     //new SimpleDateFormat("dd-MM-yyyy");
	private SimpleDateFormat sdf2	=	fc.getDateMonthShortName();   //new SimpleDateFormat("dd-MMM-yyyy");
	private SimpleDateFormat sdf3	=	fc.getSqlDateFormat();	
	
	@Autowired
	FileTrackingService service;

	@RequestMapping(value = "FileTrackingUserSearch.htm")
	public ModelAndView fileTrackingUserSearch(HttpServletRequest req)  throws Exception
	{
		ModelAndView mv = new ModelAndView("pfts/FileTrackingSearch");
		return mv;
	}
	
	@RequestMapping(value = "file-tracking-user-search-result.htm")
	public ModelAndView FileTrackingUserSearchResult(HttpServletRequest req,HttpSession ses)   throws Exception
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside file-tracking-user-search-result.htm "+UserId);
		try {			
			String DemandNo=req.getParameter("DemandNo");
			String DemandNoButton=req.getParameter("DemandNoButton");
			String ProjectCode=req.getParameter("ProjectCode");
			String ProjectCodeButton=req.getParameter("ProjectCodeButton");
			String ItemNomenclature=req.getParameter("ItemNomenclature");
			String ItemNomenclatureButton=req.getParameter("ItemNomenclatureButton");
			
			List<PftsDemandImms>  DemandImmsListForFileTracking=new ArrayList<PftsDemandImms>();
			
			if(DemandNoButton!=null)
			{
				DemandImmsListForFileTracking=service.DemandImmsListForFileTrackingByDemandNo(DemandNo);	
				req.setAttribute("DemandNoClick",DemandNo);
				
			}
			else if(ProjectCodeButton!=null)
			{
				DemandImmsListForFileTracking=service.DemandImmsListForFileTrackingByProjectCode(ProjectCode);
				req.setAttribute("ProjectCodeClick",ProjectCode);
			}
			else if(ItemNomenclatureButton!=null)
			{
				DemandImmsListForFileTracking=service.DemandImmsListForFileTrackingByItemNomenclature(ItemNomenclature);
				req.setAttribute("ItemNomenclatureClick",ItemNomenclature);
			}
			ModelAndView mv = new ModelAndView("pfts/FileTrackingSearch");
			mv.addObject("DemandImmsListForFileTracking", DemandImmsListForFileTracking);			
			return mv;
		}
		catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside file-tracking-user-search-result.htm "+UserId , e);
			return new ModelAndView ("static/Error");
		}	
	}
	
	@RequestMapping(value = "file-tracking-user-search-flow.htm")
	public ModelAndView FileTrackingUserSearchFlow(HttpServletRequest request,HttpSession ses)  throws Exception
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside file-tracking-user-search-flow.htm "+UserId);
		try {
			ModelAndView mv = new ModelAndView("pfts/FileTrackingSearch");
			String DemandNo=request.getParameter("DemandId");
			
			
			Object[] GetTrackingIdByDemandId=service.CheckingDemandIdPresent(DemandNo);
			
			if(GetTrackingIdByDemandId!=null)
			{
				List<Object[]>  FileTrackingFlowDetails=service.FileTrackingFlowDetails(GetTrackingIdByDemandId[0].toString());
				mv.addObject("FileTrackingFlowDetails",FileTrackingFlowDetails);
				mv.addObject("TrackingPanelVisible","TrackingPanelVisible");
				mv.addObject("DemandIdForFullFlowDetails",DemandNo);
				
			}
			else
			{
				mv.addObject("FileNotInitiateForThisDemand","FileNotInitiateForThisDemand");
				
			}
			
			
			Object[] DemandImmsMainDetailsByDemandId=service.DemandImmsMainDetailsByDemandId(DemandNo);
			mv.addObject("DemandImmsMainDetailsByDemandId",DemandImmsMainDetailsByDemandId);
			
			
			return mv;
		}catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside file-tracking-user-search-flow.htm "+UserId , e);
			return new ModelAndView ("static/Error");
		}	
		
	}
	
	
	
	@RequestMapping(value = "file-tracking-full-flow-details.htm")
	public ModelAndView FileTrackingFullFlowDetails(HttpServletRequest request,HttpSession ses)  
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside file-tracking-full-flow-details.htm "+UserId);
		try {
			ModelAndView mv = new ModelAndView("pfts/FileTrackingFullFlowDetails");
	        String FileTrackingId=request.getParameter("FileTrackingId");
			
			String DemandId=request.getParameter("DemandIdForFullFlowDetails");
			
			List<Object[]>  FileTrackingFlowDetails=service.FileTrackingFlowDetails(FileTrackingId);
			Object[] DemandImmsMainDetailsByDemandId=service.DemandImmsMainDetailsByDemandId(DemandId);
			
			request.setAttribute("FileTrackingFlowDetails",FileTrackingFlowDetails);
			request.setAttribute("DemandImmsMainDetailsByDemandId",DemandImmsMainDetailsByDemandId);
			
				
			return mv;
		}catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside file-tracking-full-flow-details.htm "+UserId , e);
			return new ModelAndView ("static/Error");
		}	
		
	}
	
}
		
		
