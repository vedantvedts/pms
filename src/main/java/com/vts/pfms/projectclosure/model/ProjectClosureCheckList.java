package com.vts.pfms.projectclosure.model;

import java.io.Serializable;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Data
@Getter
@Setter
@Entity
@Table(name="pfms_closure_checklist")
public class ProjectClosureCheckList implements Serializable {
	
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	private   long ClosureCheckListId;
	//private   long ClosureId;
	private   String QARHQrsSentDate;
	private   String QARSentDate ;
	private   String QARObjective;
	private   String QARMilestone;
	private   String QARPDCDate ;
	private   String QARProposedCost;
	private   String QARCostBreakup;
	private   String QARNCItems;
	private   String SCRequested;
	private   String SCGranted;
	private   double SCRevisionCost; 
	private   String SCReason;
	private   String PDCRequested;
	private   String PDCGranted;
	private   double PDCRevised;
	private   String PDCReason;
	private   String PRMaintained;
	private   String PRSanctioned;
	private   String PECVerified;
	private   String SRMaintained;
	private   String CSProcedure;
	private   String CSDrawn;
	private   String CSamountdebited;
	private   String CSReason;
	private   String NCSProcedure;
	private   String NCSDrawn;
	private   String NCSamountdebited;
	private   String NCSReason;
	private   String NCSDistributed;
	private   String NCSIncorporated;
	private   String EquipProcured;
	private   String EquipPurchased;
	private   String EquipReason;
	private   String EquipProcuredBeforePDC;
	private   String EquipProcuredBeforePDCAttach;
	private   String EquipBoughtOnCharge;
	private   String EquipBoughtOnChargeAttach;
	private   String BudgetAllocation;
	private   String BudgetMechanism;
	private   String BudgetExpenditureAttach;
	private   String BudgetFinancialProgress;
	private   String BudgetexpenditureReports;
	private   String BudgetexpenditureIncurred;
	private   String LogBookMaintained;
	private   String JobCardsMaintained;
	private   String SPdemand;
	private   String SPActualpositionAttach;
	private   String SPGeneralSpecificAttach; 
	private   String CWIncluded;
	private   String CWAdminApp;
	private   String CWMinorWorks;
	private   String CWRevenueWorks; 
	private   String CWDeviation;
	private   String CWExpenditure; 
	private   String NoOfVehicleSanctioned;
	private   String VehicleAvgRun;
	private   String VehicleAvgFuel;
	private   String ProjectClosedDate;
	private   String ReportDate;
	private   String DelayReason;
	private   String CRObjective;
	private   String CRspinoff;
	private   String CRReason;
	private   String CRcostoverin;
	private   String NonConsumableItemsReturned;
	private   String ConsumableItemsReturned;
	private   String CRAttach;
	private   String Remarks;
	private   String CreatedBy;
	private   String CreatedDate;
	private   String ModifiedBy;
	private   String ModifiedDate;
	private   int isActive;
	
	@JoinColumn(name="ClosureId")
	@OneToOne
	private ProjectClosure projectClosure;
}
