package com.vts.pfms.project.dao;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.vts.pfms.committee.model.CommitteeInitiation;
import com.vts.pfms.committee.model.PfmsNotification;
import com.vts.pfms.print.model.ProjectTechnicalWorkData;
import com.vts.pfms.project.dto.PfmsInitiationRequirementDto;
import com.vts.pfms.project.dto.PfmsRiskDto;
import com.vts.pfms.project.model.PfmsApproval;
import com.vts.pfms.project.model.PfmsInitiation;
import com.vts.pfms.project.model.PfmsInitiationAttachment;
import com.vts.pfms.project.model.PfmsInitiationAttachmentFile;
import com.vts.pfms.project.model.PfmsInitiationAuthority;
import com.vts.pfms.project.model.PfmsInitiationAuthorityFile;
import com.vts.pfms.project.model.PfmsInitiationChecklistData;
import com.vts.pfms.project.model.PfmsInitiationCost;
import com.vts.pfms.project.model.PfmsInitiationDetail;
import com.vts.pfms.project.model.PfmsInitiationLab;
import com.vts.pfms.project.model.PfmsInitiationSchedule;
import com.vts.pfms.project.model.PfmsInititationRequirement;
import com.vts.pfms.project.model.PfmsProjectData;
import com.vts.pfms.project.model.PfmsProjectDataRev;
import com.vts.pfms.project.model.PfmsRisk;
import com.vts.pfms.project.model.PfmsRiskRev;
import com.vts.pfms.project.model.ProjectAssign;
import com.vts.pfms.project.model.ProjectMain;
import com.vts.pfms.project.model.ProjectMaster;
import com.vts.pfms.project.model.ProjectMasterAttach;
import com.vts.pfms.project.model.ProjectMasterRev;

@Transactional
@Repository
public class ProjectDaoImpl implements ProjectDao {
	
	private static final Logger logger=LogManager.getLogger(ProjectDaoImpl.class);
	java.util.Date loggerdate=new java.util.Date();

