package com.vts.pfms.timesheet.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.vts.pfms.timesheet.dto.TimeSheetDTO;
import com.vts.pfms.timesheet.model.TimeSheet;

public interface TimeSheetService {

	public List<Object[]> getEmpActivityAssignList(String empId) throws Exception;
	public TimeSheet getTimeSheetByDateAndEmpId(String empId, String activityDate) throws Exception;
	public TimeSheet getTimeSheetById(String timeSheetId) throws Exception;
	public Long timeSheetSubmit(TimeSheetDTO dto) throws Exception;
	public Long timeSheetDetailsForward(String[] timeSheetIds, String empId, String action, String userId, String remarks) throws Exception;
	public List<Object[]> getEmpAllTimeSheetList(String empId, String activityDate) throws Exception;
	public List<Object[]> getEmployeesofSuperiorOfficer(String superiorOfficer, String labCode) throws Exception;
	public Map<String, Map<LocalDate, TimeSheet>> getTimesheetDataForSuperior(String superiorOfficer, String labCode, String dateofWeek) throws Exception; 
}
