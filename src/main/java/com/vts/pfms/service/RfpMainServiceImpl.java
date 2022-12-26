package com.vts.pfms.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.dao.RfpMainDao;
import com.vts.pfms.login.ProjectHoa;
import com.vts.pfms.model.FinanceChanges;
import com.vts.pfms.model.IbasLabMaster;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.model.LoginStamping;
import com.vts.pfms.model.Notice;
import com.vts.pfms.model.ProjectHoaChanges;
import com.vts.pfms.project.model.ProjectHealth;
@Service
public class RfpMainServiceImpl implements RfpMainService {
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	private SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
	
	@Autowired
	RfpMainDao dao;
	
			private static final Logger logger=LogManager.getLogger(RfpMainServiceImpl.class);
	
	@Override
	public List<Object[]> DashBoardFormUrlList(String FormModuleId, String loginId) throws Exception {
		logger.info(new Date() +"Inside SERVICE DashBoardFormUrlList ");
		int FormModuleIdinput=Integer.parseInt(FormModuleId);
		int LoginIdinput=Integer.parseInt(loginId);
		List<Object[]> DashBoardFormUrlList=dao.DashBoardFormUrlList(FormModuleIdinput, LoginIdinput);
		
		return DashBoardFormUrlList;
	}


	@Override
	public List<Object[]> UserManagerList() throws Exception {
	
		return dao.UserManagerList();
	}


	


	@Override
	public int LoginStampingUpdate(String Logid ,String LogoutType) throws Exception {
		logger.info(new Date() +"Inside SERVICE LoginStampingUpdate ");
		LoginStamping stamping=new LoginStamping();
        stamping.setAuditStampingId(dao.LastLoginStampingId(Logid));
       
        stamping.setLogOutType(LogoutType);
        stamping.setLogOutDateTime(sdf1.format(new Date()));
		
		
		return dao.LoginStampingUpdate(stamping);
	}


	@Override
	public LabMaster LabDetailes() throws Exception {
	
		return dao.LabDetailes();
	}
	
	@Override
	public List<Object[]> LabDetails() throws Exception {
	
		return dao.LabDetails();
	}
 

	@Override
	public String DesgId(String Empid) throws Exception {
		
		return dao.DesgId(Empid);
	}
	@Override
	public List<Object[]> getIndividualNoticeList(String userId)throws Exception{
		
		return dao.getIndividualNoticeList(userId);
		
	}
	@Override
	public Long addNotice(Notice notice)throws Exception{
		
		return dao.addNotice(notice);
	}
	
	@Override

	public List<Object[]> AllActionsCount(String logintype, String empid,String LoginId,String LabCode) throws Exception 
	{		
		logger.info(new Date() +"Inside SERVICE AllActionsCount ");
		List<Object[]> al = new ArrayList<Object[]>();
		List<Object[]> ProjectList=dao.ProjectEmployeeList(empid,logintype,LabCode);

		for(Object[] obj : ProjectList) {
			
			al.addAll(dao.AllActionsCount(empid,obj[0].toString()));
		}

		return al;
	}
	
	@Override
	public List<Object[]> GetNotice(String LabCode)throws Exception{
		
		return dao.GetNotice(LabCode);
		
	}

	
	@Override
	public List<Object[]> getAllNotice()throws Exception{
		
		return dao.getAllNotice();
	}
	
	@Override
	public int  GetNoticeEligibility(String empId)throws Exception{
		logger.info(new Date() +"Inside SERVICE GetNoticeEligibility ");
		int count =0; 
		List<Object> counts=(List<Object>) dao.GetNoticeEligibility(empId);
		for(Object data:counts) {
			count += Integer.parseInt(data.toString());
		}
		
		return count ;
	}
	
	@Override
    public List<Object> SelfActionsList(String empId)throws Exception 
	{
		return dao.SelfActionsList(empId);
	}
	
	@Override
	public List<Object[]> getIndividualNoticeList(String empId, String fdate, String tdate)throws Exception{
		
		return dao.getIndividualNoticeList(empId, new java.sql.Date(sdf.parse(fdate).getTime()), new java.sql.Date(sdf.parse(tdate).getTime()));
	}
	
