package com.vts.pfms.admin.dao;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.admin.dto.EmployeeDesigDto;
import com.vts.pfms.admin.model.DivisionMaster;
import com.vts.pfms.admin.model.EmployeeDesig;
import com.vts.pfms.admin.model.Expert;
import com.vts.pfms.admin.model.PfmsFormRoleAccess;
import com.vts.pfms.admin.model.PfmsLoginRoleSecurity;
import com.vts.pfms.admin.model.PfmsRtmddo;
import com.vts.pfms.admin.model.PfmsStatistics;
import com.vts.pfms.login.Login;
import com.vts.pfms.login.PfmsLoginRole;
import com.vts.pfms.mail.MailConfiguration;
import com.vts.pfms.master.model.DivisionEmployee;

@Transactional
@Repository
public class AdminDaoImpl implements AdminDao{

	private static final Logger logger=LogManager.getLogger(AdminDaoImpl.class);
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	private static final String LOGINTYPELIST ="SELECT a.username,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'empname',c.divisionname,d.rolename,a.loginid FROM login a,employee b,division_master c,pfms_role_security d,pfms_login_role_security e WHERE a.empid=b.empid AND a.divisionid=c.divisionid AND a.loginid=e.loginid AND e.roleid=d.roleid AND a.isactive='1' AND a.pfms='Y' AND b.isactive=1 ORDER BY b.srno";
	private static final String EMPLOYEELIST ="SELECT a.loginid,a.username,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'empname' FROM login a, employee b WHERE a.empid=b.empid AND b.isactive=1 AND a.isactive='1' AND a.pfms='N' ORDER BY b.srno ";
	private static final String ROLELIST="SELECT RoleId, RoleName FROM  pfms_role_security ";
	private static final String LOGINTYPEADD="UPDATE login SET pfms=:pfms,modifiedby=:modifiedby,modifieddate=:modifieddate WHERE loginid=:loginid";
	private static final String LOGINTYPEREVOKE="UPDATE login SET pfms=:pfms,modifiedby=:modifiedby,modifieddate=:modifieddate WHERE loginid=:loginid";
	private static final String LOGINTYPEEDITDATA="SELECT a.username,CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'empname' ,c.divisionname,d.rolename,a.loginid FROM login a,employee b,division_master c,pfms_role_security d,pfms_login_role_security e WHERE a.empid=b.empid AND a.divisionid=c.divisionid AND a.loginid=e.loginid AND e.roleid=d.roleid AND a.isactive='1' AND a.pfms='Y' and a.loginid=:loginid ";
	private static final String LOGINTYPEEDIT="UPDATE pfms_login_role_security SET roleid=:roleid WHERE loginid=:loginid";
	private static final String PFMSLOGINREVOKE="DELETE from pfms_login_role_security WHERE loginid=:loginid";
	private static final String PFMSLOGINTYPEREVOKE="UPDATE login set modifiedby=:modifiedby, modifieddate=:modifieddate WHERE loginid=:loginid";
	private static final String EMPLOYEELISTALL="select a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname',b.designation,a.labcode FROM employee a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId";
	private static final String RTMDDO="SELECT 'empid1',a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname',b.designation,c.validfrom,c.validto  FROM employee a,employee_desig b,pfms_initiation_Approver c WHERE a.empid=c.empid AND c.isactive='1' AND a.isactive='1' AND a.DesigId=b.DesigId AND c.type='DO-RTMD'";
	//private static final String NOTIFICATIONLIST="SELECT notificationdate,notificationmessage,notificationurl,notificationid FROM pfms_notification WHERE empid=:empid and isactive=1";
	// new code
	private static final String NOTIFICATIONLIST="SELECT notificationdate, notificationmessage, notificationurl, notificationid FROM pfms_notification WHERE empid =:empid AND isactive = 1 ORDER BY CreatedDate DESC LIMIT 0, 1000";
	private static final String RTMDDOUPDATE="update pfms_initiation_Approver set isactive='0' WHERE Type=:type";
	private static final String DIVISIONLIST ="select divisionid,divisioncode from division_master where isactive='1'";
	private static final String LOGINDELETE="update login set isactive=:isactive,modifiedby=:modifiedby,modifieddate=:modifieddate where loginid=:loginid";
	private static final String AUDITSTAMPING="SELECT a.username,a.logindate, a.logindatetime,a.ipaddress, a.macaddress, ( CASE WHEN a.logouttype='L' THEN 'Logout' ELSE 'Session Expired' END ) AS logouttype, 	a.logoutdatetime FROM auditstamping a WHERE a.`LoginDate` BETWEEN :fromdate AND :todate AND a.loginid=:loginid ORDER BY a.`LoginDateTime` DESC ";
	private static final String USERNAMELIST="SELECT l.loginid, l.empid,l.username, CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'empname',e.labcode FROM login l , employee e WHERE e.isactive=1 AND l.isactive=1 AND l.EmpId=e.EmpId ORDER BY e.srno=0,e.srno"; 
	private static final String LOGINEDITDATA="FROM Login WHERE LOGINID=:LoginId";
	private static final String USERMANAGELIST = "SELECT a.loginid, a.username, b.divisionname,c.formrolename, a.Pfms , CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'empname', d.designation ,lt.logindesc ,e.empno ,e.labcode FROM login a , division_master b , form_role c , employee e, employee_desig d,  login_type lt WHERE a.divisionid=b.divisionid AND a.formroleid=c.formroleid AND a.isactive=1 AND a.empid=e.empid AND e.desigid=d.desigid AND a.logintype=lt.logintype ";
	private static final String USERNAMEPRESENTCOUNT ="select count(*) from login where username=:username and isactive='1'";
	private static final String EMPLOYEELIST1="SELECT empid,CONCAT(IFNULL(CONCAT(title,' '),''), empname) AS 'empname' FROM employee e WHERE e.isactive='1' AND labcode=:labcode AND empid NOT IN (SELECT empid FROM login WHERE isactive=1) ORDER BY srno ";
	private static final String LOGINUPDATE="update login set divisionid=:divisionid ,formroleid=:formroleid,logintype=:logintype,empid=:empid, Pfms=:pfms, modifiedby=:modifiedby,modifieddate=:modifieddate where loginid=:loginid";
	private final static String CHECKUSER = "SELECT COUNT(LoginId) FROM pfms_login_role_security WHERE LoginId=:loginid";
	private final static String UPDATEPFMSLOGINROLE="UPDATE pfms_login_role_security SET RoleId=:roleid WHERE LoginId=:loginid";
	private static final String CURRENTADDORTMT="SELECT r.RtmddoId, r.EmpId, r.ValidFrom, r.ValidTo, r.Type,r.labcode FROM pfms_initiation_Approver r WHERE r.IsActive=1 ORDER BY r.Type DESC";
	private static final String DIVISIONLIST1 ="SELECT a.divisionid,a.divisioncode,a.divisionname, CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'empname' ,c.groupname ,a.labcode, d.Designation FROM division_master a,employee b,division_group c, employee_desig d WHERE a.isactive='1' AND b.DesigId = d.DesigId and a.divisionheadid=b.empid AND a.groupid=c.groupid AND a.labcode=:labcode ORDER BY a.divisionid desc";
	private static final String DIVISIONADDCHECK="SELECT SUM(IF(DivisionCode =:divisionCode,1,0))   AS 'dCode',SUM(IF(DivisionName = :divisionName,1,0)) AS 'dName' FROM division_master where isactive=1 ";
	private static final String DIVISIONUPDATE="UPDATE division_master SET divisioncode=:divisioncode, divisionname=:divisionname, divisionheadid=:divisionheadid , groupid=:groupid, modifiedby=:modifiedby, modifieddate=:modifieddate, isactive=:isactive WHERE divisionid=:divisionid";
	private static final String DIVISIONGROUPLIST="SELECT a.groupid,a.groupname,a.labcode FROM division_group a WHERE a.isactive=1";
	private static final String DIVISIONHEADLIST="SELECT a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname',a.labcode,b.designation FROM employee a , employee_desig b WHERE  a.isactive=1 AND a.desigid=b.desigid";
	private static final String DIVISIONEDITDATA="SELECT d.divisionid,d.divisioncode, d.divisionname, d.divisionheadid, d.groupid, d.IsActive FROM division_master d WHERE d.divisionid=:divisionid ";
	private static final String DESIGNATIONDATA="SELECT desigid,desigcode,designation,desiglimit,DesigSr FROM employee_desig WHERE desigid=:desigid";
	private static final String DESIGNATIONLIST="SELECT desigid,desigcode,designation,desiglimit,DesigSr FROM employee_desig ORDER BY DesigSr";
	private static final String DESIGNATIONEDITSUBMIT="UPDATE employee_desig SET desigcode=:desigcode, designation=:designation ,desiglimit=:desiglimit WHERE  desigid=:desigid";
	private static final String DESIGNATIONCODECHECK="SELECT COUNT(desigcode),'desigcode' FROM employee_desig WHERE desigcode=:desigcode";
	private static final String DESIGNATIONCHECK="SELECT COUNT(designation),'designation' FROM employee_desig WHERE designation=:designation";
	private static final String DESIGNATIONCODEEDITCHECK="SELECT COUNT(desigcode),'desigcode' FROM employee_desig WHERE desigcode=:desigcode AND desigid<>:desigid";
	private static final String DESIGNATIONEDITCHECK="SELECT COUNT(designation),'designation' FROM employee_desig WHERE designation=:designation AND desigid<>:desigid";
	private static final String LISTOFDESIGSENIORITYNUMBER ="SELECT DesigSr,desigid FROM employee_desig WHERE DesigSr!=0 ORDER BY Desigsr ASC ";
	private static final String DESIGUPDATESRNO="UPDATE employee_desig SET DesigSr=:srno WHERE Desigid=:desigid";
	private static final String LOGINTYPEROLES="SELECT LoginTypeId,LoginType,LoginDesc FROM login_type";
	//private static final String FORMDETAILSLIST="SELECT a.formroleaccessid,a.logintype,b.formname,a.isactive,a.labhq FROM pfms_form_role_access a,pfms_form_detail b WHERE a.logintype=:logintype AND a.formdetailid=b.formdetailid AND CASE WHEN :moduleid <> 'A' THEN b.formmoduleid=:moduleid ELSE 1=1 END";
	private static final String FORMDETAILSLIST="SELECT b.formroleaccessid,b.logintype,a.formname,b.isactive ,b.labhq ,a.formdetailid FROM  (SELECT fd.formdetailid,fd.formmoduleid,fd.formname FROM pfms_form_detail fd WHERE  fd.isactive=1 AND CASE WHEN :moduleid <> 'A' THEN fd.formmoduleid =:moduleid ELSE 1=1 END) AS a LEFT JOIN  (SELECT b.formroleaccessid,b.logintype,a.formname,b.isactive ,b.labhq , b.formdetailid FROM pfms_form_detail a ,pfms_form_role_access b  WHERE a.formdetailid=b.formdetailid AND a.isactive=1 AND b.logintype=:logintype AND  CASE WHEN :moduleid <> 'A' THEN a.formmoduleid =:moduleid ELSE 1=1 END ) AS b ON a.formdetailid = b.formdetailid";
	private static final String FORMMODULELIST="SELECT FormModuleId,FormModuleName,ModuleUrl,IsNav,IsActive FROM pfms_form_module WHERE isactive=1";
	private static final String FORMROLEACTIVELIST="SELECT isactive FROM pfms_form_role_access WHERE formroleaccessid=:formroleaccessid";
	private static final String FORMROLEACTIVE0="UPDATE pfms_form_role_access SET isactive=:isactive WHERE formroleaccessid=:formroleaccessid";
	private static final String FORMROLEACTIVE1="UPDATE pfms_form_role_access SET isactive=:isactive WHERE formroleaccessid=:formroleaccessid";
	private static final String EMPLOYEEDATA ="SELECT a.empid, a.srno,a.empno,a.empname,a.desigid,a.divisionid ,b.groupid  FROM employee  a , division_master b WHERE a.divisionid =b.divisionid  AND a.empid=:empid";
	private static final String LOGINTYPELIST1="select logintype,logindesc,logintypeid from login_type";	
	private static final String LOGINEDITEMPLIST = "SELECT empid,CONCAT(IFNULL(CONCAT(title,' '),''), empname) AS 'empname' FROM employee WHERE labcode=:labcode ORDER BY srno ";
	private static final String GETEXPERTLIST= "SELECT e.ExpertId, e.ExpertNo,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.ExpertName)AS 'ExpertName', d.Designation , e.MobileNo, e.ExtNo, e.Email, e.Organization, e.IsActive FROM expert e, employee_desig d WHERE  e.DesigId=d.DesigId ";
	private static final String GETDESIGNATION = "SELECT DesigId, DesigCode, Designation FROM employee_desig";
	private static final String  ABILITYOFEXPERTNO ="SELECT COUNT(*)FROM expert WHERE ExpertNo=:EXPERTNO ";
	private static final String ABILITYOFEXTENSIONNO = "SELECT COUNT(*)FROM expert WHERE ExtNo=:EXTNO ";
	private static final String  EXPERTREVOKE = "UPDATE expert SET IsActive=:ISACTIVE,modifiedby=:MODIFIEDBY ,modifieddate=:MODIFIEDATE WHERE ExpertId=:EXPERTID ";
	private static final String  GETEDITDETAILS = "SELECT expertid , title , salutation , expertname, desigid , mobileno , email , organization , expertno FROM expert WHERE ExpertId=:EXPERTID";
	private static final String CHECKABILITY2 ="SELECT COUNT(*)FROM expert WHERE ExtNo=:EXTNO AND  ExpertId NOT IN (:ExpertId)";
	private static final String EDITEXPERT = "UPDATE expert SET title=:title,salutation=:salutation, ExpertName=:NAME, DesigId=:DESIGID, ExtNo=:EXTNO, MobileNo=:MOBLIENO, Email=:EMAIL, Organization=:ORGANIZATION ,ModifiedDate=:MODIFIEDDATE ,modifiedby=:MODIFEDBY WHERE ExpertId=:EXPERTID";
	private static final String CLUSTERLABLIST="SELECT labid,clusterid,labname,labcode FROM cluster_lab";
	private static final String LABHQCHANGE ="UPDATE pfms_form_role_access SET labhq=:labhqvalue WHERE formroleaccessid=:formroleaccessid ";



