package com.vts.pfms.producttree.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
	
	private String IsSoftware;
}
