package com.vts.pfms.committee.model;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name="action_main")
public class ActionMain {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ActionMainId;
	private Long ParentActionId;
	private Long MainId;
	private Long ActionLevel;
	private Date ActionDate;
	private String ActionItem;
	private Long ProjectId;
	private Long ScheduleMinutesId;
	private String Type;
	private String Priority;
	private String Category;
	private String ActionType;
	private Long ActivityId;
	private Long ActionLinkId;
	private String Remarks;
	//private String ActionStatus;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	private Long CARSSoCMilestoneId;

}
