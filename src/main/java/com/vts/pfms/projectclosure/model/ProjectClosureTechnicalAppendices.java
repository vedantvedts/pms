package com.vts.pfms.projectclosure.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="pfms_closure_technical_appendices")


public class ProjectClosureTechnicalAppendices {
	
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long AppendicesId;
	private long ChapterId;
	private String Appendix;
	private String DocumentName;
	private String DocumentAttachment;
	private String CreatedBy;
	private String CreatedDate;
	private int isActive;
	
}
