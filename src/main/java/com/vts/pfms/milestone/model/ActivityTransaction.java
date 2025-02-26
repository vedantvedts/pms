package com.vts.pfms.milestone.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
	@Entity
	@Table(name="milestone_activity_transaction")
	public class ActivityTransaction {
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Long ActivityTransactionId;
		private Long MilestoneActivityId;
		private Date ActionDate;
		private Long SentBy;
		private Long RecieveBy;
		private String Status;
		private String Remarks;
		private String CreatedBy;
		private String CreatedDate;
		private int IsActive;
		public Long getActivityTransactionId() {
			return ActivityTransactionId;
		}
		public void setActivityTransactionId(Long activityTransactionId) {
			ActivityTransactionId = activityTransactionId;
		}
		public Long getMilestoneActivityId() {
			return MilestoneActivityId;
		}
		public void setMilestoneActivityId(Long milestoneActivityId) {
			MilestoneActivityId = milestoneActivityId;
		}
		public Date getActionDate() {
			return ActionDate;
		}
		public void setActionDate(Date actionDate) {
			ActionDate = actionDate;
		}
		public Long getSentBy() {
			return SentBy;
		}
		public void setSentBy(Long sentBy) {
			SentBy = sentBy;
		}
		public Long getRecieveBy() {
			return RecieveBy;
		}
		public void setRecieveBy(Long recieveBy) {
			RecieveBy = recieveBy;
		}
		public String getStatus() {
			return Status;
		}
		public void setStatus(String status) {
			Status = status;
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
