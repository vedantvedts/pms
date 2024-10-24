package com.vts.pfms.ms.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
@Entity
@Table(name="cluster_lab_employee")
public class ClusterLabEmployee {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long LabEmpId;
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
