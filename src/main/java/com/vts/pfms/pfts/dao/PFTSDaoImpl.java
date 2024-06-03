package com.vts.pfms.pfts.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.vts.pfms.pfts.dto.PFTSFileDto;
import com.vts.pfms.pfts.model.PFTSFile;
import com.vts.pfms.pfts.model.PftsFileOrder;

@Transactional
@Repository
public  class PFTSDaoImpl implements PFTSDao{

	
	@PersistenceContext
	EntityManager manager;
	
	
	private static final String PROJECTSLIST="SELECT projectid, projectcode, projectname FROM project_master";
	private static final String FILESTATUS="SELECT DISTINCT f.PftsFileId, f.DemandNo, f.DemandDate, f.EstimatedCost, f.ItemNomenclature, s.PftsStatus, s.PftsStageName, s.PftsStatusId,f.EnvisagedFlag,f.Remarks,f.demandtype FROM pfts_file f, pfts_status s WHERE f.ProjectId =:projectid AND f.PftsStatusId = s.PftsStatusId AND f.isactive = '1' UNION SELECT  f.PftsFileId, f.DemandNo, f.DemandDate, f.EstimatedCost, f.ItemNomenclature, NULL , NULL , NULL ,f.EnvisagedFlag,f.Remarks,f.demandtype FROM pfts_file f WHERE f.ProjectId =:projectid AND f.EnvisagedFlag='Y' AND f.isactive = '1'";
	private static final String PrevDemandFile ="SELECT ProjectId, DemandNo, DemandDate, ItemNomenclature, EstimatedCost FROM pfts_file WHERE ProjectId=:projectid";
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
//		if(!pfo.getIsPresent().equalsIgnoreCase("N")) {
//		String updateOrder="UPDATE pfts_file_order SET IsActive='0' WHERE PftsFileId=:PftsFileId";
//		Query query = manager.createNativeQuery(updateOrder);
//		query.setParameter("PftsFileId", pfo.getPftsFileId());
//		query.executeUpdate();
//		}
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
	
	
	private static final String GETPFTSCOUNT = "SELECT COUNT(PftsFileId) FROM pfts_file WHERE PftsFileId=:pftsFileId AND IsActive='1'";
	@Override
	public int getpftsFieldId(String pftsFileId) throws Exception {
		Query query=manager.createNativeQuery(GETPFTSCOUNT);
		query.setParameter("pftsFileId", pftsFileId);
		int result =Integer.parseInt(query.getSingleResult().toString());
		return result;
	}
	private static final String UPDATEENVI = "UPDATE pfts_file SET ItemNomenclature=:ItemNomenclature,EstimatedCost=:EstimatedCost,PrbDateOfInti=:PrbDateOfInti,Remarks=:Remarks,ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate WHERE PftsFileId=:PftsFileId";
	@Override
	public Long updatepftsEnvi(PFTSFile pf) throws Exception {
		Query query=manager.createNativeQuery(UPDATEENVI);
		query.setParameter("PftsFileId", pf.getPftsFileId());
		query.setParameter("EstimatedCost", pf.getEstimatedCost());
		query.setParameter("ItemNomenclature", pf.getItemNomenclature());
		query.setParameter("Remarks", pf.getRemarks());
		query.setParameter("PrbDateOfInti", pf.getPrbDateOfInti());
		query.setParameter("ModifiedBy", pf.getModifiedBy());
		query.setParameter("ModifiedDate", pf.getModifiedDate());
		//query.setParameter("EnvisagedStatus", pf.getEnvisagedStatus());
		
		return Long.valueOf(query.executeUpdate()) ;
	}
	private static final String GETENVIDATA ="SELECT PftsFileId,ItemNomenclature,EstimatedCost,PrbDateOfInti,EnvisagedStatus,Remarks FROM pfts_file WHERE PftsFileId=:PftsFileId";


	@Override
	public Object[] getEnviData(String PftsFileId)throws Exception
	{
		Query query=manager.createNativeQuery(GETENVIDATA);
		query.setParameter("PftsFileId", PftsFileId);
		return ( Object[])query.getSingleResult();
	}
	