	@Override
	public List<Object[]>  noticeEditData(String noticeId)throws Exception{
		
		return dao.getnoticeEditData(noticeId);
	}
	
	@Override
	public int noticeDelete(String noticeId)throws Exception{
		return dao.noticeDelete(noticeId);
	}
	
	@Override
	public int editNotice(Notice notice)throws Exception{
		
		return dao.editNotice(notice);
	}
	
	@Override
	public List<Object[]> ProjectBudgets() throws Exception {
		
		return dao. ProjectBudgets();
	}
	
	@Override
	public Object[] AllSchedulesCount(String LoginType, String loginid) throws Exception {
		logger.info(new Date() +"Inside SERVICE AllSchedulesCount ");
		Object[] allschedulescount = null;
		if(LoginType.equalsIgnoreCase("Z") || LoginType.equalsIgnoreCase("Y") || LoginType.equalsIgnoreCase("A") || LoginType.equalsIgnoreCase("E") || LoginType.equalsIgnoreCase("L") )
	     {
			allschedulescount = dao. AllSchedulesCount("0");
	     }
		else  if(!LoginType.equalsIgnoreCase("U") )
		{
			allschedulescount = dao. AllSchedulesCount(loginid);
		}
			return allschedulescount;
			
	}
	
	@Override
	public String getEmpNo(long empId) throws Exception{
		logger.info(new Date() +"Inside SERVICE getEmpNo ");
		List<String> list=dao.getEmpNo(empId);
		String empno=null;
		if(list!=null && list.size()>0) {
			empno=list.get(0);
		}
		return empno;
	}

	
	
	@Override
	public List<Object[]> ProjectMeetingCount(String LoginType,String empid,String labcode) throws Exception {
		logger.info(new Date() +"Inside SERVICE ProjectMeetingCount ");
	
		List<Object[]> ProjectList=dao.ProjectEmployeeList(empid,LoginType,labcode);
		
		List<Object[]> al= new ArrayList<Object[]>();
    	
    	for(Object[] obj : ProjectList ) {
    		
    		al.addAll(dao.ProjectMeetingCount(obj[0].toString()));
    	}
		
		return al;
		
		
	}
	
	@Override
	public List<Object[]> ProjectList(String LoginType,String empid,String labcode) throws Exception {

		logger.info(new Date() +"Inside SERVICE ProjectList");
		List<Object[]> ProjectList=dao.ProjectEmployeeList(empid,LoginType,labcode);
		
		return ProjectList;
	}
	
