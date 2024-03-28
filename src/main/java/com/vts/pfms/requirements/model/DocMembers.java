package com.vts.pfms.requirements.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

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
	private Long InitiationId;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	private Long ProjectId;
	private String MemeberType;
	@Transient
	private String[] emps;
}
