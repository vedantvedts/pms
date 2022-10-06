package com.vts.pfms.committee.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.vts.pfms.committee.model.ActionAttachment;
import com.vts.pfms.committee.model.ActionMain;
import com.vts.pfms.committee.model.ActionSelf;
import com.vts.pfms.committee.model.ActionSub;
import com.vts.pfms.committee.model.PfmsNotification;


@Transactional
@Repository
public class ActionDaoImpl implements ActionDao{
	
	private static final Logger logger=LogManager.getLogger(CommitteeDaoImpl.class);
	

	private static final String EMPLOYEELIST="select a.empid,a.empname,b.designation FROM employee a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId ORDER BY a.srno=0,a.srno ";
	private static final String ASSIGNEDLIST="SELECT a.actionmainid,ab.empname,dc.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS remarks,a.revision,a.IsSeen FROM action_main a,  employee ab ,employee_desig dc WHERE a.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND a.assignor=:empid and a.actionflag<>'Y'";
	//isseen column has been removed  04-08-2021
	//private static final String ASSIGNEDLIST="SELECT a.actionmainid,ab.empname,dc.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS remarks,a.revision FROM action_main a,  employee ab ,employee_desig dc WHERE a.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND a.assignor=:empid and a.actionflag<>'Y'";
	private static final String ASSIGNEELIST="SELECT a.actionmainid,b.empname,c.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag,a.remarks,a.actionlinkid,a.actionno FROM  action_main a, employee b ,employee_desig c WHERE a.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND (a.assignee=:empid OR a.assignor=:empid) and a.actionflag in ('N','B') order by a.enddate desc";
	private static final String ASSIGNEEDATA="SELECT a.actionmainid,b.empname,c.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag,a.scheduleminutesid,a.actionlinkid,a.actionno,a.revision,d.empname AS 'assignee',a.actiontype,pdcorg,pdc1,pdc2 ,assignorlabcode,assigneelabcode FROM  action_main a, employee b ,employee_desig c ,employee d WHERE a.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid and a.actionflag<>'Y' AND a.actionmainid=:mainid AND a.assignee=d.empid";
    private static final String SUBLIST="SELECT a.actionsubid,a.actionmainid,a.progress,a.progressdate,a.remarks,b.attachname,b.actionattach,b.actionattachid FROM action_sub a, action_attachment b WHERE a.actionsubid=b.actionsubid AND a.actionmainid=:mainid ";
	private static final String SUBDELETE="delete from action_sub where actionsubid=:subid";
	private static final String MAINUPDATE="UPDATE action_main SET actionflag=:flag,actionstatus=:status,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE actionmainid=:mainid";
	private static final String MAINFORWARD="UPDATE action_main SET actionflag=:flag,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE actionmainid=:mainid";
	private static final String FORWARDLIST="SELECT a.actionmainid,ab.empname,dc.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS remarks,a.actionlinkid,a.actionno FROM action_main a,  employee ab ,employee_desig dc WHERE a.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid and a.actionflag='F'  AND a.assignor=:empid";
	private static final String MAINSENDBACK="UPDATE action_main SET remarks=:remarks,actionstatus=:status,actionflag=:flag,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE actionmainid=:mainid";
	private static final String ACTIONLIST ="SELECT DISTINCT(a.scheduleid), a.committeeid, a.committeemainid, b.committeename, a.scheduledate, a.schedulestarttime  FROM committee_schedule a, committee b, committee_schedules_minutes_details c,committee_main d ,committee_member cm WHERE a.committeeid=b.committeeid AND a.scheduledate<=CURDATE() AND a.scheduleid=c.scheduleid AND c.idarck IN('A','K','I')  AND a.committeemainid=d.committeemainid  AND d.isactive=1 AND a.isactive=1   AND d.committeemainid=cm.committeemainid AND cm.membertype='CS'  AND cm.empid=:empid";
	private static final String COMMITTEEDATA="CALL Pfms_Action_List(:scheduleid)";
	private static final String COMMITTEESCHEDULEEDITDATA="SELECT a.committeeid,a.committeemainid,a.scheduledate,a.schedulestarttime,a.scheduleflag,a.schedulesub,a.scheduleid,b.committeename,b.committeeshortname,a.projectid FROM committee_schedule a,committee b WHERE scheduleid=:committeescheduleid AND a.committeeid=b.committeeid AND a.isactive=1 ";
	private static final String SCHEDULELIST="SELECT a.actionmainid,b.empname,c.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag FROM  action_main a, employee b ,employee_desig c WHERE a.assignee=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND a.scheduleminutesid=:schid";
    private static final String CONTENT="SELECT a.actionmainid,b.details,b.minutesid,b.minutessubid,b.minutessubofsubid,b.minutesunitid,b.idarck FROM action_main a, committee_schedules_minutes_details b WHERE a.scheduleminutesid=b.scheduleminutesid AND a.actionmainid=:aid";
    private static final String ACTIONSEARCH="SELECT a.actionmainid,a.actionno,ab.empname,dc.designation FROM action_main a,  employee ab ,employee_desig dc  WHERE a.assignor=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND a.actionno LIKE :actionno ";
    
    
    private static final String STATUSLIST="SELECT a.actionmainid,b.empname,c.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag,d.empname AS emp,e.designation AS desig,a.actionno,a.actionlinkid,(SELECT g.progress FROM action_sub g  WHERE g.actionmainid = a.actionmainid AND g.actionsubid = (SELECT MAX(f.actionsubid) FROM action_sub f WHERE f.actionmainid = a.actionmainid) )  AS progress FROM  action_main a, employee b ,employee_desig c, employee d ,employee_desig e  WHERE a.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND a.assignee=d.empid AND d.isactive='1' AND d.desigid=e.desigid AND a.assignee=:empid AND a.actiondate BETWEEN :fdate AND :tdate ";
	private static final String LABDETAILS = "select * from lab_master"; 
    private static final String ACTIONGENCOUNT="SELECT COUNT(*) FROM action_main WHERE  (CASE WHEN :projectid=0 THEN projectid=:projectid AND DATE_FORMAT(CURDATE(), \"%Y\")=DATE_FORMAT(actiondate, \"%Y\") ELSE projectid=:projectid END ) AND isactive='1'";
	private static final String ASSIGNEEDETAILS="SELECT assignor,assignee,actionno FROM action_main WHERE actionmainid=:mainid";
	private static final String SCHEDULEITEM="SELECT a.scheduleminutesid,a.details FROM  committee_schedules_minutes_details a WHERE  a.scheduleminutesid=:schid";
    private static final String ACTIONREPORT="CALL Pfms_Action_Reports(:empid,:term,:position,:type)";
    private static final String ACTIONSEARCHNO="CALL Pfms_ActionNo_Search(:empid,:no,:position)";
	private static final String PROJECTLIST="SELECT projectid,projectmainid,projectcode,projectname FROM project_master WHERE isactive=1";
    private static final String ACTIONCOUNT="CALL Pfms_Action_PD_Chart(:projectid)";
    private static final String LOGINPROJECTIDLIST="SELECT a.projectid,a.projectcode,a.projectname,a.ProjectMainId,a.ProjectDescription,a.UnitCode,a.ProjectType,a.ProjectCategory,a.SanctionNo,a.SanctionDate,a.PDC,a.ProjectDirector FROM project_master a,project_employee b WHERE a.isactive=1 and a.projectid=b.projectid and b.empid=:empid";
    private static final String ALLPROJECTDETAILSLIST ="SELECT a.projectid,a.projectcode,a.projectname,a.ProjectMainId,a.ProjectDescription,a.UnitCode,a.ProjectType,a.ProjectCategory,a.SanctionNo,a.SanctionDate,a.PDC,a.ProjectDirector FROM project_master a WHERE a.isactive=1 ";
	private static final String ACTIONWISE="CALL Pfms_Action_Wise_Reports(:term,:ProjectId)";
    private static final String ACTIONNOTIFIC="SELECT ab.empname as emp,dc.designation as desig,a.assignee,b.empname,c.designation,a.assignor,a.revision,a.actionno  FROM action_main a,  employee ab ,employee_desig dc,employee b ,employee_desig c    WHERE   a.assignor=b.empid  AND b.isactive='1' AND c.desigid=b.desigid AND a.assignee=ab.empid  AND ab.isactive='1' AND dc.desigid=ab.desigid AND a.actionmainid=:mainid";
	private static final String ACTIONPDC="CALL Pfms_Action_PDC_Report(:empid,:ProjectId,:Position,:From,:To)";
    private static final String PROJECTCODE="SELECT projectcode FROM project_master WHERE   projectid=:ProjectId  AND isactive='1'";
	private static final String SELFASSIGNEDLIST="SELECT a.actionmainid,ab.empname,dc.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS remarks,a.revision FROM action_main a,  employee ab ,employee_desig dc WHERE a.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND a.assignor=:empid AND a.assignee=:empid and a.actionflag<>'Y'";
	private static final String SEARCHDATA="SELECT a.actionmainid,b.empname,c.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag,a.scheduleminutesid,a.actionlinkid,a.actionno,a.revision FROM  action_main a, employee b ,employee_desig c WHERE a.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid  AND a.actionmainid=:mainid";
	private static final String ACTIONWISEALLREPORT="CALL Pfms_Action_Wise_All_Reports (:term,:empid,:projectid);";
	private static final String ACTIONALERT="CALL Pfms_Actions_Msg()";
	private static final String ACTIONTODAY="SELECT a.actionno,a.projectid FROM action_main a WHERE  a.enddate=CURDATE() AND a.actionflag IN('N','B','F') AND (CASE WHEN 'AI'=:AI THEN a.Actiontype IN ('S','N') ELSE a.Actiontype IN ('A','B','C') END) AND  a.assignee=:empid ";
	private static final String ACTIONTOMMO="SELECT a.actionno,a.projectid FROM action_main a WHERE  a.enddate=CURDATE()+1 AND a.actionflag IN('N','B','F') AND (CASE WHEN 'AI'=:AI THEN a.Actiontype IN ('S','N') ELSE a.Actiontype IN ('A','B','C') END) AND a.assignee=:empid ";
	private static final String MEETINGALERT="CALL Pfms_Meeting_Msg()";
	private static final String MEETINGTODAY="CALL Pfms_Meeting_Msg_Today(:empid)";
	private static final String MEETINGTOMMO="CALL Pfms_Meeting_Msg_Tommo(:empid)";
	
	
	private static final String ACTIONSELFREMINDERLIST="SELECT ActionId,EmpId,ActionItem,ActionDate,ActionTime,ActionType FROM pfms_action_self WHERE isactive='1' AND actiondate BETWEEN :fromdate AND :todate AND empid=:empid ORDER BY ActionDate DESC";
	private static final String ALLEMPNAMEDESIGLIST="SELECT e.empid , e.empname, ed.designation FROM employee e, employee_desig ed WHERE e.desigid=ed.desigid";
	private static final String COMMITTEESHORTNAME="SELECT cs.committeeid, c.committeeshortname  FROM committee c,committee_schedule cs WHERE c.committeeid=cs.committeeid AND cs.scheduleid=:scheduleid AND cs.isactive=1 ";
	private static final String ASSIGNEESEENUPDATE="UPDATE action_main SET isseen='1' WHERE assignee=:empid ";
	public static final String ACTIONSELFREMINDERDELETE="UPDATE pfms_action_self SET isactive=0 WHERE actionid=:actionid";
	private static final String PROJECTEMPLIST="SELECT a.empid,a.empname,b.designation FROM employee a,employee_desig b,project_employee pe  WHERE a.isactive='1' AND a.DesigId=b.DesigId  AND pe.empid=a.empid AND pe.projectid=:projectid ORDER BY a.srno=0,a.srno";
	 
	 
    @PersistenceContext
	EntityManager manager;
	
