package com.vts.pfms.requirements.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_doc_freeze")
public class DocumentFreeze {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DocFreezeId;
	private Long DocInitiationId;
	private String DocType;
	private String PdfFilePath;
	private String ExcelFilePath;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
}
