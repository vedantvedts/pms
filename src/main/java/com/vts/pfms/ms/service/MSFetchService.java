package com.vts.pfms.ms.service;

import java.util.List;

import com.vts.pfms.ms.dto.EmployeeDto;
import com.vts.pfms.ms.dto.PFMSCCMDataDto;
import com.vts.pfms.ms.dto.PfmsInitiationDto;
import com.vts.pfms.ms.dto.PfmsInitiationMilestoneDto;
import com.vts.pfms.ms.dto.PfmsInitiationMilestoneRevDto;
import com.vts.pfms.ms.dto.ProjectHealthDto;
import com.vts.pfms.ms.dto.ProjectHoaDto;
import com.vts.pfms.ms.dto.ProjectMasterDto;

public interface MSFetchService {

	public List<EmployeeDto> getEmployeeData() throws Exception;
	public List<ProjectMasterDto> getProjectData() throws Exception;
	public List<PfmsInitiationDto> getInitiationProjectData() throws Exception;
	public List<PfmsInitiationMilestoneDto> getInitiationProjectMSData() throws Exception;
	public List<PfmsInitiationMilestoneRevDto> getInitiationProjectMSRevData() throws Exception;
	public List<PFMSCCMDataDto> getCCMCOGData() throws Exception;
	public List<ProjectHealthDto> getProjectHealthData() throws Exception;
	public List<ProjectHoaDto> getProjectHoaData() throws Exception;

}
