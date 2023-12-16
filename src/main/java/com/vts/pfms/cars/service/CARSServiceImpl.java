package com.vts.pfms.cars.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.dao.CARSDao;
import com.vts.pfms.cars.dto.CARSRSQRDetailsDTO;
import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSInitiationTrans;
import com.vts.pfms.cars.model.CARSRSQR;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;
import com.vts.pfms.cars.model.CARSSoC;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.master.model.Employee;

@Service
public class CARSServiceImpl implements CARSService{

	private static final Logger logger = LogManager.getLogger(CARSServiceImpl.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	
	
	@Autowired
	CARSDao dao;

	@Override
	public List<Object[]> carsInitiationList(String EmpId) throws Exception {
		
		return dao.carsInitiationList(EmpId);
	}
	
	@Override
	public CARSInitiation getCARSInitiationById(long carsIntiationId) throws Exception {
		
		return dao.getCARSInitiationById(carsIntiationId);
	}

	@Override
	public long addCARSInitiation(CARSInitiation initiation) throws Exception {
		long maxCARSInitiationId = dao.getMaxCARSInitiationId();
		LocalDate now = LocalDate.now();
		String CARSNo = "LRDE/CARS-"+(maxCARSInitiationId+1)+"/RAMD/"+now.getYear();
		initiation.setCARSNo(CARSNo);
		long carsinitiationid = dao.addCARSInitiation(initiation);
		
		// Transaction
		CARSInitiationTrans transaction = CARSInitiationTrans.builder()
										  .CARSInitiationId(carsinitiationid)
										  .CARSStatusCode("INI")
										  .Remarks("")
										  .ActionBy(initiation.getEmpId()+"")
										  .ActionDate(sdtf.format(new Date()))
										  .build();
		dao.addCARSInitiationTransaction(transaction);
		return carsinitiationid;
	}

	@Override
	public long editCARSInitiation(CARSInitiation initiation) throws Exception {
		
		return dao.editCARSInitiation(initiation);
	}
	
	@Override
	public Object[] carsRSQRDetails(String carsinitiationid) throws Exception {
		
		return dao.carsRSQRDetails(carsinitiationid);
	}
	
	@Override
	public long carsRSQRDetailsSubmit(String carsInitiationId, String attributes, String details, String userId) throws Exception {
		
		CARSRSQR rsqr = new CARSRSQR();
		
		if(attributes.equalsIgnoreCase("Introduction")) {
			rsqr.setIntroduction(details);
		}else if(attributes.equalsIgnoreCase("Research Overview")) {
			rsqr.setResearchOverview(details);
		}else if(attributes.equalsIgnoreCase("Objectives")) {
			rsqr.setObjectives(details);
		}else if(attributes.equalsIgnoreCase("Proposed Milestones Timelines")) {
			rsqr.setProposedMandT(details);
		}else if(attributes.equalsIgnoreCase("RSP Scope")) {
			rsqr.setRSPScope(details);
		}else if(attributes.equalsIgnoreCase("LRDE Scope")) {
			rsqr.setLRDEScope(details);
		}else if(attributes.equalsIgnoreCase("Success Criterion")) {
			rsqr.setCriterion(details);
		}else if(attributes.equalsIgnoreCase("Literature Reference")) {
			rsqr.setLiteratureRef(details);
		}
		
		rsqr.setCARSInitiationId(Long.parseLong(carsInitiationId));
		rsqr.setCreatedBy(userId);
		rsqr.setCreatedDate(sdtf.format(new Date()));
		rsqr.setIsActive(1);
		
		return dao.addCARSRSQRDetails(rsqr);
	}
	
	@Override
	public long carsRSQRDetailsUpdate(String carsInitiationId, String attributes, String details, String userId) throws Exception {
		CARSRSQR rsqr = dao.getCARSRSQRByCARSInitiationId(Long.parseLong(carsInitiationId));
		
		if(attributes.equalsIgnoreCase("Introduction")) {
			rsqr.setIntroduction(details);
		}else if(attributes.equalsIgnoreCase("Research Overview")) {
			rsqr.setResearchOverview(details);
		}else if(attributes.equalsIgnoreCase("Objectives")) {
			rsqr.setObjectives(details);
		}else if(attributes.equalsIgnoreCase("Proposed Milestones Timelines")) {
			rsqr.setProposedMandT(details);
		}else if(attributes.equalsIgnoreCase("RSP Scope")) {
			rsqr.setRSPScope(details);
		}else if(attributes.equalsIgnoreCase("LRDE Scope")) {
			rsqr.setLRDEScope(details);
		}else if(attributes.equalsIgnoreCase("Success Criterion")) {
			rsqr.setCriterion(details);
		}else if(attributes.equalsIgnoreCase("Literature Reference")) {
			rsqr.setLiteratureRef(details);
		}
		
		rsqr.setModifiedBy(userId);
		rsqr.setModifiedDate(sdtf.format(new Date()));
		
		return dao.editCARSRSQRDetails(rsqr);
	}
	
	@Override
	public List<CARSRSQRMajorRequirements> getCARSRSQRMajorReqrByCARSInitiationId(long carsInitiationId) throws Exception {
		
		return dao.getCARSRSQRMajorReqrByCARSInitiationId(carsInitiationId);
	}
	
	@Override
	public List<CARSRSQRDeliverables> getCARSRSQRDeliverablesByCARSInitiationId(long carsInitiationId) throws Exception {
		
		return dao.getCARSRSQRDeliverablesByCARSInitiationId(carsInitiationId);
	}

	@Override
	public long carsRSQRMajorReqrDetailsSubmit(CARSRSQRDetailsDTO dto) throws Exception {
		try {
			for(int i=0;i<dto.getReqId().length;i++) {
				CARSRSQRMajorRequirements mr = new CARSRSQRMajorRequirements();
				mr.setCARSInitiationId(dto.getCARSInitiationId());
				mr.setReqId(dto.getReqId()[i]);
				mr.setReqDescription(dto.getReqDescription()[i]);
				mr.setRelevantSpecs(dto.getRelevantSpecs()[i]);
				mr.setValidationMethod(dto.getValidationMethod()[i]);
				mr.setRemarks(dto.getRemarks()[i]);
				mr.setCreatedBy(dto.getUserId());
				mr.setCreatedDate(sdtf.format(new Date()));
				mr.setIsActive(1);
				dao.addCARSRSQRMajorReqrDetails(mr);
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside CARSServiceImpl "+e);
			e.printStackTrace();
			return 0;
		}
		
	}

	public int removeCARSRSQRMajorReqrDetails(long carsInitiationId) throws Exception{
		return dao.removeCARSRSQRMajorReqrDetails(carsInitiationId);
	}

	@Override
	public long carsRSQRDeliverableDetailsSubmit(CARSRSQRDetailsDTO dto) throws Exception {
		try {
			for(int i=0;i<dto.getDescription().length;i++) {
				CARSRSQRDeliverables mr = new CARSRSQRDeliverables();
				mr.setCARSInitiationId(dto.getCARSInitiationId());
				mr.setDescription(dto.getDescription()[i]);
				mr.setDeliverableType(dto.getDeliverableType()[i]);
				mr.setCreatedBy(dto.getUserId());
				mr.setCreatedDate(sdtf.format(new Date()));
				mr.setIsActive(1);
				dao.addCARSRSQRDeliverableDetails(mr);
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside CARSServiceImpl "+e);
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public int removeCARSRSQRDeliverableDetails(long carsInitiationId) throws Exception {
		return dao.removeCARSRSQRDeliverableDetails(carsInitiationId);
	}

	// This method is to handle the approval flow for rsqr approval.
	@Override
	public long rsqrApprovalForward(long carsinitiationid,String action,String EmpId,String UserId,String remarks) throws Exception {
		try {
			CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
			long formempid = cars.getEmpId();
			Employee emp = dao.getEmpData(formempid+"");
			String fundsFrom = cars.getFundsFrom();
			String statusCode = cars.getCARSStatusCode();
			String statusCodeNext = cars.getCARSStatusCodeNext();
			
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(statusCode.equalsIgnoreCase("INI") || statusCode.equalsIgnoreCase("RGD") || statusCode.equalsIgnoreCase("RPD")) {
					if(statusCode.equalsIgnoreCase("INI")) {
						cars.setInitiationDate(sdf.format(new Date()));
					}
					cars.setCARSStatusCode("FWD");
					if(fundsFrom.equalsIgnoreCase("0")) {
						cars.setCARSStatusCodeNext("AGD");
					}else {
						cars.setCARSStatusCodeNext("APD");
					}
					dao.editCARSInitiation(cars);
				}else {
					cars.setCARSStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("AGD") || statusCodeNext.equalsIgnoreCase("APD")) {
						cars.setCARSStatusCodeNext(statusCodeNext);
						cars.setInitiationApprDate(sdtf.format(new Date()));
					}
					dao.editCARSInitiation(cars);
				}
			}
			// This is for return the approval form to the user or initiater. 
			else if(action.equalsIgnoreCase("R")){
				if(statusCodeNext.equalsIgnoreCase("AGD")) {
					cars.setCARSStatusCode("RGD");
				}else if(statusCodeNext.equalsIgnoreCase("APD")) {
					cars.setCARSStatusCode("RPD");
				}
				
				if(fundsFrom.equalsIgnoreCase("0")) {
					cars.setCARSStatusCodeNext("AGD");
				}else {
					cars.setCARSStatusCodeNext("APD");
				}
				
				dao.editCARSInitiation(cars);
			}else if(action.equalsIgnoreCase("D")) {
				if(statusCodeNext.equalsIgnoreCase("AGD")) {
					cars.setCARSStatusCode("DGD");
					cars.setCARSStatusCodeNext("DGD");
				}
				else if(statusCodeNext.equalsIgnoreCase("APD")) {
					cars.setCARSStatusCode("DPD");
					cars.setCARSStatusCodeNext("DPD");
				}
				dao.editCARSInitiation(cars);
			}
			
			// Transactions happend in the approval flow.
			CARSInitiationTrans transaction = CARSInitiationTrans.builder()
											  .CARSInitiationId(carsinitiationid)
											  .CARSStatusCode(cars.getCARSStatusCode())
											  .Remarks(remarks)
											  .ActionBy(EmpId)
											  .ActionDate(sdtf.format(new Date()))
											  .build();
			dao.addCARSInitiationTransaction(transaction);
			
			Object[] GDEmpIds = dao.getEmpGDEmpId(formempid+"");
			Object[] PDEmpIds = dao.getEmpPDEmpId(cars.getFundsFrom());
			
			long empGDEmpId = GDEmpIds!=null?Long.parseLong(GDEmpIds[1].toString()):0;
			long empPDEmpId = PDEmpIds!=null?Long.parseLong(PDEmpIds[1].toString()):0;
			
			// Notification
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A") && (cars.getCARSStatusCode().equalsIgnoreCase("AGD") || cars.getCARSStatusCode().equalsIgnoreCase("APD"))) {
				notification.setEmpId(emp.getEmpId());
				notification.setNotificationUrl("CARSInitiationList.htm");
				notification.setNotificationMessage("RSQR Approval request approved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				dao.addNotifications(notification);
				
				Object[] dpandc = dao.getEmpDataByLoginType("E");
				notification.setEmpId(Long.parseLong(dpandc[0].toString()));
				notification.setNotificationUrl("CARSRSQRApprovals.htm?val=app");
				notification.setNotificationMessage("RSQR Approval request approved for<br>"+emp.getEmpName());
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				dao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("A")) {
				
				if(cars.getCARSStatusCodeNext().equalsIgnoreCase("AGD")) {
					notification.setEmpId(empGDEmpId);
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("APD")) {
					notification.setEmpId(empPDEmpId);
				}
				
				notification.setNotificationUrl("CARSRSQRApprovals.htm");
				notification.setNotificationMessage("RSQR Approval forwarded by the "+emp.getEmpName());
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				dao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D"))
			{
				notification.setEmpId(emp.getEmpId());
				notification.setNotificationUrl("CARSInitiationList.htm");
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"RSQR Approval Request Returned":"RSQR Approval Request Disapproved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				dao.addNotifications(notification);
			}
			
			return 1;	
		}catch (Exception e) {
			logger.error(new Date() +" Inside CARSServiceImpl "+e);
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public Object[] getEmpGDEmpId(String empId) throws Exception {
		
		return dao.getEmpGDEmpId(empId);
	}

	@Override
	public Object[] getEmpPDEmpId(String projectId) throws Exception {
		
		return dao.getEmpPDEmpId(projectId);
	}
	
	@Override
	public Object[] getEmpDetailsByEmpId(String empId) throws Exception {
		
		return dao.getEmpDetailsByEmpId(empId);
	}

	@Override
	public List<Object[]> carsTransList(String carsInitiationId) throws Exception {
		
		return dao.carsTransList(carsInitiationId);
	}

	@Override
	public List<Object[]> carsTransApprovalData(String carsInitiationId) throws Exception{
		
		return dao.carsTransApprovalData(carsInitiationId);
	}
	
	@Override
	public List<Object[]> carsRSQRRemarksHistory(String carsInitiationId) throws Exception {
		
		return dao.carsRSQRRemarksHistory(carsInitiationId);
	}
	
	@Override
	public List<Object[]> carsRSQRPendingList(String empId) throws Exception {
		
		return dao.carsRSQRPendingList(empId);
	}

	@Override
	public List<Object[]> carsRSQRApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.carsRSQRApprovedList(empId, FromDate, ToDate);
	}

	@Override
	public Object[] getEmpDataByLoginType(String loginType) throws Exception {
		
		return dao.getEmpDataByLoginType(loginType);
	}

	@Override
	public CARSSoC getCARSSoCById(long carsSoCId) throws Exception {
		
		return dao.getCARSSoCById(carsSoCId);
	}

	@Override
	public long addCARSSoC(CARSSoC soc) throws Exception {
		
		return dao.addCARSSoC(soc);
	}

	@Override
	public long editCARSSoC(CARSSoC soc) throws Exception {
		
		return dao.editCARSSoC(soc);
	}
}
