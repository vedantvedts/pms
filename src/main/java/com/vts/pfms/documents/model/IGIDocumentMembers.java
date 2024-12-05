package com.vts.pfms.documents.model;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;



import lombok.Data;

@Data
@Entity
@Table(name="pfms_igi_document_members")
public class IGIDocumentMembers {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long IGIMemeberId;
	
	//primary key of employee Table 
	private Long EmpId;
	
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	
	//primary key of pfms_igi_document Table or PfmsIgiDocument Model class
	private Long IGIDocId;
	
	@Transient
	private String[] emps;

}
