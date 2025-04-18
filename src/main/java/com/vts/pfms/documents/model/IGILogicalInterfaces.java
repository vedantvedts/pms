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
@Table(name="pfms_igi_logical_interfaces")
public class IGILogicalInterfaces implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long LogicalInterfaceId;
	private String MsgCode;
	private String MsgName;
	private Long LogicalChannelId;
	private String MsgType;
	private String MsgDescription;
	private String DataRate;
	private String Protocals;
	private String AdditionalInfo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
