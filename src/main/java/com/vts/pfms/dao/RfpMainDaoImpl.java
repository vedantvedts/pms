package com.vts.pfms.dao;

import java.math.BigInteger;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.committee.controller.ActionController;
import com.vts.pfms.login.ProjectHoa;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.model.LoginStamping;
import com.vts.pfms.model.Notice;
import com.vts.pfms.model.ProjectHoaChanges;
import com.vts.pfms.project.model.ProjectHealth;

@Transactional
@Repository
public class RfpMainDaoImpl implements RfpMainDao {

	private static final Logger logger=LogManager.getLogger(RfpMainDaoImpl.class);
	
	private static final String DASHBOARDFORMURLLIST = "select a.formdispname,a.formurl,a.formcolor from form_detail a,form_role_access b,login c where c.loginid=:loginid and a.formmoduleid=:formmoduleid AND b.formroleid=c.formroleid AND a.formdetailid=b.formdetailid AND a.isactive='1' AND b.isactive='1' ORDER BY a.FormSerialNo  ";
	private static final String USERMANAGELIST = "select a.loginid, a.username, b.divisionname,c.formrolename  from login a , division_master b , formrole c where a.divisionid=b.divisionid and a.formroleid=c.formroleid and a.isactive=1";
	private static final String LASTLOGINEMPID = "select a.auditstampingid from  auditstamping a where a.auditstampingid=(select max(b.auditstampingid) from auditstamping b WHERE b.loginid=:loginid)";
	private static final String LOGINSTAMPINGUPDATE="update auditstamping set logouttype=:logouttype,logoutdatetime=:logoutdatetime where auditstampingid=:auditstampingid";
	private static final String DESGID="select desigid from employee where  empid=:empid";
	private static final String LABDETAILS="select labmasterid, labcode, labname, lablogo from lab_master";
	
	private static final String NOTICEEDITDATA="SELECT * FROM pfms_notice WHERE NoticeId=:NOTICEID AND IsActive=1" ;
	private static final String SELFACTIONSLIST="SELECT ActionId,EmpId,ActionItem,ActionDate,ActionTime,ActionType FROM pfms_action_self WHERE isactive='1'AND actiondate=CURDATE() AND empid=:empid ORDER BY createddate ASC";	
	private static final String NOTICEDATEWOSE= "SELECT noticeid, notice, fromdate,todate,noticeby,createdby,createddate FROM pfms_notice WHERE NoticeBy=:EMPID AND IsActive=1 AND ( (FromDate BETWEEN :FROMDATE AND :TODATE) OR  (todate BETWEEN :FROMDATE  AND :TODATE )   OR( fromdate < :FROMDATE  AND todate > :TODATE  ))";
	private static final String REVOKENOTICE="UPDATE pfms_notice SET isactive=:isactive WHERE NoticeId=:NOTICEID";
	private static final String EDITNOTICE="UPDATE pfms_notice SET Notice=:NOTICE,FromDate=:FROMDATE,ToDate=:TODATE, NoticeBy=:NOTICEBY WHERE NoticeId=:NOTICEID";
	private static final String NOTICELIST="SELECT * FROM pfms_notice WHERE NoticeBy=:empid AND IsActive=1 AND MONTH(CreatedDate) = MONTH(CURRENT_DATE())";
	private static final String NOTICE="SELECT n.noticeid,n.notice, e.EmpName FROM pfms_notice n, employee e   WHERE   DATE(NOW()) >=n.FromDate AND DATE(NOW()) <= n.ToDate AND e.EmpId=n.NoticeBy AND n.IsActive=1 AND n.labcode=:labcode ORDER BY n.NoticeId DESC";	
	private static final String getEmpNoQuery="SELECT empno FROM employee WHERE empid =:empid";	
	private static final String PROJECTLIST="SELECT a.projectid AS id,a.projectcode,a.projectname,a.projectmainid,a.projecttype,b.empname AS 'project_director',b.mobileno,a.projectdirector,a.sanctiondate,a.pdc FROM project_master a , employee b WHERE a.projectdirector=b.empid AND a.isactive=1 AND a.labcode = (SELECT labcode FROM employee WHERE empid=:empid)";
	private static final String QUATERS="SELECT a.sanctiondate, a.pdc, TIMESTAMPDIFF(YEAR,a.sanctiondate,a.pdc)+1 FROM project_master a WHERE a.projectid=:projectid";
	private static final String MILEQUATER="CALL Pfms_Milestone_Quarter(:proid,:Quater,:yr)"; 
	private static final String GANTTCHARTLIST="SELECT milestoneactivityid,projectid,activityname,milestoneno,orgstartdate,orgenddate,startdate,enddate,progressstatus,revisionno FROM milestone_activity WHERE isactive=1 ";
	private static final String PROJECTHEALTHDATA ="CALL Project_Health_Get_Data(:labcode)";
	private static final String PROJECTTOTALHEALTHDATA="CALL Project_Health_Total_Data(:projectid,:empid,:logintype,:labcode,:isall )";
	private static final String PROJECTHEALTHINSERTDATA="CALL Project_Health_Insert_Data(:projectid)";
	private static final String PROJECTHEALTHDELETE="DELETE FROM project_health where projectid=:projectid";
	private static final String PROJECTHOADELETE="DELETE FROM project_hoa WHERE labcode=:labcode";
	private static final String CHANGESTOTALCOUNTDATA="CALL Project_Changes_Count_Data(:projectid) ";
	private static final String MEETINGCHANGES="CALL Project_Changes_Meeting_Data(:projectid,:term,:labcode)";
	private static final String MILESTONECHANGES="CALL Project_Changes_Milestone_Data(:projectid,:term,:labcode)";
	private static final String ACTIONCHANGES="CALL Project_Changes_Action_Data(:projectid,:term,:labcode)";
	private static final String RISKCHANGES="CALL Project_Changes_Risk_Data(:projectid,:term,:labcode)";
	private static final String FINANCEDATAPARTA="SELECT pftsfileid,projectid,demandno,demanddate,estimatedcost,itemnomenclature FROM pfts_file WHERE isactive=1 AND CASE WHEN :projectid='A' THEN 1=1 ELSE projectid=:projectid END";
	private static final String PROJECTHOACHANGESDELETE="DELETE FROM project_hoa_changes where projectid=:projectid";
	
	
	@PersistenceContext
	EntityManager manager;

	
	@Override
	public List<String> getEmpNo(long empId) throws Exception {
		Query query = manager.createNativeQuery(getEmpNoQuery);
		query.setParameter("empid", empId);
		List<String> empnoList = query.getResultList();
		return empnoList;
	}
	
