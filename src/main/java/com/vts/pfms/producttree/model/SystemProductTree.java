package com.vts.pfms.producttree.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_system_product_tree")
public class SystemProductTree {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long MainId;
	private long Sid;
	private long ParentLevelId;
	private String LevelId;
	private String SubLevelId;
	private String LevelName;
	private String Stage;
	private String Module;
	private String RevisionNo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String LevelCode;
	private int isActive;
}
