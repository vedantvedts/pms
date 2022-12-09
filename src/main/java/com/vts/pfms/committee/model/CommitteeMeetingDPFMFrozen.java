package com.vts.pfms.committee.model;

import java.io.File;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name= "committee_meeting_dpfm_frozen")
public class CommitteeMeetingDPFMFrozen implements Serializable 
{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FrozenDPFMId;
	private long ScheduleId;
	private long FreezeByEmpId; 
	private String FreezeTime;
	private String FrozenDPFMPath;
	private String DPFMFileName;
	private int IsActive;
	
	@Transient
	private File dpfmfile;
	@Transient
	private String MeetingId;
	@Transient
	private String LabCode;
	
}
