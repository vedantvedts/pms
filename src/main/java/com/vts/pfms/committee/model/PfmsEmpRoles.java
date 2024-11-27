package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
