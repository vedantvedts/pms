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
	        
	        req.setAttribute("ProjectList",projlist);
			req.setAttribute("ProjectId", ProjectId);
	        
			
			if(ProjectId!=null) {
			      req.setAttribute("ProjectDetails", milservice.ProjectDetails(ProjectId).get(0));
			}
			else {
				
				req.setAttribute("ProjectDetails", milservice.ProjectDetails(ProjectId));
			}
			
			req.setAttribute("ProductTreeList",service.getProductTreeList(ProjectId) );
			
//	        List<Object[]> main=service.MilestoneActivityList(ProjectId);
//			req.setAttribute("MilestoneActivityList",main );
			
//			if(ProjectId!=null) {
//				req.setAttribute("ProjectDetails", service.ProjectDetails(ProjectId).get(0));
//				int MainCount=1;
//				for(Object[] objmain:main ) {
//				 int countA=1;
//					List<Object[]>  MilestoneActivityA=service.MilestoneActivityLevel(objmain[0].toString(),"1");
//					req.setAttribute(MainCount+"MilestoneActivityA", MilestoneActivityA);
//					for(Object[] obj:MilestoneActivityA) {
//						List<Object[]>  MilestoneActivityB=service.MilestoneActivityLevel(obj[0].toString(),"2");
//						req.setAttribute(MainCount+"MilestoneActivityB"+countA, MilestoneActivityB);
//						int countB=1;
//						for(Object[] obj1:MilestoneActivityB) {
//							List<Object[]>  MilestoneActivityC=service.MilestoneActivityLevel(obj1[0].toString(),"3");
//							req.setAttribute(MainCount+"MilestoneActivityC"+countA+countB, MilestoneActivityC);
//							int countC=1;
//							for(Object[] obj2:MilestoneActivityC) {
//								List<Object[]>  MilestoneActivityD=service.MilestoneActivityLevel(obj2[0].toString(),"4");
//								req.setAttribute(MainCount+"MilestoneActivityD"+countA+countB+countC, MilestoneActivityD);
//								int countD=1;
//								for(Object[] obj3:MilestoneActivityD) {
//									List<Object[]>  MilestoneActivityE=service.MilestoneActivityLevel(obj3[0].toString(),"5");
//									req.setAttribute(MainCount+"MilestoneActivityE"+countA+countB+countC+countD, MilestoneActivityE);
//									countD++;
//								}
//								countC++;
//							}
//							countB++;
//						}
//						countA++;
//					}
//					MainCount++;
//				}
			
		}
		catch (Exception e) {
			e.printStackTrace(); 
			logger.error(new Date() +" Inside ProductTree.htm "+UserId, e); 
			return "static/Error";
			
		}
		return "milestone/MilestoneProductTree";
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
	
	
}
