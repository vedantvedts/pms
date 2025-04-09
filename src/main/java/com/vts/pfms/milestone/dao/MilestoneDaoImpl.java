	package com.vts.pfms.milestone.dao;

import java.util.ArrayList;
import java.util.List;


import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.milestone.dto.MileEditDto;
import com.vts.pfms.milestone.dto.MilestoneActivityDto;
import com.vts.pfms.milestone.model.ActivityTransaction;
import com.vts.pfms.milestone.model.FileDocAmendment;
import com.vts.pfms.milestone.model.FileDocMaster;
import com.vts.pfms.milestone.model.FileProjectDoc;
import com.vts.pfms.milestone.model.FileRepMaster;
import com.vts.pfms.milestone.model.FileRepNew;
import com.vts.pfms.milestone.model.FileRepUploadNew;
import com.vts.pfms.milestone.model.MilestoneActivity;
import com.vts.pfms.milestone.model.MilestoneActivityLevel;
import com.vts.pfms.milestone.model.MilestoneActivitySub;
import com.vts.pfms.milestone.model.MilestoneActivitySubRev;
import com.vts.pfms.milestone.model.MilestoneSchedule;
import com.vts.pfms.print.model.ProjectTechnicalWorkData;



@Transactional
@Repository
public class MilestoneDaoImpl implements MilestoneDao {

	private static final String MALIST="SELECT a.MilestoneActivityId, b.ProjectName, a.StartDate, a.EndDate, a.ActivityName, a.MilestoneNo,\r\n"
			+ "CONCAT(IFNULL(CONCAT(c.Title,' '),(IFNULL(CONCAT(c.Salutation, ' '), ''))), c.EmpName, ', ', e.Designation) AS 'OicEmpId1Name', \r\n"
			+ "CONCAT(IFNULL(CONCAT(d.Title,' '),(IFNULL(CONCAT(d.Salutation, ' '), ''))), d.EmpName, ', ', f.Designation) AS 'OicEmpId2Name',\r\n"
			+ "(SELECT MAX(e.revisionno) FROM milestone_activity_rev e WHERE a.milestoneactivityid=e.milestoneactivityid) AS rev,\r\n"
			+ "a.acceptedby,a.isaccepted,a.statusremarks,a.progressstatus,a.Weightage,a.activitystatusid,b.projectid,a.dateofcompletion \r\n"
			+ "FROM milestone_activity a,project_master b, employee c,employee d, employee_desig e, employee_desig f \r\n"
			+ "WHERE a.projectid=b.projectid AND a.oicempid=c.empid AND a.oicempid1=d.empid AND c.DesigId = e.DesigId AND d.DesigId = f.DesigId AND a.projectid=:ProjectId ORDER BY a.MilestoneNo";
	private static final String PROJECTMASTER="SELECT a.projectid,a.projectcode,a.projectname FROM project_master a WHERE  a.isactive='1'";
	private static final String EMPLOYEELISTALL="select a.empid,a.empname,b.designation FROM employee a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId ORDER BY a.srno=0,a.srno";
    private static final String MILESTONECOUNT="Select count(*) from milestone_activity where isactive='1' and projectid=:ProjectId";
	private static final String MA="select a.milestoneactivityid,b.projectname,a.startdate,a.enddate,a.activityname,a.milestoneno,c.empname,d.empname as emp,a.oicempid,a.oicempid1,a.projectid,a.progressstatus,a.revisionno,a.acceptedby,a.accepteddate,a.activitytype,a.Weightage,e.activitytype as type from milestone_activity a,project_master b, employee c,employee d, milestone_activity_type e where a.activitytype=e.activitytypeid and a.projectid=b.projectid and a.oicempid=c.empid and a.oicempid1=d.empid and a.milestoneactivityid=:id";
	private static final String MILEACTIVITYLEVEL="CALL Pfms_Milestone_Level_List(:id,:levelid)";
    private static final String MAREVISION="SELECT IFNULL(MAX(revisionno),0) AS 'MAX' FROM milestone_activity_rev WHERE milestoneactivityid=:id ";
	private static final String MADETAILS="FROM MilestoneActivity WHERE MilestoneActivityId=:Id";
    private static final String MILEACTIVITYDATA="select a.milestoneactivityid,a.startdate,a.enddate,a.activityname,a.activitystatusid,a.progressstatus,a.statusremarks,a.oicempid,a.oicempid1,a.activitytype from milestone_activity a where  a.milestoneactivityid=:id";
    private static final String MILEACTIVITYLEVELDATA="select a.activityid,a.startdate,a.enddate,a.activityname,a.activitystatusid,a.progressstatus,a.statusremarks,a.Weightage from milestone_activity_level a where  a.activityid=:id";
	private static final String MILEACTIVITYTYPE="select activitytypeid,activitytype from milestone_activity_type";
	private static final String MAINUPDATE="UPDATE milestone_activity SET activityname=:name,Weightage=:Weightage,activitytype=:type,oicempid=:empid,oicempid1=:empid1,startdate=:from,enddate=:to,orgstartdate=:orgfrom,orgenddate=:orgto,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE milestoneactivityid=:id";
	private static final String MILEACTIVITYLEVELEDIT="UPDATE milestone_activity_level SET activityname=:name,startdate=:from,enddate=:to,Weightage=:Weightage ,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE activityid=:id";
	private static final String ACTIVITYLEVELFULLEDIT="UPDATE milestone_activity_level SET activityname=:name,Weightage=:Weightage,activitytype=:type,oicempid=:empid,oicempid1=:empid1,startdate=:from,enddate=:to,orgstartdate=:orgfrom,orgenddate=:orgto,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE activityid=:id";
	private static final String MILEACTIVITYUPDATE="UPDATE milestone_activity  SET activityname=:name, startdate=:from,enddate=:to,Weightage=:Weightage,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE milestoneactivityid=:id";
	private static final String MILEACTIVITYAUPDATE="UPDATE milestone_activity_a SET startdate=:from,enddate=:to,Weightage=:Weightage ,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE activityaid=:id";
	private static final String MILEACTIVITYBUPDATE="UPDATE milestone_activity_b SET startdate=:from,enddate=:to,Weightage=:Weightage,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE activitybid=:id";
	private static final String MILEACTIVITYCUPDATE="UPDATE milestone_activity_c SET startdate=:from,enddate=:to,Weightage=:Weightage,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE activitycid=:id";
    private static final String MILELEVELCOMPARE="CALL Pfms_Milestone_Level_Compare(:id,:rev,:rev1,:levelid)";
	private static final String MILECOMPAREMAIN="SELECT a.milestoneactivityid,b.projectname,e.startdate,e.enddate,e.activityname,e.progressstatus as ps,c.empname,d.empname AS emp,e.revisionno,e.progressstatus as ps1,e.progressstatus as ps2,e.progressstatus as ps3,DATEDIFF(e.enddate,e.startdate) AS actual,(SELECT DATEDIFF(f.enddate,f.startdate) FROM milestone_activity_rev f WHERE  f.milestoneactivityid=:id  AND f.revisionno=:rev1) AS diff,a.dateofcompletion,g.activitystatus  FROM milestone_activity a,project_master b, employee c,employee d,milestone_activity_rev e,milestone_activity_status g WHERE a.activitystatusid=g.activitystatusid and a.projectid=b.projectid AND a.oicempid=c.empid AND a.oicempid1=d.empid AND a.milestoneactivityid=e.milestoneactivityid   AND a.milestoneactivityid=:id AND e.revisionno=:rev";
	private static final String MAEMPLIST="select a.milestoneactivityid,b.projectname,a.startdate,a.enddate,a.activityname,a.milestoneno,c.empname,d.empname as emp,(SELECT IFNULL(MAX(e.revisionno),0) AS 'MAX' FROM milestone_activity_rev e WHERE a.milestoneactivityid=e.milestoneactivityid) AS rev from milestone_activity a,project_master b, employee c,employee d,milestone_activity_rev e where  a.revisionno=e.revisionno  AND a.milestoneactivityid=e.milestoneactivityid and a.projectid=b.projectid and a.oicempid=c.empid and a.oicempid1=d.empid and (a.oicempid1=:EmpId or a.oicempid=:EmpId)";
	private static final String STATUSLIST="select a.activitystatusid,a.activitystatus FROM milestone_activity_status a ";
	private static final String PROACTIVITYUPDATE="UPDATE milestone_activity SET dateofcompletion=:doc,activitystatusid=:status,progressstatus=:progress,statusremarks=:remarks,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE milestoneactivityid=:id";
	private static final String PROACTIVITYLEVELUPDATE="UPDATE milestone_activity_level SET dateofcompletion=:doc,activitystatusid=:status,progressstatus=:progress,statusremarks=:remarks,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE activityid=:id";
	private static final String REPORTSLIST="SELECT a.milestoneactivityid,c.projectname,a.milestoneno,d.activitytype,a.activityname,b.startdate,b.enddate,a.progressstatus,a.projectid FROM milestone_activity a,milestone_activity_rev b,project_master c,milestone_activity_type d  WHERE a.projectid=c.projectid AND a.activitytype=d.activitytypeid AND a.revisionno=b.revisionno  AND a.milestoneactivityid=b.milestoneactivityid AND (a.oicempid=:empid OR a.oicempid1=:empid) ";
	private static final String MILESTONETOTALWEIGHTAGE="SELECT SUM(weightage) FROM milestone_activity_a WHERE milestoneactivityid=:MilestoneActivityId";
    private static final String SUBLIST="SELECT a.activitysubid,a.progress,a.progressdate,a.remarks,a.attachname  FROM milestone_activity_sub a WHERE a.activityid=:id";
    private static final String SUBDATA="FROM MilestoneActivitySub WHERE ActivitySubId=:id"; 
	private static final String PROJECTDETAILS="SELECT a.projectid,a.projectcode,a.projectname,a.ProjectShortName FROM project_master a WHERE a.projectid=:projectid";
	private static final String MAASSIGNEELIST="CALL Pfms_Milestone_Oic_List(:ProjectId,:empid)";
	private static final String PROJECTEMPLIST="SELECT a.empid,  CONCAT(IFNULL(a.title,''), a.empname)AS 'empname',b.designation FROM employee a,employee_desig b,project_employee pe  WHERE a.isactive='1' AND pe.isactive='1' AND a.DesigId=b.DesigId  AND pe.empid=a.empid AND pe.projectid=:projectid AND a.labcode=:labcode ORDER BY a.srno=0,a.srno";
	private static final String PROJECTEMPLISTEDIT="SELECT a.empid,a.empname,b.designation,a.srno as srno FROM employee a,employee_desig b,project_employee pe  WHERE a.isactive='1' AND a.DesigId=b.DesigId  AND pe.empid=a.empid AND pe.projectid=:projectid  union SELECT a.empid,a.empname,b.designation,a.srno as srno FROM employee a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId  AND a.empid=:id ORDER BY srno";
	private static final String PROJECTASSINEE="SELECT DISTINCT(a.projectid),a.projectcode,a.projectname FROM project_master a,milestone_activity b WHERE a.projectid=b.projectid and (b.oicempid=:empid or b.oicempid1=:empid) and   a.isactive='1'";
	private static final String ASSIGNUPDATE="UPDATE milestone_activity SET isaccepted='A',ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE milestoneactivityid=:id";
	private static final String ACCEPTUPDATE="UPDATE milestone_activity SET isaccepted='Y',acceptedby=:acceptedby,accepteddate=:accepteddate,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE milestoneactivityid=:id";
	private static final String SENDBACKUPDATE="UPDATE milestone_activity SET isaccepted='B',statusremarks=:statusremarks,ModifiedBy=:modifiedby, ModifiedDate=:modifieddate WHERE milestoneactivityid=:id";
    private static final String ACTIONLIST="SELECT a.actionmainid,ab.empname,dc.designation,a.actiondate,aas.enddate,a.actionitem,aas.actionstatus,aas.actionstatus as 'status',a.createdby,a.createddate,(SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) AS subid,(SELECT c.progress FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS progress, (SELECT c.remarks FROM action_sub c  WHERE c.actionassignid = aas.actionassignid AND c.actionsubid = (SELECT MAX(b.actionsubid) FROM action_sub b WHERE b.actionassignid = aas.actionassignid) )  AS remarks,aas.revision FROM action_main a,  employee ab ,employee_desig dc , action_assign aas WHERE aas.actionmainid=a.actionmainid AND aas.assignee=ab.empid AND ab.isactive='1' AND dc.desigid=ab.desigid AND a.actiontype=:actiontype AND a.activityid=:activityid  ";//AND aas.actionflag<>'Y'
    private static final String MILESUM="SELECT IFNULL(SUM(weightage), 0) AS 'TotalWeightage' FROM milestone_activity WHERE milestoneactivityid<>:id AND projectid=:projectid";
    private static final String ACTIVITYLEVELSUM="SELECT SUM(weightage) FROM milestone_activity_level WHERE parentactivityid=:id AND activityid<>:activityid and activitylevelid=:levelid";
    private static final String BASELINEMAIN="SELECT a.milestoneactivityid AS obid,e.enddate,a.progressstatus,e.Weightage,b.activitystatus,a.activitystatusid FROM milestone_activity_rev a,milestone_activity_status b,milestone_activity e  WHERE a.activitystatusid=b.activitystatusid  AND a.milestoneactivityid=e.milestoneactivityid AND a.revisionno=e.revisionno AND  a.milestoneactivityid=:inActivityId";
    private static final String BASELINELEVEL="SELECT a.activityid AS obid,c.enddate,a.progressstatus,c.Weightage,b.activitystatus,a.activitystatusid FROM milestone_activity_level a,milestone_activity_sub_rev c,milestone_activity_status b WHERE a.activitystatusid=b.activitystatusid AND a.revision=c.revision  AND   a.parentactivityid=:inActivityId  AND a.activityid=c.activityid and a.activitylevelid=:levelid";
    private static final String PROGRESSMAIN="UPDATE milestone_activity SET activitystatusid=:status,progressstatus=:progress, DateOfCompletion=:DateOfCompletion,ModifiedDate=:ModifiedDate WHERE milestoneactivityid=:id";
    private static final String PROGRESSLEVEL="UPDATE milestone_activity_level SET activitystatusid=:status,progressstatus=:progress,ModifiedDate=:ModifiedDate WHERE activityid=:id";
    private static final String REVMAINUPDATE="UPDATE milestone_activity SET revisionno=:rev WHERE milestoneactivityid=:id";
    private static final String REVLEVELUPDATE="UPDATE milestone_activity_level SET revision=:rev WHERE activityid=:id";
    private static final String FILEPASS="select password from login where username=:userid";
   
