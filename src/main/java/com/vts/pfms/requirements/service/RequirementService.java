package com.vts.pfms.requirements.service;

import java.util.List;

public interface RequirementService {

	List<Object[]> RequirementList(String initiationid, String projectId)throws Exception;

}
