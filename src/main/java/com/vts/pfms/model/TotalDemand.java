package com.vts.pfms.model;

import lombok.Data;

@Data
public class TotalDemand {
	 private String ProjectId;
     private String ProjectCode;
     private String DemandCount;
     private String EstimatedCost;
     private String SupplyOrderCount;
     private String TotalOrderCost;
     private String TotalExpenditure;
}
