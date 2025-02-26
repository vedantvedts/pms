package com.vts.pfms.cars.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="pfms_cars_other_doc_details")
public class CARSOtherDocDetails implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long OtherDocDetailsId;
	private long CARSInitiationId;
	private String InitiationDate;
	private String OtherDocType;
	private String OtherDocDate;
//	private String OtherDocFileNo;
	private String InvoiceNo;
	private String InvoiceDate;
	private String MilestoneNo;
	private String AttachFlagA;
	private String AttachFlagB;
	private String AttachFlagC;
	private String UploadOtherDoc;
	private long ForwardedBy;
	private String ForwardedDate;
	private String OthersStatusCode;
	private String OthersStatusCodeNext;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