	@PersistenceContext
	EntityManager manager;

	@Override
	public List<Object[]> AllLabList() throws Exception 
	{
		Query query=manager.createNativeQuery(CLUSTERLABLIST);
		List<Object[]> ClusterLabList=(List<Object[]>)query.getResultList();
		return ClusterLabList;
	}


	@Override
	public List<Object[]> LoginTypeList() throws Exception {
		Query query=manager.createNativeQuery(LOGINTYPELIST);

		List<Object[]> LoginTypeList=(List<Object[]>)query.getResultList();		

		return LoginTypeList;
	}

	@Override
	public List<Object[]> EmployeeList() throws Exception {
		Query query=manager.createNativeQuery(EMPLOYEELIST);

		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();		

		return EmployeeList;
	}


	@Override
	public List<Object[]> LoginEditEmpList(String LabCode) throws Exception {
		Query query=manager.createNativeQuery(LOGINEDITEMPLIST);
		query.setParameter("labcode", LabCode);
		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();		

		return EmployeeList;
	}

	@Override
	public Object[] EmployeeData(String empid) throws Exception {
		Query query=manager.createNativeQuery(EMPLOYEEDATA);
		query.setParameter("empid",empid );
		List<Object[]> EmployeeData=(List<Object[]>)query.getResultList();		

		return EmployeeData.get(0);
	}

