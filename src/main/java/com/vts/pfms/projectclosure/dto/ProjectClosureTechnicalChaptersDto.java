package com.vts.pfms.projectclosure.dto;



import lombok.Data;


@Data
public class ProjectClosureTechnicalChaptersDto {
	
	private long ChapterId;
	private String[] ChapterParentId;
	private String[] SectionId;
	private String[] ChapterName;
	private String ChapterContent;
	private String Userid;

}
