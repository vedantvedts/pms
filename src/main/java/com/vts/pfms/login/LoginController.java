package com.vts.pfms.login;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.committee.service.CommitteeService;
import com.vts.pfms.header.service.HeaderService;
import com.vts.pfms.master.dto.ProjectSanctionDetailsMaster;
import com.vts.pfms.model.FinanceChanges;
import com.vts.pfms.model.IbasLabMaster;
import com.vts.pfms.model.Notice;
import com.vts.pfms.pfmsserv.feign.PFMSServeFeignClient;
import com.vts.pfms.service.RfpMainService;

@JsonIgnoreProperties(ignoreUnknown = true)
@Controller
@EnableScheduling
public class LoginController {
	
	private static final Logger logger=LogManager.getLogger(LoginController.class);
	@Autowired
	RfpMainService rfpmainservice;
	
	@Autowired
	LoginRepository Repository;
	
	@Autowired
	HeaderService headerservice;
	
	@Autowired
	CommitteeService comservice;

	@Autowired
	PFMSServeFeignClient PFMSServ;

	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	
//	@Autowired
//  private LoginDetailsServiceImpl loginService;
//
//  @Autowired
//  private SecurityServiceImpl securityService;
	
    @Autowired
	RestTemplate restTemplate;
	@Value("${centralapp}")
	private String centralapp;
	@Value("${server_uri}")
    private String uri;
	@Value("${ibas_uri}")
    private String ibasUri;
	@Value("${interval}")
	private String interval;

