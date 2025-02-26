package com.vts.pfms.documents.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_igi_document_shortcodes")
public class IGIDocumentShortCodes implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ShortCodeId;
	private String ShortCode;
	private String FullName;
	private String ShortCodeType;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	
}
