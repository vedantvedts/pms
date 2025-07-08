package com.vts.pfms.documents.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_igi_interfaces")
public class IGIInterface implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InterfaceId;
	private String LabCode;
	//private String InterfaceSeqNo;
	private Long ParentId;
	private String InterfaceCode;
	private String InterfaceName;
	@Transient
	private String InterfaceType;
	private Long InterfaceTypeId;
	private String ParameterData;
	@Transient
	private String InterfaceContent;
	private Long InterfaceContentId;
	private String InterfaceSpeed;
	private String InterfaceDiagram;
	private String InterfaceDescription;
	private Long ConnectorIdEOne;
	private Long ConnectorIdETwo;
	private String CableInfo;
	private String CableConstraint;
	private String CableDiameter;
	private String CableDetails;
	private Integer CableMaxLength;
	private Integer InterfaceLoss;
	private Double CableBendingRadius;
	private Long IGIDocId;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	
}
