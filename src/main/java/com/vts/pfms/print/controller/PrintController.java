package com.vts.pfms.print.controller;

import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
import com.itextpdf.html2pdf.ConverterProperties;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.html2pdf.resolver.font.DefaultFontProvider;
import com.itextpdf.io.font.FontConstants;
import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfPage;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.itextpdf.kernel.utils.PdfMerger;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.font.FontProvider;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.Zipper;
import com.vts.pfms.committee.model.Committee;
import com.vts.pfms.master.dto.ProjectFinancialDetails;
import com.vts.pfms.milestone.dto.MilestoneActivityLevelConfigurationDto;
import com.vts.pfms.milestone.service.MilestoneService;
import com.vts.pfms.model.TotalDemand;
import com.vts.pfms.print.model.CommitteeProjectBriefingFrozen;
import com.vts.pfms.print.model.InitiationSanction;
import com.vts.pfms.print.model.InitiationsanctionCopyAddr;
import com.vts.pfms.print.model.RecDecDetails;
import com.vts.pfms.print.model.TechImages;
import com.vts.pfms.print.service.PrintService;
import com.vts.pfms.utils.PMSLogoUtil;


@Controller
public class PrintController {

	@Autowired
	PrintService service;
	
	FormatConverter fc=new FormatConverter();
	
	@Autowired
	RestTemplate restTemplate;
	
	@Autowired
	MilestoneService milservice;

	@Value("${server_uri}")
    private String uri;
	
	@Value("${ProjectCost}")
	private long ProjectCost;
	
	@Value("${ApplicationFilesDrive}")
	private String ApplicationFilesDrive;
	
	@Value("#{${CommitteeCodes}}")
	private List<String> SplCommitteeCodes;
	
	@Autowired
	Environment env;
	
	@Autowired
	PMSLogoUtil LogoUtil;
	
	
	private static final Logger logger=LogManager.getLogger(PrintController.class);

	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	@RequestMapping(value="PfmsPrint.htm", method = RequestMethod.POST)
	public String PfmsPrint(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");
//		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside PfmsPrint.htm "+UserId);		
	    	try {
	    		String InitiationId=req.getParameter("IntiationId");
	    		
	    		Object[] PfmsInitiationList= service.PfmsInitiationList(InitiationId).get(0);
	    		String labcode=PfmsInitiationList[17].toString().toLowerCase();
	    		
	   		 	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(labcode));                     
	    		req.setAttribute("LabList", service.LabList(labcode));
	    		req.setAttribute("PfmsInitiationList", PfmsInitiationList);
	    		req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(InitiationId));
	    		req.setAttribute("CostDetailsList", service.CostDetailsList(InitiationId));
	    		req.setAttribute("ScheduleList", service.ProjectInitiationScheduleList(InitiationId));
	    	}
				
	    	catch(Exception e) {	    		
	    		logger.error(new Date() +" Inside PfmsPrint.htm "+UserId, e);
	    		e.printStackTrace();
	    		return "static/Error";
		
	    	}		
	    return "print/PfmsPrint";
		
	}
	
	@RequestMapping(value="PfmsPrint2.htm", method = RequestMethod.POST)
	public String PfmsPrint2(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)
			throws Exception {
		
		String UserId = (String) ses.getAttribute("Username");
		String LabCode =(String) ses.getAttribute("labcode");
		logger.info(new Date() +"Inside PfmsPrint2.htm "+UserId);		
	    try {
	    	String InitiationId=req.getParameter("IntiationId");		
	    		
	 		Object[] PfmsInitiationList= service.PfmsInitiationList(InitiationId).get(0);
    		String labcode=PfmsInitiationList[17].toString().toLowerCase();
    		
   		 	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(labcode));                     
    		req.setAttribute("PfmsInitiationList", PfmsInitiationList);
	    	req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(InitiationId));
	    	req.setAttribute("CostDetailsList", service.CostDetailsList(InitiationId));
	    	req.setAttribute("ScheduleList", service.ProjectInitiationScheduleList(InitiationId));
	    	req.setAttribute("LabList", service.LabList(labcode));
	    	req.setAttribute("LabLogo", LogoUtil.getLabLogoAsBase64String(LabCode));
	    	
	    	}
				
	    	catch(Exception e) {	    		
	    		logger.error(new Date() +" Inside PfmsPrint2.htm "+UserId, e);
	    		e.printStackTrace();
	    		return "static/Error";
	    	}	
		
		return "print/PfmsPrint2";
		
	}
	
	@RequestMapping(value="ExecutiveSummaryDownload.htm", method = RequestMethod.POST )
	public void ExecutiveSummaryDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ExecutiveSummaryDownload.htm "+UserId);		
	    try {
	    
	    	String InitiationId=req.getParameter("IntiationId");
	    	Object[] PfmsInitiationList= service.PfmsInitiationList(InitiationId).get(0);
	    	List<Object[]> costDetailsList = service.CostDetailsList(InitiationId);
	    	String labcode=PfmsInitiationList[17].toString();
   		 	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(labcode));                     
    		req.setAttribute("LabList", service.LabList(labcode));
    		req.setAttribute("PfmsInitiationList",PfmsInitiationList);
    		req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(InitiationId));
			req.setAttribute("CostDetailsList", costDetailsList);
    		req.setAttribute("ScheduleList", service.ProjectInitiationScheduleList(InitiationId));
    		req.setAttribute("isprint", "1");
    		
    		
    		costDetailsList.stream().filter(e-> Collections.frequency(costDetailsList, e[4])<1).collect(Collectors.toList());    		
    		
    		String filename="ExecutiveSummary";	
	    	String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/PfmsPrint.jsp").forward(req, customResponse);
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
	     

	    	
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ExecutiveSummaryDownload.htm "+UserId, e);
    		e.printStackTrace();
			
	
    	}		
	}
	
	
	@RequestMapping(value="ProjectProposalDownload.htm", method = RequestMethod.POST )
	public void ProjectProposalDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		
		logger.info(new Date() +"Inside ProjectProposalDownload.htm "+UserId);		
	    try {
	    
	    	String InitiationId=req.getParameter("IntiationId");
	    	Object[] PfmsInitiationList= service.PfmsInitiationList(InitiationId).get(0);
	    	String LabCode =PfmsInitiationList[17].toString();
	    	String projecttypeid =PfmsInitiationList[18].toString();
	    	List<Object[]> CostBreak = service.GetCostBreakList(InitiationId,projecttypeid); 
	    	req.setAttribute("costbreak", CostBreak);
	    	req.setAttribute("lablogo",  LogoUtil.getLabLogoAsBase64String(LabCode));  
    		req.setAttribute("PfmsInitiationList", PfmsInitiationList);
    		req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(InitiationId));
    		req.setAttribute("CostDetailsList", service.CostDetailsList(InitiationId));
    		req.setAttribute("ScheduleList", service.ProjectInitiationScheduleList(InitiationId));
    		req.setAttribute("LabList", service.LabList(LabCode));
    		req.setAttribute("RequirementList", service.RequirementList(InitiationId));
    
    		String filename="ProjectProposal";	
	    	String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/PfmsPrint2.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			ConverterProperties converterProperties = new ConverterProperties();
	    	FontProvider dfp = new DefaultFontProvider(true, true, true);
	    	converterProperties.setFontProvider(dfp);

			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"),converterProperties);
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

	        
//    		String filename="ProjectProposal";		
//	    	
//	    	String path=req.getServletContext().getRealPath("/view/temp");
//	    	req.setAttribute("path",path); 
//	    	CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
//	    	req.getRequestDispatcher("/view/print/PfmsPrint2.jsp").forward(req, customResponse);
//	    	String html = customResponse.getOutput();
//	    	byte[] data = html.getBytes();
//	    	InputStream fis1=new ByteArrayInputStream(data);
//	    	PdfDocument pdfDoc = new PdfDocument(new PdfWriter(path+"/"+filename+".pdf"));	
//	    	
//	    	Document document = new Document(pdfDoc, PageSize.A4);
//	    	//document.setMargins(50, 100, 150, 50);
//	    	document.setMargins(50, 50, 50, 50);
//	    	ConverterProperties converterProperties = new ConverterProperties();
//	    	FontProvider dfp = new DefaultFontProvider(true, true, true);
//	    	converterProperties.setFontProvider(dfp);
//	        HtmlConverter.convertToPdf(fis1,pdfDoc,converterProperties);
//            ImageData leftLogo = ImageDataFactory.create(env.getProperty("file_upload_path")+"\\logo\\drdo.png");
//            ImageData rightLogo = ImageDataFactory.create(env.getProperty("file_upload_path")+"\\logo\\lab.png");
//	        PdfWriter pdfw=new PdfWriter(path +File.separator+ "mergedb.pdf");
//	        
//	        
//	        PdfDocument pdfDocMain = new PdfDocument(new PdfReader(path+File.separator+filename+".pdf"),new PdfWriter(path+File.separator+filename+"Maintemp.pdf"));
//	        Document docMain = new Document(pdfDocMain,PageSize.A4);
//	        docMain.setMargins(50, 50, 50, 50);
//	        Rectangle pageSizeMain;
//	        PdfCanvas canvasMAin;
//	        int main = pdfDocMain.getNumberOfPages();
//	        for (int i = 1; i <= main; i++) {
//	            PdfPage pageMain = pdfDocMain.getPage(i);
//	            pageSizeMain = pageMain.getPageSize();
//	            canvasMAin = new PdfCanvas(pageMain);
//	            Rectangle rectaMain=new Rectangle(54,pageSizeMain.getHeight()-34,34,33);
//	            canvasMAin.addImage(leftLogo, rectaMain, false);
//	            Rectangle rectaMain2=new Rectangle(pageSizeMain.getWidth()-64,pageSizeMain.getHeight()-34,34,33);
//	            canvasMAin.addImage(rightLogo, rectaMain2, false);
//
//
//	        }
//	        
//	        res.setContentType("application/pdf");
//	        res.setHeader("Content-disposition","inline;filename="+filename+".pdf"); 
//	        
//	        File f=new File(path+"/"+filename+".pdf");
//	        FileInputStream fis = new FileInputStream(f);
//	        DataOutputStream os = new DataOutputStream(res.getOutputStream());
//	        res.setHeader("Content-Length",String.valueOf(f.length()));
//	        byte[] buffer = new byte[1024];
//	        int len = 0;
//	        while ((len = fis.read(buffer)) >= 0) {
//	            os.write(buffer, 0, len);
//	        } 
//	        os.close();
//	        fis.close();
//	        document.close();
//	        docMain.close();
//	        
//	        Path pathOfFile2= Paths.get(path +File.separator+ "mergedb.pdf"); 
//	        Files.delete(pathOfFile2);
//	        pathOfFile2= Paths.get( path+File.separator+filename+"Maintemp.pdf");
//	        Files.delete(pathOfFile2);	
//	        document.close();

	        
	    	
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectProposalDownload.htm "+UserId, e);
    		e.printStackTrace();
			
	
    	}		
	}
	
	
	@RequestMapping(value="ProjectBriefingDownload.htm")
	public void ProjectBriefingDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectBriefingDownload.htm "+UserId);		
	    try {
	    	String projectid=req.getParameter("projectid");
	    	String committeeid= req.getParameter("committeeid");
	    	String tempid=committeeid;
	  

	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	String Logintype= (String)ses.getAttribute("LoginType");
	    	Committee committee = service.getCommitteeData(committeeid);
	    	
	    	String projectLabCode = service.ProjectDetails(projectid).get(0)[5].toString();
	    	String CommitteeCode = committee.getCommitteeShortName().trim();
	    	
	    	List<Object[]> projectattributes = new ArrayList<Object[]>();
	    	List<List<Object[]>>  ebandpmrccount = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestonesubsystems = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestones  = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> lastpmrcactions = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> lastpmrcminsactlist = new ArrayList<List<Object[]>>();
	    	List<Object[]> ProjectDetails = new ArrayList<Object[]>();
	    	List<List<Object[]>> ganttchartlist = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> oldpmrcissueslist = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> riskmatirxdata = new ArrayList<List<Object[]>>();
	    	List<Object[]> lastpmrcdecisions = new ArrayList<Object[]>();
	    	List<List<Object[]>> actionplanthreemonths = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> ReviewMeetingListEB = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> ReviewMeetingListPMRC = new ArrayList<List<Object[]>>();
	    	List<Object[]> projectdatadetails  = new ArrayList<Object[]>();
	    	List<Object[]> TechWorkDataList =new ArrayList<Object[]>();
    		List<List<Object[]>> milestonesubsystemsnew = new ArrayList<List<Object[]>>();
	    	
	    	List<List<Object[]>> ProjectRevList =new ArrayList<List<Object[]>>();
	    	
	    	
	    	List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
	    	List<List<Object[]>> procurementOnDemandlist  = new ArrayList<List<Object[]>>();
    		List<List<Object[]>> procurementOnSanctionlist = new ArrayList<List<Object[]>>();
    		List<List<TechImages>> TechImages =new ArrayList<List<TechImages>>();
	    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	for(String proid : Pmainlist) 
	    	{	    	
	    		Object[] projectattribute = service.ProjectAttributes(proid);
	    		
	    		TechImages.add(service.getTechList(proid));
	    		projectattributes.add(projectattribute);
	    		ebandpmrccount.add(service.EBAndPMRCCount(proid));
	    		milestonesubsystems.add(service.MilestoneSubsystems(proid));
	    		milestones.add(service.Milestones(proid));
	    		lastpmrcactions.add(service.LastPMRCActions(proid,committeeid));
	    		lastpmrcminsactlist.add(service.LastPMRCActions1(proid,committeeid));
	    		ProjectDetails.add(service.ProjectDetails(proid).get(0));
	    		ganttchartlist.add(service.GanttChartList(proid));
	    		oldpmrcissueslist.add(service.OldPMRCIssuesList(proid));
	    		riskmatirxdata.add(service.RiskMatirxData(proid));
	    		lastpmrcdecisions.add(service.LastPMRCDecisions(committeeid,proid));
	    		actionplanthreemonths.add(service.ActionPlanSixMonths(proid,CommitteeCode));
	    		projectdatadetails.add(service.ProjectDataDetails(proid));
	    		ReviewMeetingListEB.add(service.ReviewMeetingList(projectid, "EB"));
	    		ReviewMeetingListPMRC.add(service.ReviewMeetingList(projectid, "PMRC"));
	    		TechWorkDataList.add(service.TechWorkData(proid));
		    	milestonesubsystemsnew.add(service.BreifingMilestoneDetails(proid,CommitteeCode));
	    		ProjectRevList.add(service.ProjectRevList(proid));
	    	
		/* ----------------------------------------------------------------------------------------------------------	   */  		
	    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectattribute[0]+"&rupess="+10000000;
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
							/*
							 * projectDetails = mapper.readValue(jsonResult,
							 * mapper.getTypeFactory().constructCollectionType(List.class,
							 * ProjectFinancialDetails.class));
							 */
							projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
							financialDetails.add(projectDetails);
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
							/*
							 * projectDetails = mapper.readValue(jsonResult,
							 * mapper.getTypeFactory().constructCollectionType(List.class,
							 * ProjectFinancialDetails.class));
							 */
							totaldemand = mapper2.readValue(jsonResult2, new TypeReference<List<TotalDemand>>(){});
							req.setAttribute("TotalProcurementDetails",totaldemand);
						} catch (JsonProcessingException e) {
							e.printStackTrace();
						}
					}
	 
	    	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(proid);
	    	List<Object[]> procurementOnDemand=null;
	    	List<Object[]> procurementOnSanction=null;
	    	

	    	if(procurementStatusList!=null)
	    	{
		    	Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
		    	Collection<?> keys = map.keySet();
		    	for(Object key:keys)
		    	{
		    		if(key.toString().equals("D")) {
		    			procurementOnDemand=map.get(key);
			    	}else if(key.toString().equals("S")) {
			    		procurementOnSanction=map.get(key);
			    	}
		    	 }
	    	}
//	    	procurementOnDemandlist.add(procurementStatusList);
//	    	procurementOnDemandlist.add(procurementOnDemand);
//	    	procurementOnSanctionlist.add(procurementOnSanction);
	    	
	    	procurementOnDemandlist.add(procurementOnDemand);
	    	procurementOnSanctionlist.add(procurementOnSanction);
	    	
	    	req.setAttribute("procurementOnDemand", procurementOnDemand);
	    	req.setAttribute("procurementOnSanction", procurementOnSanction);
	    }
