package com.vts.pfms.projectclosure.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name="pfms_closure_acp_consultancies")
public class ProjectClosureACPConsultancies implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ConsultancyId;
	private long ProjectId;
	private String ConsultancyAim;
	private String ConsultancyAgency;
	private String ConsultancyCost;
	private String ConsultancyDate;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

}
