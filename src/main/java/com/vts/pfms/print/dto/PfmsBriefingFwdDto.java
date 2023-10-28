package com.vts.pfms.print.dto;

import com.vts.pfms.print.model.PfmsBriefingTransaction;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class PfmsBriefingFwdDto {
	
	 PfmsBriefingTransaction briefingTranc;
	 private String briefingStatus;
	 private String empId;
	 private String projectId;
	 private String scheduleId;
	 private String userId;
	 private String dhId;
	 private String ghId;
	 private String doId;
	 private String directorId;
	 private String meetingID;
	 private String committeecode;

}
