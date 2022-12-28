package com.vts.pfms.committee.dao;


import java.math.BigInteger;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.committee.dto.CommitteeConstitutionApprovalDto;
import com.vts.pfms.committee.dto.CommitteeScheduleDto;
import com.vts.pfms.committee.model.Committee;
import com.vts.pfms.committee.model.CommitteeConstitutionApproval;
import com.vts.pfms.committee.model.CommitteeConstitutionHistory;
import com.vts.pfms.committee.model.CommitteeDefaultAgenda;
import com.vts.pfms.committee.model.CommitteeDivision;
import com.vts.pfms.committee.model.CommitteeInitiation;
import com.vts.pfms.committee.model.CommitteeInvitation;
import com.vts.pfms.committee.model.CommitteeMain;
import com.vts.pfms.committee.model.CommitteeMeetingApproval;
import com.vts.pfms.committee.model.CommitteeMeetingDPFMFrozen;
import com.vts.pfms.committee.model.CommitteeMember;
import com.vts.pfms.committee.model.CommitteeMemberRep;
import com.vts.pfms.committee.model.CommitteeMinutesAttachment;
import com.vts.pfms.committee.model.CommitteeProject;
import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.committee.model.CommitteeScheduleAgenda;
import com.vts.pfms.committee.model.CommitteeScheduleAgendaDocs;
import com.vts.pfms.committee.model.CommitteeScheduleMinutesDetails;
import com.vts.pfms.committee.model.CommitteeSubSchedule;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.print.model.MinutesActionList;
import com.vts.pfms.print.model.MinutesFinanceList;
import com.vts.pfms.print.model.MinutesLastPmrc;
import com.vts.pfms.print.model.MinutesMileActivity;
import com.vts.pfms.print.model.MinutesProcurementList;
import com.vts.pfms.print.model.MinutesSubMile;

@Transactional
@Repository
public class CommitteeDaoImpl  implements CommitteeDao
{
	private static final Logger logger=LogManager.getLogger(CommitteeDaoImpl.class);
	
