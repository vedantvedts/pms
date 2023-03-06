package com.vts.pfms.committee.model;


import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name="Pfms_Favourite_List")
public class FavouriteList {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FavouriteId;
	private Long EmpId;
	private Long ActionAssignId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
