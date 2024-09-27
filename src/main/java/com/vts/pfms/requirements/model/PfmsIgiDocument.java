package com.vts.pfms.requirements.model;

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
public class PfmsIgiDocument {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DocIgiId;
	private String IgiVersion;
	private String LabCode;
	private String InitiatedBy;
	private String InitiatedDate;
	private String IgiStatusCode;
	private String IgiStatusCodeNext;
	
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String Remarks;
	private int IsActive;

}
