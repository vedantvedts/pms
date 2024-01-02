package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Table(name = "pfms_rfa_attachment")
@Entity
public class RfaAttachment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RfaAttachmentId;
	private Long RfaId;
	private String FilesPath;
	private String AssignorAttachment;
	private String AssigneeAttachment;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
