package com.vts.pfms.header.dao;

import java.util.List;

public interface HeaderDao {

	public List<Object[]> FormModuleList(String LoginType,String LabCode)throws Exception;
	public List<Object[]> loginTypeList()throws Exception;
	public List<Object[]> DashboardDemandCount()throws Exception;
	public List<Object[]> NotificationList(String Empid)throws Exception;
	public int NotificationUpdate(String Empid)throws Exception;
	public List<Object[]> NotificationAllList(String Empid)throws Exception;
	public List<Object[]> EmployeeDetailes(String LoginId)throws Exception;
	public String DivisionName(String DivisionId)throws Exception;
	
	public List<Object[]> TodaySchedulesList(String EmpId, String TodayDate) throws Exception;
	public List<Object[]> TodayActionList(String EmpId) throws Exception;
	public String OldPassword(String UserId)throws Exception;
	public int PasswordChange(String OldPassword,String NewPassword,String UserName,String ModifiedDate)throws Exception;
	public String FormRoleName(String LoginType) throws Exception;
	public List<Object[]> GanttChartList(String ProjectId) throws Exception;
	public List<Object[]> ProjectList() throws Exception;
	public List<Object[]> ProjectDetails(String ProjectId)throws Exception;
	public Object[] LabDetails(String labcode) throws Exception;
	public List<Object[]> FullGanttChartList(String ProjectId) throws Exception;
	public List<Object[]> HeaderSchedulesList(String Logintype,String FormModuleId,String LabCode) throws Exception;
	public List<Object[]> ProjectIntiationList(String EmpId, String LoginType) throws Exception;
	public List<Object[]> MyTaskList(String EmpId) throws Exception;
	public List<Object[]> ApprovalList(String EmpId,String LoginType) throws Exception;
	public List<Object[]> MyTaskDetails(String EmpId) throws Exception;
	public List<Object[]> DashboardActionPdc(String EmpId,String Logintype) throws Exception;
	public List<Object[]> MilestoneActivityList(String ProjectId) throws Exception;
	public List<Object[]> MilestoneActivityLevel(String MilestoneActivityId, String LevelId) throws Exception;
	public List<Object[]> QuickLinksList( String LoginType) throws Exception;
	public String getLabCode(String Empid) throws Exception;
	public List<Object[]> LabMasterList(String Clusterid) throws Exception;
}
