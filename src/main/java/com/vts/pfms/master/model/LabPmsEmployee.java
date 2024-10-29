package com.vts.pfms.master.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
