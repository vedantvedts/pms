package com.vts.pfms.docs.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.FormatConverter;
import com.vts.pfms.docs.dao.DocumentDao;
import com.vts.pfms.docs.model.PfmsDoc;
import com.vts.pfms.docs.model.PfmsDocContent;
import com.vts.pfms.docs.model.PfmsDocContentFreeze;
import com.vts.pfms.docs.model.PfmsDocContentLinks;
import com.vts.pfms.docs.model.PfmsDocContentRev;
import com.vts.pfms.docs.model.PfmsDocTemplate;
import com.vts.pfms.milestone.model.FileRepMaster;

@Service
public class DocumentServiceImpl implements DocumentService {
	@Autowired
	DocumentDao dao;
	
	private static final Logger logger=LogManager.getLogger(DocumentServiceImpl.class);
	
	FormatConverter fc=new FormatConverter();
	private SimpleDateFormat sdf1=  fc.getSqlDateAndTimeFormat();       //new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//	private  SimpleDateFormat sdf=  fc.getRegularDateFormat();                               // new SimpleDateFormat("dd-MM-yyyy");
	
	@Override
	public List<Object[]> LoginProjectsList(String empid,String Logintype)throws Exception
	{
		return dao.LoginProjectsList(empid, Logintype);
	}
	
	@Override
	public List<Object[]> FileRepMasterListAll(String projectid)throws Exception
	{
		return dao.FileRepMasterListAll( projectid);
	}
	
	
	@Override
	public List<Object[]> DocParentLevelList(String projectid)throws Exception
	{
		return dao.DocParentLevelList(projectid);
	}
		
	@Override
	public List<Object[]> ProjectDocAssignedList(String projectid)throws Exception
	{
		return dao.ProjectDocAssignedList(projectid);
	}
	@Override
	public List<PfmsDocTemplate> PfmsDocTemplateList(String projectid,String fileuploadmasterid) throws Exception
	{
		return dao.PfmsDocTemplateList(projectid, fileuploadmasterid);
	}
	
	@Override
	public Object[] DocMasterDataPdocId(String projectid, String fileuploadmasterid)throws Exception
	{
		return dao.DocMasterDataPdocId(projectid,  fileuploadmasterid);
	}
	
	@Override
	public long TemplateItemNameEdit(PfmsDocTemplate item)throws Exception
	{
		item.setModifiedDate(sdf1.format(new Date()));
		return dao.TemplateItemNameEdit(item);
	}
	
	@Override
	public long TemplateItemDelete(PfmsDocTemplate item)throws Exception
	{
		item.setModifiedDate(sdf1.format(new Date()));
		return dao.TemplateItemDelete(item);
	}
	
	@Override
	public List<PfmsDocContent> TemplateContentList(String templateitemid)throws Exception
	{
		return dao.TemplateContentList(templateitemid);
	}
	
	@Override
	public long TemplateItemAdd(PfmsDocTemplate tempitem)throws Exception
	{
		tempitem.setCreatedDate(sdf1.format(new Date()));
		tempitem.setIsActive(1);
		return dao.TemplateItemAdd(tempitem);
	}
	
	@Override
	public List<Object[]> ProjectDocsList(String projectid)throws Exception
	{
		return dao.ProjectDocsList(projectid);
	}
	
	@Override
	public List<Object[]> TempItemListwithContentId(String pfmsdocid )throws Exception
	{
		return dao.TempItemListwithContentId(pfmsdocid);
	}
	@Override
	public Object[] PfmsTempItemContent(String templateitemid,String pfmsdocid)throws Exception
	{
		return dao.PfmsTempItemContent(templateitemid, pfmsdocid);
	}
	
	@Override
	public long TempItemContentAdd(PfmsDocContent tempitemcontent)throws Exception
	{
		tempitemcontent.setCreatedDate(sdf1.format(new Date()));
		tempitemcontent.setIsActive(1);
		return dao.TempItemContentAdd(tempitemcontent);
	}
	
	@Override
	public long TempItemContentUpdate(PfmsDocContent itemcontent)throws Exception
	{
		itemcontent.setModifiedDate(sdf1.format(new Date()));
		return dao.TempItemContentUpdate(itemcontent);
	}
	
	@Override
	public List<Object[]> TempItemContentsList(String pfmsdocid)throws Exception
	{
		return dao.TempItemContentsList( pfmsdocid);
	}
	
	@Override
	public Object[] ProjectAndDocumentName(String projectdocid)throws Exception
	{
		return dao.ProjectAndDocumentName(projectdocid);
	}
	
