package com.vts.pfms.requirements.dao;

import java.util.List;

import com.vts.pfms.requirements.model.Abbreviations;
import com.vts.pfms.requirements.model.DocMembers;
import com.vts.pfms.requirements.model.TestAcceptance;
import com.vts.pfms.requirements.model.TestApproach;
import com.vts.pfms.requirements.model.TestPlanSummary;
import com.vts.pfms.requirements.model.TestScopeIntro;

public interface RequirementDao {

	List<Object[]> RequirementList(String initiationid, String projectId) throws Exception;

	
	public List<Object[]> AbbreviationDetails(String initiationId, String projectId) throws Exception;
	public long addAbbreviations(List<Abbreviations> iaList)throws Exception;
	public long AddreqMembers(DocMembers r)throws Exception;
	public List<Object[]> DocMemberList(String initiationid, String ProjectId) throws Exception;
	public Object[] TestScopeIntro(String initiationid, String projectId)throws Exception;
	public long TestScopeIntroSubmit(TestScopeIntro pr)throws Exception;
	public long TestScopeUpdate(TestScopeIntro pr, String attributes)throws Exception;
	public long addTestPlanSummary(TestPlanSummary rs) throws Exception;
	public long editTestPlanSummary(TestPlanSummary rs) throws Exception;
	public List<Object[]> getTestPlanDocumentSummary(String initiationid, String ProjectId) throws Exception;
	public long addTestApproch(TestApproach rs)throws Exception;
	public long editTestApproach(TestApproach rs)throws Exception;
	public List<Object[]> getApproach(String initiationid, String projectId)throws Exception;
	public long TestDocContentSubmit(TestApproach pr)throws Exception;
	public Object[] GetTestContent(String initiationid, String projectId)throws Exception;
	public List<Object[]> GetTestContentList(String initiationid, String projectId)throws Exception;
	public long TestDocContentUpdate(String initiationid, String projectId, String attributes, String details,String userId)throws Exception;
	public long TestDocContentUpdate(TestApproach pr, String attributes)throws Exception;
	public long TestContentUpdate(TestApproach pr, String attributes)throws Exception;
	public long insertTestAcceptanceFile(TestAcceptance re) throws Exception;
	public List<Object[]> GetAcceptanceTestingList(String initiationid, String projectId) throws Exception;
	public long AcceptanceUpdate(TestAcceptance pr, String details)throws Exception;
	public Object[] AcceptanceTestingList(String Testid) throws Exception;
	public Object[] AcceptanceTestingExcelData(String initiationId, String projectId)throws Exception;
	
}
