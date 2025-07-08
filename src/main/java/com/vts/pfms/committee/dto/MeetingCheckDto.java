package com.vts.pfms.committee.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MeetingCheckDto {

	private Long ScheduleId;
	private String MeetingId;
	private String MeetingVenue;
	private Long empid;
	private String empname;
	private String labcode;
	private String ScheduleStartTime;
	private String description;
}
