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
@Table(name="pfms_igi_document_summary")
public class IGIDocumentSummary implements Serializable{
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SummaryId;
	private Long DocId;
	private String DocType;
	private String AdditionalInformation;
	private String Abstract;
	private String Keywords;
	private String Distribution;
	private String Reviewer;
	private Long Approver;
	private String PreparedBy;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
    private String ReleaseDate;
	private int IsActive;
	
}
