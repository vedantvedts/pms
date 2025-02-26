package com.vts.pfms.project.model;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_req_members")
public class RequirementMembers {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ReqMemeberId;
	private Long EmpId;
//	private Long InitiationId;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
//	private Long ProjectId;
	private Long ReqInitiationId;
	
	@Transient
	private String[] emps;
}