	@Override
	public PfmsDoc ProjectDocCheck(String projectid,String filerepmasterid,String fileuploadmasterid, String userid)throws Exception
	{
		PfmsDoc doc = dao.PfmsDocCheck(projectid, filerepmasterid,fileuploadmasterid);
		if(doc==null) {
			PfmsDoc doc1= new PfmsDoc();
			doc1.setProjectId(Long.parseLong(projectid));
			doc1.setFileRepMasterId(Long.parseLong(filerepmasterid));
			doc1.setFileUploadMasterId(Long.parseLong(fileuploadmasterid));
			doc1.setCreatedBy(userid);
			doc1.setCreatedDate(sdf1.format(new Date()));
			doc1.setVersionNo(1);
			doc1.setIsFrozen("N");
			doc1.setIsActive(1);
			doc= dao.PfmsDocAdd(doc1);
		}
		return doc;
	}
	
	
	@Override
	public long PfmsDocContentRevision(String projectdocid,String pfmsdocid,String userid)throws Exception
	{
		List<PfmsDocContentFreeze> doccontent = dao.PfmsDocContentFrzData(pfmsdocid);
		PfmsDoc pfmsDoc = dao.pfmsDoc(pfmsdocid); 
		for(PfmsDocContentFreeze content : doccontent) 
		{
			PfmsDocContentRev contentrev = new PfmsDocContentRev();
			contentrev.setTemplateItemId(content.getTemplateItemId());
			if(content.getTempContentId()!=0) {
				contentrev.setTempContentId(content.getTempContentId());
			}else
			{
				contentrev.setTempContentId(0);
			}			
			contentrev.setLevelNo(content.getLevelNo());
			contentrev.setParentLevelId(content.getParentLevelId());
			contentrev.setPfmsDocId(content.getPfmsDocId());
			contentrev.setItemName(content.getItemName());
			if(content.getTempContentId()>0) {
				contentrev.setItemContent(content.getItemContent());
			}
			contentrev.setRevisionDate(LocalDate.now().toString());
			contentrev.setVersionNo(pfmsDoc.getVersionNo());
			contentrev.setIsActive(1);		
			contentrev.setCreatedBy(userid);
			contentrev.setCreatedDate(sdf1.format(new Date()));
			dao.PfmsDocContentRevAdd(contentrev);
		}
		pfmsDoc.setVersionNo(pfmsDoc.getVersionNo()+1);
		pfmsDoc.setIsFrozen("N");
		return dao.pfmsDocVersionUpdate(pfmsDoc);
	}
	
	@Override
	public long pfmsDocContentFreeze(String projectdocid,String pfmsdocid,String userid)throws Exception
	{
		dao.DeleteFrozenDoc(pfmsdocid);
		List<Object[]> doccontent = dao.TempItemContentsList(pfmsdocid);
		PfmsDoc pfmsDoc = dao.pfmsDoc(pfmsdocid); 
		for(Object[] content : doccontent) 
		{
			PfmsDocContentFreeze contentfrz = new PfmsDocContentFreeze();
			contentfrz.setTemplateItemId(Long.parseLong(content[0].toString()));
			if(content[5]!=null) {
				contentfrz.setTempContentId(Long.parseLong(content[5].toString()));
			}else
			{
				contentfrz.setTempContentId(0);
			}			
			contentfrz.setLevelNo(Integer.parseInt(content[1].toString()));
			contentfrz.setParentLevelId(Long.parseLong(content[2].toString()));
			contentfrz.setPfmsDocId(Long.parseLong(pfmsdocid));
			contentfrz.setItemName(content[4].toString());
			if(content[5]!=null) {
				contentfrz.setItemContent(content[6].toString());
			}
			contentfrz.setRevisionDate(LocalDate.now().toString());
			contentfrz.setVersionNo(pfmsDoc.getVersionNo());
			contentfrz.setIsDependent(content[7].toString());
			contentfrz.setIsActive(1);		
			contentfrz.setCreatedBy(userid);
			contentfrz.setCreatedDate(sdf1.format(new Date()));
			dao.PfmsDocContentFrzAdd(contentfrz);
		}
		pfmsDoc.setIsFrozen("Y");
		return dao.pfmsDocVersionUpdate(pfmsDoc);
	}
	
	@Override
	public Object[] PfmsDocData(String pfmsdocid)throws Exception
	{
		return dao.PfmsDocData(pfmsdocid) 	;
	}
	
