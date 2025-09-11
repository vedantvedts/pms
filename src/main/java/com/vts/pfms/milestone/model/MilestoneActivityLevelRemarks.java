package com.vts.pfms.milestone.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "milestone_activity_level_remarks")
public class MilestoneActivityLevelRemarks {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long remarksId;
	
	private Long activityId;
	
	private Long empid;
	
	private String remarks;
	
	private String createdDate;
	
	private int isactive;
}
