package com.vts.pfms.cars.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="pfms_cars_rsqr_deliverables")
public class CARSRSQRDeliverables implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long DeliverablesId;
	private long CARSInitiationId;
	private String Description;
	private String DeliverableType;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

}
