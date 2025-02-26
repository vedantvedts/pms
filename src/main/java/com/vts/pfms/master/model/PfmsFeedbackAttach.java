package com.vts.pfms.master.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "pfms_feedback_attach")
public class PfmsFeedbackAttach implements Serializable {

	    @Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Long FeedbackAttachId;
	 	private Long FeedbackId;
	    private String FileName;
	    private String Path;
	    private String CreatedBy;
	    private String CreatedDate;
	    private String ModifiedBy;
	    private String ModifiedDate;
	    private int isActive;
}
