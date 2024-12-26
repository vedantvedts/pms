package com.vts.pfms.documents.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_igi_interfaces")
public class IGIInterface {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InterfaceId;
	private String LabCode;
	private String InterfaceSeqNo;
	private String InterfaceCode;
	private String InterfaceName;
	private String InterfaceType;
	private String DataType;
	private String SignalType;
	private String InterfaceSpeed;
	private String InterfaceDiagram;
	private String Connector;
	private String Protection;
	private String InterfaceDescription;
	private Long IGIDocId;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	
}
