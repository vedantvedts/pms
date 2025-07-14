package com.vts.pfms.committee.dto;

import lombok.Data;

@Data
public class CommitteeMembersEditDto {
	
	private String chairperson;
	private String co_chairperson;
	private String secretary;
	private String proxysecretary;
	private String sesLabCode;
	private String CpLabCode;
	private String committeemainid;
	private String chairpersonmemid;
	private String secretarymemid;
	private String proxysecretarymemid;
	private String comemberid;
	private String ModifiedBy;
	
	
	private String msLabCode;
	private String CommitteeId;
	
	private Long ProjectId;
	private Long DivisionId;
	private Long InitiationId;
	private Long CARSInitiationId;
	private String ProgrammeId;
	
	private String ReferenceNo;
	private String FormationDate;

}
