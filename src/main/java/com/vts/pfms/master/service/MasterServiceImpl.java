package com.vts.pfms.master.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.master.controller.MasterController;
import com.vts.pfms.master.dao.MasterDao;
import com.vts.pfms.master.dto.DivisionEmployeeDto;
import com.vts.pfms.master.dto.LabMasterAdd;
import com.vts.pfms.master.dto.OfficerMasterAdd;
import com.vts.pfms.master.model.DivisionEmployee;
import com.vts.pfms.master.model.DivisionGroup;
import com.vts.pfms.master.model.Employee;
import com.vts.pfms.master.model.EmployeeExternal;
import com.vts.pfms.master.model.MilestoneActivityType;
import com.vts.pfms.master.model.PfmsFeedback;
import com.vts.pfms.model.LabMaster;

@Service
public class MasterServiceImpl implements MasterService {

	
	private static final Logger logger=LogManager.getLogger(MasterServiceImpl.class);
	
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	@Autowired
	MasterDao dao;
	
	@Override
	public List<Object[]> OfficerList() throws Exception {
		
		return dao.OfficerList();
	}
	
	@Override
	public List<Object[]> DesignationList() throws Exception {
		
		return dao.DesignationList();
	}
	
	@Override
	public List<Object[]> OfficerDivisionList() throws Exception {
		
		return dao.OfficerDivisionList();
	}
	
	@Override
	public List<Object[]> OfficerEditData(String OfficerId) throws Exception {
		
		return dao.OfficerEditData(OfficerId);
	}
	
	@Override
	public int OfficerMasterDelete(String OfficerId, String UserId) throws Exception {

		logger.info(new Date() +" Inside SERVICE OfficerMasterDelete ");
		Employee employee = new Employee();
		employee.setSrNo((long) 0);
		employee.setModifiedBy(UserId);
		employee.setModifiedDate(sdf1.format(new Date()));
		employee.setIsActive(0);
		employee.setEmpId(Long.parseLong(OfficerId));
		
		return dao.OfficerMasterDelete(employee);
	}
	
	@Override
	public int OfficerExtDelete(String OfficerId, String UserId) throws Exception {

		logger.info(new Date() +" Inside SERVICE OfficerExtDelete ");
		Employee employee = new Employee();
		employee.setModifiedBy(UserId);
		employee.setModifiedDate(sdf1.format(new Date()));
		employee.setIsActive(0);
		employee.setEmpId(Long.parseLong(OfficerId));
		
		return dao.OfficerExtDelete(employee);
	}

	@Override
	public List<String> EmpNoCheck() throws Exception {

		return dao.EmpNoCheck();
	}
	
	@Override
	public List<String> EmpExtNoCheck() throws Exception {

		return dao.EmpExtNoCheck();
	}
	
	@Override
	public Long OfficerMasterInsert(OfficerMasterAdd officermasteradd, String UserId) throws Exception 
	{
		logger.info(new Date() +" Inside SERVICE OfficerMasterInsert ");
		Employee employee= new Employee();
		employee.setSalutation(officermasteradd.getSalutation());
		employee.setTitle(officermasteradd.getTitle());
		employee.setEmpNo(officermasteradd.getEmpNo());
		employee.setEmpName(officermasteradd.getEmpName());
		employee.setDesigId(Long.parseLong(officermasteradd.getDesignation()));
		employee.setExtNo(officermasteradd.getExtNo());
		employee.setEmail(officermasteradd.getEmail());
		employee.setDivisionId(Long.parseLong(officermasteradd.getDivision()));
		employee.setDronaEmail(officermasteradd.getDronaEmail());
		employee.setInternetEmail(officermasteradd.getInternalEmail());
		employee.setMobileNo(Long.parseLong(officermasteradd.getMobileNo()));
		employee.setCreatedBy(UserId);
		employee.setCreatedDate(sdf1.format(new Date()));
		employee.setIsActive(1);
		employee.setSrNo(0l);
		employee.setLabCode(officermasteradd.getLabCode());
		return dao.OfficeMasterInsert(employee);
	}
	
