package com.vts.pfms.projectclosure.service;

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
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.cars.dao.CARSDao;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.project.model.ProjectMaster;
import com.vts.pfms.project.model.ProjectMasterRev;
import com.vts.pfms.projectclosure.dao.ProjectClosureDao;
import com.vts.pfms.projectclosure.dto.ProjectClosureACPDTO;
import com.vts.pfms.projectclosure.dto.ProjectClosureApprovalForwardDTO;
import com.vts.pfms.projectclosure.model.ProjectClosureACP;
import com.vts.pfms.projectclosure.model.ProjectClosureACPAchievements;
import com.vts.pfms.projectclosure.model.ProjectClosureACPConsultancies;
import com.vts.pfms.projectclosure.model.ProjectClosureACPProjects;
import com.vts.pfms.projectclosure.model.ProjectClosureACPTrialResults;
import com.vts.pfms.projectclosure.model.ProjectClosureSoC;
import com.vts.pfms.projectclosure.model.ProjectClosureTrans;


@Service
public class ProjectClosureServiceImpl implements ProjectClosureService{

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	private static final Logger logger = LogManager.getLogger(ProjectClosureServiceImpl.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	
	@Autowired
	ProjectClosureDao dao;
	
	@Autowired
	CARSDao carsdao;

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
	public List<Object[]> projectClosureList(String EmpId, String labcode) throws Exception {
		
		return dao.projectClosureList(EmpId, labcode);
	}

	@Override
	public ProjectMaster getProjectMasterByProjectId(String projectId) throws Exception {
		
		return dao.getProjectMasterByProjectId(projectId);
	}

	@Override
	public ProjectClosureSoC getProjectClosureSoCByProjectId(String projectId) throws Exception {
		
		return dao.getProjectClosureSoCByProjectId(projectId);
	}

	@Override
	public long addProjectClosureSoC(ProjectClosureSoC soc, String EmpId, MultipartFile monitoringCommitteeAttach, MultipartFile lessonsLearnt) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
		String path = "Project-Closure\\SoC\\";
		
		// To upload file path for monitoringCommitteeAttach
		if (!monitoringCommitteeAttach.isEmpty()) {
			soc.setMonitoringCommitteeAttach("MinutesOfMeeting-" + timestampstr + "."
					+ FilenameUtils.getExtension(monitoringCommitteeAttach.getOriginalFilename()));
			saveFile(uploadpath + path, soc.getMonitoringCommitteeAttach(), monitoringCommitteeAttach);
		} else {
			soc.setMonitoringCommitteeAttach(null);
		}
		
		// To upload file path for monitoringCommitteeAttach
		if (!lessonsLearnt.isEmpty()) {
			soc.setLessonsLearnt("LessonsLearnt-" + timestampstr + "."
					+ FilenameUtils.getExtension(lessonsLearnt.getOriginalFilename()));
			saveFile(uploadpath + path, soc.getLessonsLearnt(), lessonsLearnt);
		} else {
			soc.setLessonsLearnt(null);
		}
		
		long closuresocid = dao.addProjectClosureSoC(soc);
		if(closuresocid!=0) {
			ProjectClosureTrans transaction = ProjectClosureTrans.builder()
											  .ProjectId(soc.getProjectId())
											  .ClosureForm("S")
											  .ClosureStatusCode("SIN")
											  .ActionBy(Long.parseLong(EmpId))
											  .ActionDate(sdtf.format(new Date()))
											  .build();
			dao.addProjectClosureTransaction(transaction);
		}
		return dao.addProjectClosureSoC(soc);
	}

