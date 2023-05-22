package com.vts.pfms.project.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
