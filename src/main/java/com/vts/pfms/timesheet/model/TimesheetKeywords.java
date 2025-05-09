package com.vts.pfms.timesheet.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
	private String CreatedDate;
	private int IsActive;
	
}
