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
@Table(name = "pfms_initiation_file_upload")
public class PreprojectFile {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	private Long DocId;
	private Long InitiationId ;
	private Long stepId;
	private String FileName;
	private String DocumentName;
	private Long DocumentId;
	private String FilePath;
	private Double VersionDoc;
	private String Description;
	private String CreatedBy;
    private String CreatedDate;
	private int IsActive;
	
	
}
