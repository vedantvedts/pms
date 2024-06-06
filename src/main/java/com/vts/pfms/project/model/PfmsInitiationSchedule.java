package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.ToString;

@ToString
@Data
@Entity
@Table(name = "pfms_initiation_schedule")
public class PfmsInitiationSchedule implements Serializable {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InitiationScheduleId;
    private Long InitiationId;
    private int MilestoneNo;
    private String MilestoneActivity;
    private int MilestoneMonth;
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	private String MilestoneRemark;
	
	private int Milestonestartedfrom;
	// private int MonthExtendedBy;
	private int MilestoneTotalMonth;

	private String StartDate;
	private String EndDate;

    
	
}
