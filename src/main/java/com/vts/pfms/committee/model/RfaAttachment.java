package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
	private String CloseAttachment;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;

}
