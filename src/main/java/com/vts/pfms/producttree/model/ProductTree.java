package com.vts.pfms.producttree.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;



import lombok.Data;

@Data
@Entity
@Table(name="pfms_product_tree")
public class ProductTree {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long MainId;
	private long ProjectId;
	private long ParentLevelId;
	private String LevelId;
	private String LevelName;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int isActive;
}
