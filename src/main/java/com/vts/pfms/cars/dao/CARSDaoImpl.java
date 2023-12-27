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

import com.vts.pfms.master.model.Employee;
import com.vts.pfms.cars.model.CARSInitiation;
import com.vts.pfms.cars.model.CARSInitiationTrans;
import com.vts.pfms.cars.model.CARSRSQR;
import com.vts.pfms.cars.model.CARSRSQRDeliverables;
import com.vts.pfms.cars.model.CARSRSQRMajorRequirements;
import com.vts.pfms.cars.model.CARSSoC;
import com.vts.pfms.cars.model.CARSSoCMilestones;
import com.vts.pfms.committee.model.PfmsNotification;

@Repository
@Transactional
public class CARSDaoImpl implements CARSDao{

	private static final Logger logger = LogManager.getLogger(CARSDaoImpl.class);
	
	@PersistenceContext
	EntityManager manager;

	private static final String CARSINITIATIONLIST = "SELECT a.CARSInitiationId,a.EmpId,a.CARSNo,a.InitiationDate,a.InitiationTitle,a.InitiationAim,a.Justification,a.FundsFrom,a.Duration,b.EmpName,c.CARSStatus,c.CARSStatusColor,c.CARSStatusCode FROM pfms_cars_initiation a,employee b,pfms_cars_approval_status c  WHERE a.EmpId=b.EmpId AND a.CARSStatusCode=c.CARSStatusCode AND a.IsActive=1 AND a.EmpId=:EmpId ORDER BY a.CARSInitiationId DESC";
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
	
	private static final String CARSRSQRDATA = "SELECT a.CARSRSQRId,a.CARSInitiationId,a.Introduction,a.ResearchOverview,a.Objectives,a.ProposedMandT,a.RSPScope,a.LRDEScope,a.Criterion,a.LiteratureRef,a.RSQRFreeze FROM pfms_cars_rsqr a WHERE CARSInitiationId=:CARSInitiationId AND IsActive=1";
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

	@Override
	public long addCARSInitiationTransaction(CARSInitiationTrans transaction) throws Exception {
		try {
			manager.persist(transaction);
			manager.flush();
			return transaction.getCARSInitiationTransId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addCARSInitiationTransaction "+e);
			return 0;
		}
	}
	
	private static final String GETEMPGDEMPID  ="SELECT emp.EmpNo,emp.EmpId,emp.EmpName FROM employee emp WHERE emp.EmpId=(SELECT c.GroupHeadId FROM employee a,division_master b,division_group c WHERE a.EmpId=:EmpId AND a.DivisionId=b.DivisionId AND b.GroupId=c.GroupId)";
	@Override
	public Object[] getEmpGDEmpId(String empId) throws Exception
	{
		try {			
			Query query= manager.createNativeQuery(GETEMPGDEMPID);
			query.setParameter("EmpId", empId);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO getEmpGDEmpId " + e);
			e.printStackTrace();
			return null;
		}		
	}
	
	private static final String GETEMPPDEMPID  ="SELECT a.ProjectCode,a.ProjectDirector,b.EmpName,a.ProjectShortName,a.ProjectName FROM project_master a,employee b WHERE a.ProjectId=:ProjectId AND a.ProjectDirector=b.EmpId";
	@Override
	public Object[] getEmpPDEmpId(String projectId) throws Exception
	{
		try {			
			Query query= manager.createNativeQuery(GETEMPPDEMPID);
			query.setParameter("ProjectId", projectId);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO getEmpPDEmpId " + e);
			e.printStackTrace();
			return null;
		}		
	}
	
	private static final String GETEMPDATA="FROM Employee WHERE EmpId=:EmpId";
	@Override
	public Employee getEmpData(String EmpId)throws Exception
	{
		Employee emp=null;
		try {
			Query query = manager.createQuery(GETEMPDATA);
			query.setParameter("EmpId", Long.parseLong(EmpId));
			emp = (Employee) query.getSingleResult();
			return emp;
		} catch (Exception e) {
			logger.error(new Date() + "Inside DAO getEmpData "+e);
			e.printStackTrace();
			return null;
		}				
	}
	
