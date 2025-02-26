package com.vts.pfms.requirements.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name="pfms_doc_members")
public class DocMembers {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long MemeberId;
	private Long EmpId;
//	private Long InitiationId;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
//	private Long ProjectId;
	private String MemeberType;
	@Transient
	private String[] emps;
	
	private Long TestPlanInitiationId;
	private Long SpecsInitiationId;

}