	private static final String PROJECTINTILIST="SELECT a.initiationid,a.projectprogramme,b.projecttypeshort,c.classification,a.projectshortname,a.projecttitle,a.projectcost,a.projectduration,a.ismain,a.empid AS 'pdd',a.LabCode FROM pfms_initiation a,project_type b, pfms_security_classification c WHERE (CASE WHEN :logintype IN ('Z','Y','A','E') THEN a.LabCode=:LabCode ELSE a.empid=:empid END ) AND a.classificationid=c.classificationid  AND a.projecttypeid=b.projecttypeid AND a.isactive='1' AND a.projectstatus IN ('PIN','DOI','ADI','TCI','RTI','DRO','DRI')";
	private static final String PROJECTTYPELIST="select classificationid,classification from pfms_security_classification order by classification";
	private static final String PROJECTCATEGORYLIST="select projecttypeid,projecttype,projecttypeshort from project_type where isactive='1' ORDER BY projecttype";
	private static final String PROJECTDELIVERABLELIST="select deliverableid,deliverable from pfms_deliverable order by deliverable ";
	private static final String LABLIST="SELECT a.labid,a.labname,a.labcode FROM cluster_lab a WHERE   a.labid NOT IN (SELECT b.labid FROM pfms_initiation_lab b  WHERE  b.initiationid=:initiationid AND b.isactive='1')";
	private static final String PROJECTSHORTNAMECHECK="SELECT count(*) from pfms_initiation where projectshortname=:projectshortname";
	private static final String PROJECTINTIUPDATE="update  pfms_initiation set labcount=:labcount ,modifiedby=:modifiedby,modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String BUDEGTITEM="select sanctionitemid,headofaccounts,refe,projecttypeid ,CONCAT (majorhead,'-',minorhead,'-',subhead) AS headcode from budget_item_sanc where budgetheadid=:budgetheadid and isactive='1' ORDER BY headofaccounts";
	private static final String PROJECTITEMLIST="SELECT a.initiationcostid,a.initiationid,c.budgetheaddescription,b.headofaccounts,a.itemdetail,a.itemcost ,b.refe , CONCAT (b.majorhead,'-',b.minorhead,'-',b.subhead) AS headcode FROM pfms_initiation_cost a,budget_item_sanc b,budget_head c WHERE a.initiationid=:initiationid AND a.budgetsancid=b.sanctionitemid AND a.budgetheadid=c.budgetheadid AND a.isactive='1' ORDER BY a.budgetheadid ASC";
	private static final String PROJECTLABLIST="select a.initiationid,a.InitiationLabId,b.labname from pfms_initiation_lab a,cluster_lab b where a.initiationid=:initiationid and b.labid=a.labid and isactive='1'";
	private static final String BUDEGTHEADLIST="select budgetheadid,budgetheaddescription from budget_head where isproject='Y' order by budgetheaddescription asc ";
	private static final String PROJECTSCHEDULELIST="select milestoneno,milestoneactivity,milestonemonth,initiationscheduleid,milestoneremark,Milestonestartedfrom,MilestoneTotalMonth from pfms_initiation_schedule where initiationid=:initiationid and isactive='1'";
	private static final String PROJECTSCHEDULETOTALMONTHLIST="select MilestoneTotalMonth,milestoneno,Milestonestartedfrom from pfms_initiation_schedule where initiationid=:initiationid and isactive='1' " ;
	/*L.A*/private static final String MILESTONENOTOTALMONTHS="SELECT milestoneno,MilestoneTotalMonth,Milestonestartedfrom FROM pfms_initiation_schedule WHERE isactive='1' AND initiationid=:InitiationId AND milestonestartedfrom=:milestonestartedfrom ";
	private static final String PROJECTDETAILSLIST= "SELECT a.Requirements,a.Objective,a.Scope,a.MultiLabWorkShare,a.EarlierWork,a.CompentencyEstablished,a.NeedOfProject,a.TechnologyChallanges,a.RiskMitigation,a.Proposal,a.RealizationPlan,a.initiationid,a.worldscenario,a.ReqBrief,a.ObjBrief,a.ScopeBrief,a.MultiLabBrief,a.EarlierWorkBrief,a.CompentencyBrief,a.NeedOfProjectBrief,a.TechnologyBrief,a.RiskMitigationBrief,a.ProposalBrief,a.RealizationBrief,a.WorldScenarioBrief FROM pfms_initiation_detail a WHERE a.initiationid=:initiationid ";
	private static final String PROJECTCOSTLIST="SELECT b.budgetheaddescription,c.headofaccounts,a.itemdetail,a.itemcost,c.refe,c.sanctionitemid  FROM pfms_initiation_cost a,budget_head b,budget_item_sanc c WHERE a.budgetheadid=b.budgetheadid AND a.budgetsancid=c.sanctionitemid AND a.initiationid=:initiationid ORDER BY sanctionitemid ";
	private static final String PROJECTINTIEDITDATA="SELECT a.initiationid,a.empid,a.divisionid,a.projectprogramme,a.projecttypeid,a.classificationid,a.projectshortname,a.projecttitle,a.projectcost,a.projectduration,a.isplanned,a.ismultilab,a.deliverable,a.fecost,a.recost,a.nodallab,a.remarks,a.ismain,a.projecttitle AS 'initiatedproject',a.pcduration,a.indicativecost,a.pcremarks FROM pfms_initiation a WHERE a.initiationid=:initiationid  AND a.isactive='1' AND a.mainid=0 UNION SELECT a.initiationid,a.empid,a.divisionid,a.projectprogramme,a.projecttypeid,a.classificationid,a.projectshortname,a.projecttitle,a.projectcost,a.projectduration,a.isplanned,a.ismultilab,a.deliverable,a.fecost,a.recost,a.nodallab,a.remarks,a.ismain,b.projecttitle ,a.pcduration,a.indicativecost,a.pcremarks FROM pfms_initiation a ,pfms_initiation b WHERE a.initiationid=:initiationid AND a.isactive='1' AND a.mainid=b.initiationid";
	private static final String PROJECTINTIEDITUPDATE="update pfms_initiation set projectprogramme=:projectprogramme,projecttypeid=:projecttypeid,classificationid=:classificationid,projecttitle=:projecttitle,isplanned=:isplanned,ismultilab=:ismultilab,deliverable=:deliverable,modifiedby=:modifiedby,modifieddate=:modifieddate,nodallab=:nodallab,remarks=:remarks,empid=:empid,pcduration=:pcduration,pcremarks=:pcremarks,indicativecost=:indicativecost where initiationid=:initiationid and isactive='1'";
	private static final String PROJECTINTITOTALCOST="select sum(ItemCost) from pfms_initiation_cost where initiationid=:initiationid and isactive='1'";
	private static final String PROJECTINTICOSTDATA="select initiationcostid,initiationid,budgetheadid,budgetsancid,itemdetail,itemcost from pfms_initiation_cost where initiationcostid=:initiationcostid and isactive='1'";
	private static final String PROJECTINTICOSTUPDATE="update pfms_initiation_cost set budgetsancid=:budgetitemid,itemdetail=:itemdetail,itemcost=:itemcost,modifiedby=:modifiedby,modifieddate=:modifieddate where initiationcostid=:initiationcostid and isactive='1'";
	/*L.A*/private static final String MILESTONETOTALMONTHUPDATE="UPDATE pfms_initiation_schedule SET MilestoneTotalMonth=:newMilestoneTotalMonth  WHERE  initiationid=:InitiationId AND isactive='1' AND milestoneno=:milestoneno";
	private static final String PROJECTSHDULEUPDATE="update pfms_initiation_schedule set milestoneactivity=:milestoneactivity,milestonemonth=:milestonemonth,milestoneremark=:milestoneremark,modifiedby=:modifiedby,modifieddate=:modifieddate where initiationscheduleid=:initiationscheduleid and isactive='1'";
	private static final String PROJECTSHDULEDELETE="update pfms_initiation_schedule set modifiedby=:modifiedby,modifieddate=:modifieddate,isactive='0' where initiationscheduleid=:initiationscheduleid and isactive='1'";
	private static final String PROJECTCOSTUPDATE="UPDATE pfms_initiation SET fecost=:fecost,recost=:recost,projectcost=:projectcost,modifieddate=:modifieddate, modifiedby=:modifiedby WHERE initiationid=:initiationid";	
	private static final String PROJECTDETAILSREQUPDATE="update pfms_initiation_detail set requirements=:requirements, reqbrief=:reqbrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSOBJUPDATE="update pfms_initiation_detail set objective=:objective, objbrief=:objbrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSSCOPEUPDATE="update pfms_initiation_detail set scope=:scope, scopebrief=:scopebrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSMULTIUPDATE="update pfms_initiation_detail set multilabworkshare=:multilab, multilabbrief=:multibrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSEARLYUPDATE="update pfms_initiation_detail set earlierwork=:earlierwork, earlierworkbrief=:earlibrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSCOMPETANCYUPDATE="update pfms_initiation_detail set compentencyestablished=:competancy, compentencybrief=:combrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSNEEDOFUPDATE="update pfms_initiation_detail set needofproject=:needofproject, needofprojectbrief=:needbrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSTECHUPDATE="update pfms_initiation_detail set technologychallanges=:technology, technologybrief=:techbrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSRISKUPDATE="update pfms_initiation_detail set riskmitigation=:riskmitigation, riskmitigationbrief=:riskbrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSPROPOSALUPDATE="update pfms_initiation_detail set proposal=:proposal, proposalbrief=:probrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSREALIZATIONUPDATE="update pfms_initiation_detail set realizationplan=:realization, realizationbrief=:realizationbrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";
	private static final String PROJECTDETAILSWORLDUPDATE="update pfms_initiation_detail set worldscenario=:worldscenario,worldscenariobrief=:worldbrief, modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid";	
	private static final String PROJECTSCHTOTALMONTH="select sum(milestonemonth) from pfms_initiation_schedule where InitiationId=:InitiationId and isactive='1'";
/*L.A*/private static final String PROJECTDURMONTH="SELECT MAX(MilestoneTotalMonth) FROM pfms_initiation_schedule WHERE InitiationId=:InitiationId AND isactive='1'";
/*L.A*/ private static final String MILESCHMONTH="SELECT MAX(MilestoneTotalMonth) FROM pfms_initiation_schedule WHERE MilestoneTotalMonth !=(SELECT MilestoneTotalMonth FROM pfms_initiation_schedule WHERE InitiationScheduleId=:initiationscheduleid AND IsActive='1') AND InitiationId=:IntiationId AND IsActive='1';";	
	private static final String MILESTONENO="select max(MilestoneNo) from pfms_initiation_schedule where InitiationId=:InitiationId and isactive='1'";
	private static final String SCDULEMONTH="select milestonemonth from pfms_initiation_schedule where initiationscheduleid=:initiationscheduleid and isactive='1'";
	/*L.A*/private static final String PREVIOUSMONTH="SELECT milestonemonth FROM pfms_initiation_schedule WHERE milestoneno=:milestoneno AND initiationid=:IntiationId AND isactive='1'";
	/*L.A*/private static final String MILESTONENOTOTALMONTH="SELECT MilestoneTotalMonth FROM pfms_initiation_schedule WHERE milestoneno=:milestoneno AND initiationid=:IntiationId AND isactive='1'";
	private static final String PROJECTINTATTACH="SELECT a.initiationattachmentid,a.initiationid,a.filename,a.filenamepath,a.createdby,a.createddate,b.initiationattachmentfileid FROM pfms_initiation_attachment a,pfms_initiation_attachment_file b WHERE isactive='1' AND initiationid=:initiationid AND a.initiationattachmentid=b.initiationattachmentid";
	private static final String PROJECTINTATTACHDELETE="update pfms_initiation_attachment set isactive='0',modifiedby=:modifiedby, modifieddate=:modifieddate where initiationattachmentid=:initiationattachmentid";
	private static final String PROJECTINTATTACHUPDATE="update pfms_initiation_attachment set filename=:filename,modifiedby=:modifiedby, modifieddate=:modifieddate where initiationattachmentid=:initiationattachmentid";
	private static final String PROJECTINTATTACHFILENAME="select a.filename from pfms_initiation_attachment a where a.isactive='1' and a.initiationattachmentid=:initiationattachmentid ";
	private static final String PROJECTINTATTACHFILENAMEPATH="select a.filenamepath from pfms_initiation_attachment a where a.isactive='1' and a.initiationattachmentid=:initiationattachmentid ";
	private static final String PROJECTINTLABUPDATE="update pfms_initiation_lab set isactive='0' ,modifiedby=:modifiedby, modifieddate=:modifieddate where initiationlabid=:initiationlabid";
	private static final String PROJECTINTCOSTDELETE="update pfms_initiation_cost set isactive='0' ,modifiedby=:modifiedby, modifieddate=:modifieddate where initiationcostid=:initiationcostid ";
	private static final String PROJECTSTATUSUPDATE="update pfms_initiation set projectstatus=:projectstatus,approvalid=:approvalid,modifiedby=:modifiedby, modifieddate=:modifieddate where initiationid=:initiationid ";
	private static final String PROJECTACTIONLIST="select projectauthorityid,status,statusaction from pfms_project_authority_actionlist where projectauthorityid=:projectauthorityid";
	private static final String EMPLOYEELIST="select a.empid,CONCAT(IFNULL(CONCAT(a.title,' '),''), a.empname) AS 'empname' ,b.designation FROM employee a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId AND a.LabCode=:LabCode ORDER BY a.srno=0,a.srno";
	private static final String PFMSINITIATIONREFESUM= "SELECT SUM(a.itemcost) AS 'recost'  FROM pfms_initiation_cost a, budget_item_sanc b  WHERE a.budgetsancid=b.sanctionitemid AND a.isactive=1 AND a.initiationid=:initiationid AND b.refe=:refe";
	private static final String PROJECTSTATUSLIST="SELECT b.projecttypeshort,c.classification,a.projecttitle,a.projectshortname,a.projectcost,a.projectduration,d.statusdetail,a.initiationid FROM pfms_initiation a,project_type b, pfms_security_classification c,pfms_project_authority_actionlist d WHERE (CASE WHEN :logintype IN ('Z','Y','A','E') THEN a.LabCode=:LabCode ELSE a.empid=:empid END ) AND a.classificationId=c.classificationId AND a.ProjectTypeId=b.ProjectTypeId AND a.projectstatus=d.Status";
	private static final String PROJECTAPPROVALTRACKING="SELECT a.projectapprovalid,a.empid,c.empname,d.designation,e.divisionname,a.actiondate,a.remarks,b.statusdetail FROM project_approval a, pfms_project_authority_actionlist b,employee c,employee_desig d,division_master e WHERE a.projectstatus=b.Status AND a.empid=c.empid  AND c.desigid=d.desigid AND c.divisionid=e.divisionid AND a.initiationid=:initiationid";
	private static final String PROJECTINTIDATAPREVIEW="SELECT a.initiationid,d.empname,e.divisioncode,a.projectprogramme,b.projecttype,c.classification,a.projectshortname,a.projecttitle,a.projectcost, a.projectduration,a.isplanned,a.ismultilab,a.deliverable,a.labcount,a.fecost,a.recost,a.ismain,f.projectshortname AS 'initiatedproject' FROM pfms_initiation a,project_type b,pfms_security_classification c,employee d,division_master e,pfms_initiation f WHERE a.initiationid=:initiationid AND a.classificationid=c.classificationid  AND a.projecttypeid=b.projecttypeid AND a.empid=d.empid AND a.divisionid=e.divisionid AND a.isactive='1' AND a.mainid=f.initiationid UNION SELECT a.initiationid,d.empname,e.divisioncode,a.projectprogramme,b.projecttype,c.classification,a.projectshortname,a.projecttitle,a.projectcost, a.projectduration,a.isplanned,a.ismultilab,a.deliverable,a.labcount,a.fecost,a.recost,a.ismain,a.projecttitle AS 'initiatedproject' FROM pfms_initiation a,project_type b,pfms_security_classification c,employee d,division_master e WHERE a.initiationid=:initiationid AND a.classificationid=c.classificationid  AND a.projecttypeid=b.projecttypeid AND a.empid=d.empid AND a.divisionid=e.divisionid AND a.isactive='1' AND a.mainid=0 ";
	private static final String PROJECTINTITOTALFECOST="select sum(a.ItemCost) from pfms_initiation_cost a,budget_item_sanc b where a.initiationid=:initiationid and a.isactive='1' and a.budgetsancid=b.sanctionitemid and a.refe='FE' ";
	private static final String PROJECTINTITOTALRECOST="select sum(a.ItemCost) from pfms_initiation_cost a,budget_item_sanc b where a.initiationid=:initiationid and a.isactive='1' and a.budgetsancid=b.sanctionitemid and a.refe='RE' ";
	private static final String PROJECTDURATIONUPDATE="update pfms_initiation set projectduration=:duration where initiationid=:initiationid";
	private static final String PROJECTCOSTDATA="select fecost , recost from pfms_initiation where initiationid=:initiationid ";
	private static final String PROJECTSHDULEINITUPDATE="update pfms_initiation set projectduration=:milestonemonth where initiationid=:initiationid and isactive='1'";
	private static final String TCCPROJECTLIST="SELECT projecttitle,projectshortname, initiationid FROM pfms_initiation WHERE projectstatus='PTA' AND isactive='1' ";
	private static final String EXPERTLIST="SELECT a.expertid,a.expertname,b.designation FROM expert a,employee_desig b WHERE a.isactive='1' AND a.DesigId=b.DesigId";
	private static final String DIVISIONHEADID="SELECT a.divisionheadid FROM division_master a, employee b WHERE a.divisionid=b.divisionid AND b.empid=:empid";
	private static final String RTMDDOID="SELECT empid FROM pfms_rtmddo WHERE isactive=1 AND Type='DO-RTMD' " ;
	private static final String TCCCHAIRPERSONID="SELECT labauthorityid FROM lab_master WHERE labcode=:labcode";
	private static final String CCMCHAIRPERSONID="SELECT labdgid FROM lab_master WHERE labcode=:labcode";
	private static final String ADID="SELECT empid FROM pfms_rtmddo WHERE isactive=1 AND TYPE='AD';";  
    private static final String APPSTATUSLIST="SELECT a.status, a.statusaction FROM pfms_project_authority_actionlist  a WHERE projectauthorityid=:AuthoId";
    private static final String PROJECTSTAGEDETAILSLIST ="SELECT projectstageid,projectstagecode,projectstage FROM pfms_project_stage";
    private static final String PROJECTDATADETAILS="SELECT ppd.projectdataid,ppd.projectid,ppd.filespath,ppd.systemconfigimgname,ppd.SystemSpecsFileName,ppd.ProductTreeImgName,ppd.PEARLImgName,ppd.CurrentStageId,ppd.RevisionNo,pps.projectstagecode,pps.projectstage,ppd.proclimit,ppd.LastPmrcDate,ppd.LastEBDate FROM pfms_project_data ppd, pfms_project_stage pps WHERE ppd.CurrentStageId=pps.projectstageid AND ppd.projectid=:projectid";
	private static final String PROJECTDATASPECSFILEDATA  ="SELECT projectdataid,projectid,filespath, systemspecsfilename,systemconfigimgname,producttreeimgname,pearlimgname FROM pfms_project_data WHERE projectdataid=:projectdataid";
	private static final String PROJECTDATASPECSREVFILEDATA  ="SELECT projectdatarevid,projectid,filespath, systemspecsfilename,systemconfigimgname,producttreeimgname,pearlimgname  FROM pfms_project_data_rev WHERE projectdatarevid=:projectdatarevid";
	private static final String PROJECTDATAREVLIST="SELECT ProjectDataRevId,ProjectId,RevisionNo,RevisionDate FROM pfms_project_data_rev WHERE ProjectId=:projectid ORDER BY RevisionNo DESC";
	private static final String INITIATEDPROJECT="SELECT initiationid,projecttitle,projectshortname,empid,divisionid,projectprogramme,projecttypeid,classificationid FROM pfms_initiation WHERE isactive=1 AND ismain='Y'";  
    private static final String INITIATEDPROJECTDETAILS="SELECT a.initiationid,a.projectprogramme,a.classificationid,b.projecttype AS category, a.projecttypeid,c.classification AS securityclassification,d.labid,d.labcode,d.labname, a.projectshortname, a.projecttitle FROM pfms_initiation a,project_type b,pfms_security_classification c ,cluster_lab d WHERE a.classificationid=c.classificationid AND a.projecttypeid=b.projecttypeid AND a.isactive=1 AND a.initiationid=:initiationid AND a.nodallab=d.labid";
	private static final String NODALLABLIST="SELECT labid,clusterid,labname,labcode FROM cluster_lab";
    private static final String SUBPROJECTLIST="SELECT initiationid,projecttitle FROM pfms_initiation WHERE mainid=:initiationid AND isactive=1 AND ismain='N' ";
    private static final String PROJECTDATAREVDATA="SELECT ppdr.projectdatarevid,ppdr.projectid,ppdr.filespath,ppdr.systemconfigimgname,ppdr.SystemSpecsFileName,ppdr.ProductTreeImgName,ppdr.PEARLImgName,ppdr.CurrentStageId,ppdr.RevisionNo,pps.projectstagecode,pps.projectstage,ppdr.revisiondate FROM pfms_project_data_rev ppdr, pfms_project_stage pps WHERE ppdr.CurrentStageId=pps.projectstageid AND  ppdr.projectdatarevid=:projectdatarevid";
    private static final String STATUSDETAILS="SELECT statusdetail FROM pfms_project_authority_actionlist WHERE status=:status ";
    private static final String INTEMPID="select empid from pfms_initiation where initiationid=:id";
    private static final String PROJECTRISKDATALIST="SELECT DISTINCT am.actionmainid, am.actionitem, am.projectid, aas.actionstatus,am.type,am.scheduleminutesId  ,aas.actionassignid FROM action_main am , action_assign aas WHERE aas.actionmainid=am.actionmainid AND am.type='K' AND  CASE WHEN :projectid > 0 THEN am.projectid=:projectid ELSE aas.assignorlabcode=:LabCode END"; 
	private static final String PROJECTRISKDATA ="SELECT DISTINCT am.actionmainid, am.actionitem, am.projectid, aas.actionstatus,am.type,aas.pdcorg,aas.enddate FROM action_main am ,action_assign aas WHERE aas.actionmainid=am.actionmainid AND  am.type='K' AND am.actionmainid=:actionmainid";
	private static final String AUTHORITYATTACHMENT="SELECT a.authorityid,a.initiationid,a.authorityname,a.letterdate,a.letterno,c.attachmentname,b.empname,c.initiationauthorityfileid FROM pfms_initiation_authority a,employee b,pfms_initiation_authority_file c WHERE a.initiationid=:initiationid AND a.authorityname=b.empid AND a.authorityid=c.authorityid";
	private static final String AUTHORITYUPDATE="UPDATE pfms_initiation_authority SET authorityname=:authorityname, letterdate=:letterdate,letterno=:letterno, modifiedby=:modifiedby,modifieddate=:modifieddate WHERE initiationid=:initiationid";
	private static final String AUTHORITYFILEUPDATE="UPDATE pfms_initiation_authority_file SET attachmentname=:attachmentname,file=:file WHERE initiationauthorityfileid=:initiationauthorityfileid ";
	private static final String PROJECTMAINLIST="SELECT a.projectmainid,b.projecttypeid,b.projecttype,a.projectcode,a.projectname, a.projectdescription, a.unitcode, a.sanctionno, a.sanctiondate, a.totalsanctioncost, a.pdc, a.revisionno,a.objective,a.deliverable FROM project_main a, project_type b WHERE a.projecttypeid=b.projecttypeid AND a.isactive='1' AND b.isactive='1' ORDER BY a.sanctiondate DESC";
	private static final String OFFICERLIST="SELECT a.empid, a.empno, a.empname, b.designation, a.extno, a.email, c.divisionname, a.desigid, a.divisionid,a.labcode FROM employee a,employee_desig b, division_master c WHERE a.desigid= b.desigid AND a.divisionid= c.divisionid AND a.isactive='1' ORDER BY a.srno=0,a.srno ASC ";
	private static final String PROJECTMAINCLOSE="update project_main set modifiedby=:modifiedby, modifieddate=:modifieddate,isactive='0'  WHERE isactive='1' and projectmainid=:projectmainid";
	private static final String PROJECTMAINEDITDATA="SELECT a.projectmainid,b.projecttypeid,b.projecttype,a.projectcode,a.projectname, a.projectdescription, a.unitcode, a.sanctionno, a.sanctiondate, a.sanctioncostre, a.sanctioncostfe, a.totalsanctioncost, a.pdc,a.projectdirector,a.projsancauthority,a.boardreference,a.ismainwc,a.workcenter, a.revisionno,a.objective,a.deliverable, a.LabParticipating,a.CategoryId,a.scope FROM project_main a, project_type b WHERE a.projecttypeid=b.projecttypeid and a.projectmainid=:promainid and a.isactive='1' and b.isactive='1' ORDER BY a.projecttypeid, a.projectmainid";
	private static final String PROJECTMAINUPDATE="UPDATE project_main SET projecttypeid=:projecttypeid,projectcode=:projectcode,projectname=:projectname,projectdescription=:projectdescription, unitcode=:unitcode, sanctionno=:sanctionno, sanctiondate=:sanctiondate,sanctioncostre=:sanctioncostre, sanctioncostfe=:sanctioncostfe,totalsanctioncost=:totalsanctioncost,pdc=:pdc,projectdirector=:projectdirector,projsancauthority=:projsancauthority,boardreference=:boardreference,ismainwc=:ismainwc,workcenter=:workcenter,objective=:objective,deliverable=:deliverable,modifiedby=:modifiedby, modifieddate=:modifieddate, LabParticipating=:labparticipating, CategoryId=:categoryId, Scope=:scope  WHERE  projectmainid=:promainid  AND isactive='1' ";
	private static final String PROJECTLIST1="SELECT a.projectid,b.projectmainid,b.projectcode AS id,a.projectcode,a.projectname, a.projectdescription, a.unitcode, a.sanctionno, a.sanctiondate, a.totalsanctioncost, a.pdc, a.revisionno,a.objective,a.deliverable,a.labcode FROM project_main b, project_master a, project_type c WHERE c.projecttypeid=b.projecttypeid AND a.projectmainid=b.projectmainid AND a.isactive='1' AND b.isactive='1' ORDER BY a.sanctiondate DESC";
	private static final String PROJECTTYPEMAINLIST="SELECT b.projectmainid,b.projectcode as id from  project_main b WHERE  b.isactive='1' ";
	private static final String PROJECTCATEGORY="select classificationid, classification from pfms_security_classification";
	private static final String PROJECTCLOSE="update project_master set modifiedby=:modifiedby, modifieddate=:modifieddate,isactive='0'  WHERE isactive='1' and projectid=:projectid";
	private static final String PROJECTEDITDATA="SELECT a.projectid,b.projectmainid,c.projecttype as id,a.projectcode,a.projectname, a.projectdescription, a.unitcode, a.sanctionno, a.sanctiondate, a.sanctioncostre, a.sanctioncostfe, a.totalsanctioncost, a.pdc,a.projectdirector,a.projsancauthority,a.boardreference,a.ismainwc,a.workcenter, a.revisionno,a.objective,a.deliverable,a.projectcategory, a.ProjectType ,a.ProjectShortName ,a.EndUser FROM project_main b, project_master a, project_type c WHERE c.projecttypeid=b.projecttypeid and a.projectid=:proid and a.projectmainid=b.projectmainid and a.isactive='1' and b.isactive='1' ORDER BY a.projectid, a.projectmainid";
	private static final String PROJECTITEMLIST11="SELECT a.projectid, a.projectcode,a.projectname FROM project_master a WHERE isactive='1'";
	private static final String PROJECTASSIGNLIST="SELECT a.projectemployeeid, c.empid, a.projectid, CONCAT(IFNULL(CONCAT(c.title,' '),''), c.empname) AS 'empname' , d.designation, e.divisioncode  FROM project_employee a, employee c, employee_desig d, division_master e WHERE a.empid=c.empid AND c.desigid=d.desigid AND c.divisionid=e.divisionid AND  a.isactive='1' AND c.isactive='1' AND e.isactive='1'  AND a.projectid= :proid "; 
	private static final String USERLIST="SELECT  b.empid, CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'empname',b.labcode,c.designation FROM employee b, employee_desig c  WHERE  b.isactive=1 AND b.desigid=c.desigid AND b.EmpId NOT IN( SELECT EmpId FROM project_employee WHERE ProjectId=:projectid AND IsActive='1')";
	private static final String PROJECTDATA="SELECT a.projectid, a.projectcode FROM project_master a WHERE a.projectid=:proid";
	private static final String PROJECTASSIGNREVOKE="update project_employee set modifiedby=:modifiedby, modifieddate=:modifieddate,isactive='0'  WHERE isactive='1' and projectemployeeid=:proempid";
	private static final String PROJECTRISKMATRIXDATA="SELECT riskid,projectid,actionmainid,description, severity,probability,mitigationplans,revisionno,LabCode,RPN,Impact,Category,RiskTypeId , status , remarks FROM pfms_risk WHERE actionmainid=:actionmainid";
	private static final String PROJECTRISKDATAEDIT="UPDATE pfms_risk SET severity =:severity , probability=:probability , mitigationplans=:mitigationplans ,revisionno=:revisionno, modifiedby=:modifiedby , modifieddate=:modifieddate, RPN=:RPN,Impact=:Impact, Category=:Category, RiskTypeId=:RiskTypeId WHERE riskid=:riskid";
	private static final String PROJECTRISKMATRIXREVLIST="SELECT rr.riskrevisionid,rr.projectid,rr.actionmainid,rr.description, rr.severity,rr.probability,rr.mitigationplans,rr.revisionno,rr.revisiondate,rr.RPN,rr.Impact,rr.category,rr.RisktypeId, rt.risktype FROM pfms_risk_rev rr, pfms_risk_type rt WHERE rr.risktypeid=rt.risktypeid AND actionmainid=:actionmainid  ORDER BY revisionno DESC";		
	private static final String RISKDATAPRESENTLIST="SELECT actionmainid , status FROM pfms_risk WHERE projectid=:projectid ";  
	private final static String PROCATSECDETAILS ="SELECT ProjectTypeId, CategoryId FROM project_main WHERE ProjectMainId=:projectmainid";
	
