package com.vts.pfms.print.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name ="pfms_project_slides")
public class ProjectSlides {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long SlideId;
	private Long ProjectId;
	private String Status;
	private String Brief;
	private String Slide;
	private String Path;
	private String ImageName;
	private String AttachmentName;
	private String VideoName;
	private String WayForward;
	private Long SystemId;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
