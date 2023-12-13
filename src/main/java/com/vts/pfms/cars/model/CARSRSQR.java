package com.vts.pfms.cars.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name="pfms_cars_rsqr")
public class CARSRSQR implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long CARSRSQRId;
	private long CARSInitiationId;
	private String Introduction;
	private String ResearchOverview;
	private String Objectives;
	private String ProposedMandT;
	private String RSPScope;
	private String LRDEScope;
	private String Criterion;
	private String LiteratureRef;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
