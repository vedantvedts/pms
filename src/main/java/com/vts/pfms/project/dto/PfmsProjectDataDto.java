package com.vts.pfms.project.dto;

import org.springframework.web.multipart.MultipartFile;

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
		private String RevisionNo;
		private String CreatedBy;
		private String CreatedDate;
		private String ModifiedBy;
		private String ModifiedDate;
		
		
		
		
		
		public MultipartFile getSystemSpecsFile() {
			return SystemSpecsFile;
		}
		public void setSystemSpecsFile(MultipartFile systemSpecsFile) {
			SystemSpecsFile = systemSpecsFile;
		}
		public MultipartFile getProductTreeImg() {
			return ProductTreeImg;
		}
		public void setProductTreeImg(MultipartFile productTreeImg) {
			ProductTreeImg = productTreeImg;
		}
		public MultipartFile getPEARLImg() {
			return PEARLImg;
		}
		public void setPEARLImg(MultipartFile pEARLImg) {
			PEARLImg = pEARLImg;
		}
		public String getProjectDataId() {
			return ProjectDataId;
		}
		public void setProjectDataId(String projectDataId) {
			ProjectDataId = projectDataId;
		}
		public String getProjectId() {
			return ProjectId;
		}
		public void setProjectId(String projectId) {
			ProjectId = projectId;
		}
		public String getFilesPath() {
			return FilesPath;
		}
		public void setFilesPath(String filesPath) {
			FilesPath = filesPath;
		}
		public String getSystemConfigImgName() {
			return SystemConfigImgName;
		}
		public void setSystemConfigImgName(String systemConfigImgName) {
			SystemConfigImgName = systemConfigImgName;
		}
		public String getSystemSpecsFileName() {
			return SystemSpecsFileName;
		}
		public void setSystemSpecsFileName(String systemSpecsFileName) {
			SystemSpecsFileName = systemSpecsFileName;
		}
		public String getProductTreeImgName() {
			return ProductTreeImgName;
		}
		public void setProductTreeImgName(String productTreeImgName) {
			ProductTreeImgName = productTreeImgName;
		}
		public String getPEARLImgName() {
			return PEARLImgName;
		}
		public void setPEARLImgName(String pEARLImgName) {
			PEARLImgName = pEARLImgName;
		}
		public String getCurrentStageId() {
			return CurrentStageId;
		}
		public void setCurrentStageId(String currentStageId) {
			CurrentStageId = currentStageId;
		}
		public String getRevisionNo() {
			return RevisionNo;
		}
		public void setRevisionNo(String revisionNo) {
			RevisionNo = revisionNo;
		}
		public String getCreatedBy() {
			return CreatedBy;
		}
		public void setCreatedBy(String createdBy) {
			CreatedBy = createdBy;
		}
		public String getCreatedDate() {
			return CreatedDate;
		}
		public void setCreatedDate(String createdDate) {
			CreatedDate = createdDate;
		}
		public String getModifiedBy() {
			return ModifiedBy;
		}
		public void setModifiedBy(String modifiedBy) {
			ModifiedBy = modifiedBy;
		}
		public String getModifiedDate() {
			return ModifiedDate;
		}
		public void setModifiedDate(String modifiedDate) {
			ModifiedDate = modifiedDate;
		}
		public MultipartFile getSystemConfigImg() {
			return SystemConfigImg;
		}
		public void setSystemConfigImg(MultipartFile systemConfigImg) {
			SystemConfigImg = systemConfigImg;
		}
		public String getProcLimit() {
			return procLimit;
		}
		public void setProcLimit(String procLimit) {
			this.procLimit = procLimit;
		}
		
		
	
	
	
}
