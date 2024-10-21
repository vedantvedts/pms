package com.vts.pfms.documents.service;

import java.util.List;

import com.vts.pfms.documents.dto.StandardDocumentsDto;

public interface DocumentsService {

	public long InsertStandardDocuments(StandardDocumentsDto dto) throws Exception;

	public List<Object[]> standardDocumentsList() throws Exception;

	public Object[] standardattachmentdata(String standardDocumentId) throws Exception;

	public long StandardDocumentDelete(long standardDocumentId) throws Exception;

}
