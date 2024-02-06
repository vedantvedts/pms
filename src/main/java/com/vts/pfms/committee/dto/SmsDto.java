package com.vts.pfms.committee.dto;

import java.util.ArrayList;
import java.util.List;

public class SmsDto {
	private String MobileNo;
	private List<Object[]> ActionItemAndPdcDate;
	
	public SmsDto(String MobileNo) {
        this.MobileNo = MobileNo;
        this.ActionItemAndPdcDate = new ArrayList<>();
    }
	
	 public String getMobileNo() {
	        return MobileNo;
	    }

	 public List<Object[]> getActionItemAndPdcDate() {
	        return ActionItemAndPdcDate;
	    }

	    public void addActionItemAndPdcDate(String ActionItem, String PdcDate) {
	    	ActionItemAndPdcDate.add(new Object[]{ActionItem, PdcDate});
	    }
}
