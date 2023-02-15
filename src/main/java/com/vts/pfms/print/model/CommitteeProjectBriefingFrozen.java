package com.vts.pfms.print.model;

import java.io.File;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name= "committee_project_briefing_frozen")
public class CommitteeProjectBriefingFrozen implements Serializable 
{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FrozenBriefingId;
	private long ScheduleId;
	private long FreezeByEmpId; 
	private String FreezeTime;
	private String FrozenBriefingPath;
	private String BriefingFileName;
	private int IsActive;
	
	@Transient
	private File BriefingFile;
	@Transient
	private String MeetingId;
	@Transient
	private String LabCode;
	@Transient
	private MultipartFile BriefingFileMultipart;
	
}