	private static final String DIRECTOREMPDATA  ="SELECT a.labauthorityid, CONCAT(IFNULL(CONCAT(b.title,' '),''), b.empname) AS 'empname' ,c.designation,'TCM'  FROM lab_master a, employee b,employee_desig c WHERE a.labauthorityid=b.empid AND b.desigid=c.desigid AND a.labcode=:labcode ";
	private static final String EMPDIVHEADDATA ="SELECT e2.empid, CONCAT(IFNULL(CONCAT(e2.title,' '),''), e2.empname) AS 'empname' , ed.designation,'Division Head'  FROM employee e1, employee e2, employee_desig ed, division_master dm WHERE e1.divisionid=dm.divisionid AND dm.divisionheadid=e2.empid AND e2.desigid=ed.desigid  AND e1.empid=:empid";
	private static final String INITCOMMDEFAULT="SELECT comminitdefaultid, committeeid FROM committee_initiation_default";
	private static final String PROJECTTYPEMAINLISTNOTADDED="SELECT b.projectmainid,b.projectcode AS id FROM  project_main b WHERE  b.isactive='1' AND b.projectmainid NOT IN (SELECT a.projectmainid FROM project_master a WHERE a.isactive=1 AND projectmainid>0)";
	
	private static final String PROJECTREVLIST = "SELECT pr.projectid, pr.revisionno,pm.projectcode AS 'ProjectMainCode', pr.projectcode, pr.projectname, pr.projectdescription, pr.unitcode, pt.projecttype,ps.classification,pr.sanctionno,pr.sanctiondate, CASE WHEN pr.totalsanctioncost>0 THEN ROUND(pr.totalsanctioncost/100000,2) ELSE pr.totalsanctioncost END AS 'TotalSanctionCost', pr.pdc, e.empname AS 'ProjectDirector' , ed.designation  FROM project_master p, project_master_rev pr , project_main pm, project_type pt, pfms_security_classification ps, employee e, employee_desig ed WHERE p.projectid=pr.projectid AND pr.projectmainid = pm.projectmainid AND pr.projecttype=pt.projecttypeid AND ps.classificationid =pr.projectcategory AND e.empid=pr.projectdirector AND e.desigid=ed.desigid  AND p.projectid=:projectid UNION SELECT pr.projectid, pr.revisionno,pm.projectcode AS 'ProjectMainCode', pr.projectcode, pr.projectname, pr.projectdescription, pr.unitcode, pt.projecttype,ps.classification,pr.sanctionno,pr.sanctiondate,CASE WHEN pr.totalsanctioncost>0 THEN ROUND(pr.totalsanctioncost/100000,2) ELSE pr.totalsanctioncost END AS 'TotalSanctionCost', pr.pdc, e.empname AS 'ProjectDirector' , ed.designation  FROM project_master pr, project_main pm, project_type pt, pfms_security_classification ps, employee e, employee_desig ed WHERE  pr.projectmainid = pm.projectmainid AND pr.projecttype=pt.projecttypeid AND ps.classificationid =pr.projectcategory AND e.empid=pr.projectdirector AND e.desigid=ed.desigid  AND pr.projectid=:projectid ";
	private static final String PROJECTMASTERATTACHLIST = "SELECT projectattachid,filename  FROM project_master_attach  WHERE projectid=:projectid";
	private static final String PROJECTMASTERATTACHDATA = "SELECT projectattachid,filename,path,originalfilename,projectid  FROM project_master_attach  WHERE projectattachid= :projectattachid ";
	private static final String PROJECTMASTERATTACHDELETE = "DELETE FROM  project_master_attach WHERE projectattachid=:projectattachid ";
	
	
	
    @Autowired
	ProjectMasterRepo pmrepo;
	
	@PersistenceContext
	EntityManager manager;

	@Override
	public List<Object[]> ProjectIntiationList(String Empid,String LoginType,String LabCode) throws Exception {
		
		Query query=manager.createNativeQuery(PROJECTINTILIST);
		query.setParameter("empid", Empid);
		query.setParameter("logintype", LoginType);
		query.setParameter("LabCode", LabCode);
		List<Object[]> ProjectIntiationList=(List<Object[]>)query.getResultList();		

		return ProjectIntiationList;
	}

	@Override
	public List<Object[]> ProjectTypeList() throws Exception {	
		
		Query query=manager.createNativeQuery(PROJECTTYPELIST);
		List<Object[]> ProjectTypeList=(List<Object[]>)query.getResultList();		

		return ProjectTypeList;
	}
	
	@Override
	public List<Object[]> OfficerList() throws Exception {
		Query query=manager.createNativeQuery(OFFICERLIST);
		List<Object[]> OfficerList=(List<Object[]>)query.getResultList();
		return OfficerList;
	}

	@Override
	public Long ProjectMainAdd(ProjectMain proType) throws Exception {
        manager.persist(proType);
		manager.flush();
		return proType.getProjectMainId();
	}
	

	
	@Override
	public List<Object[]> PfmsCategoryList() throws Exception {
		Query query=manager.createNativeQuery(PROJECTCATEGORYLIST);
		List<Object[]> PfmsCategoryList=(List<Object[]>)query.getResultList();		

		return PfmsCategoryList;
	}

	@Override
	public List<Object[]> PfmsDeliverableList() throws Exception {
		Query query=manager.createNativeQuery(PROJECTDELIVERABLELIST);
		List<Object[]> PfmsDeliverableList=(List<Object[]>)query.getResultList();		

		return PfmsDeliverableList;
	}

	@Override
	public List<Object[]> LabList(String IntiationId) throws Exception {
		Query query=manager.createNativeQuery(LABLIST);
		query.setParameter("initiationid", IntiationId);
		List<Object[]> LabList=(List<Object[]>)query.getResultList();		

		return LabList;
	}
	
