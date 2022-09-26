package com.vts.pfms.pfts.service;

import java.util.List;

public interface PftsReportsService {

	public List<Object[]> FileTrackingWeeklyReport(String AsOnDate) throws Exception;
	public List<Object[]> milstoneDetails(String fromDate, String toDate) throws Exception;
	public List<Object[]> modeWisefiles(String fromDate, String toDate) throws Exception;
	public List<Object[]> fileMonitoring(String fromDate, String toDate) throws Exception;
	public List<Object[]> soPlaced(String fromDate, String toDate) throws Exception;

}
