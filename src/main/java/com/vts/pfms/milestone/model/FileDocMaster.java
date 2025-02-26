package com.vts.pfms.milestone.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "file_doc_master" )
public class FileDocMaster {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long FileUploadMasterId;
	private String LabCode;
	private int ParentLevelId;
	private int LevelId;
	private String LevelName;
	private String DocShortName;
	private Long DocId;
	private String CreatedDate;
	private String CreatedBy; 
	private int IsActive;
	
}
