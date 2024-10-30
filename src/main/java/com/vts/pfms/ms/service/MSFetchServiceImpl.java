package com.vts.pfms.ms.service;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.committee.model.CommitteeSchedule;
import com.vts.pfms.login.PFMSCCMData;
import com.vts.pfms.login.ProjectHoa;
import com.vts.pfms.master.model.Employee;
import com.vts.pfms.ms.dao.CommitteeScheduleRepo;
import com.vts.pfms.ms.dao.EmployeeRepo;
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
import com.vts.pfms.project.dao.ProjectMasterRepo;
import com.vts.pfms.project.model.PfmsInitiation;
import com.vts.pfms.project.model.PfmsInitiationMilestone;
import com.vts.pfms.project.model.PfmsInitiationMilestoneRev;
import com.vts.pfms.project.model.ProjectHealth;
import com.vts.pfms.project.model.ProjectMaster;

@Service
public class MSFetchServiceImpl implements MSFetchService {

	private static final Logger logger = LogManager.getLogger(MSFetchServiceImpl.class);

	@Autowired
	private EmployeeRepo employeeRepo; 
	
	@Autowired
	private ProjectMasterRepo projectMasterRepo; 
	
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
	private CommitteeScheduleRepo committeeScheduleRepo; 
	
	@Override
	public List<EmployeeDto> getEmployeeData() throws Exception {
        List<Employee> dataEntities = employeeRepo.findAll();
        
        return dataEntities.stream()
                .map(entity -> EmployeeDto.builder()
			                    .EmpId(entity.getEmpId())
			                    .EmpNo(entity.getEmpNo())
			                    .Title(entity.getTitle())
			                    .Salutation(entity.getSalutation())
			                    .EmpName(entity.getEmpName())
			                    .DesigId(entity.getDesigId())
			                    .ExtNo(entity.getExtNo())
			                    .MobileNo(entity.getMobileNo())
			                    .DronaEmail(entity.getDronaEmail())
			                    .InternetEmail(entity.getInternetEmail())
			                    .Email(entity.getEmail())
			                    .DivisionId(entity.getDivisionId())
			                    .SrNo(entity.getSrNo())
			                    .IsActive(entity.getIsActive())
			                    .CreatedBy(entity.getCreatedBy())
			                    .CreatedDate(entity.getCreatedDate())
			                    .ModifiedBy(entity.getModifiedBy())
			                    .ModifiedDate(entity.getModifiedDate())
			                    .LabCode(entity.getLabCode())
			                    .SuperiorOfficer(entity.getSuperiorOfficer())
                    .build())
                .collect(Collectors.toList());
    }

	@Override
	public List<ProjectMasterDto> getProjectData() throws Exception {
	    List<ProjectMaster> dataEntities = projectMasterRepo.findAll();
	    
	    return dataEntities.stream()
	            .map(entity -> ProjectMasterDto.builder()
				                .ProjectId(entity.getProjectId())
				                .ProjectMainId(entity.getProjectMainId())
				                .ProjectCode(entity.getProjectCode())
				                .ProjectShortName(entity.getProjectShortName())
				                .ProjectImmsCd(entity.getProjectImmsCd())
				                .ProjectName(entity.getProjectName())
				                .ProjectDescription(entity.getProjectDescription())
				                .UnitCode(entity.getUnitCode())
				                .ProjectType(entity.getProjectType())
				                .SanctionNo(entity.getSanctionNo())
				                .SanctionDate(entity.getSanctionDate())
				                .TotalSanctionCost(entity.getTotalSanctionCost())
				                .SanctionCostRE(entity.getSanctionCostRE())
				                .SanctionCostFE(entity.getSanctionCostFE())
				                .PDC(entity.getPDC())
				                .ProjectDirector(entity.getProjectDirector())
				                .ProjectCategory(entity.getProjectCategory())
				                .ProjSancAuthority(entity.getProjSancAuthority())
				                .BoardReference(entity.getBoardReference())
				                .RevisionNo(entity.getRevisionNo())
				                .WorkCenter(entity.getWorkCenter())
				                .LabParticipating(entity.getLabParticipating())
				                .Objective(entity.getObjective())
				                .Deliverable(entity.getDeliverable())
				                .Scope(entity.getScope())
				                .Application(entity.getApplication())
				                .EndUser(entity.getEndUser())
				                .CreatedBy(entity.getCreatedBy())
				                .CreatedDate(entity.getCreatedDate())
				                .ModifiedBy(entity.getModifiedBy())
				                .ModifiedDate(entity.getModifiedDate())
				                .isActive(entity.getIsActive())
				                .IsMainWC(entity.getIsMainWC())
				                .LabCode(entity.getLabCode())
				                .IsCCS(entity.getIsCCS())
				                .build())
	            .collect(Collectors.toList());
	}

