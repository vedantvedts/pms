package com.vts.pfms.pfts.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.pfts.service.PftsReportsService;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsReportConfiguration;

@Controller
public class PftsReportsController {

	@Autowired PftsReportsService service;
	
	@Autowired
	DataSource datasource;
	
	private static final Logger logger=LogManager.getLogger(PftsReportsController.class);
		
	FormatConverter fc=new FormatConverter();
	SimpleDateFormat  sqldate=fc.getSqlDateFormat();
	SimpleDateFormat  regulardate=fc.getRegularDateFormat();
	
	@RequestMapping(value = "FileTrackingWeeklyReport.htm") //file-tracking-weekly-report
	public ModelAndView FileTrackingWeeklyReport(HttpServletRequest request,HttpSession ses) throws Exception   
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside FileTrackingWeeklyReport.htm "+UserId);
		try {
			ModelAndView mv = new ModelAndView("pfts/reports/FileTrackingWeeklyReport");
			String SelectedDate=request.getParameter("SelectedDate");
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat parse=new SimpleDateFormat("dd-MM-yyyy");
			String asOnDate=null;
			if(SelectedDate!=null) {
				Date date=parse.parse(SelectedDate);
				asOnDate=format.format(date);
				mv.addObject("asOnDate", SelectedDate);
			}else {
				asOnDate=format.format(new Date());
				mv.addObject("asOnDate", parse.format(new Date()));
			}
			List<Object[]>  FileTrackingWeeklyReportResult=service.FileTrackingWeeklyReport(asOnDate);
		   
			mv.addObject("FileTrackingWeeklyReportResult", FileTrackingWeeklyReportResult);
			return mv;	
		}catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside FileTrackingWeeklyReport.htm "+UserId , e);
			return new ModelAndView ("static/Error");
		}	
		
	}
	
	
	@RequestMapping(value = "PftsMilestoneReport.htm")
	public ModelAndView milestoneDetails(HttpServletRequest request,HttpSession ses) throws Exception   
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside PftsMilestoneReport.htm "+UserId);
		try {
			ModelAndView mv = new ModelAndView("pfts/reports/MilestoneReport");
			String fromDate=request.getParameter("fromDate");
			String toDate=request.getParameter("toDate");
			Date date=new Date();
			String fDate=null;
			String tDate=null;
			SimpleDateFormat parse=new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			if(fromDate!=null && toDate!=null) {
				Date parseFDate=parse.parse(fromDate);
				Date parseTDate=parse.parse(toDate);
				fDate=format.format(parseFDate);
				tDate=format.format(parseTDate);
				request.setAttribute("fromDate",fromDate );
				request.setAttribute("toDate", toDate);
			}else {
				fDate=format.format(date).substring(0,8)+"01";
			    tDate=format.format(date);
			    fromDate="01"+parse.format(date).substring(2);
			    toDate=parse.format(date);
			    
			    request.setAttribute("fromDate",fromDate );
				request.setAttribute("toDate", toDate);
			}
			
			List<Object[]> milestoneDetails=service.milstoneDetails(fDate, tDate);
			request.setAttribute("milestoneDetails", milestoneDetails);
			return mv;	
		}catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside PftsMilestoneReport.htm "+UserId , e);
			return new ModelAndView ("static/Error");
		}	
	}	
	
	
	@RequestMapping(value = "ModeWiseFilesReport.htm")
	public ModelAndView modewiseFilesReport(HttpServletRequest req,HttpServletResponse res,HttpSession ses) throws Exception  
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside ModeWiseFilesReport.htm "+UserId);
		try {
			ModelAndView mv = new ModelAndView("pfts/reports/ModewiseFilesReport");
			
			String fromDate=req.getParameter("fromDate");
			String toDate=req.getParameter("toDate");
			Date date =new Date();
			String fDate=null;
			String tDate=null;
			SimpleDateFormat parse=new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			if(fromDate!=null && toDate!=null) {
				Date parseFDate=parse.parse(fromDate);
				Date parseTDate=parse.parse(toDate);
				fDate=format.format(parseFDate);
				tDate=format.format(parseTDate);
				req.setAttribute("fromDate",fromDate );
				req.setAttribute("toDate", toDate);
			}else {
				String curdate[]=format.format(date).split("-");
				if(Integer.parseInt(curdate[1])>3) {
					int fyear=Integer.parseInt(curdate[0]);
					fDate=fyear+"-"+"04"+"-"+"01";
					fromDate="01"+"-"+"04"+"-"+fyear;
				}else {
					int fyear=Integer.parseInt(curdate[0])-1;
					fDate=fyear+"-"+"04"+"-"+"01";
					fromDate="01"+"-"+"04"+"-"+fyear;
				}
				
			    tDate=format.format(date);
			    toDate=parse.format(date);
			    
			    req.setAttribute("fromDate",fromDate );
			    req.setAttribute("toDate", toDate);
			}
			
			List<Object[]> modewisefilesCount=service.modeWisefiles(fDate, tDate);
			req.setAttribute("modewisefilesCount", modewisefilesCount);
			
			return mv;
		}catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside ModeWiseFilesReport.htm "+UserId , e);
			return new ModelAndView ("static/Error");
		}	
	}
	
	
	@RequestMapping(value = "SOPlaced.htm")
	public ModelAndView SOPlaced(HttpServletRequest request, HttpSession ses) throws Exception  {
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside SOPlaced.htm "+UserId);
		try {
			ModelAndView mv = new ModelAndView("pfts/reports/SOPlaced");
			String fromDate=request.getParameter("fromDate");
			String toDate=request.getParameter("toDate");
			Date date =new Date();
			String fDate=null;
			String tDate=null;
			SimpleDateFormat parse=new SimpleDateFormat("dd-MM-yyyy");
			SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
			if(fromDate!=null && toDate!=null) {
					Date parseFDate=parse.parse(fromDate);
					Date parseTDate=parse.parse(toDate);
					fDate=format.format(parseFDate);
					tDate=format.format(parseTDate);
					request.setAttribute("fromDate",fromDate );
					request.setAttribute("toDate", toDate);
			}else {
					String curdate[]=format.format(date).split("-");
				if(Integer.parseInt(curdate[1])>3) {
					int fyear=Integer.parseInt(curdate[0]);
					fDate=fyear+"-"+"04"+"-"+"01";
					fromDate="01"+"-"+"04"+"-"+fyear;
				}else {
					int fyear=Integer.parseInt(curdate[0])-1;
					fDate=fyear+"-"+"04"+"-"+"01";
					fromDate="01"+"-"+"04"+"-"+fyear;
				}
				
					tDate=format.format(date);
					toDate=parse.format(date);
			    
					request.setAttribute("fromDate",fromDate );
					request.setAttribute("toDate", toDate);
			}
			
			
					List<Object[]> modewiseCountList=service.fileMonitoring(fDate, tDate);
					List<Object[]> modewiseDetails=service.soPlaced(fDate, tDate);
					Map<String,List<Object[]>> detailsMap=new TreeMap<String,List<Object[]>>();
					Map<String,List<Object[]>> modeMap=new HashMap<String,List<Object[]>>();
					Map<String,Map<String,List<Object[]>>> processMap=new HashMap<String,Map<String,List<Object[]>>>();
			if(modewiseDetails!=null && modewiseDetails.size()>0) {
			for(Object[] obj:modewiseDetails) {
					List<Object[]> list=detailsMap.get(obj[0].toString());
				if(list==null) {
					list=new ArrayList<Object[]>();
					list.add(obj);
					detailsMap.put(obj[0].toString(), list);
				}else if(list!=null) {
					list.add(obj);
					detailsMap.put(obj[0].toString(), list);
					
				}
				
				}
			}
			request.setAttribute("modewiseCountList", modewiseCountList);
			request.setAttribute("modewiseDetails", modewiseDetails);
			request.setAttribute("detailsMap", detailsMap);
			
			return mv;
		}catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside SOPlaced.htm "+UserId , e);
			return new ModelAndView ("static/Error");
		}	
	}
	
	
	@RequestMapping(value = "WeeklyReport.htm", method = RequestMethod.POST)
	public void fbeMainPrint(HttpServletRequest req,HttpServletResponse res,HttpSession ses, RedirectAttributes attribute) throws Exception 
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside WeeklyReport.htm "+UserId);
		try {	
			String asondate=req.getParameter("asOnDate");
			Connection conn=datasource.getConnection(); 
			String action=req.getParameter("action");
			String fileName="com/vts/pfms/pfts/jasperreports/WeeklyReport.jrxml";
			
			InputStream input = this.getClass().getClassLoader().getResourceAsStream(fileName);
			JasperDesign design = JRXmlLoader.load(input);	
			JasperReport report = JasperCompileManager.compileReport(design);
			Map<String, Object> parameters = new HashMap<String, Object>();
			parameters.put("asondate", sqldate.format(regulardate.parse(asondate)));
			parameters.put("header", "Weekly Report Of As On Date : "+asondate );
			
			if(action.equals("pdf")) {
				
				byte[] bytes = JasperRunManager.runReportToPdf(report, parameters, conn);
				res.setContentType("application/pdf");
				res.setContentLength(bytes.length);
				ServletOutputStream outStream = res.getOutputStream();
				outStream.write(bytes, 0, bytes.length);
				outStream.flush();
				outStream.close();
			}else if(action.equals("xls")) {
				JasperPrint print = JasperFillManager.fillReport(report,parameters,conn);
				ByteArrayOutputStream os = new ByteArrayOutputStream();
				JRXlsExporter exporter = new JRXlsExporter();
				exporter.setExporterInput(new SimpleExporterInput(print));
				exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(os));
				SimpleXlsReportConfiguration configuration = new SimpleXlsReportConfiguration();
				configuration.setOnePagePerSheet(false);
				configuration.setDetectCellType(false);
				configuration.setCollapseRowSpan(false);
				//configuration.setIgnoreCellBackground(isIgnoreCellBackground);
				exporter.setConfiguration(configuration);
				exporter.exportReport();
				res.setContentType("application/vnd.ms-excel");
				res.setHeader("Content-Disposition", "attachment;filename=BillRegister.xls");
				res.getOutputStream().write(os.toByteArray());
				res.flushBuffer();
				
			}
			
			
		}catch (Exception e){			
			e.printStackTrace();
			logger.error(new Date() +" Inside WeeklyReport.htm "+UserId , e);
			//return new ModelAndView ("static/Error");
		}	
			
	}
	
	
	
	
	
	@RequestMapping(value = "FileMonitoringReport-Print.htm",method=RequestMethod.POST)
	public void fileMonitoringReportPrint(HttpServletRequest req,HttpServletResponse res,HttpSession ses) throws Exception  
	{
		String UserId= (String)ses.getAttribute("Username");
		logger.info(new Date() +" Inside FileMonitoringReport-Print.htm "+UserId);
		
		DateFormat format=new SimpleDateFormat("YYYY-MM-dd");
		DateFormat parse=new SimpleDateFormat("dd-MM-yyyy");
		Connection conn=datasource.getConnection(); 
		String action=req.getParameter("action");
		String fromDate=req.getParameter("fromDate");
		String toDate=req.getParameter("toDate");
		String fileName="ModewiseFilesReport.jrxml";
		
		String fdate=format.format(parse.parse(fromDate));
		String tdate=format.format(parse.parse(toDate));
		
		try {
			InputStream input = this.getClass().getClassLoader().getResourceAsStream(fileName);
			JasperDesign design = JRXmlLoader.load(input);
			JasperReport report = JasperCompileManager.compileReport(design);
			Map<String, Object> parameters = new HashMap<String, Object>();
			String title="Tender Mode Wise File Monitoring Report From Date : "+fromDate+" To Date : "+toDate;
			parameters.put("header", title);
			parameters.put("fromDate", fdate);
			parameters.put("toDate", tdate);
			parameters.put("fDate", fromDate);
			parameters.put("tDate", toDate);
			
			JasperPrint print = JasperFillManager.fillReport(report,
			parameters, conn);
			
			if(action.equals("pdf")) {
			byte[] bytes = JasperRunManager.runReportToPdf(report, parameters, conn);
			res.setContentType("application/pdf");
	        res.setContentLength(bytes.length);
	        ServletOutputStream outStream = res.getOutputStream();
	        outStream.write(bytes, 0, bytes.length);
	        outStream.flush();
	        outStream.close();
			}else if(action.equals("xls")) {
				ByteArrayOutputStream os = new ByteArrayOutputStream();
				JRXlsExporter exporter = new JRXlsExporter();
				exporter.setExporterInput(new SimpleExporterInput(print));
				exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(os));
				SimpleXlsReportConfiguration configuration = new SimpleXlsReportConfiguration();
				configuration.setOnePagePerSheet(false);
				configuration.setDetectCellType(false);
				configuration.setCollapseRowSpan(false);
				//configuration.setIgnoreCellBackground(isIgnoreCellBackground);
				exporter.setConfiguration(configuration);
				exporter.exportReport();
				res.setContentType("application/vnd.ms-excel");
				res.setHeader("Content-Disposition", "attachment;filename=BillRegister.xls");
				res.getOutputStream().write(os.toByteArray());
				res.flushBuffer();
			}
		}catch(Exception e) {
			e.printStackTrace();
			logger.error(new Date() +" Inside FileMonitoringReport-Print.htm "+UserId , e);
		}
	}
	
	
	
}
