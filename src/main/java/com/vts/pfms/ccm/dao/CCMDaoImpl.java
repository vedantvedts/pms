package com.vts.pfms.ccm.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.committee.model.CommitteeMember;
import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.committee.model.CommitteeScheduleAgenda;

@Repository
@Transactional
public class CCMDaoImpl implements CCMDao{

	private static final Logger logger = LogManager.getLogger(CCMDaoImpl.class);
	
	@PersistenceContext
	EntityManager manager;
	
	@Override
	public CommitteeMember getCommitteeMemberById(String committeeMemberId) throws Exception {
		try {
			return manager.find(CommitteeMember.class, Long.parseLong(committeeMemberId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl getCommitteeMemberById "+e);
			return null;
		}
		
	}
	
	@Override
	public List<CommitteeSchedule> getScheduleListByYear(String year) throws Exception {
		try {
			Query query = manager.createQuery("FROM CommitteeSchedule WHERE SUBSTR(ScheduleDate,1,4)=:Year AND ScheduleType='C' AND IsActive=1");
			query.setParameter("Year", year);
			return (List<CommitteeSchedule>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl getScheduleListByYear "+e);
			return null;
		}
	}
	
	@Override
	public CommitteeSchedule getCCMScheduleById(String ccmScheduleId) throws Exception {
		try {
			return manager.find(CommitteeSchedule.class, Long.parseLong(ccmScheduleId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl getCCMScheduleById "+e);
			return null;
		}
		
	}

	@Override
	public long addCCMSchedule(CommitteeSchedule ccmSchedule) throws Exception {
		try {
			manager.persist(ccmSchedule);
			manager.flush();
			return ccmSchedule.getScheduleId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl addCCMSchedule "+e);
			return 0;
		}
	}
	
	private static final String GETMAXCCMSCHEDULEIDFORMONTH="SELECT IFNULL(COUNT(ScheduleId),0) AS 'MAX' FROM committee_schedule WHERE IsActive=1 AND MeetingId LIKE :Month";
	@Override
	public long getMaxCCMScheduleIdForMonth(String seq) throws Exception {

		try {
			Query query =  manager.createNativeQuery(GETMAXCCMSCHEDULEIDFORMONTH);
			query.setParameter("Month", seq+"%");
			BigInteger ccmScheduleId=(BigInteger)query.getSingleResult();
			return ccmScheduleId.longValue();
		}catch ( NoResultException e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl getMaxCCMScheduleIdForMonth "+ e);
			return 0;
		}
	}
	
	@Override
	public Long addCCMScheduleAgenda(CommitteeScheduleAgenda agenda) throws Exception {
		try {
			manager.persist(agenda);
			manager.flush();
			return agenda.getScheduleAgendaId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl addCCMScheduleAgenda "+e);
			return 0L;
		}
	}
	
	private static final String GETCCMSCHEDULEAGENDALISTBYCCMSCHEDULEID = "SELECT b.ScheduleAgendaId, b.ScheduleId, b.ParentScheduleAgendaId, b.AgendaPriority, b.AgendaItem, b.PresentorLabCode, b.PresenterId, b.Duration, b.FileName,\r\n"
			+ "	(CASE WHEN b.PresentorLabCode='@EXP' THEN (SELECT CONCAT(IFNULL(CONCAT(c.Title,' '),''), c.ExpertName,', ',d.Designation) FROM expert c, employee_desig d WHERE c.ExpertId=b.PresenterId AND c.DesigId=d.DesigId LIMIT 1) \r\n"
			+ "	ELSE (SELECT CONCAT(IFNULL(CONCAT(c.Title,' '),''), c.EmpName,', ',d.Designation) FROM employee c, employee_desig d WHERE c.EmpId=b.PresenterId AND c.DesigId=d.DesigId LIMIT 1) END) AS 'Presenter',\r\n"
			+ "	(SELECT d.DesigId FROM employee c, employee_desig d WHERE c.EmpId=b.PresenterId AND c.DesigId=d.DesigId LIMIT 1) AS 'DesigId'\r\n"
			+ "FROM committee_schedule a, committee_schedules_agenda b\r\n"
			+ "WHERE a.ScheduleId=b.ScheduleId AND b.IsActive=1 AND a.ScheduleId=:ScheduleId";
	@Override
	public List<Object[]> getCCMScheduleAgendaListByCCMScheduleId(String ccmScheduleId) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETCCMSCHEDULEAGENDALISTBYCCMSCHEDULEID);
			query.setParameter("ScheduleId", ccmScheduleId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl getCCMScheduleAgendaListByCCMScheduleId "+e);
			return new ArrayList<Object[]>();
		}
	}
	
	@Override
	public CommitteeScheduleAgenda getCCMScheduleAgendaById(String ccmScheduleAgendaId) throws Exception {
		try {
			return manager.find(CommitteeScheduleAgenda.class, Long.parseLong(ccmScheduleAgendaId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl getCCMScheduleAgendaById "+e);
			return null;
		}
		
	}
	
	private static final String GETMAXAGENDAPRIORITY ="SELECT IFNULL(MAX(AgendaPriority),0) AS 'MAX' FROM committee_schedules_agenda WHERE ScheduleId=:ScheduleId AND ParentScheduleAgendaId=:ParentScheduleAgendaId";
	@Override
	public int getMaxAgendaPriority(String ccmScheduleId, String parentScheduleAgendaId) throws Exception {

		try {
			Query query =  manager.createNativeQuery(GETMAXAGENDAPRIORITY);
			query.setParameter("ScheduleId", ccmScheduleId);
			query.setParameter("ParentScheduleAgendaId", parentScheduleAgendaId);
			BigInteger agendaPriority=(BigInteger)query.getSingleResult();
			return agendaPriority.intValue();
		}catch ( NoResultException e ) {
			logger.error(new Date() +" Inside CCMDaoImpl getMaxAgendaPriority "+ e);
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String CCMAGENDAPRIORITYUPDATE ="UPDATE committee_schedules_agenda SET AgendaPriority=:AgendaPriority WHERE ScheduleAgendaId=:ScheduleAgendaId";
	@Override
	public int ccmAgendaPriorityUpdate(String scheduleAgendaId,String agendaPriority) throws Exception
	{
		try {
			Query query = manager.createNativeQuery(CCMAGENDAPRIORITYUPDATE);
			query.setParameter("AgendaPriority", agendaPriority);
			query.setParameter("ScheduleAgendaId", scheduleAgendaId);
			return query.executeUpdate();
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl ccmAgendaPriorityUpdate "+ e);
			return 0;
		}

	}
	
	private static final String GETCCMSCHEDULEAGENDASAFTER ="SELECT ScheduleAgendaId,AgendaPriority FROM committee_schedules_agenda WHERE ScheduleId=:ScheduleId AND ParentScheduleAgendaId=:ParentScheduleAgendaId AND AgendaPriority>:AgendaPriority ORDER BY AgendaPriority ASC";
	@Override
	public List<Object[]> getCCMScheduleAgendasAfter(String ccmScheduleId,String agendaPriority, String parentScheduleAgendaId) throws Exception
	{
		try {
			Query query=manager.createNativeQuery(GETCCMSCHEDULEAGENDASAFTER);
			query.setParameter("AgendaPriority", agendaPriority);
			query.setParameter("ScheduleId", ccmScheduleId);
			query.setParameter("ParentScheduleAgendaId", parentScheduleAgendaId);
			return (List<Object[]>)query.getResultList();
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl getCCMScheduleAgendasAfter "+ e);
			return new ArrayList<Object[]>();
		}

	}
	
	private static final String CCMSCHEDULEAGENDADELETE = "UPDATE committee_schedules_agenda SET ModifiedBy=:ModifiedBy, ModifiedDate=:ModifiedDate, IsActive=0, AgendaPriority=0 WHERE ScheduleAgendaId=:ScheduleAgendaId";
	@Override
	public int ccmScheduleAgendaDelete(String scheduleAgendaId, String modifiedby ,String modifiedDate)throws Exception
	{
		try {
			Query query = manager.createNativeQuery(CCMSCHEDULEAGENDADELETE);
			query.setParameter("ScheduleAgendaId", scheduleAgendaId);
			query.setParameter("ModifiedBy", modifiedby);
			query.setParameter("ModifiedDate", modifiedDate);
			return query.executeUpdate();
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl ccmScheduleAgendaDelete "+ e);
			return 0;
		}
		
	}
	
	private static final String CCMSCHEDULESUBAGENDADELETE = "UPDATE committee_schedules_agenda SET ModifiedBy=:ModifiedBy, ModifiedDate=:ModifiedDate, IsActive=0, AgendaPriority=0 WHERE ParentScheduleAgendaId=:ScheduleAgendaId";
	@Override
	public int ccmScheduleSubAgendaDelete(String scheduleAgendaId, String modifiedby ,String modifiedDate)throws Exception
	{
		try {
			Query query = manager.createNativeQuery(CCMSCHEDULESUBAGENDADELETE);
			query.setParameter("ScheduleAgendaId", scheduleAgendaId);
			query.setParameter("ModifiedBy", modifiedby);
			query.setParameter("ModifiedDate", modifiedDate);
			return query.executeUpdate();
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl ccmScheduleAgendaDelete "+ e);
			return 0;
		}
		
	}
	
	private static final String UPDATECCMSCHEDULEAGENDADURATION = "UPDATE committee_schedules_agenda SET Duration=(Duration - :OrgDuration)+:Duration WHERE ScheduleAgendaId=:ScheduleAgendaId";
	@Override
	public int updateCCMScheduleAgendaDuration(int orgDuration, int duration, Long scheduleAgendaId) throws Exception {
		try {
			Query query = manager.createNativeQuery(UPDATECCMSCHEDULEAGENDADURATION);
			query.setParameter("ScheduleAgendaId", scheduleAgendaId);
			query.setParameter("OrgDuration", orgDuration);
			query.setParameter("Duration", duration);
			return query.executeUpdate();
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl updateCCMScheduleAgendaDuration "+ e);
			return 0;
		}
	}
	
	private static final String GETCOMMITTEEMAINIDBYCOMMITTEECODE = "SELECT a.CommitteeMainId FROM committee_main a, committee b WHERE a.CommitteeId=b.CommitteeId AND b.CommitteeShortName=:CommitteeShortName AND a.ProjectId='0' AND a.DivisionId='0' AND a.InitiationId='0' AND CURDATE() BETWEEN a.ValidFrom AND a.ValidTo AND a.IsActive=1 ORDER BY a.CommitteeMainId DESC LIMIT 1";
	@Override
	public Long getCommitteeMainIdByCommitteeCode(String committeeCode) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETCOMMITTEEMAINIDBYCOMMITTEECODE);
			//query.setParameter("LabCode", labCode);
			query.setParameter("CommitteeShortName", committeeCode);
			BigInteger committeeMainId = (BigInteger)query.getSingleResult();
			return committeeMainId.longValue();
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl getCommitteeMainIdByCommitteeCode "+ e);
			return 0L;
		}
	}
	
	private static final String GETCOMMITTEEMIDBYCOMMITTEECODE = "SELECT a.committeeId FROM committee a WHERE a.CommitteeShortName=:CommitteeShortName AND a.IsActive=1";
	@Override
	public Long getCommitteeIdByCommitteeCode(String committeeCode) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETCOMMITTEEMIDBYCOMMITTEECODE);
			//query.setParameter("LabCode", labCode);
			query.setParameter("CommitteeShortName", committeeCode);
			BigInteger committeeMainId = (BigInteger)query.getSingleResult();
			return committeeMainId.longValue();
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl getCommitteeIdByCommitteeCode "+ e);
			return 0L;
		}
	}
	
	private static final String GETLATESTSCHEDULEID1 = "SELECT a.ScheduleId FROM committee_schedule a WHERE a.MeetingId LIKE :SequenceNo ORDER BY ScheduleDate DESC LIMIT 1 OFFSET 1";
	private static final String GETLATESTSCHEDULEID2 = "SELECT a.ScheduleId FROM committee_schedule a WHERE a.MeetingId LIKE :SequenceNo ORDER BY ScheduleDate DESC LIMIT 1";
	@Override
	public Long getLatestScheduleId(String sequenceNo, String meetingType) throws Exception {

		try {
			Query query = manager.createNativeQuery(meetingType.equalsIgnoreCase("C")?GETLATESTSCHEDULEID1:GETLATESTSCHEDULEID2);
			query.setParameter("SequenceNo", sequenceNo);
			BigInteger scheduleId =  (BigInteger)query.getSingleResult();
			return scheduleId.longValue();
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl getLatestScheduleId "+ e);
			return 0L;
		}
	}
	
	private static final String GETLATESTSCHEDULEMINUTESTIDS = "SELECT (CAST(ScheduleMinutesId AS CHAR)) AS 'ScheduleMinutesId' FROM committee_schedules_minutes_details WHERE ScheduleId =:ScheduleId";
	@Override
	public List<String> getLatestScheduleMinutesIds(String scheduleId) throws Exception {
		List<String> list = new ArrayList<>();
		try {
			Query query = manager.createNativeQuery(GETLATESTSCHEDULEMINUTESTIDS);
			query.setParameter("ScheduleId", scheduleId);
			list =  (List<String>)query.getResultList();
			return list;
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl getLatestScheduleMinutesIds "+ e);
			return null;
		}
	}
	
	private static final String GETCLUSTERLABLISTBYCLUSTERID ="SELECT a.LabId, a.LabName, a.LabCode, b.IsCluster FROM cluster_lab a, lab_master b WHERE a.LabId=b.LabId AND a.ClusterId=:ClusterId ORDER BY a.LabCode";
	@Override
	public List<Object[]> getClusterLabListByClusterId(String clusterId) throws Exception
	{
		try {
			Query query=manager.createNativeQuery(GETCLUSTERLABLISTBYCLUSTERID);
			query.setParameter("ClusterId", clusterId);
			return (List<Object[]>)query.getResultList();
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl getClusterLabListByClusterId "+ e);
			return new ArrayList<Object[]>();
		}

	}
	
	@Override
	public List<CommitteeSchedule> getScheduleListByScheduleType(String scheduleType) throws Exception {
		try {
			Query query = manager.createQuery("FROM CommitteeSchedule WHERE ScheduleType=:ScheduleType AND IsActive=1");
			query.setParameter("ScheduleType", scheduleType);
			return (List<CommitteeSchedule>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl getScheduleListByScheduleType "+e);
			return null;
		}
	}
	
}