	@Override
	public ArrayList<String> ProjectQuaters(String ProjectId) throws Exception {
		logger.info(new Date() +"Inside SERVICE ProjectQuaters ");
		ArrayList<String> Qualters = new ArrayList<String>();
		if(!"0".equalsIgnoreCase(ProjectId)) {
		Object[] Quater=dao.ProjectQuaters(ProjectId).get(0);
		
		Date dt=sdf2.parse(Quater[0].toString());
		Calendar c=Calendar.getInstance();
		c.setTime(dt);
		int month = c.get(Calendar.MONTH);
		int year=c.get(Calendar.YEAR);

		String qtr= (month >= Calendar.JANUARY && month <= Calendar.MARCH)     ? "Q1" :
		            (month >= Calendar.APRIL && month <= Calendar.JUNE)        ? "Q2" :
		            (month >= Calendar.JULY && month <= Calendar.SEPTEMBER)    ? "Q3" :
		                                                                    "Q4";
		if("Q1".equals(qtr)) {
			Object[] mile=dao.MileQuaters(ProjectId, 1, year).get(0);
			Qualters.add("Q1-"+year+":"+mile[0]+":"+mile[1]);
			Object[] mile2=dao.MileQuaters(ProjectId, 2, year).get(0);
			Qualters.add("Q2-"+year+":"+mile2[0]+":"+mile2[1]);
			Object[] mile3=dao.MileQuaters(ProjectId, 3, year).get(0);
			Qualters.add("Q3-"+year+":"+mile3[0]+":"+mile3[1]);
			Object[] mile4=dao.MileQuaters(ProjectId, 4, year).get(0);
			Qualters.add("Q4-"+year+":"+mile4[0]+":"+mile4[1]);
		}else if("Q2".equals(qtr)) {
			Object[] mile2=dao.MileQuaters(ProjectId, 2, year).get(0);
			Qualters.add("Q2-"+year+":"+mile2[0]+":"+mile2[1]);
			Object[] mile3=dao.MileQuaters(ProjectId, 3, year).get(0);
			Qualters.add("Q3-"+year+":"+mile3[0]+":"+mile3[1]);
			Object[] mile4=dao.MileQuaters(ProjectId, 4, year).get(0);
			Qualters.add("Q4-"+year+":"+mile4[0]+":"+mile4[1]);
		}else if("Q3".equals(qtr)) {
			Object[] mile3=dao.MileQuaters(ProjectId, 3, year).get(0);
			Qualters.add("Q3-"+year+":"+mile3[0]+":"+mile3[1]);
			Object[] mile4=dao.MileQuaters(ProjectId, 4, year).get(0);
			Qualters.add("Q4-"+year+":"+mile4[0]+":"+mile4[1]);
		}else {
			Object[] mile4=dao.MileQuaters(ProjectId, 4, year).get(0);
			Qualters.add("Q4-"+year+":"+mile4[0]+":"+mile4[1]);
		}
		for(int i=3;i<=Integer.parseInt(Quater[2].toString());i++) {
			Object[] mile=dao.MileQuaters(ProjectId, 1, (year+i-2)).get(0);
			Qualters.add("Q1-"+(year+i-2)+":"+mile[0]+":"+mile[1]);
			Object[] mile2=dao.MileQuaters(ProjectId, 2, (year+i-2)).get(0);
			Qualters.add("Q2-"+(year+i-2)+":"+mile2[0]+":"+mile2[1]);
			Object[] mile3=dao.MileQuaters(ProjectId, 3, (year+i-2)).get(0);
			Qualters.add("Q3-"+(year+i-2)+":"+mile3[0]+":"+mile3[1]);
			Object[] mile4=dao.MileQuaters(ProjectId, 4, (year+i-2)).get(0);
			Qualters.add("Q4-"+(year+i-2)+":"+mile4[0]+":"+mile4[1]);
		}
		Date dt1=sdf2.parse(Quater[1].toString());
		Calendar c1=Calendar.getInstance();
		c1.setTime(dt1);
		int month1 = c1.get(Calendar.MONTH);
		int year1=c1.get(Calendar.YEAR);
		String qtr1= (month1 >= Calendar.JANUARY && month1 <= Calendar.MARCH)     ? "Q1" :
		            (month1 >= Calendar.APRIL && month1 <= Calendar.JUNE)        ? "Q2" :
		            (month1 >= Calendar.JULY && month1 <= Calendar.SEPTEMBER)    ? "Q3" :
		                                                                   "Q4";
		if(year!=year1) { 
		if("Q4".equals(qtr1)) {
			Object[] mile=dao.MileQuaters(ProjectId, 1, year1).get(0);
			Qualters.add("Q1-"+year1+":"+mile[0]+":"+mile[1]);
			Object[] mile2=dao.MileQuaters(ProjectId, 2, year1).get(0);
			Qualters.add("Q2-"+year1+":"+mile2[0]+":"+mile2[1]);
			Object[] mile3=dao.MileQuaters(ProjectId, 3, year1).get(0);
			Qualters.add("Q3-"+year1+":"+mile3[0]+":"+mile3[1]);
			Object[] mile4=dao.MileQuaters(ProjectId, 4, year1).get(0);
			Qualters.add("Q4-"+year1+":"+mile4[0]+":"+mile4[1]);
		}else if("Q3".equals(qtr1)) {
			Object[] mile=dao.MileQuaters(ProjectId, 1, year1).get(0);
			Qualters.add("Q1-"+year1+":"+mile[0]+":"+mile[1]);
			Object[] mile2=dao.MileQuaters(ProjectId, 2, year1).get(0);
			Qualters.add("Q2-"+year1+":"+mile2[0]+":"+mile2[1]);
			Object[] mile3=dao.MileQuaters(ProjectId, 3, year1).get(0);
			Qualters.add("Q3-"+year1+":"+mile3[0]+":"+mile3[1]);
		}else if("Q2".equals(qtr1)) {
			Object[] mile=dao.MileQuaters(ProjectId, 1, year1).get(0);
			Qualters.add("Q1-"+year1+":"+mile[0]+":"+mile[1]);
			Object[] mile2=dao.MileQuaters(ProjectId, 2, year1).get(0);
			Qualters.add("Q2-"+year1+":"+mile2[0]+":"+mile2[1]);

		}else {
			Object[] mile=dao.MileQuaters(ProjectId, 1, year1).get(0);
			Qualters.add("Q1-"+year1+":"+mile[0]+":"+mile[1]);
			
		}
		}
		}
		return Qualters;
	}
	
	
	@Override
	public List<Object[]> GanttChartList() throws Exception {
	
		return dao.GanttChartList();
	}
	
