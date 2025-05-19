package com.vts.pfms.report.dao;

import java.util.List;

import com.vts.pfms.report.model.LabReport;
import com.vts.pfms.report.model.PfmsLabReportMilestone;

public interface ReportDao {

	 public Object[] prjDetails(String projectid) throws Exception;

	public List<Object[]> countPrjEntries(long prjId)  throws Exception;

	public long addData(LabReport lr) throws Exception;

	public long updateData(LabReport lr) throws Exception;

	public LabReport getLabReportDetails(String labReportId)  throws Exception;

	public Object[] editorData(String projectid) throws Exception;

	public List<Object[]> mileStoneData(int currentYear,String projectid)throws Exception;

	public long LabReportMilestone(PfmsLabReportMilestone pm)throws Exception;

	public List<PfmsLabReportMilestone> getPfmsLabReportMilestoneData(String projectid)throws Exception;

}
