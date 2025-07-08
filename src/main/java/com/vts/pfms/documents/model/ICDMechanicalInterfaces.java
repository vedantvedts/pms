package com.vts.pfms.documents.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_icd_mech_interfaces")
public class ICDMechanicalInterfaces  implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MechInterfaceId;
	private Long ICDDocId;
	private Long SubSystemMainIdOne;
	private Long SubSystemMainIdTwo;
	private String InterfaceCode;
	private String InterfaceName;
	private String InterfaceSeqId;
	private String partOne;
	private String partTwo;
	private String DrawingOne;
	private String DrawingTwo;
	private String Description;
	private String Standards;
	private String Precautions;
	private String Instructions;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private Integer IsActive;
}
