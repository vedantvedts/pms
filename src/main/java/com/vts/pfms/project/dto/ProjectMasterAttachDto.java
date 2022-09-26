package com.vts.pfms.project.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProjectMasterAttachDto {
	
	private Long ProjectAttachId;
	private String ProjectId;
	private String[] Path;
	private String[] FileName;
	private MultipartFile[] files;
	private String[] OriginalFileName;
	private String CreatedBy;
	private String CreatedDate;  

}
