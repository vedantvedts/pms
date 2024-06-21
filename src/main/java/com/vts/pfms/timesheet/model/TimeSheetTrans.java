package com.vts.pfms.timesheet.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name="pfms_timesheet_trans")
public class TimeSheetTrans {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long TimeSheetTransId;
	private String TimeSheetStatusCode;
	private String Remarks;
	private String ActionBy;
	private String ActionDate;
	
	@ManyToOne
	@JoinColumn(name="TimeSheetId")
	private TimeSheet timeSheet;
}
