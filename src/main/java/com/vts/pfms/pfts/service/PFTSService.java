package com.vts.pfms.pfts.service;

import java.util.List;

import com.vts.pfms.master.dto.DemandDetails;
import com.vts.pfms.pfts.dto.DemandOrderDetails;
import com.vts.pfms.pfts.model.PFTSFile;

public interface PFTSService {
	
	public List<Object[]> ProjectsList() throws Exception;
	public List<Object[]> getFileStatusList(String projectId)  throws Exception;
	public List<DemandDetails> getprevDemandFile(String projectId)throws Exception;
	public Long addDemandfile(PFTSFile pf) throws Exception;
	public List<Object[]> getStatusList(String fileid)throws Exception;
	public int upadteDemandFile(String fileId, String statusId, String eventDate,String remarks)throws Exception;
	public long updateCostOnDemand(List<DemandOrderDetails> dd ,String fileId,String userid)throws Exception;
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype,String LabCode) throws Exception;
	public int FileInActive(String fileId, String userId)throws Exception;
	public Object[] ProjectData(String projectid) throws Exception;
}
