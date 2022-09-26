package com.vts.pfms.print.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Entity
@Table(name = "pfms_minutes_submile")
public class MinutesSubMile {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MinutesSubMileId;
	private Long CommitteeScheduleId;
	private Long ActivityId;
	private Long ParentActivityId;
	private String ActivityName;
	private String OrgEndDate;
	private String EndDate;
	private int Progress;
	private String MilestoneNo;
	private String StatusRemarks;
	private String ActivityShort;
	private Long ActivityStatusId;
	private String CreatedBy;
	private String CreatedDate;
}