package com.vts.pfms.header.service;

import java.util.List;

import com.vts.pfms.header.model.ProjectDashBoardFavourite;
import com.vts.pfms.login.Login;

public interface HeaderService {

	public List<Object[]> FormModuleList(String LoginType,String LabCode)throws Exception;
	public List<Object[]> loginTypeList(String LoginType)throws Exception;
	public List<Object[]> DashboardDemandCount()throws Exception;
	public List<Object[]> NotificationList(String Empid)throws Exception;
	public int NotificationUpdate(String NotificationId)throws Exception;
	public List<Object[]> NotificationAllList(String Empid)throws Exception;
	public List<Object[]> EmployeeDetailes(String LoginId)throws Exception;
	public String DivisionName(String DivisionId)throws Exception;
	
	public List<Object[]> TodaySchedulesList(String EmpId,String TodayDate) throws Exception;
	public List<Object[]> TodayActionList(String EmpId) throws Exception;
	public int PasswordChange(String OldPassword,String NewPassword,String UserId)throws Exception;
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
	public List<Object[]> DashboardActionPdc(String EmpId,String LoginType) throws Exception;
	public List<Object[]> MilestoneActivityList(String ProjectId) throws Exception;
	public List<Object[]> MilestoneActivityLevel(String MilestoneActivityId, String LevelId) throws Exception;
	public List<Object[]> QuickLinksList( String LoginType) throws Exception;
	public String getLabCode(String Empid) throws Exception;
	public List<Object[]> LabMasterList(String Clusterid) throws Exception;
	// new method by anil
	public List<Object[]> getNotificationId(String Empid)throws Exception;
	public List<Object[]> getFormNameByName(String valueOf) throws Exception;
	public Boolean getRoleAccess(String valueOf, String string)throws Exception;
	public long addDashBoardFav(String projects, String favName, String empId,String UserId,String LoginType)throws Exception;
	public ProjectDashBoardFavourite findProjectDashBoardFavourite(long DashBoardId)throws Exception;
	public List<Object[]> getDashBoardId(Long empId , String LoginType)throws Exception;
	public Object[] projecthealthtotalDashBoardwise(String dashBoardId, String labCode)throws Exception;
	public long isActiveDashBoard(String empId, String loginType)throws Exception;
	public List<Object[]> DashboardFinanceProjectWise(String dashBoardId, String labCode)throws Exception;
	
	public List<Object[]> getDashBoards(Long empId , String LoginType)throws Exception;
	public long updateDashBoard(String dashboardId,String projects,String UserId)throws Exception;
	public List<Object[]> getProjectsBasedOnDashBoard(String dashBoardId)throws Exception;
	
}
