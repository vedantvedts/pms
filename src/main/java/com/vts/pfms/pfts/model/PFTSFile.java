package com.vts.pfms.pfts.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pfts_file")
public class PFTSFile implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long PftsFileId;
	private Long ProjectId;
	private String DemandNo;
	private Date DemandDate;
	private Double EstimatedCost;
	private String ItemNomenclature;
	private Date SpcDate;
	private Date EPCDate;
	private Date TenderDate;
	private Date TocDate;
	private Date TecDate;
	private Date TpcDate;
	private Date SanctionDate;
	private String OrderNo;
	private Date OrderDate;
	private Double OrderCost;
	private Date DpDate;
	private Date RevisedDp;
	private Date ReceiptDate;
	private Date InspectionDate;
	private Date CrvDate;
	private Date PaymentDate;
	private Date PartialChequeDate;
	private Date FinalChequeDate;
	private Long PftsStatusId;
	private String Remarks;
	
	public Long getPftsFileId() {
		return PftsFileId;
	}
	public void setPftsFileId(Long pftsFileId) {
		PftsFileId = pftsFileId;
	}
	public Long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(Long projectId) {
		ProjectId = projectId;
	}
	public String getDemandNo() {
		return DemandNo;
	}
	public void setDemandNo(String demandNo) {
		DemandNo = demandNo;
	}
	public Date getDemandDate() {
		return DemandDate;
	}
	public void setDemandDate(Date demandDate) {
		DemandDate = demandDate;
	}
	public Double getEstimatedCost() {
		return EstimatedCost;
	}
	public void setEstimatedCost(Double estimatedCost) {
		EstimatedCost = estimatedCost;
	}
	public String getItemNomenclature() {
		return ItemNomenclature;
	}
	public void setItemNomenclature(String itemNomenclature) {
		ItemNomenclature = itemNomenclature;
	}
	public Date getSpcDate() {
		return SpcDate;
	}
	public void setSpcDate(Date spcDate) {
		SpcDate = spcDate;
	}
	public Date getEPCDate() {
		return EPCDate;
	}
	public void setEPCDate(Date ePCDate) {
		EPCDate = ePCDate;
	}
	public Date getTenderDate() {
		return TenderDate;
	}
	public void setTenderDate(Date tenderDate) {
		TenderDate = tenderDate;
	}
	public Date getTocDate() {
		return TocDate;
	}
	public void setTocDate(Date tocDate) {
		TocDate = tocDate;
	}
	public Date getTecDate() {
		return TecDate;
	}
	public void setTecDate(Date tecDate) {
		TecDate = tecDate;
	}
	public Date getTpcDate() {
		return TpcDate;
	}
	public void setTpcDate(Date tpcDate) {
		TpcDate = tpcDate;
	}
	public Date getSanctionDate() {
		return SanctionDate;
	}
	public void setSanctionDate(Date sanctionDate) {
		SanctionDate = sanctionDate;
	}
	public String getOrderNo() {
		return OrderNo;
	}
	public void setOrderNo(String orderNo) {
		OrderNo = orderNo;
	}
	public Date getOrderDate() {
		return OrderDate;
	}
	public void setOrderDate(Date orderDate) {
		OrderDate = orderDate;
	}
	public Date getDpDate() {
		return DpDate;
	}
	public void setDpDate(Date dpDate) {
		DpDate = dpDate;
	}
	public Date getRevisedDp() {
		return RevisedDp;
	}
	public void setRevisedDp(Date revisedDp) {
		RevisedDp = revisedDp;
	}
	public Date getReceiptDate() {
		return ReceiptDate;
	}
	public void setReceiptDate(Date receiptDate) {
		ReceiptDate = receiptDate;
	}
	public Date getInspectionDate() {
		return InspectionDate;
	}
	public void setInspectionDate(Date inspectionDate) {
		InspectionDate = inspectionDate;
	}
	public Date getCrvDate() {
		return CrvDate;
	}
	public void setCrvDate(Date crvDate) {
		CrvDate = crvDate;
	}
	public Date getPaymentDate() {
		return PaymentDate;
	}
	public void setPaymentDate(Date paymentDate) {
		PaymentDate = paymentDate;
	}
	public Date getChequeDate() {
		return PartialChequeDate;
	}
	public void setChequeDate(Date chequeDate) {
		PartialChequeDate = chequeDate;
	}
	public Long getPftsStatusId() {
		return PftsStatusId;
	}
	public void setPftsStatusId(Long pftsStatusId) {
		PftsStatusId = pftsStatusId;
	}
	
	@Override
	public String toString() {
		return "PFTSFile [PftsFileId=" + PftsFileId + ", ProjectId=" + ProjectId + ", DemandNo=" + DemandNo
				+ ", DemandDate=" + DemandDate + ", EstimatedCost=" + EstimatedCost + ", ItemNomenclature="
				+ ItemNomenclature + ", SpcDate=" + SpcDate + ", EPCDate=" + EPCDate + ", TenderDate=" + TenderDate
				+ ", TocDate=" + TocDate + ", TecDate=" + TecDate + ", TpcDate=" + TpcDate + ", SanctionDate="
				+ SanctionDate + ", OrderNo=" + OrderNo + ", OrderDate=" + OrderDate + ", DpDate=" + DpDate
				+ ", RevisedDp=" + RevisedDp + ", ReceiptDate=" + ReceiptDate + ", InspectionDate=" + InspectionDate
				+ ", CrvDate=" + CrvDate + ", PaymentDate=" + PaymentDate + ", ChequeDate=" + PartialChequeDate
				+ ", PftsStatusId=" + PftsStatusId + "]";
	}
	
	public Double getOrderCost() {
		return OrderCost;
	}

	public void setOrderCost(Double orderCost) {
		OrderCost = orderCost;
	}
	
	public Date getFinalChequeDate() {
		return FinalChequeDate;
	}
	
	public void setFinalChequeDate(Date finalChequeDate) {
		FinalChequeDate = finalChequeDate;
	}
	public String getRemarks() {
		return Remarks;
	}
     public void setRemarks(String remarks) {
		Remarks = remarks;
	}
	
}