	@Override
	public List<Object[]> DashBoardFormUrlList(int FormModuleId, int loginId) throws Exception {

		Query query = manager.createNativeQuery(DASHBOARDFORMURLLIST);
		query.setParameter("loginid", loginId);
		query.setParameter("formmoduleid", FormModuleId);
		List<Object[]> DashBoardFormUrlList = query.getResultList();
		return DashBoardFormUrlList;
	}

	@Override
	public List<Object[]> UserManagerList() throws Exception {
		Query query = manager.createNativeQuery(USERMANAGELIST);

		List<Object[]> UserManagerList = query.getResultList();
		return UserManagerList;
	}

	@Override
	public Long LoginStampingInsert(LoginStamping Stamping) throws Exception {

		manager.persist(Stamping);

		manager.flush();

		return Stamping.getAuditStampingId();
	}

	@Override
	public Long LastLoginStampingId(String LoginId) throws Exception {
		Query query = manager.createNativeQuery(LASTLOGINEMPID);
		query.setParameter("loginid", LoginId);
		BigInteger LastLoginStampingId = (BigInteger) query.getSingleResult();
		return LastLoginStampingId.longValue();
	}

	@Override
	public int LoginStampingUpdate(LoginStamping Stamping) throws Exception {
		Query query = manager.createNativeQuery(LOGINSTAMPINGUPDATE);
		query.setParameter("logouttype", Stamping.getLogOutType());
		query.setParameter("logoutdatetime", Stamping.getLogOutDateTime());
		query.setParameter("auditstampingid", Stamping.getAuditStampingId());		
		int LoginStampingUpdate = (int) query.executeUpdate();
		return  LoginStampingUpdate;
	}
	
	
	@Override
	public LabMaster LabDetailes() throws Exception {
		LabMaster LabDetailes=manager.find(LabMaster.class, 1);
		return LabDetailes;
	}
	
