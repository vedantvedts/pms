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
@Table(name = "pfms_minutes_mile")
public class MinutesMileActivity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MinutesMileId;
	private Long CommitteeScheduleId;
	private Long MilestoneActivityId;
	private Long ParentActivityId;
	private String ActivityName;
	private String OrgStartDate;
	private String OrgEndDate;
	private String StartDate;
	private String EndDate;
	private int Progress;
	private String OIC1;
	private String MilestoneNo;
	private String ActivityStatus;
	private String ActivityShort;
	private Long ActivityStatusId;
	private String Level;
	private String CreatedBy;
	private String CreatedDate;
}
