package com.vts.pfms.project.dto;
import lombok.Data;
@Data
public class ProjectMajorWorkPackagesDto {

	private Long WorkId;
	private Long InitiationId;
	private String GovtAgencies;
	private String WorkPackage;
	private String Objective;
	private String Scope;
	private int PDC;
	private double cost;
}
