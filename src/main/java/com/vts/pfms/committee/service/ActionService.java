package com.vts.pfms.committee.service;


import java.util.List;

import com.vts.pfms.committee.dao.ActionSelfDao;
import com.vts.pfms.committee.dto.ActionAssignDto;
import com.vts.pfms.committee.dto.ActionMainDto;
import com.vts.pfms.committee.dto.ActionSubDto;
import com.vts.pfms.committee.model.ActionAssign;
import com.vts.pfms.committee.model.ActionAttachment;
import com.vts.pfms.committee.model.ActionMain;

public interface ActionService {


	public List<Object[]> EmployeeList(String LabCode) throws Exception;
	public List<Object[]> AssignedList(String EmpId ) throws Exception;
	public Object[] GetActionReAssignData(String Actionassignid)throws Exception;
	public Object[] GetProjectData(String projectid)throws Exception;
	public long ActionMainInsert(ActionMainDto main , ActionAssignDto assign)throws Exception;
	public List<Object[]> AssigneeList(String EmpId) throws Exception;
	public List<Object[]> AssigneeData(String MainId ,String Assignid) throws Exception;
	public List<Object[]> SubList(String MainId) throws Exception;
	public List<Object[]> AssigneeDetails(String assignid) throws Exception;
	public long ActionSubInsert(ActionSubDto main)throws Exception;
	public ActionAttachment ActionAttachmentDownload(String achmentid) throws Exception;
	public int ActionSubDelete(String id,String UserId) throws Exception;
	public int ActionForward(String mainid,String assignid,String UserId) throws Exception;
	public List<Object[]> ForwardList(String EmpId) throws Exception;
	public int ActionClosed(String id,String Remarks,String UserId ,String assignid , String levelcount) throws Exception;
	public int ActionSendBack(String id,String Remarks,String UserId, String assignid) throws Exception;
	public List<Object[]> StatusList(String EmpId,String fdate, String tdate) throws Exception;
	public List<Object[]> ActionList(String EmpId) throws Exception;
	public List<Object[]> CommitteeActionList(String EmpId) throws Exception;
	public Object[] CommitteeScheduleEditData(String CommitteeScheduleId) throws Exception ;
	public List<Object[]> ScheduleActionList(String ScheduleId) throws Exception;
	public List<Object[]> MeetingContent(String ScheduleId) throws Exception;
	public List<Object[]> ActionNoSearch(String ActionMainId) throws Exception;
	public String ScheduleActionItem(String ScheduleId) throws Exception;
	public List<Object[]> ActionReports(String EmpId,String Term,String Position,String Type,String LabCode) throws Exception ;
	public List<Object[]> ActionSearch(String EmpId,String No,String Position) throws Exception;
	public List<Object[]> ProjectList() throws Exception;
	public List<Object[]> ActionCountList(String ProjectId) throws Exception;
	public List<Object[]> projectdetailsList(String EmpId) throws Exception;
	public List<Object[]> ActionWiseReports(String Term,String ProjectId) throws Exception ;
	public List<Object[]> ActionPdcReports(String Emp,String ProjectId,String Position,String From,String To ) throws Exception ;
	public int ActionExtendPdc(String id,String date,String UserId ,String assignid) throws Exception;
	public List<Object[]> ActionSelfList(String EmpId)throws Exception;
	public List<Object[]> SearchDetails(String MainId ,String assignid) throws Exception;
	public List<Object[]> allprojectdetailsList() throws Exception;
	public List<Object[]> ActionWiseAllReport(String Term,String empid,String ProjectId) throws Exception;
	public long ActionSelfReminderAddSubmit(ActionSelfDao actionselfdao) throws Exception;
	public List<Object[]> ActionSelfReminderList(String empid,String fromdate,String todate) throws Exception;
	public int ActionSelfReminderDelete(String actionid) throws Exception;
	public List<Object[]> getActionAlertList() throws Exception;
	public List<Object[]> getActionToday(String empid,String ai) throws Exception;
	public List<Object[]> getActionTommo(String empid,String ai) throws Exception;
	public List<Object[]> getMeetingAlertList() throws Exception;
	public List<Object[]> getMeetingToday(String empid) throws Exception;
	public List<Object[]> getMeetingTommo(String empid) throws Exception;
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype , String LabCode) throws Exception;
	public List<Object[]> AllEmpNameDesigList() throws Exception;
	public List<Object[]> ProjectEmpList(String projectid) throws Exception;
	public List<Object[]> EmployeeDropdown(String empid, String logintype,String projectid) throws Exception;
	public Object[] ActionDetailsAjax(String actionid ,String assignid) throws Exception;
	public int ActionMainEdit(ActionMain main) throws Exception;
	public int ActionAssignEdit(ActionAssign assign) throws Exception;
	public List<Object[]> AllLabList() throws Exception;
	public Object[] GetActionMainData(String Actionmainid)throws Exception;
	public List<Object[]> ClusterExpertsList() throws Exception;
	public List<Object[]> ClusterFilterExpertsList(String Labcode , String MainId)throws Exception;
	public Object[] LabInfoClusterLab(String LabCode) throws Exception;
	public List<Object[]> LabEmployeeList(String LabCode) throws Exception;
	public List<Object[]> LabEmpListFilterForAction(String LabCode , String MainId)throws Exception;
	public List<Object[]> ActionSubLevelsList(String ActionAssignId) throws Exception;
	public List<Object[]> ActionSubList(String assignid) throws Exception;
	public long ActionMainInsertFromOnboard(ActionMainDto main , ActionAssign assign)throws Exception;
	public long IssueSubInsert(ActionSubDto main) throws Exception;
	public List<Object[]> GetIssueList( String Empid )throws Exception;
	public int IssueClosed(String id, String Remarks, String UserId ,String assignid)throws Exception;
	public List<Object[]> GetRecomendationList(String projectid ,  String committeid)throws Exception;
	public List<Object[]> GetDecisionList(String projectid ,  String committeid)throws Exception;
	public Object[] ActionAssignDataAjax(String assignid) throws Exception;
	public List<Object[]> GetDecisionSoughtList(String projectid,String  committeeid)throws Exception;
}
