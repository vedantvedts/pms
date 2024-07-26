package com.vts.pfms.ccm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.ccm.model.CCMSchedule;
import com.vts.pfms.ccm.model.CCMScheduleAgenda;
import com.vts.pfms.committee.dto.CommitteeMembersEditDto;

public interface CCMService {

	public long ccmCommitteeMainMembersSubmit(CommitteeMembersEditDto dto, String action) throws Exception;
	public List<CCMSchedule> getCCMScheduleList(String year) throws Exception;
	public CCMSchedule getCCMScheduleById(String ccmScheduleId) throws Exception;
	public long addCCMSchedule(CCMSchedule ccmSchedule, String labcode) throws Exception;
	public long addCCMAgendaDetails(HttpServletRequest req, HttpSession ses, Map<String, MultipartFile> fileMap, String ccmScheduleId) throws Exception;
	public List<Object[]> getCCMScheduleAgendaListByCCMScheduleId(String ccmScheduleId) throws Exception;
	public CCMScheduleAgenda getCCMScheduleAgendaById(String ccmScheduleAgendaId) throws Exception;
	public Long addCCMScheduleAgenda(CCMScheduleAgenda agenda, MultipartFile attachment, String labcode) throws Exception;
	public Long ccmAgendaPriorityUpdate(String[] ccmScheduleAgendaId, String[] agendaPriority) throws Exception;
	public long ccmScheduleAgendaDelete(String scheduleAgendaId, String userId, String ccmScheduleId,String agendaPriority) throws Exception;
	public long addCCMAgendaDetails(HttpServletRequest req, HttpSession ses, MultipartFile[] attachments) throws Exception;
	public int ccmScheduleSubAgendaDelete(String scheduleAgendaId, String userId, String ccmScheduleId, String agendaPriority, String parentScheduleAgendaId) throws Exception;
}
