package com.vts.pfms.admin.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_statistics")
public class PfmsStatistics {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long Id;
	private Long EmpId;
	private String UserName;
	private Long ActionCount;
	private Long MilestoneCount;
	private Long MeetingScheduled;
	private Date LogDate;
	private Long ActionAssignedCount;
	private Long LogInCount;
}
