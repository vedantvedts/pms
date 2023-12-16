package com.vts.pfms.download.controller;

import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.hssf.record.PageBreakRecord.Break;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.util.Units;
import org.apache.poi.wp.usermodel.HeaderFooterType;
import org.apache.poi.xwpf.usermodel.IBodyElement;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.UnderlinePatterns;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFFooter;
import org.apache.poi.xwpf.usermodel.XWPFHeader;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblGrid;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblGridCol;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTblWidth;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTcPr;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.CTVMerge;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STMerge;
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTblWidth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vts.pfms.AESCryptor;
import com.vts.pfms.Zipper;
import com.vts.pfms.download.service.DownloadService;
import com.vts.pfms.project.service.ProjectService;
import com.vts.pfms.utils.PMSLogoUtil;


@Controller
public class DownloadController {

	@Autowired
	Environment env;
	@Value("${ApplicationFilesDrive}")
	private String ApplicationFilesDrive;
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	@Autowired
	PMSLogoUtil LogoUtil;
	@Autowired
	ProjectService proservice;
	@Autowired
	DownloadService service;
	
	AESCryptor cryptor=new AESCryptor();
	
	private static final Logger logger=LogManager.getLogger(DownloadController.class);
	
	
	@RequestMapping(value = "AttachDocLinkDownload.htm")
	public void FileUnpack(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside AttachDocLinkDownload.htm "+UserId);
		
		try {	
			String filerepid=cryptor.decryptParam(req.getParameter("filerepid"));
            Object[] obj=service.AgendaDocLinkDownload(filerepid);
            String path=req.getServletContext().getRealPath("/view/temp");
            Zipper zip=new Zipper();
            zip.unpack(obj[2].toString()+obj[3].toString()+obj[7].toString()+"-"+obj[6].toString()+".zip",path,obj[5].toString());
            res.setContentType("application/pdf");
            res.setHeader("Content-disposition","attachment;filename="+obj[4]); 
            File f=new File(path+"/"+obj[4]);
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
            Path pathOfFile2= Paths.get(path+"/"+obj[4]); 
            Files.delete(pathOfFile2);

		}
		catch (Exception e) {
			
			e.printStackTrace();  
			logger.error(new Date() +" Inside AttachDocLinkDownload.htm "+UserId, e); 
			
		}

	}
	
	
//	@RequestMapping(value = "ProjectDataSystemSpecsFileDownload.htm" )
//	public void ProjectDataSystemSpecsFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
//	{
//		String UserId = (String) ses.getAttribute("Username");
//		logger.info(new Date() +"Inside ProjectDataSystemSpecsFileDownload.htm "+UserId);
//		try
//		{
////			String ftype=AESCryptor.decrypt( req.getParameter("filename"));
//			String ftype=req.getParameter("filename");
//			String projectdataid=cryptor.decryptParam( req.getParameter("projectdataid"));
//			
//			System.out.println(projectdataid+"--------");
//			
//			res.setContentType("Application/octet-stream");	
//			Object[] projectdatafiledata=service.ProjectDataSpecsFileData(projectdataid);
//			File my_file=null;
//			int index=3;
//			if(ftype.equalsIgnoreCase("sysconfig")) 
//			{
//				index=4;
//			}else if(ftype.equalsIgnoreCase("protree"))
//			{
//				index=5;
//			}else if(ftype.equalsIgnoreCase("pearl"))
//			{
//				index=6;
//			}else if(ftype.equalsIgnoreCase("sysspecs"))
//			{
//				index=3;
//			}
//		
//			my_file = new File(projectdatafiledata[2]+File.separator+projectdatafiledata[index]); 
//	        res.setHeader("Content-disposition","attachment; filename="+projectdatafiledata[index].toString()); 
//	        OutputStream out = res.getOutputStream();
//	        FileInputStream in = new FileInputStream(my_file);
//	        byte[] buffer = new byte[4096];
//	        int length;
//	        while ((length = in.read(buffer)) > 0){   
//	           out.write(buffer, 0, length);
//	        }
//	        in.close();
//	        out.flush();
//	        out.close();
//			
//		}catch (Exception e) {
//				e.printStackTrace(); 
//				logger.error(new Date() +"Inside ProjectDataSystemSpecsFileDownload.htm "+UserId,e);
//		}
//	}
		
