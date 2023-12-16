package com.vts.pfms.cars.service;

import java.util.List;

import com.vts.pfms.cars.dto.CARSRSQRDetailsDTO;
import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;
import com.vts.pfms.cars.model.CARSSoC;

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
	public long rsqrApprovalForward(long carsinitiationid,String action,String EmpId,String UserId,String remarks) throws Exception;
	public Object[] getEmpGDEmpId(String empId) throws Exception;
	public Object[] getEmpPDEmpId(String projectId) throws Exception;
	public Object[] getEmpDetailsByEmpId(String empId) throws Exception;
	public List<Object[]> carsTransList(String carsInitiationId) throws Exception;
	public List<Object[]> carsTransApprovalData(String carsInitiationId) throws Exception;
	public List<Object[]> carsRSQRRemarksHistory(String carsInitiationId) throws Exception;
	public List<Object[]> carsRSQRPendingList(String empId) throws Exception;
	public List<Object[]> carsRSQRApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public Object[] getEmpDataByLoginType(String loginType) throws Exception;
	public CARSSoC getCARSSoCById(long carsSoCId) throws Exception;
	public long addCARSSoC(CARSSoC soc) throws Exception;
	public long editCARSSoC(CARSSoC soc) throws Exception;
	
}
