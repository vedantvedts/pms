package com.vts.pfms.master.model;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name = "pfms_feedback")
public class PfmsFeedback implements Serializable {
	   @Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long FeedbackId;
	    private Long EmpId;
	    private String Feedback;
	    private String CreatedBy;
	    private String CreatedDate;
	    private int isActive;
	    
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
