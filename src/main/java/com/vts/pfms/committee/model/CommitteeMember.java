package com.vts.pfms.committee.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="committee_member")
public class CommitteeMember {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CommitteeMemberId;
	private Long CommitteeMainId;
	private String LabCode;
	private Long EmpId;
	private String MemberType;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	private long SerialNo;
}