	@Override
	public Long OfficerExtInsert(OfficerMasterAdd officermasteradd, String UserId) throws Exception 
	{
		logger.info(new Date() +" Inside SERVICE OfficerExtInsert ");
		Employee empExternal=new Employee();
		empExternal.setSrNo(Long.parseLong(officermasteradd.getSrNo()));
		empExternal.setEmpNo(officermasteradd.getEmpNo());
		empExternal.setLabCode( officermasteradd.getLabId());
		empExternal.setEmpName(officermasteradd.getEmpName());
		empExternal.setDesigId(Long.parseLong(officermasteradd.getDesignation()));
		empExternal.setExtNo(officermasteradd.getExtNo());
		empExternal.setEmail(officermasteradd.getEmail());
		empExternal.setDivisionId(Long.parseLong(officermasteradd.getDivision()));
		empExternal.setDronaEmail(officermasteradd.getDronaEmail());
		empExternal.setInternetEmail(officermasteradd.getInternalEmail());
		empExternal.setTitle(officermasteradd.getTitle());
		empExternal.setSalutation(officermasteradd.getSalutation());
		empExternal.setCreatedBy(UserId);
		empExternal.setCreatedDate(sdf1.format(new Date()));
		empExternal.setIsActive(1);
		empExternal.setMobileNo(Long.parseLong(officermasteradd.getMobileNo()));
		return dao.OfficeMasterExternalInsert(empExternal);
	}
	
	@Override
	public int OfficerMasterUpdate(OfficerMasterAdd officermasteradd, String UserId) throws Exception 
	{
		logger.info(new Date() +" Inside SERVICE OfficerMasterUpdate ");
			Employee empExternal=new Employee();
			empExternal.setTitle(officermasteradd.getTitle());
			empExternal.setSalutation(officermasteradd.getSalutation());
			empExternal.setEmpNo(officermasteradd.getEmpNo());
			empExternal.setEmpName(officermasteradd.getEmpName());
			empExternal.setDesigId(Long.parseLong(officermasteradd.getDesignation()));
			empExternal.setExtNo(officermasteradd.getExtNo());
			empExternal.setMobileNo(Long.parseLong(officermasteradd.getMobileNo()));
			empExternal.setEmail(officermasteradd.getEmail());
			empExternal.setDivisionId(Long.parseLong(officermasteradd.getDivision()));
			empExternal.setDronaEmail(officermasteradd.getDronaEmail());
			empExternal.setInternetEmail(officermasteradd.getInternalEmail());
			empExternal.setModifiedBy(UserId);
			empExternal.setModifiedDate(sdf1.format(new Date()));
			empExternal.setEmpId(Long.parseLong(officermasteradd.getEmpId()));
			
			return dao.OfficerMasterUpdate(empExternal);
		
	}
	
	@Override
	public int OfficerExtUpdate(OfficerMasterAdd officermasteradd, String UserId) throws Exception 
	{		
		logger.info(new Date() +" Inside SERVICE OfficerExtUpdate ");
			Employee empExternal=new Employee();
			empExternal.setEmpNo(officermasteradd.getEmpNo());
			empExternal.setLabCode( officermasteradd.getLabId());
			empExternal.setEmpName(officermasteradd.getEmpName());
			empExternal.setDesigId(Long.parseLong(officermasteradd.getDesignation()));
			empExternal.setExtNo(officermasteradd.getExtNo());
			empExternal.setMobileNo(Long.parseLong(officermasteradd.getMobileNo()));
			empExternal.setEmail(officermasteradd.getEmail());
			empExternal.setDivisionId(Long.parseLong(officermasteradd.getDivision()));
			empExternal.setDronaEmail(officermasteradd.getDronaEmail());
			empExternal.setInternetEmail(officermasteradd.getInternalEmail());
			empExternal.setModifiedBy(UserId);
			empExternal.setModifiedDate(sdf1.format(new Date()));
			empExternal.setEmpId(Long.parseLong(officermasteradd.getEmpId()));
			empExternal.setTitle(officermasteradd.getTitle());
			empExternal.setSalutation(officermasteradd.getSalutation());
			return dao.OfficerExtUpdate(empExternal);
		
	}
    
