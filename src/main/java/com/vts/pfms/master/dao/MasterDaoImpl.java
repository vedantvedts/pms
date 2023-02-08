package com.vts.pfms.master.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.vts.pfms.committee.model.ActionAttachment;
import com.vts.pfms.master.dto.DivisionEmployeeDto;
import com.vts.pfms.master.model.DivisionEmployee;
import com.vts.pfms.master.model.DivisionGroup;
import com.vts.pfms.master.model.Employee;
import com.vts.pfms.master.model.MilestoneActivityType;
import com.vts.pfms.master.model.PfmsFeedback;
import com.vts.pfms.master.model.PfmsFeedbackAttach;
import com.vts.pfms.model.LabMaster;

@Transactional
@Repository
public class MasterDaoImpl implements MasterDao {
	
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	private static final String OFFICERLIST="SELECT a.empid, a.empno, CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname' , b.designation, a.extno, a.email, c.divisionname, a.desigid, a.divisionid, a.SrNo, a.isactive,a.labcode  FROM employee a,employee_desig b, division_master c WHERE a.desigid= b.desigid AND a.divisionid= c.divisionid  ORDER BY a.srno=0,a.srno ";
	private static final String DESIGNATIONLIST="SELECT desigid, desigcode, designation, desiglimit FROM employee_desig";
	private static final String OFFICERDIVISIONLIST="SELECT divisionid, divisionname FROM division_master where isactive='1'";
	private static final String OFFICEREDITDATA="select empid,empno,empname,desigid,extno,email,divisionid, DronaEmail, InternetEmail,MobileNo , title , salutation from employee  where empid=:empid";
	private static final String OFFICERMASTERDELETE="UPDATE employee SET srno=:srno, isactive=:isactive, modifieddate=:modifieddate, modifiedby=:modifiedby WHERE empid=:empid";
	private static final String OFFICEREXTMASTERDELETE="UPDATE employee SET isactive=:isactive, modifieddate=:modifieddate, modifiedby=:modifiedby WHERE empid=:empid";
	private static final String EMPNOCHECK="SELECT empno FROM employee";
	private static final String EMPEXTNOCHECK="SELECT empno FROM employee_external";
	private static final String OFFICERMASTERUPDATE="UPDATE employee SET title=:title, salutation=:salutation, empno=:empno, empname=:empname, desigid=:desigid, MobileNo=:mobileno, extno=:extno, email=:email, DronaEmail=:dronaemail, InternetEmail=:internetemail, divisionid=:divisionid, modifiedby=:modifiedby, modifieddate=:modifieddate WHERE empid=:empid" ;
    private static final String CLUSTERLAB="SELECT LabId, ClusterId, LabCode FROM cluster_lab";
    private static final String EXTERNALOFFICERLIST="SELECT a.empid, a.empno, CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname', b.designation, a.extno, a.email, c.divisionname, a.desigid, a.divisionid ,'active',a.isactive  FROM employee a,employee_desig b, division_master c WHERE a.desigid= b.desigid AND a.divisionid= c.divisionid  ORDER BY a.empid DESC";
	private static final String EXTERNALOFFICEREDITDATA="select empid,empno,empname,desigid,extno,email,divisionid,DronaEmail,InternetEmail,MobileNo,Labcode,title , salutation from employee  where empid=:empid";
	private static final String EXTERNALOFFICERMASTERUPDATE="UPDATE employee SET salutation=:salutation ,title=:title, labcode=:labcode,empno=:empno, empname=:empname, desigid=:desigid, extno=:extno, MobileNo=:mobileno, email=:email,DronaEmail=:dronaemail, InternetEmail=:internalemail , divisionid=:divisionid, modifiedby=:modifiedby, modifieddate=:modifieddate WHERE empid=:empid" ;
	
	
	private static final String DIVISIONLIST="SELECT divisionid,divisioncode,divisionname FROM division_master WHERE isactive=1";
	private static final String DIVISIONEMPLIST="SELECT de.divisionemployeeid,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'empname',ed.designation,de.divisionid  FROM division_employee de,employee e, employee_desig ed WHERE de.isactive=1 AND  de.empid=e.empid AND e.desigid=ed.desigid AND de.divisionid=:divisionid";
	private static final String DIVISIONNONEMPLIST ="SELECT e.empid, CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'empname',ed.designation,e.labcode  FROM employee e,employee_desig ed  WHERE e.isactive=1 AND e.desigid=ed.desigid AND e.empid NOT IN  (SELECT de.empid FROM division_employee de WHERE de.isactive=1 AND divisionid=:divisionid) ORDER BY e.srno ASC ,ed.desigsr ASC";
	private static final String DIVISIONDATA ="SELECT divisionid, divisioncode,divisionname FROM division_master WHERE divisionid=:divisionid";
	private static final String DIVSIONEMPLOYEEREVOKE="UPDATE division_employee SET isactive=0,ModifiedBy=:modifiedby,ModifiedDate=:modifieddate WHERE divisionemployeeid=:divisionempid";
	
