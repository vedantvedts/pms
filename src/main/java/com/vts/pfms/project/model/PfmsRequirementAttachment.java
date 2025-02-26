package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "pfms_initiation_req_attach")
public class PfmsRequirementAttachment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long AttachmentId;
	private Long InitiationReqId;
	private String Filespath;
	private String AttachmentsName;
	
	
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;

	
}
