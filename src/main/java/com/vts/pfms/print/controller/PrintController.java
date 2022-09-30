package com.vts.pfms.print.controller;

import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Collection;
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
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.font.FontProvider;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.Zipper;
import com.vts.pfms.master.dto.ProjectFinancialDetails;
import com.vts.pfms.milestone.dto.MilestoneActivityLevelConfigurationDto;
import com.vts.pfms.milestone.service.MilestoneService;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.print.model.InitiationSanction;
import com.vts.pfms.print.model.InitiationsanctionCopyAddr;
import com.vts.pfms.print.model.TechImages;
import com.vts.pfms.print.service.PrintService;


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
	
	@Autowired
	Environment env;
	private static final Logger logger=LogManager.getLogger(PrintController.class);

	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	@RequestMapping(value="PfmsPrint.htm", method = RequestMethod.POST)
	public String PfmsPrint(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)
			throws Exception {
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside PfmsPrint.htm "+UserId);		
	    	try {
	    		String InitiationId=req.getParameter("IntiationId");
	    		
	   		 	LabMaster labmaster= service.LabDetailes();
	    		
//	    		if(labmaster.getLabLogo().length!=0) {
//
//	    			InputStream targetStream = new ByteArrayInputStream(labmaster.getLabLogo());
//	        		
//	        		BufferedImage img = ImageIO.read(targetStream);
//	        		String path=req.getServletContext().getRealPath("/resources");
//	        		
//	        		
//	        		String fileName="logo.jpg";
//	    		
//	        		ByteArrayOutputStream os = new ByteArrayOutputStream();
//	        		ImageIO.write(img, "jpeg", os);                          
//	        		InputStream inputStream = new ByteArrayInputStream(os.toByteArray());
//	        		
//	        	
//	    			 OutputStream outputStream = null;  
//	    			
//	    			File newFile = new File(path+File.separator+fileName);  
//	    			   
//	    			 String Path1="logo.jpg";
//	    			 
//	    			if(Path1!=null) {
//	    			 File newFile1 = new File(path+File.separator+Path1);
//	    				 newFile1.delete(); 
//	    			
//	    			  
//	    			  if (!newFile.exists()) {    
//	    			    newFile.createNewFile(); 
//	    			   }
//	    			    outputStream = new FileOutputStream(newFile);    
//	    			    int read = 0;    
//	    			    byte[] bytes = new byte[1024];    
//	    			     
//	    			   
//	    			    
//	    			    outputStream.write(bytes, 0, read);   
//	    			    
//	    			    while ((read = inputStream.read(bytes)) != -1) {    
//	    			     outputStream.write(bytes, 0, read);    
//	    			    } 
//	    			    
//	    			    outputStream.close();
//	        		
//	        		String imagepath=path+File.separator+fileName;
//	        	
//	        		
//	        		req.setAttribute("imagepath", imagepath );
//	    			
//	    		}
//
//	    	}
	   		 	req.setAttribute("lablogo", Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(req.getServletContext().getRealPath("view/images/drdologo.png")))));                     
	    		req.setAttribute("labdata", service.LabDetailes());
	    		req.setAttribute("LabList", service.LabList().get(0));
	    		req.setAttribute("PfmsInitiationList", service.PfmsInitiationList(InitiationId).get(0));
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
		logger.info(new Date() +"Inside PfmsPrint.htm "+UserId);		
	    try {
	    	String InitiationId=req.getParameter("IntiationId");		
			LabMaster labmaster= service.LabDetailes();
	    		
	    		req.setAttribute("labdata", service.LabDetailes());
	    		req.setAttribute("PfmsInitiationList", service.PfmsInitiationList(InitiationId));
	    		req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(InitiationId));
	    		req.setAttribute("CostDetailsList", service.CostDetailsList(InitiationId));
	    		req.setAttribute("ScheduleList", service.ProjectInitiationScheduleList(InitiationId));
	    		req.setAttribute("LabList", service.LabList());
	    	
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
    		
	    	
   		 	req.setAttribute("lablogo", Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(req.getServletContext().getRealPath("view/images/drdologo.png")))));                     
    		req.setAttribute("labdata", service.LabDetailes());
    		req.setAttribute("LabList", service.LabList().get(0));
    		req.setAttribute("PfmsInitiationList", service.PfmsInitiationList(InitiationId).get(0));
    		req.setAttribute("DetailsList", service.ProjectIntiationDetailsList(InitiationId));
    		req.setAttribute("CostDetailsList", service.CostDetailsList(InitiationId));
    		req.setAttribute("ScheduleList", service.ProjectInitiationScheduleList(InitiationId));
    		req.setAttribute("isprint", "1");
    		
	    	String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/PfmsPrint.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();
	    	String filename="ExecutiveSummary";		
		
	    	byte[] data = html.getBytes();
	    	InputStream fis1=new ByteArrayInputStream(data);
	    	PdfDocument pdfDoc = new PdfDocument(new PdfWriter(path+"/"+filename+".pdf"));	
	    	pdfDoc.setTagged();
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
	        os.close();
	        fis.close();
	         
	            
	        Path pathOfFile2= Paths.get(path+"/"+filename+".pdf"); 
	        Files.delete(pathOfFile2);		
	    	
	        document.close();
	        

	        
	    	
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
	    
	    	String htmlstring=req.getParameter("htmlstring");
	    	
	    	String filename="ProjectProposal";		
	    	String path=req.getServletContext().getRealPath("/view/temp");
		
	    	String html = htmlstring;
	    	byte[] data = html.getBytes();
	    	InputStream fis1=new ByteArrayInputStream(data);
	    	PdfDocument pdfDoc = new PdfDocument(new PdfWriter(path+"/"+filename+".pdf"));	
	    	pdfDoc.setTagged();
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
	        os.close();
	        fis.close();
	         
	            
	        Path pathOfFile2= Paths.get(path+"/"+filename+".pdf"); 
	        Files.delete(pathOfFile2);		
	    	
	        document.close();
	    	
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectProposalDownload.htm "+UserId, e);
    		e.printStackTrace();
			
	
    	}		
	}
	
	
	
	
	@RequestMapping(value="ProjectBriefingDownload.htm", method = RequestMethod.GET )
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
	    	List<Object[]> projectslist =service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	    	    	
	    	
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
	    	List<Object[]> projectdatadetails  = new ArrayList<Object[]>();
	    	List<Object[]> TechWorkDataList =new ArrayList<Object[]>();
    		List<List<Object[]>> milestonesubsystemsnew = new ArrayList<List<Object[]>>();
	    	
	    	List<List<Object[]>> ProjectRevList =new ArrayList<List<Object[]>>();
	    	
	    	
	    	List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
	    	List<List<Object[]>> procurementOnDemandlist  = new ArrayList<List<Object[]>>();
    		List<List<Object[]>> procurementOnSanctionlist = new ArrayList<List<Object[]>>();
	    	
	    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	for(String proid : Pmainlist) 
	    	{	    	
	    		projectattributes.add(service.ProjectAttributes(proid));
	    		ebandpmrccount.add(service.EBAndPMRCCount(proid));
	    		milestonesubsystems.add(service.MilestoneSubsystems(proid));
	    		milestones.add(service.Milestones(proid));
	    		lastpmrcactions.add(service.LastPMRCActions(proid,committeeid));
	    		lastpmrcminsactlist.add(service.LastPMRCActions1(proid,committeeid));
	    		Object[] prodetails=service.ProjectDetails(proid).get(0);
	    		ProjectDetails.add(prodetails);
	    		ganttchartlist.add(service.GanttChartList(proid));
	    		oldpmrcissueslist.add(service.OldPMRCIssuesList(proid));
	    		riskmatirxdata.add(service.RiskMatirxData(proid));
	    		lastpmrcdecisions.add(service.LastPMRCDecisions(committeeid,proid));
	    		actionplanthreemonths.add(service.ActionPlanSixMonths(proid,committeeid));
	    		projectdatadetails.add(service.ProjectDataDetails(proid));
	    		ReviewMeetingList.add(service.ReviewMeetingList(projectid, committeeid));
	    		TechWorkDataList.add(service.TechWorkData(proid));
		    	milestonesubsystemsnew.add(service.BreifingMilestoneDetails(proid));
	    		ProjectRevList.add(service.ProjectRevList(proid));
	    		
	    		
	    	
		/* ----------------------------------------------------------------------------------------------------------	   */  		
	    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?projectId="+proid+"&rupess="+10000000;
			 		HttpHeaders headers = new HttpHeaders();
			 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
			    	 
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
	    	req.setAttribute("projectslist", projectslist);
	    	
	    	
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
	    	req.setAttribute("labInfo", service.LabDetailes());
	    	req.setAttribute("lablogo", Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(req.getServletContext().getRealPath("view/images/drdologo.png")))));    
            req.setAttribute("filePath", env.getProperty("file_upload_path"));
            req.setAttribute("milestonedatalevel6", milestonesubsystemsnew);
    		
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
	    	pdfDoc.setTagged();
	    	Document document = new Document(pdfDoc, PageSize.A4);
	    	//document.setMargins(50, 100, 150, 50);
	    	document.setMargins(50, 50, 50, 50);
	    	ConverterProperties converterProperties = new ConverterProperties();
	    	FontProvider dfp = new DefaultFontProvider(true, true, true);
	    	converterProperties.setFontProvider(dfp);
	        HtmlConverter.convertToPdf(fis1,pdfDoc,converterProperties);
            ImageData leftLogo = ImageDataFactory.create(env.getProperty("file_upload_path")+"\\logo\\drdo.png");
            ImageData rightLogo = ImageDataFactory.create(env.getProperty("file_upload_path")+"\\logo\\lab.png");
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
	        	
	        	try {
	        		String No2=null;
	        		if(Long.parseLong(committeeid)==1){ 
	        		No2="P"+(Long.parseLong(ebandpmrccount.get(0).get(0)[1].toString())+1);
	        		}else if(Long.parseLong(committeeid)==2){
	        			No2="E"+(Long.parseLong(ebandpmrccount.get(0).get(1)[1].toString())+1);
	        						} 
		        	 if(new File(env.getProperty("file_upload_path")+"\\grantt\\grantt_"+objData[1]+"_"+No2+".pdf").exists()) {
		        		 	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(env.getProperty("file_upload_path")+"\\grantt\\grantt_"+objData[1]+"_"+No2+".pdf"),new PdfWriter(path+File.separator+filename+"temp.pdf"));
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
					        Files.delete(pathOfFile);	
						    }
		        	
		        	}catch (Exception e) {
						// TODO: handle exception
					}
	        	
	        	if(objData[3]!=null&&objData[3]!=null) {
	        	if(FilenameUtils.getExtension(objData[3].toString()).equals("pdf")) {
		        PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(objData[2]+"\\"+objData[3]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
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
	        	if(objData[4]!=null&&objData[4]!=null) {
			    if(FilenameUtils.getExtension(objData[4].toString()).equals("pdf")) {
			    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(objData[2]+"\\"+objData[4]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
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
	        	if(objData[5]!=null&&objData[5]!=null) {
			    if(FilenameUtils.getExtension(objData[5].toString()).equals("pdf")) {
			    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(objData[2]+"\\"+objData[5]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
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
	        	if(objData[6]!=null&&objData[6]!=null) {
			    if(FilenameUtils.getExtension(objData[6].toString()).equals("pdf")) {
			    	PdfDocument pdfDocument2 = new PdfDocument(new PdfReader(objData[2]+"\\"+objData[6]),new PdfWriter(path+File.separator+filename+"temp.pdf"));
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
	        	
	        	 if(FilenameUtils.getExtension(TechWorkDataList.get(z)[8].toString()).equals("pdf")) {
	        		 Zipper zip=new Zipper();
	                 zip.unpack(TechWorkDataList.get(z)[6].toString()+TechWorkDataList.get(z)[7].toString()+TechWorkDataList.get(z)[11].toString()+"-"+TechWorkDataList.get(z)[10].toString()+".zip",path,TechWorkDataList.get(z)[9].toString());

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
					// TODO: handle exception
				}
	        	
	        	z++;
			}


	        pdfDocument.close();
	        merger.close();

	        pdf1.close();	       
	        pdfw.close();
	        res.setContentType("application/pdf");
	        res.setHeader("Content-disposition","attachment;filename="+filename+".pdf"); 
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
	
	
	
	@RequestMapping(value="ProjectBriefing.htm", method = RequestMethod.POST)
	public String ProjectBriefing(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectBriefing.htm "+UserId);		
	    try {    	
	    	
	    	String projectid=req.getParameter("projectid");
	    	String committeeid= req.getParameter("committeeid");
	    	String tempid=committeeid;
	    	if(committeeid==null  ) {
	    		committeeid="1";
	    		tempid="1";
	    	}else if( Long.parseLong(committeeid)==0)
	    	{
	    		committeeid="1";
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
	    	
	    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	for(String proid : Pmainlist) 
	    	{	    	
	    		projectattributes.add(service.ProjectAttributes(proid));
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
	    		milestonesubsystemsnew.add(service.BreifingMilestoneDetails(proid));
	    		
	    		ProjectRevList.add(service.ProjectRevList(proid));
	    	
		/* ----------------------------------------------------------------------------------------------------------	   */  		
	    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?projectId="+proid+"&rupess="+10000000;
			 		HttpHeaders headers = new HttpHeaders();
			 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
			    	 
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
    		req.setAttribute("committeeid",tempid);
	    	
	    	
	    	req.setAttribute("ProjectCost",ProjectCost);
    		
	    	req.setAttribute("isprint", "0");
	    	
	    	req.setAttribute("labInfo", service.LabDetailes());
	    	req.setAttribute("lablogo", Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(req.getServletContext().getRealPath("view/images/drdologo.png")))));    
    		req.setAttribute("milestonedatalevel6", milestonesubsystemsnew);
    		
    		String LevelId= "2";
			
			if(service.MileStoneLevelId(projectid,committeeid) != null) {
				LevelId= service.MileStoneLevelId(projectid,committeeid)[0].toString();
			}
			  		
			req.setAttribute("levelid", LevelId);
	    	
	    	// MileStone Activity Logic (number 6)
    		
			/*
			 * try { List<Object[] > projlist=
			 * service.LoginProjectDetailsList(EmpId,Logintype); if(projlist.size()==0) {
			 * redir.addAttribute("resultfail", "No Project is Assigned to you."); return
			 * "redirect:/MainDashBoard.htm"; }
			 * 
			 * if(projectid==null) { try { Object[] pro=projlist.get(0);
			 * projectid=pro[0].toString(); }catch (Exception e) {
			 * 
			 * }
			 * 
			 * } List<Object[]> main=milservice.MilestoneActivityList(projectid);
			 * 
			 * req.setAttribute("MilestoneActivityList",main );
			 * req.setAttribute("ProjectList",projlist); req.setAttribute("ProjectId",
			 * projectid); if(projectid!=null) { req.setAttribute("ProjectDetailsMil",
			 * milservice.ProjectDetails(projectid).get(0)); int MainCount=1; for(Object[]
			 * objmain:main ) { int countA=1; List<Object[]>
			 * MilestoneActivityA=milservice.MilestoneActivityLevel(objmain[0].toString(),
			 * "1"); req.setAttribute(MainCount+"MilestoneActivityA", MilestoneActivityA);
			 * for(Object[] obj:MilestoneActivityA) { List<Object[]>
			 * MilestoneActivityB=milservice.MilestoneActivityLevel(obj[0].toString(),"2");
			 * req.setAttribute(MainCount+"MilestoneActivityB"+countA, MilestoneActivityB);
			 * int countB=1; for(Object[] obj1:MilestoneActivityB) { List<Object[]>
			 * MilestoneActivityC=milservice.MilestoneActivityLevel(obj1[0].toString(),"3");
			 * req.setAttribute(MainCount+"MilestoneActivityC"+countA+countB,
			 * MilestoneActivityC); int countC=1; for(Object[] obj2:MilestoneActivityC) {
			 * List<Object[]>
			 * MilestoneActivityD=milservice.MilestoneActivityLevel(obj2[0].toString(),"4");
			 * req.setAttribute(MainCount+"MilestoneActivityD"+countA+countB+countC,
			 * MilestoneActivityD); int countD=1; for(Object[] obj3:MilestoneActivityD) {
			 * List<Object[]>
			 * MilestoneActivityE=milservice.MilestoneActivityLevel(obj3[0].toString(),"5");
			 * req.setAttribute(MainCount+"MilestoneActivityE"+countA+countB+countC+countD,
			 * MilestoneActivityE); countD++; } countC++; } countB++; } countA++; }
			 * MainCount++; } }
			 * 
			 * 
			 * String LevelId= "2"; String Tabid="0";
			 * 
			 * if(service.MileStoneLevelId(projectid,committeeid) != null) { LevelId=
			 * service.MileStoneLevelId(projectid,committeeid)[0].toString(); }
			 * 
			 * if(req.getParameter("tabid")!=null) { Tabid=req.getParameter("tabid"); }
			 * 
			 * req.setAttribute("tabid", Tabid); req.setAttribute("levelid", LevelId);
			 * 
			 * } catch (Exception e) { e.printStackTrace(); logger.error(new Date()
			 * +" Inside ProjectBriefing.htm (Milestone ActivityLogic) "+UserId, e); return
			 * "static/Error";
			 * 
			 * }
			 */
	    	

	    	return "print/BriefingPaperNew1";
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectBriefing.htm "+UserId, e);
    		e.printStackTrace();
    		return "static/Error";
	
    	}		
	}

	

	
	
	{
		
//		@RequestMapping(value="ProjectBriefing1.htm", method = RequestMethod.POST)
//		public String ProjectBriefing1(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)	throws Exception 
//		{
//			String UserId = (String) ses.getAttribute("Username");
//			logger.info(new Date() +"Inside ProjectBriefing.htm "+UserId);		
//		    try {    	
//		    	
//		    	String projectid=req.getParameter("projectid");
//		    	String committeeid= req.getParameter("committeeid");
//		    	String tempid=committeeid;
//		    	if(committeeid==null  ) {
//		    		committeeid="1";
//		    		tempid="1";
//		    	}else if( Long.parseLong(committeeid)==0)
//		    	{
//		    		committeeid="1";
//		    	}
//		    	
//		    	if(Long.parseLong(projectid)>0)
//		    	{
//		    	req.setAttribute("lastpmrcminsactlist", service.LastPMRCActions1(projectid,"1"));
//		    	req.setAttribute("projectattributes",service.ProjectAttributes(projectid));
//	    		req.setAttribute("ebandpmrccount", service.EBAndPMRCCount(projectid));
//	    		req.setAttribute("milestonesubsystems", service.MilestoneSubsystems(projectid));
//	    		req.setAttribute("milestones", service.Milestones(projectid));	  
//	    		req.setAttribute("lastpmrcactions", service.LastPMRCActions(projectid,"2"));	 
////	    		req.setAttribute("oldpmrcactions", service.OldPMRCActions(projectid,committeeid));	 
//	    		req.setAttribute("projectid",projectid);  
//	    		req.setAttribute("committeeid",tempid);
//	    		req.setAttribute("ProjectDetails", service.ProjectDetails(projectid).get(0));
//	    		req.setAttribute("ganttchartlist", service.GanttChartList(projectid));
//	    		req.setAttribute("oldpmrcissueslist",service.OldPMRCIssuesList(projectid));
//	    		req.setAttribute("riskmatirxdata",service.RiskMatirxData(projectid));
//	    		req.setAttribute("isprint","0");
//	    		req.setAttribute("lastpmrcdecisions",service.LastPMRCDecisions(committeeid,projectid));
//	    		req.setAttribute("actionplanthreemonths",service.ActionPlanSixMonths(projectid));
//	    		
//	    		Object[] projectdatadetails=service.ProjectDataDetails(projectid);
//	    		String[] imgs=new String[3];
////				if(projectdatadetails!=null && projectdatadetails.length>0)
////				{	
////					try {
////						//config
////						imgs[0] = Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[3])));
////					}catch (Exception e) {
////						imgs[0]=null;
////					}
////					
////					try {
////							//producttree
////							imgs[1]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[5])));
////					}catch (Exception e) {
////						imgs[1]=null;
////					}
////					try {
////							//pearlimg
////							imgs[2]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[6])));
////					}catch (Exception e) {
////						imgs[2]=null;
////					}
////						
////				}
////				req.setAttribute("projectdataimages",imgs);
//	    		req.setAttribute("projectdatadetails", projectdatadetails);
//		    	
//	    		
//	    		
//	    		
//	    /* ----------------------------------------------------------------------------------------------------------	   */
//	    		 final String localUri=uri+"/pfms_serv/financialStatus?projectId="+projectid+"&rupess="+10000000;
//			 		HttpHeaders headers = new HttpHeaders();
//			 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
//			    	 
//			 		String jsonResult=null;
//					try {
//						HttpEntity<String> entity = new HttpEntity<String>(headers);
//						ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
//						jsonResult=response.getBody();						
//					}catch(Exception e) {
//						req.setAttribute("errorMsg", "errorMsg");
//					}
//					ObjectMapper mapper = new ObjectMapper();
//					mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
//					mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
//					List<ProjectFinancialDetails> projectDetails=null;
//					if(jsonResult!=null) {
//						try {
//							/*
//							 * projectDetails = mapper.readValue(jsonResult,
//							 * mapper.getTypeFactory().constructCollectionType(List.class,
//							 * ProjectFinancialDetails.class));
//							 */
//							projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
//							req.setAttribute("financialDetails",projectDetails);
//						} catch (JsonProcessingException e) {
//							e.printStackTrace();
//						}
//					}
//						
//		    	}
//					List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(projectid);
//			    	List<Object[]> procurementOnDemand=null;
//			    	List<Object[]> procurementOnSanction=null;
//			    	
	//
//			    	if(procurementStatusList!=null)
//			    	{
//				    	Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
//				    	Collection<?> keys = map.keySet();
//				    	for(Object key:keys)
//				    	{
//				    		if(key.toString().equals("D")) {
//				    			procurementOnDemand=map.get(key);
//					    	}else if(key.toString().equals("S")) {
//					    		procurementOnSanction=map.get(key);
//					    	}
//				    	 }
//			    	}
//			    	req.setAttribute("procurementOnDemand", procurementOnDemand);
//			    	req.setAttribute("procurementOnSanction", procurementOnSanction);
//			  /* ----------------------------------------------------------------------------------------------------------	   */
//	    		
//	    		
//	    		
//	    		
//		    	return "print/BriefingPaper";
//		    }
//		    catch(Exception e) {	    		
//	    		logger.error(new Date() +" Inside ProjectBriefing.htm "+UserId, e);
//	    		e.printStackTrace();
//	    		return "static/Error";
	//	
//	    	}		
//		}
	
		
//	@RequestMapping(value="ProjectBriefingPaper1.htm", method = {RequestMethod.GET,RequestMethod.POST})
//	public String ProjectBriefingPaper1(HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)	throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectBriefing.htm "+UserId);		
//	    try {
//	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
//	    	String Logintype= (String)ses.getAttribute("LoginType");
//	    	String projectid=req.getParameter("projectid");
//	    	List<Object[]> projectslist =service.LoginProjectDetailsList(EmpId,Logintype);
//	    	if(projectslist.size()==0) 
//	        {				
//				redir.addAttribute("resultfail", "No Project is Assigned to you.");
//				return "redirect:/MainDashBoard.htm";
//			}
//	    	if(projectid==null) {
//	    		projectid=projectslist.get(0)[0].toString();
//	    	}
//	    	
//	    	String committeeid= req.getParameter("committeeid");
//	    	String tempid=committeeid;
//	    	if(committeeid==null  ) {
//	    		committeeid="1";
//	    		tempid="1";
//	    	}else if( Long.parseLong(committeeid)==0)
//	    	{
//	    		committeeid="1";
//	    	}
//	    		
//	    		req.setAttribute("projectattributes",service.ProjectAttributes(projectid));
//	    		req.setAttribute("ebandpmrccount", service.EBAndPMRCCount(projectid));
//	    		req.setAttribute("milestonesubsystems", service.MilestoneSubsystems(projectid));
//	    		req.setAttribute("milestones", service.Milestones(projectid));	  
//	    		req.setAttribute("lastpmrcactions", service.LastPMRCActions(projectid,"2"));	
//	    		req.setAttribute("lastpmrcminsactlist", service.LastPMRCActions1(projectid,"1"));	
////	    		req.setAttribute("oldpmrcactions", service.OldPMRCActions(projectid,committeeid));	 
//	    		req.setAttribute("ProjectDetails", service.ProjectDetails(projectid).get(0));
//	    		req.setAttribute("ganttchartlist", service.GanttChartList(projectid));
//	    		req.setAttribute("oldpmrcissueslist",service.OldPMRCIssuesList(projectid));
//	    		req.setAttribute("projectid",projectid);
//	    		req.setAttribute("committeeid",tempid);
//	    		req.setAttribute("riskmatirxdata",service.RiskMatirxData(projectid));
//	    		req.setAttribute("lastpmrcdecisions",service.LastPMRCDecisions(committeeid,projectid));
//	    		req.setAttribute("actionplanthreemonths",service.ActionPlanSixMonths(projectid));
//	    		
//	    		
//	    		Object[] projectdatadetails=service.ProjectDataDetails(projectid);
//	    		String[] imgs=new String[4];
////				if(projectdatadetails!=null && projectdatadetails.length>0)
////				{	
////					try {
////						//config
////						imgs[0] = Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[3])));
////					}catch (Exception e) {
////						imgs[0]=null;
////					}
////					
////					try {
////							//producttree
////							imgs[1]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[5])));
////					}catch (Exception e) {
////						imgs[1]=null;
////					}
////					try {
////							//pearlimg
////							imgs[2]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(projectdatadetails[2]+File.separator+projectdatadetails[6])));
////					}catch (Exception e) {
////						imgs[2]=null;
////					}
////					  
////				}
//				req.setAttribute("projectdataimages",imgs);
//				req.setAttribute("projectdatadetails",projectdatadetails);
//	    		
//	    		
//		/* ----------------------------------------------------------------------------------------------------------	   */  		
//	    		 final String localUri=uri+"/pfms_serv/financialStatus?projectId="+projectid+"&rupess="+10000000;
//			 		HttpHeaders headers = new HttpHeaders();
//			 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
//			    	 
//			 		String jsonResult=null;
//					try {
//						HttpEntity<String> entity = new HttpEntity<String>(headers);
//						ResponseEntity<String> response=restTemplate.exchange(localUri, HttpMethod.POST, entity, String.class);
//						jsonResult=response.getBody();						
//					}catch(Exception e) {
//						req.setAttribute("errorMsg", "errorMsg");
//					}
//					ObjectMapper mapper = new ObjectMapper();
//					mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
//					mapper.setVisibility(VisibilityChecker.Std.defaultInstance().withFieldVisibility(JsonAutoDetect.Visibility.ANY));
//					List<ProjectFinancialDetails> projectDetails=null;
//					if(jsonResult!=null) {
//						try {
//							/*
//							 * projectDetails = mapper.readValue(jsonResult,
//							 * mapper.getTypeFactory().constructCollectionType(List.class,
//							 * ProjectFinancialDetails.class));
//							 */
//							projectDetails = mapper.readValue(jsonResult, new TypeReference<List<ProjectFinancialDetails>>(){});
//							req.setAttribute("financialDetails",projectDetails);
//						} catch (JsonProcessingException e) {
//							e.printStackTrace();
//						}
//					}
//	    	
//	 
//	    	List<Object[]> procurementStatusList=(List<Object[]>)service.ProcurementStatusList(projectid);
//	    	List<Object[]> procurementOnDemand=null;
//	    	List<Object[]> procurementOnSanction=null;
//	    	
//
//	    	if(procurementStatusList!=null)
//	    	{
//		    	Map<Object, List<Object[]>> map = procurementStatusList.stream().collect(Collectors.groupingBy(c -> c[9])); 
//		    	Collection<?> keys = map.keySet();
//		    	for(Object key:keys)
//		    	{
//		    		if(key.toString().equals("D")) {
//		    			procurementOnDemand=map.get(key);
//			    	}else if(key.toString().equals("S")) {
//			    		procurementOnSanction=map.get(key);
//			    	}
//		    	 }
//	    	}
//	    	req.setAttribute("procurementOnDemand", procurementOnDemand);
//	    	req.setAttribute("procurementOnSanction", procurementOnSanction);
//	  /* ----------------------------------------------------------------------------------------------------------	   */
//	    	req.setAttribute("projectslist", projectslist);
//	    	return "print/ProjectBriefingPaper";
//	    }
//	    catch(Exception e) {	    		
//    		logger.error(new Date() +" Inside ProjectBriefing.htm "+UserId, e);
//    		e.printStackTrace();
//    		return "static/Error";
//	
//    	}		
//	}
	
	}
	
	
	@RequestMapping(value="ProjectBriefingPaper.htm", method = {RequestMethod.GET,RequestMethod.POST})
	public String ProjectBriefingPaper(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)	throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectBriefing.htm "+UserId);		
	    try {
	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	String Logintype= (String)ses.getAttribute("LoginType");
	    	String projectid=req.getParameter("projectid");
	    	String committeeid= req.getParameter("committeeid");
	    	List<Object[]> projectslist =service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	    	if(projectslist.size()==0 && projectid==null) 
	        {				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
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
	    	if(committeeid==null  ) {
	    		committeeid="1";
	    		tempid="1";
	    	}else if( Long.parseLong(committeeid)==0)
	    	{
	    		committeeid="1";
	    	}
	    		    	
	    	
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
	    	
	    	List<Object[]> projectdatadetails  = new ArrayList<Object[]>();
    		
	    	List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
	    	List<List<Object[]>> procurementOnDemandlist  = new ArrayList<List<Object[]>>();
    		List<List<Object[]>> procurementOnSanctionlist = new ArrayList<List<Object[]>>();
	    	
    		List<Object[]> pdffiles =new ArrayList<Object[]>();
    		
    		List<Object[]> TechWorkDataList =new ArrayList<Object[]>();
    		
    		List<List<Object[]>> ProjectRevList =new ArrayList<List<Object[]>>();
    		List<List<TechImages>> TechImages =new ArrayList<List<TechImages>>();
	    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	for(String proid : Pmainlist) 
	    	{	   
	    		TechImages.add(service.getTechList(proid));
	    		projectattributes.add(service.ProjectAttributes(proid));
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
	    		ReviewMeetingList.add(service.ReviewMeetingList(projectid, committeeid));
	    		TechWorkDataList.add(service.TechWorkData(proid)); 
	    		
	    		ProjectRevList.add(service.ProjectRevList(proid));
	    		milestonesubsystemsnew.add(service.BreifingMilestoneDetails(proid));	    		
	    		Object[] prodetails=service.ProjectDataDetails(proid);
	    		projectdatadetails.add(prodetails);
	    		
	   
	    		
	    		String[] pdfs=new String[4];
				if(prodetails!=null && prodetails.length>0)
				{	
				
					if(prodetails[3]!=null) {
						try {
							//config
							if(Files.exists(Paths.get(prodetails[2]+File.separator+prodetails[3]))) {
								pdfs[0] = Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(prodetails[2]+File.separator+prodetails[3])));
							}
						}catch ( FileNotFoundException  e) {
							e.printStackTrace();
							pdfs[0]=null;
						}
					}
					if(prodetails[5]!=null) {
						try {
								//producttree
							if(Files.exists(Paths.get(prodetails[2]+File.separator+prodetails[5]))) {
								pdfs[1]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(prodetails[2]+File.separator+prodetails[5])));
							}
						}catch (FileNotFoundException e) {
							pdfs[1]=null;
						}
					}
					if(prodetails[6]!=null) {
						try {
								//pearlimg
							
							if(Files.exists(Paths.get(prodetails[2]+File.separator+prodetails[6]))) {
								pdfs[2]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(prodetails[2]+File.separator+prodetails[6])));
							}
						
						}catch (FileNotFoundException e) {
							pdfs[2]=null;
						}
					}
					if(prodetails[4]!=null) {
						try {
							//Sysspecs
							
							if(Files.exists(Paths.get(prodetails[2]+File.separator+prodetails[4]))) {
								pdfs[3]=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(prodetails[2]+File.separator+prodetails[4])));
						}
						
							}catch (FileNotFoundException e) {
								e.printStackTrace();
								pdfs[3]=null;
							}
					}
						
				}
				pdffiles.add(pdfs);
				
	    		
	    		
	    		
		/* -------------------------------------------------------------------------------------------------------------- */  		
	    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?projectId="+proid+"&rupess="+10000000;
			 		HttpHeaders headers = new HttpHeaders();
			 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
			    	 
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
    		
    		req.setAttribute("financialDetails",financialDetails);
    		req.setAttribute("procurementOnDemandlist",procurementOnDemandlist);
    		req.setAttribute("procurementOnSanctionlist",procurementOnSanctionlist);
        	
    		req.setAttribute("projectidlist",Pmainlist);
    		req.setAttribute("projectid",projectid);
    		req.setAttribute("committeeid",tempid);
	    	
    		req.setAttribute("pdffiles",pdffiles);
    		req.setAttribute("TechWorkDataList",TechWorkDataList);
    		req.setAttribute("ProjectCost",ProjectCost);
    		
    		req.setAttribute("labInfo", service.LabDetailes());
    		req.setAttribute("milestoneactivitystatus", service.MilestoneActivityStatus());
    		req.setAttribute("milestonedatalevel6", milestonesubsystemsnew);  
    		req.setAttribute("TechImages", TechImages);   
    		req.setAttribute("filePath", env.getProperty("file_upload_path"));
    		
    		String LevelId= "2";
			
			if(service.MileStoneLevelId(projectid,committeeid) != null) {
				LevelId= service.MileStoneLevelId(projectid,committeeid)[0].toString();
			}
			  		
			req.setAttribute("levelid", LevelId);
    		
    		
    		try {
    	        //String ProjectId=req.getParameter("projectid");
    	       
    	        List<Object[] > projlist= service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
    	        
    	        if(projlist.size()==0) 
    	        {				
    				redir.addAttribute("resultfail", "No Project is Assigned to you.");
    				return "redirect:/MainDashBoard.htm";
    			}
    	        
    	        
   	        
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
    					List<Object[]>  MilestoneActivityA=milservice.MilestoneActivityLevel(objmain[0].toString(),"1");
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
    			logger.error(new Date() +" Inside ProjectBriefing.htm (Milestone ActivityLogic) "+UserId, e); 
    			return "static/Error";
    			
    		}
   		
	    	return "print/ProjectBriefingPaperNew";
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectBriefing.htm "+UserId, e);
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
	
	@PostMapping(value = "ProjectBriefingFreeze.htm")
	public String freezeBriefingPaper(HttpServletRequest req, HttpServletResponse res, HttpSession ses,RedirectAttributes redir)throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectBriefingFreeze.htm "+UserId);		
	    try {
	    	String projectid=req.getParameter("projectid");
	    	String committeeid= req.getParameter("committeeid");
	    	String tempid=committeeid;
	        long nextScheduleId=service.getNextScheduleId(projectid, committeeid);
	    	if(nextScheduleId>0) {
	    		if(service.getNextScheduleFrozen(nextScheduleId).equalsIgnoreCase("N")) {
	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	String Logintype= (String)ses.getAttribute("LoginType");
	    	
	    	List<Object[]> projectslist =service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	    	    	
	    	
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
	    	List<Object[]> projectdatadetails  = new ArrayList<Object[]>();
	    	List<Object[]> TechWorkDataList =new ArrayList<Object[]>();
	    	
	    	
	    	List<List<Object[]>> ProjectRevList =new ArrayList<List<Object[]>>();
	    	
	    	
	    	List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
	    	List<List<Object[]>> procurementOnDemandlist  = new ArrayList<List<Object[]>>();
    		List<List<Object[]>> procurementOnSanctionlist = new ArrayList<List<Object[]>>();
	    	
	    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	for(String proid : Pmainlist) 
	    	{	    	
	    		projectattributes.add(service.ProjectAttributes(proid));
	    		ebandpmrccount.add(service.EBAndPMRCCount(proid));
	    		milestonesubsystems.add(service.MilestoneSubsystems(proid));
	    		milestones.add(service.Milestones(proid));
	    		lastpmrcactions.add(service.LastPMRCActions(proid,committeeid));
	    		lastpmrcminsactlist.add(service.LastPMRCActions1(proid,committeeid));
	    		Object[] prodetails=service.ProjectDetails(proid).get(0);
	    		ProjectDetails.add(prodetails);
	    		ganttchartlist.add(service.GanttChartList(proid));
	    		oldpmrcissueslist.add(service.OldPMRCIssuesList(proid));
	    		riskmatirxdata.add(service.RiskMatirxData(proid));
	    		lastpmrcdecisions.add(service.LastPMRCDecisions(committeeid,proid));
	    		actionplanthreemonths.add(service.ActionPlanSixMonths(proid,committeeid));
	    		projectdatadetails.add(service.ProjectDataDetails(proid));
	    		ReviewMeetingList.add(service.ReviewMeetingList(projectid, committeeid));
	    		TechWorkDataList.add(service.TechWorkData(proid));
	    		
	    		ProjectRevList.add(service.ProjectRevList(proid));
	    		
	    		
	    	
		/* ----------------------------------------------------------------------------------------------------------	   */  		
	    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?projectId="+proid+"&rupess="+10000000;
			 		HttpHeaders headers = new HttpHeaders();
			 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
			    	 
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
	    	req.setAttribute("projectslist", projectslist);
	    	
	    	
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
	    	req.setAttribute("labInfo", service.LabDetailes());
	    	req.setAttribute("lablogo", Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(req.getServletContext().getRealPath("view/images/drdologo.png")))));    

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
	    	PdfDocument pdfDoc = new PdfDocument(new PdfWriter(path+"/"+filename+"_P"+projectid+"_C"+committeeid+"_S"+nextScheduleId+".pdf"));	
	    	pdfDoc.setTagged();
	    	Document document = new Document(pdfDoc, PageSize.A4);
	    	//document.setMargins(50, 100, 150, 50);
	    	document.setMargins(50, 50, 50, 50);
	    	ConverterProperties converterProperties = new ConverterProperties();
	    	FontProvider dfp = new DefaultFontProvider(true, true, true);
	    	converterProperties.setFontProvider(dfp);
	        HtmlConverter.convertToPdf(fis1,pdfDoc,converterProperties);   
	        Files.move(Paths.get(path+"/"+filename+"_P"+projectid+"_C"+committeeid+"_S"+nextScheduleId+".pdf"),Paths.get(env.getProperty("file_upload_path")+"\\Frozen\\"+filename+"_P"+projectid+"_C"+committeeid+"_S"+nextScheduleId+".pdf"), StandardCopyOption.REPLACE_EXISTING);
	        int update=service.updateBriefingPaperFrozen(nextScheduleId);
	        redir.addAttribute("result", "Briefing Paper Frozen for Next Scheduled Meeting.");
	    		}else {
	    			redir.addAttribute("resultfail", "Briefing Paper Already Frozen for Next Scheduled Meeting.");
	    		}
	    	}else {
	    		redir.addAttribute("resultfail", "No  Meeting scheduled.");
	    	}
	        
	    }
	    catch(Exception e) {	    		
    		logger.error(new Date() +" Inside ProjectBriefingFreeze.htm "+UserId, e);
    		e.printStackTrace();
			/* return "static/Error"; */
	
    	}		
		return "redirect:/ProjectBriefingPaper.htm";
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
				System.out.println(initiationsanid);
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
		logger.info(new Date() +"Inside PdcExtention.htm "+UserId);	
		try {
			List<Object[]> projectinitiationlist = (List<Object[]>)service.GetProjectInitiationSanList();
			req.setAttribute("projectslist", projectinitiationlist);
			
		} catch (Exception e) {
			logger.error(new Date() +" Inside PdcExtention.htm "+UserId, e);
    		e.printStackTrace();
		}
		return "print/ReallocationFunds";
	}
	
	public void freezeBriefingPaperAfterKickoff(HttpServletRequest req, HttpServletResponse res, HttpSession ses,RedirectAttributes redir)throws Exception{
		String UserId = (String) ses.getAttribute("Username");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectBriefingFreeze.htm "+UserId);		
	    try {
	    	String projectid=req.getParameter("projectid");
	    	String committeeid= req.getParameter("committeeid");
	    	String tempid=committeeid;
	        long nextScheduleId=Long.parseLong(req.getParameter("committeescheduleid"));
	    	if(nextScheduleId>0) {
	    		if(service.getNextScheduleFrozen(nextScheduleId).equalsIgnoreCase("N")) {
	    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
	    	String Logintype= (String)ses.getAttribute("LoginType");
	    	
	    	List<Object[]> projectslist =service.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	    	    	
	    	
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
	    	List<Object[]> projectdatadetails  = new ArrayList<Object[]>();
	    	List<Object[]> TechWorkDataList =new ArrayList<Object[]>();
	    	
	    	
	    	List<List<Object[]>> ProjectRevList =new ArrayList<List<Object[]>>();
	    	List<List<Object[]>> milestonesubsystemsnew = new ArrayList<List<Object[]>>();
	    	
	    	List<List<ProjectFinancialDetails>> financialDetails=new ArrayList<List<ProjectFinancialDetails>>();
	    	List<List<Object[]>> procurementOnDemandlist  = new ArrayList<List<Object[]>>();
    		List<List<Object[]>> procurementOnSanctionlist = new ArrayList<List<Object[]>>();
	    	
	    	List<String> Pmainlist = service.ProjectsubProjectIdList(projectid);
	    	for(String proid : Pmainlist) 
	    	{	    	
	    		projectattributes.add(service.ProjectAttributes(proid));
	    		ebandpmrccount.add(service.EBAndPMRCCount(proid));
	    		milestonesubsystems.add(service.MilestoneSubsystems(proid));
	    		milestones.add(service.Milestones(proid));
	    		lastpmrcactions.add(service.LastPMRCActions(proid,committeeid));
	    		lastpmrcminsactlist.add(service.LastPMRCActions1(proid,committeeid));
	    		Object[] prodetails=service.ProjectDetails(proid).get(0);
	    		ProjectDetails.add(prodetails);
	    		ganttchartlist.add(service.GanttChartList(proid));
	    		oldpmrcissueslist.add(service.OldPMRCIssuesList(proid));
	    		riskmatirxdata.add(service.RiskMatirxData(proid));
	    		lastpmrcdecisions.add(service.LastPMRCDecisions(committeeid,proid));
	    		actionplanthreemonths.add(service.ActionPlanSixMonths(proid,committeeid));
	    		projectdatadetails.add(service.ProjectDataDetails(proid));
	    		ReviewMeetingList.add(service.ReviewMeetingList(projectid, committeeid));
	    		TechWorkDataList.add(service.TechWorkData(proid));
	    		milestonesubsystemsnew.add(service.BreifingMilestoneDetails(proid));
	    		ProjectRevList.add(service.ProjectRevList(proid));
	    		
	    		
	    	
		/* ----------------------------------------------------------------------------------------------------------	   */  		
	    		 final String localUri=uri+"/pfms_serv/financialStatusBriefing?projectId="+proid+"&rupess="+10000000;
			 		HttpHeaders headers = new HttpHeaders();
			 		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
			    	 
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
	    	req.setAttribute("projectslist", projectslist);
	    	
	    	
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
	    	req.setAttribute("labInfo", service.LabDetailes());
	    	req.setAttribute("lablogo", Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(req.getServletContext().getRealPath("view/images/drdologo.png")))));    
	    	req.setAttribute("milestonedatalevel6", milestonesubsystemsnew);
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
	    	PdfDocument pdfDoc = new PdfDocument(new PdfWriter(path+"/"+filename+"_P"+projectid+"_C"+committeeid+"_S"+nextScheduleId+".pdf"));	
	    	pdfDoc.setTagged();
	    	Document document = new Document(pdfDoc, PageSize.A4);
	    	//document.setMargins(50, 100, 150, 50);
	    	document.setMargins(50, 50, 50, 50);
	    	ConverterProperties converterProperties = new ConverterProperties();
	    	FontProvider dfp = new DefaultFontProvider(true, true, true);
	    	converterProperties.setFontProvider(dfp);
	        HtmlConverter.convertToPdf(fis1,pdfDoc,converterProperties);   
	        Files.move(Paths.get(path+"/"+filename+"_P"+projectid+"_C"+committeeid+"_S"+nextScheduleId+".pdf"),Paths.get(env.getProperty("file_upload_path")+"\\Frozen\\"+filename+"_P"+projectid+"_C"+committeeid+"_S"+nextScheduleId+".pdf"), StandardCopyOption.REPLACE_EXISTING);
	        int update=service.updateBriefingPaperFrozen(nextScheduleId);
	        redir.addAttribute("result", "Briefing Paper Frozen for  This Meeting.");
	    		}else {
	    			redir.addAttribute("resultfail", "Briefing Paper Already Frozen for  This Meeting.");
	    		}
	    	}else {
	    		redir.addAttribute("resultfail", "No  Meeting scheduled.");
	    	}
	        
	    }
	    catch(Exception e) {	
	    	redir.addAttribute("resultfail", "Briefing Paper Not Frozen for  This Meeting.");
    		logger.error(new Date() +" Inside ProjectBriefingFreeze.htm "+UserId, e);
    		e.printStackTrace();
			/* return "static/Error"; */
	
    	}		
		
	}
	
	@RequestMapping(value = "MilestoneActivityChange.htm", method = RequestMethod.GET)
	public @ResponseBody String MilestoneActivityChange(HttpServletRequest req, HttpServletResponse response, HttpSession ses) throws Exception 
	{
				
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
	    public String GanttChartUpload(@RequestParam("FileAttach") MultipartFile file,HttpServletRequest req,RedirectAttributes redir) {
	        try {
            int result=service.saveGranttChart(file,req.getParameter("ChartName"),env.getProperty("file_upload_path"));
            if(result>0) {  
              redir.addAttribute("result", "Grantt Chart Saved");
    		}else {
    			redir.addAttribute("resultfail", "Grantt Chart Not Saved");
    		}

	        } catch (Exception e) {

	        }
	        redir.addFlashAttribute("projectid", req.getParameter("ProjectId"));
			redir.addFlashAttribute("committeeid", req.getParameter("committeeid"));
	        return "redirect:/ProjectBriefingPaper.htm";
	    }
	  
	  
		
	    @PostMapping("/ProjectTechImages.htm") 
	    public String ProjectTechImages(@RequestParam("FileAttach") MultipartFile file,HttpServletRequest req,RedirectAttributes redir) {
	        try {
            int result=service.saveTechImages(file,req.getParameter("ProjectId"),env.getProperty("file_upload_path"),req.getUserPrincipal().getName());
            if(result>0) {  
              redir.addAttribute("result", "Tech Image Saved");
    		}else {
    			redir.addAttribute("resultfail", "Tech Image Not Saved");
    		}

	        } catch (Exception e) {

	        }
	        redir.addFlashAttribute("projectid", req.getParameter("ProjectId"));
			redir.addFlashAttribute("committeeid", req.getParameter("committeeid"));
	        return "redirect:/ProjectBriefingPaper.htm";
	    }
}
