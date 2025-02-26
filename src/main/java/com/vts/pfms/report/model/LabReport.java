package com.vts.pfms.report.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
