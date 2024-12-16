package com.vts.pfms.timesheet.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.vts.pfms.master.model.MilestoneActivityType;
import com.vts.pfms.timesheet.dto.ActionAnalyticsDTO;
import com.vts.pfms.timesheet.dto.TimeSheetDTO;
import com.vts.pfms.timesheet.model.TimeSheet;
import com.vts.pfms.timesheet.model.TimesheetKeywords;

public interface TimeSheetService {

	public List<Object[]> getEmpActivityAssignList(String empId) throws Exception;
	public TimeSheet getTimeSheetByDateAndEmpId(String empId, String activityDate) throws Exception;
	public TimeSheet getTimeSheetById(String timeSheetId) throws Exception;
	public Long timeSheetSubmit(TimeSheetDTO dto) throws Exception;
	public Long timeSheetDetailsForward(String[] timeSheetIds, String empId, String action, String userId, String remarks) throws Exception;
	public List<Object[]> getEmpAllTimeSheetList(String empId, String activityDate) throws Exception;
	public List<Object[]> getEmployeesofSuperiorOfficer(String superiorOfficer, String labCode) throws Exception;
	public Map<String, Map<LocalDate, TimeSheet>> getTimesheetDataForSuperior(String superiorOfficer, String labCode, String dateofWeek) throws Exception; 
	public List<MilestoneActivityType> getMilestoneActivityTypeList() throws Exception;
	public List<ActionAnalyticsDTO> empActionAnalyticsList(String empId, String fromDate, String toDate, String projectId) throws Exception;
	public Object[] getActionAnalyticsCounts(String empId, String fromDate, String toDate, String projectId) throws Exception;
	public List<Object[]> getAllEmployeeList(String labCode) throws Exception;
	public List<Object[]> empActivityWiseAnalyticsList(String empId, String fromDate, String toDate, String projectId) throws Exception;
	public List<Object[]> projectActivityWiseAnalyticsList(String empId, String fromDate, String toDate, String projectId) throws Exception;
	public List<Object[]> projectActionAnalyticsList(String projectId, String fromDate, String toDate) throws Exception;
	public List<Object[]> getAllEmpTimeSheetWorkingHrsList(String labCode, String loginType, String empId, String fromDate, String toDate) throws Exception;
	public List<Object[]> getProjectTimeSheetWorkingHrsList(String labCode, String loginType, String empId, String fromDate, String toDate) throws Exception;
	public List<Object[]> empExtraWorkingDaysList(String empId, String fromDate, String toDate) throws Exception;
	public List<Object[]> getHolidayList() throws Exception;
	public List<Object[]> projectWiseEmpExtraWorkingDaysList(String empId, String fromDate, String toDate) throws Exception;
	public List<Object[]> getRoleWiseEmployeeList(String labCode, String loginType, String empId) throws Exception;
	public Map<String, Map<LocalDate, TimeSheet>> getTimesheetDataForOfficer(String superiorOfficer, String labCode, String dateofWeek, String loginType) throws Exception;
	public List<Object[]> getEmployeeNewTimeSheetList(String empId, String fromDate, String toDate) throws Exception;
	public List<TimesheetKeywords> getTimesheetKeywordsList() throws Exception;
	
}
