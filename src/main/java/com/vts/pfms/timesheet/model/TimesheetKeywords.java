package com.vts.pfms.timesheet.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_timesheet_keywords")
public class TimesheetKeywords implements Serializable{


	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long KeywordId;
	private String Keyword;
	private String KeywordShortCode;
	private String CreatedBy;
	private int IsActive;
	
}