	@Override
	public List<Object[]> LabDetails() throws Exception {
		
		Query query=manager.createNativeQuery(LABDETAILS);
		List<Object[]> LabDetails=(List<Object[]>)query.getResultList();
		
		return LabDetails;
	}

	@Override
	public String DesgId(String Empid) throws Exception {
		Query query = manager.createNativeQuery(DESGID);
		query.setParameter("empid", Empid);
		BigInteger DesgId = (BigInteger) query.getSingleResult();
		return DesgId.toString();
	}
	

	

	@Override
	public List<Object[]> getIndividualNoticeList(String userId)throws Exception{
		
		Query query = manager.createNativeQuery(NOTICELIST);
		query.setParameter("empid", userId);
		List<Object[]> NoticeList=(List<Object[]>)query.getResultList();
		
		return NoticeList;		
	}

	@Override
	public Long addNotice(Notice notice)throws Exception{
		
		try {
			manager.persist(notice);
			manager.flush();
			
		}catch(Exception e) {
			logger.info(new Date() +"Inside ActionLaunch.htm "+ e);	
			e.printStackTrace();
		}

		return notice.getNoticeId();
	}
	

	
	@Override
	public List<Object[]> AllActionsCount(String empid,String ProjectId) throws Exception {
		
		Query query=manager.createNativeQuery("CALL Pfms_All_Actions_Count (:empid,:projectid)");	
		query.setParameter("empid", empid);
		query.setParameter("projectid", ProjectId);

		List<Object[]> AllActionsCount=(List<Object[]>)query.getResultList();	
		return AllActionsCount;
	}
	
	@Override
	public List<Object[]> GetNotice(String LabCode)throws Exception{
		
		Query query = manager.createNativeQuery(NOTICE);
		query.setParameter("labcode", LabCode);
		List<Object[]> NoticeList=(List<Object[]>)query.getResultList();
		
		return NoticeList;	
	}

	@Override
	public List<Object[]> getAllNotice()throws Exception{
		
		Query query = manager.createNativeQuery(NOTICE);
		List<Object[]> NoticeList=(List<Object[]>)query.getResultList();
		
		return NoticeList;	
		
	}
	
	@Override
    public List<Object> GetNoticeEligibility(String empId)throws Exception{
		
		Query query=manager.createNativeQuery("CALL Pfms_Notice_Eligibility(:EMPID)");	
		query.setParameter("EMPID",empId);
		List<Object> NoticeList=(List<Object>)query.getResultList();

		return NoticeList;	
    }
	
	
	@Override
    public List<Object> SelfActionsList(String empId)throws Exception {
		
		Query query=manager.createNativeQuery(SELFACTIONSLIST);	
		query.setParameter("empid",empId);
		List<Object> SelfActionsList=(List<Object>)query.getResultList();

		return SelfActionsList;	
    }

	@Override
	public List<Object[]> getIndividualNoticeList(String empId, java.sql.Date fdate, java.sql.Date tdate)throws Exception{
		
		Query query=manager.createNativeQuery(NOTICEDATEWOSE);	
		query.setParameter("EMPID",empId);
		query.setParameter("FROMDATE", fdate);
		query.setParameter("TODATE", tdate);
		List<Object[]> SelfActionsList=(List<Object[]>)query.getResultList();

		return SelfActionsList;	
		
	}
	
	@Override
	public List<Object[]> getnoticeEditData(String noticeId)throws Exception{
		Query query=manager.createNativeQuery(NOTICEEDITDATA);
		query.setParameter("NOTICEID", noticeId);
		List<Object[]> EditData=(List<Object[]>)query.getResultList();
        return EditData;
	}
	
	
	@Override
	public int noticeDelete(String noticeId)throws Exception{
		
		Query query=manager.createNativeQuery(REVOKENOTICE);
		query.setParameter("NOTICEID",noticeId);
		query.setParameter("isactive",0);
		int count =(int)query.executeUpdate();
		
		return count ;
		
	}
	
	 
	
	@Override
	public int editNotice(Notice notice)throws Exception{
		
		Query query=manager.createNativeQuery(EDITNOTICE);
		query.setParameter("NOTICEID",notice.getNoticeId());
		query.setParameter("NOTICE", notice.getNotice());
		query.setParameter("FROMDATE",notice.getFromDate());
		query.setParameter("TODATE",notice.getToDate());
		query.setParameter("NOTICEBY", notice.getNoticeBy());
		int count =(int)query.executeUpdate();
		
		return count ;
		
	}
	
