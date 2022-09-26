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
@Table(name = "pfms_minutes_lastpmrc" )
public class MinutesLastPmrc {
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Long MinutesLastPmrcId;
		private Long CommiteeScheduleId;
		private String ActionMainId;
		private Long MinutesId;
		private String Details;
		private String Idrck;
		private String ActionNo;
		private String EndDate;
		private Long Assignee;
		private String ActionStatus;
		private String ActionFlag;
		private String AssigneeName;
		private String AssigneeDesig;
		private int Progress;
		private String LastDate;
		private String Type;
		private int Revision;
		private String PdcOrg;
		private String PDC1;
		private String PDC2;
		private String CreatedBy;
		private String CreatedDate;
}
