package com.vts.pfms.producttree.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vts.pfms.milestone.service.MilestoneService;
import com.vts.pfms.producttree.dto.ProductTreeDto;
import com.vts.pfms.producttree.service.ProductTreeService;



@Controller
public class ProductTreeController {
	
	@Autowired
	MilestoneService milservice;
	
	@Autowired
	ProductTreeService service;
	
	
	
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
	        
	        System.out.println("viewmode---"+viewmode);
	       
	        req.setAttribute("ProjectList",projlist);
			req.setAttribute("ProjectId", ProjectId);
	        
			
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
		//String Logintype= (String)ses.getAttribute("LoginType");
		//String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		//String LabCode = (String)ses.getAttribute("labcode");
		logger.info(new Date() +"Inside LevelNameAdd.htm "+UserId);		
		try {
			
			String split=req.getParameter("Split");
              if (split != null && !split.equals("null")) {
				
				String arr[] = split.split("#");
	        String ProjectId=arr[0];
	        String LevelId=arr[1];
	        String ParentLevelId=arr[2];
	        
	        
	        String LevelName=req.getParameter("LevelName");
	        
	       
	        ProductTreeDto dto=new ProductTreeDto();
	        dto.setProjectId(Long.parseLong(ProjectId));
	        dto.setParentLevelId(Long.parseLong(ParentLevelId));
	        dto.setLevelId(LevelId);
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
			if(ProjectId!=null) {
				req.setAttribute("ProjectDetails", milservice.ProjectDetails(ProjectId).get(0));
			}else {
				req.setAttribute("ProjectDetails", milservice.ProjectDetails(ProjectId));
			}
			
			String Action=req.getParameter("Action");
			
			
			if(Action!=null && Action.equalsIgnoreCase("E")) {

			
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
				 return "redirect:/ProductTreeEditDelete.htm";
				 
			 }else {
				 redir.addAttribute("resultfail", "Level Name Update Unsuccessful");
				 redir.addAttribute("ProjectId", ProjectId);
				 return "redirect:/ProductTreeEditDelete.htm";
			 }
			
	      } else if(Action!=null && Action.equalsIgnoreCase("D")) {
	    	  
	    	  System.out.println("Mainid---"+req.getParameter("Mainid")); 
	    	  ProductTreeDto dto=new ProductTreeDto();
	    	  dto.setMainId(Long.parseLong(req.getParameter("Mainid")));
	    	  long delete = service.LevelNameEdit(dto,Action);
	    	  if(delete!=0) {
					 redir.addAttribute("result", "Level Deleted Successfully");
					 redir.addAttribute("ProjectId", ProjectId);
					 return "redirect:/ProductTreeEditDelete.htm";
					 
				 }else {
					 redir.addAttribute("resultfail", "Level Delete  Unsuccessful");
					 redir.addAttribute("ProjectId", ProjectId);
					 return "redirect:/ProductTreeEditDelete.htm";
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
	
}
