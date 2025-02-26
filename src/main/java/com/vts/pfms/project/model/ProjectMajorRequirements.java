package com.vts.pfms.project.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;
import lombok.Setter;

@Data
@Entity
@Table(name = "pfms_initiation_soc_training")
public class ProjectMajorRequirements implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long TrainingId;
	private Long InitiationId;
	private String Discipline;
	private String Agency;
	private Long Personneltrained;
	private int Duration;
	private Double Cost;
	private String Remarks;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
}
