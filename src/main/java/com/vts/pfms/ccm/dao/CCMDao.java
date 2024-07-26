package com.vts.pfms.ccm.dao;

import java.util.List;

import com.vts.pfms.ccm.model.CCMSchedule;
import com.vts.pfms.ccm.model.CCMScheduleAgenda;
import com.vts.pfms.committee.model.CommitteeMember;

public interface CCMDao {

	public CommitteeMember getCommitteeMemberById(String committeeMemberId) throws Exception;
	public List<CCMSchedule> getCCMScheduleList(String year) throws Exception;
	public CCMSchedule getCCMScheduleById(String ccmScheduleId) throws Exception;
	public long addCCMSchedule(CCMSchedule ccmSchedule) throws Exception;
	public long getMaxCCMScheduleIdForMonth(String month) throws Exception;
	public Long addCCMScheduleAgenda(CCMScheduleAgenda agenda) throws Exception;
	public List<Object[]> getCCMScheduleAgendaListByCCMScheduleId(String ccmScheduleId) throws Exception;
	public CCMScheduleAgenda getCCMScheduleAgendaById(String ccmScheduleAgendaId) throws Exception;
	public int getMaxAgendaPriority(String ccmScheduleId, String parentScheduleAgendaId) throws Exception;
	public int ccmAgendaPriorityUpdate(String scheduleAgendaId,String agendaPriority) throws Exception;
	public List<Object[]> getCCMScheduleAgendasAfter(String ccmScheduleId, String agendaPriority, String ParentScheduleAgendaId) throws Exception;
	public int ccmScheduleAgendaDelete(String scheduleAgendaId, String modifiedby, String modifiedDate) throws Exception;
	public int ccmScheduleSubAgendaDelete(String scheduleAgendaId, String modifiedby, String modifiedDate) throws Exception;
}
