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
import com.vts.pfms.cars.model.CARSRSQR;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;

@Service
public class CARSServiceImpl implements CARSService{

	private static final Logger logger = LogManager.getLogger(CARSServiceImpl.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdf1 = fc.getSqlDateAndTimeFormat();
	
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
		return dao.addCARSInitiation(initiation);
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
		rsqr.setCreatedDate(sdf1.format(new Date()));
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
		rsqr.setModifiedDate(sdf1.format(new Date()));
		
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
				mr.setCreatedDate(sdf1.format(new Date()));
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
				mr.setCreatedDate(sdf1.format(new Date()));
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

	@Override
	public long rsqrApprovalForward(long carsinitiationid,String action,String EmpId,String UserId) throws Exception {
		try {
			CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
			String fundsFrom = cars.getFundsFrom();
			String statusCode = cars.getCARSStatusCode();
			String statusCodeNext = cars.getCARSStatusCodeNext();
			if(action.equalsIgnoreCase("A")) {
				if(statusCode.equalsIgnoreCase("INI") || statusCode.equalsIgnoreCase("RGD") || statusCode.equalsIgnoreCase("RPD")) {
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
					}
					dao.editCARSInitiation(cars);
				}
			}
			return 1;	
		}catch (Exception e) {
			logger.error(new Date() +" Inside CARSServiceImpl "+e);
			e.printStackTrace();
			return 0;
		}
	}
}