	@Override
	public List<Object[]> RoleList() throws Exception {
		Query query=manager.createNativeQuery(ROLELIST);
		List<Object[]> RoleList=(List<Object[]>)query.getResultList();		
		return RoleList;
	}

	@Override
	public List<Object[]> LoginTypeList1() throws Exception {
		Query query=manager.createNativeQuery(LOGINTYPELIST1);
		List<Object[]> LoginTypeList=(List<Object[]>)query.getResultList();		
		return LoginTypeList;
	}

	@Override
	public Long LoginTypeAddSubmit(PfmsLoginRoleSecurity loginrole,Login login) throws Exception {
		manager.persist(loginrole);

		Query query=manager.createNativeQuery(LOGINTYPEADD);
		query.setParameter("pfms", login.getPfms());
		query.setParameter("loginid", loginrole.getLoginId());
		query.setParameter("modifiedby", login.getModifiedBy());
		query.setParameter("modifieddate", login.getModifiedDate());

		query.executeUpdate();

		return loginrole.getLoginId();
	}

	@Override
	public Long LoginTypeRevoke(Login login) throws Exception {
		Query query=manager.createNativeQuery(LOGINTYPEREVOKE);
		query.setParameter("pfms", "N");
		query.setParameter("loginid", login.getLoginId());
		query.setParameter("modifiedby", login.getModifiedBy());
		query.setParameter("modifieddate", login.getModifiedDate());
		query.executeUpdate();

		Query query1=manager.createNativeQuery(PFMSLOGINREVOKE);
		query1.setParameter("loginid", login.getLoginId());
		query1.executeUpdate();	

		return login.getLoginId();
	}

	@Override
	public List<Object[]> LoginTypeEditData(String LoginId) throws Exception {
		Query query=manager.createNativeQuery(LOGINTYPEEDITDATA);
		query.setParameter("loginid", LoginId);
		List<Object[]> LoginTypeEditData=(List<Object[]>)query.getResultList();		

		return LoginTypeEditData;
	}

	@Override
	public Long LoginTypeEditSubmit(PfmsLoginRoleSecurity loginrole,Login login) throws Exception {
		Query query=manager.createNativeQuery(LOGINTYPEEDIT);
		query.setParameter("loginid", loginrole.getLoginId());
		query.setParameter("roleid", loginrole.getRoleId());
		query.executeUpdate();

		Query query1=manager.createNativeQuery(PFMSLOGINTYPEREVOKE);
		query1.setParameter("loginid", login.getLoginId());
		query1.setParameter("modifiedby", login.getModifiedBy());
		query1.setParameter("modifieddate", login.getModifiedDate());
		query1.executeUpdate();

		return loginrole.getLoginId();
	}

