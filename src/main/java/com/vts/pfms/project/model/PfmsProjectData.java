package com.vts.pfms.project.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@Entity
@Table(name = "pfms_project_data")
public class PfmsProjectData {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private long ProjectDataId;
	private long ProjectId;
	private String FilesPath;
	private String SystemConfigImgName;
	private String SystemSpecsFileName;
	private String ProductTreeImgName;
	private String PEARLImgName;
	private Double procLimit;
	private int CurrentStageId;
	private long RevisionNo;
	private Date LastPmrcDate;
	private Date LastEBDate;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
	
	
	
}
