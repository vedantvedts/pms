package com.vts.pfms.admin.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="pfms_form_role_access")
public class PfmsFormRoleAccess {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FormRoleAccessId;
	private String LoginType;
	private Long FormDetailId;
	private Integer IsActive;
	private String LabHQ;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	
	
}
