package com.vts.pfms.project.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name= "project_master_rev")
public class ProjectMasterRev 
{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ProjectRevId;
	private Long ProjectId;
	private Long RevisionNo;
	private Long ProjectMainId;
	private String ProjectCode;
	private String ProjectImmsCd;
	private String ProjectName;
    private String ProjectDescription;
    private String UnitCode;
    private Long ProjectType;
    private Long ProjectCategory;
    private String SanctionNo;
    private Date SanctionDate;
	private Double TotalSanctionCost;
    private Double SanctionCostRE;
    private Double SanctionCostFE;
	private Date PDC;
	private Long ProjectDirector;
    private String ProjSancAuthority;
    private String BoardReference;
    private int IsMainWC;
    private String WorkCenter;
    private String Scope;
    private String Application;
    private String LabParticipating;
    private String Objective;
    private String Deliverable;
    private String Remarks;
	private String CreatedBy;
    private String CreatedDate;
    private Long PlatformId; //srikant
    private String Platform; //srikant
}
