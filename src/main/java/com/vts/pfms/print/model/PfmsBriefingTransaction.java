package com.vts.pfms.print.model;



import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
