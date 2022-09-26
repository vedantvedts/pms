package com.vts.pfms.pfts.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pfts_filetrackingorder")
public class PftsFileTrackingOrder {
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int 	FileTrackingOrderId;
	private int		FileTrackingId;
	private String 	DemandNo;
	private String 	SoNo;
	private String 	CreatedBy;
	private String 	CreatedDate;
	private String 	ModifiedBy;
	private String 	ModifiedDate;
	private String 	itemFor;
	
	public int getFileTrackingOrderId() {
		return FileTrackingOrderId;
	}
	public void setFileTrackingOrderId(int fileTrackingOrderId) {
		FileTrackingOrderId = fileTrackingOrderId;
	}
	public int getFileTrackingId() {
		return FileTrackingId;
	}
	public void setFileTrackingId(int fileTrackingId) {
		FileTrackingId = fileTrackingId;
	}
	public String getDemandNo() {
		return DemandNo;
	}
	public void setDemandNo(String demandNo) {
		DemandNo = demandNo;
	}
	public String getSoNo() {
		return SoNo;
	}
	public void setSoNo(String soNo) {
		SoNo = soNo;
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
	public String getItemFor() {
		return itemFor;
	}
	public void setItemFor(String itemFor) {
		this.itemFor = itemFor;
	}
}
