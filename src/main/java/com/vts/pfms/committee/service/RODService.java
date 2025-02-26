package com.vts.pfms.committee.service;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.vts.pfms.committee.dto.CommitteeScheduleDto;
import com.vts.pfms.committee.model.RODMaster;

public interface RODService {

	public List<Object[]> rodProjectScheduleListAll(String projectId) throws Exception;
	public Object[] getRODMasterDetails(String rodNameId) throws Exception;
	public List<Object[]> rodProjectScheduleListAll(String projectId, String rodNameId) throws Exception;
	public List<Object[]> rodNamesList() throws Exception;
	public Long addNewRODName(RODMaster master) throws Exception;
	public long RODScheduleAddSubmit(CommitteeScheduleDto committeescheduledto) throws Exception;
	public Object[] RODScheduleEditData(String CommitteeScheduleId) throws Exception;
	public  Long RODScheduleUpdate(CommitteeScheduleDto committeescheduledto) throws Exception;
	public Object[] RODScheduleData(String CommitteeScheduleId) throws Exception;
	public List<Object[]> RODMeetingSearchList(String MeetingId, String LabCode) throws Exception;
	public long RODPreviousAgendaAdd(String scheduleidto, String[] fromagendaids, String userid) throws Exception;
	public Object[] KickOffRODMeeting(HttpServletRequest req, RedirectAttributes redir) throws Exception;
	public List<Object[]> RODActionDetails(String rodNameId) throws Exception;
	public  int RODMeetingNo(Object[] scheduledata) throws Exception;
	public List<Object[]> industryPartnerRepListInvitations(String industryPartnerId, String scheduleid) throws Exception;
	
}
