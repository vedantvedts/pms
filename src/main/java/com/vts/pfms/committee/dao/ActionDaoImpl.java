package com.vts.pfms.committee.dao;

import java.math.BigInteger;
import java.sql.Date;
import java.util.ArrayList;
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
import com.vts.pfms.committee.model.FavouriteList;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.committee.model.RfaAction;
import com.vts.pfms.committee.model.RfaAssign;
import com.vts.pfms.committee.model.RfaAttachment;
import com.vts.pfms.committee.model.RfaTransaction;


@Transactional
@Repository
public class ActionDaoImpl implements ActionDao{
	
	private static final Logger logger=LogManager.getLogger(ActionDaoImpl.class);
	
	private static final String EMPLOYEELIST="select a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) as 'empname' ,b.designation FROM employee a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId AND LabCode=:LabCode ORDER BY a.srno=0,a.srno ";
	private static final String ASSIGNEDLIST="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(ab.title,' '),''), ab.empname) AS emp,dc.designation,a.actiondate,aas.enddate,a.actionitem,aas.actionstatus,aas.progress, aas.IsSeen , aas.actionassignid , (SELECT COUNT(am.actionmainid) FROM action_main am WHERE am.ParentActionid = a.actionmainid ) AS 'ChildActionCount' FROM action_main a,  employee ab ,employee_desig dc ,action_assign aas WHERE aas.actionmainid=a.actionmainid AND aas.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid  AND aas.actionstatus<>'C' AND aas.assigneelabcode <> '@EXP' AND aas.assignor=:empid UNION SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(ab.title,' '),''), ab.expertname) AS emp,'Expert' AS 'designation',a.actiondate,aas.enddate,a.actionitem,aas.actionstatus,aas.progress, aas.IsSeen , aas.actionassignid , (SELECT COUNT(am.actionmainid) FROM action_main am WHERE am.ParentActionid = a.actionmainid ) AS 'ChildActionCount' FROM action_main a,  expert ab , action_assign aas WHERE aas.actionmainid=a.actionmainid AND aas.assignee=ab.expertid AND ab.isactive='1' AND aas.actionstatus<>'C' AND aas.assigneelabcode = '@EXP' AND aas.assignor=:empid ORDER BY actionassignid DESC";
	//isseen column has been removed  04-08-2021
	//private static final String ASSIGNEDLIST="SELECT a.actionmainid,ab.empname,dc.designation,a.actiondate,a.enddate,a.actionitem,a.actionstatus,a.actionflag,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionmainid = a.actionmainid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionmainid = a.actionmainid) )  AS remarks,a.revision FROM action_main a,  employee ab ,employee_desig dc WHERE a.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND a.assignor=:empid and a.actionflag<>'Y'";
	private static final String ASSIGNEELIST="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'empname',c.designation,a.actiondate,d.enddate,a.actionitem,d.actionstatus,d.remarks,a.actionlinkid,d.actionno ,d.actionassignid ,d.assignee ,d.assignor , a.actionlevel ,a.projectid  FROM  action_main a, employee b ,employee_desig c , action_assign d WHERE a.actionmainid=d.actionmainid AND d.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND (d.assignee=:empid ) AND d.actionstatus IN ('I','A','B') AND d.assigneelabcode<>'@EXP' ORDER BY d.actionassignid DESC";
	private static final String ASSIGNEEDATA="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'assignor' ,c.designation,a.actiondate,e.enddate,a.actionitem,e.actionstatus,a.scheduleminutesid,a.actionlinkid,e.actionno,e.revision,CONCAT(IFNULL(CONCAT(d.title,' '),''), d.empname) AS 'assignee',a.actiontype,e.pdcorg,e.pdc1,e.pdc2 ,e.assignorlabcode,e.assigneelabcode , e.actionassignid , (SELECT COUNT(actionmainid) FROM  action_main WHERE (actionmainid=a.actionmainid OR parentActionid=a.actionmainid)) AS 'levelcount' , a.projectid , a.type,e.assignor AS actionassignor,e.Assignee AS 'AssigneeMain' FROM  action_main a, employee b ,employee_desig c ,employee d ,action_assign e WHERE e.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND  e.assignee=d.empid AND e.assigneelabcode <>'@EXP'  AND a.actionmainid=e.actionmainid AND e.actionassignid=:actionassignid UNION SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'assignor' ,c.designation,a.actiondate,e.enddate,a.actionitem,e.actionstatus,a.scheduleminutesid,a.actionlinkid,e.actionno,e.revision,CONCAT(IFNULL(CONCAT(d.title,' '),''), d.expertname) AS 'assignee',a.actiontype,e.pdcorg,e.pdc1,e.pdc2 ,e.assignorlabcode,e.assigneelabcode , e.actionassignid , (SELECT COUNT(actionmainid) FROM  action_main WHERE (actionmainid=a.actionmainid OR parentActionid=a.actionmainid)) AS 'levelcount' , a.projectid , a.type,e.assignor AS actionassignor,e.Assignee AS 'AssigneeMain' FROM  action_main a, employee b ,employee_desig c ,expert d ,action_assign e WHERE e.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND  e.assignee=d.expertid AND e.assigneelabcode = '@EXP'  AND a.actionmainid=e.actionmainid AND e.actionassignid=:actionassignid";
    private static final String SUBLIST="SELECT a.actionsubid,a.actionassignid,a.progress,a.progressdate,a.remarks,b.actionattachid,b.attachname FROM action_sub a LEFT JOIN action_attachment b ON (a.actionsubid=b.actionsubid) WHERE a.actionassignid=:assignid ORDER BY actionsubid ASC";
	private static final String SUBDELETE="delete from action_sub where actionsubid=:subid";
	private static final String MAINFORWARD="UPDATE action_assign SET  actionstatus=:actionstatus, ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE actionassignid=:assign"; //actionflag=:flag,
	private static final String FORWARDLIST="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(ab.title,' '),''), ab.empname) AS 'empname' ,dc.designation,a.actiondate,aas.enddate,a.actionitem,aas.actionstatus,aas.actionstatus as 'status' ,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS remarks,a.actionlinkid,aas.actionno, aas.actionassignid ,a.projectid FROM action_main a,  employee ab ,employee_desig dc , action_assign aas WHERE a.actionmainid=aas.actionmainid AND aas.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND aas.actionstatus IN ('F','A','B','I','C') AND aas.assignor=:empid AND aas.assigneelabcode <> '@EXP' UNION SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(ab.title,' '),''), ab.expertname) AS 'empname' ,'Expert' AS 'designation',a.actiondate,aas.enddate,a.actionitem,aas.actionstatus,aas.actionstatus as 'status',a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS remarks,a.actionlinkid,aas.actionno, aas.actionassignid ,a.projectid FROM action_main a,  expert ab , action_assign aas WHERE a.actionmainid=aas.actionmainid AND aas.assignee=ab.expertid AND ab.isactive='1'  AND aas.actionstatus IN ('F','A','B','I','C') AND aas.assignor=:empid AND aas.assigneelabcode = '@EXP'ORDER BY actionassignid DESC";
	private static final String ACTIONLIST ="SELECT DISTINCT(a.scheduleid), a.committeeid, a.committeemainid, b.committeename, a.scheduledate, a.schedulestarttime  FROM committee_schedule a, committee b, committee_schedules_minutes_details c,committee_main d ,committee_member cm WHERE a.committeeid=b.committeeid AND a.scheduledate<=CURDATE() AND a.scheduleid=c.scheduleid AND c.idarck IN('A','K','I','R')  AND a.committeemainid=d.committeemainid  AND d.isactive=1 AND a.isactive=1   AND d.committeemainid=cm.committeemainid AND cm.membertype IN ('CS','PS','CC','CH') AND cm.empid=:empid";
	private static final String COMMITTEEDATA="CALL Pfms_Action_List(:scheduleid)";
	private static final String COMMITTEESCHEDULEEDITDATA="SELECT a.committeeid,a.committeemainid,a.scheduledate,a.schedulestarttime,a.scheduleflag,a.schedulesub,a.scheduleid,b.committeename,b.committeeshortname,a.projectid FROM committee_schedule a,committee b WHERE scheduleid=:committeescheduleid AND a.committeeid=b.committeeid AND a.isactive=1 ";
	private static final String SCHEDULELIST="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'empname',c.designation,a.actiondate,d.enddate,a.actionitem,d.actionstatus,d.actionstatus as 'status' ,d.assigneelabcode,d.actionno FROM  action_main a, employee b ,employee_desig c ,action_assign d WHERE d.assigneelabcode <> '@EXP' AND a.actionmainid=d.actionmainid AND d.assignee=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND a.scheduleminutesid=:schid UNION SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.expertname) AS 'empname','Expert' AS 'designation',a.actiondate,d.enddate,a.actionitem,d.actionstatus,d.actionstatus as 'status' ,'Expert' as 'assigneelabcode',d.actionno FROM  action_main a, expert b ,action_assign d WHERE d.assigneelabcode = '@EXP' AND a.actionmainid=d.actionmainid AND d.assignee=b.expertid AND b.isactive='1' AND a.scheduleminutesid=:schid ";
    private static final String CONTENT="SELECT a.actionmainid,b.details,b.minutesid,b.minutessubid,b.minutessubofsubid,b.minutesunitid,b.idarck FROM action_main a, committee_schedules_minutes_details b WHERE a.scheduleminutesid=b.scheduleminutesid AND a.actionmainid=:aid";
    private static final String ACTIONSEARCH="SELECT a.actionmainid,aas.actionno,CONCAT(IFNULL(CONCAT(ab.title,' '),''), ab.empname) AS 'empname',dc.designation FROM action_main a,  employee ab ,employee_desig dc,action_assign  aas WHERE aas.actionmainid=a.actionmainid AND aas.assignor=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND aas.AssigneeLabCode <> '@EXP' AND aas.actionno LIKE :actionno union SELECT a.actionmainid,aas.actionno,CONCAT(IFNULL(CONCAT(ab.title,' '),''), ab.expertname) AS 'empname','Expert' AS 'designation' FROM action_main a,  expert ab ,action_assign  aas  WHERE aas.actionmainid=a.actionmainid AND aas.assignor=ab.expertid AND ab.isactive='1' AND aas.AssigneeLabCode = '@EXP' AND aas.actionno LIKE :actionno";
    private static final String STATUSLIST="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) as 'assignoremp',c.designation,a.actiondate,f.enddate,a.actionitem,f.actionstatus, CONCAT(IFNULL(CONCAT(d.title,' '),''), d.empname) AS 'assigneemp',e.designation AS desig,f.actionno,a.actionlinkid,(SELECT g.progress FROM action_sub g  WHERE g.actionassignid = f.actionassignid AND g.actionsubid = (SELECT MAX(s.actionsubid) FROM action_sub s WHERE s.actionassignid = f.actionassignid) )  AS progress , f.actionassignid  FROM  action_main a, employee b ,employee_desig c, employee d ,employee_desig e ,action_assign f WHERE a.actionmainid = f.actionmainid  AND f.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid AND f.assignee=d.empid AND d.isactive='1' AND d.desigid=e.desigid AND f.assignee=:empid AND a.actiondate BETWEEN :fdate AND :tdate AND f.AssigneeLabCode <> '@EXP' ORDER BY a.actionmainid DESC";
	private static final String LABDETAILS = "select * from lab_master"; 
    private static final String ACTIONGENCOUNT="SELECT COUNT(*) FROM action_main a , action_assign b WHERE a.actionmainid=b.actionmainid AND (CASE WHEN :projectid=0 THEN a.projectid=:projectid AND DATE_FORMAT(CURDATE(), \"%Y\")=DATE_FORMAT(a.actiondate, \"%Y\") ELSE a.projectid=:projectid END ) AND a.isactive='1' AND a.type=:type";
	private static final String ASSIGNEEDETAILS="SELECT assignor,assignee,actionno, assigneelabcode, assignorlabcode FROM action_assign WHERE actionassignid=:assignid";
	private static final String SCHEDULEITEM="SELECT a.scheduleminutesid,a.details FROM  committee_schedules_minutes_details a WHERE  a.scheduleminutesid=:schid";
    private static final String ACTIONSEARCHNO="CALL Pfms_ActionNo_Search(:empid,:no,:position)";
	private static final String PROJECTLIST="SELECT projectid,projectmainid,projectcode,projectname FROM project_master WHERE isactive=1";
    private static final String ACTIONCOUNT="CALL Pfms_Action_PD_Chart(:projectid)";
    private static final String LOGINPROJECTIDLIST="SELECT a.projectid,a.projectcode,a.projectname,a.ProjectMainId,a.ProjectDescription,a.UnitCode,a.ProjectType,a.ProjectCategory,a.SanctionNo,a.SanctionDate,a.PDC,a.ProjectDirector FROM project_master a,project_employee b WHERE a.isactive=1 and a.projectid=b.projectid and b.empid=:empid";
    private static final String ALLPROJECTDETAILSLIST ="SELECT a.projectid,a.projectcode,a.projectname,a.ProjectMainId,a.ProjectDescription,a.UnitCode,a.ProjectType,a.ProjectCategory,a.SanctionNo,a.SanctionDate,a.PDC,a.ProjectDirector FROM project_master a WHERE a.isactive=1 ";
	private static final String ACTIONWISE="CALL Pfms_Action_Wise_Reports(:term,:ProjectId)";
    private static final String ACTIONNOTIFIC="SELECT ab.empname AS emp,dc.designation AS desig,aas.assignee,b.empname,c.designation,aas.assignor,aas.revision,aas.actionno , a.type FROM action_main a,  employee ab ,employee_desig dc,employee b ,employee_desig c ,action_assign aas   WHERE   aas.assignor=b.empid  AND b.isactive='1' AND c.desigid=b.desigid AND aas.assignee=ab.empid  AND ab.isactive='1' AND aas.AssigneeLabCode <> '@EXP' AND dc.desigid=ab.desigid  AND aas.actionassignid=:actionassignid AND a.actionmainid=:mainid UNION SELECT ab.expertname AS emp,'Expert' AS desig,aas.assignee,b.empname,c.designation,aas.assignor,aas.revision,aas.actionno , a.type FROM action_main a, expert ab ,employee b ,employee_desig c ,action_assign aas   WHERE   aas.assignor=b.empid  AND b.isactive='1' AND c.desigid=b.desigid AND aas.assignee=ab.expertid  AND ab.isactive='1' AND aas.AssigneeLabCode = '@EXP'   AND aas.actionassignid=:actionassignid AND a.actionmainid=:mainid";
	private static final String ACTIONPDC="CALL Pfms_Action_PDC_Report(:empid,:ProjectId,:Position,:From,:To)";
    private static final String PROJECTCODE="SELECT projectcode FROM project_master WHERE   projectid=:ProjectId  AND isactive='1'";
	private static final String SELFASSIGNEDLIST="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(ab.title,' '),''), ab.empname) as 'empname' ,dc.designation,a.actiondate,aas.enddate,a.actionitem,aas.actionstatus,a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS remarks,aas.revision  FROM action_main a,  employee ab ,employee_desig dc , action_assign aas WHERE a.actionmainid=aas.actionmainid AND aas.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND aas.assignor=:empid AND aas.assignee=:empid AND aas.actionstatus<>'C'";
	private static final String SEARCHDATA="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) as 'empname',c.designation,a.actiondate,d.enddate,a.actionitem,d.actionstatus,d.actionstatus as 'status',a.scheduleminutesid,a.actionlinkid,d.actionno,d.revision FROM  action_main a, employee b ,employee_desig c , action_assign d WHERE a.actionmainid=d.actionmainid AND d.assignor=b.empid AND b.isactive='1' AND c.desigid=b.desigid  AND a.actionmainid=:mainid AND d.actionassignid=:assignid";
	private static final String ACTIONWISEALLREPORT="CALL Pfms_Action_Wise_All_Reports (:term,:empid,:projectid);";
	private static final String ACTIONALERT="CALL Pfms_Actions_Msg()";
	private static final String ACTIONTODAY="SELECT b.actionno,a.projectid FROM action_main a , action_assign b WHERE  b.enddate=CURDATE() AND a.actionmainid=b.actionmainid  AND b.actionstatus IN('A','B','F') AND (CASE WHEN 'AI'=:AI THEN a.Actiontype IN ('S','N') ELSE a.Actiontype IN ('A','B','C') END) AND  b.assignee=:empid AND b.AssigneeLabCode <> '@EXP'  ";
	private static final String ACTIONTOMMO="SELECT b.actionno,a.projectid FROM action_main a , action_assign b WHERE  b.enddate=CURDATE()+1 AND a.actionmainid=b.actionmainid  AND b.actionstatus IN('A','B','F') AND (CASE WHEN 'AI'=:AI THEN a.Actiontype IN ('S','N') ELSE a.Actiontype IN ('A','B','C') END) AND b.assignee=:empid AND b.AssigneeLabCode <> '@EXP' ";
	private static final String MEETINGALERT="CALL Pfms_Meeting_Msg()";
	private static final String MEETINGTODAY="CALL Pfms_Meeting_Msg_Today(:empid)";
	private static final String MEETINGTOMMO="CALL Pfms_Meeting_Msg_Tommo(:empid)";
	
