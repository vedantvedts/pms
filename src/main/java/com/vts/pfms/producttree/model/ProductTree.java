package com.vts.pfms.producttree.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;



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
	private long SystemMainId;
	private String LevelCode;
	private String SubLevelId;
	private String LevelName;
	private String Stage;
	private String Module;
	private String RevisionNo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int isActive;
	private Long InitiationId;
}
