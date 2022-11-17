package com.vts.pfms.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.vts.pfms.committee.controller.ActionController;
import com.vts.pfms.service.RfpMainService;

@Controller
public class PfmsMainController {
	@Autowired
	RfpMainService service;

	private static final Logger logger=LogManager.getLogger(PfmsMainController.class);
	@RequestMapping(value = "AdminDashBoard.htm", method = RequestMethod.GET)
	public String AdminDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside AdminDashBoard.htm "+UserId);		
		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("1", LogId));

		return "admin/AdminDashBoard";
	}

	@RequestMapping(value = "MasterDashBoard.htm", method = RequestMethod.GET)
	public String MasterDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside MasterDashBoard.htm "+UserId);	
		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("2", LogId));
		return "master/MasterDashBoard";
	}

	@RequestMapping(value = "ProjectDashBoard.htm", method = RequestMethod.GET)
	public String ProjectDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectDashBoard.htm "+UserId);	
		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("3", LogId));
		return "project/ProjectDashBoard";
	}

	@RequestMapping(value = "BudgetDashBoard.htm", method = RequestMethod.GET)
	public String BudgetDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside BudgetDashBoard.htm "+UserId);	
		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("4", LogId));
		return "budget/BudgetDashBoard";
	}

	@RequestMapping(value = "DemandDashBoard.htm", method = RequestMethod.GET)
	public String DemandDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside DemandDashBoard.htm "+UserId);	
		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("5", LogId));
		
		return "demand/DemandDashBoard";
	}

	
	
	@RequestMapping(value = "ApprovalDashBoard.htm", method = RequestMethod.GET)
	public String ApprovalDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ApprovalDashBoard.htm "+UserId);	
		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("6", LogId));
		return "approval/ApprovalDashBoard";
	}

	
	@RequestMapping(value = "RfpDashBoard.htm", method = RequestMethod.GET)
	public String RfpDashBoard(HttpServletRequest req, HttpSession ses) throws Exception {
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside RfpDashBoard.htm "+UserId);	
		String LogId = ((Long) ses.getAttribute("LoginId")).toString();
		req.setAttribute("DashBoardFormUrlList", service.DashBoardFormUrlList("7", LogId));
		return "rfp/RfpDashBoard";
	}
	
	
	@RequestMapping(value = "LoginPage/PurchaseMangementDoc2020.htm", method = RequestMethod.GET)
	public void PurchaseMangementDoc2020(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginPage/PurchaseMangementDoc2020.htm "+UserId);	
		String path = req.getServletContext().getRealPath("/PurchaseManuals/" + "PM_2020.pdf");

		res.setContentType("application/pdf");
		res.setHeader("Content-Disposition", String.format("inline; filename=\"" + req.getParameter("path") + "\""));

		File my_file = new File(path);

		OutputStream out = res.getOutputStream();
		FileInputStream in = new FileInputStream(my_file);
		byte[] buffer = new byte[4096];
		int length;
		while ((length = in.read(buffer)) > 0) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.flush();
	}
	
	
	@RequestMapping(value = "LoginPage/PurchaseMangementDoc.htm", method = RequestMethod.GET)
	public void PurchaseMangementDoc(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginPage/PurchaseMangementDoc.htm "+UserId);	
		String path = req.getServletContext().getRealPath("/PurchaseManuals/" + "PM_2016.pdf");

		res.setContentType("application/pdf");
		res.setHeader("Content-Disposition", String.format("inline; filename=\"" + req.getParameter("path") + "\""));

		File my_file = new File(path);

		OutputStream out = res.getOutputStream();
		FileInputStream in = new FileInputStream(my_file);
		byte[] buffer = new byte[4096];
		int length;
		while ((length = in.read(buffer)) > 0) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.flush();
	}


	@RequestMapping(value = "LoginPage/MmForms2020.htm", method = RequestMethod.GET)
	public void MmForms2020DownLoad(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginPage/MmForms2020.htm "+UserId);	
		String path = req.getServletContext().getRealPath("/PurchaseManuals/" + "MM_FORMS_2020.pdf");

		res.setContentType("application/pdf");
		res.setHeader("Content-Disposition", String.format("inline; filename=\"" + req.getParameter("path") + "\""));

		File my_file = new File(path);

		OutputStream out = res.getOutputStream();
		FileInputStream in = new FileInputStream(my_file);
		byte[] buffer = new byte[4096];
		int length;
		while ((length = in.read(buffer)) > 0) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.flush();
	}
	
	
	
	
	
	
	@RequestMapping(value = "LoginPage/DemandInstruction.htm", method = RequestMethod.GET)
	public void DemandInstructionDownLoad(HttpServletRequest req, HttpSession ses, HttpServletResponse res) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginPage/DemandInstruction.htm "+UserId);	
		String path = req.getServletContext().getRealPath("/PurchaseManuals/" + "DemandInstruction.pdf");

		res.setContentType("application/pdf");
		res.setHeader("Content-Disposition", String.format("inline; filename=\"" + req.getParameter("path") + "\""));

		File my_file = new File(path);

		OutputStream out = res.getOutputStream();
		FileInputStream in = new FileInputStream(my_file);
		byte[] buffer = new byte[4096];
		int length;
		while ((length = in.read(buffer)) > 0) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.flush();
	}
	
	
	
	@RequestMapping(value = "LoginPage/DelegationOfPower.htm", method = RequestMethod.GET)
	public String DelegationOfPower(HttpServletRequest req, HttpSession ses) throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginPage/DelegationOfPower.htm "+UserId);	
		return "static/DelegationOfPower";
	}
	
	@RequestMapping(value = "LoginPage/PPFMDoc2016.htm", method = RequestMethod.GET)
	public void PPFM2016(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginPage/PPFMDoc2016.htm "+UserId);	
		String path = req.getServletContext().getRealPath("/PurchaseManuals/" + "PPFM-2016.pdf");

		res.setContentType("application/pdf");
		res.setHeader("Content-Disposition", String.format("inline; filename=\"" + req.getParameter("path") + "\""));

		File my_file = new File(path);

		OutputStream out = res.getOutputStream();
		FileInputStream in = new FileInputStream(my_file);
		byte[] buffer = new byte[4096];
		int length;
		while ((length = in.read(buffer)) > 0) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.flush();
	}
	
	@RequestMapping(value = "LoginPage/DPFMDoc2021.htm", method = RequestMethod.GET)
	public void PPFM2021(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginPage/DPFMDoc2021.htm "+UserId);	
		String path = req.getServletContext().getRealPath("/PurchaseManuals/" + "DPFM_2021_DIR.pdf");

		res.setContentType("application/pdf");
		res.setHeader("Content-Disposition", String.format("inline; filename=\"" + req.getParameter("path") + "\""));

		File my_file = new File(path);

		OutputStream out = res.getOutputStream();
		FileInputStream in = new FileInputStream(my_file);
		byte[] buffer = new byte[4096];
		int length;
		while ((length = in.read(buffer)) > 0) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.flush();
	}
	
	
	@RequestMapping(value = "LoginPage/DPFMDoc2021Handbook.htm", method = RequestMethod.GET)
	public void DPFMDoc2021Handbook(HttpServletRequest req, HttpSession ses, HttpServletResponse res)
			throws Exception {

		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside LoginPage/DPFMDoc2021Handbook.htm "+UserId);	
		String path = req.getServletContext().getRealPath("/PurchaseManuals/" + "DPFM_2021_HB.pdf");

		res.setContentType("application/pdf");
		res.setHeader("Content-Disposition", String.format("inline; filename=\"" + req.getParameter("path") + "\""));

		File my_file = new File(path);

		OutputStream out = res.getOutputStream();
		FileInputStream in = new FileInputStream(my_file);
		byte[] buffer = new byte[4096];
		int length;
		while ((length = in.read(buffer)) > 0) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.flush();
	}

	
    
}
