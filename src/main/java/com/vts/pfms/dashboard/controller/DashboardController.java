package com.vts.pfms.dashboard.controller;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.vts.pfms.header.service.HeaderService;
import com.vts.pfms.service.RfpMainService;

@Controller
public class DashboardController {
	@Autowired
	RfpMainService rfpmainservice;
	
	@Autowired
	HeaderService headerservice;
	private static final Logger logger=LogManager.getLogger(DashboardController.class);
	
	
    @RequestMapping(value = "DasboardCircularProgress.htm", method = RequestMethod.GET)
	public @ResponseBody String DasboardCircularProgress(HttpServletRequest req,HttpSession ses) throws Exception
    {
    		Object[]projecthealthtotal=null;
    		String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
    		String LoginType = (String) ses.getAttribute("LoginType");
    		String LabCode = (String) ses.getAttribute("labcode");
    		String DashBoardId = (String) ses.getAttribute("DashBoardId");
    		try {
    	
    		projecthealthtotal = rfpmainservice.ProjectHealthTotalData("A", EmpId, LoginType, LabCode, "Y");
    	
    		if(DashBoardId!=null && !DashBoardId.equalsIgnoreCase("0")) {
    			projecthealthtotal = headerservice.projecthealthtotalDashBoardwise(DashBoardId,LabCode);
    		}
    		Gson json = new Gson();
    		return json.toJson(projecthealthtotal);
    		}
    		catch (Exception e) {
				
			}
    	
    	return null;
    }
    @RequestMapping(value = "FinaceCardWiseData.htm", method = RequestMethod.GET)
    public @ResponseBody String FinaceCardWiseData(HttpServletRequest req,HttpSession ses) throws Exception 
    {
    	String EmpId = ((Long) ses.getAttribute("EmpId")).toString();
		String LoginType = (String) ses.getAttribute("LoginType");
		String LabCode = (String) ses.getAttribute("labcode");
		String DashBoardId = (String) ses.getAttribute("DashBoardId");
		String ClusterId = (String) ses.getAttribute("clusterid");
    	try {
    		
    		List<Object[]>DashboardFinance = rfpmainservice.DashboardFinance(LoginType, EmpId, LabCode, ClusterId);
    		
    		if(DashBoardId!=null && !DashBoardId.equalsIgnoreCase("0")) {
    			DashboardFinance = headerservice.DashboardFinanceProjectWise(DashBoardId,LabCode);
    		}
    		Gson json = new Gson();
    		return json.toJson(DashboardFinance);
    	}
    	catch (Exception e) {
    		
    	}
    	
    	return null;
    }
}
