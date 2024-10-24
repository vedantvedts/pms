package com.vts.pfms.ms.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class ProjectMasterDto {
	private Long ProjectId;
	private Long ProjectMainId;
	private String ProjectCode;
	private String ProjectShortName;
	private String ProjectImmsCd;
    private String ProjectName;
    private String ProjectDescription;
    private String UnitCode;
    private Long ProjectType;
    private String SanctionNo;
    private Date SanctionDate;
	private Double TotalSanctionCost;
    private Double SanctionCostRE;
    private Double SanctionCostFE;
	private Date PDC;
	private Long ProjectDirector;
    private Long ProjectCategory;
    private String ProjSancAuthority;
    private String BoardReference;
    private Long RevisionNo;
    private String WorkCenter;
    private String LabParticipating;
    private String Objective;
    private String Deliverable;
    private String Scope;
    private String Application;
    private String EndUser;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
    private int isActive;
    private int IsMainWC;
    private String LabCode;
    private String IsCCS;
}
