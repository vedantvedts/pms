package com.vts.pfms.pfts.service;

import java.util.List;

public interface IbasReportsService {

	public List<Object[]> CCMReportList(String financialYear, String dateSel , int digitValue,String fromYear, String toYear, String quarterType, String loginType, String employeeNo, String ibasDatabaseName ) throws Exception;	 
	public List<Object[]> CCMReportCashOutGoList(String digitValue,String projectId,String budgetHeadId,String fromYear, String toYear, String quarterType, String ibasDatabaseName ) throws Exception;
	public List<Object[]>  CCMExpenditureList(String date,String digitValue, String projectId,String budgetHeadId,String fromYear, String ibasDatabaseName) throws Exception;
	
}
