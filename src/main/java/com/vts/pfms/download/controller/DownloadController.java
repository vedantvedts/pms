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
import org.apache.poi.xwpf.usermodel.Borders;
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
				
  		try {
  			//List<Object[]> ProjectList = proservice.LoginProjectDetailsList(EmpId,Logintype,LabCode);
  			//List<Object[]> projectIntiationList = proservice.ProjectIntiationList(EmpId,Logintype,LabCode);
  			  		
			  req.setAttribute("EditData", service.ProjectDataTempAttr());
  			//req.setAttribute("ProjectList", ProjectList);
  			//req.setAttribute("ProjectIntiationList", projectIntiationList);
  			//req.setAttribute("ProjectId", ProjectId);
  			//req.setAttribute("InitiationId", InitiationId);
  			//req.setAttribute("ismain", ismain);
  			
  			 return "documents/DocumentTemplate";
  		}catch (Exception e) {
			e.printStackTrace();
			return "Static/Error";
		}
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
  			
  			
  			String SuperHeaderFontSize=req.getParameter("SuperHeaderFontSize");
  		
  			String ParaFontSize = req.getParameter("ParaFontSize");
  			String paraFontWeight = req.getParameter("paraFontWeight");
  			
  			String SuperHeaderFontWeight=req.getParameter("SuperHeaderFontWeight");
  			
  			String FontFamily=req.getParameter("FontFamily");
  			
  			
  			ta.setHeaderFontSize(Integer.parseInt(HeaderFontSize));
  			ta.setHeaderFontWeight(HeaderFontWeight);
  			ta.setSubHeaderFontsize(Integer.parseInt(subHeaderFontSize));
  			ta.setSubHeaderFontweight(subHeaderFontWeight);
  			ta.setParaFontSize(Integer.parseInt(ParaFontSize));
  			ta.setParaFontWeight(paraFontWeight);
  			//ta.setMainTableWidth(Integer.parseInt(mainTableWidth));
  		//	ta.setSubTableWidth(Integer.parseInt(subTableWidth));
  			ta.setSuperHeaderFontsize(Integer.parseInt(SuperHeaderFontSize));
  			ta.setSuperHeaderFontWeight(SuperHeaderFontWeight);
  			ta.setFontFamily(FontFamily);
  			ta.setCreatedBy(Username);
  			ta.setCreatedDate(LocalDate.now().toString());
  			ta.setIsActive(1);
  			ta.setRestrictionOnUse(req.getParameter("RestictionOnUse"));
  			
  			System.out.println(ta.toString());
  			Long result= service.TemplateAttributesAdd(ta);
  			if(result>0) {
  				redir.addFlashAttribute("result", "Template Attributes set successfully.");
  			}else {
  				redir.addFlashAttribute("resultfail", "Template Attributes set successfully.");
  			}
  			  List<Object[]> ProjectList = proservice.LoginProjectDetailsList(EmpId,Logintype,LabCode);
  			redir.addFlashAttribute("ProjectList", ProjectList);
  		}
  		catch (Exception e) {
  			
		}
  		
  		return"redirect:/DocumentTemplate.htm";
  		
  		
  	}
  	
  	@RequestMapping(value="TemplateAttributesEdit.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String carsInitiationEditSubmit(HttpServletRequest req, HttpSession ses,RedirectAttributes redir) throws Exception {
		
		String Username = (String) ses .getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date()+ " Inside TemplateAttributesEdit "+Username);
		try {
			TemplateAttributes AttributId =null;
			String Attributid  =req.getParameter("AttributId");
  			System.out.println("!!!!!###Attributid####!!!!!!"+Attributid);
  			if(Attributid!=null)
  				{
  					AttributId = service.TemplateAttributesEditById(Long.parseLong(Attributid));
  				}
  			
  			AttributId.setHeaderFontSize(Integer.parseInt(req.getParameter("HeaderFontSize")));
  			AttributId.setHeaderFontWeight(req.getParameter("HeaderFontWeight"));
  		  
  			AttributId.setSubHeaderFontsize(Integer.parseInt(req.getParameter("subHeaderFontSize")));
  			AttributId.setSubHeaderFontweight(req.getParameter("subHeaderFontWeight"));
  		  	
  			AttributId.setParaFontSize(Integer.parseInt(req.getParameter("ParaFontSize")));
  			AttributId.setParaFontWeight(req.getParameter("paraFontWeight"));
  			
  			//AttributId.setMainTableWidth(Integer.parseInt(req.getParameter("mainTableWidth")));
  			//AttributId.setSubTableWidth(Integer.parseInt(req.getParameter("subTableWidth")));
  		  	
  			AttributId.setSuperHeaderFontsize(Integer.parseInt(req.getParameter("SuperHeaderFontSize")));
  			AttributId.setSuperHeaderFontWeight(req.getParameter("SuperHeaderFontWeight"));
  			
  			AttributId.setFontFamily(req.getParameter("FontFamily"));
  			
  		
  			AttributId.setModifiedBy(Username);
  			AttributId.setModifiedDate(LocalDate.now().toString());
  			AttributId.setIsActive(1);
  			AttributId.setRestrictionOnUse(req.getParameter("RestictionOnUse"));
  			
  			
  			
  			
			long result = service.TemplateAttributesEdit(AttributId);
			if(result!=0) {
				redir.addAttribute("result", " Edited Successfully");
			}else {
				redir.addAttribute("resultfail", " Edit UnSuccessful");
			}
			redir.addAttribute("carsInitiationId", result);
			redir.addAttribute("TabId","1");
			
			return "redirect:/DocumentTemplate.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TemplateAttributesEdit.htm "+Username,e);
			return "static/Error";
		}
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

	
	
	private static void createsubParagraph(XWPFDocument doc, String text, String alignment, boolean isBold, int fontSize, int spacingAfter ,int spacingBefore, int leftspace) {
		XWPFParagraph paragraph = doc.createParagraph();
		XWPFRun run = paragraph.createRun();
		paragraph.setIndentationLeft(leftspace);
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
	            
	          if(i==0) {
	        	  runAT.setBold(true);
	          }
	          else {
	        	  runAT.setBold(false);
	          }
	        }
	        paragraphAT.setAlignment(ParagraphAlignment.LEFT);
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
        headerParagraph.setBorderBottom(Borders.SINGLE);
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
    private static void addSingleParagraphFooter(XWPFDocument doc) {
    	
 	   XWPFFooter footer = doc.createFooter(HeaderFooterType.DEFAULT);
	    XWPFParagraph footerParagraph = footer.createParagraph();

		 XWPFRun firstLine = footerParagraph.createRun(); 
		 firstLine.setText("Prepared by:                                                          Reviewed by:                                                   Approved by:");
		 footerParagraph.setAlignment(ParagraphAlignment.LEFT);
		
    }
    
    
    private static void addSingleParagraphCenteredFooter(XWPFDocument doc) {
        // Create a new footer
    	   XWPFFooter footer = doc.createFooter(HeaderFooterType.DEFAULT);
    	    XWPFParagraph footerParagraph = footer.createParagraph();

//			
//			 XWPFRun firstLine = footerParagraph.createRun(); 
//			 firstLine.setText("Prepared by:                             Reviewed by:                        Approved by:");
//			 footerParagraph.createRun().addBreak();
//			
//    	    
    	    
    	    // Add the first line
//    	    XWPFRun firstLineRun = footerParagraph.createRun();
//    	    firstLineRun.setText("i");
//    	    footerParagraph.createRun().addBreak();

    	    // Add the second line
    	    XWPFRun secondLineRun = footerParagraph.createRun();
    	    secondLineRun.setText("RESTRICTED");
    	    secondLineRun.setUnderline(UnderlinePatterns.SINGLE);
    	    // Center the content in the paragraph
    	    footerParagraph.setAlignment(ParagraphAlignment.CENTER);
    }
    private static int estimateNumberOfPages(XWPFDocument document) {
        int numPages = 1; // Start with at least one page

        // Iterate through paragraphs and count occurrences of page breaks
        List<XWPFParagraph> paragraphs = document.getParagraphs();
        for (XWPFParagraph paragraph : paragraphs) {
            String text = paragraph.getText();
            if (text.contains("\n")) {
                numPages++;
            }
        }

        return numPages;
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
    
    
    private static void createBulletPoint(XWPFDocument doc, String data,int leftSpace) {
        XWPFParagraph paragraph = doc.createParagraph();
        paragraph.setIndentationLeft(leftSpace);
        XWPFRun run = paragraph.createRun();

        // Add dot bullet
        run.setText("• ");  // U+2022 is the Unicode character for a bullet point

        // Add data
        run.setText(data);

        // Set other formatting options as needed
        run.setFontSize(12);
        run.setColor("000000");  // Black color

        // Add spacing after the paragraph
        paragraph.setSpacingAfter(10);
    }
    
    
    
    
    
	@RequestMapping(value="RequirementWordDownload.htm", method = {RequestMethod.POST,RequestMethod.GET})
	public void CommitteeMinutesNewWordDownload(HttpServletRequest req,HttpServletResponse res, HttpSession ses, RedirectAttributes redir) throws Exception{
		
		
		
  		String Username = (String) ses .getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside RequirementWordDownload.htm "+Username);
		
		
		XWPFDocument doc1 = new XWPFDocument();
		XWPFDocument doc2 = new XWPFDocument();
		String filename="SRS";
		Object[]labDetails=service.getLabDetails(LabCode);
        String ProjectId=req.getParameter("ProjectId");
        
	   List<Object[]> ProjectList = proservice.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	   
	   Object[]projectData=proservice.ProjectEditData1(ProjectId);
	   String projectName="SampleProject";
	   
	   if(projectData!=null) {
		   projectName=projectData[3].toString();
	   }
	   
		
		String lablogo=LogoUtil.getLabLogoAsBase64String(LabCode);
		byte[] imageBytes=DatatypeConverter.parseBase64Binary(lablogo);
		ByteArrayInputStream imageStream = new ByteArrayInputStream(imageBytes);
		ByteArrayInputStream imageStream1 = new ByteArrayInputStream(imageBytes);
		int formatP = XWPFDocument.PICTURE_TYPE_PNG;
		try {
			XWPFTable table = doc1.createTable(1, 1);
            int[] percentageColumnWidths = {100};

            int totalTableWidth = 2300; 
            String[] cellTexts = {"The information in this document is not to be published or communicated either directly or indirectly , to the press or any personnel not authorized to recieve it."};

            setTableRowData(table,0,cellTexts.length,cellTexts);
            setTableWidth(table,totalTableWidth,percentageColumnWidths);
            table.getCTTbl();
            
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
	        
	        XWPFParagraph paragraphP2= doc1.createParagraph();
	        paragraphP2.createRun().addBreak();
            createParagraph(doc1, "DOCUMENT SUMMARY", "CENTER", true, 18,0,0);
//            XWPFTable tableSummary = doc1.createTable(2, 2);
//            int[] tableSummaryColWidth= {50,50};
//            String []firstCellText={"1.Title : System requirements Document Template",null};
//            setTableRowData(tableSummary,0,firstCellText.length,firstCellText);
//            setTableWidth(tableSummary,5000,tableSummaryColWidth);
//            int numCellsToMerge = 2;
//            mergrColums(tableSummary,numCellsToMerge,1);
            //String []secondCellText={"2.Type of Document :"};

            XWPFTable tableSummary = doc1.createTable(17, 2);
            int[] tableSummaryColWidth = {40,60};
            String []firstCellText={"1.Title","System requirements Document Template"};
            String []secondCelltext={"2.Type of Document"," System Requirements Document"};
            String []thirdCelltext={"3.Classification","Restricted"};
            String []fourthCelltext={"4.LRDE DOCUMENT NUMBER","LRDE: SyRD_Template"};
            String []fifthCelltext={"5.Month Year","Dec 2023"};
            String []sixCelltext={"6.Number of Pages","25"};
            String []seventCelltext={"7. Related Documents","  "};
            String []eightCelltext={"8.Additional Information","NA"};
            String []ninthCelltext={"9.Project Number abd Project Name","NA"};
            String []tenthCelltext={"10.Abstract","This template should be used for preparing System requirement Document"};
            String []eleventhCelltext={"11.Keywords",""};
            String []twelevethCelltext={"12.Organization and Address",labDetails[1].toString()+" , "+labDetails[3].toString()+", "+labDetails[4].toString()+", - "+labDetails[5].toString()};
            String []thirteenthCelltext={"13. Distribution","All Radar Divisions and RTMD"};
            String []fourteenthhCelltext={"14. Revision:","Version 1.01"};
            String []fifteenthCelltext={"15.Prepared by Name & Signature",""};
            String []sixteenthCelltext={"16.Reviewd by Name & Signature ",""};
            String []seventeethCelltext={"17.Approved by Name & Signature",""};

            
            int totalTableWidths = 5000; 
            setTableRowData(tableSummary,0,firstCellText.length,firstCellText);
            setTableRowData(tableSummary,1,secondCelltext.length,secondCelltext);
            setTableRowData(tableSummary,2,thirdCelltext.length,thirdCelltext);
            setTableRowData(tableSummary,3,fourthCelltext.length,fourthCelltext);
            setTableRowData(tableSummary,4,fifthCelltext.length,fourthCelltext);
            setTableRowData(tableSummary,5,sixCelltext.length,sixCelltext);
            setTableRowData(tableSummary,6,seventCelltext.length,seventCelltext);
            setTableRowData(tableSummary,7,eightCelltext.length,eightCelltext);
            setTableRowData(tableSummary,8,ninthCelltext.length,ninthCelltext);
            setTableRowData(tableSummary,9,tenthCelltext.length,tenthCelltext);
            setTableRowData(tableSummary,10,eleventhCelltext.length,eleventhCelltext);
            setTableRowData(tableSummary,11,twelevethCelltext.length,twelevethCelltext);
            setTableRowData(tableSummary,12,thirteenthCelltext.length,thirteenthCelltext);
            setTableRowData(tableSummary,13,fourteenthhCelltext.length,fourteenthhCelltext);
            setTableRowData(tableSummary,14,fifteenthCelltext.length,fifteenthCelltext);
            setTableRowData(tableSummary,15,sixteenthCelltext.length,sixteenthCelltext);
            setTableRowData(tableSummary,16,seventeethCelltext.length,seventeethCelltext);
            setTableWidth(tableSummary,totalTableWidths,tableSummaryColWidth);

	        createParagraph(doc1,"","LEFT" , true, 20, 1000,0);

	        createParagraph(doc1,"1. SCOPE","LEFT" , true, 20, 0,0);
	        XWPFParagraph Paragraph1 = doc1.createParagraph();
	        Paragraph1.setBorderBottom(Borders.SINGLE);
            
            createsubParagraph(doc1,"1.1 System Identification","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,"Aut explicabo voluptas aut cumque quia eum voluptate cupiditate eos sint assumenda? Ut nemo quibusdam et assumenda galisum sed beatae aliquid et quidem itaque nam voluptas quia qui quisquam laborum. Qui minus inventore eum nihil minus aut perferendis molestiae nam impedit error! A expedita minus et dolores rerum est galisum alias eos galisum nobis.\r\n"
            		+ "\r\n"
            		+ "Aut porro rerum et voluptatem reprehenderit est magni dolore ea iusto harum nam totam corrupti. Est omnis labore et beatae dolore et explicabo doloremque id similique culpa est modi quasi nam consequatur voluptates! Et voluptatem voluptas qui officiis odio ut quas omnis At quam suscipit est asperiores dolor sed repudiandae doloremque 33 ipsum praesentium. Est illum repellendus aut asperiores adipisci ea cupiditate atque est molestias similique ex velit totam rem enim unde.","LEFT" , false, 12, 0,20,720);
           
            createsubParagraph(doc1,"1.2 System Overview","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,"Aut explicabo voluptas aut cumque quia eum voluptate cupiditate eos sint assumenda? Ut nemo quibusdam et assumenda galisum sed beatae aliquid et quidem itaque nam voluptas quia qui quisquam laborum. Qui minus inventore eum nihil minus aut perferendis molestiae nam impedit error! A expedita minus et dolores rerum est galisum alias eos galisum nobis.\r\n"
            		+ "\r\n"
            		+ "Aut porro rerum et voluptatem reprehenderit est magni dolore ea iusto harum nam totam corrupti. Est omnis labore et beatae dolore et explicabo doloremque id similique culpa est modi quasi nam consequatur voluptates! Et voluptatem voluptas qui officiis odio ut quas omnis At quam suscipit est asperiores dolor sed repudiandae doloremque 33 ipsum praesentium. Est illum repellendus aut asperiores adipisci ea cupiditate atque est molestias similique ex velit totam rem enim unde.","LEFT" , false, 12, 0,20,720);
            
            createsubParagraph(doc1,"1.3 System Requirement Document Overview","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,"Aut explicabo voluptas aut cumque quia eum voluptate cupiditate eos sint assumenda? Ut nemo quibusdam et assumenda galisum sed beatae aliquid et quidem itaque nam voluptas quia qui quisquam laborum. Qui minus inventore eum nihil minus aut perferendis molestiae nam impedit error! A expedita minus et dolores rerum est galisum alias eos galisum nobis.\r\n"
            		+ "\r\n"
            		+ "Aut porro rerum et voluptatem reprehenderit est magni dolore ea iusto harum nam totam corrupti. Est omnis labore et beatae dolore et explicabo doloremque id similique culpa est modi quasi nam consequatur voluptates! Et voluptatem voluptas qui officiis odio ut quas omnis At quam suscipit est asperiores dolor sed ","LEFT" , false, 12, 0,20,720);

            
//            XWPFParagraph paragraphP3= doc1.createParagraph();
//	        paragraphP3.createRun().addBreak();
            
            createParagraph(doc1,"2. APPLICABLE DOCUMENTS","LEFT" , true, 20, 0,0);       
            XWPFParagraph Paragraph2 = doc1.createParagraph();
	        Paragraph2.setBorderBottom(Borders.SINGLE);
            createsubParagraph(doc1,"This section provides a list of refernece of reference documnets upon which this document is either based, or to which this document refers.","LEFT" , false, 12, 0,20,720);
          
            createParagraph(doc1,"3. REQUIREMENTS","LEFT" , true, 20, 0,500); 
            XWPFParagraph Paragraph3 = doc1.createParagraph();
	        Paragraph3.setBorderBottom(Borders.SINGLE);
            createsubParagraph(doc1,"This section provides a list of refernece of reference documnets upon which this document is either based, or to which this document refers.","LEFT" , false, 14, 0,20,720);
            createParagraph(doc1,"3.1. Required States and Modes","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"3.1.1 Radar Modes :","LEFT" , true, 14, 0,20,720);

            String []statesModes= {"Transporatioin Mode:", "Deployment Mode:", "StandBy Mode :", "Operation Mode :","Maintenance Mode :"};
            
            for(int i=0;i<statesModes.length;i++) {
            	createBulletPoint(doc1,statesModes[i],1080);
            }
            
            createsubParagraph(doc1,"3.1.2 Operational Modes :","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,"This section provides a list of refernece of reference documnets upon which this document is either based, or to which this document refers.","LEFT" , false, 14, 0,20,1080);
            
            createParagraph(doc1,"3.2. System  Capability Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"This section provides a list of refernece of reference documnets upon which this document is either based, or to which this document refers.This section provides a list of refernece of reference documnets upon which this document is either based, or to which this document refers.","LEFT" , false, 14, 0,20,720);
            createsubParagraph(doc1,"3.2.1 Functional Requirements","LEFT" , true, 16, 200,200,720);       

            createsubParagraph(doc1,projectName+"_FR_1 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,0,720);       
            
            createsubParagraph(doc1,projectName+"_FR_2 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_FR_3 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,100,720);
            
            createsubParagraph(doc1,"3.2.2 Performance Requirements","LEFT" , true, 16, 200,200,720);       

            createsubParagraph(doc1,projectName+"_PR_1 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_PR_2 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_PR_3 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,100,720);       
            
            createsubParagraph(doc1,"3.2.3 Operational Requirements","LEFT" , true, 16, 200,200,720);       
            
            createsubParagraph(doc1,projectName+"_PR_1 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_PR_2 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_PR_3 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,100,720);       

            createsubParagraph(doc1,"3.2.4 Deployment Requirements","LEFT" , true, 16, 200,200,720);       

            createsubParagraph(doc1,projectName+"_PR_1 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_PR_2 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_PR_3 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,100,720);       
            
            createParagraph(doc1,"3.3. System  External Interface Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,100,720);
            createsubParagraph(doc1,"This paragraph is divided into subparagraphs to specify requirements , if any fot he systems's external interfaces . This paragraph may reference one or more Interface Requirement specification (IRSs) or other documnets containing the requirements.","LEFT" , false, 12, 0,100,720);
            createsubParagraph(doc1,"3.3.1 Interface Identification","LEFT" , true, 14, 0,100,720);
            
            createsubParagraph(doc1,projectName+"_EIR_1.1 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_EIR_1.2 : The TDR should have serial interface port to provide target cue to weapon system","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_EIR_1.3 : The radar should have data and audio Interface with to remote Display  at a distance upto 800m","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_EIR_1.4 : The radar should have Ethernet interface with other networked sensors.","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_EIR_1.5 : The radar should be able to detect , track and identityfy aerial targets like linear Aircrafts , fighter Aircrafts , UAVs , Helicopters . The system shall identityfy these targets as friend or foe.","LEFT" , false, 12, 0,100,720);       
            
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample External Interface requirements are shown above  . Modify the Interfaces based on your soecific project External Interface requirements","LEFT" , false, 12, 0,100,720);
            
            
            createsubParagraph(doc1,"3.3.2 Interface Diagram","LEFT" , true, 14, 0,500,720);
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample External Interface requirements are shown above  . Modify the Interfaces based on your soecific project External Interface requirements","LEFT" , false, 12, 0,100,720);
            
            createParagraph(doc1,"3.4. System  Internal Interface Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample Internal Interface requirements are shown below  . Modify the Interfaces based on your soecific project interna; Interface requirements","LEFT" , false, 12, 0,100,720);

            createsubParagraph(doc1,projectName+"_IIR_1 :High speed Serial interface ovver optical fiber channel should be used to transfer data between AGR, DBF , Signal Processor and dwell scheduler units of the radar to meet high band width video data requirements ","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_IIR_2 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_IIR_3 : All timing signals in the system should be transmitted iover  RS422/LVDS link","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_IIR_4 : All system clocks should be distributed using RF cable ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_IIR_5 : Power, Data and optical Interface between radar sensor vehicele , ops and power vehicle should be present","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,100,720);
            createsubParagraph(doc1,"Sample External Interface requirements are shown above  . Modify the Interfaces based on your soecific project External Interface requirements","LEFT" , false, 12, 0,100,720);
            
            createParagraph(doc1,"3.5. System  Internal Data Requirements","LEFT" , true, 16, 0,300);       

            createsubParagraph(doc1,projectName+"_IDR_1 :All decesions about internal data are left to design otr to the design or to requirements specifications for system or subsytem components . This should be finalized during PDR stage of the project ","LEFT" , false, 12, 0,0,720);       

            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample External Interface requirements are shown above  . Modify the Interfaces based on your soecific project External Interface requirements","LEFT" , false, 12, 0,300,720);
            
            createParagraph(doc1,"3.6. Adaption Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,100,720);
            createsubParagraph(doc1,"This paragraph is divided into subparagraphs to specify requirements , if any fot he systems's external interfaces . This paragraph may reference one or more Interface Requirement specification (IRSs) or other documnets containing the requirements.","LEFT" , false, 12, 0,100,720);
           
            createsubParagraph(doc1,projectName+"_ADR_1 :High speed Serial interface ovver optical fiber channel should be used to transfer data between AGR, DBF , Signal Processor and dwell scheduler units of the radar to meet high band width video data requirements ","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_ADR_2 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_ADR_3 : All system clocks should be distributed using RF cable ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_ADR_4 : Power, Data and optical Interface between radar sensor vehicele , ops and power vehicle should be present","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample External Interface requirements are shown above  . Modify the Interfaces based on your soecific project External Interface requirements","LEFT" , false, 12, 0,300,720);
            
            createsubParagraph(doc1,"3.6.1 Sector Management Requirements","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,projectName+"_SMR_1 The Radar system should be capable of suppresing sea and groud clutter","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_SMR_2 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_SMR_3 : the radar should have sector blanking / silent sector facilitis  ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_SMR_4 : The radar should have option to creatyed blanking cells so as inhaibit confirmation beams for plots reported from these cells ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_SMR_5 : The radar should have option to creatyed blanking cells so as inhaibit confirmation beams for plots reported from these cells ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample External Interface requirements are shown above  . Modify the Interfaces based on your soecific project External Interface requirements","LEFT" , false, 12, 0,300,720);
           
            createsubParagraph(doc1,"3.6.2 Doctrine Management Requirements","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,projectName+"_DMR_1 The Radar system should be having multiple fences in elevation to cover total elevation coverage requirement of 0 to 70 degree","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_DMR_2 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            
            
            createParagraph(doc1,"3.7. Safety Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,100,720);
            createsubParagraph(doc1,"This pargraph is divided into subpargraphs to specify specifics system safety requirements if any , concerned with preventing minimizing unintended hazards personnel , property and physical environment . Examples include restricting use of dangerous materials ; classifying explosives for purpose of shipping , handling and storiung ; abort /escape provisions from enclosures","LEFT" , false, 12, 0,100,720);
            createsubParagraph(doc1,"3.7.1 "+projectName+"_SR_1: Mechanical Safety Requirements","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,projectName+"_SR_1.01 The Radar system should be capable of suppresing sea and groud clutter","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_SR_1.02 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_SR_1.03 : the radar should have sector blanking / silent sector facilitis  ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample External Interface requirements are shown above  . Modify the Interfaces based on your soecific project External Interface requirements","LEFT" , false, 12, 0,300,720);
           
            createsubParagraph(doc1,"3.7.2 "+projectName+"_SR_2: Electrical Safety Requirements","LEFT" , true, 14, 0,200,720);
            createsubParagraph(doc1,projectName+"_SR_2.01 The Radar system should be capable of suppresing sea and groud clutter","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_SR_2.02 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_SR_2.03 : the radar should have sector blanking / silent sector facilitis  ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample External Interface requirements are shown above  . Modify the Interfaces based on your soecific project External Interface requirements","LEFT" , false, 12, 0,300,720);
           
            createsubParagraph(doc1,"3.7.3 "+projectName+"_SR_3: Radiation Protection and Chemical Hazards","LEFT" , true, 14, 0,200,720);
            createsubParagraph(doc1,projectName+"_SR_3.01 The Radar system should be capable of suppresing sea and groud clutter","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_SR_3.02 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_SR_3.03 : the radar should have sector blanking / silent sector facilitis  ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample External Interface requirements are shown above  . Modify the Interfaces based on your soecific project External Interface requirements","LEFT" , false, 12, 0,300,720);
           
            createsubParagraph(doc1,"3.7.4 "+projectName+"_SR_4: Lightning Protection","LEFT" , true, 14, 0,200,720);
            createsubParagraph(doc1,"The radar should have proper lightning arrests and grounding system installed.","LEFT" , false, 12, 0,200,720);       
            createParagraph(doc1,"3.8. Security and Privacy  Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"The section specifies system requirements if any , concerned  with maintaing security  and privacy .The requirements include , as applicable , security /privacy environment in which the system or subsytem  should operate , type and degree of security or privacty tob provided , security /privacy riskl the system or subsystem sould withstand , required safeguards to reduce those risks , security /privacy/policy .","LEFT" , false, 12, 0,300,720);
           
            createParagraph(doc1,"3.9. System Environment Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"The section specifies Environmental requirements if any , concerned  with maintaing security  and privacy .The requirements include , as applicable , security /privacy environment in which the system or subsytem  should operate , type and degree of security or privacty tob provided , security /privacy riskl the system or subsystem sould withstand , required safeguards to reduce those risks , security /privacy/policy .","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"3.9.1 "+projectName+"_SR_1: Environmental  Requirement","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,projectName+"_ER_1.01 Highly relaible and High MTBF components should be chosen to meet all weather all terrain continuous operation of radar.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_ER_1.02 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_ER_1.03 : All components ,system and subsytems should be MIL-STD-2164 & MIL-STD_810F standards to meet temperature requirement of 15C+45C  and altitude requirement upto  3500m above MSL  ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample External Interface requirements are shown above  . Modify the Interfaces based on your soecific project External Interface requirements","LEFT" , false, 12, 0,300,720);
          
            createsubParagraph(doc1,"3.9.2 "+projectName+"_ER_2: EMI/EMC Requirements ","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,projectName+"_ER_2.01 All components sysytem and sub sytem should be chosen to make the system compatiables as per the MIL STD 461E/F .","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            
            createsubParagraph(doc1,"Sampole System EMI/EMC Requirements are shown above . Modify the EMI/EMC Requirement based on your spoecific project requirements ","LEFT" , false, 12, 0,300,720);

            
            createParagraph(doc1,"3.10. Computert Source Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This Paragraph is divided into the following subparagrapshs . Depending upon the nature of the system , Compueter resources covered in these subpragraps  may constitute the environment of the system or components of the system as  for (hardware-software system) or components of the system . ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"This paragraph s[ecifies the requirements , if any , regarding computer hardware thata is used by , or incorprated into the system . Requirements include as applicable number of each type of equipmenyt , type size , capacity  and other reuired cahracteristics of processors.","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"3.10.1 "+projectName+"_CRR_1: Component Hardware Requirments ","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,projectName+"_CRR_1.01 Highly relaible and High MTBF components should be chosen to meet all weather all terrain continuous operation of radar.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_CRR_1.02 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_CRR_1.03 : All components ,system and subsytems should be MIL-STD-2164 & MIL-STD_810F standards to meet temperature requirement of 15C+45C  and altitude requirement upto  3500m above MSL  ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,"Sample Computer resource Requirements are shown above . Modify the computer Resource Requiremnts based on your specific project requiremnts ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.10.2 "+projectName+"_CRR_2: Component Hardware Requirments ","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,projectName+"_CRR_2.01 Highly relaible and High MTBF components should be chosen to meet all weather all terrain continuous operation of radar.","LEFT" , false, 12, 0,0,720);       

            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This Paragraph is divided into the following subparagrapshs . Depending upon the nature of the system , Compueter resources covered in these subpragraps  may constitute the environment of the system or components of the system as  for (hardware-software system) or components of the system . ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.10.3 "+projectName+"_CRR_3: Component Hardware Requirments ","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,projectName+"_CRR_3.01 Highly relaible and High MTBF components should be chosen to meet all weather all terrain continuous operation of radar.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_CRR_3.02 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_CRR_3.03 : All components ,system and subsytems should be MIL-STD-2164 & MIL-STD_810F standards to meet temperature requirement of 15C+45C  and altitude requirement upto  3500m above MSL  ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This Paragraph is divided into the following subparagrapshs . Depending upon the nature of the system , Compueter resources covered in these subpragraps  may constitute the environment of the system or components of the system as  for (hardware-software system) or components of the system . ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.10.4 "+projectName+"_CRR_4: Component Communication Requirments ","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,projectName+"_CRR_4.01 Highly relaible and High MTBF components should be chosen to meet all weather all terrain continuous operation of radar.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_CRR_4.02 : Communication between ops shelter and antena should be using Ethernet interface over copper and fibre optic cables ","LEFT" , false, 12, 0,100,720);       
            
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This paparagrapoh specifies additional requirements if any concerning computer communications that are used by , or  incorporated into the system . Examples include geographic locations to be linked ; configuration and network topology ; transmission techniques ; datra transfer rates ; gateways required system use times boundaries for trasnmission /reception/response ; peak volumes of data ; and diagonistic features ","LEFT" , false, 12, 0,300,720);

            createParagraph(doc1,"3.11. System Quality Factors","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This pargaraph is divided into the following subparagraphs .These pargrapsh specifies requirements if any , pertaining to sytem quality factors . Example include quantitive requirements concerning system functionality ( ability to [perform required functions ), reliability to perform which is  correct , conssitent results mean time between faliure for equipment maintainability  ,availability,  flexibility, reusability , testiability ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.11.1 "+projectName+"_QR_1:Quality Requirments ","LEFT" , true, 14, 0,100,720);
            createsubParagraph(doc1,projectName+"_QFR_1 The software should be use d follow international standarads and to be certified by an accredied agency.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_QFR_2 : ISO 9000 standard should be followed for quality managemnet ","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_QFR_3: MIL-STD -8109 E/F should be folowed for environemntal Qulaifiaction","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,projectName+"_QFR_4: For Power supply comaptiblity MIL-STD_704 E Should be  gollowed . MIL-STD-461 D/E should be foillowed for EMI/EMC qualification","LEFT" , false, 12, 0,100,720);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample Quality Requirements are shown above . Modify the quality Requirements based on your specific project requirements ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.11.2 Reliability Requirments ","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_RR_1 All the subsytems should be designed with high MTBF so that the effective MTBF of radar system should ebe 1000 hours or more .","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,"Sample Reliability Requirements are shown above . Modify the quality Requirements based on your specific project requirements ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.11.3 Maintainability Requirments ","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_MR_1 The system should  have capability of recording equipment exploitation data interms of hours run complete system and critical assemnbly or sub assembly .The data should be available for assessing missio n readiness abd aplanninf maintenannce .","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_MR_2 Modular design approach sould be followed to restrict MTTR to max one hour . Interface between modules should be minimum . All sub-suits should be LRU type.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_MR_3 The system should  have capability of recording equipment exploitation data interms of hours run complete system and critical assemnbly or sub assembly .The data should be available for assessing missio n readiness abd aplanninf maintenannce .","LEFT" , false, 12, 0,0,720);       

            createsubParagraph(doc1,"Sample Maintainability Requirements are shown above . Modify the quality Requirements based on your specific project requirements ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.11.4 Availability Requirments ","LEFT" , true, 14, 0,300,720);

            createsubParagraph(doc1,projectName+"_AVR_1: All systems should be available for 24 hous operation.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_AVR_2: Spaces for all critical units should be made available .","LEFT" , false, 12, 0,0,720);       

            createsubParagraph(doc1,"Sample Availability Requirements are shown above . Modify the quality Requirements based on your specific project requirements ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.11.5 Portability Requirments ","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_POR_1: The System should be provided with user friendly GUI and all required interfaces porting of software or firmware.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,"Sample Portability Requirements are shown above . Modify the quality Requirements based on your specific project requirements ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.11.6 Testability Requirments ","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_TER_1: The radar should have built in simulator and data analysis tools to check for testing and fine tune different radar parameters .","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_TER_2: The radar should have entire Equipment & power supplies for testing and maintenance of the ssystem","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_TER_3: The radar should have hardware test facility with test jigs ATES and simulator .","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_TER_4: All systems should be available for 24 hous operation.","LEFT" , false, 12, 0,0,720);       
            
            createsubParagraph(doc1,"Sample Testability Requirements are shown above . Modify the quality Requirements based on your specific project requirements ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.11.7  Usability Requirments ","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This paragraph specifies requirements if any , pertatingh to system quality factors . Examples include quantative requirements concerning system functionality  , reliability, maintainability, availability , flexibility , portability odf software  reuseability .Identityfy each requirement under each category with a Unique Id as shown above abd write a brief oaragraph for each","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,projectName+"_UR_1: The System should meet all the functional requirments stated in PSQR .","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_UR_2: System should have ability to be easi;y serviced , repaired or corrected .","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_UR_3: All controls for initial stting up and for exercising tatctical controls such as selection of targets , passage of relevan data and or communications should be located suitably It should be possible toi operate the equipment while wearing protective cloths.","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_UR_4: The system should have ability to accessed and operated when needed  .","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_UR_5: Enough spares should be made available","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_UR_6: System should have ability to be easily adapted to changing requirement","LEFT" , false, 12, 0,0,720);       
            createsubParagraph(doc1,projectName+"_UR_7: The systemn software should have portability capability si that it can be easily modified for a new environment ","LEFT" , false, 12, 0,0,720);       

            createParagraph(doc1,"3.12. Design and Construction Constraints","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"3.12.1   Design Constraints","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_DC:Design Constraints","LEFT" , true, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_DC_1: The radar should be designed by using existing hardware to the maximum extent from already completed or existing projects of LRDE","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_DC_2: The radar shoudl use suitable wide band code like LFM/NLFM for transmit waveform generation","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_DC_3:This System should be seprated from power vehicle by optimum distance deployment configuration ","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_DC_4: Crieteria for selecting  the design approach should include the required surveliance coverage volume , update rate extra design margin and ration of special non standard parts to standard ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"Sample Design Constraints are shown above . Modify the quality Requirements based on your specific project requirements ","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"3.12.2   Technology Constraints","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_TC_1: The radar should be based on Active array technology with Digital beam forming 4D capabilitiy and opertaional in S band.","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_TC_2: The mechanical System should support radar operational speed up to 30 rpm","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample Design Constraints are shown above . Modify the quality Requirements based on your specific project requirements ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.12.3   Transportability Constraints","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_TRC_1: The radar system mounted on the HVM should be capoable of being transported by rail and should be capable of moving with following speeds.","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,"i. Metalled roads (Plains ):Not less tha 40kmph","LEFT" , false, 12, 0,100,1440);
            createsubParagraph(doc1,"ii. Metalic  road (Mountains):Not less than 40kmph","LEFT" , false, 12, 0,100,1440);
            createsubParagraph(doc1,"iii. Cross Country :Not less than 10kmph","LEFT" , false, 12, 0,100,1440);

            createsubParagraph(doc1,"Sample Transportability Constraints are shown above . Modify the quality Requirements based on your specific project requirements ","LEFT" , false, 12, 0,300,720);

            
            createsubParagraph(doc1,"3.12.4   Schedule Constraints","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,"The project should be completed within the alloted time of < specify tht duration in months>","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.12.5   Cost Constraints","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,"The project must be completed within the alloted resources of <specify the sanctioned amount in Lakhs > by reusing most of the availabe subsytems from other projects . The production worthy version of the radar should cost effectively less than the similar products offered by other countries","LEFT" , false, 12, 0,300,720);

            
            createsubParagraph(doc1,"3.12.6   Manufacturing Constraints","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,"All the manufacturing process at different locations should follow standard guidlines and methodologies to ensure high amount of reliability in all manufactured products/sub units.","LEFT" , false, 12, 0,300,720);

            createParagraph(doc1,"3.13. Personnel Related  requirements ","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This paragraph specifies the system requiremnets , if any included to accomdate the number , skill levels duty cycles, training needs or other information about the personnel who will use or support the system.","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"The radar team should consist of ","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"a. Hardware Enginners ","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"For each subsystem one senior one junior engineer / scientist should be alloted ","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"b. Software  Enginners ","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1," For each software modules coding one senior and one junior engineers / scientist should be alloted ","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"c. Testing  Enginners ","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"For testing of subsystem one engineer / scientis for each sub-sytem should be alloted . One techncial office for each sub-sytem should be alloted ","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"For each sub-sytem 2 technical staff should be provided","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"d. Logistic support Group ","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"for all logistic support one group consisting of four people should be formed ","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"e. Purchas Management Group","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"A group of 4 people should be alloted for managing purchase related activities","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"f. Documentation Group","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"A group of 4 people should be alloted for managing documentation related activities","LEFT" , false, 12, 0,0,720);

            
            createParagraph(doc1,"3.14. Training Related Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"3.14.1 Operator Training Requirement","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_TRR_1.1: The radar sytem should be provided with necessary hardware and software to cater for simulator . It should be able to inject synthetic targets and video into the system and use the diisplays of the radr for evaluating the trainee,s performance.","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_TRR_1.2: The radar should have built in simulatoir for maintaing individual trainees record and have the facility to recalll the data when required ","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample Operator Training Requirements are shown above . Modify the quality Requirements based on your specific project requirements ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.14.2 Maintenance Training Requirement","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_TRR_2.1: The radar should provide Computer based Training (CBT) comprising of 3D visualization of the system/sub-system .CBT pacckage should also compromise of exploded models , 3 D drawing figures and working principle of various subsystems on fault symptom correlation , usages  of SMTs/STE,s should also be provuided","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_TRR_2.2: Detiled documentation including user manuals , operator training manuals etc specification testing should be made available","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This paparagrapoh specifies systems requirements if any concerning computer communications that are used by , or  incorporated into the system . Examples include geographic locations to be linked ; configuration and network topology ; transmission techniques ; datra transfer rates ; gateways required system use times boundaries for trasnmission /reception/response ; peak volumes of data ; and diagonistic features ","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample Maintenance Training Requirements are shown above .Modify the Maintenance Traing Requirements based on your specific project constraints ","LEFT" , false, 12, 0,300,720);

            
            createParagraph(doc1,"3.15. Logistic Related Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"3.15.1 Transportability support","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1," During Design and User trials transportability of radar should be LRDE,s responsibility . Arrangements of secure at antenna while in transportaion should be provided.","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.15.2 Maintenance support","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_LR_2.1: The detailed maintenance manual should be provided to the user","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_LR_2.2: Training should be provided for all operational and maintenance aspect of the radar","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_LR_2.3: In situ repair with modular replacement maximum within one hour","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample Maintenance support Requirements are shown above .Modify the Maintenance Traing Requirements based on your specific project constraints ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.15.3 Product Life Cycle support","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,"LRDE should provide all technical support during product life cycle.","LEFT" , false, 12, 0,300,720);
            createParagraph(doc1,"3.16. Other Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,"3.16.1 Cooling Requirements","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_OTHR_1.1: The radar should be have Liquid cooling for Array Electronics using Cooling unit keep the array electronics tempertaure 25 C maximum at a pressure 10 bar.","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_OTHR_1.2: The radar should have controlled temp (25 degree) environment for equipment and crew.","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"Sample Cooling requirement are shown above Modify the cooling Requirements based on your specific project constraints.","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.16.2 Power Requirements","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_OTHR_2.1: The radar should be provided power fro 24hrs operation from two generators by means of synchronized method of operatipon . The endurance of each genrator should not be less than 8hrs with refulelling.","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_OTHR_2.2: The radars should have control switch and relay to switch between mains or genrator to operate the radar from commercial mains (220 v,50 hz ,3 phase) whenever available.","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_OTHR_2.3: the radar should have UPS as backup of not less than 15 minutes for operation of computers in the Ops shelter to ensure that the date is not lost.","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Sample Power support Requirements are shown above .Modify the Maintenance Traing Requirements based on your specific project constraints ","LEFT" , false, 12, 0,300,720);

            createsubParagraph(doc1,"3.16.3 Physical Requirements","LEFT" , true, 14, 0,300,720);

            createsubParagraph(doc1,"3.16.4 Vehicle Requirements","LEFT" , true, 14, 0,300,720);
            createsubParagraph(doc1,projectName+"_OTHR_3.1: The radar system should be mounted on not more than two HVMs. The radar should be Two Vehicle configuration","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Vehicle 1 - Radar Sensor Vehicle (RSV)","LEFT" , true, 14, 0,100,1440);
            createsubParagraph(doc1,"Vehicle 2 - Power System and OPs Vehicle ","LEFT" , true, 14, 0,100,1440);
            createsubParagraph(doc1,projectName+"_OTHR_3.2: The system mounted on HVMs should not exceed following dimensions for transportaion by rail:-","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Maximum height at center : 3095 mm","LEFT" , true, 14, 0,100,1440);
            createsubParagraph(doc1,"Maximum height at sides  : 2485mm","LEFT" , true, 14, 0,100,1440);
            createsubParagraph(doc1,"Maximum width  : 3050mm","LEFT" , true, 14, 0,100,1440);
            
            createsubParagraph(doc1,projectName+"_OTHR_3.3: The system mountained on The HMVs should be capable of being transported by rail and should be capable of moving  with following speeds.","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1," Metalled roads (Plains ):Not less tha 40kmph","LEFT" , true, 14, 0,100,1440);
            createsubParagraph(doc1," Metalic  road (Mountains):Not less than 40kmph","LEFT" , true, 14, 0,100,1440);
            createsubParagraph(doc1," Cross Country :Not less than 10kmph","LEFT" , true, 14, 0,100,1440);
            createsubParagraph(doc1,"Sample Vehicle support Requirements are shown above .Modify the Maintenance Traing Requirements based on your specific project constraints ","LEFT" , false, 12, 0,300,720);

            createParagraph(doc1,"3.17. Packaging Requirements","LEFT" , true, 16, 0,300);       
            createsubParagraph(doc1,projectName+"_PACR_1: MIL-STD-2073 1D , '' Standard Practice fro Military Packaging Requirements should be followed to protect material against environmentally induced corrosion and deterioration","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,projectName+"_PACR_1: Labelling should be done to each sub-module level for identification","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This section specifes the requirement if any for packaging labelling and handling the system or subsystem and its componnents . Applicable specificatons and standards may be referenced if appropiate","LEFT" , false, 12, 0,300,720);
            createParagraph(doc1,"3.18. Statutory , Regulatory , and Certifiaction Requirments","LEFT" , true, 16, 0,300);       
            createParagraph(doc1,"3.18.1 Statutory Requirments","LEFT" , true, 14, 0,300);       
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This paragraph specifies if applicable statutory for the system or subsystem","LEFT" , false, 12, 0,0,720);
            createParagraph(doc1,"3.18.2 Regulatory Requirments","LEFT" , true, 14, 0,300);       
            createsubParagraph(doc1,"The project group , while managing their work should to take into account the basic regulatory requiremnets for LRDE . These regulatoryt requirments ensure that he organization is functioning as per the statutory framework of the country","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This paragraph specifies if applicable regulatory for the system or subsystem","LEFT" , false, 12, 0,0,720);
            createParagraph(doc1,"3.18.3 Certifiaction Requirments","LEFT" , true, 14, 0,300);       
            createsubParagraph(doc1,projectName+"_SRCR_3.1: The radar should follow MIL-STD-810E/F for Environmental Qualification of sub-system","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,projectName+"_SRCR_3.2: The radar should follow MIL-STD-461D/E for EMI/EMC Qualification of sub-system","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,projectName+"_SRCR_3.3: The radar should follow MIL-STD-704E for power Supplies Comaptibility of sub-systems","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,projectName+"_SRCR_3.4: The radar should follow MIL-STD-461D/E for EMI/EMC Qualification of sub-system","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,projectName+"_SRCR_3.5: The radar should follow MIL-STD-704E for power Supplies Comaptibility of sub-systems","LEFT" , false, 12, 0,0,720);
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"The paragraph specifies if applicable , certification requirements for the system or subsytem .This should include Environment , EMI-EMC , Hardware , Software & Peformance certification","LEFT" , false, 12, 0,0,720);
            createParagraph(doc1,"3.19. Precedence and Criticality of Requirements ","LEFT" , true, 16, 500,300);       
            XWPFTable table19 = doc1.createTable(2, 3);
            int[] table19ColumnWidths = {20, 50, 30};
            int totalTable19Width = 5000; 

            String[] cell19Texts = {"SN", "Requirements ID", "Priority"};

            setTableRowData(table19,0,cell19Texts.length,cell19Texts);
            
            setTableWidth(table19,totalTable19Width,table19ColumnWidths);

            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"This paragraph specifies , if applicable , order of precedence criticality or assigned weights indicationg relative  importance of requirements in this specification. Examples include identifying those requirements demed critical to safety to security or to privacy for purpose of singling them out for special treatment . If all requirements have equal weight","LEFT" , false, 12, 0,300,720);

            
            createParagraph(doc1,"3.20 Demilitarization","LEFT" , true, 16, 500,300);       
            createsubParagraph(doc1,"Demilitarization and disposal at the end of lif-cycle include activities necessary to ensure disposal of decommissioned , destroyed or irreparable system components meet applicable regulations,directives and environemental constraints The process of demilitarization and disposal of systemcomponents should carry out with most cost-effective manner.","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Guidance :","LEFT" , false, 12, 0,300,720);
            createsubParagraph(doc1,"Demilitarization and disposal at the end of life cycle include activities necessary to ensure disposal of decommissioned destroyed , or irreparable system components meet applicable regulations , directives and environmental constraints.","LEFT" , false, 12, 0,300,720);

            createParagraph(doc1,"4. VERIFICATION PROVISIONS","LEFT" , true, 16, 500,300);       

            
	        addHeaders(doc1); // add normal header 
	        addHeaderswithImage(doc1,imageStream1,formatP);
	        addSingleParagraphCenteredFooter(doc1);
			addSingleParagraphFooter(doc1);
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
