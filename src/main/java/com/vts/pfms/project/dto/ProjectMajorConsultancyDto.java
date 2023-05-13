package com.vts.pfms.project.dto;

import lombok.Data;
@Data
public class ProjectMajorConsultancyDto {

	private Long ConsultancyId;
	private Long InitiationId;
	private String Discipline;
	private String Agency;
	private String Person;
	private Double Cost;
	private  String Process;
}