   @Transactional
	@Override
	public Long ProjectIntiationAdd(PfmsInitiation pfmsinitiation,PfmsNotification notification)
			throws Exception {
		manager.persist(pfmsinitiation);
		manager.persist(notification);
		
		manager.flush();
		return pfmsinitiation.getInitiationId();
	}

@Override
public Long ProjectShortNameCount(String ProjectShortName) throws Exception {
	
	Query query=manager.createNativeQuery(PROJECTSHORTNAMECHECK);
	query.setParameter("projectshortname", ProjectShortName);
	
	BigInteger ProjectShortNameCount=(BigInteger)query.getSingleResult();		

	return ProjectShortNameCount.longValue();
}

@Override
public List<Object[]> ProjectDetailes(Long IntiationId) throws Exception {
    Query query=manager.createNativeQuery("CALL Pfms_Project_Initiation_Data(:InitiationId)");
	query.setParameter("InitiationId", IntiationId);
	List<Object[]> ProjectDetailes=(List<Object[]>)query.getResultList();		
	
	return ProjectDetailes;
}

@Override
public List<Object[]> ProjectDetailsPreview(Long IntiationId) throws Exception {
    Query query=manager.createNativeQuery(PROJECTINTIDATAPREVIEW);
    query.setParameter("initiationid", IntiationId);
	List<Object[]> ProjectDetailsPreview=(List<Object[]>)query.getResultList();		
	
	return ProjectDetailsPreview;
}


@Override
public Long ProjectIntiationDetailAdd(PfmsInitiationDetail pfmsinitiationdetail) throws Exception {
	manager.persist(pfmsinitiationdetail);
	
	manager.flush();
	return pfmsinitiationdetail.getInitiationDetailId();
}

@Override
public int ProjectLabAdd(List<PfmsInitiationLab> pfmsinitiationlablist,PfmsInitiation pfmsinitiation) throws Exception {
	for(PfmsInitiationLab lab:pfmsinitiationlablist) {
		manager.persist(lab);
	}
	    Query query=manager.createNativeQuery(PROJECTINTIUPDATE);
	    query.setParameter("initiationid", pfmsinitiation.getInitiationId());
	    query.setParameter("labcount", pfmsinitiation.getLabCount());
	    query.setParameter("modifiedby",   pfmsinitiation.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiation.getModifiedDate());
	
		manager.flush();
	return query.executeUpdate();
}

@Override
public List<Object[]> BudgetItem(String BudegtId) throws Exception {
    Query query=manager.createNativeQuery(BUDEGTITEM);
    query.setParameter("budgetheadid", BudegtId);
	List<Object[]> BudgetItem=(List<Object[]>)query.getResultList();		
	
	return BudgetItem;
}

@Override
public List<Object[]> ProjectIntiationItemList(String InitiationId) throws Exception {
	 Query query=manager.createNativeQuery(PROJECTITEMLIST);
    query.setParameter("initiationid", InitiationId);
	List<Object[]> ProjectIntiationItemList=(List<Object[]>)query.getResultList();		
	
	return ProjectIntiationItemList;
}

@Override
public Long ProjectIntiationCostAdd(PfmsInitiationCost pfmsinitiationcost,String ReFe,PfmsInitiation pfmsinitiation) throws Exception {
	manager.persist(pfmsinitiationcost);
	manager.flush();

	return pfmsinitiationcost.getInitiationCostId();
}

@Override
public List<Object[]> ProjectIntiationLabList(String InitiationId) throws Exception {
	    Query query=manager.createNativeQuery(PROJECTLABLIST);
	    query.setParameter("initiationid", InitiationId);
		List<Object[]> ProjectIntiationLabList=(List<Object[]>)query.getResultList();		
		
		return ProjectIntiationLabList;
}

@Override
public List<Object[]> BudgetHead() throws Exception {
	 Query query=manager.createNativeQuery(BUDEGTHEADLIST);
	List<Object[]> BudgetHead=(List<Object[]>)query.getResultList();		
	
	return BudgetHead;
}

@Override
public Long ProjectScheduleAdd(List<PfmsInitiationSchedule> pfmsinitiationschedulelist,PfmsInitiation pfmsinitiation) throws Exception {
	
	Long count=0L;
	for(PfmsInitiationSchedule schedule:pfmsinitiationschedulelist) {
		
		manager.persist(schedule);
		count=schedule.getInitiationId();		
	}
	
	Query query=manager.createNativeQuery(PROJECTDURATIONUPDATE);
    query.setParameter("initiationid", pfmsinitiationschedulelist.get(0).getInitiationId());
    query.setParameter("duration", pfmsinitiation.getProjectDuration());
    query.executeUpdate();
	
	manager.flush();
	return count;
}

@Override
public List<Object[]> ProjectIntiationScheduleList(String InitiationId) throws Exception {
	
    Query query=manager.createNativeQuery(PROJECTSCHEDULELIST);
    query.setParameter("initiationid", InitiationId);
	List<Object[]> ProjectIntiationScheduleList=(List<Object[]>)query.getResultList();		
	
	return ProjectIntiationScheduleList;
}

private static final String INTIATIONSCHEDULELIST = "from PfmsInitiationSchedule where InitiationId=:InitiationId and IsActive=1 ORDER BY Milestonestartedfrom ASC";
@Override
public List<PfmsInitiationSchedule> IntiationScheduleList(String InitiationId) throws Exception {
	
    Query query=manager.createQuery(INTIATIONSCHEDULELIST);
    query.setParameter("InitiationId", Long.parseLong(InitiationId));
    return (List<PfmsInitiationSchedule>)query.getResultList();		
	
}

@Override
public List<Object[]> ProjectScheduleTotalMonthList(String InitiationId) throws Exception {
	// TODO Auto-generated method stub
	Query query =manager.createNativeQuery(PROJECTSCHEDULETOTALMONTHLIST);
	  query.setParameter("initiationid", InitiationId);
	  List<Object[]>ProjectScheduleTotalMonthList=(List<Object[]>)query.getResultList();
	  return ProjectScheduleTotalMonthList;
}	
@Override
public List<Object[]> MileStonenoTotalMonths(String InitiationId, int msno) throws Exception {
	// TODO Auto-generated method stub
	Query query =manager.createNativeQuery(MILESTONENOTOTALMONTHS);
	query.setParameter("InitiationId",InitiationId );
	query.setParameter("milestonestartedfrom",msno);
	  List<Object[]> MileStonenoTotalMonths=(List<Object[]>)query.getResultList();
	  return  MileStonenoTotalMonths;
}

@Override
public Object[] ProjectProgressCount(String InitiationId) throws Exception {
	Query query=manager.createNativeQuery("CALL ProjectProgressBar(:InitiationId)");
	query.setParameter("InitiationId", InitiationId);
	Object[] ProjectProgressCount=(Object[])query.getSingleResult();	
		
		return ProjectProgressCount;
}

@Override
public List<Object[]> ProjectIntiationDetailsList(String InitiationId) throws Exception {
	Query query=manager.createNativeQuery(PROJECTDETAILSLIST);
	query.setParameter("initiationid", InitiationId);
	List<Object[]> ProjectIntiationDetailsList=(List<Object[]> )query.getResultList();	
		
	
		return ProjectIntiationDetailsList;
}


@Override
public List<Object[]> ProjectIntiationCostList(String InitiationId) throws Exception {
    Query query=manager.createNativeQuery(PROJECTCOSTLIST);
    query.setParameter("initiationid", InitiationId);
	List<Object[]> ProjectIntiationCostList=(List<Object[]>)query.getResultList();		
	
	return ProjectIntiationCostList;
}

@Override
public List<Object[]> ProjectEditData(String IntiationId) throws Exception {
    Query query=manager.createNativeQuery(PROJECTINTIEDITDATA);
    query.setParameter("initiationid", IntiationId);
	List<Object[]> ProjectEditData=(List<Object[]>)query.getResultList();		
	
	return ProjectEditData;
}

@Transactional
@Override
public int ProjectIntiationEdit(PfmsInitiation pfmsinitiation) throws Exception {
	
	 Query query=manager.createNativeQuery(PROJECTINTIEDITUPDATE);
	    query.setParameter("initiationid", pfmsinitiation.getInitiationId());
	    query.setParameter("projectprogramme", pfmsinitiation.getProjectProgramme());
	    query.setParameter("projecttypeid", pfmsinitiation.getProjectTypeId());
	    query.setParameter("classificationid", pfmsinitiation.getClassificationId());
	    query.setParameter("nodallab", pfmsinitiation.getNodalLab());
	    
	    query.setParameter("projecttitle", pfmsinitiation.getProjectTitle());
	    query.setParameter("isplanned", pfmsinitiation.getIsPlanned());
	    query.setParameter("ismultilab", pfmsinitiation.getIsMultiLab());
	    
	    query.setParameter("deliverable", pfmsinitiation.getDeliverable());
	    query.setParameter("remarks", pfmsinitiation.getRemarks());
	    
	    query.setParameter("modifiedby",   pfmsinitiation.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiation.getModifiedDate());
		
		query.setParameter("empid", pfmsinitiation.getEmpId());
		query.setParameter("pcduration", pfmsinitiation.getPCDuration());
		query.setParameter("indicativecost", pfmsinitiation.getIndicativeCost());
		query.setParameter("pcremarks", pfmsinitiation.getPCRemarks());
	
	
	return query.executeUpdate();
}

@Override
public Double TotalIntiationCost(String IntiationId) throws Exception {
	 Query query=manager.createNativeQuery(PROJECTINTITOTALCOST);
    query.setParameter("initiationid", IntiationId);
	BigDecimal TotalIntiationCost=(BigDecimal)query.getSingleResult();		
	if(TotalIntiationCost==null) {
		return 0.00;
	}
	return TotalIntiationCost.doubleValue();
}

@Override
public List<Object[]> ProjectCostEditData(String InitiationCostId) throws Exception {
	 Query query=manager.createNativeQuery(PROJECTINTICOSTDATA);
    query.setParameter("initiationcostid", InitiationCostId);
	List<Object[]> ProjectCostEditData=(List<Object[]>)query.getResultList();		
	
	return ProjectCostEditData;
}


@Override
public int ProjectIntiationCostEdit(PfmsInitiationCost pfmsinitiationcost) throws Exception {

	 	Query query=manager.createNativeQuery(PROJECTINTICOSTUPDATE);
	    query.setParameter("initiationcostid", pfmsinitiationcost.getInitiationCostId());
	    query.setParameter("budgetitemid", pfmsinitiationcost.getBudgetSancId());
	    query.setParameter("itemdetail", pfmsinitiationcost.getItemDetail());
	    query.setParameter("itemcost", pfmsinitiationcost.getItemCost());
	    query.setParameter("modifiedby",   pfmsinitiationcost.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationcost.getModifiedDate());
	
		int count=0;
		count=query.executeUpdate();

	return count;
}


@Override
public int ProjectIntiationCostsUpdate(PfmsInitiation pfmsinitiation) throws Exception 
{
	int count=0;

	Query query1=manager.createNativeQuery(PROJECTCOSTUPDATE);
	query1.setParameter("fecost",pfmsinitiation.getFeCost());
	query1.setParameter("recost",pfmsinitiation.getReCost());
	query1.setParameter("projectcost",  pfmsinitiation.getProjectCost());
	query1.setParameter("modifiedby",   pfmsinitiation.getModifiedBy());
	query1.setParameter("modifieddate", pfmsinitiation.getModifiedDate());
	query1.setParameter("initiationid", pfmsinitiation.getInitiationId());
	
	query1.executeUpdate();

return count;
	
}


@Override
public PfmsInitiationSchedule getInitiationSchedule(String InitiationScheduleId) throws Exception 
{
	return manager.find(PfmsInitiationSchedule.class,Long.parseLong(InitiationScheduleId));
}


@Override
public long ProjectScheduleEdit(PfmsInitiationSchedule pfmsinitiationschedule,PfmsInitiation pfmsinitiation ) throws Exception 
{
	manager.merge(pfmsinitiationschedule);
	manager.flush();
	Query query=manager.createNativeQuery(PROJECTSHDULEINITUPDATE);
	query.setParameter("initiationid", pfmsinitiation.getInitiationId());
 	query.setParameter("milestonemonth", pfmsinitiation.getProjectDuration());
 	int count2=query.executeUpdate();
	
	return pfmsinitiationschedule.getInitiationScheduleId();
}


	private static final String INITIATIONCLEARTOTALMONTH ="UPDATE pfms_initiation_schedule SET MilestoneTotalMonth = 0 WHERE InitiationId=:InitiationId";
	@Override
	public int InitiationClearTotalMonth(String InitiationId) throws Exception 
	{
		Query query1=manager.createNativeQuery(INITIATIONCLEARTOTALMONTH);
		query1.setParameter("InitiationId",InitiationId);
		return query1.executeUpdate();
	}

//@Override
//public int ProjectScheduleEdit(PfmsInitiationSchedule pfmsinitiationschedule,PfmsInitiation pfmsinitiation ) throws Exception {
//
//	Query query=manager.createNativeQuery(PROJECTSHDULEUPDATE);
//    query.setParameter("initiationscheduleid", pfmsinitiationschedule.getInitiationScheduleId());
//    query.setParameter("milestoneactivity", pfmsinitiationschedule.getMilestoneActivity());
//    query.setParameter("milestonemonth", pfmsinitiationschedule.getMilestoneMonth());
//    query.setParameter("milestoneremark", pfmsinitiationschedule.getMilestoneRemark());
//    query.setParameter("modifiedby",   pfmsinitiationschedule.getModifiedBy());
//	query.setParameter("modifieddate", pfmsinitiationschedule.getModifiedDate());
//	int count1=query.executeUpdate();
//	
	//Query query1=manager.createNativeQuery(PROJECTSHDULEINITUPDATE);
//    query1.setParameter("initiationid", pfmsinitiation.getInitiationId());
//    query1.setParameter("milestonemonth", pfmsinitiation.getProjectDuration());
//    int count2=query1.executeUpdate();
//    
//    
//return count1+count2;
//}
@Override
public int MilestoneTotalMonthUpdate(int newMilestoneTotalMonth, String IntiationId, String milestoneno)
		throws Exception {
	// TODO Auto-generated method stub
	
		Query query= manager.createNativeQuery(MILESTONETOTALMONTHUPDATE);
		query.setParameter("newMilestoneTotalMonth", newMilestoneTotalMonth);
		query.setParameter("InitiationId", IntiationId);
		query.setParameter("milestoneno", milestoneno);
		
		int count=query.executeUpdate();
		
		return count;
}


@Override
public int ProjectScheduleDelete(PfmsInitiationSchedule pfmsinitiationschedule,PfmsInitiation pfmsinitiation ) throws Exception {
	
	 Query query=manager.createNativeQuery(PROJECTSHDULEDELETE);
	 query.setParameter("initiationscheduleid", pfmsinitiationschedule.getInitiationScheduleId());

	    query.setParameter("modifiedby",   pfmsinitiationschedule.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationschedule.getModifiedDate());

		Query query1=manager.createNativeQuery(PROJECTSHDULEINITUPDATE);
	    query1.setParameter("initiationid", pfmsinitiation.getInitiationId());
	    query1.setParameter("milestonemonth", pfmsinitiation.getProjectDuration());
	    query1.executeUpdate();	
		

	return query.executeUpdate();
}
@Override
public Long ProjectInitiationDetailsUpdate (PfmsInitiationDetail pfmsinitiationdetail,String Details) throws Exception{
	
	if(Details.equalsIgnoreCase("requirement")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSREQUPDATE);
		query.setParameter("requirements", pfmsinitiationdetail.getRequirements());
		query.setParameter("reqbrief", pfmsinitiationdetail.getReqBrief());
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("objective")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSOBJUPDATE);
		query.setParameter("objective", pfmsinitiationdetail.getObjective());
		query.setParameter("objbrief", pfmsinitiationdetail.getObjBrief());
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("scope")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSSCOPEUPDATE);
		query.setParameter("scope", pfmsinitiationdetail.getScope());
		query.setParameter("scopebrief",pfmsinitiationdetail.getScopeBrief() );
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("multilab")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSMULTIUPDATE);
		query.setParameter("multilab", pfmsinitiationdetail.getMultiLabWorkShare());
		query.setParameter("multibrief", pfmsinitiationdetail.getMultiLabBrief());
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("earlierwork")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSEARLYUPDATE);
		query.setParameter("earlierwork", pfmsinitiationdetail.getEarlierWork());
		query.setParameter("earlibrief",pfmsinitiationdetail.getEarlierWorkBrief() );
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("competency")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSCOMPETANCYUPDATE);
		query.setParameter("competancy", pfmsinitiationdetail.getCompentencyEstablished());
		query.setParameter("combrief", pfmsinitiationdetail.getCompentencyBrief());
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("needofproject")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSNEEDOFUPDATE);
		query.setParameter("needofproject", pfmsinitiationdetail.getNeedOfProject());
		query.setParameter("needbrief", pfmsinitiationdetail.getNeedOfProjectBrief());
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("technology")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSTECHUPDATE);
		query.setParameter("technology", pfmsinitiationdetail.getTechnologyChallanges());
		query.setParameter("techbrief", pfmsinitiationdetail.getTechnologyBrief());
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("riskmitigation")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSRISKUPDATE);
		query.setParameter("riskmitigation", pfmsinitiationdetail.getRiskMitigation());
		query.setParameter("riskbrief",pfmsinitiationdetail.getRiskMitigationBrief() );
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("proposal")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSPROPOSALUPDATE);
		query.setParameter("proposal", pfmsinitiationdetail.getProposal());
		query.setParameter("probrief", pfmsinitiationdetail.getProposalBrief());
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("realization")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSREALIZATIONUPDATE);
		query.setParameter("realization", pfmsinitiationdetail.getRealizationPlan());
		query.setParameter("realizationbrief", pfmsinitiationdetail.getRealizationBrief());
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	if(Details.equalsIgnoreCase("worldscenario")) {
		Query query=manager.createNativeQuery(PROJECTDETAILSWORLDUPDATE);
		query.setParameter("worldscenario", pfmsinitiationdetail.getWorldScenario());
		query.setParameter("worldbrief", pfmsinitiationdetail.getWorldScenarioBrief());
		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
		int count=(int)query.executeUpdate();
	}
	

	return pfmsinitiationdetail.getInitiationId();
}