	@Override
	public List<Object[]> NotificationList(String EmpId) throws Exception {
		Query query=manager.createNativeQuery(NOTIFICATIONLIST);
		query.setParameter("empid", EmpId);
		List<Object[]> NotificationList=(List<Object[]>)query.getResultList();		

		return NotificationList;
	}

	@Override
	public List<Object[]> EmployeeListAll() throws Exception {
		Query query=manager.createNativeQuery(EMPLOYEELISTALL);

		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();	
		return EmployeeList;
	}

	@Override
	public List<Object[]> Rtmddo() throws Exception {
		Query query=manager.createNativeQuery(RTMDDO);

		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();	
		return EmployeeList;
	}

	@Override
	public long RtmddoInsert(PfmsRtmddo rtmddo) throws Exception {
		manager.persist(rtmddo);
		manager.flush();
		return rtmddo.getRtmddoId();
	}

	@Override
	public int RtmddoUpdate(String type) throws Exception {
		Query query=manager.createNativeQuery(RTMDDOUPDATE);
		query.setParameter("type", type);
		int count=query.executeUpdate();
		return count;
	}



	@Override
	public List<Object[]> GetExpertList() throws Exception {
		final Query query = this.manager.createNativeQuery(GETEXPERTLIST);
		final List<Object[]> ExpertList = (List<Object[]>)query.getResultList();
		return ExpertList;
	}

	private static final String GETEXPERTSCOUNT ="SELECT COUNT(*) FROM expert ";

	@Override
	public long GetExpertsCount() throws Exception {
		final Query query = manager.createNativeQuery(GETEXPERTSCOUNT);
		BigInteger Expertcount = (BigInteger)query.getSingleResult();
		return Expertcount.longValue()+1;
	}


	@Override
	public List<Object[]> GetDesignation() throws Exception {
		final Query query = this.manager.createNativeQuery(GETDESIGNATION);
		final List<Object[]> DesigList = (List<Object[]>)query.getResultList();
		return DesigList;
	}


	@Override
	public int abilityOfexpertNo( String expertNo) throws Exception {
		final Query query = this.manager.createNativeQuery(ABILITYOFEXPERTNO);
		query.setParameter("EXPERTNO", (Object)expertNo);
		final Object count = query.getSingleResult();
		final int countR = Integer.parseInt(count.toString());
		return countR;
	}


	@Override
	public int abilityOfextensionNo( String extensionNo) throws Exception {
		final Query query = this.manager.createNativeQuery(ABILITYOFEXTENSIONNO);
		query.setParameter("EXTNO", (Object)extensionNo);
		final Object count = query.getSingleResult();
		final int countR = Integer.parseInt(count.toString());
		return countR;
	}

	@Override
	public Long addExpert( Expert newExpert) throws Exception {
		manager.persist(newExpert);
		this.manager.flush();
		/*
		 * String updatequery1="UPDATE expert set title=NULL where expert=:empid";
		 * String updatequery2="UPDATE expert set salutation=NULL where  expert=:empid";
		 * 
		 * if(newExpert.getSalutation().length()<1) { Query
		 * query1=manager.createNativeQuery(updatequery2); query1.setParameter("empid",
		 * newExpert.getExpertId()); query1.executeUpdate(); }
		 * 
		 * if(newExpert.getTitle().length()<1) { Query
		 * query1=manager.createNativeQuery(updatequery1); query1.setParameter("empid",
		 * newExpert.getExpertId()); query1.executeUpdate(); }
		 */

		return newExpert.getExpertId();

	}


	@Override
	public Long ExpertRevoke( Expert expert) throws Exception {
		final Query query = this.manager.createNativeQuery(EXPERTREVOKE);
		query.setParameter("ISACTIVE", (Object)0);
		query.setParameter("MODIFIEDBY", (Object)expert.getModifiedBy());
		query.setParameter("MODIFIEDATE", (Object)expert.getModifiedDate());
		query.setParameter("EXPERTID", (Object)expert.getExpertId());
		final int s = query.executeUpdate();
		return Long.parseLong(new StringBuilder(String.valueOf(s)).toString());
	}



	@Override
	public List<Object[]> getEditDetails( String expertId) throws Exception {
		final Query query = this.manager.createNativeQuery(GETEDITDETAILS);
		query.setParameter("EXPERTID", (Object)expertId);

		final List<Object[]> details = (List<Object[]>)query.getResultList();
		return details;
	}



	@Override
	public int checkAbility2( String extensionNo, final String expertId) throws Exception {
		final Query query = this.manager.createNativeQuery(CHECKABILITY2);
		query.setParameter("EXTNO", (Object)extensionNo);
		query.setParameter("ExpertId", (Object)expertId);
		final Object count = query.getSingleResult();
		final int countR = Integer.parseInt(count.toString());
		return countR;
	}


	@Override
	public Long editExpert( Expert newExpert) throws Exception {
		final Query query = this.manager.createNativeQuery(EDITEXPERT);
		query.setParameter("title", newExpert.getTitle());
		query.setParameter("salutation", newExpert.getSalutation());
		query.setParameter("NAME", (Object)newExpert.getExpertName());
		query.setParameter("DESIGID", (Object)newExpert.getDesigId());
		query.setParameter("EXTNO", (Object)newExpert.getExtNo());
		query.setParameter("MOBLIENO", (Object)newExpert.getMobileNo());
		query.setParameter("EMAIL", (Object)newExpert.getEmail());
		query.setParameter("ORGANIZATION", (Object)newExpert.getOrganization());
		query.setParameter("MODIFIEDDATE", (Object)newExpert.getModifiedDate());
		query.setParameter("MODIFEDBY", (Object)newExpert.getModifiedBy());
		query.setParameter("EXPERTID", (Object)newExpert.getExpertId());
		final int s = query.executeUpdate();
		return newExpert.getExpertId();
	}


