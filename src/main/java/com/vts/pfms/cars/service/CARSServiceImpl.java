package com.vts.pfms.cars.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itextpdf.html2pdf.HtmlConverter;
import com.vts.pfms.CharArrayWriterResponse;
import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.dao.CARSDao;
import com.vts.pfms.cars.dto.CARSRSQRDetailsDTO;
import com.vts.pfms.cars.dto.CARSApprovalForwardDTO;
import com.vts.pfms.cars.dto.CARSContractDetailsDTO;
import com.vts.pfms.cars.model.CARSAnnualReport;
import com.vts.pfms.cars.model.CARSContract;
import com.vts.pfms.cars.model.CARSContractConsultants;
import com.vts.pfms.cars.model.CARSContractEquipment;
import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSInitiationTrans;
import com.vts.pfms.cars.model.CARSOtherDocDetails;
import com.vts.pfms.cars.model.CARSRSQR;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;
import com.vts.pfms.cars.model.CARSSoC;
import com.vts.pfms.cars.model.CARSSoCMilestones;
import com.vts.pfms.cars.model.CARSSoCMilestonesProgress;
import com.vts.pfms.committee.dao.ActionDao;
import com.vts.pfms.committee.dto.ActionAssignDto;
import com.vts.pfms.committee.dto.ActionMainDto;
import com.vts.pfms.committee.model.ActionAssign;
import com.vts.pfms.committee.model.ActionMain;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.master.model.Employee;
import com.vts.pfms.model.LabMaster;

@Service
public class CARSServiceImpl implements CARSService{

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	private static final Logger logger = LogManager.getLogger(CARSServiceImpl.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
	private SimpleDateFormat sdf2=new SimpleDateFormat("dd-MMM-yyyy");
	
	@Autowired
	CARSDao dao;

	@Autowired
	ActionDao actiondao;
	
	public static int saveFile1(Path uploadPath, String fileName, MultipartFile multipartFile) throws IOException {
		logger.info(new Date() + "Inside SERVICE saveFile ");
		int result = 1;

		if (!Files.exists(uploadPath)) {
			Files.createDirectories(uploadPath);
		}
		try (InputStream inputStream = multipartFile.getInputStream()) {
			Path filePath = uploadPath.resolve(fileName);
			Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException ioe) {
			result = 0;
			throw new IOException("Could not save image file: " + fileName, ioe);
		} catch (Exception e) {
			result = 0;
			logger.error(new Date() + "Inside SERVICE saveFile " + e);
			e.printStackTrace();
		}
		return result;
	}
	
	public static int saveFileFromFileObject(Path uploadPath, String fileName, File file) throws IOException {
	    logger.info(new Date() + " Inside SERVICE saveFileFromFileObject ");
	    int result = 1;

	    // Check if the directory exists; if not, create it
	    if (!Files.exists(uploadPath)) {
	        Files.createDirectories(uploadPath);
	    }

	    try {
	        // Resolve the destination file path
	        Path filePath = uploadPath.resolve(fileName);
	        
	        // Copy the file from the source to the destination
	        Files.copy(file.toPath(), filePath, StandardCopyOption.REPLACE_EXISTING);
	        
	    } catch (IOException ioe) {
	        result = 0;
	        throw new IOException("Could not save file: " + fileName, ioe);
	    } catch (Exception e) {
	        result = 0;
	        logger.error(new Date() + " Inside SERVICE saveFileFromFileObject " + e);
	        e.printStackTrace();
	    }
	    
	    return result;
	}

	
	@Override
	public List<Object[]> carsInitiationList(String LoginType, String EmpId) throws Exception {
		
		return dao.carsInitiationList(LoginType,EmpId);
	}
	
	@Override
	public CARSInitiation getCARSInitiationById(long carsIntiationId) throws Exception {
		
		return dao.getCARSInitiationById(carsIntiationId);
	}

	@Override
	public long addCARSInitiation(CARSInitiation initiation,String labcode) throws Exception {
		
		long maxCARSInitiationId = dao.getMaxCARSInitiationId();
		LocalDate now = LocalDate.now();
		String CARSNo = labcode+"/CARS/D-P&C/"+now.getYear()+"-"+(maxCARSInitiationId+1);
		initiation.setCARSNo(CARSNo);
		
//		double amount = Double.parseDouble(initiation.getAmount())*100000;
//		initiation.setAmount(String.valueOf(amount));
		long carsinitiationid = dao.addCARSInitiation(initiation);
		
		// Transaction
		CARSInitiationTrans transaction = CARSInitiationTrans.builder()
										  .CARSInitiationId(carsinitiationid)
										  .MilestoneNo("0")
										  .CARSStatusCode("INI")
										  .LabCode(labcode)
										  .ActionBy(initiation.getEmpId()+"")
										  .ActionDate(sdtf.format(new Date()))
										  .build();
		dao.addCARSInitiationTransaction(transaction);
		return carsinitiationid;
	}

	@Override
	public long editCARSInitiation(CARSInitiation initiation) throws Exception {
//		double amount = Double.parseDouble(initiation.getAmount())*100000;
//		initiation.setAmount(String.valueOf(amount));
		
		return dao.editCARSInitiation(initiation);
	}
	
	@Override
	public Object[] carsRSQRDetails(String carsinitiationid) throws Exception {
		
		return dao.carsRSQRDetails(carsinitiationid);
	}
	
	@Override
	public long carsRSQRDetailsSubmit(String carsInitiationId, String attributes, String details, String userId, String labcode) throws Exception {
		
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
		}else if(attributes.equalsIgnoreCase(labcode+" Scope")) {
			rsqr.setLRDEScope(details);
		}else if(attributes.equalsIgnoreCase("Success Criterion")) {
			rsqr.setCriterion(details);
		}else if(attributes.equalsIgnoreCase("Literature Reference")) {
			rsqr.setLiteratureRef(details);
		}
		LocalDate now = LocalDate.now();
		
		rsqr.setCARSInitiationId(Long.parseLong(carsInitiationId));
		rsqr.setCARSRSQRNo(labcode+"/CARS/RSQR-"+carsInitiationId+"/"+now.getYear());
		rsqr.setCreatedBy(userId);
		rsqr.setCreatedDate(sdtf.format(new Date()));
		rsqr.setIsActive(1);
		
		return dao.addCARSRSQRDetails(rsqr);
	}
	
