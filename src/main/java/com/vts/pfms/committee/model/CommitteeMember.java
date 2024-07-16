package com.vts.pfms.committee.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
