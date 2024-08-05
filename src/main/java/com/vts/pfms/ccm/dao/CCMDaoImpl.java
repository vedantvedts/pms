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

import com.vts.pfms.ccm.model.CCMSchedule;
import com.vts.pfms.ccm.model.CCMScheduleAgenda;
import com.vts.pfms.committee.model.CommitteeMember;

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
	public List<CCMSchedule> getCCMScheduleList(String year) throws Exception {
		try {
			Query query = manager.createQuery("FROM CCMSchedule WHERE SUBSTR(MeetingDate,1,4)=:Year AND IsActive=1");
			query.setParameter("Year", year);
			return (List<CCMSchedule>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl getCCMScheduleByDate "+e);
			return null;
		}
	}
	
	@Override
	public CCMSchedule getCCMScheduleById(String ccmScheduleId) throws Exception {
		try {
			return manager.find(CCMSchedule.class, Long.parseLong(ccmScheduleId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl getCCMScheduleById "+e);
			return null;
		}
		
	}

	@Override
	public long addCCMSchedule(CCMSchedule ccmSchedule) throws Exception {
		try {
			manager.persist(ccmSchedule);
			manager.flush();
			return ccmSchedule.getCCMScheduleId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl addCCMSchedule "+e);
			return 0;
		}
	}
	
	private static final String GETMAXCCMSCHEDULEIDFORMONTH="SELECT IFNULL(MAX(CCMScheduleId),0) AS 'MAX' FROM pfms_ccm_schedule WHERE IsActive=1 AND MeetingRefNo LIKE :Month";
	@Override
	public long getMaxCCMScheduleIdForMonth(String month) throws Exception {

		try {
			Query query =  manager.createNativeQuery(GETMAXCCMSCHEDULEIDFORMONTH);
			query.setParameter("Month", "%"+month+"%");
			BigInteger ccmScheduleId=(BigInteger)query.getSingleResult();
			return ccmScheduleId.longValue();
		}catch ( NoResultException e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl getMaxCCMScheduleIdForMonth "+ e);
			return 0;
		}
	}
	
	@Override
	public Long addCCMScheduleAgenda(CCMScheduleAgenda agenda) throws Exception {
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
	
	private static final String GETCCMSCHEDULEAGENDALISTBYCCMSCHEDULEID = "SELECT b.ScheduleAgendaId, b.CCMScheduleId, b.ParentScheduleAgendaId, b.AgendaPriority, b.AgendaItem, \r\n"
			+ "	b.PresenterLabCode, b.PresenterId, b.StartTime, b.EndTime, b.Duration, b.AttatchmentPath,\r\n"
			+ "	(CASE WHEN b.PresenterLabCode='@EXP' THEN (SELECT CONCAT(IFNULL(CONCAT(c.Title,' '),''), c.ExpertName,', ',d.Designation) FROM expert c, employee_desig d WHERE c.ExpertId=b.PresenterId AND c.DesigId=d.DesigId LIMIT 1) \r\n"
			+ "	   ELSE (SELECT CONCAT(IFNULL(CONCAT(c.Title,' '),''), c.EmpName,', ',d.Designation) FROM employee c, employee_desig d WHERE c.EmpId=b.PresenterId AND c.DesigId=d.DesigId LIMIT 1) END) AS 'Presenter'\r\n"
			+ "FROM pfms_ccm_schedule a, pfms_ccm_schedule_agenda b\r\n"
			+ "WHERE a.CCMScheduleId=b.CCMScheduleId AND b.IsActive=1 AND a.CCMScheduleId=:CCMScheduleId\r\n"
			+ "ORDER BY b.ParentScheduleAgendaId,b.AgendaPriority";
	@Override
	public List<Object[]> getCCMScheduleAgendaListByCCMScheduleId(String ccmScheduleId) throws Exception {
		try {
			Query query = manager.createNativeQuery(GETCCMSCHEDULEAGENDALISTBYCCMSCHEDULEID);
			query.setParameter("CCMScheduleId", ccmScheduleId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl getCCMScheduleAgendaListByCCMScheduleId "+e);
			return new ArrayList<Object[]>();
		}
	}
	
	@Override
	public CCMScheduleAgenda getCCMScheduleAgendaById(String ccmScheduleAgendaId) throws Exception {
		try {
			return manager.find(CCMScheduleAgenda.class, Long.parseLong(ccmScheduleAgendaId));
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside CCMDaoImpl getCCMScheduleAgendaById "+e);
			return null;
		}
		
	}
	
	private static final String GETMAXAGENDAPRIORITY ="SELECT IFNULL(MAX(AgendaPriority),0) AS 'MAX' FROM pfms_ccm_schedule_agenda WHERE CCMScheduleId=:CCMScheduleId AND ParentScheduleAgendaId=:ParentScheduleAgendaId";
	@Override
	public int getMaxAgendaPriority(String ccmScheduleId, String parentScheduleAgendaId) throws Exception {

		try {
			Query query =  manager.createNativeQuery(GETMAXAGENDAPRIORITY);
			query.setParameter("CCMScheduleId", ccmScheduleId);
			query.setParameter("ParentScheduleAgendaId", parentScheduleAgendaId);
			BigInteger agendaPriority=(BigInteger)query.getSingleResult();
			return agendaPriority.intValue();
		}catch ( NoResultException e ) {
			logger.error(new Date() +" Inside CCMDaoImpl getMaxAgendaPriority "+ e);
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String CCMAGENDAPRIORITYUPDATE ="UPDATE pfms_ccm_schedule_agenda SET AgendaPriority=:AgendaPriority WHERE ScheduleAgendaId=:ScheduleAgendaId";
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
	
	private static final String GETCCMSCHEDULEAGENDASAFTER ="SELECT ScheduleAgendaId,AgendaPriority FROM pfms_ccm_schedule_agenda WHERE CCMScheduleId=:CCMScheduleId AND ParentScheduleAgendaId=:ParentScheduleAgendaId AND AgendaPriority>:AgendaPriority ORDER BY AgendaPriority ASC";
	@Override
	public List<Object[]> getCCMScheduleAgendasAfter(String ccmScheduleId,String agendaPriority, String parentScheduleAgendaId) throws Exception
	{
		try {
			Query query=manager.createNativeQuery(GETCCMSCHEDULEAGENDASAFTER);
			query.setParameter("AgendaPriority", agendaPriority);
			query.setParameter("CCMScheduleId", ccmScheduleId);
			query.setParameter("ParentScheduleAgendaId", parentScheduleAgendaId);
			return (List<Object[]>)query.getResultList();
		}catch ( Exception e ) {
			e.printStackTrace();
			logger.error(new Date() +" Inside CCMDaoImpl getCCMScheduleAgendasAfter "+ e);
			return new ArrayList<Object[]>();
		}

	}
	
	private static final String CCMSCHEDULEAGENDADELETE = "UPDATE pfms_ccm_schedule_agenda SET ModifiedBy=:ModifiedBy, ModifiedDate=:ModifiedDate, IsActive=0, AgendaPriority=0 WHERE ScheduleAgendaId=:ScheduleAgendaId";
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
	
	private static final String CCMSCHEDULESUBAGENDADELETE = "UPDATE pfms_ccm_schedule_agenda SET ModifiedBy=:ModifiedBy, ModifiedDate=:ModifiedDate, IsActive=0, AgendaPriority=0 WHERE ParentScheduleAgendaId=:ScheduleAgendaId";
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
	
	private static final String UPDATECCMSCHEDULEAGENDADURATION = "UPDATE pfms_ccm_schedule_agenda SET Duration=(Duration - :OrgDuration)+:Duration WHERE ScheduleAgendaId=:ScheduleAgendaId";
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
}
