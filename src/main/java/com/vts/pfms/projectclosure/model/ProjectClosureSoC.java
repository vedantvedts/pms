package com.vts.pfms.projectclosure.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="pfms_closure_soc")
public class ProjectClosureSoC implements Serializable{
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ClosureSoCId;
	private long ClosureId;
//	private String ClosureCategory;
	private String QRNo;
//	private String ExpndAsOn;
//	private String TotalExpnd;
//	private String TotalExpndFE;
	private String PresentStatus;
	private String Reason;
	private String Recommendation;
	private String MonitoringCommittee;
	private String MonitoringCommitteeAttach;
	private String DMCDirection;
	private String LessonsLearnt;
	private String OtherRelevant;
//	private String ClosureStatus;
//	private String ClosureStatusCode;
//	private String ClosureStatusCodeNext;
//	private String ForwardedBy;
//	private String ForwardedDate;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
