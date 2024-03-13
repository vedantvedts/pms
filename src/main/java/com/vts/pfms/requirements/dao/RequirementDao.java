package com.vts.pfms.requirements.dao;

import java.util.List;

public interface RequirementDao {

	List<Object[]> RequirementList(String initiationid, String projectId) throws Exception;

}
