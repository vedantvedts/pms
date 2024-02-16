package com.vts.pfms.producttree.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter


public class ProductTreeDto {

	private long MainId;
		private long ProjectId;
		private long ParentLevelId;
		private String LevelId;
		private String LevelName;
		private String Stage;
		private String Module;
		private String RevisionNo;
		private String CreatedBy;
		private String CreatedDate;
		private String ModifiedBy;
		private String ModifiedDate;
		private int isActive;
	

}
