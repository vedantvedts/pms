package com.vts.pfms.projectclosure.service;

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
import java.util.Date;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.project.dao.ProjectDao;
import com.vts.pfms.project.model.ProjectMaster;
import com.vts.pfms.project.model.ProjectMasterRev;
import com.vts.pfms.projectclosure.dao.ProjectClosureDao;
import com.vts.pfms.projectclosure.dto.ProjectCheckListRevDto;
import com.vts.pfms.projectclosure.dto.ProjectClosureACPDTO;
import com.vts.pfms.projectclosure.dto.ProjectClosureAppendixDto;
import com.vts.pfms.projectclosure.dto.ProjectClosureApprovalForwardDTO;

import com.vts.pfms.projectclosure.model.ProjectClosure;
import com.vts.pfms.projectclosure.model.ProjectClosureACP;
import com.vts.pfms.projectclosure.model.ProjectClosureACPAchievements;
import com.vts.pfms.projectclosure.model.ProjectClosureACPConsultancies;
import com.vts.pfms.projectclosure.model.ProjectClosureACPProjects;
import com.vts.pfms.projectclosure.model.ProjectClosureACPTrialResults;
import com.vts.pfms.projectclosure.model.ProjectClosureCheckList;
import com.vts.pfms.projectclosure.model.ProjectClosureCheckListRev;
import com.vts.pfms.projectclosure.model.ProjectClosureSoC;
import com.vts.pfms.projectclosure.model.ProjectClosureTechnical;
import com.vts.pfms.projectclosure.model.ProjectClosureTechnicalAppendices;
import com.vts.pfms.projectclosure.model.ProjectClosureTechnicalChapters;
import com.vts.pfms.projectclosure.model.ProjectClosureTechnicalDocDistrib;
import com.vts.pfms.projectclosure.model.ProjectClosureTechnicalDocSumary;
import com.vts.pfms.projectclosure.model.ProjectClosureTechnicalSection;
import com.vts.pfms.projectclosure.model.ProjectClosureTrans;
import com.vts.pfms.utils.PMSLogoUtil;


@Service
public class ProjectClosureServiceImpl implements ProjectClosureService{

	@Value("${ApplicationFilesDrive}")
	String uploadpath;
	
	private static final Logger logger = LogManager.getLogger(ProjectClosureServiceImpl.class);
	
	FormatConverter fc = new FormatConverter();
	private SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
	private SimpleDateFormat sdf = fc.getSqlDateFormat();
	private SimpleDateFormat rdf=new SimpleDateFormat("dd-MM-yyyy");
	
	@Autowired
	ProjectClosureDao dao;
	
	@Autowired
	CARSDao carsdao;
	
	@Autowired
	ProjectDao projectdao;

	@Autowired
	PMSLogoUtil LogoUtil;
	
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
	public List<Object[]> projectClosureList(String EmpId, String labcode, String LoginType) throws Exception {
		
		return dao.projectClosureList(EmpId, labcode, LoginType);
	}

	@Override
	public ProjectMaster getProjectMasterByProjectId(String projectId) throws Exception {
		
		return dao.getProjectMasterByProjectId(projectId);
	}

	@Override
	public ProjectClosure getProjectClosureById(String closureId) throws Exception {
		
		return dao.getProjectClosureById(closureId);
	}
	
	@Override
	public long addProjectClosure(ProjectClosure closure, String empId, String labcode) throws Exception {
		
		long result = dao.addProjectClosure(closure);
		ProjectClosureTrans transaction = ProjectClosureTrans.builder()
				  						  .ClosureId(result)
				  						  .ClosureForm(closure.getApprovalFor().equalsIgnoreCase("SoC")?"S":"A")
				  						  .ClosureStatusCode(closure.getClosureStatusCode())
				  						  .LabCode(labcode)
				  						  .ActionBy(Long.parseLong(empId))
				  						  .ActionDate(sdtf.format(new Date()))
				  						  .build();
		dao.addProjectClosureTransaction(transaction);
		return result;
	}

	@Override
	public long editProjectClosure(ProjectClosure closure) throws Exception {
		
		return dao.editProjectClosure(closure);
	}
	
	@Override
	public ProjectClosureSoC getProjectClosureSoCByProjectId(String projectId) throws Exception {
		
		return dao.getProjectClosureSoCByProjectId(projectId);
	}

	@Override
	public long addProjectClosureSoC(ProjectClosureSoC soc, String EmpId, MultipartFile monitoringCommitteeAttach, MultipartFile lessonsLearnt) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "Project-Closure\\SoC\\";
		Path closurePath = Paths.get(uploadpath, "Project-Closure", "SoC");
		
		// To upload file path for monitoringCommitteeAttach
		if (!monitoringCommitteeAttach.isEmpty()) {
			soc.setMonitoringCommitteeAttach("MinutesOfMeeting-" + timestampstr + "."
					+ FilenameUtils.getExtension(monitoringCommitteeAttach.getOriginalFilename()));
			saveFile1(closurePath, soc.getMonitoringCommitteeAttach(), monitoringCommitteeAttach);
		} else {
			soc.setMonitoringCommitteeAttach(null);
		}
		
