package com.vts.pfms.ms.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.vts.pfms.login.PFMSCCMData;
import com.vts.pfms.login.ProjectHoa;
import com.vts.pfms.model.LabMaster;
import com.vts.pfms.ms.dao.ClusterCommitteeScheduleRepo;
import com.vts.pfms.ms.dao.ClusterLabEmployeeRepo;
import com.vts.pfms.ms.dao.MSReqDao;
import com.vts.pfms.ms.dao.PfmsCCMDataRepo;
import com.vts.pfms.ms.dao.PfmsInitiationMilestoneRepo;
import com.vts.pfms.ms.dao.PfmsInitiationMilestoneRevRepo;
import com.vts.pfms.ms.dao.PfmsInitiationRepo;
import com.vts.pfms.ms.dao.ProjectHealthRepo;
import com.vts.pfms.ms.dao.ProjectHoaRepo;
import com.vts.pfms.ms.dto.CommitteeScheduleDto;
import com.vts.pfms.ms.dto.EmployeeDto;
import com.vts.pfms.ms.dto.PFMSCCMDataDto;
import com.vts.pfms.ms.dto.PfmsInitiationDto;
import com.vts.pfms.ms.dto.PfmsInitiationMilestoneDto;
import com.vts.pfms.ms.dto.PfmsInitiationMilestoneRevDto;
import com.vts.pfms.ms.dto.ProjectHealthDto;
import com.vts.pfms.ms.dto.ProjectHoaDto;
import com.vts.pfms.ms.dto.ProjectMasterDto;
import com.vts.pfms.ms.model.ClusterCommitteeSchedule;
import com.vts.pfms.ms.model.ClusterLabEmployee;
import com.vts.pfms.project.dao.ProjectMasterRepo;
import com.vts.pfms.project.model.PfmsInitiation;
import com.vts.pfms.project.model.PfmsInitiationMilestone;
import com.vts.pfms.project.model.PfmsInitiationMilestoneRev;
import com.vts.pfms.project.model.ProjectHealth;
import com.vts.pfms.project.model.ProjectMaster;

@Service
public class MSReqServiceImpl implements MSReqService{
	
	private static final Logger logger = LogManager.getLogger(MSReqServiceImpl.class);
	
	@Autowired
	MSReqDao dao;
	
	@Autowired
	ClusterLabEmployeeRepo labEmployeeRepo;
	
	@Autowired
	ProjectMasterRepo projectMasterRepo;

	@Autowired
	private PfmsInitiationRepo pfmsInitiationRepo; 
	
	@Autowired
	private PfmsInitiationMilestoneRepo pfmsInitiationMilestoneRepo; 
	
	@Autowired
	private PfmsInitiationMilestoneRevRepo pfmsInitiationMilestoneRevRepo; 
	
	@Autowired
	private PfmsCCMDataRepo pfmsCCMDataRepo; 
	
	@Autowired
	private ProjectHealthRepo projectHealthRepo; 
	
	@Autowired
	private ProjectHoaRepo projectHoaRepo; 
	
	@Autowired
	private ClusterCommitteeScheduleRepo clusterCommitteeScheduleRepo; 
	
    private final RestTemplate restTemplate;

    public MSReqServiceImpl(RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder.build();
    }

    // Employee Data Fetch
    public List<EmployeeDto> fetchEmpDataFromLocation(String locationUri) throws Exception {
    	
        ResponseEntity<List<EmployeeDto>> response = restTemplate.exchange(locationUri, HttpMethod.GET, null, new ParameterizedTypeReference<List<EmployeeDto>>() {});
        
        return response.getBody();  // Get data from the response
    }
    
