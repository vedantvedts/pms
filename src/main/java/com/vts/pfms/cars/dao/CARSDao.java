package com.vts.pfms.cars.dao;

import java.util.List;

import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSRSQR;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;

public interface CARSDao {

	public List<Object[]> carsInitiationList(String EmpId) throws Exception;
	public CARSInitiation getCARSInitiationById(long carsIntiationId) throws Exception;
	public long addCARSInitiation(CARSInitiation initiation) throws Exception;
	public long editCARSInitiation(CARSInitiation initiation) throws Exception;
	public long getMaxCARSInitiationId() throws Exception;
	public Object[] carsRSQRDetails(String carsinitiationid) throws Exception;
	public long addCARSRSQRDetails(CARSRSQR carsRSQR) throws Exception;
	public long editCARSRSQRDetails(CARSRSQR carsRSQR) throws Exception;
	public CARSRSQR getCARSRSQRByCARSInitiationId(long carsInitiationId) throws Exception;
	public List<CARSRSQRMajorRequirements> getCARSRSQRMajorReqrByCARSInitiationId(long carsInitiationId) throws Exception;
	public List<CARSRSQRDeliverables> getCARSRSQRDeliverablesByCARSInitiationId(long carsInitiationId) throws Exception;
	public long addCARSRSQRMajorReqrDetails(CARSRSQRMajorRequirements major) throws Exception;
	public int removeCARSRSQRMajorReqrDetails(long carsInitiationId) throws Exception;
	public long addCARSRSQRDeliverableDetails(CARSRSQRDeliverables deliverable) throws Exception;
	public int removeCARSRSQRDeliverableDetails(long carsInitiationId) throws Exception;
}
