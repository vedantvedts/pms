package com.vts.pfms.documents.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Data
@Table(name = "pfms_standard_documents")
public class StandardDocuments {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long StandardDocumentId;
	private String DocumentName;
	private String Description;
	private String FilePath;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
