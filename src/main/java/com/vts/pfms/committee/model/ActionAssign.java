package com.vts.pfms.committee.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
	private String ActionFlag;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsSeen;
	private int IsActive;

}
