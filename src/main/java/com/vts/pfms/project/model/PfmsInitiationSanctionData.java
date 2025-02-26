package com.vts.pfms.project.model;

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
@Table(name= "pfms_initiation_statement_data")
public class PfmsInitiationSanctionData {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY )
	private long StatementDataId;
	private long StatementId;
	private long InitiationId;
	private int IsChecked;
	private String TDN;
	private String PGNAJ;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String modifiedDate;

}
