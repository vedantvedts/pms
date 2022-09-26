package com.vts.pfms.docs.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.vts.pfms.docs.model.PfmsDoc;
import com.vts.pfms.docs.model.PfmsDocContent;
import com.vts.pfms.docs.model.PfmsDocContentFreeze;
import com.vts.pfms.docs.model.PfmsDocContentLinks;
import com.vts.pfms.docs.model.PfmsDocContentRev;
import com.vts.pfms.docs.model.PfmsDocTemplate;
import com.vts.pfms.milestone.model.FileRepMaster;

public interface DocumentService {

	public List<Object[]> LoginProjectsList(String empid, String Logintype) throws Exception;
	public List<Object[]> FileRepMasterListAll(String projectid) throws Exception;
	public List<Object[]> DocParentLevelList(String projectid) throws Exception;
	public List<Object[]> ProjectDocAssignedList(String projectid) throws Exception;
	public List<PfmsDocTemplate> PfmsDocTemplateList(String projectdocid, String fileuploadmasterid) throws Exception;
	public Object[] DocMasterDataPdocId(String projectid, String fileuploadmasterid) throws Exception;
	public long TemplateItemNameEdit(PfmsDocTemplate item) throws Exception;
	public long TemplateItemDelete(PfmsDocTemplate item) throws Exception;
	public List<PfmsDocContent> TemplateContentList(String templateitemid) throws Exception;
	public long TemplateItemAdd(PfmsDocTemplate tempitem) throws Exception;
	public List<Object[]> ProjectDocsList(String projectid) throws Exception;
	public List<Object[]> TempItemListwithContentId(String pfmsdocid ) throws Exception;
	public Object[] PfmsTempItemContent(String templateitemid, String pfmsdocid) throws Exception;
	public long TempItemContentAdd(PfmsDocContent tempitemcontent) throws Exception;
	public long TempItemContentUpdate(PfmsDocContent itemcontent) throws Exception;
	public List<Object[]> TempItemContentsList(String pfmsdocid) throws Exception;
	public Object[] ProjectAndDocumentName(String projectdocid) throws Exception;
	public PfmsDoc ProjectDocCheck(String projectid, String filerepmasterid, String fileuploadmasterid , String userid) throws Exception;
	public long PfmsDocContentRevision(String projectdocid, String pfmsdocid,String userid) throws Exception;
	public Object[] PfmsDocData(String pfmsdocid) throws Exception;
	public List<Object[]> DocRevisedVersionNos(String pfmsdocid) throws Exception;
	public List<PfmsDocContentRev> PfmsDocContentRevData(String pfmsdocid, String versionno) throws Exception;
	public Object[] LabDetails() throws Exception;
	public List<FileRepMaster> DocProjectSystems(String projectid) throws Exception;
	public List<Object[]> FileDocMasterListAll(String projectid) throws Exception;
	public List<Object[]> ProjectDocsAllAjax(String filerepmasterid) throws Exception;
	public List<Object[]> RevisedItemNamesList(String pfmsdocid,String mainitemcontentid) throws Exception;
	public Object[] RevisedItemContent(String tempcontentrevid) throws Exception;
	public long pfmsDocContentLinkAdd(PfmsDocContentLinks link) throws Exception;
	public Object[] TempContentFrz(String tempcontentfrzid) throws Exception;
	public List<Object[]> ItemLinksList(String maintempcontentid) throws Exception;
	public long pfmsDocContentFreeze(String projectdocid, String pfmsdocid, String userid) throws Exception;
	public List<PfmsDocContentFreeze> PfmsDocContentFrzData(String pfmsdocid)throws Exception;
	public HashMap<Long, ArrayList<Object[]>> AllItemsLinksList(List<PfmsDocContentFreeze> contentlist) throws Exception;
	public HashMap<Long, ArrayList<Object[]>> AllItemsLinksListDraft(List<Object[]> contentlist) throws Exception;
	public HashMap<Long, ArrayList<Object[]>> AllItemsLinksListRev(List<PfmsDocContentRev> contentlist) throws Exception;

	
	
}
