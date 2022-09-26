package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "committee_initiation")	
public class CommitteeInitiation {
	
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Long CommitteeInitiationId;
		private Long InitiationId;
		private Long CommitteeId;	
		private String AutoSchedule;
		private String Description;
		private String TermsOfReference;	
		private String CreatedBy;
		private String CreatedDate;
		private String ModifiedBy;
		private String ModifiedDate;
		
		
		public Long getCommitteeInitiationId() {
			return CommitteeInitiationId;
		}
		public void setCommitteeInitiationId(Long committeeInitiationId) {
			CommitteeInitiationId = committeeInitiationId;
		}
		public Long getInitiationId() {
			return InitiationId;
		}
		public void setInitiationId(Long initiationId) {
			InitiationId = initiationId;
		}
		public Long getCommitteeId() {
			return CommitteeId;
		}
		public void setCommitteeId(Long committeeId) {
			CommitteeId = committeeId;
		}
		public String getAutoSchedule() {
			return AutoSchedule;
		}
		public void setAutoSchedule(String autoSchedule) {
			AutoSchedule = autoSchedule;
		}
		public String getDescription() {
			return Description;
		}
		public void setDescription(String description) {
			Description = description;
		}
		public String getTermsOfReference() {
			return TermsOfReference;
		}
		public void setTermsOfReference(String termsOfReference) {
			TermsOfReference = termsOfReference;
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
		
		

}
