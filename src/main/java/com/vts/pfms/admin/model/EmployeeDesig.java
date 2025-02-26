package com.vts.pfms.admin.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
