package com.vts.pfms.master.model;
import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
@Entity
@Table(name = "pfms_feedback")
public class PfmsFeedback implements Serializable {
	   @Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long FeedbackId;
	    private Long EmpId;
	    private String FeedbackType;
	    private String Feedback;
	    private String Status;
	    private String Remarks;
	    private String CreatedBy;
	    private String CreatedDate;
	    private int isActive;
	    
	    
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
		public String getFeedbackType() {
			return FeedbackType;
		}
		public void setFeedbackType(String feedbackType) {
			FeedbackType = feedbackType;
		}
		public Long getFeedbackId() {
			return FeedbackId;
		}
		public void setFeedbackId(Long feedbackId) {
			FeedbackId = feedbackId;
		}
		public Long getEmpId() {
			return EmpId;
		}
		public void setEmpId(Long empId) {
			EmpId = empId;
		}
		public String getFeedback() {
			return Feedback;
		}
		public void setFeedback(String feedback) {
			Feedback = feedback;
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
			return isActive;
		}
		public void setIsActive(int isActive) {
			this.isActive = isActive;
		}
		
	
}