	@Override
	public List<PfmsInitiationDto> getInitiationProjectData() throws Exception {
	    List<PfmsInitiation> dataEntities = pfmsInitiationRepo.findAll();
	    
	    return dataEntities.stream()
	            .map(entity -> PfmsInitiationDto.builder()
			            		.InitiationId(entity.getInitiationId())
			                    .EmpId(entity.getEmpId())
			                    .LabCode(entity.getLabCode())
			                    .DivisionId(entity.getDivisionId())
			                    .ProjectProgramme(entity.getProjectProgramme())
			                    .ProjectTypeId(entity.getProjectTypeId())
			                    .ClassificationId(entity.getClassificationId())
			                    .ProjectShortName(entity.getProjectShortName())
			                    .ProjectTitle(entity.getProjectTitle())
			                    .ProjectCost(entity.getProjectCost())
			                    .FeCost(entity.getFeCost())
			                    .ReCost(entity.getReCost())
			                    .ProjectDuration(entity.getProjectDuration())
			                    .IsPlanned(entity.getIsPlanned())
			                    .IsMultiLab(entity.getIsMultiLab())
			                    .LabCount(entity.getLabCount())
			                    .Deliverable(entity.getDeliverable())
			                    .NodalLab(entity.getNodalLab())
			                    .Remarks(entity.getRemarks())
			                    .IsMain(entity.getIsMain())
			                    .MainId(entity.getMainId())
			                    .PCDuration(entity.getPCDuration())
			                    .IndicativeCost(entity.getIndicativeCost())
			                    .EmpId(entity.getEmpId())
			                    .PCRemarks(entity.getPCRemarks())
			                    .StartDate(entity.getStartDate()) 
			                    .User(entity.getUser())            
			                    .CreatedBy(entity.getCreatedBy())
			                    .CreatedDate(entity.getCreatedDate())
			                    .ModifiedBy(entity.getModifiedBy())
			                    .ModifiedDate(entity.getModifiedDate())
			                    .IsActive(entity.getIsActive())
			                    .build())
	            .collect(Collectors.toList());
	}

	@Override
	public List<PfmsInitiationMilestoneDto> getInitiationProjectMSData() throws Exception {
	    // Fetch all PfmsInitiationMilestone entities from the repository
	    List<PfmsInitiationMilestone> dataEntities = pfmsInitiationMilestoneRepo.findAll();

	    // Map each entity to a DTO and return the list of DTOs
	    return dataEntities.stream()
	            .map(entity -> PfmsInitiationMilestoneDto.builder()
			                    .InitiationMilestoneId(entity.getInitiationMilestoneId())
			                    .InitiationId(entity.getInitiationId())
			                    .PDRProbableDate(entity.getPDRProbableDate())
			                    .PDRActualDate(entity.getPDRActualDate())
			                    .TIECProbableDate(entity.getTIECProbableDate())
			                    .TIECActualDate(entity.getTIECActualDate())
			                    .CECProbableDate(entity.getCECProbableDate())
			                    .CECActualDate(entity.getCECActualDate())
			                    .CCMProbableDate(entity.getCCMProbableDate())
			                    .CCMActualDate(entity.getCCMActualDate())
			                    .DMCProbableDate(entity.getDMCProbableDate())
			                    .DMCActualDate(entity.getDMCActualDate())
			                    .SanctionProbableDate(entity.getSanctionProbableDate())
			                    .SanctionActualDate(entity.getSanctionActualDate())
			                    .Revision(entity.getRevision())
			                    .SetBaseline(entity.getSetBaseline())
			                    .CreatedBy(entity.getCreatedBy())
			                    .CreatedDate(entity.getCreatedDate())
			                    .ModifiedBy(entity.getModifiedBy())
			                    .ModifiedDate(entity.getModifiedDate())
			                    .IsActive(entity.getIsActive())
			                    .build())
	            .collect(Collectors.toList());
	}