    private static final String FILEREPREV="UPDATE file_rep_new SET ReleaseDoc=:release,VersionDoc=:version where filerepid=:id";
    private static final String FILEDETAILS="SELECT * FROM(SELECT a.filerepid,b.filerepuploadid,b.filepath,b.filenameui,b.filename,b.filepass,b.ReleaseDoc,b.VersionDoc FROM file_rep_new a,file_rep_upload b WHERE a.filerepid=b.filerepid AND b.filerepuploadid=:fileid)AS a JOIN (SELECT MAX(DocAmendmentId) AS 'AmendmentDocId' FROM file_doc_amendment WHERE FileRepUploadId=:fileid ) AS b  ";
    private static final String ALLEMPNAMEDESIGLIST="SELECT e.empid , e.empname, ed.designation FROM employee e, employee_desig ed WHERE e.desigid=ed.desigid and e.labcode=:labcode ";
	
    private static final String MILESTONESCHEDULELIST="SELECT milestonescheduleid,projectid,activityname,milestoneno,orgstartdate,orgenddate,startdate,enddate,statusremarks FROM milestone_schedule WHERE isactive=1 AND projectid=:projectid";
    private static final String MILESTONESCHEDULECOUNT="SELECT COUNT(*) FROM milestone_schedule WHERE isactive='1' AND projectid=:projectid";
    private static final String MILESTONEEXCEL="CALL Pfms_Milestone_Excel(:projectid)";
    private static final String MAINSYSTEM="SELECT a.filerepmasterid, a.parentlevelid, a.levelid,  a.levelname FROM file_rep_master a WHERE a.levelid='1' AND projectid=:projectid";
    private static final String MAINSYSTEMLEVEL="SELECT a.filerepmasterid, a.parentlevelid, a.levelid,  a.levelname FROM file_rep_master a WHERE a.parentlevelid=:parentid ";
	private static final String MILELEVEL="FROM MilestoneActivityLevel WHERE  ParentActivityId=:Id AND ActivityLevelId=:LevelId";
	private static final String DOCUMENTTYPELIST="SELECT fdm.fileuploadmasterid,fdm.parentlevelid,fdm.levelid,fdm.levelname,fdm.docshortname,'1' AS 'added' FROM file_doc_master fdm, file_project_doc fpd WHERE fdm.isactive=1 AND fpd.fileuploadmasterid=fdm.fileuploadmasterid AND fpd.projectid=:projectid AND LabCode=:LabCode UNION SELECT fileuploadmasterid,parentlevelid,levelid,levelname,docshortname,'0' AS 'added' FROM file_doc_master WHERE isactive=1  AND LabCode=:LabCode AND  fileuploadmasterid NOT IN (SELECT fileuploadmasterid FROM file_project_doc WHERE projectid=:projectid  AND LabCode=:LabCode ) ORDER BY 1 ";
	private static final String DOCUMENTTITLELIST="CALL Pfms_FileRepo_Doc (:projectid,:sub,:LabCode)";
	//private static final String VERSIONCHECKLIST="SELECT b.filerepuploadid,b.filenameui,b.ReleaseDoc,b.filerepid, b.versionDoc FROM file_rep_new a,file_rep_upload b WHERE a.projectid=:projectid AND  a.subl1=:subsysteml1 AND a.documentid=:documenttitle  AND a.filerepid=b.filerepid ORDER BY b.filerepuploadid DESC LIMIT 1 "; 
	private static final String VERSIONCHECKLIST="SELECT b.filerepuploadid,b.filenameui,b.ReleaseDoc,b.filerepid, b.versionDoc FROM file_rep_new a,file_rep_upload b WHERE a.projectid=:projectid AND  a.subl1=:subsysteml1 AND a.documentid=:documenttitle  AND a.filerepid=b.filerepid AND a.IsActive=1 AND b.IsActive=1 ORDER BY b.filerepuploadid DESC LIMIT 1 ";  // prakash Change
	private static final String DOCUMENTSTAGELIST="SELECT a.fileuploadmasterid,a.parentlevelid,a.levelid,a.levelname FROM file_doc_master a WHERE a.isactive=1 AND a.levelid=:levelid AND a.parentlevelid=:documenttype";
	private static final String FILEHISTORYLIST="SELECT fru.filerepuploadid,frn.filerepid,fdm.docid,fdm.levelname,fru.versiondoc,fru.releasedoc,CAST(DATE_FORMAT(fru.createddate,'%d-%m-%Y') AS CHAR) AS 'createddate' FROM  file_rep_new frn,file_rep_upload fru,file_doc_master fdm WHERE frn.filerepid=fru.filerepid AND frn.documentid=fdm.fileuploadmasterid AND frn.filerepid=:filerepid ORDER BY fru.versiondoc DESC,fru.releasedoc DESC ";
	private static final String FILEREPMASTERLISTALL ="SELECT a.filerepmasterid,a.parentlevelid,a.levelid,a.levelname,COALESCE(b.ProjectCode, 'General') AS ProjectCode FROM file_rep_master a LEFT JOIN project_master b ON a.projectid = b.projectid WHERE a.filerepmasterid > 0 AND a.projectid =:projectid AND a.LabCode =:LabCode";
	private static final String FILEDOCMASTERLISTALL ="SELECT fileuploadmasterid,parentlevelid,levelid,levelname,docid,docshortname FROM file_doc_master WHERE isactive=1  AND labcode=:LabCode AND fileuploadmasterid IN (SELECT parentlevelid FROM file_doc_master WHERE isactive=1 AND fileuploadmasterid IN (SELECT parentlevelid FROM file_project_doc   WHERE projectid=:projectid AND labcode=:LabCode ) )  UNION  SELECT fileuploadmasterid,parentlevelid,levelid,levelname,docid,docshortname FROM file_doc_master WHERE isactive=1 AND labcode=:LabCode AND fileuploadmasterid IN (SELECT parentlevelid FROM file_project_doc   WHERE projectid=:projectid AND labcode=:LabCode) ";
	private static final String PROJECTDOCUMETSADD ="SELECT DocAmendmentId,FileRepUploadId,FileName,Description,AmendVersion,FilePath,FilePass,Amendmentname FROM file_doc_amendment WHERE FileRepUploadId=:FileRepUploadId ORDER BY AmendVersion DESC";
	private static final String DOCUMENTAMENDMENTDATA ="SELECT DocAmendmentId,FileRepUploadId,FileName,Description,AmendVersion,FilePath,FilePass,Amendmentname FROM file_doc_amendment WHERE DocAmendmentId=:docammendmentid ORDER BY AmendVersion DESC";
	