	@Override
	public List<Object[]> AuditStampingList(String loginid,LocalDate Fromdate,LocalDate Todate) throws Exception {

		Query query = manager.createNativeQuery(AUDITSTAMPING);
		query.setParameter("loginid", loginid);
		query.setParameter("fromdate", Fromdate);
		query.setParameter("todate", Todate);

		List<Object[]> AuditStampingList=(List<Object[]>) query.getResultList();

		return AuditStampingList;
	}

	@Override
	public List<Object[]> UsernameList() throws Exception {

		Query query = manager.createNativeQuery(USERNAMELIST);

		List<Object[]> UsernameList=(List<Object[]>) query.getResultList();

		return UsernameList;

	}

	@Override
	public List<Object[]> DivisionList() throws Exception {
		Query query = manager.createNativeQuery(DIVISIONLIST);

		List<Object[]> DivisionList = query.getResultList();
		return DivisionList;
	}


	@Override
	public Login UserManagerEditData(Long LoginId) throws Exception {
		Query query = manager.createQuery(LOGINEDITDATA);
		query.setParameter("LoginId", LoginId);
		Login UserManagerEditData = (Login) query.getSingleResult();

		return UserManagerEditData;
	}

	@Override
	public int UserManagerDelete(Login login) throws Exception {
		Query query = manager.createNativeQuery(LOGINDELETE);
		query.setParameter("isactive", 0);
		query.setParameter("loginid", login.getLoginId());
		query.setParameter("modifiedby", login.getModifiedBy());
		query.setParameter("modifieddate", login.getModifiedDate());
		int UserManagerDelete = (int) query.executeUpdate();
		return  UserManagerDelete;
	}

	@Override
	public List<Object[]> UserManagerList( ) throws Exception {
		Query query = manager.createNativeQuery(USERMANAGELIST);

		List<Object[]> UserManagerList = query.getResultList();
		return UserManagerList;
	}

	@Override
	public int UserNamePresentCount(String UserName) throws Exception {
		Query query = manager.createNativeQuery(USERNAMEPRESENTCOUNT);
		query.setParameter("username", UserName);

		BigInteger UserNamePresentCount = (BigInteger) query.getSingleResult();
		return   UserNamePresentCount.intValue();
	}

	@Override
	public List<Object[]> EmployeeList1(String LabCode) throws Exception {

		Query query=manager.createNativeQuery(EMPLOYEELIST1);
		query.setParameter("labcode", LabCode);
		List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();		
		return EmployeeList;
	}
	@Override
	public Long UserManagerInsert(Login login,DivisionEmployee logindivision) throws Exception {

		manager.persist(login);
		manager.persist(logindivision);
		manager.flush();

		return login.getLoginId();
	}

	@Override
	public int UserManagerUpdate(Login login) throws Exception {

		Query query = manager.createNativeQuery(LOGINUPDATE);
		query.setParameter("divisionid", login.getDivisionId());
		query.setParameter("formroleid", login.getFormRoleId());
		query.setParameter("loginid", login.getLoginId());
		query.setParameter("logintype", login.getLoginType());
		query.setParameter("empid", login.getEmpId());
		query.setParameter("pfms", login.getPfms());
		query.setParameter("modifiedby", login.getModifiedBy());
		query.setParameter("modifieddate", login.getModifiedDate());
		int UserManagerUpdate = (int) query.executeUpdate();

		return  UserManagerUpdate;
	}


	@Override
	public Long pfmsRoleInsert(PfmsLoginRole pfmsrole) throws Exception {
		manager.persist(pfmsrole);
		manager.flush();
		return pfmsrole.getLoginRoleSecurityId();
	}



	@Override
	public Object checkUser(Long loginId) throws Exception {
		Query query = manager.createNativeQuery(CHECKUSER);
		query.setParameter("loginid", loginId);
		Object flag = (Object) query.getSingleResult();
		return flag;
	}


	@Override
	public Long updatePfmsLoginRole(Long role, Long loginId) throws Exception {
		Query query = manager.createNativeQuery(UPDATEPFMSLOGINROLE);
		query.setParameter("roleid", role);
		query.setParameter("loginid", loginId);
		query.executeUpdate();
		return role;
	}

	@Override
	public List<Object[]> presentEmpList()throws Exception{
		Query query =manager.createNativeQuery(CURRENTADDORTMT);
		return query.getResultList();
	}



	@Override
	public List<Object[]> DesignationList()throws Exception
	{
		Query query =manager.createNativeQuery(DESIGNATIONLIST);
		return (List<Object[]>)query.getResultList();
	}


	@Override
	public Object[] DesignationData(String desigid)throws Exception
	{
		Query query =manager.createNativeQuery(DESIGNATIONDATA);
		query.setParameter("desigid", desigid);
		return (Object[])query.getResultList().get(0);
	}


	@Override
	public long DesignationEditSubmit(EmployeeDesigDto dto)throws Exception
	{
		Query query =manager.createNativeQuery(DESIGNATIONEDITSUBMIT);
		query.setParameter("desigid", dto.getDesigId());
		query.setParameter("desigcode",dto.getDesigCode());
		query.setParameter("designation",dto.getDesignation());
		query.setParameter("desiglimit",dto.getDesigLimit());
		return query.executeUpdate();
	}

	@Override
	public long DesignationAddSubmit(EmployeeDesig model) throws Exception
	{
		manager.persist(model);
		manager.flush();
		return model.getDesigId();
	}

	@Override
	public Object[] DesignationCodeCheck(String desigcode)throws Exception
	{
		Query query =manager.createNativeQuery(DESIGNATIONCODECHECK);
		query.setParameter("desigcode", desigcode);
		return (Object[])query.getSingleResult();
	}

	@Override
	public Object[] DesignationCheck(String designation)throws Exception
	{
		Query query =manager.createNativeQuery(DESIGNATIONCHECK);
		query.setParameter("designation", designation);
		return (Object[])query.getSingleResult();
	}


	@Override
	public Object[] DesignationCodeEditCheck(String desigcode,String desigid )throws Exception
	{
		Query query =manager.createNativeQuery(DESIGNATIONCODEEDITCHECK);
		query.setParameter("desigcode", desigcode);
		query.setParameter("desigid", desigid);
		return (Object[])query.getSingleResult();
	}

