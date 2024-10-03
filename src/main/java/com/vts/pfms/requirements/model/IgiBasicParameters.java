package com.vts.pfms.requirements.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_igi_parameters")
public class IgiBasicParameters {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ParameterId;
	private String ParameterName;
	private String CreatedBy;
    private String CreatedDate;
	private int IsActive;
	
}