  	@RequestMapping(value = "DocumentTemplate.htm" , method = {RequestMethod.GET,RequestMethod.POST})
  	public String DocumentTemplate(HttpServletRequest req, HttpSession ses, HttpServletResponse res, RedirectAttributes redir)throws Exception 
  	{
  		String Username = (String) ses .getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		String ProjectId=null; 
  		try {
  			List<Object[]> ProjectList = proservice.LoginProjectDetailsList(EmpId,Logintype,LabCode);
  			if(req.getParameter("projectid")!=null) {

  				ProjectId=(String)req.getParameter("projectid");
  			}else {
  				ProjectId=ProjectList.get(0)[0].toString();
  			}
  			req.setAttribute("ProjectId", ProjectId);
  			req.setAttribute("ProjectList", ProjectList);
  		}catch (Exception e) {
			// TODO: handle exception
		}
  		
  	 return "documents/DocumentTemplate";
  	}
  	
  	
  	@RequestMapping(value="TemplateAttributesAdd.htm", method = {RequestMethod.POST})
  	public String TemplateAttributesAdd(HttpServletRequest req, HttpSession ses, HttpServletResponse res,RedirectAttributes redir)throws Exception {
  		String Username = (String) ses .getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside TemplateAttributesAdd.htm "+Username);	
  		
  		try {
  			
  			TemplateAttributes ta= new TemplateAttributes();
  			
  			String HeaderFontSize= req.getParameter("HeaderFontSize");
  			String HeaderFontWeight = req.getParameter("HeaderFontWeight");
  			
  			String subHeaderFontSize= req.getParameter("subHeaderFontSize");
  			String subHeaderFontWeight = req.getParameter("subHeaderFontWeight");
  			
  			String ParaFontSize = req.getParameter("ParaFontSize");
  			String paraFontWeight = req.getParameter("paraFontWeight");
  			
  			String mainTableWidth = req.getParameter("mainTableWidth");
  			String subTableWidth = req.getParameter("subTableWidth");
  			
  			
  			ta.setHeaderFontSize(Integer.parseInt(HeaderFontSize));
  			ta.setHeaderFontWeight(Integer.parseInt(HeaderFontWeight));
  			ta.setSubHeaderFontsize(Integer.parseInt(subHeaderFontSize));
  			ta.setHeaderFontWeight(Integer.parseInt(subHeaderFontWeight));
  			ta.setParaFontSize(Integer.parseInt(ParaFontSize));
  			ta.setParaFontWeight(Integer.parseInt(paraFontWeight));
  			ta.setMainTableWidth(Integer.parseInt(mainTableWidth));
  			ta.setSubTableWidth(Integer.parseInt(subTableWidth));
  			ta.setCreatedBy(Username);
  			ta.setCreatedDate(LocalDate.now().toString());
  			
  			Long result= service.TemplateAttributesAdd(ta);
  			System.out.println("result"+result);
  			if(result>0) {
  				redir.addFlashAttribute("result", "Template Attributes set successfully.");
  			}else {
  				redir.addFlashAttribute("resultfail", "Template Attributes set successfully.");
  			}
  			redir.addFlashAttribute("projectid",req.getParameter("projectid"));
  			List<Object[]> ProjectList = proservice.LoginProjectDetailsList(EmpId,Logintype,LabCode);
  			redir.addFlashAttribute("ProjectList", ProjectList);
  		}
  		catch (Exception e) {
  			
		}
  		
  		return"redirect:/DocumentTemplate.htm";
  		
  		
  	}
  	
	
	
	
	private static void createParagraph(XWPFDocument doc, String[] texts, String alignment, boolean[] bolds, int[] fontSizes, int spacingAfter) {
		XWPFParagraph paragraph = doc.createParagraph();
		if (texts.length != bolds.length || texts.length != fontSizes.length) {
	        throw new IllegalArgumentException("Lengths of texts, bolds, and fontSizes arrays must match.");
	    }

	    if (texts.length > 0) {
	        for (int i = 0; i < texts.length; i++) {
	            XWPFRun run = paragraph.createRun();
	            run.setText(texts[i]+"      ");
	            run.setFontSize(fontSizes[i]);
	            run.setBold(bolds[i]);
	        }
	    }

	    if ("CENTER".equals(alignment)) {
	        paragraph.setAlignment(ParagraphAlignment.CENTER);
	    } else if ("LEFT".equals(alignment)) {
	        paragraph.setAlignment(ParagraphAlignment.LEFT);
	    }
	    
	    // Set the spacing after the paragraph
	    paragraph.setSpacingAfter(spacingAfter);
	}
	
