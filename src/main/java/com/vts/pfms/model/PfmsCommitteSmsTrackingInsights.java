package com.vts.pfms.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Entity
@Table(name = "pfms_sms_committe_track_insights")
public class PfmsCommitteSmsTrackingInsights {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private long CommitteSmsTrackingInsightsId;
	private long CommitteSmsTrackingId;
    private long EmpId;
	private String Message;
	private String SmsPurpose;
	private String SmsStatus;
	private String SmsSentDate;
	private String CreatedDate;
	
}
