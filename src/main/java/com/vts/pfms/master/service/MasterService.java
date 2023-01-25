package com.vts.pfms.master.service;

import java.util.List;

import com.vts.pfms.master.dto.DivisionEmployeeDto;
import com.vts.pfms.master.dto.LabMasterAdd;
import com.vts.pfms.master.dto.OfficerMasterAdd;
import com.vts.pfms.master.model.DivisionGroup;
import com.vts.pfms.master.model.MilestoneActivityType;
import com.vts.pfms.master.model.PfmsFeedback;

public interface MasterService {
	
	public List<Object[]> OfficerList() throws Exception;
	public List<Object[]> DesignationList() throws Exception;
	public List<Object[]> OfficerDivisionList() throws Exception;
	public List<Object[]> OfficerEditData(String OfficerId) throws Exception;
	public int OfficerMasterDelete(String OfficerId, String UserId) throws Exception;
	public List<String> EmpNoCheck() throws Exception;
	public Long OfficerMasterInsert(OfficerMasterAdd officermasteradd, String UserId) throws Exception;
	public int OfficerMasterUpdate(OfficerMasterAdd officermasteradd, String UserId) throws Exception;
	public List<Object[]> LabList()throws Exception;
	public Object ExternalOfficerList()throws Exception;
	public List<Object[]> ExternalOfficerEditData(String officerId)throws Exception;
	public Object[] getOfficerDetalis(String officerId)throws Exception;
	public int updateSeniorityNumber(String empid, String newSeniorityNumber)throws Exception;
	public List<Object[]> DivisionList() throws Exception;
	public List<Object[]> DivisionEmpList(String divisionid) throws Exception;
	public List<Object[]> DivisionNonEmpList(String divisionid) throws Exception;
	public Object[] DivisionData(String divisionid) throws Exception;
	public int DivsionEmployeeRevoke(DivisionEmployeeDto dto) throws Exception;
	public long DivisionAssignSubmit(DivisionEmployeeDto dto) throws Exception;
	public List<Object[]> ActivityList() throws Exception;
	public Object[] ActivityNameCheck(String activityname) throws Exception;
	public long ActivityAddSubmit(MilestoneActivityType model) throws Exception;
	public List<Object[]> GroupsList(String LabCode) throws Exception;
	public List<Object[]> GroupHeadList(String LabCode) throws Exception;
	public long GroupAddSubmit(DivisionGroup model) throws Exception;
	public Object[] GroupAddCheck(String gcode) throws Exception;
	public Object[] GroupsData(String groupid) throws Exception;
	public int GroupMasterUpdate(DivisionGroup model) throws Exception;
	public List<Object[]> LabMasterList() throws Exception;
	public List<Object[]> EmployeeList() throws Exception;
	public List<Object[]> LabMasterEditData(String LabId) throws Exception;
	public int LabMasterUpdate(LabMasterAdd labmasteredit, String Userid) throws Exception;
	public List<Object[]> LabsList() throws Exception;
	public List<String> EmpExtNoCheck() throws Exception;
	public Long OfficerExtInsert(OfficerMasterAdd officermasteradd, String UserId) throws Exception;
	public int OfficerExtUpdate(OfficerMasterAdd officermasteradd, String UserId) throws Exception;
	public int OfficerExtDelete(String OfficerId, String UserId) throws Exception;
	public List<Object[]> empNoCheckAjax(String empno) throws Exception;
	public List<Object[]> extEmpNoCheckAjax(String empno) throws Exception;
	public Long FeedbackInsert(String Feedback, String UserId, Long EmpId,String feedbacktype) throws Exception;
	public List<Object[]> FeedbackList(String LabCode) throws Exception;
	public List<Object[]> FeedbackListForUser(String LabCode , String empid) throws Exception;
	public Object[] FeedbackContent(String feedbackid) throws Exception;

}
