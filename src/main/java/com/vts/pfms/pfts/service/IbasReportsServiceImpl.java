package com.vts.pfms.pfts.service;

import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.pfts.dao.IbasReportsDao;


@Service
public class IbasReportsServiceImpl implements IbasReportsService {
	
	private static final Logger logger=LogManager.getLogger(IbasReportsServiceImpl.class);
	
	@Autowired
	IbasReportsDao dao;

	
	public List<Object[]> CCMReportList(String financialYear, String dateSel , int digitValue,String fromYear, String toYear, String quarterType, String loginType, String employeeNo, String ibasDatabaseName) throws Exception	{
		logger.info(new Date() +"Inside CCMReportList");
		List<Object[]> CCMReportList = null;
		try {
			CCMReportList = dao.CCMReportList(financialYear,dateSel,digitValue,fromYear,toYear,quarterType,loginType,employeeNo,ibasDatabaseName);
	      
		}catch (Exception e) {
			logger.error(new Date() +"Inside CCMReportList");
			e.printStackTrace();
		}
		return CCMReportList;
		}
	
	public List<Object[]> CCMReportCashOutGoList(String digitValue,String projectId,String budgetHeadId,String fromYear, String toYear, String quarterType, String ibasDatabaseName ) throws Exception{
		logger.info(new Date() +"Inside CCMReportCashOutGoList");
		List<Object[]> CCMReportCashOutGoList = null;
		try {
			CCMReportCashOutGoList = dao.CCMReportCashOutGoList(digitValue,projectId,budgetHeadId,fromYear,toYear,quarterType,ibasDatabaseName);
	      
		}catch (Exception e) {
			logger.error(new Date() +"Inside CCMReportCashOutGoList");
			e.printStackTrace();
		}
		return CCMReportCashOutGoList;
	}
	
	public List<Object[]>  CCMExpenditureList(String date,String digitValue, String projectId,String budgetHeadId,String fromYear, String ibasDatabaseName) throws Exception{
		logger.info(new Date() +"Inside CCMExpenditureList");
		List<Object[]> CCMExpenditureList = null;
		try {
			CCMExpenditureList = dao.CCMExpenditureList(date,digitValue,projectId,budgetHeadId,fromYear,ibasDatabaseName);
	      
		}catch (Exception e) {
			logger.error(new Date() +"Inside CCMExpenditureList");
			e.printStackTrace();
		}
		return CCMExpenditureList;
	}
}
