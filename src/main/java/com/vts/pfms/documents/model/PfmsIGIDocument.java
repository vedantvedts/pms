package com.vts.pfms.documents.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="pfms_Igi_Document")
public class PfmsIGIDocument {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long IGIDocId;
	private String IGIVersion;
	private String LabCode;
	private String InitiatedBy;
	private String InitiatedDate;
	private String IGIStatusCode;
	private String IGIStatusCodeNext;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
