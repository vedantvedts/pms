package com.vts.pfms.master.model;

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
@Table(name="employee")
public class Employee {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long EmpId;
	private String EmpNo;
	private String Title;
	private String Salutation;
	private String EmpName;
	private Long DesigId;
	private String ExtNo;
	private Long MobileNo;
	private String DronaEmail;
	private String InternetEmail;
	private String Email;
	private Long DivisionId;
	private Long SrNo;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String LabCode;
	private String SuperiorOfficer;
}
