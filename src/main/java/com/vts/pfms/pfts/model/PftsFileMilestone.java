package com.vts.pfms.pfts.model;
	
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pfts_filemilestone")
public class PftsFileMilestone {
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long 	FileMilestoneId;
	private String 	DemandNo;
	private int		FileTrackingOrderId;
	private String 	CaseWorker;
	private String 	FileReceivedDate;
	private String	PacRequestDate;
	private String	PacReceivedDate;
	private String 	CfaApprovalDate;
	private String 	TenderNo;
	private String 	TenderDate;
	private String	TenderDueDate;
	private String 	CstTcecDate;
	private String 	CncRequestDate;
	private String 	CncDate;
	private String	FcRequestDate;
	private String 	FcReceivedDate;
	private String 	SanctionDate;
	private String 	BgReceivedDate;
	private String	SoNo;
	private String 	SoDate;
	private String 	DueDate;
	private double 	TotalCost;
	private String	RinNo;
	private String 	ReceiptDate;
	private String 	InspectionDate;
	private String 	CrvNo;
	private String	CrvDate;
	private String 	InBillDate;
	private String 	OutBillDate;
	private String  ChequeDate;
	private int		IsActive;
	public long getFileMilestoneId() {
		return FileMilestoneId;
	}
	public void setFileMilestoneId(long fileMilestoneId) {
		FileMilestoneId = fileMilestoneId;
	}
	public String getDemandNo() {
		return DemandNo;
	}
	public void setDemandNo(String demandNo) {
		DemandNo = demandNo;
	}
	public String getCaseWorker() {
		return CaseWorker;
	}
	public void setCaseWorker(String caseWorker) {
		CaseWorker = caseWorker;
	}
	public String getFileReceivedDate() {
		return FileReceivedDate;
	}
	public void setFileReceivedDate(String fileReceivedDate) {
		FileReceivedDate = fileReceivedDate;
	}
	public String getPacRequestDate() {
		return PacRequestDate;
	}
	public void setPacRequestDate(String pacRequestDate) {
		PacRequestDate = pacRequestDate;
	}
	public String getPacReceivedDate() {
		return PacReceivedDate;
	}
	public void setPacReceivedDate(String pacReceivedDate) {
		PacReceivedDate = pacReceivedDate;
	}
	public String getCfaApprovalDate() {
		return CfaApprovalDate;
	}
	public void setCfaApprovalDate(String cfaApprovalDate) {
		CfaApprovalDate = cfaApprovalDate;
	}
	public String getTenderNo() {
		return TenderNo;
	}
	public void setTenderNo(String tenderNo) {
		TenderNo = tenderNo;
	}
	public String getTenderDate() {
		return TenderDate;
	}
	public void setTenderDate(String tenderDate) {
		TenderDate = tenderDate;
	}
	public String getTenderDueDate() {
		return TenderDueDate;
	}
	public void setTenderDueDate(String tenderDueDate) {
		TenderDueDate = tenderDueDate;
	}
	public String getCstTcecDate() {
		return CstTcecDate;
	}
	public void setCstTcecDate(String cstTcecDate) {
		CstTcecDate = cstTcecDate;
	}
	public String getCncRequestDate() {
		return CncRequestDate;
	}
	public void setCncRequestDate(String cncRequestDate) {
		CncRequestDate = cncRequestDate;
	}
	public String getCncDate() {
		return CncDate;
	}
	public void setCncDate(String cncDate) {
		CncDate = cncDate;
	}
	public String getFcRequestDate() {
		return FcRequestDate;
	}
	public void setFcRequestDate(String fcRequestDate) {
		FcRequestDate = fcRequestDate;
	}
	public String getFcReceivedDate() {
		return FcReceivedDate;
	}
	public void setFcReceivedDate(String fcReceivedDate) {
		FcReceivedDate = fcReceivedDate;
	}
	public String getSanctionDate() {
		return SanctionDate;
	}
	public void setSanctionDate(String sanctionDate) {
		SanctionDate = sanctionDate;
	}
	public String getBgReceivedDate() {
		return BgReceivedDate;
	}
	public void setBgReceivedDate(String bgReceivedDate) {
		BgReceivedDate = bgReceivedDate;
	}
	public String getSoNo() {
		return SoNo;
	}
	public void setSoNo(String soNo) {
		SoNo = soNo;
	}
	public String getSoDate() {
		return SoDate;
	}
	public void setSoDate(String soDate) {
		SoDate = soDate;
	}
	public String getDueDate() {
		return DueDate;
	}
	public void setDueDate(String dueDate) {
		DueDate = dueDate;
	}
	public double getTotalCost() {
		return TotalCost;
	}
	public void setTotalCost(double totalCost) {
		TotalCost = totalCost;
	}
	public String getRinNo() {
		return RinNo;
	}
	public void setRinNo(String rinNo) {
		RinNo = rinNo;
	}
	public String getReceiptDate() {
		return ReceiptDate;
	}
	public void setReceiptDate(String receiptDate) {
		ReceiptDate = receiptDate;
	}
	public String getInspectionDate() {
		return InspectionDate;
	}
	public void setInspectionDate(String inspectionDate) {
		InspectionDate = inspectionDate;
	}
	public String getCrvNo() {
		return CrvNo;
	}
	public void setCrvNo(String crvNo) {
		CrvNo = crvNo;
	}
	public String getCrvDate() {
		return CrvDate;
	}
	public void setCrvDate(String crvDate) {
		CrvDate = crvDate;
	}
	public String getInBillDate() {
		return InBillDate;
	}
	public void setInBillDate(String inBillDate) {
		InBillDate = inBillDate;
	}
	public String getOutBillDate() {
		return OutBillDate;
	}
	public void setOutBillDate(String outBillDate) {
		OutBillDate = outBillDate;
	}
	public String getChequeDate() {
		return ChequeDate;
	}
	public void setChequeDate(String chequeDate) {
		ChequeDate = chequeDate;
	}
	public int getIsActive() {
		return IsActive;
	}
	public void setIsActive(int isActive) {
		IsActive = isActive;
	}
	public int getFileTrackingOrderId() {
		return FileTrackingOrderId;
	}
	public void setFileTrackingOrderId(int fileTrackingOrderId) {
		FileTrackingOrderId = fileTrackingOrderId;
	}
	
	
}
