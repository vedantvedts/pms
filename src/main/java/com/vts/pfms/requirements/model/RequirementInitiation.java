package com.vts.pfms.requirements.model;

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

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name="pfms_req_initiation")
public class RequirementInitiation implements Serializable{
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ReqInitiationId;
	private Long ProjectId;
	private Long InitiationId;
	private Long ProductTreeMainId;
	private String ReqVersion;
	private String Remarks;
	private Long InitiatedBy;
	private String InitiatedDate;
	private String ReqStatusCode;
	private String ReqStatusCodeNext;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
}
