package com.vts.pfms.committee.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.admin.service.AdminServiceImpl;
import com.vts.pfms.committee.dao.ActionDao;
import com.vts.pfms.committee.dao.ActionSelfDao;

import com.vts.pfms.committee.dto.ActionMainDto;
import com.vts.pfms.committee.dto.ActionSubDto;
import com.vts.pfms.committee.model.ActionAssign;
import com.vts.pfms.committee.model.ActionAttachment;
import com.vts.pfms.committee.model.ActionMain;
import com.vts.pfms.committee.model.ActionSelf;
import com.vts.pfms.committee.model.ActionSub;
import com.vts.pfms.committee.model.PfmsNotification;

@Service
public class ActionServiceImpl implements ActionService {
	
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	private  SimpleDateFormat sdf2=new SimpleDateFormat("dd-MMM-yyyy");
	
	@Autowired
	ActionDao dao;
	
	private static final Logger logger=LogManager.getLogger(ActionServiceImpl.class);

	@Override
	public List<Object[]> EmployeeList(String LabCode) throws Exception {
		logger.info(new Date() +"Inside EmployeeList");	
		return dao.EmployeeList(LabCode);
	}

	@Override
	public List<Object[]> AssignedList(String EmpId) throws Exception {
		logger.info(new Date() +"Inside AssignedList");	
		return dao.AssignedList(EmpId);
	}

