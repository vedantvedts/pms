package com.vts.pfms.milestone.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="milestone_activity_predecessor")
public class MilestoneActivityPredecessor {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long Id;

	private Long successorId;
	private Long predecessorId;
	
	private String CreatedBy;
	private String CreatedDate;
	
	
}
