package com.vts.pfms.projectclosure.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name="pfms_closure_technical")
public class ProjectClosureTechnical implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long TechnicalClosureId;
	private long ClosureId;
	private String Particulars;
    private String RevisionNo; 
	private String IssueDate;
	private String StatusCode;
	private String StatusCodeNext;
	private String ForwardedBy;
	private String ForwardedDate;
	private String TCRFreeze;
	
	private String CreatedBy;
	private String CreatedDate;
	private int isActive;

 }