	private final static String OFFICERDETALIS="SELECT a.empid, a.empno,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname' , b.designation, a.extno, a.email, c.divisionname, a.desigid, a.divisionid, a.SrNo FROM employee a,employee_desig b, division_master c WHERE a.desigid= b.desigid AND a.divisionid= c.divisionid AND a.isactive='1' AND a.empid=:officerid"; 
	private final static String LISTOFSENIORITYNUMBER="SELECT SrNo, EmpId FROM employee WHERE SrNo !=0 ORDER BY SrNo ASC ";
	private final static String UPDATESRNO="UPDATE employee SET SrNo=:srno WHERE EmpId=:empid";
	
	private static final String ACTIVITYLIST="SELECT activitytypeid, activitytype FROM milestone_activity_type WHERE isactive=1";
	private static final String ACTIVITYNAMECHECK="SELECT COUNT(activitytypeid) AS 'count','activity' FROM milestone_activity_type WHERE isactive=1 AND activitytype LIKE :activityname";
	private static final String GROUPLIST = "SELECT dg.GroupId,dg.GroupCode,dg.GroupName,dg.GroupHeadId,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'empname',ed.designation ,dg.labcode FROM division_group dg,employee e, employee_desig ed WHERE dg.GroupHeadId=e.empid AND e.desigid=ed.desigid AND dg.isactive=1 AND dg.labcode=:labcode ORDER BY dg.groupid DESC";
	private static final String GROUPHEADLIST ="SELECT e.empid,CONCAT(IFNULL(e.title,''), e.empname)AS 'empname',ed.designation FROM employee e, employee_desig ed WHERE  e.desigid=ed.desigid AND e.isactive=1 AND e.labcode=:labcode ORDER BY e.srno";
	private static final String GROUPADDCHECK ="SELECT SUM(IF(GroupCode =:gcode,1,0))   AS 'dCode','0' AS 'codecount'FROM division_group WHERE isactive=1 ";
	private static final String GROUPDATA = "SELECT dg.GroupId,dg.GroupCode,dg.GroupName,dg.GroupHeadId,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'empname',ed.designation,dg.isactive FROM division_group dg,employee e, employee_desig ed WHERE dg.GroupHeadId=e.empid AND e.desigid=ed.desigid AND  dg.groupid=:groupid";
	private static final String GROUPUPDATE="UPDATE division_group SET GroupCode=:groupcode, GroupName=:groupname, GroupHeadId=:groupheadid ,  ModifiedBy=:modifiedby, ModifiedDate=:modifieddate, IsActive=:isactive WHERE GroupId=:groupid";
	private static final String LABLIST="select labmasterid,labcode,labname,labunitcode,labaddress,labcity,labpin FROM lab_master";
	private static final String EMPLOYEELIST="SELECT empid, CONCAT(IFNULL(CONCAT(title,' '),''), empname) AS 'empname' FROM employee WHERE isactive=1 ORDER BY srno ";
	private static final String LABMASTEREDITDATA="select labmasterid,labcode,labname,labunitcode,labaddress,labcity,labpin,labtelno,labfaxno,labemail,labauthority,labauthorityid,labrfpemail,lablogo,labid from lab_master where labmasterid= :labmasterid";
	private static final String LABMASTERUPDATE="UPDATE lab_master SET labcode=:labcode , labname=:labname , labunitcode=:labunitcode, labaddress=:labaddress, labcity=:labcity, labpin= :labpin ,labtelno=:labtelno, labfaxno=:labfaxno, labemail=:labemail, labauthority=:labauthority, labauthorityid=:labauthorityid, labrfpemail=:labrfpemail, labid=:labid, clusterid=:clusterid,  modifiedby=:modifiedby, modifieddate=:modifieddate WHERE labmasterid=:labmasterid"; //lablogo=:lablogo,
	private static final String LABSLIST="SELECT labid,clusterid,labname,labcode FROM cluster_lab";
	private static final String EMPNOCHECKAJAX="SELECT empid, CONCAT(IFNULL(CONCAT(title,' '),''), empname) AS 'empname' , empno FROM employee WHERE empno=:empno"; 
	private static final String EXTEMPNOCHECKAJAX="SELECT empid, empname , empno FROM employee_external WHERE empno=:empno";

	
	@PersistenceContext
	EntityManager manager;
	
