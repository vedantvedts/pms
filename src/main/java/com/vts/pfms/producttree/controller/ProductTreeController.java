package com.vts.pfms.producttree.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.milestone.service.MilestoneService;
import com.vts.pfms.producttree.dto.ProductTreeDto;
import com.vts.pfms.producttree.model.ProductTreeRev;
import com.vts.pfms.producttree.service.ProductTreeService;



@Controller
public class ProductTreeController {
	
	@Autowired
	MilestoneService milservice;
	
	@Autowired
	ProductTreeService service;
	
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	FormatConverter fc=new FormatConverter();
	private  SimpleDateFormat rdf=fc.getRegularDateFormat();
	private  SimpleDateFormat sdf=fc.getSqlDateFormat();
	private  SimpleDateFormat sdtf=fc.getSqlDateAndTimeFormat();
	private  SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
	
	private static final Logger logger=LogManager.getLogger(ProductTreeController.class);
	
	@RequestMapping(value = "ProductTree.htm")
	public String ProductTree(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		
		String UserId = (String) ses.getAttribute("Username");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProductTree.htm "+UserId);		
		try {
			
			
	        String ProjectId=req.getParameter("ProjectId");
	        if(ProjectId==null)  {
				Map md=model.asMap();
				ProjectId=(String)md.get("ProjectId");
			}	
	        List<Object[] > projlist= milservice.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	        
	        if(projlist.size()==0) 
	        {				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}
	        
	        if(ProjectId==null) {
	        	try {
	        		Object[] pro=projlist.get(0);
	        		ProjectId=pro[0].toString();
	        	}catch (Exception e) {
					
				}
	        }
	        
	        String viewmode=req.getParameter("view_mode");
	        
	       
	       
	        req.setAttribute("ProjectList",projlist);
			req.setAttribute("ProjectId", ProjectId);
			req.setAttribute("RevisionCount", service.getRevisionCount(ProjectId));
	        
			
			if(ProjectId!=null) {
			      req.setAttribute("ProjectDetails", milservice.ProjectDetails(ProjectId).get(0));
			}
			else {
				
				req.setAttribute("ProjectDetails", milservice.ProjectDetails(ProjectId));
			}
			
			req.setAttribute("ProductTreeList",service.getProductTreeList(ProjectId) );

			
			
			 if(viewmode!=null && viewmode.toString().equalsIgnoreCase("Y")) {
				 
				 return "producttree/ProductTreeView";
			 }
			 else if(viewmode!=null && viewmode.toString().equalsIgnoreCase("V")) {
				 
				 return "producttree/ProductTreeViewH";
			 }
			 
			 else {
				 
				 return "producttree/ProductTreeAdd";
				 
			 }
			
			
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProductTree.htm "+UserId, e); 
			return "static/Error";
			
		}
		
	}

	
	@RequestMapping(value = "LevelNameAdd.htm" )
	public String LevelNameAdd(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		
		String UserId = (String) ses.getAttribute("Username");
		
		logger.info(new Date() +"Inside LevelNameAdd.htm "+UserId);		
		try {
			
			String split=req.getParameter("Split");
              if (split != null && !split.equals("null")) {
				
				String arr[] = split.split("#");
	        String ProjectId=arr[0];
	        String LevelId=arr[1];
	        String ParentLevelId=arr[2];
	        String SubLevelId=arr[3];
	        
	        
	        String LevelName=req.getParameter("LevelName");
	        
	       
	        ProductTreeDto dto=new ProductTreeDto();
	        dto.setProjectId(Long.parseLong(ProjectId));
	        dto.setParentLevelId(Long.parseLong(ParentLevelId));
	        dto.setLevelId(LevelId);
	        dto.setSubLevelId(SubLevelId);
	        dto.setLevelName(LevelName);
	        dto.setCreatedBy(UserId);
	        
	        
	        long result=service.AddLevelName(dto);
	        
              
			if(result!=0) {
			      
				redir.addAttribute("result", "Level Name Added Successfully");
			} else {
				redir.addAttribute("resultfail", "Level Name Add Unsuccessful");
			}
               redir.addAttribute("ProjectId", ProjectId);
               return "redirect:/ProductTree.htm";
               
              }    
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside LevelNameAdd.htm "+UserId, e); 
			return "static/Error";
			
		}
		return "redirect:/ProductTree.htm";
		
	}
	
