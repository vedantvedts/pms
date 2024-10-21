package com.vts.pfms.documents.dao;

import java.util.List;

import com.vts.pfms.documents.model.StandardDocuments;

public interface DocumentsDao {

	public long standardDocumentInsert(StandardDocuments model) throws Exception;

	public List<Object[]> standardDocumentsList() throws Exception;

	public Object[] standardattachmentdata(String standardDocumentId) throws Exception;

	public StandardDocuments StandardDocumentDataById(long StandartDocumentId) throws Exception;

	public long StandardDocumentDelete(long standardDocumentId) throws Exception;

}
