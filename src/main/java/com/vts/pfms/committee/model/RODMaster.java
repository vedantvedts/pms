package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
