package com.vts.pfms.ccm.dao;

import java.util.HashMap;
import java.util.List;

import com.vts.pfms.ccm.model.CCMAchievements;
import com.vts.pfms.ccm.model.CCMPresentationSlides;
import com.vts.pfms.committee.model.CommitteeMember;
import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.committee.model.CommitteeScheduleAgenda;
import com.vts.pfms.login.PFMSCCMData;

public interface CCMDao {

	public CommitteeMember getCommitteeMemberById(String committeeMemberId) throws Exception;
	public List<CommitteeSchedule> getScheduleListByYear(String year) throws Exception;
	public CommitteeSchedule getCCMScheduleById(String ccmScheduleId) throws Exception;
	public long addCCMSchedule(CommitteeSchedule ccmSchedule) throws Exception;
	public long getMaxCCMScheduleIdForMonth(String month) throws Exception;
	public Long addCCMScheduleAgenda(CommitteeScheduleAgenda agenda) throws Exception;
	public List<Object[]> getCCMScheduleAgendaListByCCMScheduleId(String ccmScheduleId) throws Exception;
	public CommitteeScheduleAgenda getCCMScheduleAgendaById(String ccmScheduleAgendaId) throws Exception;
	public int getMaxAgendaPriority(String ccmScheduleId, String parentScheduleAgendaId) throws Exception;
	public int ccmAgendaPriorityUpdate(String scheduleAgendaId,String agendaPriority) throws Exception;
	public List<Object[]> getCCMScheduleAgendasAfter(String ccmScheduleId, String agendaPriority, String ParentScheduleAgendaId) throws Exception;
	public int ccmScheduleAgendaDelete(String scheduleAgendaId, String modifiedby, String modifiedDate) throws Exception;
	public int ccmScheduleSubAgendaDelete(String scheduleAgendaId, String modifiedby, String modifiedDate) throws Exception;
	public int updateCCMScheduleAgendaDuration(int orgDuration, int duration, Long scheduleAgendaId) throws Exception;
	public Long getCommitteeMainIdByCommitteeCode(String committeeCode) throws Exception;
	public Long getCommitteeIdByCommitteeCode(String committeeCode) throws Exception;
	public Long getLatestScheduleId(String meetingType) throws Exception;
	public Long getSecondLatestScheduleId(String scheduleType) throws Exception;
	public List<String> getLatestScheduleMinutesIds(String scheduleId) throws Exception;
	public List<Object[]> getClusterLabListByClusterId(String clusterId) throws Exception;
	public List<CommitteeSchedule> getScheduleListByScheduleType(String scheduleType) throws Exception;
	public List<CCMAchievements> getCCMAchievementsByScheduleId(Long scheduleId, String topicType) throws Exception;
	public CCMAchievements getCCMAchievementsById(String achievementId) throws Exception;
	public long addCCMAchievements(CCMAchievements achmnts) throws Exception;
	public int ccmAchievementDelete(String achievementId) throws Exception;
	public HashMap<String, List<Object[]>> getCashOutGoList() throws Exception;
	public long addPFMSCCMData(PFMSCCMData ccmData) throws Exception;
	public List<Object[]> getProjectListByLabCode(String labCode) throws Exception;
	public CCMPresentationSlides getCCMPresentationSlidesByScheduleId(String scheduleId) throws Exception;
	public CCMPresentationSlides getCCMPresentationSlidesById(String ccmPresSlideId) throws Exception;
	public long addCCMPresentationSlides(CCMPresentationSlides slide) throws Exception;
	public Long getLastScheduleIdFromCurrentScheduleId(String ccmScheduleId) throws Exception;
	public List<String> getPreviousScheduleMinutesIds(String scheduleId) throws Exception;
	public List<Object[]> getEBPMRCCalendarData(String monthStartDate, String meeting, String clusterId) throws Exception;
	
}
