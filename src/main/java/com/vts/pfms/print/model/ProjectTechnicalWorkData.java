package com.vts.pfms.print.model;

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
@Table(name = "project_technical_work_data" )
public class ProjectTechnicalWorkData {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long TechDataId;
	private Long ProjectId;
	private String RelatedPoints;
	private Long AttachmentId;
	private Integer IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	 
}
