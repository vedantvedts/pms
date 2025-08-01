package com.vts.pfms.milestone.dao;

import java.util.List;
import java.util.Optional;

import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.milestone.dto.MileEditDto;
import com.vts.pfms.milestone.dto.MilestoneActivityDto;
import com.vts.pfms.milestone.model.ActivityTransaction;
import com.vts.pfms.milestone.model.FileDocAmendment;
import com.vts.pfms.milestone.model.FileDocMaster;
import com.vts.pfms.milestone.model.FileProjectDoc;
import com.vts.pfms.milestone.model.FileRepMaster;
import com.vts.pfms.milestone.model.FileRepNew;
import com.vts.pfms.milestone.model.FileRepUploadNew;
import com.vts.pfms.milestone.model.MilestoneActivity;
import com.vts.pfms.milestone.model.MilestoneActivityLevel;
import com.vts.pfms.milestone.model.MilestoneActivityRev;
import com.vts.pfms.milestone.model.MilestoneActivitySub;
import com.vts.pfms.milestone.model.MilestoneActivitySubRev;
import com.vts.pfms.milestone.model.MilestoneSchedule;
import com.vts.pfms.print.model.ProjectTechnicalWorkData;

public interface MilestoneDao {
	public List<Object[]> MilestoneActivityList(String ProjectId) throws Exception;
	public List<Object[]> ProjectList() throws Exception ;
	public List<Object[]> EmployeeList() throws Exception;
	public long MilestoneActivity(MilestoneActivity Milestone)throws Exception;
	public int MilestoneCount(String ProjectId) throws Exception;
	public List<Object[]> MilestoneActivity(String MilestoneActivityId) throws Exception;
	public long MilestoneActivityLevelInsert(MilestoneActivityLevel MileActivityLevel)throws Exception;
	public List<Object[]> MilestoneActivityLevel(String MilestoneActivityId,String LevelId) throws Exception;
	public int MilestoneRevisionCount(String MileActivityId) throws Exception;
	public MilestoneActivity MileActivityDetails(Long Id)throws Exception;
	public long MilestoneActivitySubRev(MilestoneActivitySubRev Milestone)throws Exception;
	public long MilestoneActivityRev(MilestoneActivityRev Milestone)throws Exception;
	public List<Object[]> MilestoneActivityData(String ActivityId) throws Exception;
	public List<MilestoneActivityLevel> ActivityLevelList(Long Id,Long LevelId);
	public List<Object[]> ActivityLevelData(String ActivityId) throws Exception;
	public List<Object[]> ActivityTypeList() throws Exception ;
	public int MilestoneActivityMainUpdate(MileEditDto dto) throws Exception;
	public int ActivityLevelEditUpdate(MileEditDto dto) throws Exception;
	public int ActivityLevelFullEdit(MileEditDto dto) throws Exception;
	public int MilestoneActivityUpdate(MileEditDto dto) throws Exception;
	public List<Object[]> ActivityCompareMAin(String ActivityId,String Rev,String Rev1) throws Exception;
	public List<Object[]> ActivityLevelCompare(String ActivityId,String Rev,String Rev1,String LevelId) throws Exception;
	public List<Object[]> MilestoneActivityEmpIdList(String EmpId) throws Exception;
	public List<Object[]> StatusList() throws Exception;
	public int ActivityProgressMainUpdate(MileEditDto dto) throws Exception;
	public int ActivityProgressUpdateLevel(MileEditDto dto) throws Exception;
	public List<Object[]> MilestoneReportsList(String ProjectId) throws Exception;
	public long MilestoneActivitySubInsert(MilestoneActivitySub sub)throws Exception;
	public List<Object[]> MilestoneActivitySub(String ActivityId,String Type) throws Exception;
    public com.vts.pfms.milestone.model.MilestoneActivitySub ActivityAttachmentDownload(Long ActivitySubId)throws Exception;
    public List<Object[]> ProjectDetails(String ProjectId)throws Exception;
    public List<Object[]> MilestoneActivityAssigneeList(String ProjectId,String EmpId) throws Exception;
	public List<Object[]> ProjectAssigneeList(String EmpId) throws Exception ;
	public int MilestoneActivityAssign(MilestoneActivityDto dto)throws Exception;
	public int MilestoneActivityAccept(MilestoneActivityDto dto,String dt)throws Exception;
	public int MilestoneActivityBack(MilestoneActivityDto dto)throws Exception;
	public List<Object[]> ActionList(String actiontype,String activityid) throws Exception;
	public long ActivityTransactionInsert(ActivityTransaction trans)throws Exception;
	public int ActivityMainSum(String Id,String ProjectId) throws Exception;
	public int ActivityLevelSum(String Id,String ActivityId,String LevelId) throws Exception;
	public List<Object[]> BaseLineMain(String ActivityId) throws Exception;
	public List<Object[]> BaseLineLevel(String ActivityId,String LevelId) throws Exception;
	public List<Object[]> WeightageLevel(String ActivityId,String LevelId) throws Exception;
	//changed
	public int ProgressMain(String ActivityId,String Status,int Progress,String DateOfCompletion,MileEditDto MileEditDto) throws Exception;
	public int ProgressLevel(String ActivityId,String Status,int Progress,MileEditDto dto) throws Exception;
	public int RevMainUpdate(String ActivityId,String Rev) throws Exception;
	public int RevLevelUpdate(String ActivityId,String Rev) throws Exception;
	public int FileRepRevUpdate(String ActivityId, Long Rev,Long ver) throws Exception;
	public String FilePass(String Userid)throws Exception;
	public List<Object[]> FileDeatils(String FileId) throws Exception;
	public List<Object[]> MilestoneScheduleList(String ProjectId) throws Exception;
	public Long MilestoneScheduleInsert(MilestoneSchedule Milestone) throws Exception;
	public int MilestoneScheduleCount(String ProjectId) throws Exception;
	public List<Object[]> MilestoneExcel(String ProjectId)throws Exception;
    public List<Object[]> MainSystem(String projectid)throws Exception;
    public long RepMasterInsert(FileRepMaster RepMaster)throws Exception;
    public List<Object[]> MainSystemLevel(String ParentId)throws Exception;
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype, String LabCode) throws Exception;
	public List<Object[]> ProjectEmpList(String projectid, String Labcode) throws Exception;
	public List<Object[]> AllEmpNameDesigList(String labcode) throws Exception;
	public List<Object[]> ProjectEmpListEdit(String projectid,String id)throws Exception;
	public List<Object[]> DocumentTypeList(String ProjectId,String LabCode) throws Exception;
	public List<Object[]> DocumentTitleList(String ProjectId,String Sub,String LabCode) throws Exception;
	public List<Object[]> DocumentStageList(String documenttype,String levelid) throws Exception;
	public long FileSubInsertNew(FileRepNew fileRepo)throws Exception;
	public long FileUploadInsertNew(FileRepUploadNew fileRepUplod) throws Exception;
	public List<Object[]> VersionCheckList(String ProjectId, String SubsystemId,String documenttitle) throws Exception;
	public List<Object[]> FileHistoryList(String filerepid) throws Exception;
	public List<Object[]> FileRepMasterListAll(String projectid,String LabCode ) throws Exception;
	public List<Object[]> FileDocMasterListAll(String projectid,String LabCode) throws Exception;
	public long ProjectDocumetsAdd(FileProjectDoc model) throws Exception;
	public List<Object[]> DocumentAmendment(String FileRepUploadId) throws Exception;
	public long DocumetAmmendAdd(FileDocAmendment model) throws Exception;
	public Object[] DocumentAmendmentData(String docammendmentid) throws Exception;
	public Object[] RepMasterData(String filerepmasterid) throws Exception;
	public List<Object[]> RepMasterAllDocLists(String filerepmasterid) throws Exception;
	public List<Object[]> MainSystem1(String filerepmasterid) throws Exception;
	public int fileRepMasterEditSubmit(String filerepmasterid, String levelname) throws Exception;
	public List<FileDocMaster> fileDocMasterList(String LabCode) throws Exception;
	public long FileDocMasterAdd(FileDocMaster model) throws Exception;
	public Object[] fileNameCheck(String levelname, String shortname, String docid, String parentlevelid,String LabCode) throws Exception;
	public long PfmsNotificationAdd(PfmsNotification notification) throws Exception;
	public List<Object[]> MilestoneActivityLevelExcel(String MilestoneActivityId, String LevelId) throws Exception;
	public List<Object[]> MilestoneActivityListNew(String ProjectId) throws Exception;
	public int MilestoneRemarkUpdate(MilestoneActivityDto dto)throws Exception;
	public List<FileDocMaster> FileLevelSublevelNameCheck(String levelname, String LabCode) throws Exception;
	public long MileActivityDetailsUpdtae(com.vts.pfms.milestone.model.MilestoneActivity mainmile) throws Exception;
	
	//prakarsh 
	public void isActive(String project, int fileUploadMasterId, int parentLevelid);
	public List<Object[]> FileRepUploadId(String project , int documentID);
	public int IsFileInActive(String project, int documentID);
	public int DocumentListNameEdit(String filerepmasterid, String levelname);
	public List<Object[]> getMsprojectTaskList(String projectId)throws Exception;
	public List<Object[]> getAttachmentId(String projectid)throws Exception;
	public long submitCheckboxFile(ProjectTechnicalWorkData modal)throws Exception;
	public List<Object[]> getFileRepData(String projectId, String fileRepMasterId, String subL1, String docid)throws Exception;
	public long FileRepUpdate(FileRepNew rep)throws Exception;
	
	public List<Object[]> getMsprojectProcurementStatusList(String projectId) throws Exception;
	public MilestoneActivityLevel getActivityLevelListById(String activitiId);
	public int mileStoneSerialNoUpdate(String newslno, String milestoneActivityId);
	public List<Object[]> getAllMilestoneActivityList() throws Exception;
	public List<Object[]> getAllMilestoneActivityLevelList() throws Exception;
	public List<Object[]> getOldFileDocNames(String projectId,String fileType,String fileId) throws Exception;
	public FileRepNew getFileRepById(long fileRepId)throws Exception;
	public List<Object[]> FileRepDocsList(String projectId)throws Exception;
	public Optional<FileRepUploadNew> getFileById(Long id)throws Exception;
	public int getFileRepMasterNames(String projectId, String fileType, String fileId, String fileName)throws Exception;
	public Optional<FileRepMaster> getFileRepMasterById(long filerepmasterId)throws Exception;
	public List<Object[]> findByFilePathStartingWith(String levelType, Long projectId, Long mainRepMasterId, Long subRepMasterId, String oldName)throws Exception;
	public void updateFileRepUploadById(Long uploadId, String updatedPath)throws Exception;
	public MilestoneActivityLevel getMilestoneActivityLevelById(String id);
	public String getMainLevelId(Long getActivityId)throws Exception;
	public String getProjectIdByMainLevelId(String id)throws Exception;
	public MilestoneActivity getMilestoneActivityById(String id);
	public List<Object[]> actionAssigneeList(String EmpId) throws Exception;
	public List<Object[]> getMilestoneActivityProgressList() throws Exception;
	
}
