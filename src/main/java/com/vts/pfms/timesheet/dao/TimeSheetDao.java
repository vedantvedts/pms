package com.vts.pfms.timesheet.dao;

import java.util.List;

import com.vts.pfms.master.model.MilestoneActivityType;
import com.vts.pfms.timesheet.dto.ActionAnalyticsDTO;
import com.vts.pfms.timesheet.model.TimeSheet;

public interface TimeSheetDao {

	public List<Object[]> getEmpActivityAssignList(String empId) throws Exception;
	public TimeSheet getTimeSheetByDateAndEmpId(String empId, String activityDate) throws Exception;
	public TimeSheet getTimeSheetById(String timeSheetId) throws Exception;
	public Long addTimeSheet(TimeSheet timeSheet) throws Exception;
	public int removeTimeSheetActivities(String timeSheetId) throws Exception;
	public List<Object[]> getEmpAllTimeSheetList(String empId, String activityDate) throws Exception;
	public List<Object[]> getEmployeesofSuperiorOfficer(String superiorOfficer, String labCode) throws Exception;
	public List<TimeSheet> getTimeSheetListofEmployeeByPeriod(String empId, String fromDate, String toDate) throws Exception;
	public List<MilestoneActivityType> getMilestoneActivityTypeList() throws Exception;
	public List<ActionAnalyticsDTO> actionAnalyticsList(String empId, String fromDate, String toDate, String projectId) throws Exception;
	public List<Object[]> getAllEmployeeList(String labCode) throws Exception;
	public List<Object[]> empActivityWiseAnalyticsList(String empId, String fromDate, String toDate) throws Exception;
	public List<Object[]> projectActivityWiseAnalyticsList(String empId, String fromDate, String toDate, String projectId) throws Exception;
	public List<Object[]> projectActionAnalyticsList(String projectId, String fromDate, String toDate) throws Exception;
	public List<Object[]> getAllEmpTimeSheetWorkingHrsList(String labCode, String loginType, String empId, String fromDate, String toDate) throws Exception;
	public List<Object[]> getProjectTimeSheetWorkingHrsList(String labCode, String loginType, String empId, String fromDate, String toDate) throws Exception;
	public List<Object[]> empExtraWorkingDaysList(String empId, String fromDate, String toDate) throws Exception;
	public List<Object[]> getHolidayList() throws Exception;

}