	private static void createParagraph(XWPFDocument doc, String text, String alignment, boolean isBold, int fontSize, int spacingAfter ,int spacingBefore) {
		XWPFParagraph paragraph = doc.createParagraph();
		XWPFRun run = paragraph.createRun();
	    run.setText(text);
	    run.setFontSize(fontSize);
	    if (isBold) {
	        run.setBold(true);
	    }
	    if ("CENTER".equals(alignment)) {
	        paragraph.setAlignment(ParagraphAlignment.CENTER);
	    } else if ("LEFT".equals(alignment)) {
	        paragraph.setAlignment(ParagraphAlignment.LEFT);
	    } else if ("RIGHT".equals(alignment)) {
	        paragraph.setAlignment(ParagraphAlignment.RIGHT);
	    }
	    
	    // Set the spacing after the paragraph
	    paragraph.setSpacingAfter(spacingAfter);
	    paragraph.setSpacingBefore(spacingBefore);
	}

	
	private static int setTableRowData(XWPFTable table, int row, int length, String[] cellTexts) {
	    XWPFTableRow tableRow = table.getRow(row);
	    int rowIndex;

	    if (tableRow == null) {
	        // If the row doesn't exist, create a new row
	        tableRow = table.createRow();
	        rowIndex = table.getRows().indexOf(tableRow);
	    } else {
	        rowIndex = row;
	    }

	    for (int i = 0; i < length; i++) {
	        XWPFTableCell cell = tableRow.getCell(i);

	        if (cell == null) {
	            // If the cell doesn't exist, create a new cell
	            cell = tableRow.createCell();
	        }

	        cell.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);

	        XWPFParagraph paragraphAT = cell.getParagraphs().get(0);
	        XWPFRun runAT = null;

	        if (paragraphAT.getRuns().isEmpty()) {
	            runAT = paragraphAT.createRun();
	        } else {
	            runAT = paragraphAT.getRuns().get(0);
	        }

	        if (cellTexts[i] != null) {
	            runAT.setText(cellTexts[i]);
	            runAT.setBold(true);
	        }
	        paragraphAT.setAlignment(ParagraphAlignment.BOTH);
	        paragraphAT.setSpacingBefore(100);  // Adjust the spacing as needed
            paragraphAT.setSpacingAfter(100);
	       
            
	    }

