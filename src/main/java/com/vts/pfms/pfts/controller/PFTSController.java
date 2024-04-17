package com.vts.pfms.pfts.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.vts.pfms.pfts.dto.PFTSFileDto;
import com.vts.pfms.pfts.model.PFTSFile;
import com.vts.pfms.pfts.model.PftsFileOrder;
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
	SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
	private  SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

	
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
			req.setAttribute("pftsStageList", service.getpftsStageList());
			req.setAttribute("projectId",projectId);
			
			
		}catch (Exception e) 
		{			
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProcurementStatus.htm "+UserId, e); 
			return "static/Error";	
		}	
		
		return "pfts/FileStatus";
	}
	
	@RequestMapping(value="AddNewDemandFile.htm", method=RequestMethod.POST)
	public String addNewDemandFile(HttpServletRequest req, HttpSession ses) throws Exception
	{
		
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside AddNewDemandFile.htm "+UserId);		
		try {
			String projectId =req.getParameter("projectId");
			String projectcode = service.ProjectData(projectId)[1].toString();
			
			
			final String localUri=uri+"/pfms_serv/newDemandsDetails?projectcode="+projectcode;
			List<DemandDetails> demandList=null;
	 		HttpHeaders headers = new HttpHeaders();
	 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON)); 
	 		headers.set("labcode", LabCode);
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
	
	@RequestMapping(value="AddDemandFileSubmit.htm", method=RequestMethod.POST)
	public String addDemandFileSubmit(HttpServletRequest req, RedirectAttributes redir, HttpSession ses) throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside AddDemandFileSubmit.htm "+UserId);		
		try {
			String projectId=req.getParameter("projectId");
			PFTSFile pf=new PFTSFile();
			pf.setDemandNo(req.getParameter("DemandNo"));
			pf.setDemandType("I");
			pf.setProjectId(Long.parseLong(projectId));
			pf.setDemandDate(new java.sql.Date(sdf.parse(req.getParameter("demandDate")).getTime()));
			pf.setItemNomenclature(req.getParameter("ItemNomcl"));
			pf.setEstimatedCost(Double.parseDouble(req.getParameter("Estimtedcost")));
			pf.setPftsStatusId(1l);
			pf.setRemarks("Nil");
			
			List<DemandDetails> prevDemandFile=service.getprevDemandFile(projectId);
			
			Long result=service.addDemandfile(pf);
			
			if(result>0) {
				redir.addAttribute("result","Demand Added Successfully ");
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
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside upadteDemandFile.htm "+UserId);		
		try {
			
             String statusId=req.getParameter("statusId");
             String projectId=req.getParameter("projectId");
             String eventDate=req.getParameter("eventDate");
             String fileId=req.getParameter("fileId");
             String remarks=req.getParameter("remarks");
             String demandNo=req.getParameter("demandNo");
             
             redir.addAttribute("projectid",projectId);
             
             if(statusId.equals("10")) {
            	   	final String localUri=uri+"/pfms_serv/newDemandsOrderDetails?demandNo="+demandNo;
    				List<DemandOrderDetails> demandOrderList=null;
    		 		HttpHeaders headers = new HttpHeaders();
    		 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON)); 
    		 		headers.set("labcode", LabCode);
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
    			
    				if(jsonResult!=null && jsonResult.length()>2) {
    					try {
    					
    						demandOrderList = mapper.readValue(jsonResult, new TypeReference<List<DemandOrderDetails>>(){});
    					} catch (JsonProcessingException e) {
    						redir.addAttribute("resultfail","Order not placed in IBAS");
    						return  "redirect:/ProcurementStatus.htm";
    					}
    				}else {
    					redir.addAttribute("resultfail","Order not placed in IBAS");
						return  "redirect:/ProcurementStatus.htm";
    				}
            	 service.updateCostOnDemand(demandOrderList,fileId,UserId);
             }
			int result =service.upadteDemandFile(fileId,statusId,eventDate,remarks);
			
			if(result>0) {
				redir.addAttribute("result","Demand Updated Successfully");
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

	@RequestMapping(value="FileInActive.htm")
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
		String LabCode = (String)ses.getAttribute("labcode");

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
    		 		headers.set("labcode", LabCode);
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
	

	@RequestMapping(value = "getFilePDCInfo.htm", method = RequestMethod.GET)
	public @ResponseBody String getFilePDCInfo(HttpServletRequest request, HttpSession ses) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside getFilePDCInfo.htm "+UserId);		
		try {
			String fileid=request.getParameter("fileid");
			Object[] statusList=service.getFilePDCInfo(fileid);
			Gson json = new Gson();
			return json.toJson(statusList);
		}
		catch (Exception e) 
		{			
			e.printStackTrace(); 
			logger.error(new Date() +" Inside getFilePDCInfo.htm "+UserId, e); 
			return "";
		}

	}
	
	@RequestMapping(value = "UpdateFilePDCInfo.htm", method = RequestMethod.POST)
	public String UpdateFilePDCInfo(HttpServletRequest request, HttpSession ses,RedirectAttributes redir) throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside UpdateFilePDCInfo.htm "+UserId);		
		try {
			String fileid=request.getParameter("fileId");
			String PDCDate=request.getParameter("PDCDate");
			String IntegrationDate=request.getParameter("IntegrationDate");
			String projectId=request.getParameter("projectId");
			
			long result = service.UpdateFilePDCInfo(fileid, PDCDate, IntegrationDate, UserId);
			
			if(result>0) {
 				redir.addAttribute("result","Demand Order Updated successfully");
 			}else {
 				redir.addAttribute("resultfail","Something went worng");
 			}
			redir.addAttribute("projectid",projectId);
			return "redirect:/ProcurementStatus.htm";
			
		}
		catch (Exception e) 
		{			
			e.printStackTrace(); 
			logger.error(new Date() +" Inside UpdateFilePDCInfo.htm "+UserId, e); 
			return "static/Error";
		}

	}
	
	// ********************************************************** Eniv Strat ***********************************************
			@RequestMapping(value = "envisagedAction.htm")
			public String envisagedAction(HttpServletRequest request, HttpSession ses) throws Exception
			{
				String UserId = (String) ses.getAttribute("Username");
				logger.info(new Date() +"Inside envisagedAction.htm "+UserId);		
				try {
					String projectId=request.getParameter("projectId");
					request.setAttribute("projectId", projectId);
					request.setAttribute("value", "Add");
				
					return "pfts/envisagedAction";
					
				}
				catch (Exception e) 
				{			
					e.printStackTrace(); 
					logger.error(new Date() +" Inside envisagedAction.htm "+UserId, e); 
					return "static/Error";
				}

			}
		
			@RequestMapping(value = "enviActionSubmit.htm", method=RequestMethod.POST)
			public String enviActionSubmit(HttpServletRequest request, HttpSession ses,RedirectAttributes redir) throws Exception
			{
				long result=0;
				long result1=0;
				String UserId = (String) ses.getAttribute("Username");
				int count=0;
				logger.info(new Date() +"Inside enviActionSubmit.htm "+UserId);		
				try {
					String projectId=request.getParameter("projectId");
					String itemNomenclature=request.getParameter("itemNomenclature");
					String estimatedCost=request.getParameter("estimatedCost");
					//String status=request.getParameter("status");
					String remarks=request.getParameter("remarks");
					String intiDate=request.getParameter("intiDate");
					String fileId=request.getParameter("fileId");
					
				
					 PFTSFile pf = new PFTSFile();
					 pf.setProjectId(Long.parseLong(projectId));
					 pf.setItemNomenclature(itemNomenclature);
					 pf.setEstimatedCost(Double.parseDouble(estimatedCost));
					 pf.setEnvisagedStatus("Demand to be Initiated");
					 pf.setRemarks(remarks);
					 pf.setPrbDateOfInti(new java.sql.Date(inputFormat.parse(intiDate).getTime()));
					
					 pf.setCreatedBy(UserId);
					 pf.setCreatedDate(sdf.format(new Date()));
					 pf.setEnvisagedFlag("Y");
					 if(!fileId.equalsIgnoreCase("null")) {
						 pf.setPftsFileId(Long.parseLong(fileId));
						 count=service.getpftsFieldId(fileId);
						 }
				
					if(count>0) {
						result1=service.updateEnvi(pf,UserId);
						if(result1>0) {
			 				redir.addAttribute("result","Demand Edited successfully");
			 			}else {
			 				redir.addAttribute("resultfail","Demand Edited unsuccessful");
			 			}
					}else {
					 result = service.addDemandfile(pf);
					
					if(result>0) {
		 				redir.addAttribute("result","Demand Added successfully");
		 			}else {
		 				redir.addAttribute("resultfail","Demand Added unsuccessful");
		 			}
					}
					redir.addAttribute("projectid",projectId);
				
					return "redirect:/ProcurementStatus.htm";
					
				}
				catch (Exception e) 
				{			
					e.printStackTrace(); 
					logger.error(new Date() +" Inside enviActionSubmit.htm "+UserId, e); 
					return "static/Error";
				}

			}
			
			@RequestMapping(value = "getEnviEditData.htm", method = RequestMethod.GET)
			public @ResponseBody String getEnviEditData(HttpServletRequest request, HttpSession ses) throws Exception
			{
				String UserId = (String) ses.getAttribute("Username");
				logger.info(new Date() +"Inside getEnviEditData.htm "+UserId);		
				try {
					String PftsFileId=request.getParameter("PftsFileId");
					Object[] EnviData=service.getEnviData(PftsFileId);
					Gson json = new Gson();
					return json.toJson(EnviData);
				}
				catch (Exception e) 
				{			
					e.printStackTrace(); 
					logger.error(new Date() +" Inside getEnviEditData.htm "+UserId, e); 
					return "";
				}

			}
			
			@RequestMapping(value="enviEdit.htm")
			public String enviEdit(HttpServletRequest req, HttpSession ses) throws Exception 
			{
				String UserId = (String) ses.getAttribute("Username");
				logger.info(new Date() +"Inside enviEdit.htm "+UserId);		
				try {
					req.setAttribute("itemN", req.getParameter("itemN"));
					req.setAttribute("estimatedCost", req.getParameter("estimatedCost"));
					req.setAttribute("PDOfInitiation", req.getParameter("PDOfInitiation"));
					req.setAttribute("status", req.getParameter("status"));
					req.setAttribute("remarks", req.getParameter("remarks"));
					req.setAttribute("fileId", req.getParameter("fileId"));
					req.setAttribute("projectId", req.getParameter("projectId"));
					req.setAttribute("value", "Edit");
					
					return  "pfts/envisagedAction";
				}catch (Exception e) 
				{			
					e.printStackTrace(); 
					logger.error(new Date() +" Inside enviEdit.htm "+UserId, e); 
					return "static/Error";	
				}
			}
			
	// ********************************************************** Eniv End ***********************************************
			
		@RequestMapping(value = "getFileViewList.htm", method = RequestMethod.GET)
		public @ResponseBody String getFileViewList(HttpServletRequest request, HttpSession ses) throws Exception
			{
				String UserId = (String) ses.getAttribute("Username");
				logger.info(new Date() +"Inside getFileViewList.htm "+UserId);		
				try {
						String procFileId=request.getParameter("fileId");
						Object[] fileViewList=service.getpftsFileViewList(procFileId);
						Gson json = new Gson();
						return json.toJson(fileViewList);
				}catch (Exception e) 
				{			
					e.printStackTrace(); 
					logger.error(new Date() +" Inside getFileViewList.htm "+UserId, e); 
					return null;
				}

			}
			
		@RequestMapping(value = "AddManualDemand.htm", method = RequestMethod.POST)
		public String AddManualDemand(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId = (String) ses.getAttribute("Username");
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String Logintype= (String)ses.getAttribute("LoginType");
			String LabCode = (String)ses.getAttribute("labcode");
			logger.info(new Date() +"Inside AddManualDemand.htm "+UserId);
			
			try {
				
				String projectId = req.getParameter("projectId");
				
				List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
				req.setAttribute("projectslist",projectlist );
				req.setAttribute("projectId",projectId);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "pfts/AddManualDemand";
		}
		
		@RequestMapping(value = "AddManualDemandSubmit.htm", method= {RequestMethod.GET,RequestMethod.POST})
		public String AddManualDemandSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String Logintype= (String)ses.getAttribute("LoginType");
			String UserId = (String) ses.getAttribute("Username");
			String LabCode = (String)ses.getAttribute("labcode");
			
			logger.info(new Date() +"Inside AddManualDemand.htm "+UserId);
			
			try {
				
				String ProjectId = req.getParameter("ProjectId");
				String demandNo = req.getParameter("demandNo");
				String demanddate = req.getParameter("demanddate");
				String estimatedcost = req.getParameter("estimatedcost");
				String itemname = req.getParameter("itemname");
				String demandType = req.getParameter("demandType");
				
				List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
				
				 PFTSFile pf = new PFTSFile();
				 
				 pf.setDemandType(demandType);
				 pf.setProjectId(Long.parseLong(ProjectId));
				 pf.setDemandNo(demandNo);
				 pf.setDemandDate(new java.sql.Date(inputFormat.parse(demanddate).getTime()));
				 pf.setItemNomenclature(itemname);
				 pf.setEstimatedCost(Double.parseDouble(estimatedcost));
				 pf.setPftsStatusId(1l);
			     pf.setRemarks("Nil");
				 pf.setCreatedBy(UserId);
				 pf.setCreatedDate(sdf.format(new Date()));
				 
				 Long result=service.addDemandfile(pf);
					
					if(result>0) {
						redir.addAttribute("result","Demand Added Successfully ");
					}else {
						redir.addAttribute("resultfail","Something went worng");
					}
					
					redir.addAttribute("projectslist",projectlist);
					redir.addAttribute("projectid",ProjectId);
					redir.addAttribute("fileStatusList",service.getFileStatusList(ProjectId));
					redir.addAttribute("pftsStageList", service.getpftsStageList());
					return  "redirect:/ProcurementStatus.htm";
				
			} catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +" Inside AddManualDemandSubmit.htm "+UserId, e); 
				return "static/Error";	
			}
		}
		
		@RequestMapping(value = "updateManualDemand.htm", method = RequestMethod.POST)
		public String updateManualDemand(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside updateManualDemand.htm "+UserId);
			
			try {
				
	             String fileId=req.getParameter("fileId");
	             req.setAttribute("fileViewList",service.getpftsFileViewList(fileId));
	 		     req.setAttribute("pftsStageList", service.getpftsStageList());
				return  "pfts/UpdateManualDemand";
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.info(new Date() +"Inside updateManualDemand.htm "+UserId);
				return "static/Error";
			}
		}
		
		
		@RequestMapping(value = "updateManualDemandSubmit.htm", method = RequestMethod.POST)
		public String updateManualDemandSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String Logintype= (String)ses.getAttribute("LoginType");
			String UserId = (String) ses.getAttribute("Username");
			String LabCode = (String)ses.getAttribute("labcode");
			
			logger.info(new Date() +"Inside updateManualDemandSubmit.htm "+UserId);
			
			try {
				
				List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
				
				 String statusId=req.getParameter("procstatus");
	             String projectId=req.getParameter("projectId");
	             String eventDate=req.getParameter("eventDate");
	             String fileId=req.getParameter("fileId");
	             String remarks=req.getParameter("procRemarks");
	             String flag=req.getParameter("flag");
	        
	             long result=0l;
	             result =service.upadteDemandFile(fileId,statusId,eventDate,remarks);
	             
	             List<DemandOrderDetails> fileList = new ArrayList<DemandOrderDetails>();
	             
	             if(flag!=null &&   flag.equalsIgnoreCase("order")) {
	            	 
	                 String[] orderNo=req.getParameterValues("orderno");
		             String[] orderDate=req.getParameterValues("orderdate");
		             String[] orderCost=req.getParameterValues("ordercost");
		             String[] dpDate=req.getParameterValues("dpdate");
		             String[] itemFor=req.getParameterValues("itemfor");
		             String[] vendorName=req.getParameterValues("vendor");
	     			
		             for(int i=0;i<orderNo.length;i++) {
		            	 DemandOrderDetails pfts = new DemandOrderDetails();
		            	 pfts.setOrderNo(orderNo[i]);
		            	 pfts.setOrderDate(new java.sql.Date(inputFormat.parse(orderDate[i]).getTime()).toString());
		            	 pfts.setDpDate(new java.sql.Date(inputFormat.parse(dpDate[i]).getTime()).toString());
		            	 pfts.setOrderCost(Double.parseDouble(orderCost[i]));
		            	 pfts.setItemFor(itemFor[i]);
		            	 pfts.setVendorName(vendorName[i]);
		            	 pfts.setIsPresent("N");
		            	 fileList.add(pfts);
		             }
		             
		             result=service.updateCostOnDemand(fileList, fileId, UserId);
	             }
	             
	             if(result>0) {
	     				redir.addAttribute("result","Demand Updated Successfully");
	     			}else {
	     				redir.addAttribute("resultfail","Something went worng");
	     			}
	             
	             redir.addAttribute("projectslist",projectlist);
				 redir.addAttribute("projectid",projectId);
				 redir.addAttribute("fileStatusList",service.getFileStatusList(projectId));
				 redir.addAttribute("pftsStageList", service.getpftsStageList());
				 return  "redirect:/ProcurementStatus.htm";
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.info(new Date() +"Inside updateManualDemandSubmit.htm "+UserId);
				return "static/Error";
			}
		}
		

		@RequestMapping(value = "getOrderDetailsAjax.htm", method = RequestMethod.GET)
		public @ResponseBody String getOrderDetailsAjax(HttpServletRequest request, HttpSession ses) throws Exception
		{
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside getOrderDetailsAjax.htm "+UserId);		
			try {
					String fileId=request.getParameter("fileId");
					List<Object[]> orderList=service.getOrderDetailsAjax(fileId);
					Gson json = new Gson();
					return json.toJson(orderList);
			}catch (Exception e) 
			{			
				e.printStackTrace(); 
				logger.error(new Date() +" Inside getOrderDetailsAjax.htm "+UserId, e); 
				return null;
			}

		}
		
		
		@RequestMapping(value = "updateManualOrderSubmit.htm", method = RequestMethod.POST)
		public String updateManualOrderSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String Logintype= (String)ses.getAttribute("LoginType");
			String UserId = (String) ses.getAttribute("Username");
			String LabCode = (String)ses.getAttribute("labcode");
			
			logger.info(new Date() +"Inside updateManualOrderSubmit.htm "+UserId);
			
			try {
				
				List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
				
	                 String projectId=req.getParameter("projectId");
	                 String orderid=req.getParameter("orderid");
	                 String orderNo=req.getParameter("orderno");
		             String orderDate=req.getParameter("orderdate");
		             String orderCost=req.getParameter("ordercost");
		             String dpDate=req.getParameter("dpdate");
		             String itemFor=req.getParameter("itemfor");
		             String vendorName=req.getParameter("vendor");
	     			
		             PftsFileOrder order = new PftsFileOrder();
		             order.setOrderNo(orderNo);
		             order.setOrderDate(new java.sql.Date(inputFormat.parse(orderDate).getTime()).toString());
		             order.setDpDate(new java.sql.Date(inputFormat.parse(dpDate).getTime()).toString());
		             order.setOrderCost(Double.parseDouble(orderCost));
		             order.setItemFor(itemFor);
		             order.setVendorName(vendorName);
		             order.setModifiedBy(UserId);
		             order.setModifiedDate(sdf.format(new Date()));
		             
		             long result=service.ManualOrderSubmit(order,orderid);
	             
	             if(result>0) {
	     				redir.addAttribute("result","Order Updated Successfully");
	     			}else {
	     				redir.addAttribute("resultfail","Order Update Unsuccessfull");
	     			}
	             
	             redir.addAttribute("projectslist",projectlist);
				 redir.addAttribute("projectid",projectId);
				 redir.addAttribute("fileStatusList",service.getFileStatusList(projectId));
				 redir.addAttribute("pftsStageList", service.getpftsStageList());
				 return  "redirect:/ProcurementStatus.htm";
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.info(new Date() +"Inside updateManualOrderSubmit.htm "+UserId);
				return "static/Error";
			}
		}
		
		
		@RequestMapping(value = "manualDemandEditSubmit.htm", method= {RequestMethod.GET,RequestMethod.POST})
		public String manualDemandEditSubmit(HttpServletRequest req, HttpSession ses, RedirectAttributes redir) throws Exception
		{
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String Logintype= (String)ses.getAttribute("LoginType");
			String UserId = (String) ses.getAttribute("Username");
			String LabCode = (String)ses.getAttribute("labcode");
			
			logger.info(new Date() +"Inside manualDemandEditSubmit.htm "+UserId);
			
			try {
				String fileId=req.getParameter("procfileId");
				String ProjectId = req.getParameter("ProjectId");
				String demandNo = req.getParameter("demandno");
				String demanddate = req.getParameter("demanddate");
				String estimatedcost = req.getParameter("estimatedcost");
				String itemname = req.getParameter("itemname");
				
				List<Object[]> projectlist=service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
				
				  PFTSFileDto pftsDto = new PFTSFileDto();
				  pftsDto.setPftsFileId(Long.parseLong(fileId));
				  pftsDto.setDemandNo(demandNo);
				  pftsDto.setDemandDate(new java.sql.Date(inputFormat.parse(demanddate).getTime()));
				  pftsDto.setItemNomenclature(itemname);
				  pftsDto.setEstimatedCost(Double.parseDouble(estimatedcost));
				  pftsDto.setModifiedBy(UserId);
				  pftsDto.setModifiedDate(sdf.format(new Date()));
				
				 Long result=service.manualDemandEditSubmit(pftsDto);
					
					if(result>0) {
						redir.addAttribute("result","Demand Edited Successfully ");
					}else {
						redir.addAttribute("resultfail","Demand Edit Unsuccessfull");
					}
					
					redir.addAttribute("projectslist",projectlist);
					redir.addAttribute("projectid",ProjectId);
					redir.addAttribute("fileStatusList",service.getFileStatusList(ProjectId));
					redir.addAttribute("pftsStageList", service.getpftsStageList());
					return  "redirect:/ProcurementStatus.htm";
				
			} catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +" Inside manualDemandEditSubmit.htm "+UserId, e); 
				return "static/Error";	
			}
		}
		
		
		@RequestMapping(value = "checkManualDemandNo.htm", method = RequestMethod.GET)
		public @ResponseBody String checkManualDemandNo(HttpServletRequest req, HttpSession ses) throws Exception
			{
				String UserId = (String) ses.getAttribute("Username");
				logger.info(new Date() +"Inside checkManualDemandNo.htm "+UserId);		
				try {
						String projectId=req.getParameter("projectId");
						List<Object[]> demandNoList=service.getDemandNoList();
						Gson json = new Gson();
						return json.toJson(demandNoList);
				}catch (Exception e) 
				{			
					e.printStackTrace(); 
					logger.error(new Date() +" Inside checkManualDemandNo.htm "+UserId, e); 
					return null;
				}

			}
			
}