	@Override
	public List<Object[]> ProjectBudgets() throws Exception {
		Query query=manager.createNativeQuery("CALL Pfms_Dashboard_Finance_Budgets();");
		List<Object[]> ProjectsBudgets=(List<Object[]>)query.getResultList();
		return ProjectsBudgets;
	}
	
	
	@Override
	public Object[] AllSchedulesCount(String loginid) throws Exception {
		Query query=manager.createNativeQuery("CALL Pfms_All_Meetings_Count(:loginid);");
		query.setParameter("loginid",loginid);
		Object[] AllSchedulesCount=(Object[])query.getSingleResult();
		return AllSchedulesCount;
	}

	@Override
	public List<Object[]> ProjectMeetingCount(String ProjectId) throws Exception {
		Query query=manager.createNativeQuery("CALL Pfms_All_Meetings_Count(:ProjectId);");
		query.setParameter("ProjectId",ProjectId);
		List<Object[]> ProjectMeetingCount=(List<Object[]>)query.getResultList();
		return ProjectMeetingCount;
	}

	@Override
	public List<Object[]> ProjectList(String EmpId) throws Exception {
		
		Query query=manager.createNativeQuery(PROJECTLIST);
		query.setParameter("empid", EmpId);

		return (List<Object[]>) query.getResultList();
	}


	@Override
	public List<Object[]> ProjectEmployeeList(String empid,String logintype,String LabCode) throws Exception {
		
		Query query=manager.createNativeQuery("CALL Pfms_Emp_ProjectList (:empid,:logintype,:labcode)");
		//Query query=manager.createNativeQuery(PROJECTEMPLOYEELIST);
		query.setParameter("empid",empid);
		query.setParameter("logintype", logintype);
		query.setParameter("labcode", LabCode);
		List<Object[]> ProjectEmployeeList=(List<Object[]>)query.getResultList();
		return ProjectEmployeeList;
	}
	
	
	
	@Override
	public List<Object[]> ProjectQuaters(String ProjectId) throws Exception {

		Query query=manager.createNativeQuery(QUATERS);
		query.setParameter("projectid",ProjectId);
		List<Object[]> ProjectQuaters=(List<Object[]>)query.getResultList();
		return ProjectQuaters;
	}

	@Override
	public List<Object[]> MileQuaters(String ProjectId, int Quater, int year) throws Exception {
		Query query=manager.createNativeQuery(MILEQUATER);
		query.setParameter("proid",ProjectId);
		query.setParameter("Quater",Quater);
		query.setParameter("yr",year);
		List<Object[]> ProjectQuaters=(List<Object[]>)query.getResultList();
		return ProjectQuaters;
	}
	
	@Override
	public List<Object[]> GanttChartList() throws Exception {
		
		Query query = manager.createNativeQuery(GANTTCHARTLIST);
		//query.setParameter("projectid", ProjectId);
		List<Object[]> GanttChartList= query.getResultList();
		return GanttChartList;
	}
	
	@Override
	public List<Object[]> ProjectHealthData(String LabCode) throws Exception {
		
		Query query = manager.createNativeQuery(PROJECTHEALTHDATA);
		query.setParameter("labcode", LabCode);
		List<Object[]> ProjectHealthData= query.getResultList();
		return ProjectHealthData;
	}
	
	@Override
	public Object[] ProjectHealthTotalData(String ProjectId,String EmpId, String LoginType,String LabCode,String IsAll) throws Exception {
		
		Query query = manager.createNativeQuery(PROJECTTOTALHEALTHDATA);
		query.setParameter("projectid", ProjectId);
		query.setParameter("empid", EmpId);
		query.setParameter("logintype", LoginType);
		query.setParameter("labcode", LabCode);
		query.setParameter("isall", IsAll);
		 	
		Object[] ProjectHealthTotalData= (Object[])query.getSingleResult();
		return ProjectHealthTotalData;
	}

