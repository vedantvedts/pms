package com.vts.pfms.dao;

import java.sql.Date;
import java.util.List;

import com.vts.pfms.login.ProjectHoa;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.model.LoginStamping;
import com.vts.pfms.model.Notice;
import com.vts.pfms.model.ProjectHoaChanges;
import com.vts.pfms.project.model.ProjectHealth;

public interface RfpMainDao {

	public List<Object[]> DashBoardFormUrlList(int FormModuleId,int loginId )throws Exception;
	public List<Object[]> UserManagerList()throws Exception;
	public Long LoginStampingInsert(LoginStamping Stamping)throws Exception;
	public Long LastLoginStampingId(String LoginId)throws Exception;
	public int  LoginStampingUpdate(LoginStamping Stamping)throws Exception;
	public LabMaster LabDetailes()throws Exception;
	public List<Object[]> LabDetails()throws Exception;
	public String DesgId(String Empid)throws Exception;
	
	///Rajat Changes///Notice
	public List<Object[]> getIndividualNoticeList(String userId)throws Exception;
	public Long addNotice(Notice notice)throws Exception;


	public List<Object[]> AllActionsCount(String empid,String ProjectId) throws Exception;


	

	public List<Object[]> GetNotice()throws Exception;
    public List<Object[]> getAllNotice()throws Exception;
    public List<Object> GetNoticeEligibility(String empId)throws Exception;
	public List<Object> SelfActionsList(String empId) throws Exception;
	public List<Object[]> getIndividualNoticeList(String empId, Date fdate, Date tdate)throws Exception;
	public List<Object[]> getnoticeEditData(String noticeId)throws Exception;
	public int noticeDelete(String noticeId)throws Exception;
	public int editNotice(Notice notice)throws Exception;
	public List<Object[]> ProjectBudgets() throws Exception;
	public Object[] AllSchedulesCount(String loginid) throws Exception;
	public List<Object[]> ProjectMeetingCount(String ProjectId) throws Exception;
	List<String> getEmpNo(long empId) throws Exception;
	public List<Object[]> ProjectList() throws Exception;
	public List<Object[]> ProjectEmployeeList(String empid,String logintype,String LabCode) throws Exception;
	public List<Object[]> ProjectQuaters(String ProjectId)throws Exception;
	public List<Object[]> MileQuaters(String ProjectId,int Quater,int year )throws Exception;
	public List<Object[]> GanttChartList()  throws Exception;
	public List<Object[]> ProjectHealthData(String LabCode) throws Exception;
	public Object[] ProjectHealthTotalData(String ProjectId,String EmpId, String LoginType,String LabCode,String IsAll)  throws Exception;
	public long ProjectHealthInsert(ProjectHealth health)throws Exception;
	public Object[] ProjectHealthInsertData(String projectId) throws Exception;
	public int ProjectHealthDelete(String projectId)throws Exception;
	public long ProjectHoaUpdate(ProjectHoa hoa ) throws Exception;
	public int ProjectHoaDelete() throws Exception;
	public Object[] ChangesTotalCountData(String ProjectId) throws Exception;
	public List<Object[]> MeetingChanges(String ProjectId,String Term,String LabCode) throws Exception;
	public List<Object[]> MilestoneChanges(String ProjectId,String Interval,String LabCode) throws Exception;
	public List<Object[]> ActionChanges(String ProjectId,String Interval,String LabCode) throws Exception;
	public List<Object[]> RiskChanges(String ProjectId,String Interval,String LabCode) throws Exception;
	public List<Object[]> FinanceDataPartA(String ProjectId, String Interval) throws Exception;
	public int ProjectHoaChangesDelete(String projectId)throws Exception;
	public long ProjectHoaChangesInsert(ProjectHoaChanges changes) throws Exception;

}
