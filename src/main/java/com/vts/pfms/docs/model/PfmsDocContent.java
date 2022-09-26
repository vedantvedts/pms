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
@Table(name = "pfms_doc_content")
public class PfmsDocContent {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long TempContentId;
	private long PfmsDocId;
	private long TemplateItemId;
	private String ItemContent;
	private String IsDependent;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
}