	private static final String EMPLOYEELIST="select a.empid, CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) as 'Emp',b.designation,a.empno FROM employee a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId AND labcode=:labcode ORDER BY a.srno=0,a.srno";
	private static final String LASTCOMMITTEEID="SELECT committeemainid FROM committee_main WHERE isactive=1 and committeeid=:committeeid AND projectid=:projectid and divisionid=:divisionid AND InitiationId=:initiationid ";
	private static final String UPDATECOMMITTEEVALIDTO="UPDATE committee_main SET isactive=0,Status='E',validto=:validto ,modifiedby=:modifiedby, modifieddate=:modifieddate WHERE committeemainid=:lastcommitteeid";
	private static final String COMMITTEENAME="SELECT committeeid,committeename,committeeshortname,projectapplicable,periodicduration,isglobal FROM committee WHERE  committeeid=:committeeid";
	private static final String COMMITTEENAMESCHECK="SELECT SUM(IF(CommitteeShortName =:committeeshortname,1,0))   AS 'shortname',SUM(IF(CommitteeName = :committeename,1,0)) AS 'name'FROM committee where isactive=1 AND labcode=:labcode ";
	private static final String COMMITTEELISTALL="SELECT committeeid,committeeshortname,committeename,CommitteeType,projectapplicable,isactive FROM committee";
	private static final String COMMITTEELISTACTIVE="SELECT committeeid,committeeshortname,committeename,CommitteeType,projectapplicable,isactive,periodicnon,periodicduration,TechNonTech,Guidelines,Description,TermsOfReference,isglobal FROM committee WHERE isactive=1 AND isglobal=:isglobal AND projectapplicable=:projectapplicable  AND labcode=:labcode ;";
	private static final String COMMITTEEDETAILS="SELECT committeeid,committeeshortname,committeename,CommitteeType,projectapplicable,technontech,guidelines,periodicnon,periodicduration,isactive,Description,TermsOfReference,isglobal,labcode FROM committee WHERE isactive=1 AND (CASE WHEN 'A'=:committeeid THEN committeeid=committeeid ELSE committeeid=:committeeid END)";
	private static final String COMMITTEEEDITSUBMIT="UPDATE committee SET CommitteeShortName=:committeeshortname ,  CommitteeName=:committeename , CommitteeType=:committeetype , ProjectApplicable=:projectapplicable ,ModifiedBy=:modifiedby , ModifiedDate=:modifieddate,PeriodicDuration=:periodicduration,TechNonTech=:technontech,Guidelines=:guidelines,PeriodicNon=:periodicnon,Description=:description,TermsOfReference=:termsofreference,isglobal=:isglobal WHERE committeeid=:committeeid";
	private static final String COMMITTEEMAINLIST="SELECT a.committeemainid, a.committeeid,a.validfrom,a.validto, b.committeename,b.committeeshortname FROM committee_main a, committee b WHERE b.projectapplicable='N' AND a.isactive='1' AND a.committeeid=b.committeeid  AND a.divisionid=0 AND a.projectid=0 AND a.initiationid=0 AND TRIM(b.labcode)=:labcode" ;
	private static final String COMMITTEEMEMBERDELETE ="UPDATE committee_member SET isactive=0, ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE committeememberid=:committeememberid";
	private static final String COMMITTEESCHEDULELIST="SELECT cs.scheduleid, cs.committeeid,cs.committeemainid,cs.scheduledate,cs.schedulestarttime,cs.projectid , c.committeeshortname FROM committee_schedule cs,committee c WHERE cs.committeeid=c.committeeid AND  cs.divisionid=0 AND cs.committeeid=:committeeid AND cs.projectid=0 AND cs.divisionid=0 AND cs.initiationid=0 AND cs.isactive=1 ";
	private static final String COMMITTEESCHEDULEEDITDATA="SELECT a.committeeid,a.committeemainid,a.scheduledate,a.schedulestarttime,a.scheduleflag,a.schedulesub,a.scheduleid,b.committeename,b.committeeshortname,a.projectid,c.meetingstatusid,a.meetingid,a.meetingvenue,a.confidential,a.Reference,d.category ,a.divisionid  ,a.initiationid ,a.pmrcdecisions,a.kickoffotp ,(SELECT minutesattachmentid FROM committee_minutes_attachment WHERE scheduleid=a.scheduleid) AS 'attachid', b.periodicNon,a.MinutesFrozen,a.briefingpaperfrozen,a.labcode FROM committee_schedule a,committee b ,committee_meeting_status c, pfms_security_classification d WHERE a.scheduleflag=c.MeetingStatus AND a.scheduleid=:committeescheduleid AND a.committeeid=b.committeeid AND a.confidential=d.categoryid";
	private static final String PROJECTLIST="SELECT projectid,projectmainid,projectcode,projectname FROM project_master WHERE isactive=1 and labcode=:labcode";
	private static final String AGENDALIST = "SELECT a.scheduleagendaid,a.scheduleid,a.schedulesubid,a.agendaitem,b.projectname,b.projectid,a.remarks,b.projectcode,a.agendapriority,a.presenterid ,CONCAT(IFNULL(CONCAT(j.title,' '),''), j.empname) as 'empname' ,h.designation,a.duration,j.desigid, a.PresentorLabCode  FROM project_master b,employee j,employee_desig h,committee_schedules_agenda a  WHERE a.projectid=b.projectid AND a.scheduleid=:committeescheduleid AND a.isactive=1 AND a.projectid<>0 AND a.presenterid=j.empid AND j.desigid=h.desigid  UNION   SELECT a.scheduleagendaid,a.scheduleid,a.schedulesubid,a.agendaitem,cs.labcode AS 'projectname' , '0' AS projectid,a.remarks,'' AS projectcode,a.agendapriority,a.presenterid ,CONCAT(IFNULL(CONCAT(j.title,' '),''), j.empname) as 'empname' ,h.designation,a.duration,j.desigid, a.PresentorLabCode  FROM employee j,employee_desig h, committee_schedules_agenda a, committee_schedule cs   WHERE a.scheduleid=:committeescheduleid AND a.scheduleid=cs.scheduleid  AND a.isactive=1 AND a.projectid=0 AND a.presenterid=j.empid AND j.desigid=h.desigid ORDER BY 9   ";
	private static final String COMMITTEESCHEDULEUPDATE="UPDATE committee_schedule SET scheduledate=:scheduledate,schedulestarttime=:schedulestarttime,modifiedby=:modifiedby,modifieddate=:modifieddate, meetingid=:meetingid WHERE scheduleid=:scheduleid";
	private static final String COMMITTEESPECLIST="SELECT a.minutesid,a.scheduleminutesid,a.schedulesubid,a.minutessubid,a.minutessubofsubid,a.details,a.scheduleid,a.idarck,b.outcomename, a.agendasubhead FROM committee_schedules_minutes_details a,committee_schedules_minutes_outcome b WHERE a.idarck=b.idarck and a.scheduleid=:scheduleid ORDER BY scheduleminutesid;";
	private static final String COMMITTEEMINUTESPEC="SELECT a.minutesid,a.description,b.agendasubid,b.subdescription,c.agendaitem FROM committee_schedules_minutes a, committee_schedules_minutes_sub b,committee_schedules_agenda c WHERE minutesid=:minutesid AND agendasubid=:agendasubid AND scheduleagendaid=:scheduleagendaid  ";
	private static final String COMMITTEEMINUTEEDIT="SELECT a.minutesid,a.details,a.scheduleid,a.scheduleminutesid,b.description,a.minutessubofsubid,a.minutessubid,c.subdescription,d.agendaitem,a.remarks,a.idarck FROM committee_schedules_minutes_details a, committee_schedules_minutes b, committee_schedules_minutes_sub c,committee_schedules_agenda d WHERE a.minutesid=b.minutesid AND a.minutessubofsubid=c.agendasubid AND a.scheduleminutesid=:scheduleminutesid AND a.minutessubid=d.scheduleagendaid ";
	private static final String COMMITTEEMINUTEUPDATE="UPDATE committee_schedules_minutes_details SET scheduleid=:scheduleid,schedulesubid=:schedulesubid,minutesid=:minutesid,details=:details,idarck=:darc,modifiedby=:modifiedby,modifieddate=:modifieddate,remarks=:remarks WHERE scheduleminutesid=:scheduleminutesid";
	private static final String COMMITTEESCHEDULEAGENDAPRIORITY="SELECT ScheduleAgendaId, ScheduleId,AgendaPriority FROM committee_schedules_agenda WHERE ScheduleId=:scheduleid ORDER BY AgendaPriority DESC";
	private static final String COMMITTEESCHEDULEAGENDAUPDATE="UPDATE committee_schedules_agenda SET PresentorLabCode=:PresentorLabCode, duration=:duration, AgendaItem=:agendaitem, ProjectId=:projectid, Remarks=:remarks, ModifiedBy=:modifiedby, ModifiedDate=:modifieddate, PresenterId=:PresenterId  WHERE ScheduleAgendaId=:scheduleagendaid";
	private static final String COMMITTEEAGENDAPRIORITYUPDATE ="UPDATE committee_schedules_agenda SET AgendaPriority=:agendapriority WHERE ScheduleAgendaId=:agendaid";
	private static final String COMMITTEESCHEDULEGETAGENDASAFTER ="SELECT ScheduleAgendaId,AgendaPriority FROM committee_schedules_agenda WHERE ScheduleId=:scheduleid AND AgendaPriority>:AgendaPriority ORDER BY AgendaPriority ASC";
	private static final String COMMITTEEAGENDADELETE="UPDATE committee_schedules_agenda SET ModifiedBy=:modifiedby, ModifiedDate=:modifieddate, isactive=0,AgendaPriority=0 WHERE ScheduleAgendaId=:agendaid";
	private static final String COMMITTEESUBSCHEDULELIST="SELECT ScheduleSubId,ScheduleId,ScheduleDate,ScheduleStartTime,ScheduleFlag,IsActive FROM committee_schedule_sub WHERE ScheduleId=:scheduleid"; 
	private static final String COMMITTEEMINUTESSUB="SELECT * FROM  committee_schedules_minutes_sub WHERE  AgendaSubId >1";
	private static final String COMMITTEEMINUTESSPECDETAILS="SELECT * FROM committee_schedules_minutes";
	private static final String COMMITTEEATTENDANCE="SELECT a.empid,a.committeeinvitationid,a.committeescheduleid,a.membertype,a.attendance,b.empno,b.empname,c.designation FROM committee_schedules_invitation a,employee b,employee_desig c WHERE a.empid = b.empid AND b.desigid=c.desigid AND a.committeescheduleid =:scheduleid AND a.membertype IN ('C','I' ) UNION SELECT a.empid,a.committeeinvitationid,a.committeescheduleid,a.membertype,a.attendance,b.expertno,b.expertname,c.designation FROM committee_schedules_invitation a,expert b,employee_desig c WHERE a.empid = b.expertid AND b.desigid=c.desigid AND a.committeescheduleid =:scheduleid AND a.membertype = 'E' ORDER BY 4";
	private static final String COMMITTEEAPPROVAL="UPDATE committee_schedule SET scheduleflag=:flag, modifiedby=:modifiedby, modifieddate=:modifieddate WHERE scheduleid=:scheduleid";
	private static final String COMMITTEESCHEDULEDATA = "SELECT a.ScheduleId, a.CommitteeMainId, a.ScheduleDate, a.ScheduleStartTime, a.ScheduleFlag, a.ScheduleSub, a.IsActive, a.committeeid ,b.committeeshortname, b.committeename, c.MeetingStatusId,a.projectid,a.meetingid, a.divisionid ,a.initiationid,a.labcode FROM committee_schedule a,committee b,committee_meeting_status c WHERE a.committeeid=b.committeeid AND a.scheduleflag=c.MeetingStatus AND a.ScheduleId=:committeescheduleid";
	private static final String ATTENDANCEUPDATEP="UPDATE committee_schedules_invitation SET Attendance=:attendance WHERE CommitteeInvitationId=:invitationid";
	private static final String ATTENDANCEUPDATEN="UPDATE committee_schedules_invitation SET Attendance=:attendance WHERE CommitteeInvitationId=:invitationid";
	private static final String COMMITTEEATTENDANCETYPE="SELECT attendance from committee_schedules_invitation WHERE CommitteeInvitationId=:invitationid";
	private static final String COMMITTEEINVITATIONDELETE ="DELETE FROM committee_schedules_invitation WHERE CommitteeInvitationId = :committeeinvitationid";
	private static final String EXPERTLIST="SELECT a.expertid,a.expertname,b.designation FROM expert a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId";
	private static final String MINUTESUNITLIST="SELECT a.unitname,a.minutesspecunitid,b.minutesid,b.minutessubid,b.minutessubofsubid FROM committee_schedules_minutes_unit a,committee_schedules_minutes_details b WHERE a.minutesspecunitid= b.minutesunitid AND b.scheduleid=:committeescheduleid AND b.statusflag='I'";	
	private static final String COMMITTEEAGENDAPRESENTER="SELECT a.presenterid ,b.empname, c.designation FROM committee_schedules_agenda a, employee b, employee_desig c WHERE a.presenterid=b.empid AND b.desigid=c.desigid AND a.scheduleid=:scheduleid GROUP BY 1";
	private static final String CHAIRPERSONEMAIL="SELECT email, empid FROM employee WHERE empid IN (SELECT empid FROM committee_member WHERE membertype IN ('CC','CS','PS','CH') AND committeemainid=:committeemainid AND labcode IN (SELECT LabCode FROM lab_master))  UNION SELECT email, empid FROM employee_external WHERE empid IN (SELECT empid FROM committee_member WHERE membertype IN ('CC','CS','PS','CH') AND committeemainid=:committeemainid AND labcode NOT IN (SELECT labcode FROM lab_master)) UNION SELECT email, empid FROM employee WHERE empid IN (SELECT pm.projectdirector FROM project_master pm, committee_main cm WHERE cm.projectid=pm.projectid AND cm.committeemainid=:committeemainid ) ";
	private static final String PROJECTDIRECTOREMAIL="SELECT d.email,d.empname FROM employee d,project_master e WHERE projectid=:projectid AND e.projectdirector=d.empid";
	private static final String RTMDDOEMAIL="SELECT a.email,a.empname FROM employee a,pfms_rtmddo b WHERE a.empid=b.empid AND b.isactive=1 AND b.type='DO-RTMD' ";
	private static final String UPDATEOTP="UPDATE committee_schedule SET kickoffotp=:otp,scheduleflag=:scheduleflag WHERE scheduleid=:committeescheduleid";
	private static final String KICKOFFOTP="SELECT kickoffotp FROM committee_schedule WHERE scheduleid=:scheduleid";
	private static final String PROJECTDETAILS="SELECT projectid, projectname, projectdescription,projectmainid,projectcode,projecttype,projectimmscd, unitcode, sanctionno,PDC,projectcategory FROM project_master WHERE projectid=:projectid";
	private static final String PROJECTSCHEDULELISTALL ="SELECT cs.scheduleid, cs.committeeid,cs.committeemainid,cs.scheduledate,cs.schedulestarttime,cs.projectid , c.committeeshortname FROM committee_schedule cs,committee c WHERE cs.committeeid=c.committeeid AND cs.isactive=1 AND cs.projectid=:projectid ";
	private static final String PROJECTAPPLICABLECOMMITTEELIST="SELECT  b.committeeid,a.projectid, a.autoschedule,b.committeeshortname,b.committeename,b.projectapplicable FROM committee_project a,committee b WHERE a.committeeid=b.committeeid AND b.projectapplicable='P' AND a.projectid=:projectid";
	private static final String UPDATECOMITTEEMAINID = "UPDATE committee_schedule SET committeemainid=:committeemainid WHERE scheduleid=:scheduleid";
	private static final String PROJECTCOMMITTEESCHEDULELISTALL ="SELECT cs.scheduleid, cs.committeeid,cs.committeemainid,cs.scheduledate,cs.schedulestarttime,cs.projectid , c.committeeshortname FROM committee_schedule cs,committee c WHERE cs.committeeid=c.committeeid AND cs.projectid=:projectid AND cs.CommitteeId=:committeeid AND cs.isactive=1 ";
	private static final String AGENDARETURNDATA="SELECT remarks,empid,meetingstatus FROM committee_meeting_approval WHERE meetingstatus IN ('MAR','MMR') AND scheduleid=:scheduleid ";
	private static final String LABDETAILS = "SELECT LabMasterId, LabCode, LabName, LabUnitCode, LabAddress, LabCity, LabPin, LabTelNo, LabFaxNo, LabEmail, LabAuthority, LabAuthorityId, LabRfpEmail, LabId, ClusterId, LabLogo FROM lab_master WHERE labcode=:labcode ;";
	private static final String COMMITTEESCHEDULEDATAPRO = "SELECT a.ScheduleId, a.CommitteeMainId, a.ScheduleDate, a.ScheduleStartTime, a.ScheduleFlag, a.ScheduleSub, a.IsActive, a.committeeid ,b.committeeshortname, b.committeename, c.MeetingStatusId FROM committee_schedule a,committee b,committee_meeting_status c WHERE a.committeeid=b.committeeid AND a.scheduleflag=c.MeetingStatus AND a.ScheduleId=:committeescheduleid AND a.projectid=:projectid ";
	private static final String PROJECTMASTERLIST="SELECT b.committeename,b.committeeshortname,b.committeeid,a.committeeprojectid,b.periodicnon,b.periodicduration,a.autoschedule  FROM committee_project a,committee b WHERE a.committeeid=b.committeeid AND a.projectid=:projectid";
	private static final String COMMITTEEPROJECTDELETE="DELETE FROM committee_project WHERE committeeprojectid=:committeeprojectid";
	private static final String COMMITTEENONPROJECTLIST="SELECT committeeid,CommitteeShortName,CommitteeName,CommitteeType,ProjectApplicable,TechNonTech,Guidelines,PeriodicNon,PeriodicDuration,Description,TermsOfReference FROM committee  WHERE projectapplicable='N' AND isactive='1'";
	private static final String COMMITTEEAUTOSCHEDULELIST="SELECT a.scheduledate,a.schedulestarttime,b.committeename,b.committeeshortname,a.scheduleid,a.scheduleflag,c.statusdetail,c.meetingstatusid FROM committee_schedule a,committee b,committee_meeting_status c WHERE a.committeeid=b.committeeid AND a.projectid=:projectid AND a.divisionid=:divisionid AND a.initiationid=:initiationid AND a.scheduleflag=c.meetingstatus AND a.isactive=1 AND (CASE WHEN 'B'=:projectstatus THEN c.meetingstatusid >= 6 WHEN 'C'=:projectstatus THEN c.meetingstatusid<=5 ELSE 1=1 END)   ORDER BY a.scheduledate DESC";
	private static final String COMMITTEEPROJECTUPDATE="UPDATE committee_project SET autoschedule='Y' WHERE projectid=:projectid AND committeeid=:committeeid";
	private static final String COMMITTEEAUTOSCHEDULELIST1="SELECT a.scheduledate,a.schedulestarttime,b.committeename,b.committeeshortname,a.scheduleid,a.scheduleflag,c.statusdetail,c.meetingstatusid FROM committee_schedule a,committee b,committee_meeting_status c WHERE a.committeeid=b.committeeid AND a.projectid=:projectid AND (CASE WHEN 'A'=:committeeid THEN a.committeeid=b.committeeid ELSE a.committeeid=:committeeid END) AND a.divisionid=:divisionid AND a.initiationid=:initiationid AND a.scheduleflag=c.meetingstatus AND a.isactive=1 AND (CASE WHEN 'B'=:projectstatus THEN c.meetingstatusid >= 6 WHEN 'C'=:projectstatus THEN c.meetingstatusid<=5 ELSE 1=1 END)  ORDER BY a.scheduledate DESC ";
	private static final String COMMITTEMAINMEMBERSDATA="SELECT cm.empid,cm.committeemainid, c.committeeshortname FROM committee_member cm,committee c, committee_main cma, committee_schedule cs, employee e WHERE cm.membertype =:membertype AND cs.committeemainid=cma.committeemainid AND cma.committeeid=c.committeeid AND cma.committeemainid=cm.committeemainid AND cs.scheduleid=:scheduleid AND cm.empid=e.empid AND cm.labcode IN (SELECT labcode FROM lab_master)";
	private static final String NOTIFICATIONDATA="SELECT a.empid, a.notificationby FROM pfms_notification a WHERE scheduleid=:scheduleid AND empid=:empid AND a.status=:status";	
	private static final String MEETINGCOUNT="SELECT COUNT(*) FROM committee_schedule WHERE YEAR(scheduledate)= :scheduledate AND projectid=:projectid AND isactive=1 ";
	private static final String MEETINGCOUNT1="SELECT COUNT(*) FROM committee_schedule WHERE projectid=:projectid AND isactive=1 ";
	private static final String UPDATEMEETINGVENUE="UPDATE committee_schedule SET  meetingvenue=:meetingvenue ,confidential=:confidential, Reference=:reference, PMRCDecisions=:pmrcdecisions WHERE scheduleid=:scheduleid";
	private static final String MINUTESATTACHMENTDELETE="DELETE FROM committee_minutes_attachment WHERE MinutesAttachmentId=:attachid";
	private static final String MINUTESATTACHMENTLIST="SELECT MinutesAttachmentId,ScheduleId,AttachmentName FROM committee_minutes_attachment WHERE ScheduleId=:scheduleid";
	private static final String PROJECTCATEGORYLIST="select categoryid,category from pfms_security_classification";
	private static final String COMMITTEEALLATTENDANCE="SELECT a.empid,a.committeeinvitationid,a.committeescheduleid,a.membertype,a.attendance,b.empno,b.empname,c.designation,b.email,'organization' FROM committee_schedules_invitation a,employee b,employee_desig c WHERE a.empid = b.empid AND b.desigid=c.desigid AND a.committeescheduleid =:scheduleid AND a.membertype IN ('CC','CS','C','I' ) UNION SELECT a.empid,a.committeeinvitationid,a.committeescheduleid,a.membertype,a.attendance,b.expertno,b.expertname,c.designation,b.email,b.organization FROM committee_schedules_invitation a,expert b,employee_desig c WHERE a.empid = b.expertid AND b.desigid=c.desigid AND a.committeescheduleid =:scheduleid AND a.membertype = 'E' ORDER BY FIELD(4,'CC','CS','C','I' ,'E')ASC";
	private static final String MEETINGREPORTTOTAL="SELECT a.meetingid,a.scheduledate,a.schedulestarttime,a.projectid,b.committeename,a.meetingvenue,a.scheduleid FROM committee_schedule a,committee b WHERE a.scheduledate BETWEEN :fdate AND :tdate AND (CASE WHEN 'A'=:ProjectId THEN 1=1 ELSE a.projectid=:ProjectId END) AND a.committeeid=b.committeeid AND a.isactive=1 ";
	private static final String PROJECTCOMMITTEESLISTNOTADDED="SELECT a.committeeid,a.committeeshortname,a.committeename,a.CommitteeType,a.projectapplicable,a.isactive,a.periodicnon,a.periodicduration,a.TechNonTech,a.Guidelines,a.Description,a.TermsOfReference FROM committee a WHERE a.projectapplicable='P' AND isglobal IN (0,:projectid)  AND a.committeeid NOT IN ( SELECT b.CommitteeId FROM committee_project b WHERE b.projectId = :projectid) AND a.labcode=:LabCode  ORDER BY a.committeeid,a.committeeshortname";
	private static final String PROJECTCOMMITTEESLIST="SELECT committeeid,committeeshortname,committeename,CommitteeType,projectapplicable,isactive,periodicnon,periodicduration,TechNonTech,Guidelines,Description,TermsOfReference FROM committee WHERE projectapplicable='P' AND LabCode=:LabCode AND isactive=1";
	private static final String MINUTESVIEWALLACTIONLIST="CALL Pfms_Meeting_Action_List(:scheduleid)";
	private static final String MEETINGSEARCHLIST="SELECT '0' committeemainid, 0 AS empid,a.scheduleid,a.scheduledate,a.schedulestarttime,a.scheduleflag,'NA' AS membertype ,a.meetingid,b.committeename,b.committeeshortname, a.meetingvenue FROM committee_schedule a,committee b WHERE a.committeeid=b.committeeid AND a.meetingid LIKE :meetingid AND a.isactive=1 and a.labcode=:labcode";
	private static final String CLUSTERLABLIST="SELECT labid,clusterid,labname,labcode FROM cluster_lab";
	private static final String EXTERNALMEMBERSNOTADDEDCOMMITTEE="SELECT a.expertid,a.expertname,b.designation  FROM expert a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId AND a.expertid NOT IN (SELECT  empid FROM committee_member  WHERE isactive=1 AND labcode='@EXP' AND committeemainid=:committeemainid);";
	private static final String EXTERNALEMPLOYEELISTFORMATION="SELECT a.empid, a.empname,a.empno,b.designation FROM employee_external a,employee_desig b WHERE a.labid>0 AND a.labid=:labid AND a.desigid=b.desigid AND a.empid NOT IN (SELECT  empid FROM committee_member   WHERE isactive=1  AND labid=:labid AND committeemainid=:committeemainid)   ";
	private static final String EXTERNALEMPLOYEELISTINVITATIONS =" SELECT a.empid, a.empname,a.empno,b.designation, a.desigid  FROM employee a,employee_desig b   WHERE labcode=:labcode AND a.desigid=b.desigid AND a.empid NOT IN (SELECT empid  FROM committee_schedules_invitation WHERE  committeescheduleid=:scheduleid AND labcode=:labcode)  ";
	private static final String EMPLOYEELISTNOINVITEDMEMBERS="SELECT a.empid, CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) as 'empname' ,b.designation,a.desigid FROM employee a,employee_desig b WHERE a.isactive='1' AND a.LabCode = :LabCode AND a.DesigId=b.DesigId AND a.empid NOT IN ( SELECT c.empid FROM committee_schedules_invitation c WHERE c.committeescheduleid=:scheduleid AND c.labcode=:LabCode ) ORDER BY a.srno=0,a.srno";
	private static final String EXPERTLISTNOINVITEDMEMBERS = "SELECT a.expertid,CONCAT(IFNULL(CONCAT(a.title,' '),''),a.expertname) as 'expertname'  ,b.designation,a.desigid FROM expert a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId AND a.expertid NOT IN( SELECT empid FROM committee_schedules_invitation WHERE committeescheduleid=:scheduleid AND labcode='@EXP'  ) ORDER BY a.expertname ";
	private static final String ALLPROJECTDETAILSLIST ="SELECT a.projectid,a.projectcode,a.projectname,a.ProjectMainId,a.ProjectDescription,a.UnitCode,a.ProjectType,a.ProjectCategory,a.SanctionNo,a.SanctionDate,a.PDC,a.ProjectDirector FROM project_master a WHERE a.isactive=1 ";
	private static final String PROJECTCOMMITTEEDESCRIPTIONTOR="SELECT committeeprojectid,description , termsofreference, committeeid , projectid  FROM committee_project WHERE committeeid=:committeeid AND projectid=:projectid";
	private static final String PROJECTCOMMITTEEDESCRIPTIONTOREDIT="UPDATE committee_project SET description=:description  , termsofreference = :termsofreference ,modifiedby= :modifiedby ,modifieddate=:modifieddate WHERE committeeprojectid=:committeeprojectid";
	private static final String PROJECTCOMMITTEEFORMATIONCHECKLIST="SELECT a.committeeprojectid,b.committeemainid FROM committee_project a LEFT JOIN committee_main b ON a.projectid = b.projectid AND a.committeeid = b.committeeid AND b.isactive=1 WHERE a.projectid = :projectid";
	private static final String UPDATECOMMITTEEINVITATIONEMAILSENT="UPDATE committee_schedules_invitation SET emailsent ='Y' WHERE membertype NOT IN ('CW','W','E','CO') AND committeescheduleid=:committeescheduleid";
	private static final String UPDATEUNIT="UPDATE committee_schedules_minutes_unit SET unitname=:unitname,createdby=:createdby,createddate=:createddate WHERE minutesspecunitid=:unitid";
	private static final String DIVISIONCOMMITTEEDESCRIPTIONTOR="SELECT committeedivisionid,description , termsofreference, committeeid , divisionid  FROM committee_division WHERE committeeid=:committeeid AND divisionid=:divisionid";
	private static final String DIVISIONCOMMITTEEDESCRIPTIONTOREDIT="UPDATE committee_division SET description=:description  , termsofreference = :termsofreference ,modifiedby= :modifiedby ,modifieddate=:modifieddate WHERE committeedivisionid=:committeedivisionid";
	private static final String DIVISIONLIST = "SELECT divisionid, divisioncode,divisionname,divisionheadid,groupid FROM division_master";
	private static final String COMMITTEEDIVISIONASSIGNED = "SELECT b.committeename,b.committeeshortname,b.committeeid,a.committeedivisionid,b.periodicnon,b.periodicduration,a.autoschedule  FROM committee_division a,committee b WHERE a.committeeid=b.committeeid AND a.divisionid=:divisionid";
	private static final String COMMITTEEDIVISIONNOTASSIGNED = "SELECT a.committeeid,a.committeeshortname,a.committeename,a.CommitteeType,a.projectapplicable,a.isactive,a.periodicnon,a.periodicduration,a.TechNonTech,a.Guidelines,a.Description,a.TermsOfReference  FROM committee a WHERE a.projectapplicable='N' AND a.committeeid NOT IN ( SELECT b.CommitteeId FROM committee_division b WHERE b.divisionid = :divisionid ) AND a.labcode=:LabCode  ORDER BY a.committeeid,a.committeeshortname ";
	private static final String DIVISIONCOMMITTEEFORMATIONCHECKLIST = "SELECT a.committeedivisionid,b.committeemainid FROM committee_division a LEFT JOIN  committee_main b ON a.Divisionid = b.Divisionid AND b.divisionid>0 AND a.committeeid = b.committeeid AND b.isactive=1 WHERE a.Divisionid =:divisionid";
	private static final String DIVISIONCOMMITTEEDELETE="DELETE FROM committee_division WHERE committeedivisionid=:committeedivisionid";
	private static final String COMMITTEEACTIONDATA="CALL Pfms_Action_List(:scheduleid)";
	private static final String OUTCOMELIST="select idarck,outcomename from committee_schedules_minutes_outcome";
	private static final String INVITATIONMAXSERIALNO ="SELECT 'MaxSlNo', MAX(serialno) FROM committee_schedules_invitation WHERE committeescheduleid=:scheduleid ";
	private static final String LOGINDIVISIONLIST ="CALL Pfms_Emp_DivisiontList(:empid);";
	private static final String COMMITTEEINVITATIONSERIALNOAFTER="SELECT committeeInvitationid, serialno FROM committee_schedules_invitation WHERE serialno> (SELECT serialno FROM committee_schedules_invitation WHERE committeeInvitationid=:committeeinvitationid ) AND committeescheduleid=(SELECT committeescheduleid FROM committee_schedules_invitation WHERE committeeInvitationid=:committeeinvitationid )  ";
	private static final String COMMITTEEINVITATIONSERIALNOUPDATE="UPDATE committee_schedules_invitation  SET serialno=:serialno WHERE committeeInvitationid=:committeeinvitationid";
	private static final String COMMITTEELASTSCHEDULEDATE="SELECT MAX(scheduledate),scheduleid FROM committee_schedule WHERE committeeid=:committeeid AND isactive=1";
	private static final String INTERNALEMPLOYEELISTFORMATION = "SELECT a.empid, a.empname,a.empno,b.designation FROM employee a,employee_desig b WHERE a.desigid=b.desigid AND labcode=:labcode AND a.empid NOT IN (SELECT  empid FROM committee_member   WHERE isactive=1  AND labcode=:labcode AND committeemainid=:committeemainid)  ORDER BY a.srno=0,a.srno ";
	private static final String DIVISIONDATA = "SELECT divisionid, divisioncode,divisionname,divisionheadid,groupid FROM division_master WHERE divisionid=:divisionid";
	private static final String DIVISIONCOMMITTEEMAINLIST ="SELECT  b.committeeid,a.Divisionid, a.autoschedule,b.committeeshortname,b.committeename FROM committee_Division a,committee b WHERE a.committeeid=b.committeeid AND b.projectapplicable='N' AND a.Divisionid = :divisionid";
	private static final String DIVISIONCOMMITTEESCHEDULELIST = "SELECT cs.scheduleid, cs.committeeid,cs.committeemainid,cs.scheduledate,cs.schedulestarttime,cs.projectid , c.committeeshortname FROM committee_schedule cs,committee c WHERE cs.committeeid=c.committeeid AND  cs.divisionid=:divisionid AND cs.CommitteeId=:committeeid AND cs.isactive=1 ";
	private static final String INITIATIONMASTERLIST="SELECT b.committeename,b.committeeshortname,b.committeeid,a.CommitteeInitiationId,b.periodicnon,b.periodicduration,a.autoschedule  FROM committee_initiation a,committee b WHERE a.committeeid=b.committeeid AND a.initiationid=:initiationid";
	private static final String INITIATIONCOMMITTEEFORMATIONCHECKLIST="SELECT a.CommitteeInitiationId,b.committeemainid FROM committee_initiation a LEFT JOIN committee_main b ON a.initiationid = b.initiationid AND a.committeeid = b.committeeid AND b.isactive=1 WHERE a.initiationid =:initiationid";
	private static final String INITIATIONCOMMITTEESLISTNOTADDED="SELECT a.committeeid,a.committeeshortname,a.committeename,a.CommitteeType,a.projectapplicable,a.isactive,a.periodicnon,a.periodicduration,a.TechNonTech,a.Guidelines,a.Description,a.TermsOfReference FROM committee a WHERE a.projectapplicable='P'  AND isglobal=0 AND a.committeeid NOT IN ( SELECT b.CommitteeId FROM committee_initiation b WHERE b.initiationid = :initiationid) AND a.labcode=:LabCode  ORDER BY a.committeeid,a.committeeshortname";
	private static final String INVITATIONSERIALNOUPDATE="UPDATE committee_schedules_invitation SET SerialNo=:newslno  WHERE CommitteeInvitationId=:invitationid";
	private static final String INITIATEDPROJECTDETAILSLIST="SELECT a.initiationid, a.projecttitle, a.divisionid, a.categoryid, a.projectshortname, a.projecttypeid FROM pfms_initiation a";
	private static final String COMMITTEEDIVISIONUPDATE="UPDATE committee_division SET autoschedule='Y' WHERE divisionid=:divisionid AND committeeid=:committeeid";
	private static final String DIVCOMMITTEEAUTOSCHEDULELIST="SELECT a.scheduledate,a.schedulestarttime,b.committeename,b.committeeshortname,a.scheduleid  FROM committee_schedule a,committee b  WHERE a.committeeid=b.committeeid AND a.divisionid=:divisionid AND a.isactive=1 ORDER BY a.scheduledate ";
	private static final String DIVISIONMASTERLIST="SELECT b.committeename,b.committeeshortname,b.committeeid,a.committeedivisionid,b.periodicnon,b.periodicduration,a.autoschedule FROM committee_division a,committee b  WHERE a.committeeid=b.committeeid AND a.divisionid=:divisionid";
	private static final String DIVISIONSCHEDULELISTALL = "SELECT cs.scheduleid, cs.committeeid,cs.committeemainid,cs.scheduledate,cs.schedulestarttime,cs.projectid , c.committeeshortname FROM committee_schedule cs,committee c WHERE cs.committeeid=c.committeeid AND cs.initiationid=0 AND cs.projectid=0 AND cs.divisionid=:divisionid AND cs.isactive=1 ";
	private static final String CHAIRPERSONEMPLOYEELISTFORMATION="SELECT a.empid, CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) as 'emp' ,a.empno,b.designation FROM employee a,employee_desig b WHERE a.isactive=1 AND a.desigid=b.desigid AND a.labcode=:labcode AND a.empid NOT IN (SELECT  empid FROM committee_member WHERE isactive=1  AND labcode IN (SELECT labcode FROM lab_master) AND committeemainid=:committeemainid AND membertype NOT IN ('CC','CS','PS','CH'))  ";
//	private static final String CHAIRPERSONEXTERNALEMPLOYEELIST = "SELECT a.empid, a.empname,a.empno,b.designation FROM employee_external a,employee_desig b WHERE a.isactive=1 AND a.labid=:labid AND a.desigid=b.desigid AND a.empid NOT IN (SELECT  empid FROM committee_member  WHERE isactive=1  AND labid=:labid AND committeemainid=:committeemainid AND membertype NOT IN ('CC','CS','PS','CH'))  ";
	private static final String COMMITTEEMEMBERREPDELETE ="DELETE FROM committee_member_rep WHERE memberrepid=:memberrepid";
	private static final String COMMITTEEREPNOTADDEDLIST="SELECT repid, repcode , repname FROM committee_rep WHERE repid NOT IN (SELECT repid FROM committee_member_rep WHERE committeemainid=:committeemainid)"; 
	private static final String COMMITTEEMEMBERREPLIST="SELECT cmr.memberrepid,cmr.repid, cr.repcode, cr.repname FROM committee_rep cr, committee_member_rep cmr WHERE cmr.repid=cr.repid AND cmr.committeemainid=:committeemainid"; 
	private static final String COMMITTREPLIST="SELECT repid, repcode , repname FROM committee_rep"; 
	private static final String EMPLOYEELISTWITHOUTMEMBERS="SELECT a.empid,a.empname,b.designation FROM employee a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId AND a.empid NOT IN (SELECT empid FROM committee_member WHERE labcode=(SELECT labcode FROM lab_master WHERE labcode=:labcode) AND committeemainid=:committeemainid AND isactive=1) AND labcode=:labcode ORDER BY a.srno=0,a.srno;";
	private static final String COMMITTEEMEMBERUPDATE="UPDATE committee_member SET labcode=:labcode,empid=:empid,modifiedby=:modifiedby,modifieddate=:modifieddate WHERE committeememberid=:committeememberid";
	private static final String COMMITTEMAINDATA ="SELECT cm.committeemainid, cm.committeeid,cm.projectid, cm.divisionid,cm.initiationid, cm.validfrom, cm.validto, cm.isactive,c.committeeshortname,cm.status, c.labcode FROM committee_main cm, committee c WHERE  cm.committeeid=c.committeeid AND committeemainid=:committeemainid ";
	private static final  String INITIATIONCOMMITTEEDELETE= "DELETE FROM committee_initiation WHERE CommitteeInitiationId=:committeeinitiationid";
	private static final String INITIATIONDETAILS ="SELECT InitiationId,ProjectShortName,ProjectTitle FROM pfms_initiation WHERE InitiationId=:initiationid";
	private static final String INITIATIONCOMMITTEEDESCRIPTIONTOR ="SELECT CommitteeInitiationId,description , termsofreference, committeeid , InitiationId FROM committee_initiation WHERE committeeid=:committeeid AND InitiationId=:initiationid";
	private static final String  INITIATIONCOMMITTEEDESCRIPTIONTOREDIT ="UPDATE committee_initiation SET description=:description  , termsofreference = :termsofreference ,modifiedby= :modifiedby ,modifieddate=:modifieddate WHERE CommitteeInitiationId=:committeeinitiationid";
	private final static String COMMITTEEINITIATIONUPDATE="UPDATE committee_initiation SET autoschedule='Y' WHERE initiationid=:initiationid AND committeeid=:committeeid";
	private static final String INITIATIONSCHEDULELISTALL = "SELECT cs.scheduleid, cs.committeeid,cs.committeemainid,cs.scheduledate,cs.schedulestarttime,cs.projectid , c.committeeshortname FROM committee_schedule cs,committee c WHERE cs.committeeid=c.committeeid AND cs.projectid=0 AND cs.divisionid=0 AND cs.initiationid=:initiationid AND cs.isactive=1 ";
	private static final String INITIATIONCOMMITTEESCHEDULELIST = "SELECT cs.scheduleid, cs.committeeid,cs.committeemainid,cs.scheduledate,cs.schedulestarttime,cs.projectid , c.committeeshortname FROM committee_schedule cs,committee c WHERE cs.committeeid=c.committeeid AND cs.initiationid=:initiationid AND cs.CommitteeId=:committeeid AND cs.isactive=1 ";
	private final static String INITIATIONCOMMITTEEMAINLIST = "SELECT  b.committeeid,a.initiationid, a.autoschedule,b.committeeshortname,b.committeename FROM committee_initiation a,committee b WHERE a.committeeid=b.committeeid  AND a.initiationid =:initiationid";
	private static final String INITIAITIONMASTERLIST = "SELECT b.committeename,b.committeeshortname,b.committeeid,a.committeeinitiationid,b.periodicnon,b.periodicduration,a.autoschedule FROM committee_initiation a,committee b  WHERE a.committeeid=b.committeeid AND a.initiationid=:initiationid";
	private static final String PROPOSEDCOMMITTEEMAINID ="SELECT b.committeemainid,'mainid' FROM committee_main a , committee_main b WHERE a.committeeid=b.committeeid AND a.projectid=b.projectid AND a.divisionid=b.divisionid AND a.initiationid= b.initiationid AND b.status='P' AND b.isactive=0 AND a.committeemainid=:committeemainid";
	private static final String GETPROPOSEDCOMMITTEEMAINID="SELECT committeemainid,'mainid' FROM committee_main WHERE STATUS='P' AND committeeid=:committeeid AND projectid=:projectid AND divisionid=:divisionid AND initiationid=:initiationid";
	private static final String COMMITTEEMAINAPPROVALDATA="SELECT ca.constitutionapprovalid, ca.committeemainid, ca.emplabid, ca.empid, ca.remarks, ca.constitutionstatus, ca.approvalauthority,cas.statusdetail,cas.constitutionstatusid FROM committee_constitution_approval ca,committee_constitution_approval_status cas WHERE ca.constitutionstatus=cas.status AND ca.committeemainid=:committeemainid";
	private static final String COMMITTEEAPPROVALUPDATE="UPDATE committee_constitution_approval SET ConstitutionStatus=:constitutionstatus , ActionBy=:actionby,ActionDate=:actiondate,Remarks=:remarks WHERE CommitteeMainId=:committeemainid"; //, EmpLabid=:emplabid, Empid=:empid
	private static final String UPDATECOMMITTEEAPPROVALAUTHORITY="UPDATE committee_constitution_approval SET ApprovalAuthority=:approvalauthority WHERE CommitteeMainId=:committeemainid";
	private static final String PROPOSEDCOMMITTELIST="SELECT cm.committeemainid,cm.committeeid, cm.projectid, cm.divisionid, cm.initiationid ,cm.status, cm.isactive ,c.committeeshortname,c.committeename FROM committee_main cm, committee c  ,committee_constitution_approval cca WHERE cm.status='P' AND cm.committeeid=c.committeeid AND cca.committeemainid=cm.committeemainid AND cca.ConstitutionStatus NOT IN ('0') ";
	private static final String APPROVALSTATUSLIST="SELECT constitutionstatusid,authorityid,STATUS, statusdetail FROM committee_constitution_approval_status WHERE authorityid = (SELECT cas.authorityid FROM committee_constitution_approval_status cas,committee_constitution_approval ca   WHERE ca.committeemainid=:committeemainid AND ca.constitutionstatus=cas.status)+1 ORDER BY  constitutionstatusid";
	private static final String NEWCOMMITTEEMAINISACTIVEUPDATE ="UPDATE committee_main SET isactive=1,STATUS='A',modifiedby=:modifiedby, modifieddate=:modifieddate WHERE committeemainid=:committeemainid";
	private static final String LOGINDATA ="SELECT loginid, username,empid, divisionid,logintype FROM login WHERE loginid=:loginid";
	private static final String DORTMDDATA ="SELECT rt.rtmddoid, rt.empid , rt.type FROM pfms_rtmddo rt WHERE rt.isactive=1 AND rt.type='P&C DO'";
	private static final String COMCONSTITUTIONAPPROVALHISTORY ="SELECT cch.constitutionapprovalid, cch.committeemainid,cch.constitutionstatus,cch.remarks, cch.actionbylabid, cch.actionbyempid,cch.actiondate,ccs.statusdetail, e.empname,ed.designation,cl.labcode, cl.labname FROM committee_constitution_history cch, committee_constitution_approval_status ccs,  employee e, employee_desig ed, cluster_lab cl WHERE cch.constitutionstatus=ccs.status AND cch.actionbyempid=e.empid AND e.desigid=ed.desigid AND cch.actionbylabid=cl.labid AND cch.committeemainid=:committeemainid";
	private static final String COMCONSTITUTIONEMPDETAILS ="SELECT cca.empid ,e.empname,ed.designation,'Constituted By' FROM committee_constitution_approval cca, employee e ,employee_desig ed WHERE cca.empid=e.empid AND e.desigid=ed.desigid AND committeemainid=:committeemainid";
	private static final String DORTMDADEMPDATA=" SELECT pr.empid ,e.empname,ed.designation ,pr.type FROM pfms_rtmddo pr, employee e ,employee_desig ed WHERE pr.empid=e.empid AND e.desigid=ed.desigid AND pr.isactive='1' AND pr.type='DO-RTMD' ";
	private static final String DIRECTOREMPDATA="SELECT l.labauthorityId,e.empname,ed.designation ,'Director'  FROM lab_master l, employee e ,employee_desig ed   WHERE l.labauthorityId=e.empid AND e.desigid=ed.desigid AND l.labcode=:LabCode ";
	private static final String COMMITTEEMAINAPPROVALDODATA ="SELECT e1.empid,e1.empname,ed.designation,'Group Head' FROM employee e,employee e1,employee_desig ed, committee_constitution_approval cca,division_master dm ,division_group dg WHERE cca.empid=e.empid AND e.divisionid=dm.divisionid AND dm.groupid=dg.groupid AND dg.groupheadid=e1.empid AND e1.desigid=ed.desigid AND cca.committeemainid=:committeemainid";
	private static final String COMMITTEEMINUTESDELETE ="DELETE FROM committee_schedules_minutes_details WHERE scheduleminutesid=:scheduleminutesid";
	private static final String COMMITTEECONSTATUSDETAILS ="SELECT statusdetail,status FROM committee_constitution_approval_status WHERE status=:status";
	private static final String COMMITTEESCHEDULEDELETE ="UPDATE committee_schedule SET modifiedby=:modifiedby, modifieddate=:modifieddate, isactive=0 WHERE scheduleid=:scheduleid";
	private static final String COMMITTEESCHEDULEAGENDADELETE ="UPDATE committee_schedules_agenda SET isactive=0, modifiedby=:modifiedby, modifieddate=:modifieddate WHERE scheduleid=:scheduleid";
	private static final String COMMITTEESCHEDULEINVITATIONDELETE ="DELETE FROM committee_schedules_invitation WHERE committeescheduleid=:scheduleid ";
	private static final String SCHEDULECOMMITTEEEMPCHECK ="SELECT cm.committeemainid,cme.empid FROM committee_schedule cs,committee_main cm,committee_member cme WHERE cs.committeeid=cm.committeeid AND cs.projectid=cm.projectid 	AND cs.divisionid=cm.divisionid AND cs.initiationid=cm.initiationid AND cm.isactive=1 AND cm.committeemainid=cme.committeemainid 	AND cme.labcode IN (SELECT labcode FROM lab_master) AND cme.membertype IN ('CC','CS','PS','CH') AND cme.isactive=1 AND cs.scheduleid=:scheduleid AND cme.empid=:empid";
	private static final String SCHEDULECOMMITTEEEMPINVITEDCHECK ="SELECT csi.committeescheduleid, csi.empid, csi.membertype ,cms.meetingstatusid FROM committee_schedules_invitation csi ,committee_schedule cs, committee_meeting_status cms WHERE csi.committeescheduleid=cs.scheduleid  AND cs.scheduleflag=cms.meetingstatus AND   CASE WHEN cms.meetingstatusid < 7  	THEN  csi.membertype IN ('CC','CS','PS','CH') 	 WHEN  cms.meetingstatusid >= 7  THEN  csi.membertype IN ('CC','CS','PS','CH','CI','P','I') 	END AND csi.empid =:empid AND csi.committeescheduleid=:scheduleid";
	private static final String EMPSCHEDULEDATA="SELECT cs1.scheduleid,cs1.meetingid,cs1.scheduledate,csi.membertype,cs1.committeemainid,cs1.schedulestarttime FROM committee_schedule cs1, committee_schedules_invitation csi WHERE csi.labcode IN (SELECT labcode FROM lab_master) AND cs1.scheduleid=csi.committeescheduleid AND csi.empid=:empid AND cs1.scheduledate=(SELECT cs2.scheduledate FROM committee_schedule cs2 WHERE cs2.scheduleid=:scheduleid) AND cs1.scheduleid  <> :scheduleid";
	private static final String ALLACTIONASSIGNEDCHECK="SELECT csm.scheduleminutesid AS 'csmid',csm.scheduleid ,csm.idarck,ass.assignee, am.scheduleminutesid AS 'ammid' FROM action_assign ass, committee_schedules_minutes_details csm LEFT JOIN action_main am ON csm.scheduleminutesid=am.scheduleminutesid  WHERE ass.actionmainid=am.actionmainid AND csm.idarck IN ('A','I','K') AND csm.scheduleid=:scheduleid";
	private static final String DEFAULTAGENDALIST="SELECT csa.DefaultAgendaid,csa.agendapriority,csa.agendaitem,csa.remarks,csa.duration,csa.committeeid FROM committee_default_agenda csa  WHERE isactive=1 AND csa.committeeid=:committeeid AND csa.LabCode = :LabCode";
	private static final String PROCUREMETSSTATUSLIST="SELECT f.PftsFileId, f.DemandNo, f.OrderNo, f.DemandDate, f.DpDate, ROUND(f.EstimatedCost/100000,2) AS 'EstimatedCost',ROUND(f.OrderCost/100000, 2) AS 'OrderCost', f.RevisedDp ,f.ItemNomenclature, s.PftsStatus, s.PftsStageName, f.Remarks,'' AS vendorname,f.PftsStatusId  AS id  FROM pfts_file f, pfts_status s  WHERE f.ProjectId=:projectid AND f.EstimatedCost>(SELECT proclimit FROM pfms_project_data WHERE ProjectId=:projectid )  AND f.PftsStatusId=s.PftsStatusId AND s.PftsStatusId<16 AND f.PftsFileId NOT IN(SELECT PftsFileId FROM pfts_file_order) UNION SELECT f.PftsFileId, f.DemandNo, o.OrderNo, f.DemandDate, o.DpDate, ROUND(f.EstimatedCost/100000,2) AS 'EstimatedCost',ROUND(o.OrderCost/100000, 2) AS 'OrderCost', f.RevisedDp ,f.ItemNomenclature, s.PftsStatus, s.PftsStageName, f.Remarks,o.vendorname,f.PftsStatusId  AS id  FROM pfts_file f, pfts_status s,pfts_file_order o  WHERE f.ProjectId=:projectid AND f.PftsFileId=o.PftsFileId  AND f.PftsStatusId=s.PftsStatusId AND s.PftsStatusId<16 AND o.OrderCost>(SELECT proclimit FROM pfms_project_data WHERE ProjectId=:projectid ) ORDER BY  DemandNo , id ASC";
	private static final String COMMITTEEMINUTESSPECNEW="SELECT minutesid,description FROM committee_schedules_minutes_new";
	private static final String MILESTONESUBSYSTEMS="SELECT maa.activityId, maa.Parentactivityid, maa.activityname, maa.orgenddate, maa.enddate,maa.activitystatusid,mas.activityshort, maa.ProgressStatus,ma.milestoneno, maa.StatusRemarks,maa.activitylevelid FROM milestone_activity ma,milestone_activity_level maa,milestone_activity_status mas WHERE ma.milestoneactivityid = maa.parentactivityid AND maa.activitylevelid='1' AND maa.activitystatusid=mas.activitystatusid  AND ma.projectid=:projectid ORDER BY ma.milestoneno ASC";
	private static final String FILEREPMASTERLISTALL ="SELECT filerepmasterid,parentlevelid, levelid,levelname FROM file_rep_master where filerepmasterid>0 AND projectid=:projectid and LabCode=:LabCode ORDER BY parentlevelid ";
//	private static final String AGENDADOCLINKDOWNLOAD  ="SELECT a.filerepid,b.filerepuploadid,b.filepath,b.filenameui,b.filename,b.filepass,b.ReleaseDoc,b.VersionDoc FROM file_rep_new a,file_rep_upload b WHERE a.filerepid=b.filerepid AND a.filerepid=:filerepid AND a.releasedoc=b.releasedoc AND a.versiondoc=b.versiondoc";
	private static final String AGENDADOCLINKDOWNLOAD  ="SELECT b.filerepid,b.filerepuploadid,b.filepath,b.filenameui,b.filename,b.filepass,b.ReleaseDoc,b.VersionDoc FROM file_rep_upload b WHERE  b.filerepuploadid=:filerepid ";
	private static final String MALIST="SELECT a.milestoneactivityid,0 AS 'parentactivityid', a.activityname,a.orgstartdate,a.orgenddate,a.startdate,a.enddate,a.progressstatus, mas.activitystatus, e.empname AS 'OIC1',a.milestoneno, mas.activityshort, mas.activitystatusid,0 as level FROM milestone_activity a, milestone_activity_status mas,employee e WHERE  a.isactive=1 AND mas.activitystatusid=a.activitystatusid AND a.enddate BETWEEN CURDATE() AND DATE(DATE_ADD(CURDATE(),INTERVAL 180 DAY))  AND a.oicempid=e.empid AND a.projectid=:ProjectId";
	private static final String MILEACTIVITYLEVEL="SELECT a.activityid ,a.parentactivityid, a.activityname,a.orgstartdate,a.orgenddate , a.startdate, a.enddate,  a.progressstatus, mas.activitystatus, e.empname,0 as milestoneno, mas.activityshort, mas.activitystatusid,a.activitylevelid as level  FROM milestone_activity_level a, milestone_activity_status mas, employee e WHERE  a.enddate BETWEEN CURDATE() AND DATE(DATE_ADD(CURDATE(),INTERVAL 180 DAY)) AND mas.activitystatusid=a.activitystatusid AND a.oicempid=e.empid AND a.parentactivityid=:id AND a.activitylevelid=:levelid ";
	private static final String AGENDALINKEDDOCLIST="SELECT sad.agendadocid,sad.agendaid,sad.filedocid,dm.levelname FROM committee_schedule_agenda_docs sad, file_rep_new rn, committee_schedules_agenda sa,file_doc_master dm WHERE sad.agendaid=sa.scheduleagendaid AND sad.filedocid=rn.filerepid AND dm.fileuploadmasterid = rn.documentid AND sad.isactive=1 AND sa.isactive=1 AND sa.scheduleid=:scheduleid";
	
