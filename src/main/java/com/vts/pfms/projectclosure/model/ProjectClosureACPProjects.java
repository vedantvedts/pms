package com.vts.pfms.projectclosure.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name="pfms_closure_acp_projects")
public class ProjectClosureACPProjects implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ClosureACPProjectId;
	private long ClosureId;
	private String ACPProjectType;
	private String ACPProjectName;
	private String ACPProjectNo;
	private String ProjectAgency;
	private String ProjectCost;
	private String ProjectStatus;
	private String ProjectAchivements;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

}
