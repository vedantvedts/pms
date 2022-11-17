package com.vts.pfms.pfts.controller;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.introspect.VisibilityChecker;
import com.google.gson.Gson;
import com.vts.pfms.master.dto.DemandDetails;
import com.vts.pfms.pfts.dto.DemandOrderDetails;
import com.vts.pfms.pfts.model.PFTSFile;
import com.vts.pfms.pfts.service.PFTSService;

@Controller
public class PFTSController {

	@Autowired
	PFTSService service;
	
	@Autowired
	RestTemplate restTemplate;
	
	@Value("${server_uri}")
    private String uri;
	
	private static final Logger logger=LogManager.getLogger(PFTSController.class);
	
	@RequestMapping(value = "ProcurementStatus.htm" ,method= {RequestMethod.GET,RequestMethod.POST})
	public String procurement(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception 
	{
		
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String projectId =req.getParameter("projectid");		
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProcurementStatus.htm "+UserId);		
		try {
			List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
			
			if(projectlist.size()==0) 
		    {				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}
			
			if(projectId==null) 
			{
				projectId=projectlist.get(0)[0].toString();
			}
			
			req.setAttribute("projectslist",projectlist );
			req.setAttribute("fileStatusList",service.getFileStatusList(projectId));
			req.setAttribute("projectId",projectId);
			
			
		}catch (Exception e) 
		{			
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProcurementStatus.htm "+UserId, e); 
			return "static/Error";	
		}	
		
		return "pfts/FileStatus";
	}
	
	@RequestMapping(value="AddNewDemandFile.hmt", method=RequestMethod.POST)
	public String addNewDemandFile(HttpServletRequest req, HttpSession ses) throws Exception
	{
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside AddNewDemandFile.htm "+UserId);		
		try {
			String projectId =req.getParameter("projectId");
			
			
			String projectcode = service.ProjectData(projectId)[1].toString();
			
			
			final String localUri=uri+"/pfms_serv/newDemandsDetails?projectcode="+projectcode;
			List<DemandDetails> demandList=null;
	 		HttpHeaders headers = new HttpHeaders();
	 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON)); 
	 		String jsonResult=null;
			try {
				HttpEntity<String> entity = new HttpEntity<String>(headers);
				ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
				jsonResult=response.getBody();
		
			}catch(HttpClientErrorException e) {
				req.setAttribute("errorMsg", "errorMsg");
			}
			ObjectMapper mapper = new ObjectMapper();
			mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
			mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
			if(jsonResult!=null) {
				try {
				
					demandList = mapper.readValue(jsonResult, new TypeReference<List<DemandDetails>>(){});
				} catch (JsonProcessingException e) {
	
					e.printStackTrace();
				}
			}
		    List<DemandDetails> prevDemandFile=service.getprevDemandFile(projectId);
		    if(demandList!=null && prevDemandFile!=null) {
		    	demandList.removeAll(prevDemandFile);
		    }
	        req.setAttribute("demandList",demandList);
	        req.setAttribute("projectId",projectId);
			return "pfts/AddNewDemandFile";
		}catch (Exception e) 
		{			
			e.printStackTrace(); 
			logger.error(new Date() +" Inside AddNewDemandFile.htm "+UserId, e); 
			return "static/Error";	
		}	
		
	} 
	private  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	@RequestMapping(value="AddDemandFileSubmit.htm", method=RequestMethod.POST)
	public String addDemandFileSubmit(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside AddDemandFileSubmit.htm "+UserId);		
		try {
			String projectId=req.getParameter("projectId");
			PFTSFile pf=new PFTSFile();
			pf.setDemandNo(req.getParameter("DemandNo"));
			pf.setProjectId(Long.parseLong(projectId));
			pf.setDemandDate(new java.sql.Date(sdf.parse(req.getParameter("demandDate")).getTime()));
			pf.setItemNomenclature(req.getParameter("ItemNomcl"));
			pf.setEstimatedCost(Double.parseDouble(req.getParameter("Estimtedcost")));
			pf.setPftsStatusId(1l);
			pf.setRemarks("Nil");
			
			List<DemandDetails> prevDemandFile=service.getprevDemandFile(projectId);
			
			
			
			Long result=service.addDemandfile(pf);
			
			if(result>0) {
				redir.addAttribute("result","Demand successfully added ");
			}else {
				redir.addAttribute("resultfail","Something went worng");
			}
			
			redir.addAttribute("projectid",projectId);
			return  "redirect:/ProcurementStatus.htm";
		}catch (Exception e) 
		{			
			e.printStackTrace(); 
			logger.error(new Date() +" Inside AddDemandFileSubmit.htm "+UserId, e); 
			return "static/Error";	
		}
	}
   	
	
	@RequestMapping(value = "getStatusEvent.htm", method = RequestMethod.GET)
	public @ResponseBody String getStatusEvent(HttpServletRequest request, HttpSession ses) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside getStatusEvent.htm "+UserId);		
		try {
				String fileid=request.getParameter("fileid");
				List<Object[]> statusList=service.getStatusList(fileid);
				Gson json = new Gson();
				return json.toJson(statusList);
		}catch (Exception e) 
		{			
			e.printStackTrace(); 
			logger.error(new Date() +" Inside getStatusEvent.htm "+UserId, e); 
			return null;
		}

	}
	

	
	@RequestMapping(value="upadteDemandFile.htm", method=RequestMethod.POST)
	public String upadteDemandFile(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside upadteDemandFile.htm "+UserId);		
		try {
			
             String statusId=req.getParameter("statusId");
             String projectId=req.getParameter("projectId");
             String eventDate=req.getParameter("eventDate");
             String fileId=req.getParameter("fileId");
             String remarks=req.getParameter("remarks");
             String demandNo=req.getParameter("demandNo");
             redir.addAttribute("projectid",projectId);
             if(statusId.equals("9")) {
            	   	final String localUri=uri+"/pfms_serv/newDemandsOrderDetails?demandNo="+demandNo;
    				List<DemandOrderDetails> demandOrderList=null;
    		 		HttpHeaders headers = new HttpHeaders();
    		 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON)); 
    		 		String jsonResult=null;
    				try {
    					HttpEntity<String> entity = new HttpEntity<String>(headers);
    					ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
    					jsonResult=response.getBody();
    			
    				}catch(HttpClientErrorException e) {
    					redir.addAttribute("resultfail","Order not placed in IBAS");
						return  "redirect:/ProcurementStatus.htm";
    				}
    				ObjectMapper mapper = new ObjectMapper();
    				mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
    				mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
    				if(jsonResult!=null) {
    					try {
    					
    						demandOrderList = mapper.readValue(jsonResult, new TypeReference<List<DemandOrderDetails>>(){});
    					} catch (JsonProcessingException e) {
    						redir.addAttribute("resultfail","Order not placed in IBAS");
    						return  "redirect:/ProcurementStatus.htm";
    					}
    				}
            	 service.updateCostOnDemand(demandOrderList,fileId,UserId);
             }
			int result =service.upadteDemandFile(fileId,statusId,eventDate,remarks);
			
			if(result>0) {
				redir.addAttribute("result","Demand Edited successfully");
			}else {
				redir.addAttribute("resultfail","Something went worng");
			}
			
			
			return  "redirect:/ProcurementStatus.htm";
		}catch (Exception e) 
		{			
			e.printStackTrace(); 
			logger.error(new Date() +" Inside upadteDemandFile.htm "+UserId, e); 
			return "static/Error";	
		}
	}

	@RequestMapping(value="FileInActive.htm", method=RequestMethod.POST)
	public String FileInActive(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside FileInActive.htm "+UserId);		
		try {
             String projectId=req.getParameter("projectId");
             String fileId=req.getParameter("fileId");
			int result =service.FileInActive(fileId,UserId);
			
			if(result>0) {
				redir.addAttribute("result","File InActived successfully");
			}else {
				redir.addAttribute("resultfail","Something went worng");
			}
			redir.addAttribute("projectid",projectId);
			
			return  "redirect:/ProcurementStatus.htm";
		}catch (Exception e) 
		{			
			e.printStackTrace(); 
			logger.error(new Date() +" Inside FileInActive.htm "+UserId, e); 
			return "static/Error";	
		}
	}
