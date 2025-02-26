package com.vts.pfms.cars.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="pfms_cars_soc_ms_progress")
public class CARSSoCMilestonesProgress implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CARSMSProgressId;
	private Long CARSSoCMilestoneId;
	private int Progress;
	private String ProgressDate;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
}