	private static final String ACTIONSELFREMINDERLIST="SELECT ActionId,EmpId,ActionItem,ActionDate,ActionTime,ActionType FROM pfms_action_self WHERE isactive='1' AND actiondate BETWEEN :fromdate AND :todate AND empid=:empid AND labcode=(SELECT labcode FROM employee WHERE empid= :empid ) ORDER BY ActionDate DESC";
	private static final String ALLEMPNAMEDESIGLIST="SELECT e.empid ,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) as 'empname' , ed.designation FROM employee e, employee_desig ed WHERE e.desigid=ed.desigid";
	private static final String COMMITTEESHORTNAME="SELECT cs.committeeid, c.committeeshortname  FROM committee c,committee_schedule cs , committee_schedules_minutes_details cmd WHERE c.committeeid=cs.committeeid AND cs.scheduleid=cmd.scheduleid AND cmd.scheduleminutesid=:scheduleid AND cs.isactive=1 ";
	private static final String ASSIGNEESEENUPDATE="UPDATE action_assign SET isseen='1' WHERE assignee=:empid ";
	public static final String ACTIONSELFREMINDERDELETE="UPDATE pfms_action_self SET isactive=0 WHERE actionid=:actionid";
	private static final String PROJECTEMPLIST="SELECT a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) as 'empname' ,b.designation FROM employee a,employee_desig b,project_employee pe  WHERE a.isactive='1' AND a.DesigId=b.DesigId  AND pe.empid=a.empid AND pe.projectid=:projectid ORDER BY a.srno=0,a.srno";
	 
	 
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
//		query.setParameter("mainid", mainid);
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
	public ActionAssign getActionAssign(String actionassignId) throws Exception 
	{
		ActionAssign actionassign = manager.find(ActionAssign.class, Long.parseLong(actionassignId));
		return actionassign;
	}
	@Override
	public long AssignUpdate(ActionAssign assign) throws Exception 
	{
//		Query query=manager.createNativeQuery(ASSIGNUPDATE);
//		query.setParameter("assignid",assign.getActionAssignId());
//		query.setParameter("flag", assign.getActionFlag());
//		query.setParameter("status",assign.getActionStatus());
//		query.setParameter("modifiedby",assign.getModifiedBy());
//		query.setParameter("modifieddate",assign.getModifiedDate());
//		int result=query.executeUpdate();
		
		manager.merge(assign);
		manager.flush();
		return assign.getActionAssignId();
	}

