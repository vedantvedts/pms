package com.vts.pfms.pfts.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.vts.pfms.pfts.model.PFTSFile;
import com.vts.pfms.pfts.model.PftsFileOrder;

@Transactional
@Repository
public  class PFTSDaoImpl implements PFTSDao{

	
	@PersistenceContext
	EntityManager manager;
	
	
	private static final String PROJECTSLIST="SELECT projectid, projectcode, projectname FROM project_master";
	private static final String FILESTATUS="SELECT f.PftsFileId, f.DemandNo, f.DemandDate, f.EstimatedCost, f.ItemNomenclature, s.PftsStatus, s.PftsStageName,  s.PftsStatusId  FROM pfts_file f, pfts_status s WHERE f.ProjectId=:projectid AND f.PftsStatusId=s.PftsStatusId AND s.PftsStatusId<16 and f.isactive='1'";
	private static final String  PrevDemandFile ="SELECT ProjectId, DemandNo, DemandDate, ItemNomenclature, EstimatedCost FROM pfts_file WHERE ProjectId=:projectid";
	private static final String StatusList="SELECT s.PftsStatusId, s.PftsStatus, s.PftsStageName FROM pfts_status s WHERE s.PftsStatusId > (SELECT PftsStatusId FROM pfts_file WHERE PftsFileId=:fileid) AND CASE WHEN (SELECT PftsStatusId FROM pfts_file WHERE PftsFileId=:fileid) < 10 THEN s.PftsStatusId <= 10 ELSE TRUE END ORDER BY pftsstatusid ";
	private static final String updateCostDetails="UPDATE pfts_file SET OrderNo=:orderno, OrderCost=:ordercost, DpDate=:dpdate WHERE PftsFileId=:fileid";
	private static final String INACTIVEFILE="UPDATE pfts_file SET isactive='0' where PftsFileId=:fileid ";
	private static final String PROJECTDATA="SELECT projectid, projectcode, projectname FROM project_master WHERE projectid=:projectid";
	
	
	@Override
	public List<Object[]> ProjectsList() throws Exception {

		Query query=manager.createNativeQuery(PROJECTSLIST);	   
		List<Object[]> ProjectsList=(List<Object[]>)query.getResultList();	
		
		return ProjectsList;
	}
	
	@Override
	public Object[] ProjectData(String projectid) throws Exception {

		Query query=manager.createNativeQuery(PROJECTDATA);	   
		query.setParameter("projectid", projectid);
		Object[] Project=(Object[])query.getSingleResult();	
		
		return Project;
	}
	
	@Override
	public List<Object[]> LoginProjectDetailsList(String empid,String Logintype ,String LabCode)throws Exception
	{
		Query query=manager.createNativeQuery("CALL Pfms_Emp_ProjectList(:empid,:logintype,:labcode);");
		query.setParameter("empid", empid);
		query.setParameter("logintype", Logintype);
		query.setParameter("labcode", LabCode);
		List<Object[]> LoginProjectIdList=(List<Object[]>)query.getResultList();
		return LoginProjectIdList;
	}
	

	
	@Override
	public List<Object[]> getFileStatusList(String projectId) throws Exception {
	
		Query query=manager.createNativeQuery(FILESTATUS);
		query.setParameter("projectid", projectId);
		List<Object[]> fileStatusList=(List<Object[]>)query.getResultList();	
		
		return fileStatusList;
	}
	
	
	@Override
	public List<Object[]> getprevDemandFile(String projectId)throws Exception{
		Query query=manager.createNativeQuery(PrevDemandFile);
		query.setParameter("projectid", projectId);
		List<Object[]> prevDemandFileList=(List<Object[]>)query.getResultList();	
		
		return prevDemandFileList;
	}
	

	@Override
	public Long addDemandfile(PFTSFile pf)throws Exception{
		
		manager.persist(pf);
		manager.flush();
		
		return pf.getPftsFileId();
	}
	
	
	@Override
	public List<Object[]> getStatusList(String fileid)throws Exception{
		Query query=manager.createNativeQuery(StatusList);
		query.setParameter("fileid", fileid);
		return (List<Object[]>)query.getResultList();
	}
	
	
	
	@Override
	public int upadteDemandFile(String fileId, String statusId, Date eventDateSql,String update,String remarks)throws Exception{
		
		String UpdateDemand="UPDATE pfts_file SET PftsStatusId=:statusid, "+update+"=:eventDate, Remarks=:remarks  WHERE PftsFileId=:fileid";
		Query query=manager.createNativeQuery(UpdateDemand);
		query.setParameter("fileid", fileId);
		query.setParameter("statusid", statusId);
		query.setParameter("eventDate", eventDateSql);
		query.setParameter("remarks", remarks);
		int result=query.executeUpdate();
		return result;
	}
	
	
	private static final String updateCostDetails1="UPDATE pfts_file SET OrderNo=:orderno, OrderCost=:ordercost, DpDate=:dpdate WHERE PftsFileId=:fileid";
	@Override
	public int updateCostOnDemand(String orderNo, String oderCostD, String fileId,Date dpDateSql)throws Exception{
		Query query=manager.createNativeQuery(updateCostDetails);
		query.setParameter("fileid", fileId);
		query.setParameter("orderno", orderNo);
		query.setParameter("ordercost", oderCostD);
		query.setParameter("dpdate", dpDateSql);
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public int FileInActive(String fileId, String userId) throws Exception {
		Query query=manager.createNativeQuery(INACTIVEFILE);
		query.setParameter("fileid", fileId);
		int result=query.executeUpdate();
		return result;
	}

	@Override
	public Long addDemandfileOrder(PftsFileOrder pfo) throws Exception {
		manager.persist(pfo);
		manager.flush();
		
		return pfo.getPftsFileOrderId();
	}
	
	private static final String GETFILEPDCINFO ="SELECT f.PftsFileId, f.DemandNo, f.DemandDate, f.EstimatedCost, f.ItemNomenclature,f.PDC,f.IntegrationDate  FROM pfts_file f WHERE  f.PftsFileId=:fileid ";
	@Override
	public Object[] getFilePDCInfo(String fileid)throws Exception
	{
		Query query=manager.createNativeQuery(GETFILEPDCINFO);
		query.setParameter("fileid", fileid);
		return ( Object[])query.getSingleResult();
	}
	
	@Override
	public PFTSFile getPftsFile(String pftsFileId) throws Exception {
		PFTSFile file= manager.find(PFTSFile.class, Long.parseLong(pftsFileId));
		
		return file;
	}
	
	@Override
	public long editPftsFile(PFTSFile file) throws Exception {
		manager.merge(file);
		manager.flush();
		return file.getPftsFileId();
	}
}