//@Override
//public Long ProjectInitiationDetailsUpdate (PfmsInitiationDetail pfmsinitiationdetail,String Details) throws Exception{
//	
//	if(Details.equalsIgnoreCase("requirement")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSREQUPDATE);
//		query.setParameter("requirements", pfmsinitiationdetail.getRequirements());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("objective")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSOBJUPDATE);
//		query.setParameter("objective", pfmsinitiationdetail.getObjective());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("scope")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSSCOPEUPDATE);
//		query.setParameter("scope", pfmsinitiationdetail.getScope());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("multilab")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSMULTIUPDATE);
//		query.setParameter("multilab", pfmsinitiationdetail.getMultiLabWorkShare());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("earlierwork")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSEARLYUPDATE);
//		query.setParameter("earlierwork", pfmsinitiationdetail.getEarlierWork());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("competency")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSCOMPETANCYUPDATE);
//		query.setParameter("competancy", pfmsinitiationdetail.getCompentencyEstablished());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("needofproject")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSNEEDOFUPDATE);
//		query.setParameter("needofproject", pfmsinitiationdetail.getNeedOfProject());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("technology")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSTECHUPDATE);
//		query.setParameter("technology", pfmsinitiationdetail.getTechnologyChallanges());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("riskmitigation")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSRISKUPDATE);
//		query.setParameter("riskmitigation", pfmsinitiationdetail.getRiskMitigation());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("proposal")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSPROPOSALUPDATE);
//		query.setParameter("proposal", pfmsinitiationdetail.getProposal());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("realization")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSREALIZATIONUPDATE);
//		query.setParameter("realization", pfmsinitiationdetail.getRealizationPlan());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	if(Details.equalsIgnoreCase("worldscenario")) {
//		Query query=manager.createNativeQuery(PROJECTDETAILSWORLDUPDATE);
//		query.setParameter("worldscenario", pfmsinitiationdetail.getWorldScenario());
//		query.setParameter("initiationid", pfmsinitiationdetail.getInitiationId());
//		query.setParameter("modifiedby", pfmsinitiationdetail.getModifiedBy());
//		query.setParameter("modifieddate", pfmsinitiationdetail.getModifiedDate());
//		int count=(int)query.executeUpdate();
//	}
//	
//
//	return pfmsinitiationdetail.getInitiationId();
//}

@Override
public Integer ProjectScheduleMonth(String InitiationId) throws Exception {
	
	 Query query=manager.createNativeQuery(PROJECTSCHTOTALMONTH);
    query.setParameter("InitiationId", InitiationId);
    BigDecimal ProjectScheduleMonth=(BigDecimal)query.getSingleResult();		
	if(ProjectScheduleMonth==null) {
		return 0;
	}
	return ProjectScheduleMonth.intValue();
}



@Override/*L.A*/
public Integer ProjectDurationMonth(String InitiationId) throws Exception {
	// TODO Auto-generated method stub

	 Query query=manager.createNativeQuery(PROJECTDURMONTH);
   query.setParameter("InitiationId", InitiationId);
   Integer ProjectDurationeMonth=(Integer)query.getSingleResult();		
	if(ProjectDurationeMonth==null) {
		return 0;
	}
	return ProjectDurationeMonth.intValue();
}
@Override/*L.A*/
public Integer MilestoneScheduleMonth(String initiationscheduleid,String IntiationId) throws Exception {
	// TODO Auto-generated method stub
	 Query query=manager.createNativeQuery(MILESCHMONTH);
	   query.setParameter("initiationscheduleid", initiationscheduleid);
	   query.setParameter("IntiationId", IntiationId);
	   Integer MilestoneScheduleMonth=(Integer)query.getSingleResult();		
	  
		if(MilestoneScheduleMonth==null) {
			return 0;
		}
		return MilestoneScheduleMonth.intValue();
	}


@Override
public int ProjectMileStoneNo(String InitiationId) throws Exception {
	 Query query=manager.createNativeQuery(MILESTONENO);
    query.setParameter("InitiationId", InitiationId);
    Integer ProjectMileStoneNo=(Integer)query.getSingleResult();		
	if(ProjectMileStoneNo==null) {
		return 0;
	}
	
	
	return ProjectMileStoneNo.intValue();
}

public int ProjectScheduleEditData(String InitiationScheduleId) throws Exception {
	Query query=manager.createNativeQuery(SCDULEMONTH);
	    query.setParameter("initiationscheduleid", InitiationScheduleId);
	    
	    Integer ProjectScheduleMonth=(Integer)query.getSingleResult();		
		if(ProjectScheduleMonth==null) {
			return 0;
		}
		return ProjectScheduleMonth.intValue();
}



@Override/*L.A*/
public int mileStonemonthprevious(String IntiationId, String milestoneno) throws Exception {
	
	Query query=manager.createNativeQuery(PREVIOUSMONTH);
    query.setParameter("IntiationId", IntiationId);
    query.setParameter("milestoneno", milestoneno);
    
    Integer PreviousMilestoneMonth=(Integer)query.getSingleResult();		
	if(PreviousMilestoneMonth==null) {
		return 0;
	}
	return PreviousMilestoneMonth.intValue();
}


@Override/*L.A*/
public int milestonenototalmonth(String IntiationId, String milestoneno) throws Exception {
	// TODO Auto-generated method stub
	Query query=manager.createNativeQuery(MILESTONENOTOTALMONTH);
    query.setParameter("IntiationId", IntiationId);
    query.setParameter("milestoneno", milestoneno);
    Integer milestonenototalmonth=(Integer)query.getSingleResult();		
  	if(milestonenototalmonth==null) {
  		return 0;
  	}
  	return milestonenototalmonth.intValue();
}

@Override
public Long ProjectInitiationAttachmentAdd(PfmsInitiationAttachment pfmsinitiationattachment,
		PfmsInitiationAttachmentFile pfmsinitiationattachmentfile) throws Exception {
manager.persist(pfmsinitiationattachment);
pfmsinitiationattachmentfile.setInitiationAttachmentId(pfmsinitiationattachment.getInitiationAttachmentId());
manager.persist(pfmsinitiationattachmentfile);
manager.flush();
return pfmsinitiationattachmentfile.getInitiationAttachmentFileId();
}

@Override
public List<Object[]> ProjectIntiationAttachment(String InitiationId) throws Exception {
	
	 Query query=manager.createNativeQuery(PROJECTINTATTACH);
    query.setParameter("initiationid", InitiationId);
	List<Object[]> ProjectIntiationAttachment=(List<Object[]>)query.getResultList();		
	
	return ProjectIntiationAttachment;
}

@Override
public List<Object[]> AuthorityAttachment(String InitiationId) throws Exception {
	
	 Query query=manager.createNativeQuery(AUTHORITYATTACHMENT);
    query.setParameter("initiationid", InitiationId);
 
    List<Object[]> AuthorityAttachment=(List<Object[]>)query.getResultList();		
	
	return AuthorityAttachment;
}

@Override
public PfmsInitiationAttachmentFile ProjectIntiationAttachmentFile(String InitiationAttachmentId) throws Exception {
	PfmsInitiationAttachmentFile ProjectIntiationAttachmentFile= manager.find(PfmsInitiationAttachmentFile.class,Long.parseLong(InitiationAttachmentId));
	return ProjectIntiationAttachmentFile;
}

@Override
public Object[] ProjectIntiationFileName(long AttachmentId) throws Exception
{
	Query query=manager.createNativeQuery("SELECT a.initiationattachmentid,a.initiationid,a.filename,a.filenamepath FROM pfms_initiation_attachment a WHERE isactive='1' AND a.initiationattachmentid=:AttachmentId");
	query.setParameter("AttachmentId", AttachmentId);
	List<Object[]> ProjectApprovePdList=(List<Object[]>)query.getResultList();
	Object[] result =null;
	if(ProjectApprovePdList!=null && ProjectApprovePdList.size()>0) {
		result=ProjectApprovePdList.get(0);
	}
	return result;
}

@Override
public int ProjectInitiationAttachmentDelete(PfmsInitiationAttachment pfmsinitiationattachment) throws Exception {
	
	Query query=manager.createNativeQuery(PROJECTINTATTACHDELETE);
	query.setParameter("initiationattachmentid", pfmsinitiationattachment.getInitiationAttachmentId());

	query.setParameter("modifiedby", pfmsinitiationattachment.getModifiedBy());
	query.setParameter("modifieddate", pfmsinitiationattachment.getModifiedDate());
	int count=(int)query.executeUpdate();
	
	
	return count;
}

@Override
public int ProjectInitiationAttachmentUpdate(PfmsInitiationAttachment pfmsinitiationattachment) throws Exception {
	
	Query query=manager.createNativeQuery(PROJECTINTATTACHUPDATE);
	query.setParameter("initiationattachmentid", pfmsinitiationattachment.getInitiationAttachmentId());
    query.setParameter("filename", pfmsinitiationattachment.getFileName());
	query.setParameter("modifiedby", pfmsinitiationattachment.getModifiedBy());
	query.setParameter("modifieddate", pfmsinitiationattachment.getModifiedDate());
	int count=(int)query.executeUpdate();
	
	
	return count;
}

@Override
public String ProjectIntiationAttachmentFileName(String InitiationAttachmentId) throws Exception {
	
	Query query=manager.createNativeQuery(PROJECTINTATTACHFILENAME);
    query.setParameter("initiationattachmentid", InitiationAttachmentId);
    String ProjectIntiationAttachmentFileName=(String)query.getSingleResult();		
	
	return ProjectIntiationAttachmentFileName;
}

@Override
public String ProjectIntiationAttachmentFileNamePath(String InitiationAttachmentId) throws Exception {
	
	Query query=manager.createNativeQuery(PROJECTINTATTACHFILENAMEPATH);
    query.setParameter("initiationattachmentid", InitiationAttachmentId);
    String ProjectIntiationAttachmentFileNamePath=(String)query.getSingleResult();		
	
	return ProjectIntiationAttachmentFileNamePath;
}

@Override
public int ProjectLabdelete(PfmsInitiationLab pfmsinitiationlab, PfmsInitiation pfmsinitiation) throws Exception {
	
	
	    Query query=manager.createNativeQuery(PROJECTINTIUPDATE);
	    query.setParameter("initiationid", pfmsinitiation.getInitiationId());
	    query.setParameter("labcount", pfmsinitiation.getLabCount());
	    query.setParameter("modifiedby",   pfmsinitiation.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiation.getModifiedDate());
	
	    Query query1=manager.createNativeQuery(PROJECTINTLABUPDATE);
	    query1.setParameter("initiationlabid", pfmsinitiationlab.getInitiationLabId());
	    
	    query1.setParameter("modifiedby",   pfmsinitiationlab.getModifiedBy());
		query1.setParameter("modifieddate", pfmsinitiationlab.getModifiedDate());
		query1.executeUpdate();
		
	return query.executeUpdate();
}

@Override
public int ProjectIntiationCostDelete(PfmsInitiationCost pfmsinitiationcost) throws Exception {
	 Query query=manager.createNativeQuery(PROJECTINTCOSTDELETE);
	    query.setParameter("initiationcostid", pfmsinitiationcost.getInitiationCostId());
	    query.setParameter("modifiedby",   pfmsinitiationcost.getModifiedBy());
		query.setParameter("modifieddate", pfmsinitiationcost.getModifiedDate());
	
	
	return query.executeUpdate();
}


@Override
public int ProjectIntiationStatusUpdate(PfmsInitiation pfmsinitiation,PfmsApproval pfmsapproval,PfmsNotification notification) throws Exception {
	
	manager.persist(pfmsapproval);
	manager.persist(notification);
	
    Query query=manager.createNativeQuery(PROJECTSTATUSUPDATE);
    query.setParameter("initiationid", pfmsinitiation.getInitiationId());
    query.setParameter("projectstatus", pfmsinitiation.getProjectStatus());
    query.setParameter("approvalid", pfmsapproval.getProjectApprovalId());
    query.setParameter("modifiedby",   pfmsinitiation.getModifiedBy());
	query.setParameter("modifieddate", pfmsinitiation.getModifiedDate());
	
	int count=query.executeUpdate();
	manager.flush();
	
	return count;
}

@Override
public Long ProjectForwardStatus(String InitiationId) throws Exception {
	Query query=manager.createNativeQuery("CALL ProjectForwardStatus(:InitiationId)");
	query.setParameter("InitiationId", InitiationId);
	BigInteger ProjectForwardStatus=(BigInteger)query.getSingleResult();	
	return ProjectForwardStatus.longValue();
}

@Override
public List<Object[]> ProjectActionList(String ProjectAuthorityId) throws Exception {
	
	Query query=manager.createNativeQuery(PROJECTACTIONLIST);
    query.setParameter("projectauthorityid", ProjectAuthorityId);
	List<Object[]> ProjectActionList=(List<Object[]>)query.getResultList();		
	
	return ProjectActionList;
}

@Override
public List<Object[]> ProjectApprovePdList(String EmpId) throws Exception {
	
	Query query=manager.createNativeQuery("CALL Project_Approval_Pd(:EmpId)");
	query.setParameter("EmpId", EmpId);
	List<Object[]> ProjectApprovePdList=(List<Object[]>)query.getResultList();	
	return ProjectApprovePdList;
}

@Override
public int ProjectApprove(PfmsInitiation pfmsinitiation, PfmsApproval pfmsapproval,PfmsNotification notification) throws Exception {
	manager.persist(pfmsapproval);
	manager.persist(notification);
	
    Query query=manager.createNativeQuery(PROJECTSTATUSUPDATE);
    query.setParameter("initiationid", pfmsinitiation.getInitiationId());
    query.setParameter("projectstatus", pfmsinitiation.getProjectStatus());
    query.setParameter("approvalid", pfmsapproval.getProjectApprovalId());
    query.setParameter("modifiedby",   pfmsinitiation.getModifiedBy());
	query.setParameter("modifieddate", pfmsinitiation.getModifiedDate());
	
	int count=query.executeUpdate();
	manager.flush();
	
	return count;
}


