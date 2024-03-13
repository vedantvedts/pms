package com.vts.pfms.project.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_initiation_req_members")
public class RequirementMembers {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ReqMemeberId;
	private Long EmpId;
	private Long InitiationId;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	private Long ProjectId;
	
	@Transient
	private String[] emps;
}
