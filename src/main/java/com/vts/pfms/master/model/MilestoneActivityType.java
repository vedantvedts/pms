package com.vts.pfms.master.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "milestone_activity_type")
public class MilestoneActivityType {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ActivityTypeId;
	private String ActivityType;
	private String ActivityCode;
	private String IsTimeSheet;
	private String CreatedDate;
	private String CreatedBy;
	private int IsActive;
	
}
