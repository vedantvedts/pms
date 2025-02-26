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
@Table(name="pfms_cars_initiation")
public class CARSInitiation implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long CARSInitiationId;
	private long EmpId;
	private String CARSNo;
	private String InitiationDate;
	private String InitiationTitle;
	private String InitiationAim;
	private String Justification;
	private String FundsFrom;
	private String Amount;
	private String Duration;
	private String RSPInstitute;
	private String RSPAddress;
	private String RSPCity;
	private String RSPState;
	private String RSPPinCode;
	private String PITitle;
	private String PIName;
	private String PIDesig;
	private String PIDept;
	private String PIMobileNo;
	private String PIEmail;
	private String PIFaxNo;
	private String EquipmentNeed;
	private String InitiationApprDate;
	private String InvForSoODate;
	private String CARSStatusCode;
	private String CARSStatusCodeNext;
	private long DPCSoCForwardedBy;
	private String DPCForwardDate;
	private String DPCSoCStatus;
	private String CurrentStatus;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
