package com.vts.pfms.report.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

@Entity
@Table(name="pfms_labreport")
public class LabReport {
	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
    private long LabReportId;
	
	private Long ProjectId;
	private String SpinOffData;
	private String DetailsofNomination;
	private String CurrentYrAchievement;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String Introduction;

}
