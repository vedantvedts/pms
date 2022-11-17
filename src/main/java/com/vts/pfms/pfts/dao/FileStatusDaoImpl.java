package com.vts.pfms.pfts.dao;

import java.math.BigInteger;
import java.sql.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.pfts.model.PftsDemandImms;
import com.vts.pfms.pfts.model.PftsEventCreator;
import com.vts.pfms.pfts.model.PftsFileEvents;
import com.vts.pfms.pfts.model.PftsFileMilestone;
import com.vts.pfms.pfts.model.PftsFileStage;
import com.vts.pfms.pfts.model.PftsFileTracking;
import com.vts.pfms.pfts.model.PftsFileTrackingTransaction;



@Transactional
@Repository
public class FileStatusDaoImpl implements FileStatusDao 
{
	private static final Logger logger=LogManager.getLogger(FileStatusDaoImpl.class);	
	@PersistenceContext
	EntityManager manager;
	 
	private static final String  GETRESULTASDEMANDNO = "SELECT DemandId , BudCatCd , BudHead , CancelDate , Comments, CreatedBy , CreatedDate , DemandCat ,DemandDate, DemandFlag , DemandMode , DemandNo , DemandingOfficer , DivisionCode , EmployeeNo , EstimatedCost , FbeItemSlNo , FileNo , FundCd , IsActive , ItemFor , ModifiedBy , ModifiedDate , ProjectCode FROM pfts_demandimms   WHERE LOWER(DemandNo) LIKE :DemandNo";
	private static final String  GETRESULTASFILENO = "SELECT DemandId , BudCatCd , BudHead , CancelDate ,Comments , CreatedBy, CreatedDate , DemandCat , DemandDate , DemandFlag , DemandMode , DemandNo , DemandingOfficer , DivisionCode , EmployeeNo, EstimatedCost , FbeItemSlNo , FileNo  FundCd , IsActive , ItemFor , ModifiedBy , ModifiedDate , ProjectCode FROM pfts_demandimms  WHERE LOWER(FileNo) LIKE :fileno";
	private static final String  GETRESULTASPERITEMSEARCH = "SELECT DemandId , BudCatCd , BudHead , CancelDate ,Comments , CreatedBy, CreatedDate , DemandCat , DemandDate , DemandFlag , DemandMode , DemandNo , DemandingOfficer , DivisionCode , EmployeeNo, EstimatedCost , FbeItemSlNo , FileNo  FundCd , IsActive , ItemFor , ModifiedBy , ModifiedDate , ProjectCode FROM pfts_demandimms  WHERE LOWER(ItemFor) LIKE :ItemFor";
	
	@Override
	public List<PftsDemandImms> getResultAsDemandNo(String DemandNo) throws Exception
	{
		
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<PftsDemandImms> cq = cb.createQuery(PftsDemandImms.class);
		Root<PftsDemandImms> root = cq.from(PftsDemandImms.class);
		cq.select(root).where(cb.like(cb.lower(cb.trim(root.get("DemandNo"))), "%"+DemandNo.toLowerCase().trim()+"%"  ));
		TypedQuery<PftsDemandImms> q = manager.createQuery(cq);
		List<PftsDemandImms> list = q.getResultList();
		
		return list;	
	}
	
	
	
	@Override
	public List<PftsDemandImms> getResultAsFileNo(String fileno) throws Exception
	{
		
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<PftsDemandImms> cq = cb.createQuery(PftsDemandImms.class);
		Root<PftsDemandImms> root = cq.from(PftsDemandImms.class);
		cq.select(root).where(cb.like(cb.lower(cb.trim(root.get("FileNo"))), "%"+fileno.toLowerCase().trim()+"%"  ));
		TypedQuery<PftsDemandImms> q = manager.createQuery(cq);
		List<PftsDemandImms> list = q.getResultList();
				
		return list;		
	}
	
	
	@Override
	public List<PftsDemandImms> getResultAsPerItemSearch(String ItemFor) throws Exception
	{
		
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<PftsDemandImms> cq = cb.createQuery(PftsDemandImms.class);
		Root<PftsDemandImms> root = cq.from(PftsDemandImms.class);
		cq.select(root).where(cb.like(cb.lower(cb.trim(root.get("ItemFor"))), "%"+ItemFor.toLowerCase().trim()+"%"));
		TypedQuery<PftsDemandImms> q = manager.createQuery(cq);
		List<PftsDemandImms> list = q.getResultList();
		return list;
		
	}	
	
