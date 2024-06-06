package com.vts.pfms.project.dto;

import lombok.Data;

@Data
public class PfmsInitiationDto {

	private String InitiationId;
	private String EmpId;
	private String LabCode;
    private String DivisionId;
    private String ProjectProgramme;
    private String ProjectTypeId;
    private String ClassificationId;
    private String ProjectShortName;
    private String ProjectTitle;
    private String ProjectCost;
    private String FeCost;
    private String ReCost;
	private String ProjectDuration;
    private String IsPlanned;
    private String IsMultiLab;
    private String LabCount;
    private String DeliverableId;
    private String NodalLab;
    private String Remarks;
    private String IsMain;
    private String MainId;
    private String Duration;
    private String IndicativeCost;
    private String PDD;
    private String PCRemarks;
 // newlyadded after 04-06-2024//
 	private String StartDate;
}
