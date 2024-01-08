package com.vts.pfms.mail;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;
@Transactional
@Repository
public class MailDaoImpl implements MailDao {

	@PersistenceContext
	EntityManager manager;
	
	private static final String MEETINGS="SELECT cs.scheduleid,cs.projectid,cs.InitiationId,c.CommitteeShortName,c.CommitteeName,cs.MeetingVenue,cs.ScheduleStartTime,pm.projectcode,pm.projectshortname FROM committee_schedule cs,committee c ,project_master pm WHERE  c.CommitteeId=cs.CommitteeId AND pm.projectid=cs.projectid AND  cs.ScheduleDate=:date AND cs.isactive='1'";
	@Override
	public List<Object[]> getTodaysMeetings(String date) throws Exception {
		Query query = manager.createNativeQuery(MEETINGS);
		query.setParameter("date", date);
		
		return (List<Object[]>)query.getResultList();
	}
	private static final String MAILPROPERTIESCONFIGURATION = "SELECT a.MailConfigurationId,a.TypeOfHost,a.Host,a.Port,a.Username,a.Password,a.CreatedBy,a.CreatedDate FROM mail_configuration a WHERE a.TypeOfHost=:typeOfHost LIMIT 1";
	@Override
	public List<Object[]> GetMailPropertiesByTypeOfHost(String typeOfHost)throws Exception{
		Query query = manager.createNativeQuery(MAILPROPERTIESCONFIGURATION);
		query.setParameter("typeOfHost", typeOfHost);
		List<Object[]> GetMailPropertiesByTypeOfHost = query.getResultList();
		return GetMailPropertiesByTypeOfHost;

		
	}

}
