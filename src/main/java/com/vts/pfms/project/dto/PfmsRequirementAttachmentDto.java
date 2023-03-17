package com.vts.pfms.project.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PfmsRequirementAttachmentDto {
	
		private Long AttachmentId;
		private Long InitiationReqId;
		private String Filespath;
		private String AttachmentsName;
		private MultipartFile[] Attachments;
		
}
