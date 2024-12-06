package com.vts.pfms.master.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "milestone_activity_type")
public class MilestoneActivityType {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ActivityTypeId;
	private String ActivityType;
	private String IsTimeSheet;
	private String CreatedDate;
	private String CreatedBy;
	private int IsActive;
	
}