	@Override
	public List<Object[]> LabList()throws Exception{
		
		return dao.LabList();
	}
	
	@Override
	public List<Object[]>  ExternalOfficerList()throws Exception{
		return dao.ExternalOfficerList();
	}
	@Override
	public List<Object[]> ExternalOfficerEditData(String officerId)throws Exception{
		return dao.ExternalOfficerEditData(officerId);
	}
	
	@Override
	public Object[] getOfficerDetalis(String officerId)throws Exception{
		return dao.getOfficerDetalis(officerId);
	}
	
	@Override
	public int updateSeniorityNumber(String empid, String newSeniorityNumber)throws Exception{
		logger.info(new Date() +" Inside SERVICE updateSeniorityNumber ");
		Long empId=Long.parseLong(empid);
		Long SeniorityNumber=Long.parseLong(newSeniorityNumber);
		int result= 0;
		Long newSeniorityNumberL=SeniorityNumber;
		List<Object[]> EmpSenHaveUpdate=dao.updateAndGetList(empId,newSeniorityNumber);
		List<Object[]> result1=EmpSenHaveUpdate.stream().filter(srno-> Long.parseLong(srno[0].toString())>=SeniorityNumber && Long.parseLong(srno[1].toString())!=empId  ).collect(Collectors.toList());
		
		for(Object[] data:result1) { 
		  Long empIdL=Long.parseLong(data[1].toString()); 
		  result= dao.updateAllSeniority(empIdL, ++newSeniorityNumberL);
		}
		
		return result;
	}
	
	
	@Override
	public List<Object[]> DivisionList()throws Exception
	{	
		return dao.DivisionList();
	}
	@Override
	public List<Object[]> DivisionEmpList(String divisionid)throws Exception
	{
		return dao.DivisionEmpList(divisionid);
	}	
	@Override
	public List<Object[]> DivisionNonEmpList(String divisionid)throws Exception
	{	
		return dao.DivisionNonEmpList(divisionid);
	}
	
	@Override
	public Object[] DivisionData(String divisionid)throws Exception
	{
		return dao.DivisionData(divisionid);
	}
	@Override
	public int DivsionEmployeeRevoke(DivisionEmployeeDto dto)throws Exception
	{
		dto.setModifiedDate(sdf1.format(new Date()));
		return dao.DivsionEmployeeRevoke(dto);
	}
	@Override
	public long DivisionAssignSubmit(DivisionEmployeeDto dto)throws Exception
	{
		logger.info(new Date() +" Inside SERVICE DivisionAssignSubmit ");
		int count=0;
		for(int i=0;i<dto.getEmpId().length;i++)  //
		{
			DivisionEmployee model= new DivisionEmployee();
			model.setDivisionId(Long.parseLong(dto.getDivisionId()));
			model.setEmpId(Long.parseLong(dto.getEmpId()[i]));
			model.setCreatedBy(dto.getCreatedBy());
			model.setCreatedDate(sdf1.format(new Date()));	
			model.setIsActive(1);
			if(dao.DivisionAssignSubmit(model)>0) {
				count++;
			}
		}
		return count;
	}
	
	@Override
	public List<Object[]> ActivityList()throws Exception
	{
		return dao.ActivityList();
	}
	
	@Override
	public Object[] ActivityNameCheck(String activityname)throws Exception
	{	
		return dao.ActivityNameCheck(activityname);
	} 
	@Override
	public long ActivityAddSubmit(MilestoneActivityType model)throws Exception
	{	
		model.setCreatedDate(sdf1.format(new Date()));
		model.setIsActive(1);
		return dao.ActivityAddSubmit(model);
	} 
	
	@Override
	public List<Object[]> GroupsList(String LabCode)throws Exception
	{	
		return dao.GroupsList(LabCode);
	}
	
	@Override
	public List<Object[]> GroupHeadList(String LabCode) throws Exception 
	{
		return dao.GroupHeadList(LabCode);
	}
	
