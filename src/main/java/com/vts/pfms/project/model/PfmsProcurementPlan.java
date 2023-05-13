package com.vts.pfms.project.model;

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
public class PfmsProcurementPlan {
		
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Long PlanId;
		private Long InitiationId;
		private String Item;
		private String Purpose;
		private String Source;
		private String ModeName;
		private Double Cost;
		private int Demand;
		private int Tender;
		private int OrderTime;
		private int Payout;
		private int Total;
		private String Approved;
}
