package com.vts.pfms.pfts.dao;

import java.util.List;

import com.vts.pfms.pfts.model.PftsDemandImms;

public interface FileTrackingDao {

	public List<PftsDemandImms> DemandImmsListForFileTrackingByDemandNo(String DemandNo) throws Exception;
	public List<PftsDemandImms> DemandImmsListForFileTrackingByItemNomenclature(String ItemNomenclature) throws Exception;
	public List<PftsDemandImms> DemandImmsListForFileTrackingByProjectCode(String ProjectCode) throws Exception;
	public Object[] CheckingDemandIdPresent(String DemandNo) throws Exception;
	public List<Object[]> FileTrackingFlowDetails(String FileTrackingId) throws Exception;
	public Object[] DemandImmsMainDetailsByDemandId(String DemandNo) throws Exception;


}