	@Override
	public List<Object[]> DocRevisedVersionNos(String pfmsdocid)throws Exception
	{
		return dao.DocRevisedVersionNos(pfmsdocid);
	}
	@Override
	public List<PfmsDocContentRev> PfmsDocContentRevData(String pfmsdocid,String versionno)throws Exception
	{
//		if(versionno!=null && Integer.parseInt(versionno)==0) 
//		{
//			versionno = String.valueOf(Integer.parseInt(dao.PfmsDocData(pfmsdocid)[4].toString())-1);
//		}
		return dao.PfmsDocContentRevData(pfmsdocid, versionno);
	}
	
	@Override
	public List<PfmsDocContentFreeze> PfmsDocContentFrzData(String pfmsdocid)throws Exception
	{
		return dao.PfmsDocContentFrzData(pfmsdocid);
	}
	
	@Override
	public Object[] LabDetails()throws Exception
	{
		return dao.LabDetails();
	}
	
	@Override
	public List<FileRepMaster> DocProjectSystems(String projectid)throws Exception
	{
		return dao.DocProjectSystems(projectid);
	}
	
	@Override
	public List<Object[]> FileDocMasterListAll(String projectid)throws Exception
	{
		return dao.FileDocMasterListAll(projectid);
	}
	
	@Override
	public List<Object[]> ProjectDocsAllAjax(String filerepmasterid)throws Exception
	{
		return dao.ContentAddedDocs(filerepmasterid);
	}
	
	@Override
	public List<Object[]> RevisedItemNamesList(String pfmsdocid,String mainitemcontentid)throws Exception
	{
		return dao.RevisedItemNamesList(pfmsdocid,mainitemcontentid);
	}
	
	@Override
	public Object[] RevisedItemContent(String tempcontentrevid)throws Exception 
	{
		return dao.RevisedItemContent(tempcontentrevid);
	}	
	
	@Override
	public long pfmsDocContentLinkAdd(PfmsDocContentLinks link)throws Exception
	{
		link.setIsActive(1);
		link.setCreatedDate(sdf1.format(new Date()));
		return dao.pfmsDocContentLinkAdd(link);
	}
	
	@Override
	public Object[] TempContentFrz(String tempcontentfrzid)throws Exception 
	{
		return dao.TempContentFrz(tempcontentfrzid);
	}
	
	@Override
	public List<Object[]> ItemLinksList(String maintempcontentid)throws Exception
	{
		return dao.ItemLinksList(maintempcontentid);
	}
	
	@Override
	public HashMap<Long, ArrayList<Object[]>> AllItemsLinksList(List<PfmsDocContentFreeze> contentlist)throws Exception
	{
		HashMap<Long, ArrayList<Object[]>> linkslistmap = new HashMap<Long, ArrayList<Object[]>>();
			for(PfmsDocContentFreeze content : contentlist)
			{
				if(content.getIsDependent().equalsIgnoreCase("Y")) 
				{
					linkslistmap.put(content.getTempContentId(),(ArrayList<Object[]>)dao.ItemLinksList(String.valueOf(content.getTempContentId())));
				}
			}		
		
		return linkslistmap;
	}
	
	@Override
	public HashMap<Long, ArrayList<Object[]>> AllItemsLinksListDraft(List<Object[]> contentlist)throws Exception
	{
		HashMap<Long, ArrayList<Object[]>> linkslistmap = new HashMap<Long, ArrayList<Object[]>>();
		
			for(Object[] content : contentlist)
			{
				if(content[7].toString().equalsIgnoreCase("Y")) 
				{
					linkslistmap.put(Long.parseLong(content[5].toString()),(ArrayList<Object[]>)dao.ItemLinksList(content[5].toString()));
				}
			}		
		
		return linkslistmap;
	}
	
	@Override
	public HashMap<Long, ArrayList<Object[]>> AllItemsLinksListRev(List<PfmsDocContentRev> contentlist)throws Exception
	{
		HashMap<Long, ArrayList<Object[]>> linkslistmap = new HashMap<Long, ArrayList<Object[]>>();
		for(PfmsDocContentRev content : contentlist)
		{
			ArrayList<Object[]> linkslist = (ArrayList<Object[]>)dao.ItemLinksList(String.valueOf(content.getTempContentId()));
			if(linkslist.size()>0) 
			{
				linkslistmap.put(content.getTempContentId(),linkslist);
			}
		}		
	
	return linkslistmap;
	}
	
}