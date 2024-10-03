package com.vts.pfms.requirements.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_igi_intefactes")
public class IGIInterface {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InterfaceId;
	private String InterfaceCode;
	private String InterfaceName;
	private String LabCode;
	private String InterfaceDescription;
	private Long ParentId;
	private Long DocIgiId;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	
}