	@Override
	public List<PfmsInitiationMilestoneRevDto> getInitiationProjectMSRevData() throws Exception {
	    // Fetch all PfmsInitiationMilestoneRev entities from the repository
	    List<PfmsInitiationMilestoneRev> dataEntities = pfmsInitiationMilestoneRevRepo.findAll();

	    // Map each entity to a DTO and return the list of DTOs
	    return dataEntities.stream()
	            .map(entity -> PfmsInitiationMilestoneRevDto.builder()
			                    .InitiationMileRevId(entity.getInitiationMileRevId())
			                    .InitiationMilestoneId(entity.getInitiationMilestoneId())
			                    .InitiationId(entity.getInitiationId())
			                    .PDRProbableDate(entity.getPDRProbableDate())
			                    .PDRActualDate(entity.getPDRActualDate())
			                    .TIECProbableDate(entity.getTIECProbableDate())
			                    .TIECActualDate(entity.getTIECActualDate())
			                    .CECProbableDate(entity.getCECProbableDate())
			                    .CECActualDate(entity.getCECActualDate())
			                    .CCMProbableDate(entity.getCCMProbableDate())
			                    .CCMActualDate(entity.getCCMActualDate())
			                    .DMCProbableDate(entity.getDMCProbableDate())
			                    .DMCActualDate(entity.getDMCActualDate())
			                    .SanctionProbableDate(entity.getSanctionProbableDate())
			                    .SanctionActualDate(entity.getSanctionActualDate())
			                    .Revision(entity.getRevision())
			                    .Remarks(entity.getRemarks())
			                    .ModifiedBy(entity.getModifiedBy())
			                    .ModifiedDate(entity.getModifiedDate())
			                    .IsActive(entity.getIsActive())
			                    .build())
	            .collect(Collectors.toList());
	}

	@Override
	public List<PFMSCCMDataDto> getCCMCOGData() throws Exception {
	    // Fetch all PFMSCCMData entities from the repository
	    List<PFMSCCMData> dataEntities = pfmsCCMDataRepo.findAll();
	    
	    // Map each entity to a DTO and return the list of DTOs
	    return dataEntities.stream()
	            .map(entity -> PFMSCCMDataDto.builder()
	                            .CCMDataId(entity.getCCMDataId())
	                            .ClusterId(entity.getClusterId())
	                            .LabCode(entity.getLabCode())
	                            .ProjectId(entity.getProjectId())
	                            .ProjectCode(entity.getProjectCode())
	                            .BudgetHeadId(entity.getBudgetHeadId())
	                            .BudgetHeadDescription(entity.getBudgetHeadDescription())
	                            .AllotmentCost(entity.getAllotmentCost())
	                            .Expenditure(entity.getExpenditure())
	                            .Balance(entity.getBalance())
	                            .Q1CashOutGo(entity.getQ1CashOutGo())
	                            .Q2CashOutGo(entity.getQ2CashOutGo())
	                            .Q3CashOutGo(entity.getQ3CashOutGo())
	                            .Q4CashOutGo(entity.getQ4CashOutGo())
	                            .Required(entity.getRequired())
	                            .CreatedDate(entity.getCreatedDate())
	                            .build())
	            .collect(Collectors.toList());
	}

	@Override
	public List<ProjectHealthDto> getProjectHealthData() throws Exception {
		// Fetch all ProjectHealth entities from the repository
		List<ProjectHealth> dataEntities = projectHealthRepo.findAll();
		
		// Map each entity to a DTO and return the list of DTOs
		return dataEntities.stream()
				.map(entity -> ProjectHealthDto.builder()
								.ProjectHealthId(entity.getProjectHealthId())
								.LabCode(entity.getLabCode())
								.ProjectId(entity.getProjectId())
								.ProjectShortName(entity.getProjectShortName())
								.ProjectCode(entity.getProjectCode())
								.PDC(entity.getPDC())
								.SanctionDate(entity.getSanctionDate())
								.PMRCHeld(entity.getPMRCHeld())
								.PMRCPending(entity.getPMRCPending())
								.PMRCTotal(entity.getPMRCTotal())
								.PMRCTotalToBeHeld(entity.getPMRCTotalToBeHeld())
								.EBHeld(entity.getEBHeld())
								.EBPending(entity.getEBPending())
								.EBTotal(entity.getEBTotal())
								.EBTotalToBeHeld(entity.getEBTotalToBeHeld())
								.MilPending(entity.getMilPending())
								.MilDelayed(entity.getMilDelayed())
								.MilCompleted(entity.getMilCompleted())
								.ActionPending(entity.getActionPending())
								.ActionForwarded(entity.getActionForwarded())
								.ActionDelayed(entity.getActionDelayed())
								.ActionCompleted(entity.getActionCompleted())
								.RiskCompleted(entity.getRiskCompleted())
								.RiskPending(entity.getRiskPending())
								.Expenditure(entity.getExpenditure())
								.OutCommitment(entity.getOutCommitment())
								.Dipl(entity.getDipl())
								.Balance(entity.getBalance())
								.ProjectType(entity.getProjectType())
								.EndUser(entity.getEndUser())
								.TodayChanges(entity.getTodayChanges())
								.WeeklyChanges(entity.getWeeklyChanges())
								.MonthlyChanges(entity.getMonthlyChanges())
								.CreatedBy(entity.getCreatedBy())
								.CreatedDate(entity.getCreatedDate())
								.ModifiedBy(entity.getModifiedBy())
								.ModifiedDate(entity.getModifiedDate())	
								.PJBHeld(entity.getPJBHeld())
								.PJBPending(entity.getPJBPending())
								.PJBTotal(entity.getPJBTotal())
								.PMBHeld(entity.getPMBHeld())
								.PMBPending(entity.getPMBPending())
								.PMBTotal(entity.getPMBTotal())
								.ABHeld(entity.getABHeld())
								.ABPending(entity.getABPending())
								.ABTotal(entity.getABTotal())
								.PJBTotalToBeHeld(entity.getPJBTotalToBeHeld())
								.PMBTotalToBeHeld(entity.getPMBTotalToBeHeld())
								.ABTotalToBeHeld(entity.getABTotalToBeHeld())
								.build())
				.collect(Collectors.toList());
	}
	
