package com.vts.pfms.project.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
