package com.vts.pfms.timesheet.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.dao.CARSDao;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.master.dao.MasterDao;
import com.vts.pfms.master.model.Employee;
import com.vts.pfms.timesheet.dao.TimeSheetDao;
import com.vts.pfms.timesheet.dto.TimeSheetDTO;
import com.vts.pfms.timesheet.model.TimeSheet;
import com.vts.pfms.timesheet.model.TimeSheetActivity;

@Service
public class TimeSheetServiceImpl implements TimeSheetService {

	private static final Logger logger = LogManager.getLogger(TimeSheetServiceImpl.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf = new SimpleDateFormat("dd-MM-yyyy");
	
	@Autowired
	TimeSheetDao dao;

	@Autowired
	CARSDao carsdao;
	
	@Autowired
	MasterDao masterdao;
	
	@Override
	public List<Object[]> getEmpActivityAssignList(String empId) throws Exception {
		
		return dao.getEmpActivityAssignList(empId);
	}

	@Override
	public TimeSheet getTimeSheetByDateAndEmpId(String empId, String activityDate) throws Exception {
		
		return dao.getTimeSheetByDateAndEmpId(empId, activityDate);
	}

	@Override
	public TimeSheet getTimeSheetById(String timeSheetId) throws Exception {
		
		return dao.getTimeSheetById(timeSheetId);
	}

	@Override
	public Long timeSheetSubmit(TimeSheetDTO dto) throws Exception {
		try {
			TimeSheet timeSheet = dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Add")?new TimeSheet(): dao.getTimeSheetById(dto.getTimeSheetId());
			timeSheet.setEmpId(Long.parseLong(dto.getEmpId()));
			timeSheet.setActivityFromDate(dto.getActivityFromDate()!=null?fc.RegularToSqlDate(dto.getActivityFromDate()):null);
			timeSheet.setActivityToDate(timeSheet.getActivityFromDate());
			timeSheet.setPunchInTime(dto.getPunchInTime()!=null?fc.rdtfTosdtf(dto.getPunchInTime()):null);
			
			// Remove Previously added Time Sheet Activities
			if(dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Edit"))
			dao.removeTimeSheetActivities(dto.getTimeSheetId());
			
			// Storing list of Time Sheet Activities
			List<TimeSheetActivity> timeSheetActivityList = new ArrayList<TimeSheetActivity>();
			
			int totalMinutes = 0;
			
			for(int i=0;i<dto.getActivityId().length;i++) {
				
				if(dto.getActivityId()[i].equalsIgnoreCase("0")) continue;
				
				TimeSheetActivity activity =  new TimeSheetActivity();
				activity.setActivityId(dto.getActivityId()[i]!=null && dto.getActivityId()[i].equalsIgnoreCase("N")?0:Long.parseLong(dto.getActivityId()[i]));
				activity.setActivityType(activity.getActivityId()==0?"N":"A");
				activity.setActivityName(activity.getActivityId()==0?dto.getActivityName()[i]:null);
				activity.setActivityDuration(dto.getActivityDuration()[i]);
				activity.setRemarks(dto.getRemarks()[i]);
				activity.setCreatedBy(dto.getUserId());
				activity.setTimeSheet(timeSheet);
				activity.setCreatedDate(sdtf.format(new Date()));
				activity.setIsActive(1);
				
				timeSheetActivityList.add(activity);
				
				String[] split = dto.getActivityDuration()[i].split(":");
				
			    // Convert hours to minutes and add to totalMinutes
			    totalMinutes += Integer.parseInt(split[0]) * 60 + Integer.parseInt(split[1]);
			}
			
			timeSheet.setTimeSheetActivity(timeSheetActivityList);
			
			int totalHours = totalMinutes / 60;
			int remainingMinutes = totalMinutes % 60;
			String totalDuration = String.format("%02d:%02d", totalHours, remainingMinutes);
			
			timeSheet.setTotalDuration(totalDuration);
			
			if(dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Add")) {
				timeSheet.setTimeSheetStatus("INI");
				timeSheet.setCreatedBy(dto.getUserId());
				timeSheet.setCreatedDate(sdtf.format(new Date()));
				timeSheet.setIsActive(1);
			}else {
				timeSheet.setModifiedBy(dto.getUserId());
				timeSheet.setModifiedDate(sdtf.format(new Date()));
				
			}
			
			return dao.addTimeSheet(timeSheet);
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
		
	}

	@Override
	public Long timeSheetDetailsForward(String timeSheetId, String empId, String action, String userId) throws Exception {
		try {
			TimeSheet timeSheet = dao.getTimeSheetById(timeSheetId);
			String statusCode = timeSheet.getTimeSheetStatus();
			Employee emp = masterdao.getEmployeeById(timeSheet.getEmpId()+"");
			
			if(action!=null && action.equalsIgnoreCase("A")) {
				if(statusCode.equalsIgnoreCase("INI") || statusCode.equalsIgnoreCase("RBS") ) {
					timeSheet.setInitiationDate(sdf.format(new Date()));
					timeSheet.setTimeSheetStatus("FWD");
				}else {
					timeSheet.setTimeSheetStatus("ABS");
				}
			}else if(action!=null && action.equalsIgnoreCase("R")) {
				timeSheet.setTimeSheetStatus("RBS");
			}
			
			dao.addTimeSheet(timeSheet);
			
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A")) {
				notification.setEmpId(Long.parseLong(emp.getSuperiorOfficer()));
				notification.setNotificationUrl("TimeSheetApprovals.htm");
				notification.setNotificationMessage("Time Sheet Forwarded by <br>"+emp.getEmpName());
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdtf.format(new Date()));
				
				carsdao.addNotifications(notification);
			}else if(action.equalsIgnoreCase("R")){
				notification.setEmpId(timeSheet.getEmpId());
				notification.setNotificationUrl("TimeSheetList.htm?activityDate="+fc.SqlToRegularDate(timeSheet.getActivityFromDate()));
				notification.setNotificationMessage("Time Sheet Returned");
				notification.setNotificationby(Long.parseLong(empId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(userId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				carsdao.addNotifications(notification);
			}
			
			return 1L;
		}catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
	}

	@Override
	public List<Object[]> getEmpAllTimeSheetList(String empId, String activityDate) throws Exception {
		
		return dao.getEmpAllTimeSheetList(empId, activityDate);
	}
}
