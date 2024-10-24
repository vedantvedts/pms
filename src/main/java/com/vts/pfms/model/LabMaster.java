package com.vts.pfms.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="lab_master")
public class LabMaster implements Serializable {

	
	private static final long serialVersionUID = 1L;
	@Id
	private int LabMasterId;
	private String LabCode;
	private String LabName;
	private String LabUnitCode;
	private String LabAddress;
	private String LabCity;
	private String LabPin;
	private String LabTelNo;
	private String LabFaxNo;
	private String LabEmail;
	private String LabAuthority;
	private Long LabAuthorityId;
	private String LabRfpEmail;
	private Long LabId;
	private Long ClusterId;
	private String LabURI;
	private byte[] LabLogo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
}
