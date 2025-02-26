package com.vts.pfms.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Entity
@Data
@Table(name = "pfms_sms_track")
public class PfmsSmsTracking {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private long SmsTrackingId;
	private String SmsTrackingType;
	private long SmsExpectedCount;
	private long SmsSentCount;
	private String SmsSentStatus;
	private String CreatedDate;
	private String CreatedTime;
	private String SmsSentDateTime;
}