	 @RequestMapping(value = "/login", method = RequestMethod.GET)
	    public String login(Model model, String error, String logout,HttpServletRequest req,HttpSession ses,HttpServletResponse response) {
	 
		 logger.info(new Date() +"Inside login ");
	    	if (error != null) 
	            model.addAttribute("error", "Your username and password is invalid.");

	    	if (logout != null)
	             model.addAttribute("message", "You have been logged out successfully.");
	    	
	    	try {
	    	
	    	}
				catch(Exception e) {
	    		e.printStackTrace();
	    		logger.error(new Date() +" Inside login.htm "+ e);
	    	}
	        return "static/login";
	    }

    
  
    
    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(Model model,HttpServletRequest req,HttpSession ses) throws Exception {
    	
      logger.info(new Date() +" Login By "+req.getUserPrincipal().getName());
   
      try {

		    long LoginId=Repository.findByUsername(req.getUserPrincipal().getName()).getLoginId();
		    Object[] empdetails = headerservice.EmployeeDetailes(String.valueOf(LoginId)).get(0);
		
		    ses.setAttribute("Username",req.getUserPrincipal().getName());
		    ses.setAttribute("LoginId",LoginId ); 
		    ses.setAttribute("Division", Repository.findByUsername(req.getUserPrincipal().getName()).getDivisionId()); 	
		    ses.setAttribute("LoginType", Repository.findByUsername(req.getUserPrincipal().getName()).getLoginType()); 
		    ses.setAttribute("EmpId", Repository.findByUsername(req.getUserPrincipal().getName()).getEmpId()); 
		    ses.setAttribute("FormRole", Repository.findByUsername(req.getUserPrincipal().getName()).getFormRoleId());
		    ses.setAttribute("EmpName", empdetails[0]);
		    ses.setAttribute("EmpNo", empdetails[2].toString());
		    // ses.setAttribute("LoginAs", Repository.findByUsername(req.getUserPrincipal().getName()).getLoginType()); 
		    ses.setAttribute("ProjectId", "0");
		  	ses.setAttribute("DesgId", rfpmainservice.DesgId(Repository.findByUsername(req.getUserPrincipal().getName()).getEmpId().toString()));
		  	ses.setAttribute("LoginTypeName", headerservice.FormRoleName(Repository.findByUsername(req.getUserPrincipal().getName()).getLoginType()));
		  	ses.setAttribute("labid",headerservice.LabDetails(empdetails[3].toString())[0].toString());
		  	//ses.setAttribute("ProjectInitiationList", headerservice.ProjectIntiationList(Repository.findByUsername(req.getUserPrincipal().getName()).getEmpId().toString(),Repository.findByUsername(req.getUserPrincipal().getName()).getLoginType()).size());
		 	
		  	String LabCode = headerservice.getLabCode(Repository.findByUsername(req.getUserPrincipal().getName()).getUsername().toString()).trim();
		  	
		  	ses.setAttribute("labcode", LabCode);
		 	ses.setAttribute("clusterid", headerservice.LabDetails(empdetails[3].toString())[1].toString());
		
		 	String DGName = headerservice.LabMasterList(headerservice.LabDetails(empdetails[3].toString())[1].toString()).stream().filter(e-> "Y".equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()).get(0)[1].toString();
		 	String IsDG = "No";
		    if(DGName.equalsIgnoreCase(LabCode))
		   	 IsDG = "Yes";
		    else
		   	 IsDG = "No";
		    ses.setAttribute("IsDG", IsDG);
		 
		 	req.setAttribute("loginTypeList", headerservice.loginTypeList(Repository.findByUsername(req.getUserPrincipal().getName()).getLoginType()));
		    req.setAttribute("DashboardDemandCount", headerservice.DashboardDemandCount().get(0));
		
		    
		    
		    
		     String empNo=rfpmainservice.getEmpNo(Repository.findByUsername(req.getUserPrincipal().getName()).getEmpId());
		     ses.setAttribute("empNo", empNo);
      }catch (Exception e) {
    	e.printStackTrace();
    	 logger.error(new Date() +" Login Problem Occures When Login By "+req.getUserPrincipal().getName(), e);
     }
     
      return "redirect:/MainDashBoard.htm";
    }
    
    
    @RequestMapping(value = "MainDashBoard.htm", method = RequestMethod.GET)
    public String MainDashBoard(HttpServletRequest req,HttpSession ses) throws Exception {
   
    	String UserId = (String) ses.getAttribute("Username");
    	String EmpId= ((Long) ses.getAttribute("EmpId")).toString();
    	String LoginType=(String)ses.getAttribute("LoginType");
    	String LoginId=String.valueOf(ses.getAttribute("LoginId"));
    	String empNo=(String)ses.getAttribute("empNo"); 
    	String LabCode  = (String)ses.getAttribute("labcode");
    	String ClusterId =(String)ses.getAttribute("clusterid");

    	String ProjectId="A";
		if(req.getParameter("projectid")!=null) {
			ProjectId=req.getParameter("projectid");
		}

    	
    	logger.info(new Date() +"Inside MainDashBoard.htm ");
	      try {    

			     req.setAttribute("loginTypeList", headerservice.loginTypeList(LoginType));
			     req.setAttribute("DashboardDemandCount", headerservice.DashboardDemandCount().get(0));			   
			     req.setAttribute("todayschedulelist", headerservice.TodaySchedulesList(EmpId,LocalDate.now().toString()));
			     req.setAttribute("todayactionlist", headerservice.TodayActionList(EmpId));
			     req.setAttribute("dashbordNotice", rfpmainservice.GetNotice(LabCode));
			     req.setAttribute("noticeEligibility", rfpmainservice.GetNoticeEligibility(EmpId));
			     req.setAttribute("logintype",LoginType);
			     req.setAttribute("selfremindercount",rfpmainservice.SelfActionsList(EmpId).size() );
			     //req.setAttribute("NotiecList",rfpmainservice.getAllNotice());
//			     req.setAttribute("budgetlist",rfpmainservice.ProjectBudgets());
			     req.setAttribute("ibasUri",ibasUri);
			     req.setAttribute("interval", interval);
			     req.setAttribute("ProjectInitiationList", headerservice.ProjectIntiationList(EmpId,LoginType).size());
			     req.setAttribute("mytasklist", headerservice.MyTaskList(EmpId));
			     req.setAttribute("approvallist", headerservice.ApprovalList(EmpId,LoginType));
			     req.setAttribute("mytaskdetails", headerservice.MyTaskDetails(EmpId));
			     req.setAttribute("dashboardactionpdc", headerservice.DashboardActionPdc(EmpId,LoginType));
			     req.setAttribute("QuickLinkList", headerservice.QuickLinksList(LoginType));
			     req.setAttribute("projecthealthdata",  rfpmainservice.ProjectHealthData(LabCode));
			     req.setAttribute("projecthealthtotal",rfpmainservice.ProjectHealthTotalData(ProjectId,EmpId,LoginType,LabCode,"Y"));
			     //req.setAttribute("clusterlablist", headerservice.LabList());
			     //req.setAttribute("clusterlist", comservice.ClusterList());
			     //req.setAttribute("CCMFinanceData",rfpmainservice.getCCMData(EmpId,LoginType,LabCode));
			     req.setAttribute("DashboardFinanceCashOutGo",rfpmainservice.DashboardFinanceCashOutGo(LoginType,EmpId,LabCode,ClusterId ));
			     req.setAttribute("DashboardFinance",rfpmainservice.DashboardFinance(LoginType,EmpId,LabCode,ClusterId ));
			     
			     
			     String DGName = Optional.ofNullable(headerservice.LabMasterList(ClusterId).stream().filter(e-> "Y".equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()).get(0)[1].toString()).orElse("");
			     
			     String IsDG = "No";
			     if(DGName.equalsIgnoreCase(LabCode) || LoginType.equalsIgnoreCase("K"))
			    	 IsDG = "Yes";
			     else
			    	 IsDG = "No";
			     req.setAttribute("IsDG", IsDG);	 
			    	 
			     List<Object[]> labdatalist = new ArrayList<Object[]>();
			     List<Object[]> LabMasterList = new ArrayList<Object[]>();
			     String InAll ="N";
			     
			     
			     if(LoginType.equalsIgnoreCase("K")) {// For Secretary
			    	 LabMasterList = headerservice.LabMasterList(ClusterId).stream().filter(e-> "Y".equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()) ;
			     	 InAll="Y";
			     }
			     else {
			    	 LabMasterList = headerservice.LabMasterList(ClusterId).stream().filter(e-> "N".equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()) ;
			     }
			     
			     for(Object[] obj : LabMasterList) {
			    	 
			    	 labdatalist.add(rfpmainservice.ProjectHealthTotalData(ProjectId,EmpId,LoginType, obj[1].toString().trim() ,InAll));
			     }
			     
			     req.setAttribute("projecthealthtotaldg", labdatalist);
			     
			     
			    // req.setAttribute("changestotalcount", rfpmainservice.ChangesTotalCountData(ProjectId));

//			     if(LoginType.equalsIgnoreCase("P") || LoginType.equalsIgnoreCase("Z") || LoginType.equalsIgnoreCase("Y") || LoginType.equalsIgnoreCase("A") || LoginType.equalsIgnoreCase("E") || LoginType.equalsIgnoreCase("Q") )
			     
			     if(!LoginType.equalsIgnoreCase("U") || !LoginType.equalsIgnoreCase("K")  )
			     {

			    	//req.setAttribute("budgetlist",rfpmainservice.ProjectBudgets());
			    	 
			    	//code for pfms service call to get data for project pie chart

			    	final String localUri=uri+"/pfms_serv/pfms-chart-service?inType="+LoginType+"&employeeNo="+empNo;
			    	
			 		HttpHeaders headers = new HttpHeaders();
			 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
			 		headers.add("labcode", LabCode);
			 		
			 		String jsonResult=null;

					try {

						HttpEntity<String> entity = new HttpEntity<String>(headers);
						ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
						jsonResult=response.getBody();
						
					}
					catch(HttpClientErrorException  | ResourceAccessException e) {
						logger.error(new Date() +" Inside MainDashboard.htm "+UserId, e);
						e.printStackTrace();
					
						req.setAttribute("budgetlist",new ArrayList<ProjectSanctionDetailsMaster>());
						req.setAttribute("errorMsg", "IBAS Server Not Responding !!");

					}catch(Exception e)
					{
						logger.error(new Date() +" Inside MainDashboard.htm "+UserId, e);
						e.printStackTrace();
						req.setAttribute("budgetlist",new ArrayList<ProjectSanctionDetailsMaster>());
						req.setAttribute("errorMsg", "IBAS Server Not Responding !!");
					}
					
					
					ObjectMapper mapper=new ObjectMapper();
					List<ProjectSanctionDetailsMaster> projectDetails=null;
					if(jsonResult!=null) {
						try {

							projectDetails = mapper.readValue(jsonResult, mapper.getTypeFactory().constructCollectionType(List.class, ProjectSanctionDetailsMaster.class));
							req.setAttribute("budgetlist",projectDetails);
							
						} catch (JsonProcessingException e) {
	
							e.printStackTrace();
						}
					}

					//req.setAttribute("AllSchedulesCount", rfpmainservice.AllSchedulesCount(LoginType,LoginId));
			    	req.setAttribute("actionscount",rfpmainservice.AllActionsCount(LoginType,EmpId,LoginId,LabCode));
			    	req.setAttribute("ProjectList", rfpmainservice.ProjectList(LoginType,EmpId,LabCode));
			    	req.setAttribute("ProjectMeetingCount", rfpmainservice.ProjectMeetingCount(LoginType,EmpId,LabCode));
			    	req.setAttribute("ganttchartlist", rfpmainservice.GanttChartList());

					/*
					 * for(Object[] obj:rfpmainservice.ProjectList(LoginType,LoginId)) {
					 * 
					 * req.setAttribute("Quater"+obj[0],
					 * rfpmainservice.ProjectQuaters(obj[0].toString()));
					 * 
					 * }
					 */
			    	
			     }

			     } catch (Exception e) {
			    	   
			    	 logger.error(new Date() +" Inside MainDashboard.htm "+UserId, e);
			    	 e.printStackTrace();
	    	} 
			    	

     return "static/MainDashBoard";
    }
 
    
    @RequestMapping(value = "IndividualProjectDetails.htm", method = RequestMethod.GET)
	public @ResponseBody String IndividualProjectDetails(HttpServletRequest req, HttpSession ses) throws Exception {
		
    	
	 	Object[] IndividualProjectDetails=null;
	 	String UserId =(String)ses.getAttribute("Username");
	 	String EmpId= ((Long) ses.getAttribute("EmpId")).toString();
    	String LoginType=(String)ses.getAttribute("LoginType");
    	String LabCode=(String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside IndividualProjectDetails.htm "+UserId);		
		try {
			
			IndividualProjectDetails = rfpmainservice.ProjectHealthTotalData(req.getParameter("ProjectId"),EmpId,LoginType,LabCode,"Y");
		
		}
		catch (Exception e) {
			e.printStackTrace();
			 logger.error(new Date() +" Inside IndividualProjectDetails.htm "+UserId, e);
		}
	
		Gson convertedgson = new Gson();
		return convertedgson.toJson(IndividualProjectDetails);

	}
    
    @RequestMapping(value = "ChangesDataTotalCount.htm", method = RequestMethod.GET)
   	public @ResponseBody String ChangesDataTotalCount(HttpServletRequest req, HttpSession ses) throws Exception {
   		
   	 	Object[] ChangesDataTotalCount=null;
   	 	String UserId =(String)ses.getAttribute("Username");
   		logger.info(new Date() +"Inside ChangesDataTotalCount.htm "+UserId);		
   		try {
   			
   			ChangesDataTotalCount =  rfpmainservice.ChangesTotalCountData(req.getParameter("ProjectId"));
   		
   		}
   		catch (Exception e) {
   			e.printStackTrace();
   			 logger.error(new Date() +" Inside IndividualProjectDetails.htm "+UserId, e);
   		}
   	
   		Gson convertedgson = new Gson();
   		return convertedgson.toJson(ChangesDataTotalCount);

   	}
	

    @RequestMapping(value = {"/sessionExpired","/invalidSession"}, method = RequestMethod.GET)
    public String sessionExpired(Model model,HttpServletRequest req,HttpSession ses) {
    	logger.info(new Date() +"Inside sessionExpired ");
    	try {
      	  String LogId = ((Long) ses.getAttribute("LoginId")).toString();
      	  rfpmainservice.LoginStampingUpdate(LogId, "S");
      	}
      	catch (Exception e) {
      		
				e.printStackTrace();
			}
    	
        return "SessionExp";
    }
    
    @RequestMapping(value = {"/accessdenied"}, method = RequestMethod.GET)
    public String accessdenied(Model model,HttpServletRequest req,HttpSession ses) {
    	
        return "accessdenied";
    }
    
    
	/////////Rajat Changes//Notice
    @RequestMapping(value = {"IndividualNoticeList.htm"}, method = {RequestMethod.POST,RequestMethod.GET})
    public String addNotice(HttpServletRequest req,HttpSession ses) throws Exception {
    	
		/*
		 * String EmpId = ses.getAttribute("EmpId").toString(); logger.info(new Date()
		 * +"Inside Individual Notice List "+EmpId);
		 * 
		 * req.setAttribute("NotiecList",rfpmainservice.getIndividualNoticeList(EmpId));
		 * 
		 * return "admin/IndividualNoticeList";
		 */
    	
    	String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside IndividualNoticeList.htm "+UserId);
		
		try {
			
			FormatConverter fc=new FormatConverter();
			Calendar c= Calendar.getInstance();
			c.add(Calendar.DATE, 30);
			Date d=c.getTime();
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
			String fdate=req.getParameter("fdate");
			String tdate=req.getParameter("tdate");
			
			if(fdate==null)
			{
				    fdate=fc.getRegularDateFormat().format(new Date());
					tdate=fc.getRegularDateFormat().format(d);
			}
			req.setAttribute("tdate",tdate);
			req.setAttribute("fdate",fdate);
			req.setAttribute("NotiecList",rfpmainservice.getIndividualNoticeList(EmpId,fdate,tdate));

			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside IndividualNoticeList.htm "+UserId, e);
			}
			return  "admin/IndividualNoticeList";

    }
    
    FormatConverter fc=new FormatConverter();
    
    @RequestMapping(value = {"NoticeAddSubmit.htm"}, method = RequestMethod.POST)
    public String NoticeAddSubmit(HttpServletRequest req,HttpSession ses, RedirectAttributes redir) throws Exception {
    	
    	String EmpId =  ses.getAttribute("EmpId").toString();
    	String UserId = (String) ses.getAttribute("Username");
    	String LabCode =(String) ses.getAttribute("labcode");
    	
    	logger.info(new Date() +"Inside Notice Add Submit "+ UserId);
    	
    	Notice notice=new Notice();
    	notice.setNotice(req.getParameter("noticeFiled"));
    	notice.setNoticeBy(EmpId);
    	notice.setIsActive(1);
    	notice.setCreatedBy(UserId);
    	notice.setCreatedDate(this.fc.getSqlDateAndTimeFormat().format(new Date()));
    	notice.setFromDate(new java.sql.Date(sdf.parse(req.getParameter("fdate")).getTime()));
    	notice.setToDate(new java.sql.Date(sdf.parse(req.getParameter("tdate")).getTime()));
    	notice.setLabCode(LabCode);
    	
    	Long result=rfpmainservice.addNotice(notice);
    	

		if (result > 0) {
			redir.addAttribute("result", "Notice Added Successfully");
		} else {
			redir.addAttribute("resultfail", "Something went wrong");
	
		}
        	
      return "redirect:/MainDashBoard.htm";
    }
    
    @RequestMapping(value = {"SeeMoreNotice.htm"}, method = RequestMethod.GET)
    public String noticeSeeMore(HttpServletRequest req,HttpSession ses ) throws Exception {
    	
    	String EmpId =  ses.getAttribute("EmpId").toString();
    	logger.info(new Date() +"Notice See More Notice List "+EmpId);
        req.setAttribute("noticeEligibility", rfpmainservice.GetNoticeEligibility(EmpId));
    	 req.setAttribute("NotiecList",rfpmainservice.getAllNotice());
    	
      return "admin/SeeMoreNotice";
    }
    
    @RequestMapping(value = {"NoticeEditRevoke.htm"}, method = RequestMethod.POST)
    public String NoticeEditRevoke(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception {
    	
    	String EmpId =  ses.getAttribute("EmpId").toString();
    	logger.info(new Date() +"NoticeEditRevoke.htm "+EmpId);
    	
    	String Option=req.getParameter("sub");
		String noticeId=req.getParameter("noticeId");
		
		if(Option.equalsIgnoreCase("edit")) {
			req.setAttribute("NoticeEditData",rfpmainservice.noticeEditData(noticeId).get(0));
			return "admin/NoticeEdit";
		}else {
            int count= rfpmainservice.noticeDelete(noticeId);
			
			if(count>0) {
				
				redir.addAttribute("result", "Notice Deleted Successfully ");
			}
			else {
				
				redir.addAttribute("resultfail","Notice Delete Unsuccessful");
			}
			
		}
    	
      return"redirect:/IndividualNoticeList.htm";
    }
    
    @RequestMapping(value = {"NoticeEditSubmit.htm"}, method = RequestMethod.POST)
     public String noticeEditSubmit(HttpServletRequest req,HttpSession ses,RedirectAttributes redir) throws Exception {
    	String EmpId =  ses.getAttribute("EmpId").toString();
    	logger.info(new Date() +"NoticeEditSubmit.htm "+EmpId);
    
    	Notice notice=new Notice();
    	notice.setNoticeId(Long.parseLong(req.getParameter("noticeId")));
    	notice.setNotice(req.getParameter("noticeFiled"));
    	notice.setNoticeBy(EmpId);
     	notice.setFromDate(new java.sql.Date(sdf.parse(req.getParameter("fdate")).getTime()));
    	notice.setToDate(new java.sql.Date(sdf.parse(req.getParameter("tdate")).getTime()));
    	
    	
    	int count=rfpmainservice.editNotice(notice);
    	if(count>0) {
			
			redir.addAttribute("result", "Notice Edited Successfully ");
		}
		else {
			
			redir.addAttribute("resultfail","Notice Edit Unsuccessful");
		}
    	  return"redirect:/IndividualNoticeList.htm";
    }
    
    @RequestMapping (value="ProjectHealthUpdate.htm", method=RequestMethod.GET)
    public String ProjectHealthUpdate(HttpSession ses, RedirectAttributes redir)throws Exception{
    	
    	String EmpId =  ses.getAttribute("EmpId").toString();	
    	String UserId = (String) ses.getAttribute("Username");
    	String LoginType =(String) ses.getAttribute("LoginType");
    	
    	logger.info(new Date() +"ProjectHealthUpdate.htm "+EmpId);
    	long count=rfpmainservice.ProjectHealthUpdate(EmpId,UserId);
        if(count>0) {
			redir.addAttribute("Overall","Overall");
			
			if(LoginType.equalsIgnoreCase("X")) {
				redir.addAttribute("result", "Cluster Health Updated Successfully ");
			}else {
				redir.addAttribute("result", "Project Health Updated Successfully ");
			}
			
		}
		else 
		{
			
			redir.addAttribute("resultfail","Project Health Update Unsuccessful");
		}
    	  return "redirect:/MainDashBoard.htm";
    	
    }
    
    @Scheduled(cron ="0 1 9-19/3 * * ? ")
    public String ProjectHealthUpdateAuto()throws Exception{
    	
    	logger.info(new Date() +"ProjectHealthUpdateAuto.htm ");
    	rfpmainservice.ProjectHealthUpdate("0","auto-update");
        
    	return "";
    }
    
   
    @RequestMapping (value="ProjectHoaUpdate.htm", method=RequestMethod.GET)
    public String ProjectHoaUpdate(HttpSession ses, RedirectAttributes redir) throws Exception
    {
    	
    	String Empid= ses.getAttribute("EmpId").toString();
    	String UserId = (String) ses.getAttribute("Username");
    	String LabCode=(String)ses.getAttribute("labcode");
    	String ClusterId =(String)ses.getAttribute("clusterid");
    	logger.info(new Date() +"ProjectHoaUpdate.htm "+Empid);
    
    	// Calling pms_serv to update hoa data from ibas to pms
    	final String localUri1=uri+"/pfms_serv/tblprojectdata?labcode="+LabCode;
    	final String localUri2=uri+"/pfms_serv/pfms-finance-changes?projectCode=A&interval=M";
    	final String localUri3=uri+"/pfms_serv/pfms-finance-changes?projectCode=A&interval=W";
    	final String localUri4=uri+"/pfms_serv/pfms-finance-changes?projectCode=A&interval=T";
    	final String localUri5=uri+"/pfms_serv/labdetails";
//    	final String CCMDataURI=uri+"/pfms_serv/getCCMViewData";
    	
    	String MonthlyData=null;
    	String WeeklyData=null;
    	String TodayData=null;
    	String HoaJsonData=null;
    	String LabData= null;
    	List<CCMView> CCMViewData=null;
    	long count= 0L;
    	long ibasserveron=0L;
    	try {
    		HttpHeaders headers = new HttpHeaders();
	 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
	 		headers.set("labcode", LabCode);
    		HttpEntity<String> entity = new HttpEntity<String>(headers);
			ResponseEntity<String> response1=restTemplate.exchange(localUri1, HttpMethod.POST, entity, String.class);
			HoaJsonData=response1.getBody();

			ResponseEntity<String> monthlyresponse=restTemplate.exchange(localUri2, HttpMethod.POST, entity, String.class);
			ResponseEntity<String> weeklyresponse=restTemplate.exchange(localUri3, HttpMethod.POST, entity, String.class);
			ResponseEntity<String> todayresponse=restTemplate.exchange(localUri4, HttpMethod.POST, entity, String.class);
			ResponseEntity<String> labdata=restTemplate.exchange(localUri5, HttpMethod.POST, entity, String.class);
//			ResponseEntity<List<CCMView>> CCMData=restTemplate.exchange(CCMDataURI, HttpMethod.POST,entity, new ParameterizedTypeReference<List<CCMView>>() {});
//			List<CCMView> CCMData =PFMSServ.getCCMViewData();
			
			MonthlyData=monthlyresponse.getBody();
			WeeklyData=weeklyresponse.getBody();
			TodayData=todayresponse.getBody();
			LabData=labdata.getBody();
			CCMViewData= PFMSServ.getCCMViewData(LabCode);
			
    	}
    	catch(HttpClientErrorException  | ResourceAccessException e) 
    	{
    		logger.error(new Date() +" Inside ProjectHoaUpdate.htm pfms_serv Not Responding.htm "+UserId, e);
    		e.printStackTrace();
    		ibasserveron = 1;
		}
    	catch(Exception e)
		{
    		logger.error(new Date() +" Inside ProjectHoaUpdate.htm "+UserId, e);
			e.printStackTrace();
		}

		ObjectMapper mao = new ObjectMapper().configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true);
		List<ProjectHoa> projectDetails1=null;
		List<FinanceChanges> FinanceDetailsMonthly=null;
		List<FinanceChanges> FinanceDetailsWeekly=null;
		List<FinanceChanges> FinanceDetailsToday=null;
		List<IbasLabMaster> LabDetails=null;
		
		if(HoaJsonData!=null) {
			try {

				projectDetails1 = mao.readValue(HoaJsonData, mao.getTypeFactory().constructCollectionType(List.class, ProjectHoa.class));
				LabDetails = mao.readValue(LabData, mao.getTypeFactory().constructCollectionType(List.class, IbasLabMaster.class));
				count = rfpmainservice.ProjectHoaUpdate(projectDetails1,UserId,LabDetails);
				
			} catch (JsonProcessingException e) {
				
				e.printStackTrace();
			}
		}
		
		if(MonthlyData!=null) {
			try {

				FinanceDetailsMonthly = mao.readValue(MonthlyData, mao.getTypeFactory().constructCollectionType(List.class, FinanceChanges.class));
				FinanceDetailsWeekly = mao.readValue(WeeklyData, mao.getTypeFactory().constructCollectionType(List.class, FinanceChanges.class));
				FinanceDetailsToday = mao.readValue(TodayData, mao.getTypeFactory().constructCollectionType(List.class, FinanceChanges.class));
				

				rfpmainservice.ProjectFinanceChangesUpdate(FinanceDetailsMonthly,FinanceDetailsWeekly,FinanceDetailsToday,UserId,Empid);
				
			} catch (JsonProcessingException e) {

				logger.error(new Date() +" Inside ProjectHoaUpdate.htm "+UserId, e);
				e.printStackTrace();
			}
		}
		
		if(CCMViewData!=null && CCMViewData.size()>0)
		{
			rfpmainservice.CCMViewDataUpdate(CCMViewData, LabCode, ClusterId, UserId, Empid);
		}
		
    	
    	if(count>0 ) {
			redir.addAttribute("Overall","Overall");
			redir.addAttribute("result", "Project HOA and CCM Details Updated Successfully ");
		}
    	else if(ibasserveron==1){
    		redir.addAttribute("resultfail","IBAS Server Not Responding");
    	}
		else {
			
			redir.addAttribute("resultfail","Project HOA and CCM Details Update Unsuccessful");
		  }
    	  return "redirect:/MainDashBoard.htm";
    }
    

    
   // @Scheduled(cron ="0 1 9-19/3 * * ? ")
    public String ProjectHoaUpdateAuto()throws Exception{
    	    	
    	logger.info(new Date() +"ProjectHoaUpdateAuto.htm ");
    	// Calling pms_serv to update hoa data from ibas to pms
    	final String localUri1=uri+"/pfms_serv/tblprojectdata";
    	final String localUri2=uri+"/pfms_serv/pfms-finance-changes?projectCode=A&interval=M";
    	final String localUri3=uri+"/pfms_serv/pfms-finance-changes?projectCode=A&interval=W";
    	final String localUri4=uri+"/pfms_serv/pfms-finance-changes?projectCode=A&interval=T";
    	final String localUri5=uri+"/pfms_serv/labdetails";
    	
    	String HoaJsonData=null;
    	String MonthlyData=null;
    	String WeeklyData=null;
    	String TodayData=null;
    	String LabData=null;
    
    	try {
    		
    		HttpHeaders headers = new HttpHeaders();
	 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
	 		//headers.set("labcode", LabCode);
    		HttpEntity<String> entity = new HttpEntity<String>(headers);
			ResponseEntity<String> response1=restTemplate.exchange(localUri1, HttpMethod.POST, entity, String.class);
			HoaJsonData=response1.getBody();
			
			ResponseEntity<String> monthlyresponse=restTemplate.exchange(localUri2, HttpMethod.POST, entity, String.class);
			ResponseEntity<String> weeklyresponse=restTemplate.exchange(localUri3, HttpMethod.POST, entity, String.class);
			ResponseEntity<String> todayresponse=restTemplate.exchange(localUri4, HttpMethod.POST, entity, String.class);
			ResponseEntity<String> labdata=restTemplate.exchange(localUri5, HttpMethod.POST, entity, String.class);
			MonthlyData=monthlyresponse.getBody();
			WeeklyData=weeklyresponse.getBody();
			TodayData=todayresponse.getBody();
			LabData=labdata.getBody();

    	}catch(Exception e)
		{
    		logger.error(new Date() +" Inside ProjectHoaUpdateAuto "+ e);
			e.printStackTrace();
			
		}

		ObjectMapper mao = new ObjectMapper().configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true);
		List<ProjectHoa> projectDetails1=null;
		List<FinanceChanges> FinanceDetailsMonthly=null;
		List<FinanceChanges> FinanceDetailsWeekly=null;
		List<FinanceChanges> FinanceDetailsToday=null;
		List<IbasLabMaster> LabDetails=null;
		if(HoaJsonData!=null) {
			try {

				projectDetails1 = mao.readValue(HoaJsonData, mao.getTypeFactory().constructCollectionType(List.class, ProjectHoa.class));
				LabDetails = mao.readValue(LabData, mao.getTypeFactory().constructCollectionType(List.class, IbasLabMaster.class));
				long count = rfpmainservice.ProjectHoaUpdate(projectDetails1,"auto-update",LabDetails);
				
			} catch (JsonProcessingException e) {

				logger.error(new Date() +" Inside ProjectHoaUpdateAuto "+ e);
				e.printStackTrace();
			}
		}
		
		if(MonthlyData!=null) {
			try {

				FinanceDetailsMonthly = mao.readValue(MonthlyData, mao.getTypeFactory().constructCollectionType(List.class, FinanceChanges.class));
				FinanceDetailsWeekly = mao.readValue(WeeklyData, mao.getTypeFactory().constructCollectionType(List.class, FinanceChanges.class));
				FinanceDetailsToday = mao.readValue(TodayData, mao.getTypeFactory().constructCollectionType(List.class, FinanceChanges.class));
				//we have to pass empid instead of 0
				rfpmainservice.ProjectFinanceChangesUpdate(FinanceDetailsMonthly,FinanceDetailsWeekly,FinanceDetailsToday,"auto-update","0");
				
			} catch (JsonProcessingException e) {

				logger.error(new Date() +" Inside ProjectHoaUpdateAuto "+ e);
				e.printStackTrace();
			}
		}
        
    	return "";
    }
    
