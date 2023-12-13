package com.vts.pfms.cars.dao;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSRSQR;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;

@Repository
@Transactional
public class CARSDaoImpl implements CARSDao{

	private static final Logger logger = LogManager.getLogger(CARSDaoImpl.class);
	
	@PersistenceContext
	EntityManager manager;

	private static final String CARSINITIATIONLIST = "SELECT a.CARSInitiationId,a.EmpId,a.CARSNo,a.InitiationDate,a.InitiationTitle,a.InitiationAim,a.Justification,a.FundsFrom,a.Duration,a.CARSStatusCode,a.CARSStatusCodeNext,b.EmpName FROM pfms_cars_initiation a,employee b  WHERE a.EmpId=b.EmpId AND a.IsActive=1 AND a.EmpId=:EmpId";
	@Override
	public List<Object[]> carsInitiationList(String EmpId) throws Exception {
		try {
			Query query = manager.createNativeQuery(CARSINITIATIONLIST);
			query.setParameter("EmpId", EmpId);
			return (List<Object[]>) query.getResultList();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO carsInitiationList "+e);
			return new ArrayList<>();
		}
		
	}
	
	@Override
	public CARSInitiation getCARSInitiationById(long carsInitiationId) throws Exception{
		try {
			return manager.find(CARSInitiation.class, carsInitiationId);
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getCARSInitiationById "+e);
			return new CARSInitiation();
		}
	}
	
	@Override
	public long addCARSInitiation(CARSInitiation initiation) throws Exception{
		try {
			manager.persist(initiation);
			manager.flush();
			return initiation.getCARSInitiationId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addCARSInitiation "+e);
			return 0;
		}
	}
	
	@Override
	public long editCARSInitiation(CARSInitiation initiation) throws Exception{
		try {
			manager.merge(initiation);
			manager.flush();
			return initiation.getCARSInitiationId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO editCARSInitiation "+e);
			return 0;
		}
	}
	
	private static final String MAXCARSINITIATIONID="SELECT IFNULL(MAX(CARSInitiationId),0) AS 'MAX' FROM pfms_cars_initiation";
	@Override
	public long getMaxCARSInitiationId() throws Exception {
		
		try {
			Query query =  manager.createNativeQuery(MAXCARSINITIATIONID);
			BigInteger carsInitiationId=(BigInteger)query.getSingleResult();
			return carsInitiationId.longValue();
		}catch ( NoResultException e ) {
			logger.error(new Date() +"Inside DAO getMaxCARSInitiationId "+ e);
			return 0;
		}
	}
	
	private static final String CARSRSQRDATA = "SELECT a.CARSRSQRId,a.CARSInitiationId,a.Introduction,a.ResearchOverview,a.Objectives,a.ProposedMandT,a.RSPScope,a.LRDEScope,a.Criterion,a.LiteratureRef FROM pfms_cars_rsqr a WHERE CARSInitiationId=:CARSInitiationId AND IsActive=1";
	@Override
	public Object[] carsRSQRDetails(String carsinitiationid) throws Exception {
		try {
			Query query = manager.createNativeQuery(CARSRSQRDATA);
			query.setParameter("CARSInitiationId", carsinitiationid);
			List<Object[]> list = (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO carsRSQRDetails "+e);
			return null;
		}

	}
	
	@Override
	public long addCARSRSQRDetails(CARSRSQR carsRSQR) throws Exception{
		try {
			manager.persist(carsRSQR);
			manager.flush();
			return carsRSQR.getCARSRSQRId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addCARSRSQRDetails "+e);
			return 0;
		}
	}
	
	@Override
	public long editCARSRSQRDetails(CARSRSQR carsRSQR) throws Exception{
		try {
			manager.merge(carsRSQR);
			manager.flush();
			return carsRSQR.getCARSRSQRId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO editCARSRSQRDetails "+e);
			return 0;
		}
	}

	private static final String CARSRSQRBYCARSINITIATIONID = "FROM CARSRSQR WHERE CARSInitiationId=:CARSInitiationId AND IsActive=1";
	@Override
	public CARSRSQR getCARSRSQRByCARSInitiationId(long carsInitiationId) throws Exception{
		try {
			Query query = manager.createQuery(CARSRSQRBYCARSINITIATIONID);
			query.setParameter("CARSInitiationId", carsInitiationId);
			return (CARSRSQR)query.getSingleResult();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getCARSRSQRByCARSInitiationId "+e);
			return null;
		}
	}
	
	private static final String RSQRMAJORREQUIREMENTSLIST = "FROM CARSRSQRMajorRequirements WHERE CARSInitiationId=:CARSInitiationId AND IsActive=1";
	@Override
	public List<CARSRSQRMajorRequirements> getCARSRSQRMajorReqrByCARSInitiationId(long carsInitiationId) throws Exception{
		try {
			Query query = manager.createQuery(RSQRMAJORREQUIREMENTSLIST);
			query.setParameter("CARSInitiationId", carsInitiationId);
			return (List<CARSRSQRMajorRequirements>)query.getResultList();

		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getCARSRSQRMajorReqrByCARSInitiationId "+e);
			return null;
		}
	}
	
	private static final String RSQRDELIVERABLESLIST = "FROM CARSRSQRDeliverables WHERE CARSInitiationId=:CARSInitiationId AND IsActive=1";
	@Override
	public List<CARSRSQRDeliverables> getCARSRSQRDeliverablesByCARSInitiationId(long carsInitiationId) throws Exception{
		try {
			Query query = manager.createQuery(RSQRDELIVERABLESLIST);
			query.setParameter("CARSInitiationId", carsInitiationId);
			return (List<CARSRSQRDeliverables>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getCARSRSQRDeliverablesByCARSInitiationId "+e);
			return null;
		}
	}
	
	@Override
	public long addCARSRSQRMajorReqrDetails(CARSRSQRMajorRequirements major) throws Exception {
		try {
			manager.persist(major);
			manager.flush();
			return major.getMajorReqrId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addCARSRSQRMajorReqrDetails "+e);
			return 0;
		}
	}
	
	private static final String REMOVECARSRSQRMAJORREQRDETAILS = "UPDATE pfms_cars_rsqr_major_reqr SET IsActive=:IsActive WHERE CARSInitiationId=:CARSInitiationId";
	@Override
	public int removeCARSRSQRMajorReqrDetails(long carsInitiationId) throws Exception{
		try {
			Query query = manager.createNativeQuery(REMOVECARSRSQRMAJORREQRDETAILS);
			query.setParameter("IsActive", "0");
			query.setParameter("CARSInitiationId", carsInitiationId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO removeCARSRSQRMajorReqrDetails "+e);
			return 0;
		}
		
	}

	@Override
	public long addCARSRSQRDeliverableDetails(CARSRSQRDeliverables deliverable) throws Exception {
		try {
			manager.persist(deliverable);
			manager.flush();
			return deliverable.getDeliverablesId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addCARSRSQRDeliverableDetails "+e);
			return 0;
		}
	}

	private static final String REMOVECARSRSQRDELIVERABLEDETAILS = "UPDATE pfms_cars_rsqr_deliverables SET IsActive=:IsActive WHERE CARSInitiationId=:CARSInitiationId";
	@Override
	public int removeCARSRSQRDeliverableDetails(long carsInitiationId) throws Exception {
		try {
			Query query = manager.createNativeQuery(REMOVECARSRSQRDELIVERABLEDETAILS);
			query.setParameter("IsActive", "0");
			query.setParameter("CARSInitiationId", carsInitiationId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO removeCARSRSQRDeliverableDetails "+e);
			return 0;
		}
		
	}
}
