package com.vts.pfms.projectclosure.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="pfms_closure_technical_chapters")


public class ProjectClosureTechnicalChapters {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ChapterId;
	private long ChapterParentId;
	private long SectionId;
	private String ChapterName;
	private String ChapterContent;
	

}
