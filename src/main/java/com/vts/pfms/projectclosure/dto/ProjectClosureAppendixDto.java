package com.vts.pfms.projectclosure.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data

public class ProjectClosureAppendixDto {
	
	private long ChapterId;
	private String UserId;
	private String[] Appendix;
	private String[] DocumentName;
	private String[] AttatchmentName;
	private MultipartFile[] Attachment;

}
