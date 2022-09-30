package com.vts.pfms.fracas.dao;

import java.util.List;

import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.fracas.dto.PfmsFracasAssignDto;
import com.vts.pfms.fracas.dto.PfmsFracasMainDto;
import com.vts.pfms.fracas.model.PfmsFracasAssign;
import com.vts.pfms.fracas.model.PfmsFracasAttach;
import com.vts.pfms.fracas.model.PfmsFracasMain;
import com.vts.pfms.fracas.model.PfmsFracasSub;

public interface FracasDao {

	public List<Object[]> ProjectsList() throws Exception;
	public List<Object[]> FracasTypeList() throws Exception;
	public long FracasMainAddSubmit(PfmsFracasMain model) throws Exception;
	public Object[] ProjectsData(String projectid) throws Exception;
	public List<Object[]> ProjectFracasItemsList(String projectid) throws Exception;
	public long FracasAttachAdd(PfmsFracasAttach model) throws Exception;
	public PfmsFracasAttach FracasAttachDownload(String fracasattachid) throws Exception;
	public Object[] FracasItemData(String fracasmainid) throws Exception;
	public List<Object[]> EmployeeList() throws Exception;
	public long FracasAssignSubmit(PfmsFracasAssign model) throws Exception;
	public List<Object[]> FracasAssignedList(String assignerempid, String fracasmainid) throws Exception;
	public List<Object[]> FracasAssigneeList(String assigneeid) throws Exception;
	public Object[] FracasAssignData(String fracasassignid) throws Exception;
	public long FracasSubSubmit(PfmsFracasSub model) throws Exception;
	public List<Object[]> FracasSubList(String fracasassignid) throws Exception;
	public int FracasAssignForwardUpdate(PfmsFracasAssignDto dto) throws Exception;
	public List<Object[]> FracasToReviewList(String assignerempid) throws Exception;
	public int FracasSubDelete(String fracassubid) throws Exception;
	public int FracasMainDelete(PfmsFracasMainDto dto) throws Exception;
	public Object[] LabDetails() throws Exception;
	public Object[] FracasMainAssignCount(String fracasmainid) throws Exception;
	public int FracasMainEdit(PfmsFracasMainDto dto) throws Exception;
	public int FracasAttachDelete(String fracasattachid) throws Exception;
	public long FRACASNotificationInsert(PfmsNotification notification) throws Exception;
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype,String LabCode) throws Exception;

}
