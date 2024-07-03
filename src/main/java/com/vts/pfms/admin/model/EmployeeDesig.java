package com.vts.pfms.admin.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "employee_desig")
public class EmployeeDesig {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long DesigId;
	private String DesigCode;
	private String Designation;
	private long DesigLimit;
	private String DesigCadre;
	
}
