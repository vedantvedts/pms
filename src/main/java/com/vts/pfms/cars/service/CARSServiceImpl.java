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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

@Service
public class CARSServiceImpl implements CARSService{

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
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
	public long addCARSInitiation(CARSInitiation initiation,String labcode) throws Exception {
		
		long maxCARSInitiationId = dao.getMaxCARSInitiationId();
		LocalDate now = LocalDate.now();
		String CARSNo = labcode+"/CARS-"+(maxCARSInitiationId+1)+"/RAMD/"+now.getYear();
		initiation.setCARSNo(CARSNo);
		
		double amount = Double.parseDouble(initiation.getAmount())*100000;
		initiation.setAmount(String.valueOf(amount));
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
		double amount = Double.parseDouble(initiation.getAmount())*100000;
		initiation.setAmount(String.valueOf(amount));
		
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
				notification.setNotificationMessage("RSQR request approved");
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
					notification2.setEmpId(Long.parseLong(i==0?dpandc[0].toString():GHDPandC[0].toString()));
					notification2.setNotificationUrl("CARSRSQRApprovedList.htm");
					notification2.setNotificationMessage("RSQR request approved for<br>"+emp.getEmpName());
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
				notification.setNotificationMessage("RSQR forwarded by "+emp.getEmpName());
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
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"RSQR Request Returned":"RSQR Request Disapproved");
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
		
		String path = "CARS\\SoC\\";
		
		// To upload file path for SoO
		if (!sooFile.isEmpty()) {
			soc.setSoOUpload("SoO-" + timestampstr + "."
					+ FilenameUtils.getExtension(sooFile.getOriginalFilename()));
			saveFile(uploadpath + path, soc.getSoOUpload(), sooFile);
		} else {
			soc.setSoOUpload(null);
		}
		
		// To upload file path for Feasibility report
		if (!frFile.isEmpty()) {
			soc.setFRUpload("FR-" + timestampstr + "."
					+ FilenameUtils.getExtension(frFile.getOriginalFilename()));
			saveFile(uploadpath + path, soc.getFRUpload(), frFile);
		} else {
			soc.setFRUpload(null);
		}
		
		// To upload file path for Execution plan
		if (!executionPlan.isEmpty()) {
			soc.setExecutionPlan("ExePlan-" + timestampstr + "."
					+ FilenameUtils.getExtension(executionPlan.getOriginalFilename()));
			saveFile(uploadpath + path, soc.getExecutionPlan(), executionPlan);
		} else {
			soc.setExecutionPlan(null);
		}
		
		long carsSoCId = dao.addCARSSoC(soc);
	
		return carsSoCId;
	}

	@Override
	public long editCARSSoC(CARSSoC soc, MultipartFile sooFile, MultipartFile frFile, MultipartFile executionPlan) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
		String path = "CARS\\SoC\\";
		
		// To upload file path for SoO
		if (!sooFile.isEmpty()) {
			soc.setSoOUpload("SoO-" + timestampstr + "."
					+ FilenameUtils.getExtension(sooFile.getOriginalFilename()));
			saveFile(uploadpath + path, soc.getSoOUpload(), sooFile);
		}
		
		// To upload file path for Feasibility report
		if (!frFile.isEmpty()) {
			soc.setFRUpload("FR-" + timestampstr + "."
					+ FilenameUtils.getExtension(frFile.getOriginalFilename()));
			saveFile(uploadpath + path, soc.getFRUpload(), frFile);
		}
		
		// To upload file path for Execution plan
		if (!executionPlan.isEmpty()) {
			soc.setExecutionPlan("ExePlan-" + timestampstr + "."
					+ FilenameUtils.getExtension(executionPlan.getOriginalFilename()));
			saveFile(uploadpath + path, soc.getExecutionPlan(), executionPlan);
		}
	
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
			String filepath = "CARS\\RSQR";
			int count=0;
			while(new File(uploadpath+filepath+"\\"+fname+".pdf").exists())
			{
				fname = "RSQR-"+carsInitiationId;
				fname = fname+" ("+ ++count+")";
			}
	        
	        saveFile(uploadpath+filepath, fname+".pdf", file);
	        
	        dao.carsRSQRFreeze(carsInitiationId, filepath+"\\"+fname+".pdf");
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
			if(action.equalsIgnoreCase("A") && (cars.getCARSStatusCode().equalsIgnoreCase("SFG") || cars.getCARSStatusCode().equalsIgnoreCase("SFP"))) {
				notification.setEmpId(emp.getEmpId());
				notification.setNotificationUrl("CARSInitiationList.htm");
				notification.setNotificationMessage("SoC request approved");
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
				notification.setNotificationMessage("SoC forwarded by "+emp.getEmpName());
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
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"SoC Request Returned":"SoC Request Disapproved");
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
	public long carsUserRevoke(String carsInitiationId, String username, String empId, String carsStatusCode) throws Exception {
		
		long carsinitiationid = Long.parseLong(carsInitiationId);
		
		CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
		cars.setCARSStatusCode(carsStatusCode.equalsIgnoreCase("FWD")?"REV":"SRV");
		cars.setCARSStatusCodeNext(carsStatusCode);
		cars.setModifiedBy(username);
		cars.setModifiedDate(sdtf.format(new Date()));
		
		// Transactions.
		CARSInitiationTrans transaction = CARSInitiationTrans.builder()
										  .CARSInitiationId(carsinitiationid)
										  .CARSStatusCode(carsStatusCode.equalsIgnoreCase("FWD")?"REV":"SRV")
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
				mil.setPaymentPercentage(dto.getPaymentPercentage()[i]);
				mil.setPaymentTerms(dto.getPaymentTerms()[i]);
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
			String approverEmpId = dto.getApproverEmpId();
			String approvalDate = dto.getApprovalDate();

			CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
			long formempid = cars.getEmpId();
			Employee emp = dao.getEmpData(formempid+"");
			String fundsFrom = cars.getFundsFrom();
			String statusCode = cars.getCARSStatusCode();
			String statusCodeNext = cars.getCARSStatusCodeNext();
			Double amount = cars.getAmount()!=null?Double.parseDouble(cars.getAmount()):0.00;

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
											  .CARSStatusCode(cars.getCARSStatusCode())
											  .Remarks(remarks)
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
				notification.setNotificationMessage("SoC request approved");
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
				notification.setNotificationMessage("SoC forwarded by D-P&C "+GHDPandC[1].toString());
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
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"SoC Request Returned":"SoC Request Disapproved");
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
	public long carsSoCDPCRevoke(String carsInitiationId, String userId, String empId) throws Exception {
		
		long carsinitiationid = Long.parseLong(carsInitiationId);
		
		CARSInitiation cars = dao.getCARSInitiationById(carsinitiationid);
		cars.setCARSStatusCode("SRD");
		cars.setCARSStatusCodeNext("SFD");
		cars.setModifiedBy(userId);
		cars.setModifiedDate(sdtf.format(new Date()));
		
		// Transactions.
		CARSInitiationTrans transaction = CARSInitiationTrans.builder()
										  .CARSInitiationId(carsinitiationid)
										  .CARSStatusCode("SRD")
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
		
		String path = "CARS\\SoC\\";
		
		String momupload = null;
		// To upload file path for SoO
		if (!momFile.isEmpty()) {
			momupload = "MoM-" + timestampstr + "."+ FilenameUtils.getExtension(momFile.getOriginalFilename());
			saveFile(uploadpath + path, momupload, momFile);
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
					notification2.setNotificationMessage("MoM Uploaded for CARSNO "+carsIni.getCARSNo());
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
	
}
