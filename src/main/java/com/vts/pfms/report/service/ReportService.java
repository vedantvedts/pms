package com.vts.pfms.report.service;

import java.util.List;

import com.vts.pfms.report.model.LabReport;

public interface ReportService {

	 public Object[] prjDetails(String projectid) throws Exception;

	public List<Object[]> countPrjEntries(long prjId)throws Exception;

	public long addData(LabReport lr) throws Exception;

	public long updateData(LabReport lr) throws Exception;

	public LabReport getLabReportDetails(String labReportId) throws Exception;

	public Object[] editorData(String projectid)throws Exception;

	public List<Object[]> mileStoneData(int currentYear,String projectid)throws Exception;
	

}
