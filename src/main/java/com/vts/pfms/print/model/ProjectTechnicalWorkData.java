package com.vts.pfms.print.model;

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
@Table(name = "project_technical_work_Data" )
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
