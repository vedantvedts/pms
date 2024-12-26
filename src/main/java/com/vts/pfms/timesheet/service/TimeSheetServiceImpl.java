package com.vts.pfms.timesheet.service;

import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.dao.CARSDao;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.master.dao.MasterDao;
import com.vts.pfms.master.model.Employee;
import com.vts.pfms.master.model.MilestoneActivityType;
import com.vts.pfms.timesheet.dao.TimeSheetDao;
import com.vts.pfms.timesheet.dto.ActionAnalyticsDTO;
import com.vts.pfms.timesheet.dto.TimeSheetDTO;
import com.vts.pfms.timesheet.model.TimeSheet;
import com.vts.pfms.timesheet.model.TimeSheetActivity;
import com.vts.pfms.timesheet.model.TimeSheetTrans;
import com.vts.pfms.timesheet.model.TimesheetKeywords;

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

//	@Override
//	public Long timeSheetSubmit(TimeSheetDTO dto) throws Exception {
//		try {
//			TimeSheet timeSheet = dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Add")?new TimeSheet(): dao.getTimeSheetById(dto.getTimeSheetId());
//			timeSheet.setEmpId(Long.parseLong(dto.getEmpId()));
//			timeSheet.setActivityFromDate(dto.getActivityFromDate()!=null?fc.RegularToSqlDate(dto.getActivityFromDate()):null);
//			timeSheet.setActivityToDate(timeSheet.getActivityFromDate());
//			timeSheet.setPunchInTime(dto.getPunchInTime()!=null?fc.rdtfTosdtf(dto.getPunchInTime()):null);
//			
//			// Remove Previously added Time Sheet Activities
//			if(dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Edit"))
//			dao.removeTimeSheetActivities(dto.getTimeSheetId());
//			
//			// Storing list of Time Sheet Activities
//			List<TimeSheetActivity> timeSheetActivityList = new ArrayList<TimeSheetActivity>();
//			
//			int totalMinutes = 0;
//			int ac = 0;
//			for(int i=0;i<dto.getActivityId().length;i++) {
//				
//				if(dto.getActivityId()[i].equalsIgnoreCase("0")) continue;
//				
//				TimeSheetActivity activity =  new TimeSheetActivity();
//				activity.setActivityId(dto.getActivityId()[i]!=null && dto.getActivityId()[i].equalsIgnoreCase("N")?0:Long.parseLong(dto.getActivityId()[i]));
//				activity.setActivityType(activity.getActivityId()==0?"N":"A");
//				if(dto.getProjectIdhidden()[i]!=null && !dto.getProjectIdhidden()[i].isEmpty()) {
//					activity.setProjectId(Long.parseLong(dto.getProjectIdhidden()[i]));
//				}else {
//					activity.setProjectId(Long.parseLong(dto.getProjectId()[i]));
//				}
//				
//				if(activity.getActivityId()==0) {
//					activity.setActivityTypeId(Long.parseLong(dto.getActivityTypeId()[ac]));
//					++ac;
//				}else {
//					activity.setActivityTypeId(0L);
//				}
//				activity.setActivityDuration(dto.getActivityDuration()[i]);
//				activity.setRemarks(dto.getRemarks()[i]);
//				activity.setCreatedBy(dto.getUserId());
//				activity.setTimeSheet(timeSheet);
//				activity.setCreatedDate(sdtf.format(new Date()));
//				activity.setIsActive(1);
//				
//				timeSheetActivityList.add(activity);
//				
//				String[] split = dto.getActivityDuration()[i].split(":");
//				
//			    // Convert hours to minutes and add to totalMinutes
//			    totalMinutes += Integer.parseInt(split[0]) * 60 + Integer.parseInt(split[1]);
//			}
//			
//			timeSheet.setTimeSheetActivity(timeSheetActivityList);
//			
//			int totalHours = totalMinutes / 60;
//			int remainingMinutes = totalMinutes % 60;
//			String totalDuration = String.format("%02d:%02d", totalHours, remainingMinutes);
//			
//			timeSheet.setTotalDuration(totalDuration);
//			
//			if(dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Add")) {
//				timeSheet.setTimeSheetStatus("INI");
//				timeSheet.setCreatedBy(dto.getUserId());
//				timeSheet.setCreatedDate(sdtf.format(new Date()));
//				timeSheet.setIsActive(1);
//				
//				// Transaction
//				List<TimeSheetTrans> transactionList = new ArrayList<TimeSheetTrans>();
//				
//				TimeSheetTrans transaction = TimeSheetTrans.builder()
//											 .timeSheet(timeSheet)
//											 .TimeSheetStatusCode("INI")
//											 .ActionBy(dto.getEmpId())
//											 .ActionDate(sdtf.format(new Date()))
//											 .build();
//				transactionList.add(transaction);
//				timeSheet.setTimeSheetTrans(transactionList);
//			}else {
//				timeSheet.setModifiedBy(dto.getUserId());
//				timeSheet.setModifiedDate(sdtf.format(new Date()));
//				
//			}
//			
//			return dao.addTimeSheet(timeSheet);
////			return 1L;
//		}catch (Exception e) {
//			e.printStackTrace();
//			logger.error(new Date()+" Inside TimeSheetServiceImpl timeSheetSubmit() "+e);
//			return 0L;
//		}
//		
//	}
	
	@Override
	public Long timeSheetSubmit(TimeSheetDTO dto) throws Exception {
		try {
			TimeSheet timeSheet = dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Add")?new TimeSheet(): dao.getTimeSheetById(dto.getTimeSheetId());
			
			// Remove Previously added Time Sheet Activities
			if(dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Edit"))
				dao.removeTimeSheetActivities(dto.getTimeSheetId());
			
			// Get the Total Activity Submission of employee 
			long activityCount = dao.getEmployeeActivitySubmissionCount(dto.getEmpId(), LocalDate.now().getYear()+"");
			
			String activitySeqNo = (dto.getEmpNo().length()>4?dto.getEmpNo().substring(dto.getEmpNo().length()-4, dto.getEmpNo().length()):dto.getEmpNo())
									+"/"+ LocalDate.now().getYear()+"/";
			
			// Storing list of Time Sheet Activities
			List<TimeSheetActivity> timeSheetActivityList = new ArrayList<TimeSheetActivity>();
			
			for(int i=0;i<dto.getAssignedBy().length;i++) {
				
				if(dto.getAssignedBy()[i].isEmpty()) continue;
				
				TimeSheetActivity activity =  new TimeSheetActivity();
				
				activity.setActivityId(0L);
				activity.setActivityType("N");
				activity.setProjectId(Long.parseLong(dto.getProjectId()[i]));
				activity.setActivityTypeId(Long.parseLong(dto.getActivityTypeId()[i]));
				
				activity.setActivityDuration("00:00");
				activity.setRemarks(null);
				// New Columns for Sample Demo
				activity.setActivitySeqNo(activitySeqNo + (activityCount+(i+1)) );
				activity.setAssignedBy(dto.getAssignedBy()[i]!=null?Long.parseLong(dto.getAssignedBy()[i]):0L);
				activity.setKeywordId(dto.getKeywordId()!=null && dto.getKeywordId()[i]!=null?Long.parseLong(dto.getKeywordId()[i]):0L);
				activity.setWorkDone(dto.getWorkDone()[i]);
				activity.setWorkDoneon(dto.getWorkDoneon()[i]);
				// New Columns for Sample Demo End
				activity.setCreatedBy(dto.getUserId());
				activity.setTimeSheet(timeSheet);
				activity.setCreatedDate(sdtf.format(new Date()));
				activity.setIsActive(1);
				
				timeSheetActivityList.add(activity);
				
			}
			
			timeSheet.setTimeSheetActivity(timeSheetActivityList);
			
			timeSheet.setTotalDuration("00:00");
			
			if(dto.getAction()!=null && dto.getAction().equalsIgnoreCase("Add")) {
				timeSheet.setEmpId(Long.parseLong(dto.getEmpId()));
				timeSheet.setActivityFromDate(dto.getActivityFromDate()!=null?fc.RegularToSqlDate(dto.getActivityFromDate()):null);
				timeSheet.setActivityToDate(timeSheet.getActivityFromDate());
				//timeSheet.setPunchInTime(dto.getPunchInTime()!=null?fc.rdtfTosdtf(dto.getPunchInTime()):null);
				timeSheet.setPunchInTime(dto.getPunchInTime()!=null?fc.rdfTosdf(dto.getPunchInTime()):null);
				timeSheet.setTimeSheetStatus("ABS");
				timeSheet.setCreatedBy(dto.getUserId());
				timeSheet.setCreatedDate(sdtf.format(new Date()));
				timeSheet.setIsActive(1);
				
				// Transaction
				List<TimeSheetTrans> transactionList = new ArrayList<TimeSheetTrans>();
				
				TimeSheetTrans transaction = TimeSheetTrans.builder()
						.timeSheet(timeSheet)
						.TimeSheetStatusCode("ABS")
						.ActionBy(dto.getEmpId())
						.ActionDate(sdtf.format(new Date()))
						.build();
				transactionList.add(transaction);
				timeSheet.setTimeSheetTrans(transactionList);
			}else {
				timeSheet.setModifiedBy(dto.getUserId());
				timeSheet.setModifiedDate(sdtf.format(new Date()));
				
			}
			
			return dao.addTimeSheet(timeSheet);
//			return 1L;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetServiceImpl timeSheetSubmit() "+e);
			return 0L;
		}
		
	}

	@Override
	public Long timeSheetDetailsForward(String[] timeSheetIds, String empId, String action, String userId, String remarks) throws Exception {
		try {
			for(int i=0;i<timeSheetIds.length;i++) {
				TimeSheet timeSheet = dao.getTimeSheetById(timeSheetIds[i]);
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
				
				// Transaction
				List<TimeSheetTrans> transactionList = new ArrayList<TimeSheetTrans>();
				
				TimeSheetTrans transaction = TimeSheetTrans.builder()
											 .timeSheet(timeSheet)
											 .TimeSheetStatusCode(timeSheet.getTimeSheetStatus())
											 .Remarks(remarks)
											 .ActionBy(empId)
											 .ActionDate(sdtf.format(new Date()))
											 .build();
				transactionList.add(transaction);
				timeSheet.setTimeSheetTrans(transactionList);
				
				dao.addTimeSheet(timeSheet);
				
				PfmsNotification notification = new PfmsNotification();
				if(action.equalsIgnoreCase("A")) {
					if(timeSheet.getTimeSheetStatus().equalsIgnoreCase("FWD")) {
						notification.setEmpId(Long.parseLong(emp.getSuperiorOfficer()));
						notification.setNotificationUrl("TimeSheetApprovals.htm");
						notification.setNotificationMessage("Time Sheet Forwarded by <br>"+emp.getEmpName());
					}else if(timeSheet.getTimeSheetStatus().equalsIgnoreCase("ABS")) {
						notification.setEmpId(timeSheet.getEmpId());
						notification.setNotificationUrl("TimeSheetList.htm?activityDate="+fc.SqlToRegularDate(timeSheet.getActivityFromDate()));
						notification.setNotificationMessage("Time Sheet Approved");
					}
					
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
			}
			
			return 1L;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetServiceImpl timeSheetDetailsForward() "+e);
			return 0L;
		}
	}

	@Override
	public List<Object[]> getEmpAllTimeSheetList(String empId) throws Exception {
		
		return dao.getEmpAllTimeSheetList(empId);
	}
	
	@Override
	public List<Object[]> getEmployeesofSuperiorOfficer(String superiorOfficer, String labCode) throws Exception {
		
		return dao.getEmployeesofSuperiorOfficer(superiorOfficer, labCode);
	}
	
	@Override
	public Map<String, Map<LocalDate, TimeSheet>> getTimesheetDataForSuperior(String superiorOfficer, String labCode, String dateofWeek) throws Exception {
		try {
			List<Object[]> emplist = dao.getEmployeesofSuperiorOfficer(superiorOfficer, labCode);
			
			Map<String, Map<LocalDate, TimeSheet>> timesheetData = new HashMap<>();
			
			LocalDate localdate = LocalDate.parse(dateofWeek);
			// Get the start of the week (Sunday)
	        LocalDate startOfWeek = localdate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));

	        // Get the end of the week (Saturday)
	        LocalDate endOfWeek = localdate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SATURDAY));
	        
	        for(Object[] obj : emplist) {
	        	Map<LocalDate, TimeSheet> employeeTimesheet = new HashMap<>();
	            List<TimeSheet> timesheets = dao.getTimeSheetListofEmployeeByPeriod(obj[0].toString(), startOfWeek.toString(), endOfWeek.toString());

	            Map<LocalDate, TimeSheet> timeSheetMap = new HashMap<>();
	            for (TimeSheet timesheet : timesheets) {
	            	timeSheetMap.put(LocalDate.parse(timesheet.getActivityFromDate()), timesheet);
	            }

	            for (LocalDate date = startOfWeek; !date.isAfter(endOfWeek); date = date.plusDays(1)) {
	                employeeTimesheet.put(date, timeSheetMap.getOrDefault(date, null));
	            }

	            timesheetData.put(obj[0].toString(), employeeTimesheet);
	        }
			return timesheetData;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetServiceImpl getTimesheetDataForSuperior() "+e);
			return null;
		}
	}

	@Override
	public List<MilestoneActivityType> getMilestoneActivityTypeList() throws Exception {
		
		return dao.getMilestoneActivityTypeList();
	}

	@Override
	public List<ActionAnalyticsDTO> empActionAnalyticsList(String empId, String fromDate, String toDate, String projectId) throws Exception {
		
		return dao.actionAnalyticsList(empId, fromDate, toDate, projectId);
	}

	@Override
	public Object[] getActionAnalyticsCounts(String empId, String fromDate, String toDate, String projectId) throws Exception {
		List<ActionAnalyticsDTO> dtoList = dao.actionAnalyticsList(empId, fromDate, toDate, projectId);
		Integer[] count = {0,0,0,0,0,0,0,0};
		
		LocalDate now = LocalDate.now();
		
		dtoList.stream().forEach(e ->{
			LocalDate closedDate =  e.getClosedDate()!=null? LocalDate.parse(e.getClosedDate()): null;
			LocalDate endDate =  LocalDate.parse(e.getEndDate());
			// Completed Within Time
			if(e.getClosedDate()!=null && ( closedDate.isBefore(endDate) || closedDate.isEqual(endDate) ) ) {
				count[0] += 1;
			}
			// Completed With Delay
			else if(e.getClosedDate()!=null && closedDate.isAfter(endDate) ) {
				count[1] += 1;
			}

			// Within Time Actions
			if(LocalDate.parse(e.getEndDate()).isAfter(now) || LocalDate.parse(e.getEndDate()).isEqual(now)) {
				// Ongoing
				if(Arrays.asList("I","B","F").contains(e.getActionStatus())) {
					count[2] += 1;
				}
				// Not Started
				else if("A".equalsIgnoreCase(e.getActionStatus())) {
					count[4] += 1;
				}

			}
			// Delayed Actions
			else if(LocalDate.parse(e.getEndDate()).isBefore(now)) {
				
				// Ongoing
				if(Arrays.asList("I","B","F").contains(e.getActionStatus())) {
					count[3] += 1;
				}
				// Not Started
				else if("A".equalsIgnoreCase(e.getActionStatus())) {
					count[5] += 1;
				}
			}

			
		});
		
		// Total OnTime Actions
		count[6] += count[0]+count[2]+count[4];
		// Total Missed Actions
		count[7] += count[1]+count[3]+count[5];
		return count;
	}

	@Override
	public List<Object[]> getAllEmployeeList(String labCode) throws Exception {
		
		return dao.getAllEmployeeList(labCode);
	}

	@Override
	public List<Object[]> empActivityWiseAnalyticsList(String empId, String fromDate, String toDate, String projectId) throws Exception {
		
		return dao.empActivityWiseAnalyticsList(empId, fromDate, toDate, projectId);
	}
	
	@Override
	public List<Object[]> projectActivityWiseAnalyticsList(String empId, String fromDate, String toDate, String projectId) throws Exception {

		return dao.projectActivityWiseAnalyticsList(empId, fromDate, toDate, projectId);
	}

	@Override
	public List<Object[]> projectActionAnalyticsList(String projectId, String fromDate, String toDate) throws Exception {
		
		return dao.projectActionAnalyticsList(projectId, fromDate, toDate);
	}
	
	@Override
	public List<Object[]> getAllEmpTimeSheetWorkingHrsList(String labCode, String loginType, String empId, String fromDate, String toDate) throws Exception {
		
		return dao.getAllEmpTimeSheetWorkingHrsList(labCode, loginType, empId, fromDate, toDate);
	}
	
	@Override
	public List<Object[]> getProjectTimeSheetWorkingHrsList(String labCode, String loginType, String empId, String fromDate, String toDate) throws Exception {
		
		return dao.getProjectTimeSheetWorkingHrsList(labCode, loginType, empId, fromDate, toDate);
	}
	
	@Override
	public List<Object[]> empExtraWorkingDaysList(String empId, String fromDate, String toDate) throws Exception {
		
		return dao.empExtraWorkingDaysList(empId, fromDate, toDate);
	}
	
	@Override
	public List<Object[]> getHolidayList() throws Exception {
		
		return dao.getHolidayList();
	}
	
	@Override
	public List<Object[]> projectWiseEmpExtraWorkingDaysList(String empId, String fromDate, String toDate) throws Exception {
		
		return dao.projectWiseEmpExtraWorkingDaysList(empId, fromDate, toDate);
	}

	@Override
	public List<Object[]> getRoleWiseEmployeeList(String labCode, String loginType, String empId) throws Exception {
		
		return dao.getRoleWiseEmployeeList(labCode, loginType, empId);
	}

	@Override
	public Map<String, Map<LocalDate, TimeSheet>> getTimesheetDataForOfficer(String superiorOfficer, String labCode, String dateofWeek, String loginType) throws Exception {
		try {
			List<Object[]> emplist = dao.getRoleWiseEmployeeList(labCode, loginType, superiorOfficer);
			
			Map<String, Map<LocalDate, TimeSheet>> timesheetData = new HashMap<>();
			
			LocalDate localdate = LocalDate.parse(dateofWeek);
			// Get the start of the week (Sunday)
	        LocalDate startOfWeek = localdate.with(TemporalAdjusters.previousOrSame(DayOfWeek.SUNDAY));

	        // Get the end of the week (Saturday)
	        LocalDate endOfWeek = localdate.with(TemporalAdjusters.nextOrSame(DayOfWeek.SATURDAY));
	        
	        for(Object[] obj : emplist) {
	        	Map<LocalDate, TimeSheet> employeeTimesheet = new HashMap<>();
	            List<TimeSheet> timesheets = dao.getTimeSheetListofEmployeeByPeriod(obj[0].toString(), startOfWeek.toString(), endOfWeek.toString());

	            Map<LocalDate, TimeSheet> timeSheetMap = new HashMap<>();
	            for (TimeSheet timesheet : timesheets) {
	            	timeSheetMap.put(LocalDate.parse(timesheet.getActivityFromDate()), timesheet);
	            }

	            for (LocalDate date = startOfWeek; !date.isAfter(endOfWeek); date = date.plusDays(1)) {
	                employeeTimesheet.put(date, timeSheetMap.getOrDefault(date, null));
	            }

	            timesheetData.put(obj[0].toString(), employeeTimesheet);
	        }
			return timesheetData;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside TimeSheetServiceImpl getTimesheetDataForSuperior() "+e);
			return null;
		}
	}

	@Override
	public List<Object[]> getEmployeeNewTimeSheetList(String empId, String fromDate, String toDate) throws Exception {
		
		return dao.getEmployeeNewTimeSheetList(empId, fromDate, toDate);
	}
	
	@Override
	public List<TimesheetKeywords> getTimesheetKeywordsList() throws Exception {
		
		return dao.getTimesheetKeywordsList();
	}
}
