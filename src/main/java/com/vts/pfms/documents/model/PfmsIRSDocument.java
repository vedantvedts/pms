package com.vts.pfms.documents.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="pfms_irs_document")
public class PfmsIRSDocument implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long IRSDocId;
	private Long ProjectId;
	private Long InitiationId;
	private Long ProductTreeMainId;
	private String IRSVersion;
	private String LabCode;
	private String InitiatedBy;
	private String InitiatedDate;
	private String IRSStatusCode;
	private String IRSStatusCodeNext;
	private String Remarks;
	private String Introduction;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
