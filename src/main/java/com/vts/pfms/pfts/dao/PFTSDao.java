package com.vts.pfms.pfts.dao;

import java.util.Date;
import java.util.List;

import com.vts.pfms.pfts.model.PFTSFile;
import com.vts.pfms.pfts.model.PftsFileOrder;

public interface PFTSDao {

	public List<Object[]> ProjectsList() throws Exception;
	public List<Object[]> getFileStatusList(String projectId)throws Exception;
	public List<Object[]> getprevDemandFile(String projectId)throws Exception;
	public Long addDemandfile(PFTSFile pf)throws Exception;
	public List<Object[]> getStatusList(String fileid)throws Exception;
	public int upadteDemandFile(String fileId, String statusId, Date eventDateSql, String update,String remarks)throws Exception;
	public int updateCostOnDemand(String orderNo, String oderCostD, String fileId, Date dpDateSql)throws Exception;
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype) throws Exception;
	public int FileInActive(String fileId, String userId)throws Exception;
	public Long addDemandfileOrder(PftsFileOrder pfo)throws Exception;
}
