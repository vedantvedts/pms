package com.vts.pfms.master.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