	private static final String REPMASTERDATA ="SELECT filerepmasterid,projectid,levelname FROM file_rep_master WHERE filerepmasterid=:filerepmasterid";
	private static final String REPMASTERALLDOCLISTS="CALL Pfms_FileRepo_SubLev_list(:filerepmasterid);";
	private static final String MAINSYSTEM1 ="SELECT a.filerepmasterid, a.parentlevelid, a.levelid,  a.levelname FROM file_rep_master a WHERE a.levelid='1' AND a.filerepmasterid=:filerepmasterid";
    private static final String WEIGHTAGELEVEL="SELECT a.activityid AS obid,a.enddate,a.progressstatus,a.Weightage FROM milestone_activity_level a WHERE    a.parentactivityid=:inActivityId   and a.activitylevelid=:levelid";

	
    @PersistenceContext
	EntityManager manager;
	
	private static final Logger logger=LogManager.getLogger(MilestoneDaoImpl.class);
	
	@Override
	public List<Object[]> MilestoneActivityList(String ProjectId) throws Exception {

		Query query=manager.createNativeQuery(MALIST);
		query.setParameter("ProjectId", ProjectId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}

	@Override
	public List<Object[]> ProjectList() throws Exception {

		Query query=manager.createNativeQuery(PROJECTMASTER);
		
		List<Object[]> ProjectList=(List<Object[]>)query.getResultList();		

		return ProjectList;
	}
	
	@Override
	public List<Object[]> MilestoneActivityAssigneeList(String ProjectId,String EmpId) throws Exception {

		Query query=manager.createNativeQuery(MAASSIGNEELIST);
		query.setParameter("ProjectId", ProjectId);
		query.setParameter("empid", EmpId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}

	@Override
	public List<Object[]> ProjectAssigneeList(String EmpId) throws Exception {

		Query query=manager.createNativeQuery(PROJECTASSINEE);
		query.setParameter("empid", EmpId);
		List<Object[]> ProjectList=(List<Object[]>)query.getResultList();		
		return ProjectList;
	}
	
	@Override
	public List<Object[]> EmployeeList() throws Exception {

		Query query=manager.createNativeQuery(EMPLOYEELISTALL);
		
		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();		

		return EmployeeList;
	}

	@Override
	public long MilestoneActivity(com.vts.pfms.milestone.model.MilestoneActivity Milestone) throws Exception {
		manager.persist(Milestone);
		manager.flush();
		return Milestone.getMilestoneActivityId();
	}
	
	@Override
	public int MilestoneCount(String ProjectId) throws Exception {
		
		Query query = manager.createNativeQuery(MILESTONECOUNT);
		query.setParameter("ProjectId", ProjectId);
		Long count = (Long)query.getSingleResult();
		return count.intValue();
	}

	@Override
	public List<Object[]> MilestoneActivity(String MilestoneActivityId) throws Exception {

		Query query=manager.createNativeQuery(MA);
		query.setParameter("id", MilestoneActivityId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}

	@Override
	public long MilestoneActivityLevelInsert(MilestoneActivityLevel MileActivityA) throws Exception {
		manager.persist(MileActivityA);
		manager.flush();
		return MileActivityA.getActivityId();
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
	public int MilestoneRevisionCount(String MileActivityId) throws Exception {
		try {
			Query query = manager.createNativeQuery(MAREVISION);
			query.setParameter("id", Long.parseLong(MileActivityId));
			Long revCount = (Long)query.getSingleResult();
			return revCount.intValue();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public MilestoneActivity MileActivityDetails(Long Id) throws Exception {

        Query query=manager.createQuery(MADETAILS);
		query.setParameter("Id",Id);
		MilestoneActivity NoList=(MilestoneActivity)query.getSingleResult();
		return NoList;
	}
	
	
	@Override
	public long PfmsNotificationAdd(PfmsNotification notification) throws Exception {
		manager.persist(notification);
		manager.flush();
        return notification.getNotificationId();
	
	}

	@Override
	public long MilestoneActivityRev(com.vts.pfms.milestone.model.MilestoneActivityRev Milestone) throws Exception {
		manager.persist(Milestone);
		manager.flush();
		return Milestone.getMilestoneActivityRevId();
	}

	@Override
	public long MilestoneActivitySubRev(MilestoneActivitySubRev Milestone)
			throws Exception {
		manager.persist(Milestone);
		manager.flush();
		return Milestone.getActivityRevId();
	}


	@Override
	public List<Object[]> MilestoneActivityData(String ActivityId) throws Exception {
		Query query=manager.createNativeQuery(MILEACTIVITYDATA);
		query.setParameter("id", ActivityId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}

	@Override
	public List<Object[]> ActivityLevelData(String ActivityId) throws Exception {
		Query query=manager.createNativeQuery(MILEACTIVITYLEVELDATA);
		query.setParameter("id", ActivityId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}


	@Override
	public List<Object[]> ActivityTypeList() throws Exception {
		Query query=manager.createNativeQuery(MILEACTIVITYTYPE);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}

	@Override
	public int MilestoneActivityMainUpdate(MileEditDto dto) throws Exception {
		
		Query query=manager.createNativeQuery(MAINUPDATE);
		query.setParameter("id",dto.getMilestoneActivityId());
		query.setParameter("type", dto.getActivityTypeId());
		query.setParameter("empid",dto.getOicEmpId());
		query.setParameter("empid1",dto.getOicEmpId1());
		query.setParameter("name",dto.getActivityName());
		query.setParameter("from",dto.getStartDate());
		query.setParameter("to",dto.getEndDate());
		query.setParameter("orgfrom",dto.getStartDate());
		query.setParameter("orgto",dto.getEndDate());
		query.setParameter("Weightage",dto.getWeightage());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}
	
	@Override
	public int ActivityLevelFullEdit(MileEditDto dto) throws Exception {
		
		Query query=manager.createNativeQuery(ACTIVITYLEVELFULLEDIT);
		query.setParameter("id",dto.getActivityId());
		query.setParameter("type", dto.getActivityTypeId());
		query.setParameter("empid",dto.getOicEmpId());
		query.setParameter("empid1",dto.getOicEmpId1());
		query.setParameter("name",dto.getActivityName());
		query.setParameter("from",dto.getStartDate());
		query.setParameter("to",dto.getEndDate());
		query.setParameter("orgfrom",dto.getStartDate());
		query.setParameter("orgto",dto.getEndDate());
		query.setParameter("Weightage",dto.getWeightage());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int ActivityLevelEditUpdate(MileEditDto dto) throws Exception {
		
		Query query=manager.createNativeQuery(MILEACTIVITYLEVELEDIT);
		query.setParameter("id",dto.getActivityId());
		query.setParameter("name",dto.getActivityName());
		query.setParameter("from",dto.getStartDate());
		query.setParameter("to",dto.getEndDate());
		query.setParameter("Weightage",dto.getWeightage());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}

	
	@Override
	public int MilestoneActivityUpdate(MileEditDto dto) throws Exception {
		
		Query query=manager.createNativeQuery(MILEACTIVITYUPDATE);
		query.setParameter("id",dto.getMilestoneActivityId());
		query.setParameter("from",dto.getStartDate());
		query.setParameter("to",dto.getEndDate());
		query.setParameter("Weightage",dto.getWeightage());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		query.setParameter("name",dto.getActivityName());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int ActivityUpdateA(MileEditDto dto) throws Exception {
		
		Query query=manager.createNativeQuery(MILEACTIVITYAUPDATE);
		query.setParameter("id",dto.getActivityId());
		query.setParameter("from",dto.getStartDate());
		query.setParameter("to",dto.getEndDate());
		query.setParameter("Weightage",dto.getWeightage());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int ActivityUpdateB(MileEditDto dto) throws Exception {
		
		Query query=manager.createNativeQuery(MILEACTIVITYBUPDATE);
		query.setParameter("id",dto.getActivityId());
		query.setParameter("from",dto.getStartDate());
		query.setParameter("to",dto.getEndDate());
		query.setParameter("Weightage",dto.getWeightage());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int ActivityUpdateC(MileEditDto dto) throws Exception {
		
		Query query=manager.createNativeQuery(MILEACTIVITYCUPDATE);
		query.setParameter("id",dto.getActivityId());
		query.setParameter("from",dto.getStartDate());
		query.setParameter("to",dto.getEndDate());
		query.setParameter("Weightage",dto.getWeightage());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public List<Object[]> ActivityCompareMAin(String ActivityId,String Rev,String Rev1) throws Exception {
		Query query=manager.createNativeQuery(MILECOMPAREMAIN);
		query.setParameter("id", Long.parseLong(ActivityId));
		query.setParameter("rev", Integer.parseInt(Rev));
		query.setParameter("rev1", Integer.parseInt(Rev1));
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}

	@Override
	public List<Object[]> ActivityLevelCompare(String ActivityId,String Rev,String Rev1,String LevelId) throws Exception {
		Query query=manager.createNativeQuery(MILELEVELCOMPARE);
		query.setParameter("id", ActivityId);
		query.setParameter("rev", Rev);
		query.setParameter("rev1", Rev1);
		query.setParameter("levelid", LevelId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}



	@Override
	public List<Object[]> MilestoneActivityEmpIdList(String EmpId) throws Exception {
		Query query=manager.createNativeQuery(MAEMPLIST);
		query.setParameter("EmpId", EmpId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	
	}
	
	@Override
	public List<Object[]> StatusList() throws Exception {

		Query query=manager.createNativeQuery(STATUSLIST);
		
		List<Object[]> StatusList=(List<Object[]>)query.getResultList();		

		return StatusList;
	}
	
	@Override
	public int ActivityProgressMainUpdate(MileEditDto dto) throws Exception {
		
		Query query=manager.createNativeQuery(PROACTIVITYUPDATE);
		query.setParameter("id",dto.getMilestoneActivityId());
		query.setParameter("doc",dto.getDateOfCompletion());
		query.setParameter("remarks",dto.getStatusRemarks());
		query.setParameter("progress",dto.getProgressStatus());
		query.setParameter("status",dto.getActivityStatusId());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int ActivityProgressUpdateLevel(MileEditDto dto) throws Exception {
		
		Query query=manager.createNativeQuery(PROACTIVITYLEVELUPDATE);
		query.setParameter("id",dto.getActivityId());
		query.setParameter("doc",dto.getDateOfCompletion());
		query.setParameter("remarks",dto.getStatusRemarks());
		query.setParameter("progress",dto.getProgressStatus());
		query.setParameter("status",dto.getActivityStatusId());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}


	@Override
	public List<Object[]> MilestoneReportsList(String ProjectId) throws Exception {

		Query query=manager.createNativeQuery(REPORTSLIST);
		query.setParameter("empid", ProjectId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}
	 
	
	@Override
	public int MilestoneTotalWeightage(String MilestoneActivityId) throws Exception {
		try {
			Query query=manager.createNativeQuery(MILESTONETOTALWEIGHTAGE);
			query.setParameter("MilestoneActivityId", MilestoneActivityId);		
			return (Integer)query.getSingleResult();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}

	}

	@Override
	public long MilestoneActivitySubInsert(MilestoneActivitySub sub) throws Exception {
		manager.persist(sub);
		manager.flush();
		return sub.getActivitySubId();
	}

	@Override
	public List<Object[]> MilestoneActivitySub(String ActivityId,String Type) throws Exception {
		Query query=manager.createNativeQuery(SUBLIST);
		query.setParameter("id", ActivityId);
		//query.setParameter("type", ActivityId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}

	@Override
	public com.vts.pfms.milestone.model.MilestoneActivitySub ActivityAttachmentDownload(Long ActivitySubId)
			throws Exception {
        Query query=manager.createQuery(SUBDATA);
		query.setParameter("id",ActivitySubId);
		MilestoneActivitySub NoList=(MilestoneActivitySub)query.getSingleResult();
		return NoList;
	}

	@Override
	public List<Object[]> ProjectDetails(String ProjectId) throws Exception {
		Query query=manager.createNativeQuery(PROJECTDETAILS);
		query.setParameter("projectid",ProjectId);
		List<Object[]> ProjectList=(List<Object[]>)query.getResultList();		

		return ProjectList;
	}

	@Override
	public int MilestoneActivityAssign(MilestoneActivityDto dto) throws Exception {
		Query query=manager.createNativeQuery(ASSIGNUPDATE);
		query.setParameter("id",dto.getActivityId());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int MilestoneActivityAccept(MilestoneActivityDto dto, String dt) throws Exception {
		Query query=manager.createNativeQuery(ACCEPTUPDATE);
		query.setParameter("id",dto.getActivityId());
		query.setParameter("acceptedby",dto.getOicEmpId());
		query.setParameter("accepteddate",dt);
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int MilestoneActivityBack(MilestoneActivityDto dto) throws Exception {
		Query query=manager.createNativeQuery(SENDBACKUPDATE);
		query.setParameter("id",dto.getActivityId());
		query.setParameter("statusremarks",dto.getStatusRemarks());
		query.setParameter("modifiedby",dto.getCreatedBy());
		query.setParameter("modifieddate",dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}


	@Override
	public List<Object[]> ActionList(String actiontype,String activityid) throws Exception {
		Query query=manager.createNativeQuery(ACTIONLIST);
		query.setParameter("actiontype",actiontype);
		query.setParameter("activityid",activityid);
		List<Object[]> ActionList=(List<Object[]>)query.getResultList();		

		return ActionList;
	}

	@Override
	public long ActivityTransactionInsert(ActivityTransaction trans) throws Exception {
		manager.persist(trans);
		manager.flush();
		return trans.getActivityTransactionId();
	}
	@Override
	public int ActivityMainSum(String Id,String ActivityId) throws Exception {
		try {
			Query query = manager.createNativeQuery(MILESUM);
			query.setParameter("projectid", ActivityId);
			query.setParameter("id", Id);
			return (Integer)query.getSingleResult();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int ActivityLevelSum(String Id, String ActivityId,String LevelId) throws Exception {
		try {	
			Query query = manager.createNativeQuery(ACTIVITYLEVELSUM);
			query.setParameter("activityid", ActivityId);
			query.setParameter("id", Id);
			query.setParameter("levelid", LevelId);
			return (Integer)query.getSingleResult();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
	public List<Object[]> BaseLineMain(String ActivityId) throws Exception {
		Query query=manager.createNativeQuery(BASELINEMAIN);
		query.setParameter("inActivityId", ActivityId);
		List<Object[]> BaseLineC=(List<Object[]>)query.getResultList();		

		return BaseLineC;
	}

	@Override
	public List<Object[]> BaseLineLevel(String ActivityId,String LevelId) throws Exception {
		Query query=manager.createNativeQuery(BASELINELEVEL);
		query.setParameter("inActivityId", ActivityId);
		query.setParameter("levelid", LevelId);
		List<Object[]> BaseLineC=(List<Object[]>)query.getResultList();		

		return BaseLineC;
	}

	@Override
	public List<Object[]> WeightageLevel(String ActivityId,String LevelId) throws Exception {
		Query query=manager.createNativeQuery(WEIGHTAGELEVEL);
		query.setParameter("inActivityId", ActivityId);
		query.setParameter("levelid", LevelId);
		List<Object[]> BaseLineC=(List<Object[]>)query.getResultList();		

		return BaseLineC;
	}

	@Override
	public int ProgressMain(String ActivityId, String Status, int Progress,String DateOfCompletion,MileEditDto dto) throws Exception {
		Query query=manager.createNativeQuery(PROGRESSMAIN);
		query.setParameter("id",ActivityId);
		query.setParameter("status",Status);
		query.setParameter("progress",Progress);
		query.setParameter("DateOfCompletion",DateOfCompletion);
		query.setParameter("ModifiedDate", dto.getCreatedDate());
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int ProgressLevel(String ActivityId, String Status, int Progress,MileEditDto dto) throws Exception {
		Query query=manager.createNativeQuery(PROGRESSLEVEL);
		
		System.out.println("date of Completion - "+dto.getDateOfCompletion());
		
		query.setParameter("id",ActivityId);
		query.setParameter("status",Status);
		query.setParameter("progress",Progress);
		query.setParameter("ModifiedDate", dto.getCreatedDate());
		
		int result=query.executeUpdate();
		
//		//newly added 
//		System.out.println("id - "+ActivityId);
//		if(Progress==100) {
//			String docUpdate="UPDATE milestone_activity_level SET DateOfCompletion=:DateOfCompletion,ModifiedDate=:ModifiedDate WHERE activityid=:id";
//			Query query1=manager.createNativeQuery(docUpdate);
//			query1.setParameter("ModifiedDate", dto.getCreatedDate());
//			query1.setParameter("id",ActivityId);
//			query1.setParameter("DateOfCompletion",dto.getDateOfCompletion());
//			query1.executeUpdate();
//			System.out.println("progress - "+Progress);
//		}
		return result;
	}



	@Override
	public int RevMainUpdate(String ActivityId, String Rev) throws Exception {
		Query query=manager.createNativeQuery(REVMAINUPDATE);
		query.setParameter("id",ActivityId);
		query.setParameter("rev",Rev);
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int RevLevelUpdate(String ActivityId, String Rev) throws Exception {
		Query query=manager.createNativeQuery(REVLEVELUPDATE);
		query.setParameter("id",ActivityId);
		query.setParameter("rev",Rev);
		int result=query.executeUpdate();
		return result;
	}

	
	
	@Override
	public int FileRepRevUpdate(String ActivityId, Long release,Long version) throws Exception {
		Query query=manager.createNativeQuery(FILEREPREV);
		query.setParameter("id",ActivityId);
		query.setParameter("release",release);
		query.setParameter("version",version);
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public String FilePass(String Userid) throws Exception {
		Query query=manager.createNativeQuery(FILEPASS);
		query.setParameter("userid", Userid);
		String FilePass=(String)query.getSingleResult();

		return FilePass;
	}
	
	@Override
	public List<Object[]> FileDeatils(String FileId) throws Exception {
		Query query=manager.createNativeQuery(FILEDETAILS);
		query.setParameter("fileid", FileId);
		List<Object[]> FileSub=(List<Object[]>)query.getResultList();		

		return FileSub;
	}
	

	@Override
	public List<Object[]> MilestoneScheduleList(String ProjectId) throws Exception {

		Query query=manager.createNativeQuery(MILESTONESCHEDULELIST);
		query.setParameter("projectid", ProjectId);
		List<Object[]> MilestoneScheduleList=(List<Object[]>)query.getResultList();		

		return MilestoneScheduleList;
	}

	@Override
	public Long MilestoneScheduleInsert(MilestoneSchedule Milestone) throws Exception {

		manager.persist(Milestone);
		manager.flush();
		return Milestone.getMilestoneScheduleId();
	}
	
	@Override
	public int MilestoneScheduleCount(String ProjectId) throws Exception {
		
		Query query = manager.createNativeQuery(MILESTONESCHEDULECOUNT);
		query.setParameter("projectid", ProjectId);
		Long count=(Long)query.getSingleResult();
		return count.intValue();
	}

	@Override
	public List<Object[]> MilestoneExcel(String ProjectId) throws Exception {
		Query query=manager.createNativeQuery(MILESTONEEXCEL);
		query.setParameter("projectid", ProjectId);
		List<Object[]> MilestoneExcel=(List<Object[]>)query.getResultList();		

		return MilestoneExcel;
	}

	@Override
	public List<Object[]> MainSystem(String projectid) throws Exception {
		Query query=manager.createNativeQuery(MAINSYSTEM);
		query.setParameter("projectid", projectid);
		List<Object[]> MainSystem=(List<Object[]>)query.getResultList();		

		return MainSystem;
	}

	
	
	@Override
	public long RepMasterInsert(FileRepMaster RepMaster) throws Exception {
		manager.persist(RepMaster);
		manager.flush();
		return RepMaster.getFileRepMasterId();
	}

	@Override
	public List<Object[]> MainSystemLevel(String ParentId) throws Exception {
	
		Query query=manager.createNativeQuery(MAINSYSTEMLEVEL);
		query.setParameter("parentid", ParentId);
		List<Object[]> MainSystem=(List<Object[]>)query.getResultList();
		return MainSystem;
	}
	
	@Override
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype ,String LabCode)throws Exception
	{
		Query query=manager.createNativeQuery("CALL Pfms_Emp_ProjectList(:empid,:logintype,:labcode);");
		query.setParameter("empid", empid);
		query.setParameter("logintype", Logintype);
		query.setParameter("labcode", LabCode);
		List<Object[]> LoginProjectIdList=(List<Object[]>)query.getResultList();
		return LoginProjectIdList;
	}

	@Override
	public List<Object[]> ProjectEmpList(String projectid ,String Labcode)throws Exception
	{
		Query query=manager.createNativeQuery(PROJECTEMPLIST);
		query.setParameter("projectid", projectid);
		query.setParameter("labcode", Labcode);

		List<Object[]> ProjectEmpList=(List<Object[]>)query.getResultList();
		return ProjectEmpList;
	}
	
	@Override
	public List<Object[]> ProjectEmpListEdit(String projectid,String id)throws Exception
	{
		Query query=manager.createNativeQuery(PROJECTEMPLISTEDIT);
		query.setParameter("projectid", projectid);
		query.setParameter("id", id);
		List<Object[]> ProjectEmpList=(List<Object[]>)query.getResultList();
		return ProjectEmpList;
	}
	
	@Override
	public List<Object[]> AllEmpNameDesigList(String labcode)throws Exception
	{
		Query query=manager.createNativeQuery(ALLEMPNAMEDESIGLIST);
		query.setParameter("labcode", labcode);
		System.out.println(labcode);
		List<Object[]> AllEmpNameDesigList=(List<Object[]>)query.getResultList();
		return AllEmpNameDesigList;
	}

	@Override
	public List<MilestoneActivityLevel> ActivityLevelList(Long Id, Long LevelId) {
        Query query=manager.createQuery(MILELEVEL);
		query.setParameter("Id",Id);
		query.setParameter("LevelId",LevelId);
		List<MilestoneActivityLevel> NoList=(List<MilestoneActivityLevel>)query.getResultList();
		return NoList;
	}
	
	@Override
	public List<Object[]> DocumentTypeList(String projectid,String LabCode)throws Exception
	{
		Query query=manager.createNativeQuery(DOCUMENTTYPELIST);
		query.setParameter("projectid",projectid);
		query.setParameter("LabCode",LabCode);
		List<Object[]> DocumentTypeList=(List<Object[]>)query.getResultList();
		return DocumentTypeList;
	}
	
	@Override
	public List<Object[]> DocumentTitleList(String ProjectId,String Sub,String LabCode) throws Exception 
	{
		Query query=manager.createNativeQuery(DOCUMENTTITLELIST);
		query.setParameter("projectid", ProjectId);
		query.setParameter("sub", Sub);
		query.setParameter("LabCode", LabCode);
		List<Object[]> DocumentStageList=(List<Object[]>)query.getResultList();
		return DocumentStageList;
	}
	

	@Override
	public List<Object[]> DocumentStageList(String documenttype,String levelid) throws Exception {
		
		Query query=manager.createNativeQuery(DOCUMENTSTAGELIST);
		query.setParameter("documenttype", documenttype);
		query.setParameter("levelid", levelid);
	
		List<Object[]> DocumentStageList=(List<Object[]>)query.getResultList();
		return DocumentStageList;
	}
	
	
	@Override
	public long FileSubInsertNew(FileRepNew fileRepo) throws Exception {
		manager.persist(fileRepo);
		manager.flush();
		return fileRepo.getFileRepId();
	}
	
	
	@Override
	public long FileUploadInsertNew(FileRepUploadNew fileRepUplod) throws Exception {
		manager.persist(fileRepUplod);
		manager.flush();
		return fileRepUplod.getFileRepUploadId();
	}

	@Override
	public List<Object[]> VersionCheckList(String ProjectId, String SubsystemId,String documenttitle) throws Exception {
		
		Query query=manager.createNativeQuery(VERSIONCHECKLIST);
		query.setParameter("projectid", ProjectId);
		query.setParameter("subsysteml1", SubsystemId);
		query.setParameter("documenttitle", documenttitle);
		List<Object[]> VersionCheckList=(List<Object[]>)query.getResultList();
		return VersionCheckList;
	}
	
	
	@Override
	public List<Object[]> FileHistoryList(String filerepid) throws Exception 
	{		
		Query query=manager.createNativeQuery(FILEHISTORYLIST);
		query.setParameter("filerepid", filerepid);		
		List<Object[]> FileHistoryList=(List<Object[]>)query.getResultList();
		return FileHistoryList;
	}

	
	
	@Override
	public List<Object[]> FileRepMasterListAll(String projectid,String LabCode )throws Exception
	{
		Query query=manager.createNativeQuery(FILEREPMASTERLISTALL);
		query.setParameter("projectid", projectid);
		query.setParameter("LabCode", LabCode);
		List<Object[]> FileRepMasterListAll=(List<Object[]>)query.getResultList();
		return FileRepMasterListAll;
	}
	
	
	
	@Override
	public List<Object[]> FileDocMasterListAll(String projectid,String LabCode)throws Exception
	{
		Query query=manager.createNativeQuery(FILEDOCMASTERLISTALL);
		query.setParameter("projectid", projectid);
		query.setParameter("LabCode", LabCode);
		List<Object[]> FileDocMasterListAll=(List<Object[]>)query.getResultList();
		return FileDocMasterListAll;
	}
	
	@Override
	public long ProjectDocumetsAdd(FileProjectDoc model) throws Exception {
		manager.persist(model);
		manager.flush();
		return model.getProjectDocId();
	}
	
	
	
	@Override
	public List<Object[]> DocumentAmendment(String FileRepUploadId) throws Exception {
		Query query=manager.createNativeQuery(PROJECTDOCUMETSADD);
		query.setParameter("FileRepUploadId", FileRepUploadId);
		List<Object[]> FileDocMasterListAll=(List<Object[]>)query.getResultList();
			return FileDocMasterListAll;
	}
	
	@Override
	public long DocumetAmmendAdd(FileDocAmendment model) throws Exception {
		manager.persist(model);
		manager.flush();
		return model.getDocAmendmentId();
	}
	
	
	@Override
	public Object[] DocumentAmendmentData(String docammendmentid) throws Exception {
		Query query=manager.createNativeQuery(DOCUMENTAMENDMENTDATA);
		query.setParameter("docammendmentid", docammendmentid);
		List<Object[]> DocumentAmendmentData=(List<Object[]>)query.getResultList();
		if(DocumentAmendmentData.size()>0) {
			return DocumentAmendmentData.get(0);
		}else
		{
			return null;
		}
	}
	
	@Override
	public Object[] RepMasterData(String filerepmasterid) throws Exception {
		Query query=manager.createNativeQuery(REPMASTERDATA);
		query.setParameter("filerepmasterid", filerepmasterid);
		List<Object[]> RepMasterData=(List<Object[]>)query.getResultList();
		if(RepMasterData.size()>0) {
			return RepMasterData.get(0);
		}else
		{
			return null;
		}
	}
	
	@Override
	public List<Object[]> RepMasterAllDocLists(String filerepmasterid) throws Exception {
		Query query=manager.createNativeQuery(REPMASTERALLDOCLISTS);
		query.setParameter("filerepmasterid", filerepmasterid);
		List<Object[]> RepMasterAllDocLists=(List<Object[]>)query.getResultList();
		return RepMasterAllDocLists;
	}
	
	
	
 	@Override
	public List<Object[]> MainSystem1(String filerepmasterid) throws Exception
 	{
		Query query=manager.createNativeQuery(MAINSYSTEM1);
		query.setParameter("filerepmasterid", filerepmasterid);
		List<Object[]> MainSystem=(List<Object[]>)query.getResultList();		

		return MainSystem;
	}
	
	@Override
	public int fileRepMasterEditSubmit(String filerepmasterid,String levelname) throws Exception
 	{
		FileRepMaster repmaster=manager.find(FileRepMaster.class,Long.parseLong(filerepmasterid));	
		repmaster.setLevelName(levelname);
		repmaster=manager.merge(repmaster);
		if(repmaster!=null) {
			return 1;
		}else
		{
			return 0;
		}
	}
	
	private static final String FILEDOCMASTERLIST ="FROM FileDocMaster WHERE IsActive= 1 AND LabCode = :LabCode ";
	@Override
	public List<FileDocMaster> fileDocMasterList(String LabCode) throws Exception
 	{
		Query query = manager.createQuery(FILEDOCMASTERLIST);
		query.setParameter("LabCode", LabCode);
		return (List<FileDocMaster>)query.getResultList();
		
	}
	
	@Override
	public long FileDocMasterAdd(FileDocMaster model) throws Exception
	{
		manager.persist(model);
		manager.flush();
		return model.getFileUploadMasterId();
	}
	
	private static final String FILELEVELSUBLEVELNAMECHECK = "FROM FileDocMaster where IsActive=1 AND (LevelId=1 OR LevelId=2) AND LevelName=:LevelName AND LabCode=:LabCode";
	@Override
	public List<FileDocMaster> FileLevelSublevelNameCheck(String levelname,String LabCode) throws Exception
 	{
//		CriteriaBuilder cb = manager.getCriteriaBuilder();
//	    CriteriaQuery<FileDocMaster> cq = cb.createQuery(FileDocMaster.class);
//	    Root<FileDocMaster> rootEntry = cq.from(FileDocMaster.class);
//	    Predicate p1=cb.equal(rootEntry.get("LevelId"), 1);
//	    Predicate p2=cb.equal(rootEntry.get("LevelId"), 2);
//	    Predicate p3=cb.equal(rootEntry.get("LabCode"), LabCode);
//	    CriteriaQuery<FileDocMaster> all = cq.select(rootEntry).where(cb.equal(rootEntry.get("LevelName"), levelname),cb.or(p1,p2),p3);
//	    TypedQuery<FileDocMaster> allQuery = manager.createQuery(all);
//	    return allQuery.getResultList();
		
		Query query = manager.createQuery(FILELEVELSUBLEVELNAMECHECK);
		query.setParameter("LevelName", levelname);
		query.setParameter("LabCode", LabCode);
		return (List<FileDocMaster>) query.getResultList();
		
	}
	
	private static final String FILENAMECHECK = "SELECT (SELECT COUNT(levelname)  FROM file_doc_master WHERE levelname=:levelname AND levelid=3 AND parentlevelid =:parentlevelid  AND LabCode=:LabCode ) AS 'levelname' ,  (SELECT COUNT(DocShortName) FROM file_doc_master WHERE DocShortName=:shortname AND levelid=3 AND LabCode=:LabCode )AS 'DocShortName' , (SELECT COUNT(DocId)  FROM file_doc_master WHERE DocId=:docid AND levelid=3 AND LabCode=:LabCode   ) AS 'DocId' FROM DUAL";
	@Override
	public Object[] fileNameCheck(String levelname, String shortname, String docid, String parentlevelid,String LabCode ) throws Exception
 	{
		Query query=manager.createNativeQuery(FILENAMECHECK);
		query.setParameter("levelname", levelname);
		query.setParameter("shortname", shortname);
		query.setParameter("docid", docid);
		query.setParameter("parentlevelid", parentlevelid);
		query.setParameter("LabCode", LabCode);
		List<Object[]> MainSystem=(List<Object[]>)query.getResultList();		
		if(MainSystem.size()>0) {
			return MainSystem.get(0);
		}else
		{
			return null;
		}
	}
	
	private static final String MILESTONEACTIVITYLISTNEW = "SELECT a.milestoneactivityid AS obid,0 AS 'parentactivityid',a.startdate,a.enddate,a.activityname,a.progressstatus,a.Weightage,a.dateofcompletion, b.activitystatus,a.activitystatusid,a.revisionno AS 'rev' ,d.activitytypeid, d.activitytype ,a.oicempid,e.empname,a.oicempid1,0 AS 'activitylevelid' FROM milestone_activity a,milestone_activity_status b, milestone_activity_type d ,employee e WHERE a.activitystatusid=b.activitystatusid AND a.activitytype=d.activitytypeid AND a.oicempid=e.empid AND a.projectid=:projectid";
	@Override
	public List<Object[]> MilestoneActivityListNew(String ProjectId) throws Exception 
	{
		Query query=manager.createNativeQuery(MILESTONEACTIVITYLISTNEW);
		query.setParameter("projectid", ProjectId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}
	
	
	private static final String MILESTONEACTIVITYLEVELEXCEL = "SELECT a.activityid AS obid,a.parentactivityid,a.startdate,a.enddate,a.activityname,a.progressstatus,a.Weightage,a.dateofcompletion, b.activitystatus,a.activitystatusid,a.revision AS rev,d.activitytypeid, d.activitytype,a.oicempid,e.empname,a.oicempid1 ,a.activitylevelid FROM milestone_activity_level a,milestone_activity_status b, milestone_activity_type d ,employee e WHERE a.activitystatusid=b.activitystatusid AND a.activitytype=d.activitytypeid AND a.oicempid=e.empid AND   a.parentactivityid=:MilestoneActivityId AND a.activitylevelid=:levelid ";
	@Override
	public List<Object[]> MilestoneActivityLevelExcel(String MilestoneActivityId,String LevelId) throws Exception {
		Query query=manager.createNativeQuery(MILESTONEACTIVITYLEVELEXCEL);
		query.setParameter("MilestoneActivityId", MilestoneActivityId);
		query.setParameter("levelid", LevelId);
		List<Object[]> MilestoneActivityList=(List<Object[]>)query.getResultList();		

		return MilestoneActivityList;
	}
	
	private static final String MILEREMARKUPDATE="update milestone_activity set FinancialOutlay=:Financial , statusremarks=:remarks , modifiedby=:userid,modifieddate=sysdate() where milestoneactivityid=:id";

	@Override
	public int MilestoneRemarkUpdate(MilestoneActivityDto dto) throws Exception {
		Query query=manager.createNativeQuery(MILEREMARKUPDATE);
		query.setParameter("id",dto.getActivityId());
		query.setParameter("remarks",dto.getStatusRemarks());
		query.setParameter("Financial",dto.getFinancaOutlay());
		query.setParameter("userid",dto.getCreatedBy());
		int result=query.executeUpdate();
		return result;
	}
	
	@Override
	public long MileActivityDetailsUpdtae(MilestoneActivity mainmile) throws Exception {

		manager.merge(mainmile);
		manager.flush();
		return mainmile.getMilestoneActivityId();
	}
	//prakarsh--------------------------------------------------------------------
		private static final String isActive="DELETE FROM file_project_doc WHERE Projectid=:Projectid  AND FileUploadMasterId=:FileUploadMasterId  AND ParentLevelid=:ParentLevelid";
		@Override
		public void isActive(String project, int fileUploadMasterId, int parentLevelid) {
			// TODO Auto-generated method stub
			Query query=manager.createNativeQuery(isActive);
		
			query.setParameter("Projectid", project);
			query.setParameter("FileUploadMasterId", fileUploadMasterId);
			query.setParameter("ParentLevelid", parentLevelid);
			query.executeUpdate();
		}
		private static final String FileRepUploadId="SELECT FileRepUploadId FROM file_rep_upload WHERE FileRepId IN (SELECT FileRepId FROM file_rep_new WHERE FileRepMasterId IN (SELECT FileRepMasterId FROM file_rep_master WHERE ProjectId=:project AND IsActive=1)  AND DocumentId=:documentID AND IsActive=1) AND IsActive=1 ";
	    @Override
		public List<Object[]> FileRepUploadId(String project, int documentID) {
			
			Query query=manager.createNativeQuery(FileRepUploadId);
			query.setParameter("project", project);
			query.setParameter("documentID", documentID);
			List<Object[]>FileRepUploadId=query.getResultList();

			return FileRepUploadId;	
		}
		private static final String IsFileInActive="UPDATE file_rep_upload JOIN file_rep_new ON file_rep_upload.FileRepId = file_rep_new.FileRepId SET file_rep_upload.IsActive = 0,file_rep_new.IsActive = 0 WHERE file_rep_new.FileRepMasterId IN (SELECT FileRepMasterId FROM file_rep_master   WHERE ProjectId =:project AND IsActive = 1)AND file_rep_new.DocumentId = :documentID AND file_rep_new.IsActive=1 ";
				
		@Override
		public int IsFileInActive(String project, int documentID) {
			Query query=manager.createNativeQuery(IsFileInActive);
			
			query.setParameter("project", project);
			query.setParameter("documentID", documentID);
		  int count=query.executeUpdate();
		  return count;
		}
		private static final String DocumentListNameEdit="UPDATE file_doc_master SET LevelName =:levelname WHERE FileUploadMasterId =:filerepmasterid";
		@Override
		public int DocumentListNameEdit(String filerepmasterid, String levelname) {
			Query query=manager.createNativeQuery(DocumentListNameEdit);
			query.setParameter("filerepmasterid", filerepmasterid);
			query.setParameter("levelname", levelname);
		  int count=query.executeUpdate();
			return count;
		}
		
//		private static final String MSPROJECTLIST= "SELECT a.MilestoneId,a.SampleTableId,a.ProjectUID,a.ProjectId,e.EmpName,d.designation,a.TaskUID,a.TaskParentUID,a.TaskOutlineLevel,a.TaskOutlineNumber,\r\n"
//				+ "a.TaskName,a.StartDate,a.FinishDate,a.ActualStartDate,a.ActualFinishDate,a.TaskProgress,a.IsCritical FROM pfms_milestone_msprojectdata a,\r\n"
//				+ "employee e , employee_desig d WHERE a.projectid=:projectid AND e.empno = a.empno AND e.desigid = d.desigid ORDER BY \r\n"
//				+ "    CAST(SUBSTRING_INDEX(TaskOutlineNumber, '.', 1) AS UNSIGNED),\r\n"
//				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 2), '.', -1) AS UNSIGNED),\r\n"
//				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 3), '.', -1) AS UNSIGNED),\r\n"
//				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 4), '.', -1) AS UNSIGNED),\r\n"
//				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 5), '.', -1) AS UNSIGNED),\r\n"
//				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 6), '.', -1) AS UNSIGNED),\r\n"
//				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 7), '.', -1) AS UNSIGNED)";
		
		
		private static final String MSPROJECTLIST= "SELECT \r\n"
				+ "    a.MilestoneId,\r\n"
				+ "    a.SampleTableId,\r\n"
				+ "    a.ProjectUID,\r\n"
				+ "    a.ProjectId,\r\n"
				+ "    e.EmpName,\r\n"
				+ "    d.designation,\r\n"
				+ "    a.TaskUID,\r\n"
				+ "    a.TaskParentUID,\r\n"
				+ "    a.TaskOutlineLevel,\r\n"
				+ "    a.TaskOutlineNumber,\r\n"
				+ "    a.TaskName,\r\n"
				+ "    a.StartDate,\r\n"
				+ "    a.FinishDate,\r\n"
				+ "    a.ActualStartDate,\r\n"
				+ "    a.ActualFinishDate,\r\n"
				+ "    a.TaskProgress,\r\n"
				+ "    a.TaskIsCritical,\r\n"
				+ "    a.TaskIsMilestone,\r\n"
				+ "    a.TaskIsSummary, \r\n"
				+ "    a.DemandNo, \r\n"
				+ "    a.TaskIsProcurement, \r\n"
				+ "    a.PftsStatusId, \r\n"
				+ "    a.OrgStartDate, \r\n"
				+ "    a.OrgFinishDate, \r\n"
				+ "    a.Revision \r\n"
				+ "FROM \r\n"
				+ "    pfms_milestone_msprojectdata a\r\n"
				+ "LEFT JOIN \r\n"
				+ "    employee e ON e.empno = a.empno\r\n"
				+ "LEFT JOIN \r\n"
				+ "    employee_desig d ON e.desigid = d.desigid\r\n"
				+ "WHERE \r\n"
				+ "    a.projectid = :projectid\r\n"
				+ "ORDER BY \r\n"
				+ "    CAST(SUBSTRING_INDEX(TaskOutlineNumber, '.', 1) AS UNSIGNED),\r\n"
				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 2), '.', -1) AS UNSIGNED),\r\n"
				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 3), '.', -1) AS UNSIGNED),\r\n"
				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 4), '.', -1) AS UNSIGNED),\r\n"
				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 5), '.', -1) AS UNSIGNED),\r\n"
				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 6), '.', -1) AS UNSIGNED),\r\n"
				+ "    CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(TaskOutlineNumber, '.', 7), '.', -1) AS UNSIGNED)\r\n"
				+ "";
		
		@Override
		public List<Object[]> getMsprojectTaskList(String ProjectId) throws Exception {
			try {
				System.out.println("ProjectId  "+ProjectId);
				Query query = manager.createNativeQuery(MSPROJECTLIST);
				query.setParameter("projectid", Long.parseLong(ProjectId));
				List<Object[]>mstaskList=query.getResultList();
				return mstaskList;
			}catch (Exception e) {
				// TODO: handle exception
				return null;
			}
		}
		
		private static final String GETATTACHMENTID="SELECT a.TechDataId,a.AttachmentId,(SELECT VersionDoc FROM file_rep_upload WHERE FileRepUploadId=a.AttachmentId)AS 'version',(SELECT ReleaseDoc FROM file_rep_upload WHERE FileRepUploadId=a.AttachmentId)AS 'release' FROM project_technical_work_data a WHERE a.ProjectId=:projectid AND a.IsActive='1'";
		@Override
		public List<Object[]> getAttachmentId(String projectid) throws Exception {
			Query query = manager.createNativeQuery(GETATTACHMENTID);
			query.setParameter("projectid", projectid);
			return (List<Object[]>) query.getResultList();
		}
		
		private static final String SUBMITCHECKFILE="UPDATE project_technical_work_data SET AttachmentId=:AttachmentId,ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate,IsActive=:IsActive WHERE TechDataId=:TechDataId";
		@Override
		public long submitCheckboxFile(ProjectTechnicalWorkData modal) throws Exception {
			Query query = manager.createNativeQuery(SUBMITCHECKFILE);
			query.setParameter("TechDataId", modal.getTechDataId());
			query.setParameter("AttachmentId", modal.getAttachmentId());
			query.setParameter("ModifiedBy", modal.getModifiedBy());
			query.setParameter("ModifiedDate", modal.getModifiedDate());
			query.setParameter("IsActive", modal.getIsActive());
			return query.executeUpdate();
		}
		
		private static final String GETFILEREPCHECKDATA="SELECT FileRepId,ProjectId,FileRepMasterId,SubL1,VersionDoc,ReleaseDoc FROM file_rep_new WHERE ProjectId=:projectId AND FileRepMasterId=:fileRepMasterId AND SubL1=:subL1 AND DocumentId=:docid AND IsActive='1'";
		@Override
		public List<Object[]> getFileRepData(String projectId, String fileRepMasterId, String subL1, String docid)
				throws Exception {
			Query query = manager.createNativeQuery(GETFILEREPCHECKDATA);
			query.setParameter("projectId", projectId);
			query.setParameter("fileRepMasterId", fileRepMasterId);
			query.setParameter("subL1", subL1);
			query.setParameter("docid", docid);
			return (List<Object[]>)query.getResultList();
		}
		
		private static final String FILEREPUPDATEDATA="UPDATE file_rep_new SET VersionDoc=:VersionDoc,ReleaseDoc=:ReleaseDoc,CreatedBy=:CreatedBy,CreatedDate=:CreatedDate WHERE FileRepId=:FileRepId";
		@Override
		public long FileRepUpdate(FileRepNew rep) throws Exception {
			Query query = manager.createNativeQuery(FILEREPUPDATEDATA);
			query.setParameter("FileRepId", rep.getFileRepId());
			query.setParameter("VersionDoc", rep.getVersionDoc());
			query.setParameter("ReleaseDoc", rep.getReleaseDoc());
			query.setParameter("CreatedBy", rep.getCreatedBy());
			query.setParameter("CreatedDate", rep.getCreatedDate());
			return query.executeUpdate();
		}
		
		private static final String MSPROJECTPROCUREMENTSTATUSLIST= "SELECT a.MilestoneId, a.DemandNo, MAX(CASE WHEN a.TaskProgress = 100 THEN a.PftsStatusId ELSE NULL END) AS MaxPftsStatusId, (SELECT b.TaskName FROM pfms_milestone_msprojectdata b WHERE a.DemandNo=b.DemandNo AND b.TaskOutLineLevel = 3 LIMIT 1) AS MainTaskName FROM pfms_milestone_msprojectdata a  WHERE a.TaskIsMilestone=1 AND a.TaskIsProcurement=1 AND a.ProjectId =:ProjectId GROUP BY a.DemandNo ORDER BY a.DemandNo";
		@Override
		public List<Object[]> getMsprojectProcurementStatusList(String projectId) throws Exception {
			try {
				Query query = manager.createNativeQuery(MSPROJECTPROCUREMENTSTATUSLIST);
				query.setParameter("ProjectId", projectId);
				return (List<Object[]>)query.getResultList();
			}catch (Exception e) {
				e.printStackTrace();
				return new ArrayList<>();
			}
		}

		@Override
		public MilestoneActivityLevel getActivityLevelListById(String activitiId) {
	        try {
	        	return manager.find(MilestoneActivityLevel.class, Long.parseLong(activitiId));
	        }catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}

		@Override
		public int mileStoneSerialNoUpdate(String newslno, String milestoneActivityId) {
			try {
				Query query = manager.createNativeQuery("UPDATE milestone_activity SET MilestoneNo=:MilestoneNo WHERE MilestoneActivityId=:MilestoneActivityId");
				query.setParameter("MilestoneActivityId", milestoneActivityId);
				query.setParameter("MilestoneNo", newslno);
				
				return query.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
		}
}