	@Override
	public List<Object[]> ProjectHealthData(String LabCode) throws Exception{
		
		return dao.ProjectHealthData(LabCode);
	}

	@Override
	public Object[] ProjectHealthTotalData(String ProjectId,String EmpId, String LoginType,String LabCode,String IsAll) throws Exception{
		
		return dao.ProjectHealthTotalData(ProjectId,EmpId,LoginType,LabCode,IsAll);
	}


	@Override
	public long ProjectHealthUpdate(String EmpId, String UserName) throws Exception {
		List<Object[]> proList=dao.ProjectList().stream().filter(e-> !"0".equalsIgnoreCase(e[0].toString())).collect(Collectors.toList());
		long result=0;
		for(Object[] obj:proList) {
			try {
		        dao.ProjectHealthDelete(obj[0].toString());
				Object[] data=dao.ProjectHealthInsertData(obj[0].toString());
				ProjectHealth health=new ProjectHealth();
				health.setLabCode(data[0].toString());
				health.setProjectId(Long.parseLong(data[1].toString()));
				health.setProjectShortName(data[2].toString());
				health.setPMRCHeld(Long.parseLong(data[3].toString()));
				health.setPMRCPending(Long.parseLong(data[4].toString()));
				health.setEBHeld(Long.parseLong(data[5].toString()));
				health.setEBPending(Long.parseLong(data[6].toString()));
				health.setMilPending(Long.parseLong(data[7].toString()));
				health.setMilDelayed(Long.parseLong(data[8].toString()));
				health.setMilCompleted(Long.parseLong(data[9].toString()));
				health.setActionPending(Long.parseLong(data[10].toString()));
				health.setActionForwarded(Long.parseLong(data[11].toString()));
				health.setActionDelayed(Long.parseLong(data[12].toString()));
				health.setActionCompleted(Long.parseLong(data[13].toString()));
				health.setRiskPending(Long.parseLong(data[14].toString()));
				health.setRiskCompleted(Long.parseLong(data[15].toString()));
				health.setProjectType(data[20].toString());
				health.setEndUser(data[21].toString());
				health.setProjectCode(data[22].toString());
				health.setPMRCTotal(Long.parseLong(data[23].toString()));
				health.setEBTotal(Long.parseLong(data[24].toString()));
				if(data[16]!=null) {
				health.setExpenditure(Double.parseDouble(data[16].toString()));
				health.setDipl(Double.parseDouble(data[17].toString()));
				health.setOutCommitment(Double.parseDouble(data[18].toString()));
				health.setBalance(Double.parseDouble(data[19].toString()));
				}else {
					health.setExpenditure(Double.parseDouble("0.00"));
					health.setDipl(Double.parseDouble("0.00"));
					health.setOutCommitment(Double.parseDouble("0.00"));
					health.setBalance(Double.parseDouble("0.00"));
				}
				health.setCreatedBy(UserName);
				health.setCreatedDate(sdf1.format(new Date()));
				health.setTodayChanges(Long.parseLong(data[25].toString()));
				health.setWeeklyChanges(Long.parseLong(data[26].toString()));
				health.setMonthlyChanges(Long.parseLong(data[27].toString()));
				result=dao.ProjectHealthInsert(health);
			}catch (Exception e) {
				e.printStackTrace();
			}		
			}
		return result;
	}
	
