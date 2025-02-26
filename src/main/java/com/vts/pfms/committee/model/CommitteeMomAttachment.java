package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
@Entity

@Table(name="committee_mom_attachment")
public class CommitteeMomAttachment {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	private Long AttachmentId;
	private Long ScheduleId;
	
	private String FilePath;
	private String AttachmentName;
	
	private String CreatedBy;
	private String CreatedDate;
	
	private int IsActive;
	
	
	@Transient
	private MultipartFile file;
}