/* ----------------------------------------------------------------------------------------------------------  */
	    	
	    	req.setAttribute("TechImages",TechImages);
	    	req.setAttribute("committeeData", committee);
	    	req.setAttribute("projectattributes",projectattributes);
    		req.setAttribute("ebandpmrccount", ebandpmrccount);	    		
    		req.setAttribute("milestonesubsystems", milestonesubsystems);
    		req.setAttribute("milestones", milestones);	  
    		req.setAttribute("lastpmrcactions", lastpmrcactions);
    		req.setAttribute("lastpmrcminsactlist", lastpmrcminsactlist);
    		req.setAttribute("ProjectDetails", ProjectDetails);
    		req.setAttribute("ganttchartlist", ganttchartlist );
    		req.setAttribute("oldpmrcissueslist",oldpmrcissueslist);	    		
    		req.setAttribute("riskmatirxdata",riskmatirxdata);	    		
    		req.setAttribute("lastpmrcdecisions" , lastpmrcdecisions);	    		
    		req.setAttribute("actionplanthreemonths" , actionplanthreemonths);  	
    		req.setAttribute("projectdatadetails",projectdatadetails);
    		
    		
    		req.setAttribute("ReviewMeetingList",ReviewMeetingListEB);
    		req.setAttribute("ReviewMeetingListPMRC",ReviewMeetingListPMRC);
    		
    		req.setAttribute("financialDetails",financialDetails);
    		req.setAttribute("procurementOnDemandlist",procurementOnDemandlist);
    		req.setAttribute("procurementOnSanctionlist",procurementOnSanctionlist);
    		
    		req.setAttribute("TechWorkDataList",TechWorkDataList);
    		req.setAttribute("ProjectRevList", ProjectRevList);
        	
    		req.setAttribute("projectidlist",Pmainlist);
    		req.setAttribute("projectid",projectid);
    		req.setAttribute("committeeid",tempid);
    		req.setAttribute("ProjectCost",ProjectCost);
	    	req.setAttribute("isprint", "0");
	    	req.setAttribute("AppFilesPath",ApplicationFilesDrive);
	    	req.setAttribute("projectLabCode",projectLabCode);
	    	req.setAttribute("labInfo", service.LabDetailes(projectLabCode));
	    	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(projectLabCode));    
            req.setAttribute("filePath", env.getProperty("ApplicationFilesDrive"));
            req.setAttribute("milestonedatalevel6", milestonesubsystemsnew);
    		req.setAttribute("ApplicationFilesDrive",env.getProperty("ApplicationFilesDrive"));
    		req.setAttribute("committeeMetingsCount", service.ProjectCommitteeMeetingsCount(projectid, CommitteeCode) );
    		Object[] nextmeetVenue = (Object[])service.BriefingMeetingVenue(projectid, committeeid);
	    	req.setAttribute("nextMeetVenue", nextmeetVenue);
	    	if(nextmeetVenue!=null && nextmeetVenue[0]!=null) {
	    	req.setAttribute("recdecDetails", service.GetRecDecDetails(nextmeetVenue[0].toString()));
	    	}
    		
    		String LevelId= "2";
			
			if(service.MileStoneLevelId(projectid,committeeid) != null) {
				LevelId= service.MileStoneLevelId(projectid,committeeid)[0].toString();
			}
			  		
			req.setAttribute("levelid", LevelId);
			
    		
    		
	    	String filename="BriefingPaper";		
	    	
	    	String path=req.getServletContext().getRealPath("/view/temp");
	    	req.setAttribute("path",path); 
	    	CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
	    	req.getRequestDispatcher("/view/print/BriefingPaperNew1.jsp").forward(req, customResponse);
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
            ImageData leftLogo = ImageDataFactory.create(env.getProperty("ApplicationFilesDrive")+"\\images\\lablogos\\drdo.png");
            ImageData rightLogo = ImageDataFactory.create(env.getProperty("ApplicationFilesDrive")+"\\images\\lablogos\\"+projectLabCode.toLowerCase()+".png");
	        PdfWriter pdfw=new PdfWriter(path +File.separator+ "mergedb.pdf");
	        
	        
	        PdfDocument pdfDocMain = new PdfDocument(new PdfReader(path+File.separator+filename+".pdf"),new PdfWriter(path+File.separator+filename+"Maintemp.pdf"));
	        Document docMain = new Document(pdfDocMain,PageSize.A4);
	        docMain.setMargins(50, 50, 50, 50);
	        Rectangle pageSizeMain;
	        PdfCanvas canvasMAin;
	        int main = pdfDocMain.getNumberOfPages();
	        for (int i = 1; i <= main; i++) {
	            PdfPage pageMain = pdfDocMain.getPage(i);
	            pageSizeMain = pageMain.getPageSize();
	            canvasMAin = new PdfCanvas(pageMain);
	            Rectangle rectaMain=new Rectangle(54,pageSizeMain.getHeight()-34,34,33);
	            canvasMAin.addImage(leftLogo, rectaMain, false);
	            Rectangle rectaMain2=new Rectangle(pageSizeMain.getWidth()-64,pageSizeMain.getHeight()-34,34,33);
	            canvasMAin.addImage(rightLogo, rectaMain2, false);


	        }
	        docMain.close();
	        pdfDocMain.close();
	        Path pathOfFileMain= Paths.get( path+File.separator+filename+".pdf");
	        Files.delete(pathOfFileMain);	
	        
	        PdfReader pdf1=new PdfReader(path+File.separator+filename+"Maintemp.pdf");
	        PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);
	        PdfMerger merger = new PdfMerger(pdfDocument);
	        int z=0;
	        for(Object[] objData:projectdatadetails)
			{	
	        	if(objData!=null) {
	        	
	        	try {
	        		String No2=null;
	        		if(CommitteeCode.equalsIgnoreCase("PMRC")){ 
	        		No2="P"+(Long.parseLong(ebandpmrccount.get(0).get(0)[1].toString())+1);
	        		}else if(CommitteeCode.equalsIgnoreCase("EB")){
	        			No2="E"+(Long.parseLong(ebandpmrccount.get(0).get(1)[1].toString())+1);
	        		} 
		        	if(new File(env.getProperty("ApplicationFilesDrive")+"\\"+projectLabCode+"\\gantt\\grantt_"+objData[1]+"_"+No2+".pdf").exists()) {
		        		 	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("ApplicationFilesDrive")+"\\"+projectLabCode+"\\gantt\\grantt_"+objData[1]+"_"+No2+".pdf"),new PdfWriter(path+File.separator+filename+"temp.pdf"));
					        Document document5 = new Document(pdfDocument2,PageSize.A4);
					        document5.setMargins(50, 50, 50, 50);
					        Rectangle pageSize;
					        PdfCanvas canvas;
					        int n = pdfDocument2.getNumberOfPages();
					        for (int i = 1; i <= n; i++) {
					            PdfPage page = pdfDocument2.getPage(i);
					            pageSize = page.getPageSize();
					            canvas = new PdfCanvas(page);
					            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
					            canvas.addImage(leftLogo, recta, false);
					            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
					            canvas.addImage(rightLogo, recta2, false);
					            canvas.beginText().setFontAndSize(
					                    PdfFontFactory.createFont(FontConstants.HELVETICA), 11)
					                    .moveText(pageSize.getWidth() / 2 - 124, pageSize.getHeight() - 25)
					                    .showText(objData[12]+" :-  Grantt Chart ")
					                    .endText();
					            

					        }
					        document5.close();
					        pdfDocument2.close();
				        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
				        	 PdfDocument pdfDocument3 = new PdfDocument(pdf2);
					        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
					        
					        pdfDocument3.close();
					        pdf2.close();
					        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
					        Files.delete(pathOfFile);	
					        pathOfFile= Paths.get( path+File.separator+TechWorkDataList.get(z)[8].toString());
					        
						    }
		        	 
		        	}
	        	
	        		catch (Exception e) {
	        			logger.error(new Date() +" Inside ProjectBriefingDownload "+UserId, e);
						e.printStackTrace();
					}
	        	
	        	}
	        	
	        	
	        	if(objData!=null && objData[3]!=null) {
	        	if(FilenameUtils.getExtension(objData[3].toString()).equalsIgnoreCase("pdf")) {
		        PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("ApplicationFilesDrive")+objData[2]+"\\"+objData[3]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
		        Document document5 = new Document(pdfDocument2,PageSize.A4);
		        document5.setMargins(50, 50, 50, 50);
		        Rectangle pageSize;
		        PdfCanvas canvas;
		        int n = pdfDocument2.getNumberOfPages();
		        for (int i = 1; i <= n; i++) {
		            PdfPage page = pdfDocument2.getPage(i);
		            pageSize = page.getPageSize();
		            canvas = new PdfCanvas(page);
		            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
		            canvas.addImage(leftLogo, recta, false);
		            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
		            canvas.addImage(rightLogo, recta2, false);
		            canvas.beginText().setFontAndSize(
		                    PdfFontFactory.createFont(FontConstants.HELVETICA), 11)
		                    .moveText(pageSize.getWidth() / 2 - 124, pageSize.getHeight() - 25)
		                    .showText(objData[12]+" :-  System Configuration Annexure: ")
		                    .endText();

		        }
		        document5.close();
		        pdfDocument2.close();
	        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
	        	 PdfDocument pdfDocument3 = new PdfDocument(pdf2);
		        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
		        
		        pdfDocument3.close();
		        pdf2.close();
		        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
		        Files.delete(pathOfFile);	
			    }
	        	}
	        	if(objData!=null && objData[4]!=null) {
			    if(FilenameUtils.getExtension(objData[4].toString()).equalsIgnoreCase("pdf")) {
			    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("ApplicationFilesDrive")+objData[2]+"\\"+objData[4]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
			        Document document5 = new Document(pdfDocument2,PageSize.A4);
			        document5.setMargins(50, 50, 50, 50);
			        Rectangle pageSize;
			        PdfCanvas canvas;
			        int n = pdfDocument2.getNumberOfPages();
			        for (int i = 1; i <= n; i++) {
			            PdfPage page = pdfDocument2.getPage(i);
			            pageSize = page.getPageSize();
			            canvas = new PdfCanvas(page);
			            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
			            canvas.addImage(leftLogo, recta, false);
			            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
			            canvas.addImage(rightLogo, recta2, false);
			            canvas.beginText().setFontAndSize(
			                    PdfFontFactory.createFont(FontConstants.HELVETICA),11)
			                    .moveText(pageSize.getWidth() / 2 - 130, pageSize.getHeight() - 25)
			                    .showText(objData[12]+" :-  System Specification Annexure: ")
			                    .endText();

			        }
			        document5.close();
			        pdfDocument2.close();
		        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
		        	 PdfDocument pdfDocument3 = new PdfDocument(pdf2);
			        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
			        
			        pdfDocument3.close();
			        pdf2.close();
			        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
			        Files.delete(pathOfFile);	
			    }
	        	}
	        	if(objData!=null && objData[5]!=null) {
			    if(FilenameUtils.getExtension(objData[5].toString()).equalsIgnoreCase("pdf")) {
			    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("ApplicationFilesDrive")+objData[2]+"\\"+objData[5]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
			        Document document5 = new Document(pdfDocument2,PageSize.A4);
			        document5.setMargins(50, 50, 50, 50);
			        Rectangle pageSize;
			        PdfCanvas canvas;
			        int n = pdfDocument2.getNumberOfPages();
			        for (int i = 1; i <= n; i++) {
			            PdfPage page = pdfDocument2.getPage(i);
			            pageSize = page.getPageSize();
			            canvas = new PdfCanvas(page);
			            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
			            canvas.addImage(leftLogo, recta, false);
			            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
			            canvas.addImage(rightLogo, recta2, false);
			            canvas.beginText().setFontAndSize(
			                    PdfFontFactory.createFont(FontConstants.HELVETICA), 11)
			                    .moveText(pageSize.getWidth() / 2 - 140, pageSize.getHeight() - 25)
			                    .showText(objData[12]+" :-  Overall Product tree/WBS Annexure: ")
			                    .endText();

			        }
			        document5.close();
			        pdfDocument2.close();
		        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
		        	 PdfDocument pdfDocument3 = new PdfDocument(pdf2);
			        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
			        
			        pdfDocument3.close();
			        pdf2.close();
			        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
			        Files.delete(pathOfFile);	
				    }
	        	}
	        	if(objData!=null&&objData[6]!=null) {
			    if(FilenameUtils.getExtension(objData[6].toString()).equalsIgnoreCase("pdf")) {
			    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("ApplicationFilesDrive")+objData[2]+"\\"+objData[6]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
			        Document document5 = new Document(pdfDocument2,PageSize.A4);
			        document5.setMargins(50, 50, 50, 50);
			        Rectangle pageSize;
			        PdfCanvas canvas;
			        int n = pdfDocument2.getNumberOfPages();
			        for (int i = 1; i <= n; i++) {
			            PdfPage page = pdfDocument2.getPage(i);
			            pageSize = page.getPageSize();
			            canvas = new PdfCanvas(page);
			            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
			            canvas.addImage(leftLogo, recta, false);
			            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
			            canvas.addImage(rightLogo, recta2, false);
			            canvas.beginText().setFontAndSize(
			                    PdfFontFactory.createFont(FontConstants.HELVETICA), 11)
			                    .moveText(pageSize.getWidth() / 2 - 145, pageSize.getHeight() - 25)
			                    .showText(objData[12]+" :-  TRL table with TRL at sanction stage Annexure ")
			                    .endText();
			            

			        }
			        document5.close();
			        pdfDocument2.close();
		        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
		        	PdfDocument pdfDocument3 = new PdfDocument(pdf2);
			        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
			        
			        pdfDocument3.close();
			        pdf2.close();
			        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
			        Files.delete(pathOfFile);	
				    }
	        	}
	        	
	        	//Point 13
	        	try {
	        	
	        	 if(FilenameUtils.getExtension(TechWorkDataList.get(z)[8].toString()).equalsIgnoreCase("pdf")) {
	        		 Zipper zip=new Zipper();
	                 zip.unpack(env.getProperty("ApplicationFilesDrive")+TechWorkDataList.get(z)[6].toString()+TechWorkDataList.get(z)[7].toString()+TechWorkDataList.get(z)[11].toString()+"-"+TechWorkDataList.get(z)[10].toString()+".zip",path,TechWorkDataList.get(z)[9].toString());
				    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(path+File.separator+TechWorkDataList.get(z)[8].toString()),new PdfWriter(path+File.separator+filename+"temp.pdf"));
				        Document document5 = new Document(pdfDocument2,PageSize.A4);
				        document5.setMargins(50, 50, 50, 50);
				        Rectangle pageSize;
				        PdfCanvas canvas;
				        int n = pdfDocument2.getNumberOfPages();
				        for (int i = 1; i <= n; i++) {
				            PdfPage page = pdfDocument2.getPage(i);
				            pageSize = page.getPageSize();
				            canvas = new PdfCanvas(page);
				            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
				            canvas.addImage(leftLogo, recta, false);
				            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
				            canvas.addImage(rightLogo, recta2, false);
				            canvas.beginText().setFontAndSize(
				                    PdfFontFactory.createFont(FontConstants.HELVETICA), 11)
				                    .moveText(pageSize.getWidth() / 2 - 80, pageSize.getHeight() - 25)
				                    .showText(objData[12]+" :-  Technical Details ")
				                    .endText();
				            

				        }
				        document5.close();
				        pdfDocument2.close();
			        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
			        	PdfDocument pdfDocument3 = new PdfDocument(pdf2);
				        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
				        
				        pdfDocument3.close();
				        pdf2.close();
				        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
				        Files.delete(pathOfFile);	
				        pathOfFile= Paths.get( path+File.separator+TechWorkDataList.get(z)[8].toString());
				        Files.delete(pathOfFile);	
					    }
	        	
	        	}catch (Exception e) {
	        		logger.error(new Date() +" Inside ProjectBriefingDownload "+UserId, e);
					e.printStackTrace();
				}
	        	
	        	z++;
			}


	        pdfDocument.close();
	        merger.close();

	        pdf1.close();	       
	        pdfw.close();
	        res.setContentType("application/pdf");
	        res.setHeader("Content-disposition","inline;filename="+filename+".pdf"); 
	        File f=new File(path +File.separator+ "mergedb.pdf");
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
	         
	            
	        Path pathOfFile2= Paths.get(path +File.separator+ "mergedb.pdf"); 
	        Files.delete(pathOfFile2);
	        pathOfFile2= Paths.get( path+File.separator+filename+"Maintemp.pdf");
	        Files.delete(pathOfFile2);	
	        document.close();
	    	
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectBriefingDownload.htm "+UserId, e);
    		e.printStackTrace();
			/* return "static/Error"; */
	
    	}		
	}
	
	
	public File BriefingPaperGeneratePDF(HttpServletRequest req, HttpServletResponse res, HttpSession ses,RedirectAttributes redir)
	{

		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectBriefingDownload.htm "+UserId);		
	    try {
	    	String projectid=req.getParameter("projectid");
	    	String committeeid= req.getParameter("committeeid");
	    	String tempid=committeeid;
	  

	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	String Logintype= (String)ses.getAttribute("LoginType");
	    	Committee committee = service.getCommitteeData(committeeid);
	    	
	    	String projectLabCode = service.ProjectDetails(projectid).get(0)[5].toString();
	    	String CommitteeCode = committee.getCommitteeShortName().trim();
	    	
	    	List<Object[]> projectattributes = new ArrayList<Object[]>();
	    	List<List<Object[]>>  ebandpmrccount = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestonesubsystems = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestones  = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> lastpmrcactions = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> lastpmrcminsactlist = new ArrayList<List<Object[]>>();
	    	List<Object[]> ProjectDetails = new ArrayList<Object[]>();
	    	List<List<Object[]>> ganttchartlist = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> oldpmrcissueslist = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> riskmatirxdata = new ArrayList<List<Object[]>>();
	    	List<Object[]> lastpmrcdecisions = new ArrayList<Object[]>();
	    	List<List<Object[]>> actionplanthreemonths = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> ReviewMeetingListEB = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> ReviewMeetingListPMRC = new ArrayList<List<Object[]>>();
	    	List<Object[]> projectdatadetails  = new ArrayList<Object[]>();
	    	List<Object[]> TechWorkDataList =new ArrayList<Object[]>();
    		List<List<Object[]>> milestonesubsystemsnew = new ArrayList<List<Object[]>>();
	    	
	    	List<List<Object[]>> ProjectRevList =new ArrayList<List<Object[]>>();
	    	
	    	
	    	List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
	    	List<List<Object[]>> procurementOnDemandlist  = new ArrayList<List<Object[]>>();
    		List<List<Object[]>> procurementOnSanctionlist = new ArrayList<List<Object[]>>();
    		List<List<TechImages>> TechImages =new ArrayList<List<TechImages>>();
	    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	for(String proid : Pmainlist) 
	    	{	    	
	    		Object[] projectattribute = service.ProjectAttributes(proid);
	    		
	    		TechImages.add(service.getTechList(proid));
	    		projectattributes.add(projectattribute);
	    		ebandpmrccount.add(service.EBAndPMRCCount(proid));
	    		milestonesubsystems.add(service.MilestoneSubsystems(proid));
	    		milestones.add(service.Milestones(proid));
	    		lastpmrcactions.add(service.LastPMRCActions(proid,committeeid));
	    		lastpmrcminsactlist.add(service.LastPMRCActions1(proid,committeeid));
	    		ProjectDetails.add(service.ProjectDetails(proid).get(0));
	    		ganttchartlist.add(service.GanttChartList(proid));
	    		oldpmrcissueslist.add(service.OldPMRCIssuesList(proid));
	    		riskmatirxdata.add(service.RiskMatirxData(proid));
	    		lastpmrcdecisions.add(service.LastPMRCDecisions(committeeid,proid));
	    		actionplanthreemonths.add(service.ActionPlanSixMonths(proid,CommitteeCode));
	    		projectdatadetails.add(service.ProjectDataDetails(proid));
	    		ReviewMeetingListEB.add(service.ReviewMeetingList(projectid, "EB"));
	    		ReviewMeetingListPMRC.add(service.ReviewMeetingList(projectid, "PMRC"));
	    		TechWorkDataList.add(service.TechWorkData(proid));
		    	milestonesubsystemsnew.add(service.BreifingMilestoneDetails(proid,CommitteeCode));
	    		ProjectRevList.add(service.ProjectRevList(proid));
	    	
		/* ----------------------------------------------------------------------------------------------------------	   */  		
	    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectattribute[0]+"&rupess="+10000000;
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
							/*
							 * projectDetails = mapper.readValue(jsonResult,
							 * mapper.getTypeFactory().constructCollectionType(List.class,
							 * ProjectFinancialDetails.class));
							 */
							projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
							financialDetails.add(projectDetails);
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
							/*
							 * projectDetails = mapper.readValue(jsonResult,
							 * mapper.getTypeFactory().constructCollectionType(List.class,
							 * ProjectFinancialDetails.class));
							 */
							totaldemand = mapper2.readValue(jsonResult2, new TypeReference<List<TotalDemand>>(){});
							req.setAttribute("TotalProcurementDetails",totaldemand);
						} catch (JsonProcessingException e) {
							e.printStackTrace();
						}
					}
	 
	    	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(proid);
	    	List<Object[]> procurementOnDemand=null;
	    	List<Object[]> procurementOnSanction=null;
	    	

	    	if(procurementStatusList!=null)
	    	{
		    	Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
		    	Collection<?> keys = map.keySet();
		    	for(Object key:keys)
		    	{
		    		if(key.toString().equals("D")) {
		    			procurementOnDemand=map.get(key);
			    	}else if(key.toString().equals("S")) {
			    		procurementOnSanction=map.get(key);
			    	}
		    	 }
	    	}
//	    	procurementOnDemandlist.add(procurementStatusList);
//	    	procurementOnDemandlist.add(procurementOnDemand);
//	    	procurementOnSanctionlist.add(procurementOnSanction);
	    	
	    	procurementOnDemandlist.add(procurementOnDemand);
	    	procurementOnSanctionlist.add(procurementOnSanction);
	    	
	    	req.setAttribute("procurementOnDemand", procurementOnDemand);
	    	req.setAttribute("procurementOnSanction", procurementOnSanction);
	    }
