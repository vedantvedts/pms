package com.vts.pfms.pfts.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfts_file_ms_rev")
public class PftsFileMilestoneRev {
	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long PftsMileStoneRevId;
	private long PftsMilestoneId;
	private String ProbableDate;
	private long Revision;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int	IsActive;
	
}