	@Override
	public List<Object[]> OfficerList() throws Exception {
		Query query=manager.createNativeQuery(OFFICERLIST);
		List<Object[]> OfficerList=(List<Object[]>)query.getResultList();
		return OfficerList;
	}
	
	@Override
	public List<Object[]> DesignationList() throws Exception {

		Query query=manager.createNativeQuery(DESIGNATIONLIST);
		List<Object[]> DesignationList=(List<Object[]>)query.getResultList();
		return DesignationList;
	}
	
	@Override
	public List<Object[]> OfficerDivisionList() throws Exception {

		Query query=manager.createNativeQuery(OFFICERDIVISIONLIST);
		List<Object[]> DivisionList=(List<Object[]>)query.getResultList();
		return DivisionList;
	}
	
	@Override
	public List<Object[]> OfficerEditData(String OfficerId) throws Exception {

		Query query=manager.createNativeQuery(OFFICEREDITDATA);
		query.setParameter("empid", OfficerId);
		List<Object[]> OfficerEditData= (List<Object[]>) query.getResultList();
		
		return OfficerEditData;
	}
	
	@Override
	public int OfficerMasterDelete(Employee employee) throws Exception {
		
		Query query=manager.createNativeQuery(OFFICERMASTERDELETE);
		query.setParameter("modifieddate", employee.getModifiedDate());
		query.setParameter("modifiedby", employee.getModifiedBy());
		query.setParameter("isactive", employee.getIsActive());
		query.setParameter("empid", employee.getEmpId());
		query.setParameter("srno", employee.getSrNo());
		int count =(int)query.executeUpdate();
		
		return count ;
	}
	
	@Override
	public int OfficerExtDelete(Employee employee) throws Exception {
		
		Query query=manager.createNativeQuery(OFFICEREXTMASTERDELETE);
		query.setParameter("modifieddate", employee.getModifiedDate());
		query.setParameter("modifiedby", employee.getModifiedBy());
		query.setParameter("isactive", employee.getIsActive());
		query.setParameter("empid", employee.getEmpId());
		int count =(int)query.executeUpdate();
		
		return count ;
	}


	@Override
	public List<String> EmpNoCheck() throws Exception {

		Query query=manager.createNativeQuery(EMPNOCHECK);
		List<String> EmpNoCheck=(List<String>)query.getResultList();
		return EmpNoCheck;
	}
	
	@Override
	public List<String> EmpExtNoCheck() throws Exception {

		Query query=manager.createNativeQuery(EMPEXTNOCHECK);
		List<String> EmpNoCheck=(List<String>)query.getResultList();
		return EmpNoCheck;
	}

	@Override
	public Long OfficeMasterInsert(Employee employee) throws Exception {

		manager.persist(employee);
		manager.flush();
		
		return employee.getEmpId();
	}
	
	@Override
	public int OfficerMasterUpdate(Employee employee) throws Exception {
		
		Query query=manager.createNativeQuery(OFFICERMASTERUPDATE);
		query.setParameter("title", employee.getTitle());
		query.setParameter("salutation", employee.getSalutation());
		query.setParameter("empno", employee.getEmpNo());
		query.setParameter("empname", employee.getEmpName());
		query.setParameter("desigid", employee.getDesigId());
		query.setParameter("extno", employee.getExtNo());
		query.setParameter("email", employee.getEmail());
		query.setParameter("mobileno",employee.getMobileNo());
		query.setParameter("dronaemail",employee.getDronaEmail());
		query.setParameter("internetemail",employee.getInternetEmail());
		query.setParameter("divisionid", employee.getDivisionId());
		query.setParameter("empid", employee.getEmpId());
		query.setParameter("modifiedby", employee.getModifiedBy());
		query.setParameter("modifieddate", employee.getModifiedDate());
		
		int count =(int)query.executeUpdate();
		
		return count;
	}
	
