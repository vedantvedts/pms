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
@Table(name = "pfms_minutes_action" )
public class MinutesActionList {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MinutesActionId;
	private Long CommiteeScheduleId;
	private Long SchduleMinutesId;
	private String Details;
	private String Idrck;
	private String ActionNo;
	private String ActionDate;
	private String EndDate;
	private Long Assignor;
	private Long Assignee;
	private String ActionItem;
	private String ActionStatus;
	private String ActionFlag;
	private String AssignorName;
	private String AssignerDesig;
	private String AssigneeName;
	private String AssigneeDesig;
	private String CreatedBy;
	private String CreatedDate;
	
}
