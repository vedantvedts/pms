package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

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
