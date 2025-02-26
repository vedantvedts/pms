package com.vts.pfms.timesheet.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_timesheet_activity")
public class TimeSheetActivity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "TimeSheetActivityId", length = 20)
	private Long TimeSheetActivityId;
	@Column(name = "ActivityId", length = 20)
	private Long ActivityId;
	// N=New, A=Action
	@Column(name = "ActivityType", length = 1)
	private String ActivityType;
	@Column(name = "ProjectId", length = 20)
	private Long ProjectId;
	@Column(name = "ActivityTypeId", length = 20)
	private Long ActivityTypeId;
	@Column(name = "ActivitySeqNo")
	private String ActivitySeqNo;
	@Column(name = "ActivityFromTime")
	private String ActivityFromTime;
	@Column(name = "ActivityToTime")
	private String ActivityToTime;
	@Column(name = "ActivityDuration", length = 5)
	private String ActivityDuration;
	@Column(name = "Remarks", length = 1000)
	private String Remarks;
	@Column(name = "AssignedBy", length = 20)
	private Long AssignedBy;
	@Column(name = "KeywordId", length = 20)
	private Long KeywordId;
	@Column(name = "WorkDone", length = 255)
	private String WorkDone;
	@Column(name = "WorkDoneon", length = 1)
	private String WorkDoneon;
	@Column(name = "CreatedBy", length = 50)
	private String CreatedBy;
	@Column(name = "CreatedDate")
	private String CreatedDate;
	@Column(name = "IsActive", length = 1)
	private int IsActive;
	
	@ManyToOne
	@JoinColumn(name="TimeSheetId")
	private TimeSheet timeSheet;
	
}
