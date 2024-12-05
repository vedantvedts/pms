package com.vts.pfms.documents.dao;

import java.util.List;

import com.vts.pfms.documents.model.IGIBasicParameters;
import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.IGIInterface;
import com.vts.pfms.documents.model.PfmsIGIDocument;
import com.vts.pfms.documents.model.StandardDocuments;

public interface DocumentsDao {

	public long standardDocumentInsert(StandardDocuments model) throws Exception;
	public List<Object[]> standardDocumentsList() throws Exception;
	public Object[] standardattachmentdata(String standardDocumentId) throws Exception;
	public StandardDocuments StandardDocumentDataById(long StandartDocumentId) throws Exception;
	public long StandardDocumentDelete(long standardDocumentId) throws Exception;
	
	/* ************************************************ IGI Document ***************************************************** */
	public List<Object[]> IgiDocumentList() throws Exception;
	public long addPfmsIgiDocument(PfmsIGIDocument pfmsIgiDocument) throws Exception;
	public List<Object[]> igiDocumentSummaryList(String igiDocId) throws Exception;
	public IGIDocumentSummary getIgiDocumentSummaryById(String summaryId) throws Exception;
	public long addIgiDocumentSummary(IGIDocumentSummary rs) throws Exception;
	public List<Object[]> igiDocumentMemberList(String igiDocId) throws Exception;
	public List<Object[]> getDocmployeeListByIGIDocId(String labCode, String igiDocId) throws Exception;
	public long addIGIDocumentMembers(IGIDocumentMembers igiDocumentMember) throws Exception;
	public IGIDocumentMembers getIGIDocumentMembersById(Long igiMemeberId) throws Exception;
	public int deleteIGIDocumentMembers(String igiMemeberId) throws Exception;
	public long addBasicInterfaceType(IGIInterface iif)throws Exception;
	public List<IGIInterface> getAllIGIInterface(String labCode)throws Exception;
	public List<Object[]> getAllBasicParameters()throws Exception;
	public long addIGIBasicParameters(IGIBasicParameters ib)throws Exception;
	public PfmsIGIDocument getPfmsIGIDocumentById(String igiDocId)throws Exception;
	/* ************************************************ IGI Document End ***************************************************** */
}
