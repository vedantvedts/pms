package com.vts.pfms.documents.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name="pfms_icd_connector_pin_mapping")
public class ICDConnectorPinMapping implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ConnectorPinMapId;
	private Long ICDConnectionId;
	private Long ConnectorPinIdFrom;
	private Long ConnectorPinIdTo;
	private String PinFunction;
	private String SignalName;
	private Long InterfaceId;
	private String ConnectionCode;
	private Integer CableMaxLength;
	private Integer InterfaceLoss;
	private Double CableBendingRadius;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
