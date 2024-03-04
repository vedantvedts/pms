package com.vts.pfms.committee.dao;

import java.util.List;

import com.vts.pfms.committee.model.RODMaster;

public interface RODDao {

	public List<Object[]> rodProjectScheduleListAll(String projectId) throws Exception;
	public Object[] getRODMasterDetails(String rodNameId) throws Exception;
	public List<Object[]> rodProjectScheduleListAll(String projectId, String rodNameId) throws Exception;
	public List<Object[]> rodNamesList() throws Exception;
	public Long addNewRODName(RODMaster master) throws Exception;
	public Object[] RODScheduleEditData(String CommitteeScheduleId) throws Exception;

}