	@Autowired
	ActionDaoRepo amrepo;
	
	@Override
	public Object[] LabDetails()throws Exception
	{
		logger.info(new Date() +"Inside LabDetails");	
		Query query=manager.createNativeQuery(LABDETAILS);
		Object[] Labdetails =(Object[])query.getResultList().get(0);
		return Labdetails ;
	}
	
	@Override
	public List<Object[]> EmployeeList() throws Exception {
		logger.info(new Date() +"Inside EmployeeList");	
		Query query=manager.createNativeQuery(EMPLOYEELIST);
		
		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();	
		return EmployeeList;
	}

	@Override
	public List<Object[]> AssignedList(String EmpId) throws Exception {
		logger.info(new Date() +"Inside AssignedList");	
        Query query=manager.createNativeQuery(ASSIGNEDLIST);
		query.setParameter("empid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public long ActionMainInsert(ActionMain main) throws Exception {
		
		logger.info(new Date() +"Inside ActionMainInsert");	
		manager.persist(main);
		manager.flush();
		return main.getActionMainId();
	}

	@Override
	public List<Object[]> AssigneeList(String EmpId) throws Exception {
		
		logger.info(new Date() +"Inside AssigneeList");	
		Query query=manager.createNativeQuery(ASSIGNEELIST);
		query.setParameter("empid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	
	
	@Override
	public int AssigneeSeenUpdate(String EmpId) throws Exception 
	{		
		logger.info(new Date() +"Inside AssigneeSeenUpdate");	
		Query query=manager.createNativeQuery(ASSIGNEESEENUPDATE);
		query.setParameter("empid", EmpId);
		return query.executeUpdate();
	}
	
	
	
	@Override
	public List<Object[]> AssigneeData(String EmpId) throws Exception {
		
		logger.info(new Date() +"Inside AssigneeData");	
		Query query=manager.createNativeQuery(ASSIGNEEDATA);
		query.setParameter("mainid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> SubList(String MainId) throws Exception {
		logger.info(new Date() +"Inside SubList");	
		Query query=manager.createNativeQuery(SUBLIST);
		query.setParameter("mainid", MainId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	@Override
	public long ActionSubInsert(ActionSub main) throws Exception {
		
		logger.info(new Date() +"Inside ActionSubInsert");	
		manager.persist(main);
		manager.flush();
		return main.getActionSubId();
	}
	
	@Override
	public long ActionAttachInsert(ActionAttachment main) throws Exception {
		
		logger.info(new Date() +"Inside ActionAttachInsert");
		manager.persist(main);
		manager.flush();
		return main.getActionAttachId();
	}
	
	@Override
	public ActionAttachment ActionAttachmentDownload(String achmentid) throws Exception
	{
		logger.info(new Date() +"Inside ActionAttachmentDownload");
		ActionAttachment Attachment= manager.find(ActionAttachment.class,Long.parseLong(achmentid));
		return Attachment;
	}

	@Override
	public int ActionSubDelete(String id) throws Exception {
		
		logger.info(new Date() +"Inside ActionSubDelete");
		Query query=manager.createNativeQuery(SUBDELETE);
		query.setParameter("subid", id);
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int MainUpdate(ActionMain main) throws Exception {
		
		logger.info(new Date() +"Inside MainUpdate");
		Query query=manager.createNativeQuery(MAINUPDATE);
		query.setParameter("mainid",main.getActionMainId());
		query.setParameter("flag", main.getActionFlag());
		query.setParameter("status",main.getActionStatus());
		query.setParameter("modifiedby",main.getModifiedBy());
		query.setParameter("modifieddate",main.getModifiedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int MainForward(ActionMain main) throws Exception {
		
		logger.info(new Date() +"Inside MainForward");
		Query query=manager.createNativeQuery(MAINFORWARD);
		query.setParameter("mainid",main.getActionMainId());
		query.setParameter("flag", main.getActionFlag());
		query.setParameter("modifiedby",main.getModifiedBy());
		query.setParameter("modifieddate",main.getModifiedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public List<Object[]> ForwardList(String EmpId) throws Exception {
		
		logger.info(new Date() +"Inside ForwardList");
		Query query=manager.createNativeQuery(FORWARDLIST);
		query.setParameter("empid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public int MainSendBack(ActionMain main) throws Exception {
		
		logger.info(new Date() +"Inside MainSendBack");
		Query query=manager.createNativeQuery(MAINSENDBACK);
		query.setParameter("mainid",main.getActionMainId());
		query.setParameter("remarks", main.getRemarks());
		query.setParameter("flag", main.getActionFlag());
		query.setParameter("status",main.getActionStatus());
		query.setParameter("modifiedby",main.getModifiedBy());
		query.setParameter("modifieddate",main.getModifiedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public List<Object[]> StatusList(String EmpId,String fdate, String tdate) throws Exception {
		
		logger.info(new Date() +"Inside StatusList");
		Query query=manager.createNativeQuery(STATUSLIST);
		query.setParameter("empid", EmpId);
		query.setParameter("fdate", fdate);
		query.setParameter("tdate", tdate);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> ActionList(String EmpId) throws Exception {
		
		logger.info(new Date() +"Inside ActionList");
		Query query=manager.createNativeQuery(ACTIONLIST);
		query.setParameter("empid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> CommitteeActionList(String EmpId) throws Exception {
		
		logger.info(new Date() +"Inside CommitteeActionList");
		Query query=manager.createNativeQuery(COMMITTEEDATA);
		query.setParameter("scheduleid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	@Override
	public Object[] CommitteeScheduleEditData(String CommitteeScheduleId) throws Exception 
	{		
		logger.info(new Date() +"Inside CommitteeScheduleEditData");
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEEDITDATA);
		query.setParameter("committeescheduleid", CommitteeScheduleId );
		Object[] CommitteeScheduleEditData=(Object[])query.getSingleResult();
		return CommitteeScheduleEditData;
	}
				
	@Override
	public List<Object[]> ScheduleActionList(String ScheduleId) throws Exception {
		
		logger.info(new Date() +"Inside ScheduleActionList");
		Query query=manager.createNativeQuery(SCHEDULELIST);
		query.setParameter("schid", ScheduleId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	@Override
	public List<Object[]> MeetingContent(String ScheduleId) throws Exception {
		
		logger.info(new Date() +"Inside MeetingContent");
		Query query=manager.createNativeQuery(CONTENT);
		query.setParameter("aid", ScheduleId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]>  ActionNoSearch(String ActionMainId) throws Exception {

		logger.info(new Date() +"Inside ActionNoSearch");
		Query query=manager.createNativeQuery(ACTIONSEARCH);
		query.setParameter("actionno",ActionMainId);
		List<Object[]> ActionDetails=(List<Object[]>)query.getResultList();
		
		return ActionDetails;
	}

	@Override
	public int ActionGenCount(String ProjectId) throws Exception {
		
		logger.info(new Date() +"Inside ActionGenCount");
		Query query = manager.createNativeQuery(ACTIONGENCOUNT);
		query.setParameter("projectid",ProjectId );
		BigInteger count=(BigInteger)query.getSingleResult();
			return count.intValue();
	}
	
	@Override
	public long ActionNotificationInsert(PfmsNotification main) throws Exception {
		
		logger.info(new Date() +"Inside ActionNotificationInsert");
		manager.persist(main);
		manager.flush();
		return main.getNotificationId();
	}

	@Override
	public List<Object[]> AssigneeDetails(String MainId) throws Exception {
		
		logger.info(new Date() +"Inside AssigneeDetails");
		Query query=manager.createNativeQuery(ASSIGNEEDETAILS);
		query.setParameter("mainid",MainId );
		List<Object[]> AssigneeDetails=(List<Object[]>)query.getResultList();
		
		return AssigneeDetails;
	}
	
	@Override
	public List<Object[]> ScheduleActionItem(String ScheduleId) throws Exception {
		
		logger.info(new Date() +"Inside ScheduleActionItem");
		Query query=manager.createNativeQuery(SCHEDULEITEM);
		query.setParameter("schid", ScheduleId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	@Override
	public List<Object[]> ActionReports(String EmpId,String Term,String Position,String Type) throws Exception {
		
		logger.info(new Date() +"Inside ActionReports");
		Query query=manager.createNativeQuery(ACTIONREPORT);
		query.setParameter("empid",EmpId);
		query.setParameter("term",Term);
		query.setParameter("position",Position);
		query.setParameter("type",Type);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	@Override
	public List<Object[]> ActionSearch(String EmpId,String No,String Position) throws Exception {
		
		logger.info(new Date() +"Inside ActionSearch");
		Query query=manager.createNativeQuery(ACTIONSEARCHNO);
		query.setParameter("empid",EmpId);
		query.setParameter("no",No);
		query.setParameter("position",Position);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> ProjectList() throws Exception {
		
		logger.info(new Date() +"Inside ProjectList");
		Query query=manager.createNativeQuery(PROJECTLIST);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> ActionCountList(String ProjectId) throws Exception {
		
		logger.info(new Date() +"Inside ActionCountList");
		Query query=manager.createNativeQuery(ACTIONCOUNT);
		query.setParameter("projectid",ProjectId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> projectdetailsList(String EmpId) throws Exception {
		
		logger.info(new Date() +"Inside projectdetailsList");
		Query query=manager.createNativeQuery(LOGINPROJECTIDLIST);
		query.setParameter("empid", EmpId);
		return (List<Object[]>)query.getResultList();
	}
	
	@Override
	public List<Object[]> allprojectdetailsList() throws Exception {
		
		logger.info(new Date() +"Inside allprojectdetailsList");
		Query query=manager.createNativeQuery(ALLPROJECTDETAILSLIST);		
		return (List<Object[]>)query.getResultList();
	}

	@Override
	public List<Object[]> ActionWiseReports(String Term, String ProjectId) throws Exception {
		
		logger.info(new Date() +"Inside ActionWiseReports");
		Query query=manager.createNativeQuery(ACTIONWISE);
		query.setParameter("term",Term);
		query.setParameter("ProjectId",ProjectId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	@Override
	public List<Object[]> ActionNotification( String MainId) throws Exception {
		
		logger.info(new Date() +"Inside ActionNotification");
		Query query=manager.createNativeQuery(ACTIONNOTIFIC);
		query.setParameter("mainid",MainId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> ActionPdcReports(String Emp, String ProjectId,String Position, java.sql.Date From, java.sql.Date To)
			throws Exception {
		Query query=manager.createNativeQuery(ACTIONPDC);
		query.setParameter("empid",Emp);
		query.setParameter("ProjectId",ProjectId);
		query.setParameter("From",From);
		query.setParameter("To",To);
		query.setParameter("Position",Position);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	

	@Override
	public String ProjectCode(String ProjectId) throws Exception {
		
		logger.info(new Date() +"Inside ProjectCode");
		Query query=manager.createNativeQuery(PROJECTCODE);
		query.setParameter("ProjectId",ProjectId);
		String ProjectCode=(String)query.getSingleResult();	
		return ProjectCode;
	}

	@Override
	public int MainExtendPdc(ActionMain main) throws Exception {
		logger.info(new Date() +"Inside MainExtendPdc");
		ActionMain am=amrepo.findById(main.getActionMainId()).get();
		am.setModifiedBy(main.getModifiedBy());
		am.setModifiedDate(main.getModifiedDate());
		am.setEndDate(main.getEndDate());
		am.setRevision(main.getRevision());
		if(main.getRevision()==1) {
			am.setPDC1(main.getEndDate());
		}else if(main.getRevision()==2) {
			am.setPDC2(main.getEndDate());
		}
		amrepo.save(am);
		return main.getRevision();
	}

	@Override
	public List<Object[]> ActionSelfList(String EmpId) throws Exception {
			logger.info(new Date() +"Inside Self AssignedList");	
	        Query query=manager.createNativeQuery(SELFASSIGNEDLIST);
			query.setParameter("empid", EmpId);
			List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
			return AssignedList;
		}

	@Override
	public List<Object[]> SearchDetails(String MainId) throws Exception {
		logger.info(new Date() +"Inside SearchDetails");	
		Query query=manager.createNativeQuery(SEARCHDATA);
		query.setParameter("mainid", MainId);
		List<Object[]> SearchDetails=(List<Object[]>)query.getResultList();	
		return SearchDetails;
	}	
	
	
	
	@Override
	public List<Object[]> ActionWiseAllReport(String Term,String empid,String ProjectId) throws Exception {
		
		logger.info(new Date() +"Inside ActionWiseAllReport");
		Query query=manager.createNativeQuery(ACTIONWISEALLREPORT);
		query.setParameter("term",Term);
		query.setParameter("empid",empid);
		query.setParameter("projectid", ProjectId);
		List<Object[]> ActionWiseAllReport=(List<Object[]>)query.getResultList();	
		return ActionWiseAllReport;
	}
	
	
	
	@Override
	public long ActionSelfReminderAddSubmit(ActionSelf actionself) throws Exception {
		logger.info(new Date() +"Inside ActionSelfReminderAddSubmit");		
		manager.persist(actionself);
		manager.flush();	
		return actionself.getActionId();
	}
	
	
	@Override
	public List<Object[]> ActionSelfReminderList(String empid,String fromdate,String todate) throws Exception {
		
		logger.info(new Date() +"Inside ActionSelfReminderList");
		Query query=manager.createNativeQuery(ACTIONSELFREMINDERLIST);		
		query.setParameter("empid",empid);
		query.setParameter("fromdate",fromdate);
		query.setParameter("todate",todate);
		List<Object[]> ActionSelfReminderList=(List<Object[]>)query.getResultList();	
		return ActionSelfReminderList;
	}
	
	@Override
	public int ActionSelfReminderDelete(String actionid) throws Exception {		
		logger.info(new Date() +"Inside ActionSelfReminderDelete");
		Query query=manager.createNativeQuery(ACTIONSELFREMINDERDELETE);	
		query.setParameter("actionid",actionid);
		return query.executeUpdate();		
	}

	@Override
	public List<Object[]> getActionAlertList() throws Exception {
		logger.info(new Date() +"Inside getActionAlertList");
		Query query=manager.createNativeQuery(ACTIONALERT);		
		List<Object[]> getActionAlertList=(List<Object[]>)query.getResultList();	
		return getActionAlertList;
	}

	@Override
	public List<Object[]> getActionToday(String empid,String ai) throws Exception {
		logger.info(new Date() +"Inside getActionToday");
		Query query=manager.createNativeQuery(ACTIONTODAY);	
		query.setParameter("empid",empid);
		query.setParameter("AI",ai);
		List<Object[]> getActionToday=(List<Object[]>)query.getResultList();	
		return getActionToday;
	}

	@Override
	public List<Object[]> getActionTommo(String empid,String ai) throws Exception {
		logger.info(new Date() +"Inside getActionTommo");
		Query query=manager.createNativeQuery(ACTIONTOMMO);	
		query.setParameter("empid",empid);
		query.setParameter("AI",ai);
		List<Object[]> getActionTommo=(List<Object[]>)query.getResultList();	
		return getActionTommo;
	}

	@Override
	public List<Object[]> getMeetingAlertList() throws Exception {
		logger.info(new Date() +"Inside getMeetingAlertList");
		Query query=manager.createNativeQuery(MEETINGALERT);		
		List<Object[]> getMeetingAlertList=(List<Object[]>)query.getResultList();	
		return getMeetingAlertList;
	}

	@Override
	public List<Object[]> getMeetingToday(String empid) throws Exception {
		logger.info(new Date() +"Inside getMeetingToday");
		Query query=manager.createNativeQuery(MEETINGTODAY);	
		query.setParameter("empid",empid);
		List<Object[]> getMeetingToday=(List<Object[]>)query.getResultList();	
		return getMeetingToday;
	}

	@Override
	public List<Object[]> getMeetingTommo(String empid) throws Exception {
		logger.info(new Date() +"Inside getMeetingTommo");
		Query query=manager.createNativeQuery(MEETINGTOMMO);	
		query.setParameter("empid",empid);
		List<Object[]> getMeetingTommo=(List<Object[]>)query.getResultList();	
		return getMeetingTommo;
	}
	
	@Override
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype , String LabCode)throws Exception
	{
		logger.info(new java.util.Date() +"Inside LoginProjectDetailsList");
		Query query=manager.createNativeQuery("CALL Pfms_Emp_ProjectList(:empid,:logintype,:labcode);");
		query.setParameter("empid", empid);
		query.setParameter("logintype", Logintype);
		query.setParameter("labcode", LabCode);
		List<Object[]> LoginProjectIdList=(List<Object[]>)query.getResultList();
		return LoginProjectIdList;
	}
	
	@Override
	public List<Object[]> AllEmpNameDesigList()throws Exception
	{
		logger.info(new java.util.Date() +"Inside AllEmpNameDesigList");
		Query query=manager.createNativeQuery(ALLEMPNAMEDESIGLIST);
		List<Object[]> AllEmpNameDesigList=(List<Object[]>)query.getResultList();
		return AllEmpNameDesigList;
	}
	
	
	@Override
	public List<Object[]> ProjectEmpList(String projectid)throws Exception
	{
		logger.info(new java.util.Date() +"Inside ProjectEmpList");
		Query query=manager.createNativeQuery(PROJECTEMPLIST);
		query.setParameter("projectid", projectid);
		List<Object[]> ProjectEmpList=(List<Object[]>)query.getResultList();
		return ProjectEmpList;
	}
	
	
	
	@Override
	public Object[] CommitteeShortName(String scheduleid)throws Exception
	{
		logger.info(new java.util.Date() +"Inside CommitteeShortName");
		Query query=manager.createNativeQuery(COMMITTEESHORTNAME);
		query.setParameter("scheduleid", scheduleid);
		Object[] CommitteeShortName=(Object[])query.getResultList().get(0);
		return CommitteeShortName;
	}
	
	
	
	@Override
	public List<Object[]> EmployeeDropdown(String empid,String logintype,String projectid)throws Exception
	{
		logger.info(new java.util.Date() +"Inside EmployeeDropdown");
		Query query=manager.createNativeQuery("CALL Employee_Dropdown(:empid,:logintype,:projectid);");
		query.setParameter("empid", empid);
		query.setParameter("logintype", logintype);
		query.setParameter("projectid", projectid);
		List<Object[]> EmployeeDropdown=(List<Object[]>)query.getResultList();
		return EmployeeDropdown;
	}
	
	
	private static final String  ACTIONDETAILSAJAX = "SELECT actionmainid,actionitem, assignee,CAST( DATE_FORMAT(enddate,'%d-%m-%Y') AS CHAR) AS 'enddate',revision ,assigneelabcode FROM action_main WHERE actionmainid=:actionid";
	
	@Override
	public Object[] ActionDetailsAjax(String actionid) throws Exception
	{		
		logger.info(new Date() +"Inside ActionDetailsAjax");
		Query query=manager.createNativeQuery(ACTIONDETAILSAJAX);
		query.setParameter("actionid", actionid);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		if(AssignedList.size()>0) {
			return AssignedList.get(0);
		}else {
			return null;
		}
	}
	
	@Override
	public int ActionMainEdit(ActionMain main) throws Exception
	{	
		logger.info(new Date() +"Inside ActionMainEdit");
		ActionMain detach = manager.find(ActionMain.class, main.getActionMainId());
		detach.setActionItem(main.getActionItem());
		detach.setAssignee(main.getAssignee());
		detach.setAssigneeLabCode(main.getAssigneeLabCode());
		if(manager.merge(detach)!=null) {
			return 1;
		}
		return 0;
		
	}
	
	private static final String CLUSTERLABLIST="SELECT labid,clusterid,labname,labcode FROM cluster_lab";
	
	@Override
	public List<Object[]> AllLabList() throws Exception 
	{
		logger.info(new java.util.Date() +"Inside ClusterLabList");
		Query query=manager.createNativeQuery(CLUSTERLABLIST);
		List<Object[]> ClusterLabList=(List<Object[]>)query.getResultList();
		return ClusterLabList;
	}
	
	private static final String CLUSTEREXPERTSLIST ="SELECT e.expertid,e.expertname,e.expertno,'Expert' AS designation FROM expert e WHERE e.isactive=1 ";
	@Override
	public List<Object[]> ClusterExpertsList() throws Exception
	{
		logger.info(new java.util.Date() +"Inside DGEmpData");
		try {
			Query query=manager.createNativeQuery(CLUSTEREXPERTSLIST);
			List<Object[]> DGEmpData=(List<Object[]>)query.getResultList();
			return DGEmpData;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new java.util.Date() +" Inside DGEmpData DAO "+ e);
			return new ArrayList<Object[]>();
		}
	}
	
	private static final String LABINFOCLUSTERLAB = "SELECT labid,clusterid,labname,labcode FROM cluster_lab WHERE labcode =:labcode";
	@Override
	public Object[] LabInfoClusterLab(String LabCode) throws Exception 
	{
		logger.info(new java.util.Date() +"Inside LabInfoClusterLab");
		Query query=manager.createNativeQuery(LABINFOCLUSTERLAB);
		query.setParameter("labcode", LabCode);
		Object[] LabInfoClusterLab=(Object[])query.getSingleResult();
		return LabInfoClusterLab;
	}
	
	private static final String LABEMPLOYEELIST="SELECT a.empid, a.empname,a.empno,b.designation FROM employee a,employee_desig b WHERE a.isactive=1 AND a.desigid=b.desigid AND a.labcode=:labcode ;";
	@Override
	public List<Object[]> LabEmployeeList(String LabCode) throws Exception 
	{
		logger.info(new java.util.Date() +"Inside LabEmployeeList");
		Query query=manager.createNativeQuery(LABEMPLOYEELIST);
		query.setParameter("labcode", LabCode);
		List<Object[]> ChairpersonEmployeeListFormation=(List<Object[]>)query.getResultList();
		return ChairpersonEmployeeListFormation;
	}
	
	
}