    @RequestMapping(value="ChangesinProject.htm", method= {RequestMethod.GET,RequestMethod.POST})
    public String ChangesinProject (HttpSession ses,HttpServletRequest req) throws Exception
    {
    	logger.info(new Date() +"ChangesinProject.htm ");
    	try {
    	String Empid= ses.getAttribute("EmpId").toString();
    	String LoginType=(String)ses.getAttribute("LoginType");
    	String LabCode=(String)ses.getAttribute("labcode");
    	String ProjectId = "A";
    	String Interval = "T";
    	String ActiveTab = "all-tab_alltab";
    	String ClusterId = (String)ses.getAttribute("clusterid");
    	
    	 String DGName = headerservice.LabMasterList(ClusterId).stream().filter(e-> "Y".equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()).get(0)[1].toString();
	     String IsDG = "No";
	     if(DGName.equalsIgnoreCase(LabCode)) {
	    	 IsDG = "Yes";
	     	 LabCode="A";
	     }
	     else {
	    	 IsDG = "No";
	     }
	     
    	
    	if(req.getParameter("interval")!=null) {
    		Interval=req.getParameter("interval");
    	}
    	if(req.getParameter("projectid")!=null) {
    		ProjectId=req.getParameter("projectid");
    	}
    	if(req.getParameter("activetab")!=null) {
    		ActiveTab=req.getParameter("activetab");
    	}
    	if(req.getParameter("labcode")!=null) {
    		LabCode = req.getParameter("labcode");
    	}
    	
    	List<Object[]> LabMasterList = headerservice.LabMasterList(ClusterId).stream().filter(e-> "N".equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()) ;
    	List<Object[]> MeetingChangesData =rfpmainservice.MeetingChanges(ProjectId,Interval,LabCode);
    	List<Object[]> MilestoneChangesData =rfpmainservice.MilestoneChanges(ProjectId, Interval,LabCode);
    	List<Object[]> ActionChangesData =rfpmainservice.ActionChanges(ProjectId,Interval,LabCode);
    	List<Object[]> RiskChangesData =rfpmainservice.RiskChanges(ProjectId,Interval,LabCode) ;
    	String projectCode="A";
    	if(ProjectId!=null && !ProjectId.equalsIgnoreCase("A")) {
    		projectCode = rfpmainservice.ProjectData(ProjectId)[1].toString().trim();
    	}
	    	 
	    req.setAttribute("IsDG", IsDG);
    	req.setAttribute("ProjectList", rfpmainservice.ProjectList(LoginType,Empid,LabCode));
    	req.setAttribute("changestotalcount", rfpmainservice.ChangesTotalCountData(ProjectId));
    	req.setAttribute("meetingchangesdata", MeetingChangesData);
    	req.setAttribute("milestonechangesdata", MilestoneChangesData);
    	req.setAttribute("actionchangesdata", ActionChangesData );
    	req.setAttribute("riskchangesdata", RiskChangesData );
    	//Finance data from pfts_file is done and commented
    	//req.setAttribute("financedataparta", rfpmainservice.FinanceDataPartA(ProjectId,Interval));
    	req.setAttribute("interval", Interval);
    	req.setAttribute("projectid", ProjectId);
    	req.setAttribute("activetab", ActiveTab);
    	req.setAttribute("labmasterlist", LabMasterList);
    	req.setAttribute("labcode", LabCode);
 
    	final String localUri=uri+"/pfms_serv/pfms-finance-changes?projectCode="+projectCode+"&interval="+Interval;
    	List<FinanceChanges> FinanceDetails=null;
    	String FinanceChanges=null;
    	long count= 0L;
    	long ibasserveron=0L;
    	try {
    		
    		HttpHeaders headers = new HttpHeaders();
	 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
	 		headers.set("labcode", LabCode);
    		HttpEntity<String> entity = new HttpEntity<String>(headers);
			ResponseEntity<String> response1=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
			FinanceChanges=response1.getBody();
    	}
    	catch(HttpClientErrorException  | ResourceAccessException e) {
    		logger.error(new Date() +" Inside ChangesinProject.htm pfms_serv not Responding "+ e);
    		ibasserveron = 1;
		}
    	catch(Exception e)
		{
    		logger.error(new Date() +" Inside ChangesinProject.htm  "+ e);
			e.printStackTrace();
		}

		ObjectMapper mao = new ObjectMapper().configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true);
		
		if(FinanceChanges!=null) {
			try {
				FinanceDetails = mao.readValue(FinanceChanges, mao.getTypeFactory().constructCollectionType(List.class, FinanceChanges.class));
			} catch (JsonProcessingException e) {

				logger.error(new Date() +" Inside ChangesinProject.htm pfms_serv not Responding "+ e);
				e.printStackTrace();
			}
		}
		
		req.setAttribute("financechangesdata", FinanceDetails );
		
		
		List<Object[]> alldatalist = new ArrayList<Object[]>();

    	MeetingChangesData.stream().map(c->  new Object[] { "Meeting" ,c[12], c[8] , c[9], sdf.format(c[10]),c[13] } ).collect(Collectors.toList()).forEach( alldatalist :: add );
    	MilestoneChangesData.stream().map(c-> new Object[] {"Milestone" ,c[0] ,c[7] , c[8], sdf.format(c[9]),c[10] } ).collect(Collectors.toList()).forEach( alldatalist :: add );
    	ActionChangesData.stream().map(c-> new Object[] {"Action" ,c[2] , c[7] , c[9], sdf.format(c[8]),c[10] } ).collect(Collectors.toList()).forEach( alldatalist :: add );
    	RiskChangesData.stream().map(c-> new Object[] {"Risk" ,c[1] ,c[9] , c[10], sdf.format(c[8]),c[11] } ).collect(Collectors.toList()).forEach( alldatalist :: add );
    	
    	if(!IsDG.equalsIgnoreCase("Yes")) {
    	
    	if(FinanceDetails!=null) {
    	FinanceDetails.stream().map(c-> {
			try {
				return new Object[] {"Finance", c.getType(),c.getFirstName(),c.getDesignation(), sdf.format(sdf1.parse(c.getCreatedDate().toString())), "-" };
			} catch (ParseException e) {
				logger.error(new Date() +" Inside ChangesinProject.htm"+ e);
				e.printStackTrace();
			}
			return new Object[] {"Finance", c.getType(),c.getFirstName(),c.getDesignation(), "-" ,"-" };
		} ).forEach(alldatalist :: add);
    	}
    	
    	}
    	
    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d-MM-yyyy");
    	alldatalist.sort((o1, o2) -> {
			//return (sdf.format(sdf.parse(o2[4].toString()))).compareTo(sdf.format(sdf.parse(o1[4].toString())));
			return (LocalDate.parse(o2[4].toString(), formatter)).compareTo(LocalDate.parse(o1[4].toString(), formatter));
		});
    
    	//alldatalist.stream().sorted(Comparator.comparing(c-> c. )).collect(Collectors.toList());
    	
    	req.setAttribute("alldatacombinedlist", alldatalist );

    	}
    	catch(Exception e) {
    		logger.error(new Date() +" Inside ChangesinProject.htm"+ e);
    		e.printStackTrace();
    	}

