package com.vts.pfms.master.dto;

public class DemandDetails {

	private Long ProjectId;
	private String DemandNo;
	private String DemandDate;
	private String ItemFor;
	private Double EstimatedCost;
	
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
	public String getDemandDate() {
		return DemandDate;
	}
	public void setDemandDate(String demandDate) {
		DemandDate = demandDate;
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
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((DemandDate == null) ? 0 : DemandDate.hashCode());
		result = prime * result + ((DemandNo == null) ? 0 : DemandNo.hashCode());
		result = prime * result + ((EstimatedCost == null) ? 0 : EstimatedCost.hashCode());
		result = prime * result + ((ItemFor == null) ? 0 : ItemFor.hashCode());
		result = prime * result + ((ProjectId == null) ? 0 : ProjectId.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		
		DemandDetails other = (DemandDetails) obj;
		
		if (DemandDate == null) {
			if (other.DemandDate != null)
				return false;
		}
		if (DemandNo == null) {
			if (other.DemandNo != null)
				return false;
		} else if (!DemandNo.equalsIgnoreCase(other.DemandNo))
			return false;
//		if (EstimatedCost == null) {
//			if (other.EstimatedCost != null)
//				return false;
//		} else if (!EstimatedCost.equals(other.EstimatedCost))
//			return false;
//		if (ItemFor == null) {
//			if (other.ItemFor != null)
//				return false;
//		} else if (!ItemFor.equals(other.ItemFor))
//			return false;
//		if (ProjectId == null) {
//			if (other.ProjectId != null)
//				return false;
//		} else if (!ProjectId.equals(other.ProjectId))
//			return false;
		return true;
	}

}
