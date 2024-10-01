package com.vts.pfms.ccm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.ccm.model.CCMASPStatus;
import com.vts.pfms.ccm.model.CCMAchievements;
import com.vts.pfms.ccm.model.CCMClosureStatus;
import com.vts.pfms.ccm.model.CCMPresentationSlides;
import com.vts.pfms.committee.dto.CommitteeMembersEditDto;
import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.committee.model.CommitteeScheduleAgenda;
import com.vts.pfms.login.PFMSCCMData;

public interface CCMService {

	public long ccmCommitteeMainMembersSubmit(CommitteeMembersEditDto dto, String action) throws Exception;
	public List<CommitteeSchedule> getScheduleListByYear(String year) throws Exception;
	public CommitteeSchedule getCCMScheduleById(String ccmScheduleId) throws Exception;
	public long addCCMSchedule(CommitteeSchedule schedule) throws Exception;
	public long addCCMAgendaDetails(HttpServletRequest req, HttpSession ses, Map<String, MultipartFile> fileMap, String ccmScheduleId) throws Exception;
	public List<Object[]> getCCMScheduleAgendaListByCCMScheduleId(String ccmScheduleId) throws Exception;
	public CommitteeScheduleAgenda getCCMScheduleAgendaById(String ccmScheduleAgendaId) throws Exception;
	public Long addCCMScheduleAgenda(CommitteeScheduleAgenda agenda, MultipartFile attachment, String labcode, int orgDuration) throws Exception;
	public Long ccmAgendaPriorityUpdate(String[] ccmScheduleAgendaId, String[] agendaPriority) throws Exception;
	public long ccmScheduleAgendaDelete(String scheduleAgendaId, String userId, String ccmScheduleId,String agendaPriority) throws Exception;
	public long addCCMAgendaDetails(HttpServletRequest req, HttpSession ses, MultipartFile[] attachments) throws Exception;
	public int ccmScheduleSubAgendaDelete(String scheduleAgendaId, String userId, String ccmScheduleId, String agendaPriority, String parentScheduleAgendaId) throws Exception;
	public Long getCommitteeMainIdByCommitteeCode(String committeeCode) throws Exception;
	public Long getCommitteeIdByCommitteeCode(String committeeCode) throws Exception;
	public Long getLatestScheduleId(String scheduleType) throws Exception;
	public Long getSecondLatestScheduleId(String scheduleType) throws Exception;
	public List<String> getLatestScheduleMinutesIds(String scheduleId) throws Exception;
	public List<Object[]> getClusterLabListByClusterId(String clusterId) throws Exception;
	public List<CommitteeSchedule> getScheduleListByScheduleType(String scheduleType) throws Exception;
	public List<CCMAchievements> getCCMAchievementsByScheduleId(Long scheduleId, String topicType) throws Exception;
	public CCMAchievements getCCMAchievementsById(String achievementId) throws Exception;
	public long addCCMAchievements(CCMAchievements achmnts, MultipartFile imageAttachment, MultipartFile pdfAttachment, MultipartFile videoAttachment, String clusterId) throws Exception;
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
	public CCMClosureStatus getCCMClosureStatusById(String ccmClosureId) throws Exception;
	public long addCCMClosureStatus(HttpServletRequest req, HttpSession ses) throws Exception;
	public HashMap<String, List<Object[]>> getClosureStatusList(String scheduleId) throws Exception;
	public int ccmClosureStatusDelete(String ccmClosureId) throws Exception;
	public long addCCMClosureStatus(CCMClosureStatus closure) throws Exception;
	public HashMap<String, List<Object[]>> getCCMASPList(String scheduleId) throws Exception;
	public long addCCMASPStatus(CCMASPStatus aspData) throws Exception;
	public int ccmCashoutGoDelete(String labCode) throws Exception;
	public CCMASPStatus getCCMASPStatusById(String ccmASPStatusId) throws Exception;
	public long getMaxCCMScheduleIdForMonth(String sequence) throws Exception;
	public Map<String, Map<String, List<Map<String, Object>>>> getCashOutGoListForStackGraph() throws Exception;
}
