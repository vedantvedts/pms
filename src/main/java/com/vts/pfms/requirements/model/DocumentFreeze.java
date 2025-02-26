package com.vts.pfms.requirements.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