	@Override
	public List<Object[]> LabList()throws Exception{

		Query query=manager.createNativeQuery(CLUSTERLAB);
		List<Object[]> OfficerEditData= (List<Object[]>) query.getResultList();
		
		return OfficerEditData;
	}
	
	@Override
	public Long OfficeMasterExternalInsert(Employee empExternal)throws Exception{

		manager.persist(empExternal);
		manager.flush();
		
		return empExternal.getEmpId();
		
	}
	@Override
	public List<Object[]> ExternalOfficerList()throws Exception{
		Query query=manager.createNativeQuery(EXTERNALOFFICERLIST);
		List<Object[]> OfficerList=(List<Object[]>)query.getResultList();
		return OfficerList;
	}
	@Override
	public List<Object[]> ExternalOfficerEditData(String officerId) throws Exception{

		Query query=manager.createNativeQuery(EXTERNALOFFICEREDITDATA);
		query.setParameter("empid", officerId);
		List<Object[]> OfficerEditData= (List<Object[]>) query.getResultList();
		
		return OfficerEditData;
	}

	@Override  
	public int OfficerExtUpdate(Employee employee) throws Exception{

		Query query=manager.createNativeQuery(EXTERNALOFFICERMASTERUPDATE);
		query.setParameter("empno", employee.getEmpNo());
		query.setParameter("empname", employee.getEmpName());
		query.setParameter("desigid", employee.getDesigId());
		query.setParameter("extno", employee.getExtNo());
		query.setParameter("mobileno", employee.getMobileNo());
		query.setParameter("email", employee.getEmail());
		query.setParameter("divisionid", employee.getDivisionId());
		query.setParameter("empid", employee.getEmpId());
		query.setParameter("modifiedby", employee.getModifiedBy());
		query.setParameter("modifieddate", employee.getModifiedDate());
		query.setParameter("dronaemail", employee.getDronaEmail());
		query.setParameter("internalemail", employee.getInternetEmail());
		query.setParameter("title", employee.getTitle());
		query.setParameter("salutation", employee.getSalutation());
		query.setParameter("labcode", employee.getLabCode());
		int count =(int)query.executeUpdate();
		
		return count;
	}
	
	
	@Override
	public Object[] getOfficerDetalis(String officerId)throws Exception{
		Query query=manager.createNativeQuery(OFFICERDETALIS);
		query.setParameter("officerid", officerId);
		return (Object[])query.getSingleResult();
	}
	
	@Override
	public List<Object[]> updateAndGetList(Long empId, String newSeniorityNumber)throws Exception{
		
	    Query query=manager.createNativeQuery(LISTOFSENIORITYNUMBER);
	    List<Object[]> listSeni=(List<Object[]>)query.getResultList();
	    
	    Query updatequery=manager.createNativeQuery(UPDATESRNO);
	    updatequery.setParameter("empid", empId);
        updatequery.setParameter("srno", newSeniorityNumber);  	   
        updatequery.executeUpdate();
        
	    return listSeni;
	}
	
	@Override
	public int updateAllSeniority(Long empIdL, Long long1)throws Exception{
		    Query updatequery=manager.createNativeQuery(UPDATESRNO);
		    updatequery.setParameter("empid", empIdL);
	        updatequery.setParameter("srno", long1);  	 
	        return updatequery.executeUpdate();
	}
	
	
	@Override
	public List<Object[]> DivisionList()throws Exception
	{		
	   Query query=manager.createNativeQuery(DIVISIONLIST);   
	   return  (List<Object[]>)query.getResultList();
	}
	
	
	@Override
	public List<Object[]> DivisionEmpList(String divisionid)throws Exception
	{		
	   Query query=manager.createNativeQuery(DIVISIONEMPLIST); 
	   query.setParameter("divisionid", divisionid);  	 
	   return  (List<Object[]>)query.getResultList();
	}
	
