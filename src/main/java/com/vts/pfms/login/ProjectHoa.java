package com.vts.pfms.login;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table (name="project_hoa")
public class ProjectHoa {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ProjectHoaId;
	private Long ProjectId;
	private Long BudgetHeadId;
	private Long ProjectSanctionId;
	private Long BudgetItemId;
	private String ReFe;
	private Double SanctionCost;
	private Double Expenditure;
	private Double OutCommitment;
	private Double Dipl;
	private Double Balance;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String LabCode;
	public String getLabCode() {
		return LabCode;
	}
	public void setLabCode(String labCode) {
		LabCode = labCode;
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
	public Long getProjectHoaId() {
		return ProjectHoaId;
	}
	public void setProjectHoaId(Long projectHoaId) {
		ProjectHoaId = projectHoaId;
	}
	public Long getProjectId() {
		return ProjectId;
	}
	public void setProjectId(Long projectId) {
		ProjectId = projectId;
	}
	public Long getBudgetHeadId() {
		return BudgetHeadId;
	}
	public void setBudgetHeadId(Long budgetHeadId) {
		BudgetHeadId = budgetHeadId;
	}
	public Long getProjectSanctionId() {
		return ProjectSanctionId;
	}
	public void setProjectSanctionId(Long projectSanctionId) {
		ProjectSanctionId = projectSanctionId;
	}
	public Long getBudgetItemId() {
		return BudgetItemId;
	}
	public void setBudgetItemId(Long budgetItemId) {
		BudgetItemId = budgetItemId;
	}
	public String getReFe() {
		return ReFe;
	}
	public void setReFe(String reFe) {
		ReFe = reFe;
	}
	public Double getSanctionCost() {
		return SanctionCost;
	}
	public void setSanctionCost(Double sanctionCost) {
		SanctionCost = sanctionCost;
	}
	public Double getExpenditure() {
		return Expenditure;
	}
	public void setExpenditure(Double expenditure) {
		Expenditure = expenditure;
	}
	public Double getOutCommitment() {
		return OutCommitment;
	}
	public void setOutCommitment(Double outCommitment) {
		OutCommitment = outCommitment;
	}
	public Double getDipl() {
		return Dipl;
	}
	public void setDipl(Double dipl) {
		Dipl = dipl;
	}
	public Double getBalance() {
		return Balance;
	}
	public void setBalance(Double balance) {
		Balance = balance;
	}


	
	
}