	@Override
	public int MainForward(ActionAssign assign) throws Exception {
		
		Query query=manager.createNativeQuery(MAINFORWARD);
		query.setParameter("assign",assign.getActionAssignId());
		query.setParameter("actionstatus", assign.getActionStatus());
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
//     private static final String MAINSENDBACK="UPDATE action_assign SET remarks=:remarks,actionstatus=:status,actionflag=:flag,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE actionassignid=:assignid";

	@Override
	public long MainSendBack(ActionAssign assign) throws Exception {
		
//		Query query=manager.createNativeQuery(MAINSENDBACK);
//		query.setParameter("assignid",assign.getActionAssignId());
//		query.setParameter("remarks", assign.getRemarks());
//		query.setParameter("flag", assign.getActionFlag());
//		query.setParameter("status",assign.getActionStatus());
//		query.setParameter("modifiedby",assign.getModifiedBy());
//		query.setParameter("modifieddate",assign.getModifiedDate());
//		int result=query.executeUpdate();
		
		manager.merge(assign);
		
		return assign.getActionAssignId();
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
	public int ActionGenCount(String ProjectId, String type) throws Exception {
		
		Query query = manager.createNativeQuery(ACTIONGENCOUNT);
		query.setParameter("projectid",ProjectId );
		query.setParameter("type", type);
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
    private static final String ACTIONREPORT="CALL Pfms_Action_Reports(:empid,:term,:position,:type)";

	@Override
	public List<Object[]> ActionReports(String EmpId,String Term,String Position,String Type,String LabCode) throws Exception {
		
		Query query=manager.createNativeQuery(ACTIONREPORT);
		query.setParameter("empid",EmpId);
		query.setParameter("term",Term);
		query.setParameter("position",Position);
		query.setParameter("type",Type);
		//query.setParameter("LabCode",LabCode);
		
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
	private static final String GETREASSIGNEDDATA="SELECT  b.actionassignid,b.Actionmainid ,a.Actionitem , b.Actionno , a.actionlevel,a.projectid ,b.enddate,a.mainid ,a.actiontype ,a.ScheduleMinutesId FROM action_main a , action_assign b WHERE a.actionmainid=b.actionmainid AND b.actionassignid=:actionassignid";
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
		 	detach.setModifiedDate(assign.getModifiedDate());
		 	detach.setModifiedBy(assign.getModifiedBy());
		 	detach.setPDCOrg(assign.getPDCOrg());
		 	detach.setEndDate(assign.getEndDate());
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
	
	private static final String CLUSTEREXPERTSLIST ="SELECT e.expertid,CONCAT(IFNULL(CONCAT(e.title,' '),''),e.expertname) as 'expertname' ,e.expertno,'Expert' AS designation FROM expert e WHERE e.isactive=1 ";
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
	private static final String CLUSTERFILTEREMPLIST="SELECT e.expertid,CONCAT(IFNULL(CONCAT(e.title,' '),''),e.expertname) as 'expertname',e.expertno,'Expert' AS designation FROM expert e  WHERE e.isactive=1 AND e.expertid NOT IN (SELECT b.assignee FROM  action_main a, action_assign b WHERE a.actionmainid=b.actionmainid AND b.assigneelabcode=:labcode AND (a.mainid=:mainid OR a.actionmainid=:mainid))";
	
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
	
	private static final String LABEMPLOYEELIST="SELECT a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) as 'empname',a.empno,b.designation FROM employee a,employee_desig b WHERE a.isactive=1 AND a.desigid=b.desigid AND a.labcode=:labcode ;";
	@Override
	public List<Object[]> LabEmployeeList(String LabCode) throws Exception 
	{
		Query query=manager.createNativeQuery(LABEMPLOYEELIST);
		query.setParameter("labcode", LabCode);
		List<Object[]> ChairpersonEmployeeListFormation=(List<Object[]>)query.getResultList();
		return ChairpersonEmployeeListFormation;
	}
	private static final String LABEMPFILTERFORACTION="SELECT a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) as 'empname',a.empno,b.designation FROM employee a,employee_desig b WHERE a.isactive=1 AND a.desigid=b.desigid AND a.empid NOT IN (SELECT b.assignee FROM  action_main a, action_assign b WHERE a.actionmainid=b.actionmainid AND b.assigneelabcode=:labcode AND (a.mainid=:mainid OR a.actionmainid=:mainid)) AND a.labcode=:labcode";
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
	 
	 
	 private static final String ACTIONSUBLEVELSLIST="CALL pfms_action_level_list (:ActionAssignId ); ";
			 
	 @Override
	 public List<Object[]> ActionSubLevelsList(String ActionAssignId) throws Exception
	 {
		Query query=manager.createNativeQuery(ACTIONSUBLEVELSLIST);
		query.setParameter("ActionAssignId", ActionAssignId);
		List<Object[]> ActionSubLevelsList=(List<Object[]>)query.getResultList();
		return ActionSubLevelsList;
	 }
	 
	 private static final String ACTIONSUBLEVELSLISTFORCLOSE="CALL pfms_action_level_list (:ActionAssignId ); ";
	 
	 @Override
	 public List<Object[]> ActionSubLevelsListForClose(String ActionAssignId) throws Exception
	 {
		Query query=manager.createNativeQuery(ACTIONSUBLEVELSLISTFORCLOSE);
		query.setParameter("ActionAssignId", ActionAssignId);
		List<Object[]> ActionSubLevelsList=(List<Object[]>)query.getResultList();
		return ActionSubLevelsList;
	 }
	 private static final String ACTIONSUBLIST="SELECT a.actionsubid,a.actionassignid,a.progress,a.progressdate,a.remarks,b.actionattachid FROM action_sub a LEFT JOIN action_attachment b ON (a.actionsubid=b.actionsubid) WHERE a.actionassignid=:assignid ORDER BY actionsubid ASC";
	 
	 @Override
		public List<Object[]> ActionSubList(String assignid) throws Exception {
			Query query=manager.createNativeQuery(ACTIONSUBLIST);
			query.setParameter("assignid", assignid);
			List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
			return AssignedList;
		}
	
		private static final String ISSULIST ="SELECT  am.actionmainid, am.actionitem, am.projectid, aas.actionstatus,am.type,am.scheduleminutesId , aas.actionassignid , aas.actionno , (SELECT c.progress FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS progress ,aas.actionstatus as 'status' ,aas.assignee , aas.assignor FROM action_main am , action_assign aas WHERE aas.actionmainid=am.actionmainid AND am.type='I' AND aas.actionstatus<>'C' AND ((aas.assignee=:empid AND aas.AssigneeLabCode <> '@EXP' ) OR aas.assignor=:empid)";
		@Override
		public List<Object[]> GetIssueList(String empid )throws Exception
		{
			Query query = manager.createNativeQuery(ISSULIST);
			
			query.setParameter("empid", empid);
			return (List<Object[]>)query.getResultList();
		}
		private static final String GETRECOMENDATIONLIST="SELECT b.scheduleminutesid, a.scheduleid ,a.meetingid, b.details , b.remarks FROM committee_schedule a, committee_schedules_minutes_details b WHERE idarck='R' AND a.scheduleid = b.scheduleid AND (CASE WHEN 'A'=:projectid THEN 1=1 ELSE a.projectid=:projectid END)  AND (CASE WHEN 'A'=:committeid THEN 1=1 ELSE a.committeeid=:committeid END) ";
		@Override
		public List<Object[]> GetRecomendationList(String projectid ,  String committeid)throws Exception
		{
			Query query = manager.createNativeQuery(GETRECOMENDATIONLIST);
			query.setParameter("projectid", projectid);
			query.setParameter("committeid", committeid);
			return (List<Object[]>)query.getResultList();
		}
		
		private static final String GETDECISIONLIST="SELECT b.scheduleminutesid, a.scheduleid ,a.meetingid, b.details , b.remarks FROM committee_schedule a, committee_schedules_minutes_details b WHERE idarck='D' AND a.scheduleid = b.scheduleid AND (CASE WHEN 'A'=:projectid THEN 1=1 ELSE a.projectid=:projectid END)  AND (CASE WHEN 'A'=:committeid THEN 1=1 ELSE a.committeeid=:committeid END) ";
		@Override
		public List<Object[]> GetDecisionList(String projectid ,  String committeid)throws Exception
		{
			Query query = manager.createNativeQuery(GETDECISIONLIST);
			query.setParameter("projectid", projectid);
			query.setParameter("committeid", committeid);
			return (List<Object[]>)query.getResultList();
		}

	
	private static final String ACTIONASSIGNDATAAJAX="SELECT aas.ActionAssignId,am.actionitem,aas.ActionNo,am.actionmainid,aas.progress,am.actiondate, aas.enddate,aas.PDCOrg,CONCAT(IFNULL(asn.title,''), asn.empname) AS  'assignor name',CASE WHEN aas.assigneelabcode <> '@EXP' THEN (SELECT CONCAT(IFNULL(asi.title,''), asi.empname) FROM employee asi WHERE aas.assignee= asi.empid)  ELSE (SELECT CONCAT(IFNULL(asi.title,''), asi.expertname)  FROM expert asi WHERE aas.assignee= asi.expertid )END AS 'assignee name' ,am.type,aas.Assignor,aas.Assignee,aas.ActionStatus AS 'assignedstatus' FROM action_main am, action_Assign aas, employee asn WHERE am.actionmainid=aas.actionmainid  AND am.isactive=1 AND aas.isactive=1 AND  aas.assignor= asn.empid AND aas.actionassignid=:assignid";
	
	@Override
	public Object[] ActionAssignDataAjax(String assignid) throws Exception 
	{
		Query query=manager.createNativeQuery(ACTIONASSIGNDATAAJAX);
		query.setParameter("assignid", assignid);
		return (Object[])query.getResultList().get(0);	
	}
	private static final String GETDECISIONSOUGHT="SELECT DISTINCT (a.scheduleid) ,a.meetingid, a.pmrcdecisions , a.reference  FROM committee_schedule a, committee_schedules_minutes_details b WHERE idarck=:type AND a.scheduleid = b.scheduleid AND (CASE WHEN 'A'=:projectid THEN 1=1 ELSE a.projectid=:projectid END)  AND (CASE WHEN 'A'=:committeeid THEN 1=1 ELSE a.committeeid=:committeeid END)";
	@Override
	public List<Object[]> GetRecDecSoughtList(String projectid,String  committeeid , String type)throws Exception
	{
		Query query = manager.createNativeQuery(GETDECISIONSOUGHT);
		query.setParameter("projectid", projectid);
		query.setParameter("committeeid", committeeid);
		query.setParameter("type", type);
		return (List<Object[]>)query.getResultList();
	}
	
	private static final String RECDECSOUGHT="SELECT a.recdecid , a.point FROM  pfms_recdec_point a WHERE a.isactive=1 AND a.type=:type and a.scheduleid=:scheduleid ORDER BY a.recdecid DESC";
	@Override
	public List<Object[]> getActualDecOrRecSought(String scheduleid, String type)throws Exception
	{
		Query query = manager.createNativeQuery(RECDECSOUGHT);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("type", type);
		return (List<Object[]>)query.getResultList();
	}
	
	private static final String ACTUALDECISIONSOUGHT="SELECT a.details , a.scheduleid FROM committee_schedules_minutes_details a WHERE a.idarck=:type AND a.scheduleid=:scheduleid ORDER BY a.ScheduleMinutesId DESC";
	@Override
	public List<Object[]> getDecOrRecSought(String scheduleid , String type)throws Exception
	{
		Query query = manager.createNativeQuery(ACTUALDECISIONSOUGHT);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("type", type);
		return (List<Object[]>)query.getResultList();
	}

	private static final String ALLACTIONLIST="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'assignorempname',c.designation,a.actiondate,d.enddate,a.actionitem,d.actionstatus,d.actionstatus as 'status',d.remarks,d.actionno ,d.actionassignid ,d.assignee ,d.assignor ,a.actionlevel ,(SELECT c.progress FROM action_sub c  WHERE  c.actionassignid = d.actionassignid AND c.actionsubid =(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = d.actionassignid))  AS progress , d.pdcorg, CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'assigneeempname' , a.type FROM  action_main a, employee b ,employee_desig c , action_assign d , employee e WHERE a.actionmainid=d.actionmainid AND d.assignor=b.empid AND b.isactive='1' AND d.assignee=e.empid AND c.desigid=b.desigid AND (d.assignee=:empid OR d.assignor=:empid) AND d.actionstatus IN ('A','B','F') ORDER BY d.actionassignid DESC";
	@Override
	public List<Object[]> GetActionList(String empid)throws Exception
	{
		Query query = manager.createNativeQuery(ALLACTIONLIST);
		query.setParameter("empid", empid);
		return (List<Object[]>)query.getResultList();
	}
	
	private static final String ACTIONMONITORING="CALL Pfms_Action_Monitoring (:ProjectId ,:Status);";
	@Override
	public List<Object[]> ActionMonitoring(String ProjectId , String Status)throws Exception
	{
		Query query = manager.createNativeQuery(ACTIONMONITORING);
		query.setParameter("ProjectId", ProjectId);
		query.setParameter("Status", Status);
		return (List<Object[]>)query.getResultList();
	}
	private static final String GETACTIONFORFEVORITE="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'assignorempname',c.designation,a.actiondate,d.enddate,a.actionitem,d.actionstatus,d.actionstatus as 'status',d.remarks,d.actionno ,d.actionassignid ,d.assignee ,d.assignor ,a.actionlevel ,(SELECT c.progress FROM action_sub c  WHERE  c.actionassignid = d.actionassignid AND c.actionsubid =(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = d.actionassignid))  AS progress ,d.pdcorg, CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'assigneeempname' , a.type FROM  action_main a, employee b ,employee_desig c , action_assign d , employee e WHERE a.actionmainid=d.actionmainid AND d.assignor=b.empid AND b.isactive='1' AND d.assignee=e.empid AND c.desigid=b.desigid   AND d.actionstatus NOT IN ('C') AND d.actionassignid NOT IN (SELECT actionassignid FROM Pfms_Favourite_List WHERE empid=:empid) AND c.desigsr <=(SELECT ed.desigsr FROM employee e, employee_desig ed WHERE e.desigid=ed.desigid AND e.empid=:empid) AND a.projectid=:projectid AND a.actiondate BETWEEN :fromdate AND :todate ORDER BY d.actionassignid DESC";
	@Override
	public List<Object[]> GetActionListForFevorite(Date fromdate , Date todate , String projectid , String  empid)throws Exception
	{
		Query query = manager.createNativeQuery(GETACTIONFORFEVORITE);
		query.setParameter("fromdate", fromdate);
		query.setParameter("todate", todate);
		query.setParameter("projectid", projectid);
		query.setParameter("empid", empid);
		return (List<Object[]>)query.getResultList();
	}
	
	@Override
	public Long AddFavouriteList(FavouriteList fav) throws Exception
	{
		manager.persist(fav);
		manager.flush();
		return fav.getFavouriteId();
	}
	private static final String GETFAVOURITE="SELECT a.actionmainid,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'assignorempname',c.designation,a.actiondate,d.enddate,a.actionitem,d.actionno ,d.actionassignid ,d.assignee ,d.assignor ,a.actionlevel ,(SELECT c.progress FROM action_sub c  WHERE  c.actionassignid = d.actionassignid AND c.actionsubid =(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = d.actionassignid))  AS progress ,d.pdcorg, CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'assigneeempname' , a.type FROM  action_main a, employee b ,employee_desig c , action_assign d , employee e , Pfms_Favourite_List fl WHERE a.actionmainid=d.actionmainid AND d.assignor=b.empid AND b.isactive='1' AND d.assignee=e.empid AND fl.actionassignid = d.actionassignid AND c.desigid=b.desigid AND d.actionstatus NOT IN ('C') AND fl.empid=:empid order by fl.FavouriteId desc";
	@Override
	public List<Object[]> GetFavouriteList(String empid)throws Exception
	{
		Query query = manager.createNativeQuery(GETFAVOURITE);
		query.setParameter("empid", empid);
		return (List<Object[]>)query.getResultList();
	}
	private static final String PROJECTTYPELIST="select classificationid,classification from pfms_security_classification order by classification";
	@Override
	public List<Object[]> ProjectTypeList() throws Exception {	
		
		Query query=manager.createNativeQuery(PROJECTTYPELIST);
		List<Object[]> ProjectTypeList=(List<Object[]>)query.getResultList();		

		return ProjectTypeList;
	}
	
	
	private static final String RFAACTIONLIST="SELECT a.rfaid,a.labcode,d.projectcode,a.rfano,a.rfadate,b.priority,f.classification AS category, a.statement,a.description,a.reference,CONCAT (e.empname,',' ,c.designation)AS emp,a.createdby,a.createddate,a.projectid,a.rfastatus,a.AssignorId,(SELECT COUNT(Remarks) FROM pfms_rfa_action_transaction trans WHERE a.RfaId=trans.RfaId) AS Remarks,g.rfastatusdetails FROM pfms_rfa_action a, pfms_rfa_priority b, employee_desig c ,project_master d, employee e, pfms_security_classification f, pfms_rfa_status g WHERE a.priorityid=b.priorityid AND d.projectid=a.projectid AND CASE WHEN 'A'=:ProjectId THEN 1=1 ELSE a.projectid=:ProjectId END AND a.assigneeid=e.empid AND e.desigid=c.desigid AND d.projectcategory=f.classificationid AND a.assignorid=:EmpId AND a.rfastatus=g.rfastatus AND a.rfadate BETWEEN :fdate AND :tdate ORDER BY rfaid DESC";
	@Override
	public List<Object[]> GetRfaActionList(String fdate, String tdate, String ProjectId,String EmpId) throws Exception 
	{
		Query query = manager.createNativeQuery(RFAACTIONLIST);
		query.setParameter("fdate", fdate);
		query.setParameter("tdate", tdate);
		query.setParameter("ProjectId", ProjectId);
		query.setParameter("EmpId", EmpId);
		return (List<Object[]>)query.getResultList();
	}

	
	private static final String PRIORITYLIST="SELECT priorityid,priority FROM pfms_rfa_priority";
	@Override
	public List<Object[]> PriorityList() throws Exception 
	{
		Query query = manager.createNativeQuery(PRIORITYLIST);
		return (List<Object[]>)query.getResultList();
	}
	
	@Override
	public Long RfaActionSubmit(RfaAction rfa) throws Exception {
		logger.info( "Inside Service RfaActionSubmit");
		try {
		manager.persist(rfa);
		manager.flush();
		return rfa.getRfaId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error( "Inside Service RfaActionSubmit", e);
		return null;
	}
	}

	private static final String GETDIVISIONCODE="SELECT d.divisionid, d.divisioncode FROM division_master d WHERE d.divisionid=(SELECT divisionid FROM employee WHERE empid=:empid)";
	@Override
	public Object[] GetDivisionCode(String Division) throws Exception {
		
		Query query = manager.createNativeQuery(GETDIVISIONCODE);
		query.setParameter("empid", Division); // passing EmpId as Division  
		return (Object[])query.getSingleResult();
		
	}
    
	private static final String GETRFACOUNT="SELECT MAX(RfaId) FROM pfms_rfa_action WHERE IsActive=1";
	@Override
	public Long GetRfaCount() throws Exception {
		
		Query query = manager.createNativeQuery(GETRFACOUNT);
		Object Count = (Object)query.getSingleResult();
		Long RfaCount=0l ;
		if(Count==null) {
			RfaCount=0l;
		}else {
			RfaCount=Long.parseLong(Count.toString());
		}
		return RfaCount;
	}
	
	private static final String RFAEDITDATA="SELECT rfaid,labcode,projectid,rfano,rfadate,priorityid,statement,description,reference,assigneeid,rfastatus,createdby,createddate,modifiedby,modifieddate,isactive FROM pfms_rfa_action WHERE rfaid=:rfaid";
	@Override
	public Object[] RfaActionEdit(String rfaid) throws Exception {
		
		Query query = manager.createNativeQuery(RFAEDITDATA);
		query.setParameter("rfaid", rfaid);
		return (Object[])query.getSingleResult();
	}

	

	private static final String RFAEDITSUBMIT="UPDATE pfms_rfa_action SET rfadate=:rfadate,priorityid=:priority,statement=:statement,description=:description,reference=:reference,ModifiedBy=:modifiedby , ModifiedDate=:modidifeddate WHERE rfaid=:rfaid";
	@Override
	public Long RfaEditSubmit(RfaAction rfa) throws Exception {
		
		Query query = manager.createNativeQuery(RFAEDITSUBMIT);
			query.setParameter("rfadate", rfa.getRfaDate());
			query.setParameter("priority", rfa.getPriorityId());
			query.setParameter("statement", rfa.getStatement());
			query.setParameter("description", rfa.getDescription());
			query.setParameter("reference", rfa.getReference());
			query.setParameter("modifiedby", rfa.getModifiedBy());
			query.setParameter("modidifeddate", rfa.getModifiedDate());
			query.setParameter("rfaid", rfa.getRfaId());
		
		Long result = (long) query.executeUpdate();
		return result;
	}

	private static final String RFALABDETAILS="SELECT a.labid,a.labcode,a.labname,a.labaddress,a.labcity,a.labpin FROM lab_master a WHERE a.labcode=:labcode";
	@Override
	public Object[] RfaLabDetails(String LabCode) throws Exception {
       
		Query query = manager.createNativeQuery(RFALABDETAILS);
		query.setParameter("labcode", LabCode);
		return (Object[])query.getSingleResult();
	}
    
	private static final String RFAPRINT="CALL pfms_Rfa_Print(:rfaid)";
	@Override
	public Object[] RfaPrintData(String rfaid) throws Exception {
		
		Query query = manager.createNativeQuery(RFAPRINT);
		query.setParameter("rfaid", rfaid);
		return (Object[])query.getSingleResult();
	}
    
  //  private static final String RFAFORWARDLIST="CALL pfms_RfaForward_List(:EmpId)";
	private static final String RFAFORWARDLIST="CALL pfms_RfaForward_List_New(:EmpId)";
	@Override
	public List<Object[]> RfaForwardList(String EmpId) throws Exception {
		Query query = manager.createNativeQuery(RFAFORWARDLIST);
		query.setParameter("EmpId", EmpId);
		return (List<Object[]>)query.getResultList();
	}
	
//	private static final String RFAINSPECTIONAPPROVALLIST="CALL pfms_RfaInspectionForward_List(:EmpId)"; 
	private static final String RFAINSPECTIONAPPROVALLIST="CALL pfms_RfaInspectionForward_List_New(:EmpId)";
	@Override
	public List<Object[]> RfaInspectionApprovalList(String EmpId) throws Exception {
		Query query = manager.createNativeQuery(RFAINSPECTIONAPPROVALLIST);
		query.setParameter("EmpId", EmpId);
		return (List<Object[]>)query.getResultList();
	}
	
	
	//private static final String RFAINSPECTIONLIST="CALL pfms_RfaInspection_List(:EmpId)"; 
	private static final String RFAINSPECTIONLIST="CALL pfms_RfaInspection_List_New(:EmpId)"; 
	@Override
	public List<Object[]> RfaInspectionList(String EmpId) throws Exception {
		Query query = manager.createNativeQuery(RFAINSPECTIONLIST);
		query.setParameter("EmpId", EmpId);
		return (List<Object[]>)query.getResultList();
	}
	
	
	private static final String RFAFORWARDAPPROVALLIST="CALL pfms_RfaForwardApproved_List_New(:EmpId)"; 
	@Override
	public List<Object[]> RfaForwardApprovedList(String EmpId) throws Exception {
		Query query = manager.createNativeQuery(RFAFORWARDAPPROVALLIST);
		query.setParameter("EmpId", EmpId);
		return (List<Object[]>)query.getResultList();
	}
	
//	private static final String RFAINSPECTIONAPPROVEDLIST="CALL pfms_RfaInspectionApproved_List(:EmpId)"; 
	private static final String RFAINSPECTIONAPPROVEDLIST="CALL pfms_RfaInspectionApproved_List_New(:EmpId)"; 
	@Override
	public List<Object[]> RfaInspectionApprovedList(String EmpId) throws Exception {
		Query query = manager.createNativeQuery(RFAINSPECTIONAPPROVEDLIST);
		query.setParameter("EmpId", EmpId);
		return (List<Object[]>)query.getResultList();
	}
	
	
	private static final String EMPS="SELECT a.projectdirector FROM project_master a WHERE a.projectid=:projectid UNION SELECT a.divisionheadid FROM division_master a ,employee b WHERE a.divisionid=b.divisionid AND b.empno=:empno UNION SELECT c.groupheadid FROM division_master a ,employee b,division_group c WHERE a.divisionid=b.divisionid AND a.groupid=c.groupid AND b.empno=:empno";
	@Override
	public List<String> ListEmps(String UserId, String projectid) throws Exception {
		
		Query query =manager.createNativeQuery(EMPS);
		query.setParameter("empno", UserId);
		query.setParameter("projectid", projectid);
		
	 List<BigInteger>x=(List<BigInteger>)query.getResultList();
	 List<String>emps=new ArrayList<>();
	 
	 for(int i=0;i<x.size();i++) {
		 emps.add(x.get(i)+"");
	 }
	 
	 return emps;
	}
	
	private static final String UPDATESTATUS="UPDATE pfms_rfa_action SET rfastatus=:rfastatus WHERE rfaid=:rfa AND isactive=1 ";
	@Override
	public long RfaActionForward(List<PfmsNotification> x, RfaAction rf, RfaTransaction tr, String rfa)throws Exception {
	
		for(PfmsNotification notification:x) {
			manager.persist(notification);
		}
		manager.persist(tr);
		Query query = manager.createNativeQuery(UPDATESTATUS);
		query.setParameter("rfastatus", rf.getRfaStatus());
		query.setParameter("rfa", rfa);
		query.executeUpdate();
		return tr.getRfaTransactionId();
	}

	private static final String RFALIST="SELECT a.rfaid,a.labcode,a.rfano,a.rfadate,a.rfastatus,(SELECT CONCAT(e.empname,',' ,c.designation) FROM employee e, employee_desig c WHERE empid=:EmpId AND e.desigid=c.desigid)AS emp FROM pfms_rfa_action a WHERE rfaid=:rfa";
    @Override
	public Object[] RfaList(String rfa,String EmpId) throws Exception {
		Query query = manager.createNativeQuery(RFALIST);
		query.setParameter("rfa", rfa);
		query.setParameter("EmpId", EmpId);
		return (Object[])query.getSingleResult();
	}

    private static final String DHTDLIST="SELECT DISTINCT a.tdheadid FROM division_td a,division_group b,division_master c,employee e WHERE a.tdid=b.tdid AND b.groupid=c.groupid  AND e.DivisionId=c.DivisionId AND e.EmpId=:EmpId";
	@Override
	public BigInteger GetDhTdList(String EmpId) throws Exception {
		
		Query query = manager.createNativeQuery(DHTDLIST);
		query.setParameter("EmpId", EmpId);
		return (BigInteger)query.getSingleResult();
	}

	private static final String GHTDLIST="SELECT a.tdheadid FROM division_td a,division_group b WHERE a.tdid=b.tdid AND b.groupheadid=:EmpId";
	@Override
	public BigInteger GetGhTdList(String EmpId) throws Exception {
		
		Query query = manager.createNativeQuery(GHTDLIST);
		query.setParameter("EmpId", EmpId);
		return (BigInteger)query.getSingleResult();
	}
	
	private static final String GETUSERID="SELECT DISTINCT a.AssignorId  FROM pfms_rfa_action a,pfms_rfa_action_transaction b WHERE a.RfaId=b.RfaId  AND b.RfaId=:rfa";
	@Override
	public String getUserId(String rfa) throws Exception {
		Query query = manager.createNativeQuery(GETUSERID);
		query.setParameter("rfa", rfa);
		return query.getSingleResult().toString();
	}
	
	private static final String GETASSINEID="SELECT DISTINCT a.AssigneeId  FROM pfms_rfa_action a,pfms_rfa_action_transaction b WHERE a.RfaId=b.RfaId  AND b.RfaId=:rfa";
	@Override
	public String getAssineeId(String rfa) throws Exception {
		Query query = manager.createNativeQuery(GETASSINEID);
		query.setParameter("rfa", rfa);
		return query.getSingleResult().toString();
	}
	
	

	private static final String PDTDLIST="SELECT a.tdheadid FROM division_td a,division_group b,division_master c,project_master d,employee e WHERE d.projectdirector=e.empid AND e.divisionid=c.divisionid AND c.groupid=b.groupid AND b.tdid=a.tdid AND d.projectdirector=:EmpId";
	@Override
	public BigInteger GetPdTdList(String EmpId) throws Exception {
		
		Query query = manager.createNativeQuery(PDTDLIST);
		query.setParameter("EmpId", EmpId);
		return (BigInteger)query.getSingleResult();
	}
	
	
	private static final String RFAACTION="SELECT RfaAssignId,LabCode,RfaId,RfaNo,CompletionDate,Observation,Clarification,ActionRequired,EmpId,RfaStatus,CreatedBy,CreatedDate,ModifiedBy,ModifiedDate FROM pfms_rfa_assign WHERE rfaid=:rfa AND isactive=1";	
	@Override
	public Object[] getRfaAssign(String rfa) throws Exception {
		
		Query query = manager.createNativeQuery(RFAACTION);
		query.setParameter("rfa", rfa);
		Object[] assign=null;
		try {
			assign=(Object[])query.getSingleResult();
			}catch(Exception e) {
				
			}
		
		return assign;
	}
	
	@Override
	public Long RfaModalSubmit(RfaAssign assign) throws Exception {
		
		manager.persist(assign);
		
		return assign.getRfaAssignId();
	}
	
	
	private static final String RFAASSIGNDATA="SELECT rfaassignid,labcode,rfaid,rfano,completiondate,observation,clarification,actionrequired,(SELECT AssigneeAttachment FROM pfms_rfa_attachment WHERE rfaid=:rfaid AND isactive='1')AS 'Assigneeattach'  FROM pfms_rfa_assign WHERE rfaid=:rfaid AND isactive=1";
	@Override
	public Object[] RfaAssignAjax(String rfaId) throws Exception {
		
		Query query = manager.createNativeQuery(RFAASSIGNDATA);
		query.setParameter("rfaid", rfaId);
		
		Object[] RfaAssignAjax=null;
		try {
			RfaAssignAjax=(Object[])query.getSingleResult();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return RfaAssignAjax;
	}
	
	private static final String ASSIGNUPDATE="UPDATE pfms_rfa_assign SET completiondate=:fdate , observation=:observation , clarification=:clarification , actionrequired=:Rfaaction,ModifiedBy=:ModifiedBy ,ModifiedDate=:ModifiedDate WHERE rfaid=:rfaid";
	@Override
	public Long RfaModalUpdate(RfaAssign assign) throws Exception {
		
		
		Query query = manager.createNativeQuery(ASSIGNUPDATE);
		query.setParameter("rfaid", assign.getRfaId());
		query.setParameter("fdate", assign.getCompletionDate());
		query.setParameter("observation", assign.getObservation());
		query.setParameter("clarification", assign.getClarification());
		query.setParameter("Rfaaction", assign.getActionRequired());
		query.setParameter("ModifiedBy", assign.getModifiedBy());
		query.setParameter("ModifiedDate", assign.getModifiedDate());
		
		
		return Long.valueOf(query.executeUpdate());
	}

	private final static String RFARETURNLIST="UPDATE pfms_rfa_action SET rfastatus=:rfastatus WHERE rfaid=:rfa AND isactive=1 ";

	@Override
	public Long RfaReturnList(List<PfmsNotification> x, RfaAction rf, RfaTransaction tr, String rfa) throws Exception {
		for(PfmsNotification notification:x) {
			manager.persist(notification);
		}
		manager.persist(tr);
		Query query = manager.createNativeQuery(UPDATESTATUS);
		query.setParameter("rfastatus", rf.getRfaStatus());
		query.setParameter("rfa", rfa);
		query.executeUpdate();
		return tr.getRfaTransactionId();
	}
	private static final String GETASSIGNRFAID =  "SELECT COUNT(RfaId) FROM pfms_rfa_assign WHERE RfaId=:rfaId AND EmpId=:empId AND IsActive='1'";

	@Override
	public String getAssignDetails(String empId, Long rfaId) throws Exception {
		logger.info( "Inside DAO getAssignDetails");
		
		try {
		Query query=manager.createNativeQuery(GETASSIGNRFAID);
		
		query.setParameter("empId", empId);
		query.setParameter("rfaId", rfaId);
		Object executeUpdate = query.getSingleResult();
		return  executeUpdate.toString();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Inside DaoImpl getAssignDetails", e);
			return "0";
		}
	}
	private static final String GETRFAADDDATA = "SELECT pm.ProjectCode,CONCAT('(',pp.PriorityId,')',pp.Priority) AS priority,pa.RfaDate,CONCAT (e.empname,',' ,c.designation)AS emp,pa.Statement,pa.Description,pa.Reference FROM pfms_rfa_action pa,pfms_rfa_priority pp,employee e,project_master pm,employee_desig c WHERE pa.RfaId=:rfaId AND pa.IsActive='1' AND pa.PriorityId=pp.PriorityId AND pa.AssigneeId=e.EmpId AND e.desigid=c.desigid AND pm.ProjectId=pa.ProjectId;";

	@Override
	public Object[] getRfaAddData(String rfaId) throws Exception {
		logger.info( "Inside DAO getRfaAddData");
		try {
		Query query=manager.createNativeQuery(GETRFAADDDATA);
		
		query.setParameter("rfaId", rfaId);
		Object[] executeUpdate = (Object[])query.getSingleResult();
		return executeUpdate ;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Inside DaoImpl getRfaAddData", e);
			return null;
		}
	}
	
	private static final String GETRFAINSPECTIONDATA = "SELECT RfaNo,CompletionDate,Observation,Clarification,ActionRequired FROM pfms_rfa_assign WHERE RfaId=:rfaId";

	@Override
	public Object[] getRfaInspectionData(String rfaId) throws Exception {
		logger.info( "Inside DAO getRfaAddData");
		try {
		Query query=manager.createNativeQuery(GETRFAINSPECTIONDATA);
		
		query.setParameter("rfaId", rfaId);
		Object[] executeUpdate = (Object[])query.getSingleResult();
		return executeUpdate ;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Inside DaoImpl getRfaAddData", e);
			return null;
		}
	}
	
	
	private static final String GETRFAREMARKS = "SELECT CONCAT (e.empname,',' ,c.designation) AS emp,t.Remarks,t.ActionDate FROM pfms_rfa_action_transaction t,employee e,employee_desig c WHERE t.RfaId=:rfaId AND CASE WHEN 'user'=:status THEN t.RfaStatus IN ('RC','RV') WHEN 'assigner'=:status THEN t.RfaStatus IN ('RR','RP') END  AND t.EmpId=e.EmpId AND e.desigid=c.desigid";

	
	@Override
	public List<Object[]> getrfaRemarks(String rfaId,String status) throws Exception {
		Query query=manager.createNativeQuery(GETRFAREMARKS);
		query.setParameter("rfaId", rfaId);
		query.setParameter("status", status);
		List<Object[]> remarksList=(List<Object[]>)query.getResultList();	
		return remarksList;
	}
	private static final String GETASSINEEID = "SELECT AssigneeId FROM pfms_rfa_action WHERE RfaId=:rfa";
	@Override
	public String getAssineId(String rfa) throws Exception {
	logger.info( "Inside DAO getAssineId");
		
		try {
		Query query=manager.createNativeQuery(GETASSINEEID);
		
		query.setParameter("rfa", rfa);
		Object executeUpdate = query.getSingleResult();
		return  executeUpdate.toString();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Inside DaoImpl getAssineId", e);
			return "0";
		}
	}

	public static final String PROJECTAPPLICABLECOMMITTEELIST="SELECT  b.committeeid,a.projectid, a.autoschedule,b.committeeshortname,b.committeename,b.projectapplicable FROM committee_project a,committee b WHERE a.committeeid=b.committeeid AND b.projectapplicable='P' AND a.projectid=:projectid";
	@Override
	public List<Object[]> ProjectApplicableCommitteeList(String projectid)throws Exception
	{
		Query query=manager.createNativeQuery(PROJECTAPPLICABLECOMMITTEELIST);
		query.setParameter("projectid", projectid);
		return (List<Object[]>)query.getResultList();
	}

	public static final String MEETTINGCOUNT="SELECT a.scheduleid,a.meetingid,a.scheduledate,b.committeeshortname,b.committeeid FROM committee_schedule a, committee b WHERE a.committeeid=:committeeid AND a.committeeid=b.committeeid AND a.scheduleflag IN('MKV','MMR','MMF','MMS','MMA') AND a.projectid=:projectid AND a.isactive=1";
	@Override
	public List<Object[]> MeettingCount(String committeeid, String projectid) throws Exception {
		
		Query query = manager.createNativeQuery(MEETTINGCOUNT);
		query.setParameter("committeeid", committeeid);
		query.setParameter("projectid", projectid);
		return (List<Object[]>)query.getResultList();
	}

	public static final String MEETINGLIST="CALL Pfms_Meeting_Action_Reports(:projectid,:committeeid,:scheduleid)";
	@Override
	public List<Object[]> MeettingList(String committeeid, String projectid, String scheduleid) throws Exception {
		Query query = manager.createNativeQuery(MEETINGLIST);
		query.setParameter("committeeid", committeeid);
		query.setParameter("projectid", projectid);
		query.setParameter("scheduleid", scheduleid);
		return (List<Object[]>)query.getResultList();
	}
	
	public static final String MEETINGACTIONLIST="CALL Pfms_Meeting_AllAction_List(:projectid,:committeeid,:scheduleid,:empId)";
	@Override
	public List<Object[]> MeettingActionList(String committeeid, String projectid, String scheduleid, String empId)
			throws Exception {
		Query query = manager.createNativeQuery(MEETINGACTIONLIST);
		query.setParameter("committeeid", committeeid);
		query.setParameter("projectid", projectid);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("empId", empId);
		return (List<Object[]>)query.getResultList();
	}
	
	@Override// newlyadded
	public List<Object[]> getAllEmployees(String flag) throws Exception {
		String allGh="SELECT DISTINCT a.groupheadid,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'employee',b.designation FROM division_group a, employee e, employee_desig b WHERE a.groupheadid=e.empid AND e.isactive='1' AND b.desigid=e.desigid";
		String allDh="SELECT DISTINCT a.divisionheadid,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'employee',b.designation FROM division_master a, employee e, employee_desig b WHERE a.divisionheadid=e.empid AND e.isactive='1' AND b.desigid=e.desigid";
		String allTd="SELECT DISTINCT a.tdheadid,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'employee',b.designation FROM division_td a, employee e, employee_desig b WHERE a.tdheadid=e.empid AND e.isactive='1' AND b.desigid=e.desigid";
		String allPd="SELECT DISTINCT a.ProjectDirector,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'employee',b.designation FROM project_master a, employee e, employee_desig b WHERE a.ProjectDirector=e.empid AND e.isactive='1' AND b.desigid=e.desigid";
		if(flag.equalsIgnoreCase("T")) {
			Query query=manager.createNativeQuery(allTd);
			return (List<Object[]>)query.getResultList();
		}else if(flag.equalsIgnoreCase("D")) {
			Query query=manager.createNativeQuery(allDh);
			return (List<Object[]>)query.getResultList();
		}else if(flag.equalsIgnoreCase("G")) {
			Query query=manager.createNativeQuery(allGh);
			return (List<Object[]>)query.getResultList();
		}else if(flag.equalsIgnoreCase("p"))  {
			Query query=manager.createNativeQuery(allPd);
			return (List<Object[]>)query.getResultList();
		}else {
			List<Object[]>allEmployees=new ArrayList<>();
			return allEmployees;
		}
		
	
	}

	
	public static final String RFAMODALEMPLIST="CALL pfms_Rfa_ModalEmplist()";
	@Override
	public List<Object[]> getRfaModalEmpList() throws Exception {
		Query query = manager.createNativeQuery(RFAMODALEMPLIST);
		return (List<Object[]>)query.getResultList();
	}

	
	public static final String RFATDLIST="SELECT DISTINCT a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname' ,b.designation,a.srNo FROM employee a,employee_desig b,division_td c WHERE a.isactive='1' AND a.DesigId=b.DesigId AND c.tdheadid=a.empid ORDER BY srno";
	@Override
	public List<Object[]> getRfaTDList() throws Exception {
		Query query = manager.createNativeQuery(RFATDLIST);
		return (List<Object[]>)query.getResultList();
	}

	public static final String RFATRANSACTIONLIST="SELECT a.rfatransactionid,c.rfano,e.empid,e.empname,d.designation,a.actiondate,a.remarks,b.rfastatusdetails,b.rfastatuscolor FROM pfms_rfa_action_transaction a,pfms_rfa_status b,pfms_rfa_action c,employee_desig d,employee e WHERE c.rfaid=a.rfaid AND a.rfastatus=b.rfastatus AND a.actionby=e.empid AND e.desigid = d.desigid AND c.rfaid=:rfaTransId ORDER BY a.actiondate ";
	@Override
	public List<Object[]> getRfaTransList(String rfaTransId) throws Exception {
		try {
			Query query = manager.createNativeQuery(RFATRANSACTIONLIST);
			query.setParameter("rfaTransId", rfaTransId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public Long RfaAttachment(RfaAttachment rfaAttach)throws Exception{
		
		logger.info( "Inside Service RfaAttachment");
		try {
		manager.persist(rfaAttach);
		manager.flush();
		return rfaAttach.getRfaAttachmentId();
	} catch (Exception e) {
		e.printStackTrace();
		logger.error( "Inside Service RfaAttachment", e);
		return null;
	}
		
	}

	public static final String RFAATTACHMENTDOWNLOAD="SELECT rfaattachmentid,rfaid,filespath,assignorattachment,assigneeattachment FROM pfms_rfa_attachment WHERE rfaid=:rfaid AND isactive=1";
	@Override
	public Object[] RfaAttachmentDownload(String rfaid) throws Exception {
		try {
			Query query = manager.createNativeQuery(RFAATTACHMENTDOWNLOAD);
			query.setParameter("rfaid", rfaid);
			return (Object[])query.getSingleResult();
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	
	public static final String DELETERFAATTACH="UPDATE pfms_rfa_attachment SET isactive='0' WHERE rfaid=:rfaid";
	@Override
	public int deleterfaAttachment(Long rfaId) throws Exception {
		
		Query query=manager.createNativeQuery(DELETERFAATTACH);
		query.setParameter("rfaid", rfaId);
		return query.executeUpdate();
	}
	
	public static final String UPDATERFAATTACH="UPDATE pfms_rfa_attachment SET AssigneeAttachment=:AssigneeAttachment,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate  WHERE rfaid=:rfaid AND isactive='1'";
	@Override
	public long updateRfaAttachment(RfaAttachment rfaAttach) {
	
		Query query=manager.createNativeQuery(UPDATERFAATTACH);
		query.setParameter("rfaid", rfaAttach.getRfaId());
		query.setParameter("AssigneeAttachment", rfaAttach.getAssigneeAttachment());
		query.setParameter("modifiedby", rfaAttach.getModifiedBy());
		query.setParameter("modifieddate", rfaAttach.getModifiedDate());
		return query.executeUpdate();
	}
	
}
