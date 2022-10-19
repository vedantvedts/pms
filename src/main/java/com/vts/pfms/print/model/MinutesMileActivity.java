package com.vts.pfms.print.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Builder
@AllArgsConstructor
@Entity
@Table(name = "pfms_minutes_mile")
public class MinutesMileActivity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MinutesMileId;
	private Long CommitteeScheduleId;
	private int MilestoneNo;
	private long MainId;
	private long AId;
	private long BId;
	private long CId;
	private long DId;
	private long EId;
	private String StartDate;
	private String EndDate;
	private String MileStoneMain;
	private String MileStoneA;
	private String MileStoneB;
	private String MileStoneC;
	private String MileStoneD;
	private String MileStoneE;
	private String ActivityType;
	private int ProgressStatus;
	private int Weightage;
	private String DateOfCompletion;
	private String Activitystatus;
	private long ActivitystatusId;
	private int RevisionNo;
	private long OicEmpId;
	private String EmpName;
	private String Designation;
	private int LevelId;
	private String ActivityShort;
	private String StatusRemarks;
	private String CreatedBy;
	private String CreatedDate;
}
