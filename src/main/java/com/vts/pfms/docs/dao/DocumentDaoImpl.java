package com.vts.pfms.docs.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.vts.pfms.docs.model.PfmsDoc;
import com.vts.pfms.docs.model.PfmsDocContent;
import com.vts.pfms.docs.model.PfmsDocContentFreeze;
import com.vts.pfms.docs.model.PfmsDocContentLinks;
import com.vts.pfms.docs.model.PfmsDocContentRev;
import com.vts.pfms.docs.model.PfmsDocTemplate;
import com.vts.pfms.milestone.model.FileRepMaster;

@Transactional
@Repository
public class DocumentDaoImpl implements DocumentDao 
{
	@PersistenceContext
	EntityManager manager;
	
	private static final Logger logger=LogManager.getLogger(DocumentDaoImpl.class);
	
	@Override
	public List<Object[]> LoginProjectsList(String empid,String Logintype)throws Exception
	{
		logger.info(new Date() +"Inside LoginProjectDetailsList");
		Query query=manager.createNativeQuery("CALL Pfms_Emp_ProjectList(:empid,:logintype);");
		query.setParameter("empid", empid);
		query.setParameter("logintype", Logintype);
		List<Object[]> LoginProjectIdList=(List<Object[]>)query.getResultList();
		return LoginProjectIdList;
	}
	
	private static final String FILEREPMASTERLISTALL ="SELECT filerepmasterid,parentlevelid, levelid,levelname FROM file_rep_master where filerepmasterid>0 AND projectid=:projectid ORDER BY parentlevelid ";
	
	@Override
	public List<Object[]> FileRepMasterListAll(String projectid)throws Exception
	{
		logger.info(new Date() +"Inside FileRepMasterListAll");
		Query query=manager.createNativeQuery(FILEREPMASTERLISTALL);
		query.setParameter("projectid", projectid);
		List<Object[]> FileRepMasterListAll=(List<Object[]>)query.getResultList();
		return FileRepMasterListAll;
	}
	
	
	private static final String DOCPARENTLEVELLIST ="SELECT fileuploadmasterid,parentlevelid,levelid,levelname,docid,docshortname FROM file_doc_master WHERE isactive=1 AND fileuploadmasterid IN (SELECT parentlevelid FROM file_doc_master WHERE isactive=1 AND fileuploadmasterid IN (SELECT parentlevelid FROM file_project_doc   WHERE projectid=:projectid ) )  UNION SELECT fileuploadmasterid,parentlevelid,levelid,levelname,docid,docshortname FROM file_doc_master WHERE isactive=1 AND fileuploadmasterid IN (SELECT parentlevelid FROM file_project_doc   WHERE projectid=:projectid ) ";
	
	@Override
	public List<Object[]> DocParentLevelList(String projectid)throws Exception
	{
		logger.info(new java.util.Date() +"Inside DocParentLevelList");
		Query query=manager.createNativeQuery(DOCPARENTLEVELLIST);
		query.setParameter("projectid", projectid);
		List<Object[]> DocParentLevelList=(List<Object[]>)query.getResultList();
		return DocParentLevelList;
	}
	
	private static final String PROJECTDOCASSIGNEDLIST ="SELECT  dm.fileuploadmasterid,dm.parentlevelid,levelid,dm.levelname,dm.docid,dm.docshortname ,pd.projectdocid FROM file_project_doc pd, file_doc_master dm WHERE  pd.isactive=1 AND dm.isactive=1 AND pd.fileuploadmasterid = dm.fileuploadmasterid AND dm.levelid=3 AND pd.projectid=:projectid";
	
	@Override
	public List<Object[]> ProjectDocAssignedList(String projectid)throws Exception
	{
		logger.info(new java.util.Date() +"Inside ProjectDocAssignedList");
		Query query=manager.createNativeQuery(PROJECTDOCASSIGNEDLIST);
		query.setParameter("projectid", projectid);
		List<Object[]> ProjectDocAssignedList=(List<Object[]>)query.getResultList();
		return ProjectDocAssignedList;
	}
	
