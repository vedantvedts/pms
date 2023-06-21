package com.vts.pfms.pfts.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;



@Transactional
@Repository
public class IbasReportsDaoImpl implements IbasReportsDao{
	private static final Logger logger=LogManager.getLogger(IbasReportsDaoImpl.class);
	
	@PersistenceContext
	EntityManager manager;
	
	private static final String CCMVIEW="CALL CCMSummaryView_Rpt(:finYear,:asOnDate,:digitValue,:fromYear,:toYear,:quarterType,:loginType,:employeeNo,:ibasDbName)";
	public List<Object[]> CCMReportList(String financialYear, String dateSel , int digitValue,String fromYear, String toYear, String quarterType, String loginType, String employeeNo,String ibasDatabaseName ) throws Exception{
		logger.info(new Date() +"Inside DAOImpl CCMReportList()");
		try {
			System.out.println("CALL CCMSummaryView_Rpt('"+financialYear+"','"+dateSel+"','"+digitValue+"','"+fromYear+"','"+toYear+"','"+quarterType+"','"+loginType+"','"+employeeNo+"','"+ibasDatabaseName+"');");
		    Query query=manager.createNativeQuery(CCMVIEW);
			query.setParameter("finYear", financialYear);
			query.setParameter("asOnDate", dateSel);
			query.setParameter("digitValue", digitValue);
			query.setParameter("fromYear", fromYear);
			query.setParameter("toYear", toYear);
			query.setParameter("quarterType", quarterType);
			query.setParameter("loginType", loginType);
			query.setParameter("employeeNo", employeeNo);
			query.setParameter("ibasDbName", ibasDatabaseName);

			List<Object[]> CCMViewList=(List<Object[]>)query.getResultList();
			return CCMViewList;
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside DAOImpl  CCMReportList "+ e);
			return null;
		}
	}
	
	private static final String CCMCASHOUTGOLIST="CALL CCMCashOutGo_Rpt(:projectId,:budgetHeadId,:digitValue,:fromYear,:toYear,:quarterType,:ibasDbName)";
	public List<Object[]> CCMReportCashOutGoList(String digitValue,String projectId,String budgetHeadId,String fromYear, String toYear, String quarterType,String ibasDatabaseName ) throws Exception{
		logger.info(new Date() +"Inside DAOImpl CCMReportCashOutGoList()");
		try {
			System.out.println("CALL CCMCashOutGo_Rpt('"+projectId+"','"+budgetHeadId+"','"+digitValue+"','"+fromYear+"','"+toYear+"','"+quarterType+"','"+ibasDatabaseName+"');");
		    Query query=manager.createNativeQuery(CCMCASHOUTGOLIST);
			query.setParameter("digitValue", digitValue);
			query.setParameter("projectId", projectId);
			query.setParameter("budgetHeadId", budgetHeadId);
			query.setParameter("fromYear", fromYear);
			query.setParameter("toYear", toYear);
			query.setParameter("quarterType", quarterType);
			query.setParameter("ibasDbName", ibasDatabaseName);

			List<Object[]> CCMReportCashOutGoList=(List<Object[]>)query.getResultList();
			return CCMReportCashOutGoList;
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside DAOImpl  CCMReportCashOutGoList "+ e);
			return null;
		}
	}

	private static final String CCMEXPLIST ="CALL CCMExpenditure_Rpt(:projectId,:budgetHeadId,:date,:digitValue,:fromYear,:ibasDbName)";
	public List<Object[]>  CCMExpenditureList(String date,String digitValue, String projectId,String budgetHeadId,String fromYear,String ibasDatabaseName) throws Exception{
		logger.info(new Date() +"Inside CCMExpenditureList");
		try {
			System.out.println("CALL CCMExpenditure_Rpt('"+projectId+"','"+budgetHeadId+"','"+date+"','"+digitValue+"','"+fromYear+"','"+ibasDatabaseName+"');");
			 Query query=manager.createNativeQuery(CCMEXPLIST);
			 query.setParameter("date", date);
			query.setParameter("digitValue", digitValue);
			query.setParameter("projectId", projectId);
			query.setParameter("budgetHeadId", budgetHeadId);
			query.setParameter("fromYear", fromYear);
			query.setParameter("ibasDbName", ibasDatabaseName);
			List<Object[]> CCMExpenditureList=(List<Object[]>)query.getResultList();
			return CCMExpenditureList;
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() +"Inside DAOImpl  CCMExpenditureList "+ e);
			return null;
		}
	}


	
}
