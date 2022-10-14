package com.vts.pfms.model;

import javax.persistence.Entity;
import javax.persistence.Table;

import lombok.Data;

@Data
public class IbasLabMaster {

	private int LabMasterId;
	private String LabCode;
	private String LabName;
	private String LabUnitCode;
	private String LabAddress;
	private String LabCity;
	private String LabPin;
}
