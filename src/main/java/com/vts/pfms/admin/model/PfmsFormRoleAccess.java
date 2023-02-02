package com.vts.pfms.admin.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