	private static final String GETEVENTSTATUS="SELECT a.EventCreator, b.FileStageId, d.FileStageName, b.EventName, c.EventDate, c.Remarks, e.DemandNo, e.FileTrackingId, c.FileTrackingTransactionId, e.StatusId FROM pfts_eventcreator a, pfts_fileevents b, pfts_filetrackingtransaction c, pfts_filestage d, pfts_filetracking e WHERE e.DemandNo=:DemandNo AND e.FileTrackingId=c.FileTrackingId AND a.EventCreatorId=c.EventCreatorId AND b.FileEventId=c.EventId AND b.FileStageId=d.FileStageId ORDER BY c.EventDate DESC"; 
	@Override
	public List<Object[]> getEventStatus(String demandNo) throws Exception
	{
		
		List<Object[]> eventStatusList=null;	    
	    Query query=manager.createNativeQuery(GETEVENTSTATUS);
		query.setParameter("DemandNo",demandNo);
		eventStatusList=(List<Object[]>) query.getResultList();
		return eventStatusList;
	          
	}
	
	@Override
	public List<PftsFileEvents> getEvent(String FtUserType) throws Exception
	{
	        
			
			CriteriaBuilder cb = manager.getCriteriaBuilder();
			CriteriaQuery<PftsFileEvents> cq = cb.createQuery(PftsFileEvents.class);
			Root<PftsFileEvents> root = cq.from(PftsFileEvents.class);
			
			cq.select(root).where(cb.equal(root.get("MilestoneFlag"), "Y"));
			
			TypedQuery<PftsFileEvents> q = manager.createQuery(cq);
			List<PftsFileEvents> list = q.getResultList();
			return list;
	  
	}
	
	@Override
	public  List<PftsEventCreator> getEventCreator(char userType) throws Exception
	{
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<PftsEventCreator> cq = cb.createQuery(PftsEventCreator.class);
		Root<PftsEventCreator> root = cq.from(PftsEventCreator.class);
		cq.select(root).where(cb.equal(root.get("userType"), userType));
		TypedQuery<PftsEventCreator> q = manager.createQuery(cq);
		List<PftsEventCreator> list = q.getResultList();
		return list;
	}
	
	private static final String GETSUPPLYORDERFROMMILESTONE="SELECT a.SoNo, a.FileTrackingOrderId, b.IsActive FROM pfts_filetrackingorder a, pfts_filemilestone b WHERE a.DemandNo=:DemandNo AND b.FileTrackingOrderId=a.FileTrackingOrderId ORDER BY FileTrackingOrderId DESC"; 
	@Override
	public List<Object[]> getSupplyOrderFromMilestone(String demandNo) throws Exception
	{
		
		List<Object[]> resultlist=null;	    
	    Query query=manager.createNativeQuery(GETSUPPLYORDERFROMMILESTONE);
		query.setParameter("DemandNo",demandNo);
		resultlist=(List<Object[]>) query.getResultList();
		return resultlist;
	          
	}
	
	private static final String GETSUPPLYORDERFORFILECLOSE="SELECT a.SoNo, a.FileTrackingOrderId, b.IsActive FROM pfts_filetrackingorder a, pfts_filemilestone b WHERE a.DemandNo=:DemandNo AND b.FileTrackingOrderId=a.FileTrackingOrderId AND b.IsActive=1 ORDER BY FileTrackingOrderId DESC";
	@Override
	public List<Object[]> getSupplyOrderForFileClose(String demandNo) throws Exception
	{
		
		List<Object[]> resultlist=null;	    
	    Query query=manager.createNativeQuery(GETSUPPLYORDERFORFILECLOSE);
		query.setParameter("DemandNo",demandNo);
		resultlist=(List<Object[]>) query.getResultList();
		return resultlist;
	          
	}
	
	private static final String GETEVENTDATE ="SELECT c.EventDate FROM  pfts_filetrackingtransaction c, pfts_filetracking e WHERE e.DemandNo=:DemandNo AND e.FileTrackingId=c.FileTrackingId ORDER BY c.FileTrackingTransactionId DESC";
	@Override
	public List<Date> getEventDate(String demandNo) throws Exception
	{
		
		List<Date> resultlist=null;	    
	    Query query=manager.createNativeQuery(GETEVENTDATE);
		query.setParameter("DemandNo",demandNo);
		resultlist=(List<Date>) query.getResultList();
		return resultlist;
	          
	}
	
	@Override
	public  List<PftsFileStage> getDetailsOfFileStage()throws Exception
    {
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<PftsFileStage> cq = cb.createQuery(PftsFileStage.class);
		Root<PftsFileStage> root = cq.from(PftsFileStage.class);
		cq.select(root);
		TypedQuery<PftsFileStage> q = manager.createQuery(cq);
		List<PftsFileStage> list = q.getResultList();
		return list;
    }
	private static final String CHECKISACTIVEFROMMILESTONE="SELECT IsActive FROM pfts_filemilestone WHERE DemandNo=:DemandNo AND SoNo IS NULL";
	
