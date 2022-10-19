package com.vts.pfms.committee.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="action_assign")
public class ActionAssign {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ActionAssignId;
	private Long ActionMainId;
	private String ActionNo;
	private Date EndDate;
	private Date PDCOrg;
	private Date PDC1;
	private Date PDC2;
	private int Revision;
	private String AssignorLabCode;
	private Long Assignor;
	private String AssigneeLabCode;
	private Long Assignee;
	private String Remarks;
	private String ActionStatus;
	private String ActionFlag;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsSeen;
	private int IsActive;

	
	public Long getActionAssignId() {
		return ActionAssignId;
	}
	public void setActionAssignId(Long actionAssignId) {
		ActionAssignId = actionAssignId;
	}
	
	
	public Long getActionMainId() {
		return ActionMainId;
	}
	public void setActionMainId(Long actionMainId) {
		ActionMainId = actionMainId;
	}
	public String getActionNo() {
		return ActionNo;
	}
	public void setActionNo(String actionNo) {
		ActionNo = actionNo;
	}
	public Date getEndDate() {
		return EndDate;
	}
	public void setEndDate(Date endDate) {
		EndDate = endDate;
	}
	public Date getPDCOrg() {
		return PDCOrg;
	}
	public void setPDCOrg(Date pDCOrg) {
		PDCOrg = pDCOrg;
	}
	public Date getPDC1() {
		return PDC1;
	}
	public void setPDC1(Date pDC1) {
		PDC1 = pDC1;
	}
	public Date getPDC2() {
		return PDC2;
	}
	public void setPDC2(Date pDC2) {
		PDC2 = pDC2;
	}
	public int getRevision() {
		return Revision;
	}
	public void setRevision(int revision) {
		Revision = revision;
	}
	public String getAssignorLabCode() {
		return AssignorLabCode;
	}
	public void setAssignorLabCode(String assignorLabCode) {
		AssignorLabCode = assignorLabCode;
	}
	public Long getAssignor() {
		return Assignor;
	}
	public void setAssignor(Long assignor) {
		Assignor = assignor;
	}
	public String getAssigneeLabCode() {
		return AssigneeLabCode;
	}
	public void setAssigneeLabCode(String assigneeLabCode) {
		AssigneeLabCode = assigneeLabCode;
	}
	public Long getAssignee() {
		return Assignee;
	}
	public void setAssignee(Long assignee) {
		Assignee = assignee;
	}
	public String getRemarks() {
		return Remarks;
	}
	public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	public String getActionStatus() {
		return ActionStatus;
	}
	public void setActionStatus(String actionStatus) {
		ActionStatus = actionStatus;
	}
	public String getActionFlag() {
		return ActionFlag;
	}
	public void setActionFlag(String actionFlag) {
		ActionFlag = actionFlag;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public String getCreatedDate() {
		return CreatedDate;
	}
	public void setCreatedDate(String createdDate) {
		CreatedDate = createdDate;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public String getModifiedDate() {
		return ModifiedDate;
	}
	public void setModifiedDate(String modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	public int getIsSeen() {
		return IsSeen;
	}
	public void setIsSeen(int isSeen) {
		IsSeen = isSeen;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
}
