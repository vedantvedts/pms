package com.vts.pfms.download.controller;

import javax.annotation.Generated;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name="pfms_doc_template_attributes")
public class TemplateAttributes {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long AttributId;
	
	private int HeaderFontSize;
	
	private int HeaderFontWeight;
	
	private int SubHeaderFontsize;
	
	private int SubHeaderFontweight;
	
	private int ParaFontSize;
	
	private int ParaFontWeight;
	
	private int MainTableWidth;
	
	private int subTableWidth;
	
	private String CreatedBy;
	
	private String CreatedDate;
	
	private String ModifiedBy;
	
	private String ModifiedDate;
	
}