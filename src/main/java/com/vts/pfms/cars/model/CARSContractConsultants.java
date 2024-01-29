package com.vts.pfms.cars.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="pfms_cars_contract_consultants")
public class CARSContractConsultants implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ConsultantId;
	private long CARSInitiationId;
	private String ConsultantName;
	private String ConsultantCompany;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

}
