package com.vts.pfms.master.model;



import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;



@Entity
@Table(name="division_group")

public class DivisionGroup {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long GroupId;
	private String GroupCode;
	private String GroupName;
	private Long GroupHeadId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	private String LabCode;
	private String TDId;
	
	
	public String getTDId() {
		return TDId;
	}
	public void setTDId(String tDId) {
		TDId = tDId;
	}
	public String getLabCode() {
		return LabCode;
	}
	public void setLabCode(String labCode) {
		LabCode = labCode;
	}
	public Long getGroupId() {
		return GroupId;
	}
	public void setGroupId(Long groupId) {
		GroupId = groupId;
	}
	public String getGroupCode() {
		return GroupCode;
	}
	public void setGroupCode(String groupCode) {
		GroupCode = groupCode;
	}
	public String getGroupName() {
		return GroupName;
	}
	public void setGroupName(String groupName) {
		GroupName = groupName;
	}
	public Long getGroupHeadId() {
		return GroupHeadId;
	}
	public void setGroupHeadId(Long groupHeadId) {
		GroupHeadId = groupHeadId;
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
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}	
}