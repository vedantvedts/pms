package com.vts.pfms.report.service;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.vts.pfms.print.dao.PrintDao;
import com.vts.pfms.report.dao.ReportDao;
import com.vts.pfms.report.model.LabReport;
import com.vts.pfms.report.model.PfmsLabReportMilestone;
import com.vts.pfms.roadmap.dao.RoadMapDao;



@Service
public class ReportServiceImpl implements ReportService {
	
	
	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	@Autowired
	ReportDao dao;
	
	@Autowired
	PrintDao printdao;
	
	private static final Logger logger = LogManager.getLogger(ReportServiceImpl.class);

	@Override
	public Object[] prjDetails(String projectid) throws Exception {
		// TODO Auto-generated method stub
		return dao.prjDetails(projectid);
	}

	@Override
	public List<Object[]> countPrjEntries(long prjId) throws Exception {
		// TODO Auto-generated method stub
		return dao.countPrjEntries(prjId);
	}

	@Override
	public long addData(LabReport lr) throws Exception {
		// TODO Auto-generated method stub
		return dao.addData(lr);
	}

	@Override
	public long updateData(LabReport lr) throws Exception {
		// TODO Auto-generated method stub
		return dao.updateData(lr);
	}

	@Override
	public LabReport getLabReportDetails(String labReportId) throws Exception {
		return dao.getLabReportDetails(labReportId);
	}

	@Override
	public Object[] editorData(String projectid) throws Exception {
		// TODO Auto-generated method stub
				return dao.editorData(projectid);
	}

	@Override
	public List<Object[]> mileStoneData(int currentYear,String projectid) throws Exception {
		
		return dao.mileStoneData(currentYear,projectid);
	}

	@Override
	public List<Object[]> newMilesetoneData(String projectid) throws Exception {

		List<Object[]> milestones = printdao.Milestones(projectid,"1" );
		
		return null;
	}

	@Override
	public long LabReportMilestone(PfmsLabReportMilestone pm) throws Exception {
		// TODO Auto-generated method stub
		return dao.LabReportMilestone(pm);
	}
@Override
public List<PfmsLabReportMilestone> getPfmsLabReportMilestoneData(String projectid) throws Exception {
	// TODO Auto-generated method stub
	return dao.getPfmsLabReportMilestoneData(projectid);
}
}