	@Override
	public long editProjectClosureSoC(ProjectClosureSoC soc, MultipartFile monitoringCommitteeAttach, MultipartFile lessonsLearnt) throws Exception {
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
		String path = "Project-Closure\\SoC\\";
		
		// To upload file path for monitoringCommitteeAttach
		if (!monitoringCommitteeAttach.isEmpty()) {
			soc.setMonitoringCommitteeAttach("MinutesOfMeeting-" + timestampstr + "."
					+ FilenameUtils.getExtension(monitoringCommitteeAttach.getOriginalFilename()));
			saveFile(uploadpath + path, soc.getMonitoringCommitteeAttach(), monitoringCommitteeAttach);
		} 
		
		// To upload file path for monitoringCommitteeAttach
		if (!lessonsLearnt.isEmpty()) {
			soc.setLessonsLearnt("LessonsLearnt-" + timestampstr + "."
					+ FilenameUtils.getExtension(lessonsLearnt.getOriginalFilename()));
			saveFile(uploadpath + path, soc.getLessonsLearnt(), lessonsLearnt);
		} 
		
		return dao.editProjectClosureSoC(soc);
	}

	@Override
	public ProjectMasterRev getProjectMasterRevByProjectId(String projectId) throws Exception {
		
		return dao.getProjectMasterRevByProjectId(projectId);
	}

	@Override
	public List<Object[]> projectClosureApprovalDataByType(String projectId, String closureForward, String closureForm) throws Exception {
		
		return dao.projectClosureApprovalDataByType(projectId, closureForward, closureForm);
	}

	@Override
	public List<Object[]> projectClosureRemarksHistoryByType(String projectId, String closureForward, String closureForm) throws Exception {
		
		return dao.projectClosureRemarksHistoryByType(projectId, closureForward, closureForm);
	}

	@Override
	public Object[] getEmpGDDetails(String empId) throws Exception {
		
		return dao.getEmpGDDetails(empId);
	}

	@Override
	public long projectClosureSoCApprovalForward(ProjectClosureApprovalForwardDTO dto) throws Exception {
		try {
			long closureSoCId = dto.getClosureSoCId();
			String projectId = dto.getProjectId();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			String UserId = dto.getUserId();
			String remarks = dto.getRemarks();
			String labcode = dto.getLabcode();
			String approverEmpId = dto.getApproverEmpId();
			String approvalDate = dto.getApprovalDate();

			ProjectClosureSoC soc = dao.getProjectClosureSoCByProjectId(projectId);
			String statusCode = soc.getClosureStatusCode();
			String statusCodeNext = soc.getClosureStatusCodeNext();
			
			Object[] PD = carsdao.getEmpPDEmpId(projectId);
			Object[] GD = dao.getEmpGDDetails(PD!=null?PD[1].toString():"0");

			List<String> forwardstatus = Arrays.asList("SIN","SRG","SRA","SRP","SRD","SRC","SRV");

			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(forwardstatus.contains(statusCode)) {
					
					if(statusCode.equalsIgnoreCase("SIN")) {
						soc.setForwardedBy(PD!=null?PD[1].toString():"0");
						soc.setForwardedDate(sdf.format(new Date()));
					}
					
					soc.setClosureStatusCode("SFW");
					if(PD!=null && PD[1].toString().equalsIgnoreCase(GD!=null? GD[0].toString():"0")) {
						soc.setClosureStatusCodeNext("SAA");
					}
					else {
						soc.setClosureStatusCodeNext("SAG");
					}
					
				}else {
					soc.setClosureStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("SAG")) {
						soc.setClosureStatusCodeNext("SAA");
					}else if(statusCodeNext.equalsIgnoreCase("SAA")) {
						soc.setClosureStatusCodeNext("SAP");
					}else if(statusCodeNext.equalsIgnoreCase("SAP")) {
						soc.setClosureStatusCodeNext("SAD");
					}else if(statusCodeNext.equalsIgnoreCase("SAD")) {
						soc.setClosureStatusCodeNext("SAC");
					}else if(statusCodeNext.equalsIgnoreCase("SAC")) {
						soc.setClosureStatusCodeNext("SAC");
						soc.setClosureStatus("A");
					}
				}
				dao.editProjectClosureSoC(soc);
			}
			// This is for return the application form to the user
			else if(action.equalsIgnoreCase("R")) {
				// Setting StatusCode
				if(statusCodeNext.equalsIgnoreCase("SAG")) {
					soc.setClosureStatusCode("SRG");	
				}else if(statusCodeNext.equalsIgnoreCase("SAA")) {
					soc.setClosureStatusCode("SRA");	
				}else if(statusCodeNext.equalsIgnoreCase("SAP")) {
					soc.setClosureStatusCode("SRP");	
				}else if(statusCodeNext.equalsIgnoreCase("SAD")) {
					soc.setClosureStatusCode("SRD");	
				}else if(statusCodeNext.equalsIgnoreCase("SAC")) {
					soc.setClosureStatusCode("SRC");	
				}

				// Setting StatusCode Next
				soc.setClosureStatusCodeNext("SFW");

				dao.editProjectClosureSoC(soc);
			}

