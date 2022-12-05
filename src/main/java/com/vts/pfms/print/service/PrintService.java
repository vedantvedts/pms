package com.vts.pfms.print.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.committee.model.Committee;
import com.vts.pfms.milestone.dto.MilestoneActivityLevelConfigurationDto;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.print.model.InitiationSanction;
import com.vts.pfms.print.model.InitiationsanctionCopyAddr;
import com.vts.pfms.print.model.TechImages;

public interface PrintService {

	public Object[] LabList(String LabCode) throws Exception;
	public List<Object[]> PfmsInitiationList(String InitiationId) throws Exception;
	public List<Object[]> GetCostBreakList(String InitiationId , String projecttypeid)throws Exception;
	public List<Object[]> ProjectIntiationDetailsList(String InitiationId) throws Exception;
	public LabMaster LabDetailes(String LabCode)throws Exception;
	public List<Object[]> CostDetailsList(String InitiationId) throws Exception;
	public List<Object[]> ProjectInitiationScheduleList(String InitiationId) throws Exception;
	public List<Object[]> ProjectsList() throws Exception;
	public Object[] ProjectAttributes(String projectid) throws Exception;
	public List<Object[]> EBAndPMRCCount(String projectid) throws Exception;
	public List<Object[]> Milestones(String projectid) throws Exception;
	public List<Object[]> MilestoneSubsystems(String projectid) throws Exception;
	public List<Object[]> LastPMRCActions(String projectid,String committeeid) throws Exception;
	public List<Object[]> OldPMRCActions(String projectid,String committeeid) throws Exception;
	public List<Object[]> ProjectDetails(String ProjectId) throws Exception;
	public List<Object[]> GanttChartList(String ProjectId) throws Exception;
	public Object[] ProjectDataDetails(String projectid) throws Exception;
	public List<Object[]> OldPMRCIssuesList(String projectid) throws Exception;
	public List<Object[]> ProcurementStatusList(String projectid)throws Exception;
	public List<Object[]> RiskMatirxData(String projectid) throws Exception;
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype ,String LabCode) throws Exception;
	public Object[] LastPMRCDecisions(String committeeid, String projectid) throws Exception;
	public List<Object[]> ActionPlanSixMonths(String projectid, String committeeid ) throws Exception;
	public List<Object[]> LastPMRCActions1(String projectid, String committeeid) throws Exception;
	public List<String> ProjectsubProjectIdList(String projectid) throws Exception;
	public List<Object[]> ReviewMeetingList(String projectid, String committeecode) throws Exception;
	public Object[] TechWorkData(String projectid) throws Exception;
	public List<Object[]> ProjectRevList(String projectid) throws Exception;
	public List<Object[]> getMeetingSchedules(String ProjectId,String Month,String Year)throws Exception;
	public Object[] CommitteeScheduleEditData(String CommitteeScheduleId) throws Exception;
	public long getLastPmrcId(String projectid,String committeeid,String scheduleId) throws Exception;
	public long getNextScheduleId(String projectid,String committeeid) throws Exception;
	public int updateBriefingPaperFrozen(long schduleid) throws Exception;
	public String getNextScheduleFrozen(long schduleid) throws Exception;
	public List<Object[]> MilestoneActivityStatus() throws Exception;
	public List<Object[]> MilestonesChange(String projectid, String milestoneactivitystatusid) throws Exception;
	public List<Object[]> GetProjectInitiationSanList()throws Exception;
	public Object[] GetProjectInitiationdata(String initiationId)throws Exception;
	public List<Object[]> GetItemList(String initiationId)throws Exception;
	public List<Object[]> GetAuthorityList()throws Exception;
	public List<Object[]> GetinitiationCopyAddr() throws Exception;
	public List<Object[]> GetinitiationDeptList ()throws Exception;
	public Long AddInitiationSanction(InitiationSanction initiationsac) throws Exception;
	public Long AddCopyAddress(InitiationsanctionCopyAddr copyaddress) throws Exception;
	public Object[] GetInitiationSanctionData(String initiationId)throws Exception;
	public List<Object[]> GetCopyAddressList (String initiationId)throws Exception;
	public int DeleteCopyAddress(String initiationsancopyid) throws Exception;
	public Long EditInitiationSanction(InitiationSanction initiationsac) throws Exception;
    public int saveGranttChart(MultipartFile file,String Name,String path,String labcode)throws Exception;
    public Object[] MileStoneLevelId(String ProjectId, String CommitteeId) throws Exception;
    public int MileStoneLevelUpdate(MilestoneActivityLevelConfigurationDto dto) throws Exception;
    //public List<Object[]> BreifingMilestoneDetails(String ProjectId) throws Exception;
    public int saveTechImages(MultipartFile file,String ProjectId,String path,String userName,String LabCode)throws Exception;
    public List<Object[]> BreifingMilestoneDetails(String ProjectId, String CommitteeCode) throws Exception;
    //public int saveTechImages(MultipartFile file,String ProjectId,String path,String userName)throws Exception;
    public List<TechImages> getTechList(String proId)throws Exception;
    public List<Object[]> SpecialCommitteesList(String LabCode) throws Exception;
    public Committee getCommitteeData(String committeeid) throws Exception;
}
