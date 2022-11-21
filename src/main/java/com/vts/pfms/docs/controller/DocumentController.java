package com.vts.pfms.docs.controller;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.itextpdf.html2pdf.HtmlConverter;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.docs.model.PfmsDoc;
import com.vts.pfms.docs.model.PfmsDocContent;
import com.vts.pfms.docs.model.PfmsDocContentFreeze;
import com.vts.pfms.docs.model.PfmsDocContentLinks;
import com.vts.pfms.docs.model.PfmsDocContentRev;
import com.vts.pfms.docs.model.PfmsDocTemplate;
import com.vts.pfms.docs.service.DocumentService;
import com.vts.pfms.utils.PMSLogoUtil;

@Controller
public class DocumentController {

	@Autowired
	DocumentService service;
	
	@Autowired
	PMSLogoUtil LogoUtil;
	
	
	private static final Logger logger=LogManager.getLogger(DocumentController.class);
	
	@RequestMapping(value = "ProjectSystems.htm")
	public String ProjectSystems(HttpServletRequest req, HttpSession ses, RedirectAttributes redir, Model model)throws Exception 
	{
 		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
 		String UserId = (String) ses.getAttribute("Username");
 		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProjectSystems.htm "+UserId);
		try {
			String projectid=req.getParameter("projectid");
			Map md = model.asMap();
			if(projectid==null){
				projectid = (String) md.get("projectid");
			}
			if(projectid==null){
				projectid = "0";
			}
			String docl1= req.getParameter("docl1");
			String docl2= req.getParameter("docl2");
			String docl3= req.getParameter("docl3");
			String systemids= req.getParameter("systemids");
			if(systemids==null) {
				 docl1= (String) md.get("docl1");
				 docl2= (String) md.get("docl2");
				 docl3= (String) md.get("docl3");
				 systemids= (String) md.get("systemids");
			}
			
			req.setAttribute("docl1", docl1);
			req.setAttribute("docl2", docl2);
			req.setAttribute("docl3", docl3);
			req.setAttribute("systemids", systemids);
			
			req.setAttribute("projectid", projectid);
			req.setAttribute("ProjectList", service.LoginProjectsList(EmpId, Logintype,LabCode));
			req.setAttribute("filerepmasterlistall", service.FileRepMasterListAll(projectid,LabCode));
			
			return "documents/ProjectSystem";
		}
		catch (Exception e) {
			e.printStackTrace();  
			logger.error(new Date() +" Inside ProjectSystems.htm "+UserId, e); 
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "DocumentTemplate.htm")
	public String ProjectDocumentsList(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String Logintype= (String)ses.getAttribute("LoginType");
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside DocumentTemplate.htm "+UserId);		
		try {			
			String projectid=req.getParameter("projectid");
			Map md = model.asMap();
			if(projectid==null) {
				projectid= (String) md.get("projectid");
			}
			if(projectid==null){
				projectid="0";
			}
			
			req.setAttribute("parentlist",service.DocParentLevelList(projectid,LabCode)) ;
			req.setAttribute("assignedlist",service.ProjectDocAssignedList(projectid,LabCode));			
			req.setAttribute("projectid", projectid);
			req.setAttribute("projectslist", service.LoginProjectsList(EmpId, Logintype,LabCode));
			
			String l1id=req.getParameter("l1id");
			String l2id=req.getParameter("l2id");
			String l3id=req.getParameter("l3id");
			String fileuploadmasterid=req.getParameter("fileuploadmasterid");
			if(fileuploadmasterid==null) {
				l1id= (String) md.get("l1id");
				l2id= (String) md.get("l2id");
				l3id= (String) md.get("l3id");
				fileuploadmasterid= (String) md.get("fileuploadmasterid");
			}
			
			if(fileuploadmasterid!=null) 
			{				
				Object[] docdata = service.DocMasterDataPdocId(projectid,fileuploadmasterid);
				req.setAttribute("doctemplatelist", service.PfmsDocTemplateList(projectid,fileuploadmasterid));
				req.setAttribute("docdata",docdata);				
				req.setAttribute("l1id", l1id);
				req.setAttribute("l2id", l2id);
				req.setAttribute("l3id", l3id);
				req.setAttribute("projectdocid", docdata[5].toString());
			}
			
			
			
			return "documents/DocumentTemplateAdd";
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocumentTemplate.htm "+UserId, e);
			return "static/Error";
		}
	}
	
	
	
	@RequestMapping(value = "ItemContentCheckAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String ItemContentCheckAjax(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ItemContentCheckAjax.htm "+UserId);		
		try {			
			String templateitemid=req.getParameter("templateitemid");
			Gson json = new Gson();
			return json.toJson(service.TemplateContentList(templateitemid).size());	
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ItemContentCheckAjax.htm "+UserId, e);
			return "0";
		}
		
	}
	