//	@RequestMapping(value = "FileSearch.htm", method = {RequestMethod.POST,RequestMethod.GET})
//	public String FileSearch(HttpServletRequest request, HttpSession ses,RedirectAttributes redir) throws Exception  
//	{
//		ModelAndView mv=new ModelAndView();
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside FileSearch.htm "+UserId);		
//		try {
//			//String category=request.getParameter("Category");
//			String action=request.getParameter("action");			
//			String searchData=request.getParameter("SearchData");
//			
//			if(action!=null && searchData!=null && !searchData.equals("")) 
//			{
//				List<Object[]> demandSearchList=null;
//				
//				if(action.equalsIgnoreCase("DemandNo")) 
//				{
//					demandSearchList= service.getResultAsDemandNo(searchData.trim());
//				}
//				else if(action.equalsIgnoreCase("FileNo")) 
//				{
//					demandSearchList= service.getResultAsFileNo(searchData.trim());
//				}
//				else if(action.equalsIgnoreCase("Item"))
//				{
//					demandSearchList=service.getResultAsPerItemSearch(searchData.trim());
//				}	
//				
//				request.setAttribute("action", action);
//				request.setAttribute("searchData", searchData);
//				request.setAttribute("demandSearchList", demandSearchList);
//							
//			}
//			
//			return "pfts/FileSearch";
//		}
//		catch (Exception e) 
//		{			
//			e.printStackTrace(); 
//			logger.error(new Date() +" Inside FileSearch.htm "+UserId, e); 
//			return "static/Error";	
//		}
//	}
	@RequestMapping(value="FileOrderRetrive.htm", method=RequestMethod.POST)
	public String FileOrderRetrive(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside FileOrderRetrive.htm "+UserId);		
		try {
			
             String projectId=req.getParameter("projectId");
             String fileId=req.getParameter("fileId");
             String demandNo=req.getParameter("demandNo");
             redir.addAttribute("projectid",projectId);
            	   	final String localUri=uri+"/pfms_serv/newDemandsOrderDetails?demandNo="+demandNo;
    				List<DemandOrderDetails> demandOrderList=null;
    		 		HttpHeaders headers = new HttpHeaders();
    		 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON)); 
    		 		String jsonResult=null;
    				try {
    					HttpEntity<String> entity = new HttpEntity<String>(headers);
    					ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
    					jsonResult=response.getBody();
    			
    				}catch(HttpClientErrorException e) {
    					redir.addAttribute("resultfail","Order not placed in IBAS");
						return  "redirect:/ProcurementStatus.htm";
    				}
    				ObjectMapper mapper = new ObjectMapper();
    				mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
    				mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
    				if(jsonResult!=null) {
    					try {
    					
    						demandOrderList = mapper.readValue(jsonResult, new TypeReference<List<DemandOrderDetails>>(){});
    					} catch (JsonProcessingException e) {
    						redir.addAttribute("resultfail","Order not placed in IBAS");
    						return  "redirect:/ProcurementStatus.htm";
    					}
    				}
            	long result= service.updateCostOnDemand(demandOrderList,fileId,UserId);

            	if(result>0) {
     				redir.addAttribute("result","Demand Order Updated successfully");
     			}else {
     				redir.addAttribute("resultfail","Something went worng");
     			}
			
			
			return  "redirect:/ProcurementStatus.htm";
		}catch (Exception e) 
		{			
			e.printStackTrace(); 
			logger.error(new Date() +" Inside FileOrderRetrive.htm "+UserId, e); 
			return "static/Error";	
		}
	}
	
}