	@Override
	public Object[] DesignationEditCheck(String designation,String desigid)throws Exception
	{
		Query query =manager.createNativeQuery(DESIGNATIONEDITCHECK);
		query.setParameter("designation", designation);
		query.setParameter("desigid", desigid);
		return (Object[])query.getSingleResult();
	}



	@Override
	public List<Object[]> DivisionMasterList(String LabCode) throws Exception {
		Query query = manager.createNativeQuery(DIVISIONLIST1);
		query.setParameter("labcode", LabCode);
		List<Object[]> DivisionList = query.getResultList();
		return DivisionList;
	}

	@Override
	public List<Object[]> DivisionGroupList() throws Exception{

		Query query=manager.createNativeQuery(DIVISIONGROUPLIST);
		List<Object[]> DivisionGroupList=(List<Object[]>)query.getResultList();

		return DivisionGroupList;
	}

	@Override
	public List<Object[]> DivisionHeadList() throws Exception {

		Query query=manager.createNativeQuery(DIVISIONHEADLIST);
		List<Object[]> DivisionHeadList=(List<Object[]>)query.getResultList();

		return DivisionHeadList;
	}


	@Override
	public List<Object[]> DivisionMasterEditData(String DivisionId) throws Exception {

		Query query= manager.createNativeQuery(DIVISIONEDITDATA);
		query.setParameter("divisionid", DivisionId);
		List<Object[]> DivisionMasterEditData=(List<Object[]>) query.getResultList();

		return DivisionMasterEditData;
	}


	//	private static final String DivisionAddCheck="SELECT SUM(IF(DivisionCode =:divisionCode,1,0))   AS 'dCode',SUM(IF(DivisionName = :divisionName,1,0)) AS 'dName' FROM division_master where isactive=1 ";
	@Override
	public List<Object[]> DivisionAddCheck(String dCode,String dName) throws Exception
	{

		Query query=manager.createNativeQuery(DIVISIONADDCHECK);
		query.setParameter("divisionCode", dCode);
		query.setParameter("divisionName", dName);

		List<Object[]> DivisionAddCheck=(List<Object[]>)query.getResultList();

		return DivisionAddCheck;
	}


	@Override
	public long DivisionAddSubmit(DivisionMaster model) throws Exception
	{
		manager.persist(model);
		manager.flush();
		return model.getGroupId();
	}


	@Override
	public int DivisionMasterUpdate(DivisionMaster divisionmaster) throws Exception {

		Query query=manager.createNativeQuery(DIVISIONUPDATE);
		query.setParameter("divisioncode", divisionmaster.getDivisionCode());
		query.setParameter("divisionname", divisionmaster.getDivisionName());
		query.setParameter("divisionheadid", divisionmaster.getDivisionHeadId());
		query.setParameter("groupid", divisionmaster.getGroupId());
		query.setParameter("divisionid", divisionmaster.getDivisionId());
		query.setParameter("modifiedby", divisionmaster.getModifiedBy());
		query.setParameter("modifieddate", divisionmaster.getModifiedDate());
		query.setParameter("isactive", divisionmaster.getIsActive());
		int count = (int)query.executeUpdate();

		return count;
	}


	@Override
	public List<Object[]> DesigupdateAndGetList(Long desigid, String newSeniorityNumber)throws Exception
	{			
		Query query=manager.createNativeQuery(LISTOFDESIGSENIORITYNUMBER);
		List<Object[]> listSeni=(List<Object[]>)query.getResultList();

		Query updatequery=manager.createNativeQuery(DESIGUPDATESRNO);
		updatequery.setParameter("desigid", desigid);
		updatequery.setParameter("srno", newSeniorityNumber);  	   
		updatequery.executeUpdate();

		return listSeni;
	}

	@Override
	public int updateAllDesigSeniority(Long desigid, Long srno)throws Exception{
		Query updatequery=manager.createNativeQuery(DESIGUPDATESRNO);
		updatequery.setParameter("desigid", desigid);
		updatequery.setParameter("srno", srno);  	 
		return updatequery.executeUpdate();
	}

	@Override
	public List<Object[]> LoginTypeRoles() throws Exception {

		Query query=manager.createNativeQuery(LOGINTYPEROLES);
		List<Object[]> LoginTypeRoles=(List<Object[]>)query.getResultList();

		return LoginTypeRoles;
	}

	@Override
	public List<Object[]> FormDetailsList(String LoginType,String ModuleId) throws Exception {

		Query query=manager.createNativeQuery(FORMDETAILSLIST);
		query.setParameter("logintype", LoginType);
		query.setParameter("moduleid", ModuleId);
		List<Object[]> FormDetailsList=(List<Object[]>)query.getResultList();

		return FormDetailsList;
	}

	@Override
	public List<Object[]> FormModulesList() throws Exception {

		Query query=manager.createNativeQuery(FORMMODULELIST);
		List<Object[]> FormModulesList=(List<Object[]>)query.getResultList();

		return FormModulesList;
	}

	@Override
	public List<BigInteger> FormRoleActiveList(String formroleaccessid) throws Exception {

		Query query=manager.createNativeQuery(FORMROLEACTIVELIST);
		query.setParameter("formroleaccessid", formroleaccessid);
		List<BigInteger> FormRoleActiveList=(List<BigInteger>)query.getResultList();

		return FormRoleActiveList;
	}

	@Override
	public Long FormRoleActive(String formroleaccessid, Long Value) throws Exception {

		int count=0;


		if(Value.equals(1L)) {


			Query query=manager.createNativeQuery(FORMROLEACTIVE0);
			query.setParameter("formroleaccessid", formroleaccessid);
			query.setParameter("isactive", "0");
			count=query.executeUpdate();
		}
		if(Value.equals(0L)) {
			Query query=manager.createNativeQuery(FORMROLEACTIVE1);
			query.setParameter("formroleaccessid", formroleaccessid);
			query.setParameter("isactive", "1");
			count=query.executeUpdate();
		}

		return (long) count;
	}



