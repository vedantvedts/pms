package com.vts.pfms.download.controller;

import jakarta.annotation.Generated;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name="pfms_doc_template_attributes")
public class TemplateAttributes {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long AttributId;
	
	private int HeaderFontSize;
	
	private String HeaderFontWeight;
	
	private int SubHeaderFontsize;
	
	private String  SubHeaderFontweight;
	
	private int ParaFontSize;
	
	private String ParaFontWeight;
	
	private int MainTableWidth;
	
	private int subTableWidth;
	private int  SuperHeaderFontsize;
	private String SuperHeaderFontWeight;
	private String FontFamily;
	private String RestrictionOnUse;
	private String CreatedBy;
	
	private String CreatedDate;
	
	private String ModifiedBy;
	
	private String ModifiedDate;
	private int IsActive;
}