package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_emp_roles")
public class PfmsEmpRoles {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RoleId;
	private String Organization;
	private String EmpNo;
	private String EmpRole;
	
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
}
