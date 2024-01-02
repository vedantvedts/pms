package com.vts.pfms.cars.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
	private String PaymentTerms;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

}
