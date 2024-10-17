package com.vts.pfms.pfts.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfts_file_ms")
public class PftsFileMilestone {
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long PftsMilestoneId;
	private long PftsFileId;
	private String EPCDate;
	private String TocDate;
	private String OrderDate;
	private String PDRDate;
	private String CriticalDate;
	private String DDRDate;
	private String CDRDate;
	private String AcceptanceDate;
	private String FATDate;
	private String DeliveryDate;
	private String SATDate;
	private String IntegrationDate;
	private long Revision;
	private String SetBaseline;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int	IsActive;
	
}
