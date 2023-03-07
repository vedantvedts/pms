package com.vts.pfms.header.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.vts.pfms.header.dao.HeaderDao;
@Service
public class HeaderServiceImpl implements HeaderService {
	@Autowired
	HeaderDao dao;
	@Autowired
	BCryptPasswordEncoder encoder;
	
	private static final Logger logger=LogManager.getLogger(HeaderServiceImpl.class);
	
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
	
	@Override
	public List<Object[]> FormModuleList(String LoginType,String LabCode)throws Exception {
		
		return dao.FormModuleList(LoginType,LabCode);
	}

	@Override
	public List<Object[]> loginTypeList(String LoginType) throws Exception {
		logger.info(new Date() +"Inside SERVICE loginTypeList ");
	List<Object[]>loginTypeList=dao.loginTypeList();
	List<Object[]>loginTypeListnew=new ArrayList<Object[]>();
	
	if(LoginType.equalsIgnoreCase("D")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("G")||obj[0].toString().equalsIgnoreCase("T")||obj[0].toString().equalsIgnoreCase("D")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	if(LoginType.equalsIgnoreCase("G")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("T")||obj[0].toString().equalsIgnoreCase("G")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	
	if(LoginType.equalsIgnoreCase("P")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("P")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	if(LoginType.equalsIgnoreCase("B")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("B")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}	
	
	
	if(LoginType.equalsIgnoreCase("O")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("O")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	
	
	if(LoginType.equalsIgnoreCase("S")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("D")||obj[0].toString().equalsIgnoreCase("G")||obj[0].toString().equalsIgnoreCase("T")||obj[0].toString().equalsIgnoreCase("S")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	

	
	
	if(LoginType.equalsIgnoreCase("M")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("M")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	if(LoginType.equalsIgnoreCase("R")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("R")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}	
	
	
		
	if(LoginType.equalsIgnoreCase("U")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("U")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	if(LoginType.equalsIgnoreCase("P")) {
		for(Object[] obj:loginTypeList) {
			if(obj[0].toString().equalsIgnoreCase("P")||obj[0].toString().equalsIgnoreCase("D")) {
				loginTypeListnew.add(obj);
			}
		}
	
	}
	
	
	
		if(LoginType.equalsIgnoreCase("A")) 
		{
			loginTypeListnew=loginTypeList;
		}
		
		return loginTypeListnew;
	}

	@Override
	public List<Object[]> DashboardDemandCount() throws Exception {
		
		return dao.DashboardDemandCount();
	}

	@Override
	public List<Object[]> NotificationList(String Empid) throws Exception {
	
		return dao.NotificationList(Empid);
	}

	@Override
	public int NotificationUpdate(String NotificationId) throws Exception {
		
		return dao.NotificationUpdate(NotificationId);
	}

	@Override
	public List<Object[]> NotificationAllList(String Empid) throws Exception {
		
		return dao.NotificationAllList(Empid);
	}

	@Override
	public List<Object[]> EmployeeDetailes(String LoginId) throws Exception {
	
		return dao.EmployeeDetailes(LoginId);
	}

	@Override
	public String DivisionName(String DivisionId) throws Exception {
	
		return dao.DivisionName(DivisionId);
	}
	
	@Override
	public List<Object[]> TodaySchedulesList(String EmpId, String TodayDate) throws Exception {


		return dao.TodaySchedulesList(EmpId,TodayDate);
	}

	@Override
	public List<Object[]> TodayActionList(String EmpId) throws Exception {
		
		return dao.TodayActionList(EmpId);
	}

	@Override
	public int PasswordChange(String OldPassword, String NewPassword, String UserId)
			throws Exception {

		logger.info(new Date() +"Inside SERVICE PasswordChange ");
		String actualoldpassword=dao.OldPassword(UserId);

		if(encoder.matches(OldPassword, actualoldpassword)) {
		
		String oldpassword=encoder.encode(OldPassword);
		String newpassword=encoder.encode(NewPassword);
		
		return dao.PasswordChange(oldpassword, newpassword, UserId, sdf1.format(new Date()));
		}else {
			
		}
		return 0;
	}

	@Override
	public String FormRoleName(String LoginType) throws Exception {

		return dao.FormRoleName(LoginType);
	}

	@Override
	public List<Object[]> GanttChartList(String ProjectId) throws Exception {
		
		return dao.GanttChartList(ProjectId);
	}

	@Override
	public List<Object[]> ProjectList() throws Exception {
		
		return dao.ProjectList();
	}
	
	@Override
	public List<Object[]> ProjectDetails(String ProjectId) throws Exception {
		
		return dao.ProjectDetails(ProjectId);
	}
	

	@Override
	public Object[] LabDetails(String labcode) throws Exception {
		
		return dao.LabDetails(labcode);
	}

	@Override
	public List<Object[]> FullGanttChartList(String ProjectId) throws Exception 
	{	
		return dao.FullGanttChartList(ProjectId);
	}

	@Override
	public List<Object[]> HeaderSchedulesList(String Logintype,String FormModuleId,String LabCode) throws Exception {
		
		return dao.HeaderSchedulesList(Logintype,FormModuleId,LabCode);
	}

	@Override
	public List<Object[]> ProjectIntiationList(String EmpId, String LoginType) throws Exception {
		
		return dao.ProjectIntiationList(EmpId,LoginType);
	}

	@Override
	public List<Object[]> MyTaskList(String EmpId) throws Exception {
		
		return dao.MyTaskList(EmpId);
	}
	
	@Override
	public List<Object[]> ApprovalList(String EmpId,String LoginType) throws Exception {
		
		return dao.ApprovalList(EmpId,LoginType);
	}
	
	@Override
	public List<Object[]> MyTaskDetails(String EmpId) throws Exception {
		
		return dao.MyTaskDetails(EmpId);
	}
	
	@Override
	public List<Object[]> DashboardActionPdc(String EmpId,String Logintype) throws Exception {
		
		return dao.DashboardActionPdc(EmpId,Logintype);
	}
	
	@Override
	public List<Object[]> MilestoneActivityList(String ProjectId) throws Exception {
		return dao.MilestoneActivityList(ProjectId);
	}
	
	@Override
	public List<Object[]> MilestoneActivityLevel(String MilestoneActivityId,String LevelId) throws Exception {
		return dao.MilestoneActivityLevel(MilestoneActivityId, LevelId);
	}

	@Override
	public List<Object[]> QuickLinksList(String LoginType) throws Exception {

		return dao.QuickLinksList( LoginType);
	}

	@Override
	public String getLabCode(String Empid) throws Exception {
		
		return dao.getLabCode( Empid);
	}
	
	@Override
	public List<Object[]>  LabMasterList(String Clusterid) throws Exception {
		
		return dao.LabMasterList(Clusterid);
	}
	
}
