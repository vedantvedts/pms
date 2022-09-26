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
@Table(name = "pfms_doc_content_freeze")
public class PfmsDocContentFreeze {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long TempContentFrzId;
	private long TemplateItemId;
	private long TempContentId;
	private int LevelNo;
	private long ParentLevelId;
	private long PfmsDocId;
	private String ItemName;
	private String ItemContent;
	private int VersionNo;
	private String RevisionDate;
	private String IsDependent;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
}
