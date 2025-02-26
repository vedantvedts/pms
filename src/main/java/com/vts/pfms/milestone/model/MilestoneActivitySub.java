package com.vts.pfms.milestone.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;

	@Entity
	@Table(name="milestone_activity_sub")
	public class MilestoneActivitySub {
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Long ActivitySubId;
		private Long ActivityId;
		private String AttachName;
		@Lob
		private byte[] AttachFile;
		private Date ProgressDate;
		private int Progress;
		private String Remarks;
		private String CreatedBy;
		private String CreatedDate;
		private int IsActive;
		public Long getActivitySubId() {
			return ActivitySubId;
		}
		public void setActivitySubId(Long activitySubId) {
			ActivitySubId = activitySubId;
		}
		public Long getActivityId() {
			return ActivityId;
		}
		public void setActivityId(Long activityId) {
			ActivityId = activityId;
		}
		
		public String getAttachName() {
			return AttachName;
		}
		public void setAttachName(String attachName) {
			AttachName = attachName;
		}
		public byte[] getAttachFile() {
			return AttachFile;
		}
		public void setAttachFile(byte[] attachFile) {
			AttachFile = attachFile;
		}
		public Date getProgressDate() {
			return ProgressDate;
		}
		public void setProgressDate(Date progressDate) {
			ProgressDate = progressDate;
		}
		public int getProgress() {
			return Progress;
		}
		public void setProgress(int progress) {
			Progress = progress;
		}
		public String getRemarks() {
			return Remarks;
		}
		public void setRemarks(String remarks) {
			Remarks = remarks;
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
		public int getIsActive() {
			return IsActive;
		}
		public void setIsActive(int isActive) {
			IsActive = isActive;
		}
		
}
