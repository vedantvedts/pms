package com.vts.pfms.projectclosure.model;

import java.io.Serializable;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
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
@Table(name="pfms_closure")
public class ProjectClosure implements Serializable{

	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ClosureId;
	private long ProjectId;
	private String ClosureCategory;
	private String ApprovalFor;
	private String ApprStatus;
	private String ClosureStatusCode;
	private String ClosureStatusCodeNext;
	private String ForwardedBy;
	private String ForwardedDate;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	
	@OneToOne(mappedBy ="projectClosure", cascade = CascadeType.ALL)
	private ProjectClosureCheckList closurechecklist;
	
}
