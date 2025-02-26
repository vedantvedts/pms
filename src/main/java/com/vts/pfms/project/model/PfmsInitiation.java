package com.vts.pfms.project.model;

import java.io.Serializable;
import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Entity
@Table(name = "pfms_initiation")
public class PfmsInitiation implements Serializable {

	

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
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
