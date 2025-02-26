package com.vts.pfms.fracas.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
