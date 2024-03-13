package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name="pfms_rod_master")
public class RODMaster {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RODNameId;
	private String RODName;
	private String RODShortName;
	
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
}
