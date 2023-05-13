package com.vts.pfms.project.dto;

import lombok.Data;

@Data
public class ProjectMajorCarsDto {
	
	private Long CarsId;
	private Long InitiationId;
	private String Institute;
	private String professor;
	private String AreaRD;
	private double Cost;
	private int PDC;
	private int Confidencelevel;
	
}