	@Override
	public List<ProjectHoaDto> getProjectHoaData() throws Exception {
		// Fetch all ProjectHealth entities from the repository
		List<ProjectHoa> dataEntities = projectHoaRepo.findAll();
		
		// Map each entity to a DTO and return the list of DTOs
		return dataEntities.stream()
				.map(entity -> ProjectHoaDto.builder()
								.ProjectHoaId(entity.getProjectHoaId())
								.ProjectId(entity.getProjectId())
								.ProjectCode(entity.getProjectCode())
								.BudgetHeadId(entity.getBudgetHeadId())
								.ProjectSanctionId(entity.getProjectSanctionId())
								.BudgetItemId(entity.getBudgetItemId())
								.ReFe(entity.getReFe())
								.SanctionCost(entity.getSanctionCost())
								.Expenditure(entity.getExpenditure())
								.OutCommitment(entity.getOutCommitment())
								.Dipl(entity.getDipl())
								.Balance(entity.getBalance())
								.CreatedBy(entity.getCreatedBy())
								.CreatedDate(entity.getCreatedDate())
								.ModifiedBy(entity.getModifiedBy())
								.ModifiedDate(entity.getModifiedDate())
								.LabCode(entity.getLabCode())
								.build())
				.collect(Collectors.toList());
	}

	@Override
	public List<CommitteeScheduleDto> getCommitteeScheduleData() throws Exception {
		// Fetch all CommitteeSchedule entities from the repository
		List<CommitteeSchedule> dataEntities = committeeScheduleRepo.findAll();
		
		// Map each entity to a DTO and return the list of DTOs
		return dataEntities.stream()
				.map(entity -> CommitteeScheduleDto.builder()
								.ScheduleId(entity.getScheduleId())
								.LabCode(entity.getLabCode())
								.CommitteeId(entity.getCommitteeId())
								.CommitteeMainId(entity.getCommitteeMainId())
								.MeetingId(entity.getMeetingId())
								.ProjectId(entity.getProjectId())
								.DivisionId(entity.getDivisionId())
								.InitiationId(entity.getInitiationId())
								.CARSInitiationId(entity.getCARSInitiationId())
								.RODNameId(entity.getRODNameId())
								.ScheduleDate(entity.getScheduleDate())
								.ScheduleStartTime(entity.getScheduleStartTime())
								.ScheduleFlag(entity.getScheduleFlag())
								.ScheduleSub(entity.getScheduleSub())
								.KickOffOtp(entity.getKickOffOtp())
								.MeetingVenue(entity.getMeetingVenue())
								.Confidential(entity.getConfidential())
								.Reference(entity.getReference())
								.PMRCDecisions(entity.getPMRCDecisions())
								.BriefingPaperFrozen(entity.getBriefingPaperFrozen())
								.MinutesFrozen(entity.getMinutesFrozen())
								.PresentationFrozen(entity.getPresentationFrozen())
								.BriefingStatus(entity.getBriefingStatus())
								.ScheduleType(entity.getScheduleType())
								.CreatedBy(entity.getCreatedBy())
								.CreatedDate(entity.getCreatedDate())
								.ModifiedBy(entity.getModifiedBy())
								.ModifiedDate(entity.getModifiedDate())
								.IsActive(entity.getIsActive())
								.build())
				.collect(Collectors.toList());
	}
}
