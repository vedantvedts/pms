package com.vts.pfms.project.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
@Entity
@Table(name = "pfms_procurement_plan")
public class PfmsProcurementPlan implements Serializable {
		
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Long PlanId;
		private Long InitiationId;
		private Long InitiationCostId;
		private String Item;
		private String Purpose;
		private String Source;
		private String ModeName;
		private Double Cost;
		private int Demand;
		private int Tender;
		private int OrderTime;
		private int Payment;
		private int Total;
		private String Approved;
		private String CreatedBy;
	    private String CreatedDate;
	    private String ModifiedBy;
	    private String ModifiedDate;
		private int IsActive;
}
