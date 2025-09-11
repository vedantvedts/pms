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
@Table(name="pfms_field_master")
public class FieldMaster implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FieldMasterId;
	private String FieldName;
	private String FieldShortName;
	private String FieldCode;
	private String FieldDesc;
	private Long DataTypeMasterId;
	private String TypicalValue;
	private String FieldMinValue;
	private String FieldMaxValue;
	private String InitValue;
	private String FieldOffSet;
	private String Quantum;
	private String FieldUnit;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private Integer IsActive;
	private Long UnitMasterId;

}
