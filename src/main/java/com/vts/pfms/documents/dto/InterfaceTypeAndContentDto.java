package com.vts.pfms.documents.dto;

import java.util.List;

import lombok.Data;

@Data
public class InterfaceTypeAndContentDto {

	private String InterfaceTypeId;
	private String InterfaceType;
	private String InterfaceTypeCode;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	private String Action;
	private String[] InterfaceContent;
	private List<String> InterfaceContentCode;
	private List<String> IsDataCarrying;

}
