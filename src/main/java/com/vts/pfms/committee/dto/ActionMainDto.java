package com.vts.pfms.committee.dto;

import jakarta.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ActionMainDto {
	private String ActionMainId;
	private String ActionParentId;
	private String MainId;
	private Long ActionLevel;
	private String ActionLinkId;
	private String ActionDate;
	private String StartDate;
	private String ActionItem;
	private String ProjectId;
	private String ScheduleMinutesId;
	private String Priority;
	private String Category;
	private String Type;
	private String ActionType;
	private String ActivityId;
	private String ActionStatus;
	
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String MeetingDate;
	private String ScheduleId;
	private String LabName;
	private String PDCDate;
	
	private String CARSSoCMilestoneId;

	
	
	private MultipartFile actionAttachment;
}
