package com.vts.pfms.cars.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.cars.dto.CARSRSQRDetailsDTO;
import com.vts.pfms.cars.dto.CARSApprovalForwardDTO;
import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSInitiationTrans;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;
import com.vts.pfms.cars.model.CARSSoC;
import com.vts.pfms.cars.model.CARSSoCMilestones;
import com.vts.pfms.model.LabMaster;

public interface CARSService {

	public List<Object[]> carsInitiationList(String EmpId) throws Exception;
	public CARSInitiation getCARSInitiationById(long carsIntiationId) throws Exception;
	public long addCARSInitiation(CARSInitiation initiation,String labcode) throws Exception;
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
	public long rsqrApprovalForward(CARSApprovalForwardDTO dto,HttpServletRequest req, HttpServletResponse res, String labcode) throws Exception;
	public Object[] getEmpGDEmpId(String empId) throws Exception;
	public Object[] getEmpPDEmpId(String projectId) throws Exception;
	public Object[] getEmpDetailsByEmpId(String empId) throws Exception;
	public List<Object[]> carsTransApprovalData(String carsInitiationId, String apprFor) throws Exception;
	public List<Object[]> carsRSQRPendingList(String empId) throws Exception;
	public List<Object[]> carsRSQRApprovedList(String empId, String FromDate, String ToDate, String type) throws Exception;
	public Object[] getEmpDataByLoginType(String loginType) throws Exception;
	public CARSSoC getCARSSoCById(long carsSoCId) throws Exception;
	public long addCARSSoC(CARSSoC soc, MultipartFile sooFile, MultipartFile frFile, MultipartFile executionPlan) throws Exception;
	public long editCARSSoC(CARSSoC soc, MultipartFile sooFile, MultipartFile frFile, MultipartFile executionPlan) throws Exception;
	public int invForSoODateSubmit(String carsInitiationId, String sooDate) throws Exception;
	public CARSSoC getCARSSoCByCARSInitiationId(long carsInitiationId) throws Exception;
	public void carsRSQRFormFreeze(HttpServletRequest req, HttpServletResponse res, long carsInitiationId) throws Exception;
	public long socApprovalForward(CARSApprovalForwardDTO dto) throws Exception;
	public long addCARSInitiationTransaction(CARSInitiationTrans transaction) throws Exception;
	public long carsUserRevoke(String carsInitiationId, String username, String empId, String carsStatusCode) throws Exception;
	public List<CARSSoCMilestones> getCARSSoCMilestonesByCARSInitiationId(long carsInitiationId) throws Exception;
	public long carsSoCMilestonesDetailsSubmit(CARSRSQRDetailsDTO dto) throws Exception;
	public int removeCARSSoCMilestonesDetails(long carsInitiationId) throws Exception;
	public List<Object[]> carsSoCMoMUploadedList(String fromdate, String todate) throws Exception;
	public long editCARSSoC(CARSSoC soc) throws Exception;
	public long dpcSoCApprovalForward(CARSApprovalForwardDTO dto) throws Exception;
	public Object[] getApprAuthorityDataByType(String labcode, String type) throws Exception;
	public Object[] getLabDirectorData(String labcode) throws Exception;
	public List<Object[]> carsDPandCSoCPendingList(String empId, String labcode) throws Exception;
	public long carsSoCDPCRevoke(String carsInitiationId, String userId, String empId) throws Exception;
	public List<Object[]> carsDPCSoCApprovedList(String empId, String FromDate, String ToDate) throws Exception;
	public List<Object[]> carsTransListByType(String carsInitiationId, String statusFor) throws Exception;
	public List<Object[]> carsRemarksHistoryByType(String carsInitiationId, String remarksFor) throws Exception;
	public long carsSoCUploadMoM(MultipartFile momFile, String labcode, String carsInitiationId, String EmpId, String UserId, String MoMFlag) throws Exception;
	public List<Object[]> getLabList(String lab) throws Exception;
	public List<Object[]> getEmployeeListByLabCode(String labCode) throws Exception;
	public LabMaster getLabDetailsByLabCode(String labcode) throws Exception;
	public List<Object[]> carsDPCSoCFinalApprovedList(String fromdate, String todate) throws Exception;
	
}
