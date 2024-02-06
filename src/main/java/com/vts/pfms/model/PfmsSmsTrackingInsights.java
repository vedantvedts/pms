package com.vts.pfms.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Entity
@Data
@Table(name ="pfms_sms_track_insights")
public class PfmsSmsTrackingInsights {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private long SmsTrackingInsightsId;
	private long SmsTrackingId;
    private long EmpId;
	private String Message;
	private String SmsPurpose;
	private String SmsStatus;
	private long SmsActivityAssigned;
	private long SmsOnGoing;
	private long SmsDelayOnGoing;
	private String SmsSentDate;
	private String CreatedDate;
}
