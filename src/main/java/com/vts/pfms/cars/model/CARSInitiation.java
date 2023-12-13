package com.vts.pfms.cars.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
	private String Duration;
	private String RSPAddress;
	private String RSPCity;
	private String RSPState;
	private String RSPPinCode;
	private String PIName;
	private String PITitle;
	private String PIDept;
	private String PIMobileNo;
	private String PIEmail;
	private String InitiationApprDate;
	private String CARSStatusCode;
	private String CARSStatusCodeNext;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