		// To upload file path for monitoringCommitteeAttach
		if (!lessonsLearnt.isEmpty()) {
			soc.setLessonsLearnt("LessonsLearnt-" + timestampstr + "."
					+ FilenameUtils.getExtension(lessonsLearnt.getOriginalFilename()));
			saveFile1(closurePath, soc.getLessonsLearnt(), lessonsLearnt);
		} else {
			soc.setLessonsLearnt(null);
		}
		
//		long closuresocid = dao.addProjectClosureSoC(soc);
//		if(closuresocid!=0) {
//			ProjectClosureTrans transaction = ProjectClosureTrans.builder()
//											  .ClosureId(soc.getClosureId())
//											  .ClosureForm("S")
//											  .ClosureStatusCode("SIN")
//											  .ActionBy(Long.parseLong(EmpId))
//											  .ActionDate(sdtf.format(new Date()))
//											  .build();
//			dao.addProjectClosureTransaction(transaction);
//		}
		return dao.addProjectClosureSoC(soc);
	}

	@Override
	public long editProjectClosureSoC(ProjectClosureSoC soc, MultipartFile monitoringCommitteeAttach, MultipartFile lessonsLearnt) throws Exception {
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "Project-Closure\\SoC\\";
		Path closurePath = Paths.get(uploadpath, "Project-Closure", "SoC");
		
		// To upload file path for monitoringCommitteeAttach
		if (!monitoringCommitteeAttach.isEmpty()) {
			soc.setMonitoringCommitteeAttach("MinutesOfMeeting-" + timestampstr + "."
					+ FilenameUtils.getExtension(monitoringCommitteeAttach.getOriginalFilename()));
			saveFile1(closurePath, soc.getMonitoringCommitteeAttach(), monitoringCommitteeAttach);
		} 
		
		// To upload file path for monitoringCommitteeAttach
		if (!lessonsLearnt.isEmpty()) {
			soc.setLessonsLearnt("LessonsLearnt-" + timestampstr + "."
					+ FilenameUtils.getExtension(lessonsLearnt.getOriginalFilename()));
			saveFile1(closurePath, soc.getLessonsLearnt(), lessonsLearnt);
		} 
		
		return dao.editProjectClosureSoC(soc);
	}

	@Override
	public List<Object[]> projectClosureApprovalDataByType(String closureId, String closureForward, String closureForm) throws Exception {
		
		return dao.projectClosureApprovalDataByType(closureId, closureForward, closureForm);
	}

	@Override
	public List<Object[]> projectClosureRemarksHistoryByType(String closureId, String closureForward, String closureForm) throws Exception {
		
		return dao.projectClosureRemarksHistoryByType(closureId, closureForward, closureForm);
	}

	@Override
	public Object[] getEmpGDDetails(String empId) throws Exception {
		
		return dao.getEmpGDDetails(empId);
	}

	@Override
	public long projectClosureSoCApprovalForward(ProjectClosureApprovalForwardDTO dto) throws Exception {
		try {
//			long closureSoCId = dto.getClosureSoCId();
			String closureId = dto.getClosureId();
//			String projectId = dto.getProjectId();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			String UserId = dto.getUserId();
			String remarks = dto.getRemarks();
			String labcode = dto.getLabcode();
			String approverLabCode = dto.getApproverLabCode();
			String approverEmpId = dto.getApproverEmpId();
			String approvalDate = dto.getApprovalDate();

			ProjectClosure closure = dao.getProjectClosureById(closureId);
			String projectId = closure.getProjectId()+"";
			String statusCode = closure.getClosureStatusCode();
			String statusCodeNext = closure.getClosureStatusCodeNext();
			
			Object[] PD = carsdao.getEmpPDEmpId(projectId);
			Object[] GD = dao.getEmpGDDetails(PD!=null?PD[1].toString():"0");

			List<String> forwardstatus = Arrays.asList("SIN","SRG","SRA","SRP","SRD","SRC","SRV");

			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(forwardstatus.contains(statusCode)) {
					
					if(statusCode.equalsIgnoreCase("SIN")) {
						closure.setForwardedBy(PD!=null?PD[1].toString():"0");
						closure.setForwardedDate(sdf.format(new Date()));
					}
					
					closure.setClosureStatusCode("SFW");
					if(PD!=null && PD[1].toString().equalsIgnoreCase(GD!=null? GD[0].toString():"0")) {
						closure.setClosureStatusCodeNext("SAA");
					}
					else {
						closure.setClosureStatusCodeNext("SAG");
					}
					
				}else {
					closure.setClosureStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("SAG")) {
						closure.setClosureStatusCodeNext("SAA");
					}else if(statusCodeNext.equalsIgnoreCase("SAA")) {
						closure.setClosureStatusCodeNext("SAP");
					}else if(statusCodeNext.equalsIgnoreCase("SAP")) {
						closure.setClosureStatusCodeNext("SAD");
					}else if(statusCodeNext.equalsIgnoreCase("SAD")) {
						closure.setClosureStatusCodeNext("SAC");
					}else if(statusCodeNext.equalsIgnoreCase("SAC")) {
						closure.setClosureStatusCodeNext("SAC");
						closure.setApprStatus("A");
					}
				}
				dao.editProjectClosure(closure);
			}
			// This is for return the application form to the user
			else if(action.equalsIgnoreCase("R")) {
				// Setting StatusCode
				if(statusCodeNext.equalsIgnoreCase("SAG")) {
					closure.setClosureStatusCode("SRG");	
				}else if(statusCodeNext.equalsIgnoreCase("SAA")) {
					closure.setClosureStatusCode("SRA");	
				}else if(statusCodeNext.equalsIgnoreCase("SAP")) {
					closure.setClosureStatusCode("SRP");	
				}else if(statusCodeNext.equalsIgnoreCase("SAD")) {
					closure.setClosureStatusCode("SRD");	
				}else if(statusCodeNext.equalsIgnoreCase("SAC")) {
					closure.setClosureStatusCode("SRC");	
				}

				// Setting StatusCode Next
				closure.setClosureStatusCodeNext("SFW");

				dao.editProjectClosure(closure);
			}

			// Transaction
			ProjectClosureTrans transaction = ProjectClosureTrans.builder()
											  .ClosureId(Long.parseLong(closureId))
											  .ClosureForm("S")
											  .ClosureStatusCode(closure.getClosureStatusCode())
											  .Remarks(remarks)
											  .LabCode(approverLabCode!=null?approverLabCode:labcode)
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
			if(action.equalsIgnoreCase("A") && closure.getApprStatus().equalsIgnoreCase("A") ) {
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
				
				if(closure.getClosureStatusCodeNext().equalsIgnoreCase("SAG")) {
					notification.setEmpId(Long.parseLong(GD[0].toString()));
				}
				
				else if(closure.getClosureStatusCodeNext().equalsIgnoreCase("SAA")) {
					notification.setEmpId(Long.parseLong(AD[0].toString()));
				}
				else if(closure.getClosureStatusCodeNext().equalsIgnoreCase("SAP")) {
					notification.setEmpId(Long.parseLong(GDDPandC[0].toString()));
				}
				else if(closure.getClosureStatusCodeNext().equalsIgnoreCase("SAD")) {
					notification.setEmpId(Long.parseLong(Director[0].toString()));
				}
				else if(closure.getClosureStatusCodeNext().equalsIgnoreCase("SAC")) {
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
	public List<Object[]> projectClosureTransListByType(String closureId, String closureStatusFor, String closureForm) throws Exception {
		
		return dao.projectClosureTransListByType(closureId, closureStatusFor, closureForm);
	}

	@Override
	public long projectClosureSoCRevoke(String closureId, String userId, String empId, String labcode) throws Exception {
		
		try {
			ProjectClosure closure = dao.getProjectClosureById(closureId);
			closure.setClosureStatusCode("SRV");
			closure.setClosureStatusCodeNext("SFW");
			
			long result = dao.editProjectClosure(closure);
			if(result!=0) {
				ProjectClosureTrans transaction = ProjectClosureTrans.builder()
						  						  .ClosureId(result)
						  						  .ClosureForm("S")
						  						  .ClosureStatusCode("SRV")
						  						  .LabCode(labcode)
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
	public ProjectClosureACP getProjectClosureACPByProjectId(String closureId) throws Exception {
		
		return dao.getProjectClosureACPByProjectId(closureId);
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
			
			long closureId = dto.getClosureId();
			String details = dto.getDetails();

			Path closurePath = Paths.get(uploadpath, "Project-Closure", "ACP");
			ProjectClosureACP acp = dao.getProjectClosureACPByProjectId(closureId+"");
			String firstime = "N";
			if(acp==null) {
				firstime = "Y";
				acp = new ProjectClosureACP();
			}


			if(details.equalsIgnoreCase("facilitiescreated")) {
				acp.setFacilitiesCreated(dto.getFacilitiesCreated());
			}
			else if(details.equalsIgnoreCase("recommendations")) {
				acp.setMonitoringCommittee(dto.getMonitoringCommittee());

				Timestamp instant = Timestamp.from(Instant.now());
				String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

//				String path = "Project-Closure\\ACP\\";

				// To upload file path for monitoringCommitteeAttach
				if (!monitoringCommitteeAttach.isEmpty()) {
					acp.setMonitoringCommitteeAttach("MinutesOfMeeting-" + timestampstr + "."
							+ FilenameUtils.getExtension(monitoringCommitteeAttach.getOriginalFilename()));
					saveFile1(closurePath, acp.getMonitoringCommitteeAttach(), monitoringCommitteeAttach);
				} 
			}
			else if(details.equalsIgnoreCase("trialresults")) {
				acp.setTrialResults(dto.getTrialResults());
			}
			else if(details.equalsIgnoreCase("others")) {

				acp.setPrototyes(Integer.parseInt(dto.getPrototyes()));
				acp.setTechReportNo(dto.getTechReportNo());

				Timestamp instant = Timestamp.from(Instant.now());
				String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

//				String path = "Project-Closure\\ACP\\";

				// To upload file path for Certificate from lab
				if (!labCertificateAttach.isEmpty()) {
					acp.setCertificateFromLab("Lab-Certificate-" + timestampstr + "."
							+ FilenameUtils.getExtension(labCertificateAttach.getOriginalFilename()));
					saveFile1(closurePath, acp.getCertificateFromLab(), labCertificateAttach);
				}
			}

			if(firstime.equalsIgnoreCase("Y")) {
				acp.setClosureId(closureId);
				acp.setCreatedBy(UserId);
				acp.setCreatedDate(sdtf.format(new Date()));
				acp.setIsActive(1);
				long count = dao.addProjectClosureACP(acp);
//				if(count!=0) {
//					ProjectClosureTrans transaction = ProjectClosureTrans.builder()
//							               			  .ClosureId(closureId)
//							               			  .ClosureForm("A")
//							               			  .ClosureStatusCode("AIN")
//							               			  .ActionBy(Long.parseLong(EmpId))
//							               			  .ActionDate(sdtf.format(new Date()))
//							               			  .build();
//					dao.addProjectClosureTransaction(transaction);
//				}
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
	public List<ProjectClosureACPProjects> getProjectClosureACPProjectsByProjectId(String closureId) throws Exception {
		
		return dao.getProjectClosureACPProjectsByProjectId(closureId);
	}

	@Override
	public List<ProjectClosureACPConsultancies> getProjectClosureACPConsultanciesByProjectId(String closureId) throws Exception {
		
		return dao.getProjectClosureACPConsultanciesByProjectId(closureId);
	}

	@Override
	public List<ProjectClosureACPTrialResults> getProjectClosureACPTrialResultsByProjectId(String closureId) throws Exception {
		
		return dao.getProjectClosureACPTrialResultsByProjectId(closureId);
	}

	@Override
	public List<ProjectClosureACPAchievements> getProjectClosureACPAchievementsByProjectId(String closureId) throws Exception {
		
		return dao.getProjectClosureACPAchievementsByProjectId(closureId);
	}

	@Override
	public long addProjectClosureProjectDetailsSubmit(ProjectClosureACPDTO dto) throws Exception {
		try {
			long closureId = dto.getClosureId();
			String acpProjectTypeFlag = dto.getAcpProjectTypeFlag();
			//Removing previously added details
			dao.removeProjectClosureACPProjectDetailsByType(closureId, acpProjectTypeFlag);
			for(int i=0;i<dto.getACPProjectName().length;i++) {
				ProjectClosureACPProjects projects = ProjectClosureACPProjects.builder()
													 .ClosureId(closureId)
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
			long closureId = dto.getClosureId();
			//Removing previously added details
			dao.removeProjectClosureACPConsultancyDetails(closureId);
			
			for(int i=0;i<dto.getConsultancyAim().length;i++) {
				ProjectClosureACPConsultancies consultancy = ProjectClosureACPConsultancies.builder()
															 .ClosureId(closureId)
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
			long closureId = dto.getClosureId();
			//Removing previously added details
			dao.removeProjectClosureACPTrialResultsDetails(closureId);
			for(int i=0;i<dto.getAttachment().length ;i++) {
				ProjectClosureACPTrialResults results = new ProjectClosureACPTrialResults();
				
				results.setClosureId(closureId);
				results.setDescription(dto.getDescription()[i]);
				
				Timestamp instant = Timestamp.from(Instant.now());
				String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

//				String path = "Project-Closure\\TPCR\\Appendices\\";
				Path closurePath = Paths.get(uploadpath, "Project-Closure", "ACP", "Trial-Results");

				// To upload file path for monitoringCommitteeAttach
				if (!dto.getAttachment()[i].isEmpty()) {
					results.setAttachment("TrialResult-" + timestampstr + "."
							+ FilenameUtils.getExtension(dto.getAttachment()[i].getOriginalFilename()));
					saveFile1(closurePath, results.getAttachment(), dto.getAttachment()[i]);
				}else {
					results.setAttachment(dto.getAttatchmentName()!=null?dto.getAttatchmentName()[i]:null);
				}
				
				results.setCreatedBy(dto.getUserId());
				results.setCreatedDate(sdtf.format(new Date()));
				results.setIsActive(1);
				
				if(results.getAttachment()!=null && !results.getAttachment().isEmpty()) {
					dao.addProjectClosureACPTrialResults(results);
				}
				
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
			long closureId = dto.getClosureId();
			//Removing previously added details
			dao.removeProjectClosureACPAchievementDetails(closureId);
			
			for(int i=0;i<dto.getEnvisaged().length ;i++) {
				ProjectClosureACPAchievements achivements = ProjectClosureACPAchievements.builder()
														   .ClosureId(closureId)
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
//			String projectId = dto.getProjectId();
			String closureId = dto.getClosureId();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			String UserId = dto.getUserId();
			String remarks = dto.getRemarks();
			String labcode = dto.getLabcode();
			String approverLabCode = dto.getApproverLabCode();
			String approverEmpId = dto.getApproverEmpId();
			String approvalDate = dto.getApprovalDate();

			ProjectClosure closure = dao.getProjectClosureById(closureId);
			String projectId = closure.getProjectId()+"";
			String statusCode = closure.getClosureStatusCode();
			String statusCodeNext = closure.getClosureStatusCodeNext();
			
			ProjectMaster pm = dao.getProjectMasterByProjectId(projectId);
			int isMain = pm.getIsMainWC();
			Double sanctionCost = pm.getTotalSanctionCost();
			
			
			Object[] PD = carsdao.getEmpPDEmpId(projectId);
			Object[] GD = dao.getEmpGDDetails(PD!=null?PD[1].toString():"0");

			List<String> forwardstatus = Arrays.asList("AIN","ARG","ARA","ARP","ARL","ARD","ARO","ARN","ARC","ARV");

			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(forwardstatus.contains(statusCode)) {
					
					if(statusCode.equalsIgnoreCase("AIN")) {
						closure.setForwardedBy(PD!=null?PD[1].toString():"0");
						closure.setForwardedDate(sdf.format(new Date()));
					}
					
					closure.setClosureStatusCode("AFW");
					if(PD!=null && PD[1].toString().equalsIgnoreCase(GD!=null? GD[0].toString():"0")) {
						closure.setClosureStatusCodeNext("AAA");
					}
					else {
						closure.setClosureStatusCodeNext("AAG");
					}
					
				}else {
					closure.setClosureStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("AAG")) {
						closure.setClosureStatusCodeNext("AAA");
					}
					else if(statusCodeNext.equalsIgnoreCase("AAA")) {
						closure.setClosureStatusCodeNext("AAP");
					}
					else if(statusCodeNext.equalsIgnoreCase("AAP")) {
						closure.setClosureStatusCodeNext("AAL");
					}
					else if(statusCodeNext.equalsIgnoreCase("AAL")) {
						closure.setClosureStatusCodeNext("AAD");
					}
					else if(statusCodeNext.equalsIgnoreCase("AAD")) {
						if(isMain!=0 && sanctionCost<=10000000) {
							closure.setClosureStatusCodeNext("AAD");
							closure.setApprStatus("A");
						}else if(isMain!=0 && (sanctionCost>10000000 && sanctionCost<=750000000)) {
							closure.setClosureStatusCodeNext("AAC");
						}else {
							closure.setClosureStatusCodeNext("AAO");
						}
						
					}
					else if(statusCodeNext.equalsIgnoreCase("AAO")) {
						if(isMain==0 && sanctionCost>750000000) {
							closure.setClosureStatusCodeNext("AAN");
						}else {
							closure.setClosureStatusCodeNext("AAC");
						}
						
					}
					else if(statusCodeNext.equalsIgnoreCase("AAN")) {
						closure.setClosureStatusCodeNext("AAC");
					}
					else if(statusCodeNext.equalsIgnoreCase("AAC")) {
						closure.setClosureStatusCodeNext("AAC");
						closure.setApprStatus("A");
					}
				}
				dao.editProjectClosure(closure);
			}
			// This is for return the application form to the user
			else if(action.equalsIgnoreCase("R")) {
				// Setting StatusCode
				if(statusCodeNext.equalsIgnoreCase("AAG")) {
					closure.setClosureStatusCode("ARG");	
				}else if(statusCodeNext.equalsIgnoreCase("AAA")) {
					closure.setClosureStatusCode("ARA");	
				}else if(statusCodeNext.equalsIgnoreCase("AAP")) {
					closure.setClosureStatusCode("ARP");	
				}else if(statusCodeNext.equalsIgnoreCase("AAL")) {
					closure.setClosureStatusCode("ARL");	
				}else if(statusCodeNext.equalsIgnoreCase("AAD")) {
					closure.setClosureStatusCode("ARD");	
				}else if(statusCodeNext.equalsIgnoreCase("AAO")) {
					closure.setClosureStatusCode("ARO");	
				}else if(statusCodeNext.equalsIgnoreCase("AAN")) {
					closure.setClosureStatusCode("ARN");	
				}else if(statusCodeNext.equalsIgnoreCase("AAC")) {
					closure.setClosureStatusCode("ARC");	
				}

				// Setting StatusCode Next
				closure.setClosureStatusCodeNext("AFW");

				dao.editProjectClosure(closure);
			}

			// Transaction
			ProjectClosureTrans transaction = ProjectClosureTrans.builder()
											  .ClosureId(Long.parseLong(closureId))
											  .ClosureForm("A")
											  .ClosureStatusCode(closure.getClosureStatusCode())
											  .Remarks(remarks)
											  .LabCode(approverLabCode!=null?approverLabCode:labcode)
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
			if(action.equalsIgnoreCase("A") && closure.getApprStatus().equalsIgnoreCase("A") ) {
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
				
				if(closure.getClosureStatusCodeNext().equalsIgnoreCase("AAG")) {
					notification.setEmpId(Long.parseLong(GD[0].toString()));
				}
				else if(closure.getClosureStatusCodeNext().equalsIgnoreCase("AAA")) {
					notification.setEmpId(Long.parseLong(AD[0].toString()));
				}
				else if(closure.getClosureStatusCodeNext().equalsIgnoreCase("AAP")) {
					notification.setEmpId(Long.parseLong(GDDPandC[0].toString()));
				}
				else if(closure.getClosureStatusCodeNext().equalsIgnoreCase("AAL")) {
					notification.setEmpId(Long.parseLong(LAO[0].toString()));
				}
				else if(closure.getClosureStatusCodeNext().equalsIgnoreCase("AAD")) {
					notification.setEmpId(Long.parseLong(Director[0].toString()));
				}
				else if(apporvenextstatus.contains(closure.getClosureStatusCodeNext())) {
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

	@Override
	public Object[] projectExpenditureDetails(String projectId) throws Exception {
		
		return dao.projectExpenditureDetails(projectId);
	}

	@Override
	public long projectClosureACPRevoke(String closureId, String userId, String empId, String labcode) throws Exception {
		
		try {
			ProjectClosure closure = dao.getProjectClosureById(closureId);
			closure.setClosureStatusCode("ARV");
			closure.setClosureStatusCodeNext("AFW");
			
			long result = dao.editProjectClosure(closure);
			if(result!=0) {
				ProjectClosureTrans transaction = ProjectClosureTrans.builder()
						  						  .ClosureId(result)
						  						  .ClosureForm("A")
						  						  .ClosureStatusCode("ARV")
						  						  .LabCode(labcode)
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
	public ProjectClosureCheckList getProjectClosureCheckListByProjectId(String closureId) throws Exception {
		
		return dao.getProjectClosureCheckListByProjectId(closureId);
	}

	@Override
	public long addProjectClosureCheckList(ProjectClosureCheckList clist, ProjectCheckListRevDto dto,String empId,
			MultipartFile qARMilestoneAttach, MultipartFile qARCostBreakupAttach,MultipartFile qARNCItemsAttach,
			MultipartFile equipProcuredAttach, MultipartFile equipProcuredBeforePDCAttach,
			MultipartFile CommittmentRegister,MultipartFile BudgetDocument ) throws Exception {
		
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
//		String path = "Project-Closure\\Check-List\\";
		Path closurePath = Paths.get(uploadpath, "Project-Closure", "Check-List");
		
		// To upload file path for qARMilestoneAttach
		if (!qARMilestoneAttach.isEmpty()) {
			clist.setQARMilestone("QARMilestone" + timestampstr + "."
					+ FilenameUtils.getExtension(qARMilestoneAttach.getOriginalFilename()));
			saveFile1(closurePath, clist.getQARMilestone(), qARMilestoneAttach);
		} else {
			clist.setQARMilestone(null);
		}
		
		// To upload file path for qARCostBreakupAttach
		if (!qARCostBreakupAttach.isEmpty()) {
			clist.setQARCostBreakup("QARCostBreakup" + timestampstr + "."
					+ FilenameUtils.getExtension(qARCostBreakupAttach.getOriginalFilename()));
			saveFile1(closurePath, clist.getQARCostBreakup(), qARCostBreakupAttach);
		} else {
			clist.setQARCostBreakup(null);
		}
		
		
		// To upload file path for QARNCItems
		if (!qARNCItemsAttach.isEmpty()) {
			clist.setQARNCItems("QARNCItems" + timestampstr + "."
					+ FilenameUtils.getExtension(qARNCItemsAttach.getOriginalFilename()));
			saveFile1(closurePath, clist.getQARNCItems(), qARNCItemsAttach);
		} else {
			clist.setQARNCItems(null);
		}
		
		
		if (!equipProcuredAttach.isEmpty()) {
			clist.setEquipProcured("EquipProcuredAttach" + timestampstr + "."
					+ FilenameUtils.getExtension(equipProcuredAttach.getOriginalFilename()));
			saveFile1(closurePath, clist.getEquipProcured(), equipProcuredAttach);
		} else {
			clist.setEquipProcured(null);
		}
		
		
		if (!equipProcuredBeforePDCAttach.isEmpty()) {
			clist.setEquipProcuredBeforePDCAttach("EquipProcuredBeforePDCAttach" + timestampstr + "."
					+ FilenameUtils.getExtension(equipProcuredBeforePDCAttach.getOriginalFilename()));
			saveFile1(closurePath, clist.getEquipProcuredBeforePDCAttach(), equipProcuredBeforePDCAttach);
		} else {
			clist.setEquipProcuredBeforePDCAttach(null);
		}
		
		if (!CommittmentRegister.isEmpty() && clist.getCRBringFrom().equalsIgnoreCase("DOC")){
			clist.setCommittmentRegister("CommittmentRegister" + timestampstr + "."
					+ FilenameUtils.getExtension(CommittmentRegister.getOriginalFilename()));
			saveFile1(closurePath, clist.getCommittmentRegister(), CommittmentRegister);
		} else {
			clist.setCommittmentRegister(null);
		}
		
		System.out.println("BudgetDocument.isEmpty()----"+BudgetDocument);
		if (!BudgetDocument.isEmpty()) {
			clist.setBudgetDocument("BudgetDocument" + timestampstr + "."
					+ FilenameUtils.getExtension(BudgetDocument.getOriginalFilename()));
			saveFile1(closurePath, clist.getBudgetDocument(), BudgetDocument);
		} else {
			clist.setBudgetDocument(null);
		}
		
		if(dto.getRevSancCost()!=null && dto.getRevSancCost()!="null") {
			 for(int i=0;i<dto.getSCRequestedDate().length ;i++) {
					
					ProjectClosureCheckListRev rev = new ProjectClosureCheckListRev();
					
					rev.setClosureId(clist.getProjectClosure().getClosureId());
					rev.setRevisionType("SANC");	
					rev.setRequestedDate(sdf.format(rdf.parse(dto.getSCRequestedDate()[i])));
					rev.setGrantedDate(sdf.format(rdf.parse(dto.getSCGrantedDate()[i])));
					rev.setRevisionCost(dto.getSCRevisionCost()[i].toString());
					rev.setReason(dto.getSCReason()[i]);
					rev.setCreatedBy(clist.getCreatedBy());	
					rev.setCreatedDate(clist.getCreatedDate());	
					rev.setIsActive(1);				
					
					 dao.AddProjectClosureCheckListRev(rev);
				
				}
			}
			 
			if(dto.getRevPDCCost()!=null && dto.getRevPDCCost()!="null") {
			 for(int i=0;i<dto.getPDCRequestedDate().length ;i++) {
					
					ProjectClosureCheckListRev rev = new ProjectClosureCheckListRev();
					
					rev.setClosureId(clist.getProjectClosure().getClosureId());
					rev.setRevisionType("PDC");	
					rev.setRequestedDate(sdf.format(rdf.parse(dto.getPDCRequestedDate()[i])));
					rev.setGrantedDate(sdf.format(rdf.parse(dto.getPDCGrantedDate()[i])));
					rev.setRevisionPDC(sdf.format(rdf.parse(dto.getPDCRevised()[i])));
					rev.setReason(dto.getPDCReason()[i]);
					rev.setCreatedBy(clist.getCreatedBy());	
					rev.setCreatedDate(clist.getCreatedDate());	
					rev.setIsActive(1);				
					
					 dao.AddProjectClosureCheckListRev(rev);
				}
			}
		 
		 return dao.addProjectClosureCheckList(clist);
		
	}

	@Override
	public long editProjectClosureCheckList(ProjectClosureCheckList clist, ProjectCheckListRevDto dto,String empId,
			MultipartFile qARMilestoneAttach, MultipartFile qARCostBreakupAttach, MultipartFile qARNCItemsAttach
			,MultipartFile equipProcuredAttach, MultipartFile equipProcuredBeforePDCAttach,
			MultipartFile CommittmentRegister,MultipartFile BudgetDocument) throws Exception {
		
		Timestamp instant = Timestamp.from(Instant.now());
		String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");
		
        Path closurePath = Paths.get(uploadpath, "Project-Closure", "Check-List");
		
		// To upload file path for qARMilestoneAttach
		if (!qARMilestoneAttach.isEmpty()) {
			clist.setQARMilestone("QARMilestone" + timestampstr + "."
					+ FilenameUtils.getExtension(qARMilestoneAttach.getOriginalFilename()));
			saveFile1(closurePath, clist.getQARMilestone(), qARMilestoneAttach);
		} 
		
		// To upload file path for qARCostBreakupAttach
		if (!qARCostBreakupAttach.isEmpty()) {
			clist.setQARCostBreakup("QARCostBreakup" + timestampstr + "."
					+ FilenameUtils.getExtension(qARCostBreakupAttach.getOriginalFilename()));
			saveFile1(closurePath, clist.getQARCostBreakup(), qARCostBreakupAttach);
		} 
		
		
		// To upload file path for QARNCItems
		if (!qARNCItemsAttach.isEmpty()) {
			clist.setQARNCItems("QARNCItems" + timestampstr + "."
					+ FilenameUtils.getExtension(qARNCItemsAttach.getOriginalFilename()));
			saveFile1(closurePath, clist.getQARNCItems(), qARNCItemsAttach);
		} 
		
		
		if (!equipProcuredAttach.isEmpty()) {
			clist.setEquipProcured("EquipProcuredAttach" + timestampstr + "."
					+ FilenameUtils.getExtension(equipProcuredAttach.getOriginalFilename()));
			saveFile1(closurePath, clist.getEquipProcured(), equipProcuredAttach);
		} 
		
		if (!equipProcuredBeforePDCAttach.isEmpty()) {
			clist.setEquipProcuredBeforePDCAttach("EquipProcuredBeforePDCAttach" + timestampstr + "."
					+ FilenameUtils.getExtension(equipProcuredBeforePDCAttach.getOriginalFilename()));
			saveFile1(closurePath, clist.getEquipProcuredBeforePDCAttach(), equipProcuredBeforePDCAttach);
		} 
		
		if (!CommittmentRegister.isEmpty() && clist.getCRBringFrom().equalsIgnoreCase("DOC")){
			clist.setCommittmentRegister("CommittmentRegister" + timestampstr + "."
					+ FilenameUtils.getExtension(CommittmentRegister.getOriginalFilename()));
			saveFile1(closurePath, clist.getCommittmentRegister(), CommittmentRegister);
		}else {
			clist.setCommittmentRegister(null);
			
		} 
		
		
		if (!BudgetDocument.isEmpty()) {
			clist.setBudgetDocument("BudgetDocument" + timestampstr + "."
					+ FilenameUtils.getExtension(BudgetDocument.getOriginalFilename()));
			saveFile1(closurePath, clist.getBudgetDocument(), BudgetDocument);
		} 
		
		dao.removeProjectClosureCheckListRev(clist.getProjectClosure().getClosureId());
		
		if(dto.getRevSancCost()!=null && dto.getRevSancCost()!="null") {

			for(int i=0;i<dto.getSCRequestedDate().length ;i++) {

				ProjectClosureCheckListRev rev = new ProjectClosureCheckListRev();

				rev.setClosureId(clist.getProjectClosure().getClosureId());
				rev.setRevisionType("SANC");	
				rev.setRequestedDate(sdf.format(rdf.parse(dto.getSCRequestedDate()[i])));
				rev.setGrantedDate(sdf.format(rdf.parse(dto.getSCGrantedDate()[i])));
				rev.setRevisionCost(dto.getSCRevisionCost()[i].toString());
				rev.setReason(dto.getSCReason()[i]);
				rev.setCreatedBy(clist.getCreatedBy());	
				rev.setCreatedDate(clist.getCreatedDate());	
				rev.setIsActive(1);				

				dao.AddProjectClosureCheckListRev(rev);
			}

		}
	 
		if(dto.getRevPDCCost()!=null && dto.getRevPDCCost()!="null") {
			for(int j=0;j<dto.getPDCRequestedDate().length ;j++) {

				ProjectClosureCheckListRev rev = new ProjectClosureCheckListRev();

				rev.setClosureId(clist.getProjectClosure().getClosureId());
				rev.setRevisionType("PDC");
				rev.setRequestedDate(sdf.format(rdf.parse(dto.getPDCRequestedDate()[j])));
				rev.setGrantedDate(sdf.format(rdf.parse(dto.getPDCGrantedDate()[j])));
				rev.setRevisionPDC(sdf.format(rdf.parse(dto.getPDCRevised()[j])));
				rev.setReason(dto.getPDCReason()[j]);
				rev.setCreatedBy(clist.getCreatedBy());	
				rev.setCreatedDate(clist.getCreatedDate());	
				rev.setIsActive(1);				

				dao.AddProjectClosureCheckListRev(rev);
			}
		}
		
		return  dao.editProjectClosureCheckList(clist);
		
	}

	@Override
	public long AddIssue(ProjectClosureTechnical tech,String EmpId,String LabCode,String Action) throws Exception {
		
		 dao.AddIssue(tech);
		
		ProjectClosureTrans trans=new ProjectClosureTrans();
		
		trans.setClosureId(tech.getTechnicalClosureId());
		trans.setClosureForm("T");
		trans.setClosureStatusCode("TIN");
		trans.setLabCode(LabCode);
		trans.setActionBy(Long.parseLong(EmpId));
		trans.setActionDate(sdtf.format(new Date()));
		
		return dao.addProjectClosureTransaction(trans);
		
	}

	@Override
	public List<Object[]> getTechnicalClosureRecord(String closureId) throws Exception {
		
		return dao.getTechnicalClosureRecord(closureId);
	}

	@Override
	public long AddSection(ProjectClosureTechnicalSection sec) throws Exception {
		
		return dao.AddSection(sec);
		
	}

	@Override
	public List<Object[]> getSectionList(String closureId) throws Exception {
		
		return dao.getSectionList(closureId);
	}

	@Override
	public List<Object[]> getChapterList(String closureId) throws Exception {
		
		return dao.getChapterList(closureId);
	}

	@Override
	public long ChapterAdd(ProjectClosureTechnicalChapters chapter) throws Exception {
		
	     return dao.ChapterAdd(chapter);
			
	}

	@Override
	public ProjectClosureTechnicalSection getProjectClosureTechnicalSectionById(String id) throws Exception {
		
		return dao.getProjectClosureTechnicalSectionById(id);
	}

	@Override
	public long ChapterEdit(String chapterId, String chapterName,String ChapterContent) throws Exception {
		
		return dao.ChapterEdit(chapterId,chapterName,ChapterContent);
	}

	@Override
	public Object[] getChapterContent(String chapterId) throws Exception {
		
		return dao.getChapterContent(chapterId);
	}

	@Override
	public List<Object[]> getAppndDocList() throws Exception {
		
		return dao.getAppndDocList();
	}

	@Override
	public long ProjectClosureAppendixDocSubmit(ProjectClosureAppendixDto dto) throws Exception {
	try {
		
		dao.removeProjectClosureProjectClosureAppendixDoc(dto.getChapterId());
		
		for(int i=0;i<dto.getAttachment().length ;i++) {
			
				ProjectClosureTechnicalAppendices appnd = new ProjectClosureTechnicalAppendices();
				
				appnd.setDocumentName(dto.getDocumentName()[i]);
				appnd.setAppendix(dto.getAppendix()[i]);;
				
				Timestamp instant = Timestamp.from(Instant.now());
				String timestampstr = instant.toString().replace(" ", "").replace(":", "").replace("-", "").replace(".", "");

//				String path = "Project-Closure\\TPCR\\";
				Path closurePath = Paths.get(uploadpath, "Project-Closure", "TPCR");

				
				if (!dto.getAttachment()[i].isEmpty()) {
					appnd.setDocumentAttachment("TPCR-" + timestampstr + "."
							+ FilenameUtils.getExtension(dto.getAttachment()[i].getOriginalFilename()));
					saveFile1(closurePath, appnd.getDocumentAttachment(), dto.getAttachment()[i]);
				}else {
					appnd.setDocumentAttachment(dto.getAttatchmentName()[i]);
				}
				
				appnd.setChapterId(dto.getChapterId());
				appnd.setCreatedBy(dto.getUserId());
				appnd.setCreatedDate(sdtf.format(new Date()));
				appnd.setIsActive(1);
				
				dao.ProjectClosureAppendixDocSubmit(appnd);
			}
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureServiceImpl ProjectClosureAppendixDocSubmit "+e);
			e.printStackTrace();
			return 0;
		}
	}

	

	@Override
	public List<Object[]>  getAppendicesList(String closureId) throws Exception {
		
		return dao.getAppendicesList(closureId);
	}

	@Override
	public ProjectClosureTechnicalAppendices getProjectClosureTechnicalAppendicesById(String attachmentfile)
			throws Exception {
		
		return dao.getProjectClosureTechnicalAppendicesById(attachmentfile);
	}

	@Override
	public List<Object[]> getTechnicalClosureContent(String closureId) throws Exception {
		
		return dao.getTechnicalClosureContent(closureId);
	}

	@Override
	public long addDocSummary(ProjectClosureTechnicalDocSumary rs) throws Exception {
		
		return dao.addDocSummary(rs);
	}

	@Override
	public long editDocSummary(ProjectClosureTechnicalDocSumary rs) throws Exception{
		
		return dao.editDocSummary(rs);
	}

	@Override
	public List<Object[]> getDocumentSummary(String closureId) throws Exception {
		
		return dao.getDocumentSummary(closureId);
	}

	@Override
	public ProjectClosureTechnical getProjectClosureTechnicalById(String closureId) throws Exception {
		
		return dao.getProjectClosureTechnicalById(closureId);
	}

	@Override
	public long UpdateProjectClosureTechnical(ProjectClosureTechnical techn) throws Exception {
		
		return dao.UpdateProjectClosureTechnical(techn);
	}

	@Override
	public long projectTechClosureApprovalForward(ProjectClosureApprovalForwardDTO dto,HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		try {
//			long closureSoCId = dto.getClosureSoCId();
			String TechclosureId = dto.getTechclosureId();
			String ClosureId=dto.getClosureId();
//			String projectId = dto.getProjectId();
			String action = dto.getAction();
			String EmpId = dto.getEmpId();
			String UserId = dto.getUserId();
			String remarks = dto.getRemarks();
			String labcode = dto.getLabcode();
			String approverLabCode = dto.getApproverLabCode();
			String approverEmpId = dto.getApproverEmpId();
			String approvalDate = dto.getApprovalDate();

			ProjectClosure closur = dao.getProjectClosureById(ClosureId);
			
			ProjectClosureTechnical closure = dao.getProjectClosureTechnicalById(TechclosureId);
			String projectId = closur.getProjectId()+"";
			String statusCode = closure.getStatusCode();
			String statusCodeNext = closure.getStatusCodeNext();
			
			Object[] PD = carsdao.getEmpPDEmpId(projectId);
			Object[] GD = dao.getEmpGDDetails(PD!=null?PD[1].toString():"0");

			List<String> forwardstatus = Arrays.asList("TIN","TRG","TRA","TRP","TRD","TGD","TRV");

			// This is for the moving the approval flow in forward direction.
			if(action.equalsIgnoreCase("A")) {
				if(forwardstatus.contains(statusCode)) {
					
					if(statusCode.equalsIgnoreCase("TIN")) {
						closure.setForwardedBy(PD!=null?PD[1].toString():"0");
						closure.setForwardedDate(sdf.format(new Date()));
					}
					
					closure.setStatusCode("TFW");
					if(PD!=null && PD[1].toString().equalsIgnoreCase(GD!=null? GD[0].toString():"0")) {
						closure.setStatusCodeNext("TAA");
					}
					else {
						closure.setStatusCodeNext("TAG");
					}
					
				}else {
					closure.setStatusCode(statusCodeNext);
					if(statusCodeNext.equalsIgnoreCase("TAG")) {
						closure.setStatusCodeNext("TAA");
					}else if(statusCodeNext.equalsIgnoreCase("TAA")) {
						closure.setStatusCodeNext("TAP");
					}else if(statusCodeNext.equalsIgnoreCase("TAP")) {
						closure.setStatusCodeNext("TAD");
					}else if(statusCodeNext.equalsIgnoreCase("TAD")) {
						closure.setStatusCodeNext("TDG");
					}else if(statusCodeNext.equalsIgnoreCase("TDG")) {
						closure.setStatusCodeNext("TDG");
						
					}
				}
				dao.UpdateProjectClosureTechnical(closure);
			}
			// This is for return the application form to the user
			else if(action.equalsIgnoreCase("R")) {
				// Setting StatusCode
				if(statusCodeNext.equalsIgnoreCase("TAG")) {
					closure.setStatusCode("TRG");	
				}else if(statusCodeNext.equalsIgnoreCase("TAA")) {
					closure.setStatusCode("TRA");	
				}else if(statusCodeNext.equalsIgnoreCase("TAP")) {
					closure.setStatusCode("TRP");	
				}else if(statusCodeNext.equalsIgnoreCase("TAD")) {
					closure.setStatusCode("TRD");	
				}else if(statusCodeNext.equalsIgnoreCase("TDG")) {
					closure.setStatusCode("TGD");	
				}

				// Setting StatusCode Next
				closure.setStatusCodeNext("TFW");

				dao.UpdateProjectClosureTechnical(closure);
			}

			// Transaction
			ProjectClosureTrans transaction = ProjectClosureTrans.builder()
											  .ClosureId(Long.parseLong(TechclosureId))
											  .ClosureForm("T")
											  .ClosureStatusCode(closure.getStatusCode())
											  .Remarks(remarks)
											  .LabCode(approverLabCode!=null?approverLabCode:labcode)
											  .ActionBy(Long.parseLong(approverEmpId!=null? approverEmpId:EmpId))
											  .ActionDate(approvalDate!=null?fc.RegularToSqlDate(approvalDate):sdtf.format(new Date()))
											  .build();
			dao.addProjectClosureTransaction(transaction);
			
			
			if(statusCodeNext.equalsIgnoreCase("TDG")){
				
				
			     TCRFormFreeze(req,res,ClosureId,TechclosureId,labcode);
			     
			}
			
			
			// Approval Authority Data to send notifications
			Object[] AD = carsdao.getApprAuthorityDataByType(labcode, "AD");
			Object[] GDDPandC = carsdao.getApprAuthorityDataByType(labcode, "DO-RTMD");
			Object[] Director = carsdao.getLabDirectorData(labcode);
			
			long PDEmpId = PD!=null?Long.parseLong(PD[1].toString()):0;
			// Notification
			PfmsNotification notification = new PfmsNotification();
			if(action.equalsIgnoreCase("A") && statusCodeNext.equalsIgnoreCase("TDG")) {
				notification.setEmpId(PDEmpId);
				notification.setNotificationUrl("ProjectClosureList.htm");
				notification.setNotificationMessage("Technical Closure request approved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));

				carsdao.addNotifications(notification);
			}
			else if(action.equalsIgnoreCase("A")) {
				
				if(closure.getStatusCodeNext().equalsIgnoreCase("TAG")) {
					notification.setEmpId(Long.parseLong(GD[0].toString()));
				}
				
				else if(closure.getStatusCodeNext().equalsIgnoreCase("TAA")) {
					notification.setEmpId(Long.parseLong(AD[0].toString()));
				}
				else if(closure.getStatusCodeNext().equalsIgnoreCase("TAP")) {
					notification.setEmpId(Long.parseLong(GDDPandC[0].toString()));
				}
				else if(closure.getStatusCodeNext().equalsIgnoreCase("TAD")) {
					notification.setEmpId(Long.parseLong(Director[0].toString()));
				}
				else if(closure.getStatusCodeNext().equalsIgnoreCase("TDG")) {
					notification.setEmpId(PDEmpId);
				}
				
				notification.setNotificationUrl("ProjectClosureApprovals.htm");
				notification.setNotificationMessage("Project Technical Closure  forwarded by "+PD[2].toString());
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
				notification.setNotificationMessage(action.equalsIgnoreCase("R")?"Project Technical Closure Request Returned":"Project Technical Closure Request Disapproved");
				notification.setNotificationby(Long.parseLong(EmpId));
				notification.setNotificationDate(LocalDate.now().toString());
				notification.setIsActive(1);
				notification.setCreatedBy(UserId);
				notification.setCreatedDate(sdtf.format(new Date()));
			
				carsdao.addNotifications(notification);
			}			
			return 1;
		}catch (Exception e) {
			logger.error(new Date() +" Inside ProjectClosureServiceImpl projectTechClosureApprovalForward "+e);
			e.printStackTrace();
			return 0;
		}
		
	}

	@Override
	public List<Object[]> projectTechClosureTransListByType(String techClosureId, String closureStatusFor, String closureForm) throws Exception {
		
		return dao.projectTechClosureTransListByType(techClosureId,closureStatusFor,closureForm);
	}

	@Override
	public List<Object[]> projectTechClosurePendingList(String empId, String labcode) throws Exception {
		
		return dao.projectTechClosurePendingList(empId,labcode);
	}

	@Override
	public List<Object[]> projectTechClosureApprovedList(String empId, String fromdate, String todate) throws Exception {
		
		return dao.projectTechClosureApprovedList(empId,fromdate,todate);
	}

	@Override
	public long AddTCRMembers(ProjectClosureTechnicalDocDistrib dist) throws Exception {
		
		
		int numberOfPersons= dist.getEmps().length; 
		
		String []assignee= dist.getEmps();
		long count=0;
		for(int i=0;i<numberOfPersons;i++) {
			ProjectClosureTechnicalDocDistrib r = new ProjectClosureTechnicalDocDistrib();

			r.setTechnicalClosureId(dist.getTechnicalClosureId());		
			r.setCreatedBy(dist.getCreatedBy());
			r.setCreatedDate(dist.getCreatedDate());
			r.setEmpId(Long.parseLong(assignee[i]));
			r.setIsActive(1);
			
			count=dao.AddDocDistribMembers(r);
			
		}
		
		return count;
		
	}

	@Override
	public List<Object[]> getDocSharingMemberList(String techClosureId) throws Exception {
		
		return dao.getDocSharingMemberList(techClosureId);
	}
	
	
	@Override
	public void TCRFormFreeze(HttpServletRequest req, HttpServletResponse res,String ClosureId,String TechclosureId,String labcode) throws Exception{
		logger.info(new Date() +"Inside SERVICE TCRFormFreeze ");
		try {
			
			req.setAttribute("lablogo",  LogoUtil.getLabLogoAsBase64String(labcode)); 
		  	req.setAttribute("LabImage",  LogoUtil.getLabImageAsBase64String(labcode)); 
		  	req.setAttribute("LabList",   projectdao.LabListDetails(labcode));
		  	req.setAttribute("RecordOfAmendments", dao.getTechnicalClosureRecord(ClosureId));
		  	req.setAttribute("TechnicalClosureContent", dao.getTechnicalClosureContent(ClosureId));
		  	req.setAttribute("AppendicesList",dao.getAppendicesList(ClosureId));
			req.setAttribute("DocumentSummary",dao.getDocumentSummary(ClosureId));
			req.setAttribute("MemberList", dao.getDocSharingMemberList(TechclosureId));
			
			
			String filename="TCR Form";
			String path=req.getServletContext().getRealPath("/view/temp");
			req.setAttribute("path",path);
				        
	        CharArrayWriterResponse customResponse = new CharArrayWriterResponse(res);
			req.getRequestDispatcher("/view/print/ProjectTechClosureDownload.jsp").forward(req, customResponse);
			String html = customResponse.getOutput();                  
	        
	        HtmlConverter.convertToPdf(html,new FileOutputStream(path+File.separator+filename+".pdf")); 
	         
	        File file=new File(path +File.separator+ filename+".pdf");
	        
	        String fname="TCRFreeze-"+TechclosureId;
//			String filepath = "Project-Closure\\TPCR";
	        Path closurePath = Paths.get(uploadpath, "Project-Closure", "TPCR");
			int count=0;
			while(closurePath.resolve(fname+".pdf").toFile().exists())
			{
				fname = "TCRFreeze-"+TechclosureId;
				fname = fname+" ("+ ++count+")";
			}
	        
			saveFileFromFileObject(closurePath, fname+".pdf", file);
	        
			Path closurePath1 = Paths.get("Project-Closure", "TPCR", fname+".pdf");
//	        dao.TCRFreeze(TechclosureId, filepath+"\\"+fname+".pdf");
	        dao.TCRFreeze(TechclosureId, closurePath1.toString());
	        Path pathOfFile= Paths.get( path+File.separator+filename+".pdf"); 
	        Files.delete(pathOfFile);		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
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
	public List<Object[]> getProjectClosureCheckListRevByClosureId(String closureId) throws Exception {
		
		return dao.getProjectClosureCheckListRevByClosureId(closureId);
	}

	@Override
	public List<Object[]> TCRTemplateSectionList() throws Exception {
		
		return dao.TCRTemplateSectionList();
	}

	@Override
	public List<Object[]> TCRTemplateChapterListBySectionId(String sectionid) throws Exception {
		
		return dao.TCRTemplateChapterListBySectionId(sectionid);
	}

	@Override
	public List<Object[]> TCRTemplateChapterListByChapterParentId(String chapterparentid) throws Exception {
		
		return dao.TCRTemplateChapterListByChapterParentId(chapterparentid);
	}

	@Override
	public int AmendTechClosureList(String techClosureId) throws Exception {
		
		return dao.AmendTechClosureList(techClosureId);
	}

	@Override
	public long AddNewRevision(ProjectClosureTechnical tech, String empId, String labCode, String techClosureId) throws Exception {
		
		
		dao.AddIssue(tech);
		
     ProjectClosureTrans trans1=new ProjectClosureTrans();
		
		trans1.setClosureId(Long.parseLong(techClosureId));
		trans1.setClosureForm("T");
		trans1.setClosureStatusCode("TAM");
		trans1.setLabCode(labCode);
		trans1.setActionBy(Long.parseLong(empId));
		trans1.setActionDate(sdtf.format(new Date()));
		
		 dao.addProjectClosureTransaction(trans1);
		
		
       ProjectClosureTrans trans=new ProjectClosureTrans();
		
		trans.setClosureId(tech.getTechnicalClosureId());
		trans.setClosureForm("T");
		trans.setClosureStatusCode("TIN");
		trans.setLabCode(labCode);
		trans.setActionBy(Long.parseLong(empId));
		trans.setActionDate(sdtf.format(new Date()));
		
		return dao.addProjectClosureTransaction(trans);
		
	}
	
	@Override
	public List<ProjectMasterRev> getProjectMasterRevListByProjectId(String projectId) throws Exception {
		
		return dao.getProjectMasterRevListByProjectId(projectId);
	}

}
