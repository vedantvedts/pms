package com.vts.pfms.project.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "pfms_initiation_req")
public class PfmsInititationRequirement implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InitiationReqId;
//	private Long InitiationId;
	private String RequirementId;
	private Long ReqTypeId;
	private String RequirementBrief;
	private String RequirementDesc;
	private int ReqCount;
	private String priority;
	private String LinkedRequirements;
	private String NeedType;
	private String Remarks;
	private String LinkedDocuments;
	private String Category;
	private String Constraints;
	private String LinkedPara;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
//	private Long ProjectId;
	private Long ReqMainId;
	private Long ParentId;
	private String Demonstration;
	private String Test;
	private String Analysis;
	private String Inspection;
	private String SpecialMethods;
	private String Criticality;
	private Long ReqInitiationId;
	private String TestStage;
	
	private String LinkedSubSystem;
	private String Derivedtype;
}