@Override
public double PfmsInitiationRefeSum(String initiationid,String refe) throws Exception
{
	Query query=manager.createNativeQuery(PFMSINITIATIONREFESUM);
	query.setParameter("initiationid", initiationid);
	query.setParameter("refe", refe);
	Object temp=query.getResultList().get(0);
	double costsum=0.00;
	if(!(temp==null)) 
	{		
		costsum=Double.parseDouble(temp.toString());
	}
	
	
	return costsum;
}


@Override
public List<Object[]> EmployeeList(String LabCode) throws Exception {
	Query query=manager.createNativeQuery(EMPLOYEELIST);
	query.setParameter("LabCode", LabCode);
	List<Object[]> EmployeeList=(List<Object[]>)query.getResultList();	
	return EmployeeList;
}



@Override
public List<Object[]> ProjectStatusList(String EmpId,String LoginType,String LabCode) throws Exception{
	
	Query query=manager.createNativeQuery(PROJECTSTATUSLIST);
	query.setParameter("empid", EmpId);
	query.setParameter("logintype", LoginType);
	query.setParameter("LabCode", LabCode);
	List <Object[]> ProjectStatusList= (List<Object[]>)query.getResultList();
	return ProjectStatusList;
	
}

@Override
public List<Object[]> ProjectApprovalTracking(String InitiationId) throws Exception{
	
	Query query=manager.createNativeQuery(PROJECTAPPROVALTRACKING);
	query.setParameter("initiationid", InitiationId);
	List<Object[]> ProjectApprovalTracking=(List<Object[]>)query.getResultList();
	
	return ProjectApprovalTracking;
}

@Override
public List<Object[]> ProjectApproveRtmddoList(String EmpId) throws Exception {
	
	Query query=manager.createNativeQuery("CALL Project_Approval_Rtmddo(:EmpId)");
	query.setParameter("EmpId", EmpId);
	List<Object[]> ProjectApproveRtmddoList=(List<Object[]>)query.getResultList();	
	return ProjectApproveRtmddoList;
}

@Override
public List<Object[]> ProjectApproveTccList(String EmpId) throws Exception {
	
	Query query=manager.createNativeQuery("CALL Project_Approval_Tcc(:EmpId)");
	query.setParameter("EmpId", EmpId);
	List<Object[]> ProjectApproveTccList=(List<Object[]>)query.getResultList();	
	return ProjectApproveTccList;
}



@Override
public Double TotalIntiationFeCost(String IntiationId) throws Exception {
	 Query query=manager.createNativeQuery(PROJECTINTITOTALFECOST);
	    query.setParameter("initiationid", IntiationId);
		BigDecimal TotalIntiationFeCost=(BigDecimal)query.getSingleResult();		
		if(TotalIntiationFeCost==null) {
			return 0.00;
		}
		return TotalIntiationFeCost.doubleValue();
}

@Override
public Double TotalIntiationReCost(String IntiationId) throws Exception {
	
	 Query query=manager.createNativeQuery(PROJECTINTITOTALRECOST);
	    query.setParameter("initiationid", IntiationId);
		BigDecimal TotalIntiationReCost=(BigDecimal)query.getSingleResult();		
		if(TotalIntiationReCost==null) {
			return 0.00;
		}
		return TotalIntiationReCost.doubleValue();
}

@Override
public List<Object[]> ProjectCost(Long IntiationId) throws Exception {
	
	 	Query query=manager.createNativeQuery(PROJECTCOSTDATA);
	    query.setParameter("initiationid", IntiationId);
		List<Object[]> ProjectCost=(List<Object[]>)query.getResultList();		
		
		return ProjectCost;
}



@Override
public List<Object[]> TccProjectList() throws Exception {

	Query query=manager.createNativeQuery(TCCPROJECTLIST);
	List<Object[]> TccProjectList=(List<Object[]>)query.getResultList();		
	
	return TccProjectList;
}



@Override
public List<Object[]> ExpertList() throws Exception {

	Query query=manager.createNativeQuery(EXPERTLIST);
	List<Object[]> ExpertList=(List<Object[]>)query.getResultList();
	return ExpertList;
}


@Override
public BigInteger DivisionHeadId(String EmpId) throws Exception {
	
	Query query=manager.createNativeQuery(DIVISIONHEADID);
	query.setParameter("empid", EmpId);
	BigInteger  DivisionHeadId=(BigInteger)query.getSingleResult();
	return DivisionHeadId;
}

@Override
public BigInteger RtmddoId() throws Exception {

	Query query=manager.createNativeQuery(RTMDDOID);
	
	BigInteger  RtmddoId=(BigInteger)query.getSingleResult();
	return RtmddoId;
}

@Override
public BigInteger TccChairpersonId(String Labcode) throws Exception {

	Query query=manager.createNativeQuery(TCCCHAIRPERSONID);
	query.setParameter("labcode", Labcode);
	
	BigInteger  TccChairpersonId=(BigInteger)query.getSingleResult();
	return TccChairpersonId;
}

@Override
public BigInteger CcmChairpersonId(String Labcode) throws Exception {
	
	Query query=manager.createNativeQuery(CCMCHAIRPERSONID);
	query.setParameter("labcode", Labcode);
	
	BigInteger  CcmChairpersonId=(BigInteger)query.getSingleResult();
	return CcmChairpersonId;
}

@Override
public List<Object[]> ProjectMainList() throws Exception {
	Query query = manager.createNativeQuery(PROJECTMAINLIST);
	List<Object[]> ProjectMainList = (List<Object[]>) query.getResultList();
	return ProjectMainList;
}

@Override
public Long ProjectMainClose(ProjectMain proType) throws Exception {
	Query query=manager.createNativeQuery(PROJECTMAINCLOSE);
	query.setParameter("projectmainid",proType.getProjectMainId());
	query.setParameter("modifiedby", proType.getModifiedBy());
	query.setParameter("modifieddate",proType.getModifiedDate());
	int ProjectTypeEdit=(int)query.executeUpdate();	
		
		return Long.valueOf(ProjectTypeEdit) ;

}
@Override
public Object[] ProjectMainEditData(String ProjectMainId) throws Exception {
	Query query = manager.createNativeQuery(PROJECTMAINEDITDATA);
	query.setParameter("promainid",ProjectMainId);
	Object[] ProjectMainEditData = (Object[]) query.getSingleResult();
	return ProjectMainEditData;
}

@Override
public Long ProjectMainEdit(ProjectMain proType) throws Exception {

	Query query=manager.createNativeQuery(PROJECTMAINUPDATE);
	query.setParameter("projecttypeid",proType.getProjectTypeId());
    query.setParameter("categoryId", proType.getCategoryId());
	query.setParameter("promainid",proType.getProjectMainId());
	query.setParameter("projectcode",proType.getProjectCode());
	query.setParameter("projectname",proType.getProjectName());
	query.setParameter("projectdescription",proType.getProjectDescription());
	query.setParameter("unitcode",proType.getUnitCode());
	query.setParameter("sanctionno",proType.getSanctionNo());
	query.setParameter("sanctiondate",proType.getSanctionDate());
	query.setParameter("sanctioncostre",proType.getSanctionCostRE());
	query.setParameter("sanctioncostfe",proType.getSanctionCostFE());
	query.setParameter("totalsanctioncost",proType.getTotalSanctionCost());
	query.setParameter("pdc",proType.getPDC());
	query.setParameter("projectdirector",proType.getProjectDirector());
	query.setParameter("projsancauthority",proType.getProjSancAuthority());
	query.setParameter("boardreference",proType.getBoardReference());
	query.setParameter("ismainwc",proType.getIsMainWC());
	query.setParameter("workcenter",proType.getWorkCenter());
	query.setParameter("objective",proType.getObjective());
	query.setParameter("deliverable",proType.getDeliverable());
	query.setParameter("labparticipating", proType.getLabParticipating());
	query.setParameter("modifiedby", proType.getModifiedBy());
	query.setParameter("modifieddate",proType.getModifiedDate());
	query.setParameter("scope",proType.getScope());

	 query.executeUpdate();
		return Long.valueOf(1) ;
}


@Override
public List<Object[]> ProjectList() throws Exception {
	Query query = manager.createNativeQuery(PROJECTLIST1);
	List<Object[]> ProjectList = (List<Object[]>) query.getResultList();
	return ProjectList;
}

@Override
public List<Object[]> ProjectTypeMainList() throws Exception {
	Query query = manager.createNativeQuery(PROJECTTYPEMAINLIST);
	List<Object[]> ProjectTypeList = (List<Object[]>) query.getResultList();
	return ProjectTypeList;
}


@Override
public List<Object[]> ProjectTypeMainListNotAdded() throws Exception {
	Query query = manager.createNativeQuery(PROJECTTYPEMAINLISTNOTADDED);
	List<Object[]> ProjectMainList = (List<Object[]>) query.getResultList();
	return ProjectMainList;
}

@Override
public List<Object[]> ProjectCategoryList() throws Exception {
	Query query = manager.createNativeQuery(PROJECTCATEGORY);
	List<Object[]> ProjectCategoryList = (List<Object[]>) query.getResultList();
	return ProjectCategoryList;
}


@Override
public Long ProjectMasterAdd(ProjectMaster proType) throws Exception {
    manager.persist(proType);
	manager.flush();
	return proType.getProjectId();
}

@Override
public Long ProjectEdit(ProjectMaster proType) throws Exception {
	
	ProjectMaster proj=pmrepo.findById(proType.getProjectId()).get();
//	 proj.setIsMainWC(proType.getIsMainWC());
//	 proj.setWorkCenter(proType.getWorkCenter());
//   proj.setProjectCode(proType.getProjectCode());
	 proj.setProjectShortName(proType.getProjectShortName());
	 proj.setEndUser(proType.getEndUser());
	 proj.setProjectName(proType.getProjectName());
	 proj.setProjectType(proType.getProjectType());
     proj.setProjectDescription(proType.getProjectDescription());
 	 proj.setUnitCode(proType.getUnitCode());
 	 proj.setSanctionNo(proType.getSanctionNo());
 	 proj.setBoardReference(proType.getBoardReference());
     proj.setProjectMainId(proType.getProjectMainId());
     proj.setProjectDirector(proType.getProjectDirector());
     proj.setProjectCategory(proType.getProjectCategory());
	 proj.setProjSancAuthority(proType.getProjSancAuthority());
	 proj.setSanctionDate(proType.getSanctionDate());
	 proj.setTotalSanctionCost(proType.getTotalSanctionCost());
	 proj.setSanctionCostRE(proType.getSanctionCostRE());
	 proj.setSanctionCostFE(proType.getSanctionCostFE());
	 proj.setPDC(proType.getPDC());
	 proj.setObjective(proType.getObjective());
	 proj.setDeliverable(proType.getDeliverable());
	 proj.setRevisionNo(proType.getRevisionNo());
	 proj.setModifiedBy(proType.getModifiedBy());
 	 proj.setModifiedDate(proType.getModifiedDate());

 	 pmrepo.save(proj);
		
 	 return proj.getProjectId() ;
}





@Override
public Long ProjectClose(ProjectMaster proType) throws Exception {
	Query query=manager.createNativeQuery(PROJECTCLOSE);
	query.setParameter("projectid",proType.getProjectId());
	query.setParameter("modifiedby", proType.getModifiedBy());
	query.setParameter("modifieddate",proType.getModifiedDate());
	int ProjectTypeEdit=(int)query.executeUpdate();	
		
		return Long.valueOf(ProjectTypeEdit) ;

}

@Override
public Object[] ProjectEditData1(String ProjectId) throws Exception {
	Query query = manager.createNativeQuery(PROJECTEDITDATA);
	query.setParameter("proid",ProjectId);
	Object[] ProjectEditData = (Object[]) query.getSingleResult();
	return ProjectEditData;
}

@Override
public List<Object[]> getProjectList() throws Exception {
	Query query = manager
			.createNativeQuery(PROJECTITEMLIST11);
	List<Object[]> projectList = (List<Object[]>) query.getResultList();
	return projectList;
}

@Override
public List<Object[]> ProjectAssignList(String EmpId) throws Exception {

	Query query=manager.createNativeQuery(PROJECTASSIGNLIST);
	query.setParameter("proid",EmpId);
	List<Object[]> ProjectAssignList=(List<Object[]>)query.getResultList();	
	return ProjectAssignList;
}

@Override
public List<Object[]> UserList(String proId) throws Exception {

	Query query=manager.createNativeQuery(USERLIST);
	query.setParameter("projectid", proId);
	List<Object[]> OfficerList=(List<Object[]>)query.getResultList();
	return OfficerList;
}

@Override
public Object[] ProjectData(String ProId) throws Exception {
	Query query=manager.createNativeQuery(PROJECTDATA);
	query.setParameter("proid",ProId);
	Object[] ProjectData=(Object[])query.getSingleResult();
	return ProjectData;
}


@Override
public Long ProjectAssignAdd(ProjectAssign proAssign) throws Exception {
    manager.persist(proAssign);
	manager.flush();
	return proAssign.getProjectEmployeeId();
}

@Override
public Long ProjectRevoke(ProjectAssign proAssign) throws Exception {
	Query query=manager.createNativeQuery(PROJECTASSIGNREVOKE);
	query.setParameter("proempid",proAssign.getProjectEmployeeId());
	query.setParameter("modifiedby", proAssign.getModifiedBy());
	query.setParameter("modifieddate",proAssign.getModifiedDate());
	int ProjectRevoke=(int)query.executeUpdate();	
		
		return Long.valueOf(ProjectRevoke) ;
}

@Override
public List<Object[]> ProjectApproveAdList(String EmpId) throws Exception {
	Query query=manager.createNativeQuery("CALL Project_Approval_Ad(:EmpId)");
	query.setParameter("EmpId", EmpId);
	List<Object[]> ProjectApproveAdList=(List<Object[]>)query.getResultList();	
	return ProjectApproveAdList;
}

