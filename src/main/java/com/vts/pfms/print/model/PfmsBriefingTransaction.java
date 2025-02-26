package com.vts.pfms.print.model;



import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

@Entity
@Table(name = "pfms_briefing_transaction")
public class PfmsBriefingTransaction {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long BriefingTransactionId;
	private Long ScheduleId;
	private Long EmpId;
	private String Remarks;
	private String BriefingStatus;
	private String ActionBy;
	private String ActionDate;
}
