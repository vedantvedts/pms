package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name="project_employee")
public class ProjectAssign {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ProjectEmployeeId;
	private long EmpId;
	private long ProjectId;
	private int isActive;
	private Long RoleMasterId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