	@Override
	public List<Object[]> DivisionNonEmpList(String divisionid)throws Exception
	{		
	   Query query=manager.createNativeQuery(DIVISIONNONEMPLIST); 
	   query.setParameter("divisionid", divisionid);  	 
	   return  (List<Object[]>)query.getResultList();
	}
	
	@Override
	public Object[] DivisionData(String divisionid)throws Exception
	{
		 Query query=manager.createNativeQuery(DIVISIONDATA); 
		 query.setParameter("divisionid", divisionid);  
		 return  (Object[])query.getSingleResult();
	}
	
	
	@Override
	public int DivsionEmployeeRevoke(DivisionEmployeeDto dto)throws Exception
	{
		Query query=manager.createNativeQuery(DIVSIONEMPLOYEEREVOKE); 
		query.setParameter("divisionempid", dto.getDivisionEmployeeId());
		query.setParameter("modifiedby", dto.getModifiedBy());
		query.setParameter("modifieddate", dto.getModifiedDate());
		return  query.executeUpdate();
	}
	
	
	@Override
	public long DivisionAssignSubmit(DivisionEmployee model)throws Exception
	{
		manager.persist(model);
		manager.flush();
		return model.getDivisionEmployeeId();
	}
	
	
	@Override
	public List<Object[]> ActivityList()throws Exception
	{		
	   Query query=manager.createNativeQuery(ACTIVITYLIST);   
	   return  (List<Object[]>)query.getResultList();
	}
	
	
	@Override
	public Object[] ActivityNameCheck(String activityname)throws Exception
	{		
	   Query query=manager.createNativeQuery(ACTIVITYNAMECHECK);   
	   query.setParameter("activityname", activityname);
	   return  (Object[])query.getSingleResult();
	}
	
	@Override
	public long ActivityAddSubmit(MilestoneActivityType model)throws Exception
	{	
		manager.persist(model);
		manager.flush();
		return model.getActivityTypeId();
	}
	
	
	@Override
	public List<Object[]> GroupsList(String LabCode)throws Exception
	{	
		Query query=manager.createNativeQuery(GROUPLIST);
		query.setParameter("labcode", LabCode);
		return (List<Object[]> )query.getResultList();
	}
	
	
	@Override
	public List<Object[]> GroupHeadList(String LabCode) throws Exception 
	{		
		Query query=manager.createNativeQuery(GROUPHEADLIST);
		query.setParameter("labcode", LabCode);
		List<Object[]> GroupHeadList=(List<Object[]>)query.getResultList();

		return GroupHeadList;
	}
	
	@Override
	public long GroupAddSubmit(DivisionGroup model) throws Exception 
	{	
		manager.persist(model);
		manager.flush();
		return model.getGroupId();
	}
	
	
	@Override
	public Object[] GroupAddCheck(String gcode) throws Exception 
	{
		Query query=manager.createNativeQuery(GROUPADDCHECK);   
		query.setParameter("gcode", gcode);
		return  (Object[])query.getSingleResult();
	}
	
	
	
	@Override
	public Object[] GroupsData(String groupid)throws Exception
	{	
		Query query=manager.createNativeQuery(GROUPDATA);
		query.setParameter("groupid", groupid);				
		return( Object[] )query.getSingleResult();
	}
	
	
	@Override
	public int GroupMasterUpdate(DivisionGroup model) throws Exception
	{		
		Query query=manager.createNativeQuery(GROUPUPDATE);
		query.setParameter("groupcode", model.getGroupCode());
		query.setParameter("groupname", model.getGroupName());
		query.setParameter("groupheadid", model.getGroupHeadId());
		query.setParameter("groupid", model.getGroupId());
		query.setParameter("modifiedby", model.getModifiedBy());
		query.setParameter("modifieddate", model.getModifiedDate());
		query.setParameter("isactive", model.getIsActive());
		int count = (int)query.executeUpdate();
		
		return count;
	}
	
	@Override
	public List<Object[]> LabMasterList() throws Exception {
			Query query = manager.createNativeQuery(LABLIST);
			List<Object[]> LabList =(List<Object[]>) query.getResultList();
		    return LabList;
	}
	
