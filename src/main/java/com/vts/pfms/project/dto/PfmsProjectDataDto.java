package com.vts.pfms.project.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PfmsProjectDataDto {

		private String ProjectDataId;
		private String ProjectId;
		private String FilesPath;
		private String SystemConfigImgName;
		private MultipartFile SystemConfigImg;
		private String SystemSpecsFileName;
		private MultipartFile SystemSpecsFile;
		private String ProductTreeImgName;
		private MultipartFile ProductTreeImg;
		private String PEARLImgName;
		private MultipartFile PEARLImg;
		private String procLimit;
		private String CurrentStageId;
		private Date LastPmrcDate;
		private Date LastEBDate;
		private String RevisionNo;
		private String CreatedBy;
		private String CreatedDate;
		private String ModifiedBy;
		private String ModifiedDate;
		
		private String Labcode;
		
		
		
	
}
