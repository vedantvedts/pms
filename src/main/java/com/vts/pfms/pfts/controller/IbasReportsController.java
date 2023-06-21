package com.vts.pfms.pfts.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.pfts.service.IbasReportsService;

@Controller
public class IbasReportsController {
	
	@Autowired
	IbasReportsService reportService;

	
	private static final Logger logger = LogManager.getLogger(IbasReportsController.class);
	
	private  SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
	
	@Value("${ibas_db}")
     private String ibasDatabaseName;
	
	@RequestMapping(value="CCMReportData.htm",method= {RequestMethod.POST,RequestMethod.GET})
	public String CCMReport(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		String LoginType=(String)ses.getAttribute("LoginType");
		String EmployeeNo=(String)ses.getAttribute("EmpNo");
		logger.info(new Date() + "Inside CCMReport.htm"+Username);
		try {
			FormatConverter fc=new FormatConverter();
			String DateSel = req.getParameter("DateCCM");
			String DigitSel = req.getParameter("DigitSel");
			if(DateSel==null && DigitSel==null) {
				DateSel = fc.getRegularDateFormat().format(new Date());
				DigitSel ="Rupees";
			}

			int DigitValue = 0;
			if(DigitSel.equalsIgnoreCase("Rupees")) {
				DigitValue = 1;
			}else if(DigitSel.equalsIgnoreCase("Lakhs")) {
				DigitValue = 100000;
			}else {
				DigitValue = 10000000;
			}
			
			String Data[] = DateSel.split("-");
			String Month = Data[1];
			String Year = Data[2];
			String FinancialYear = null;
			int FyCalc = 0;
			if (Integer.valueOf(Year) <= 3) {
				FyCalc = Integer.valueOf(Year) - 1;
			} else {
				FyCalc = Integer.valueOf(Year);
            }
			FinancialYear =  FyCalc + "-" + (FyCalc + 1);
			String[] FYArr = FinancialYear.split("-");
			String FromYear = FYArr[0];
			String ToYear = FYArr[1];
			
			
			String StartDate = FromYear + "-04-01";
			String EndDate =   null;
			String QuarterType = null;

			if ("04".equals(Month) || "05".equals(Month) || "06".equals(Month)) {
				QuarterType = "Q1";
				EndDate = FromYear + "-06-30";
				
			} else if ("07".equals(Month) || "08".equals(Month) || "09".equals(Month)) {	
				QuarterType = "Q2";
				EndDate = FromYear + "-09-30";
				
			} else if ("10".equals(Month) || "11".equals(Month) || "12".equals(Month)) {
				QuarterType = "Q3";
				EndDate = ToYear + "-" + 12 + "-31";
				
			} else if ("01".equals(Month) || "02".equals(Month) || "03".equals(Month)) {
				QuarterType = "Q4";
				EndDate = ToYear + "-03-31";
			}

			
			
		  List<Object[]> CCMReportList = reportService.CCMReportList(FinancialYear,new java.sql.Date(rdf.parse(DateSel).getTime()).toString(), DigitValue , 
				  FromYear, ToYear, QuarterType,LoginType,EmployeeNo,ibasDatabaseName);
			/****************LinkedHashMapping*******************/
		    Map<String, List<Object[]>> ccmMap = new LinkedHashMap<String, List<Object[]>>();
		    BigDecimal cogQ1 = new BigDecimal(0.00);
		    BigDecimal cogQ2 = new BigDecimal(0.00);
		    BigDecimal cogQ3 = new BigDecimal(0.00);
		    BigDecimal cogQ4 = new BigDecimal(0.00);
		  
		    
		    for (Object[] obj : CCMReportList) {
		    	List<Object[]> ccmListBHeadWise = ccmMap.get(obj[3].toString());
		    	if(ccmListBHeadWise == null) {
		    		 ccmListBHeadWise = new LinkedList<Object[]>();
		    		 ccmListBHeadWise.add(obj);
		    		 ccmMap.put(obj[3].toString(), ccmListBHeadWise);
		    	}else {
		    		 ccmListBHeadWise.add(obj);
		    		 ccmMap.put(obj[3].toString(), ccmListBHeadWise);
		    	}
		    	
		    	cogQ1 = cogQ1.add(new BigDecimal(obj[7].toString()));
				cogQ2 = cogQ2.add(new BigDecimal(obj[8].toString()));
				cogQ3 = cogQ3.add(new BigDecimal(obj[9].toString()));
				cogQ4 = cogQ4.add(new BigDecimal(obj[10].toString()));
		    	
		    }
		  
		  req.setAttribute("dateForCCM", DateSel);
		  req.setAttribute("digitTypeSel", DigitSel);
		  req.setAttribute("digitValueSel", DigitValue);
		  req.setAttribute("quarterType", QuarterType);
		  req.setAttribute("financialYear", FinancialYear);
		  req.setAttribute("fromYear", FromYear);
		  req.setAttribute("toYear", ToYear);
		  req.setAttribute("startDate", StartDate);
		  req.setAttribute("endDate", EndDate);
		  req.setAttribute("loginType", LoginType);
		  req.setAttribute("employeeNo", EmployeeNo);
		  req.setAttribute("ccmReportList", CCMReportList);
		  req.setAttribute("ccmMap", ccmMap);
		  req.setAttribute("cogQ1", String.valueOf(cogQ1));
		  req.setAttribute("cogQ2", String.valueOf(cogQ2));
		  req.setAttribute("cogQ3", String.valueOf(cogQ3));
		  req.setAttribute("cogQ4", String.valueOf(cogQ4));
			
			
			return"ibasReports/ccmReport";
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+"Inside CCMReport.htm" +Username,e);
			return "static/Error";
		}
	}
	
	@RequestMapping(value="CCMReportDetailsData.htm",method= {RequestMethod.POST,RequestMethod.GET})
	public String CCMReportDetails(HttpServletRequest req, HttpSession ses, RedirectAttributes redir)throws Exception{
		String Username=(String)ses.getAttribute("Username");
		logger.info(new Date() + "Inside CCMReportDetails.htm"+Username);
		try {	
			String FromYear = req.getParameter("fromYear");
			String ToYear = req.getParameter("toYear");
			String ProjectId = req.getParameter("projectid");
			String BudgetHeadId = req.getParameter("Budgetheadid");
			String Date = req.getParameter("date");
			String DigitValue = req.getParameter("digitvalue");
			String DigitTypeSel = req.getParameter("digittype");
			String QuarterType = req.getParameter("quartertype");
			String ProjectCode = null;
			String BudgetHead = null;
			List<Object[]> CCMExpenditureList = null;
			
			
			
			if (   Date != null && Date.length() > 0 && DigitValue != null && DigitValue.length() > 0
				&& ProjectId != null && ProjectId.length() > 0 && BudgetHeadId != null&& BudgetHeadId.length() > 0
				&& FromYear!=null && FromYear.length()>0 && ToYear!=null && ToYear.length()>0
			) {
				
				
				
	      	List<Object[]> CCMReportCashOutGoList = reportService.CCMReportCashOutGoList(DigitValue,ProjectId,
				                                BudgetHeadId,FromYear,ToYear,QuarterType,ibasDatabaseName);
	      	Map<String, List<Object[]>> CCMDetailedMap = new LinkedHashMap<String, List<Object[]>>();
	      	
	      	if(CCMReportCashOutGoList!=null) {
	      		for (Object[] ccmObj : CCMReportCashOutGoList) {
	      			
	      			List<Object[]> CCMDetailsList = CCMDetailedMap.get(ccmObj[7].toString());
	      			if(CCMDetailsList == null) {
	      				CCMDetailsList = new LinkedList<Object[]>();
	      				CCMDetailsList.add(ccmObj);
	      				CCMDetailedMap.put(ccmObj[7].toString(), CCMDetailsList);
	      				ProjectCode = ccmObj[0].toString();
	      				BudgetHead = ccmObj[8].toString();
	      				
	      			}else {
	      				
	      				CCMDetailsList.add(ccmObj);
	      				CCMDetailedMap.put(ccmObj[7].toString(), CCMDetailsList);
						ProjectCode = ccmObj[0].toString();
						BudgetHead = ccmObj[8].toString();
	      			}
	      			
	      		}
	      		
	      		CCMExpenditureList = reportService.CCMExpenditureList(new java.sql.Date(rdf.parse(Date).getTime()).toString(),DigitValue,ProjectId,BudgetHeadId,FromYear,ibasDatabaseName);
	      	}

				  req.setAttribute("dateForCCMDetails", Date);
				  req.setAttribute("digitTypeSel", DigitTypeSel);
				  req.setAttribute("digitValueSel", Integer.parseInt(DigitValue));
				  req.setAttribute("quarterType", QuarterType);
				  req.setAttribute("financialYear", FromYear+"-"+ToYear);
				  req.setAttribute("fromYear", FromYear);
				  req.setAttribute("toYear", ToYear);
				  req.setAttribute("budgetHeadId", BudgetHeadId);
				  req.setAttribute("projectId", ProjectId);
				  req.setAttribute("projectCode", ProjectCode);
				  req.setAttribute("budgetHead", BudgetHead);
				  req.setAttribute("ccmDetailedMap", CCMDetailedMap);
				  req.setAttribute("ccmReportCashOutGoList", CCMReportCashOutGoList);
				  req.setAttribute("ccmExpenditureList", CCMExpenditureList);
			
			}
			
			
			
			
		return"ibasReports/ccmReportDetails";
		
	}catch (Exception e) {
		e.printStackTrace();
		logger.error(new Date()+"Inside CCMReportDetails.htm" +Username,e);
		return "static/error";
	}
	}
}
