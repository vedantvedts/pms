package com.vts.pfms.requirements.model;

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
@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name="pfms_specification_intro")
public class SpecificationIntro {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long IntroductionId;
	private String IntroName;
	private String IntroContent;
	private Long SpecsInitiationId;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
}
