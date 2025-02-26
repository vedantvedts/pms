package com.vts.pfms.pfts.model;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="pfts_demandimms")
public class PftsDemandImms {	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
    private int DemandId;
	private String DemandNo;
	private String FileNo;
	private String DemandMode;
	private String FundCd;
	private String BudHead;
	private String BudCatCd;
	private String DemandCat;
	private String DemandDate;
	private String ProjectCode;
	private String ItemFor;
	private Double EstimatedCost;
	private String FbeItemSlNo;
	private String Comments;
	private char DemandFlag;
	private Date CancelDate;
	private String CreatedBy;
	private Date CreatedDate;
	private String ModifiedBy;
	private Date ModifiedDate;
	private String DivisionCode;
	private String EmployeeNo;
	private String DemandingOfficer;
	private int IsActive;
	
	public int getDemandId() {
		return DemandId;
	}
	public void setDemandId(int demandId) {
		DemandId = demandId;
	}
	public String getDemandNo() {
		return DemandNo;
	}
	public void setDemandNo(String demandNo) {
		DemandNo = demandNo;
	}
	public String getFileNo() {
		return FileNo;
	}
	public void setFileNo(String fileNo) {
		FileNo = fileNo;
	}
	public String getDemandMode() {
		return DemandMode;
	}
	public void setDemandMode(String demandMode) {
		DemandMode = demandMode;
	}
	public String getFundCd() {
		return FundCd;
	}
	public void setFundCd(String fundCd) {
		FundCd = fundCd;
	}
	public String getBudHead() {
		return BudHead;
	}
	public void setBudHead(String budHead) {
		BudHead = budHead;
	}
	public String getBudCatCd() {
		return BudCatCd;
	}
	public void setBudCatCd(String budCatCd) {
		BudCatCd = budCatCd;
	}
	public String getDemandCat() {
		return DemandCat;
	}
	public void setDemandCat(String demandCat) {
		DemandCat = demandCat;
	}
	public String getDemandDate() {
		return DemandDate;
	}
	public void setDemandDate(String demandDate) {
		DemandDate = demandDate;
	}
	public String getProjectCode() {
		return ProjectCode;
	}
	public void setProjectCode(String projectCode) {
		ProjectCode = projectCode;
	}
	public String getItemFor() {
		return ItemFor;
	}
	public void setItemFor(String itemFor) {
		ItemFor = itemFor;
	}
	public Double getEstimatedCost() {
		return EstimatedCost;
	}
	public void setEstimatedCost(Double estimatedCost) {
		EstimatedCost = estimatedCost;
	}
	public String getFbeItemSlNo() {
		return FbeItemSlNo;
	}
	public void setFbeItemSlNo(String fbeItemSlNo) {
		FbeItemSlNo = fbeItemSlNo;
	}
	public String getComments() {
		return Comments;
	}
	public void setComments(String comments) {
		Comments = comments;
	}
	public char getDemandFlag() {
		return DemandFlag;
	}
	public void setDemandFlag(char demandFlag) {
		DemandFlag = demandFlag;
	}
	public Date getCancelDate() {
		return CancelDate;
	}
	public void setCancelDate(Date cancelDate) {
		CancelDate = cancelDate;
	}
	public String getCreatedBy() {
		return CreatedBy;
	}
	public void setCreatedBy(String createdBy) {
		CreatedBy = createdBy;
	}
	public Date getCreatedDate() {
		return CreatedDate;
	}
	public void setCreatedDate(Date createdDate) {
		CreatedDate = createdDate;
	}
	public String getModifiedBy() {
		return ModifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		ModifiedBy = modifiedBy;
	}
	public Date getModifiedDate() {
		return ModifiedDate;
	}
	public void setModifiedDate(Date modifiedDate) {
		ModifiedDate = modifiedDate;
	}
	public String getDivisionCode() {
		return DivisionCode;
	}
	public void setDivisionCode(String divisionCode) {
		DivisionCode = divisionCode;
	}
	public String getEmployeeNo() {
		return EmployeeNo;
	}
	public void setEmployeeNo(String employeeNo) {
		EmployeeNo = employeeNo;
	}
	public String getDemandingOfficer() {
		return DemandingOfficer;
	}
	public void setDemandingOfficer(String demandingOfficer) {
		DemandingOfficer = demandingOfficer;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	
	
	
	
	
}