	private static final String GETSTAGELIST="SELECT PftsStatusId, PftsStatus, PftsStageName FROM pfts_status  ORDER BY pftsstatusid ";
	@Override
	public List<Object[]> getpftsStageList() throws Exception {
		Query query=manager.createNativeQuery(GETSTAGELIST);
		return ( List<Object[]>)query.getResultList();
	}
	
	
	private static final String FILEVIEWLIST="SELECT f.PftsFileId, f.DemandNo, f.DemandDate, f.EstimatedCost, f.ItemNomenclature, s.PftsStatus,s.PftsStageName, s.PftsStatusId,f.EnvisagedFlag,f.Remarks,f.demandtype,f.projectid FROM pfts_file f, pfts_status s WHERE f.PftsFileId=:pftsfileid AND f.PftsStatusId = s.PftsStatusId";
	@Override
	public Object[] getpftsFileViewList(String procFileId) throws Exception {
		
		Query query = manager.createNativeQuery(FILEVIEWLIST);
		query.setParameter("pftsfileid", procFileId);
		
		return  (Object[])query.getSingleResult();
	}
	
	private static final String ORDERETAILSAJAX="SELECT a.PftsFileOrderId,b.PftsFileId,b.DemandType,b.DemandNo,b.PftsStatusId,b.projectid,a.OrderNo,a.OrderDate,a.DpDate,a.ItemFor,a.OrderCost,a.VendorName FROM pfts_file_order a, pfts_file b WHERE a.PftsFileId=b.PftsFileId AND a.IsActive='1' AND b.PftsFileId=:fileId";
	@Override
	public List<Object[]> getOrderDetailsAjax(String fileId) throws Exception {
		
		Query query = manager.createNativeQuery(ORDERETAILSAJAX);
		query.setParameter("fileId", fileId);
		return  (List<Object[]>)query.getResultList();
	}
	
	private static final String MANUALORDERSUBMIT=" UPDATE pfts_file_order SET OrderNo=:OrderNo,OrderDate=:OrderDate,OrderCost=:OrderCost,DpDate=:DpDate,ItemFor=:ItemFor,VendorName=:VendorName,ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate WHERE PftsFileOrderId=:PftsFileOrderId";
	@Override
	public long ManualOrderSubmit(PftsFileOrder order, String orderid) throws Exception {

		Query query = manager.createNativeQuery(MANUALORDERSUBMIT);
		query.setParameter("PftsFileOrderId", orderid);
		query.setParameter("OrderNo", order.getOrderNo());
		query.setParameter("OrderDate", order.getOrderDate());
		query.setParameter("OrderCost", order.getOrderCost());
		query.setParameter("DpDate", order.getDpDate());
		query.setParameter("ItemFor", order.getItemFor());
		query.setParameter("VendorName", order.getVendorName());
		query.setParameter("ModifiedBy", order.getModifiedBy());
		query.setParameter("ModifiedDate", order.getModifiedDate());
		return  query.executeUpdate();
	}
	
	private static final String MANUALDEMANDEDITSUBMIT="UPDATE pfts_file SET DemandNo=:DemandNo,DemandDate=:DemandDate,EstimatedCost=:EstimatedCost,ItemNomenclature=:ItemNomenclature,ModifiedBy=:ModifiedBy,ModifiedDate=:ModifiedDate WHERE PftsFileId=:fileId";
	@Override
	public long manualDemandEditSubmit(PFTSFileDto pftsDto) throws Exception {
		
		Query query = manager.createNativeQuery(MANUALDEMANDEDITSUBMIT);
		query.setParameter("DemandNo", pftsDto.getDemandNo());
		query.setParameter("DemandDate", pftsDto.getDemandDate());
		query.setParameter("EstimatedCost", pftsDto.getEstimatedCost());
		query.setParameter("ItemNomenclature", pftsDto.getItemNomenclature());
		query.setParameter("ModifiedBy", pftsDto.getModifiedBy());
		query.setParameter("ModifiedDate", pftsDto.getModifiedDate());
		query.setParameter("fileId", pftsDto.getPftsFileId());
		return  query.executeUpdate();
	}
	
	private static final String GETDEMANDNO="SELECT demandno FROM pfts_file WHERE isactive='1'";
	@Override
	public List<Object[]> getDemandNoList() throws Exception {
		Query query = manager.createNativeQuery(GETDEMANDNO);
		return (List<Object[]>)query.getResultList();
	}
	
	@Override
	public void updatePftsFileId(String fileId) throws Exception {
		// TODO Auto-generated method stub
		
			String updateOrder="UPDATE pfts_file_order SET IsActive='0' WHERE PftsFileId=:PftsFileId";
			Query query = manager.createNativeQuery(updateOrder);
			query.setParameter("PftsFileId", fileId);
			query.executeUpdate();
			
	}
}