	@Override
	public Long LabHqChange(String formroleaccessid, String Value) throws Exception{

		int count=0;

		Query query=manager.createNativeQuery(LABHQCHANGE);
		query.setParameter("formroleaccessid", formroleaccessid);
		query.setParameter("labhqvalue", Value);
		count=query.executeUpdate();

		return (long) count;

	}

	@Override
	public int checkavaibility(String logintype,String detailsid)throws Exception{
		Query query = manager.createNativeQuery("SELECT COUNT(formroleaccessid)  FROM `pfms_form_role_access` WHERE logintype=:logintype  AND  formdetailid=:detailsid");
		query.setParameter("logintype", logintype);
		query.setParameter("detailsid",detailsid );

		BigInteger result = (BigInteger) query.getSingleResult();
		return result.intValue();
	}
	@Override
	public Long insertformroleaccess(PfmsFormRoleAccess main) throws Exception {
		logger.info(new Date() + "Inside insertformroleaccess()");
		try {
			manager.persist(main);
			manager.flush();
			return (long)main.getFormRoleAccessId();
		} catch (Exception e) {
			e.printStackTrace();
			return 0l;
		}

	}
	@Override
	public int updateformroleaccess(String formroleid,String active,String auth)throws Exception{
		Query query = manager.createNativeQuery("UPDATE pfms_form_role_access SET isactive=:isactive , modifieddate=:modifieddate , modifiedby=:modifiedby WHERE formroleaccessid=:formroleaccessid");
		query.setParameter("formroleaccessid", formroleid);
		query.setParameter("isactive", active);
		query.setParameter("modifieddate",sdf1.format(new Date()));
		query.setParameter("modifiedby", auth);

		return query.executeUpdate();
	}

	private static final String PASSWORDRESET="update login set password=:password,modifiedby=:modifiedby,modifieddate=:modifieddate where LoginId=:LoginId ";

	@Override
	public int resetPassword(String lid, String userId, String password, String modifieddate) throws Exception {

		Query query = manager.createNativeQuery(PASSWORDRESET);

		query.setParameter("password", password);
		query.setParameter("LoginId", lid);
		query.setParameter("modifiedby", userId);
		query.setParameter("modifieddate", modifieddate);
		int PasswordChange = (int) query.executeUpdate();
		return  PasswordChange;
	}

	private static final String FIRSTDAY="SELECT MIN(logindate) AS 'MINDATE'  FROM auditstamping";
	@Override
	public String firstDateOfAudit() throws Exception {
		Query query = manager.createNativeQuery(FIRSTDAY);
		Object result = query.getSingleResult();
		if(result != null) {
			// Assuming logindate is of type java.sql.Date
			java.sql.Date minDate = (java.sql.Date) result;
			// You can convert the date to a String using a SimpleDateFormat or another method
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			return result.toString();
		} else {
			return "No records found";
		}
	}
	// newlyCreated

	private static final String EMPLIST="SELECT a.empid,a.username,COUNT(b.loginid)AS 'TotalLogInCounts' FROM login a, auditstamping b WHERE a.loginid=b.loginid AND b.logindate=:logindate GROUP BY b.loginid";
	@Override
	public List<Object[]> getAllEmployeesOfDate(String date) throws Exception {
		Query query = manager.createNativeQuery(EMPLIST);
		query.setParameter("logindate", date);
		List<Object[]>emplist= new ArrayList<>();
		emplist=(List<Object[]>)query.getResultList();
		return emplist;
	}
	private static final String WORKCOUNTS="CALL pfms_statistics_data(:username,:date)";
	@Override
	public Object[] ListOfWorkCounts(String username, String date) throws Exception {
		Query query=manager.createNativeQuery(WORKCOUNTS);
		query.setParameter("username", username);
		query.setParameter("date", date);
		Object[] workCounts=(Object[])query.getSingleResult();
		return workCounts;
	}

	@Override
	public int  DataInsetrtIntoPfmsStatistics(List<PfmsStatistics> pfmsStatistics) throws Exception {
		// TODO Auto-generated method stub
		for(PfmsStatistics p:pfmsStatistics) {
			manager.persist(p);
		}
		return 1;
	}

	private static final String PMSSTATTABLEDATA="select * from pfms_statistics";
	@Override
	public List<Object[]> getpfmsStatiscticsTableData() throws Exception {
		Query query = manager.createNativeQuery(PMSSTATTABLEDATA);
		List<Object[]>totalData=(List<Object[]>)query.getResultList();
		return totalData;
	}

	private static final String EMPLOYEELISTDH="SELECT a.EmpId,a.EmpName,b.Designation FROM employee a,employee_desig b WHERE a.labcode=:labCode AND a.IsActive=1 AND a.DesigId=b.DesigId AND a.DivisionId=:division";
	private static final String EMPLOYEELISTGH="SELECT a.EmpId,a.EmpName,b.Designation FROM employee a,employee_desig b WHERE a.labcode=:labCode AND a.IsActive=1 AND a.DesigId=b.DesigId AND a.DivisionId=:division";
	private static final String ALLEMPLOYEELIST="SELECT a.EmpId,a.EmpName,b.Designation FROM employee a,employee_desig b WHERE a.labcode=:labCode AND a.IsActive=1 AND a.DesigId=b.DesigId";

	@Override
	public List<Object[]> StatsEmployeeList(String logintype, String division, String labCode) throws Exception {
		// TODO Auto-generated method stub
		if(logintype.equalsIgnoreCase("D")) {
			Query query=manager.createNativeQuery(EMPLOYEELISTDH);
			query.setParameter("division", division);
			query.setParameter("labCode", labCode);

			return (List<Object[]>)query.getResultList();
		}else if(logintype.equalsIgnoreCase("G")) {
			Query query=manager.createNativeQuery(EMPLOYEELISTGH);
			query.setParameter("division", division);
			query.setParameter("labCode", labCode);

			return (List<Object[]>)query.getResultList();
		}else if(logintype.equalsIgnoreCase("A")|| logintype.equalsIgnoreCase("X")|| logintype.equalsIgnoreCase("Z")||logintype.equalsIgnoreCase("E") || logintype.equalsIgnoreCase("L")){
			Query query=manager.createNativeQuery(ALLEMPLOYEELIST);
			query.setParameter("labCode", labCode);

			return (List<Object[]>)query.getResultList();
		}else {
			return null;
		}
	}
	