	@Override
	public long carsRSQRDetailsUpdate(String carsInitiationId, String attributes, String details, String userId, String labcode) throws Exception {
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
		}else if(attributes.equalsIgnoreCase(labcode+" Scope")) {
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
	public long rsqrApprovalForward(CARSApprovalForwardDTO dto, HttpServletRequest req,HttpServletResponse res, String labcode) throws Exception {
		try {
			long carsinitiationid = dto.getCarsinitiationid();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			String UserId = dto.getUserId();
			String remarks = dto.getRemarks();
			
			CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
			long formempid = cars.getEmpId();
			Employee emp = dao.getEmpData(formempid+"");
			String fundsFrom = cars.getFundsFrom();
			String statusCode = cars.getCARSStatusCode();
			String statusCodeNext = cars.getCARSStatusCodeNext();
			
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(statusCode.equalsIgnoreCase("INI") || statusCode.equalsIgnoreCase("REV") || 
				   statusCode.equalsIgnoreCase("RGD") || statusCode.equalsIgnoreCase("RPD")) {
					if(statusCode.equalsIgnoreCase("INI")) {
						cars.setInitiationDate(sdf.format(new Date()));
					}
					cars.setEquipmentNeed(req.getParameter("equipmentNeed")!=null?"Y":"N");
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
						
						carsRSQRFormFreeze(req,res,carsinitiationid);
					}
					dao.editCARSInitiation(cars);
				}
			}
			// This is for return the approval form to the user or initiator. 
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
											  .MilestoneNo("0")
											  .CARSStatusCode(cars.getCARSStatusCode())
											  .Remarks(remarks)
											  .LabCode(labcode)
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
				notification.setNotificationMessage("CARS RSQR request approved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				dao.addNotifications(notification);
				
				Object[] dpandc = dao.getEmpDataByLoginType("E");
				Object[] GHDPandC = dao.getApprAuthorityDataByType(labcode, "GH-DP&C");
				
				for(int i=0;i<2;i++) {
					PfmsNotification notification2 = new PfmsNotification();
					notification2.setEmpId(dpandc!=null?(Long.parseLong(i==0?dpandc[0].toString():GHDPandC[0].toString())):0L);
					notification2.setNotificationUrl("CARSRSQRApprovedList.htm");
					notification2.setNotificationMessage("CARS RSQR request approved for "+emp.getEmpName());
					notification2.setNotificationby(Long.parseLong(EmpId));
					notification2.setNotificationDate(LocalDate.now().toString());
					notification2.setIsActive(1);
					notification2.setCreatedBy(UserId);
					notification2.setCreatedDate(sdtf.format(new Date()));

					dao.addNotifications(notification2);
				}
				
			}
			else if(action.equalsIgnoreCase("A")) {
				
				if(cars.getCARSStatusCodeNext().equalsIgnoreCase("AGD")) {
					notification.setEmpId(empGDEmpId);
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("APD")) {
					notification.setEmpId(empPDEmpId);
				}
				
				notification.setNotificationUrl("CARSRSQRApprovals.htm");
				notification.setNotificationMessage("CARS RSQR forwarded by "+emp.getEmpName());
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
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"CARS RSQR Request Returned":"CARS RSQR Request Disapproved");
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
	public List<Object[]> carsTransApprovalData(String carsInitiationId, String apprFor) throws Exception{
		
		return dao.carsTransApprovalData(carsInitiationId, apprFor);
	}
	@Override
	public List<Object[]> carsRSQRPendingList(String empId) throws Exception {
		
		return dao.carsRSQRPendingList(empId);
	}

	@Override
	public List<Object[]> carsRSQRApprovedList(String empId, String FromDate, String ToDate, String type) throws Exception {
		
		return dao.carsRSQRApprovedList(empId, FromDate, ToDate, type);
	}

	@Override
	public Object[] getEmpDataByLoginType(String loginType) throws Exception {
		
		return dao.getEmpDataByLoginType(loginType);
	}

	@Override
	public CARSSoC getCARSSoCById(long carsSoCId) throws Exception {
		
		return dao.getCARSSoCById(carsSoCId);
	}

	public static void saveFile(String uploadpath, String fileName, MultipartFile multipartFile) throws IOException {
		logger.info(new Date() + "Inside SERVICE saveFile ");
		Path uploadPath = Paths.get(uploadpath);

		if (!Files.exists(uploadPath)) {
			Files.createDirectories(uploadPath);
		}

		try (InputStream inputStream = multipartFile.getInputStream()) {
			Path filePath = uploadPath.resolve(fileName);
			Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException ioe) {
			throw new IOException("Could not save pdf file: " + fileName, ioe);
		}
	}
	
	@Override
	public long addCARSSoC(CARSSoC soc, MultipartFile sooFile, MultipartFile frFile, MultipartFile executionPlan) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "CARS\\SoC\\";
		Path carsPath = Paths.get(uploadpath,"CARS", "SoC");
		
		// To upload file path for SoO
		if (!sooFile.isEmpty()) {
			soc.setSoOUpload("SoO-" + timestampstr + "."
					+ FilenameUtils.getExtension(sooFile.getOriginalFilename()));
			saveFile1(carsPath, soc.getSoOUpload(), sooFile);
		} else {
			soc.setSoOUpload(null);
		}
		
		// To upload file path for Feasibility report
		if (!frFile.isEmpty()) {
			soc.setFRUpload("FR-" + timestampstr + "."
					+ FilenameUtils.getExtension(frFile.getOriginalFilename()));
			saveFile1(carsPath, soc.getFRUpload(), frFile);
		} else {
			soc.setFRUpload(null);
		}
		
		// To upload file path for Execution plan
		if (!executionPlan.isEmpty()) {
			soc.setExecutionPlan("ExePlan-" + timestampstr + "."
					+ FilenameUtils.getExtension(executionPlan.getOriginalFilename()));
			saveFile1(carsPath, soc.getExecutionPlan(), executionPlan);
		} else {
			soc.setExecutionPlan(null);
		}
		
		// Converting amount from lakhs to rupees
//		double amount = Double.parseDouble(soc.getSoCAmount())*100000;
//		soc.setSoCAmount(String.valueOf(amount));
		
		long carsSoCId = dao.addCARSSoC(soc);
	
		return carsSoCId;
	}

	@Override
	public long editCARSSoC(CARSSoC soc, MultipartFile sooFile, MultipartFile frFile, MultipartFile executionPlan) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "CARS\\SoC\\";
		Path carsPath = Paths.get(uploadpath,"CARS", "SoC");
		
		// To upload file path for SoO
		if (!sooFile.isEmpty()) {
			soc.setSoOUpload("SoO-" + timestampstr + "."
					+ FilenameUtils.getExtension(sooFile.getOriginalFilename()));
			saveFile1(carsPath, soc.getSoOUpload(), sooFile);
		}
		
		// To upload file path for Feasibility report
		if (!frFile.isEmpty()) {
			soc.setFRUpload("FR-" + timestampstr + "."
					+ FilenameUtils.getExtension(frFile.getOriginalFilename()));
			saveFile1(carsPath, soc.getFRUpload(), frFile);
		}
		
		// To upload file path for Execution plan
		if (!executionPlan.isEmpty()) {
			soc.setExecutionPlan("ExePlan-" + timestampstr + "."
					+ FilenameUtils.getExtension(executionPlan.getOriginalFilename()));
			saveFile1(carsPath, soc.getExecutionPlan(), executionPlan);
		}
	
		// Converting amount from lakhs to rupees
//		double amount = Double.parseDouble(soc.getSoCAmount())*100000;
//		soc.setSoCAmount(String.valueOf(amount));
		
