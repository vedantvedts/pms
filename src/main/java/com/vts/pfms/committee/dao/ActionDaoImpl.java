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

import com.vts.pfms.committee.model.ActionAssign;
import com.vts.pfms.committee.model.ActionAttachment;
import com.vts.pfms.committee.model.ActionMain;
import com.vts.pfms.committee.model.ActionSelf;
import com.vts.pfms.committee.model.ActionSub;
import com.vts.pfms.committee.model.PfmsNotification;


@Transactional
@Repository
public class ActionDaoImpl implements ActionDao{
	
	private static final Logger logger=LogManager.getLogger(ActionDaoImpl.class);
	


	private static final String EMPLOYEELIST="select a.empid,a.empname,b.designation FROM employee a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId AND LabCode=:LabCode ORDER BY a.srno=0,a.srno ";
	private static final String ASSIGNEDLIST="SELECT a.actionmainid,ab.empname,dc.designation,a.actiondate,aas.enddate,a.actionitem,aas.actionstatus,aas.actionflag,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) AS subid,(SELECT c.progress FROM action_sub c  WHERE  c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS remarks,aas.revision,aas.IsSeen , aas.actionassignid , (SELECT COUNT(am.actionmainid) FROM action_main am WHERE am.ParentActionid = a.actionmainid ) AS 'ChildActionCount' FROM action_main a,  employee ab ,employee_desig dc ,action_assign aas WHERE aas.actionmainid=a.actionmainid AND aas.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND aas.assignor=:empid AND aas.actionflag<>'Y'";
	//isseen column has been removed  04-08-2021
	//private static final String ASSIGNEDLIST="SELECT a.actionmainid,ab.empname,dc.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS remarks,a.revision FROM action_main a,  employee ab ,employee_desig dc WHERE a.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND a.assignor=:empid and a.actionflag<>'Y'";
	private static final String ASSIGNEELIST="SELECT a.actionmainid,b.empname,c.designation,a.actiondate,d.enddate,a.actionitem,d.actionstatus,d.actionflag,d.remarks,a.actionlinkid,d.actionno ,d.actionassignid ,d.assignee ,d.assignor , a.actionlevel ,a.projectid FROM  action_main a, employee b ,employee_desig c , action_assign d WHERE a.actionmainid=d.actionmainid AND d.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND (d.assignee=:empid OR d.assignor=:empid) and d.actionflag in ('N','B') order by d.enddate desc";
	private static final String ASSIGNEEDATA="SELECT a.actionmainid,b.empname,c.designation,a.actiondate,e.enddate,a.actionitem,e.actionstatus,e.actionflag,a.scheduleminutesid,a.actionlinkid,e.actionno,e.revision,d.empname AS 'assignee',a.actiontype,e.pdcorg,e.pdc1,e.pdc2 ,e.assignorlabcode,e.assigneelabcode , e.actionassignid FROM  action_main a, employee b ,employee_desig c ,employee d ,action_assign e WHERE e.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND  e.actionflag<>'Y' AND  e.assignee=d.empid AND a.actionmainid=:mainid AND e.actionassignid=:actionassignid";
    private static final String SUBLIST="SELECT a.actionsubid,a.actionassignid,a.progress,a.progressdate,a.remarks,b.attachname,b.actionattach,b.actionattachid FROM action_sub a, action_attachment b WHERE a.actionsubid=b.actionsubid AND a.actionassignid=:assignid";
	private static final String SUBDELETE="delete from action_sub where actionsubid=:subid";
	private static final String ASSIGNUPDATE="UPDATE action_assign SET actionflag=:flag,actionstatus=:status,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE actionassignid=:assignid";
	private static final String MAINFORWARD="UPDATE action_assign SET actionflag=:flag,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE actionassignid=:assign";
	private static final String FORWARDLIST="SELECT a.actionmainid,ab.empname,dc.designation,a.actiondate,aas.enddate,a.actionitem,aas.actionstatus,aas.actionflag,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS remarks,a.actionlinkid,aas.actionno, aas.actionassignid FROM action_main a,  employee ab ,employee_desig dc , action_assign aas WHERE a.actionmainid=aas.actionmainid AND aas.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND aas.actionflag='F' AND aas.assignor=:empid";
	private static final String MAINSENDBACK="UPDATE action_assign SET remarks=:remarks,actionstatus=:status,actionflag=:flag,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE actionassignid=:assignid";
	private static final String ACTIONLIST ="SELECT DISTINCT(a.scheduleid), a.committeeid, a.committeemainid, b.committeename, a.scheduledate, a.schedulestarttime  FROM committee_schedule a, committee b, committee_schedules_minutes_details c,committee_main d ,committee_member cm WHERE a.committeeid=b.committeeid AND a.scheduledate<=CURDATE() AND a.scheduleid=c.scheduleid AND c.idarck IN('A','K','I')  AND a.committeemainid=d.committeemainid  AND d.isactive=1 AND a.isactive=1   AND d.committeemainid=cm.committeemainid AND cm.membertype='CS'  AND cm.empid=:empid";
	private static final String COMMITTEEDATA="CALL Pfms_Action_List(:scheduleid)";
	private static final String COMMITTEESCHEDULEEDITDATA="SELECT a.committeeid,a.committeemainid,a.scheduledate,a.schedulestarttime,a.scheduleflag,a.schedulesub,a.scheduleid,b.committeename,b.committeeshortname,a.projectid FROM committee_schedule a,committee b WHERE scheduleid=:committeescheduleid AND a.committeeid=b.committeeid AND a.isactive=1 ";
	private static final String SCHEDULELIST="SELECT a.actionmainid,b.empname,c.designation,a.actiondate,d.enddate,a.actionitem,d.actionstatus,d.actionflag ,d.assigneelabcode FROM  action_main a, employee b ,employee_desig c ,action_assign d WHERE a.actionmainid=d.actionmainid AND d.assignee=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND a.scheduleminutesid=:schid";
    private static final String CONTENT="SELECT a.actionmainid,b.details,b.minutesid,b.minutessubid,b.minutessubofsubid,b.minutesunitid,b.idarck FROM action_main a, committee_schedules_minutes_details b WHERE a.scheduleminutesid=b.scheduleminutesid AND a.actionmainid=:aid";
    private static final String ACTIONSEARCH="SELECT a.actionmainid,aas.actionno,ab.empname,dc.designation FROM action_main a,  employee ab ,employee_desig dc,action_assign  aas WHERE aas.actionmainid=a.actionmainid AND aas.assignor=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND aas.actionno LIKE :actionno";
    private static final String STATUSLIST="SELECT a.actionmainid,b.empname,c.designation,a.actiondate,f.enddate,a.actionitem,f.actionstatus,f.actionflag,d.empname AS emp,e.designation AS desig,f.actionno,a.actionlinkid,(SELECT g.progress FROM action_sub g  WHERE g.actionassignid = f.actionassignid AND g.actionsubid = (SELECT MAX(s.actionsubid) FROM action_sub s WHERE s.actionassignid = f.actionassignid) )  AS progress , f.actionassignid FROM  action_main a, employee b ,employee_desig c, employee d ,employee_desig e ,action_assign f WHERE a.actionmainid = f.actionmainid  AND f.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND f.assignee=d.empid AND d.isactive='1' AND d.desigid=e.desigid AND f.assignee=:empid AND a.actiondate BETWEEN :fdate AND :tdate";
	private static final String LABDETAILS = "select * from lab_master"; 
    private static final String ACTIONGENCOUNT="SELECT COUNT(*) FROM action_main a , action_assign b WHERE a.actionmainid=b.actionmainid AND (CASE WHEN :projectid=0 THEN a.projectid=:projectid AND DATE_FORMAT(CURDATE(), \"%Y\")=DATE_FORMAT(a.actiondate, \"%Y\") ELSE a.projectid=:projectid END ) AND a.isactive='1'";
	private static final String ASSIGNEEDETAILS="SELECT assignor,assignee,actionno FROM action_assign WHERE actionassignid=:assignid";
	private static final String SCHEDULEITEM="SELECT a.scheduleminutesid,a.details FROM  committee_schedules_minutes_details a WHERE  a.scheduleminutesid=:schid";
    private static final String ACTIONREPORT="CALL Pfms_Action_Reports(:empid,:term,:position,:type,:LabCode)";
    private static final String ACTIONSEARCHNO="CALL Pfms_ActionNo_Search(:empid,:no,:position)";
	private static final String PROJECTLIST="SELECT projectid,projectmainid,projectcode,projectname FROM project_master WHERE isactive=1";
    private static final String ACTIONCOUNT="CALL Pfms_Action_PD_Chart(:projectid)";
    private static final String LOGINPROJECTIDLIST="SELECT a.projectid,a.projectcode,a.projectname,a.ProjectMainId,a.ProjectDescription,a.UnitCode,a.ProjectType,a.ProjectCategory,a.SanctionNo,a.SanctionDate,a.PDC,a.ProjectDirector FROM project_master a,project_employee b WHERE a.isactive=1 and a.projectid=b.projectid and b.empid=:empid";
    private static final String ALLPROJECTDETAILSLIST ="SELECT a.projectid,a.projectcode,a.projectname,a.ProjectMainId,a.ProjectDescription,a.UnitCode,a.ProjectType,a.ProjectCategory,a.SanctionNo,a.SanctionDate,a.PDC,a.ProjectDirector FROM project_master a WHERE a.isactive=1 ";
	private static final String ACTIONWISE="CALL Pfms_Action_Wise_Reports(:term,:ProjectId)";
    private static final String ACTIONNOTIFIC="SELECT ab.empname as emp,dc.designation as desig,aas.assignee,b.empname,c.designation,aas.assignor,aas.revision,aas.actionno  FROM action_main a,  employee ab ,employee_desig dc,employee b ,employee_desig c ,action_assign aas   WHERE   aas.assignor=b.empid  AND b.isactive='1' AND c.desigid=b.desigid AND aas.assignee=ab.empid  AND ab.isactive='1' AND dc.desigid=ab.desigid AND a.actionmainid=:mainid and aas.actionassignid=:actionassignid";
	private static final String ACTIONPDC="CALL Pfms_Action_PDC_Report(:empid,:ProjectId,:Position,:From,:To)";
    private static final String PROJECTCODE="SELECT projectcode FROM project_master WHERE   projectid=:ProjectId  AND isactive='1'";
	private static final String SELFASSIGNEDLIST="SELECT a.actionmainid,ab.empname,dc.designation,a.actiondate,aas.enddate,a.actionitem,aas.actionstatus,aas.actionflag,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS remarks,aas.revision FROM action_main a,  employee ab ,employee_desig dc , action_assign aas WHERE a.actionmainid=aas.actionmainid AND aas.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND aas.assignor=:empid AND aas.assignee=:empid AND aas.actionflag<>'Y'";
	private static final String SEARCHDATA="SELECT a.actionmainid,b.empname,c.designation,a.actiondate,d.enddate,a.actionitem,d.actionstatus,d.actionflag,a.scheduleminutesid,a.actionlinkid,d.actionno,d.revision FROM  action_main a, employee b ,employee_desig c , action_assign d WHERE a.actionmainid=d.actionmainid AND d.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid  AND a.actionmainid=:mainid AND d.actionassignid=:assignid";
	private static final String ACTIONWISEALLREPORT="CALL Pfms_Action_Wise_All_Reports (:term,:empid,:projectid);";
	private static final String ACTIONALERT="CALL Pfms_Actions_Msg()";
	private static final String ACTIONTODAY="SELECT a.actionno,a.projectid FROM action_main a WHERE  a.enddate=CURDATE() AND a.actionflag IN('N','B','F') AND (CASE WHEN 'AI'=:AI THEN a.Actiontype IN ('S','N') ELSE a.Actiontype IN ('A','B','C') END) AND  a.assignee=:empid ";
	private static final String ACTIONTOMMO="SELECT a.actionno,a.projectid FROM action_main a WHERE  a.enddate=CURDATE()+1 AND a.actionflag IN('N','B','F') AND (CASE WHEN 'AI'=:AI THEN a.Actiontype IN ('S','N') ELSE a.Actiontype IN ('A','B','C') END) AND a.assignee=:empid ";
	private static final String MEETINGALERT="CALL Pfms_Meeting_Msg()";
	private static final String MEETINGTODAY="CALL Pfms_Meeting_Msg_Today(:empid)";
	private static final String MEETINGTOMMO="CALL Pfms_Meeting_Msg_Tommo(:empid)";
	
	
	private static final String ACTIONSELFREMINDERLIST="SELECT ActionId,EmpId,ActionItem,ActionDate,ActionTime,ActionType FROM pfms_action_self WHERE isactive='1' AND actiondate BETWEEN :fromdate AND :todate AND empid=:empid AND labcode=(SELECT labcode FROM employee WHERE empid= :empid ) ORDER BY ActionDate DESC";
	private static final String ALLEMPNAMEDESIGLIST="SELECT e.empid , e.empname, ed.designation FROM employee e, employee_desig ed WHERE e.desigid=ed.desigid";
	private static final String COMMITTEESHORTNAME="SELECT cs.committeeid, c.committeeshortname  FROM committee c,committee_schedule cs WHERE c.committeeid=cs.committeeid AND cs.scheduleid=:scheduleid AND cs.isactive=1 ";
	private static final String ASSIGNEESEENUPDATE="UPDATE action_assign SET isseen='1' WHERE assignee=:empid ";
	public static final String ACTIONSELFREMINDERDELETE="UPDATE pfms_action_self SET isactive=0 WHERE actionid=:actionid";
	private static final String PROJECTEMPLIST="SELECT a.empid,a.empname,b.designation FROM employee a,employee_desig b,project_employee pe  WHERE a.isactive='1' AND a.DesigId=b.DesigId  AND pe.empid=a.empid AND pe.projectid=:projectid ORDER BY a.srno=0,a.srno";
	 
	 
    @PersistenceContext
	EntityManager manager;
	
