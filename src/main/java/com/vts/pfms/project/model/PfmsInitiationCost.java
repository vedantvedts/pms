package com.vts.pfms.project.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "pfms_initiation_cost")
public class PfmsInitiationCost implements Serializable {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InitiationCostId;

	private Long InitiationId;
    private Long BudgetHeadId;
    private Long BudgetSancId;
    private String ItemDetail;
    private Double ItemCost; 
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
	
	public Long getInitiationCostId() {
		return InitiationCostId;
	}
	public void setInitiationCostId(Long initiationCostId) {
		InitiationCostId = initiationCostId;
	}
	public Long getInitiationId() {
		return InitiationId;
	}
	public void setInitiationId(Long initiationId) {
		InitiationId = initiationId;
	}
	public Long getBudgetHeadId() {
		return BudgetHeadId;
	}
	public void setBudgetHeadId(Long budgetHeadId) {
		BudgetHeadId = budgetHeadId;
	}

	public Long getBudgetSancId() {
		return BudgetSancId;
	}
	public void setBudgetSancId(Long budgetSancId) {
		BudgetSancId = budgetSancId;
	}
	public String getItemDetail() {
		return ItemDetail;
	}
	public void setItemDetail(String itemDetail) {
		ItemDetail = itemDetail;
	}
	public Double getItemCost() {
		return ItemCost;
	}
	public void setItemCost(Double itemCost) {
		ItemCost = itemCost;
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