		return dao.editCARSSoC(soc);
	}

	@Override
	public int invForSoODateSubmit(String carsInitiationId, String sooDate) throws Exception {
		
		return dao.invForSoODateSubmit(carsInitiationId, sooDate);
	}

	@Override
	public CARSSoC getCARSSoCByCARSInitiationId(long carsInitiationId) throws Exception {
		
		return dao.getCARSSoCByCARSInitiationId(carsInitiationId);
	}
	
	@Override
	public void carsRSQRFormFreeze(HttpServletRequest req,HttpServletResponse res,long carsInitiationId) throws Exception{
		logger.info(new Date() +"Inside SERVICE DepIncFormFreeze ");
		try {
			
			req.setAttribute("CARSInitiationData", dao.getCARSInitiationById(carsInitiationId));
			req.setAttribute("RSQRMajorReqr", dao.getCARSRSQRMajorReqrByCARSInitiationId(carsInitiationId));
			req.setAttribute("RSQRDeliverables", dao.getCARSRSQRDeliverablesByCARSInitiationId(carsInitiationId));
			req.setAttribute("RSQRDetails", dao.carsRSQRDetails(carsInitiationId+""));
			req.setAttribute("CARSSoCMilestones", dao.getCARSSoCMilestonesByCARSInitiationId(carsInitiationId));
			
			String filename="RSQR Form";
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
				        
	        CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/CARSRSQRDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();                  
	        
	        HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf")) ; 
	         
	        File file=new File(path +File.separator+ filename+".pdf");
	        
	        String fname="RSQR-"+carsInitiationId;
//			String filepath = "CARS\\RSQR";
			Path carsPath = Paths.get(uploadpath, "CARS", "RSQR");
			Path carsPath1 = Paths.get(uploadpath, "CARS", "RSQR",fname+".pdf");
			int count=0;
			while(carsPath1.toFile().exists())
			{
				fname = "RSQR-"+carsInitiationId;
				fname = fname+" ("+ ++count+")";
			}
	        
			saveFileFromFileObject(carsPath, fname+".pdf", file);
			Path carsPath2 = Paths.get("CARS", "RSQR", fname+".pdf");
	        dao.carsRSQRFreeze(carsInitiationId, carsPath2.toString());
	        Path pathOfFile= Paths.get( path+File.separator+filename+".pdf"); 
	        Files.delete(pathOfFile);		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void saveFile(String uploadpath, String fileName, File fileToSave) throws IOException 
	{
	   logger.info(new Date() +"Inside SERVICE saveFile ");
	   Path uploadPath = Paths.get(uploadpath);
	          
	   if (!Files.exists(uploadPath)) {
		   Files.createDirectories(uploadPath);
	   }
	        
	   try (InputStream inputStream = new FileInputStream(fileToSave)) {
		   Path filePath = uploadPath.resolve(fileName);
	       Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	   } catch (IOException ioe) {       
		   throw new IOException("Could not save file: " + fileName, ioe);
	   }     
	}

	@Override
	public long socApprovalForward(CARSApprovalForwardDTO dto) throws Exception {
		try {
			long carsinitiationid = dto.getCarsinitiationid();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			String UserId = dto.getUserId();
			String remarks = dto.getRemarks();
			String labcode = dto.getLabcode();
			
			CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
			long formempid = cars.getEmpId();
			Employee emp = dao.getEmpData(formempid+"");
			String fundsFrom = cars.getFundsFrom();
			String statusCode = cars.getCARSStatusCode();
			String statusCodeNext = cars.getCARSStatusCodeNext();
			
			CARSSoC soc = dao.getCARSSoCByCARSInitiationId(carsinitiationid);
			
			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(statusCode.equalsIgnoreCase("AGD") || statusCode.equalsIgnoreCase("APD") || statusCode.equalsIgnoreCase("SRV") || 
				   statusCode.equalsIgnoreCase("SRG") || statusCode.equalsIgnoreCase("SRP")) {
					if(statusCode.equalsIgnoreCase("AGD") || statusCode.equalsIgnoreCase("APD")) {
						soc.setSoCDate(sdf.format(new Date()));
					}
					cars.setCARSStatusCode("SFU");
					if(fundsFrom.equalsIgnoreCase("0")) {
						cars.setCARSStatusCodeNext("SFG");
					}else {
						cars.setCARSStatusCodeNext("SFP");
					}
					
				}else {
					cars.setCARSStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("SFG") || statusCodeNext.equalsIgnoreCase("SFP")) {
						cars.setCARSStatusCodeNext(statusCodeNext);
					}
				}
				dao.editCARSInitiation(cars);
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(statusCodeNext.equalsIgnoreCase("SFG")) {
					cars.setCARSStatusCode("SRG");
				}else if(statusCodeNext.equalsIgnoreCase("SFP")) {
					cars.setCARSStatusCode("SRP");
				}
				
				if(fundsFrom.equalsIgnoreCase("0")) {
					cars.setCARSStatusCodeNext("SFG");
				}else {
					cars.setCARSStatusCodeNext("SFP");
				}
				
				dao.editCARSInitiation(cars);
			// This is for disapprove the approval form to the user or initiator.
			}else if(action.equalsIgnoreCase("D")) {
				if(statusCodeNext.equalsIgnoreCase("SFG")) {
					cars.setCARSStatusCode("SDG");
					cars.setCARSStatusCodeNext("SDG");
				}
				else if(statusCodeNext.equalsIgnoreCase("SFP")) {
					cars.setCARSStatusCode("SDP");
					cars.setCARSStatusCodeNext("SDP");
				}
				dao.editCARSInitiation(cars);
			}
			
			// Transactions happend in the approval flow.
			CARSInitiationTrans transaction = CARSInitiationTrans.builder()
											  .CARSInitiationId(carsinitiationid)
											  .MilestoneNo("0")
											  .CARSStatusCode(cars.getCARSStatusCode())
											  .Remarks(remarks)
											  .LabCode(labcode)
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
			if(action.equalsIgnoreCase("A") && (cars.getCARSStatusCode().equalsIgnoreCase("SFG") || cars.getCARSStatusCode().equalsIgnoreCase("SFP"))) {
				notification.setEmpId(emp.getEmpId());
				notification.setNotificationUrl("CARSInitiationList.htm");
				notification.setNotificationMessage("CARS SoC request approved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				dao.addNotifications(notification);
				
//				Object[] dpandc = dao.getEmpDataByLoginType("E");
//				
//				PfmsNotification notification2 = new PfmsNotification();
//				notification2.setEmpId(Long.parseLong(dpandc[0].toString()));
//				notification2.setNotificationUrl("CARSRSQRApprovedList.htm");
//				notification2.setNotificationMessage("SoC request approved for<br>"+emp.getEmpName());
//				notification2.setNotificationby(Long.parseLong(EmpId));
//				notification2.setNotificationDate(LocalDate.now().toString());
//				notification2.setIsActive(1);
//				notification2.setCreatedBy(UserId);
//				notification2.setCreatedDate(sdtf.format(new Date()));
//
//				dao.addNotifications(notification2);
			}
			else if(action.equalsIgnoreCase("A")) {
				
				if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SFG")) {
					notification.setEmpId(empGDEmpId);
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SFP")) {
					notification.setEmpId(empPDEmpId);
				}
				
				notification.setNotificationUrl("CARSRSQRApprovals.htm");
				notification.setNotificationMessage("CARS SoC forwarded by "+emp.getEmpName());
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
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"CARS SoC Request Returned":"CARS SoC Request Disapproved");
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
	public long addCARSInitiationTransaction(CARSInitiationTrans transaction) throws Exception {
		
		return dao.addCARSInitiationTransaction(transaction);
	}

	@Override
	public long carsUserRevoke(String carsInitiationId, String username, String empId, String carsStatusCode, String labcode) throws Exception {
		
		long carsinitiationid = Long.parseLong(carsInitiationId);
		
		CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
		cars.setCARSStatusCode(carsStatusCode.equalsIgnoreCase("FWD")?"REV":"SRV");
		cars.setCARSStatusCodeNext(carsStatusCode);
		cars.setModifiedBy(username);
		cars.setModifiedDate(sdtf.format(new Date()));
		
		// Transactions.
		CARSInitiationTrans transaction = CARSInitiationTrans.builder()
										  .CARSInitiationId(carsinitiationid)
										  .MilestoneNo("0")
										  .CARSStatusCode(carsStatusCode.equalsIgnoreCase("FWD")?"REV":"SRV")
										  .LabCode(labcode)
										  .ActionBy(empId)
										  .ActionDate(sdtf.format(new Date()))
										  .build();
		dao.addCARSInitiationTransaction(transaction);
		
		return dao.editCARSInitiation(cars);
	}

	@Override
	public List<CARSSoCMilestones> getCARSSoCMilestonesByCARSInitiationId(long carsInitiationId) throws Exception {
		
		return dao.getCARSSoCMilestonesByCARSInitiationId(carsInitiationId);
	}
	
	@Override
	public long carsSoCMilestonesDetailsSubmit(CARSRSQRDetailsDTO dto) throws Exception {
		try {
			for(int i=0;i<dto.getMilestoneNo().length;i++) {
				CARSSoCMilestones mil = new CARSSoCMilestones();
				mil.setCARSInitiationId(dto.getCARSInitiationId());
				mil.setMilestoneNo(dto.getMilestoneNo()[i]);
				mil.setTaskDesc(dto.getTaskDesc()[i]);
				mil.setMonths(dto.getMonths()[i]);
				mil.setDeliverables(dto.getDeliverables()[i]);
				mil.setPaymentPercentage(dto.getPaymentPercentage()!=null?dto.getPaymentPercentage()[i]:"0");
				mil.setPaymentTerms(dto.getPaymentTerms()!=null?dto.getPaymentTerms()[i]:null);
				mil.setActualAmount(dto.getActualAmount()!=null?dto.getActualAmount()[i]:"0.00");
				mil.setCreatedBy(dto.getUserId());
				mil.setCreatedDate(sdtf.format(new Date()));
				mil.setIsActive(1);
				dao.addCARSSoCMilestoneDetails(mil);
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside CARSServiceImpl "+e);
			e.printStackTrace();
			return 0;
		}
		
	}
	
	@Override
	public int removeCARSSoCMilestonesDetails(long carsInitiationId) throws Exception {
		return dao.removeCARSSoCMilestonesDetails(carsInitiationId);
	}

	@Override
	public List<Object[]> carsSoCMoMUploadedList(String fromdate, String todate) throws Exception {
		
		return dao.carsSoCMoMUploadedList(fromdate,todate);
	}

	@Override
	public long editCARSSoC(CARSSoC soc) throws Exception {
		
		return dao.editCARSSoC(soc);
	}

	@Override
	public long dpcSoCApprovalForward(CARSApprovalForwardDTO dto) throws Exception {
		try {
			long carsinitiationid = dto.getCarsinitiationid();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			String UserId = dto.getUserId();
			String remarks = dto.getRemarks();
			String labcode = dto.getLabcode();
			String approverLabCode = dto.getApproverLabCode();
			String approverEmpId = dto.getApproverEmpId();
			String approvalDate = dto.getApprovalDate();

			CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
			long formempid = cars.getEmpId();
			Employee emp = dao.getEmpData(formempid+"");
			String fundsFrom = cars.getFundsFrom();
			String statusCode = cars.getCARSStatusCode();
			String statusCodeNext = cars.getCARSStatusCodeNext();
			
			CARSSoC soc = dao.getCARSSoCByCARSInitiationId(carsinitiationid);
			Double amount = soc.getSoCAmount()!=null?Double.parseDouble(soc.getSoCAmount()):0.00;

			List<String> forwardstatus = Arrays.asList("SFG","SFP","SID","SGR","SPR","SRC","SRM","SRF","SRR","SRI","RDG","SRD");

			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(forwardstatus.contains(statusCode)) {
					if(statusCode.equalsIgnoreCase("SFG") || statusCode.equalsIgnoreCase("SFP")) {
						cars.setDPCForwardDate(sdf.format(new Date()));
					}
					cars.setDPCSoCForwardedBy(Long.parseLong(EmpId));
					cars.setCARSStatusCode("SFD");
					cars.setCARSStatusCodeNext("SGD");
					
					dao.updateDPCApprovalSought(carsinitiationid, dto.getApprovalSought());

				}else {
					cars.setCARSStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("SGD")) {
						cars.setCARSStatusCodeNext(fundsFrom.equalsIgnoreCase("0")?"SCR":"SPD");
					}
					else if(statusCodeNext.equalsIgnoreCase("SCR") || statusCodeNext.equalsIgnoreCase("SPD")) {
						cars.setCARSStatusCodeNext("SMA");
					}
					else if(statusCodeNext.equalsIgnoreCase("SMA")) {
						cars.setCARSStatusCodeNext("SDF");
					}
					else if(statusCodeNext.equalsIgnoreCase("SDF")) {
//						if( (amount<=1000000) || (amount>5000000 && amount<=30000000) || (amount>30000000)) {
//							cars.setCARSStatusCodeNext("SAD");
//						}
//						else if(amount>1000000 && amount<=5000000) {
//							cars.setCARSStatusCodeNext("SAI");
//						}
						if(amount>1000000 && amount<=5000000) {
							cars.setCARSStatusCodeNext("SAI");
						}else {
							cars.setCARSStatusCodeNext("SAD");
						}
					}
					else if(statusCodeNext.equalsIgnoreCase("SAD")) {
						if( amount<=1000000 || (amount>1000000 && amount<=5000000) ) {
							cars.setCARSStatusCodeNext("SAD");
							cars.setDPCSoCStatus("A");
						}
						else if(amount>5000000 && amount<=30000000) {
							cars.setCARSStatusCodeNext("SAI");
						}else {
							cars.setCARSStatusCodeNext("SAJ");
						}
					}
					else if(statusCodeNext.equalsIgnoreCase("SAI")) {
						if(amount>1000000 && amount<=5000000) {
							cars.setCARSStatusCodeNext("SAD");
						}
						else if(amount>5000000 && amount<=30000000) {
							cars.setCARSStatusCodeNext("ADG");
						}
					}
					else if(statusCodeNext.equalsIgnoreCase("ADG")) {
						cars.setCARSStatusCodeNext("ADG");
						cars.setDPCSoCStatus("A");
					}
					else if(statusCodeNext.equalsIgnoreCase("SAJ")) {
						cars.setCARSStatusCodeNext("SAS");
					}
					else if(statusCodeNext.equalsIgnoreCase("SAS")) {
						cars.setCARSStatusCodeNext("SAS");
						cars.setDPCSoCStatus("A");
					}
				}

				dao.editCARSInitiation(cars);
			}
			// This is for return the application form to the user
			else if(action.equalsIgnoreCase("R")) {

				// Setting StatusCode
				if(statusCodeNext.equalsIgnoreCase("SGD")) {
					cars.setCARSStatusCode("SGR");	
				}
				else if(statusCodeNext.equalsIgnoreCase("SPD")) {
					cars.setCARSStatusCode("SPR");	
				}
				else if(statusCodeNext.equalsIgnoreCase("SCR")) {
					cars.setCARSStatusCode("SRC");	
				}
				else if(statusCodeNext.equalsIgnoreCase("SMA")) {
					cars.setCARSStatusCode("SRM");	
				}
				else if(statusCodeNext.equalsIgnoreCase("SDF")) {
					cars.setCARSStatusCode("SRF");	
				}
				else if(statusCodeNext.equalsIgnoreCase("SAD")) {
					cars.setCARSStatusCode("SRR");	
				}
				else if(statusCodeNext.equalsIgnoreCase("SAI")) {
					cars.setCARSStatusCode("SRI");	
				}
				else if(statusCodeNext.equalsIgnoreCase("ADG")) {
					cars.setCARSStatusCode("RDG");	
				}
				else if(statusCodeNext.equalsIgnoreCase("SAJ")) {
					cars.setCARSStatusCode("SRJ");	
				}
				else if(statusCodeNext.equalsIgnoreCase("SAS")) {
					cars.setCARSStatusCode("SRS");	
				}

				// Setting StatusCodeNext
				cars.setCARSStatusCodeNext("SGD");
			}
			// This is for disapprove the approval form to the user or initiator.
			else if(action.equalsIgnoreCase("D")) {
				if(statusCodeNext.equalsIgnoreCase("SAD")) {
					cars.setCARSStatusCode("SDD");
					cars.setCARSStatusCodeNext("SDD");
					cars.setDPCSoCStatus("D");
				}
				else if(statusCodeNext.equalsIgnoreCase("SAI")) {
					cars.setCARSStatusCode("SDI");
					cars.setCARSStatusCodeNext("SDI");
					cars.setDPCSoCStatus("D");
				}
				else if(statusCodeNext.equalsIgnoreCase("ADG")) {
					cars.setCARSStatusCode("DDG");
					cars.setCARSStatusCodeNext("DDG");
					cars.setDPCSoCStatus("D");
				}
				else if(statusCodeNext.equalsIgnoreCase("SAJ")) {
					cars.setCARSStatusCode("SDJ");
					cars.setCARSStatusCodeNext("SDJ");
					cars.setDPCSoCStatus("D");
				}
				else if(statusCodeNext.equalsIgnoreCase("SAS")) {
					cars.setCARSStatusCode("SDS");
					cars.setCARSStatusCodeNext("SDS");
					cars.setDPCSoCStatus("D");
				}
				dao.editCARSInitiation(cars);
			}

			// Transactions happend in the approval flow.
			CARSInitiationTrans transaction = CARSInitiationTrans.builder()
											  .CARSInitiationId(carsinitiationid)
											  .MilestoneNo("0")
											  .CARSStatusCode(cars.getCARSStatusCode())
											  .Remarks(remarks)
											  .LabCode(approverLabCode!=null?approverLabCode:labcode)
											  .ActionBy(approverEmpId!=null?approverEmpId:EmpId)
											  .ActionDate(approvalDate!=null?fc.RegularToSqlDate(approvalDate):sdtf.format(new Date()))
											  .build();
			dao.addCARSInitiationTransaction(transaction);
			
			// Approval Authority Data to send notifications
			Object[] GHDPandC = dao.getApprAuthorityDataByType(labcode, "GH-DP&C");
			Object[] GDDPandC = dao.getApprAuthorityDataByType(labcode, "DO-RTMD");
			Object[] ChairmanRPB = dao.getApprAuthorityDataByType(labcode, "Chairman RPB");
			Object[] PDEmpIds = dao.getEmpPDEmpId(cars.getFundsFrom());
			Object[] MMFDAG = dao.getApprAuthorityDataByType(labcode, "MMFD AG");
			Object[] GDDFandMM = dao.getApprAuthorityDataByType(labcode, "GD DF&MM");
			Object[] Director = dao.getLabDirectorData(labcode);
			
			long GHDPandCEmpId = Long.parseLong(GHDPandC[0].toString());
			// Notification
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A") && cars.getDPCSoCStatus().equalsIgnoreCase("A") ) {
				notification.setEmpId(GHDPandCEmpId);
				notification.setNotificationUrl("CARSRSQRApprovedList.htm?AllListTabId=2");
				notification.setNotificationMessage("CARS SoC request approved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				dao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("A")) {
				
				if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SGD")) {
					notification.setEmpId(Long.parseLong(GDDPandC[0].toString()));
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SCR")) {
					notification.setEmpId(Long.parseLong(ChairmanRPB[0].toString()));
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SPD")) {
					notification.setEmpId(Long.parseLong(PDEmpIds[1].toString()));
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SMA")) {
					notification.setEmpId(Long.parseLong(MMFDAG[0].toString()));
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SDF")) {
					notification.setEmpId(Long.parseLong(GDDFandMM[0].toString()));
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SAD")) {
					notification.setEmpId(Long.parseLong(Director[0].toString()));
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SAI")) {
					notification.setEmpId(GHDPandCEmpId);
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("ADG")) {
					notification.setEmpId(GHDPandCEmpId);
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SAJ")) {
					notification.setEmpId(GHDPandCEmpId);
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("SAS")) {
					notification.setEmpId(GHDPandCEmpId);
				}
				
				notification.setNotificationUrl("CARSRSQRApprovals.htm");
				notification.setNotificationMessage("CARS SoC forwarded by D-P&C "+GHDPandC[1].toString());
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				dao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")){
				notification.setEmpId(GHDPandCEmpId);
				notification.setNotificationUrl("CARSRSQRApprovedList.htm?AllListTabId=2");
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"CARS SoC Request Returned":"CARS SoC Request Disapproved");
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
	public Object[] getApprAuthorityDataByType(String labcode, String type) throws Exception {
		
		return dao.getApprAuthorityDataByType(labcode, type);
	}

	@Override
	public Object[] getLabDirectorData(String labcode) throws Exception {
		
		return dao.getLabDirectorData(labcode);
	}

	@Override
	public List<Object[]> carsDPandCSoCPendingList(String empId, String labcode) throws Exception {
		
		return dao.carsDPandCSoCPendingList(empId, labcode);
	}

	@Override
	public long carsSoCDPCRevoke(String carsInitiationId, String userId, String empId, String labcode) throws Exception {
		
		long carsinitiationid = Long.parseLong(carsInitiationId);
		
		CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
		cars.setCARSStatusCode("SRD");
		cars.setCARSStatusCodeNext("SFD");
		cars.setModifiedBy(userId);
		cars.setModifiedDate(sdtf.format(new Date()));
		
		// Transactions.
		CARSInitiationTrans transaction = CARSInitiationTrans.builder()
										  .CARSInitiationId(carsinitiationid)
										  .MilestoneNo("0")
										  .CARSStatusCode("SRD")
										  .LabCode(labcode)
										  .ActionBy(empId)
										  .ActionDate(sdtf.format(new Date()))
										  .build();
		dao.addCARSInitiationTransaction(transaction);
		
		return dao.editCARSInitiation(cars);
	}

	@Override
	public List<Object[]> carsDPCSoCApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.carsDPCSoCApprovedList(empId, FromDate, ToDate);
	}

	@Override
	public List<Object[]> carsTransListByType(String carsInitiationId, String statusFor) throws Exception {
		
		return dao.carsTransListByType(carsInitiationId, statusFor);
	}

	@Override
	public List<Object[]> carsRemarksHistoryByType(String carsInitiationId, String remarksFor) throws Exception {
		
		return dao.carsRemarksHistoryByType(carsInitiationId, remarksFor);
	}

	@Override
	public long carsSoCUploadMoM(MultipartFile momFile, String labcode, String carsInitiationId, String EmpId, String UserId, String MoMFlag) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "CARS\\SoC\\";
		Path carsPath = Paths.get(uploadpath,"CARS" ,"SoC");
		
		String momupload = null;
		// To upload file path for SoO
		if (!momFile.isEmpty()) {
			momupload = "MoM-" + timestampstr + "."+ FilenameUtils.getExtension(momFile.getOriginalFilename());
			saveFile1(carsPath, momupload, momFile);
		}
		
		long result = dao.carsSoCUploadMoM(momupload, carsInitiationId);
		if(MoMFlag!=null && MoMFlag.equalsIgnoreCase("F")) {
			if(result!=0) {
				CARSInitiation carsIni = dao.getCARSInitiationById(Long.parseLong(carsInitiationId));
				Object[] dpandc = dao.getEmpDataByLoginType("E");
				Object[] GHDPandC = dao.getApprAuthorityDataByType(labcode, "GH-DP&C");
				
				for(int i=0;i<2;i++) {
					PfmsNotification notification2 = new PfmsNotification();
					notification2.setEmpId(Long.parseLong(i==0?dpandc[0].toString():GHDPandC[0].toString()));
					notification2.setNotificationUrl("CARSRSQRApprovedList.htm?AllListTabId=2");
					notification2.setNotificationMessage("CARS MoM Uploaded for CARSNO "+carsIni.getCARSNo());
					notification2.setNotificationby(Long.parseLong(EmpId));
					notification2.setNotificationDate(LocalDate.now().toString());
					notification2.setIsActive(1);
					notification2.setCreatedBy(UserId);
					notification2.setCreatedDate(sdtf.format(new Date()));

					dao.addNotifications(notification2);
				}
			}
		}
		
		return result;
	}

	@Override
	public List<Object[]> getLabList(String lab) throws Exception {
		
		return dao.getLabList(lab);
	}

	@Override
	public List<Object[]> getEmployeeListByLabCode(String labCode) throws Exception {
		
		return dao.getEmployeeListByLabCode(labCode);
	}

	@Override
	public LabMaster getLabDetailsByLabCode(String labcode) throws Exception {
	
		return dao.getLabDetailsByLabCode(labcode);
	}

	@Override
	public List<Object[]> carsDPCSoCFinalApprovedList(String fromdate, String todate) throws Exception {
		
		return dao.carsDPCSoCFinalApprovedList(fromdate, todate);
	}

	@Override
	public CARSContract getCARSContractByCARSInitiationId(long carsInitiationId) throws Exception {
		
		return dao.getCARSContractByCARSInitiationId(carsInitiationId);
	}

	@Override
	public List<CARSContractConsultants> getCARSContractConsultantsByCARSInitiationId(long carsInitiationId) throws Exception {
		
		return dao.getCARSContractConsultantsByCARSInitiationId(carsInitiationId);
	}

	@Override
	public List<CARSContractEquipment> getCARSContractEquipmentByCARSInitiationId(long carsInitiationId) throws Exception {
		
		return dao.getCARSContractEquipmentByCARSInitiationId(carsInitiationId);
	}

	@Override
	public long addCARSContractDetails(CARSContract contract) throws Exception {
		
		return dao.addCARSContractDetails(contract);
	}

	@Override
	public long editCARSContractDetails(CARSContract contract) throws Exception {
		
		return dao.editCARSContractDetails(contract);
	}

	@Override
	public long addCARSContractConsultantsDetails(CARSContractDetailsDTO dto) throws Exception {
		try {
			dao.removeCARSContractConsultantsDetails(dto.getCARSInitiationId());
			
			for(int i=0;i<dto.getConsultantName().length;i++) {
				CARSContractConsultants consultants = new CARSContractConsultants();
				consultants.setCARSInitiationId(dto.getCARSInitiationId());
				consultants.setConsultantName(dto.getConsultantName()[i]);
				consultants.setConsultantCompany(dto.getConsultantCompany()!=null?dto.getConsultantCompany()[i]:null);
				consultants.setCreatedBy(dto.getUserId());
				consultants.setCreatedDate(sdtf.format(new Date()));
				consultants.setIsActive(1);
				if( (dto.getConsultantName()[i]!=null && !dto.getConsultantName()[i].isEmpty()) || (dto.getConsultantCompany()[i]!=null && !dto.getConsultantCompany()[i].isEmpty()) ) {
					dao.addCARSContractConsultantsDetails(consultants);
				}
			
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside CARSServiceImpl addCARSContractConsultantsDetails "+e);
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public long addCARSContractEquipmentDetails(CARSContractDetailsDTO dto) throws Exception {
		try {
			dao.removeCARSContractEquipmentDetails(dto.getCARSInitiationId());
			
			for(int i=0;i<dto.getEquipmentDescription().length ;i++) {
				CARSContractEquipment equipment = new CARSContractEquipment();
				equipment.setCARSInitiationId(dto.getCARSInitiationId());
				equipment.setDescription(dto.getEquipmentDescription()[i]);
				equipment.setCreatedBy(dto.getUserId());
				equipment.setCreatedDate(sdtf.format(new Date()));
				equipment.setIsActive(1);
				if(dto.getEquipmentDescription()[i]!=null && !dto.getEquipmentDescription()[i].isEmpty()) {
					dao.addCARSContractEquipmentDetails(equipment);
				}
				
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside CARSServiceImpl addCARSContractEquipmentDetails "+e);
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public long carsFinalReportEditSubmit(CARSContract contract, String firstTime,String labcode) throws Exception {
		try {
			long carsInitiationId = contract.getCARSInitiationId();
			CARSInitiation carsInitiation = dao.getCARSInitiationById(carsInitiationId);
			Object[] empDetails = dao.getEmpDetailsByEmpId(carsInitiation.getEmpId()+"");
			
			if(firstTime!=null && firstTime.equalsIgnoreCase("Y")) {
				String maxCARSContractNo = dao.getMaxCARSContractNo();
				String[] split = maxCARSContractNo!=null?maxCARSContractNo.split("/"):null;
				String CARSContractId = split!=null?split[0]:"0";
				LocalDate now = LocalDate.now();
				String ContractNo = labcode+"/CARS-"+(Long.parseLong(CARSContractId)+1)+"/"+empDetails[6]+"/"+now.getYear();
				contract.setContractNo(ContractNo);
			}
			dao.editCARSContractDetails(contract);
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside CARSServiceImpl carsFinalReportEditSubmit  "+e);
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<CARSOtherDocDetails> getCARSOtherDocDetailsByCARSInitiationId(long carsInitiationId) throws Exception {
		
		return dao.getCARSOtherDocDetailsByCARSInitiationId(carsInitiationId);
	}

	@Override
	public long CARSCSDocDetailsSubmit(CARSOtherDocDetails doc, MultipartFile attatchFlagA, MultipartFile attatchFlagB, MultipartFile attatchFlagC, String EmpId, String labcode) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "CARS\\Other Docs\\";
		Path carsPath = Paths.get(uploadpath, "CARS", "Other Docs");
		
		long carsInitiationId = doc.getCARSInitiationId();
		// To upload file path for Flag-A
		if (!attatchFlagA.isEmpty()) {
			doc.setAttachFlagA("CSFlagA-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagA.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagA(), attatchFlagA);
		} else {
			doc.setAttachFlagA(null);
		}
		
		// To upload file path for Flag-B
		if (!attatchFlagB.isEmpty()) {
			doc.setAttachFlagB("CSFlagB-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagB.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagB(), attatchFlagB);
		} else {
			doc.setAttachFlagB(null);
		}
		
		// To upload file path for Flag-C
		if (!attatchFlagC.isEmpty()) {
			doc.setAttachFlagC("CSFlagC-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagC.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagC(), attatchFlagC);
		} else {
			doc.setAttachFlagC(null);
		}
		
		doc.setInitiationDate(sdf.format(new Date()));
//		doc.setOtherDocFileNo("LRDE/CARS/CS-"+doc.getCARSInitiationId()+"/2024");
		
		long otherDocId = dao.addCARSOtherDocDetails(doc);
		if(otherDocId>0) {
			
			dao.updateCARSInitiationStatusCodes(carsInitiationId, "CIN", "CFW");
			
		// Transaction
		CARSInitiationTrans transaction = CARSInitiationTrans.builder()
										  .CARSInitiationId(doc.getCARSInitiationId())
										  .MilestoneNo("0")
										  .CARSStatusCode("CIN")
										  .LabCode(labcode)
										  .ActionBy(EmpId)
										  .ActionDate(sdtf.format(new Date()))
										  .build();
		dao.addCARSInitiationTransaction(transaction);
		}
		
		return otherDocId;
	}

	@Override
	public long CARSCSDocDetailsUpdate(CARSOtherDocDetails doc, MultipartFile attatchFlagA, MultipartFile attatchFlagB,MultipartFile attatchFlagC) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "CARS\\Other Docs\\";
		Path carsPath = Paths.get(uploadpath, "CARS", "Other Docs");
		
		// To upload file path for Flag-A
		if (!attatchFlagA.isEmpty()) {
			doc.setAttachFlagA("CSFlagA-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagA.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagA(), attatchFlagA);
		} 
		
		// To upload file path for Flag-B
		if (!attatchFlagB.isEmpty()) {
			doc.setAttachFlagB("CSFlagB-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagB.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagB(), attatchFlagB);
		}
		
		// To upload file path for Flag-C
		if (!attatchFlagC.isEmpty()) {
			doc.setAttachFlagC("CSFlagC-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagC.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagC(), attatchFlagC);
		}
		
		return dao.editCARSOtherDocDetails(doc);
	}

	@Override
	public Object[] carsStatusDetailsByCARSInitiationId(long carsInitiationId) throws Exception {
		
		return dao.carsStatusDetailsByCARSInitiationId(carsInitiationId);
	}

	@Override
	public CARSOtherDocDetails getCARSOtherDocDetailsById(long otherDocDetailsId) throws Exception {
		
		return dao.getCARSOtherDocDetailsById(otherDocDetailsId);
	}
	
	// This method is to handle the approval flow for Contract Signature approval.
	@Override
	public long othersCSApprovalForward(CARSApprovalForwardDTO dto,String labcode) throws Exception {
		try {
			long carsinitiationid = dto.getCarsinitiationid();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			String UserId = dto.getUserId();
			String remarks = dto.getRemarks();
			String otherDocDetailsId = dto.getOtherDocDetailsId();

			CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
			long formempid = cars.getEmpId();
			Employee emp = dao.getEmpData(formempid+"");
			String statusCode = cars.getCARSStatusCode();
			String statusCodeNext = cars.getCARSStatusCodeNext();
			String carsNo = cars.getCARSNo();

			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(statusCode.equalsIgnoreCase("CIN") || statusCode.equalsIgnoreCase("CRA") || 
					statusCode.equalsIgnoreCase("CRD") || statusCode.equalsIgnoreCase("CRV")) {

					if(statusCode.equalsIgnoreCase("CIN")) {
						
						dao.updateOtherDocForwardDetails(EmpId, sdf.format(new Date()), otherDocDetailsId);
					}
					cars.setCARSStatusCode("CFW");
					cars.setCARSStatusCodeNext("CFA");
					
				}else {
					cars.setCARSStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("CFA")) {
						cars.setCARSStatusCodeNext("CAD");
					}else if(statusCodeNext.equalsIgnoreCase("CAD")) {
						cars.setCARSStatusCodeNext(statusCodeNext);
					}
					
				}
				dao.editCARSInitiation(cars);
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(statusCodeNext.equalsIgnoreCase("CFA")) {
					cars.setCARSStatusCode("CRA");
				}else if(statusCodeNext.equalsIgnoreCase("CAD")) {
					cars.setCARSStatusCode("CRD");
				}

				cars.setCARSStatusCodeNext("CFA");

				dao.editCARSInitiation(cars);
			}

			// Transactions happend in the approval flow.
			CARSInitiationTrans transaction = CARSInitiationTrans.builder()
											  .CARSInitiationId(carsinitiationid)
											  .MilestoneNo("0")
											  .CARSStatusCode(cars.getCARSStatusCode())
											  .Remarks(remarks)
											  .LabCode(labcode)
											  .ActionBy(EmpId)
											  .ActionDate(sdtf.format(new Date()))
											  .build();
			dao.addCARSInitiationTransaction(transaction);

			// Approval Authority Data to send notifications
			Object[] GHDPandC = dao.getApprAuthorityDataByType(labcode, "GH-DP&C");
			Object[] GDDPandC = dao.getApprAuthorityDataByType(labcode, "DO-RTMD");
			Object[] ADPandC = dao.getApprAuthorityDataByType(labcode, "AD-P&C");
			Object[] Director = dao.getLabDirectorData(labcode);
						
			// Notification
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A") && cars.getCARSStatusCode().equalsIgnoreCase("CAD") ) {
				notification.setEmpId(Long.parseLong(GDDPandC[0].toString()));
				notification.setNotificationUrl("CARSOtherDocsList.htm?carsInitiationId="+carsinitiationid);
				notification.setNotificationMessage("CARS Contract Signature request approved <br> for "+carsNo);
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				dao.addNotifications(notification);

			}
			else if(action.equalsIgnoreCase("A")) {

				if(cars.getCARSStatusCodeNext().equalsIgnoreCase("CFA")) {
					notification.setEmpId(Long.parseLong(ADPandC[0].toString()));
				}
				else if(cars.getCARSStatusCodeNext().equalsIgnoreCase("CAD")) {
					notification.setEmpId(Long.parseLong(Director[0].toString()));
				}

				notification.setNotificationUrl("CARSRSQRApprovals.htm");
				notification.setNotificationMessage("CARS Contract Signature request forwarded <br> by "+GDDPandC[1].toString());
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				dao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D"))
			{
				notification.setEmpId(Long.parseLong(GDDPandC[0].toString()));
				notification.setNotificationUrl("CARSOtherDocsList.htm?carsInitiationId="+carsinitiationid);
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"CARS Contract Signature Request Returned":"CARS Contract Signature Request Disapproved");
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
	public List<Object[]> carsCSPendingList(String empId, String labcode) throws Exception {
		
		return dao.carsCSPendingList(empId, labcode);
	}

	@Override
	public List<Object[]> carsCSApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.carsCSApprovedList(empId, FromDate, ToDate);
	}

	@Override
	public long carsCSDoCRevoke(String carsInitiationId, String userId, String empId, String labcode) throws Exception {
		
		try {
			long carsinitiationid = Long.parseLong(carsInitiationId);
			
			dao.updateCARSInitiationStatusCodes(carsinitiationid, "CRV", "CFW");
			
			// Transactions.
			CARSInitiationTrans transaction = CARSInitiationTrans.builder()
											  .CARSInitiationId(carsinitiationid)
											  .MilestoneNo("0")
											  .CARSStatusCode("CRV")
											  .LabCode(labcode)
											  .ActionBy(empId)
											  .ActionDate(sdtf.format(new Date()))
											  .build();
			dao.addCARSInitiationTransaction(transaction);
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public long carsCSDocUpload(MultipartFile otherdocfile, String otherDocDetailsId) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "CARS\\Other Docs\\";
		Path carsPath = Paths.get(uploadpath, "CARS", "Other Docs");
		
		String otherdocupload = null;
		// To upload file path for Contract Signature form
		if (!otherdocfile.isEmpty()) {
			otherdocupload = "Contract Signature-" + timestampstr + "."+ FilenameUtils.getExtension(otherdocfile.getOriginalFilename());
			saveFile1(carsPath, otherdocupload, otherdocfile);
		}
		
		long result = dao.carsOtherDocUpload(otherdocupload, otherDocDetailsId);
		
		return result;
	}

	@Override
	public List<Object[]> carsRemarksHistoryByMilestoneNo(String carsInitiationId, String milestoneNo) throws Exception {
	
		return dao.carsRemarksHistoryByMilestoneNo(carsInitiationId, milestoneNo);
	}

	@Override
	public List<Object[]> carsTransApprovalDataByMilestoneNo(String carsInitiationId, String milestoneNo) {
		
		return dao.carsTransApprovalDataByMilestoneNo(carsInitiationId, milestoneNo);
	}

	@Override
	public long CARSMPDocDetailsSubmit(CARSOtherDocDetails doc, MultipartFile attatchFlagA, MultipartFile attatchFlagB, MultipartFile attatchFlagC, String EmpId, String labcode) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "CARS\\Other Docs\\";
		Path carsPath = Paths.get(uploadpath, "CARS", "Other Docs");
		
		long carsInitiationId = doc.getCARSInitiationId();
		// To upload file path for Flag-A
		if (attatchFlagA!=null && !attatchFlagA.isEmpty()) {
			doc.setAttachFlagA("PaymentFlagA-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagA.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagA(), attatchFlagA);
		} else {
			doc.setAttachFlagA(null);
		}
		
		// To upload file path for Flag-B
		if (attatchFlagB!=null && !attatchFlagB.isEmpty()) {
			doc.setAttachFlagB("PaymentFlagB-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagB.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagB(), attatchFlagB);
		} else {
			doc.setAttachFlagB(null);
		}
		
		// To upload file path for Flag-C
		if (attatchFlagC!=null && !attatchFlagC.isEmpty()) {
			doc.setAttachFlagC("PaymentFlagC-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagC.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagC(), attatchFlagC);
		} else {
			doc.setAttachFlagC(null);
		}
		
		doc.setInitiationDate(sdf.format(new Date()));
//		doc.setOtherDocFileNo("LRDE/CARS/"+doc.getMilestoneNo()+"/"+doc.getCARSInitiationId()+"/2024");
		
		long otherDocId = dao.addCARSOtherDocDetails(doc);
		if(otherDocId>0) {
			
			dao.updateCARSInitiationStatusCodes(carsInitiationId, "MIN", "MFW");
			
		// Transaction
		CARSInitiationTrans transaction = CARSInitiationTrans.builder()
										  .CARSInitiationId(doc.getCARSInitiationId())
										  .MilestoneNo(doc.getMilestoneNo())
										  .CARSStatusCode("MIN")
										  .LabCode(labcode)
										  .ActionBy(EmpId)
										  .ActionDate(sdtf.format(new Date()))
										  .build();
		dao.addCARSInitiationTransaction(transaction);
		}
		
		return otherDocId;
	}

	@Override
	public long CARSMPDocDetailsUpdate(CARSOtherDocDetails doc, MultipartFile attatchFlagA, MultipartFile attatchFlagB,MultipartFile attatchFlagC) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "CARS\\Other Docs\\";
		Path carsPath = Paths.get(uploadpath, "CARS", "Other Docs");
		
		// To upload file path for Flag-A
		if (attatchFlagA!=null && !attatchFlagA.isEmpty()) {
			doc.setAttachFlagA("PaymentFlagA-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagA.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagA(), attatchFlagA);
		} 
		
		// To upload file path for Flag-B
		if (attatchFlagB!=null && !attatchFlagB.isEmpty()) {
			doc.setAttachFlagB("PaymentFlagB-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagB.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagB(), attatchFlagB);
		}
		
		// To upload file path for Flag-C
		if (attatchFlagC!=null && !attatchFlagC.isEmpty()) {
			doc.setAttachFlagC("PaymentFlagC-" + timestampstr + "."
					+ FilenameUtils.getExtension(attatchFlagC.getOriginalFilename()));
			saveFile1(carsPath, doc.getAttachFlagC(), attatchFlagC);
		}
		
		return dao.editCARSOtherDocDetails(doc);
	}
	
	// This method is to handle the approval flow for Milestone Payment approval.
	@Override
	public long othersMPApprovalForward(CARSApprovalForwardDTO dto,String labcode) throws Exception {
		try {
			long carsinitiationid = dto.getCarsinitiationid();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			String UserId = dto.getUserId();
			String remarks = dto.getRemarks();
			String otherDocDetailsId = dto.getOtherDocDetailsId();
			String milestoneNo = dto.getMilestoneNo();

			CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
			
			CARSOtherDocDetails doc = dao.getCARSOtherDocDetailsById(Long.parseLong(otherDocDetailsId));
			String statusCode = doc.getOthersStatusCode();
			String statusCodeNext = doc.getOthersStatusCodeNext();
//			long formempid = cars.getEmpId();
//			Employee emp = dao.getEmpData(formempid+"");
//			String statusCode = cars.getCARSStatusCode();
//			String statusCodeNext = cars.getCARSStatusCodeNext();
			String carsNo = cars.getCARSNo();

			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(statusCode.equalsIgnoreCase("MIN") || statusCode.equalsIgnoreCase("MRA") || statusCode.equalsIgnoreCase("MRC") ||
				   statusCode.equalsIgnoreCase("MRD") || statusCode.equalsIgnoreCase("MRV")) {

					
					doc.setForwardedBy(Long.parseLong(EmpId));
					doc.setForwardedDate(sdf.format(new Date()));
					doc.setOthersStatusCode("MFW");
					doc.setOthersStatusCodeNext("MFA");
					
				}else {
					doc.setOthersStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("MFA")) {
						doc.setOthersStatusCodeNext("MFC");
					}else if(statusCodeNext.equalsIgnoreCase("MFC")) {
						doc.setOthersStatusCodeNext("MAD");
					}else if(statusCodeNext.equalsIgnoreCase("MAD")) {
						doc.setOthersStatusCodeNext(statusCodeNext);
					}
					
				}
				
				dao.editCARSOtherDocDetails(doc);
				
				dao.updateCARSInitiationStatusCodes(carsinitiationid, doc.getOthersStatusCode(), doc.getOthersStatusCodeNext());
			}
			// This is for return the approval form to the user or initiator. 
			else if(action.equalsIgnoreCase("R")){
				if(statusCodeNext.equalsIgnoreCase("MFA")) {
					doc.setOthersStatusCode("MRA");
				}else if(statusCodeNext.equalsIgnoreCase("MFC")) {
					doc.setOthersStatusCode("MRC");
				}else if(statusCodeNext.equalsIgnoreCase("MAD")) {
					doc.setOthersStatusCode("MRD");
				}

				doc.setOthersStatusCodeNext("MFA");

				dao.editCARSOtherDocDetails(doc);
				dao.updateCARSInitiationStatusCodes(carsinitiationid, doc.getOthersStatusCode(), doc.getOthersStatusCodeNext());
			}

			// Transactions happend in the approval flow.
			CARSInitiationTrans transaction = CARSInitiationTrans.builder()
											  .CARSInitiationId(carsinitiationid)
											  .MilestoneNo(milestoneNo)
											  .CARSStatusCode(doc.getOthersStatusCode())
											  .Remarks(remarks)
											  .LabCode(labcode)
											  .ActionBy(EmpId)
											  .ActionDate(sdtf.format(new Date()))
											  .build();
			dao.addCARSInitiationTransaction(transaction);

			// Approval Authority Data to send notifications
			Object[] GHDPandC = dao.getApprAuthorityDataByType(labcode, "GH-DP&C");
			Object[] GDDPandC = dao.getApprAuthorityDataByType(labcode, "DO-RTMD");
			Object[] ADPandC = dao.getApprAuthorityDataByType(labcode, "AD-P&C");
			Object[] Chairperson = dao.getApprAuthorityDataByType(labcode, "Chairperson (CARS Committee)");
			Object[] Director = dao.getLabDirectorData(labcode);
						
			// Notification
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A") && doc.getOthersStatusCode().equalsIgnoreCase("MAD") ) {
				notification.setEmpId(Long.parseLong(GDDPandC[0].toString()));
				notification.setNotificationUrl("CARSOtherDocsList.htm?carsInitiationId="+carsinitiationid);
				notification.setNotificationMessage("CARS Payment Approval request approved <br> for "+carsNo);
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				dao.addNotifications(notification);

			}
			else if(action.equalsIgnoreCase("A")) {

				if(doc.getOthersStatusCodeNext().equalsIgnoreCase("MFA")) {
					notification.setEmpId(Long.parseLong(ADPandC[0].toString()));
				}
				else if(doc.getOthersStatusCodeNext().equalsIgnoreCase("MFC")) {
					notification.setEmpId(Long.parseLong(Chairperson[0].toString()));
				}
				else if(doc.getOthersStatusCodeNext().equalsIgnoreCase("MAD")) {
					notification.setEmpId(Long.parseLong(Director[0].toString()));
				}

				notification.setNotificationUrl("CARSRSQRApprovals.htm");
				notification.setNotificationMessage("CARS Payment Approval request forwarded <br> by "+GDDPandC[1].toString());
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				dao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D"))
			{
				notification.setEmpId(Long.parseLong(GDDPandC[0].toString()));
				notification.setNotificationUrl("CARSOtherDocsList.htm?carsInitiationId="+carsinitiationid);
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"CARS Payment Approval Request Returned":"CARS Payment Approval Request Disapproved");
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
	public List<Object[]> carsMPPendingList(String empId, String labcode) throws Exception {
		
		return dao.carsMPPendingList(empId, labcode);
	}

	@Override
	public List<Object[]> carsMPApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.carsMPApprovedList(empId, FromDate, ToDate);
	}

	@Override
	public List<Object[]> carsMPStatusDetailsByCARSInitiationId(long carsInitiationId) throws Exception {
		
		return dao.carsMPStatusDetailsByCARSInitiationId(carsInitiationId);
	}

	@Override
	public long carsMPDoCRevoke(String carsInitiationId, String userId, String empId, String milestoneNo, String labcode) throws Exception {
		
		try {
			long carsinitiationid = Long.parseLong(carsInitiationId);
			
			dao.updateCARSInitiationStatusCodes(carsinitiationid, "MRV", "MFW");
			
			dao.updateCARSOtherDocStatusCodes(carsinitiationid, "MRV", "MFW", milestoneNo);
			
			// Transactions.
			CARSInitiationTrans transaction = CARSInitiationTrans.builder()
											  .CARSInitiationId(carsinitiationid)
											  .MilestoneNo(milestoneNo)
											  .CARSStatusCode("MRV")
											  .LabCode(labcode)
											  .ActionBy(empId)
											  .ActionDate(sdtf.format(new Date()))
											  .build();
			dao.addCARSInitiationTransaction(transaction);
			
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public long carsMPDocUpload(MultipartFile otherdocfile, String otherDocDetailsId) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "CARS\\Other Docs\\";
		Path carsPath = Paths.get(uploadpath, "CARS", "Other Docs");
		
		String otherdocupload = null;
		// To upload file path for Contract Signature form
		if (!otherdocfile.isEmpty()) {
			otherdocupload = "Payment Approval-" + timestampstr + "."+ FilenameUtils.getExtension(otherdocfile.getOriginalFilename());
			saveFile1(carsPath, otherdocupload, otherdocfile);
		}
		
		long result = dao.carsOtherDocUpload(otherdocupload, otherDocDetailsId);
		
		return result;
	}

	@Override
	public long CARSPTCDocDetailsSubmit(CARSOtherDocDetails doc) throws Exception {
		
		return dao.addCARSOtherDocDetails(doc);
	}

	@Override
	public long CARSPTCDocDetailsUpdate(CARSOtherDocDetails doc) throws Exception {
		
		return dao.editCARSOtherDocDetails(doc);
	}

	@Override
	public List<Object[]> ExpertEmployeeList() throws Exception {
		
		return dao.ExpertEmployeeList();
	}

	@Override
	public int finalSoODateSubmit(String carsInitiationId, String date) throws Exception {
		
		return dao.finalSoODateSubmit(carsInitiationId, date);
	}
	
	@Override
	public Long carsMilestoneActionMainInsert(ActionMainDto main, ActionAssignDto assign) throws Exception {
		try {
			logger.info(new Date() +"Inside SERVICE carsMilestoneActionMainInsert ");
//			long success=1;
			long unsuccess=0;
			Object[] lab=null;
			int count=0;
			String ProjectCode=null;
			try
			{
				lab=actiondao.LabDetails();
				count=actiondao.ActionGenCount(main.getProjectId(),main.getType());
				if(!main.getProjectId().equalsIgnoreCase("0"))
				{
					ProjectCode=actiondao.ProjectCode(main.getProjectId());
				}
			}
			catch (Exception e) 
			{	
				logger.info(new Date() +"Inside SERVICE carsMilestoneActionMainInsert ",e);	
				return unsuccess;
			}
			
			CARSSoCMilestones carsSoCMilestones = dao.getCARSSoCMilestonesById(main.getCARSSoCMilestoneId());
			String Project=null;
			
			if(!main.getProjectId().equalsIgnoreCase("0")) {
				
					Project="/"+ProjectCode;
				
			}else{
				Project="/GEN";
			}
			Project+="/CARS-"+carsSoCMilestones.getCARSInitiationId()+"/"+carsSoCMilestones.getMilestoneNo()+"/";
			ActionMain actionmain=new ActionMain();
			
			actionmain.setCARSSoCMilestoneId(Long.parseLong(main.getCARSSoCMilestoneId()));
			actionmain.setActionLinkId(Long.parseLong(main.getActionLinkId()));
			actionmain.setMainId(Long.parseLong(main.getMainId()));
			actionmain.setActivityId(Long.parseLong(main.getActivityId()));
			actionmain.setActionType(main.getActionType());
			actionmain.setType(main.getType());
			actionmain.setActionItem(main.getActionItem());
			actionmain.setActionDate(java.sql.Date.valueOf(main.getMeetingDate()));
			actionmain.setCategory(main.getCategory());
			actionmain.setPriority(main.getPriority());
			//actionmain.setActionStatus(main.getActionStatus());
			actionmain.setProjectId(Long.parseLong(main.getProjectId()));
			actionmain.setScheduleMinutesId(Long.parseLong(main.getScheduleMinutesId()));
			actionmain.setCreatedBy(main.getCreatedBy());
			actionmain.setCreatedDate(sdtf.format(new Date()));
			actionmain.setIsActive(1);
			actionmain.setParentActionId(Long.parseLong(main.getActionParentId()));
			actionmain.setActionLevel(main.getActionLevel());
			long result=actiondao.ActionMainInsert(actionmain);
			//changed on 06-11
			if(assign.getMultipleAssigneeList().size()>0) {
				for(int i=0;i<assign.getMultipleAssigneeList().size();i++) {
					ActionAssign actionassign = new ActionAssign();
						
					//count=count+1;
					String actionCount=(count+1)+"-"+(i+1);

					if(lab!=null && main.getLabName()!=null) {
				    	 Date meetingdate= new SimpleDateFormat("yyyy-MM-dd").parse(main.getMeetingDate().toString());

					     actionassign.setActionNo(main.getLabName()+Project+sdf2.format(meetingdate).toString().toUpperCase().replace("-", "")+"/"+actionCount);
					}else {
						return unsuccess;
					}
					
					actionassign.setActionMainId(result);
					actionassign.setPDCOrg(java.sql.Date.valueOf(sdf.format(rdf.parse(assign.getPDCOrg()))));
					actionassign.setEndDate(java.sql.Date.valueOf(sdf.format(rdf.parse(assign.getPDCOrg()))));
					actionassign.setAssigneeLabCode(assign.getAssigneeLabCode());
					actionassign.setAssignee(Long.parseLong(assign.getMultipleAssigneeList().get(i)));
					actionassign.setAssignorLabCode(assign.getAssignorLabCode());
					actionassign.setAssignor(assign.getAssignor());
					actionassign.setRevision(0);
//					actionassign.setActionFlag("N");		
					actionassign.setActionStatus("A");
					actionassign.setCreatedBy(main.getCreatedBy());
					actionassign.setCreatedDate(sdtf.format(new Date()));
					actionassign.setIsActive(1);
					actionassign.setProgress(0);
					long assignid=  actiondao.ActionAssignInsert(actionassign);
					System.out.println("assignid---"+assignid);
//					if(result>0) {
//						Object[] data=actiondao.ActionNotification(String.valueOf(result) ,String.valueOf(assignid)).get(0);
//						PfmsNotification notification=new PfmsNotification();
//						notification.setEmpId(Long.parseLong(data[2].toString()));
//						notification.setNotificationby(Long.parseLong(data[5].toString()));
//						notification.setNotificationDate(sdtf.format(new Date()));
//						notification.setScheduleId(unsuccess);
//						notification.setCreatedBy(main.getCreatedBy());
//						notification.setCreatedDate(sdtf.format(new Date()));
//						notification.setIsActive(1);
//						if("I".equalsIgnoreCase(actionmain.getType())) {
//							notification.setNotificationUrl("ActionIssue.htm");
//							 notification.setNotificationMessage("An Issue No "+data[7]+" Assigned by "+data[3]+", "+data[4]+".");
//						} else {
//							notification.setNotificationUrl("AssigneeList.htm");
//							notification.setNotificationMessage("An Action No "+data[7]+" Assigned by "+data[3]+", "+data[4]+".");
//						}
//						notification.setStatus("MAR");
//			            dao.ActionNotificationInsert(notification);
//					}else {
//					return unsuccess;
//					}
					}	
		
			}
		
			return 1L;
		} catch (Exception e) {
			logger.info(new Date() +"Inside SERVICE carsMilestoneActionMainInsert "+ e);	
			e.printStackTrace();
			return 0L;
		}
	}

	@Override
	public List<Object[]> assignedListByCARSSoCMilestoneId(String carsSoCMilestoneId) throws Exception {
		
		return dao.assignedListByCARSSoCMilestoneId(carsSoCMilestoneId);
	}

	@Override
	public CARSSoCMilestones getCARSSoCMilestonesById(String carsSoCMilestoneId) throws Exception {
		
		return dao.getCARSSoCMilestonesById(carsSoCMilestoneId);
	}
	
	@Override
	public long addCARSSoCMilestonesProgress(CARSSoCMilestonesProgress milestoneProgress) throws Exception {
		
		return dao.addCARSSoCMilestonesProgress(milestoneProgress);
	}
	
	@Override
	public List<CARSSoCMilestonesProgress> getCARSSoCMilestonesProgressListByCARSSoCMilestoneId(String carsSoCMilestoneId) throws Exception {

		return dao.getCARSSoCMilestonesProgressListByCARSSoCMilestoneId(carsSoCMilestoneId);
	}
	
	@Override
	public List<Object[]> getAllCARSSoCMilestonesProgressList() throws Exception {
	
		return dao.getAllCARSSoCMilestonesProgressList();
	}

	@Override
	public List<CARSSoCMilestones> getAllCARSSoCMilestonesList() throws Exception {
		
		return dao.getAllCARSSoCMilestonesList();
	}
	
	@Override
	public List<CARSContract> getAllCARSContractList() throws Exception {

		return dao.getAllCARSContractList();
	}

	@Override
	public List<CARSOtherDocDetails> getCARSOtherDocDetailsList() throws Exception {

		return dao.getCARSOtherDocDetailsList();
	}
	
	@Override
	public int carsCurrentStatusUpdate(String currentStatus, String carsInitiationId) throws Exception {
		
		return dao.carsCurrentStatusUpdate(currentStatus, carsInitiationId);
	}

	@Override
	public List<CARSAnnualReport> getCARSAnnualReportListByYear(String annualYear) throws Exception {
		
		return dao.getCARSAnnualReportListByYear(annualYear);
	}

	@Override
	public long addCARSAnnualReport(CARSAnnualReport carsAnnualReport) throws Exception {
		
		return dao.addCARSAnnualReport(carsAnnualReport);
	}
	
	@Override
	public int deleteCARSAnnualReportRecordsByYear(String annualYear) throws Exception {
		
		return dao.deleteCARSAnnualReportRecordsByYear(annualYear);
	}
	
}
