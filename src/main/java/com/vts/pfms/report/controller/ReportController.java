package com.vts.pfms.report.controller;

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.util.Units;
import org.apache.poi.xwpf.usermodel.BreakType;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.UnderlinePatterns;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTbl;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblWidth;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTc;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTcPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTblWidth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gargoylesoftware.htmlunit.javascript.host.Element;
import com.itextpdf.io.source.ByteArrayOutputStream;
import com.itextpdf.styledxmlparser.jsoup.Jsoup;
import com.itextpdf.styledxmlparser.jsoup.nodes.Document;
import com.itextpdf.styledxmlparser.jsoup.select.Elements;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.print.model.ProjectTechnicalWorkData;
import com.vts.pfms.print.service.PrintService;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.report.model.LabReport;
import com.vts.pfms.report.service.ReportService;
import com.vts.pfms.report.service.ReportServiceImpl;
import com.vts.pfms.utils.PMSLogoUtil;

@Controller
public class ReportController {
private static final Logger logger = LogManager.getLogger(ReportController.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
	
	@Autowired
	ReportService service;
	
	@Autowired
	ProjectService prjservice;
	
	@Autowired
	PrintService printservice;
	
	@Autowired
	RestTemplate restTemplate;
	
	@Value("${server_uri}")
    private String uri;
	
	@Value("${ApplicationFilesDrive}")
	private String LabLogoPath;
	
	@Autowired
	Environment env;
	
	@Autowired
	PMSLogoUtil LogoUtil;
	
	
	@RequestMapping(value="LabReports.htm",method= {RequestMethod.GET,RequestMethod.POST})
    public String LabReports(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception  {
	   
		String Logintype = (String) ses.getAttribute("LoginType");
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode = (String) ses.getAttribute("labcode");
		logger.info(new Date() + "Inside LabReports.htm " + UserId);
		try {
		List<Object[]> proList = prjservice.LoginProjectDetailsList(EmpId, Logintype, LabCode);
         req.setAttribute("proList", proList);
	    String projectid=req.getParameter("projectid");
	    
	    if(projectid==null || projectid.equals("null"))
		{
			projectid=proList.get(0)[0].toString();
		}
	
  	req.setAttribute("ProjectId", projectid);
 
   req.setAttribute("ProjectAssignList", prjservice.ProjectAssignList(projectid));

  	Object[] projectattribute = service.prjDetails(projectid);//this is for the project basic details
  	req.setAttribute("ProjectEditData", projectattribute);
  	
  	//data of editor
	Object[] editorData = service.editorData(projectid);
	req.setAttribute("editorData", editorData);
	
	int currentYear = LocalDate.now().getYear();
    System.out.println("Current Year: " + currentYear);
    
    //milestone data
    List<Object[]>milestoneData=service.mileStoneData(currentYear,projectid);
    req.setAttribute("milestoneData", milestoneData);
    
    req.setAttribute("currentYear", currentYear);
    req.setAttribute("nextYear", (currentYear+1));
    req.setAttribute("filePath", env.getProperty("ApplicationFilesDrive"));
    String projectLabCode = printservice.ProjectDetails(projectid).get(0)[5].toString();
    req.setAttribute("projectLabCode", projectLabCode);

		}catch (Exception e) {
			e.printStackTrace();
		} 
	    
	    
		return "reports/LabReport";
	}

	// LabReportDataAdd.htm
	@RequestMapping(value = "LabReportDataAdd.htm", method= {RequestMethod.GET,RequestMethod.POST} )
	public String LabReportDataAdd(HttpServletRequest req, HttpSession ses,HttpServletResponse res, RedirectAttributes redir)throws Exception
	{	
	String userName = (String) ses.getAttribute("Username");
	
	String labcode = (String)ses.getAttribute("labcode");
	String Logintype= (String)ses.getAttribute("LoginType");
	String EmpId = ((Long)ses.getAttribute("EmpId")).toString();
	logger.info(new Date() +"Inside TechnicalWorkDataAdd.htm "+userName);
	try
		{
		String CurrentYrAchievement=req.getParameter("CurrentYrAchievement");
		String SpinOffData=req.getParameter("SpinOffData");
		String NominatedDetails=req.getParameter("NominatedDetails");
		String projectId=req.getParameter("projectId");
		
		long result=0;
		
		//count the prj in the table
		List<Object[]> count=service.countPrjEntries(Long.parseLong(projectId));
		
		if(count!=null &&count.size()>0) {
		      
		      LabReport labReportDetails=service.getLabReportDetails(count.get(0)[0].toString());
		      
		    if (CurrentYrAchievement != null) {
		    	labReportDetails.setCurrentYrAchievement(CurrentYrAchievement);
		    }
		    if (SpinOffData != null) {
		    	labReportDetails.setSpinOffData(SpinOffData);
		    }
		    if (NominatedDetails != null) {
		    	labReportDetails.setDetailsofNomination(NominatedDetails);
		    }

		    labReportDetails.setModifiedBy(userName);  // Assuming you have an updatedBy field
		   
		    labReportDetails.setModifiedDate(sdtf.format(new Date()));
		    result = service.updateData(labReportDetails);  // Update the existing row	
		}else {
			    LabReport lr=new LabReport();
			    
			    if(CurrentYrAchievement!=null) {
				lr.setCurrentYrAchievement(CurrentYrAchievement);}
			    if(SpinOffData!=null) {
				lr.setSpinOffData(SpinOffData);}
			    if(NominatedDetails!=null) {
				lr.setDetailsofNomination(NominatedDetails);}
				
				lr.setProjectId(Long.parseLong(projectId));
				lr.setCreatedBy(userName);
				lr.setCreatedDate(sdtf.format(new Date()));
				result=service.addData(lr);
}
		if(result!=0) {
			redir.addAttribute("result", req.getParameter("Action")+"added Successfully");
		}else {
			redir.addAttribute("resultfail", req.getParameter("Action")+" UnSuccessful");
		}
		
		redir.addAttribute("projectid", projectId);
		return "redirect:/LabReports.htm";
		}catch (Exception e) {
			e.printStackTrace();
			return "" ;
		}
	}
	@RequestMapping(value = "LabReportDownload.htm", method = {RequestMethod.GET, RequestMethod.POST})
    public ResponseEntity<byte[]> LabReportDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {

        String Logintype = (String) ses.getAttribute("LoginType");
        String UserId = (String) ses.getAttribute("Username");
        String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
        String LabCode = (String) ses.getAttribute("labcode");

      
        List<Object[]> proList = prjservice.LoginProjectDetailsList(EmpId, Logintype, LabCode);
        req.setAttribute("proList", proList);
       // String projectid = req.getParameter("projectid");
        String projectIdsParam = req.getParameter("projectid");
        String[] projectIds = null;

        if (projectIdsParam != null && !projectIdsParam.isEmpty()) {
            projectIds = projectIdsParam.split(",");
        } else {
            // Handle the case where no projects were selected
            throw new Exception("No projects selected.");
        }
        
        

        if (projectIdsParam == null || projectIdsParam.equals("null")) {
        	projectIdsParam = proList.get(0)[0].toString();
        }
        
       

        req.setAttribute("ProjectId", projectIdsParam);
        req.setAttribute("ProjectAssignList", prjservice.ProjectAssignList(projectIdsParam));
   
//        req.setAttribute("milestoneData", milestoneData);
//        req.setAttribute("currentYear", currentYear);
//        req.setAttribute("nextYear", (currentYear + 1));
     

        XWPFDocument document = new XWPFDocument();
//        for (String projectId : projectIds) {
        for (int i = 0; i < projectIds.length; i++) {
            String projectId = projectIds[i];
        	
            Object[] projectattribute = service.prjDetails(projectId); 
            
            Object[] editorData = service.editorData(projectId); 
          
            int currentYear = LocalDate.now().getYear();
            List<Object[]> milestoneData = service.mileStoneData(currentYear, projectId);
     
        XWPFParagraph projectName = document.createParagraph();

        
        XWPFRun projectNameHeadingRun = projectName.createRun();
        projectNameHeadingRun.setText("Project Name:");
        projectNameHeadingRun.setBold(true);
        projectNameHeadingRun.setColor("0000FF");  
        projectNameHeadingRun.setFontSize(12);

        
        XWPFRun projectNameValueRun = projectName.createRun();
        String projectNames = projectattribute[2] != null && !projectattribute[2].toString().trim().isEmpty() 
            ? projectattribute[2].toString() 
            : "-";
        projectNameValueRun.setText(" " + projectNames); 
        projectNameValueRun.setBold(false);
        projectNameValueRun.setFontSize(12);
        projectNameValueRun.addBreak();
   if(projectattribute[18]!=null) {
     Path imgfile = Paths.get(env.getProperty("ApplicationFilesDrive"),LabCode, "ProjectSlide", projectattribute[18].toString());
  // Insert the image
     try (InputStream imageStream = Files.newInputStream(imgfile)) {
     	projectNameValueRun.addBreak(); // Add a line break before the image
     	projectNameValueRun.addPicture(imageStream, XWPFDocument.PICTURE_TYPE_PNG, imgfile.getFileName().toString(), Units.toEMU(200), Units.toEMU(200)); // width and height in EMU
     } catch (InvalidFormatException | IOException e) {
         e.printStackTrace(); // Handle the exception accordingly
     }
     }else {
    	   Path imgfile = Paths.get(env.getProperty("ApplicationFilesDrive"),LabCode, "ProjectSlide", "-");
    	// Insert the image
           try (InputStream imageStream = Files.newInputStream(imgfile)) {
           	projectNameValueRun.addBreak(); // Add a line break before the image
           	projectNameValueRun.addPicture(imageStream, XWPFDocument.PICTURE_TYPE_PNG, imgfile.getFileName().toString(), Units.toEMU(200), Units.toEMU(200)); // width and height in EMU
           } catch (InvalidFormatException | IOException e) {
               e.printStackTrace(); // Handle the exception accordingly
           }
     }
//        XWPFParagraph projectNameParagraph = document.createParagraph();
//        XWPFRun projectNameRun = projectNameParagraph.createRun();
//        projectNameRun.setBold(true);
//        projectNameRun.setFontSize(12);
//        projectNameRun.addBreak();

        // Insert the image
//        try (InputStream imageStream = Files.newInputStream(imgfile)) {
//        	projectNameValueRun.addBreak(); // Add a line break before the image
//        	projectNameValueRun.addPicture(imageStream, XWPFDocument.PICTURE_TYPE_PNG, imgfile.getFileName().toString(), Units.toEMU(200), Units.toEMU(200)); // width and height in EMU
//        } catch (InvalidFormatException | IOException e) {
//            e.printStackTrace(); // Handle the exception accordingly
//        }
        projectNameValueRun.addBreak();
        
        XWPFRun BriefValueRun = projectName.createRun();
        String Brief = projectattribute[17] != null && !projectattribute[17].toString().trim().isEmpty() ? projectattribute[17].toString().replaceAll("<[^>]*>", "").trim() : "-";
        BriefValueRun.setText(Brief);  
        BriefValueRun.setBold(false);
        BriefValueRun.setFontSize(12);
     
        
        
     XWPFParagraph categorys = document.createParagraph();

        
        XWPFRun categoryHeadingRun = categorys.createRun();
        categoryHeadingRun.setText("Category:");
        categoryHeadingRun.setBold(true);
        categoryHeadingRun.setColor("0000FF");  
        categoryHeadingRun.setFontSize(12);

        
        XWPFRun categoryValueRun = categorys.createRun();
        String category = projectattribute[19] != null && !projectattribute[19].toString().trim().isEmpty() 
            ? projectattribute[19].toString() 
            : "-";
        categoryValueRun.setText(" " + category); 
        categoryValueRun.setBold(false);
        categoryValueRun.setFontSize(12);
        
        //project cost
  XWPFParagraph cost = document.createParagraph();

        
        XWPFRun costHeadingRun = cost.createRun();
        costHeadingRun.setText("Project Cost:");
        costHeadingRun.setBold(true);
        costHeadingRun.setColor("0000FF");  
        costHeadingRun.setFontSize(12);

        
        XWPFRun costValueRun = cost.createRun();
        String PrjCost = projectattribute[6] != null && !projectattribute[6].toString().trim().isEmpty() 
            ? projectattribute[6].toString() 
            : "-";
        costValueRun.setText(" " + PrjCost+"(in Lakhs)"); 
        costValueRun.setBold(false);
        costValueRun.setFontSize(12);
        
       //participating lab 
  XWPFParagraph participatinglab = document.createParagraph();

        
        XWPFRun participatinglabHeadingRun = participatinglab.createRun();
        participatinglabHeadingRun.setText("Participating Lab:");
        participatinglabHeadingRun.setBold(true);
        participatinglabHeadingRun.setColor("0000FF");  
        participatinglabHeadingRun.setFontSize(12);

        
        XWPFRun labValueRun = participatinglab.createRun();
        String labparticipation = projectattribute[10] != null && !projectattribute[10].toString().trim().isEmpty() 
            ? projectattribute[10].toString() 
            : "-";
        labValueRun.setText(" " + labparticipation); 
        labValueRun.setBold(false);
        labValueRun.setFontSize(12);
        
        
        
        
        
        //scope
    XWPFParagraph scope = document.createParagraph();

        
        XWPFRun Prjscopes = scope.createRun();
        Prjscopes.setText("Scope:");
        Prjscopes.setBold(true);
        Prjscopes.setColor("0000FF");  
        Prjscopes.setFontSize(12);

        
        XWPFRun ScopeValueRun = scope.createRun();
        String Scope = projectattribute[11] != null && !projectattribute[11].toString().trim().isEmpty() 
            ? projectattribute[11].toString() 
            : "-";
        ScopeValueRun.setText(" " + Scope); 
        ScopeValueRun.setBold(false);
        ScopeValueRun.setFontSize(12);
        
        //objective
 XWPFParagraph objective = document.createParagraph();

        
        XWPFRun objectives = objective.createRun();
        objectives.setText("Objective:");
        objectives.setBold(true);
        objectives.setColor("0000FF");  
        objectives.setFontSize(12);

        
        XWPFRun objectivesValueRun = objective.createRun();
        String prjobjective = projectattribute[9] != null && !projectattribute[9].toString().trim().isEmpty() 
            ? projectattribute[9].toString() 
            : "-";
        objectivesValueRun.setText(" " + prjobjective); 
        objectivesValueRun.setBold(false);
        objectivesValueRun.setFontSize(12);
        
        
        //details of review held
XWPFParagraph reviewHeld = document.createParagraph();

        
        XWPFRun reviewHelds = reviewHeld.createRun();
        reviewHelds.setText("Details of Review till "+(currentYear - 1)+":");
        reviewHelds.setBold(true);
        reviewHelds.setColor("0000FF");  
        reviewHelds.setFontSize(12);

        
        XWPFRun reviewHeldsValueRun = reviewHeld.createRun();
        String reviewHeldValuePMRC = projectattribute[15] != null && !projectattribute[15].toString().trim().isEmpty() 
            ? projectattribute[15].toString() 
            : "-";
        
       String reviewHeldValueEB=projectattribute[16] != null && !projectattribute[16].toString().trim().isEmpty() 
               ? projectattribute[16].toString() 
                       : "-";
       reviewHeldsValueRun.setText(" " + "EB:"+reviewHeldValueEB+" "+"PMRC:"+reviewHeldValuePMRC); 
       reviewHeldsValueRun.setBold(false);
       reviewHeldsValueRun.setFontSize(12);
        
   
        
        
        
        
        
        
        
        
        
        
        
//        String[] headings = {
//            "Project Name", 
//            "Brief",
//            "Category", 
//            "Participating Lab", 
//            "Scope", 
//            "Objective", 
//            "Details of Review held till YR",
//            "Total Cost"
//        };
//
//       // String Brief =(projectattribute[17] != null && !projectattribute[17].toString().trim().isEmpty()) ? projectattribute[17].toString().replaceAll("<[^>]*>", "").trim() : "-";
//        
//        String[] data = {
//            (projectattribute[2] != null && !projectattribute[2].toString().trim().isEmpty()) ? projectattribute[2].toString() : "-", // Project Name
//            (Brief),
//            (projectattribute[19] != null && !projectattribute[19].toString().trim().isEmpty()) ? projectattribute[19].toString() : "-", // Category
//            (projectattribute[10] != null && !projectattribute[10].toString().trim().isEmpty()) ? projectattribute[10].toString() : "-", // Participating Lab
//            (projectattribute[11] != null && !projectattribute[11].toString().trim().isEmpty()) ? projectattribute[11].toString() : "-", // Scope
//            (projectattribute[9] != null && !projectattribute[9].toString().trim().isEmpty()) ? projectattribute[9].toString() : "-", // Objective
//            (projectattribute[16] != null && projectattribute[15] != null && !projectattribute[16].toString().trim().isEmpty() && !projectattribute[15].toString().trim().isEmpty()) 
//                ? "EB: " + projectattribute[16].toString() + "\nPMRC: " + projectattribute[15].toString() : "-", // Details of Review
//            (projectattribute[6] != null && !projectattribute[6].toString().trim().isEmpty()) ? projectattribute[6].toString() + " (in Lakhs)" : "-" // Total Cost
//        };
//
//        // Add the project headings and data
//        for (int i = 0; i < headings.length; i++) {
//            XWPFParagraph headingParagraph = document.createParagraph();
//            XWPFRun headingRunInner = headingParagraph.createRun();
//            headingRunInner.setText(headings[i]);
//            headingRunInner.setBold(true);
//            headingRunInner.setFontSize(12);
//            headingRunInner.addBreak();
//
//            XWPFParagraph dataParagraph = document.createParagraph();
//            XWPFRun dataRun = dataParagraph.createRun();
//            dataRun.setText(data[i]);
//            dataRun.addBreak();
//        }

 

    
        XWPFParagraph mileParagraph = document.createParagraph();
        XWPFRun mileParagraphs = mileParagraph.createRun();
        mileParagraphs.setText("Major Achievements / activities completed during this year");
        mileParagraphs.setBold(true);
        mileParagraphs.setFontSize(12);
        mileParagraphs.setColor("0000FF");  
       
     
        int count=0;
        if(milestoneData!=null && milestoneData.size()>0) {
        for (Object[] activity : milestoneData) {
        	
        	 
        	if(activity[6]!=null && activity[6].toString().equalsIgnoreCase(currentYear+"")) {
                XWPFParagraph mileParagraph1 = document.createParagraph();
            XWPFRun mileParagraphs1 = mileParagraph1.createRun();
            mileParagraphs1.setText((++count)+". "+activity[1].toString());
            
           
            mileParagraphs1.addBreak();
        	}
        }
        }
        
        XWPFParagraph mileParagraph2 = document.createParagraph();
        XWPFRun mileParagraphs2 = mileParagraph2.createRun();
        mileParagraphs2.setText("Planned Activities in the Project for Next year");
        mileParagraphs2.setBold(true);
        mileParagraphs2.setFontSize(12);
        mileParagraphs2.setColor("0000FF");
       
     
        
        int count1=0;
        if(milestoneData!=null && milestoneData.size()>0) {
        for (Object[] activity : milestoneData) {
        	
     	  
     	if(activity[7].toString().equalsIgnoreCase((currentYear+1)+"")||activity[8].toString().equalsIgnoreCase((currentYear+1)+"")) {
           XWPFParagraph mileParagraph1 = document.createParagraph();
         XWPFRun mileParagraphs1 = mileParagraph1.createRun();
         mileParagraphs1.setText((++count1)+". "+activity[1].toString());
   
        
         mileParagraphs1.addBreak();
     	}
        }
     }
        //spinoff data------------------------------------------------------------------------------------
        XWPFParagraph spinoff = document.createParagraph();
        XWPFRun attributesRun2 = spinoff.createRun();
        attributesRun2.setText("Likely Spin-Off including application for Civil use (if any)");
        attributesRun2.setBold(true); // Set the subheading text to bold
        attributesRun2.setColor("0000FF");// Set the text color to blue (hexadecimal color code)
        attributesRun2.setFontSize(14);
        //attributesRun.setUnderline(UnderlinePatterns.SINGLE); // Set the underline style
        attributesRun2.addBreak(); // Add a line break after the subheading
        
        
        XWPFRun spinoffDataRun = spinoff.createRun();
        String spinoffData = (editorData!=null&&editorData[2] != null && !editorData[2].toString().trim().isEmpty()) 
            ? editorData[2].toString().replaceAll("<[^>]*>", "").trim() // Inline regex to strip HTML tags
            : "-";
        spinoffDataRun.setText(spinoffData); 
        spinoffDataRun.addBreak(); // Add a line break after the project name

        XWPFParagraph details = document.createParagraph();
        XWPFRun attributesRun3 = details.createRun();
        attributesRun3.setText("Details of LSI/DCPP/PA (If Nominated)");
        attributesRun3.setBold(true); // Set the subheading text to bold
        attributesRun3.setColor("0000FF");// Set the text color to blue (hexadecimal color code)
        attributesRun3.setFontSize(14);
        //attributesRun.setUnderline(UnderlinePatterns.SINGLE); // Set the underline style
        attributesRun3.addBreak(); // Add a line break after the subheading
        


        // Check if the editorData contains table data in HTML format
           if (editorData != null && editorData[3] != null && !editorData[3].toString().trim().isEmpty()) {
               String htmlContent = editorData[3].toString();
               
               // Parse the HTML content using JSoup
               Document htmlDoc = Jsoup.parse(htmlContent);
               Elements tables = htmlDoc.select("table"); // Get all tables from HTML

               if (!tables.isEmpty()) {
                   // If the content has an HTML table, convert it to a Word table
                   for (com.itextpdf.styledxmlparser.jsoup.nodes.Element table1 : tables) {
                       Elements rows = table1.select("tr"); // Get all rows from the HTML table
                       XWPFTable wordTable = document.createTable(rows.size(), rows.get(0).select("td").size()); // Create Word table

                       

                       // Set table width to 80%
                       CTTbl ctTbl = wordTable.getCTTbl(); // Get the underlying XML structure
                       CTTblPr tblPr = ctTbl.getTblPr(); // Get the table properties
                       if (tblPr == null) {
                           tblPr = ctTbl.addNewTblPr(); // Add new table properties if not already present
                       }
                       CTTblWidth tblWidth = tblPr.addNewTblW();
                       tblWidth.setW(BigInteger.valueOf(8000)); // 80% width in twips (twentieths of a point)
                       tblWidth.setType(STTblWidth.PCT); // Set width as percentage
                       
                       int rowIdx = 0;
                       for (com.itextpdf.styledxmlparser.jsoup.nodes.Element row : rows) {
                           Elements cells = row.select("td"); // Get all cells from the HTML row
                           XWPFTableRow wordRow = wordTable.getRow(rowIdx);

                           for (int cellIdx = 0; cellIdx < cells.size(); cellIdx++) {
                               String cellText = cells.get(cellIdx).text(); // Get text from the HTML cell
                               if (wordRow.getCell(cellIdx) != null) {
                                   wordRow.getCell(cellIdx).setText(cellText); // Set text in Word cell
                               } else {
                                   wordRow.addNewTableCell().setText(cellText); // Add new cell if necessary
                               }
                           }
                           rowIdx++;
                       }
                   }
               } else {
                   // If there's no table, treat it as plain text
                   XWPFRun detailsDataRun = details.createRun();
                   String detailsData = htmlContent.replaceAll("<[^>]*>", "").trim(); // Strip unwanted characters
                   detailsDataRun.setText(detailsData);
                   detailsDataRun.addBreak();
               }
           } else {
               // Handle case where there's no data
               XWPFRun detailsDataRun = details.createRun();
               detailsDataRun.setText("-");
               detailsDataRun.addBreak();
           }
           
           
//           XWPFParagraph curstage = document.createParagraph();
//           XWPFRun attributesRun4 = curstage.createRun();
//           attributesRun4.setText("Current Stage");
//           attributesRun4.setBold(true); // Set the subheading text to bold
//           attributesRun4.setColor("0000FF");// Set the text color to blue (hexadecimal color code)
//           attributesRun4.setFontSize(14);
//           
//           attributesRun4.addBreak(); 
//           XWPFParagraph mileParagraph1 = document.createParagraph();
//           XWPFRun mileParagraphs1 = mileParagraph1.createRun();
//           mileParagraphs1.setText(projectattribute[14]!=null ?projectattribute[14].toString():"");
//    
//           
//        // Output the document to a byte array
//        ByteArrayOutputStream out = new ByteArrayOutputStream();
//        document.write(out);
//        document.close();
           
           XWPFParagraph current = document.createParagraph();

           
      
           
           XWPFRun currentStage = current.createRun();
           currentStage.setText("Project Current Stage:");
           currentStage.setBold(true);
           currentStage.setColor("0000FF");  
           currentStage.setFontSize(12);

           
           XWPFRun currentStageValueRun = current.createRun();
           String currentStages = projectattribute[14] != null && !projectattribute[14].toString().trim().isEmpty() 
               ? projectattribute[14].toString() 
               : "-";
           currentStageValueRun.setText(" " + currentStages); 
           currentStageValueRun.setBold(false);
           currentStageValueRun.setFontSize(12);
           
           
           
           if (i < projectIds.length - 1) {
               XWPFParagraph pageBreakParagraph = document.createParagraph();
               XWPFRun pageBreakRun = pageBreakParagraph.createRun();
               pageBreakRun.addBreak(BreakType.PAGE);
           }
        } 
           ByteArrayOutputStream out = new ByteArrayOutputStream();
         document.write(out);
        document.close();
        
        
        // Prepare headers for the response
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "LabReport.docx");

        // Return the generated document as a response
        return ResponseEntity.ok()
                .headers(headers)
                .body(out.toByteArray());
    }

    

}
