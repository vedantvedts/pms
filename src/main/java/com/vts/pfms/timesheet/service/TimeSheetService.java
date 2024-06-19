package com.vts.pfms.timesheet.service;

import java.util.List;

import com.vts.pfms.timesheet.dto.TimeSheetDTO;
import com.vts.pfms.timesheet.model.TimeSheet;

public interface TimeSheetService {

	public List<Object[]> getEmpActivityAssignList(String empId) throws Exception;
	public TimeSheet getTimeSheetByDateAndEmpId(String empId, String activityDate) throws Exception;
	public TimeSheet getTimeSheetById(String timeSheetId) throws Exception;
	public Long timeSheetSubmit(TimeSheetDTO dto) throws Exception;
	public Long timeSheetDetailsForward(String timeSheetId, String empId, String action, String userId) throws Exception;
	public List<Object[]> getEmpAllTimeSheetList(String empId, String activityDate) throws Exception;
	
}