	@Override
	public long ActionMainInsert(ActionMainDto main) throws Exception 
	{
		logger.info(new Date() +"Inside ActionMainInsert");
		long success=1;
		long unsuccess=0;
		Object[] lab=null;
		int count=0;
		String ProjectCode=null;
		try
		{
			lab=dao.LabDetails();
			count=dao.ActionGenCount(main.getProjectId());
			if(!main.getProjectId().equalsIgnoreCase("0"))
			{
				ProjectCode=dao.ProjectCode(main.getProjectId());
			}
		}
		catch (Exception e) 
		{
			logger.info(new Date() +"Inside ActionMainInsert Project",e);	
			return unsuccess;
		}
		String Project=null;
		if(!main.getProjectId().equalsIgnoreCase("0")) {
			if(main.getActionType().equalsIgnoreCase("S")) 
			{
				Object[] comishortname=dao.CommitteeShortName(main.getScheduleId());
				Project="/"+ProjectCode+"/"+comishortname[1]+"/";
			}else if(main.getActionType().equalsIgnoreCase("N")) {
				Project="/"+ProjectCode+"/";
				
			}else {
				Project="/"+ProjectCode+"/MIL/";
			}
		}else 
		{
			Project="/GEN/";
		}
		ActionMain actionmain=new ActionMain();
		
		if(main.getActionLinkId()!=null) {
			actionmain.setActionLinkId(Long.parseLong(main.getActionLinkId()));
		}else {
			actionmain.setActionLinkId(unsuccess);
		}
		actionmain.setActivityId(Long.parseLong(main.getActivityId()));
		actionmain.setActionType(main.getActionType());
		actionmain.setType(main.getType());
		actionmain.setActionItem(main.getActionItem());
		actionmain.setActionDate(main.getMeetingDate());
		actionmain.setCategory(main.getCategory());
		actionmain.setPriority(main.getPriority());
		actionmain.setProjectId(Long.parseLong(main.getProjectId()));
		actionmain.setScheduleMinutesId(Long.parseLong(main.getScheduleMinutesId()));
		actionmain.setCreatedBy(main.getCreatedBy());
		actionmain.setCreatedDate(sdf1.format(new Date()));
		actionmain.setIsActive(1);
		long result=dao.ActionMainInsert(actionmain);
		for(int i=0;i<main.getAssigneeList().length;i++) {
		ActionAssign actionassign = new ActionAssign();

		count=count+1;
		if(lab!=null) {

		Date meetingdate= new SimpleDateFormat("yyyy-MM-dd").parse(main.getMeetingDate().toString());

		actionassign.setActionNo(lab[1]+Project+sdf2.format(meetingdate).toString().toUpperCase().replace("-", "")+"/"+count);
		
		}else {
			return unsuccess;
		}
		actionassign.setEndDate(new java.sql.Date(sdf.parse(main.getActionDate()).getTime()));
		actionassign.setActionMainId(result);
		actionassign.setPDCOrg(new java.sql.Date(sdf.parse(main.getActionDate()).getTime()));
		actionassign.setAssigneeLabCode(main.getAssigneeLabCode());
		actionassign.setAssignee(Long.parseLong(main.getAssigneeList()[i]));
		actionassign.setAssignorLabCode(main.getAssignorLabCode());
		actionassign.setAssignor(Long.parseLong(main.getAssignor()));
		actionassign.setRevision(0);
		actionassign.setActionFlag("N");		
		actionassign.setActionStatus("A");
		actionassign.setCreatedBy(main.getCreatedBy());
		actionassign.setCreatedDate(sdf1.format(new Date()));
		actionassign.setIsActive(1);
		long assignid=  dao.ActionAssignInsert(actionassign);
		if(result>0) {
			Object[] data=dao.ActionNotification(String.valueOf(result) ,String.valueOf(assignid)).get(0);
			PfmsNotification notification=new PfmsNotification();
			notification.setEmpId(Long.parseLong(data[2].toString()));
			notification.setNotificationby(Long.parseLong(data[5].toString()));
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setScheduleId(unsuccess);
			notification.setCreatedBy(main.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			notification.setNotificationUrl("AssigneeList.htm");
		    notification.setNotificationMessage("An Action No "+data[7]+" Assigned by "+data[3]+", "+data[4]+".");
		    notification.setStatus("MAR");
            dao.ActionNotificationInsert(notification);
		}else {
			return unsuccess;
		}
		}
		return success;
	}

	@Override
	public List<Object[]> AssigneeList(String EmpId) throws Exception {
		logger.info(new Date() +"Inside AssigneeList");
		dao.AssigneeSeenUpdate(EmpId);
		return dao.AssigneeList(EmpId);
	}

	@Override
	public List<Object[]> AssigneeData(String MainId ,String Assignid) throws Exception {
		logger.info(new Date() +"Inside AssigneeData");
		
		List<Object[]> list = dao.AssigneeData(MainId , Assignid);
		
		return list;
	}

	@Override
	public List<Object[]> SubList(String assignid) throws Exception {
		logger.info(new Date() +"Inside SubList");
		return dao.SubList(assignid);
	}

	@Override
	public long ActionSubInsert(ActionSubDto main) throws Exception {
		logger.info(new Date() +"Inside ActionSubInsert");
		ActionSub sub=new ActionSub();
		sub.setActionAssignId(Long.parseLong(main.getActionAssignId()));
		sub.setRemarks(main.getRemarks());
		sub.setProgress(Integer.parseInt(main.getProgress()));
		sub.setProgressDate(new java.sql.Date(sdf.parse(main.getProgressDate()).getTime()));
		sub.setCreatedBy(main.getCreatedBy());
		sub.setCreatedDate(sdf1.format(new Date()));
		sub.setIsActive(1);
		long subresult=dao.ActionSubInsert(sub);
		if(subresult>0) {
			ActionAssign updateassign=new ActionAssign();
			updateassign.setActionAssignId(Long.parseLong(main.getActionAssignId()));
			updateassign.setActionFlag("N");
			updateassign.setActionStatus("I");
			updateassign.setModifiedBy(main.getCreatedBy());
			updateassign.setModifiedDate(sdf1.format(new Date()));
			dao.AssignUpdate(updateassign);
			ActionAttachment attach=new ActionAttachment();
			attach.setActionAttach(main.getFilePath());
			attach.setActionSubId(subresult);
			attach.setAttachName(main.getFileNamePath());
			attach.setCreatedBy(main.getCreatedBy());
			attach.setCreatedDate(sdf1.format(new Date()));
			dao.ActionAttachInsert(attach);
		}else {
			subresult=0;
		}
		return subresult;
	}

	@Override
	public ActionAttachment ActionAttachmentDownload(String achmentid) throws Exception {
		logger.info(new Date() +"Inside ActionAttachmentDownload");
		return dao.ActionAttachmentDownload(achmentid);
	}

	@Override
	public int ActionSubDelete(String id, String UserId) throws Exception {
		logger.info(new Date() +"Inside ActionSubDelete");
		
		return dao.ActionSubDelete(id);
	}

	@Override
	public int ActionForward(String mainid ,String assignid, String UserId) throws Exception {
		logger.info(new Date() +"Inside ActionForward");
		long unsuccess=0;
		ActionAssign main=new ActionAssign();
		main.setActionAssignId(Long.parseLong(assignid));
		main.setActionFlag("F");
		main.setModifiedBy(UserId);
		main.setModifiedDate(sdf1.format(new Date()));
		int result=dao.MainForward(main);
		if(result>0) {
			Object[] data=dao.ActionNotification(mainid,assignid).get(0);
			PfmsNotification notification=new PfmsNotification();
			notification.setEmpId(Long.parseLong(data[5].toString()));
			notification.setNotificationby(Long.parseLong(data[2].toString()));
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setScheduleId(unsuccess);
			notification.setCreatedBy(main.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			notification.setNotificationUrl("ActionForwardList.htm");
		    notification.setNotificationMessage("An Action No "+data[7]+" Forwarded by "+data[0]+", "+data[1]+".");
		    notification.setStatus("MAR");
            dao.ActionNotificationInsert(notification);
		}else {
			result=0;
		}
		return result;
	}

	@Override
	public List<Object[]> ForwardList(String EmpId) throws Exception {
		logger.info(new Date() +"Inside ForwardList");
		return dao.ForwardList(EmpId);
	}

	@Override
	public int ActionClosed(String id, String Remarks, String UserId ,String assignid) throws Exception {
		logger.info(new Date() +"Inside ActionClosed");
		long unsuccess=0;
		ActionAssign assign=new ActionAssign();
		assign.setActionAssignId(Long.parseLong(assignid));
		assign.setActionFlag("Y");
		assign.setActionStatus("C");
		assign.setRemarks(Remarks);
		assign.setModifiedBy(UserId);
		assign.setModifiedDate(sdf1.format(new Date()));
		int result=dao.MainSendBack(assign);
		if(result>0) {
			Object[] data=dao.ActionNotification(id,assignid).get(0);
			PfmsNotification notification=new PfmsNotification();
			notification.setEmpId(Long.parseLong(data[2].toString()));
			notification.setNotificationby(Long.parseLong(data[5].toString()));
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setScheduleId(unsuccess);
			notification.setCreatedBy(assign.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			notification.setNotificationUrl("ActionStatusList.htm");
		    notification.setNotificationMessage("An Action No "+data[7]+" Closed by "+data[3]+", "+data[4]+".");
		    notification.setStatus("MAR");
            dao.ActionNotificationInsert(notification);
		}else {
			result=0;
		}
		return result;
	}

	@Override
	public int ActionSendBack(String id, String Remarks, String UserId , String assignid) throws Exception {
		logger.info(new Date() +"Inside ActionSendBack");
		long unsuccess=0;
		ActionAssign assign=new ActionAssign();
		assign.setActionAssignId(Long.parseLong(assignid));
		assign.setActionFlag("B");
		assign.setActionStatus("I");
		assign.setRemarks(Remarks);
		assign.setModifiedBy(UserId);
		assign.setModifiedDate(sdf1.format(new Date()));
		int result=dao.MainSendBack(assign);
		if(result>0) {
			Object[] data=dao.ActionNotification(id,assignid).get(0);
			PfmsNotification notification=new PfmsNotification();
			notification.setEmpId(Long.parseLong(data[2].toString()));
			notification.setNotificationby(Long.parseLong(data[5].toString()));
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setScheduleId(unsuccess);
			notification.setCreatedBy(assign.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			notification.setNotificationUrl("AssigneeList.htm");
		    notification.setNotificationMessage("An Action No "+data[7]+" Send Back by "+data[3]+", "+data[4]+".");
		    notification.setStatus("MAR");
            dao.ActionNotificationInsert(notification);
		}else {
			result=0;
		}
		return result;
	}

	@Override
	public List<Object[]> StatusList(String EmpId,String fdate, String tdate) throws Exception {
		logger.info(new Date() +"Inside StatusList");
		return dao.StatusList(EmpId, fdate, tdate);
	}

	@Override
	public List<Object[]> ActionList(String EmpId) throws Exception {
		logger.info(new Date() +"Inside ActionList");
		return dao.ActionList(EmpId);
	}

	@Override
	public List<Object[]> CommitteeActionList(String EmpId) throws Exception {
		logger.info(new Date() +"Inside CommitteeActionList");
		return dao.CommitteeActionList(EmpId);
	}

	@Override
	public Object[] CommitteeScheduleEditData(String CommitteeScheduleId) throws Exception {
		logger.info(new Date() +"Inside CommitteeScheduleEditData");		
		return dao.CommitteeScheduleEditData(CommitteeScheduleId);
	}

	@Override
	public List<Object[]> ScheduleActionList(String ScheduleId) throws Exception {
		logger.info(new Date() +"Inside ScheduleActionList");
		return dao.ScheduleActionList(ScheduleId);
	}

	@Override
	public List<Object[]> MeetingContent(String ScheduleId) throws Exception {
		logger.info(new Date() +"Inside MeetingContent");
		return dao.MeetingContent(ScheduleId);
	}

	@Override
	public List<Object[]> ActionNoSearch(String ActionMainId) throws Exception {
		logger.info(new Date() +"Inside ActionNoSearch");
		return dao.ActionNoSearch("%"+ActionMainId+"%");
	}

	@Override
	public List<Object[]> AssigneeDetails(String assignid) throws Exception {
		logger.info(new Date() +"Inside AssigneeDetails");
		
		return dao.AssigneeDetails(assignid);
	}

	@Override
	public String ScheduleActionItem(String ScheduleId) throws Exception {
		logger.info(new Date() +"Inside ScheduleActionItem");
		Object[] data=dao.ScheduleActionItem(ScheduleId).get(0);
		 String Item= data[1].toString().replaceAll("\\<.*?\\>", "");
		return Item;
	}

	@Override
	public List<Object[]> ActionReports(String EmpId, String Term, String Position,String Type,String LabCode) throws Exception {
		logger.info(new Date() +"Inside ActionReports");
		return dao.ActionReports(EmpId, Term, Position,Type,LabCode);
	}

	@Override
	public List<Object[]> ActionSearch(String EmpId, String No, String Position) throws Exception {
		logger.info(new Date() +"Inside ActionSearch");
		return dao.ActionSearch(EmpId, "%"+No+"%", Position) ;
	}

	@Override
	public List<Object[]> ProjectList() throws Exception {
		logger.info(new Date() +"Inside ProjectList");
		return dao.ProjectList();
	}

	@Override
	public List<Object[]> ActionCountList(String ProjectId) throws Exception {
		logger.info(new Date() +"Inside ActionCountList");
		return dao.ActionCountList(ProjectId);
	}

	@Override
	public List<Object[]> projectdetailsList(String EmpId) throws Exception {
		logger.info(new Date() +"Inside projectdetailsList");        
		return dao.projectdetailsList(EmpId);
	}
	
	@Override
	public List<Object[]> allprojectdetailsList() throws Exception {
		logger.info(new Date() +"Inside allprojectdetailsList");        
		return dao.allprojectdetailsList();
	}

	@Override
	public List<Object[]> ActionWiseReports(String Term, String ProjectId) throws Exception {
		logger.info(new Date() +"Inside ActionWiseReports");
		return dao.ActionWiseReports(Term, ProjectId);
	}

	@Override
	public List<Object[]> ActionPdcReports(String Emp, String ProjectId,String Position, String From, String To) throws Exception {
		logger.info(new Date() +"Inside ActionPdcReports");
		return dao.ActionPdcReports(Emp, ProjectId,Position, new java.sql.Date(sdf.parse(From).getTime()), new java.sql.Date(sdf.parse(To).getTime()));
	}

	@Override
	public int ActionExtendPdc(String id,String date, String UserId , String assignid) throws Exception {
		logger.info(new Date() +"Inside ActionExtendPdc");
		long unsuccess=0;
		int result=0;
		Object[] data=dao.ActionNotification(id , assignid).get(0);

		
		ActionAssign assign=new ActionAssign();
		assign.setRevision(1+Integer.parseInt(data[6].toString()));
		if(assignid!=null) {
		assign.setActionAssignId(Long.parseLong(assignid));
		}
		assign.setEndDate(new java.sql.Date(sdf.parse(date).getTime()));
		assign.setActionMainId(Long.parseLong(id));
		assign.setModifiedBy(UserId);
		assign.setModifiedDate(sdf1.format(new Date()));
		result=dao.ActionAssignRevisionEdit(assign);
		if(result>0) {
			
			PfmsNotification notification=new PfmsNotification();
			notification.setEmpId(Long.parseLong(data[2].toString()));
			notification.setNotificationby(Long.parseLong(data[5].toString()));
			notification.setNotificationDate(sdf1.format(new Date()));
			notification.setScheduleId(unsuccess);
			notification.setCreatedBy(assign.getCreatedBy());
			notification.setCreatedDate(sdf1.format(new Date()));
			notification.setIsActive(1);
			notification.setNotificationUrl("ActionStatusList.htm");
		    notification.setNotificationMessage("An Action No "+data[7]+" PDC Extended by "+data[3]+", "+data[4]+".");
		    notification.setStatus("MAR");
            dao.ActionNotificationInsert(notification);
		}else {
			result=0;
		}
		return result;
	}

	@Override
	public List<Object[]> ActionSelfList(String EmpId) throws Exception {
		logger.info(new Date() +"Inside ActionSelfList");
		return dao.ActionSelfList(EmpId);
	}

	@Override
	public List<Object[]> SearchDetails(String MainId , String assignid) throws Exception {
		logger.info(new Date() +"Inside SearchDetails");
		return dao.SearchDetails(MainId , assignid);
	}
	
	
	@Override
	public List<Object[]> ActionWiseAllReport(String Term,String empid,String ProjectId) throws Exception {
		logger.info(new Date() +"Inside ActionWiseAllReport");
		return dao.ActionWiseAllReport(Term,empid,ProjectId);
	}
	
	@Override
	public long ActionSelfReminderAddSubmit(ActionSelfDao actionselfdao) throws Exception {
		logger.info(new Date() +"Inside ActionSelfReminderAddSubmit");
		ActionSelf actionself=new ActionSelf();
		actionself.setEmpId(Long.parseLong(actionselfdao.getEmpId()));
		actionself.setActionDate(new java.sql.Date(sdf.parse(actionselfdao.getActionDate()).getTime()));
		actionself.setActionTime(actionselfdao.getActionTime());
		actionself.setActionItem(actionselfdao.getActionItem());
		actionself.setActionType(actionselfdao.getActionType());
		actionself.setCreatedBy(actionselfdao.getCreatedBy());
		actionself.setCreatedDate(sdf1.format(new Date()));
		actionself.setIsActive(1);		
		actionself.setLabCode(actionselfdao.getLabCode());
		return dao.ActionSelfReminderAddSubmit(actionself);
	}
	
	@Override
	public List<Object[]> ActionSelfReminderList(String empid,String fromdate,String todate) throws Exception 
	{
		logger.info(new Date() +"Inside ActionSelfReminderList");
		return dao.ActionSelfReminderList(empid,fromdate,todate);
	}
	
	@Override
	public int ActionSelfReminderDelete(String actionid) throws Exception {
		logger.info(new Date() +"Inside ActionSelfReminderDelete");
		return dao.ActionSelfReminderDelete(actionid);
	}

	@Override
	public List<Object[]> getActionAlertList() throws Exception {
	
		return dao.getActionAlertList();
	}

	@Override
	public List<Object[]> getActionToday(String empid,String ai) throws Exception {
	
		return dao.getActionToday(empid,ai);
	}

	@Override
	public List<Object[]> getActionTommo(String empid,String ai) throws Exception {
		
		return dao.getActionTommo(empid,ai);
	}

	@Override
	public List<Object[]> getMeetingAlertList() throws Exception {
		
		return dao.getMeetingAlertList();
	}

	@Override
	public List<Object[]> getMeetingToday(String empid) throws Exception {

		return dao.getMeetingToday(empid);
	}

	@Override
	public List<Object[]> getMeetingTommo(String empid) throws Exception {
	
		return dao.getMeetingTommo(empid);
	}
	
	@Override
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype,String LabCode)throws Exception
	{
		return dao.LoginProjectDetailsList(empid,Logintype,LabCode);
	}

	@Override
	public List<Object[]> AllEmpNameDesigList()throws Exception
	{
		logger.info(new Date() +"Inside AllEmpNameDesigList"); 
		return dao.AllEmpNameDesigList();
	}
	
	@Override
	public List<Object[]> ProjectEmpList(String projectid)throws Exception
	{
		logger.info(new Date() +"Inside ProjectEmpList"); 
		return dao.ProjectEmpList(projectid);
	}
	
	
	@Override
	public List<Object[]> EmployeeDropdown(String empid,String logintype,String projectid)throws Exception
	{
		logger.info(new Date() +"Inside EmployeeDropdown"); 
		return dao.EmployeeDropdown(empid, logintype,projectid);
	}
	
	
	@Override
	public Object[] ActionDetailsAjax(String actionid , String assignid) throws Exception
	{
		logger.info(new Date() +"Inside ActionDetailsAjax"); 
		return dao.ActionDetailsAjax(actionid , assignid);
	}
	
	@Override
	public int ActionMainEdit(ActionMain main) throws Exception
	{
		logger.info(new Date() +"Inside ActionMainEdit"); 
		return dao.ActionMainEdit(main);
	}
	@Override
	 public int ActionAssignEdit(ActionAssign assign) throws Exception
	 {
		logger.info(new Date() +"Inside ActionAssignEdit"); 
		return dao.ActionAssignEdit(assign);
	 }
	
	@Override
	public List<Object[]> AllLabList() throws Exception 
	{
		return dao.AllLabList();
	}
	
	@Override
	public List<Object[]> ClusterExpertsList() throws Exception
	{
		return dao.ClusterExpertsList();
	}
	
	@Override
	public Object[] LabInfoClusterLab(String LabCode) throws Exception 
	{
		return dao.LabInfoClusterLab(LabCode);
	}
	
	@Override
	public List<Object[]> LabEmployeeList(String LabCode) throws Exception {
		logger.info(new Date() +"Inside ChairpersonEmployeeListFormation");		
		return dao.LabEmployeeList(LabCode);
	}
}
