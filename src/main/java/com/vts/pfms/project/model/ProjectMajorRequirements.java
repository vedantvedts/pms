package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.Setter;

@Data
@Entity
@Table(name = "project_major_training_requirements")
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