	@Override
	public List<Object[]> EmployeeList() throws Exception {
		
		Query query= manager.createNativeQuery(EMPLOYEELIST);
		List < Object[]>  EmployeeList =(List <Object[]>)query.getResultList();
		return EmployeeList;
	}
	
	@Override
	public List<Object[]> LabMasterEditData(String LabId) throws Exception {

		Query query = manager.createNativeQuery(LABMASTEREDITDATA);
		query.setParameter("labmasterid",LabId );
		List<Object[]> LabMasterEditData=(List<Object[]>) query.getResultList();
		return LabMasterEditData;
	}
	
	
	@Override
	public int LabMasterUpdate(LabMaster labmaster) throws Exception {
		
		Query query=manager.createNativeQuery(LABMASTERUPDATE);
		query.setParameter("labcode", labmaster.getLabCode());
		query.setParameter("labname", labmaster.getLabName());
		query.setParameter("labunitcode", labmaster.getLabUnitCode());
		query.setParameter("labaddress", labmaster.getLabAddress());
		query.setParameter("labcity", labmaster.getLabCity());
		query.setParameter("labpin", labmaster.getLabPin());
		query.setParameter("labmasterid", labmaster.getLabMasterId());
		query.setParameter("labtelno", labmaster.getLabTelNo());
		query.setParameter("labfaxno", labmaster.getLabFaxNo());
		query.setParameter("labemail", labmaster.getLabEmail());
		query.setParameter("labauthority", labmaster.getLabAuthority());
		query.setParameter("labauthorityid", labmaster.getLabAuthorityId());
		query.setParameter("labrfpemail", labmaster.getLabRfpEmail());
		query.setParameter("labid", labmaster.getLabId());
		query.setParameter("clusterid", labmaster.getClusterId());
//		query.setParameter("lablogo", labmaster.getLabLogo());
		query.setParameter("modifiedby", labmaster.getModifiedBy());
		query.setParameter("modifieddate", labmaster.getModifiedDate());
		
		
		int count = (int)query.executeUpdate();
		return count;
	}
	
	@Override
	public List<Object[]> LabsList() throws Exception 
	{		
		Query query= manager.createNativeQuery(LABSLIST);
		List < Object[]>  LabsList =(List <Object[]>)query.getResultList();
		return LabsList;
	}
	
	
	@Override
	public List<Object[]> empNoCheckAjax(String empno)throws Exception
	{		
	   Query query=manager.createNativeQuery(EMPNOCHECKAJAX); 
	   query.setParameter("empno", empno);  	 
	   return  (List<Object[]>)query.getResultList();
	}
	
	 
	@Override
	public List<Object[]> extEmpNoCheckAjax(String empno)throws Exception
	{		
	   Query query=manager.createNativeQuery(EXTEMPNOCHECKAJAX); 
	   query.setParameter("empno", empno);  	 
	   return  (List<Object[]>)query.getResultList();
	}
	
	@Override
	public Long FeedbackInsert(PfmsFeedback feedback) throws Exception {
		manager.persist(feedback);
		manager.flush();
		return feedback.getFeedbackId();
	}
	
	@Override
	public long FeedbackAttachInsert(PfmsFeedbackAttach main) throws Exception {
		
		manager.persist(main);
		manager.flush();
		return main.getFeedbackAttachId();
	}
	
	private static final String FEEDBACKLIST = "SELECT a.feedbackid,b.empname,a.createddate , a.feedback , a.feedbacktype , a.status , a.remarks FROM pfms_feedback a,employee b WHERE a.isactive='1' AND a.empid=b.empid  AND CASE WHEN 'A'<>:feedbacktype THEN a.feedbacktype=:feedbacktype ELSE 1=1 END and CASE WHEN 'A'<>:empid THEN a.empid=:empid ELSE 1=1 END AND CAST(a.createddate AS DATE) BETWEEN :fromdate AND :todate AND b.labcode=:labcode  ORDER BY feedbackid DESC";

