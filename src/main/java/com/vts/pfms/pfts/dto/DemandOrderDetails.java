package com.vts.pfms.pfts.dto;

import java.sql.Date;

public class DemandOrderDetails {
	private String OrderNo;
	private String OrderDate;
	private Double OrderCost;
	private String DpDate;
	private String RevisedDp;
	private String VendorName;
	private String ItemFor;
	public String getOrderNo() {
		return OrderNo;
	}
	public void setOrderNo(String orderNo) {
		OrderNo = orderNo;
	}
	public String getOrderDate() {
		return OrderDate;
	}
	public void setOrderDate(String orderDate) {
		OrderDate = orderDate;
	}
	public Double getOrderCost() {
		return OrderCost;
	}
	public void setOrderCost(Double orderCost) {
		OrderCost = orderCost;
	}
	public String getDpDate() {
		return DpDate;
	}
	public void setDpDate(String dpDate) {
		DpDate = dpDate;
	}
	public String getRevisedDp() {
		return RevisedDp;
	}
	public void setRevisedDp(String revisedDp) {
		RevisedDp = revisedDp;
	}
	public String getVendorName() {
		return VendorName;
	}
	public void setVendorName(String vendorName) {
		VendorName = vendorName;
	}
	public String getItemFor() {
		return ItemFor;
	}
	public void setItemFor(String itemFor) {
		ItemFor = itemFor;
	}

	
}
