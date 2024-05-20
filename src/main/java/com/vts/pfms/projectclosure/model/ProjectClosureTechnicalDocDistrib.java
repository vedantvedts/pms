package com.vts.pfms.projectclosure.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

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
