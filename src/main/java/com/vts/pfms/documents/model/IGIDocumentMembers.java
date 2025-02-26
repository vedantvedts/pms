package com.vts.pfms.documents.model;


import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;



import lombok.Data;

@Data
@Entity
@Table(name="pfms_igi_document_members")
public class IGIDocumentMembers implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long IGIMemeberId;
	private Long EmpId;
	private Long DocId;
	private String DocType;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	
	@Transient
	private String[] emps;

}
