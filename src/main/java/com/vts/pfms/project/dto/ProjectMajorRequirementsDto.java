package com.vts.pfms.project.dto;
import lombok.Data;
@Data
public class ProjectMajorRequirementsDto {
		private Long TrainingId;
		private Long InitiationId;
		private String Discipline;
		private String Agency;
		private Long Personneltrained;
		private int Duration;
		private Double Cost;
		private String Remarks;
		
}
