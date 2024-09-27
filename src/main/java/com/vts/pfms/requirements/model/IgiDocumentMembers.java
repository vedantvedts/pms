package com.vts.pfms.requirements.model;


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
public class IgiDocumentMembers {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long IgiMemeberId;
	
	//primary key of employee Table 
	private Long EmpId;
	
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	
	
	
	//primary key of pfms_igi_document Table or PfmsIgiDocument Model class
	private Long DocIgiId;
	
	@Transient
	private String[] emps;

}
