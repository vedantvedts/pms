package com.vts.pfms.documents.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="pfms_irs_field_desc")
public class IRSFieldDescription implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long IRSFieldDescId;
	private Long IRSSpecificationId;
	private Long LogicalInterfaceId;
	private Long FieldMasterId;
	private Long FieldGroupId;
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
	private String GroupVariable;
	private Long ArrayMasterId;
	private Integer FieldSlNo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private Integer IsActive;
}
