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
@Table( name="pfms_cars_annual_report" )
public class CARSAnnualReport implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CARSAnnualReportId;
	private Long CARSInitiationId;
	private int AnnualYear;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
}
