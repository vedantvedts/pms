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
	private String PinFunction;
	private String SignalName;
	private String ConnectionCode;
	private Integer CableMaxLength;
	private Integer InterfaceLoss;
	private Double CableBendingRadius;
	private String Remarks;
	
	private String ConPinMappedIdE1s;
	private String PinIdE1s;
	private String ConnectorIdE1s;
	private String PinNoE1s;
	private String ConPinMappedIdE2s;
	private String PinIdE2s;
	private String ConnectorIdE2s; 
	private String PinNoE2s; 
	
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
