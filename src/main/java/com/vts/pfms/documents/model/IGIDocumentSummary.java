package com.vts.pfms.documents.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;


@Data
@Entity
@Table(name="pfms_Igi_document_summary")
public class IGIDocumentSummary {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SummaryId;

	private String AdditionalInformation;
	private String Abstract;
	private String Keywords;
	private String Distribution;
	private String Reviewer;
	private Long Approver;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
    private String ReleaseDate;

	private int IsActive;
	private String PreparedBy;
	
	//primary key of pfms_igi_document Table or PfmsIgiDocument Model class
	private Long IGIDocId;

}
