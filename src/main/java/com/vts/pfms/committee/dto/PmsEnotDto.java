package com.vts.pfms.committee.dto;

import java.util.Date;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PmsEnotDto {

	private Long EnoteId;
	private String RefNo;
	private Date RefDate;
	private String Subject;
	private String Comment;
	private Long CommitteeMainId;
	private Long ScheduleId;
	private Long Recommend1;
	private String Rec1_Role;
	private Long Recommend2;
	private String Rec2_Role;
	private Long Recommend3;
	private String Rec3_Role;
	private Long ApprovingOfficer;
	private String Approving_Role;
	private String EnoteFrom;
	private String EnoteStatusCode;
	private String EnoteStatusCodeNext;
	private Long InitiatedBy;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
