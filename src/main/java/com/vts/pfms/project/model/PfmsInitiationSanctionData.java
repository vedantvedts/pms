package com.vts.pfms.project.model;

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
