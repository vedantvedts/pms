package com.vts.pfms.cars.dao;

import java.util.List;


import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSInitiationTrans;
import com.vts.pfms.cars.model.CARSRSQR;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;
import com.vts.pfms.cars.model.CARSSoC;
import com.vts.pfms.cars.model.CARSSoCMilestones;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.master.model.Employee;
import com.vts.pfms.model.LabMaster;

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
	public long addCARSInitiationTransaction(CARSInitiationTrans transaction) throws Exception;
	public Object[] getEmpGDEmpId(String empId) throws Exception;
	public Object[] getEmpPDEmpId(String projectId) throws Exception;
	public Employee getEmpData(String EmpId) throws Exception;
	public long addNotifications(PfmsNotification notification) throws Exception;
	public Object[] getEmpDetailsByEmpId(String empId) throws Exception;
	public List<Object[]> carsTransApprovalData(String carsInitiationId, String apprFor) throws Exception;
	public List<Object[]> carsRSQRPendingList(String empId) throws Exception;
	public List<Object[]> carsRSQRApprovedList(String empId, String FromDate, String ToDate, String type) throws Exception;
	public Object[] getEmpDataByLoginType(String loginType) throws Exception;
	public CARSSoC getCARSSoCById(long carsSoCId) throws Exception;
	public long addCARSSoC(CARSSoC soc) throws Exception;
	public long editCARSSoC(CARSSoC soc) throws Exception;
	public int invForSoODateSubmit(String carsInitiationId, String sooDate) throws Exception;
	public CARSSoC getCARSSoCByCARSInitiationId(long carsInitiationId) throws Exception;
	public int carsRSQRFreeze(long carsInitiationId, String filepath) throws Exception;
	public List<CARSSoCMilestones> getCARSSoCMilestonesByCARSInitiationId(long carsInitiationId) throws Exception;
	public long addCARSSoCMilestoneDetails(CARSSoCMilestones milestone) throws Exception;
	public int removeCARSSoCMilestonesDetails(long carsInitiationId) throws Exception;
	public List<Object[]> carsSoCMoMUploadedList(String fromdate, String todate) throws Exception;
	public Object[] getApprAuthorityDataByType(String labcode, String type) throws Exception;
	public Object[] getLabDirectorData(String labcode) throws Exception;
	public List<Object[]> carsDPandCSoCPendingList(String empId, String labcode) throws Exception;
	public List<Object[]> carsDPCSoCApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public List<Object[]> carsTransListByType(String carsInitiationId, String statusFor) throws Exception;
	public List<Object[]> carsRemarksHistoryByType(String carsInitiationId, String remarksFor) throws Exception;
	public long carsSoCUploadMoM(String momFile, String carsSocId) throws Exception;
	public int updateDPCApprovalSought(long carsInitiationId, String approvalSought) throws Exception;
	public List<Object[]> getLabList(String lab) throws Exception;
	public List<Object[]> getEmployeeListByLabCode(String labCode) throws Exception;
	public LabMaster getLabDetailsByLabCode(String labcode) throws Exception;
	public List<Object[]> carsDPCSoCFinalApprovedList(String fromdate, String todate) throws Exception;
	
}
