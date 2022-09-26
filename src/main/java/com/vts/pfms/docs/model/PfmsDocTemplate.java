package com.vts.pfms.docs.model;

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
@Table(name = "pfms_doc_template")
public class PfmsDocTemplate 
{	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long TemplateItemId;
	private int LevelNo;
	private long ParentLevelId;
	private long ProjectId;
	private long FileUploadMasterId;
	private String ItemName;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
}
