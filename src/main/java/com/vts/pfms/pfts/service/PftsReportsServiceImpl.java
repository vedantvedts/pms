package com.vts.pfms.pfts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.pfts.dao.PftsReportsDao;

@Service
public class PftsReportsServiceImpl implements PftsReportsService {

	@Autowired PftsReportsDao dao;
	
	@Override
	public List<Object[]> FileTrackingWeeklyReport(String AsOnDate) throws Exception
    {
		return dao.FileTrackingWeeklyReport(AsOnDate);
    }
	
	@Override
	public   List<Object[]> milstoneDetails(String fromDate,String toDate) throws Exception
    {
		return dao.milstoneDetails(fromDate, toDate);
    }
	
	@Override
	public List<Object[]> modeWisefiles(String fromDate,String toDate) throws Exception
    {
		return dao.modeWisefiles(fromDate, toDate);
    }
	
	@Override
	public List<Object[]> fileMonitoring(String fromDate,String toDate) throws Exception
    {
		return dao.fileMonitoring(fromDate, toDate);
    }
	
	@Override
	public  List<Object[]> soPlaced(String fromDate,String toDate) throws Exception
    {
		return dao.soPlaced(fromDate, toDate);
    }
	
	
}