	@Override
	public long GroupAddSubmit(DivisionGroup model) throws Exception 
	{
		model.setCreatedDate(sdf1.format(new Date()));
		model.setIsActive(1);
		return dao.GroupAddSubmit(model);
	}
	
	@Override
	public Object[] GroupAddCheck(String gcode) throws Exception 
	{		
		return dao.GroupAddCheck(gcode); 
	}
	
	@Override
	public Object[] GroupsData(String groupid)throws Exception
	{	
		return dao.GroupsData(groupid); 
	}
	
	
	@Override
	public int GroupMasterUpdate(DivisionGroup model) throws Exception
	{
		model.setModifiedDate(sdf1.format(new Date()));		
		return dao.GroupMasterUpdate(model); 
	}
	
	@Override
	public List<Object[]> LabMasterList() throws Exception
	{
		return dao. LabMasterList();
	}
	@Override
	public List<Object[]> EmployeeList() throws Exception {
		
		return dao.EmployeeList();
	}
	@Override
	public List<Object[]> LabMasterEditData(String LabId) throws Exception {

		
		return dao.LabMasterEditData(LabId);
	}
	
	
	@Override
	public int LabMasterUpdate(LabMasterAdd labmasteredit, String Userid) throws Exception {
		logger.info(new Date() +" Inside SERVICE LabMasterUpdate ");
		LabMaster labmaster= new LabMaster();
		labmaster.setLabCode(labmasteredit.getLabCode());
		labmaster.setLabName(labmasteredit.getLabName());
		labmaster.setLabUnitCode(labmasteredit.getLabUnitCode());
		labmaster.setLabAddress(labmasteredit.getLabAddress());
		labmaster.setLabCity(labmasteredit.getLabCity());
		labmaster.setLabPin(labmasteredit.getLabPin());
		labmaster.setLabMasterId(Integer.parseInt(labmasteredit.getLabMasterId()));
		labmaster.setLabTelNo(labmasteredit.getLabTelephone());
		labmaster.setLabFaxNo(labmasteredit.getLabFaxNo());
		labmaster.setLabEmail(labmasteredit.getLabEmail());
		labmaster.setLabAuthority(labmasteredit.getLabAuthority());
		labmaster.setLabAuthorityId(Long.parseLong(labmasteredit.getLabAuthorityId()));
		labmaster.setLabRfpEmail(labmasteredit.getLabRfpEmail());
		labmaster.setLabId(Long.parseLong(labmasteredit.getLabId()));
		labmaster.setClusterId(Long.parseLong(labmasteredit.getClusterId()));
		labmaster.setModifiedBy(Userid);
		labmaster.setModifiedDate(sdf1.format(new Date()));
//		labmaster.setLabLogo(labmasteredit.getLabLogo());
		
		return dao.LabMasterUpdate(labmaster);
	}
	
	@Override
	public List<Object[]> LabsList() throws Exception 
	{		
		return dao.LabsList();
	}
	
	@Override
	public List<Object[]> empNoCheckAjax(String empno)throws Exception
	{	
		return dao.empNoCheckAjax(empno);
	}
	
	@Override
	public List<Object[]> extEmpNoCheckAjax(String empno)throws Exception
	{	
		return dao.extEmpNoCheckAjax(empno);
	}
	
	@Override
	public Long FeedbackInsert(String Feedback, String UserId,Long EmpId) throws Exception {
		logger.info(new Date() +" Inside SERVICE FeedbackInsert ");
		PfmsFeedback feedback=new PfmsFeedback();
    feedback.setEmpId(EmpId);
    feedback.setFeedback(Feedback);
    feedback.setCreatedBy(UserId);
    feedback.setCreatedDate(sdf1.format(new Date()));
    feedback.setIsActive(1);
		return dao.FeedbackInsert(feedback);
	}
	
	@Override
	public List<Object[]> FeedbackList(String LabCode) throws Exception {

		return dao.FeedbackList(LabCode);
	}
	@Override
	public Object[] FeedbackContent(String feedbackid)throws Exception
	{	
		return dao.FeedbackContent(feedbackid);
	}
	
}