/* ----------------------------------------------------------------------------------------------------------  */
	    	
	    	req.setAttribute("TechImages",TechImages);
	    	req.setAttribute("committeeData", committee);
	    	req.setAttribute("projectattributes",projectattributes);
    		req.setAttribute("ebandpmrccount", ebandpmrccount);	    		
    		req.setAttribute("milestonesubsystems", milestonesubsystems);
    		req.setAttribute("milestones", milestones);	  
    		req.setAttribute("lastpmrcactions", lastpmrcactions);
    		req.setAttribute("lastpmrcminsactlist", lastpmrcminsactlist);
    		req.setAttribute("ProjectDetails", ProjectDetails);
    		req.setAttribute("ganttchartlist", ganttchartlist );
    		req.setAttribute("oldpmrcissueslist",oldpmrcissueslist);	    		
    		req.setAttribute("riskmatirxdata",riskmatirxdata);	    		
    		req.setAttribute("lastpmrcdecisions" , lastpmrcdecisions);	    		
    		req.setAttribute("actionplanthreemonths" , actionplanthreemonths);  	
    		req.setAttribute("projectdatadetails",projectdatadetails);
    		
    		
    		req.setAttribute("ReviewMeetingList",ReviewMeetingListEB);
    		req.setAttribute("ReviewMeetingListPMRC",ReviewMeetingListPMRC);
    		
    		req.setAttribute("financialDetails",financialDetails);
    		req.setAttribute("procurementOnDemandlist",procurementOnDemandlist);
    		req.setAttribute("procurementOnSanctionlist",procurementOnSanctionlist);
    		
    		req.setAttribute("TechWorkDataList",TechWorkDataList);
    		req.setAttribute("ProjectRevList", ProjectRevList);
        	
    		req.setAttribute("projectidlist",Pmainlist);
    		req.setAttribute("projectid",projectid);
    		req.setAttribute("committeeid",tempid);
    		req.setAttribute("ProjectCost",ProjectCost);
	    	req.setAttribute("isprint", "0");
	    	req.setAttribute("AppFilesPath",ApplicationFilesDrive);
	    	req.setAttribute("projectLabCode",projectLabCode);
	    	req.setAttribute("labInfo", service.LabDetailes(projectLabCode));
	    	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(projectLabCode));    
            req.setAttribute("filePath", env.getProperty("ApplicationFilesDrive"));
            req.setAttribute("milestonedatalevel6", milestonesubsystemsnew);
    		req.setAttribute("ApplicationFilesDrive",env.getProperty("ApplicationFilesDrive"));
    		req.setAttribute("committeeMetingsCount", service.ProjectCommitteeMeetingsCount(projectid, CommitteeCode) );
    		req.setAttribute("nextMeetVenue", service.BriefingMeetingVenue(projectid, committeeid));
    		
    		String LevelId= "2";
			
			if(service.MileStoneLevelId(projectid,committeeid) != null) {
				LevelId= service.MileStoneLevelId(projectid,committeeid)[0].toString();
			}
			  		
			req.setAttribute("levelid", LevelId);
					
		    		
		    		
			    	String filename="BriefingPaper";		
			    	
			    	String path=req.getServletContext().getRealPath("/view/temp");
			    	req.setAttribute("path",path); 
			    	CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			    	req.getRequestDispatcher("/view/print/BriefingPaperNew1.jsp").forward(req, customResponse);
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
		            ImageData leftLogo = ImageDataFactory.create(env.getProperty("ApplicationFilesDrive")+"\\images\\lablogos\\drdo.png");
		            ImageData rightLogo = ImageDataFactory.create(env.getProperty("ApplicationFilesDrive")+"\\images\\lablogos\\"+projectLabCode.toLowerCase()+".png");
			        PdfWriter pdfw=new PdfWriter(path +File.separator+ "mergedb.pdf");
			        
			        
			        PdfDocument pdfDocMain = new PdfDocument(new PdfReader(path+File.separator+filename+".pdf"),new PdfWriter(path+File.separator+filename+"Maintemp.pdf"));
			        Document docMain = new Document(pdfDocMain,PageSize.A4);
			        docMain.setMargins(50, 50, 50, 50);
			        Rectangle pageSizeMain;
			        PdfCanvas canvasMAin;
			        int main = pdfDocMain.getNumberOfPages();
			        for (int i = 1; i <= main; i++) {
			            PdfPage pageMain = pdfDocMain.getPage(i);
			            pageSizeMain = pageMain.getPageSize();
			            canvasMAin = new PdfCanvas(pageMain);
			            Rectangle rectaMain=new Rectangle(54,pageSizeMain.getHeight()-34,34,33);
			            canvasMAin.addImage(leftLogo, rectaMain, false);
			            Rectangle rectaMain2=new Rectangle(pageSizeMain.getWidth()-64,pageSizeMain.getHeight()-34,34,33);
			            canvasMAin.addImage(rightLogo, rectaMain2, false);
		
		
			        }
			        docMain.close();
			        pdfDocMain.close();
			        Path pathOfFileMain= Paths.get( path+File.separator+filename+".pdf");
			        Files.delete(pathOfFileMain);	
			        
			        
			        PdfReader pdf1=new PdfReader(path+File.separator+filename+"Maintemp.pdf");
			        PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);
			        PdfMerger merger = new PdfMerger(pdfDocument);
			        int z=0;
			        try {
			        	for(Object[] objData:projectdatadetails)
						{	
				        	if(objData!=null) {
				        	
				        	try {
				        		String No2=null;
				        		if(CommitteeCode.equalsIgnoreCase("PMRC")){ 
				        		No2="P"+(Long.parseLong(ebandpmrccount.get(0).get(0)[1].toString())+1);
				        		}else if(CommitteeCode.equalsIgnoreCase("EB")){
				        			No2="E"+(Long.parseLong(ebandpmrccount.get(0).get(1)[1].toString())+1);
				        		} 
					        	if(new File(env.getProperty("ApplicationFilesDrive")+"\\"+projectLabCode+"\\gantt\\grantt_"+objData[1]+"_"+No2+".pdf").exists()) {
					        		 	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("ApplicationFilesDrive")+"\\"+projectLabCode+"\\gantt\\grantt_"+objData[1]+"_"+No2+".pdf"),new PdfWriter(path+File.separator+filename+"temp.pdf"));
								        Document document5 = new Document(pdfDocument2,PageSize.A4);
								        document5.setMargins(50, 50, 50, 50);
								        Rectangle pageSize;
								        PdfCanvas canvas;
								        int n = pdfDocument2.getNumberOfPages();
								        for (int i = 1; i <= n; i++) {
								            PdfPage page = pdfDocument2.getPage(i);
								            pageSize = page.getPageSize();
								            canvas = new PdfCanvas(page);
								            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
								            canvas.addImage(leftLogo, recta, false);
								            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
								            canvas.addImage(rightLogo, recta2, false);
								            canvas.beginText().setFontAndSize(
								                    PdfFontFactory.createFont(FontConstants.HELVETICA), 11)
								                    .moveText(pageSize.getWidth() / 2 - 124, pageSize.getHeight() - 25)
								                    .showText(objData[12]+" :-  Grantt Chart ")
								                    .endText();
								            
			
								        }
								        document5.close();
								        pdfDocument2.close();
							        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
							        	 PdfDocument pdfDocument3 = new PdfDocument(pdf2);
								        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
								        
								        pdfDocument3.close();
								        pdf2.close();
								        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
								        Files.delete(pathOfFile);	
								        pathOfFile= Paths.get( path+File.separator+TechWorkDataList.get(z)[8].toString());
								        
									    }
					        	 
					        	}
				        	
				        		catch (Exception e) {
				        			logger.error(new Date() +" Inside ProjectBriefingDownload "+UserId, e);
									e.printStackTrace();
								}
				        	
				        	}
				        	
				        	
				        	if(objData!=null && objData[3]!=null) {
				        	if(FilenameUtils.getExtension(objData[3].toString()).equalsIgnoreCase("pdf")) {
					        PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("ApplicationFilesDrive")+objData[2]+"\\"+objData[3]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
					        Document document5 = new Document(pdfDocument2,PageSize.A4);
					        document5.setMargins(50, 50, 50, 50);
					        Rectangle pageSize;
					        PdfCanvas canvas;
					        int n = pdfDocument2.getNumberOfPages();
					        for (int i = 1; i <= n; i++) {
					            PdfPage page = pdfDocument2.getPage(i);
					            pageSize = page.getPageSize();
					            canvas = new PdfCanvas(page);
					            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
					            canvas.addImage(leftLogo, recta, false);
					            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
					            canvas.addImage(rightLogo, recta2, false);
					            canvas.beginText().setFontAndSize(
					                    PdfFontFactory.createFont(FontConstants.HELVETICA), 11)
					                    .moveText(pageSize.getWidth() / 2 - 124, pageSize.getHeight() - 25)
					                    .showText(objData[12]+" :-  System Configuration Annexure: ")
					                    .endText();
			
					        }
					        document5.close();
					        pdfDocument2.close();
				        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
				        	 PdfDocument pdfDocument3 = new PdfDocument(pdf2);
					        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
					        
					        pdfDocument3.close();
					        pdf2.close();
					        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
					        Files.delete(pathOfFile);	
						    }
				        	}
				        	if(objData!=null && objData[4]!=null) {
						    if(FilenameUtils.getExtension(objData[4].toString()).equalsIgnoreCase("pdf")) {
						    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("ApplicationFilesDrive")+objData[2]+"\\"+objData[4]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
						        Document document5 = new Document(pdfDocument2,PageSize.A4);
						        document5.setMargins(50, 50, 50, 50);
						        Rectangle pageSize;
						        PdfCanvas canvas;
						        int n = pdfDocument2.getNumberOfPages();
						        for (int i = 1; i <= n; i++) {
						            PdfPage page = pdfDocument2.getPage(i);
						            pageSize = page.getPageSize();
						            canvas = new PdfCanvas(page);
						            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
						            canvas.addImage(leftLogo, recta, false);
						            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
						            canvas.addImage(rightLogo, recta2, false);
						            canvas.beginText().setFontAndSize(
						                    PdfFontFactory.createFont(FontConstants.HELVETICA),11)
						                    .moveText(pageSize.getWidth() / 2 - 130, pageSize.getHeight() - 25)
						                    .showText(objData[12]+" :-  System Specification Annexure: ")
						                    .endText();
			
						        }
						        document5.close();
						        pdfDocument2.close();
					        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
					        	 PdfDocument pdfDocument3 = new PdfDocument(pdf2);
						        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
						        
						        pdfDocument3.close();
						        pdf2.close();
						        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
						        Files.delete(pathOfFile);	
						    }
				        	}
				        	if(objData!=null && objData[5]!=null) {
						    if(FilenameUtils.getExtension(objData[5].toString()).equalsIgnoreCase("pdf")) {
						    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("ApplicationFilesDrive")+objData[2]+"\\"+objData[5]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
						        Document document5 = new Document(pdfDocument2,PageSize.A4);
						        document5.setMargins(50, 50, 50, 50);
						        Rectangle pageSize;
						        PdfCanvas canvas;
						        int n = pdfDocument2.getNumberOfPages();
						        for (int i = 1; i <= n; i++) {
						            PdfPage page = pdfDocument2.getPage(i);
						            pageSize = page.getPageSize();
						            canvas = new PdfCanvas(page);
						            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
						            canvas.addImage(leftLogo, recta, false);
						            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
						            canvas.addImage(rightLogo, recta2, false);
						            canvas.beginText().setFontAndSize(
						                    PdfFontFactory.createFont(FontConstants.HELVETICA), 11)
						                    .moveText(pageSize.getWidth() / 2 - 140, pageSize.getHeight() - 25)
						                    .showText(objData[12]+" :-  Overall Product tree/WBS Annexure: ")
						                    .endText();
			
						        }
						        document5.close();
						        pdfDocument2.close();
					        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
					        	 PdfDocument pdfDocument3 = new PdfDocument(pdf2);
						        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
						        
						        pdfDocument3.close();
						        pdf2.close();
						        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
						        Files.delete(pathOfFile);	
							    }
				        	}
				        	if(objData!=null&&objData[6]!=null) {
						    if(FilenameUtils.getExtension(objData[6].toString()).equalsIgnoreCase("pdf")) {
						    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("ApplicationFilesDrive")+objData[2]+"\\"+objData[6]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
						        Document document5 = new Document(pdfDocument2,PageSize.A4);
						        document5.setMargins(50, 50, 50, 50);
						        Rectangle pageSize;
						        PdfCanvas canvas;
						        int n = pdfDocument2.getNumberOfPages();
						        for (int i = 1; i <= n; i++) {
						            PdfPage page = pdfDocument2.getPage(i);
						            pageSize = page.getPageSize();
						            canvas = new PdfCanvas(page);
						            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
						            canvas.addImage(leftLogo, recta, false);
						            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
						            canvas.addImage(rightLogo, recta2, false);
						            canvas.beginText().setFontAndSize(
						                    PdfFontFactory.createFont(FontConstants.HELVETICA), 11)
						                    .moveText(pageSize.getWidth() / 2 - 145, pageSize.getHeight() - 25)
						                    .showText(objData[12]+" :-  TRL table with TRL at sanction stage Annexure ")
						                    .endText();
						            
			
						        }
						        document5.close();
						        pdfDocument2.close();
					        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
					        	PdfDocument pdfDocument3 = new PdfDocument(pdf2);
						        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
						        
						        pdfDocument3.close();
						        pdf2.close();
						        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
						        Files.delete(pathOfFile);	
							    }
				        	}
				        	
				        	//Point 13
				        	try {
				        	
				        	 if(FilenameUtils.getExtension(TechWorkDataList.get(z)[8].toString()).equalsIgnoreCase("pdf")) {
				        		 Zipper zip=new Zipper();
				                 zip.unpack(env.getProperty("ApplicationFilesDrive")+TechWorkDataList.get(z)[6].toString()+TechWorkDataList.get(z)[7].toString()+TechWorkDataList.get(z)[11].toString()+"-"+TechWorkDataList.get(z)[10].toString()+".zip",path,TechWorkDataList.get(z)[9].toString());
							    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(path+File.separator+TechWorkDataList.get(z)[8].toString()),new PdfWriter(path+File.separator+filename+"temp.pdf"));
							        Document document5 = new Document(pdfDocument2,PageSize.A4);
							        document5.setMargins(50, 50, 50, 50);
							        Rectangle pageSize;
							        PdfCanvas canvas;
							        int n = pdfDocument2.getNumberOfPages();
							        for (int i = 1; i <= n; i++) {
							            PdfPage page = pdfDocument2.getPage(i);
							            pageSize = page.getPageSize();
							            canvas = new PdfCanvas(page);
							            Rectangle recta=new Rectangle(10,pageSize.getHeight()-50,40,40);
							            canvas.addImage(leftLogo, recta, false);
							            Rectangle recta2=new Rectangle(pageSize.getWidth()-50,pageSize.getHeight()-50,40,40);
							            canvas.addImage(rightLogo, recta2, false);
							            canvas.beginText().setFontAndSize(
							                    PdfFontFactory.createFont(FontConstants.HELVETICA), 11)
							                    .moveText(pageSize.getWidth() / 2 - 80, pageSize.getHeight() - 25)
							                    .showText(objData[12]+" :-  Technical Details ")
							                    .endText();
							            
			
							        }
							        document5.close();
							        pdfDocument2.close();
						        	PdfReader pdf2=new PdfReader(path+"/"+filename+"temp.pdf");
						        	PdfDocument pdfDocument3 = new PdfDocument(pdf2);
							        merger.merge(pdfDocument3, 1, pdfDocument3.getNumberOfPages());
							        
							        pdfDocument3.close();
							        pdf2.close();
							        Path pathOfFile= Paths.get( path+File.separator+filename+"temp.pdf");
							        Files.delete(pathOfFile);	
							        pathOfFile= Paths.get( path+File.separator+TechWorkDataList.get(z)[8].toString());
							        Files.delete(pathOfFile);	
								    }
				        	
				        	}catch (Exception e) {
				        		logger.error(new Date() +" Inside ProjectBriefingDownload "+UserId, e);
								e.printStackTrace();
								
							}
				        	
				        	z++;
						}
			        }catch (Exception e) {
			        	return new File(path+File.separator+filename+"Maintemp.pdf");
					}
		
			        pdfDocument.close();
			        merger.close();
			        document.close();
			        pdf1.close();	       
			        pdfw.close();
	        
			        return new File(path +File.separator+ "mergedb.pdf");
		    	
		    
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectBriefingFreeze.htm "+UserId, e);
    		e.printStackTrace();
			return null;
	
    	}		
		
	
	}
	
	
	
	@PostMapping(value = "ProjectBriefingFreeze.htm")
	public String freezeBriefingPaper(HttpServletRequest req, HttpServletResponse res, HttpSession ses,RedirectAttributes redir)throws Exception
	{

		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		logger.info(new Date() +"Inside ProjectBriefingFreeze.htm "+UserId);		
	    try {
	    	String projectid=req.getParameter("projectid");
	    	String committeeid= req.getParameter("committeeid");
	    	String scheduleid= req.getParameter("committeescheduleid");
	    	long nextScheduleId=0;
	    	if(scheduleid==null) {
	    		nextScheduleId=service.getNextScheduleId(projectid, committeeid);
	    	}else {
	    		nextScheduleId=Long.parseLong(scheduleid);
	    	}
		    if(nextScheduleId>0) 
		    {
		    	String freezeflag = service.getNextScheduleFrozen(nextScheduleId);
		    	if(freezeflag.equalsIgnoreCase("N")) 
		    	{
		    		
		    		String projectLabCode = service.ProjectDetails(projectid).get(0)[5].toString();
		    		File BPFile =  BriefingPaperGeneratePDF(req, res, ses, redir);
		    		
			        
	    			CommitteeProjectBriefingFrozen briefing = CommitteeProjectBriefingFrozen.builder()
		        											.ScheduleId(nextScheduleId)
		        											.FreezeByEmpId(Long.parseLong(EmpId))
		        											.BriefingFile(BPFile)
		        											.LabCode(projectLabCode)
		        											.IsActive(1)
		        											.build();
		       
	    			long count = service.FreezeBriefing(briefing);
	    			
	    			BPFile.delete();	
			        
	    			if(count>0)
	    			{
	    				int update=service.updateBriefingPaperFrozen(nextScheduleId);
	    				redir.addAttribute("result", "Briefing Paper Frozen Successfully");
	    			}
	    			else 
	    			{
	    				redir.addAttribute("resultfail", "Briefing Paper Freezing Failed");	
	    			}
	    			
		    	}
		    	else
		    	{
		    		redir.addAttribute("result", "Briefing Paper Already Frozen!");
		    	}
		    	
		    }
		    
		    redir.addFlashAttribute("projectid",projectid);
			redir.addFlashAttribute("committeeid",committeeid);
			return "redirect:/ProjectBriefingPaper.htm";
	    	
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectBriefingFreeze.htm "+UserId, e);
    		e.printStackTrace();
			return "static/Error";
	
    	}		
		
	
	}
	

	@RequestMapping(value = "MeetingBriefingPaper.htm")
	public void MeetingBriefingPaper(HttpServletRequest req, HttpServletResponse res, HttpSession ses,RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectBriefing.htm "+UserId);		
	    try { 
			String ScheduleId = req.getParameter("scheduleid");
			CommitteeProjectBriefingFrozen briefing = service.getFrozenProjectBriefing(ScheduleId);
				res.setContentType("application/pdf");
			    res.setHeader("Content-disposition","inline;filename="+"Briefing Paper"+".pdf"); 
			    File file=new File(env.getProperty("ApplicationFilesDrive") +briefing.getFrozenBriefingPath()+briefing.getBriefingFileName());
			    FileInputStream fis = new FileInputStream(file);
			    DataOutputStream os = new DataOutputStream(res.getOutputStream());
			    res.setHeader("Content-Length",String.valueOf(file.length()));
			    byte[] buffer = new byte[1024];
			    int len = 0;
			    while ((len = fis.read(buffer)) >= 0) {
			        os.write(buffer, 0, len);
			    } 
			    os.close();
			    fis.close();
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectBriefingFreeze.htm "+UserId, e);
    		e.printStackTrace();
	
    	}		
	}
	
	
	@RequestMapping(value="ProjectBriefing.htm", method = RequestMethod.POST)
	public String ProjectBriefing(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectBriefing.htm "+UserId);		
	    try {    	
	    	
	    	String projectid=req.getParameter("projectid");
	    	String committeeid = req.getParameter("committeeid");
	    	if(committeeid==null  ) {
	    		committeeid="PMRC";
	    	}else if( Long.parseLong(committeeid)==0)
	    	{
	    		committeeid="PMRC";
	    	}

	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	String Logintype= (String)ses.getAttribute("LoginType");
	    	List<Object[]> projectslist =service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	    	if(projectslist.size()==0) 
	        {				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}
	    	if(projectid==null) {
	    		projectid=projectslist.get(0)[0].toString();
	    	}
	    	
	    	Committee committee = service.getCommitteeData(committeeid);
	    	
	    	List<Object[]> projectattributes = new ArrayList<Object[]>();
	    	List<List<Object[]>>  ebandpmrccount = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestonesubsystems = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestones  = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> lastpmrcactions = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> lastpmrcminsactlist = new ArrayList<List<Object[]>>();
	    	List<Object[]> ProjectDetails = new ArrayList<Object[]>();
	    	List<List<Object[]>> ganttchartlist = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> oldpmrcissueslist = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> riskmatirxdata = new ArrayList<List<Object[]>>();
	    	List<Object[]> lastpmrcdecisions = new ArrayList<Object[]>();
	    	List<List<Object[]>> actionplanthreemonths = new ArrayList<List<Object[]>>();
	    	
    		List<List<Object[]>> ReviewMeetingList = new ArrayList<List<Object[]>>();
    		List<Object[]> TechWorkDataList =new ArrayList<Object[]>();
	    	List<Object[]> projectdatadetails  = new ArrayList<Object[]>();
    		
	    	List<List<Object[]>> ProjectRevList =new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestonesubsystemsnew = new ArrayList<List<Object[]>>();
	    	
	    	List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
	    	List<List<Object[]>> procurementOnDemandlist  = new ArrayList<List<Object[]>>();
    		List<List<Object[]>> procurementOnSanctionlist = new ArrayList<List<Object[]>>();
	    	
    		String CommitteeCode = committee.getCommitteeShortName().trim();
	    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	for(String proid : Pmainlist) 
	    	{	    	
	    		Object[] projectattribute = service.ProjectAttributes(proid);
	    		
	    		projectattributes.add(projectattribute);
	    		ebandpmrccount.add(service.EBAndPMRCCount(proid));
	    		milestonesubsystems.add(service.MilestoneSubsystems(proid));
	    		milestones.add(service.Milestones(proid));
	    		lastpmrcactions.add(service.LastPMRCActions(proid,committeeid));
	    		lastpmrcminsactlist.add(service.LastPMRCActions1(proid,committeeid));
	    		ProjectDetails.add(service.ProjectDetails(proid).get(0));
	    		ganttchartlist.add(service.GanttChartList(proid));
	    		oldpmrcissueslist.add(service.OldPMRCIssuesList(proid));
	    		riskmatirxdata.add(service.RiskMatirxData(proid));
	    		lastpmrcdecisions.add(service.LastPMRCDecisions(committeeid,proid));
	    		actionplanthreemonths.add(service.ActionPlanSixMonths(proid,committeeid));
	    		projectdatadetails.add(service.ProjectDataDetails(proid));
	    		ReviewMeetingList.add(service.ReviewMeetingList(projectid, committeeid));
	    		TechWorkDataList.add(service.TechWorkData(proid));
	    		milestonesubsystemsnew.add(service.BreifingMilestoneDetails(proid,CommitteeCode));
	    		
	    		ProjectRevList.add(service.ProjectRevList(proid));
	    	
		/* ----------------------------------------------------------------------------------------------------------	   */  		
	    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectattribute[0]+"&rupess="+10000000;
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
							financialDetails.add(projectDetails);
							req.setAttribute("financialDetails",projectDetails);
						} catch (JsonProcessingException e) {
							e.printStackTrace();
						}
					}
	    	
	 
	    	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(proid);
	    	List<Object[]> procurementOnDemand=null;
	    	List<Object[]> procurementOnSanction=null;
	    	

	    	if(procurementStatusList!=null)
	    	{
		    	Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
		    	Collection<?> keys = map.keySet();
		    	for(Object key:keys)
		    	{
		    		if(key.toString().equals("D")) {
		    			procurementOnDemand=map.get(key);
			    	}else if(key.toString().equals("S")) {
			    		procurementOnSanction=map.get(key);
			    	}
		    	 }
	    	}
	    	
	    	procurementOnDemandlist.add(procurementOnDemand);
	    	procurementOnSanctionlist.add(procurementOnSanction);
	    	
	    	req.setAttribute("procurementOnDemand", procurementOnDemand);
	    	req.setAttribute("procurementOnSanction", procurementOnSanction);
	    }