	@Override
	public List<Boolean> checkIsActiveFromMilestone(String demandNo) throws Exception
	{
		List<Boolean> resultlist=null;	    
	    Query query=manager.createNativeQuery(CHECKISACTIVEFROMMILESTONE);
		query.setParameter("DemandNo",demandNo);
		resultlist=(List<Boolean>) query.getResultList();
		return resultlist;
	}
	
	
	@Override
	public  List<PftsFileEvents> getEventAsperFilestageId(String filestageId)throws Exception
	{
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<PftsFileEvents> cq = cb.createQuery(PftsFileEvents.class);
		Root<PftsFileEvents> root = cq.from(PftsFileEvents.class);
		cq.select(root).where(cb.equal(root.get("FileStageId"), filestageId),cb.equal(root.get("MilestoneFlag"), "Y"));
		TypedQuery<PftsFileEvents> q = manager.createQuery(cq);
		List<PftsFileEvents> list = q.getResultList();
		return list;
	}

	private static final String GETFILETRACKINGID = "SELECT FileTrackingId FROM pfts_filetracking WHERE DemandNo = :DemandNo";
	@Override
	public BigInteger getFiletrackingId(String demandNo) throws Exception
	{
		try {
		    Query query=manager.createNativeQuery(GETFILETRACKINGID);
			query.setParameter("DemandNo",demandNo);
			BigInteger ret=(BigInteger)query.getSingleResult();
			return ret;
		}catch (Exception e) {
			logger.error(new java.util.Date() +"Inside DAO getFiletrackingId " + e);
			e.printStackTrace();
		}
		return null;
	}
	
	
	private static final String GETFILEMILESTONE = "SELECT FileMilestone FROM pfts_filemaster WHERE EventNumber=:EventNumber";
	@Override
	public String getFileMileStone(String eventNumber) throws Exception
	{
		
	    Query query=manager.createNativeQuery(GETFILEMILESTONE);
		query.setParameter("EventNumber",eventNumber);
		String ret=(String)query.getSingleResult();
		return ret;
	}
	
	private static final String CHECKFILEMILESTONE = "SELECT DemandNo,CaseWorker,FileTrackingOrderId,FileReceivedDate FROM pfts_filemilestone WHERE DemandNo=:DemandNo ORDER BY FileTrackingOrderId ASC";
	@Override
	public List<Object[]> checkFileMileStone(String demandNo)throws Exception
	{
		
		List<Object[]> resultlist=null;	    
	    Query query=manager.createNativeQuery(CHECKFILEMILESTONE);
		query.setParameter("DemandNo",demandNo);
		resultlist=(List<Object[]>) query.getResultList();
		return resultlist;
	}
	
	
	@Override
	public int updateFileMileStone(PftsFileMilestone fileMilestone,String column)throws Exception
	{
		
		final String UPDATEFILEMILESTONE ="UPDATE pfts_filemilestone SET "+column+"=:FileReceivedDate WHERE DemandNo=:DemandNo ";
		
		Query query=manager.createNativeQuery(UPDATEFILEMILESTONE);
		query.setParameter("FileReceivedDate",fileMilestone.getFileReceivedDate());
		query.setParameter("DemandNo",fileMilestone.getDemandNo());
		int ret=query.executeUpdate();
		return ret;
	}
	
	@Override
	public long addFileMileStone(PftsFileMilestone fileMilestone)throws Exception
	{
		
		manager.persist(fileMilestone);
		manager.flush();
		return (long)fileMilestone.getFileMilestoneId();
	}
	
