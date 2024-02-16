package com.vts.pfms.producttree.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_product_tree_rev")
public class ProductTreeRev {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long RevId;
	private long MainId;
	private long ProjectId;
	private long ParentLevelId;
	private String LevelId;
	private String LevelName;
	private String Stage;
	private String Module;
	private String RevisionNo;
	private String CreatedBy;
	private String CreatedDate;
	private int isActive;
	

}
