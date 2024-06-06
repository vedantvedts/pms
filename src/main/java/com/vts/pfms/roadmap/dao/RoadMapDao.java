package com.vts.pfms.roadmap.dao;

import java.util.List;

import com.vts.pfms.roadmap.model.AnnualTargets;
import com.vts.pfms.roadmap.model.RoadMap;
import com.vts.pfms.roadmap.model.RoadMapAnnualTargets;

public interface RoadMapDao {

	public List<Object[]> roadMapList() throws Exception;
	public List<Object[]> divisionList(String labCode) throws Exception;
	public List<Object[]> getProjectList(String labCode) throws Exception;
	public List<Object[]> getPreProjectList(String labcode) throws Exception;
	public Object[] getProjectDetails(String labcode, String projectId, String roadMapType) throws Exception;
	public RoadMap getRoadMapDetailsById(String roadMapId) throws Exception;
	public List<RoadMapAnnualTargets> getRoadMapAnnualTargetDetails(String roadMapId) throws Exception;
	public long addRoadMapDetails(RoadMap roadMap) throws Exception;
	public int removeRoadMapAnnualTargets(String roadMapId) throws Exception;
	public int removeRoadMapDetails(String roadMapId, String userId) throws Exception;
//	public int roadMapDetailsMoveToASP(String roadMapId, String userId) throws Exception;
	public List<Object[]> roadMapTransApprovalData(String roadMapId);
	public List<Object[]> roadMapTransList(String roadMapId) throws Exception;
	public List<Object[]> roadMapRemarksHistory(String roadMapId) throws Exception;
	public List<Object[]> roadMapPendingList(String empId, String labCode) throws Exception;
	public List<Object[]> roadMapApprovedList(String empId, String fromDate, String toDate) throws Exception;
	public List<RoadMap> getRoadMapList() throws Exception;
	public List<Object[]> roadMapASPList() throws Exception;
	public List<AnnualTargets> getAnnualTargetsFromMaster() throws Exception;
	public Long addAnnualTargets(AnnualTargets targets) throws Exception;
	public AnnualTargets getAnnualTargetsById(String annualTargetId) throws Exception;
	public List<Object[]> getProjectMilestoneActivityList(String labCode) throws Exception;
	public List<Object[]> getPreProjectMilestoneActivityList() throws Exception;

}