	@Override
	public List<PfmsDocTemplate> PfmsDocTemplateList(String projectid,String fileuploadmasterid)throws Exception
	{
		logger.info(new Date() +"Inside PfmsDocTemplateList");
		List<PfmsDocTemplate> pfmsdoctemplatelist = new ArrayList<PfmsDocTemplate>();
		try {
			CriteriaBuilder cb = manager.getCriteriaBuilder();
			CriteriaQuery<PfmsDocTemplate> cq= cb.createQuery(PfmsDocTemplate.class);
			Root<PfmsDocTemplate> root= cq.from(PfmsDocTemplate.class);
			Predicate p1 = cb.equal(root.get("ProjectId"), Long.parseLong(projectid));
			Predicate p2 = cb.equal(root.get("FileUploadMasterId"), Long.parseLong(fileuploadmasterid));
			Predicate p3 = cb.equal(root.get("IsActive"), 1);
			cq=cq.select(root).where(cb.and(p1,p2));
			TypedQuery<PfmsDocTemplate> allQuery = manager.createQuery(cq);
			pfmsdoctemplatelist =allQuery.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return pfmsdoctemplatelist;
	}
	
	
	
	private static final String DOCMASTERDATAPDOCID = "SELECT dm.fileuploadmasterid,dm.levelid,dm.levelname,dm.docshortname,dm.docid,pd.projectdocid FROM file_doc_master dm,file_project_doc pd WHERE  dm.fileuploadmasterid  =pd.fileuploadmasterid AND pd.projectid =:projectid  AND pd.fileuploadmasterid=:fileuploadmasterid ";
	
	@Override
	public Object[] DocMasterDataPdocId(String projectid, String fileuploadmasterid)throws Exception
	{
		logger.info(new Date() +"Inside DocMasterDataPdocId");
		try {
			Query query=manager.createNativeQuery(DOCMASTERDATAPDOCID);
			query.setParameter("projectid", projectid);
			query.setParameter("fileuploadmasterid", fileuploadmasterid);
			Object[] DocMasterDataPdocId=(Object[])query.getResultList().get(0);
			return DocMasterDataPdocId;			
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public long TemplateItemNameEdit(PfmsDocTemplate item)throws Exception
	{
		logger.info(new Date() +"Inside TemplateItemNameEdit");
		long templateid= 0;
		try {
			PfmsDocTemplate detach=manager.find(PfmsDocTemplate.class, item.getTemplateItemId());
			detach.setItemName(item.getItemName());
			detach.setModifiedBy(item.getModifiedBy());
			detach.setModifiedDate(item.getModifiedDate());
			templateid = detach.getTemplateItemId();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return templateid;
	}
	
	@Override
	public long TemplateItemDelete(PfmsDocTemplate item)throws Exception
	{
		logger.info(new Date() +"Inside TemplateItemDelete");
		long templateid= 0;
		try {
			PfmsDocTemplate detach=manager.find(PfmsDocTemplate.class, item.getTemplateItemId());
			detach.setModifiedBy(item.getModifiedBy());
			detach.setModifiedDate(item.getModifiedDate());
			detach.setIsActive(0);
			templateid = detach.getTemplateItemId();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return templateid;
	}
	
	@Override
	public List<PfmsDocContent> TemplateContentList(String templateitemid)throws Exception
	{
		logger.info(new Date() +"Inside TemplateContentList");
		List<PfmsDocContent> contentlist = new ArrayList<PfmsDocContent>();
		try {
			CriteriaBuilder cb = manager.getCriteriaBuilder();
			CriteriaQuery<PfmsDocContent> cq= cb.createQuery(PfmsDocContent.class);
			Root<PfmsDocContent> root= cq.from(PfmsDocContent.class);
			Predicate p1 = cb.equal(root.get("TemplateItemId"), Long.parseLong(templateitemid));
			Predicate p2 = cb.equal(root.get("IsActive"), 1);
			cq=cq.select(root).where(cb.and(p1,p2));
			TypedQuery<PfmsDocContent> allQuery = manager.createQuery(cq);
			contentlist =allQuery.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return contentlist;
	}
	
	@Override
	public long TemplateItemAdd(PfmsDocTemplate tempitem)throws Exception
	{
		logger.info(new Date() +"Inside TemplateItemAdd");
		try {
			manager.persist(tempitem);
			manager.flush();
			return tempitem.getTemplateItemId();
			
		}catch (Exception e) {
			e.printStackTrace();
		}		
		return 0;
	}
	
	private static final String PROJECTDOCSLIST = "SELECT a.fileuploadmasterid,a.parentlevelid,a.levelname,a.docid,d.projectdocid FROM file_doc_master a, file_project_doc d  WHERE a.isactive=1 AND d.isactive=1 AND a.fileuploadmasterid =d.fileuploadmasterid AND d.projectid=:projectid";
	
	@Override
	public List<Object[]> ProjectDocsList(String projectid)throws Exception
	{
		logger.info(new Date() +"Inside ProjectDocsList");
		try {
			Query query=manager.createNativeQuery(PROJECTDOCSLIST);
			query.setParameter("projectid", projectid);
			List<Object[]> ProjectDocsList=( List<Object[]>)query.getResultList();
			return ProjectDocsList;			
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	private static final String TEMPITEMLISTWITHCONTENTID = "SELECT dt.TemplateItemId,dt.LevelNo,dt.ParentLevelId,dt.ProjectId,dt.ItemName, (SELECT dc.tempcontentid FROM  pfms_doc_content dc WHERE dt.TemplateItemId=dc.TemplateItemId AND dc.isactive=1 AND dc.pfmsdocid = :pfmsdocid ) AS 'contentid' FROM pfms_doc pd, pfms_doc_template dt WHERE  pd.projectid=dt.projectid AND  pd.fileuploadmasterid=dt.fileuploadmasterid AND dt.isactive=1 AND pd.pfmsdocid = :pfmsdocid";
	
	@Override
	public List<Object[]> TempItemListwithContentId(String pfmsdocid)throws Exception
	{
		logger.info(new Date() +"Inside TempItemListwithContentId");
		try {
			Query query=manager.createNativeQuery(TEMPITEMLISTWITHCONTENTID);
			query.setParameter("pfmsdocid", pfmsdocid);
			 List<Object[]> TempItemListwithContentId=( List<Object[]>)query.getResultList();
			return TempItemListwithContentId;			
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}
	
	
	private static final String PFMSTEMPITEMCONTENT = "SELECT dt.templateitemid,dt.levelno,dt.projectid,dt.itemname,(SELECT dc.tempcontentid FROM pfms_doc_content dc WHERE dc.isactive=1 AND dt.templateitemid=dc.templateitemid AND dc.pfmsdocid=:pfmsdocid ) AS 'contentid',(SELECT dc.Itemcontent FROM pfms_doc_content dc WHERE dc.isactive=1 AND dt.templateitemid=dc.templateitemid AND dc.pfmsdocid=:pfmsdocid ) AS 'content', (SELECT dc.IsDependent FROM pfms_doc_content dc WHERE dc.isactive=1 AND dt.templateitemid=dc.templateitemid AND dc.pfmsdocid=:pfmsdocid ) AS 'isdependent'  FROM  pfms_doc_template dt WHERE dt.templateitemid=:templateitemid AND dt.isactive=1 ";
	@Override
	public Object[] PfmsTempItemContent(String templateitemid,String pfmsdocid)throws Exception
	{
		logger.info(new Date() +"Inside TempItemListwithContentId");
		try {
			Query query=manager.createNativeQuery(PFMSTEMPITEMCONTENT);
			query.setParameter("templateitemid", templateitemid);
			query.setParameter("pfmsdocid", pfmsdocid);
			 List<Object[]> PfmsTempItemContent=( List<Object[]>)query.getResultList();
			return PfmsTempItemContent.get(0);			
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public long TempItemContentAdd(PfmsDocContent tempitemcontent)throws Exception
	{
		logger.info(new Date() +"Inside TemplateItemAdd");
		try {
			manager.persist(tempitemcontent);
			manager.flush();
			return tempitemcontent.getTempContentId();
			
		}catch (Exception e) {
			e.printStackTrace();
		}		
		return 0;
	}
	
	@Override
	public long TempItemContentUpdate(PfmsDocContent itemcontent)throws Exception
	{
		logger.info(new Date() +"Inside TempItemContentUpdate");
		long templateid= 0;
		try {
			PfmsDocContent detach=manager.find(PfmsDocContent.class, itemcontent.getTempContentId());
			detach.setItemContent(itemcontent.getItemContent());
			detach.setIsDependent(itemcontent.getIsDependent());
			detach.setModifiedBy(itemcontent.getModifiedBy());
			detach.setModifiedDate(itemcontent.getModifiedDate());			
			templateid = detach.getTempContentId();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return templateid;
	}
	
	
	private static final String TEMPITEMCONTENTSLIST = "SELECT a.templateitemid, a.levelno, a.parentlevelid, a.projectid, a.itemname, b.tempcontentid, b.Itemcontent,b.IsDependent FROM  (SELECT dt.templateitemid, dt.levelno, dt.parentlevelid, dt.projectid, dt.itemname, pd.PfmsDocId FROM pfms_doc pd,  pfms_doc_template dt  WHERE pd.projectid = dt.projectid    AND pd.fileuploadmasterid = dt.fileuploadmasterid    AND dt.isactive = 1    AND pd.pfmsdocid = :pfmsdocid) AS a  LEFT JOIN pfms_doc_content b  ON a.templateitemid = b.templateitemid AND a.pfmsdocid = b.pfmsdocid ";
	@Override
	public List<Object[]> TempItemContentsList(String pfmsdocid)throws Exception
	{
		logger.info(new Date() +"Inside TempItemContentsList");
		try {
			Query query=manager.createNativeQuery(TEMPITEMCONTENTSLIST);
			query.setParameter("pfmsdocid", pfmsdocid);
			 List<Object[]> TempItemContentsList=( List<Object[]>)query.getResultList();
			return TempItemContentsList;		
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}
	
	private static final String PROJECTANDDOCUMENTNAME = "SELECT pd.projectdocid,pd.projectid,pd.fileuploadmasterid, pm.projectcode,dm.levelname FROM file_project_doc pd, file_doc_master dm,project_master pm WHERE pd.projectid=pm.projectid AND pd.fileuploadmasterid=dm.fileuploadmasterid AND projectdocid=:projectdocid ";
	@Override
	public Object[] ProjectAndDocumentName(String projectdocid)throws Exception
	{
		logger.info(new Date() +"Inside ProjectAndDocumentName");
		try {
			Query query=manager.createNativeQuery(PROJECTANDDOCUMENTNAME);
			query.setParameter("projectdocid", projectdocid);
			List<Object[]> ProjectAndDocumentName=( List<Object[]>)query.getResultList();
			return ProjectAndDocumentName.get(0);		
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public PfmsDoc PfmsDocCheck(String projectid,String filerepmasterid,String fileuploadmasterid)throws Exception
	{
		logger.info(new Date() +"Inside PfmsDocCheck");
		try {
			PfmsDoc pfmsdoc = null;
			CriteriaBuilder cb = manager.getCriteriaBuilder();
			CriteriaQuery<PfmsDoc> cq= cb.createQuery(PfmsDoc.class);
			Root<PfmsDoc> root= cq.from(PfmsDoc.class);
			Predicate p1 = cb.equal(root.get("ProjectId"), Long.parseLong(projectid));
			Predicate p2 = cb.equal(root.get("FileRepMasterId"), Long.parseLong(filerepmasterid));
			Predicate p3 = cb.equal(root.get("FileUploadMasterId"), Long.parseLong(fileuploadmasterid));
			cq=cq.select(root).where(cb.and(p1,p2,p3));
			TypedQuery<PfmsDoc> allQuery = manager.createQuery(cq);
			pfmsdoc = allQuery.getSingleResult();
			return pfmsdoc;
		}catch (NoResultException e) {
			return null;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public PfmsDoc PfmsDocAdd(PfmsDoc doc)throws Exception
	{
		logger.info(new Date() +"Inside PfmsDocList");
		try {
			manager.persist(doc);
			manager.flush();
			return doc;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}		
		
	}
	
	@Override
	public long PfmsDocContentRevAdd(PfmsDocContentRev contentrev)throws Exception
	{
		logger.info(new Date() +"Inside PfmsDocContentRevAdd");
		try {
			manager.persist(contentrev);
			manager.flush();
			return contentrev.getTempContentRevId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}		
		
	}
	
	
	@Override
	public long PfmsDocContentFrzAdd(PfmsDocContentFreeze contentfrz)throws Exception
	{
		logger.info(new Date() +"Inside PfmsDocContentRevAdd");
		try {
			manager.persist(contentfrz);
			manager.flush();
			return contentfrz.getTempContentFrzId();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}		
		
	}
	
	
	
	@Override
	public PfmsDoc pfmsDoc(String pfmsdocid)throws Exception
	{
		logger.info(new Date() +"Inside pfmsDoc");
		try {
			PfmsDoc pfmsdoc = null;
			CriteriaBuilder cb = manager.getCriteriaBuilder();
			CriteriaQuery<PfmsDoc> cq= cb.createQuery(PfmsDoc.class);
			Root<PfmsDoc> root= cq.from(PfmsDoc.class);
			Predicate p1 = cb.equal(root.get("PfmsDocId"), Long.parseLong(pfmsdocid));
			cq=cq.select(root).where(p1);
			TypedQuery<PfmsDoc> allQuery = manager.createQuery(cq);
			pfmsdoc = allQuery.getSingleResult();
			return pfmsdoc;
		}catch (NoResultException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public long pfmsDocVersionUpdate(PfmsDoc pfmsdoc)throws Exception
	{
		logger.info(new Date() +"Inside pfmsDoc");
		try {
			manager.merge(pfmsdoc);
			manager.flush();
			return pfmsdoc.getPfmsDocId();
		}catch (NoResultException e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	private static final String PFMSDOCDATA = "SELECT pd.pfmsdocid,pd.projectid,pd.filerepmasterid,pd.fileuploadmasterid,pd.versionno,rm.levelname AS 'systemname',dm.levelname AS 'docname' , pm.projectcode,pm.projectname,pd.isfrozen FROM pfms_doc pd, file_rep_master rm, file_doc_master dm ,project_master pm WHERE pd.filerepmasterid=rm.filerepmasterid AND pd.fileuploadmasterid=dm.fileuploadmasterid AND pd.projectid = pm.projectid AND pd.pfmsdocid=:pfmsdocid  UNION  SELECT   pd.pfmsdocid,   pd.projectid,   pd.filerepmasterid,    pd.fileuploadmasterid,    pd.versionno,    rm.levelname AS 'systemname',    dm.levelname AS 'docname',  'GEN' AS 'projectcode',  'GENERAL' AS 'projectname', pd.isfrozen  FROM  pfms_doc pd,  file_rep_master rm,  file_doc_master dm WHERE pd.filerepmasterid = rm.filerepmasterid  AND pd.fileuploadmasterid = dm.fileuploadmasterid  AND pd.pfmsdocid = :pfmsdocid AND pd.projectid=0 ";
	@Override
	public Object[] PfmsDocData(String pfmsdocid)throws Exception
	{
		logger.info(new Date() +"Inside PfmsDocData");
		try {
			Query query=manager.createNativeQuery(PFMSDOCDATA);
			query.setParameter("pfmsdocid", pfmsdocid);
			List<Object[]> PfmsDocData=( List<Object[]>)query.getResultList();
			return PfmsDocData.get(0);		
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	private static final String DOCREVISEDVERSIONNOS = "SELECT DISTINCT(cr.versionno), cr.revisiondate FROM  pfms_doc_content_rev cr WHERE cr.isactive=1 AND cr.pfmsdocid=:pfmsdocid ORDER BY cr.versionno DESC";
	@Override
	public List<Object[]> DocRevisedVersionNos(String pfmsdocid)throws Exception
	{
		logger.info(new Date() +"Inside DocRevisedVersionNos");
		try {
			Query query=manager.createNativeQuery(DOCREVISEDVERSIONNOS);
			query.setParameter("pfmsdocid", pfmsdocid);
			 List<Object[]> resultset=( List<Object[]>)query.getResultList();
			return resultset;		
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}
	

	@Override
	public List<PfmsDocContentRev> PfmsDocContentRevData(String pfmsdocid,String versionno)throws Exception
	{
		logger.info(new Date() +"Inside PfmsDocTemplateList");
		List<PfmsDocContentRev> pfmsdoctemplatelist = new ArrayList<PfmsDocContentRev>();
		try {
			CriteriaBuilder cb = manager.getCriteriaBuilder();
			CriteriaQuery<PfmsDocContentRev> cq= cb.createQuery(PfmsDocContentRev.class);
			Root<PfmsDocContentRev> root= cq.from(PfmsDocContentRev.class);
			Predicate p1 = cb.equal(root.get("PfmsDocId"), Long.parseLong(pfmsdocid));
			Predicate p2 = cb.equal(root.get("VersionNo"), Long.parseLong(versionno));
			Predicate p3 = cb.equal(root.get("IsActive"), 1);
			cq=cq.select(root).where(p1,p2,p3);
			TypedQuery<PfmsDocContentRev> allQuery = manager.createQuery(cq);
			pfmsdoctemplatelist =allQuery.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return pfmsdoctemplatelist;
	}
	
	@Override
	public List<PfmsDocContentFreeze> PfmsDocContentFrzData(String pfmsdocid)throws Exception
	{
		logger.info(new Date() +"Inside PfmsDocContentFrzData");
		List<PfmsDocContentFreeze> pfmsdoctemplatelist = new ArrayList<PfmsDocContentFreeze>();
		try {
			CriteriaBuilder cb = manager.getCriteriaBuilder();
			CriteriaQuery<PfmsDocContentFreeze> cq= cb.createQuery(PfmsDocContentFreeze.class);
			Root<PfmsDocContentFreeze> root= cq.from(PfmsDocContentFreeze.class);
			Predicate p1 = cb.equal(root.get("PfmsDocId"), Long.parseLong(pfmsdocid));
//			Predicate p2 = cb.equal(root.get("VersionNo"), Long.parseLong(versionno));
			Predicate p3 = cb.equal(root.get("IsActive"), 1);
			cq=cq.select(root).where(p1,p3);
			TypedQuery<PfmsDocContentFreeze> allQuery = manager.createQuery(cq);
			pfmsdoctemplatelist =allQuery.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return pfmsdoctemplatelist;
	}
	
	private static final String LABDETAILS = "SELECT LabMasterId, LabCode, LabName, LabUnitCode, LabAddress, LabCity, LabPin, LabTelNo, LabFaxNo, LabEmail, LabAuthority, LabAuthorityId, LabRfpEmail, LabId, ClusterId, LabLogo FROM lab_master";
	@Override
	public Object[] LabDetails()throws Exception 
	{
		logger.info(new java.util.Date() +"Inside LabDetails");
		Query query=manager.createNativeQuery(LABDETAILS);
		Object[] Labdetails =(Object[])query.getResultList().get(0);
		return Labdetails ;
	}
	
	private static final String FILEDOCMASTERLISTALL ="SELECT fileuploadmasterid,parentlevelid,levelid,levelname,docid,docshortname FROM file_doc_master WHERE isactive=1 AND fileuploadmasterid IN (SELECT parentlevelid FROM file_doc_master WHERE isactive=1 AND fileuploadmasterid IN (SELECT parentlevelid FROM file_project_doc   WHERE projectid=:projectid ) )  UNION SELECT fileuploadmasterid,parentlevelid,levelid,levelname,docid,docshortname FROM file_doc_master WHERE isactive=1 AND fileuploadmasterid IN (SELECT parentlevelid FROM file_project_doc   WHERE projectid=:projectid ) ";
	
	@Override
	public List<Object[]> FileDocMasterListAll(String projectid)throws Exception
	{
		logger.info(new java.util.Date() +"Inside FileDocMasterListAll");
		Query query=manager.createNativeQuery(FILEDOCMASTERLISTALL);
		query.setParameter("projectid", projectid);
		List<Object[]> FileDocMasterListAll=(List<Object[]>)query.getResultList();
		return FileDocMasterListAll;
	}
	
	
	@Override
	public List<FileRepMaster> DocProjectSystems(String projectid)throws Exception
	{
		logger.info(new Date() +"Inside DocProjectSystems");
		List<FileRepMaster> pfmsdoctemplatelist = new ArrayList<FileRepMaster>();
		try {
			CriteriaBuilder cb = manager.getCriteriaBuilder();
			CriteriaQuery<FileRepMaster> cq= cb.createQuery(FileRepMaster.class);
			Root<FileRepMaster> root= cq.from(FileRepMaster.class);
			Predicate p1 = cb.equal(root.get("ProjectId"), Long.parseLong(projectid));
			Predicate p2 = cb.equal(root.get("IsActive"), 1);
			cq=cq.select(root).where(p1,p2);
			TypedQuery<FileRepMaster> allQuery = manager.createQuery(cq);
			pfmsdoctemplatelist =allQuery.getResultList();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return pfmsdoctemplatelist;
	}
	
	private static final String REVISEDITEMNAMESLIST = "SELECT dcr.tempcontentfrzid, dcr.templateitemid,dcr.tempcontentid,dcr.levelno,dcr.parentlevelid,dcr.pfmsdocid,dcr.Itemname ,(SELECT dcl.contentlinkid FROM pfms_doc_content_links dcl WHERE dcr.tempcontentid = dcl.linkedTempContentId AND dcl.maintempcontentid = :mainitemcontentid ) AS 'linkcontentid' FROM pfms_doc_content_freeze dcr WHERE dcr.isactive=1 AND dcr.pfmsdocid = :pfmsdocid   ";
	@Override
	public List<Object[]> RevisedItemNamesList(String pfmsdocid,String mainitemcontentid)throws Exception
	{
		logger.info(new Date() +"Inside RevisedItemNamesList");
		try {
			Query query=manager.createNativeQuery(REVISEDITEMNAMESLIST);
			query.setParameter("pfmsdocid", pfmsdocid);
			query.setParameter("mainitemcontentid", mainitemcontentid);
			 List<Object[]> resultset=( List<Object[]>)query.getResultList();
			return resultset;		
		}catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<Object[]>();
		}
	}
	
	private static final String REVISEDITEMCONTENT = "SELECT LabMasterId, LabCode, LabName, LabUnitCode, LabAddress, LabCity, LabPin, LabTelNo, LabFaxNo, LabEmail, LabAuthority, LabAuthorityId, LabRfpEmail, LabId, ClusterId, LabLogo FROM lab_master";
	@Override
	public Object[] RevisedItemContent(String tempcontentrevid)throws Exception 
	{
		logger.info(new java.util.Date() +"Inside RevisedItemContent");
		Query query=manager.createNativeQuery(REVISEDITEMCONTENT);
		Object[] result =(Object[])query.getResultList().get(0);
		return result ;
	}
	
	private static final String CONTENTADDEDDOCS ="SELECT DISTINCT dm.fileuploadmasterid,  dm.parentlevelid,  dm.levelid,  dm.levelname,  dm.docid,  dm.docshortname, pd.pfmsdocid , cr.versionno FROM  pfms_doc pd,  file_doc_master dm,  pfms_doc_content_freeze cr WHERE pd.isactive = 1  AND pd.FileUploadMasterId = dm.FileUploadMasterId  AND  cr.isactive = 1 AND cr.PfmsDocId = pd.PfmsDocId  AND pd.FileRepMasterId = :filerepmasterid";
	
	@Override
	public List<Object[]> ContentAddedDocs(String filerepmasterid)throws Exception
	{
		logger.info(new java.util.Date() +"Inside ContentAddedDocs");
		Query query=manager.createNativeQuery(CONTENTADDEDDOCS);
		query.setParameter("filerepmasterid", filerepmasterid);
		List<Object[]> reslutlist=(List<Object[]>)query.getResultList();
		return reslutlist;
	}
	
	@Override
	public long pfmsDocContentLinkAdd(PfmsDocContentLinks link)throws Exception
	{
		logger.info(new Date() +"Inside pfmsDocContentLinkAdd ");
		try {
			manager.persist(link);
			manager.flush();
			return link.getContentLinkId();
			
		}catch (Exception e) {
			e.printStackTrace();
		}		
		return 0;
	}
	
	
	private static final String TEMPCONTENTFRZ = "SELECT tempcontentfrzid, ItemName,ItemContent FROM pfms_doc_content_freeze WHERE tempcontentfrzid=:tempcontentfrzid";
	@Override
	public Object[] TempContentFrz(String tempcontentfrzid)throws Exception 
	{
		Object[] result =null;
		logger.info(new java.util.Date() +"Inside TempContentFrz");
		try {
			Query query=manager.createNativeQuery(TEMPCONTENTFRZ);
			query.setParameter("tempcontentfrzid", tempcontentfrzid);
			result =(Object[])query.getResultList().get(0);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result ;
	}
	
	private static final String ITEMLINKSLIST ="SELECT   cr.tempcontentfrzid,   cr.tempcontentid,   cr.pfmsdocid,  cr.itemname,  cr.versionno,  pd.PfmsDocId,  dm.DocId,  dm.LevelName,  dm.DocShortName FROM  pfms_doc_content_links cl,   pfms_doc_content_freeze cr,   pfms_doc pd,   file_doc_master dm WHERE cr.isactive = 1   AND cl.LinkedTempContentId = cr.TempContentId   AND cr.PfmsDocId = pd.PfmsDocId   AND pd.FileUploadMasterId = dm.FileUploadMasterId   AND cl.maintempcontentid = :maintempcontentid";
	@Override
	public List<Object[]> ItemLinksList(String maintempcontentid)throws Exception
	{
		logger.info(new java.util.Date() +"Inside ItemLinksList");
		Query query=manager.createNativeQuery(ITEMLINKSLIST);
		query.setParameter("maintempcontentid", maintempcontentid);
		List<Object[]> reslutlist=(List<Object[]>)query.getResultList();
		return reslutlist;
	}
	
	private static final String DELETEFROZENDOC ="DELETE FROM pfms_doc_content_freeze WHERE pfmsdocid=:pfmsdocid";
	@Override
	public int DeleteFrozenDoc(String pfmsdocid)throws Exception
	{
		logger.info(new java.util.Date() +"Inside DeleteFrozenDoc");
		Query query=manager.createNativeQuery(DELETEFROZENDOC);
		query.setParameter("pfmsdocid", pfmsdocid);
		return query.executeUpdate(); 
	}
	
}