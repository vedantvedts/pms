package com.vts.pfms.project.model;

import java.io.Serializable;
import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "project_main")
public class ProjectMain implements Serializable{


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ProjectMainId;
	private Long ProjectTypeId;
	private Long CategoryId;
	private String ProjectCode;
    private String ProjectName;
    private String ProjectDescription;
    private String ProjectShortName;
    private String UnitCode;
    private String SanctionNo;
    private Date SanctionDate;
    private Double TotalSanctionCost;
    private Double SanctionCostRE;
    private Double SanctionCostFE;
	private Date PDC;
    private Long ProjectDirector;
    private String ProjSancAuthority;
    private String BoardReference;
    private Long RevisionNo;
    private String WorkCenter;
    private String EndUser;
    private String Objective;
    private String Deliverable;
    private String LabParticipating;
    private String Application;
    private String Scope;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
    private int isActive;
    private int IsMainWC;
    private Long PlatformId; //srikant
}