	@Autowired
	ActionDaoRepo amrepo;
	
	@Override
	public Object[] LabDetails()throws Exception
	{
		Query query=manager.createNativeQuery(LABDETAILS);
		Object[] Labdetails =(Object[])query.getResultList().get(0);
		return Labdetails ;
	}
	
	@Override
	public List<Object[]> EmployeeList(String LabCode) throws Exception {
		Query query=manager.createNativeQuery(EMPLOYEELIST);
		query.setParameter("LabCode", LabCode);
		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();	
		return EmployeeList;
	}

	@Override
	public List<Object[]> AssignedList(String EmpId ) throws Exception {
        Query query=manager.createNativeQuery(ASSIGNEDLIST);
		query.setParameter("empid", EmpId);
		
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public long ActionMainInsert(ActionMain main) throws Exception {
		
		manager.persist(main);
		manager.flush();
		return main.getActionMainId();
	}
	
	@Override
	public long ActionAssignInsert(ActionAssign assign) throws Exception {
		
		manager.persist(assign);
		manager.flush();
		return assign.getActionAssignId();
	}
	

	@Override
	public List<Object[]> AssigneeList(String EmpId) throws Exception {
		
		Query query=manager.createNativeQuery(ASSIGNEELIST);
		query.setParameter("empid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	
	
	@Override
	public int AssigneeSeenUpdate(String EmpId) throws Exception 
	{		
		Query query=manager.createNativeQuery(ASSIGNEESEENUPDATE);
		query.setParameter("empid", EmpId);
		return query.executeUpdate();
	}
	
	
	
	@Override
	public List<Object[]> AssigneeData(String mainid ,String assignid) throws Exception {
		
		Query query=manager.createNativeQuery(ASSIGNEEDATA);
		query.setParameter("mainid", mainid);
		query.setParameter("actionassignid", assignid);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> SubList(String assignid) throws Exception {
		Query query=manager.createNativeQuery(SUBLIST);
		query.setParameter("assignid", assignid);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	@Override
	public long ActionSubInsert(ActionSub main) throws Exception {
		
		manager.persist(main);
		manager.flush();
		return main.getActionSubId();
	}
	
	@Override
	public long ActionAttachInsert(ActionAttachment main) throws Exception {
		
		manager.persist(main);
		manager.flush();
		return main.getActionAttachId();
	}
	
	@Override
	public ActionAttachment ActionAttachmentDownload(String achmentid) throws Exception
	{
		ActionAttachment Attachment= manager.find(ActionAttachment.class,Long.parseLong(achmentid));
		return Attachment;
	}

	@Override
	public int ActionSubDelete(String id) throws Exception {
		
		Query query=manager.createNativeQuery(SUBDELETE);
		query.setParameter("subid", id);
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int AssignUpdate(ActionAssign assign) throws Exception {
		
		Query query=manager.createNativeQuery(ASSIGNUPDATE);
		query.setParameter("assignid",assign.getActionMainId());
		query.setParameter("flag", assign.getActionFlag());
		query.setParameter("status",assign.getActionStatus());
		query.setParameter("modifiedby",assign.getModifiedBy());
		query.setParameter("modifieddate",assign.getModifiedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int MainForward(ActionAssign assign) throws Exception {
		
		Query query=manager.createNativeQuery(MAINFORWARD);
		query.setParameter("assign",assign.getActionAssignId());
		query.setParameter("flag", assign.getActionFlag());
		query.setParameter("modifiedby",assign.getModifiedBy());
		query.setParameter("modifieddate",assign.getModifiedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public List<Object[]> ForwardList(String EmpId) throws Exception {
		
		Query query=manager.createNativeQuery(FORWARDLIST);
		query.setParameter("empid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public int MainSendBack(ActionAssign assign) throws Exception {
		
		Query query=manager.createNativeQuery(MAINSENDBACK);
		query.setParameter("assignid",assign.getActionAssignId());
		query.setParameter("remarks", assign.getRemarks());
		query.setParameter("flag", assign.getActionFlag());
		query.setParameter("status",assign.getActionStatus());
		query.setParameter("modifiedby",assign.getModifiedBy());
		query.setParameter("modifieddate",assign.getModifiedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public List<Object[]> StatusList(String EmpId,String fdate, String tdate) throws Exception {
		
		Query query=manager.createNativeQuery(STATUSLIST);
		query.setParameter("empid", EmpId);
		query.setParameter("fdate", fdate);
		query.setParameter("tdate", tdate);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> ActionList(String EmpId) throws Exception {
		
		Query query=manager.createNativeQuery(ACTIONLIST);
		query.setParameter("empid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> CommitteeActionList(String EmpId) throws Exception {
		
		Query query=manager.createNativeQuery(COMMITTEEDATA);
		query.setParameter("scheduleid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	@Override
	public Object[] CommitteeScheduleEditData(String CommitteeScheduleId) throws Exception 
	{		
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEEDITDATA);
		query.setParameter("committeescheduleid", CommitteeScheduleId );
		Object[] CommitteeScheduleEditData=(Object[])query.getSingleResult();
		return CommitteeScheduleEditData;
	}
				
	@Override
	public List<Object[]> ScheduleActionList(String ScheduleId) throws Exception {
		
		Query query=manager.createNativeQuery(SCHEDULELIST);
		query.setParameter("schid", ScheduleId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	@Override
	public List<Object[]> MeetingContent(String ScheduleId) throws Exception {
		
		Query query=manager.createNativeQuery(CONTENT);
		query.setParameter("aid", ScheduleId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]>  ActionNoSearch(String ActionMainId) throws Exception {

		Query query=manager.createNativeQuery(ACTIONSEARCH);
		query.setParameter("actionno",ActionMainId);
		List<Object[]> ActionDetails=(List<Object[]>)query.getResultList();
		
		return ActionDetails;
	}

	@Override
	public int ActionGenCount(String ProjectId) throws Exception {
		
		Query query = manager.createNativeQuery(ACTIONGENCOUNT);
		query.setParameter("projectid",ProjectId );
		BigInteger count=(BigInteger)query.getSingleResult();
			return count.intValue();
	}
	
	@Override
	public long ActionNotificationInsert(PfmsNotification main) throws Exception {
		
		manager.persist(main);
		manager.flush();
		return main.getNotificationId();
	}

	@Override
	public List<Object[]> AssigneeDetails(String assignid) throws Exception {
		
		Query query=manager.createNativeQuery(ASSIGNEEDETAILS);
		query.setParameter("assignid",assignid );
		List<Object[]> AssigneeDetails=(List<Object[]>)query.getResultList();
		
		return AssigneeDetails;
	}
	
	@Override
	public List<Object[]> ScheduleActionItem(String ScheduleId) throws Exception {
		
		Query query=manager.createNativeQuery(SCHEDULEITEM);
		query.setParameter("schid", ScheduleId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	@Override
	public List<Object[]> ActionReports(String EmpId,String Term,String Position,String Type,String LabCode) throws Exception {
		
		Query query=manager.createNativeQuery(ACTIONREPORT);
		query.setParameter("empid",EmpId);
		query.setParameter("term",Term);
		query.setParameter("position",Position);
		query.setParameter("type",Type);
		query.setParameter("LabCode",LabCode);
		
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	@Override
	public List<Object[]> ActionSearch(String EmpId,String No,String Position) throws Exception {
		
		Query query=manager.createNativeQuery(ACTIONSEARCHNO);
		query.setParameter("empid",EmpId);
		query.setParameter("no",No);
		query.setParameter("position",Position);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> ProjectList() throws Exception {
		
		Query query=manager.createNativeQuery(PROJECTLIST);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> ActionCountList(String ProjectId) throws Exception {
		
		Query query=manager.createNativeQuery(ACTIONCOUNT);
		query.setParameter("projectid",ProjectId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	@Override
	public List<Object[]> projectdetailsList(String EmpId) throws Exception {
		
		Query query=manager.createNativeQuery(LOGINPROJECTIDLIST);
		query.setParameter("empid", EmpId);
		return (List<Object[]>)query.getResultList();
	}
	
	@Override
	public List<Object[]> allprojectdetailsList() throws Exception {
		
		Query query=manager.createNativeQuery(ALLPROJECTDETAILSLIST);		
		return (List<Object[]>)query.getResultList();
	}

	@Override
	public List<Object[]> ActionWiseReports(String Term, String ProjectId) throws Exception {
		
		Query query=manager.createNativeQuery(ACTIONWISE);
		query.setParameter("term",Term);
		query.setParameter("ProjectId",ProjectId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	@Override
	public List<Object[]> ActionNotification( String MainId , String assignid) throws Exception {
		
		Query query=manager.createNativeQuery(ACTIONNOTIFIC);
		query.setParameter("mainid",MainId);
		query.setParameter("actionassignid", assignid);
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
		
		Query query=manager.createNativeQuery(PROJECTCODE);
		query.setParameter("ProjectId",ProjectId);
		String ProjectCode=(String)query.getSingleResult();	
		return ProjectCode;
	}
	@Override
	public List<Object[]> ActionSelfList(String EmpId) throws Exception {
	        Query query=manager.createNativeQuery(SELFASSIGNEDLIST);
			query.setParameter("empid", EmpId);
			List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
			return AssignedList;
		}

	@Override
	public List<Object[]> SearchDetails(String MainId , String assignid) throws Exception {
		Query query=manager.createNativeQuery(SEARCHDATA);
		query.setParameter("mainid", MainId);
		query.setParameter("assignid", assignid);
		List<Object[]> SearchDetails=(List<Object[]>)query.getResultList();	
		return SearchDetails;
	}	
	
	
	
	@Override
	public List<Object[]> ActionWiseAllReport(String Term,String empid,String ProjectId) throws Exception {
		
		Query query=manager.createNativeQuery(ACTIONWISEALLREPORT);
		query.setParameter("term",Term);
		query.setParameter("empid",empid);
		query.setParameter("projectid", ProjectId);
		List<Object[]> ActionWiseAllReport=(List<Object[]>)query.getResultList();	
		return ActionWiseAllReport;
	}
	
	
	
	@Override
	public long ActionSelfReminderAddSubmit(ActionSelf actionself) throws Exception {
		manager.persist(actionself);
		manager.flush();	
		return actionself.getActionId();
	}
	
	
	@Override
	public List<Object[]> ActionSelfReminderList(String empid,String fromdate,String todate) throws Exception {
		
		Query query=manager.createNativeQuery(ACTIONSELFREMINDERLIST);		
		query.setParameter("empid",empid);
		query.setParameter("fromdate",fromdate);
		query.setParameter("todate",todate);
		List<Object[]> ActionSelfReminderList=(List<Object[]>)query.getResultList();	
		return ActionSelfReminderList;
	}
	
	@Override
	public int ActionSelfReminderDelete(String actionid) throws Exception {		
		Query query=manager.createNativeQuery(ACTIONSELFREMINDERDELETE);	
		query.setParameter("actionid",actionid);
		return query.executeUpdate();		
	}

	@Override
	public List<Object[]> getActionAlertList() throws Exception {
		Query query=manager.createNativeQuery(ACTIONALERT);		
		List<Object[]> getActionAlertList=(List<Object[]>)query.getResultList();	
		return getActionAlertList;
	}

	@Override
	public List<Object[]> getActionToday(String empid,String ai) throws Exception {
		Query query=manager.createNativeQuery(ACTIONTODAY);	
		query.setParameter("empid",empid);
		query.setParameter("AI",ai);
		List<Object[]> getActionToday=(List<Object[]>)query.getResultList();	
		return getActionToday;
	}

	@Override
	public List<Object[]> getActionTommo(String empid,String ai) throws Exception {
		Query query=manager.createNativeQuery(ACTIONTOMMO);	
		query.setParameter("empid",empid);
		query.setParameter("AI",ai);
		List<Object[]> getActionTommo=(List<Object[]>)query.getResultList();	
		return getActionTommo;
	}

	@Override
	public List<Object[]> getMeetingAlertList() throws Exception {
		Query query=manager.createNativeQuery(MEETINGALERT);		
		List<Object[]> getMeetingAlertList=(List<Object[]>)query.getResultList();	
		return getMeetingAlertList;
	}

	@Override
	public List<Object[]> getMeetingToday(String empid) throws Exception {
		Query query=manager.createNativeQuery(MEETINGTODAY);	
		query.setParameter("empid",empid);
		List<Object[]> getMeetingToday=(List<Object[]>)query.getResultList();	
		return getMeetingToday;
	}

	@Override
	public List<Object[]> getMeetingTommo(String empid) throws Exception {
		Query query=manager.createNativeQuery(MEETINGTOMMO);	
		query.setParameter("empid",empid);
		List<Object[]> getMeetingTommo=(List<Object[]>)query.getResultList();	
		return getMeetingTommo;
	}
	
	@Override
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype , String LabCode)throws Exception
	{
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
		Query query=manager.createNativeQuery(ALLEMPNAMEDESIGLIST);
		List<Object[]> AllEmpNameDesigList=(List<Object[]>)query.getResultList();
		return AllEmpNameDesigList;
	}
	private static final String GETREASSIGNEDDATA="SELECT  b.actionassignid,b.Actionmainid ,a.Actionitem , b.Actionno , a.actionlevel,a.projectid ,b.enddate,a.mainid ,a.actiontype FROM action_main a , action_assign b WHERE a.actionmainid=b.actionmainid AND b.actionassignid=:actionassignid";
	@Override
	public Object[] GetActionReAssignData(String Actionassignid)throws Exception
	{
		Object[] assigndata = null;
		Query query=manager.createNativeQuery(GETREASSIGNEDDATA);
		query.setParameter("actionassignid", Actionassignid);
		List<Object[]> list=(List<Object[]>)query.getResultList();
		if(list!=null && list.size()>0) {
			assigndata=list.get(0);
		}
		return assigndata;
	}
	private static final String PROJECTDATA="SELECT projectid ,projectcode , projectname FROM project_master WHERE projectid=:projectid";
	@Override
	public Object[] GetProjectData(String projectid)throws Exception
	{
		Object[] assigndata = null;
		Query query=manager.createNativeQuery(PROJECTDATA);
		query.setParameter("projectid", projectid);
		List<Object[]> list=(List<Object[]>)query.getResultList();
		if(list!=null && list.size()>0) {
			assigndata=list.get(0);
		}
		return assigndata;
	}
	
	@Override
	public List<Object[]> ProjectEmpList(String projectid)throws Exception
	{
		Query query=manager.createNativeQuery(PROJECTEMPLIST);
		query.setParameter("projectid", projectid);
		List<Object[]> ProjectEmpList=(List<Object[]>)query.getResultList();
		return ProjectEmpList;
	}
	
	
	
	@Override
	public Object[] CommitteeShortName(String scheduleid)throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEESHORTNAME);
		query.setParameter("scheduleid", scheduleid);
		Object[] CommitteeShortName=(Object[])query.getResultList().get(0);
		return CommitteeShortName;
	}
	
	
	
	@Override
	public List<Object[]> EmployeeDropdown(String empid,String logintype,String projectid)throws Exception
	{
		Query query=manager.createNativeQuery("CALL Employee_Dropdown(:empid,:logintype,:projectid);");
		query.setParameter("empid", empid);
		query.setParameter("logintype", logintype);
		query.setParameter("projectid", projectid);
		List<Object[]> EmployeeDropdown=(List<Object[]>)query.getResultList();
		return EmployeeDropdown;
	}
	
	
	private static final String  ACTIONDETAILSAJAX = "SELECT a.actionmainid,a.actionitem, b.assignee,CAST( DATE_FORMAT(b.enddate,'%d-%m-%Y') AS CHAR) AS 'enddate',b.revision ,b.assigneelabcode ,b.ActionAssignId FROM action_main a , action_assign b WHERE a.actionmainid=b.actionmainid AND a.actionmainid=:actionid and b.actionassignid=:assignid";
	
	@Override
	public Object[] ActionDetailsAjax(String actionid ,String assignid) throws Exception
	{		
		Query query=manager.createNativeQuery(ACTIONDETAILSAJAX);
		query.setParameter("actionid", actionid);
		query.setParameter("assignid", assignid);
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
		ActionMain detach = manager.find(ActionMain.class, main.getActionMainId());
		detach.setActionItem(main.getActionItem());
		
		if(manager.merge(detach)!=null) {
			return 1;
		}
		return 0;
		
	}
	 @Override
	 public int ActionAssignEdit(ActionAssign assign) throws Exception
	 {
		 ActionAssign detach = manager.find(ActionAssign.class, assign.getActionAssignId());
		
			detach.setAssignee(assign.getAssignee());
			detach.setAssigneeLabCode(assign.getAssigneeLabCode());
			if(manager.merge(detach)!=null) {
				return 1;
			}
			return 0;
	 }
	
	private static final String CLUSTERLABLIST="SELECT labid,clusterid,labname,labcode FROM cluster_lab";
	
	@Override
	public List<Object[]> AllLabList() throws Exception 
	{
		Query query=manager.createNativeQuery(CLUSTERLABLIST);
		List<Object[]> ClusterLabList=(List<Object[]>)query.getResultList();
		return ClusterLabList;
	}
	
	private static final String ACTIONMAINDATA="SELECT Actionmainid,empid,actiondate,actionitem,actiontype,projectid,scheduleminutesid FROM action_main WHERE actionstatus='A' AND isactive=1 AND Actionmainid=:actionmainid";
	@Override
	public Object[] GetActionMainData(String actionmainid) throws Exception {
		Object[] actiondata=null;
		Query query = manager.createNativeQuery(ACTIONMAINDATA);
		query.setParameter("actionmainid", actionmainid);
		List<Object[]> result = (List<Object[]>)query.getResultList();
		if(result.size()>0) {
			actiondata=result.get(0);
		}
		return actiondata;
	}
	
	private static final String CLUSTEREXPERTSLIST ="SELECT e.expertid,e.expertname,e.expertno,'Expert' AS designation FROM expert e WHERE e.isactive=1 ";
	@Override
	public List<Object[]> ClusterExpertsList() throws Exception
	{
		try {
			Query query=manager.createNativeQuery(CLUSTEREXPERTSLIST);
			List<Object[]> DGEmpData=(List<Object[]>)query.getResultList();
			return DGEmpData;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new java.util.Date() +" Inside DAO ClusterExpertsList"+ e);
			return new ArrayList<Object[]>();
		}
	}
	private static final String CLUSTERFILTEREMPLIST="SELECT e.expertid,e.expertname,e.expertno,'Expert' AS designation FROM expert e  WHERE e.isactive=1 AND e.expertid NOT IN (SELECT b.assignee FROM  action_main a, action_assign b WHERE a.actionmainid=b.actionmainid AND b.assigneelabcode=:labcode AND (a.mainid=:mainid OR a.actionmainid=:mainid))";
	
	@Override
	public List<Object[]> ClusterFilterExpertsList(String Labcode , String MainId)throws Exception
	{
		try {
			Query query=manager.createNativeQuery(CLUSTERFILTEREMPLIST);
			query.setParameter("labcode", Labcode);
			query.setParameter("mainid", MainId);
			List<Object[]> DGEmpData=(List<Object[]>)query.getResultList();
			return DGEmpData;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new java.util.Date() +" Inside DAO ClusterFilterExpertsList "+ e);
			return new ArrayList<Object[]>();
		}
	}
	private static final String LABINFOCLUSTERLAB = "SELECT labid,clusterid,labname,labcode FROM cluster_lab WHERE labcode =:labcode";
	@Override
	public Object[] LabInfoClusterLab(String LabCode) throws Exception 
	{
		Query query=manager.createNativeQuery(LABINFOCLUSTERLAB);
		query.setParameter("labcode", LabCode);
		Object[] LabInfoClusterLab=(Object[])query.getSingleResult();
		return LabInfoClusterLab;
	}
	
	private static final String LABEMPLOYEELIST="SELECT a.empid, a.empname,a.empno,b.designation FROM employee a,employee_desig b WHERE a.isactive=1 AND a.desigid=b.desigid AND a.labcode=:labcode ;";
	@Override
	public List<Object[]> LabEmployeeList(String LabCode) throws Exception 
	{
		Query query=manager.createNativeQuery(LABEMPLOYEELIST);
		query.setParameter("labcode", LabCode);
		List<Object[]> ChairpersonEmployeeListFormation=(List<Object[]>)query.getResultList();
		return ChairpersonEmployeeListFormation;
	}
	private static final String LABEMPFILTERFORACTION="SELECT a.empid, a.empname,a.empno,b.designation FROM employee a,employee_desig b WHERE a.isactive=1 AND a.desigid=b.desigid AND a.empid NOT IN (SELECT b.assignee FROM  action_main a, action_assign b WHERE a.actionmainid=b.actionmainid AND b.assigneelabcode=:labcode AND (a.mainid=:mainid OR a.actionmainid=:mainid)) AND a.labcode=:labcode\r\n"
			+ "";
	@Override
	public List<Object[]> LabEmpListFilterForAction(String LabCode , String MainId) throws Exception
	{
		Query query=manager.createNativeQuery(LABEMPFILTERFORACTION);
		query.setParameter("labcode", LabCode);
		query.setParameter("mainid", MainId);
		List<Object[]> ChairpersonEmployeeListFormation=(List<Object[]>)query.getResultList();
		return ChairpersonEmployeeListFormation;
	}
	 @Override
	 public int ActionAssignRevisionEdit(ActionAssign assign) throws Exception
	 {
		 ActionAssign detach = manager.find(ActionAssign.class, assign.getActionAssignId());
		
			detach.setRevision(assign.getRevision());
			detach.setModifiedBy(assign.getModifiedBy());
			detach.setModifiedDate(assign.getModifiedDate());
			
			if(assign.getRevision()==1) {
				detach.setPDC1(assign.getEndDate());
			}else if(assign.getRevision()==2) {
				detach.setPDC2(assign.getEndDate());
			}
			if(manager.merge(detach)!=null) {
				return 1;
			}
			return 0;
	 }
	
}