	@RequestMapping(value = "ProductTreeEditDelete.htm")
	public String ProductTreeEditDelete(Model model,HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		
		String UserId = (String) ses.getAttribute("Username");
		String Logintype= (String)ses.getAttribute("LoginType");
		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside ProductTreeEditDelete.htm "+UserId);		
		try {
	        String ProjectId=req.getParameter("ProjectId");
	       
	        if(ProjectId==null)  {
				Map md=model.asMap();
				ProjectId=(String)md.get("ProjectId");
			}	
	        List<Object[] > projlist= milservice.LoginProjectDetailsList(EmpId,Logintype,LabCode);
	        
	        if(projlist.size()==0) 
	        {				
				redir.addAttribute("resultfail", "No Project is Assigned to you.");
				return "redirect:/MainDashBoard.htm";
			}
	        
	        
	        
	        if(ProjectId==null) {
	        	try {
	        		Object[] pro=projlist.get(0);
	        		ProjectId=pro[0].toString();
	        	}catch (Exception e) {
					
				}
	        }
	        List<Object[]> main=service.getProductTreeList(ProjectId);
			req.setAttribute("ProductTreeList",main );
			req.setAttribute("ProjectList",projlist);
			req.setAttribute("ProjectId", ProjectId);
			String id=req.getParameter("id");
			if(id!=null) {
				
			     req.setAttribute("id", id);
			}
			
			
			if(ProjectId!=null) {
				req.setAttribute("ProjectDetails", milservice.ProjectDetails(ProjectId).get(0));
			}else {
				req.setAttribute("ProjectDetails", milservice.ProjectDetails(ProjectId));
			}
			
			String Action=req.getParameter("Action");
			
			
			if(Action!=null && (Action.equalsIgnoreCase("E")|| Action.equalsIgnoreCase("TE"))) {

			
			 ProductTreeDto dto=new ProductTreeDto();
			 dto.setLevelName(req.getParameter("LevelName"));
			 dto.setMainId(Long.parseLong(req.getParameter("Mainid")));
			 dto.setStage(req.getParameter("Stage"));
			 dto.setModule(req.getParameter("Module"));
			 dto.setModifiedBy(UserId);
			
			 
			 long update = service.LevelNameEdit(dto,Action);
			 if(update!=0) {
			 
				 redir.addAttribute("result", "Level Name Updated Successfully");
			     redir.addAttribute("ProjectId", ProjectId);
			     redir.addAttribute("id",req.getParameter("buttonid"));
				 if(Action.equalsIgnoreCase("E")) {
				 
				 return "redirect:/ProductTreeEditDelete.htm";
				 }
				 else {
					 return "redirect:/ProductTree.htm";
					 
				 }
				 
			 }else {
				 redir.addAttribute("resultfail", "Level Name Update Unsuccessful");
				 redir.addAttribute("ProjectId", ProjectId);
				 redir.addAttribute("id",req.getParameter("buttonid"));
				 if(Action.equalsIgnoreCase("E")) {
				 return "redirect:/ProductTreeEditDelete.htm";
				 }
				 else {
					 return "redirect:/ProductTree.htm";
					 
				 }
			 }
			
	      } else if(Action!=null && (Action.equalsIgnoreCase("D")|| Action.equalsIgnoreCase("TD")) ) {
	    	  
	    	  
	    	 
	    	  ProductTreeDto dto=new ProductTreeDto();
	    	  dto.setMainId(Long.parseLong(req.getParameter("Mainid")));
	    	  long delete = service.LevelNameEdit(dto,Action);
	    	  if(delete!=0) {
					 redir.addAttribute("result", "Level Deleted Successfully");
					 redir.addAttribute("ProjectId", ProjectId);
					 redir.addAttribute("id",req.getParameter("buttonid"));
					 
					 if(Action.equalsIgnoreCase("D")) {
						 return "redirect:/ProductTreeEditDelete.htm";
						 }
						 else {
							 return "redirect:/ProductTree.htm";
							 
						 }
					 
					 
					 
				 }else {
					 redir.addAttribute("resultfail", "Level Delete Unsuccessful");
					 redir.addAttribute("ProjectId", ProjectId);
					 redir.addAttribute("id",req.getParameter("buttonid"));
					 
					 
					 if(Action.equalsIgnoreCase("D")) {
						 return "redirect:/ProductTreeEditDelete.htm";
						 }
						 else {
							 return "redirect:/ProductTree.htm";
							 
						 }
					 
				 }
	    		  
	      }
			
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProductTreeEditDelete.htm "+UserId, e); 
			return "static/Error";
			
		}
		return "producttree/ProductTreeEditDelete";
	}
	
	
	@RequestMapping(value = "ProductTreeRevise.htm")
	public String ProductTreeRevise(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		
		String UserId = (String) ses.getAttribute("Username");
		
		logger.info(new Date() +"Inside ProductTreeRevise.htm "+UserId);		
		try {
			
			
	        String ProjectId=req.getParameter("ProjectId");
	       String RevisionCount=req.getParameter("REVCount");
	      
			req.setAttribute("ProjectId", ProjectId);
			List<Object[]> ProductTreeList=service.getProductTreeList(ProjectId);
	        req.setAttribute("ProductTreeList",ProductTreeList );
	        req.setAttribute("ProjectDetails", milservice.ProjectDetails(ProjectId));
	        req.setAttribute("RevisionCount", service.getRevisionCount(ProjectId));
	        
	      
	        
	        long save=0;
	        if(ProductTreeList.size()>0) {
	        	
	        	for(Object[] obj :ProductTreeList) {
	        		
	        		ProductTreeRev rev=new ProductTreeRev();
	        		
	        		rev.setMainId(Long.parseLong(obj[0].toString()));
	        		rev.setProjectId(Long.parseLong(obj[4].toString()));
	        		rev.setParentLevelId(Long.parseLong(obj[1].toString()));
	        		rev.setLevelId(obj[2].toString());
	        		rev.setLevelName(obj[3].toString());
	        		rev.setStage(obj[6]!=null?obj[6].toString():null);
	        		rev.setModule(obj[7]!=null?obj[7].toString():null);
	        		rev.setRevisionNo(RevisionCount);
	        		rev.setCreatedBy(UserId);
	        		rev.setCreatedDate(fc.getSqlDateAndTimeFormat().format(new Date()));
	        		rev.setIsActive(1);
	        		
	        	     save = service.ProductTreeRevise(rev);
	        	     
	        	  }
	        	}
	         
			 if(save!=0) {
				 
				 redir.addAttribute("result", "Product Tree Revision " +RevisionCount+ " Successful");
				 redir.addAttribute("ProjectId", ProjectId);
				 return "redirect:/ProductTree.htm";
				 
			 }else {
				 
				 redir.addAttribute("resultfail", "Product Tree Revision " +RevisionCount+ " Unsuccessfull");
				 redir.addAttribute("ProjectId", ProjectId);
				 return "redirect:/ProductTree.htm";
			 
	         	
	        }
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProductTreeRevise.htm "+UserId, e); 
			return "static/Error";
			
		}
		
	}

	
	