	@Override
	public List<Object[]> FeedbackList(String fromdate , String todate , String empid ,String LabCode,String feedbacktype) throws Exception{
		Query query = manager.createNativeQuery(FEEDBACKLIST);
		query.setParameter("empid", empid);
		query.setParameter("fromdate", fromdate);
		query.setParameter("todate", todate);
		query.setParameter("labcode", LabCode);
		query.setParameter("feedbacktype", feedbacktype);
		List<Object[]> FeedbackList = (List<Object[]>) query.getResultList();
		return FeedbackList;
	}
	private static final String FEEDBACKLISTFORUSER="SELECT a.feedbackid,b.empname,a.createddate , a.feedback , a.feedbacktype , a.status , a.remarks FROM pfms_feedback a,employee b WHERE a.isactive='1' AND a.empid=b.empid  AND CASE WHEN :empid<>'A' THEN a.empid=:empid ELSE 1=1 END AND MONTH(a.createddate)=MONTH(NOW())-1 AND b.labcode=:labcode UNION SELECT a.feedbackid,b.empname,a.createddate , a.feedback , a.feedbacktype , a.status , a.remarks FROM pfms_feedback a,employee b WHERE a.isactive='1' AND a.empid=b.empid AND CASE WHEN :empid<>'A' THEN a.empid=:empid ELSE 1=1 END  AND b.labcode=:labcode ORDER BY feedbackid DESC";
	@Override
	public List<Object[]> FeedbackListForUser(String LabCode , String empid) throws Exception
	{
		Query query = manager.createNativeQuery(FEEDBACKLISTFORUSER);
		query.setParameter("labcode", LabCode);
		query.setParameter("empid", empid);
		List<Object[]> FeedbackList = (List<Object[]>) query.getResultList();
		return FeedbackList;
	}

	private static final String FEEDBACKCONTENT = "SELECT a.feedbackid,b.empname,a.createddate,a.feedback FROM pfms_feedback a,employee b WHERE a.isactive='1' AND a.empid=b.empid AND feedbackid=:feedbackid";
	
	@Override
	public Object[] FeedbackContent(String feedbackid)throws Exception
	{		
	   Query query=manager.createNativeQuery(FEEDBACKCONTENT);   
	   query.setParameter("feedbackid", feedbackid);
	   return  (Object[])query.getSingleResult();
	}
	private final static String CLOSEFEEDBACK="UPDATE pfms_feedback SET STATUS=:status , remarks=:remarks , ModifiedBy=:modifiedby , ModifiedDate=:modifieddate WHERE feedbackid=:feedbackId";
	@Override
	public int CloseFeedback(String feedbackId , String remarks , String username)throws Exception
	{
		Query query=manager.createNativeQuery(CLOSEFEEDBACK);   
		query.setParameter("feedbackId", feedbackId);
		query.setParameter("remarks", remarks);
		query.setParameter("status", "C");
		query.setParameter("modifiedby", username);
		query.setParameter("modifieddate", sdf1.format(new Date()));
		int count =(int)query.executeUpdate();
		return count ;
	}
	private static final String ATTACHLIST="SELECT a.feedbackid, a.FeedbackAttachId ,a.path , a.filename  FROM pfms_feedback_attach a , pfms_feedback b WHERE a.feedbackid=b.feedbackid AND a.isactive=1";
	@Override
	public List<Object[]> GetfeedbackAttch()throws Exception
	{
		Query query = manager.createNativeQuery(ATTACHLIST);
		List<Object[]> FeedbackList = (List<Object[]>) query.getResultList();
		return FeedbackList;
	}
	private static final String USERATTCHFEEDBACK="SELECT a.feedbackid,a.FeedbackAttachId ,a.path , a.filename  FROM pfms_feedback_attach a , pfms_feedback b WHERE a.feedbackid=b.feedbackid AND b.empid=:empid AND a.isactive=1";
	@Override
	public List<Object[]> GetfeedbackAttchForUser(String empid)throws Exception
	{
		Query query = manager.createNativeQuery(USERATTCHFEEDBACK);
		query.setParameter("empid", empid);
		List<Object[]> FeedbackList = (List<Object[]>) query.getResultList();
		return FeedbackList;
	}
	
	@Override
	public PfmsFeedbackAttach FeedbackAttachmentDownload(String achmentid) throws Exception
	{
		PfmsFeedbackAttach Attachment= manager.find(PfmsFeedbackAttach.class,Long.parseLong(achmentid));
		return Attachment;
	}
}
