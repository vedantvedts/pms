package com.vts.pfms.documents.service;

import java.math.BigInteger;
import java.util.List;

import com.vts.pfms.documents.dto.StandardDocumentsDto;
import com.vts.pfms.documents.model.IGIDocumentMembers;
import com.vts.pfms.documents.model.IGIDocumentShortCodes;
import com.vts.pfms.documents.model.IGIDocumentSummary;
import com.vts.pfms.documents.model.IGIInterface;
import com.vts.pfms.documents.model.PfmsIGIDocument;

public interface DocumentsService {

	public long InsertStandardDocuments(StandardDocumentsDto dto) throws Exception;
	public List<Object[]> standardDocumentsList() throws Exception;
	public Object[] standardattachmentdata(String standardDocumentId) throws Exception;
	public long StandardDocumentDelete(long standardDocumentId) throws Exception;
	
	/* ************************************************ IGI Document ***************************************************** */
	public List<Object[]> IgiDocumentList() throws Exception;
	public long addPfmsIgiDocument(PfmsIGIDocument pfmsIgiDocument) throws Exception;
	public List<Object[]> igiDocumentSummaryList(String igiDocId) throws Exception;
	public IGIDocumentSummary getIgiDocumentSummaryById(String SummaryId) throws Exception;
	public long addIgiDocumentSummary(IGIDocumentSummary rs) throws Exception;
	public List<Object[]> igiDocumentMemberList(String igiDocId) throws Exception;
	public List<Object[]> getDocmployeeListByIGIDocId(String labCode, String igiDocId) throws Exception;
	public long addIGIDocumentMembers(IGIDocumentMembers rm) throws Exception;
	public IGIDocumentMembers getIGIDocumentMembersById(Long IgiMemeberId) throws Exception;
	public int deleteIGIDocumentMembers(String igiMemeberId) throws Exception;
	public long addIGIInterface(IGIInterface iif)throws Exception;
	public List<IGIInterface> getIGIInterfaceListByLabCode(String labCode)throws Exception;
	public PfmsIGIDocument getPfmsIGIDocumentById(String igiDocId)throws Exception;
	public IGIInterface getIGIInterfaceById(String interfaceId) throws Exception;
	public BigInteger getDuplicateInterfaceCodeCount(String interfaceId, String interfaceCode) throws Exception;
	public List<IGIDocumentShortCodes> getIGIDocumentShortCodesList() throws Exception;
	public int deleteIGIDocumentShortCodesByType(String shortCodeType) throws Exception;
	public long addIGIDocumentShortCodes(List<IGIDocumentShortCodes> igiDocumentShortCodes) throws Exception;
	/* ************************************************ IGI Document End***************************************************** */
}
