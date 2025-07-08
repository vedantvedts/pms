package com.vts.pfms.documents.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ICDPinMapDTO {

	private Long ConnectorPinMapId;
	private Long ICDConnectionId;
	private Long ConnectorPinIdFrom;
	private Long ConnectorPinIdTo;
	private String PinFunction;
	private String SignalName;
	private String ConnectionCode;
	private Integer CableMaxLength;
	private Integer InterfaceLoss;
	private Double CableBendingRadius;
	private String Remarks;
	
	private Long PinIdE1;
	private Long ConnectorIdE1;
	private String PinNoE1;
	private Long PinIdE2;
	private Long ConnectorIdE2; 
	private String PinNoE2; 
	
	private Integer ConnectorNoE1; 
	private Integer ConnectorNoE2;
	private Long SubSystemIdE1;
	private Long SubSystemIdE2;
	
	private String LevelNameE1; 
	private String LevelCodeE1; 
	private String LevelNameE2; 
	private String LevelCodeE2;
	
	private Long InterfaceId;
	private String Constraints;
	private String Periodicity;
	private String Description; 
	private String InterfaceName; 
	private String InterfaceCode;
	private String InterfaceType;
	private String InterfaceContent;
}
