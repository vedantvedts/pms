package com.vts.pfms.ms.dto;

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
public class PfmsInitiationDto {
	private Long InitiationId;
	private Long EmpId;
	private String LabCode;
    private Long DivisionId;
    private String ProjectProgramme;
    private Long ProjectTypeId;
	/* private Long CategoryId; */
    private Long ClassificationId;
    private String ProjectShortName;
    private String ProjectTitle;
    private Double ProjectCost;
    private Double FeCost;
    private Double ReCost;
    private int ProjectDuration;
    private String IsPlanned;
    private String IsMultiLab;
    private int LabCount;
    private String Deliverable;
    private String ProjectStatus;
    private String IsMain;
    private Long MainId;
    private Long NodalLab;
    private String Remarks;
    private Long PCDuration;
    private Double IndicativeCost;
    private String PCRemarks;
   // newlyadded//
    private String User;
    ///--------//
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	// newlyadded after 04-06-2024//
	private String StartDate;
}
