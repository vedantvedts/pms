package com.vts.pfms.master.dao;

import java.util.List;

import com.vts.pfms.master.dto.DivisionEmployeeDto;
import com.vts.pfms.master.model.DivisionEmployee;
import com.vts.pfms.master.model.DivisionGroup;
import com.vts.pfms.master.model.Employee;
import com.vts.pfms.master.model.EmployeeExternal;
import com.vts.pfms.master.model.MilestoneActivityType;
import com.vts.pfms.master.model.PfmsFeedback;
import com.vts.pfms.model.LabMaster;

public interface MasterDao  {
	
	public List<Object[]> OfficerList() throws Exception;
	public List<Object[]> DesignationList() throws Exception;
	public List<Object[]> OfficerDivisionList() throws Exception;
	public List<Object[]> OfficerEditData(String OfficerId) throws Exception;
	public int OfficerMasterDelete(Employee employee) throws Exception;
	public List<String> EmpNoCheck() throws Exception;
	public Long OfficeMasterInsert(Employee employee) throws Exception;
	public int OfficerMasterUpdate(Employee employee) throws Exception;
	public List<Object[]> LabList()throws Exception;
	public Long OfficeMasterExternalInsert(Employee empExternal)throws Exception;
	public List<Object[]> ExternalOfficerList()throws Exception;
	public List<Object[]> ExternalOfficerEditData(String officerId) throws Exception;
	public int OfficerExtUpdate(Employee employee) throws Exception;
	public Object[] getOfficerDetalis(String officerId)throws Exception;
	public List<Object[]> updateAndGetList(Long empId, String newSeniorityNumber)throws Exception;
	public int  updateAllSeniority(Long empIdL, Long long1)throws Exception;
	public List<Object[]> DivisionList() throws Exception;
	public List<Object[]> DivisionEmpList(String divisionid) throws Exception;
	public List<Object[]> DivisionNonEmpList(String divisionid) throws Exception;
	public Object[] DivisionData(String divisionid) throws Exception;
	public int DivsionEmployeeRevoke(DivisionEmployeeDto dto) throws Exception;
	public long DivisionAssignSubmit(DivisionEmployee model) throws Exception;
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
	public int LabMasterUpdate(LabMaster labmaster) throws Exception;
	public List<Object[]> LabsList() throws Exception;
	public List<String> EmpExtNoCheck() throws Exception;
	public int OfficerExtDelete(Employee employee) throws Exception;
	public List<Object[]> empNoCheckAjax(String empno) throws Exception;
	public List<Object[]> extEmpNoCheckAjax(String empno) throws Exception;
	public Long FeedbackInsert(PfmsFeedback feedback) throws Exception;
	public List<Object[]> FeedbackList(String LabCode) throws Exception;
	public List<Object[]> FeedbackListForUser(String LabCode , String empid) throws Exception;
	public Object[] FeedbackContent(String feedbackid) throws Exception;
	public int CloseFeedback(String feedbackId , String remarks, String username)throws Exception;
	
}
