package com.vts.pfms.master.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Entity
@Data
@Table(name="lab_employee")
public class LabPmsEmployee {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long EmpId;
	private Long PcNo;
	private String Pis;
	private String Name;
	private String Designation;
	private String DivName;
	private String LrdeMail;
	private String MobileNo;
	private String InternetMail;
	private String DronaMail;
	private String InternalPhoneNo;

}
