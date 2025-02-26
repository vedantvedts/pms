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
@Table(name="pfms_icd_document_connections")
public class ICDDocumentConnections implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ICDConnectionId;
	private Long ICDDocId;
	private Long SubSystemMainIdOne;
	private Long SubSystemMainIdTwo;
	private String SubSystemOne;
	private String SubSystemTwo;
	private Long SuperSubSysMainIdOne;
	private Long SuperSubSysMainIdTwo;
	private String SuperSubSystemOne;
	private String SuperSubSystemTwo;
	//private Long InterfaceId;
	//private String Purpose;
	private String Constraints;
	private String Periodicity;
	private String Description;
	private String DrawingNo;
	private String DrawingAttach;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