	@RequestMapping(value = "ProductTreeRevisionData.htm")
	public String ProductTreeRevisionData(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception 
	{
		
		String UserId = (String) ses.getAttribute("Username");
		
		logger.info(new Date() +"Inside ProductTreeRevisionData.htm "+UserId);		
		try {
			
			
	        String ProjectId=req.getParameter("ProjectId");
	        String RevisionCount=req.getParameter("revCount");
	      
	      
			req.setAttribute("projectid", ProjectId);
			List<Object[]> getProductRevTreeList=service.getProductRevTreeList(ProjectId,RevisionCount);
	        req.setAttribute("ProductRevTreeList",getProductRevTreeList );
	        req.setAttribute("ProjectDetails", milservice.ProjectDetails(ProjectId));
	        req.setAttribute("RevisionCount", service.getRevisionCount(ProjectId));
	        req.setAttribute("RevCount", RevisionCount);
	        
	       return "producttree/ProductTreeRevision";
	      
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProductTreeRevisionData.htm "+UserId, e); 
			return "static/Error";
			
		}
		
		
	}
	
	
	
	@RequestMapping(value = {"ProductTreeDownload.htm"})
	public void ProductTreeDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProductTreeDownload.htm "+UserId);
		try
		{
			
			//String ProjectId=req.getParameter("ProjectId");
			
			req.setAttribute("ProductTreeList",service.getProductTreeList("65") );
			req.setAttribute("ProjectDetails", milservice.ProjectDetails("65"));
		    String filename="ProductTree";	
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
			CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/ProductTreeView.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();

			HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf"));
			PdfWriter pdfw=new PdfWriter(path +File.separator+ "merged.pdf");
			PdfReader pdf1=new PdfReader(path+File.separator+filename+".pdf");
			PdfDocument pdfDocument = new PdfDocument(pdf1, pdfw);	
			pdfDocument.close();
			pdf1.close();	       
			pdfw.close();

			res.setContentType("application/pdf");
			res.setHeader("Content-Disposition", "attachment; filename=\"ProductTreeView.jsp\"");

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
    		logger.error(new Date() +" Inside ProductTreeDownload.htm "+UserId, e);
    		e.printStackTrace();
    	}
		
	}
	
	
	/*
	 * @RequestMapping(value = "ProductTreeDownload.htm", method =
	 * RequestMethod.GET) public @ResponseBody String
	 * ProductTreeDownload(HttpServletRequest req,HttpSession ses) throws Exception
	 * {
	 * 
	 * String UserId = (String)ses.getAttribute("Username"); logger.info(new Date()
	 * +" Inside ProductTreeDownload.htm "+ UserId); String
	 * ProjectId=req.getParameter("ProjectId");
	 * System.out.println("ProjectId---"+ProjectId);
	 * 
	 * List<Object[]> ProductTreeList = service.getProductTreeList(ProjectId); Gson
	 * json = new Gson(); return json.toJson(ProductTreeList); }
	 */
	
}