	private static final String COUNT="SELECT a.EmpName,c.Designation, b.* FROM employee a JOIN pfms_statistics b ON a.EmpId = b.EmpId JOIN employee_desig c ON a.DesigId = c.DesigId WHERE b.EmpId =:employeeId AND b.LogDate  BETWEEN :fromDate AND :toDate ORDER BY b.Logdate DESC";
	@Override
	public List<Object[]> getEmployeeWiseCount(long employeeId, String fromDate, String toDate) throws Exception {
		Query query = manager.createNativeQuery(COUNT);
		query.setParameter("employeeId", employeeId);
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		return (List<Object[]>)query.getResultList();
	}

	private static final String INITIATINAPPROVALAUTH="SELECT a.RtmddoId,a.LabCode,a.EmpId,a.ValidFrom,a.ValidTo,a.Type,b.EmpName,b.EmpNo,c.Designation FROM pfms_initiation_approver a,employee b,employee_desig c WHERE a.IsActive=1 AND a.InitiationId=0 AND b.IsActive=1 AND a.EmpId=b.EmpId AND b.DesigId=c.DesigId AND a.LabCode=:labcode";
	@Override
	public List<Object[]> initiationApprovalAuthority(String labcode) throws Exception {
		try {
			Query query = manager.createNativeQuery(INITIATINAPPROVALAUTH);
			query.setParameter("labcode", labcode);
			return (List<Object[]>)query.getResultList();
		}catch(Exception e){
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}

	@Override
	public PfmsRtmddo getApprovalAuthById(String RtmddoId) throws Exception{
		try {
			return manager.find(PfmsRtmddo.class, Long.parseLong(RtmddoId));
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
		
	}
	
	private static final String APPROVALAUTHREVOKE = "UPDATE pfms_initiation_approver SET IsActive='0' WHERE RtmddoId=:RtmddoId";
	@Override
	public int approvalAuthRevoke(String RtmddoId) throws Exception {
		Query query=manager.createNativeQuery(APPROVALAUTHREVOKE);
		query.setParameter("RtmddoId", RtmddoId);
		int count=query.executeUpdate();
		return count;
	}
	private static final String MAILCONFIGURATIONLIST = "SELECT a.MailConfigurationId,a.Username,a.Host,a.TypeOfHost,a.Port,a.Password,a.CreatedBy,a.CreatedDate FROM mail_configuration a  WHERE a.IsActive='1' ORDER BY MailConfigurationId DESC";
	@Override
	public List<Object[]> MailConfigurationList()throws Exception{
		Query query = manager.createNativeQuery(MAILCONFIGURATIONLIST);
		List<Object[]> MailConfigurationList = query.getResultList();
		return MailConfigurationList;
	}
	private static final String DELETEMAILCONFIGURATION = "UPDATE mail_configuration SET IsActive=0 AND ModifiedBy=:modifiedBy AND ModifiedDate=:modifiedDate WHERE MailConfigurationId=:mailConfigurationId";
	public long DeleteMailConfiguration(long MailConfigurationId, String ModifiedBy)throws Exception{
		logger.info(new Date() + "Inside DaoImpl DeleteMailConfiguration");
		try {
			Query query = manager.createNativeQuery(DELETEMAILCONFIGURATION);
			query.setParameter("mailConfigurationId", MailConfigurationId);
			query.setParameter("modifiedBy", ModifiedBy);
			query.setParameter("modifiedDate", sdf1.format(new Date()));		
			int DeleteMailConfiguration = (int) query.executeUpdate();
			return  DeleteMailConfiguration;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl DeleteMailConfiguration", e);
			return 0;
		}
	}
	@Override
	public long AddMailConfiguration( MailConfiguration mailConfigAdd)throws Exception{
		logger.info(new Date() + "Inside DaoImpl AddMailConfiguration");
		try {
			manager.persist(mailConfigAdd);
			manager.flush();
			return mailConfigAdd.getMailConfigurationId();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl AddMailConfiguration", e);
			return 0;
		}
	}
    private static final String MAILCONFIGURATIONEDITLIST ="SELECT a.MailConfigurationId,a.Username,a.Host,a.TypeOfHost,a.Port,a.Password,a.CreatedBy,a.CreatedDate FROM mail_configuration a  WHERE a.MailConfigurationId=:mailConfigurationId";
	@Override
	public List<Object[]> MailConfigurationEditList(long MailConfigurationId)throws Exception{
		logger.info(new Date() + "Inside DaoImpl MailConfigurationEditList");
		try {
			Query query = manager.createNativeQuery(MAILCONFIGURATIONEDITLIST);
			query.setParameter("mailConfigurationId", MailConfigurationId);
			List<Object[]> MailConfigurationEditList = query.getResultList();
			return MailConfigurationEditList;

			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl MailConfigurationEditList", e);
			return null;
		}
	}
    private static final String UPDATEMAILCONFIGURATION = "UPDATE mail_configuration SET a.Username=:userName ,a.TypeOfHost=:hostType, a.ModifiedBy=:modifiedBy ,a.ModifiedDate=:modifiedDate WHERE MailConfigurationId=:mailConfigurationId";

	@Override
	public long UpdateMailConfiguration(long MailConfigurationId,String userName,String hostType, String modifiedBy)throws Exception{
		logger.info(new Date() + "Inside DaoImpl MailConfigurationEditList");
		try {
			Query query = manager.createNativeQuery(UPDATEMAILCONFIGURATION);
			query.setParameter("mailConfigurationId", MailConfigurationId);
			query.setParameter("userName", userName);
			query.setParameter("hostType", hostType);
			query.setParameter("modifiedBy", modifiedBy);
			query.setParameter("modifiedDate", sdf1.format(new Date()));		
			int DeleteMailConfiguration = (int) query.executeUpdate();
			return  DeleteMailConfiguration;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(new Date() + "Inside DaoImpl MailConfigurationEditList", e);
			return 0;
		}
		
	}
	
}
