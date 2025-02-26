package com.vts.pfms.projectclosure.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Table(name = "pfms_closure_technical_docdistr")

public class ProjectClosureTechnicalDocDistrib {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long DistrubtionId;
	private long TechnicalClosureId;
	private long EmpId;
	private String CreatedBy;
	private String CreatedDate;
	private int isActive;
	
	
	@Transient
	private String[] emps;
	

}