    public long saveAllClusterLabEmployeesData(List<EmployeeDto> empDtoList) throws Exception {
    	try {
    		if(empDtoList!=null && empDtoList.size()>0) {
    			// Remove Existing Employees
        		labEmployeeRepo.deleteAll();
        		
        		// Reset auto-increment to start from 1
        		labEmployeeRepo.resetAutoIncrement();
        	    
        		// Map EmployeeDTO to ClusterLabEmployee using builder
        		List<ClusterLabEmployee> empList = empDtoList.stream()
								        		    .map(dto -> ClusterLabEmployee.builder()
								    		    		        .EmpId(dto.getEmpId())
								    		    		        .EmpNo(dto.getEmpNo())
								    		    		        .Title(dto.getTitle())
								    		    		        .Salutation(dto.getSalutation())
								    		    		        .EmpName(dto.getEmpName())
								    		    		        .DesigId(dto.getDesigId())
								    		    		        .ExtNo(dto.getExtNo())
								    		    		        .MobileNo(dto.getMobileNo())
								    		    		        .DronaEmail(dto.getDronaEmail())
								    		    		        .InternetEmail(dto.getInternetEmail())
								    		    		        .Email(dto.getEmail())
								    		    		        .DivisionId(dto.getDivisionId())
								    		    		        .SrNo(dto.getSrNo())
								    		    		        .IsActive(dto.getIsActive())
								    		    		        .CreatedBy(dto.getCreatedBy())
								    		    		        .CreatedDate(dto.getCreatedDate())
								    		    		        .ModifiedBy(dto.getModifiedBy())
								    		    		        .ModifiedDate(dto.getModifiedDate())
								    		    		        .LabCode(dto.getLabCode())
								    		    		        .SuperiorOfficer(dto.getSuperiorOfficer())
								    		    		        .build())
								        			.collect(Collectors.toList());

                // Save all employees to the database
                labEmployeeRepo.saveAll(empList);
    		}
            
    		return 1;
    	}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside MSServiceImpl saveAllClusterLabEmployeesData "+e);
			return 0;
		}
    }

    // Project Data Fetch
    public List<ProjectMasterDto> fetchProjectDataFromLocation(String locationUri) throws Exception{

    	ResponseEntity<List<ProjectMasterDto>> response = restTemplate.exchange(locationUri, HttpMethod.GET, null, new ParameterizedTypeReference<List<ProjectMasterDto>>() {});

    	return response.getBody();  // Get data from the response
    }
    
    public long saveAllProjectsData(List<ProjectMasterDto> projectDtoList) throws Exception {
        try {
        	if(projectDtoList!=null && projectDtoList.size()>0) {
        		// Remove Existing Projects
        		projectMasterRepo.deleteAll();

        		// Reset auto-increment to start from 1
        		projectMasterRepo.resetAutoIncrement();

        		// Map ProjectMasterDTO to ProjectMaster using builder
        		List<ProjectMaster> projectList = projectDtoList.stream()
								        			.map(dto -> ProjectMaster.builder()
								        						//.ProjectId(dto.getProjectId())
								        						.ProjectMainId(dto.getProjectMainId())
								        						.ProjectCode(dto.getProjectCode())
								        						.ProjectShortName(dto.getProjectShortName())
								        						.ProjectImmsCd(dto.getProjectImmsCd())
								        						.ProjectName(dto.getProjectName())
								        						.ProjectDescription(dto.getProjectDescription())
								        						.UnitCode(dto.getUnitCode())
								        						.ProjectType(dto.getProjectType())
								        						.SanctionNo(dto.getSanctionNo())
								        						.SanctionDate(dto.getSanctionDate())
								        						.TotalSanctionCost(dto.getTotalSanctionCost())
								        						.SanctionCostRE(dto.getSanctionCostRE())
								        						.SanctionCostFE(dto.getSanctionCostFE())
								        						.PDC(dto.getPDC())
								        						.ProjectDirector(dto.getProjectDirector())
								        						.ProjectCategory(dto.getProjectCategory())
								        						.ProjSancAuthority(dto.getProjSancAuthority())
								        						.BoardReference(dto.getBoardReference())
								        						.RevisionNo(dto.getRevisionNo())
								        						.WorkCenter(dto.getWorkCenter())
								        						.LabParticipating(dto.getLabParticipating())
								        						.Objective(dto.getObjective())
								        						.Deliverable(dto.getDeliverable())
								        						.Scope(dto.getScope())
								        						.Application(dto.getApplication())
								        						.EndUser(dto.getEndUser())
								        						.CreatedBy(dto.getCreatedBy())
								        						.CreatedDate(dto.getCreatedDate())
								        						.ModifiedBy(dto.getModifiedBy())
								        						.ModifiedDate(dto.getModifiedDate())
								        						.isActive(dto.getIsActive())
								        						.IsMainWC(dto.getIsMainWC())
								        						.LabCode(dto.getLabCode())
								        						.IsCCS(dto.getIsCCS())
								        						.build())
								        			.collect(Collectors.toList());

        		// Save all projects to the database
        		projectMasterRepo.saveAll(projectList);
        	}

            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(new Date() + " Inside MSServiceImpl saveAllProjectsData " + e);
            return 0;
        }
    }

    // Initiation Project Data Fetch
    public List<PfmsInitiationDto> fetchInitiationProjectDataFromLocation(String locationUri) throws Exception{
    	
    	ResponseEntity<List<PfmsInitiationDto>> response = restTemplate.exchange(locationUri, HttpMethod.GET, null, new ParameterizedTypeReference<List<PfmsInitiationDto>>() {});
    	
    	return response.getBody();  // Get data from the response
    }
    
    public long saveAllInitiationProjectsData(List<PfmsInitiationDto> initiationDtoList) throws Exception {
        try {
        	if(initiationDtoList!=null && initiationDtoList.size()>0) {
        		// Remove Existing Projects
	            pfmsInitiationRepo.deleteAll();
	            
	            // Reset auto-increment to start from 1
	            pfmsInitiationRepo.resetAutoIncrement();
	            
	            // Map PfmsInitiationDto to PfmsInitiation using builder
	            List<PfmsInitiation> initiationList = initiationDtoList.stream()
										            	.map(dto -> PfmsInitiation.builder()
										                            //.InitiationId(dto.getInitiationId())
										                            .EmpId(dto.getEmpId())
										                            .LabCode(dto.getLabCode())
										                            .DivisionId(dto.getDivisionId())
										                            .ProjectProgramme(dto.getProjectProgramme())
										                            .ProjectTypeId(dto.getProjectTypeId())
										                            .ClassificationId(dto.getClassificationId())
										                            .ProjectShortName(dto.getProjectShortName())
										                            .ProjectTitle(dto.getProjectTitle())
										                            .ProjectCost(dto.getProjectCost())
										                            .FeCost(dto.getFeCost())
										                            .ReCost(dto.getReCost())
										                            .ProjectDuration(dto.getProjectDuration())
										                            .IsPlanned(dto.getIsPlanned())
										                            .IsMultiLab(dto.getIsMultiLab())
										                            .LabCount(dto.getLabCount())
										                            .Deliverable(dto.getDeliverable())
										                            .ProjectStatus(dto.getProjectStatus())
										                            .IsMain(dto.getIsMain())
										                            .MainId(dto.getMainId())
										                            .NodalLab(dto.getNodalLab())
										                            .Remarks(dto.getRemarks())
										                            .PCDuration(dto.getPCDuration())
										                            .IndicativeCost(dto.getIndicativeCost())
										                            .PCRemarks(dto.getPCRemarks())
										                            .User(dto.getUser())
										                            .CreatedBy(dto.getCreatedBy())
										                            .CreatedDate(dto.getCreatedDate())
										                            .ModifiedBy(dto.getModifiedBy())
										                            .ModifiedDate(dto.getModifiedDate())
										                            .IsActive(dto.getIsActive())
										                            .StartDate(dto.getStartDate())
										                            .build())
										            	.collect(Collectors.toList());
	
	            // Save all initiation projects to the database
	            pfmsInitiationRepo.saveAll(initiationList);
        	}
            
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(new Date() + " Inside MSServiceImpl saveAllInitiationProjectsData " + e);
            return 0;
        }
    }

    // Initiation Project Milestone (MS) Data Fetch
    public List<PfmsInitiationMilestoneDto> fetchInitiationProjectMSDataFromLocation(String locationUri) throws Exception{
    	
    	ResponseEntity<List<PfmsInitiationMilestoneDto>> response = restTemplate.exchange(locationUri, HttpMethod.GET, null, new ParameterizedTypeReference<List<PfmsInitiationMilestoneDto>>() {});
    	
    	return response.getBody();  // Get data from the response
    }
    
    public long saveAllInitiationProjectsMSData(List<PfmsInitiationMilestoneDto> initiationMSDtoList) throws Exception {
        try {
        	if(initiationMSDtoList!=null && initiationMSDtoList.size()>0) {
        		// Remove Existing Milestones
	            pfmsInitiationMilestoneRepo.deleteAll();
	            
	            // Reset auto-increment to start from 1
	            pfmsInitiationMilestoneRepo.resetAutoIncrement();
	
	            // Map PfmsInitiationMilestoneDto to PfmsInitiationMilestone using builder
	            List<PfmsInitiationMilestone> msList = initiationMSDtoList.stream()
										                .map(dto -> PfmsInitiationMilestone.builder()
										                        //.InitiationMilestoneId(dto.getInitiationMilestoneId())
										                        .InitiationId(dto.getInitiationId())
										                        .PDRProbableDate(dto.getPDRProbableDate())
										                        .PDRActualDate(dto.getPDRActualDate())
										                        .TIECProbableDate(dto.getTIECProbableDate())
										                        .TIECActualDate(dto.getTIECActualDate())
										                        .CECProbableDate(dto.getCECProbableDate())
										                        .CECActualDate(dto.getCECActualDate())
										                        .CCMProbableDate(dto.getCCMProbableDate())
										                        .CCMActualDate(dto.getCCMActualDate())
										                        .DMCProbableDate(dto.getDMCProbableDate())
										                        .DMCActualDate(dto.getDMCActualDate())
										                        .SanctionProbableDate(dto.getSanctionProbableDate())
										                        .SanctionActualDate(dto.getSanctionActualDate())
										                        .Revision(dto.getRevision())
										                        .SetBaseline(dto.getSetBaseline())
										                        .CreatedBy(dto.getCreatedBy())
										                        .CreatedDate(dto.getCreatedDate())
										                        .ModifiedBy(dto.getModifiedBy())
										                        .ModifiedDate(dto.getModifiedDate())
										                        .IsActive(dto.getIsActive())
										                        .build())
										                .collect(Collectors.toList());
										
	            // Save all milestones to the database
	            pfmsInitiationMilestoneRepo.saveAll(msList);
        	}

            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(new Date() + " Inside MSServiceImpl saveAllInitiationProjectsMSData " + e);
            return 0;
        }
    }
    
    // Initiation Project Milestone (MS) Revision Data Fetch
    public List<PfmsInitiationMilestoneRevDto> fetchInitiationProjectMSRevDataFromLocation(String locationUri) throws Exception{
    	
    	ResponseEntity<List<PfmsInitiationMilestoneRevDto>> response = restTemplate.exchange(locationUri, HttpMethod.GET, null, new ParameterizedTypeReference<List<PfmsInitiationMilestoneRevDto>>() {});
    	
    	return response.getBody();  // Get data from the response
    }
    
    public long saveAllInitiationProjectsMSRevData(List<PfmsInitiationMilestoneRevDto> initiationMSRevDtoList) throws Exception {
        try {
        	if(initiationMSRevDtoList!=null && initiationMSRevDtoList.size()>0) {
        		// Remove Existing Milestone Revisions
	            pfmsInitiationMilestoneRevRepo.deleteAll();
	            
	            // Reset auto-increment to start from 1
	            pfmsInitiationMilestoneRevRepo.resetAutoIncrement();
	
	            // Map PfmsInitiationMilestoneRevDto to PfmsInitiationMilestoneRev using builder
	            List<PfmsInitiationMilestoneRev> msRevList = initiationMSRevDtoList.stream()
												                .map(dto -> PfmsInitiationMilestoneRev.builder()
												                        //.InitiationMileRevId(dto.getInitiationMileRevId())
												                        .InitiationMilestoneId(dto.getInitiationMilestoneId())
												                        .InitiationId(dto.getInitiationId())
												                        .PDRProbableDate(dto.getPDRProbableDate())
												                        .PDRActualDate(dto.getPDRActualDate())
												                        .TIECProbableDate(dto.getTIECProbableDate())
												                        .TIECActualDate(dto.getTIECActualDate())
												                        .CECProbableDate(dto.getCECProbableDate())
												                        .CECActualDate(dto.getCECActualDate())
												                        .CCMProbableDate(dto.getCCMProbableDate())
												                        .CCMActualDate(dto.getCCMActualDate())
												                        .DMCProbableDate(dto.getDMCProbableDate())
												                        .DMCActualDate(dto.getDMCActualDate())
												                        .SanctionProbableDate(dto.getSanctionProbableDate())
												                        .SanctionActualDate(dto.getSanctionActualDate())
												                        .Revision(dto.getRevision())
												                        .Remarks(dto.getRemarks())
												                        .ModifiedBy(dto.getModifiedBy())
												                        .ModifiedDate(dto.getModifiedDate())
												                        .IsActive(dto.getIsActive())
												                        .build())
												                .collect(Collectors.toList());
	
	            // Save all milestone revisions to the database
	            pfmsInitiationMilestoneRevRepo.saveAll(msRevList);
        	}

            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(new Date() + " Inside MSServiceImpl saveAllInitiationProjectsMSRevData " + e);
            return 0;
        }
    }
    
    // CCM COG Data Fetch
    public List<PFMSCCMDataDto> fetchCCMCOGDataFromLocation(String locationUri) throws Exception{
    	
    	ResponseEntity<List<PFMSCCMDataDto>> response = restTemplate.exchange(locationUri, HttpMethod.GET, null, new ParameterizedTypeReference<List<PFMSCCMDataDto>>() {});
    	
    	return response.getBody();  // Get data from the response
    }
    
    public long saveAllCCMCOGData(List<PFMSCCMDataDto> ccmCOGDtoList) throws Exception {
        try {
        	if(ccmCOGDtoList!=null && ccmCOGDtoList.size()>0) {
        		// Remove Existing CCM Data
	            pfmsCCMDataRepo.deleteAll();
	            
	            // Reset auto-increment to start from 1
	            pfmsCCMDataRepo.resetAutoIncrement();
	            
	            // Map PFMSCCMDataDto to PFMSCCMData using builder
	            List<PFMSCCMData> ccmDataList = ccmCOGDtoList.stream()
								                .map(dto -> PFMSCCMData.builder()
									                        //.CCMDataId(dto.getCCMDataId())
									                        .ClusterId(dto.getClusterId())
									                        .LabCode(dto.getLabCode())
									                        .ProjectId(dto.getProjectId())
									                        .ProjectCode(dto.getProjectCode())
									                        .BudgetHeadId(dto.getBudgetHeadId())
									                        .BudgetHeadDescription(dto.getBudgetHeadDescription())
									                        .AllotmentCost(dto.getAllotmentCost())
									                        .Expenditure(dto.getExpenditure())
									                        .Balance(dto.getBalance())
									                        .Q1CashOutGo(dto.getQ1CashOutGo())
									                        .Q2CashOutGo(dto.getQ2CashOutGo())
									                        .Q3CashOutGo(dto.getQ3CashOutGo())
									                        .Q4CashOutGo(dto.getQ4CashOutGo())
									                        .Required(dto.getRequired())
									                        .CreatedDate(dto.getCreatedDate())
									                        .build())
								                .collect(Collectors.toList());
	
	            // Save all CCM data to the database
	            pfmsCCMDataRepo.saveAll(ccmDataList);
        	}

            return 1;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(new Date() + " Inside MSServiceImpl saveAllCCMCOGData " + e);
            return 0;
        }
    }

    // Project Health Data Fetch
    public List<ProjectHealthDto> fetchProjectHealthDataFromLocation(String locationUri) throws Exception{
    	
    	ResponseEntity<List<ProjectHealthDto>> response = restTemplate.exchange(locationUri, HttpMethod.GET, null, new ParameterizedTypeReference<List<ProjectHealthDto>>() {});
    	
    	return response.getBody();  // Get data from the response
    }
    
    public long saveAllProjectHealthData(List<ProjectHealthDto> projectHealthDtoList) throws Exception {
        try {
        	if(projectHealthDtoList!=null && projectHealthDtoList.size()>0) {
        		// Remove Existing Project Health Data
        		projectHealthRepo.deleteAll();
                
                // Reset auto-increment to start from 1
        		projectHealthRepo.resetAutoIncrement();
        		
        		// Map ProjectHealthDto to ProjectHealth using builder
        		List<ProjectHealth> projectHealthDataList = projectHealthDtoList.stream()
										        			.map(dto -> ProjectHealth.builder()
												        				//.ProjectHealthId(dto.getProjectHealthId())
																		.LabCode(dto.getLabCode())
																		.ProjectId(dto.getProjectId())
																		.ProjectShortName(dto.getProjectShortName())
																		.ProjectCode(dto.getProjectCode())
																		.PDC(dto.getPDC())
																		.SanctionDate(dto.getSanctionDate())
																		.PMRCHeld(dto.getPMRCHeld())
																		.PMRCPending(dto.getPMRCPending())
																		.PMRCTotal(dto.getPMRCTotal())
																		.PMRCTotalToBeHeld(dto.getPMRCTotalToBeHeld())
																		.EBHeld(dto.getEBHeld())
																		.EBPending(dto.getEBPending())
																		.EBTotal(dto.getEBTotal())
																		.EBTotalToBeHeld(dto.getEBTotalToBeHeld())
																		.MilPending(dto.getMilPending())
																		.MilDelayed(dto.getMilDelayed())
																		.MilCompleted(dto.getMilCompleted())
																		.ActionPending(dto.getActionPending())
																		.ActionForwarded(dto.getActionForwarded())
																		.ActionDelayed(dto.getActionDelayed())
																		.ActionCompleted(dto.getActionCompleted())
																		.RiskCompleted(dto.getRiskCompleted())
																		.RiskPending(dto.getRiskPending())
																		.Expenditure(dto.getExpenditure())
																		.OutCommitment(dto.getOutCommitment())
																		.Dipl(dto.getDipl())
																		.Balance(dto.getBalance())
																		.ProjectType(dto.getProjectType())
																		.EndUser(dto.getEndUser())
																		.TodayChanges(dto.getTodayChanges())
																		.WeeklyChanges(dto.getWeeklyChanges())
																		.MonthlyChanges(dto.getMonthlyChanges())
																		.CreatedBy(dto.getCreatedBy())
																		.CreatedDate(dto.getCreatedDate())
																		.ModifiedBy(dto.getModifiedBy())
																		.ModifiedDate(dto.getModifiedDate())	
																		.PJBHeld(dto.getPJBHeld())
																		.PJBPending(dto.getPJBPending())
																		.PJBTotal(dto.getPJBTotal())
																		.PMBHeld(dto.getPMBHeld())
																		.PMBPending(dto.getPMBPending())
																		.PMBTotal(dto.getPMBTotal())
																		.ABHeld(dto.getABHeld())
																		.ABPending(dto.getABPending())
																		.ABTotal(dto.getABTotal())
																		.PJBTotalToBeHeld(dto.getPJBTotalToBeHeld())
																		.PMBTotalToBeHeld(dto.getPMBTotalToBeHeld())
																		.ABTotalToBeHeld(dto.getABTotalToBeHeld())
											        					.build())
										        			.collect(Collectors.toList());
        		
        		// Save all Project Health data to the database
        		projectHealthRepo.saveAll(projectHealthDataList);
        	}
            
            return 1;
        }catch (Exception e) {
            e.printStackTrace();
            logger.error(new Date() + " Inside MSServiceImpl saveAllProjectHealthData " + e);
            return 0;
        }
    } 

    // Project Hoa Data Fetch
    public List<ProjectHoaDto> fetchProjectHoaDataFromLocation(String locationUri) throws Exception{
    	
    	ResponseEntity<List<ProjectHoaDto>> response = restTemplate.exchange(locationUri, HttpMethod.GET, null, new ParameterizedTypeReference<List<ProjectHoaDto>>() {});
    	
    	return response.getBody();  // Get data from the response
    }
    
    public long saveAllProjectHoaData(List<ProjectHoaDto> projectHoaDtoList) throws Exception {
        try {
        	if(projectHoaDtoList!=null && projectHoaDtoList.size()>0) {
        		// Remove Existing Project Hoa Data
            	projectHoaRepo.deleteAll();
                
                // Reset auto-increment to start from 1
            	projectHoaRepo.resetAutoIncrement();
            	
            	// Map ProjectHealthDto to ProjectHealth using builder
            	List<ProjectHoa> projectHoaDataList = projectHoaDtoList.stream()
            											.map(dto -> ProjectHoa.builder()
	            													//.ProjectHoaId(dto.getProjectHoaId())
			            											.ProjectId(dto.getProjectId())
			            											.ProjectCode(dto.getProjectCode())
			            											.BudgetHeadId(dto.getBudgetHeadId())
			            											.ProjectSanctionId(dto.getProjectSanctionId())
			            											.BudgetItemId(dto.getBudgetItemId())
			            											.ReFe(dto.getReFe())
			            											.SanctionCost(dto.getSanctionCost())
			            											.Expenditure(dto.getExpenditure())
			            											.OutCommitment(dto.getOutCommitment())
			            											.Dipl(dto.getDipl())
			            											.Balance(dto.getBalance())
			            											.CreatedBy(dto.getCreatedBy())
			            											.CreatedDate(dto.getCreatedDate())
			            											.ModifiedBy(dto.getModifiedBy())
			            											.ModifiedDate(dto.getModifiedDate())
			            											.LabCode(dto.getLabCode())
            														.build())
            											.collect(Collectors.toList());
            	
            	// Save all Project Hoa data to the database
            	projectHoaRepo.saveAll(projectHoaDataList);
        	}
            
            return 1;
        }catch (Exception e) {
            e.printStackTrace();
            logger.error(new Date() + " Inside MSServiceImpl saveAllProjectHoaData " + e);
            return 0;
        }
    } 

    // Committee Schedule Data Fetch
    public List<CommitteeScheduleDto> fetchCommitteeScheduleDataFromLocation(String locationUri) throws Exception{
    	
    	ResponseEntity<List<CommitteeScheduleDto>> response = restTemplate.exchange(locationUri, HttpMethod.GET, null, new ParameterizedTypeReference<List<CommitteeScheduleDto>>() {});
    	
    	return response.getBody();  // Get data from the response
    }

    public long saveAllClusterCommitteeScheduleData(List<CommitteeScheduleDto> committeeScheduleDtoList) throws Exception {
        try {
        	if(committeeScheduleDtoList!=null && committeeScheduleDtoList.size()>0) {
        		// Remove Existing ClusterCommitteeSchedule Data
        		clusterCommitteeScheduleRepo.deleteAll();
                
                // Reset auto-increment to start from 1
        		clusterCommitteeScheduleRepo.resetAutoIncrement();
            	
            	// Map CommitteeScheduleDto to ClusterCommitteeSchedule using builder
            	List<ClusterCommitteeSchedule> committeeScheduleDataList = committeeScheduleDtoList.stream()
            											.map(dto -> ClusterCommitteeSchedule.builder()
	            													.ScheduleId(dto.getScheduleId())
	            													.LabCode(dto.getLabCode())
	            													.CommitteeId(dto.getCommitteeId())
	            													.CommitteeMainId(dto.getCommitteeMainId())
	            													.MeetingId(dto.getMeetingId())
	            													.ProjectId(dto.getProjectId())
	            													.DivisionId(dto.getDivisionId())
	            													.InitiationId(dto.getInitiationId())
	            													.CARSInitiationId(dto.getCARSInitiationId())
	            													.RODNameId(dto.getRODNameId())
	            													.ScheduleDate(dto.getScheduleDate())
	            													.ScheduleStartTime(dto.getScheduleStartTime())
	            													.ScheduleFlag(dto.getScheduleFlag())
	            													.ScheduleSub(dto.getScheduleSub())
	            													.KickOffOtp(dto.getKickOffOtp())
	            													.MeetingVenue(dto.getMeetingVenue())
	            													.Confidential(dto.getConfidential())
	            													.Reference(dto.getReference())
	            													.PMRCDecisions(dto.getPMRCDecisions())
	            													.BriefingPaperFrozen(dto.getBriefingPaperFrozen())
	            													.MinutesFrozen(dto.getMinutesFrozen())
	            													.PresentationFrozen(dto.getPresentationFrozen())
	            													.BriefingStatus(dto.getBriefingStatus())
	            													.ScheduleType(dto.getScheduleType())
	            													.CreatedBy(dto.getCreatedBy())
	            													.CreatedDate(dto.getCreatedDate())
	            													.ModifiedBy(dto.getModifiedBy())
	            													.ModifiedDate(dto.getModifiedDate())
	            													.IsActive(dto.getIsActive())
            														.build())
            											.collect(Collectors.toList());
            	
            	// Save all ClusterCommitteeSchedule data to the database
            	clusterCommitteeScheduleRepo.saveAll(committeeScheduleDataList);
        	}
            
            return 1;
        }catch (Exception e) {
            e.printStackTrace();
            logger.error(new Date() + " Inside MSServiceImpl saveAllClusterCommitteeScheduleData " + e);
            return 0;
        }
    } 

	@Override
	public long syncDataFromClusterLabs() throws Exception {
		try {
			List<EmployeeDto> empDtoList = new ArrayList<>();
			List<ProjectMasterDto> projectDtoList = new ArrayList<>();
			List<PfmsInitiationDto> initiationDtoList = new ArrayList<>();
			List<PfmsInitiationMilestoneDto> initiationMSDtoList = new ArrayList<>();
			List<PfmsInitiationMilestoneRevDto> initiationMSRevDtoList = new ArrayList<>();
			List<PFMSCCMDataDto> ccmCOGDtoList = new ArrayList<>();
			List<ProjectHealthDto> projectHealthDtoList = new ArrayList<>();
			List<ProjectHoaDto> projectHoaDtoList = new ArrayList<>();
			List<CommitteeScheduleDto> committeeScheduleDtoList = new ArrayList<>();
			
			
			//List<LabMaster> labList = dao.getAllLabList().stream().filter(lab -> lab.getClusterId()==Long.parseLong(clusterid)).collect(Collectors.toList());
			List<LabMaster> labList = dao.getAllLabList();
			
    		labList.forEach(labMaster -> {
    			// Fetch data from each location 
    			if(labMaster.getLabURI()!=null && !labMaster.getLabURI().isEmpty()) {
    				// Employee Data fetch
    				try {
						empDtoList.addAll(fetchEmpDataFromLocation(labMaster.getLabURI() + "/api/sync/employeeData"));
					} catch (Exception e) {
						e.printStackTrace();
					}
    				
    				// Project Data fetch
    				try {
						projectDtoList.addAll(fetchProjectDataFromLocation(labMaster.getLabURI() + "/api/sync/projectData"));
					} catch (Exception e) {
						e.printStackTrace();
					}
    				
    				// Initiation Project Data fetch
    				try {
    					initiationDtoList.addAll(fetchInitiationProjectDataFromLocation(labMaster.getLabURI() + "/api/sync/initiationProjectData"));
    				} catch (Exception e) {
    					e.printStackTrace();
    				}
    				
    				// Initiation Project Milestone (MS) Data fetch
    				try {
    					initiationMSDtoList.addAll(fetchInitiationProjectMSDataFromLocation(labMaster.getLabURI() + "/api/sync/initiationProjectMSData"));
    				} catch (Exception e) {
    					e.printStackTrace();
    				}
    				
    				// Initiation Project Milestone (MS) Revision Data fetch
    				try {
    					initiationMSRevDtoList.addAll(fetchInitiationProjectMSRevDataFromLocation(labMaster.getLabURI() + "/api/sync/initiationProjectMSRevData"));
    				} catch (Exception e) {
    					e.printStackTrace();
    				}
    				
    				// CCM COG Data fetch
    				try {
    					ccmCOGDtoList.addAll(fetchCCMCOGDataFromLocation(labMaster.getLabURI() + "/api/sync/ccmCOGData"));
    				} catch (Exception e) {
    					e.printStackTrace();
    				}
    				
    				// Project Health Data fetch
    				try {
    					projectHealthDtoList.addAll(fetchProjectHealthDataFromLocation(labMaster.getLabURI() + "/api/sync/projectHealthData"));
    				} catch (Exception e) {
    					e.printStackTrace();
    				}
    				
    				// Project Hoa Data fetch
    				try {
    					projectHoaDtoList.addAll(fetchProjectHoaDataFromLocation(labMaster.getLabURI() + "/api/sync/projectHoaData"));
    				} catch (Exception e) {
    					e.printStackTrace();
    				}
    				
    				// Committee Schedule Data fetch
    				try {
    					committeeScheduleDtoList.addAll(fetchCommitteeScheduleDataFromLocation(labMaster.getLabURI() + "/api/sync/committeeScheduleData"));
    				} catch (Exception e) {
    					e.printStackTrace();
    				}
    				
    			}
    		});
    		
    		saveAllClusterLabEmployeesData(empDtoList); // Save Employee Data
			saveAllProjectsData(projectDtoList); // Save Project Data
			saveAllInitiationProjectsData(initiationDtoList); // Save Initiation Project Data
			saveAllInitiationProjectsMSData(initiationMSDtoList); // Save Initiation Project Milestone Data
			saveAllInitiationProjectsMSRevData(initiationMSRevDtoList); // Save Initiation Project Milestone Revision Data
			saveAllCCMCOGData(ccmCOGDtoList); // Save CCM COG Data
			saveAllProjectHealthData(projectHealthDtoList); // Save Project Health Data
			saveAllProjectHoaData(projectHoaDtoList); // Save Project Hoa Data
			saveAllClusterCommitteeScheduleData(committeeScheduleDtoList); // Save Cluster Committee Schedule Data
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside MSServiceImpl syncDataFromClusterLabs "+e);
			return 0;
		}
	}
	
}
