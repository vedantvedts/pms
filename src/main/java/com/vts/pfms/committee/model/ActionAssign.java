package com.vts.pfms.committee.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name="action_assign")
public class ActionAssign {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ActionAssignId;
	private Long ActionMainId;
	private String ActionNo;
	private Date EndDate;
	private Date PDCOrg;
	private Date PDC1;
	private Date PDC2;
	private int Revision;
	private String AssignorLabCode;
	private Long Assignor;
	private String AssigneeLabCode;
	private Long Assignee;
	private String Remarks;
	private String ActionStatus;
//	private String ActionFlag;
	private int Progress;
	private String ProgressDate;
	private String ProgressRemark;
	private String ClosedDate;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsSeen;
	private int IsActive;

}
