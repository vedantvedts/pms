package com.vts.pfms.pfts.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Transactional
@Repository
public class PftsReportsDaoImpl implements PftsReportsDao 
{
	@Autowired EntityManager manager;
	private static final Logger logger=LogManager.getLogger(PftsReportsDaoImpl.class);	

	@Override
	public List<Object[]> FileTrackingWeeklyReport(String AsOnDate) throws Exception
    {
		
		List<Object[]> returnlist=null;	    
	    Query query=manager.createNativeQuery("CALL pfts_sp_WeeklyReport (:AsOnDate)");
		query.setParameter("AsOnDate",AsOnDate);
		returnlist=( List<Object[]>) query.getResultList();
		return returnlist;
		
    }
	
	@Override
	public   List<Object[]> milstoneDetails(String fromDate,String toDate) throws Exception
    {
		
		List<Object[]> returnlist=null;	    
	    Query query=manager.createNativeQuery("CALL pfts_sp_MilestoneReport(:fromdate,:todate)");
		query.setParameter("fromdate",fromDate);
		query.setParameter("todate",toDate);
		returnlist=( List<Object[]>) query.getResultList();
		return returnlist;
    }
	
	@Override
	public List<Object[]> modeWisefiles(String fromDate,String toDate) throws Exception
    {
		
		List<Object[]> returnlist=null;	    
	    Query query=manager.createNativeQuery("CALL Pfts_sp_ModeWiseFiles(:fromdate,:todate)");
		query.setParameter("fromdate",fromDate);
		query.setParameter("todate",toDate);
		returnlist=( List<Object[]>) query.getResultList();
		return returnlist;

    }
	
	@Override
	public List<Object[]> fileMonitoring(String fromDate,String toDate) throws Exception
    {
		
		List<Object[]> returnlist=null;	    
	    Query query=manager.createNativeQuery("CALL Pfts_sp_ModeWiseMonitoring(:fromdate,:todate)");
		query.setParameter("fromdate",fromDate);
		query.setParameter("todate",toDate);
		returnlist=( List<Object[]>) query.getResultList();
		return returnlist;

    }
	
	@Override
	public  List<Object[]> soPlaced(String fromDate,String toDate) throws Exception
    {		
		
		List<Object[]> returnlist=null;	    
	    Query query=manager.createNativeQuery("CALL Pfts_sp_ModeWiseMonitoringOrders(:fromdate,:todate)");
	    query.setParameter("fromdate",fromDate);
	    query.setParameter("todate",toDate);
		returnlist=( List<Object[]>) query.getResultList();
		return returnlist;

    }
    
}