	//String query="UPDATE FileTracking SET DemandNo='"+dto.getDemandNo()+"', ForwardedBy='"+dto.getForwardedBy()+"', ForwardedTo='"+dto.getForwardedTo()+"', EventId='"+dto.getEventId()+"',EventDate='"+dto.getEventDate()+"', Remarks='"+dto.getRemarks()+"', AckDate='"+dto.getAckDate()+"' WHERE FileTrackingId='"+filetrackingId+"'";
	
	
	private static final String ADDUPDATEEVENTSTATUS ="UPDATE pfts_FileTracking SET DemandNo=:DemandNo, ForwardedBy=:ForwardedBy , ForwardedTo=:ForwardedTo, EventId=:EventId ,EventDate=:EventDate , Remarks=:Remarks,AckDate=:AckDate  WHERE FileTrackingId=:FileTrackingId ";
	@Override
	public int addupdateEventStatus(PftsFileTracking dto,int filetrackingId,PftsFileTrackingTransaction tdto)throws Exception 
	{
		
		Query query=manager.createNativeQuery(ADDUPDATEEVENTSTATUS);
		query.setParameter("DemandNo",dto.getDemandNo());
		query.setParameter("ForwardedBy",dto.getForwardedBy());
		query.setParameter("ForwardedTo",dto.getForwardedTo());
		query.setParameter("EventId",dto.getEventId() );
		query.setParameter("EventDate",dto.getEventDate());
		query.setParameter("Remarks",dto.getRemarks());
		query.setParameter("AckDate",dto.getAckDate());
		query.setParameter("FileTrackingId",filetrackingId);
		
		int ret=query.executeUpdate();
		
		if(ret>0)
		{
			manager.persist(tdto);
			manager.flush();
		}
		return ret;
	}
	
	@Override
	public long addEventStatus(PftsFileTracking dto)throws Exception
	{
		
		manager.persist(dto);
		manager.flush();
		return (long)dto.getFileTrackingId();
	}
	
	@Override
	public int addTransactionEvent(PftsFileTrackingTransaction transactionDto) throws Exception
	{
		
		manager.persist(transactionDto);
		manager.flush();
		return transactionDto.getFileTrackingTransactionId();
	}
	
	private static final String GETEVENTSTATUSASPERFILETRACKINGID="SELECT a.EventCreator, b.FileStageId, d.FileStageName, b.FileEventId, b.EventName, c.EventDate, c.Remarks, e.DemandNo, e.FileTrackingId, c.FileTrackingTransactionId FROM pfts_eventcreator a, pfts_fileevents b, pfts_filetrackingtransaction c, pfts_filestage d, pfts_filetracking e WHERE c.FileTrackingTransactionId=:fttid AND e.FileTrackingId=c.FileTrackingId AND a.EventCreatorId=c.EventCreatorId AND b.FileEventId=c.EventId AND b.FileStageId=d.FileStageId";
	
	
	@Override
	public List<Object[]> getEventStatusasPerFileTrackingId(int id) throws Exception
	{		
		
		List<Object[]> resultlist=null;	    
	    Query query=manager.createNativeQuery(GETEVENTSTATUSASPERFILETRACKINGID);
		query.setParameter("fttid",id);
		resultlist=(List<Object[]>) query.getResultList();
		return resultlist;
			
	}
	
	
	private static final String UPDATEEVENTSTATUSAS="UPDATE pfts_filetrackingtransaction SET EventId=:EventId, EventDate= :EventDate,Remarks=:Remarks,ModifiedBy=:ModifiedBy, ModifiedDate=:ModifiedDate WHERE FileTrackingTransactionId=:FileTrackingTransactionId";
	@Override
	public int updateEventStatusas(int transactionId,int eventId,String eventDate,String modifiedBy,String moDate,String remarks, int fileTrackingId) throws Exception
	{
		Query query=manager.createNativeQuery(UPDATEEVENTSTATUSAS);
		query.setParameter("EventId", eventId);
		query.setParameter("EventDate", eventDate );
		query.setParameter("Remarks",remarks );
		query.setParameter("ModifiedBy", modifiedBy );
		query.setParameter("ModifiedDate",moDate );
		query.setParameter("FileTrackingTransactionId", transactionId);
		
		
		int ret=query.executeUpdate();
		return ret;
	}
	
	private static final String FILECLOSED="UPDATE pfts_filemilestone SET IsActive='0' WHERE FileTrackingOrderId=:FileTrackingOrderId";
	@Override
	public int fileClosed(PftsFileTrackingTransaction tranDto,PftsFileTracking trackingDto,int fileClosed) throws Exception
	{
		Query query=manager.createNativeQuery(FILECLOSED);
		query.setParameter("FileTrackingOrderId", fileClosed);
		
		manager.persist(tranDto);
        manager.merge(trackingDto);
		
		int ret=query.executeUpdate();
		return ret;
	}

	
	private static final String FILECLOSEDNOORDER="UPDATE pfts_filemilestone SET IsActive='0' WHERE DemandNo=:DemandNo";
	@Override
	public int fileClosedNoOrder(PftsFileTrackingTransaction tranDto,PftsFileTracking trackingDto,String demandNo) throws Exception
	{
		Query query=manager.createNativeQuery(FILECLOSEDNOORDER);
		query.setParameter("DemandNo", demandNo);
		
		manager.persist(tranDto);
        manager.merge(trackingDto);
		
		int ret=query.executeUpdate();
		return ret;
	}
	
	
	
	
}
