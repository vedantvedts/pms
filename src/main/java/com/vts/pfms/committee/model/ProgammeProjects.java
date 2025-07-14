package com.vts.pfms.committee.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "pfms_programme_master")
public class ProgammeProjects implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long PrgmProjLinkedId;
	private Long ProgrammeId;
	private Long ProjectId;
	private String CreatedBy;
	private String CreatedDate;
	private Integer IsActive;
	
}
