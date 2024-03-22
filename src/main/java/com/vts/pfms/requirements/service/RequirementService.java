package com.vts.pfms.requirements.service;

import java.util.List;

import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;

public interface RequirementService {

	List<Object[]> RequirementList(String initiationid, String projectId)throws Exception;

	long ProjectRequirementAdd(PfmsInitiationRequirementDto prd, String userId, String labCode)throws Exception;

}
