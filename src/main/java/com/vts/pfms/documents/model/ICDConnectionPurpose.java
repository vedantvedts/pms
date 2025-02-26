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
@Table(name="pfms_icd_connection_purpose")
public class ICDConnectionPurpose implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ConPurposeId;
	private Long ICDConnectionId;
	private Long PurposeId;
	private String CreatedBy;
	private String CreatedDate;
	//private String ModifiedBy;
	//private String ModifiedDate;
	private int IsActive;
}