	@Override
	public long ProjectHealthInsert(ProjectHealth health) throws Exception {
		manager.persist(health);

		manager.flush();

		return health.getProjectHealthId();
	}
	@Override
	public Object[] ProjectHealthInsertData(String projectId) throws Exception {
		
		Query query = manager.createNativeQuery(PROJECTHEALTHINSERTDATA);
		query.setParameter("projectid", projectId);
		Object[] ProjectHealthTotalData= (Object[])query.getSingleResult();
		return ProjectHealthTotalData;
	}

	@Override
	public int ProjectHealthDelete(String projectId) throws Exception {
		Query query = manager.createNativeQuery(PROJECTHEALTHDELETE);
		query.setParameter("projectid", projectId);
		int count =(int)query.executeUpdate();
		
		return count ;
	}
	
	@Override
	public long ProjectHoaUpdate(ProjectHoa hoa)throws Exception{
		
		manager.merge(hoa);
		manager.flush();
		
		return hoa.getProjectHoaId();
	}
	
	@Override
	public int ProjectHoaDelete(String LabCode) throws Exception{
		
		Query query = manager.createNativeQuery(PROJECTHOADELETE);
		query.setParameter("labcode", LabCode);

		return query.executeUpdate();
	}
	
	@Override
	public Object[] ChangesTotalCountData(String ProjectId) throws Exception
	{
		
		Query query = manager.createNativeQuery(CHANGESTOTALCOUNTDATA);
		query.setParameter("projectid", ProjectId);
		return (Object[]) query.getSingleResult();
		
	}
	
	@Override
	public List<Object[]> MeetingChanges(String ProjectId,String Interval,String LabCode) throws Exception
	{

		Query query = manager.createNativeQuery(MEETINGCHANGES);
		query.setParameter("projectid", ProjectId);
		query.setParameter("term", Interval);
		query.setParameter("labcode", LabCode);
		return (List<Object[]>) query.getResultList();
		
	}
	
	@Override
	public List<Object[]> MilestoneChanges(String ProjectId,String Interval,String LabCode) throws Exception
	{
		
		Query query = manager.createNativeQuery(MILESTONECHANGES);
		query.setParameter("projectid", ProjectId);
		query.setParameter("term", Interval);
		query.setParameter("labcode", LabCode);
		return (List<Object[]>) query.getResultList();
		
	}
	
	@Override
	public List<Object[]> ActionChanges(String ProjectId,String Interval,String LabCode) throws Exception
	{
		
		Query query = manager.createNativeQuery(ACTIONCHANGES);
		query.setParameter("projectid", ProjectId);
		query.setParameter("term", Interval);
		query.setParameter("labcode", LabCode);
		return (List<Object[]>) query.getResultList();
		
	}
	
	@Override
	public List<Object[]> RiskChanges(String ProjectId,String Interval,String LabCode) throws Exception
	{
		
		Query query = manager.createNativeQuery(RISKCHANGES);
		query.setParameter("projectid", ProjectId);
		query.setParameter("term", Interval);
		query.setParameter("labcode", LabCode);
		return (List<Object[]>) query.getResultList();
		
	}
	
	
	@Override
	public List<Object[]> FinanceDataPartA(String ProjectId,String Interval) throws Exception
	{
		
		Query query = manager.createNativeQuery(FINANCEDATAPARTA);
		query.setParameter("projectid", ProjectId);
		//query.setParameter("term", Interval);
		return (List<Object[]>) query.getResultList();
		
	}
	
	@Override
	public int ProjectHoaChangesDelete(String projectId) throws Exception {
		Query query = manager.createNativeQuery(PROJECTHOACHANGESDELETE);
		query.setParameter("projectid", projectId);
		int count =(int)query.executeUpdate();
		
		return count ;
	}
	
	@Override
	public long ProjectHoaChangesInsert(ProjectHoaChanges changes)throws Exception{
		
		manager.merge(changes);
		manager.flush();
		
		return 0L;
	}
	
	private static final String PROJECTDATA ="SELECT projectid, projectcode, projectname FROM project_master WHERE projectid=:projectid ";
	@Override
	public Object[] ProjectData(String projectid) throws Exception 
	{
		try {
			Query query=manager.createNativeQuery(PROJECTDATA);
			query.setParameter("projectid",projectid);
			return (Object[])query.getSingleResult();
		}catch (NoResultException e) {
			return null;
		}
		
	}
}

