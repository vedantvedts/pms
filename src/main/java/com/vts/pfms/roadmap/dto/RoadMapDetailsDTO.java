package com.vts.pfms.roadmap.dto;



import java.util.List;


import lombok.Data;

@Data
public class RoadMapDetailsDTO {

	private String RoadMapId;
	private String RoadMapType;
	private String ProjectId;
	private String InitiationId;
	private String DivisionId;
	private String ProjectTitle;
	private String AimObjectives;
	private String StartDate;
	private String EndDate;
	private String Reference;
	private String Scope;
	private String OtherReference;
	private String ProjectCost;
	
	private String[] AnnualYear;
	private List<String[]> annualTargetList;
	private String[] AnnualTarget;
	
	private String Username;
	private String Action;
	private String EmpId;
	
	private String LabCode;
}