    	return "admin/ChangesRecord";
    }
    
    @RequestMapping(value="LabWiseProjectDetails.htm", method=RequestMethod.POST)
    public String LabWiseProjectDetails(HttpServletRequest req, HttpSession ses) throws Exception
    {
    	logger.info(new Date() +  "LabWiseProjectDetails.htm");
    	String LabCode = req.getParameter("labcode");
    	String EmpId =  ses.getAttribute("EmpId").toString();
    	String LoginType=(String)ses.getAttribute("LoginType");
    	String UserId = (String) ses.getAttribute("Username");
    	String ProjectId="A";
		if(req.getParameter("projectid")!=null) {
			ProjectId=req.getParameter("projectid");
		}
    	
    	try {
    		req.setAttribute("projecthealthtotal",rfpmainservice.ProjectHealthTotalData("A",EmpId,LoginType,LabCode,"N"));
    		req.setAttribute("projecthealthdata",  rfpmainservice.ProjectHealthData(LabCode));
    		req.setAttribute("logintype", LoginType);
    		
    		String ClusterId = headerservice.LabDetails(LabCode)[1].toString();
    		
    		List<Object[]> LabMasterList = headerservice.LabMasterList(ClusterId).stream().filter(e-> "N".equalsIgnoreCase(e[2].toString())).collect(Collectors.toList()) ;
    		List<Object[]> labdatalist = new ArrayList<Object[]>();
    		
		    for(Object[] obj : LabMasterList) 
		    {
		    	 labdatalist.add(rfpmainservice.ProjectHealthTotalData(ProjectId,EmpId,LoginType, obj[1].toString().trim() ,"N"));
		    }
		    req.setAttribute("projecthealthtotaldg", labdatalist);
    		
    	}
    	catch(Exception e) {
    		logger.error(new Date() +" Inside LabWiseProjectDetails.htm"+UserId+ e);
    		e.printStackTrace();
    	}
    	
    	return "admin/LabProjectDetails";
    }
   
    
    @RequestMapping(value = "CashoutgoProject.htm", method = RequestMethod.GET)
   	public @ResponseBody String cashoutgoProject(HttpServletRequest req, HttpSession ses) throws Exception 
    {
    	List<Object[]> cashoutgo=null;
    	String LabCode=(String)ses.getAttribute("labcode");
    	String EmpId =  ses.getAttribute("EmpId").toString();
    	String LoginType=(String)ses.getAttribute("LoginType");
    	String UserId = (String) ses.getAttribute("Username");
    	String ClusterId =(String)ses.getAttribute("clusterid");
   		logger.info(new Date() +"Inside CashoutgoProject.htm "+UserId);		
   		try {
   			String ProjectCode = req.getParameter("ProjectCode");
   			
   			if(ProjectCode.equalsIgnoreCase("0")) {
   				cashoutgo = rfpmainservice.DashboardFinanceCashOutGo(LoginType,EmpId,LabCode,ClusterId );
   			}else
   			{
   				cashoutgo = rfpmainservice.DashboardProjectFinanceCashOutGo(ProjectCode);	
   			}
   		}
   		catch (Exception e) {
   			e.printStackTrace();
   			 logger.error(new Date() +" Inside CashoutgoProject.htm "+UserId, e);
   		}
   		Gson convertedgson = new Gson();
   		return convertedgson.toJson(cashoutgo);
   	}
    
    @RequestMapping(value = "ProjectAttribures.htm", method = RequestMethod.GET)
   	public @ResponseBody String ProjectAttribures(HttpServletRequest req, HttpSession ses) throws Exception 
    {
    	String UserId = (String) ses.getAttribute("Username");
   		logger.info(new Date() +"Inside CashoutgoProject.htm "+UserId);
   		Object[] Project = null;
   		
   		try {
   			String ProjectCode = req.getParameter("ProjectCode");
   			Project = rfpmainservice.ProjectAttributes(ProjectCode);
   		}
   		catch (Exception e) {
   			e.printStackTrace();
   			 logger.error(new Date() +" Inside ProjectAttribures.htm "+UserId, e);
   		}
   		Gson convertedgson = new Gson();
   		return convertedgson.toJson(Project);
   	}
    
}
