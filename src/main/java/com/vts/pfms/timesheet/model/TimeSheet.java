package com.vts.pfms.timesheet.model;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_timesheet")
public class TimeSheet implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "TimeSheetId", length = 20)
	private Long TimeSheetId;
	@Column(name = "EmpId", length = 20)
	private Long EmpId;
	@Column(name = "InitiationDate")
	private String InitiationDate;
	@Column(name = "ActivityFromDate")
	private String ActivityFromDate;
	@Column(name = "ActivityToDate")
	private String ActivityToDate;
	@Column(name = "PunchInTime")
	private String PunchInTime;
	@Column(name = "PunchOutTime")
	private String PunchOutTime;
	@Column(name = "TotalDuration", length = 5)
	private String TotalDuration;
	@Column(name = "EmpStatus", length = 255)
	private String EmpStatus;
	@Column(name = "TDRemarks", length = 255)
	private String TDRemarks;
	@Column(name = "TimeSheetStatus", length = 3)
	private String TimeSheetStatus;
	@Column(name = "CreatedBy", length = 50)
	private String CreatedBy;
	@Column(name = "CreatedDate")
	private String CreatedDate;
	@Column(name = "ModifiedBy", length = 50)
	private String ModifiedBy;
	@Column(name = "ModifiedDate")
	private String ModifiedDate;
	@Column(name = "IsActive", length = 1)
	private int IsActive;
	
	@OneToMany(mappedBy = "timeSheet", cascade = CascadeType.ALL)
	private List<TimeSheetActivity> timeSheetActivity;
	
	@OneToMany(mappedBy = "timeSheet", cascade = CascadeType.ALL)
	private List<TimeSheetTrans> timeSheetTrans;
	
}
