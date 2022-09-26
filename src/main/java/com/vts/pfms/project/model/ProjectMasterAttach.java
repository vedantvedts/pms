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
@Table(name = "project_master_attach")
public class ProjectMasterAttach {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ProjectAttachId;
	private Long ProjectId;
	private String Path;
	private String FileName;
	private String OriginalFileName;
	private String CreatedBy;
	private String CreatedDate;  
	
}