	    return rowIndex;
	}
	private static int setSmallTableRowData(XWPFTable table, int row, int length, String[] cellTexts) {
	    XWPFTableRow tableRow = table.getRow(row);
	    int rowIndex;

	    if (tableRow == null) {
	        // If the row doesn't exist, create a new row
	        tableRow = table.createRow();
	        rowIndex = table.getRows().indexOf(tableRow);
	    } else {
	        rowIndex = row;
	    }

	    
	        XWPFTableCell cell = tableRow.getCell(length);

	        if (cell == null) {
	            // If the cell doesn't exist, create a new cell
	            cell = tableRow.createCell();
	        }

	        cell.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);

	        XWPFParagraph paragraphAT = cell.getParagraphs().get(0);
	        XWPFRun runAT = null;

	        if (paragraphAT.getRuns().isEmpty()) {
	            runAT = paragraphAT.createRun();
	        } else {
	            runAT = paragraphAT.getRuns().get(0);
	        }

	   
	            runAT.setText(cellTexts[length]);
	            runAT.setBold(true);
	            runAT.addBreak();
	            
	        paragraphAT.setAlignment(ParagraphAlignment.BOTH);
	        runAT.setBold(true);

	    return rowIndex;
	}
	
	
	

	private static void mergrColums(XWPFTable table,int numCellsToMerge,int row) {
		XWPFTableCell cell = table.getRow(row).getCell(0);
		   for (int i = 1; i < numCellsToMerge; i++) {
			   cell.getCTTc().addNewTcPr().addNewGridSpan().setVal(BigInteger.valueOf(numCellsToMerge));
            }

            // Get the row and cells in the same row for the next columns
            XWPFTableRow sameRow = table.getRow(table.getNumberOfRows() - 1);
            for (int i = 1; i < numCellsToMerge; i++) {
                XWPFTableCell nextCell = sameRow.getCell(1);
                sameRow.getCtRow().removeTc(sameRow.getTableCells().indexOf(nextCell));
            }
	}
	
	private static void setTableWidth(XWPFTable table,int totalTableWidth,int[] percentageColumnWidths) {
        // Get the table properties and set the width
        CTTblPr tblPr = table.getCTTbl().getTblPr();
        if (tblPr == null) {
            tblPr = table.getCTTbl().addNewTblPr();
        }
        CTTblWidth tblWidth = tblPr.getTblW();
        if (tblWidth == null) {
            tblWidth = tblPr.addNewTblW();
        }
        tblWidth.setType(STTblWidth.PCT);
        tblWidth.setW(BigInteger.valueOf(totalTableWidth));

        // Set the column widths
        CTTblGrid tblGrid = table.getCTTbl().addNewTblGrid();
        for (int width : percentageColumnWidths) {
            CTTblGridCol tblGridCol = tblGrid.addNewGridCol();
            tblGridCol.setW(BigInteger.valueOf((width * totalTableWidth) / 100));
        }
	}
	
	private static void setTableHeader(XWPFTableRow thirdRow) {
		  // Get the merged cell (the first cell in the first row)
         XWPFTableCell mergedCell = thirdRow.getCell(0);
         mergedCell.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);

         // Set cell color (if needed)
         mergedCell.setColor("auto");

         // Get the paragraph within the merged cell
         XWPFParagraph paragraphTable = mergedCell.getParagraphs().get(0);

         String formattedText = "NA : Not Assigned  AA : Activity Assigned  OG : On Going  DO : Delay - On Going  RC : Review & Close  FD : Forwarded With Delay  CO : Completed  CD : Completed with Delay  IA : InActive  DD : Delayed days";

         String[] wordAndFormat = formattedText.split("\\s+");

         for (int i = 0; i < wordAndFormat.length; i++) {
             String text = wordAndFormat[i];
             XWPFRun run3 = paragraphTable.createRun();
             run3.setFontSize(9); 
             // Check if the text is a word (not a formatting code)
             if (!text.matches(".*:[\\s\\w]*")) {
                 // Apply red color to specific words
                 if (text.equals("NA") || text.equals("AA") || text.equals("OG") ||
                     text.equals("DO") || text.equals("RC") || text.equals("FD") ||
                     text.equals("CO") || text.equals("CD") || text.equals("IA") ||
                     text.equals("DD")) {
                     run3.setColor("FF0000"); // Red color
                 } else {
                     run3.setColor("000000"); // Black color (default)
                 }
             }
             // Add a space after "NA : Not Assigned" except for the last item
             if ((text.equals("Assigned") && i < wordAndFormat.length - 1) || text.equals("Going") || text.equals("Close") || text.equals("ForwardedWithDelay") || text.equals("InActive") || text.equals("Delayeddays") || text.equals("Completed")) {
                 text += "  ";
             }
             run3.setText(text);
            
         }

         // Set the alignment of the paragraph to center
         paragraphTable.setAlignment(ParagraphAlignment.CENTER);
 
	}
	private static void mergeColums(XWPFTable table,int rowNo,int startIdx,int endIdx ) {
		XWPFTableRow futureRow = table.getRow(rowNo);
         XWPFTableCell lastCell5 = futureRow.getCell(startIdx);
	       //  XWPFTableCell lastCell2 = seventhRow.getCell(6);

	      // Merge the last two cells
	      CTTcPr tcPr3 = lastCell5.getCTTc().addNewTcPr();
	      tcPr3.addNewGridSpan().setVal(BigInteger.valueOf(2));
	         
	      futureRow.getCtRow().removeTc(endIdx);
	}	
	private static void mergeRows(XWPFTable table,int rowNo1,int rowNo2,int startIdx,int endIdx) {
         XWPFTableCell firstCellFirstRow = table.getRow(rowNo1).getCell(startIdx);
         XWPFTableCell firstCellSecondRow = table.getRow(rowNo2).getCell(endIdx);

         // Merge the cells by setting the vMerge property
         CTTcPr tcPrFirstCellFirstRow = firstCellFirstRow.getCTTc().isSetTcPr() ? firstCellFirstRow.getCTTc().getTcPr() : firstCellFirstRow.getCTTc().addNewTcPr();
         CTTcPr tcPrFirstCellSecondRow = firstCellSecondRow.getCTTc().isSetTcPr() ? firstCellSecondRow.getCTTc().getTcPr() : firstCellSecondRow.getCTTc().addNewTcPr();

         CTVMerge vMerge = tcPrFirstCellFirstRow.isSetVMerge() ? tcPrFirstCellFirstRow.getVMerge() : tcPrFirstCellFirstRow.addNewVMerge();
         vMerge.setVal(STMerge.RESTART);

         vMerge = tcPrFirstCellSecondRow.isSetVMerge() ? tcPrFirstCellSecondRow.getVMerge() : tcPrFirstCellSecondRow.addNewVMerge();
         vMerge.setVal(STMerge.CONTINUE);
	}
	

	
	private static void createCell2(XWPFTableRow row, String value, int cell) {
	    XWPFTableCell cell2 = row.getCell(cell);
	    if (value != null) {
	        String[] lines = value.split("\n");
	        for (int i = 0; i < lines.length; i++) {
	            if (i > 0) {
	                cell2.addParagraph().createRun().addBreak();
	            }
	            cell2.addParagraph().createRun().setText(lines[i]);
	        }

	    } else {
	        cell2.setText("-");
	    }
	    cell2.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
	}
	private static void createCell(XWPFTableRow row, String value, int cell) {
	    XWPFTableCell cell2 = row.getCell(cell);
	    if (value != null) {
	    	cell2.setText(value);
	    } else {
	        cell2.setText("-");
	    }
	    cell2.setVerticalAlignment(XWPFTableCell.XWPFVertAlign.CENTER);
	}
	
    private static void addHeaders(XWPFDocument doc) {
        // Create a new header and set its content
        XWPFHeader header = doc.createHeader(HeaderFooterType.DEFAULT);
        XWPFParagraph headerParagraph = header.createParagraph();
        XWPFRun run = headerParagraph.createRun();
        run.setText("RESTRICTED");
        run.setUnderline(UnderlinePatterns.SINGLE);
        headerParagraph.setAlignment(ParagraphAlignment.CENTER);
    }
    private static void addHeaderswithImage(XWPFDocument doc, ByteArrayInputStream imageStream,int formatP) throws InvalidFormatException, IOException {
        // Create a new header and set its content
        XWPFHeader header = doc.createHeader(HeaderFooterType.DEFAULT);
        XWPFParagraph headerParagraph = header.createParagraph();
        XWPFRun run = headerParagraph.createRun();
        headerParagraph.setAlignment(ParagraphAlignment.LEFT);
        run.addPicture(imageStream, formatP, "Lab Logo", Units.toEMU(30), Units.toEMU(30));
        run.setText("                                                                       RESTRICTED");
    }
    private static void addSingleParagraphCenteredFooter(XWPFDocument doc) {
        // Create a new footer
    	   XWPFFooter footer = doc.createFooter(HeaderFooterType.DEFAULT);
    	    XWPFParagraph footerParagraph = footer.createParagraph();

    	    // Add the first line
    	    XWPFRun firstLineRun = footerParagraph.createRun();
    	    firstLineRun.setText("i");
    	    footerParagraph.createRun().addBreak();

    	    // Add the second line
    	    XWPFRun secondLineRun = footerParagraph.createRun();
    	    secondLineRun.setText("RESTRICTED");
    	    secondLineRun.setUnderline(UnderlinePatterns.SINGLE);
    	    // Center the content in the paragraph
    	    footerParagraph.setAlignment(ParagraphAlignment.CENTER);
    }
	
    private static void mergeDocumentsSimple(XWPFDocument targetDoc, XWPFDocument sourceDoc) {
        for (XWPFParagraph sourceParagraph : sourceDoc.getParagraphs()) {
            // Create a new paragraph in the target document
            XWPFParagraph targetParagraph = targetDoc.createParagraph();

            // Copy the content of the source paragraph to the target paragraph
            for (XWPFRun sourceRun : sourceParagraph.getRuns()) {
                XWPFRun targetRun = targetParagraph.createRun();
                targetRun.getCTR().set(sourceRun.getCTR().copy());
            }
        }
    }
    
    
	@RequestMapping(value="RequirementWordDownload.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public void CommitteeMinutesNewWordDownload(HttpServletRequest req,HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{
		String LabCode = (String)ses.getAttribute("labcode");
		XWPFDocument doc1 = new XWPFDocument();
		XWPFDocument doc2 = new XWPFDocument();
		String filename="ABC";
		Object[]labDetails=service.getLabDetails(LabCode);
        
		String lablogo=LogoUtil.getLabLogoAsBase64String(LabCode);
		byte[] imageBytes=DatatypeConverter.parseBase64Binary(lablogo);
		ByteArrayInputStream imageStream = new ByteArrayInputStream(imageBytes);
		ByteArrayInputStream imageStream1 = new ByteArrayInputStream(imageBytes);
		int formatP = XWPFDocument.PICTURE_TYPE_PNG;
		try {
			XWPFTable table = doc1.createTable(1, 1);
            int[] percentageColumnWidths = {100};

            int totalTableWidth = 2500; 
            String[] cellTexts = {"The information in this document is not to be published or communicated either directly or indirectly , to the press or any personnel not authorized to recieve it."};

            setTableRowData(table,0,cellTexts.length,cellTexts);
            setTableWidth(table,totalTableWidth,percentageColumnWidths);
			
            
            
//	 		createParagraph(doc1, "SYSTEM REQUIREMENTS DOCUMENT", "CENTER", true, 24,1000);
	 		createParagraph(doc1, "","CENTER" , true, 25, 0,4000);
	 		
	 		XWPFParagraph paragraphP = doc1.createParagraph();
	 		XWPFRun runP = paragraphP.createRun();
	        runP.addPicture(imageStream, formatP, "Lab Logo", Units.toEMU(100), Units.toEMU(100));
	        paragraphP.setAlignment(ParagraphAlignment.CENTER);
	        addHeaderswithImage(doc2,imageStream1,formatP); /* add header with Image*/  
	        createParagraph(doc1,LabCode.toUpperCase(),"CENTER" , true, 10, 20,0);
	        createParagraph(doc1,"( ISO 9001:2008 Certified Establishment )","CENTER" , true, 10, 20,0);
	        createParagraph(doc1,"SYSTEM REQUIREMENTS DOCUMENT","CENTER" , true, 20, 0,2000);
	        createParagraph(doc1,labDetails[1].toString(),"CENTER" , true, 12, 0,40);
	        createParagraph(doc1,"Government of India, Ministry of Defence","CENTER" , true, 12, 0,10);
	        createParagraph(doc1,"Defence Research & Development Organisation","CENTER" , true, 12, 0,40);
	        createParagraph(doc1,labDetails[3].toString()+", "+labDetails[4].toString()+", -"+labDetails[5].toString(),"CENTER" , true, 12, 0,40);
	        
	        XWPFParagraph pageBreak = doc1.createParagraph();
            pageBreak.setPageBreak(true);
            createParagraph(doc1, "DOCUMENT SUMMARY", "CENTER", true, 18,0,0);
            XWPFTable tableSummary = doc1.createTable(17, 1);
            setTableWidth(tableSummary,5000,percentageColumnWidths);
	        addHeaders(doc1); // add normal header 
	        addSingleParagraphCenteredFooter(doc1);
			//addSingleParagraphCenteredFooter(doc2);
			mergeDocumentsSimple(doc1,doc2);
	 	    String minutesFilePath = env.getProperty("ApplicationFilesDrive");
	 	    String outputPath = minutesFilePath + "/" + filename + ".docx";
	 	    FileOutputStream out = new FileOutputStream(outputPath);
	 	    doc1.write(out);
	 	    out.close();
	 	    // Set response headers
	 	    res.setContentType("application/msword");
	 	    res.setHeader("Content-Disposition", "inline; filename=" + filename + ".docx");
	 	    // Stream the Word document to the response
	 	    FileInputStream in = new FileInputStream(outputPath);
	 	    byte[] buffer = new byte[4096];
	 	    int length;
	 	    while ((length = in.read(buffer)) > 0) {
	 	        res.getOutputStream().write(buffer, 0, length);
	 	    }
	 	    in.close();
		}catch (Exception e) {
			// TODO: handle exception
		}
	}
	
}
