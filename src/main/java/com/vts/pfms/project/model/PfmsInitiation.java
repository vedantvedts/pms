package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
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
    
}
