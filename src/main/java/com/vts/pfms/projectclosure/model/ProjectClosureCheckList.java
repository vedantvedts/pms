package com.vts.pfms.projectclosure.model;

import java.io.Serializable;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;


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
	private   double QARProposedCost;
	private   String QARCostBreakup;
	private   String QARNCItems;
	private   String SCRequested;
	private   String SCGranted;
	private   double SCRevisionCost; 
	private   String SCReason;
	private   String PDCRequested;
	private   String PDCGranted;
	private   String PDCRevised;
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
	private   String CRBringFrom;
	private   String CommittmentRegister;
	private   String BudgetDocument;
	private   String EquipBoughtOnCharge;
	private   String EquipBoughtOnChargeReason;
	private   String BudgetAllocation;
	private   String BudgetMechanism;
	private   String BudgetExpenditure;
	private   String BudgetFinancialProgress;
	private   String BudgetexpenditureReports;
	private   String BudgetexpenditureIncurred;
	private   String LogBookMaintained;
	private   String JobCardsMaintained;
	private   String SPdemand;
	private   String SPActualposition;
	private   String SPGeneralSpecific; 
	private   String CWIncluded;
	private   String CWAdminApp;
	private   String CWMinorWorks;
	private   String CWRevenueWorks; 
	private   String CWDeviation;
	private   String CWExpenditure; 
	private   String NoOfVehicleSanctioned;
	private   String VehicleType;
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
	private   String ManPowerSanctioned;
	private   String Remarks;
	private   String PRRemark1;
	private   String PRRemark2;
	private   String PECRemark1;
	private   String SRRemark1;
	private   String CSRemark1;
	private   String NCSRemark1;
	private   String NCSRemark2;
	private   String NCSRemark3;
	private   String EquipmentRemark1;
	private   String EquipmentRemark2;
	private   String EquipmentRemark3;
	private   String BudgetRemark1;
	private   String BudgetRemark2;
	private   String BudgetRemark3;
	private   String BudgetRemark4;
	private   String UtilizationRemark1;
	private   String StaffRemark1;
	private   String CWRemark1;
	private   String ProjectRemark1;
	private   String CreatedBy;
	private   String CreatedDate;
	private   String ModifiedBy;
	private   String ModifiedDate;
	private   int IsActive;
	
	
	
	@JoinColumn(name="ClosureId")
	@OneToOne
	private ProjectClosure projectClosure;
}