/* ----------------------------------------------------------------------------------------------------------	   */
	    	req.setAttribute("projectslist", projectslist);
	    	
	    	
	    	
    		req.setAttribute("TechWorkDataList",TechWorkDataList);
	    	
	    	req.setAttribute("projectattributes",projectattributes);
    		req.setAttribute("ebandpmrccount", ebandpmrccount);	    		
    		req.setAttribute("milestonesubsystems", milestonesubsystems);
    		req.setAttribute("milestones", milestones);	  
    		req.setAttribute("lastpmrcactions", lastpmrcactions);
    		req.setAttribute("lastpmrcminsactlist", lastpmrcminsactlist);
    		req.setAttribute("ProjectDetails", ProjectDetails);
    		req.setAttribute("ganttchartlist", ganttchartlist );
    		req.setAttribute("oldpmrcissueslist",oldpmrcissueslist);	    		
    		req.setAttribute("riskmatirxdata",riskmatirxdata);	    		
    		req.setAttribute("lastpmrcdecisions" , lastpmrcdecisions);	    		
    		req.setAttribute("actionplanthreemonths" , actionplanthreemonths);  	
    		req.setAttribute("projectdatadetails",projectdatadetails);
    		req.setAttribute("ProjectRevList", ProjectRevList);
    		req.setAttribute("financialDetails",financialDetails);
    		req.setAttribute("procurementOnDemandlist",procurementOnDemandlist);
    		req.setAttribute("procurementOnSanctionlist",procurementOnSanctionlist);
    		req.setAttribute("ReviewMeetingList",ReviewMeetingList);
    		req.setAttribute("projectidlist",Pmainlist);
    		req.setAttribute("projectid",projectid);
    		req.setAttribute("committeeid",committeeid);
	    	req.setAttribute("ProjectCost",ProjectCost);
	    	req.setAttribute("isprint", "0");
	    	req.setAttribute("labInfo", service.LabDetailes(LabCode));
	    	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(LabCode)); 
    		req.setAttribute("milestonedatalevel6", milestonesubsystemsnew);
    		req.setAttribute("nextMeetVenue", service.BriefingMeetingVenue(projectid, committeeid));
    		
    		
    		String LevelId= "2";
			
			if(service.MileStoneLevelId(projectid,committeeid) != null) {
				LevelId= service.MileStoneLevelId(projectid,committeeid)[0].toString();
			}
			  		
			req.setAttribute("levelid", LevelId);
	    	

	    	return "print/BriefingPaperNew1";
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectBriefing.htm "+UserId, e);
    		e.printStackTrace();
    		return "static/Error";
	
    	}		
	}

	public int setBriefingDataToResponse(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res) throws Exception
	{
		
		try {
		
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");

	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	String Logintype= (String)ses.getAttribute("LoginType");
	    	String projectid=req.getParameter("projectid");
	    	String committeeid = req.getParameter("committeeid");
	    	
	    	if(projectid==null || committeeid==null) 
	    	{
	    		Map md = model.asMap();	    	
	    		projectid = (String) md.get("projectid");
	    		committeeid = (String) md.get("committeeid");
	    	}
	    	
	    	List<Object[]> projectslist =service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	    	List<Object[] > projlist= service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	    	List<Object[]>SpecialCommitteesList =  service.SpecialCommitteesList(LabCode);
	    	
	    	if((projectslist.size()==0 && projectid==null) || projlist.size()==0) 
	        {				
				return 0;
			}
	    	
	    	if(projectslist.size()==0 && projectid!=null) 
	        {				
				projectslist.addAll(service.ProjectDetails(projectid));
			}
	    	
	    	Map md = model.asMap();
	    	if(projectid==null) {
	    	projectid = (String) md.get("projectid");
	    	committeeid = (String) md.get("committeeid");
	    	}
	    	if(projectid==null) {
	    		projectid=projectslist.get(0)[0].toString();
	    	}
	    	
	    	String tempid=committeeid;
	    	if(committeeid==null  ) 
	    	{
	    		
	    		for(Object[] committee : SpecialCommitteesList) {
	    			if(committee[1].toString().equalsIgnoreCase("PMRC")) {
	    				
	    				committeeid=committee[0].toString();
	    	    		tempid=committee[0].toString();
	    	    		
	    	    		break;
	    			}
	    		}
	    		
	    	}
	    	else if(Long.parseLong(committeeid)==0)
	    	{
	    		for(Object[] committee : SpecialCommitteesList) {
	    			if(committee[1].toString().equalsIgnoreCase("PMRC")) 
	    			{
	    				committeeid=committee[0].toString();
	    	    		break;
	    			}
	    		}
	    	}
	    	
	    	
	    	Committee committee = service.getCommitteeData(committeeid);
	    	String projectLabCode = service.ProjectDetails(projectid).get(0)[5].toString();
	    	String CommitteeCode = committee.getCommitteeShortName().trim();
	    	
	    	List<Object[]> projectattributes = new ArrayList<Object[]>();
	    	List<List<Object[]>>  ebandpmrccount = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestonesubsystems = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestonesubsystemsnew = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestones  = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> lastpmrcactions = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> lastpmrcminsactlist = new ArrayList<List<Object[]>>();
	    	List<Object[]> ProjectDetails = new ArrayList<Object[]>();
	    	List<List<Object[]>> ganttchartlist = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> oldpmrcissueslist = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> riskmatirxdata = new ArrayList<List<Object[]>>();
	    	List<Object[]> lastpmrcdecisions = new ArrayList<Object[]>();
	    	List<List<Object[]>> actionplanthreemonths = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> ReviewMeetingList = new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> ReviewMeetingListPMRC = new ArrayList<List<Object[]>>();
	    	List<Object[]> projectdatadetails  = new ArrayList<Object[]>();
    		
	    	List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
	    	List<List<Object[]>> procurementOnDemandlist  = new ArrayList<List<Object[]>>();
    		List<List<Object[]>> procurementOnSanctionlist = new ArrayList<List<Object[]>>();
	    	
    		List<Object[]> pdffiles =new ArrayList<Object[]>();
    		
    		List<Object[]> TechWorkDataList =new ArrayList<Object[]>();
    		
    		List<List<Object[]>> ProjectRevList =new ArrayList<List<Object[]>>();
    		List<List<TechImages>> TechImages =new ArrayList<List<TechImages>>();
    		List<Object[]> LastMeetingDates =new ArrayList<Object[]>();
    		
    		
	    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	for(String proid : Pmainlist) 
	    	{	   
	    		
	    		Object[] projectattribute = service.ProjectAttributes(proid);
	    		projectattributes.add(projectattribute);
	    		TechImages.add(service.getTechList(proid));
	    		ebandpmrccount.add(service.EBAndPMRCCount(proid));
	    		milestonesubsystems.add(service.MilestoneSubsystems(proid));
				milestones.add(service.Milestones(proid)); /* CALL Pfms_Milestone_Level_Prior(:projectid) */
				lastpmrcactions.add(service.LastPMRCActions(proid, committeeid)); /* CALL Last_PMRC_Actions_List(:projectid,:committeeid); */
				lastpmrcminsactlist.add(service.LastPMRCActions1(proid,committeeid)); /* CALL last_pmrc_actions_list_bpaper(:projectid,:committeeid); */
	    		ProjectDetails.add(service.ProjectDetails(proid).get(0));
	    		ganttchartlist.add(service.GanttChartList(proid));
				oldpmrcissueslist.add(service.OldPMRCIssuesList(proid));/* CALL Old_Issues_List(:projectid); */
	    		riskmatirxdata.add(service.RiskMatirxData(proid));
	    		lastpmrcdecisions.add(service.LastPMRCDecisions(committeeid,proid));
				actionplanthreemonths.add(service.ActionPlanSixMonths(proid,committeeid)); /* CALL Pfms_Milestone_PDC_New(:projectid, :interval) */
	    		TechWorkDataList.add(service.TechWorkData(proid)); 
	    		ReviewMeetingList.add(service.ReviewMeetingList(projectid, "EB"));
	    		ReviewMeetingListPMRC.add(service.ReviewMeetingList(projectid, "PMRC"));
	    		ProjectRevList.add(service.ProjectRevList(proid));
				milestonesubsystemsnew.add(service.BreifingMilestoneDetails(proid, CommitteeCode)); /* CALL Pfms_Milestone_Level_Details (:projectid, :CommitteeCode ) */	    	 	
	    		Object[] prodetails=service.ProjectDataDetails(proid);
	    		LastMeetingDates.add(null);
	    		projectdatadetails.add(prodetails);
	    		
	   
	    		
	    		String[] pdfs=new String[4];
				if(prodetails!=null && prodetails.length>0)
				{	
				
					if(prodetails[3]!=null) {
						try {
							//config
							if(Files.exists(Paths.get(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[3]))) {
								pdfs[0] = Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[3])));
							}
						}catch ( FileNotFoundException  e) {
							logger.error(new Date() +" Inside ProjectBriefingPaper "+UserId, e);
							e.printStackTrace();
							pdfs[0]=null;
						}
					}
					if(prodetails[5]!=null) {
						try {
								//producttree
							if(Files.exists(Paths.get(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[5]))) {
								pdfs[1]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[5])));
							}
						}catch (FileNotFoundException e) {
							logger.error(new Date() +" Inside ProjectBriefingPaper "+UserId, e);
							pdfs[1]=null;
						}
					}
					if(prodetails[6]!=null) {
						try {
								//pearlimg
							
							if(Files.exists(Paths.get(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[6]))) {
								pdfs[2]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[6])));
							}
						
						}catch (FileNotFoundException e) {
							logger.error(new Date() +" Inside ProjectBriefingPaper "+UserId, e);
							pdfs[2]=null;
						}
					}
					if(prodetails[4]!=null) {
						try {
							//Sysspecs
							
							if(Files.exists(Paths.get(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[4]))) {
								pdfs[3]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[4])));
						}
						
							}catch (FileNotFoundException e) {
								logger.error(new Date() +" Inside ProjectBriefingPaper "+UserId, e);
								e.printStackTrace();
								pdfs[3]=null;
							}
					}
						
				}
				pdffiles.add(pdfs);
	    		
	    		
		/* -------------------------------------------------------------------------------------------------------------- */  		
	    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectattribute[0]+"&rupess="+10000000;
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
							/*
							 * projectDetails = mapper.readValue(jsonResult,
							 * mapper.getTypeFactory().constructCollectionType(List.class,
							 * ProjectFinancialDetails.class));
							 */
							projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
							financialDetails.add(projectDetails);
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
							/*
							 * projectDetails = mapper.readValue(jsonResult,
							 * mapper.getTypeFactory().constructCollectionType(List.class,
							 * ProjectFinancialDetails.class));
							 */
							totaldemand = mapper2.readValue(jsonResult2, new TypeReference<List<TotalDemand>>(){});
							req.setAttribute("TotalProcurementDetails",totaldemand);
						} catch (JsonProcessingException e) {
							e.printStackTrace();
						}
					}
	 
	    	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(proid);
	    	List<Object[]> procurementOnDemand=null;
	    	List<Object[]> procurementOnSanction=null;
	    	

	    	if(procurementStatusList!=null)
	    	{
		    	Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
		    	Collection<?> keys = map.keySet();
		    	for(Object key:keys)
		    	{
		    		if(key.toString().equals("D")) {
		    			procurementOnDemand=map.get(key);
			    	}else if(key.toString().equals("S")) {
			    		procurementOnSanction=map.get(key);
			    	}
		    	 }
	    	}
