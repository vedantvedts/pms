package com.vts.pfms.ccm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.committee.dto.CommitteeMembersEditDto;
import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.committee.model.CommitteeScheduleAgenda;

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
	public Long getLatestScheduleId(String sequenceNo, String meetingType) throws Exception;
	public List<String> getLatestScheduleMinutesIds(String scheduleId) throws Exception;
	public List<Object[]> getClusterLabListByClusterId(String clusterId) throws Exception;
	public List<CommitteeSchedule> getScheduleListByScheduleType(String scheduleType) throws Exception;
	
}
