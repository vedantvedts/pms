package com.vts.pfms.committee.dto;

public class CommitteeMembersDto {

	
	private String CommitteeMainId;
	private String InternalMembers[];
	private String InternalLabId;	
	private String ExternalMember[];
	private String LabId;	
	private String ExpertMember[];
	private String CreatedBy;
	
	
	public String getCommitteeMainId() {
		return CommitteeMainId;
	}
	public void setCommitteeMainId(String committeeMainId) {
		CommitteeMainId = committeeMainId;
	}
	public String[] getInternalMembers() {
		return InternalMembers;
	}
	public void setInternalMembers(String[] internalMembers) {
		InternalMembers = internalMembers;
	}
	public String getInternalLabId() {
		return InternalLabId;
	}
	public void setInternalLabId(String internalLabId) {
		InternalLabId = internalLabId;
	}
	public String[] getExternalMember() {
		return ExternalMember;
	}
	public void setExternalMember(String[] externalMember) {
		ExternalMember = externalMember;
	}
	public String getLabId() {
		return LabId;
	}
	public void setLabId(String labId) {
		LabId = labId;
	}
	public String[] getExpertMember() {
		return ExpertMember;
	}
	public void setExpertMember(String[] expertMember) {
		ExpertMember = expertMember;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	
	
	
}