@Override
public BigInteger AdId() throws Exception {

	Query query=manager.createNativeQuery(ADID);
	
	BigInteger  RtmddoId=(BigInteger)query.getSingleResult();
	return RtmddoId;
}

@Override
public List<Object[]> ApprovalStutusList(String AuthoId) throws Exception {
	Query query=manager.createNativeQuery(APPSTATUSLIST);
	query.setParameter("AuthoId", AuthoId);
	List<Object[]> StutusList=(List<Object[]>)query.getResultList();	
	return StutusList;
}

		@Override
		public long ProjectDataSubmit(PfmsProjectData pfmsprojectdata) throws Exception {
			manager.persist(pfmsprojectdata);
			manager.flush();
			return pfmsprojectdata.getProjectDataId();
		}


		@Override
		public List<Object[]> ProjectStageDetailsList() throws Exception {
			Query query=manager.createNativeQuery(PROJECTSTAGEDETAILSLIST);
			List<Object[]> ProjectStageDetailsList=(List<Object[]>)query.getResultList();	
			return ProjectStageDetailsList;
		}
		
				
		@Override
		public Object[] ProjectDataDetails(String projectid) throws Exception {
			Query query=manager.createNativeQuery(PROJECTDATADETAILS);
			query.setParameter("projectid", projectid);
			Object[] ProjectStageDetails=null;
			try {
				ProjectStageDetails=(Object[])query.getSingleResult();
			}catch (Exception e) {
				logger.error(loggerdate +"Inside DAO ProjectDataDetails "+ e);
				return null;
			}
			
			return ProjectStageDetails;
		}
		
		
		
		@Override
		public long ProjectDataEditSubmit(PfmsProjectData pfmsprojectdata, String querystr) throws Exception {
			String PROJECTDATAEDITSUBMIT="UPDATE pfms_project_data SET "+querystr+" currentstageid=:currentstageid,RevisionNo=:revisionno,proclimit=:proclimit,ModifiedBy=:modifiedby,ModifiedDate=:modifieddate,LastPmrcDate=:pmrcdate,LastEBDate=:ebdate WHERE projectdataid=:projectdataid";
			Query query=manager.createNativeQuery(PROJECTDATAEDITSUBMIT);
			//query.setParameter("querystr", querystr);
			query.setParameter("currentstageid", pfmsprojectdata.getCurrentStageId());
			query.setParameter("projectdataid", pfmsprojectdata.getProjectDataId());
			query.setParameter("revisionno", pfmsprojectdata.getRevisionNo());
			query.setParameter("proclimit", pfmsprojectdata.getProcLimit());
			query.setParameter("pmrcdate", pfmsprojectdata.getLastPmrcDate());
			query.setParameter("ebdate", pfmsprojectdata.getLastEBDate());
			query.setParameter("modifiedby", pfmsprojectdata.getModifiedBy());
			query.setParameter("modifieddate", pfmsprojectdata.getModifiedDate());
			return query.executeUpdate();
		}
		
		
		@Override
		public Object[] ProjectDataSpecsFileData(String projectdataid) throws Exception
		{
		
			Query query=manager.createNativeQuery(PROJECTDATASPECSFILEDATA);
			query.setParameter("projectdataid",projectdataid);
			Object[] ProjectDataSpecsFileData=(Object[])query.getSingleResult();
			return ProjectDataSpecsFileData;
			
		}

		
		@Override
		public long ProjectRevDataSubmit(PfmsProjectDataRev pfmsprojectrevdata) throws Exception {
			manager.persist(pfmsprojectrevdata);
			manager.flush();
			return pfmsprojectrevdata.getProjectDataRevId();
		}
		
		
		@Override
		public List<Object[]> ProjectDataRevList(String projectid) throws Exception {
			Query query=manager.createNativeQuery(PROJECTDATAREVLIST);
			query.setParameter("projectid", projectid);
			List<Object[]> ProjectDataRevList=(List<Object[]>)query.getResultList();
			return ProjectDataRevList;
		}
		
		
		
		
		 @Override
		 public Object[] ProjectDataRevData(String projectdatarevid) throws Exception
		 {
			Query query=manager.createNativeQuery(PROJECTDATAREVDATA);
			query.setParameter("projectdatarevid", projectdatarevid); 
			Object[] ProjectDataRevData=null;
			try 
			{
				ProjectDataRevData=(Object[])query.getSingleResult();
			}catch (Exception e) {
				logger.error(loggerdate +"Inside DAO ProjectDataRevData "+ e);
				ProjectDataRevData=null;
			}
			 return	 ProjectDataRevData; 
		}
		
		
		
		@Override
		public Object[] ProjectDataSpecsRevFileData(String projectdatarevid) throws Exception
		{
		
			Query query=manager.createNativeQuery(PROJECTDATASPECSREVFILEDATA);
			query.setParameter("projectdatarevid",projectdatarevid);
			Object[] ProjectDataSpecsRevFileData=(Object[])query.getSingleResult();
			return ProjectDataSpecsRevFileData;
			
		}

		@Override
		public List<Object[]> InitiatedProjectList() throws Exception {

			
			Query query=manager.createNativeQuery(INITIATEDPROJECT);
			List<Object[]> InitiatedProjectList=(List<Object[]>)query.getResultList();
			return InitiatedProjectList;
		}

		@Override
		public List<Object[]> InitiatedProjectDetails(String ProjectId) throws Exception {

			Query query=manager.createNativeQuery(INITIATEDPROJECTDETAILS);
			query.setParameter("initiationid", ProjectId);
			List<Object[]> InitiatedProjectDetails=(List<Object[]>)query.getResultList();
			return InitiatedProjectDetails;
		}

		@Override
		public List<Object[]> NodalLabList() throws Exception {
			
			Query query=manager.createNativeQuery(NODALLABLIST);
			List<Object[]> NodalLabList=(List<Object[]>)query.getResultList();
			return NodalLabList;
		}


		@Override
		public List<Object[]> SubProjectList(String InitiationId) throws Exception {

			Query query=manager.createNativeQuery(SUBPROJECTLIST);
			query.setParameter("initiationid", InitiationId);
			List<Object[]> SubProjectList=(List<Object[]>)query.getResultList();
			return SubProjectList;
		}

		@Override
		public String StatusDetails(String Status) throws Exception {
			Query query=manager.createNativeQuery(STATUSDETAILS);
			query.setParameter("status",Status);
			String StatusDetails=(String)query.getSingleResult();
			return StatusDetails;
		}

		
		@Override
		public BigInteger EmpId(String InitiationId) throws Exception {
			
			Query query=manager.createNativeQuery(INTEMPID);
			query.setParameter("id", InitiationId);
			BigInteger  DivisionHeadId=(BigInteger)query.getSingleResult();
			return DivisionHeadId;
		}

		
		
		
		@Override
		public List<Object[]> ProjectRiskDataList(String projectid,String LabCode) throws Exception 
		{			
			Query query=manager.createNativeQuery(PROJECTRISKDATALIST);
			query.setParameter("projectid", Long.parseLong(projectid));
			query.setParameter("LabCode", LabCode);
			List<Object[]>  ProjectRiskDataList=(List<Object[]>)query.getResultList();
			return ProjectRiskDataList;
		}
		
		
		
		@Override
		public Object[] ProjectRiskData(String actionmainid) throws Exception 
		{			
			Query query=manager.createNativeQuery(PROJECTRISKDATA);
			query.setParameter("actionmainid", actionmainid);
			Object[] ProjectRiskData=null;
			try {
				ProjectRiskData=(Object[])query.getSingleResult();
			}catch (Exception e) {
				logger.error(loggerdate +"Inside DAO ProjectRiskData "+ e);
				ProjectRiskData=null;
			}
			return ProjectRiskData;		
		}
		private static final String PROJECTCLOSERISK="UPDATE pfms_risk SET status=:status, statusdate=:statusdate , remarks=:remarks , modifiedby=:modifiedby, modifieddate=:modifieddate WHERE riskid=:riskid";
		private static final String ACTIONRISK="UPDATE action_assign SET actionstatus=:actionstatus , modifiedby=:modifiedby, modifieddate=:modifieddate WHERE actionassignid=:actionassignid";
		@Override
		public long CloseProjectRisk(PfmsRiskDto dto)throws Exception
		{
			
			
			Query query1=manager.createNativeQuery(ACTIONRISK);
			query1.setParameter("actionassignid", dto.getActionMainId());
			query1.setParameter("actionstatus", dto.getStatus());
			query1.setParameter("modifiedby", dto.getModifiedBy());
			query1.setParameter("modifieddate", dto.getModifiedDate());
			query1.executeUpdate();
			Query query=manager.createNativeQuery(PROJECTCLOSERISK);
				query.setParameter("riskid", dto.getRiskId());
				query.setParameter("status", dto.getStatus());
				query.setParameter("statusdate", dto.getStatusDate());
				query.setParameter("remarks", dto.getRemarks());
				query.setParameter("modifiedby", dto.getModifiedBy());
				query.setParameter("modifieddate", dto.getModifiedDate());
				long count=query.executeUpdate();
			return count;
		}
		
		@Override
		public long ProjectRiskDataSubmit(PfmsRisk model) throws Exception {
			manager.persist(model);
			manager.flush();
			return model.getRiskId();
		}
		
		
		@Override
		public Object[] ProjectRiskMatrixData(String actionmainid) throws Exception 
		{
			Query query=manager.createNativeQuery(PROJECTRISKMATRIXDATA);
			query.setParameter("actionmainid", actionmainid);
			Object[] ProjectRiskMatrixData=null;
			try {
				ProjectRiskMatrixData=(Object[])query.getSingleResult();
			}catch (Exception e) {
				logger.error(loggerdate +"Inside DAO ProjectRiskMatrixData "+ e);
				ProjectRiskMatrixData=null;
			}
			return ProjectRiskMatrixData;
		}		
		
		
		
		
		@Override
		public int ProjectRiskDataEdit(PfmsRiskDto dto) throws Exception {
			Query query=manager.createNativeQuery(PROJECTRISKDATAEDIT);
			query.setParameter("severity", dto.getSeverity());
			query.setParameter("probability", dto.getProbability());
			query.setParameter("mitigationplans", dto.getMitigationPlans());
			query.setParameter("revisionno", dto.getRevisionNo());
			query.setParameter("RPN", Integer.parseInt(dto.getProbability()) * Integer.parseInt(dto.getSeverity()) );
			query.setParameter("Impact", dto.getImpact());
			query.setParameter("Category", dto.getCategory());
			query.setParameter("RiskTypeId", dto.getRiskTypeId());
			query.setParameter("modifiedby", dto.getModifiedBy());
			query.setParameter("modifieddate", dto.getModifiedDate());
			query.setParameter("riskid", dto.getRiskId());
			
			return query.executeUpdate();
		}	
		
		@Override
		public long ProjectRiskDataRevSubmit(PfmsRiskRev model) throws Exception{
			manager.persist(model);
			manager.flush();
			return model.getRiskRevisionId();
		}
		
		
		@Override
		public List<Object[]> ProjectRiskMatrixRevList(String actionmainid) throws Exception {
			Query query=manager.createNativeQuery(PROJECTRISKMATRIXREVLIST);
			query.setParameter("actionmainid", actionmainid);
			List<Object[]>  ProjectRiskMatrixRevList=(List<Object[]>)query.getResultList();
			return ProjectRiskMatrixRevList;
		}	
		

		
		
		@Override
		public List<Object> RiskDataPresentList(String projectid,String LabCode) throws Exception {
			Query query=manager.createNativeQuery(RISKDATAPRESENTLIST);
			query.setParameter("projectid", projectid);
//			query.setParameter("LabCode", LabCode);
			List<Object>  RiskDataPresentList=(List<Object>)query.getResultList();
			return RiskDataPresentList;
		}	


		@Override
		public Long ProjectInitiationAuthorityAdd(PfmsInitiationAuthority pfmsauthority,PfmsInitiationAuthorityFile pfmsinitiationauthorityfile) throws Exception {
			
			manager.persist(pfmsauthority);
			pfmsinitiationauthorityfile.setAuthorityId(pfmsauthority.getAuthorityId());
			manager.persist(pfmsinitiationauthorityfile);
			manager.flush();
			return pfmsinitiationauthorityfile.getInitiationAuthorityFileId();

		}

		@Override
		public PfmsInitiationAuthorityFile ProjectAuthorityDownload(String AuthorityFileId) throws Exception {
			

			PfmsInitiationAuthorityFile ProjectAuthorityDownload= manager.find(PfmsInitiationAuthorityFile.class,Long.parseLong(AuthorityFileId));
			
			return ProjectAuthorityDownload;
		}

		@Override
		public Long ProjectAuthorityUpdate(PfmsInitiationAuthority pfmsauthority) throws Exception {
			
			Query query=manager.createNativeQuery(AUTHORITYUPDATE);
			query.setParameter("authorityname",pfmsauthority.getAuthorityName() );
			query.setParameter("letterdate", pfmsauthority.getLetterDate());
			query.setParameter("letterno", pfmsauthority.getLetterNo());
			query.setParameter("modifiedby",pfmsauthority.getModifiedBy());
			query.setParameter("modifieddate", pfmsauthority.getModifiedDate());
			query.setParameter("initiationid", pfmsauthority.getInitiationId());
			int count= query.executeUpdate();
			
			return Long.valueOf(count);
			
		}

		@Override
		public Long AuthorityFileUpdate(PfmsInitiationAuthorityFile pfmsinitiationauthorityfile) throws Exception {
			
			Query query=manager.createNativeQuery(AUTHORITYFILEUPDATE);
			query.setParameter("attachmentname", pfmsinitiationauthorityfile.getAttachmentName());
			query.setParameter("file", pfmsinitiationauthorityfile.getFile());
			query.setParameter("initiationauthorityfileid", pfmsinitiationauthorityfile.getInitiationAuthorityFileId());

			int count= query.executeUpdate();
			
			return Long.valueOf(count);
		}
          
		
		@Override
		public List<Object[]> getProjectCatSecDetalis(Long projectId)throws Exception{
			Query query=manager.createNativeQuery(PROCATSECDETAILS);
			query.setParameter("projectmainid", projectId);
			return (List<Object[]>)query.getResultList();
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
		

		private static final String DORTMDADEMPDATA="SELECT pr.empid ,CONCAT(IFNULL(CONCAT(e.title,' '),''), e.empname) AS 'empname' ,ed.designation ,pr.type  FROM pfms_rtmddo pr, employee e ,employee_desig ed WHERE pr.empid=e.empid AND e.desigid=ed.desigid AND pr.isactive='1' AND pr.LabCode=:Labcode ORDER BY FIELD (pr.type,'DO-RTMD','AD')";
		@Override
		public List<Object[]>  DoRtmdAdEmpData(String Labcode) throws Exception
		{
			Query query=manager.createNativeQuery(DORTMDADEMPDATA);
			query.setParameter("Labcode", Labcode)	;	
			return (List<Object[]>)query.getResultList();
		}
		
		
		@Override
		public Object[]  DirectorEmpData(String LabCode) throws Exception
		{
			Query query=manager.createNativeQuery(DIRECTOREMPDATA);
			query.setParameter("labcode", LabCode);	
			try {
				return (Object[])query.getSingleResult();
			}catch (NoResultException e) {
				return null;
			}
		}
		
		
		@Override
		public Object[]  EmpDivHeadData(String empid) throws Exception
		{
			Query query=manager.createNativeQuery(EMPDIVHEADDATA);
			query.setParameter("empid",empid);
			try {
				return (Object[])query.getSingleResult();
			}catch (NoResultException e) {
				logger.error(loggerdate +"Inside DAO EmpDivHeadData "+ e);
				return null;
			}
			
		}
		
		
		@Override
		public ProjectMain  ProjectMainObj(String projectmainid) throws Exception
		{
			ProjectMain model= manager.find(ProjectMain.class,Long.parseLong(projectmainid));
			return model;
		}
		
		
		@Override
		public List<Object[]>  InitCommDefault() throws Exception
		{
			Query query=manager.createNativeQuery(INITCOMMDEFAULT);
			return (List<Object[]> )query.getResultList();
		}
		
		@Override
		public long InitiationCommitteeAdd(CommitteeInitiation model) throws Exception
		{		
			manager.persist(model);
			manager.flush();
			return  model.getCommitteeInitiationId();
		}
		
		@Override
		public ProjectMaster ProjectMasterData(long projectid) throws Exception
		{		
			return manager.find(ProjectMaster.class, projectid);
			
		}
		

		@Override
		public ProjectMasterRev ProjectREVSubmit(ProjectMasterRev masterrev) throws Exception {
		    manager.persist(masterrev);
			manager.flush();
			return masterrev;
		}
		
		
		@Override
		public List<Object[]> ProjectRevList(String projectid) throws Exception {
			Query query=manager.createNativeQuery(PROJECTREVLIST);
			query.setParameter("projectid", projectid);
			return (List<Object[]>)query.getResultList();
		}
		
		@Override
		public long ProjectMasterAttachAdd(ProjectMasterAttach modal) throws Exception {
		    manager.persist(modal);
			manager.flush();
			return modal.getProjectAttachId();
		}
		
		
		@Override
		public List<Object[]> ProjectMasterAttachList(String projectid) throws Exception {
			Query query=manager.createNativeQuery(PROJECTMASTERATTACHLIST);
			query.setParameter("projectid", projectid);
			return (List<Object[]>)query.getResultList();
		}
		
		
		@Override
		public Object[] ProjectMasterAttachData(String projectattachid) throws Exception {
			Query query=manager.createNativeQuery(PROJECTMASTERATTACHDATA);
			query.setParameter("projectattachid", projectattachid);
			return (Object[])query.getResultList().get(0);
		}
		
				
		
		
		@Override
		public int ProjectMasterAttachDelete(String projectattachid) throws Exception
		{
			Query query=manager.createNativeQuery(PROJECTMASTERATTACHDELETE);
			query.setParameter("projectattachid", projectattachid);
			return query.executeUpdate();
		}

		@Override
		public long TechnicalWorkDataAdd(ProjectTechnicalWorkData modal) throws Exception {
		    manager.persist(modal);
			manager.flush();
			return modal.getTechDataId();
		}
		
		@Override
		public long TechnicalWorkDataEdit(ProjectTechnicalWorkData modal,long Techdataid) throws Exception {
			ProjectTechnicalWorkData detached = manager.find(ProjectTechnicalWorkData.class, Techdataid);
			detached.setModifiedBy(modal.getCreatedBy());
			detached.setModifiedDate(modal.getCreatedDate());			
			detached.setIsActive(0);
			return detached.getTechDataId();
		}
		
		private static final String INITIATIONCHECKLIST ="SELECT cl.checklistid, cl.checklistno, cl.checklistSNo,  cl.checklistsubsno, cl.checklistitem ,(SELECT ischecked FROM pfms_initiation_checklist_data cd WHERE cl.checklistid = cd.checklistid AND cd.initiationid=:initiationid ) AS 'ischecked' FROM pfms_initiation_checklist_list cl  WHERE cl.isactive=1  ";
		
		@Override
		public List<Object[]> InitiationCheckList(String initiationid ) throws Exception 
		{
			Query query=manager.createNativeQuery(INITIATIONCHECKLIST);
			query.setParameter("initiationid", initiationid);
			return (List<Object[]>)query.getResultList();
		}
		
		@Override
		public long InitiationChecklistAdd( PfmsInitiationChecklistData cldata ) throws Exception 
		{
			manager.persist(cldata);
			manager.flush();
			return cldata.getChecklistDataId();
		}
		
		@Override
		public PfmsInitiationChecklistData InitiationChecklistCheck( PfmsInitiationChecklistData cldata ) throws Exception
	 	{
			try {
				CriteriaBuilder cb =manager.getCriteriaBuilder();
				CriteriaQuery <PfmsInitiationChecklistData> cq = cb.createQuery(PfmsInitiationChecklistData.class);
				Root<PfmsInitiationChecklistData> rootentry = cq.from(PfmsInitiationChecklistData.class);
				CriteriaQuery<PfmsInitiationChecklistData> all = cq.select(rootentry).where(cb.and(cb.equal(rootentry.get("InitiationId"), cldata.getInitiationId() ),cb.equal(rootentry.get("ChecklistId"), cldata.getChecklistId() )));
				TypedQuery<PfmsInitiationChecklistData> query  = manager.createQuery(all);
				return query.getSingleResult();
			}catch (NoResultException e) {
				logger.error(loggerdate +"Inside DAO InitiationChecklistCheck "+ e);
				return null;
			}			
		}
		
		@Override
		public long InitiationChecklistUpdate( PfmsInitiationChecklistData cldata ) throws Exception
	 	{
			manager.merge(cldata);
			manager.flush();
			return cldata.getChecklistDataId();
		}

		
		private static final String RISKTYPELIST = "SELECT risktypeid, risktype FROM pfms_risk_type";
		
		@Override
		public List<Object[]> RiskTypeList() throws Exception 
		{
			Query query=manager.createNativeQuery(RISKTYPELIST);
			return (List<Object[]>)query.getResultList();
		}		
		
   private static final String MILESTONEDATA ="FROM PfmsInitiationSchedule WHERE InitiationId=:InitiationId AND MilestoneNo=:MilestoneNo AND IsActive=1";
		@Override
		public PfmsInitiationSchedule MilestoneData(long InitiationId, int milestoneno) throws Exception {
			// TODO Auto-generated method stub
		
			Query query=manager.createQuery(MILESTONEDATA);
			query.setParameter("InitiationId", InitiationId);	
			query.setParameter("MilestoneNo", milestoneno);	
			try {
				return (PfmsInitiationSchedule)query.getSingleResult();
			}catch (Exception e) {
				return null;
			}
		}
		private static final String REQQUIREMENTTYPELIST="SELECT a.reqtypeid,a.reqtypecode,a.reqtype,a.frnr FROM pfms_initiation_req_type a";
		@Override
		public List<Object[]> RequirementTypeList() throws Exception {
			// TODO Auto-generated method stub
			Query query=manager.createNativeQuery(REQQUIREMENTTYPELIST);
			return (List<Object[]>)query.getResultList();
		}

		@Override
		public long ProjectRequirementAdd(PfmsInititationRequirement pir) throws Exception {
			// TODO Auto-generated method stub
			manager.persist(pir);
			
			manager.flush();
			return pir.getInitiationReqId();
		}
		//Line Added	
		private static final String REQLIST="SELECT a.InitiationReqId, a.requirementid,a.reqtypeid,a.requirementbrief,a.requirementdesc,a.priority FROM pfms_initiation_req a WHERE initiationid=:initiationid AND isActive='1'";
		@Override
		public Object RequirementList(String intiationId) throws Exception {
			// TODO Auto-generated method stub
			 Query query=manager.createNativeQuery(REQLIST);
			 query.setParameter("initiationid", intiationId);
			 List<Object[]> RequirementList=(List<Object[]> )query.getResultList();	
			return RequirementList;
		}
		
		private static final String REQDLT="";
		@Override
		public long ProjectRequirementDelete(long initiationReqId) throws Exception {
			return 0;
		}
		private static final String REQUIREMENTS="SELECT a.InitiationId,a.reqtypeid,a.RequirementBrief,a.RequirementDesc,a.RequirementId,a.priority,a.linkedrequirements,a.InitiationReqId FROM pfms_initiation_req a WHERE InitiationReqId=:InitiationReqId AND isActive='1'";
		@Override
		public Object[] Requirement(long InitiationReqId) throws Exception {
			Query query=manager.createNativeQuery(REQUIREMENTS);
			query.setParameter("InitiationReqId", InitiationReqId);
			Object[] Requirement=(Object[])query.getSingleResult();	
				
				return Requirement;
		}
		private static final String REQUPDATE="UPDATE pfms_initiation_req SET initiationid=:initiationid, requirementid=:requirementid, reqtypeid=:reqtypeid, requirementbrief=:requirementbrief ,RequirementDesc=:RequirementDesc,modifiedby=:modifiedby,modifieddate=:modifieddate,priority=:priority WHERE initiationreqid=:initiationreqid AND isActive=1";
		@Override
		public long RequirementUpdate(PfmsInititationRequirement pir, String initiationReqId) throws Exception {
			// TODO Auto-generated method stub
		Query query=manager.createNativeQuery(REQUPDATE);
		
		query.setParameter("initiationid", pir.getInitiationId());
		query.setParameter("requirementid", pir.getRequirementId());
		query.setParameter("reqtypeid", pir.getReqTypeId());
		query.setParameter("requirementbrief", pir.getRequirementBrief());
		query.setParameter("RequirementDesc", pir.getRequirementDesc());
		query.setParameter("modifiedby", pir.getModifiedBy());
		query.setParameter("modifieddate", pir.getModifiedDate());
		query.setParameter("priority", pir.getPriority());
		query.setParameter("initiationreqid", initiationReqId);
		
		
		query.executeUpdate();
		return 1l;
		}
		private static final String REQTYPECOUNT="SELECT COUNT(reqtypeid) FROM pfms_initiation_req WHERE initiationid=:intiationId AND isactive='1'";
		@Override
		public long numberOfReqTypeId(String intiationId) throws Exception {
			// TODO Auto-generated method stub
		Query query=manager.createNativeQuery(REQTYPECOUNT);
		query.setParameter("intiationId", intiationId);
		BigInteger x=(BigInteger)query.getSingleResult();
		if(x==null) {
			return 0;
		}
		return x.longValue();
		}
		private final static String BUDGETHEADLIST="SELECT DISTINCT(a.budgetheadid), a. budgetheaddescription FROM budget_head a , budget_item_sanc b WHERE isproject='Y' AND b.projecttypeid=:projecttypeid AND a.budgetheadid =b.budgetheadid  ORDER BY budgetheaddescription ASC ";
		@Override
		public List<Object[]> BudgetHeadList(BigInteger projecttypeid) throws Exception {
			// TODO Auto-generated method stub
			 Query query=manager.createNativeQuery(BUDGETHEADLIST);
			 query.setParameter("projecttypeid", projecttypeid);
			 
			 List<Object[]> BudgetHeadList=(List<Object[]> )query.getResultList();	
			return BudgetHeadList;
		}
		private final static String REQCOUNTLIST="SELECT reqcount FROM pfms_initiation_req WHERE initiationid=:initiationId AND isactive=1";
		@Override
		public List<Integer> reqcountList(String initiationId) throws Exception {
			// TODO Auto-generated method stub
			Query query=manager.createNativeQuery(REQCOUNTLIST);
			query.setParameter("initiationId",initiationId );
			List<Integer>reqcountList=(List<Integer>)query.getResultList();
			
			return reqcountList;
		}
		private  final static String REQDELT="DELETE FROM pfms_initiation_req WHERE initiationreqid=:initiationReqId";
		@Override
		public int deleteRequirement(String initiationReqId) throws Exception {
			// TODO Auto-generated method stub
		Query query =manager.createNativeQuery(REQDELT);
		query.setParameter("initiationReqId", initiationReqId);
		
		return query.executeUpdate();
		}
		private final static String REQIREID="SELECT requirementid FROM pfms_initiation_req WHERE reqcount=:i AND initiationid=:initiationId AND isactive=1;";
		@Override
		
		public String getReqId(int i, String initiationId) throws Exception {
			// TODO Auto-generated method stub
			Query query=manager.createNativeQuery(REQIREID);
			query.setParameter("i", i);
			query.setParameter("initiationId", initiationId);
		    String getReqId=(String)query.getSingleResult();
			return getReqId;
		}
		private final static String REQIDUPDATE="UPDATE pfms_initiation_req SET requirementid=:s,reqcount=:last WHERE reqcount=:first AND initiationid=:initiationId AND isactive='1'";
		@Override
		public int updateReqId(int last, String s, int first, String initiationId) throws Exception {
			// TODO Auto-generated method stub
			Query query =manager.createNativeQuery(REQIDUPDATE);
			query.setParameter("s", s);
			query.setParameter("last", last);
			query.setParameter("first", first);
			query.setParameter("initiationId", initiationId);
			
			return query.executeUpdate();
		}

	
		
		
}
