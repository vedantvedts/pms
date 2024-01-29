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
@Table(name="pfms_cars_contract")
public class CARSContract implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long CARSContractId;
	private long CARSInitiationId;
	private String ContractNo;
	private String ContractDate;
	private String T0Date;
	private String T0Remarks;
	private String RSPOfferRef;
	private String RSPOfferDate;
	private String KP1Details;
	private String KP2Details;
	private String ExpndPersonnelCost;
	private String ExpndEquipmentCost;
	private String ExpndOthersCost;
	private String ExpndGST;
	private String ExpndTotalCost;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
