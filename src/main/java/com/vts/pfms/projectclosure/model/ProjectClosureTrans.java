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

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

@Entity
@Table(name="pfms_closure_trans")
public class ProjectClosureTrans implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long ClosureTransId;
	private long ClosureId;
	private String ClosureForm;
	private String ClosureStatusCode;
	private String Remarks;
	private String LabCode;
	private long ActionBy;
	private String ActionDate;
}