	@PersistenceContext
	EntityManager manager;
	
	@Override
	public long CommitteeNewAdd(Committee committeeModel)throws Exception
	{
		manager.persist(committeeModel);
		return committeeModel.getCommitteeId(); 
	}
	

	@Override
	public List<Object[]> CommitteeNamesCheck(String name,String sname,String projectid,String LabCode) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEENAMESCHECK);		
		query.setParameter("committeeshortname", sname);
		query.setParameter("committeename", name);
		query.setParameter("labcode", LabCode);
		
		List<Object[]> CommitteeNamesCheck=(List<Object[]>)query.getResultList();

		return CommitteeNamesCheck;
	}
	
	@Override
	public List<Object[]> CommitteeListAll() throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEELISTALL);
		
		List<Object[]> CommitteeListAll=(List<Object[]>)query.getResultList();
		
		return CommitteeListAll;
	}
	
	@Override
	public List<Object[]> CommitteeListActive(String isglobal,String projectapplicable, String LabCode) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEELISTACTIVE);
		query.setParameter("isglobal", isglobal);
		query.setParameter("projectapplicable", projectapplicable);
		query.setParameter("labcode", LabCode);
		List<Object[]> CommitteeListActives=(List<Object[]>)query.getResultList();		
		return CommitteeListActives;
	}
	
	@Override
	public Object[] CommitteeDetails(String committeeid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEDETAILS);
		query.setParameter("committeeid", committeeid);		
		Object[] CommitteeDetails = (Object[])query.getResultList().get(0);		
		return CommitteeDetails;
	}
	
	@Override
	public Long CommitteeEditSubmit(Committee committeemodel) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEEDITSUBMIT);
		query.setParameter("committeeshortname",committeemodel.getCommitteeShortName() );
		query.setParameter("committeename", committeemodel.getCommitteeName());
		query.setParameter("committeetype", committeemodel.getCommitteeType());
		query.setParameter("projectapplicable", committeemodel.getProjectApplicable());
		query.setParameter("modifiedby", committeemodel.getModifiedBy());
		query.setParameter("modifieddate", committeemodel.getModifiedDate());
		query.setParameter("committeeid", committeemodel.getCommitteeId());
		query.setParameter("periodicduration", committeemodel.getPeriodicDuration());  
		query.setParameter("technontech", committeemodel.getTechNonTech());
		query.setParameter("guidelines", committeemodel.getGuidelines());
		query.setParameter("periodicnon", committeemodel.getPeriodicNon() );
		query.setParameter("description", committeemodel.getDescription());
		query.setParameter("termsofreference", committeemodel.getTermsOfReference());
		query.setParameter("isglobal", committeemodel.getIsGlobal());
		return (long)query.executeUpdate();		
	}
	

	@Override
	public List<Object[]> EmployeeList(String LabCode) throws Exception {
		Query query=manager.createNativeQuery(EMPLOYEELIST);
		query.setParameter("labcode", LabCode);
		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();	
		return EmployeeList;
	}
	
	@Override
	public Object[] CommitteeName(String CommitteeId) throws Exception {
		Query query=manager.createNativeQuery(COMMITTEENAME);
		query.setParameter("committeeid", CommitteeId);		
		Object[] CommitteeName=(Object[])query.getSingleResult();	
		return CommitteeName;
	}

	@Override
	public long CommitteeDetailsSubmit(CommitteeMain committeemain) throws Exception {
		
		manager.persist(committeemain);
		return committeemain.getCommitteeMainId();
	}
	

	


	@Override
	public Long LastCommitteeId(String CommitteeId,String projectid,String divisionid,String initiationid) throws Exception {

		Query query=manager.createNativeQuery(LASTCOMMITTEEID);
		query.setParameter("committeeid", CommitteeId);
		query.setParameter("projectid", projectid);
		query.setParameter("divisionid", divisionid);
		query.setParameter("initiationid", initiationid);
		return Long.parseLong(query.getResultList().stream().findFirst().orElse(0).toString());
	}

	@Override
	public Long UpdateCommitteemainValidto(CommitteeMain committeemain) throws Exception {

		Query query=manager.createNativeQuery(UPDATECOMMITTEEVALIDTO);
		query.setParameter("validto", committeemain.getValidTo());
		query.setParameter("lastcommitteeid", committeemain.getCommitteeMainId());
		query.setParameter("modifiedby", committeemain.getModifiedBy());
		query.setParameter("modifieddate", committeemain.getModifiedDate());

		int count=query.executeUpdate();

		return (long)count ;
	}


	@Override
	public List<Object[]> CommitteeMainList(String labcode) throws Exception {

		Query query=manager.createNativeQuery(COMMITTEEMAINLIST);
		query.setParameter("labcode", labcode);
		List<Object[]> CommitteeMainList=(List<Object[]>)query.getResultList();
		
		return CommitteeMainList;
	}
	
	
	
	@Override
	public List<Object[]> CommitteeNonProjectList() throws Exception 
	{
		Query query=manager.createNativeQuery(COMMITTEENONPROJECTLIST);
		List<Object[]> CommitteeNonProjectList=(List<Object[]>)query.getResultList();
		
		return CommitteeNonProjectList;
	}

	
	@Override
	public int CommitteeMemberDelete(CommitteeMember committeemember) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEMEMBERDELETE);
		query.setParameter("modifiedby", committeemember.getModifiedBy());
		query.setParameter("modifieddate",committeemember.getModifiedDate());
		query.setParameter("committeememberid",committeemember.getCommitteeMemberId());
		return query.executeUpdate();
	}
	
	
	@Override
	public Long CommitteeMainMembersAdd(CommitteeMember  committeemember)throws Exception
	{
		manager.persist(committeemember);
		manager.flush();
		return (Long)committeemember.getCommitteeMemberId();
	}
	
	
	
	@Override
	public long CommitteeScheduleAddSubmit(CommitteeSchedule committeeschedule )throws Exception
	{
		manager.persist(committeeschedule);
		return committeeschedule.getScheduleId();
	}
	
	@Override
	public List<Object[]> CommitteeScheduleListNonProject(String committeeid)throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEESCHEDULELIST);
		query.setParameter("committeeid", committeeid);
		List<Object[]> committeeschedulelist=(List<Object[]>)query.getResultList();
		return committeeschedulelist;
	}

	@Override
	public Object[] CommitteeScheduleEditData(String CommitteeScheduleId) throws Exception {

		Query query=manager.createNativeQuery(COMMITTEESCHEDULEEDITDATA);
		query.setParameter("committeescheduleid", CommitteeScheduleId );
		Object[] CommitteeScheduleEditData=(Object[])query.getSingleResult();
		return CommitteeScheduleEditData;
	}
	
	@Override
	public List<Object[]> AgendaReturnData(String CommitteeScheduleId) throws Exception {

		Query query=manager.createNativeQuery(AGENDARETURNDATA);
		query.setParameter("scheduleid", CommitteeScheduleId );
		List<Object[]> AgendaReturnData=(List<Object[]>)query.getResultList();
		return AgendaReturnData;
	}
  

	@Override
	public List<Object[]> ProjectList(String LabCode) throws Exception {

		Query query=manager.createNativeQuery(PROJECTLIST);
		query.setParameter("labcode", LabCode);
		List<Object[]> ProjectList=(List<Object[]>)query.getResultList();
		return ProjectList;
	}



	@Override
	public Long CommitteeAgendaSubmit(CommitteeScheduleAgenda scheduleagenda) throws Exception 
	{
		manager.persist(scheduleagenda);
		manager.flush();
		
		return scheduleagenda.getScheduleAgendaId();
	}
	
	private static final String AGENDAADDEDDOCLINKIDLIST = " SELECT CAST( filedocid AS CHAR) AS filedocid  FROM committee_schedule_agenda_docs WHERE agendaid=:agendaid AND isactive=1 ";
	
	@Override
	public List<String> AgendaAddedDocLinkIdList(String agendaid) throws Exception 
	{
		Query query=manager.createNativeQuery(AGENDAADDEDDOCLINKIDLIST);
		query.setParameter("agendaid", agendaid);
		List<String> AgendaAddedDocLinkIdList=new ArrayList<String>();
		try {
			AgendaAddedDocLinkIdList=(List<String>)query.getResultList();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO AgendaAddedDocLinkIdList "+e);
			e.printStackTrace();
			return AgendaAddedDocLinkIdList;
		}
		return AgendaAddedDocLinkIdList;
	}
	
	@Override
	public Long AgendaDocLinkAdd(CommitteeScheduleAgendaDocs doc) throws Exception {
		manager.persist(doc);
		manager.flush();		
		return doc.getAgendaDocid();
	}

	
	@Override
	public List<Object[]> AgendaList(String CommitteeScheduleId) throws Exception {

		Query query=manager.createNativeQuery(AGENDALIST);
		query.setParameter("committeescheduleid", CommitteeScheduleId);
		List<Object[]> AgendaList=(List<Object[]>)query.getResultList();
		
		return AgendaList;
	}
	

	

	@Override
	public Long CommitteeScheduleUpdate(CommitteeSchedule committeeschedule) throws Exception {

		Query query=manager.createNativeQuery(COMMITTEESCHEDULEUPDATE);
		query.setParameter("scheduledate", committeeschedule.getScheduleDate());
		query.setParameter("schedulestarttime", committeeschedule.getScheduleStartTime());
		query.setParameter("modifiedby", committeeschedule.getModifiedBy());
		query.setParameter("modifieddate", committeeschedule.getModifiedDate());
		query.setParameter("scheduleid", committeeschedule.getScheduleId());
		query.setParameter("meetingid", committeeschedule.getMeetingId());
		long count=query.executeUpdate();

		return count;
	}


	@Override
	public List<Object[]> CommitteeMinutesSpecList(String CommitteeScheduleId) throws Exception 
	{
		Query query=manager.createNativeQuery(COMMITTEESPECLIST);
		query.setParameter("scheduleid", CommitteeScheduleId);
		List<Object[]> CommitteeMinutesSpecList=(List<Object[]>)query.getResultList();
		
		return CommitteeMinutesSpecList;
	}


	@Override
	public Long CommitteeMinutesInsert(CommitteeScheduleMinutesDetails committeescheduleminutesdetails)	throws Exception {

		manager.persist(committeescheduleminutesdetails);
		manager.flush();
		
		return committeescheduleminutesdetails.getScheduleMinutesId();
	}
	

	@Override
	public Object[] CommitteeMinutesSpecDesc(CommitteeScheduleMinutesDetails committeescheduleminutesdetails)throws Exception {
		Query query=manager.createNativeQuery(COMMITTEEMINUTESPEC);
		query.setParameter("minutesid", committeescheduleminutesdetails.getMinutesId());
		query.setParameter("agendasubid", committeescheduleminutesdetails.getMinutesSubId());
		query.setParameter("scheduleagendaid", committeescheduleminutesdetails.getMinutesSubOfSubId());
		Object[] CommitteeMinutesSpecDesc=(Object[])query.getSingleResult();		
		return CommitteeMinutesSpecDesc;
	}
	
	@Override
	public Object[] CommitteeMinutesSpecEdit(CommitteeScheduleMinutesDetails committeescheduleminutesdetails)throws Exception {
		
		Query query=manager.createNativeQuery(COMMITTEEMINUTEEDIT);
		query.setParameter("scheduleminutesid", committeescheduleminutesdetails.getScheduleMinutesId());		
		Object[] CommitteeMinutesSpecEdit=(Object[])query.getSingleResult();		
		return CommitteeMinutesSpecEdit;
	}


	@Override
	public Long CommitteeMinutesUpdate(CommitteeScheduleMinutesDetails committeescheduleminutesdetails)	throws Exception {

		Query query=manager.createNativeQuery(COMMITTEEMINUTEUPDATE);
		query.setParameter("scheduleid", committeescheduleminutesdetails.getScheduleId());
		query.setParameter("schedulesubid", committeescheduleminutesdetails.getScheduleSubId());
		query.setParameter("minutesid", committeescheduleminutesdetails.getMinutesId());
		query.setParameter("details", committeescheduleminutesdetails.getDetails());
		query.setParameter("darc", committeescheduleminutesdetails.getIDARCK());
		query.setParameter("modifiedby", committeescheduleminutesdetails.getModifiedBy());
		query.setParameter("modifieddate", committeescheduleminutesdetails.getModifiedDate());
		query.setParameter("scheduleminutesid", committeescheduleminutesdetails.getScheduleMinutesId());
		query.setParameter("remarks", committeescheduleminutesdetails.getRemarks());
		int count=query.executeUpdate();
		
		return (long)count;
	}

	@Override
	public List<Object[]> CommitteeScheduleAgendaPriority(String Committeescheduleid)throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEAGENDAPRIORITY);
		query.setParameter("scheduleid", Committeescheduleid);
		return  (List<Object[]>)query.getResultList();
	}

	@Override
	public long	CommitteeScheduleAgendaUpdate(CommitteeScheduleAgenda scheduleagenda) throws Exception   
	{
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEAGENDAUPDATE);
		query.setParameter("scheduleagendaid", scheduleagenda.getScheduleAgendaId());
		query.setParameter("agendaitem", scheduleagenda.getAgendaItem());
		query.setParameter("projectid", scheduleagenda.getProjectId());
		query.setParameter("remarks", scheduleagenda.getRemarks());
		query.setParameter("modifiedby", scheduleagenda.getModifiedBy());
		query.setParameter("modifieddate", scheduleagenda.getModifiedDate());
		query.setParameter("PresentorLabCode", scheduleagenda.getPresentorLabCode());
		query.setParameter("PresenterId", scheduleagenda.getPresenterId());
		query.setParameter("duration", scheduleagenda.getDuration());
		
		return  query.executeUpdate();
	}

	

	@Override
	public int CommitteeAgendaPriorityUpdate(String agendaid,String agendapriority) throws Exception
	{
			Query query =manager.createNativeQuery(COMMITTEEAGENDAPRIORITYUPDATE);
			query.setParameter("agendapriority", agendapriority);
			query.setParameter("agendaid", agendaid);
			int count=(int)query.executeUpdate();
			
			return count;
	}

	@Override
	public List<Object[]> CommitteeScheduleGetAgendasAfter( String  scheduleid,String AgendaPriority) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEGETAGENDASAFTER);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("AgendaPriority",  AgendaPriority);
		List<Object[]> TccScheduleGetAgendasAfter=(List<Object[]>)query.getResultList();
		
		return TccScheduleGetAgendasAfter;
	}


	@Override
	public int CommitteeAgendaDelete(String committeescheduleagendaid,String Modifiedby ,String ModifiedDate)throws Exception
	{
		Query query =manager.createNativeQuery(COMMITTEEAGENDADELETE);
		query.setParameter("agendaid",committeescheduleagendaid);
		query.setParameter("modifiedby",Modifiedby);
		query.setParameter("modifieddate", ModifiedDate);
		return query.executeUpdate();
	}
	
	private static final String AGENDADOCUNLINK = "UPDATE committee_schedule_agenda_docs  SET isactive=0, modifiedby=:modifiedby , modifieddate=:modifieddate WHERE agendaid=:agendaid ";
	
	@Override
	public int AgendaDocUnlink(String agendaid,String Modifiedby ,String ModifiedDate)throws Exception
	{
		Query query =manager.createNativeQuery(AGENDADOCUNLINK);
		query.setParameter("agendaid",agendaid);
		query.setParameter("modifiedby",Modifiedby);
		query.setParameter("modifieddate", ModifiedDate);
		return query.executeUpdate();
	}

	@Override
	public long CommitteeSubScheduleSubmit(CommitteeSubSchedule committeesubschedule) throws Exception
	{
		manager.persist(committeesubschedule);
		return committeesubschedule.getScheduleSubId();
	}
		
	@Override
	public List<Object[]> CommitteeSubScheduleList(String scheduleid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEESUBSCHEDULELIST);
		query.setParameter("scheduleid", scheduleid);
		List<Object[]> CommitteeSubScheduleList=(List<Object[]> )query.getResultList();
		return CommitteeSubScheduleList;
	}

	@Override
	public List<Object[]> CommitteeScheduleMinutes(String scheduleid) throws Exception
	{
		Query query=manager.createNativeQuery("CALL Pfms_Committee_Minutes_View_All(:scheduleid)");
		query.setParameter("scheduleid", scheduleid);
		List<Object[]> CommitteeScheduleMinutes =(List<Object[]>)query.getResultList();
		return CommitteeScheduleMinutes;
	}

	@Override
	public List<Object[]> CommitteeMinutesSpecdetails()throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEMINUTESSPECDETAILS);
		 List<Object[]> CommitteeMinutesSpecdetails=(List<Object[]>) query.getResultList();
		return CommitteeMinutesSpecdetails;
	}
	


	@Override
	public List<Object[]> CommitteeMinutesSub()throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEMINUTESSUB);
		 List<Object[]> CommitteeMinutesSub=(List<Object[]>) query.getResultList();
		return CommitteeMinutesSub;
	}


	@Override
	public List<Object[]> CommitteeAttendance(String CommitteeScheduleId) throws Exception {

		Query query=manager.createNativeQuery(COMMITTEEATTENDANCE);
		query.setParameter("scheduleid", CommitteeScheduleId);	
		List<Object[]> CommitteeAttendance=(List<Object[]>) query.getResultList();
		return CommitteeAttendance;
	}
	
	
	


	@Override
	public int MeetingAgendaApproval(CommitteeMeetingApproval approval, CommitteeSchedule schedule,List<PfmsNotification> notifications)
			throws Exception {
		manager.persist(approval);
		for(int i=0;i<notifications.size();i++) {
			manager.persist(notifications.get(i));
		}
		Query query=manager.createNativeQuery(COMMITTEEAPPROVAL);
		query.setParameter("scheduleid", schedule.getScheduleId());
		query.setParameter("flag", schedule.getScheduleFlag());
		query.setParameter("modifiedby", schedule.getModifiedBy());
		query.setParameter("modifieddate", schedule.getModifiedDate());
		int count=query.executeUpdate();
		manager.flush();
		return count;
	}

	@Override
	public List<Object[]> MeetingApprovalAgendaList(String EmpId) throws Exception {
				
		Query query=manager.createNativeQuery("CALL Pfms_Agenda_aproval_List(:empid);");
		query.setParameter("empid", EmpId);
		List<Object[]> MeetingApprovalAgendaList=(List<Object[]>) query.getResultList();
			
		return MeetingApprovalAgendaList;
		
	}
			
			


	@Override
	public int MeetingAgendaApprovalSubmit(CommitteeSchedule schedule, CommitteeMeetingApproval approval,PfmsNotification notification)throws Exception 
	{

		manager.persist(approval);
		manager.persist(notification);

		Query query=manager.createNativeQuery(COMMITTEEAPPROVAL);
		query.setParameter("scheduleid", schedule.getScheduleId());
		query.setParameter("flag", schedule.getScheduleFlag());
		query.setParameter("modifiedby", schedule.getModifiedBy());
		query.setParameter("modifieddate", schedule.getModifiedDate());
		int count=query.executeUpdate();
		manager.flush();
		
		return count;
	}

	
	@Override
	public Object[] CommitteeScheduleData(String committeescheduleid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEDATA);
		query.setParameter("committeescheduleid", committeescheduleid );
		return (Object[] )query.getResultList().get(0);
	}
	
	@Override
	public List<Object[]> CommitteeAtendance(String committeescheduleid) throws Exception
	{
		Query query= manager.createNativeQuery("Call Pfms_Committee_Invitation (:committeescheduleid)");
		query.setParameter("committeescheduleid", committeescheduleid);
		return (List<Object[]>)query.getResultList();
	}

	private static final String COMMITTEEINVITATIONCHECK="SELECT committeescheduleid, labcode, empid FROM committee_schedules_invitation WHERE committeescheduleid=:scheduleid AND labcode=:labcode AND empid=:empid";

	
	@Override
	public List<Object[]> CommitteeInvitationCheck(CommitteeInvitation committeeinvitation) throws Exception
	{
		Query query= manager.createNativeQuery(COMMITTEEINVITATIONCHECK);
		query.setParameter("scheduleid", committeeinvitation.getCommitteeScheduleId());
		query.setParameter("labcode", committeeinvitation.getLabCode() );
		query.setParameter("empid", committeeinvitation.getEmpId());
		
		return (List<Object[]>)query.getResultList();
	}
	
	
	@Override
	public long CommitteeInvitationCreate(CommitteeInvitation committeeinvitation) throws Exception
	{
		manager.persist(committeeinvitation);
		return committeeinvitation.getCommitteeInvitationId();
	}
	
	 
	
	@Override
	public Object[] InvitationMaxSerialNo(String scheduleid) throws Exception
	{
		Query query=manager.createNativeQuery(INVITATIONMAXSERIALNO);
		query.setParameter("scheduleid", scheduleid);
		
		Object[] InvitationMaxSerialNo=(Object[] )query.getResultList().get(0);
		return InvitationMaxSerialNo;		
	}
	
	@Override
	public Long CommitteeInvitationDelete(String committeeinvitationid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEINVITATIONDELETE);
		query.setParameter("committeeinvitationid", committeeinvitationid);
		return (long) query.executeUpdate();
	}
	
	
	
	@Override
	public int CommitteeInvitationSerialNoUpdate(String committeeinvitationid,long serialno) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEINVITATIONSERIALNOUPDATE);
		query.setParameter("committeeinvitationid", committeeinvitationid);
		query.setParameter("serialno", serialno);
		
		return query.executeUpdate();
	}
	
	
	
	
	@Override
	public List<Object[]> CommitteeInvitationSerialNoAfter(String committeeinvitationid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEINVITATIONSERIALNOAFTER);
		query.setParameter("committeeinvitationid", committeeinvitationid);
		List<Object[]> CommitteeInvitationSerialNoAfter=(List<Object[]> )query.getResultList();
		return CommitteeInvitationSerialNoAfter;
	}
	
	

	@Override
	public List<String> CommitteeAttendanceList(String invitationId) throws Exception 
	{
		Query query=manager.createNativeQuery(COMMITTEEATTENDANCETYPE);
		query.setParameter("invitationid", invitationId);
		List<String> AttendanceList=(List<String>)query.getResultList();		
		return AttendanceList;
	}

	@Override
	public Long CommitteeAttendanceUpdate(String InvitationId, String Value) throws Exception 
	 {

		int count=0;
		
		if(Value.equalsIgnoreCase("P")) {
			Query query=manager.createNativeQuery(ATTENDANCEUPDATEN);
			query.setParameter("invitationid", InvitationId);
			query.setParameter("attendance", "N");
			count=query.executeUpdate();
		}
		if(Value.equalsIgnoreCase("N")) {
			Query query=manager.createNativeQuery(ATTENDANCEUPDATEP);
			query.setParameter("invitationid", InvitationId);
			query.setParameter("attendance", "P");
			count=query.executeUpdate();
		}
		
		return (long) count;
	}

	@Override
	public List<Object[]> ExpertList() throws Exception 
	{
		Query query=manager.createNativeQuery(EXPERTLIST);
		List<Object[]> ExpertList=(List<Object[]>)query.getResultList();
		return ExpertList;
	}



	@Override
	public long ScheduleMinutesUnitUpdate(CommitteeScheduleMinutesDetails minutesdetails) throws Exception {

		manager.persist(minutesdetails);
		manager.flush();
		
		return minutesdetails.getScheduleMinutesId();
	}


	@Override
	public List<Object[]> MinutesUnitList(String CommitteeScheduleId) throws Exception {

		Query query=manager.createNativeQuery(MINUTESUNITLIST);
		query.setParameter("committeescheduleid", CommitteeScheduleId);
		List<Object[]> MinutesUnitList=(List<Object[]> )query.getResultList();
		
		return MinutesUnitList;
	}
	
	@Override
	public List<Object[]> CommitteeAgendaPresenter(String scheduleid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEAGENDAPRESENTER);
		query.setParameter("scheduleid", scheduleid);
		return (List<Object[]>)query.getResultList();
	}


	@Override
	public List<Object[]> ChaipersonEmailId(String CommitteeMainId) throws Exception {

		Query query=manager.createNativeQuery(CHAIRPERSONEMAIL);
		query.setParameter("committeemainid", CommitteeMainId);
		List<Object[]> ChaipersonEmailId=(List<Object[]>)query.getResultList();
		
		return ChaipersonEmailId;
	}
	
	@Override
	public Object[] ProjectDirectorEmail(String ProjectId) throws Exception {

		Query query=manager.createNativeQuery(PROJECTDIRECTOREMAIL);
		query.setParameter("projectid", ProjectId);
		Object[] ProjectDirectorEmail=(Object[])query.getSingleResult();
		
		return ProjectDirectorEmail;
	}
	
	@Override
	public Object[] RtmddoEmail() throws Exception {

		Query query=manager.createNativeQuery(RTMDDOEMAIL);
		try {
			Object[] RtmddoEmail=(Object[])query.getSingleResult();
			return RtmddoEmail;
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO RtmddoEmail "+e);
			return null;
		}
		
	}

	private static final String LASTPMRCDATEUPDATE ="UPDATE pfms_project_data SET lastpmrcdate =:lastpmrcdate WHERE projectid=:projectid ;";
	private static final String LASTEBDATEUPDATE ="UPDATE pfms_project_data SET lastebdate =:lastebdate WHERE projectid=:projectid ;";
	@Override
	public String UpdateOtp(CommitteeSchedule schedule) throws Exception {

		Query query=manager.createNativeQuery(UPDATEOTP);
		query.setParameter("otp", schedule.getKickOffOtp());
		query.setParameter("committeescheduleid", schedule.getScheduleId());
		query.setParameter("scheduleflag", schedule.getScheduleFlag());
		int ret=query.executeUpdate();
		

		if(schedule.getScheduleFlag().equalsIgnoreCase("MKV")) 
		{
			Object[] scheduledata = CommitteeScheduleEditData(String.valueOf(schedule.getScheduleId()));
			if(scheduledata[8].toString().equalsIgnoreCase("PMRC") && Long.parseLong(scheduledata[9].toString()) > 0) 
			{
				query = manager.createNativeQuery(LASTPMRCDATEUPDATE);
				query.setParameter("lastpmrcdate", scheduledata[2].toString());
				query.setParameter("projectid", scheduledata[9].toString());
				query.executeUpdate();
			}
			else if(scheduledata[8].toString().equalsIgnoreCase("EB") && Long.parseLong(scheduledata[9].toString()) > 0) 
			{
				query = manager.createNativeQuery(LASTEBDATEUPDATE);
				query.setParameter("lastebdate", scheduledata[2].toString());
				query.setParameter("projectid", scheduledata[9].toString());
				query.executeUpdate();
			}
		}
		
		
		if(schedule.getKickOffOtp()==null) {
			return String.valueOf(ret);
		}else {
			return schedule.getKickOffOtp();
		}
	}
	
	
	@Override
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype, String LabCode)throws Exception
	{
		Query query=manager.createNativeQuery("CALL Pfms_Emp_ProjectList(:empid,:logintype,:labcode);");
		query.setParameter("empid", empid);
		query.setParameter("logintype", Logintype);
		query.setParameter("labcode", LabCode);
		List<Object[]> LoginProjectIdList=(List<Object[]>)query.getResultList();
		return LoginProjectIdList;
	}
	
	
	
	@Override
	public Object[] projectdetails(String projectid) throws Exception
	{		
		Query query=manager.createNativeQuery(PROJECTDETAILS);
		query.setParameter("projectid",projectid);
		return (Object[]) query.getResultList().get(0);
	}
	
	@Override
	public List<Object[]> ProjectScheduleListAll(String projectid) throws Exception
	{
		Query query=manager.createNativeQuery(PROJECTSCHEDULELISTALL);
		query.setParameter("projectid",projectid);
		return (List<Object[]>) query.getResultList();
	}
	
	@Override
	public List<Object[]> ProjectApplicableCommitteeList(String projectid)throws Exception
	{
		Query query=manager.createNativeQuery(PROJECTAPPLICABLECOMMITTEELIST);
		query.setParameter("projectid", projectid);
		return (List<Object[]>)query.getResultList();
	}
	
	@Override
	public  int UpdateComitteeMainid(String committeemainid, String scheduleid ) throws Exception
	{
		Query query=manager.createNativeQuery(UPDATECOMITTEEMAINID);
		query.setParameter("committeemainid", committeemainid);
		query.setParameter("scheduleid", scheduleid);		
		return query.executeUpdate();
	}
	
	@Override
	public List<Object[]> ProjectCommitteeScheduleListAll(String projectid,String committeeid) throws Exception
	{
		Query query=manager.createNativeQuery(PROJECTCOMMITTEESCHEDULELISTALL);
		query.setParameter("projectid",projectid);
		query.setParameter("committeeid",committeeid);
		return (List<Object[]>) query.getResultList();
	}


	@Override
	public String KickOffOtp(String CommitteeScheduleId) throws Exception {

		Query query=manager.createNativeQuery(KICKOFFOTP);
		query.setParameter("scheduleid", CommitteeScheduleId);
		String KickOffOtp=(String)query.getSingleResult();
		return KickOffOtp;
	}


	@Override
	public List<Object[]> UserSchedulesList(String EmpId,String MeetingId) throws Exception {

		Query query=manager.createNativeQuery("CALL Pfms_Schedule_Individual(:empid,:meetingid)");
		query.setParameter("empid",EmpId);
		query.setParameter("meetingid",MeetingId);
		
		
		return (List<Object[]>) query.getResultList();
	}
	
	@Override
	public List<Object[]> MeetingSearchList(String MeetingId ,String LabCode) throws Exception {

		Query query=manager.createNativeQuery(MEETINGSEARCHLIST);
		query.setParameter("meetingid",MeetingId);
		query.setParameter("labcode", LabCode);
		return (List<Object[]>) query.getResultList();
	}

	@Override
	public Object[] CommitteeScheduleDataPro(String committeescheduleid, String projectid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEDATAPRO);
		query.setParameter("committeescheduleid", committeescheduleid );
		query.setParameter("projectid", projectid);
		return (Object[] )query.getResultList().get(0);
	}
	
	@Override
	public Object[] LabDetails(String LabCode)throws Exception
	{
		Query query=manager.createNativeQuery(LABDETAILS);
		query.setParameter("labcode", LabCode);
		Object[] Labdetails =(Object[])query.getSingleResult();
		return Labdetails ;
	}
	@Override
	public long ProjectCommitteeAdd(CommitteeProject committeeproject) throws Exception{
		
		manager.persist(committeeproject);
		manager.flush();
		return  committeeproject.getCommitteeProjectId();
	}

	@Override
	public long InitiationCommitteeAdd(CommitteeInitiation model) throws Exception
	{		
		manager.persist(model);
		manager.flush();
		return  model.getCommitteeInitiationId();
	}


	@Override
	public List<Object[]> ProjectMasterList(String ProjectId) throws Exception {
		
		Query query=manager.createNativeQuery(PROJECTMASTERLIST);
		query.setParameter("projectid", ProjectId );
		List<Object[]> ProjectMasterList=(List<Object[]>)query.getResultList();
		return ProjectMasterList;
	}
	
	
	
	@Override
	public  long ProjectCommitteeDelete(CommitteeProject committeeproject ) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEPROJECTDELETE);
		query.setParameter("committeeprojectid", committeeproject.getCommitteeProjectId());
		return query.executeUpdate();

	}

	@Override
	public List<Object[]> CommitteeAutoScheduleList(String ProjectId,String divisionid,String initiationid,String projectstatus) throws Exception {

		Query query=manager.createNativeQuery(COMMITTEEAUTOSCHEDULELIST);
		query.setParameter("projectid", ProjectId );
		query.setParameter("divisionid", divisionid );
		query.setParameter("initiationid", initiationid );
		query.setParameter("projectstatus", projectstatus  );
		List<Object[]> CommitteeAutoScheduleList=(List<Object[]>)query.getResultList();
		return CommitteeAutoScheduleList;
	}
	
	@Override
	public List<Object[]> CommitteeAutoScheduleList(String ProjectId,String committeeid, String divisionid, String initiationid,String projectstatus) throws Exception 
	{
		
		Query query=manager.createNativeQuery(COMMITTEEAUTOSCHEDULELIST1);
		query.setParameter("projectid", ProjectId );
		query.setParameter("committeeid", committeeid ); 
		query.setParameter("divisionid", divisionid  );
		query.setParameter("initiationid", initiationid  );
		query.setParameter("projectstatus", projectstatus  );
		List<Object[]> CommitteeAutoScheduleList=(List<Object[]>)query.getResultList();
		return CommitteeAutoScheduleList;
	}
	

	
	@Override
	public Object[] CommitteeLastScheduleDate(String committeeid) throws Exception 
	{
		Query query=manager.createNativeQuery(COMMITTEELASTSCHEDULEDATE);	
		query.setParameter("committeeid", committeeid );
		Object[] CommitteeLastScheduleDate=(Object[])query.getSingleResult();
		return CommitteeLastScheduleDate;
	}


	@Override
	public int CommitteeProjectUpdate(String ProjectId, String CommitteeId) throws Exception {

		Query query=manager.createNativeQuery(COMMITTEEPROJECTUPDATE);
		query.setParameter("projectid", ProjectId);
		query.setParameter("committeeid", CommitteeId);		
		
		return query.executeUpdate();
	}


	@Override
	public Object[] CommitteMainMembersData(String CommitteeScheduleId, String membertype) throws Exception {

		Query query=manager.createNativeQuery(COMMITTEMAINMEMBERSDATA);
		query.setParameter("scheduleid", CommitteeScheduleId );
		query.setParameter("membertype", membertype);
		try {
		Object[] CommitteMainMembersData=(Object[])query.getSingleResult();
		return CommitteMainMembersData;
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO CommitteMainMembersData "+e);
			return null;
		}		
	}
	
	
	
	
	


	@Override
	public Object[] NotificationData(String ScheduleId, String EmpId,String Status) throws Exception {

		Query query=manager.createNativeQuery(NOTIFICATIONDATA);
		query.setParameter("scheduleid", ScheduleId );
		query.setParameter("empid", EmpId );
		query.setParameter("status", Status );
		Object[] NotificationData=null;
		
		try {
		 NotificationData=(Object[])query.getSingleResult();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO NotificationData "+e);
			
		}
		
		return NotificationData;
	}
	

	@Override
	public BigInteger MeetingCount(Date ScheduleDate,String ProjectId) throws Exception {

		if(ProjectId.equalsIgnoreCase("0")) {
			Query query=manager.createNativeQuery(MEETINGCOUNT);
			query.setParameter("scheduledate", ScheduleDate );
			query.setParameter("projectid", ProjectId );
			BigInteger MeetingCount=(BigInteger) query.getSingleResult();
			
			return MeetingCount;
		}
			
			Query query=manager.createNativeQuery(MEETINGCOUNT1);
			query.setParameter("projectid", ProjectId );
			BigInteger MeetingCount=(BigInteger) query.getSingleResult();
			
			return MeetingCount;
	
	}

	
	@Override
	public int UpdateMeetingVenue(CommitteeScheduleDto csdto) throws Exception
	{
		int ret=0;
		Query query=manager.createNativeQuery(UPDATEMEETINGVENUE);
		query.setParameter("meetingvenue", csdto.getMeetingVenue());
		query.setParameter("confidential", csdto.getConfidential());
		query.setParameter("scheduleid", csdto.getScheduleId());
		query.setParameter("reference", csdto.getReferrence());
		query.setParameter("pmrcdecisions", csdto.getPMRCDecisions());
		ret=query.executeUpdate();
		return ret;
	}


	@Override
	public Long MinutesAttachmentAdd(CommitteeMinutesAttachment attachment) throws Exception {

		manager.persist(attachment);
		manager.flush();
		
		return attachment.getMinutesAttachmentId();
	}
	
	@Override
	public List<Object[]> MinutesAttachmentList(String scheduleid ) throws Exception 
	{
		Query query=manager.createNativeQuery(MINUTESATTACHMENTLIST);
		query.setParameter("scheduleid", scheduleid);
		List<Object[]> MinutesAttachmentList=null;
		MinutesAttachmentList=query.getResultList();
		return MinutesAttachmentList;
	}
	
	
	@Override
	public int MinutesAttachmentDelete(String attachid ) throws Exception 
	{
		Query query=manager.createNativeQuery(MINUTESATTACHMENTDELETE);
		query.setParameter("attachid", attachid);		
		return query.executeUpdate();
	}
	
	@Override
	public CommitteeMinutesAttachment MinutesAttachDownload(String attachmentid) throws Exception {

		CommitteeMinutesAttachment minutesattachment= manager.find(CommitteeMinutesAttachment.class, Long.parseLong(attachmentid));
		
		return minutesattachment;
		
	}
	
	

	@Override
	public List<Object[]> PfmsCategoryList() throws Exception {
		Query query=manager.createNativeQuery(PROJECTCATEGORYLIST);
		List<Object[]> PfmsCategoryList=(List<Object[]>)query.getResultList();		

		return PfmsCategoryList;
	}

	@Override
	public int MeetingMinutesApproval(CommitteeMeetingApproval approval, CommitteeSchedule schedule)
			throws Exception {
		manager.persist(approval);

		Query query=manager.createNativeQuery(COMMITTEEAPPROVAL);
		query.setParameter("scheduleid", schedule.getScheduleId());
		query.setParameter("flag", schedule.getScheduleFlag());
		query.setParameter("modifiedby", schedule.getModifiedBy());
		query.setParameter("modifieddate", schedule.getModifiedDate());
		int count=query.executeUpdate();
		manager.flush();
		return count;
	}

	@Override
	public long MeetingMinutesApprovalNotification(PfmsNotification notification)throws Exception
	{
		manager.persist(notification);
		return notification.getNotificationId();
	}
	
	
	
	@Override
	public List<Object[]> MeetingApprovalMinutesList(String EmpId) throws Exception {
		Query query=manager.createNativeQuery("CALL Pfms_Minutes_aproval_List(:empid)");
		query.setParameter("empid", EmpId);
		List<Object[]> MeetingApprovalMinutesList=(List<Object[]>) query.getResultList();			
		return MeetingApprovalMinutesList;
	}


	
	@Override
	public int MeetingMinutesApprovalSubmit(CommitteeSchedule schedule, CommitteeMeetingApproval approval,PfmsNotification notification)throws Exception {

		manager.persist(approval);
		manager.persist(notification);

		Query query=manager.createNativeQuery(COMMITTEEAPPROVAL);
		query.setParameter("scheduleid", schedule.getScheduleId());
		query.setParameter("flag", schedule.getScheduleFlag());
		query.setParameter("modifiedby", schedule.getModifiedBy());
		query.setParameter("modifieddate", schedule.getModifiedDate());
		int count=query.executeUpdate();
		manager.flush();
		
		return count;
	}
	
	@Override
	public List<Object[]> CommitteeAllAttendance(String CommitteeScheduleId) throws Exception {

		Query query=manager.createNativeQuery(COMMITTEEALLATTENDANCE);
		query.setParameter("scheduleid", CommitteeScheduleId);	
		List<Object[]> CommitteeAttendance=(List<Object[]>) query.getResultList();
		return CommitteeAttendance;
	}


	@Override
	public List<Object[]> MeetingReports(String EmpId, String Term, String ProjectId,String divisionid,String initiationid,String logintype,String LabCode) throws Exception {

		Query query=manager.createNativeQuery("CALL Pfms_Meeting_Reports(:EmpId,:Term,:projectid,:divisionid, :initiationid,:logintype,:LabCode)");
		query.setParameter("EmpId", EmpId);
		query.setParameter("Term", Term);
		query.setParameter("projectid", ProjectId);
		query.setParameter("divisionid", divisionid);
		query.setParameter("initiationid", initiationid);
		query.setParameter("logintype", logintype);
		query.setParameter("LabCode", LabCode);
		
		List<Object[]> MeetingReports=(List<Object[]>) query.getResultList();
			
		return MeetingReports;
	}

	@Override
	public List<Object[]> MeetingReportListAll(String fdate, String tdate, String ProjectId) throws Exception {


		Query query=manager.createNativeQuery(MEETINGREPORTTOTAL);
		query.setParameter("fdate", fdate);
		query.setParameter("tdate", tdate);
		query.setParameter("ProjectId", ProjectId);

		List<Object[]> MeetingReportListAll=(List<Object[]>) query.getResultList();
		return MeetingReportListAll;
	}
	
	@Override
	public List<Object[]> MeetingReportListEmp(String fdate, String tdate, String ProjectId, String EmpId)	throws Exception {
		Query query=manager.createNativeQuery("CALL Pfms_Total_Meeting_Reports(:fdate,:tdate,:ProjectId,:EmpId)");
		query.setParameter("EmpId", EmpId);
		query.setParameter("fdate", fdate);
		query.setParameter("tdate", tdate);
		query.setParameter("ProjectId", ProjectId);
		

		List<Object[]> MeetingReportListEmp=(List<Object[]>) query.getResultList();
		return MeetingReportListEmp;
		
	}

	
	@Override
	public int UpdateCommitteeInvitationEmailSent(String committeescheduleid)throws Exception
	{
		Query query=manager.createNativeQuery(UPDATECOMMITTEEINVITATIONEMAILSENT);
		query.setParameter("committeescheduleid", committeescheduleid);
		int ret=0;
		ret=query.executeUpdate();
		return ret;
	}
	
	
	@Override
	public List<Object[]> MinutesViewAllActionList(String scheduleid) throws Exception {
		Query query=manager.createNativeQuery(MINUTESVIEWALLACTIONLIST);
		query.setParameter("scheduleid", scheduleid );
		List<Object[]>  MinutesViewAllActionList=(List<Object[]> )query.getResultList();

		return MinutesViewAllActionList;
	}
	
	
	@Override
	public List<Object[]> ProjectCommitteesList(String LabCode) throws Exception {
		Query query=manager.createNativeQuery(PROJECTCOMMITTEESLIST);		
		query.setParameter("LabCode", LabCode );
		List<Object[]>  ProjectCommitteesList=(List<Object[]> )query.getResultList();
		return ProjectCommitteesList;
	}
	
	@Override
	public List<Object[]> ProjectCommitteesListNotAdded(String projectid,String LabCode) throws Exception {
		Query query=manager.createNativeQuery(PROJECTCOMMITTEESLISTNOTADDED);
		query.setParameter("projectid", projectid );
		query.setParameter("LabCode", LabCode );
		List<Object[]>  ProjectCommitteesListNotAdded=(List<Object[]> )query.getResultList();
		return ProjectCommitteesListNotAdded;
	}
	
	@Override
	public List<Object[]> AllLabList() throws Exception 
	{
		Query query=manager.createNativeQuery(CLUSTERLABLIST);
		List<Object[]> ClusterLabList=(List<Object[]>)query.getResultList();
		return ClusterLabList;
	}
	
	private static final String CLUSTERLABS="SELECT cl.labid,cl.clusterid,cl.labname,cl.labcode FROM cluster_lab cl, cluster_lab cl2 WHERE cl2.clusterid=cl.clusterid AND  cl2.labcode=:LabCode ";
	
	@Override
	public List<Object[]> ClusterLabs(String LabCode) throws Exception 
	{
		Query query=manager.createNativeQuery(CLUSTERLABS);
		query.setParameter("LabCode", LabCode );
		List<Object[]> ClusterLabList=(List<Object[]>)query.getResultList();
		return ClusterLabList;
	}

	
	@Override
	public List<Object[]> ExternalEmployeeListFormation(String LabId ,String committeemainid) throws Exception {
		
		Query query=manager.createNativeQuery(EXTERNALEMPLOYEELISTFORMATION);
		query.setParameter("labid", LabId);
		query.setParameter("committeemainid", committeemainid);
		List<Object[]> ExternalEmployeeList=(List<Object[]>)query.getResultList();
		return ExternalEmployeeList;
	}
	

	
	@Override
	public List<Object[]> InternalEmployeeListFormation(String labcode ,String committeemainid) throws Exception {
		
		Query query=manager.createNativeQuery(INTERNALEMPLOYEELISTFORMATION);
		query.setParameter("labcode", labcode);
		query.setParameter("committeemainid", committeemainid);
		List<Object[]> ExternalEmployeeList=(List<Object[]>)query.getResultList();
		return ExternalEmployeeList;
	}
	
	
	
	@Override
	public List<Object[]> ChairpersonEmployeeList(String LabCode ,String committeemainid) throws Exception 
	{
		Query query=manager.createNativeQuery(CHAIRPERSONEMPLOYEELISTFORMATION);
		query.setParameter("labcode", LabCode);
		query.setParameter("committeemainid", committeemainid);
		List<Object[]> ChairpersonEmployeeListFormation=(List<Object[]>)query.getResultList();
		return ChairpersonEmployeeListFormation;
	}
	private static final String PRESENETERFORCOMMITTE="SELECT a.empid, CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) as 'empname' ,a.empno,b.designation FROM employee a,employee_desig b WHERE a.isactive=1 AND a.desigid=b.desigid AND a.labcode=:labcode ";
	@Override
	public List<Object[]> PreseneterForCommitteSchedule(String LabCode)throws Exception
	{
		Query query=manager.createNativeQuery(PRESENETERFORCOMMITTE);
		query.setParameter("labcode", LabCode);
		List<Object[]> result=(List<Object[]>)query.getResultList();
		return result;
	}
	
	
	
	private static final String LABINFOCLUSTERLAB = "SELECT labid,clusterid,labname,labcode FROM cluster_lab WHERE labcode =:labcode";
	@Override
	public Object[] LabInfoClusterLab(String LabCode) throws Exception 
	{
		try {
			Query query=manager.createNativeQuery(LABINFOCLUSTERLAB);
			query.setParameter("labcode", LabCode);
			Object[] LabInfoClusterLab=(Object[])query.getSingleResult();
		
			return LabInfoClusterLab;
		}
		catch (NoResultException e) 
		{
			return null;
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO LabInfoClusterLab"+e);
			e.printStackTrace();
			return null;
		}
	}
	
	
	
	private static final String CLUSTEREXPERTSLIST ="SELECT e.expertid,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.expertname) AS 'expertname' ,e.expertno,'Expert' AS designation FROM expert e WHERE e.isactive=1  AND e.expertid NOT IN (SELECT  empid FROM committee_member  WHERE isactive=1 AND labcode='@EXP' AND committeemainid=:committeemainid AND membertype IN ('CH','CO')); ";
	@Override
	public List<Object[]> ClusterExpertsList(String committeemainid) throws Exception
	{
		try {
			Query query=manager.createNativeQuery(CLUSTEREXPERTSLIST);
			query.setParameter("committeemainid", committeemainid);
			List<Object[]> DGEmpData=(List<Object[]>)query.getResultList();
			return DGEmpData;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new java.util.Date() +" Inside DAO ClusterExpertsList "+ e);
			return new ArrayList<Object[]>();
		}
	}
	
	private static final String CELISTFORCOMMITTESCHEDULE="SELECT e.expertid,e.expertname,e.expertno,'Expert' AS designation FROM expert e WHERE e.isactive=1  AND e.expertid NOT IN (SELECT  empid FROM committee_member  WHERE isactive=1 AND labcode='@EXP'  AND membertype IN ('CH','CO')); ";
	@Override
	public List<Object[]> ClusterExpertsListForCommitteeSchdule() throws Exception
	{
		try {
			Query query=manager.createNativeQuery(CELISTFORCOMMITTESCHEDULE);
		
			List<Object[]> DGEmpData=(List<Object[]>)query.getResultList();
			return DGEmpData;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new java.util.Date() +" Inside DAO ClusterExpertsListForCommitteeSchdule "+ e);
			return new ArrayList<Object[]>();
		}
		
	}
	
