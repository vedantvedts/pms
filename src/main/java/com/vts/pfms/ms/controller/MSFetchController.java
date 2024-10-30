package com.vts.pfms.ms.controller;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.vts.pfms.ms.dto.CommitteeScheduleDto;
import com.vts.pfms.ms.dto.EmployeeDto;
import com.vts.pfms.ms.dto.PFMSCCMDataDto;
import com.vts.pfms.ms.dto.PfmsInitiationDto;
import com.vts.pfms.ms.dto.PfmsInitiationMilestoneDto;
import com.vts.pfms.ms.dto.PfmsInitiationMilestoneRevDto;
import com.vts.pfms.ms.dto.ProjectHealthDto;
import com.vts.pfms.ms.dto.ProjectHoaDto;
import com.vts.pfms.ms.dto.ProjectMasterDto;
import com.vts.pfms.ms.service.MSFetchService;

@RestController
@RequestMapping("/api/sync")
public class MSFetchController {

	private static final Logger logger = LogManager.getLogger(MSFetchController.class);
	
	@Autowired
    private MSFetchService service;  

    @GetMapping("/employeeData")
    public ResponseEntity<List<EmployeeDto>> fetchEmployeeData() throws Exception {
        List<EmployeeDto> data = service.getEmployeeData();
        return ResponseEntity.ok(data);  
    }
    
    @GetMapping("/projectData")
    public ResponseEntity<List<ProjectMasterDto>> fetchProjectData() throws Exception {
    	List<ProjectMasterDto> data = service.getProjectData();
    	return ResponseEntity.ok(data);  
    }
    
    @GetMapping("/initiationProjectData")
    public ResponseEntity<List<PfmsInitiationDto>> fetchInitiationProjectData() throws Exception {
    	List<PfmsInitiationDto> data = service.getInitiationProjectData();
    	return ResponseEntity.ok(data);  
    }
    
    @GetMapping("/initiationProjectMSData")
    public ResponseEntity<List<PfmsInitiationMilestoneDto>> fetchInitiationProjectMSData() throws Exception {
    	List<PfmsInitiationMilestoneDto> data = service.getInitiationProjectMSData();
    	return ResponseEntity.ok(data);  
    }
    
    @GetMapping("/initiationProjectMSRevData")
    public ResponseEntity<List<PfmsInitiationMilestoneRevDto>> fetchInitiationProjectMSRevData() throws Exception {
    	List<PfmsInitiationMilestoneRevDto> data = service.getInitiationProjectMSRevData();
    	return ResponseEntity.ok(data);  
    }
    
    @GetMapping("/ccmCOGData")
    public ResponseEntity<List<PFMSCCMDataDto>> fetchCCMCOGData() throws Exception {
    	List<PFMSCCMDataDto> data = service.getCCMCOGData();
    	return ResponseEntity.ok(data);  
    }
    
    @GetMapping("/projectHealthData")
    public ResponseEntity<List<ProjectHealthDto>> fetchProjectHealthData() throws Exception {
    	List<ProjectHealthDto> data = service.getProjectHealthData();
    	return ResponseEntity.ok(data);  
    }
    
    @GetMapping("/projectHoaData")
    public ResponseEntity<List<ProjectHoaDto>> fetchProjectHoaData() throws Exception {
    	List<ProjectHoaDto> data = service.getProjectHoaData();
    	return ResponseEntity.ok(data);  
    }
    
    @GetMapping("/committeeScheduleData")
    public ResponseEntity<List<CommitteeScheduleDto>> fetchCommitteeScheduleData() throws Exception {
    	List<CommitteeScheduleDto> data = service.getCommitteeScheduleData();
    	return ResponseEntity.ok(data);  
    }
    
}