	@Override
	public long ProjectHoaUpdate(List<ProjectHoa> hoa,String Username,List<IbasLabMaster> LabDetails) throws Exception{
		logger.info(new Date() +"Inside SERVICE ProjectHoaUpdate ");
		long count1 =0 ;
		long count = dao.ProjectHoaDelete(LabDetails.get(0).getLabCode());
		for(ProjectHoa obj : hoa) {
			obj.setCreatedBy(Username);
			obj.setCreatedDate(sdf1.format(new Date()));
			obj.setLabCode(LabDetails.get(0).getLabCode());
			count1=dao.ProjectHoaUpdate(obj);
		}
		
		return count1;
	}
	
	@Override
	public Object[]  ChangesTotalCountData(String ProjectId) throws Exception{
		
		return dao.ChangesTotalCountData(ProjectId);
	}

	@Override
	public List<Object[]> MeetingChanges(String ProjectId,String Interval,String LabCode) throws Exception {
	
		return dao.MeetingChanges(ProjectId,Interval,LabCode);
	}
	
	@Override
	public List<Object[]> MilestoneChanges(String ProjectId,String Interval,String LabCode) throws Exception {
		
		return dao.MilestoneChanges(ProjectId, Interval,LabCode);
	}
	
	@Override
	public List<Object[]> ActionChanges(String ProjectId,String Interval,String LabCode) throws Exception{
		
		return dao.ActionChanges(ProjectId,Interval,LabCode);
	}
	
	@Override
	public List<Object[]> RiskChanges(String ProjectId,String Interval,String LabCode)throws Exception{
		
		return dao.RiskChanges(ProjectId,Interval,LabCode);
	}
	
	@Override
	public List<Object[]> FinanceDataPartA(String ProjectId, String Interval) throws Exception{
		
		return dao.FinanceDataPartA(ProjectId, Interval);
	}
	
	@Override
	public long ProjectFinanceChangesUpdate(List<FinanceChanges> Monthly, List<FinanceChanges> Weekly, List<FinanceChanges> Today, String UserId) throws Exception {
		logger.info(new Date() +"Inside SERVICE ProjectFinanceChangesUpdate ");
		List<Object[]> proList=dao.ProjectList();
		long result=0;
		for(Object[] obj:proList) {
			try {
		        dao.ProjectHoaChangesDelete(obj[0].toString());
		        ProjectHoaChanges changes = new ProjectHoaChanges();
		        changes.setProjectId(Long.parseLong(obj[0].toString()));
		        changes.setProjectCode(obj[1].toString());
		        changes.setMonthlyChanges(Long.valueOf(Monthly.stream().filter(c-> c.getProjectCode().toString().equalsIgnoreCase(obj[1].toString())).collect(Collectors.toList()).size()));
		        changes.setWeeklyChanges(Long.valueOf(Weekly.stream().filter(c-> c.getProjectCode().toString().equalsIgnoreCase(obj[1].toString())).collect(Collectors.toList()).size()));
		        changes.setTodayChanges(Long.valueOf(Today.stream().filter(c-> c.getProjectCode().toString().equalsIgnoreCase(obj[1].toString())).collect(Collectors.toList()).size()));
		        changes.setCreatedBy(UserId);
		        changes.setCreatedDate(sdf1.format(new Date()));
		        changes.setIsActive(1);
		        
		        result= dao.ProjectHoaChangesInsert(changes);

			}catch (Exception e) {
				e.printStackTrace();
			}		
			}
		return result;
	}
	
	
	@Override
	public Object[] ProjectData(String projectid) throws Exception 
	{
		return dao.ProjectData(projectid);
	}
	
}