//	@Override
//	public List<Object[]> ChairpersonExternalEmployeeList(String LabId ,String committeemainid) throws Exception {
//		
//		logger.info(new java.util.Date() +"Inside ChairpersonExternalEmployeeList");
//		Query query=manager.createNativeQuery(CHAIRPERSONEXTERNALEMPLOYEELIST);
//		query.setParameter("labid", LabId);
//		query.setParameter("committeemainid", committeemainid);
//		List<Object[]> ExternalEmployeeList=(List<Object[]>)query.getResultList();
//		return ExternalEmployeeList;
//	}
	
	
	@Override
	public List<Object[]> ExternalEmployeeListInvitations(String labcode ,String scheduleid) throws Exception {
		
		Query query=manager.createNativeQuery(EXTERNALEMPLOYEELISTINVITATIONS);
		query.setParameter("labcode", labcode);
		query.setParameter("scheduleid", scheduleid);
		List<Object[]> ExternalEmployeeList=(List<Object[]>)query.getResultList();
		return ExternalEmployeeList;
	}

	
	@Override
	public List<Object[]> ExternalMembersNotAddedCommittee(String committeemainid) throws Exception {
		Query query=manager.createNativeQuery(EXTERNALMEMBERSNOTADDEDCOMMITTEE);
		query.setParameter("committeemainid", committeemainid );
		List<Object[]>  ExternalMembersNotAddedCommittee=(List<Object[]> )query.getResultList();
		return ExternalMembersNotAddedCommittee;
	}
	
	

	@Override
	public List<Object[]> CommitteeAllMembers(String committeemainid) throws Exception {
		Query query=manager.createNativeQuery("CALL Pfms_Committee_All_Members(:committeemainid); ");
		query.setParameter("committeemainid", committeemainid );
		List<Object[]>  CommitteeAllMembers=(List<Object[]> )query.getResultList();
		return CommitteeAllMembers;
	}
	
	
	
	@Override
	public List<Object[]> EmployeeListNoInvitedMembers(String scheduleid,String LabCode) throws Exception {
		Query query=manager.createNativeQuery(EMPLOYEELISTNOINVITEDMEMBERS);
		query.setParameter("scheduleid", scheduleid );
		query.setParameter("LabCode", LabCode );
		List<Object[]>  EmployeeListNoInvitedMembers=(List<Object[]> )query.getResultList();
		return EmployeeListNoInvitedMembers;
	}
	
	
	@Override
	public List<Object[]> ExternalMembersNotInvited(String scheduleid) throws Exception {
		Query query=manager.createNativeQuery(EXPERTLISTNOINVITEDMEMBERS);
		query.setParameter("scheduleid", scheduleid );
		List<Object[]>  ExpertListNoInvitedMembers=(List<Object[]> )query.getResultList();
		return ExpertListNoInvitedMembers;
	}
	
	@Override
	public Object[] ProjectBasedMeetingStatusCount(String projectid) throws Exception
	{
		Query query=manager.createNativeQuery(" CALL Pfms_Meetings_Status_Count(:projectid);");
		query.setParameter("projectid", projectid);
		Object[] ProjectBasedMeetingStatusCount = (Object[]) query.getSingleResult();
		return ProjectBasedMeetingStatusCount;
	}
	
	 
	
		
	@Override
	public List<Object[]> allprojectdetailsList() throws Exception {
		
		Query query=manager.createNativeQuery(ALLPROJECTDETAILSLIST);		
		return (List<Object[]>)query.getResultList();
	}
	
	@Override
	public List<Object[]> PfmsMeetingStatusWiseReport(String projectid,String statustype) throws Exception
	{		
		Query query=manager.createNativeQuery("CALL Pfms_Meeting_Status_Wise_Report (:projectid,:statustype);");
		query.setParameter("projectid", projectid);
		query.setParameter("statustype", statustype);
		List<Object[]> PfmsMeetingStatusWiseReport = (List<Object[]>)query.getResultList();
		return PfmsMeetingStatusWiseReport;
	}
	
	
	
	@Override
	public List<Object[]> ProjectCommitteeFormationCheckList(String projectid) throws Exception
	{		
		Query query=manager.createNativeQuery(PROJECTCOMMITTEEFORMATIONCHECKLIST);
		query.setParameter("projectid", projectid);		
		List<Object[]> ProjectCommitteeFormationCheckList = (List<Object[]>)query.getResultList();
		return ProjectCommitteeFormationCheckList;
	}
	
	
	@Override
	public Object[] ProjectCommitteeDescriptionTOR(String projectid,String Committeeid) throws Exception
	{		
		Query query=manager.createNativeQuery(PROJECTCOMMITTEEDESCRIPTIONTOR);
		query.setParameter("committeeid", Committeeid);	
		query.setParameter("projectid", projectid);	
		Object[] ProjectCommitteeFormationCheckList = (Object[])query.getSingleResult();
		return ProjectCommitteeFormationCheckList;
	}
	
	
	@Override
	public Object[] DivisionCommitteeDescriptionTOR(String divisionid,String Committeeid) throws Exception
	{		
		Query query=manager.createNativeQuery(DIVISIONCOMMITTEEDESCRIPTIONTOR);
		query.setParameter("committeeid", Committeeid);	
		query.setParameter("divisionid", divisionid);	
		Object[] DivisionCommitteeDescriptionTOR = (Object[])query.getSingleResult();
		return DivisionCommitteeDescriptionTOR;
	}
	
	@Override
	public int ProjectCommitteeDescriptionTOREdit( CommitteeProject  committeeproject ) throws Exception
	{		
		Query query=manager.createNativeQuery(PROJECTCOMMITTEEDESCRIPTIONTOREDIT);
		query.setParameter("description", committeeproject.getDescription());	
		query.setParameter("termsofreference", committeeproject.getTermsOfReference());	
		query.setParameter("modifiedby", committeeproject.getModifiedBy());	
		query.setParameter("modifieddate", committeeproject.getModifiedDate());	
		query.setParameter("committeeprojectid", committeeproject.getCommitteeProjectId() );	
		int ProjectCommitteeFormationCheckList = query.executeUpdate();
		return ProjectCommitteeFormationCheckList;
	}
	
	
	@Override
	public int DivisionCommitteeDescriptionTOREdit(CommitteeDivision committeedivision) throws Exception
	{		
		Query query=manager.createNativeQuery(DIVISIONCOMMITTEEDESCRIPTIONTOREDIT);
		query.setParameter("description", committeedivision.getDescription());	
		query.setParameter("termsofreference", committeedivision.getTermsOfReference());	
		query.setParameter("modifiedby", committeedivision.getModifiedBy());	
		query.setParameter("modifieddate", committeedivision.getModifiedDate());	
		query.setParameter("committeedivisionid", committeedivision.getCommitteeDivisionId() );	
		int ProjectCommitteeFormationCheckList = query.executeUpdate();
		return ProjectCommitteeFormationCheckList;
	}
	
	


	@Override
	public  CommitteeScheduleAgenda CommitteePreviousAgendaGet(String agendaid) throws Exception
	{
		CommitteeScheduleAgenda scheduleagenda= manager.find(CommitteeScheduleAgenda.class,Long.parseLong(agendaid));
		return scheduleagenda;
	}

	@Override
	public int ScheduleMinutesUnitUpdate(String UnitId, String Unit, String UserId,String dt) throws Exception {
		Query query=manager.createNativeQuery(UPDATEUNIT);
		query.setParameter("unitid", UnitId);	
		query.setParameter("unitname",Unit);	
		query.setParameter("createdby", UserId);	
		query.setParameter("createddate", dt);	
		int ScheduleMinutesUnitUpdate = query.executeUpdate();
		return ScheduleMinutesUnitUpdate;
	}

	
	@Override
	public List<Object[]> divisionList() throws Exception {
		Query query=manager.createNativeQuery(DIVISIONLIST);
		
		List<Object[]> divisionList=(List<Object[]>)query.getResultList();	
		return divisionList;
	}
	
		@Override
	public List<Object[]> LoginDivisionList(String empid) throws Exception {
		Query query=manager.createNativeQuery(LOGINDIVISIONLIST);
		query.setParameter("empid", empid);
		List<Object[]> divisionList=(List<Object[]>)query.getResultList();	
		return divisionList;
	}
	
	@Override
	public List<Object[]> CommitteedivisionAssigned(String divisionid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEDIVISIONASSIGNED);
		query.setParameter("divisionid", divisionid);	
		List<Object[]> CommitteedivisionAssigned=(List<Object[]>)query.getResultList();	
		return CommitteedivisionAssigned;
	}
	
	
	
	@Override
	public List<Object[]> CommitteedivisionNotAssigned(String divisionid, String LabCode ) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEDIVISIONNOTASSIGNED);
		query.setParameter("divisionid", divisionid);	
		query.setParameter("LabCode", LabCode);
		List<Object[]> CommitteedivisionNotAssigned=(List<Object[]>)query.getResultList();	
		return CommitteedivisionNotAssigned;
		
	}
	
	@Override
	public long DivisionCommitteeAdd(CommitteeDivision committeedivision) throws Exception
	{		
		manager.persist(committeedivision);
		manager.flush();		
		return  committeedivision.getCommitteeDivisionId();
	}
	
	
	
	
	@Override
	public List<Object[]> DivisionCommitteeFormationCheckList(String divisionid) throws Exception
	{		
		Query query=manager.createNativeQuery(DIVISIONCOMMITTEEFORMATIONCHECKLIST);
		query.setParameter("divisionid", divisionid);		
		List<Object[]> CommitteeFormationCheckList = (List<Object[]>)query.getResultList();
		return CommitteeFormationCheckList;
	}
	
	
	@Override
	public  long DivisionCommitteeDelete(CommitteeDivision committeedivision ) throws Exception
	{
		Query query=manager.createNativeQuery(DIVISIONCOMMITTEEDELETE);
		query.setParameter("committeedivisionid", committeedivision.getCommitteeDivisionId());				
		return query.executeUpdate();

	}
	

	@Override
	public  Object[] DivisionData(String divisionid) throws Exception
	{
		Query query=manager.createNativeQuery(DIVISIONDATA);
		try {
		query.setParameter("divisionid", divisionid);		
		return (Object[])query.getSingleResult();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO DivisionData "+e);
			return null;
		}
	}
	

	

	
	@Override
	public List<Object[]> DivisionCommitteeMainList(String divisionid) throws Exception 
	{
		Query query=manager.createNativeQuery(DIVISIONCOMMITTEEMAINLIST);
		query.setParameter("divisionid", divisionid);	
		List<Object[]> DivisionCommitteeMainList=(List<Object[]>)query.getResultList();
		return DivisionCommitteeMainList;
	}
	
	
	@Override
	public List<Object[]> DivisionScheduleListAll(String divisionid) throws Exception
	{
		Query query=manager.createNativeQuery(DIVISIONSCHEDULELISTALL);
		query.setParameter("divisionid",divisionid);
		return (List<Object[]>) query.getResultList();
	}

	
	@Override
	public List<Object[]> DivisionCommitteeScheduleList(String divisionid,String committeeid) throws Exception
	{
		Query query=manager.createNativeQuery(DIVISIONCOMMITTEESCHEDULELIST);
		query.setParameter("divisionid",divisionid);
		query.setParameter("committeeid",committeeid);
		return (List<Object[]>) query.getResultList();
	}

	
	
	@Override
	public List<Object[]> DivisionMasterList(String divisionid) throws Exception {
		
		Query query=manager.createNativeQuery(DIVISIONMASTERLIST);
		query.setParameter("divisionid", divisionid );
		List<Object[]> divisionmasterlist=null;
		try {
			divisionmasterlist=(List<Object[]>)query.getResultList();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO DivisionMasterList "+e);
			return null;
		}
		return divisionmasterlist;
	}

	
	
	@Override
	public List<Object[]> DivCommitteeAutoScheduleList(String divisionid) throws Exception {

		Query query=manager.createNativeQuery(DIVCOMMITTEEAUTOSCHEDULELIST);
		query.setParameter("divisionid", divisionid );
		List<Object[]> divcommitteeautoschedulelist=(List<Object[]>)query.getResultList();
		return divcommitteeautoschedulelist;
	}
	
	
	@Override
	public List<Object[]> CommitteeActionList(String EmpId) throws Exception {
		
		Query query=manager.createNativeQuery(COMMITTEEACTIONDATA);
		query.setParameter("scheduleid", EmpId);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}

	
	@Override
	public int CommitteeDivisionUpdate(String divisionid, String CommitteeId) throws Exception 
	{
		Query query=manager.createNativeQuery(COMMITTEEDIVISIONUPDATE);
		query.setParameter("divisionid", divisionid);
		query.setParameter("committeeid", CommitteeId);		
		
		return query.executeUpdate();
	}
	
	


	@Override
	public List<Object[]> MinutesOutcomeList() throws Exception {
		Query query=manager.createNativeQuery(OUTCOMELIST);
		List<Object[]> AssignedList=(List<Object[]>)query.getResultList();	
		return AssignedList;
	}
	
	
	@Override
	public List<Object[]> InitiatedProjectDetailsList()throws Exception
	{
		Query query=manager.createNativeQuery(INITIATEDPROJECTDETAILSLIST);
		List<Object[]> InitiatedProjectDetailsList=(List<Object[]>)query.getResultList();
		return InitiatedProjectDetailsList;
	}
	
	
	
	
	@Override
	public List<Object[]> InitiationMasterList(String initiationid) throws Exception {
		
		Query query=manager.createNativeQuery(INITIATIONMASTERLIST);
		query.setParameter("initiationid", initiationid );
		List<Object[]> InitiationMasterList=(List<Object[]>)query.getResultList();
		return InitiationMasterList;
	}
	
	@Override
	public List<Object[]> InitiationCommitteeFormationCheckList(String initiationid) throws Exception
	{		
		Query query=manager.createNativeQuery(INITIATIONCOMMITTEEFORMATIONCHECKLIST);
		query.setParameter("initiationid", initiationid);		
		List<Object[]> InitiationCommitteeFormationCheckList = (List<Object[]>)query.getResultList();
		return InitiationCommitteeFormationCheckList;
	}
	
	
	@Override
	public List<Object[]> InitiationCommitteesListNotAdded(String initiationid,String LabCode) throws Exception {
		Query query=manager.createNativeQuery(INITIATIONCOMMITTEESLISTNOTADDED);
		query.setParameter("initiationid", initiationid );
		query.setParameter("LabCode", LabCode );
		List<Object[]>  InitiationCommitteesListNotAdded=(List<Object[]> )query.getResultList();
		return InitiationCommitteesListNotAdded;
	}
	
	
	
	
	@Override
	public int InvitationSerialnoUpdate(String invitationid,String newslno) throws Exception
	{
			Query query =manager.createNativeQuery(INVITATIONSERIALNOUPDATE);
			query.setParameter("newslno", newslno);
			query.setParameter("invitationid", invitationid);
			int count=(int)query.executeUpdate();
			
			return count;
	}
	
	
	@Override
	public List<Object[]> CommitteeRepList() throws Exception
	{
			Query query =manager.createNativeQuery(COMMITTREPLIST);
			List<Object[]> CommittRepList=(List<Object[]>)query.getResultList();
			return CommittRepList;
	}
	
	@Override
	public long CommitteeRepMembersSubmit(CommitteeMemberRep memreps) throws Exception {
		
		manager.persist(memreps);		
		return memreps.getMemberRepId();
	}
	
	
	
	@Override
	public List<Object[]> CommitteeMemberRepList(String committeemainid) throws Exception
	{
			Query query =manager.createNativeQuery(COMMITTEEMEMBERREPLIST);
			query.setParameter("committeemainid", committeemainid);
			List<Object[]> CommitteeMemberRepList=(List<Object[]>)query.getResultList();
			return CommitteeMemberRepList;
	}
	
	@Override
	public List<Object[]> CommitteeRepNotAddedList(String committeemainid) throws Exception
	{
			Query query =manager.createNativeQuery(COMMITTEEREPNOTADDEDLIST);
			query.setParameter("committeemainid", committeemainid);
			List<Object[]> CommitteeRepNotAddedList=(List<Object[]>)query.getResultList();
			return CommitteeRepNotAddedList;
	}
	
	
	
	@Override
	public int CommitteeMemberRepDelete(String memberrepid) throws Exception
	{
			Query query =manager.createNativeQuery(COMMITTEEMEMBERREPDELETE);
			query.setParameter("memberrepid", memberrepid);
			return query.executeUpdate();
	}
	
	@Override
	public List<Object[]> CommitteeAllMembersList(String committeemainid) throws Exception
	{
			Query query =manager.createNativeQuery("CALL Pfms_Committee_All_Members(:committeemainid);");
			query.setParameter("committeemainid", committeemainid);
			return query.getResultList();
	}
	
	
	@Override
	public List<Object[]> EmployeeListWithoutMembers(String committeemainid,String LabCode) throws Exception {
		Query query=manager.createNativeQuery(EMPLOYEELISTWITHOUTMEMBERS);
		query.setParameter("committeemainid", committeemainid);
		query.setParameter("labcode", LabCode);
		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();	
		return EmployeeList;
	}
	
	@Override
	public int CommitteeMemberUpdate(CommitteeMember model) throws Exception {
		Query query=manager.createNativeQuery(COMMITTEEMEMBERUPDATE);
		query.setParameter("committeememberid", model.getCommitteeMemberId());
		query.setParameter("labcode", model.getLabCode());
		query.setParameter("empid", model.getEmpId());
		query.setParameter("modifiedby", model.getModifiedBy());
		query.setParameter("modifieddate", model.getModifiedDate());
		return query.executeUpdate();
	}
	
	

	@Override
	public Object[] CommitteMainData(String committeemainid) throws Exception 
	{
		Query query=manager.createNativeQuery(COMMITTEMAINDATA);
		query.setParameter("committeemainid", committeemainid );		
		try {
		Object[] CommitteeAutoScheduleList=(Object[])query.getSingleResult();
		return CommitteeAutoScheduleList;
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO CommitteMainData "+e);
			return null;
		}		
	}
	
	
	
	@Override
	public  long InitiationCommitteeDelete(CommitteeInitiation model) throws Exception
	{
		Query query=manager.createNativeQuery(INITIATIONCOMMITTEEDELETE);
		query.setParameter("committeeinitiationid", model.getCommitteeInitiationId());
		return query.executeUpdate();
	}
	
	
	
	@Override
	public Object[] Initiationdetails(String initiationid) throws Exception
	{		
		Query query=manager.createNativeQuery(INITIATIONDETAILS);
		try {
		query.setParameter("initiationid",initiationid);
		return (Object[]) query.getResultList().get(0);
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO Initiationdetails "+ e);
			return null;	
		}
		
	}
	
	
	@Override
	public Object[] InitiationCommitteeDescriptionTOR(String initiationid,String Committeeid) throws Exception
	{		
		Query query=manager.createNativeQuery(INITIATIONCOMMITTEEDESCRIPTIONTOR);
		query.setParameter("committeeid", Committeeid);	
		query.setParameter("initiationid", initiationid);	
		Object[] InitiationCommitteeDescriptionTOR = (Object[])query.getSingleResult();
		return InitiationCommitteeDescriptionTOR;
	}
	
	
	@Override
	public int InitiationCommitteeDescriptionTOREdit(CommitteeInitiation committeedivision) throws Exception
	{		
		Query query=manager.createNativeQuery(INITIATIONCOMMITTEEDESCRIPTIONTOREDIT);
		query.setParameter("description", committeedivision.getDescription());	
		query.setParameter("termsofreference", committeedivision.getTermsOfReference());	
		query.setParameter("modifiedby", committeedivision.getModifiedBy());	
		query.setParameter("modifieddate", committeedivision.getModifiedDate());	
		query.setParameter("committeeinitiationid", committeedivision.getCommitteeInitiationId() );	
		int ProjectCommitteeFormationCheckList = query.executeUpdate();
		return ProjectCommitteeFormationCheckList;
	}
	
	
	@Override
	public List<Object[]> InitiaitionMasterList(String initiationid) throws Exception 
	{		
		Query query=manager.createNativeQuery(INITIAITIONMASTERLIST);
		query.setParameter("initiationid", initiationid );
		List<Object[]> InitiaitionMasterList=(List<Object[]>)query.getResultList();
		return InitiaitionMasterList;
	}
	
	
	@Override
	public int CommitteeInitiationUpdate(String initiationid, String CommitteeId) throws Exception 
	{
		Query query=manager.createNativeQuery(COMMITTEEINITIATIONUPDATE);
		query.setParameter("initiationid", initiationid);
		query.setParameter("committeeid", CommitteeId);		
		return query.executeUpdate();
	}
	
	@Override
	public List<Object[]> InitiationCommitteeMainList(String initiationid) throws Exception 
	{
		Query query=manager.createNativeQuery(INITIATIONCOMMITTEEMAINLIST);
		query.setParameter("initiationid", initiationid);	
		List<Object[]> InitiationCommitteeMainList=(List<Object[]>)query.getResultList();
		return InitiationCommitteeMainList;
	}
	
	
	@Override
	public List<Object[]> InitiationScheduleListAll(String initiationid) throws Exception
	{
		Query query=manager.createNativeQuery(INITIATIONSCHEDULELISTALL);
		query.setParameter("initiationid",initiationid);
		return (List<Object[]>) query.getResultList();
	}
	
	
	
	@Override
	public List<Object[]> InitiationCommitteeScheduleList(String initiationid,String committeeid) throws Exception
	{
		Query query=manager.createNativeQuery(INITIATIONCOMMITTEESCHEDULELIST);
		query.setParameter("initiationid",initiationid);
		query.setParameter("committeeid",committeeid);
		return (List<Object[]>) query.getResultList();
	}
	
	
	@Override
	public Object[] ProposedCommitteeMainId(String committeemainid) throws Exception
	{
		Query query=manager.createNativeQuery(PROPOSEDCOMMITTEEMAINID);
		try {
			query.setParameter("committeemainid",committeemainid);
			return (Object[]) query.getSingleResult();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO ProposedCommitteeMainId "+e);
			return null;	
		}
		
	}
	
	
	@Override
	public Object[] GetProposedCommitteeMainId(String committeeid,String projectid,String divisionid,String initiationid) throws Exception
	{
		Query query=manager.createNativeQuery(GETPROPOSEDCOMMITTEEMAINID);
		try {
			query.setParameter("committeeid",committeeid);
			query.setParameter("projectid",projectid);
			query.setParameter("divisionid",divisionid);
			query.setParameter("initiationid",initiationid);
			return (Object[]) query.getResultList().get(0);
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO GetProposedCommitteeMainId "+e);
			return null;	
		}
		
	}
	
	
	
	@Override
	public Object[] CommitteeMainApprovalData(String committeemainid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEMAINAPPROVALDATA);
		try {
			query.setParameter("committeemainid",committeemainid);
			return (Object[]) query.getResultList().get(0);
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO CommitteeMainApprovalData "+e);
			return null;	
		}		
	}	
	
	@Override
	public long CommitteeConstitutionApprovalAdd(CommitteeConstitutionApproval model) throws Exception
	{		
		manager.persist(model);		
		return model.getConstitutionApprovalId();
	}
	
	
	
	@Override
	public int CommitteeApprovalUpdate(CommitteeConstitutionApproval model) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEAPPROVALUPDATE);
		try {
			query.setParameter("committeemainid",model.getCommitteeMainId());
			query.setParameter("constitutionstatus",model.getConstitutionStatus());
			//query.setParameter("emplabid",model.getEmpLabid());
			//query.setParameter("empid",model.getEmpid());
			query.setParameter("actionby",model.getActionBy());
			query.setParameter("actiondate",model.getActionDate());
			query.setParameter("remarks",model.getRemarks());
			
			return query.executeUpdate();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO CommitteeApprovalUpdate "+ e);
			return 0;	
		}
		
	}
	
	
	@Override
	public int updatecommitteeapprovalauthority(CommitteeConstitutionApproval model) throws Exception
	{
		
		try {
			Query query=manager.createNativeQuery(UPDATECOMMITTEEAPPROVALAUTHORITY);
			query.setParameter("approvalauthority",model.getApprovalAuthority());
			query.setParameter("committeemainid",model.getCommitteeMainId());
			
			return query.executeUpdate();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO updatecommitteeapprovalauthority "+ e);
			return 0;	
		}
		
	}
	
	
	
	
	@Override
	public List<Object[]> ProposedCommitteList() throws Exception
	{
		Query query=manager.createNativeQuery(PROPOSEDCOMMITTELIST);
		return (List<Object[]>)query.getResultList();
	}
	
	
	@Override
	public List<Object[]> ApprovalStatusList(String committeemainid ) throws Exception
	{
		
		try {			
			Query query=manager.createNativeQuery(APPROVALSTATUSLIST);
			query.setParameter("committeemainid",committeemainid);
			List<Object[]> ApprovalStatusList =(List<Object[]>) query.getResultList();
			return ApprovalStatusList ;
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO ApprovalStatusList "+ e);
			return null;	
		}
		
		
		
	}
	
	
	
	@Override
	public int NewCommitteeMainIsActiveUpdate(CommitteeConstitutionApprovalDto dto ) throws Exception
	{
		try {	
			Query query=manager.createNativeQuery(NEWCOMMITTEEMAINISACTIVEUPDATE);
			query.setParameter("committeemainid",dto.getCommitteeMainId());
			query.setParameter("modifiedby",dto.getActionBy());
			query.setParameter("modifieddate",dto.getActionDate());
			return query.executeUpdate();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO NewCommitteeMainIsActiveUpdate "+ e);
			e.printStackTrace();
			return 0;	
		}
	}
	
	
	@Override
	public List<Object[]> ProposedCommitteesApprovalList(String logintype,String empid) throws Exception
	{
		Query query=manager.createNativeQuery("CALL Pfms_Com_Con_Approval(:logintype, :empid);");
		query.setParameter("logintype",logintype);
		query.setParameter("empid",empid);
		return (List<Object[]>)query.getResultList();
	}
	
	
	
	@Override
	public Object[] LoginData(String loginid) throws Exception
	{
		Query query=manager.createNativeQuery(LOGINDATA);
		query.setParameter("loginid",loginid);
		return (Object[])query.getSingleResult();
	}
	
	
	@Override
	public List<Object[]> DORTMDData() throws Exception
	{
		Query query=manager.createNativeQuery(DORTMDDATA);
		return (List<Object[]>)query.getResultList();
	}
	
	
	@Override
	public long ConstitutionApprovalHistoryAdd(CommitteeConstitutionHistory model) throws Exception
	{		
		manager.persist(model);		
		return model.getCommitteeHistoryId();
	}
	
	
	
	
	@Override
	public List<Object[]>  ComConstitutionApprovalHistory(String committeemainid) throws Exception
	{
		Query query=manager.createNativeQuery(COMCONSTITUTIONAPPROVALHISTORY);
		query.setParameter("committeemainid",committeemainid);
		return (List<Object[]>)query.getResultList();
	}
	

	@Override
	public Object[]  ComConstitutionEmpdetails(String committeemainid) throws Exception
	{
		Query query=manager.createNativeQuery(COMCONSTITUTIONEMPDETAILS);
		query.setParameter("committeemainid",committeemainid);
		try {
			return (Object[])query.getSingleResult();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO ComConstitutionEmpdetails "+ e);
			return null;
		}
	}
	
	
	@Override
	public Object[]  DoRtmdAdEmpData() throws Exception
	{
		Query query=manager.createNativeQuery(DORTMDADEMPDATA);
		try {
			return (Object[])query.getResultList().get(0);
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO DoRtmdAdEmpData "+ e);
			return null;
		}
	}
	
	
	@Override
	public Object[]  DirectorEmpData(String LabCode) throws Exception
	{
		try {
			Query query=manager.createNativeQuery(DIRECTOREMPDATA);
			query.setParameter("LabCode",LabCode);
			return (Object[])query.getResultList().get(0);
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO DirectorEmpData "+ e);
			return null;
		}
	}
	
	
	@Override
	public Object[]  CommitteeMainApprovalDoData(String committeemainid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEMAINAPPROVALDODATA);
		query.setParameter("committeemainid",committeemainid);
		try {
			return (Object[])query.getSingleResult();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO CommitteeMainApprovalDoData "+ e);
			return null;
		}
		
	}
	
	
	
	
	@Override
	public int  CommitteeMinutesDelete(String scheduleminutesid) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEMINUTESDELETE);
		query.setParameter("scheduleminutesid",scheduleminutesid);
		return query.executeUpdate();
	}
	
	
	@Override
	public Object[]  CommitteeConStatusDetails(String status) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEECONSTATUSDETAILS);
		query.setParameter("status",status);
		return (Object[])query.getSingleResult();
	}
	
	@Override
	public int  CommitteeScheduleDelete(CommitteeScheduleDto dto) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEDELETE);
		query.setParameter("modifiedby",dto.getModifiedBy());
		query.setParameter("modifieddate",dto.getModifiedDate());
		query.setParameter("scheduleid",dto.getScheduleId());
		return query.executeUpdate();
	}
	
	@Override
	public int  CommitteeScheduleAgendaDelete(CommitteeScheduleDto dto) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEAGENDADELETE);
		query.setParameter("modifiedby",dto.getModifiedBy());
		query.setParameter("modifieddate",dto.getModifiedDate());
		query.setParameter("scheduleid",dto.getScheduleId());
		return query.executeUpdate();
	}
	
	
	
	
	@Override
	public int  CommitteeScheduleInvitationDelete(CommitteeScheduleDto dto) throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEESCHEDULEINVITATIONDELETE);
		query.setParameter("scheduleid",dto.getScheduleId());
		return query.executeUpdate();
	}
	
	
	@Override
	public List<Object[]> ScheduleCommitteeEmpCheck(String scheduleid ,String empid) throws Exception
	{
		Query query=manager.createNativeQuery(SCHEDULECOMMITTEEEMPCHECK);
		query.setParameter("scheduleid",scheduleid);
		query.setParameter("empid",empid);
		return (List<Object[]>)query.getResultList();
	}
	
	
	@Override
	public List<Object[]> ScheduleCommitteeEmpinvitedCheck(String scheduleid ,String empid) throws Exception
	{
		Query query=manager.createNativeQuery(SCHEDULECOMMITTEEEMPINVITEDCHECK);
		query.setParameter("scheduleid",scheduleid);
		query.setParameter("empid",empid);
		return (List<Object[]>)query.getResultList();
	}
	
	
	@Override
	public List<Object[]> EmpScheduleData(String empid,String scheduleid) throws Exception 
	{
		Query query=manager.createNativeQuery(EMPSCHEDULEDATA);
		query.setParameter("empid", empid );
		query.setParameter("scheduleid", scheduleid );
		List<Object[]> EmpScheduleData=(List<Object[]>)query.getResultList();
		return EmpScheduleData;
	}
	
	
	@Override
	public List<Object[]> AllActionAssignedCheck(String scheduleid) throws Exception 
	{
		Query query=manager.createNativeQuery(ALLACTIONASSIGNEDCHECK);
		query.setParameter("scheduleid", scheduleid );
		List<Object[]> AllActionAssignedCheck=(List<Object[]>)query.getResultList();
		return AllActionAssignedCheck;
	}
	
	
	@Override
	public List<Object[]> DefaultAgendaList(String committeeid,String LabCode) throws Exception 
	{
		Query query=manager.createNativeQuery(DEFAULTAGENDALIST);
		query.setParameter("committeeid", committeeid );
		query.setParameter("LabCode", LabCode );
		List<Object[]> DefaultAgendaList=(List<Object[]>)query.getResultList();
		return DefaultAgendaList;
	}
	
	
	@Override
	public List<Object[]> ProcurementStatusList(String projectid)throws Exception{
		Query query = manager.createNativeQuery(PROCUREMETSSTATUSLIST);
		query.setParameter("projectid", projectid);
		List<Object[]> ProcurementStatusList= query.getResultList();
		return ProcurementStatusList;
		
	}
	
	@Override
	public List<Object[]> ActionPlanSixMonths(String projectid)throws Exception
	{
		List<Object[]> ActionPlanThreeMonths=new ArrayList<Object[]>();
		Query query = manager.createNativeQuery("CALL Pfms_Milestone_PDC_New(:projectid, 180);");
		query.setParameter("projectid", projectid);
		try {
			ActionPlanThreeMonths= query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new java.util.Date() +" Inside DAO ActionPlanSixMonths " + e);
		}
		return ActionPlanThreeMonths;
	}
	
	private static final String PROJECTDATADETAILS="SELECT ppd.projectdataid,ppd.projectid,ppd.filespath,ppd.systemconfigimgname,ppd.SystemSpecsFileName,ppd.ProductTreeImgName,ppd.PEARLImgName,ppd.CurrentStageId,ppd.RevisionNo,pps.projectstagecode,pps.projectstage,pps.stagecolor,pm.projectcode,ppd.proclimit/100000  FROM pfms_project_data ppd, pfms_project_stage pps,project_master pm WHERE ppd.projectid=pm.projectid AND ppd.CurrentStageId=pps.projectstageid AND ppd.projectid=:projectid";
	@Override
	public Object[] ProjectDataDetails(String projectid) throws Exception 
	{
		Query query=manager.createNativeQuery(PROJECTDATADETAILS);
		query.setParameter("projectid", projectid);
		Object[] ProjectStageDetails=null;
		try {
			ProjectStageDetails=(Object[])query.getSingleResult();
		}catch (Exception e) {
			logger.error(new java.util.Date() +" Inside DAO ProjectDataDetails "+ e);
			return null;
		}
		
		return ProjectStageDetails;
	}
	@Override
	public List<Object[]> LastPMRCActions(long scheduleid,String committeeid,String proid,String isFrozen) throws Exception 
	{
		System.out.println( scheduleid+"   "+committeeid+"   "+ proid+"   "+isFrozen);
		Query query=manager.createNativeQuery("CALL last_pmrc_actions_list_new(:scheduleid,:committeeid,:proid,:isFrozen)");	   
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("committeeid",committeeid);
		query.setParameter("proid",proid);
		query.setParameter("isFrozen",isFrozen);
		List<Object[]> LastPMRCActions=(List<Object[]>)query.getResultList();			
		return LastPMRCActions;		
	}
	
	@Override
	public List<Object[]> CommitteeMinutesSpecNew()throws Exception
	{
		Query query=manager.createNativeQuery(COMMITTEEMINUTESSPECNEW);
		 List<Object[]> CommitteeMinutesSpecNew=(List<Object[]>) query.getResultList();
		return CommitteeMinutesSpecNew;
	}
	
	
	@Override 
	public List<Object[]> MilestoneSubsystems(String projectid) throws Exception 
	{
		Query query=manager.createNativeQuery(MILESTONESUBSYSTEMS);	   
		query.setParameter("projectid", projectid);
		List<Object[]> MilestoneSubsystems=(List<Object[]>)query.getResultList();	
		return MilestoneSubsystems;
	}
	
	@Override 
	public List<Object[]> EmployeeScheduleReports(String empid, String fromdate,String todate) throws Exception 
	{
		Query query=manager.createNativeQuery("CALL Pfms_Emp_Report (:empid,:fromdate,:todate)");	   
		query.setParameter("empid", empid);
		query.setParameter("fromdate", fromdate);
		query.setParameter("todate", todate);
		List<Object[]> EmployeeScheduleList=(List<Object[]>)query.getResultList();	
		return EmployeeScheduleList;
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
	
	
	@Override
	public List<Object[]> FileRepMasterListAll(String projectid,String LabCode)throws Exception
	{
		Query query=manager.createNativeQuery(FILEREPMASTERLISTALL);
		query.setParameter("projectid", projectid);
		query.setParameter("LabCode", LabCode);
		List<Object[]> FileRepMasterListAll=(List<Object[]>)query.getResultList();
		return FileRepMasterListAll;
	}
	
	
	@Override
	public Object[] AgendaDocLinkDownload(String filerepid)throws Exception
	{
		Query query=manager.createNativeQuery(AGENDADOCLINKDOWNLOAD);
		query.setParameter("filerepid", filerepid);
		List<Object[]> FileRepMasterListAll=(List<Object[]>)query.getResultList();
		if(FileRepMasterListAll.size()>0) {
		return FileRepMasterListAll.get(0);
		}else {
			return null;
		}
	}
	
	
	@Override
	public List<Object[]> MilestoneActivityList(String ProjectId) throws Exception {

		Query query=manager.createNativeQuery(MALIST);
		query.setParameter("ProjectId", ProjectId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}
	
	
	@Override
	public List<Object[]> MilestoneActivityLevel(String MilestoneActivityId,String LevelId) throws Exception {
		Query query=manager.createNativeQuery(MILEACTIVITYLEVEL);
		query.setParameter("id", MilestoneActivityId);
		query.setParameter("levelid", LevelId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}
	
	
	@Override
	public List<Object[]> AgendaLinkedDocList(String scheduleid) throws Exception {
		Query query=manager.createNativeQuery(AGENDALINKEDDOCLIST);
		query.setParameter("scheduleid", scheduleid);
		List<Object[]> AgendaLinkedDocList=(List<Object[]>)query.getResultList();
		return AgendaLinkedDocList;
	}
	
	@Override
	public CommitteeScheduleAgendaDocs AgendaUnlinkDoc(CommitteeScheduleAgendaDocs agendadoc) throws Exception {
		CommitteeScheduleAgendaDocs detachedentity = manager.find(CommitteeScheduleAgendaDocs.class, agendadoc.getAgendaDocid());
		detachedentity.setIsActive(0);
		detachedentity.setModifiedBy(agendadoc.getModifiedBy());
		detachedentity.setModifiedDate(agendadoc.getModifiedDate());
		try {
			return manager.merge(detachedentity);
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO AgendaUnlinkDoc"+e);
			e.printStackTrace();
			return null;
		}
	}
	
	private static final String PREDEFAGENDAEDIT = "UPDATE committee_default_agenda SET agendaitem=:agendaitem , remarks = :remarks , duration = :duration, modifiedby=:modifiedby , modifieddate=:modifieddate WHERE DefaultAgendaId= :DefaultAgendaId ";
	
	@Override
	public int PreDefAgendaEdit(CommitteeDefaultAgenda agenda) throws Exception 
	{
		Query query=manager.createNativeQuery(PREDEFAGENDAEDIT);
		query.setParameter("agendaitem", agenda.getAgendaItem());
		query.setParameter("remarks", agenda.getRemarks());
		query.setParameter("duration", agenda.getDuration());
		query.setParameter("modifiedby", agenda.getModifiedBy());
		query.setParameter("modifieddate", agenda.getModifiedDate());
		query.setParameter("DefaultAgendaId", agenda.getDefaultAgendaId());
		return query.executeUpdate();
	}

	
	@Override
	public long PreDefAgendaAdd(CommitteeDefaultAgenda agenda) throws Exception 
	{
		manager.persist(agenda);
		manager.flush();
		return agenda.getDefaultAgendaId();
	}
	
	private static final String PREDEFAGENDADELETE=  "UPDATE committee_default_agenda set isactive=0 WHERE DefaultAgendaId=:DefaultAgendaId ";
	
	@Override
	public int PreDefAgendaDelete(String DefaultAgendaId) throws Exception 
	{
		Query query=manager.createNativeQuery(PREDEFAGENDADELETE);		
		query.setParameter("DefaultAgendaId", DefaultAgendaId);
		return query.executeUpdate();
	}
	
	private static final String COMMPROSCHEDULELIST = "SELECT COUNT(*)+1 FROM  committee_schedule cs ,committee_meeting_status ms WHERE cs.committeeid=:committeeid AND cs.projectid=:projectid AND cs.isactive=1 AND  ms.meetingstatus=cs.scheduleflag AND ms.meetingstatusid > 6 AND cs.scheduledate<:sdate ";
	@Override
	public int CommProScheduleList(String projectid,String committeeid,String sdate) throws Exception 
	{
		Query query=manager.createNativeQuery(COMMPROSCHEDULELIST);
		query.setParameter("projectid", projectid);
		query.setParameter("committeeid", committeeid);
		query.setParameter("sdate", sdate);
		BigInteger CommProScheduleList=(BigInteger)query.getSingleResult();
		return CommProScheduleList.intValue();
	}
	
	private static final String LASTPRMC="SELECT cs.scheduleid FROM  committee_schedule cs ,committee_meeting_status ms WHERE cs.committeeid=:committeeid AND cs.projectid=:projectid AND cs.isactive=1 AND  ms.meetingstatus=cs.scheduleflag AND ms.meetingstatusid > 6 AND cs.scheduleid<:scheduleId ORDER BY cs.scheduleid DESC LIMIT 1";
	@Override
	public long getLastPmrcId(String projectid,String committeeid,String scheduleId) throws Exception 
	{
		Query query=manager.createNativeQuery(LASTPRMC);
		query.setParameter("projectid", projectid);
		query.setParameter("committeeid", committeeid);
		query.setParameter("scheduleId", scheduleId);
		long result=0;
		try {
		BigInteger CommProScheduleList=(BigInteger)query.getSingleResult();
		result=CommProScheduleList.longValue();
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO getLastPmrcId "+ e);
		}
		return result;
	}

	@Override
	public long insertMinutesFinance(MinutesFinanceList finance) throws Exception {
		
		manager.persist(finance);
		manager.flush();
		return finance.getMinutesFinanceId();
	}


	@Override
	public long insertMinutesProcurement(MinutesProcurementList procure) throws Exception {
		manager.persist(procure);
		manager.flush();
		return procure.getMinutesProcurementId();
	}


	@Override
	public long insertMinutesAction(MinutesActionList action) throws Exception {
		manager.persist(action);
		manager.flush();
		return action.getMinutesActionId();
	}


	@Override
	public long insertMinutesLastPmrc(MinutesLastPmrc lastpmrc) throws Exception {
		manager.persist(lastpmrc);
		manager.flush();
		return lastpmrc.getMinutesLastPmrcId();
	}


	@Override
	public long insertMinutesMileActivity(MinutesMileActivity Mile) throws Exception {
		manager.persist(Mile);
		manager.flush();
		return Mile.getMinutesMileId();
	}


	@Override
	public long insertMinutesSubMile(MinutesSubMile submile) throws Exception {
		manager.persist(submile);
		manager.flush();
		return submile.getMinutesSubMileId();
	}

    private static final String UPDATEFROZEN="update committee_schedule set MinutesFrozen='Y' where scheduleid=:schduleid";
	@Override
	public int updateMinutesFrozen(String schduleid) throws Exception {
		Query query=manager.createNativeQuery(UPDATEFROZEN);
		query.setParameter("schduleid", schduleid);
		int ret=0;
		ret=query.executeUpdate();
		return ret;
	}

    private static final String FINANCELIST="FROM MinutesFinanceList WHERE CommiteeScheduleId=:scheduleid";
	@Override
	public List<MinutesFinanceList> getMinutesFinance(String scheduleid) throws Exception {
		Query query=manager.createQuery(FINANCELIST);
		query.setParameter("scheduleid", Long.parseLong(scheduleid));
		List<MinutesFinanceList> getMinutesFinance=(List<MinutesFinanceList>)query.getResultList();
		return getMinutesFinance;
	
	}
	
	private static final String MINUTESACTION="SELECT a.schduleminutesid, a.details,a.idrck,a.actionno,a.actiondate,a.enddate,a.assignor,a.assignee,a.actionitem,a.actionstatus,a.actionflag,a.AssignorName,a.AssignerDesig,a.AssigneeName,a.AssigneeDesig   FROM  pfms_minutes_action a WHERE a.commiteescheduleid =:scheduleid ORDER BY a.schduleminutesid ASC";
	
	@Override
	public List<Object[]> getMinutesAction(String scheduleid) throws Exception {
		Query query=manager.createNativeQuery(MINUTESACTION);
		query.setParameter("scheduleid", scheduleid);
		List<Object[]> getMinutesFinance=( List<Object[]>)query.getResultList();
		return getMinutesFinance;
	
	}

	private static final String MINUTESPROCURE="SELECT f.PftsFileId, f.DemandNo, f.OrderNo, f.DemandDate, f.DpDate, f.EstimatedCost, f.OrderCost, f.RevisedDp ,f.ItemNomenclature, f.PftsStatus, f.PftsStageName, f.Remarks, f.vendorname, f.PftsStatusId  AS id  FROM pfms_minutes_procurement f WHERE f.commiteescheduleid=:scheduleid ";
	@Override
	public List<Object[]> getMinutesProcure(String scheduleid) throws Exception {
		Query query=manager.createNativeQuery(MINUTESPROCURE);
		query.setParameter("scheduleid", scheduleid);
		List<Object[]> getMinutesFinance=( List<Object[]>)query.getResultList();
		return getMinutesFinance;
	
	}

	private static final String MINUTESMILE="SELECT MilestoneNo AS 'Main',MainId,AId,BId,CId,DId,EId,StartDate,EndDate,MileStoneMain,MileStoneA,MileStoneB,MileStoneC,MileStoneD,MileStoneE,ActivityType,ProgressStatus,Weightage,DateOfCompletion,Activitystatus,ActivityStatusId,RevisionNo,MilestoneNo, OicEmpId,EmpName,Designation,LevelId,ActivityShort,StatusRemarks FROM pfms_minutes_mile a WHERE a.committeescheduleid=:scheduleid";
	@Override
	public List<Object[]> getMinutesMile(String scheduleid) throws Exception {
		Query query=manager.createNativeQuery(MINUTESMILE);
		query.setParameter("scheduleid", scheduleid);
		List<Object[]> getMinutesMile=( List<Object[]>)query.getResultList();
		return getMinutesMile;
	}
	
	private static final String MINUTESSUBMILE="SELECT a.activityId, a.Parentactivityid, a.activityname, a.orgenddate, a.enddate,a.activitystatusid,a.activityshort, a.Progress,a.milestoneno, a.StatusRemarks FROM pfms_minutes_submile a WHERE a.committeescheduleid=:scheduleid ORDER BY a.milestoneno ASC";
	@Override
	public List<Object[]> getMinutesSubMile(String scheduleid) throws Exception {
		Query query=manager.createNativeQuery(MINUTESSUBMILE);
		query.setParameter("scheduleid", scheduleid);
		List<Object[]> getMinutesSubMile=( List<Object[]>)query.getResultList();
		return getMinutesSubMile;
	}
	
	private static final String CLUSTERLIST="SELECT clusterid,clustername, clustershortname FROM cluster WHERE clustertype='Technology Cluster' ";
	@Override
	public List<Object[]> ClusterList() throws Exception{
		Query query=manager.createNativeQuery(CLUSTERLIST);
		List<Object[]> ClusterList=( List<Object[]>)query.getResultList();
		return ClusterList;
		
		
	}
	

	private static final String GETDEFAULTAGENDASCOUNT="SELECT COUNT(defaultagendaid),'count' FROM committee_default_agenda WHERE committeeid=:committeeId AND labcode=:LabCode";
	@Override
	public Object[] getDefaultAgendasCount(String committeeId, String LabCode) throws Exception
	{
		Query query=manager.createNativeQuery(GETDEFAULTAGENDASCOUNT);
		query.setParameter("committeeId", committeeId);
		query.setParameter("LabCode", LabCode);
		Object[] ClusterList=(Object[])query.getResultList().get(0);
		return ClusterList;
	}
	
			
	@Override
	public LabMaster LabDetailes(String LabCode) throws Exception {
		logger.info(new java.util.Date() +"Inside LabDetailes");
		LabMaster LabDetailes=manager.find(LabMaster.class, 1);
		
		CriteriaBuilder cb= manager.getCriteriaBuilder();
		CriteriaQuery<LabMaster> cq= cb.createQuery(LabMaster.class);
		Root<LabMaster> root= cq.from(LabMaster.class);					
		Predicate p1=cb.equal(root.get("LabCode") , LabCode);
		cq=cq.select(root).where(p1);
		TypedQuery<LabMaster> allquery = manager.createQuery(cq);
		LabMaster lab= allquery.getResultList().get(0);
		
		
		return LabDetailes;
	}


	private static final String  COMMITTEEMAINDETAILS = "SELECT cm.committeemainid, cm.committeeid, c.committeeshortname, c.labcode FROM committee_main cm, committee c  WHERE cm.committeeid = c.committeeid AND cm.committeemainid=:CommitteeMainId ";
	@Override
	public Object[] CommitteeMainDetails(String CommitteeMainId) {
		
		Query query=manager.createNativeQuery(COMMITTEEMAINDETAILS);
		query.setParameter("CommitteeMainId", CommitteeMainId);
		Object[] ClusterList=(Object[])query.getResultList().get(0);
		return ClusterList;
		
	}
	
	@Override
	public long FreezeDPFMMinutesAdd(CommitteeMeetingDPFMFrozen dpfm)throws Exception
	{
		manager.persist(dpfm);
		return dpfm.getFrozenDPFMId();
	}
	
	private static final String GETFROZENDPFMMINUTES = "from CommitteeMeetingDPFMFrozen where ScheduleId=:scheduleId and IsActive=1 "; 
	@Override
	public CommitteeMeetingDPFMFrozen getFrozenDPFMMinutes(String scheduleId)throws Exception
	{
		Query query=manager.createQuery(GETFROZENDPFMMINUTES);
		query.setParameter("scheduleId", Long.parseLong(scheduleId));
		CommitteeMeetingDPFMFrozen dpfm=(CommitteeMeetingDPFMFrozen)query.getResultList().get(0);
		return dpfm;
	}
}