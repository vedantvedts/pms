package com.vts.pfms.committee.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.committee.model.RODMaster;

@Repository
@Transactional
public class RODDaoImpl implements RODDao{

	private static final Logger logger=LogManager.getLogger(RODDaoImpl.class);
			
	@PersistenceContext
	EntityManager manager;
	
	private static final String RODPROJECTSCHEDULELISTALL = "SELECT a.ScheduleId, a.RODNameId,a.MeetingId,a.ScheduleDate,a.ScheduleStartTime,a.ProjectId,b.RODName,a.ScheduleFlag FROM committee_schedule a,pfms_rod_master b WHERE a.RODNameId=b.RODNameId AND a.IsActive=1 AND a.ProjectId=:ProjectId ORDER BY a.ScheduleDate";
	@Override
	public List<Object[]> rodProjectScheduleListAll(String projectId) throws Exception
	{
		try {
			Query query=manager.createNativeQuery(RODPROJECTSCHEDULELISTALL);
			query.setParameter("ProjectId",projectId);
			return (List<Object[]>) query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RODDaoImpl rodProjectScheduleListAll "+e);
			return new ArrayList<>();
		}
		
	}
	
	private static final String RODMASTERDETAILS ="SELECT RODNameId,RODName FROM pfms_rod_master WHERE IsActive=1 AND (CASE WHEN 'A'=:RODNameId THEN 1=1 ELSE RODNameId=:RODNameId END)";
	@Override
	public Object[] getRODMasterDetails(String rodNameId) throws Exception {
		
		try {
			Query query = manager.createNativeQuery(RODMASTERDETAILS);
			query.setParameter("RODNameId", rodNameId);
			List<Object[]> list = (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RODDaoImpl getRODMasterDetails"+e);
			return null;
		}
	}
	
	private static final String RODPROJECTSCHEDULELISTALL2 = "SELECT a.ScheduleId, a.RODNameId,a.MeetingId,a.ScheduleDate,a.ScheduleStartTime,a.ProjectId,b.RODName,a.ScheduleFlag FROM committee_schedule a,pfms_rod_master b WHERE a.RODNameId=b.RODNameId AND a.ProjectId=:ProjectId AND a.RODNameId=:RODNameId AND a.IsActive=1 ORDER BY a.ScheduleDate";
	@Override
	public List<Object[]> rodProjectScheduleListAll(String projectId, String rodNameId) throws Exception
	{
		try {
			Query query=manager.createNativeQuery(RODPROJECTSCHEDULELISTALL2);
			query.setParameter("ProjectId",projectId);
			query.setParameter("RODNameId", rodNameId);
			return (List<Object[]>) query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RODDaoImpl rodProjectScheduleListAll "+e);
			return new ArrayList<>();
		}
		
	}
	
	private static final String RODNAMESLIST = "SELECT RODNameId,RODName FROM pfms_rod_master WHERE IsActive=1";
	@Override
	public List<Object[]> rodNamesList() throws Exception
	{
		try {
			Query query=manager.createNativeQuery(RODNAMESLIST);
//			query.setParameter("ProjectId",projectId);
			return (List<Object[]>) query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RODDaoImpl rodNamesList "+e);
			return new ArrayList<>();
		}
		
	}
	@Override
	public Long addNewRODName(RODMaster master) throws Exception {
		try {
			manager.persist(master);
			manager.flush();
			return master.getRODNameId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RODDaoImpl addNewRODName "+e);
			return 0L;
		}
		
	}
	
	private static final String RODSCHEDULEEDITDATA = "SELECT a.RODNameId,a.committeemainid,a.scheduledate,a.schedulestarttime,a.scheduleflag,a.schedulesub,a.scheduleid,b.RODName,'' AS Test1,a.projectid,\r\n"
			+ "c.meetingstatusid,a.meetingid,a.meetingvenue,a.confidential,a.Reference,d.classification ,a.divisionid  ,a.initiationid ,a.pmrcdecisions,a.kickoffotp ,\r\n"
			+ "(SELECT minutesattachmentid FROM committee_minutes_attachment WHERE scheduleid=a.scheduleid) AS 'attachid',\r\n"
			+ "'' AS Test2,a.MinutesFrozen,a.briefingpaperfrozen,a.labcode \r\n"
			+ "FROM committee_schedule a,pfms_rod_master b ,committee_meeting_status c, pfms_security_classification d \r\n"
			+ "WHERE a.scheduleflag=c.MeetingStatus AND a.scheduleid=:committeescheduleid AND a.RODNameId=b.RODNameId AND a.confidential=d.classificationid";

	@Override
	public Object[] RODScheduleEditData(String CommitteeScheduleId) throws Exception {
		try {
			Query query=manager.createNativeQuery(RODSCHEDULEEDITDATA);
			query.setParameter("committeescheduleid", CommitteeScheduleId );
			List<Object[]> list = (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside RODDaoImpl RODScheduleEditData "+e);
			return null;
		}
		
	}
}
