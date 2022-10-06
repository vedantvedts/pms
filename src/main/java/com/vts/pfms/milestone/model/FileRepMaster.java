package com.vts.pfms.milestone.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="file_rep_master")
public class FileRepMaster {			
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long FileRepMasterId;
    private String LabCode;
    private Long ProjectId;
    private Long ParentLevelId;
	private Long LevelId;
	private String LevelName;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

				
}
