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
@Table(name="pfms_field_group_linked")
public class FieldGroupLinked implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FieldGroupLinkedId;
	private Long FieldMasterId;
	private Long FieldGroupId;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
}