	@RequestMapping(value = "DocTemplatePDF.htm", method = RequestMethod.POST)
	public void DocTemplatePDF(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocTemplatePDF.htm "+UserId);		
		try {
			String projectid=req.getParameter("projectid");
			String fileuploadmasterid=req.getParameter("fileuploadmasterid");
			List<PfmsDocTemplate> itemslist = service.PfmsDocTemplateList(projectid,fileuploadmasterid);
			
			 Object[] docdata = service.DocMasterDataPdocId(projectid, fileuploadmasterid);
			
//			req.setAttribute("doctemplatelist", service.PfmsDocTemplateList(projectdocid));
//			req.setAttribute("docdata",service.DocMasterDataPdocId(projectdocid));
			
			req.setAttribute("doctemplatelist",itemslist );
			req.setAttribute("docdata",docdata);
			

			String filename=docdata[2]+"- Layout";
			
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/documents/DocumentTemplate.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();			
			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
	        
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
			
			
//			return "documents/DocumentTemplate";
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocTemplatePDF.htm "+UserId, e);
//			return "0";
		}
	}
	
	@RequestMapping(value = "DocTemplateExcel.htm", method = RequestMethod.POST)
	public void DocTemplateExcel(Model model,HttpServletRequest req, HttpSession ses,  RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocTemplateExcel.htm "+UserId);		
		try {			
			String projectid=req.getParameter("projectid");
			String fileuploadmasterid=req.getParameter("fileuploadmasterid");
			 List<PfmsDocTemplate> itemslist = service.PfmsDocTemplateList(projectid, fileuploadmasterid);
			
			 Object[] docdata = service.DocMasterDataPdocId(projectid,fileuploadmasterid);
					
			@SuppressWarnings("resource")
			XSSFWorkbook workbook = new XSSFWorkbook();
			
			XSSFCellStyle  wrapname	 = workbook.createCellStyle();
		  	wrapname.setWrapText(true);
		  	wrapname.setBorderBottom(BorderStyle.THIN);
		  	wrapname.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		  	wrapname.setBorderLeft(BorderStyle.THIN);
		  	wrapname.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		  	wrapname.setBorderRight(BorderStyle.THIN);
		  	wrapname.setRightBorderColor(IndexedColors.BLACK.getIndex());
		  	wrapname.setBorderTop(BorderStyle.THIN);
		  	wrapname.setTopBorderColor(IndexedColors.BLACK.getIndex());
			
			XSSFSheet sheet = workbook.createSheet("Template");
			
			XSSFRow row = sheet.createRow((short) 0);
			XSSFCell cell = row.createCell((short) 0);
            cell.setCellValue(docdata[2].toString());
            sheet.addMergedRegion(new CellRangeAddress(
                    0, //  first row 
                    0, // last row 
                    0, // first column 
                    2  // last column 
                    ));
            XSSFCellStyle headercellstyle=cell.getCellStyle();
            headercellstyle.setAlignment(HorizontalAlignment.CENTER);
            cell.setCellStyle(headercellstyle);
			int rowNum = 1;
			int count =1;
			for(PfmsDocTemplate item : itemslist)
			{ 
				if(item.getLevelNo()==1)
				{
					XSSFRow row0 = sheet.createRow(rowNum++);
		 			
	 			    XSSFCell cell11 = row0.createCell(0);
	 			    cell11.setCellValue(count+")"+ item.getItemName());
	 			    cell11.setCellStyle(wrapname);
	 			    XSSFCell cell12 = row0.createCell(1);
	                cell12.setCellValue("");
	                cell12.setCellStyle(wrapname);
	                XSSFCell cell13 = row0.createCell(2);
	                cell13.setCellValue("");
	                cell13.setCellStyle(wrapname);
				    
				    
				    count++;
				    
				    int count1=1;
					for(PfmsDocTemplate item1 : itemslist)
					{ 
						if(item.getTemplateItemId() ==item1.getParentLevelId())
						{ 
							XSSFRow row1 = sheet.createRow(rowNum++);
							
							XSSFCell cell21 = row1.createCell(0);
							cell21.setCellValue("");
							cell21.setCellStyle(wrapname);
				 			XSSFCell cell22 = row1.createCell(1);
				 			cell22.setCellValue(count+"."+count1+")"+ item1.getItemName());
				 			cell22.setCellStyle(wrapname);
				            XSSFCell cell23 = row1.createCell(2);
				            cell23.setCellValue("");
				            cell23.setCellStyle(wrapname);
						    
						    int count2=1;
							for(PfmsDocTemplate item2 : itemslist)
							{ 
								if(item1.getTemplateItemId() ==item2.getParentLevelId())
								{ 
									XSSFRow row2 = sheet.createRow(rowNum++);
									
									XSSFCell cell31 = row2.createCell(0);
									cell31.setCellValue("");
									cell31.setCellStyle(wrapname);
						 			XSSFCell cell32 = row2.createCell(1);
						 			cell32.setCellValue("");
						 			cell32.setCellStyle(wrapname);
						            XSSFCell cell33 = row2.createCell(2);
						            cell33.setCellValue(count+"."+count1+"."+count2+")"+ item2.getItemName());
						            cell33.setCellStyle(wrapname);
								}
							}
						    
						}
					}
				}
			}
		    sheet.setColumnWidth(0,8000);
		    sheet.setColumnWidth(1,8000);
		    sheet.setColumnWidth(2,8000);
			
			ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
	        workbook.write(outByteStream);
	        byte [] outArray = outByteStream.toByteArray();
		
	        res.setContentType("application/ms-excel");
	        res.addHeader("Content-Disposition", "attachment;fileName="+docdata[2]+"-Template"+".xls");
	        
	        OutputStream outStream = res.getOutputStream();
	        outStream.write(outArray);
	        outStream.flush();
	        outStream.close();
	        outByteStream.close();
	        workbook.close();
			

		}catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocTemplateExcel.htm "+UserId, e);
//			return "static/Error";
		}
		
	}
	@RequestMapping(value = "TempItemNameEdit.htm", method = RequestMethod.POST)
	public String TempItemNameEdit(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside TempItemNameEdit.htm "+UserId);		
		try {			
			String itemname=req.getParameter("itemname");
			String templateitemid=req.getParameter("templateid");
			String action=req.getParameter("action");
			
			PfmsDocTemplate tempitem =new PfmsDocTemplate();
			tempitem.setTemplateItemId(Long.parseLong(templateitemid));
			tempitem.setModifiedBy(UserId);
			
			
			if(action.equalsIgnoreCase("E")) {
				tempitem.setItemName(itemname);
				long count = service.TemplateItemNameEdit(tempitem);
				
				if (count > 0) {
					redir.addAttribute("result", "Item Name Updated Successfully");
				} else {
					redir.addAttribute("resultfail", "Item Name Update Unsuccessful");
				}
			}
			if(action.equalsIgnoreCase("D")) {
				
				long count = service.TemplateItemDelete(tempitem);
				
				if (count > 0) {
					redir.addAttribute("result", "Item Deleted Successfully");
				} else {
					redir.addAttribute("resultfail", "Item Deleted Unsuccessful");
				}
			}
			
			redir.addFlashAttribute("fileuploadmasterid",req.getParameter("fileuploadmasterid"));
			redir.addFlashAttribute("projectid",req.getParameter("projectid"));
			redir.addFlashAttribute("l1id",req.getParameter("l1id"));
			redir.addFlashAttribute("l2id",req.getParameter("l2id"));
			redir.addFlashAttribute("l3id",req.getParameter("l3id"));
			return "redirect:/DocumentTemplate.htm";
			
		}catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside TempItemNameEdit.htm "+UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "TemplateItemAdd.htm", method = RequestMethod.POST)
	public String TemplateItemAdd(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside TemplateItemAdd.htm "+UserId);		
		try {
			
			String levelno=req.getParameter("levelno");
			String parentlevelid=req.getParameter("parentlevelid");
			String projectid=req.getParameter("projectid");
			String itemname=req.getParameter("itemname");
			String fileuploadmasterid=req.getParameter("fileuploadmasterid");
			
			PfmsDocTemplate tempitem =new PfmsDocTemplate();
			tempitem.setLevelNo(Integer.parseInt(levelno));
			tempitem.setParentLevelId(Long.parseLong(parentlevelid));
			tempitem.setProjectId(Long.parseLong(projectid));
			tempitem.setFileUploadMasterId(Long.parseLong(fileuploadmasterid));
			tempitem.setItemName(itemname.trim());
			tempitem.setCreatedBy(UserId);
			
			long count = service.TemplateItemAdd(tempitem);
			
			if (count > 0) {
				redir.addAttribute("result", "Item Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Item Adding Unsuccessful");
			}
			
			redir.addFlashAttribute("fileuploadmasterid",fileuploadmasterid);
			redir.addFlashAttribute("projectdocid",req.getParameter("projectdocid"));
			redir.addFlashAttribute("projectid",req.getParameter("projectid"));
			redir.addFlashAttribute("l1id",req.getParameter("l1id"));
			redir.addFlashAttribute("l2id",req.getParameter("l2id"));
			redir.addFlashAttribute("l3id",req.getParameter("l3id"));
			return "redirect:/DocumentTemplate.htm";
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside TemplateItemAdd.htm "+UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "ProjectDocsListAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String ProjectDocsListAjax(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectDocsListAjax.htm "+UserId);		
		try {			
			String projectid=req.getParameter("projectid");
			Gson json = new Gson();
			return json.toJson(service.ProjectDocsList(projectid));	
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectDocsListAjax.htm "+UserId, e);
			return null;
		}
		
	}
	
	@RequestMapping(value = "DocTempItemDataAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String DocTempItemDataAjax(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocTempItemDataAjax.htm "+UserId);		
		try {			
			String itemid=req.getParameter("itemid");
			String pfmsdocid=req.getParameter("pfmsdocid");
			Gson json = new Gson();
			return json.toJson(service.PfmsTempItemContent(itemid, pfmsdocid));
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocTempItemDataAjax.htm "+UserId, e);
			return null;
		}
		
	}
	
	
	@RequestMapping(value = "DocumentTempContent.htm")
	public String DocumentTempContent(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocumentTempContent.htm "+UserId);		
		try {			
			
			String projectid=req.getParameter("projectid");
			String filerepmasterid=req.getParameter("filerepmasterid");
			String fileuploadmasterid=req.getParameter("fileuploadmasterid");
			
			String pfmsdocid = req.getParameter("pfmsdocid");
			if(pfmsdocid==null) {
				Map md=model.asMap();
				pfmsdocid=(String)md.get("pfmsdocid");
			}
			
			if(pfmsdocid==null) {
				PfmsDoc pfmsdoc = service.ProjectDocCheck(projectid,filerepmasterid,fileuploadmasterid,  UserId);
				pfmsdocid = String.valueOf(pfmsdoc.getPfmsDocId());
			}
			
			Object[] pfmsdocdata = service.PfmsDocData(pfmsdocid);
			
			String headertext1=req.getParameter("headertext1");
			String headertext2=req.getParameter("headertext2");
			String systemids=req.getParameter("systemids");
			String docids=req.getParameter("docids");
			String collapseids=req.getParameter("collapseids");
			if(headertext1==null)
			{
				Map md=model.asMap();				
				headertext1=(String)md.get("headertext1");
				headertext2=(String)md.get("headertext2");				
				systemids=(String)md.get("systemids");
				docids=(String)md.get("docids");
				collapseids=(String)md.get("collapseids");
			}
			
			
			List<Object[]> tempitemlist = service.TempItemListwithContentId(pfmsdocid);
			
			
			
			req.setAttribute("headertext1",headertext1);
			req.setAttribute("headertext2",headertext2);
			req.setAttribute("systemids",systemids);
			req.setAttribute("docids",docids);
			redir.addFlashAttribute("collapseids",collapseids);
			
			req.setAttribute("docversionnos",service.DocRevisedVersionNos(pfmsdocid));
			req.setAttribute("pfmsdocdata",pfmsdocdata);
			req.setAttribute("tempitemlist",tempitemlist);
			return "documents/DocumentTempContent";
		}catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocumentTempContent.htm "+UserId, e);
			return "static/Error";
		}
		
	}
	
	@RequestMapping(value = "TempItemContentAdd.htm", method = RequestMethod.POST)
	public String TempItemContentAdd(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside TempItemContentAdd.htm "+UserId);		
		try {			
			String templateitemid=req.getParameter("templateitemid");
			String itemcontent = req.getParameter("itemcontent");
			String pfmsdocid=req.getParameter("pfmsdocid");
			
			
			PfmsDocContent tempitemcontent = new PfmsDocContent(); 
			tempitemcontent.setTemplateItemId(Long.parseLong(templateitemid));
			tempitemcontent.setPfmsDocId(Long.parseLong(pfmsdocid));
			tempitemcontent.setItemContent(itemcontent);
			tempitemcontent.setIsDependent(req.getParameter("isdependent"));
			tempitemcontent.setCreatedBy(UserId);
			
			long count = service.TempItemContentAdd(tempitemcontent);
			
			if (count > 0) {
				redir.addAttribute("result", "Content Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Content Addding Unsuccessful");
			}
			
			redir.addFlashAttribute("docids",req.getParameter("docids"));
			redir.addFlashAttribute("headertext1",req.getParameter("headertext1"));
			redir.addFlashAttribute("headertext2",req.getParameter("headertext2"));
			redir.addFlashAttribute("systemids",req.getParameter("systemids"));
			redir.addFlashAttribute("collapseids",req.getParameter("collapseids"));
			
			redir.addFlashAttribute("pfmsdocid",req.getParameter("pfmsdocid"));
			
			return "redirect:/DocumentTempContent.htm";
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside TempItemContentAdd.htm "+UserId, e);
			return null;
		}
		
	}
	
	@RequestMapping(value = "TempItemContentUpdate.htm", method = RequestMethod.POST)
	public String TempItemContentUpdate(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside TempItemContentUpdate.htm "+UserId);		
		try {			
			String templateitemid=req.getParameter("templateitemid");
			String pfmsdocid=req.getParameter("pfmsdocid");
			String itemcontent = req.getParameter("itemcontent");
			String tempcontentid =  req.getParameter("itemcontentid");
			
			
			PfmsDocContent tempitemcontent = new PfmsDocContent(); 
			tempitemcontent.setTempContentId(Long.parseLong(tempcontentid));
			tempitemcontent.setTemplateItemId(Long.parseLong(templateitemid));
			tempitemcontent.setPfmsDocId(Long.parseLong(pfmsdocid));
			tempitemcontent.setItemContent(itemcontent);
			tempitemcontent.setIsDependent(req.getParameter("isdependent"));
			tempitemcontent.setModifiedBy(UserId);
			
			long count = service.TempItemContentUpdate(tempitemcontent);
			
			if (count > 0) {
				redir.addAttribute("result", "Content Updated Successfully");
			} else {
				redir.addAttribute("resultfail", "Content Update Unsuccessful");
			}
			
			redir.addFlashAttribute("pfmsdocid",req.getParameter("pfmsdocid"));
			
			redir.addFlashAttribute("headertext1",req.getParameter("headertext1"));
			redir.addFlashAttribute("headertext2",req.getParameter("headertext2"));
			redir.addFlashAttribute("systemids",req.getParameter("systemids"));
			redir.addFlashAttribute("docids",req.getParameter("docids"));
			redir.addFlashAttribute("collapseids",req.getParameter("collapseids"));
			
			return "redirect:/DocumentTempContent.htm";
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside TempItemContentUpdate.htm "+UserId, e);
			return null;
		}
		
	}
	
	@RequestMapping(value = "DocDraftView.htm", method = RequestMethod.POST)
	public String DocDraftView(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocDraftView.htm "+UserId);		
		try {			
			String pfmsdocid=req.getParameter("pfmsdocid");
									
			Object[] docdata = service.PfmsDocData(pfmsdocid);
			List<PfmsDocTemplate> itemslist = service.PfmsDocTemplateList(docdata[1].toString(), docdata[3].toString());
			List<Object[]> contentlist = service.TempItemContentsList( pfmsdocid);
			req.setAttribute("itemslist", itemslist);
			req.setAttribute("docdata",docdata  );
			req.setAttribute("labdetails",service.LabDetails()  );
			req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(docdata[10].toString()));
			req.setAttribute("itemcontentlist", contentlist);
			req.setAttribute("linkslistmap", service.AllItemsLinksListDraft(contentlist));
			return "documents/DocUnrevised";
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocDraftView.htm "+UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "DocFreezeView.htm", method = RequestMethod.POST)
	public String DocFreezeView(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocFreezeView.htm "+UserId);		
		try {			
			String pfmsdocid=req.getParameter("pfmsdocid");
									
			Object[] docdata = service.PfmsDocData(pfmsdocid);
			List<PfmsDocContentFreeze> contentlist = service.PfmsDocContentFrzData(pfmsdocid);			
			req.setAttribute("contentlist", contentlist);
			req.setAttribute("linkslistmap", service.AllItemsLinksList(contentlist));
			req.setAttribute("docdata",docdata  );
			req.setAttribute("labdetails",service.LabDetails()  );
			req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(docdata[10].toString()));
			
			req.setAttribute("itemcontentlist", service.PfmsDocContentFrzData(pfmsdocid));
			
			
			return "documents/DocFrozen";
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocFreezeView.htm "+UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "DocDraftDownload.htm", method = RequestMethod.POST)
	public void DocCreateDownload(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocDraftDownload.htm "+UserId);		
		try {			
			String pfmsdocid=req.getParameter("pfmsdocid");
			Object[] docdata = service.PfmsDocData(pfmsdocid); 
			
			
			List<PfmsDocTemplate> itemslist = service.PfmsDocTemplateList(docdata[1].toString(), docdata[3].toString());
			List<Object[]> contentlist = service.TempItemContentsList( pfmsdocid);	
			req.setAttribute("itemslist", itemslist);
			req.setAttribute("docdata",docdata);
			req.setAttribute("labdetails",service.LabDetails()  );
			req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(docdata[10].toString()));
			req.setAttribute("itemcontentlist", contentlist);
			req.setAttribute("linkslistmap", service.AllItemsLinksListDraft(contentlist));
			
			String filename=docdata[6].toString();			
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/documents/DocUnrevised.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();			
			HtmlConverter.convertToPdf(html, new FileOutputStream(path+File.separator+filename+".pdf"));
	        
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
			
			
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocDraftDownload.htm "+UserId, e);
		}
	}
	@RequestMapping(value = "DocVersionDownload.htm", method = RequestMethod.POST)
	public void DocNewVersionView(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocVersionDownload.htm "+UserId);		
		try {			
			String pfmsdocid=req.getParameter("pfmsdocid");
			String versionno=req.getParameter("versionno");			
			
			List<PfmsDocContentRev> contentlist = service.PfmsDocContentRevData(pfmsdocid, versionno);
			Object[] docdata = service.PfmsDocData(pfmsdocid);
			req.setAttribute("contentlist",contentlist );
			req.setAttribute("docdata",docdata  );
			req.setAttribute("labdetails",service.LabDetails()  );
			req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(docdata[10].toString()));
			req.setAttribute("linkslistmap", service.AllItemsLinksListRev(contentlist));
			
			String filename=docdata[6].toString();			
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/documents/DocRevised.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();			
			HtmlConverter.convertToPdf(html, new FileOutputStream(path+File.separator+filename+".pdf"));
	        
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
			
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocVersionDownload.htm "+UserId, e);
		}
	}
	
	
	@RequestMapping(value = "DocFreezeDownload.htm", method = RequestMethod.POST)
	public void DocFreezeDownload(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocFreezeDownload.htm "+UserId);		
		try {			
			String pfmsdocid=req.getParameter("pfmsdocid");
			
			Object[] docdata = service.PfmsDocData(pfmsdocid);
			List<PfmsDocContentFreeze> contentlist = service.PfmsDocContentFrzData(pfmsdocid);
			req.setAttribute("contentlist", contentlist);
			req.setAttribute("linkslistmap", service.AllItemsLinksList(contentlist));
			req.setAttribute("docdata",docdata  );
			req.setAttribute("labdetails",service.LabDetails()  );
			req.setAttribute("lablogo", LogoUtil.getLabLogoAsBase64String(docdata[10].toString()));
			
			
			String filename=docdata[6].toString();			
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/documents/DocFrozen.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();			
			HtmlConverter.convertToPdf(html, new FileOutputStream(path+File.separator+filename+".pdf"));
	        
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
			
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocFreezeDownload.htm "+UserId, e);
		}
	}
	
	
	@RequestMapping(value = "PfmsDocRevise.htm", method = RequestMethod.POST)
	public String PfmsDocRevise(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside PfmsDocRevise.htm "+UserId);		
		try {			
			String projectdocid=req.getParameter("projectdocid");
			String pfmsdocid=req.getParameter("pfmsdocid");			
			
			long count =service.PfmsDocContentRevision(projectdocid, pfmsdocid, UserId);
			
			if (count > 0) {
				redir.addAttribute("result", "Document Revised Successfully");
			} else {
				redir.addAttribute("resultfail", "Document Revision Unsuccessful");
			}
			
			redir.addFlashAttribute("pfmsdocid",req.getParameter("pfmsdocid"));
			
			redir.addFlashAttribute("headertext1",req.getParameter("headertext1"));
			redir.addFlashAttribute("headertext2",req.getParameter("headertext2"));
			redir.addFlashAttribute("systemids",req.getParameter("systemids"));
			redir.addFlashAttribute("docids",req.getParameter("docids"));
			
			return "redirect:/DocumentTempContent.htm";
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside PfmsDocRevise.htm "+UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "PfmsDocFreeze.htm", method = RequestMethod.POST)
	public String PfmsDocFreeze(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir,HttpServletResponse res)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside PfmsDocFreeze.htm "+UserId);		
		try {			
			String projectdocid=req.getParameter("projectdocid");
			String pfmsdocid=req.getParameter("pfmsdocid");			
			
			long count =service.pfmsDocContentFreeze(projectdocid, pfmsdocid, UserId);
			
			if (count > 0) {
				redir.addAttribute("result", "Document Frozen Successfully");
			} else {
				redir.addAttribute("resultfail", "Document Freezing Unsuccessful");
			}
			
			redir.addFlashAttribute("pfmsdocid",req.getParameter("pfmsdocid"));			
			redir.addFlashAttribute("headertext1",req.getParameter("headertext1"));
			redir.addFlashAttribute("headertext2",req.getParameter("headertext2"));
			redir.addFlashAttribute("systemids",req.getParameter("systemids"));
			redir.addFlashAttribute("docids",req.getParameter("docids"));
			
			return "redirect:/DocumentTempContent.htm";
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside PfmsDocFreeze.htm "+UserId, e);
			return "static/Error";
		}
	}
	
	
	
	
	
	@RequestMapping(value = "DocProjectSystemsAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String DocProjectSystemsAjax(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocProjectSystemsAjax.htm "+UserId);		
		try {			
			String projectid=req.getParameter("projectid");
			Gson json = new Gson();
			return json.toJson(service.DocProjectSystems(projectid));	
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocProjectSystemsAjax.htm "+UserId, e);
			return "0";
		}
	}
	
	@RequestMapping(value = "ProjectDocsAllAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String ProjectDocsAllAjax(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectDocsAllAjax.htm "+UserId);		
		try {			
			String filerepmasterid=req.getParameter("filerepmasterid");
			Gson json = new Gson();
			return json.toJson(service.ProjectDocsAllAjax(filerepmasterid));	
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProjectDocsAllAjax.htm "+UserId, e);
			return "0";
		}
	}
	
	@RequestMapping(value = "DocItemsAllAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String DocItemsAllAjax(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocItemsAllAjax.htm "+UserId);		
		try {			
			String pfmsdocid=req.getParameter("pfmsdocid");
			String mainitemcontentid=req.getParameter("mainitemcontentid");
			Gson json = new Gson();
			return json.toJson(service.RevisedItemNamesList(pfmsdocid,mainitemcontentid));	
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocItemsAllAjax.htm "+UserId, e);
			return "0";
		}
		
	}
	
	@RequestMapping(value = "ItemContentAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String ItemContentAjax(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ItemContentAjax.htm "+UserId);		
		try {			
			String tempcontentrevid=req.getParameter("tempcontentrevid");
			Gson json = new Gson();
			return json.toJson(service.RevisedItemContent(tempcontentrevid));	
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ItemContentAjax.htm "+UserId, e);
			return "0";
		}		
	}
	
	
	@RequestMapping(value = "DocContentLinkAdd.htm", method = RequestMethod.POST)
	public String DocContentLinkAdd(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DocContentLinkAdd.htm "+UserId);		
		try {
			String mainitemcontentid=req.getParameter("mainitemcontentid");
//			String mainiversoionno=req.getParameter("mainiversoionno");
			String linkitemcontentid=req.getParameter("linkitemcontentid");
//			String linkversoionno=req.getParameter("linkversoionno");
			
			PfmsDocContentLinks link= new PfmsDocContentLinks();
			link.setMainTempContentId(Long.parseLong(mainitemcontentid));
//			link.setMainVersionNo(Integer.parseInt(mainiversoionno));
			link.setLinkedTempContentId(Long.parseLong(linkitemcontentid));
//			link.setLinkVersionNo(Integer.parseInt(linkversoionno));
			link.setCreatedBy(UserId);
			
			long count = service.pfmsDocContentLinkAdd(link);
			
			if (count > 0) {
				redir.addAttribute("result", "Item Link Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Item Link Adding Unsuccessful");
			}
			
			redir.addFlashAttribute("docids",req.getParameter("docids"));
			redir.addFlashAttribute("headertext1",req.getParameter("headertext1"));
			redir.addFlashAttribute("headertext2",req.getParameter("headertext2"));
			redir.addFlashAttribute("systemids",req.getParameter("systemids"));
			redir.addFlashAttribute("collapseids",req.getParameter("collapseids"));
			
			redir.addFlashAttribute("pfmsdocid",req.getParameter("pfmsdocid"));
			
			return "redirect:/DocumentTempContent.htm";
			
		}catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside DocContentLinkAdd.htm "+UserId, e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value = "ItemsFrzContentAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String ItemsFrzContentAjax(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ItemsFrzContentAjax.htm "+UserId);		
		try {			
			String tempcontentfrzid=req.getParameter("tempcontentfrzid");
			Gson json = new Gson();
			return json.toJson(service.TempContentFrz(tempcontentfrzid));	
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ItemsFrzContentAjax.htm "+UserId, e);
			return "0";
		}
		
	}
	
	@RequestMapping(value = "ItemLinksListAjax.htm", method = RequestMethod.GET)
	public @ResponseBody String ItemLinksListAjax(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ItemLinksListAjax.htm "+UserId);		
		try {			
			String maintempcontentid=req.getParameter("maintempcontentid");
			Gson json = new Gson();
			return json.toJson(service.ItemLinksList(maintempcontentid));	
		}
		catch (Exception e) 
		{
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ItemLinksListAjax.htm "+UserId, e);
			return "0";
		}		
	}
		
}