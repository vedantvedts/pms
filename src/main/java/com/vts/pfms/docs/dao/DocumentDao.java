package com.vts.pfms.docs.dao;

import java.util.List;

import com.vts.pfms.docs.model.PfmsDoc;
import com.vts.pfms.docs.model.PfmsDocContent;
import com.vts.pfms.docs.model.PfmsDocContentFreeze;
import com.vts.pfms.docs.model.PfmsDocContentLinks;
import com.vts.pfms.docs.model.PfmsDocContentRev;
import com.vts.pfms.docs.model.PfmsDocTemplate;
import com.vts.pfms.milestone.model.FileRepMaster;

public interface DocumentDao {

	public List<Object[]> LoginProjectsList(String empid, String Logintype,String LabCode) throws Exception;
	public List<Object[]> FileRepMasterListAll(String projectid,String LabCode) throws Exception;
	public List<Object[]> DocParentLevelList(String projectid,String LabCode) throws Exception;
	public List<Object[]> ProjectDocAssignedList(String projectid,String LabCode) throws Exception;
	public List<PfmsDocTemplate> PfmsDocTemplateList(String projectid,String fileuploadmasterid) throws Exception;
	public Object[] DocMasterDataPdocId(String projectid, String fileuploadmasterid) throws Exception;
	public long TemplateItemNameEdit(PfmsDocTemplate item) throws Exception;
	public long TemplateItemDelete(PfmsDocTemplate item) throws Exception;
	public List<PfmsDocContent> TemplateContentList(String templateitemid) throws Exception;
	public long TemplateItemAdd(PfmsDocTemplate tempitem) throws Exception;
	public List<Object[]> ProjectDocsList(String projectid) throws Exception;
	public List<Object[]> TempItemListwithContentId(String pfmsdocid) throws Exception;
	public Object[] PfmsTempItemContent(String templateitemid, String pfmsdocid) throws Exception;
	public long TempItemContentAdd(PfmsDocContent tempitemcontent) throws Exception;
	public long TempItemContentUpdate(PfmsDocContent itemcontent) throws Exception;
	public List<Object[]> TempItemContentsList(String filerepmasterid) throws Exception;
	public Object[] ProjectAndDocumentName(String projectdocid) throws Exception;
	public PfmsDoc PfmsDocCheck(String projectdocid, String filerepmasterid,String fileuploadmasterid) throws Exception;
	public PfmsDoc PfmsDocAdd(PfmsDoc doc) throws Exception;
	public long PfmsDocContentRevAdd(PfmsDocContentRev contentrev) throws Exception;
	public PfmsDoc pfmsDoc(String pfmsdocid) throws Exception;
	public long pfmsDocVersionUpdate(PfmsDoc pfmsdoc) throws Exception;
	public Object[] PfmsDocData(String pfmsdocid) throws Exception;
	public List<Object[]> DocRevisedVersionNos(String pfmsdocid) throws Exception;
	public List<PfmsDocContentRev> PfmsDocContentRevData(String pfmsdocid, String versionno) throws Exception;
	public Object[] LabDetails() throws Exception;
	public List<FileRepMaster> DocProjectSystems(String projectid) throws Exception;
	public List<Object[]> FileDocMasterListAll(String projectid) throws Exception;
	public List<Object[]> RevisedItemNamesList(String pfmsdocid,String mainitemcontentid) throws Exception;
	public Object[] RevisedItemContent(String tempcontentrevid) throws Exception;
	public List<Object[]> ContentAddedDocs(String filerepmasterid) throws Exception;
	public long pfmsDocContentLinkAdd(PfmsDocContentLinks link) throws Exception;
	public Object[] TempContentFrz(String tempcontentfrzid) throws Exception;
	public List<Object[]> ItemLinksList(String maintempcontentid) throws Exception;
	public long PfmsDocContentFrzAdd(PfmsDocContentFreeze contentfrz) throws Exception;
	public List<PfmsDocContentFreeze> PfmsDocContentFrzData(String pfmsdocid) throws Exception;
	public int DeleteFrozenDoc(String pfmsdocid) throws Exception;

}
