package com.vts.pfms.pfts.dao;

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



@Transactional
@Repository
public class FileTrackingDaoImpl implements FileTrackingDao 
{
	private static final Logger logger=LogManager.getLogger(FileTrackingDaoImpl.class);	
	@PersistenceContext
	EntityManager manager;
	
	@Override
	public  List<PftsDemandImms>  DemandImmsListForFileTrackingByDemandNo(String DemandNo) throws Exception
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
	public  List<PftsDemandImms>  DemandImmsListForFileTrackingByProjectCode(String ProjectCode) throws Exception
    {
		
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<PftsDemandImms> cq = cb.createQuery(PftsDemandImms.class);
		Root<PftsDemandImms> root = cq.from(PftsDemandImms.class);
		cq.select(root).where(cb.like(cb.lower(cb.trim(root.get("ProjectCode"))), "%"+ProjectCode.toLowerCase().trim()+"%"  ));
		TypedQuery<PftsDemandImms> q = manager.createQuery(cq);
		List<PftsDemandImms> list = q.getResultList();		
		return list;
    }
	
	@Override
	public  List<PftsDemandImms>  DemandImmsListForFileTrackingByItemNomenclature(String ItemNomenclature) throws Exception
    {
		
		CriteriaBuilder cb = manager.getCriteriaBuilder();
		CriteriaQuery<PftsDemandImms> cq = cb.createQuery(PftsDemandImms.class);
		Root<PftsDemandImms> root = cq.from(PftsDemandImms.class);
		cq.select(root).where(cb.like(cb.lower(cb.trim(root.get("ItemFor"))), "%"+ItemNomenclature.toLowerCase().trim()+"%"  ));
		TypedQuery<PftsDemandImms> q = manager.createQuery(cq);
		List<PftsDemandImms> list = q.getResultList();		
		return list;
    }
	
	private static final String CHECKINGDEMANDIDPRESENT = "select FileTrackingId,ForwardedBy from Pfts_FileTracking where DemandNo=:DemandNo";
	@Override
	public Object[] CheckingDemandIdPresent(String DemandNo) throws Exception
    {
		
		List<Object[]> returnlist=null;	    
	    Query query=manager.createNativeQuery(CHECKINGDEMANDIDPRESENT);
		query.setParameter("DemandNo",DemandNo);
		returnlist=( List<Object[]>) query.getResultList();
		if(returnlist.size()>0) {
			return returnlist.get(0);
		}else
		{
			return null;
		}
    }
	
	private static final String FILETRACKINGFLOWDETAILS = "SELECT a.FileTrackingTransactionId,a.FileTrackingId,d.empname AS ForwardedBy,e.empname AS ForwardedTo,a.ActionDate, b.FileStageName,c.EventName,a.Remarks,c.FileStageId, a.AckDate   FROM Pfts_FileTrackingTransaction a,Pfts_FileStage b,Pfts_FileEvents c ,employee d , employee e    WHERE b.FileStageId=c.FileStageId AND a.EventId=c.FileEventId AND a.ForwardedBy=d.empno AND a.ForwardedTo=e.empno AND a.FileTrackingId=:FileTrackingId ORDER BY a.FileTrackingTransactionId DESC";
	@Override
	public   List<Object[]> FileTrackingFlowDetails(String FileTrackingId) throws Exception
	{
		
		List<Object[]> returnlist=null;	    
	    Query query=manager.createNativeQuery(FILETRACKINGFLOWDETAILS);
		query.setParameter("FileTrackingId",FileTrackingId);
		returnlist=( List<Object[]>) query.getResultList();
		return returnlist;
	}
	
		
	private static final String DEMANDIMMSMAINDETAILSBYDEMANDID = "select DemandId,ItemFor,DemandNo,DemandDate,EstimatedCost from pfts_DemandImms  where DemandNo=:DemandNo";
	@Override
	public  Object[] DemandImmsMainDetailsByDemandId(String DemandNo) throws Exception
    {
		
		List<Object[]> returnlist=null;	    
	    Query query=manager.createNativeQuery(DEMANDIMMSMAINDETAILSBYDEMANDID);
		query.setParameter("DemandNo",DemandNo);
		returnlist=( List<Object[]>) query.getResultList();
		if(returnlist.size()>0) {
			return returnlist.get(0);
		}else
		{
			return null;
		}
    }
}
