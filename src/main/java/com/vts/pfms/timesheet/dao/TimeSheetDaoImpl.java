package com.vts.pfms.timesheet.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.master.model.Employee;
import com.vts.pfms.timesheet.model.TimeSheet;

@Repository
@Transactional
public class TimeSheetDaoImpl implements TimeSheetDao {

	private static final Logger logger = LogManager.getLogger(TimeSheetDaoImpl.class);
	
	@PersistenceContext
	EntityManager manager;
	
	private static final String GETEMPACTIVITYASSIGNLIST = "SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'empname',c.designation,a.actiondate,d.enddate,a.actionitem,d.actionstatus,d.remarks,a.actionlinkid,d.actionno ,d.actionassignid ,d.assignee ,d.assignor , a.actionlevel ,a.projectid FROM  action_main a, employee b ,employee_desig c , action_assign d WHERE a.actionmainid=d.actionmainid AND d.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND CASE WHEN 'A'=:EmpId THEN 1=1 ELSE d.assignee=:EmpId END AND d.actionstatus IN ('I','A','B') AND d.assigneelabcode<>'@EXP' ORDER BY d.actionassignid DESC";
	@Override
	public List<Object[]> getEmpActivityAssignList(String empId) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETEMPACTIVITYASSIGNLIST);
			query.setParameter("EmpId", empId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetDaoImpl getEmpActivityAssignList() "+e);
			return new ArrayList<Object[]>();
		}
	}
	
	private static final String GETTIMESHEETBYDATE = "FROM TimeSheet WHERE EmpId=:EmpId AND ActivityFromDate=:ActivityDate AND IsActive=1";
	@Override
	public TimeSheet getTimeSheetByDateAndEmpId(String empId, String activityDate) throws Exception {
		try {
			Query query = manager.createQuery(GETTIMESHEETBYDATE);
			query.setParameter("EmpId", Long.parseLong(empId));
			query.setParameter("ActivityDate", activityDate);
			List<TimeSheet> list = (List<TimeSheet>)query.getResultList();
			return list.size()>0?list.get(0):null;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetDaoImpl getTimeSheetByDate() "+e);
			return null;
		}
	}
	
	@Override
	public TimeSheet getTimeSheetById(String timeSheetId) throws Exception {
		try {
			return manager.find(TimeSheet.class, Long.parseLong(timeSheetId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetDaoImpl getTimeSheetById() "+e);
			return null;
		}
	}

	@Override
	public Long addTimeSheet(TimeSheet timeSheet) throws Exception {
		try {
			manager.persist(timeSheet);
			manager.flush();
			return timeSheet.getTimeSheetId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetDaoImpl addTimeSheet() "+e);
		}
		return null;
	}
	
	private static final String REMOVETIMESHEETACTIVITIES ="DELETE FROM pfms_timesheet_activity WHERE TimeSheetId=:TimeSheetId";
	@Override
	public int removeTimeSheetActivities(String timeSheetId) throws Exception {
		try {
			Query query = manager.createNativeQuery(REMOVETIMESHEETACTIVITIES);
			query.setParameter("TimeSheetId", timeSheetId);
			return query.executeUpdate();
		}catch (Exception e) {
			logger.error(new Date()+" Inside TimeSheetDaoImpl removeTimeSheetActivities() "+e);
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String EMPALLTIMESHEETLIST = "SELECT a.TimeSheetId,a.EmpId,a.InitiationDate,a.ActivityFromDate,a.ActivityToDate,a.PunchInTime,a.PunchOutTime,a.TotalDuration,a.EmpStatus,a.TDRemarks,a.TimeSheetStatus  FROM pfms_timesheet a WHERE a.IsActive=1 AND a.ActivityFromDate BETWEEN DATE_SUB(:ActivityDate, INTERVAL 30 DAY) AND DATE_ADD(:ActivityDate , INTERVAL 30 DAY ) AND a.EmpId=:EmpId";
	@Override
	public List<Object[]> getEmpAllTimeSheetList(String empId, String activityDate) throws Exception {
		try {
			Query query = manager.createNativeQuery(EMPALLTIMESHEETLIST);
			query.setParameter("EmpId", Long.parseLong(empId));
			query.setParameter("ActivityDate", activityDate);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetDaoImpl getEmpAllTimeSheetList() "+e);
			return new ArrayList<Object[]>();
		}
	}
	
	private static final String GETEMPLOYEESOFSUPERIOROFFICER = "SELECT a.EmpId,a.Title,a.Salutation,a.SrNo,a.EmpNo,a.EmpName,b.Designation FROM employee a, employee_desig b WHERE a.DesigId=b.DesigId AND a.LabCode=:LabCode AND a.SuperiorOfficer=:SuperiorOfficer ORDER BY CASE WHEN a.SrNo=0 THEN 1 ELSE 0 END,a.SrNo";
	@Override
	public List<Object[]> getEmployeesofSuperiorOfficer(String superiorOfficer, String labCode) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETEMPLOYEESOFSUPERIOROFFICER);
			query.setParameter("SuperiorOfficer", Long.parseLong(superiorOfficer));
			query.setParameter("LabCode", labCode);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetDaoImpl getEmployeesofSuperiorOfficer() "+e);
			return new ArrayList<Object[]>();
		}
	}
	
	private static final String GETTIMESHEETLISTOFEMPLOYEEBYPERIOD = "FROM TimeSheet WHERE IsActive=1 AND TimeSheetStatus NOT IN ('INI') AND EmpId=:EmpId AND ActivityFromDate BETWEEN :FromDate AND :ToDate";
	@Override
	public List<TimeSheet> getTimeSheetListofEmployeeByPeriod(String empId, String fromDate, String toDate) throws Exception {
		try {
			Query query = manager.createQuery(GETTIMESHEETLISTOFEMPLOYEEBYPERIOD);
			query.setParameter("EmpId", Long.parseLong(empId));
			query.setParameter("FromDate", fromDate);
			query.setParameter("ToDate", toDate);
			return (List<TimeSheet>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetDaoImpl getEmployeesofSuperiorOfficer() "+e);
			return new ArrayList<TimeSheet>();
		}
	}
}
