package com.vts.pfms.fracas.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "pfms_fracas_main")
public class  PfmsFracasMain  {
		
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long FracasMainId;
	private String LabCode;
	private int FracasTypeId;
	private String FracasItem;
	private String FracasDate;
	private long ProjectId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	
}
