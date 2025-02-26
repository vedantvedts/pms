package com.vts.pfms.pfts.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfts_file_ms_rev")
public class PftsFileMilestoneRev {
	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long PftsMileStoneRevId;
	private long PftsMilestoneId;
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
	private String ModifiedBy;
	private String ModifiedDate;
	private int	IsActive;
	
}
