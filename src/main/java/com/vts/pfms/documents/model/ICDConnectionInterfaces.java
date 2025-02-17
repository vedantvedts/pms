package com.vts.pfms.documents.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_icd_connection_interfaces")
public class ICDConnectionInterfaces implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ConInterfaceId;
	private Long ICDConnectionId;
	private Long InterfaceId;
	private String ConnectionCode;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	
}
