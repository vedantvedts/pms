package com.vts.pfms.ms.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.vts.pfms.ms.service.MSReqService;

@Controller
public class MSReqController {

	private static final Logger logger = LogManager.getLogger(MSReqController.class);
	
	@Autowired
	MSReqService service;
	
	@Value("${IsClusterLab}")
	String isClusterLab;
	
	@RequestMapping(value="SyncDataFromClusterLabs.htm", method= { RequestMethod.POST, RequestMethod.GET})
	public String syncDataFromClusterLabs(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside SyncDataFromClusterLabs.htm "+UserId);
		try {
			if(isClusterLab!=null && isClusterLab.equalsIgnoreCase("Y"))
			service.syncDataFromClusterLabs();
			
			return "redirect:/MainDashBoard.htm";
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside SyncDataFromClusterLabs.htm "+UserId, e);
			return "static/Error";
		}
	}

//	@Scheduled(cron = "0 0 */4 * * *")
//	public void syncDataFromClusterLabsScheduler() throws Exception {
//		logger.info(new Date() +" Inside syncDataFromClusterLabsScheduler() ");
//		try {
//			
//			if(isClusterLab!=null && isClusterLab.equalsIgnoreCase("Y"))
//			service.syncDataFromClusterLabs();
//
//		}catch (Exception e) {
//			e.printStackTrace();
//			logger.error(new Date()+" Inside syncDataFromClusterLabsScheduler() "+ e);
//		}
//	}
}
