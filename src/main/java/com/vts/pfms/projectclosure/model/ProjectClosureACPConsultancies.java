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
@Table(name="pfms_closure_acp_consultancies")
public class ProjectClosureACPConsultancies implements Serializable{

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ConsultancyId;
	private long ClosureId;
	private String ConsultancyAim;
	private String ConsultancyAgency;
	private String ConsultancyCost;
	private String ConsultancyDate;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

}