			// Transaction
			ProjectClosureTrans transaction = ProjectClosureTrans.builder()
											  .ProjectId(Long.parseLong(projectId))
											  .ClosureForm("S")
											  .ClosureStatusCode(soc.getClosureStatusCode())
											  .Remarks(remarks)
											  .ActionBy(Long.parseLong(approverEmpId!=null? approverEmpId:EmpId))
											  .ActionDate(approvalDate!=null?fc.RegularToSqlDate(approvalDate):sdtf.format(new Date()))
											  .build();
			dao.addProjectClosureTransaction(transaction);
			
			// Approval Authority Data to send notifications
			Object[] AD = carsdao.getApprAuthorityDataByType(labcode, "AD");
			Object[] GDDPandC = carsdao.getApprAuthorityDataByType(labcode, "DO-RTMD");
			Object[] Director = carsdao.getLabDirectorData(labcode);
			
			long PDEmpId = PD!=null?Long.parseLong(PD[1].toString()):0;
			// Notification
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A") && soc.getClosureStatus().equalsIgnoreCase("A") ) {
				notification.setEmpId(PDEmpId);
				notification.setNotificationUrl("ProjectClosureList.htm");
				notification.setNotificationMessage("Project Closure SoC request approved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				carsdao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("A")) {
				
				if(soc.getClosureStatusCodeNext().equalsIgnoreCase("SAG")) {
					notification.setEmpId(Long.parseLong(GD[0].toString()));
				}
				
				else if(soc.getClosureStatusCodeNext().equalsIgnoreCase("SAA")) {
					notification.setEmpId(Long.parseLong(AD[0].toString()));
				}
				else if(soc.getClosureStatusCodeNext().equalsIgnoreCase("SAP")) {
					notification.setEmpId(Long.parseLong(GDDPandC[0].toString()));
				}
				else if(soc.getClosureStatusCodeNext().equalsIgnoreCase("SAD")) {
					notification.setEmpId(Long.parseLong(Director[0].toString()));
				}
				else if(soc.getClosureStatusCodeNext().equalsIgnoreCase("SAC")) {
					notification.setEmpId(PDEmpId);
				}
				
				notification.setNotificationUrl("ProjectClosureApprovals.htm");
				notification.setNotificationMessage("Project Closure SoC forwarded by "+PD[2].toString());
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				carsdao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")){
				notification.setEmpId(PDEmpId);
				notification.setNotificationUrl("ProjectClosureList.htm");
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"Project Closure SoC Request Returned":"Project Closure SoC Request Disapproved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				carsdao.addNotifications(notification);
			}			
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureServiceImpl projectClosureSoCApprovalForward "+e);
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<Object[]> projectClosureSoCPendingList(String empId, String labcode) throws Exception {
		
		return dao.projectClosureSoCPendingList(empId, labcode);
	}

