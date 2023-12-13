package com.vts.pfms.cars.service;

import java.util.List;

import com.vts.pfms.cars.dto.CARSRSQRDetailsDTO;
import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;

public interface CARSService {

	public List<Object[]> carsInitiationList(String EmpId) throws Exception;
	public CARSInitiation getCARSInitiationById(long carsIntiationId) throws Exception;
	public long addCARSInitiation(CARSInitiation initiation) throws Exception;
	public long editCARSInitiation(CARSInitiation initiation) throws Exception;
	public Object[] carsRSQRDetails(String carsinitiationid) throws Exception;
	public long carsRSQRDetailsSubmit(String carsInitiationId, String attributes, String details, String userId) throws Exception;
	public long carsRSQRDetailsUpdate(String carsInitiationId, String attributes, String details, String userId) throws Exception;
	public List<CARSRSQRMajorRequirements> getCARSRSQRMajorReqrByCARSInitiationId(long carsInitiationId) throws Exception;
	public List<CARSRSQRDeliverables> getCARSRSQRDeliverablesByCARSInitiationId(long carsInitiationId) throws Exception;
	public long carsRSQRMajorReqrDetailsSubmit(CARSRSQRDetailsDTO dto) throws Exception;
	public int removeCARSRSQRMajorReqrDetails(long carsInitiationId) throws Exception;
	public long carsRSQRDeliverableDetailsSubmit(CARSRSQRDetailsDTO dto) throws Exception;
	public int removeCARSRSQRDeliverableDetails(long carsInitiationId) throws Exception;
	public long rsqrApprovalForward(long carsinitiationid,String action,String EmpId,String UserId) throws Exception;
 
}
