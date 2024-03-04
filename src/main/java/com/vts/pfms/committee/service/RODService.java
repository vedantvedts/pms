package com.vts.pfms.committee.service;

import java.util.List;

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
	
}
