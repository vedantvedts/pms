package com.vts.pfms.documents.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StandardDocumentsDto {

	private Long StandardDocumentId;
	private String DocumentName;
	private String Description;
	private String FilePath;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String SelectedStandardDocumentId;
	private MultipartFile Attachment;
	private int IsActive;
}
