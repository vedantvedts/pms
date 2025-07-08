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
@Table(name="pfms_icd_connection_systems")
public class ICDConnectionSystems implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ConSystemsId;
	private Long ICDConnectionId;
	private String SubSystemType;
	private Long SubSystemId;
	private String CreatedBy;
	private String CreatedDate;
	private Integer IsActive;

}
