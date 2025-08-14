package com.vts.pfms.milestone.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name="file_rep_upload_preproject")
public class FileRepUploadPreProject {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FileRepUploadId;
	private Long FileRepId;
	private String FileNameUi;
	private String FileName;
	private String FilePath;
	private String FilePass;
	private Long VersionDoc;
	private Long ReleaseDoc;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
}
