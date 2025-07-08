package com.vts.pfms.milestone.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name="file_rep_new")
@Data
public class FileRepNew {			
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long FileRepId;
    private Long ProjectId;
	private Long FileRepMasterId;
	private Long VersionDoc;
	private Long ReleaseDoc;
	private Long DocumentId;
	private Long SubL1;
	private String DocumentName;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	
	
}
