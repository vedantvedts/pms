package com.vts.pfms.fracas.service;

import java.util.List;

import com.vts.pfms.fracas.dto.PfmsFracasAssignDto;
import com.vts.pfms.fracas.dto.PfmsFracasMainDto;
import com.vts.pfms.fracas.dto.PfmsFracasSubDto;
import com.vts.pfms.fracas.model.PfmsFracasAttach;

public interface FracasService {

	public List<Object[]> ProjectsList() throws Exception;
	public List<Object[]> FracasTypeList() throws Exception;
	public long FracasMainAddSubmit(PfmsFracasMainDto dto) throws Exception;
	public List<Object[]> ProjectFracasItemsList(String projectid) throws Exception;
	public PfmsFracasAttach FracasAttachDownload(String fracasattachid) throws Exception;
	public Object[] FracasItemData(String fracasmainid) throws Exception;
	public List<Object[]> EmployeeList() throws Exception;
	public long FracasAssignSubmit(PfmsFracasAssignDto dto) throws Exception;
	public List<Object[]> FracasAssignedList(String assignerempid, String fracasmainid) throws Exception;
	public List<Object[]> FracasAssigneeList(String assigneeid) throws Exception;
	public Object[] FracasAssignData(String fracasassignid) throws Exception;
	public long FracasSubSubmit(PfmsFracasSubDto dto) throws Exception;
	public List<Object[]> FracasSubList(String fracasassignid) throws Exception;
	public int FracasAssignForwardUpdate(PfmsFracasAssignDto dto) throws Exception;
	public List<Object[]> FracasToReviewList(String assignerempid) throws Exception;
	public int FracasSubDelete(String fracassubid,String fracasattachid ) throws Exception;
	public int FracasMainDelete(PfmsFracasMainDto dto) throws Exception;
	public int FracasMainEdit(PfmsFracasMainDto dto) throws Exception;
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype,String LabCode) throws Exception;

}
