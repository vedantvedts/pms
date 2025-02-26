package com.vts.pfms.cars.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_cars_soc_milestones")
public class CARSSoCMilestones implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long CARSSoCMilestoneId;
	private long CARSInitiationId;
	private String MilestoneNo;
	private String TaskDesc;
	private String Months;
	private String Deliverables;
	private String PaymentPercentage;
	private String PaymentTerms;
	private String ActualAmount;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

}
