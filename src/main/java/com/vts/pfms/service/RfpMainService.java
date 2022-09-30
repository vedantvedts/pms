package com.vts.pfms.service;

import java.util.ArrayList;
import java.util.List;

import com.vts.pfms.login.ProjectHoa;
import com.vts.pfms.model.FinanceChanges;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.model.Notice;

public interface RfpMainService {

	
	public List<Object[]> DashBoardFormUrlList(String FormModuleId,String loginId )throws Exception;
	public List<Object[]> UserManagerList()throws Exception;
	public int  LoginStampingUpdate(String Logid,String LogoutType)throws Exception;
	public LabMaster LabDetailes()throws Exception;
	public List<Object[]> LabDetails()throws Exception;
	public String DesgId(String Empid)throws Exception;
	
	/////////Rajat Changes//Notice
	public List<Object[]> getIndividualNoticeList(String userId)throws Exception;
	public Long addNotice(Notice notice)throws Exception;


	public List<Object[]> AllActionsCount(String logintype, String empid,String LoginId) throws Exception;



	public List<Object[]> GetNotice()throws Exception;
	public List<Object[]> getAllNotice()throws Exception;
	public int GetNoticeEligibility(String empId)throws Exception;
	public List<Object> SelfActionsList(String empId) throws Exception;
	public List<Object[]>  getIndividualNoticeList(String empId, String fdate, String tdate)throws Exception;
	public List<Object[]>  noticeEditData(String noticeId)throws Exception;
	public int noticeDelete(String noticeId)throws Exception;
	public int editNotice(Notice notice)throws Exception;
	public List<Object[]> ProjectBudgets() throws Exception;
	public Object[] AllSchedulesCount(String LoginType,String loginid) throws Exception;
	
	public List<Object[]> ProjectMeetingCount(String LoginType,String empid) throws Exception;
	public List<Object[]> ProjectList(String LoginType,String LoginId) throws Exception;
	public ArrayList<String> ProjectQuaters(String ProjectId)throws Exception;
	public String getEmpNo(long empId) throws Exception;
	public List<Object[]> GanttChartList() throws Exception;
	public List<Object[]> ProjectHealthData() throws Exception;
	public Object[] ProjectHealthTotalData(String ProjectId,String EmpId,String LoginType,String LabCode) throws Exception;
	public long ProjectHealthUpdate(String EmpId,String UserName)throws Exception;
	public long ProjectHoaUpdate(List<ProjectHoa> hoa, String Username) throws Exception;
	public Object[] ChangesTotalCountData(String ProjectId) throws Exception;
	public List<Object[]> MeetingChanges(String ProjectId,String Interval) throws Exception;
	public List<Object[]> MilestoneChanges(String ProjectId,String Interval) throws Exception;
	public List<Object[]> ActionChanges(String ProjectId,String Interval) throws Exception;
	public List<Object[]> RiskChanges(String ProjectId,String Interval) throws Exception;
	public List<Object[]> FinanceDataPartA(String ProjectId, String Interval) throws Exception;
	public long ProjectFinanceChangesUpdate(List<FinanceChanges> Monthly, List<FinanceChanges> Weekly, List<FinanceChanges> Today, String UserId) throws Exception;
}