	@Override
	public long addNotifications(PfmsNotification notification) throws Exception {
		try {
			manager.persist(notification);
			manager.flush();
			return notification.getNotificationId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addNotifications "+e);
			return 0;
		}
	}
	
	private static final String GETEMPDETAILS  ="SELECT a.EmpId,a.EmpName,b.Designation,c.DivisionName,a.Title FROM employee a,employee_desig b,division_master c WHERE a.EmpId=:EmpId AND a.DesigId=b.DesigId AND a.DivisionId=c.DivisionId";
	@Override
	public Object[] getEmpDetailsByEmpId(String empId) throws Exception
	{
		try {			
			Query query= manager.createNativeQuery(GETEMPDETAILS);
			query.setParameter("EmpId", empId);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO getEmpDetailsByEmpId " + e);
			e.printStackTrace();
			return null;
		}		
	}
	
	private static final String CARSRSQRTRANSLIST = "SELECT tra.CARSInitiationTransId,emp.EmpId,emp.EmpName,des.Designation,tra.ActionDate,tra.Remarks,sta.CARSStatus,sta.CARSStatusColor FROM pfms_cars_initiation_trans tra,pfms_cars_approval_status sta,employee emp,employee_desig des,pfms_cars_initiation par WHERE par.CARSInitiationId = tra.CARSInitiationId AND tra.CARSStatusCode = sta.CARSStatusCode AND tra.CARSStatusCode IN('INI','FWD','AGD','RGD','DGD','APD','RPD','DPD') AND tra.ActionBy=emp.EmpId AND emp.DesigId = des.DesigId AND par.CARSInitiationId=:CARSInitiationId ORDER BY tra.ActionDate";
	@Override
	public List<Object[]> carsRSQRTransList(String carsInitiationId) throws Exception {
		
		try {
			Query query = manager.createNativeQuery(CARSRSQRTRANSLIST);
			query.setParameter("CARSInitiationId", carsInitiationId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			logger.info(new Date()+"Inside DAO carsRSQRTransList"+e);
			e.printStackTrace();
			return null;
		}
		
	}
	
	private static final String CARSTRANSAPPROVALDATA = "SELECT tra.CARSInitiationTransId,\r\n"
			+ "	(SELECT empno FROM pfms_cars_initiation_trans t , employee e  WHERE e.EmpId = t.ActionBy AND t.CARSStatusCode =  sta.CARSStatusCode AND t.CARSInitiationId=par.CARSInitiationId ORDER BY t.CARSInitiationTransId DESC LIMIT 1) AS 'empno',\r\n"
			+ "	(SELECT empname FROM pfms_cars_initiation_trans t , employee e  WHERE e.EmpId = t.ActionBy AND t.CARSStatusCode =  sta.CARSStatusCode AND t.CARSInitiationId=par.CARSInitiationId ORDER BY t.CARSInitiationTransId DESC LIMIT 1) AS 'empname',\r\n"
			+ "	(SELECT designation FROM pfms_cars_initiation_trans t , employee e,employee_desig des WHERE e.EmpId = t.ActionBy AND e.desigid=des.desigid AND t.CARSStatusCode =  sta.CARSStatusCode AND t.CARSInitiationId=par.CARSInitiationId ORDER BY t.CARSInitiationTransId DESC LIMIT 1) AS 'Designation',\r\n"
			+ "	MAX(tra.ActionDate) AS ActionDate,tra.Remarks,sta.CARSStatus,sta.CARSStatusColor,sta.CARSStatusCode \r\n"
			+ "	FROM pfms_cars_initiation_trans tra,pfms_cars_approval_status sta,employee emp,pfms_cars_initiation par\r\n"
			+ "	WHERE par.CARSInitiationId=tra.CARSInitiationId AND tra.CARSStatusCode =sta.CARSStatusCode AND tra.Actionby=emp.EmpId AND sta.CARSStatusCode IN ('FWD','AGD','APD','SFG','SFP') AND par.CARSInitiationId=:CARSInitiationId GROUP BY sta.CARSStatusCode ORDER BY ActionDate ASC";
	@Override
	public List<Object[]> carsTransApprovalData(String carsInitiationId) {
		
		try {
			Query query = manager.createNativeQuery(CARSTRANSAPPROVALDATA);
			query.setParameter("CARSInitiationId", carsInitiationId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			logger.info(new Date()+"Inside DAO carsTransApprovalData "+e);
			e.printStackTrace();
			return null;
		}
		
	}

	private static final String CARSRSQRREMARKSHISTORY  ="SELECT cat.CARSInitiationId,cat.Remarks,cs.CARSStatusCode,e.EmpName,ed.Designation FROM pfms_cars_approval_status cs,pfms_cars_initiation_trans cat,pfms_cars_initiation ca,employee e,employee_desig ed WHERE cat.ActionBy = e.EmpId AND e.DesigId = ed.DesigId AND cs.CARSStatusCode = cat.CARSStatusCode AND cs.CARSStatusCode IN('FWD','AGD','APD') AND ca.CARSInitiationId = cat.CARSInitiationId AND TRIM(cat.Remarks)<>'' AND ca.CARSInitiationId=:CARSInitiationId ORDER BY cat.ActionDate ASC";
	@Override
	public List<Object[]> carsRSQRRemarksHistory(String carsInitiationId) throws Exception
	{
		List<Object[]> list =new ArrayList<Object[]>();
		try {
			Query query= manager.createNativeQuery(CARSRSQRREMARKSHISTORY);
			query.setParameter("CARSInitiationId", carsInitiationId);
			list= (List<Object[]>)query.getResultList();
			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO carsRSQRRemarksHistory " + e);
			e.printStackTrace();
		}
		return list;
	}
	
	private static final String CARSRSQRPENDINGLIST  ="CALL pfms_cars_rsqr_pending(:EmpId);";
	@Override
	public List<Object[]> carsRSQRPendingList(String empId) throws Exception {
		try {			
			Query query= manager.createNativeQuery(CARSRSQRPENDINGLIST);
			query.setParameter("EmpId", Long.parseLong(empId));
			List<Object[]> list =  (List<Object[]>)query.getResultList();
				return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO rsqrPendingList " + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
		
	}
	
	private static final String CARSRSQRAPPROVEDLIST  ="CALL pfms_cars_rsqr_approved(:EmpId,:FromDate,:ToDate,:Type);";
	@Override
	public List<Object[]> carsRSQRApprovedList(String empId, String FromDate, String ToDate, String type) throws Exception {
		
		try {			
			Query query= manager.createNativeQuery(CARSRSQRAPPROVEDLIST);
			query.setParameter("EmpId", Long.parseLong(empId));
			query.setParameter("FromDate", FromDate);
			query.setParameter("ToDate", ToDate);
			query.setParameter("Type", type);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
				return list;
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO carsRSQRApprovedList " + e);
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}
	
	private static final String GETDPANDCEMPID  ="SELECT a.EmpId,a.EmpNo,a.EmpName,a.Title,c.Designation FROM employee a,login b,employee_desig c WHERE a.EmpId=b.EmpId AND a.DesigId=c.DesigId AND b.LoginType=:LoginType LIMIT 1";
	@Override
	public Object[] getEmpDataByLoginType(String loginType) throws Exception
	{
		try {			
			Query query= manager.createNativeQuery(GETDPANDCEMPID);
			query.setParameter("LoginType", loginType);
			List<Object[]> list =  (List<Object[]>)query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO getEmpDataByLoginType " + e);
			e.printStackTrace();
			return null;
		}		
	}

	@Override
	public CARSSoC getCARSSoCById(long carsSoCId) throws Exception{
		try {
			return manager.find(CARSSoC.class, carsSoCId);
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getCARSSoCById "+e);
			return new CARSSoC();
		}
	}
	
	@Override
	public long addCARSSoC(CARSSoC soc) throws Exception{
		try {
			manager.persist(soc);
			manager.flush();
			return soc.getCARSSoCId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addCARSSoC "+e);
			return 0;
		}
	}
	
	@Override
	public long editCARSSoC(CARSSoC soc) throws Exception{
		try {
			manager.merge(soc);
			manager.flush();
			return soc.getCARSSoCId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO editCARSSoC "+e);
			return 0;
		}
	}
	
	private static final String UPDATEINVFORSOODATE = "UPDATE pfms_cars_initiation SET InvForSoODate=:InvForSoODate WHERE CARSInitiationId=:CARSInitiationId AND IsActive=1";
	@Override
	public int invForSoODateSubmit(String carsInitiationId, String sooDate) throws Exception{
		try {
			Query query = manager.createNativeQuery(UPDATEINVFORSOODATE);
			query.setParameter("CARSInitiationId", carsInitiationId);
			query.setParameter("InvForSoODate", sooDate);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO invForSoODateSubmit "+e);
			return 0;
		}
	}
	
	private static final String CARSSOCBYINITIATIONID = "FROM CARSSoC WHERE CARSInitiationId=:CARSInitiationId AND IsActive=1";
	@Override
	public CARSSoC getCARSSoCByCARSInitiationId(long carsInitiationId) throws Exception{
		try {
			Query query = manager.createQuery(CARSSOCBYINITIATIONID);
			query.setParameter("CARSInitiationId", carsInitiationId);
			List<CARSSoC> list =(List<CARSSoC>) query.getResultList();
			if(list.size()>0) {
				return list.get(0);
			}else {
				return null;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getCARSSoCByCARSInitiationId "+e);
			return null;
		}
	}
	
	private static final String CARSRSQRFREEZE = "UPDATE pfms_cars_rsqr SET RSQRFreeze=:RSQRFreeze WHERE CARSInitiationId=:CARSInitiationId AND IsActive=1";
	@Override
	public int carsRSQRFreeze(long carsInitiationId, String filepath) throws Exception{
		try {
			Query query = manager.createNativeQuery(CARSRSQRFREEZE);
			query.setParameter("CARSInitiationId", carsInitiationId);
			query.setParameter("RSQRFreeze", filepath);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO carsRSQRFreeze "+e);
			return 0;
		}
	}
	
	private static final String CARSSOCREMARKSHISTORY  ="SELECT cat.CARSInitiationId,cat.Remarks,cs.CARSStatusCode,e.EmpName,ed.Designation FROM pfms_cars_approval_status cs,pfms_cars_initiation_trans cat,pfms_cars_initiation ca,employee e,employee_desig ed WHERE cat.ActionBy = e.EmpId AND e.DesigId = ed.DesigId AND cs.CARSStatusCode = cat.CARSStatusCode AND cs.CARSStatusCode NOT IN('FWD','AGD','APD') AND ca.CARSInitiationId = cat.CARSInitiationId AND TRIM(cat.Remarks)<>'' AND ca.CARSInitiationId=:CARSInitiationId ORDER BY cat.ActionDate ASC";
	@Override
	public List<Object[]> carsSoCRemarksHistory(String carsInitiationId) throws Exception
	{
		List<Object[]> list =new ArrayList<Object[]>();
		try {
			Query query= manager.createNativeQuery(CARSSOCREMARKSHISTORY);
			query.setParameter("CARSInitiationId", carsInitiationId);
			list= (List<Object[]>)query.getResultList();
			
		}catch (Exception e) {
			logger.error(new Date()  + "Inside DAO carsSoCRemarksHistory " + e);
			e.printStackTrace();
		}
		return list;
	}
	
	private static final String CARSSOCTRANSLIST = "SELECT tra.CARSInitiationTransId,emp.EmpId,emp.EmpName,des.Designation,tra.ActionDate,tra.Remarks,sta.CARSStatus,sta.CARSStatusColor FROM pfms_cars_initiation_trans tra,pfms_cars_approval_status sta,employee emp,employee_desig des,pfms_cars_initiation par WHERE par.CARSInitiationId = tra.CARSInitiationId AND tra.CARSStatusCode = sta.CARSStatusCode AND tra.CARSStatusCode NOT IN('INI','FWD','AGD','RGD','DGD','APD','RPD','DPD') AND tra.ActionBy=emp.EmpId AND emp.DesigId = des.DesigId AND par.CARSInitiationId=:CARSInitiationId ORDER BY tra.ActionDate";
	@Override
	public List<Object[]> carsSoCTransList(String carsInitiationId) throws Exception {
		
		try {
			Query query = manager.createNativeQuery(CARSSOCTRANSLIST);
			query.setParameter("CARSInitiationId", carsInitiationId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			logger.info(new Date()+"Inside DAO carsSoCTransList "+e);
			e.printStackTrace();
			return null;
		}
		
	}
	
	private static final String CARSTRANSALLLIST = "SELECT tra.CARSInitiationTransId,emp.EmpId,emp.EmpName,des.Designation,tra.ActionDate,tra.Remarks,sta.CARSStatus,sta.CARSStatusColor FROM pfms_cars_initiation_trans tra,pfms_cars_approval_status sta,employee emp,employee_desig des,pfms_cars_initiation par WHERE par.CARSInitiationId = tra.CARSInitiationId AND tra.CARSStatusCode = sta.CARSStatusCode AND tra.ActionBy=emp.EmpId AND emp.DesigId = des.DesigId AND par.CARSInitiationId=:CARSInitiationId ORDER BY tra.ActionDate";
	@Override
	public List<Object[]> carsTransAllList(String carsInitiationId) throws Exception {
		
		try {
			Query query = manager.createNativeQuery(CARSTRANSALLLIST);
			query.setParameter("CARSInitiationId", carsInitiationId);
			return (List<Object[]>)query.getResultList();
		}catch (Exception e) {
			logger.info(new Date()+"Inside DAO carsSoCTransAllList "+e);
			e.printStackTrace();
			return null;
		}
		
	}
	
	private static final String CARSSOCMILESTONESLIST = "FROM CARSSoCMilestones WHERE CARSInitiationId=:CARSInitiationId AND IsActive=1";
	@Override
	public List<CARSSoCMilestones> getCARSSoCMilestonesByCARSInitiationId(long carsInitiationId) throws Exception{
		try {
			Query query = manager.createQuery(CARSSOCMILESTONESLIST);
			query.setParameter("CARSInitiationId", carsInitiationId);
			return (List<CARSSoCMilestones>)query.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO getCARSSoCMilestonesByCARSInitiationId "+e);
			return null;
		}
	}
	
	@Override
	public long addCARSSoCMilestoneDetails(CARSSoCMilestones milestone) throws Exception {
		try {
			manager.persist(milestone);
			manager.flush();
			return milestone.getCARSSoCMilestoneId();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO addCARSSoCMilestoneDetails "+e);
			return 0;
		}
	}
	
	private static final String REMOVECARSSOCMILESTONEDETAILS = "UPDATE pfms_cars_soc_milestones SET IsActive=:IsActive WHERE CARSInitiationId=:CARSInitiationId";
	@Override
	public int removeCARSSoCMilestonesDetails(long carsInitiationId) throws Exception {
		try {
			Query query = manager.createNativeQuery(REMOVECARSSOCMILESTONEDETAILS);
			query.setParameter("IsActive", "0");
			query.setParameter("CARSInitiationId", carsInitiationId);
			return query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date()+" Inside DAO removeCARSSoCMilestonesDetails "+e);
			return 0;
		}
		
	}
}