	@Override
	public List<Object[]> projectClosureSoCApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.projectClosureSoCApprovedList(empId, FromDate, ToDate);
	}

	@Override
	public List<Object[]> projectClosureTransListByType(String projectId, String closureStatusFor, String closureForm) throws Exception {
		
		return dao.projectClosureTransListByType(projectId, closureStatusFor, closureForm);
	}

	@Override
	public long projectClosureSoCRevoke(String projectId, String userId, String empId) throws Exception {
		
		try {
			ProjectClosureSoC soc = dao.getProjectClosureSoCByProjectId(projectId);
			soc.setClosureStatusCode("SRV");
			soc.setClosureStatusCodeNext("FWD");
			
			long closureSoCId = dao.editProjectClosureSoC(soc);
			if(closureSoCId!=0) {
				ProjectClosureTrans transaction = ProjectClosureTrans.builder()
						  						  .ProjectId(Long.parseLong(projectId))
						  						  .ClosureForm("S")
						  						  .ClosureStatusCode("SRV")
						  						  .ActionBy(Long.parseLong(empId))
						  						  .ActionDate(sdtf.format(new Date()))
						  						  .build();
				dao.addProjectClosureTransaction(transaction);
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureServiceImpl projectClosureSoCRevoke "+e);
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public ProjectClosureACP getProjectClosureACPByProjectId(String projectId) throws Exception {
		
		return dao.getProjectClosureACPByProjectId(projectId);
	}

	@Override
	public long addProjectClosureACP(ProjectClosureACP acp) throws Exception {
		
		return dao.addProjectClosureACP(acp);
	}

	@Override
	public long editProjectClosureACP(ProjectClosureACP acp) throws Exception {
		
		return dao.editProjectClosureACP(acp);
	}

	@Override
	public long projectClosureACPDetailsSubmit(ProjectClosureACPDTO dto, MultipartFile labCertificateAttach, MultipartFile monitoringCommitteeAttach) throws Exception {
		try {
			String UserId = dto.getUserId();
			String EmpId = dto.getEmpId();
			
			long projectId = dto.getProjectId();
			String details = dto.getDetails();


			ProjectClosureACP acp = dao.getProjectClosureACPByProjectId(projectId+"");
			String firstime = "N";
			if(acp==null) {
				firstime = "Y";
				acp = new ProjectClosureACP();
			}

			if(details.equalsIgnoreCase("aimobjectives")) {
				acp.setACPAim(dto.getACPAim());
				acp.setACPObjectives(dto.getACPObjectives());
			}
			else if(details.equalsIgnoreCase("facilitiescreated")) {
				acp.setFacilitiesCreated(dto.getFacilitiesCreated());
			}
			else if(details.equalsIgnoreCase("recommendations")) {
				acp.setMonitoringCommittee(dto.getMonitoringCommittee());

				Timestamp instant = Timestamp.from(Instant.now());
				String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

				String path = "Project-Closure\\ACP\\";

				// To upload file path for monitoringCommitteeAttach
				if (!monitoringCommitteeAttach.isEmpty()) {
					acp.setMonitoringCommitteeAttach("MinutesOfMeeting-" + timestampstr + "."
							+ FilenameUtils.getExtension(monitoringCommitteeAttach.getOriginalFilename()));
					saveFile(uploadpath + path, acp.getMonitoringCommitteeAttach(), monitoringCommitteeAttach);
				} 
			}
			else if(details.equalsIgnoreCase("trialresults")) {
				acp.setTrialResults(dto.getTrialResults());
			}
			else if(details.equalsIgnoreCase("others")) {

				String expndAsOn = dto.getExpndAsOn();
				String totalExpnd = dto.getTotalExpnd();
				String totalExpndFE = dto.getTotalExpndFE();

				acp.setExpndAsOn(fc.RegularToSqlDate(expndAsOn));
//				acp.setTotalExpnd(totalExpnd!=null?String.format("%.2f", Double.parseDouble(totalExpnd)*10000000 ):null );
//				acp.setTotalExpndFE(totalExpndFE!=null?String.format("%.2f", Double.parseDouble(totalExpndFE)*10000000 ):null );
				acp.setTotalExpnd(totalExpnd);
				acp.setTotalExpndFE(totalExpndFE);
				acp.setPrototyes(Integer.parseInt(dto.getPrototyes()));
				acp.setTechReportNo(dto.getTechReportNo());

				Timestamp instant = Timestamp.from(Instant.now());
				String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

				String path = "Project-Closure\\ACP\\";

				// To upload file path for Certificate from lab
				if (!labCertificateAttach.isEmpty()) {
					acp.setCertificateFromLab("Lab-Certificate-" + timestampstr + "."
							+ FilenameUtils.getExtension(labCertificateAttach.getOriginalFilename()));
					saveFile(uploadpath + path, acp.getCertificateFromLab(), labCertificateAttach);
				}
			}

			if(firstime.equalsIgnoreCase("Y")) {
				acp.setProjectId(projectId);
				acp.setACPStatus("N");
				acp.setClosureStatusCode("AIN");
				acp.setClosureStatusCodeNext("AIN");
				acp.setCreatedBy(UserId);
				acp.setCreatedDate(sdtf.format(new Date()));
				acp.setIsActive(1);
				long count = dao.addProjectClosureACP(acp);
				if(count!=0) {
					ProjectClosureTrans transaction = ProjectClosureTrans.builder()
							               			  .ProjectId(projectId)
							               			  .ClosureForm("A")
							               			  .ClosureStatusCode("AIN")
							               			  .ActionBy(Long.parseLong(EmpId))
							               			  .ActionDate(sdtf.format(new Date()))
							               			  .build();
					dao.addProjectClosureTransaction(transaction);
				}
			}else {
				acp.setModifiedBy(UserId);
				acp.setModifiedDate(sdtf.format(new Date()));
				dao.editProjectClosureACP(acp);
			}
			
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureServiceImpl projectClosureACPDetailsSubmit "+e);
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<ProjectClosureACPProjects> getProjectClosureACPProjectsByProjectId(String projectId) throws Exception {
		
		return dao.getProjectClosureACPProjectsByProjectId(projectId);
	}

	@Override
	public List<ProjectClosureACPConsultancies> getProjectClosureACPConsultanciesByProjectId(String projectId) throws Exception {
		
		return dao.getProjectClosureACPConsultanciesByProjectId(projectId);
	}

	@Override
	public List<ProjectClosureACPTrialResults> getProjectClosureACPTrialResultsByProjectId(String projectId) throws Exception {
		
		return dao.getProjectClosureACPTrialResultsByProjectId(projectId);
	}

	@Override
	public List<ProjectClosureACPAchievements> getProjectClosureACPAchievementsByProjectId(String projectId) throws Exception {
		
		return dao.getProjectClosureACPAchievementsByProjectId(projectId);
	}

	@Override
	public long addProjectClosureProjectDetailsSubmit(ProjectClosureACPDTO dto) throws Exception {
		try {
			long projectId = dto.getProjectId();
			String acpProjectTypeFlag = dto.getAcpProjectTypeFlag();
			//Removing previously added details
			dao.removeProjectClosureACPProjectDetailsByType(projectId, acpProjectTypeFlag);
			for(int i=0;i<dto.getACPProjectName().length;i++) {
				ProjectClosureACPProjects projects = ProjectClosureACPProjects.builder()
													 .ProjectId(projectId)
													 .ACPProjectType(acpProjectTypeFlag!=null && acpProjectTypeFlag.equalsIgnoreCase("S")?acpProjectTypeFlag: dto.getACPProjectType()[i])
													 .ACPProjectName(dto.getACPProjectName()[i])
													 .ACPProjectNo(dto.getACPProjectNo()[i])
													 .ProjectAgency(dto.getProjectAgency()[i])
													 .ProjectCost(dto.getProjectCost()[i])
													 .ProjectStatus(dto.getProjectStatus()[i])
													 .ProjectAchivements(dto.getProjectAchivements()[i])
													 .CreatedBy(dto.getUserId())
													 .CreatedDate(sdtf.format(new Date()))
													 .IsActive(1)
													 .build();
				dao.addProjectClosureACPProjects(projects);
				
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureServiceImpl addProjectClosureProjectDetailsSubmit "+e);
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public long addProjectClosureConsultancyDetailsSubmit(ProjectClosureACPDTO dto) throws Exception {
		try {
			long projectId = dto.getProjectId();
			//Removing previously added details
			dao.removeProjectClosureACPConsultancyDetails(projectId);
			
			for(int i=0;i<dto.getConsultancyAim().length;i++) {
				ProjectClosureACPConsultancies consultancy = ProjectClosureACPConsultancies.builder()
															 .ProjectId(projectId)
															 .ConsultancyAim(dto.getConsultancyAim()[i])
															 .ConsultancyAgency(dto.getConsultancyAgency()[i])
															 .ConsultancyCost(dto.getConsultancyCost()[i])
															 .ConsultancyDate(fc.RegularToSqlDate(dto.getConsultancyDate()[i]))
															 .CreatedBy(dto.getUserId())
															 .CreatedDate(sdtf.format(new Date()))
															 .IsActive(1)
															 .build();
				dao.addProjectClosureACPConsultancies(consultancy);
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureServiceImpl addProjectClosureConsultancyDetailsSubmit "+e);
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public long projectClosureACPTrialResultsSubmit(ProjectClosureACPDTO dto) throws Exception {
		try {
			long projectId = dto.getProjectId();
			//Removing previously added details
			dao.removeProjectClosureACPTrialResultsDetails(projectId);
			for(int i=0;i<dto.getAttachment().length ;i++) {
				ProjectClosureACPTrialResults results = new ProjectClosureACPTrialResults();
				
				results.setProjectId(projectId);
				results.setDescription(dto.getDescription()[i]);
				
				Timestamp instant = Timestamp.from(Instant.now());
				String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

				String path = "Project-Closure\\ACP\\Trial-Results\\";

				// To upload file path for monitoringCommitteeAttach
				if (!dto.getAttachment()[i].isEmpty()) {
					results.setAttachment("TrialResult-" + timestampstr + "."
							+ FilenameUtils.getExtension(dto.getAttachment()[i].getOriginalFilename()));
					saveFile(uploadpath + path, results.getAttachment(), dto.getAttachment()[i]);
				}else {
					results.setAttachment(dto.getAttatchmentName()[i]);
				}
				
				results.setCreatedBy(dto.getUserId());
				results.setCreatedDate(sdtf.format(new Date()));
				results.setIsActive(1);
				
				dao.addProjectClosureACPTrialResults(results);
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureServiceImpl projectClosureACPTrialResultsSubmit "+e);
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public ProjectClosureACPTrialResults getProjectClosureACPTrialResultsById(String trialResultId) throws Exception {
		
		return dao.getProjectClosureACPTrialResultsById(trialResultId);
	}

	@Override
	public long projectClosureACPAchievementDetailsSubmit(ProjectClosureACPDTO dto) throws Exception {
		try {
			long projectId = dto.getProjectId();
			//Removing previously added details
			dao.removeProjectClosureACPAchievementDetails(projectId);
			
			for(int i=0;i<dto.getEnvisaged().length ;i++) {
				ProjectClosureACPAchievements achivements = ProjectClosureACPAchievements.builder()
														   .ProjectId(projectId)
														   .Envisaged(dto.getEnvisaged()[i])
														   .Achieved(dto.getAchieved()[i])
														   .Remarks(dto.getRemarks()[i])
														   .CreatedBy(dto.getUserId())
														   .CreatedDate(sdtf.format(new Date()))
														   .IsActive(1)
														   .build();
				dao.addProjectClosureACPAchievements(achivements);
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureServiceImpl projectClosureACPAchievementDetailsSubmit "+e);
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public long projectClosureACPApprovalForward(ProjectClosureApprovalForwardDTO dto) throws Exception {
		try {
			String projectId = dto.getProjectId();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			String UserId = dto.getUserId();
			String remarks = dto.getRemarks();
			String labcode = dto.getLabcode();
			String approverEmpId = dto.getApproverEmpId();
			String approvalDate = dto.getApprovalDate();

			ProjectMaster pm = dao.getProjectMasterByProjectId(projectId);
			int isMain = pm.getIsMainWC();
			Double sanctionCost = pm.getTotalSanctionCost();
			
			ProjectClosureACP acp = dao.getProjectClosureACPByProjectId(projectId);
			String statusCode = acp.getClosureStatusCode();
			String statusCodeNext = acp.getClosureStatusCodeNext();
			
			Object[] PD = carsdao.getEmpPDEmpId(projectId);
			Object[] GD = dao.getEmpGDDetails(PD!=null?PD[1].toString():"0");

			List<String> forwardstatus = Arrays.asList("AIN","ARG","ARA","ARP","ARL","ARD","ARO","ARN","ARC","ARV");

			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(forwardstatus.contains(statusCode)) {
					
					if(statusCode.equalsIgnoreCase("AIN")) {
						acp.setForwardedBy(PD!=null?PD[1].toString():"0");
						acp.setForwardedDate(sdf.format(new Date()));
					}
					
					acp.setClosureStatusCode("AFW");
					if(PD!=null && PD[1].toString().equalsIgnoreCase(GD!=null? GD[0].toString():"0")) {
						acp.setClosureStatusCodeNext("AAA");
					}
					else {
						acp.setClosureStatusCodeNext("AAG");
					}
					
				}else {
					acp.setClosureStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("AAG")) {
						acp.setClosureStatusCodeNext("AAA");
					}
					else if(statusCodeNext.equalsIgnoreCase("AAA")) {
						acp.setClosureStatusCodeNext("AAP");
					}
					else if(statusCodeNext.equalsIgnoreCase("AAP")) {
						acp.setClosureStatusCodeNext("AAL");
					}
					else if(statusCodeNext.equalsIgnoreCase("AAL")) {
						acp.setClosureStatusCodeNext("AAD");
					}
					else if(statusCodeNext.equalsIgnoreCase("AAD")) {
						if(isMain!=0 && sanctionCost<=10000000) {
							acp.setClosureStatusCodeNext("AAD");
							acp.setACPStatus("A");
						}else if(isMain!=0 && (sanctionCost>10000000 && sanctionCost<=750000000)) {
							acp.setClosureStatusCodeNext("AAC");
						}else {
							acp.setClosureStatusCodeNext("AAO");
						}
						
					}
					else if(statusCodeNext.equalsIgnoreCase("AAO")) {
						if(isMain==0 && sanctionCost>750000000) {
							acp.setClosureStatusCodeNext("AAN");
						}else {
							acp.setClosureStatusCodeNext("AAC");
						}
						
					}
					else if(statusCodeNext.equalsIgnoreCase("AAN")) {
						acp.setClosureStatusCodeNext("AAC");
					}
					else if(statusCodeNext.equalsIgnoreCase("AAC")) {
						acp.setClosureStatusCodeNext("AAC");
						acp.setACPStatus("A");
					}
				}
				dao.editProjectClosureACP(acp);
			}
			// This is for return the application form to the user
			else if(action.equalsIgnoreCase("R")) {
				// Setting StatusCode
				if(statusCodeNext.equalsIgnoreCase("AAG")) {
					acp.setClosureStatusCode("ARG");	
				}else if(statusCodeNext.equalsIgnoreCase("AAA")) {
					acp.setClosureStatusCode("ARA");	
				}else if(statusCodeNext.equalsIgnoreCase("AAP")) {
					acp.setClosureStatusCode("ARP");	
				}else if(statusCodeNext.equalsIgnoreCase("AAL")) {
					acp.setClosureStatusCode("ARL");	
				}else if(statusCodeNext.equalsIgnoreCase("AAD")) {
					acp.setClosureStatusCode("ARD");	
				}else if(statusCodeNext.equalsIgnoreCase("AAO")) {
					acp.setClosureStatusCode("ARO");	
				}else if(statusCodeNext.equalsIgnoreCase("AAN")) {
					acp.setClosureStatusCode("ARN");	
				}else if(statusCodeNext.equalsIgnoreCase("AAC")) {
					acp.setClosureStatusCode("ARC");	
				}

				// Setting StatusCode Next
				acp.setClosureStatusCodeNext("AFW");

				dao.editProjectClosureACP(acp);
			}

			// Transaction
			ProjectClosureTrans transaction = ProjectClosureTrans.builder()
											  .ProjectId(Long.parseLong(projectId))
											  .ClosureForm("A")
											  .ClosureStatusCode(acp.getClosureStatusCode())
											  .Remarks(remarks)
											  .ActionBy(Long.parseLong(approverEmpId!=null? approverEmpId:EmpId))
											  .ActionDate(approvalDate!=null?fc.RegularToSqlDate(approvalDate):sdtf.format(new Date()))
											  .build();
			dao.addProjectClosureTransaction(transaction);
			
			// Approval Authority Data to send notifications
			Object[] AD = carsdao.getApprAuthorityDataByType(labcode, "AD");
			Object[] GDDPandC = carsdao.getApprAuthorityDataByType(labcode, "DO-RTMD");
			Object[] LAO = carsdao.getApprAuthorityDataByType(labcode, "Lab Accounts Officer");
			Object[] Director = carsdao.getLabDirectorData(labcode);
			
			List<String> apporvenextstatus = Arrays.asList("AAO","AAN","AAC");
			
			long PDEmpId = PD!=null?Long.parseLong(PD[1].toString()):0;
			// Notification
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A") && acp.getACPStatus().equalsIgnoreCase("A") ) {
				notification.setEmpId(PDEmpId);
				notification.setNotificationUrl("ProjectClosureList.htm");
				notification.setNotificationMessage("Administrative Closure request approved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				carsdao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("A")) {
				
				if(acp.getClosureStatusCodeNext().equalsIgnoreCase("AAG")) {
					notification.setEmpId(Long.parseLong(GD[0].toString()));
				}
				else if(acp.getClosureStatusCodeNext().equalsIgnoreCase("AAA")) {
					notification.setEmpId(Long.parseLong(AD[0].toString()));
				}
				else if(acp.getClosureStatusCodeNext().equalsIgnoreCase("AAP")) {
					notification.setEmpId(Long.parseLong(GDDPandC[0].toString()));
				}
				else if(acp.getClosureStatusCodeNext().equalsIgnoreCase("AAL")) {
					notification.setEmpId(Long.parseLong(LAO[0].toString()));
				}
				else if(acp.getClosureStatusCodeNext().equalsIgnoreCase("AAD")) {
					notification.setEmpId(Long.parseLong(Director[0].toString()));
				}
				else if(apporvenextstatus.contains(acp.getClosureStatusCodeNext())) {
					notification.setEmpId(PDEmpId);
				}
				
				notification.setNotificationUrl("ProjectClosureApprovals.htm");
				notification.setNotificationMessage("Administrative Closure forwarded by "+PD[2].toString());
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				carsdao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("R") || action.equalsIgnoreCase("D")){
				notification.setEmpId(PDEmpId);
				notification.setNotificationUrl("ProjectClosureList.htm");
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"Administrative Closure Request Returned":"Administrative Closure Request Disapproved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				carsdao.addNotifications(notification);
			}			
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureServiceImpl projectClosureACPApprovalForward "+e);
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public List<Object[]> projectClosureACPPendingList(String empId, String labcode) throws Exception {
		
		return dao.projectClosureACPPendingList(empId, labcode);
	}

	@Override
	public List<Object[]> projectClosureACPApprovedList(String empId, String FromDate, String ToDate) throws Exception {
		
		return dao.projectClosureACPApprovedList(empId, FromDate, ToDate);
	}

	@Override
	public Object[] projectOriginalAndRevisionDetails(String projectId) throws Exception {
		
		return dao.projectOriginalAndRevisionDetails(projectId);
	}
	
}