//	    	procurementOnDemandlist.add(procurementStatusList);
//	    	procurementOnDemandlist.add(procurementOnDemand);
//	    	procurementOnSanctionlist.add(procurementOnSanction);
	    	
	    	procurementOnDemandlist.add(procurementOnDemand);
	    	procurementOnSanctionlist.add(procurementOnSanction);
	    	
	    	req.setAttribute("procurementOnDemand", procurementOnDemand);
	    	req.setAttribute("procurementOnSanction", procurementOnSanction);
	    }
/* -------------------------------------------------------------------------------------------------------------  */
	    	req.setAttribute("projectslist", projectslist);
	    	req.setAttribute("committeeData", committee);
	    	
	    	req.setAttribute("projectattributes",projectattributes);
    		req.setAttribute("ebandpmrccount", ebandpmrccount);	    		
    		req.setAttribute("milestonesubsystems", milestonesubsystems);
    		req.setAttribute("milestones", milestones);	  
    		req.setAttribute("lastpmrcactions", lastpmrcactions);
    		req.setAttribute("lastpmrcminsactlist", lastpmrcminsactlist);
    		req.setAttribute("ProjectDetails", ProjectDetails);
    		req.setAttribute("ganttchartlist", ganttchartlist );
    		req.setAttribute("oldpmrcissueslist",oldpmrcissueslist);	    		
    		req.setAttribute("riskmatirxdata",riskmatirxdata);	    		
    		req.setAttribute("lastpmrcdecisions" , lastpmrcdecisions);	    		
    		req.setAttribute("actionplanthreemonths" , actionplanthreemonths);  	
    		req.setAttribute("projectdatadetails",projectdatadetails);
    		req.setAttribute("ReviewMeetingList",ReviewMeetingList);
    		req.setAttribute("ProjectRevList", ProjectRevList);
    		req.setAttribute("ReviewMeetingListPMRC",ReviewMeetingListPMRC);
    		req.setAttribute("financialDetails",financialDetails);
    		req.setAttribute("procurementOnDemandlist",procurementOnDemandlist);
    		req.setAttribute("procurementOnSanctionlist",procurementOnSanctionlist);
        	
    		req.setAttribute("projectidlist",Pmainlist);
    		req.setAttribute("projectid",projectid);
    		req.setAttribute("committeeid",tempid);
	    	
    		req.setAttribute("pdffiles",pdffiles);
    		req.setAttribute("TechWorkDataList",TechWorkDataList);
    		req.setAttribute("ProjectCost",ProjectCost);
    		
    		req.setAttribute("milestoneactivitystatus", service.MilestoneActivityStatus());
    		req.setAttribute("milestonedatalevel6", milestonesubsystemsnew);  
    		req.setAttribute("TechImages", TechImages);   
    		req.setAttribute("filePath", env.getProperty("ApplicationFilesDrive"));
    		req.setAttribute("projectLabCode",projectLabCode);
    		req.setAttribute("SpecialCommitteesList",SpecialCommitteesList);
    		req.setAttribute("labInfo", service.LabDetailes(projectLabCode));
	    	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(projectLabCode));
	    	req.setAttribute("Drdologo", LogoUtil.getDRDOLogoAsBase64String());
	    	req.setAttribute("committeeMetingsCount", service.ProjectCommitteeMeetingsCount(projectid, CommitteeCode) );
	    	Object[] nextmeetVenue = (Object[])service.BriefingMeetingVenue(projectid, committeeid);
	    	req.setAttribute("nextMeetVenue", nextmeetVenue);
	    	if(nextmeetVenue!=null && nextmeetVenue[0]!=null) {
	    	req.setAttribute("recdecDetails", service.GetRecDecDetails(nextmeetVenue[0].toString()));
	    	}
	    	
	    	
    		String LevelId= "2";
			
			if(service.MileStoneLevelId(projectid,committeeid) != null) {
				LevelId= service.MileStoneLevelId(projectid,committeeid)[0].toString();
			}
			  		
			req.setAttribute("levelid", LevelId);
    		
    		try {
    	        if(projectid==null) {
    	        	try {
    	        		Object[] pro=projlist.get(0);
    	        		projectid=pro[0].toString();
    	        	}catch (Exception e) {
    					
    				}
    	           
    	        }
    	        List<Object[]> main=milservice.MilestoneActivityList(projectid);
    	            	        
    			req.setAttribute("MilestoneActivityList",main );
    			req.setAttribute("ProjectList",projlist);
    			req.setAttribute("ProjectId", projectid);
    			if(projectid!=null) {
    				req.setAttribute("ProjectDetailsMil", milservice.ProjectDetails(projectid).get(0));
    				int MainCount=1;
    				for(Object[] objmain:main ) {
    				 int countA=1;
						List<Object[]> MilestoneActivityA = milservice.MilestoneActivityLevel(objmain[0].toString(),"1"); /* CALL Pfms_Milestone_Level_List(:id,:levelid) */
    					req.setAttribute(MainCount+"MilestoneActivityA", MilestoneActivityA);
    					for(Object[] obj:MilestoneActivityA) {
    						List<Object[]>  MilestoneActivityB=milservice.MilestoneActivityLevel(obj[0].toString(),"2");
    						req.setAttribute(MainCount+"MilestoneActivityB"+countA, MilestoneActivityB);
    						int countB=1;
    						for(Object[] obj1:MilestoneActivityB) {
    							List<Object[]>  MilestoneActivityC=milservice.MilestoneActivityLevel(obj1[0].toString(),"3");
    							req.setAttribute(MainCount+"MilestoneActivityC"+countA+countB, MilestoneActivityC);
    							int countC=1;
    							for(Object[] obj2:MilestoneActivityC) {
    								List<Object[]>  MilestoneActivityD=milservice.MilestoneActivityLevel(obj2[0].toString(),"4");
    								req.setAttribute(MainCount+"MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
    								int countD=1;
    								for(Object[] obj3:MilestoneActivityD) {
    									List<Object[]>  MilestoneActivityE=milservice.MilestoneActivityLevel(obj3[0].toString(),"5");
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
    			logger.error(new Date() +" Inside ProjectBriefingPaper.htm (Milestone ActivityLogic) "+UserId, e); 
    		}
    		
			}	
			catch (Exception e) {
    			e.printStackTrace(); 
    			logger.error(new Date() +" Inside ProjectBriefingPaper.htm (Milestone ActivityLogic) ", e); 
    		}
    		
    		
    		
			return 1;
		
	}
	
	
	@RequestMapping(value="ProjectBriefingPaper.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ProjectBriefingPaper(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectBriefingPaper.htm "+UserId);		
		try
		{
			int flag = setBriefingDataToResponse(model, req, ses, redir, res);
		
			if(flag==0) 
	        {				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}
			return "print/ProjectBriefingPaperNew";
		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectBriefing.htm "+UserId, e);
    		e.printStackTrace();
    		return "static/Error";
	
    	}		
	}
	
	
	@RequestMapping(value="BriefingPresentation.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String BriefingPresentation(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside BriefingPresentation.htm "+UserId);		
		try
		{
			int flag = setBriefingDataToResponse(model, req, ses, redir, res);
			if(flag==0) 
	        {				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}  
			return "print/BriefingPresentation";
		}
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside BriefingPresentation.htm "+UserId, e);
    		e.printStackTrace();
    		return "static/Error";
	
    	}		
	}

	@RequestMapping(value="AnnualMeetingSchedules.htm", method = RequestMethod.GET)
	public String AnnualMeetingSchedules(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside AnnualMeetingSchedules.htm "+UserId);		
	    try {   
	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	String Logintype= (String)ses.getAttribute("LoginType");
	    	String yeart=req.getParameter("year");
			if(yeart==null) {
			  yeart=fc.getCurrentYear();
			}
			req.setAttribute("year",yeart);
	    	List<Object[]> projectslist =service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	    	req.setAttribute("projectslist",projectslist);
	    	return "print/AnnualMeetingSchedules";
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside AnnualMeetingSchedules.htm "+UserId, e);
    		e.printStackTrace();
    		return "static/Error";
	
    	}		

	}
	
	@RequestMapping(value = "getMeetingSchedules.htm", method = RequestMethod.GET)
	public @ResponseBody String getWorkingHours(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
	{
		
				
		List<Object[]> getWorkingHours =new ArrayList<Object[]>();
		try {
		
			getWorkingHours = service.getMeetingSchedules(req.getParameter("projectId"),req.getParameter("month"),req.getParameter("year"));

			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		Gson json = new Gson();
		return json.toJson(getWorkingHours);
	}
	

	
	
	
	@RequestMapping(value="ProjectDocs.htm" ,method = RequestMethod.GET)
	public String ProjectDocuments(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectDocs.htm "+UserId);	
		try {
			
		} catch (Exception e) {
			logger.error(new Date() +" Inside ProjectDocs.htm "+UserId, e);
    		e.printStackTrace();
		}
		return "print/ProjectDocuments";
	}
	
	@RequestMapping(value="ProjectSanctionPreview.htm" ,method = { RequestMethod.POST , RequestMethod.GET})
	public String ProjectSanctionPreview(HttpServletRequest req , RedirectAttributes redir, HttpServletResponse res , HttpSession ses)throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectSanctionPreview.htm "+UserId);	
		try {
			
			String action = req.getParameter("Action");
	
			String initiationid = req.getParameter("initiationid");
			
			String rdNo = req.getParameter("RddNo");
			String fromdept = req.getParameter("FromDepartment");
			String todept = req.getParameter("ToDepartment"); 
			String authority = req.getParameter("Authority");
			String startdate = req.getParameter("StartDate");
			String estimatefund = req.getParameter("EstimateCost");
			String uac = req.getParameter("USC");
			String videno =req.getParameter("videNo");
			String rddate = req.getParameter("RdDate");
			String fromdate = req.getParameter("fromDate");
			
			String[] copyaddr = req.getParameterValues("CopyAddr");
			

			if("AddEditSanction".equalsIgnoreCase(action)) {
				String initiationsanid = req.getParameter("initiationsanid");
				if(initiationsanid!=null && initiationsanid!="") {
					//edit the project sanction data
					InitiationSanction initiationsac = new InitiationSanction(); 
					initiationsac.setInitiationSanctionId(Long.parseLong(initiationsanid));
					initiationsac.setInitiationId(Long.parseLong(initiationid));
					initiationsac.setAuthorityId(Long.parseLong(authority));
					initiationsac.setFromDeptId(Long.parseLong(fromdept));
					initiationsac.setToDeptId(Long.parseLong(todept));
					initiationsac.setRdNo(rdNo);
					initiationsac.setStartDate(new java.sql.Date(sdf.parse(startdate).getTime()));
					initiationsac.setEstimateFund(Double.parseDouble(estimatefund));
					initiationsac.setUAC(uac);
					initiationsac.setVideNo(videno);
					initiationsac.setRdDate(new java.sql.Date(sdf.parse(rddate).getTime()));
					initiationsac.setFromDate(new java.sql.Date(sdf.parse(fromdate).getTime()));
					initiationsac.setModifiedBy(UserId);
					initiationsac.setModifiedDate(sdf1.format(new Date()));
				Long initiationsanctionid =	service.EditInitiationSanction(initiationsac);
					
				if(initiationsanctionid>0) {
					List<Object[]> copyaddresslist = (List<Object[]>)service.GetCopyAddressList(initiationid);
					for(Object[] obj:copyaddresslist) {
						service.DeleteCopyAddress(obj[4]+"");
					}
				for(int i=0;i<copyaddr.length;i++) {
					InitiationsanctionCopyAddr copyaddress = new InitiationsanctionCopyAddr();
					copyaddress.setInitiationId(Long.parseLong(initiationid));	
					copyaddress.setCopyaddrId(Long.parseLong(copyaddr[i]));
					copyaddress.setCreatedBy(UserId);
					copyaddress.setCreatedDate(sdf1.format(new Date()));
					service.AddCopyAddress(copyaddress);
				}	}
				if(initiationsanctionid>0) {
					redir.addAttribute("result", "Project Sanction Data Edit Successfully ");
					}else {
					    redir.addAttribute("resultfail","Project Sanction Data Edit Unsuccessful");
					}
				redir.addAttribute("projectinitiationid", initiationid);
				return "redirect:/ProjectSanctionPreview.htm";
				
				}else {
					//Add the project sanction data
					InitiationSanction initiationsac = new InitiationSanction(); 
					initiationsac.setInitiationId(Long.parseLong(initiationid));
					initiationsac.setAuthorityId(Long.parseLong(authority));
					initiationsac.setFromDeptId(Long.parseLong(fromdept));
					initiationsac.setToDeptId(Long.parseLong(todept));
					initiationsac.setRdNo(rdNo);
					initiationsac.setStartDate(new java.sql.Date(sdf.parse(startdate).getTime()));
					initiationsac.setEstimateFund(Double.parseDouble(estimatefund));
					initiationsac.setUAC(uac);
					initiationsac.setVideNo(videno);
					initiationsac.setRdDate(new java.sql.Date(sdf.parse(rddate).getTime()));
					initiationsac.setFromDate(new java.sql.Date(sdf.parse(fromdate).getTime()));
					initiationsac.setCreatedBy(UserId);
					initiationsac.setCreatedDate(sdf1.format(new Date()));
				Long initiationsanctionid =	service.AddInitiationSanction(initiationsac);
					
				
				if(initiationsanctionid>0) {
				for(int i=0;i<copyaddr.length;i++) {
					InitiationsanctionCopyAddr copyaddress = new InitiationsanctionCopyAddr();
					copyaddress.setInitiationId(Long.parseLong(initiationid));	
					copyaddress.setCopyaddrId(Long.parseLong(copyaddr[i]));
					copyaddress.setCreatedBy(UserId);
					copyaddress.setCreatedDate(sdf1.format(new Date()));
					service.AddCopyAddress(copyaddress);
				}	}
				if(initiationsanctionid>0) {
					redir.addAttribute("result", "Project Sanction Data Added Successfully ");
					}else {
					    redir.addAttribute("resultfail","Project Sanction Data Add Unsuccessful");
					}
				redir.addAttribute("projectinitiationid", initiationid);
				return "redirect:/ProjectSanctionPreview.htm";
				}
					
			
			}else if("EditSanction".equalsIgnoreCase(action)){
				
				String projectinitiationid = req.getParameter("initiationid");
				List<Object[]> projectinitiationlist = (List<Object[]>)service.GetProjectInitiationSanList();
				req.setAttribute("projectslist", projectinitiationlist);
				List<Object[]> authoritylist = (List<Object[]>)service.GetAuthorityList();
				req.setAttribute("authoritylist", authoritylist);
				List<Object[]> initiationcopy = (List<Object[]>)service.GetinitiationCopyAddr();
				req.setAttribute("initiationcopy", initiationcopy);
				List<Object[]> initiationdept = (List<Object[]>)service.GetinitiationDeptList();
				req.setAttribute("initiationdept", initiationdept);	
				Object[] projectdata = (Object[])service.GetProjectInitiationdata(projectinitiationid);
				List<Object[]> itemlist = (List<Object[]>) service.GetItemList(projectinitiationid);
				req.setAttribute("itemlist", itemlist );
				req.setAttribute("projectdata", projectdata);
				req.setAttribute("projectid", projectinitiationid);
				Object[] initiationSanctionlist = (Object[])service.GetInitiationSanctionData(projectinitiationid);
				req.setAttribute("initiationSanctionlist", initiationSanctionlist);
				List<Object[]> copyaddresslist = (List<Object[]>)service.GetCopyAddressList(projectinitiationid);
				req.setAttribute("copyaddresslist", copyaddresslist);
			
				req.setAttribute("editdata", "edit");
				
			return "print/ProgramSanction";
			}else{

			String projectid = req.getParameter("projectinitiationid");
			List<Object[]> projectinitiationlist = (List<Object[]>)service.GetProjectInitiationSanList();
			req.setAttribute("projectslist", projectinitiationlist);
			List<Object[]> authoritylist = (List<Object[]>)service.GetAuthorityList();
			req.setAttribute("authoritylist", authoritylist);
			List<Object[]> initiationcopy = (List<Object[]>)service.GetinitiationCopyAddr();
			req.setAttribute("initiationcopy", initiationcopy);
			List<Object[]> initiationdept = (List<Object[]>)service.GetinitiationDeptList();
			req.setAttribute("initiationdept", initiationdept);
			
			if(projectid!=null){
				Object[]projectdata = (Object[])service.GetProjectInitiationdata(projectid);
				List<Object[]> itemlist = (List<Object[]>) service.GetItemList(projectid);
				req.setAttribute("itemlist", itemlist );
				req.setAttribute("projectdata", projectdata);
				req.setAttribute("projectid", projectid);
				Object[] initiationSanctionlist = (Object[])service.GetInitiationSanctionData(projectid);
				req.setAttribute("initiationSanctionlist", initiationSanctionlist);
				List<Object[]> copyaddresslist = (List<Object[]>)service.GetCopyAddressList(projectid);
				req.setAttribute("copyaddresslist", copyaddresslist);
			}else {
				Object[] projectdata = (Object[])service.GetProjectInitiationdata(projectinitiationlist.get(0)[0].toString());
				List<Object[]> itemlist = (List<Object[]>) service.GetItemList(projectinitiationlist.get(0)[0].toString());
				req.setAttribute("itemlist", itemlist );
				req.setAttribute("projectdata", projectdata);
				req.setAttribute("projectid", projectinitiationlist.get(0)[0].toString());
				Object[] initiationSanctionlist = (Object[])service.GetInitiationSanctionData(projectinitiationlist.get(0)[0].toString());
				req.setAttribute("initiationSanctionlist", initiationSanctionlist);
				List<Object[]> copyaddresslist = (List<Object[]>)service.GetCopyAddressList(projectinitiationlist.get(0)[0].toString());
				req.setAttribute("copyaddresslist", copyaddresslist);
			}
		}
			
		} catch (Exception e) {
			logger.error(new Date() +" Inside ProjectSanctionPreview.htm "+UserId, e);
    		e.printStackTrace();
		}
		return "print/ProgramSanction";
	}
	
	@RequestMapping(value="PdcExtention.htm" ,method = { RequestMethod.GET , RequestMethod.POST})
	public String PdcExtentionPreview(HttpServletRequest req , HttpServletResponse res , HttpSession ses)throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside PdcExtention.htm "+UserId);	
		try {
			List<Object[]> projectinitiationlist = (List<Object[]>)service.GetProjectInitiationSanList();
			req.setAttribute("projectslist", projectinitiationlist);
			
		} catch (Exception e) {
			logger.error(new Date() +" Inside PdcExtention.htm "+UserId, e);
    		e.printStackTrace();
		}
		return "print/PdcExtention";
	}
	
	@RequestMapping(value="ReallocationReport.htm" ,method = { RequestMethod.GET , RequestMethod.POST})
	public String ReallocationPreview(HttpServletRequest req , HttpServletResponse res , HttpSession ses)throws Exception
	{
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +"Inside ReallocationReport.htm "+UserId);	
		try {
			List<Object[]> projectinitiationlist = (List<Object[]>)service.GetProjectInitiationSanList();
			req.setAttribute("projectslist", projectinitiationlist);
			
		} catch (Exception e) {
			logger.error(new Date() +" Inside ReallocationReport.htm "+UserId, e);
    		e.printStackTrace();
		}
		return "print/ReallocationFunds";
	}
	
	public void freezeBriefingPaperAfterKickoff(HttpServletRequest req, HttpServletResponse res, HttpSession ses,RedirectAttributes redir)throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside freezeBriefingPaperAfterKickoff "+UserId);		
	    try {
	    	String projectid=req.getParameter("projectid");
	    	String committeeid= req.getParameter("committeeid");
	    	String tempid=committeeid;
	        long nextScheduleId=Long.parseLong(req.getParameter("committeescheduleid"));
	    	if(nextScheduleId>0) {
	    		if(service.getNextScheduleFrozen(nextScheduleId).equalsIgnoreCase("N")) {
	    		
	    	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	    	String Logintype= (String)ses.getAttribute("LoginType");
	    	    	Committee committee = service.getCommitteeData(committeeid);
	    	    	
	    	    	String projectLabCode = service.ProjectDetails(projectid).get(0)[5].toString();
	    	    	String CommitteeCode = committee.getCommitteeShortName().trim();
	    	    	
	    	    	List<Object[]> projectattributes = new ArrayList<Object[]>();
	    	    	List<List<Object[]>>  ebandpmrccount = new ArrayList<List<Object[]>>();
	    	    	List<List<Object[]>> milestonesubsystems = new ArrayList<List<Object[]>>();
	    	    	List<List<Object[]>> milestones  = new ArrayList<List<Object[]>>();
	    	    	List<List<Object[]>> lastpmrcactions = new ArrayList<List<Object[]>>();
	    	    	List<List<Object[]>> lastpmrcminsactlist = new ArrayList<List<Object[]>>();
	    	    	List<Object[]> ProjectDetails = new ArrayList<Object[]>();
	    	    	List<List<Object[]>> ganttchartlist = new ArrayList<List<Object[]>>();
	    	    	List<List<Object[]>> oldpmrcissueslist = new ArrayList<List<Object[]>>();
	    	    	List<List<Object[]>> riskmatirxdata = new ArrayList<List<Object[]>>();
	    	    	List<Object[]> lastpmrcdecisions = new ArrayList<Object[]>();
	    	    	List<List<Object[]>> actionplanthreemonths = new ArrayList<List<Object[]>>();
	    	    	List<List<Object[]>> ReviewMeetingListEB = new ArrayList<List<Object[]>>();
	    	    	List<List<Object[]>> ReviewMeetingListPMRC = new ArrayList<List<Object[]>>();
	    	    	List<Object[]> projectdatadetails  = new ArrayList<Object[]>();
	    	    	List<Object[]> TechWorkDataList =new ArrayList<Object[]>();
	        		List<List<Object[]>> milestonesubsystemsnew = new ArrayList<List<Object[]>>();
	    	    	
	    	    	List<List<Object[]>> ProjectRevList =new ArrayList<List<Object[]>>();
	    	    	
	    	    	List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
	    	    	List<List<Object[]>> procurementOnDemandlist  = new ArrayList<List<Object[]>>();
	        		List<List<Object[]>> procurementOnSanctionlist = new ArrayList<List<Object[]>>();
	        		List<List<TechImages>> TechImages =new ArrayList<List<TechImages>>();
	    	    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	    	for(String proid : Pmainlist) 
	    	    	{	    	
	    	    		Object[] projectattribute = service.ProjectAttributes(proid);
	    	    		
	    	    		TechImages.add(service.getTechList(proid));
	    	    		projectattributes.add(projectattribute);
	    	    		ebandpmrccount.add(service.EBAndPMRCCount(proid));
	    	    		milestonesubsystems.add(service.MilestoneSubsystems(proid));
	    	    		milestones.add(service.Milestones(proid));
	    	    		lastpmrcactions.add(service.LastPMRCActions(proid,committeeid));
	    	    		lastpmrcminsactlist.add(service.LastPMRCActions1(proid,committeeid));
	    	    		ProjectDetails.add(service.ProjectDetails(proid).get(0));
	    	    		ganttchartlist.add(service.GanttChartList(proid));
	    	    		oldpmrcissueslist.add(service.OldPMRCIssuesList(proid));
	    	    		riskmatirxdata.add(service.RiskMatirxData(proid));
	    	    		lastpmrcdecisions.add(service.LastPMRCDecisions(committeeid,proid));
	    	    		actionplanthreemonths.add(service.ActionPlanSixMonths(proid,CommitteeCode));
	    	    		projectdatadetails.add(service.ProjectDataDetails(proid));
	    	    		ReviewMeetingListEB.add(service.ReviewMeetingList(projectid, "EB"));
	    	    		ReviewMeetingListPMRC.add(service.ReviewMeetingList(projectid, "PMRC"));
	    	    		TechWorkDataList.add(service.TechWorkData(proid));
	    		    	milestonesubsystemsnew.add(service.BreifingMilestoneDetails(proid,CommitteeCode));
	    	    		ProjectRevList.add(service.ProjectRevList(proid));
	    	    	
	    		/* ----------------------------------------------------------------------------------------------------------	   */  		
	    	    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectattribute[0]+"&rupess="+10000000;
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
	    							/*
	    							 * projectDetails = mapper.readValue(jsonResult,
	    							 * mapper.getTypeFactory().constructCollectionType(List.class,
	    							 * ProjectFinancialDetails.class));
	    							 */
	    							projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
	    							financialDetails.add(projectDetails);
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
	    							/*
	    							 * projectDetails = mapper.readValue(jsonResult,
	    							 * mapper.getTypeFactory().constructCollectionType(List.class,
	    							 * ProjectFinancialDetails.class));
	    							 */
	    							totaldemand = mapper2.readValue(jsonResult2, new TypeReference<List<TotalDemand>>(){});
	    							req.setAttribute("TotalProcurementDetails",totaldemand);
	    						} catch (JsonProcessingException e) {
	    							e.printStackTrace();
	    						}
	    					}
	    	 
	    	    	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(proid);
	    	    	List<Object[]> procurementOnDemand=null;
	    	    	List<Object[]> procurementOnSanction=null;
	    	    	

	    	    	if(procurementStatusList!=null)
	    	    	{
	    		    	Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
	    		    	Collection<?> keys = map.keySet();
	    		    	for(Object key:keys)
	    		    	{
	    		    		if(key.toString().equals("D")) {
	    		    			procurementOnDemand=map.get(key);
	    			    	}else if(key.toString().equals("S")) {
	    			    		procurementOnSanction=map.get(key);
	    			    	}
	    		    	 }
	    	    	}
//	    	    	procurementOnDemandlist.add(procurementStatusList);
//	    	    	procurementOnDemandlist.add(procurementOnDemand);
//	    	    	procurementOnSanctionlist.add(procurementOnSanction);
	    	    	
	    	    	procurementOnDemandlist.add(procurementOnDemand);
	    	    	procurementOnSanctionlist.add(procurementOnSanction);
	    	    	
	    	    	req.setAttribute("procurementOnDemand", procurementOnDemand);
	    	    	req.setAttribute("procurementOnSanction", procurementOnSanction);
	    	    }
	    /* ----------------------------------------------------------------------------------------------------------  */
	    	    	
	    	    	req.setAttribute("TechImages",TechImages);
	    	    	req.setAttribute("committeeData", committee);
	    	    	req.setAttribute("projectattributes",projectattributes);
	        		req.setAttribute("ebandpmrccount", ebandpmrccount);	    		
	        		req.setAttribute("milestonesubsystems", milestonesubsystems);
	        		req.setAttribute("milestones", milestones);	  
	        		req.setAttribute("lastpmrcactions", lastpmrcactions);
	        		req.setAttribute("lastpmrcminsactlist", lastpmrcminsactlist);
	        		req.setAttribute("ProjectDetails", ProjectDetails);
	        		req.setAttribute("ganttchartlist", ganttchartlist );
	        		req.setAttribute("oldpmrcissueslist",oldpmrcissueslist);	    		
	        		req.setAttribute("riskmatirxdata",riskmatirxdata);	    		
	        		req.setAttribute("lastpmrcdecisions" , lastpmrcdecisions);	    		
	        		req.setAttribute("actionplanthreemonths" , actionplanthreemonths);  	
	        		req.setAttribute("projectdatadetails",projectdatadetails);
	        		
	        		
	        		req.setAttribute("ReviewMeetingList",ReviewMeetingListEB);
	        		req.setAttribute("ReviewMeetingListPMRC",ReviewMeetingListPMRC);
	        		
	        		req.setAttribute("financialDetails",financialDetails);
	        		req.setAttribute("procurementOnDemandlist",procurementOnDemandlist);
	        		req.setAttribute("procurementOnSanctionlist",procurementOnSanctionlist);
	        		
	        		req.setAttribute("TechWorkDataList",TechWorkDataList);
	        		req.setAttribute("ProjectRevList", ProjectRevList);
	            	
	        		req.setAttribute("projectidlist",Pmainlist);
	        		req.setAttribute("projectid",projectid);
	        		req.setAttribute("committeeid",tempid);
	        		req.setAttribute("ProjectCost",ProjectCost);
	    	    	req.setAttribute("isprint", "0");
	    	    	req.setAttribute("AppFilesPath",ApplicationFilesDrive);
	    	    	req.setAttribute("projectLabCode",projectLabCode);
	    	    	req.setAttribute("labInfo", service.LabDetailes(projectLabCode));
	    	    	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(projectLabCode));    
	                req.setAttribute("filePath", env.getProperty("ApplicationFilesDrive"));
	                req.setAttribute("milestonedatalevel6", milestonesubsystemsnew);
	        		req.setAttribute("ApplicationFilesDrive",env.getProperty("ApplicationFilesDrive"));
	        		req.setAttribute("committeeMetingsCount", service.ProjectCommitteeMeetingsCount(projectid, CommitteeCode) );
	        		req.setAttribute("nextMeetVenue", service.BriefingMeetingVenue(projectid, committeeid));
	        		
	        		String LevelId= "2";
	    			
	    			if(service.MileStoneLevelId(projectid,committeeid) != null) {
	    				LevelId= service.MileStoneLevelId(projectid,committeeid)[0].toString();
	    			}
	    			  		
	    			req.setAttribute("levelid", LevelId);
	    		}else {
	    			redir.addAttribute("resultfail", "Briefing Paper Already Frozen for  This Meeting.");
	    		}
	    	}else {
	    		redir.addAttribute("resultfail", "No  Meeting scheduled.");
	    	}
	        
	    }
	    catch(Exception e) {	
	    	redir.addAttribute("resultfail", "Briefing Paper Not Frozen for  This Meeting.");
    		logger.error(new Date() +" Inside freezeBriefingPaperAfterKickoff "+UserId, e);
    		e.printStackTrace();
			/* return "static/Error"; */
	
    	}		
		
	}
	
	@RequestMapping(value = "MilestoneActivityChange.htm", method = RequestMethod.GET)
	public @ResponseBody String MilestoneActivityChange(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
	{
		String UserId=(String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside freezeBriefingPaperAfterKickoff "+UserId);
		String projectid=req.getParameter("projectid");
    	String milestoneactivitystatusid = req.getParameter("milactivitystatusid");
    			
		List<List<Object[]>> milestoneschange =new ArrayList<List<Object[]>>();
		
		try {
		
			List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	for(String proid : Pmainlist) 
	    	{	    	
	    		milestoneschange.add(service.MilestonesChange(proid,milestoneactivitystatusid));
	    	}
			
		} catch (Exception e) {
			logger.error(new Date() +" Inside freezeBriefingPaperAfterKickoff "+UserId,e);
			e.printStackTrace();
		}
		Gson json = new Gson();
		return json.toJson(milestoneschange);
	}
	
	@RequestMapping(value="MilestoneLevelUpdate.htm", method = RequestMethod.POST)
	public String MilestoneLevelUpdate(HttpServletRequest req, HttpServletResponse res, RedirectAttributes redir,HttpSession ses) throws Exception{
		
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MilestoneLevelUpdate.htm "+UserId);	
		
		int count=0;
		String projectid=req.getParameter("projectid");
    	String committeeid= req.getParameter("committeeid");
		
		try {

			Object[] LevelDetails= service.MileStoneLevelId(projectid,committeeid); 
			
			MilestoneActivityLevelConfigurationDto dto = new MilestoneActivityLevelConfigurationDto();
			dto.setProjectId(projectid);
			dto.setCommitteeId(committeeid);
			if(LevelDetails!=null) {
			dto.setLevelConfigurationId(LevelDetails[1].toString());
			}
			dto.setLevelid(req.getParameter("milestonelevelid"));
			dto.setCreatedBy(UserId);			
			 count = service.MileStoneLevelUpdate(dto);
			
		}
		catch(Exception e) {	    		
    		logger.error(new Date() +" Inside MilestoneLevelUpdate.htm "+UserId, e);
    		e.printStackTrace();
	
    	}		
		
		if(count>0) {  
            redir.addAttribute("result", "Milestone Level Updated Successfully");
  		}else {
  			redir.addAttribute("resultfail", "Milestone Level Update Unsuccessful");
  		}

		redir.addFlashAttribute("projectid", projectid);
		redir.addFlashAttribute("committeeid", committeeid);
		//redir.addFlashAttribute("tabid", "6");
		
		return "redirect:/ProjectBriefingPaper.htm";
	}
	
	
	
	  @PostMapping("/GanttChartUpload.htm") 
	    public String GanttChartUpload(@RequestParam("FileAttach") MultipartFile file,HttpServletRequest req,RedirectAttributes redir,HttpSession ses) {
		  String UserId = (String) ses.getAttribute("Username");
		  String Labcode = (String) ses.getAttribute("labcode");
			logger.info(new Date() +"Inside GanttChartUpload.htm "+UserId);	  
		  try {
            int result=service.saveGranttChart(file,req.getParameter("ChartName"),env.getProperty("ApplicationFilesDrive"),Labcode);
            if(result>0) {  
              redir.addAttribute("result", "Grantt Chart Saved");
    		}else {
    			redir.addAttribute("resultfail", "Grantt Chart Not Saved");
    		}

	        } catch (Exception e) {
	        	logger.error(new Date() +" Inside GanttChartUpload.htm "+UserId, e);
	        }
	        redir.addFlashAttribute("projectid", req.getParameter("ProjectId"));
			redir.addFlashAttribute("committeeid", req.getParameter("committeeid"));
	        return "redirect:/ProjectBriefingPaper.htm";
	    }
	  
	  
		
	    @PostMapping("/ProjectTechImages.htm") 
	    public String ProjectTechImages(@RequestParam("FileAttach") MultipartFile file,HttpSession ses,HttpServletRequest req,RedirectAttributes redir) {
	    	 String UserId = (String) ses.getAttribute("Username");
	    	 String LabCode= (String) ses.getAttribute("labcode");
				logger.info(new Date() +"Inside GanttChartUpload.htm "+UserId);
	    	try {
            int result=service.saveTechImages(file,req.getParameter("ProjectId"),env.getProperty("ApplicationFilesDrive"),req.getUserPrincipal().getName(),LabCode);
            if(result>0) {  
              redir.addAttribute("result", "Tech Image Saved");
    		}else {
    			redir.addAttribute("resultfail", "Tech Image Not Saved");
    		}

	        } catch (Exception e) {
	        	logger.error(new Date() +" Inside ProjectTechImages.htm "+UserId, e);
	        }
	        redir.addFlashAttribute("projectid", req.getParameter("ProjectId"));
			redir.addFlashAttribute("committeeid", req.getParameter("committeeid"));
	        return "redirect:/ProjectBriefingPaper.htm";
	    }
	    
	    
	    @RequestMapping(value ="FilterMilestone.htm" ,method = RequestMethod.POST)
	    public String FilterMilestone(HttpServletRequest req, HttpServletResponse res, RedirectAttributes redir,HttpSession ses)throws Exception
	    {
	    	
	    	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside FilterMilestone.htm "+UserId);
		    try {
				
		    	String projectid = req.getParameter("projectidvalue");
		    	String committeeid = req.getParameter("committeidvalue");
		    	Committee committee = service.getCommitteeData(committeeid);
		    	String MilestoneActivity = req.getParameter("milestoneactivity");
		    	String CommitteeCode = committee.getCommitteeShortName().trim();
		    	String LevelId= "2";
		    	Object[] getlevelid = service.MileStoneLevelId(projectid,committeeid);
				if(getlevelid != null && getlevelid[0]!=null) {
					LevelId= getlevelid[0].toString();
				}
				List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
				List<List<Object[]>> MilestoneFilterlist = new ArrayList<List<Object[]>>();
		    	for(String  proid : Pmainlist) 
		    	{
		    		 MilestoneFilterlist.add(service.BreifingMilestoneDetails(proid,CommitteeCode));
		    	}
		    	
		    	List<Object[]> main = new ArrayList<>();
     	        if(MilestoneActivity==null || "A".equalsIgnoreCase(MilestoneActivity)) {
     	        	 main=milservice.MilestoneActivityList(projectid);
     	        }else {
     	        	main=milservice.MilestoneActivityList(projectid).stream().filter(statusactivityid-> statusactivityid[14].toString().equalsIgnoreCase(MilestoneActivity)  ).collect(Collectors.toList());
     	        }
					
		    	if(projectid!=null) {
    				req.setAttribute("ProjectDetailsMil", milservice.ProjectDetails(projectid).get(0));
    				int MainCount=1;
    				for(Object[] objmain:main ) {
    				 int countA=1;
    				    List<Object[]>  MilestoneActivityA = new ArrayList<>();
    					
    						 MilestoneActivityA=milservice.MilestoneActivityLevel(objmain[0].toString(),"1");
    					
    					req.setAttribute(MainCount+"MilestoneActivityA", MilestoneActivityA);
    					
    					for(Object[] obj:MilestoneActivityA) {
    						List<Object[]>  MilestoneActivityB = new ArrayList<>();
        					
        						MilestoneActivityB=milservice.MilestoneActivityLevel(obj[0].toString(),"2");
        					
    						req.setAttribute(MainCount+"MilestoneActivityB"+countA, MilestoneActivityB);
    						int countB=1;
    						for(Object[] obj1:MilestoneActivityB) {
    							List<Object[]>  MilestoneActivityC = new ArrayList<>();
            					
            						MilestoneActivityC=milservice.MilestoneActivityLevel(obj1[0].toString(),"3");
            					
    							req.setAttribute(MainCount+"MilestoneActivityC"+countA+countB, MilestoneActivityC);
    							int countC=1;
    							for(Object[] obj2:MilestoneActivityC) {
    								
    								List<Object[]>  MilestoneActivityD = new ArrayList<>();
                					
                						MilestoneActivityD=milservice.MilestoneActivityLevel(obj2[0].toString(),"4");
                					
    								req.setAttribute(MainCount+"MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
    								int countD=1;
    								for(Object[] obj3:MilestoneActivityD) {
    									List<Object[]>  MilestoneActivityE = new ArrayList<>();
                    					
                    						MilestoneActivityE=milservice.MilestoneActivityLevel(obj3[0].toString(),"5");
                    					
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
		    	req.setAttribute("MilestoneActivityList",main );
    			req.setAttribute("ProjectId",projectid );
		    	req.setAttribute("milestoneactivitystatus", service.MilestoneActivityStatus());
		    	req.setAttribute("milestonefilterlist", MilestoneFilterlist);
		    	req.setAttribute("levelid", LevelId);
		    	req.setAttribute("CommitteeId", committeeid);
		    	req.setAttribute("MilestoneActivity", MilestoneActivity);
			} catch (Exception e) {
				logger.error(new Date() +" Inside FilterMilestone.htm "+UserId, e);
	    		e.printStackTrace();
			}	
		    return "milestone/MilestoneFilterList";
	    }
	    
	    
	    
//	    @RequestMapping(value="ProjectBriefingPaper.htm", method = {RequestMethod.GET,RequestMethod.POST})
//		public String ProjectBriefingPaper(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)	throws Exception 
//		{
//			String UserId = (String) ses.getAttribute("Username");
//			String LabCode = (String)ses.getAttribute("labcode");
//			logger.info(new Date() +"Inside ProjectBriefingPaper.htm "+UserId);		
//		    try {
//		    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//		    	String Logintype= (String)ses.getAttribute("LoginType");
//		    	String projectid=req.getParameter("projectid");
//		    	String committeeid = req.getParameter("committeeid");
//		    	
//		    	
//		    	
//		    	if(projectid==null || committeeid==null) 
//		    	{
//		    		Map md = model.asMap();	    	
//		    		projectid = (String) md.get("projectid");
//		    		committeeid = (String) md.get("committeeid");
//		    	}
//		    	
//		    	List<Object[]> projectslist =service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
//		    	
//		    	
//		    	List<Object[]>SpecialCommitteesList =  service.SpecialCommitteesList(LabCode);
//		    	
//		    	if(projectslist.size()==0 && projectid==null) 
//		        {				
//					redir.addAttribute("resultfail", "No Project is Assigned to you.");
//					return "redirect:/MainDashBoard.htm";
//				}
//		    	
//		    	if(projectslist.size()==0 && projectid!=null) 
//		        {				
//					projectslist.addAll(service.ProjectDetails(projectid));
//				}
//		    	
//		    	Map md = model.asMap();
//		    	if(projectid==null) {
//		    	projectid = (String) md.get("projectid");
//		    	committeeid = (String) md.get("committeeid");
//		    	}
//		    	if(projectid==null) {
//		    		projectid=projectslist.get(0)[0].toString();
//		    	}
//		    	
//		    	String tempid=committeeid;
//		    	if(committeeid==null  ) 
//		    	{
//		    		
//		    		for(Object[] committee : SpecialCommitteesList) {
//		    			if(committee[1].toString().equalsIgnoreCase("PMRC")) {
//		    				
//		    				committeeid=committee[0].toString();
//		    	    		tempid=committee[0].toString();
//		    	    		
//		    	    		break;
//		    			}
//		    		}
//		    		
//		    	}
//		    	else if(Long.parseLong(committeeid)==0)
//		    	{
//		    		for(Object[] committee : SpecialCommitteesList) {
//		    			if(committee[1].toString().equalsIgnoreCase("PMRC")) 
//		    			{
//		    				committeeid=committee[0].toString();
//		    	    		break;
//		    			}
//		    		}
//		    	}
//		    	
//		    	if(committeeid==null) 
//		    	{
//		    		committeeid = "0";
//		    		tempid = "0";
//		    	}
//		    	
//		    	Committee committee = service.getCommitteeData(committeeid);
//		    	String projectLabCode = service.ProjectDetails(projectid).get(0)[5].toString();
//		    	
//		    	List<Object[]> projectattributes = new ArrayList<Object[]>();
//		    	List<List<Object[]>>  ebandpmrccount = new ArrayList<List<Object[]>>();
//		    	List<List<Object[]>> milestonesubsystems = new ArrayList<List<Object[]>>();
//		    	List<List<Object[]>> milestonesubsystemsnew = new ArrayList<List<Object[]>>();
//		    	List<List<Object[]>> milestones  = new ArrayList<List<Object[]>>();
//		    	List<List<Object[]>> lastpmrcactions = new ArrayList<List<Object[]>>();
//		    	List<List<Object[]>> lastpmrcminsactlist = new ArrayList<List<Object[]>>();
//		    	List<Object[]> ProjectDetails = new ArrayList<Object[]>();
//		    	List<List<Object[]>> ganttchartlist = new ArrayList<List<Object[]>>();
//		    	List<List<Object[]>> oldpmrcissueslist = new ArrayList<List<Object[]>>();
//		    	List<List<Object[]>> riskmatirxdata = new ArrayList<List<Object[]>>();
//		    	List<Object[]> lastpmrcdecisions = new ArrayList<Object[]>();
//		    	List<List<Object[]>> actionplanthreemonths = new ArrayList<List<Object[]>>();
//		    	List<List<Object[]>> ReviewMeetingList = new ArrayList<List<Object[]>>();
//		    	List<List<Object[]>> ReviewMeetingListPMRC = new ArrayList<List<Object[]>>();
//		    	List<Object[]> projectdatadetails  = new ArrayList<Object[]>();
//	    		
//		    	List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
//		    	List<List<Object[]>> procurementOnDemandlist  = new ArrayList<List<Object[]>>();
//	    		List<List<Object[]>> procurementOnSanctionlist = new ArrayList<List<Object[]>>();
//		    	
//	    		List<Object[]> pdffiles =new ArrayList<Object[]>();
//	    		
//	    		List<Object[]> TechWorkDataList =new ArrayList<Object[]>();
//	    		
//	    		List<List<Object[]>> ProjectRevList =new ArrayList<List<Object[]>>();
//	    		List<List<TechImages>> TechImages =new ArrayList<List<TechImages>>();
//		    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
//		    	for(String proid : Pmainlist) 
//		    	{	   
//		    		
//		    		Object[] projectattribute = service.ProjectAttributes(proid);
//		    		
//		    		projectattributes.add(projectattribute);
//		    		
//		    		TechImages.add(service.getTechList(proid));
//		    		
//		    		ebandpmrccount.add(service.EBAndPMRCCount(proid));
//		    		
//		    		milestonesubsystems.add(service.MilestoneSubsystems(proid));
//		    		milestones.add(service.Milestones(proid));
//		    		lastpmrcactions.add(service.LastPMRCActions(proid,committeeid));
//		    		lastpmrcminsactlist.add(service.LastPMRCActions1(proid,committeeid));
//		    		ProjectDetails.add(service.ProjectDetails(proid).get(0));
//		    		ganttchartlist.add(service.GanttChartList(proid));
//		    		oldpmrcissueslist.add(service.OldPMRCIssuesList(proid));
//		    		riskmatirxdata.add(service.RiskMatirxData(proid));
//		    		lastpmrcdecisions.add(service.LastPMRCDecisions(committeeid,proid));
//		    		actionplanthreemonths.add(service.ActionPlanSixMonths(proid,committeeid));
//		    		
//		    		TechWorkDataList.add(service.TechWorkData(proid)); 
//		    		
//		    		ReviewMeetingList.add(service.ReviewMeetingList(projectid, "EB"));
//		    		ReviewMeetingListPMRC.add(service.ReviewMeetingList(projectid, "PMRC"));
//		    		
//		    		ProjectRevList.add(service.ProjectRevList(proid));
//		    		milestonesubsystemsnew.add(service.BreifingMilestoneDetails(proid,CommitteeCode));	    		
//		    		Object[] prodetails=service.ProjectDataDetails(proid);
//		    		projectdatadetails.add(prodetails);
//		    		
//		   
//		    		
//		    		String[] pdfs=new String[4];
//					if(prodetails!=null && prodetails.length>0)
//					{	
//					
//						if(prodetails[3]!=null) {
//							try {
//								//config
//								if(Files.exists(Paths.get(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[3]))) {
//									pdfs[0] = Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[3])));
//								}
//							}catch ( FileNotFoundException  e) {
//								logger.error(new Date() +" Inside ProjectBriefingPaper "+UserId, e);
//								e.printStackTrace();
//								pdfs[0]=null;
//							}
//						}
//						if(prodetails[5]!=null) {
//							try {
//									//producttree
//								if(Files.exists(Paths.get(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[5]))) {
//									pdfs[1]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[5])));
//								}
//							}catch (FileNotFoundException e) {
//								logger.error(new Date() +" Inside ProjectBriefingPaper "+UserId, e);
//								pdfs[1]=null;
//							}
//						}
//						if(prodetails[6]!=null) {
//							try {
//									//pearlimg
//								
//								if(Files.exists(Paths.get(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[6]))) {
//									pdfs[2]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[6])));
//								}
//							
//							}catch (FileNotFoundException e) {
//								logger.error(new Date() +" Inside ProjectBriefingPaper "+UserId, e);
//								pdfs[2]=null;
//							}
//						}
//						if(prodetails[4]!=null) {
//							try {
//								//Sysspecs
//								
//								if(Files.exists(Paths.get(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[4]))) {
//									pdfs[3]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(env.getProperty("ApplicationFilesDrive")+prodetails[2]+File.separator+prodetails[4])));
//							}
//							
//								}catch (FileNotFoundException e) {
//									logger.error(new Date() +" Inside ProjectBriefingPaper "+UserId, e);
//									e.printStackTrace();
//									pdfs[3]=null;
//								}
//						}
//							
//					}
//					pdffiles.add(pdfs);
//		    		
//		    		
//			/* -------------------------------------------------------------------------------------------------------------- */  		
//		    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?ProjectCode="+projectattribute[0]+"&rupess="+10000000;
//				 		HttpHeaders headers = new HttpHeaders();
//				 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
//				    	 
//				 		String jsonResult=null;
//						try {
//							HttpEntity<String> entity = new HttpEntity<String>(headers);
//							ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
//							jsonResult=response.getBody();						
//						}catch(Exception e) {
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
//								financialDetails.add(projectDetails);
//								req.setAttribute("financialDetails",projectDetails);
//							} catch (JsonProcessingException e) {
//								e.printStackTrace();
//							}
//						}
//						final String localUri2=uri+"/pfms_serv/getTotalDemand";
//
//				 		String jsonResult2=null;
//						try {
//							HttpEntity<String> entity = new HttpEntity<String>(headers);
//							ResponseEntity<String> response=restTemplate.exchange(localUri2, HttpMethod.POST, entity, String.class);
//							jsonResult2=response.getBody();						
//						}catch(Exception e) {
//							req.setAttribute("errorMsg", "errorMsg");
//						}
//						ObjectMapper mapper2 = new ObjectMapper();
//						mapper2.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
//						mapper2.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
//						List<TotalDemand> totaldemand=null;
//						if(jsonResult2!=null) {
//							try {
//								/*
//								 * projectDetails = mapper.readValue(jsonResult,
//								 * mapper.getTypeFactory().constructCollectionType(List.class,
//								 * ProjectFinancialDetails.class));
//								 */
//								totaldemand = mapper2.readValue(jsonResult2, new TypeReference<List<TotalDemand>>(){});
//								req.setAttribute("TotalProcurementDetails",totaldemand);
//							} catch (JsonProcessingException e) {
//								e.printStackTrace();
//							}
//						}
//		 
//		    	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(proid);
//		    	List<Object[]> procurementOnDemand=null;
//		    	List<Object[]> procurementOnSanction=null;
//		    	
//
//		    	if(procurementStatusList!=null)
//		    	{
//			    	Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
//			    	Collection<?> keys = map.keySet();
//			    	for(Object key:keys)
//			    	{
//			    		if(key.toString().equals("D")) {
//			    			procurementOnDemand=map.get(key);
//				    	}else if(key.toString().equals("S")) {
//				    		procurementOnSanction=map.get(key);
//				    	}
//			    	 }
//		    	}
////		    	procurementOnDemandlist.add(procurementStatusList);
////		    	procurementOnDemandlist.add(procurementOnDemand);
////		    	procurementOnSanctionlist.add(procurementOnSanction);
//		    	
//		    	procurementOnDemandlist.add(procurementOnDemand);
//		    	procurementOnSanctionlist.add(procurementOnSanction);
//		    	
//		    	req.setAttribute("procurementOnDemand", procurementOnDemand);
//		    	req.setAttribute("procurementOnSanction", procurementOnSanction);
//		    }
//	/* -------------------------------------------------------------------------------------------------------------  */
//		    	req.setAttribute("projectslist", projectslist);
//		    	req.setAttribute("committeeData", committee);
//		    	
//		    	req.setAttribute("projectattributes",projectattributes);
//	    		req.setAttribute("ebandpmrccount", ebandpmrccount);	    		
//	    		req.setAttribute("milestonesubsystems", milestonesubsystems);
//	    		req.setAttribute("milestones", milestones);	  
//	    		req.setAttribute("lastpmrcactions", lastpmrcactions);
//	    		req.setAttribute("lastpmrcminsactlist", lastpmrcminsactlist);
//	    		req.setAttribute("ProjectDetails", ProjectDetails);
//	    		req.setAttribute("ganttchartlist", ganttchartlist );
//	    		req.setAttribute("oldpmrcissueslist",oldpmrcissueslist);	    		
//	    		req.setAttribute("riskmatirxdata",riskmatirxdata);	    		
//	    		req.setAttribute("lastpmrcdecisions" , lastpmrcdecisions);	    		
//	    		req.setAttribute("actionplanthreemonths" , actionplanthreemonths);  	
//	    		req.setAttribute("projectdatadetails",projectdatadetails);
//	    		req.setAttribute("ReviewMeetingList",ReviewMeetingList);
//	    		req.setAttribute("ProjectRevList", ProjectRevList);
//	    		req.setAttribute("ReviewMeetingListPMRC",ReviewMeetingListPMRC);
//	    		req.setAttribute("financialDetails",financialDetails);
//	    		req.setAttribute("procurementOnDemandlist",procurementOnDemandlist);
//	    		req.setAttribute("procurementOnSanctionlist",procurementOnSanctionlist);
//	        	
//	    		req.setAttribute("projectidlist",Pmainlist);
//	    		req.setAttribute("projectid",projectid);
//	    		req.setAttribute("committeeid",tempid);
//		    	
//	    		req.setAttribute("pdffiles",pdffiles);
//	    		req.setAttribute("TechWorkDataList",TechWorkDataList);
//	    		req.setAttribute("ProjectCost",ProjectCost);
//	    		
//	    		req.setAttribute("milestoneactivitystatus", service.MilestoneActivityStatus());
//	    		req.setAttribute("milestonedatalevel6", milestonesubsystemsnew);  
//	    		req.setAttribute("TechImages", TechImages);   
//	    		req.setAttribute("filePath", env.getProperty("ApplicationFilesDrive"));
//	    		req.setAttribute("projectLabCode",projectLabCode);
//	    		req.setAttribute("SpecialCommitteesList",SpecialCommitteesList);
//	    		
//	    		String LevelId= "2";
//				
//				if(service.MileStoneLevelId(projectid,committeeid) != null) {
//					LevelId= service.MileStoneLevelId(projectid,committeeid)[0].toString();
//				}
//				  		
//				req.setAttribute("levelid", LevelId);
//	    		
//	    		
//	    		try {
//	    	        //String ProjectId=req.getParameter("projectid");
//	    	       
//	    	        List<Object[] > projlist= service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
//	    	        
//	    	        if(projlist.size()==0) 
//	    	        {				
//	    				redir.addAttribute("resultfail", "No Project is Assigned to you.");
//	    				return "redirect:/MainDashBoard.htm";
//	    			}
//	    	        
//	    	        
//	   	        
//	    	        if(projectid==null) {
//	    	        	try {
//	    	        		Object[] pro=projlist.get(0);
//	    	        		projectid=pro[0].toString();
//	    	        	}catch (Exception e) {
//	    					
//	    				}
//	    	           
//	    	        }
//	    	        List<Object[]> main=milservice.MilestoneActivityList(projectid);
//	    	            	        
//	    			req.setAttribute("MilestoneActivityList",main );
//	    			req.setAttribute("ProjectList",projlist);
//	    			req.setAttribute("ProjectId", projectid);
//	    			if(projectid!=null) {
//	    				req.setAttribute("ProjectDetailsMil", milservice.ProjectDetails(projectid).get(0));
//	    				int MainCount=1;
//	    				for(Object[] objmain:main ) {
//	    				 int countA=1;
//	    					List<Object[]>  MilestoneActivityA=milservice.MilestoneActivityLevel(objmain[0].toString(),"1");
//	    					req.setAttribute(MainCount+"MilestoneActivityA", MilestoneActivityA);
//	    					for(Object[] obj:MilestoneActivityA) {
//	    						List<Object[]>  MilestoneActivityB=milservice.MilestoneActivityLevel(obj[0].toString(),"2");
//	    						req.setAttribute(MainCount+"MilestoneActivityB"+countA, MilestoneActivityB);
//	    						int countB=1;
//	    						for(Object[] obj1:MilestoneActivityB) {
//	    							List<Object[]>  MilestoneActivityC=milservice.MilestoneActivityLevel(obj1[0].toString(),"3");
//	    							req.setAttribute(MainCount+"MilestoneActivityC"+countA+countB, MilestoneActivityC);
//	    							int countC=1;
//	    							for(Object[] obj2:MilestoneActivityC) {
//	    								List<Object[]>  MilestoneActivityD=milservice.MilestoneActivityLevel(obj2[0].toString(),"4");
//	    								req.setAttribute(MainCount+"MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
//	    								int countD=1;
//	    								for(Object[] obj3:MilestoneActivityD) {
//	    									List<Object[]>  MilestoneActivityE=milservice.MilestoneActivityLevel(obj3[0].toString(),"5");
//	    									req.setAttribute(MainCount+"MilestoneActivityE"+countA+countB+countC+countD, MilestoneActivityE);
//	    									countD++;
//	    								}
//	    								countC++;
//	    							}
//	    							countB++;
//	    						}
//	    						countA++;
//	    					}
//	    					MainCount++;
//	    				}
//	    			}
//
//	    		}
//	    		catch (Exception e) {
//	    			e.printStackTrace(); 
//	    			logger.error(new Date() +" Inside ProjectBriefing.htm (Milestone ActivityLogic) "+UserId, e); 
//	    			return "static/Error";
//	    			
//	    		}
//	   		
//		    	return "print/ProjectBriefingPaperNew";
//		    }
//		    catch(Exception e) {	    		
//	    		logger.error(new Date() +" Inside ProjectBriefing.htm "+UserId, e);
//	    		e.printStackTrace();
//	    		return "static/Error";
//		
//	    	}		
//		}
	    
	    @RequestMapping(value="AgendaPresentation.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String AgendaPresentation(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)	throws Exception 
		{
	    	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside AgendaPresentation.htm "+UserId);		
	    	try {
		    	String scheduleid = req.getParameter("scheduleid");
		    	String projectid = req.getParameter("projectid");
		    	String committeeid= req.getParameter("committeeid");
		    	
		    	Committee committee = service.getCommitteeData(committeeid);
		    	String projectLabCode = committee.getLabCode();
		    	String CommitteeCode = committee.getCommitteeShortName().trim();
		    	
		    	
		    	Object[] scheduledata=service.CommitteeScheduleEditData(scheduleid);
		    	
		    	req.setAttribute("labInfo", service.LabDetailes(projectLabCode));
		    	req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(projectLabCode));
		    	req.setAttribute("Drdologo", LogoUtil.getDRDOLogoAsBase64String());
		    	req.setAttribute("committeeData", service.getCommitteeData(committeeid));
		    	req.setAttribute("projectattributes", service.ProjectAttributes(projectid));
		    	req.setAttribute("AgendaList", service.AgendaList(scheduleid));
		    	req.setAttribute("AgendaDocList",service.AgendaLinkedDocList(scheduleid));
		    	req.setAttribute("committeeMetingsCount", service.ProjectCommitteeMeetingsCount(projectid, CommitteeCode) );
		    	req.setAttribute("scheduledata", scheduledata);
		    	req.setAttribute("SplCommitteeCodes",SplCommitteeCodes);
		    	
		    	req.setAttribute("projectid", projectid);
		    	
		    	return "print/AgendaPresentation";
	    	}catch (Exception e) {
    			e.printStackTrace(); 
    			logger.error(new Date() +" Inside AgendaPresentation.htm  "+UserId, e); 
    			return "static/Error";
    			
    		}
		}
	    
	    
	    @RequestMapping(value="FrozenBriefingAdd.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String FrozenBriefingAdd(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res,@RequestParam(name = "briefingpaper")MultipartFile BPaper)	throws Exception 
		{
	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside FrozenBriefingAdd.htm "+UserId);		
	    	try {
		    	String scheduleid = req.getParameter("scheduleid");
		    	String projectid=req.getParameter("projectid");
		    	String committeecode=req.getParameter("committeecode");
		    	
		    	String projectLabCode = service.ProjectDetails(projectid).get(0)[5].toString();
		    	CommitteeProjectBriefingFrozen briefing = CommitteeProjectBriefingFrozen.builder()
						.ScheduleId(Long.parseLong(scheduleid))
						.FreezeByEmpId(Long.parseLong(EmpId))
						.BriefingFileMultipart(BPaper)
						.LabCode(projectLabCode)
						.IsActive(1)
						.build();

		    	long count = service.FreezeBriefingMultipart(briefing);
		    	if(count>0)
    			{
    				int update=service.updateBriefingPaperFrozen(Long.parseLong(scheduleid));
    				redir.addAttribute("result", "Briefing Paper Added Successfully");
    			}
    			else 
    			{
    				redir.addAttribute("resultfail", "Briefing Paper Adding Failed");	
    			}
		    	redir.addFlashAttribute("projectid",projectid);
		    	redir.addFlashAttribute("committeecode",committeecode);
		    	return "redirect:/FroozenBriefingList.htm";
	    	}catch (Exception e) {
    			e.printStackTrace(); 
    			logger.error(new Date() +" Inside FrozenBriefingAdd.htm  "+UserId, e); 
    			return "static/Error";
    			
    		}
		}
	    
	    
	    @RequestMapping(value="FrozenBriefingUpdate.htm", method = {RequestMethod.GET,RequestMethod.POST})
		public String FrozenBriefingUpdate(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res,@RequestParam(name = "briefingpaper")MultipartFile BPaper)	throws Exception 
		{
	    	String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside FrozenBriefingUpdate.htm "+UserId);		
	    	try {
		    	String scheduleid = req.getParameter("scheduleid");
		    	String projectid=req.getParameter("projectid");
		    	String committeecode=req.getParameter("committeecode");
		    	
		    	long count = service.FreezeBriefingMultipartUpdate(scheduleid, BPaper);
		    	if(count>0)
    			{
    				redir.addAttribute("result", "Briefing Paper Added Successfully");
    			}
    			else 
    			{
    				redir.addAttribute("resultfail", "Briefing Paper Adding Failed");	
    			}

		    	redir.addFlashAttribute("projectid",projectid);
		    	redir.addFlashAttribute("committeecode",committeecode);
		    	return "redirect:/FroozenBriefingList.htm";
	    	}catch (Exception e) {
    			e.printStackTrace(); 
    			logger.error(new Date() +" Inside FrozenBriefingUpdate.htm  "+UserId, e); 
    			return "static/Error";
    			
    		}
		}
	    
		
		@RequestMapping(value = "FroozenBriefingList.htm")
		public String FroozenBriefingList(Model model, HttpServletRequest req, HttpSession ses, HttpServletResponse res,RedirectAttributes redir) throws Exception 
		{
			String UserId = (String) ses.getAttribute("Username");
			String LabCode = (String) ses.getAttribute("labcode");
			String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	String Logintype= (String)ses.getAttribute("LoginType");
			logger.info(new Date() +"Inside FroozenBriefingList.htm "+UserId);		
			try {
				
				String projectid= req.getParameter("projectid");
				String committeecode= req.getParameter("committeecode");
				
				List<Object[]> projectslist  =service.LoginProjectDetailsList(EmpId, Logintype, LabCode);
				
				if(projectslist.size()==0) 
				{
					redir.addAttribute("resultfail","Project is Not Assigned!" );
					return "redirect:/MainDashBoard.htm";
				}
				if(projectid==null || committeecode==null) 
		    	{
		    		Map md = model.asMap();	    	
		    		projectid = (String) md.get("projectid");
		    		committeecode = (String) md.get("committeecode");
		    	}
				if(projectid==null) {
					projectid  = projectslist.get(0)[0].toString();
					committeecode = "PMRC";
				}
				
				req.setAttribute("projectid",projectid);
				req.setAttribute("committeecode",committeecode);
				req.setAttribute("projectslist", projectslist);
				req.setAttribute("BriefingScheduleList", service.BriefingScheduleList(LabCode, committeecode, projectid));
				return "print/ScheduleBriefingList";
			}
			catch (Exception e) {
				e.printStackTrace();
				logger.error(new Date() +" Inside FroozenBriefingList.htm "+UserId, e);
				return "static/error";
			}
		}
		
		
		@RequestMapping(value = "RecDecDetailsAdd.htm" ,method = RequestMethod.POST)
		public String RecDecAdd(HttpServletRequest req , HttpSession ses , RedirectAttributes redir)throws Exception
		{
			String UserId = (String) ses.getAttribute("Username");
			logger.info(new Date() +"Inside RecDecDetailsAdd.htm "+UserId);	
			try {
				String committeeid = req.getParameter("committeeid");
				String projectid = req.getParameter("projectid");
				
				String recid  = req.getParameter("RedDecID");
				String recdec = req.getParameter("RecDecPoints");
				String type = req.getParameter("darc");
				String schedulid = req.getParameter("schedulid");
				String val="";
				if(type.equalsIgnoreCase("D")) {
					val="Decision";
				}else {
					val="Recommendations";
				}
				RecDecDetails rcdc = new RecDecDetails();
				
				if(recid!=null && recid!=""){
					rcdc.setRecDecId(Long.parseLong(recid));
				}
				rcdc.setType(type);
				rcdc.setPoint(recdec);
				rcdc.setScheduleId(Long.parseLong(schedulid));
				long result  =service.RedDecAdd(rcdc,UserId);
				if(recid!=null && recid!="") {
					if(result>0)
	    			{
	    				redir.addAttribute("result", val+" Updated Successfully");
	    			}else{
	    				redir.addAttribute("resultfail", val+" Update Failed");	
	    			}
				}else {
					if(result>0)
	    			{
	    				redir.addAttribute("result", val+" Added Successfully");
	    			}else{
	    				redir.addAttribute("resultfail", val+" Adding Failed");	
	    			}
				}
				redir.addFlashAttribute("projectid",projectid);
				redir.addFlashAttribute("committeeid",committeeid);
				return "redirect:/ProjectBriefingPaper.htm";
			}catch(Exception e){
				e.printStackTrace();
				logger.error(new Date() +" Inside RecDecDetailsAdd.htm "+UserId, e);
				return "static/error";
			}
		}
	    
}
