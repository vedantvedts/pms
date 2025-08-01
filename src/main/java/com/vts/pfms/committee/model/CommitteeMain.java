package com.vts.pfms.committee.model;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;
@Data
@Entity
@Table(name="committee_main")
public class CommitteeMain implements Serializable {
	
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CommitteeMainId;
	private Long CommitteeId;
	private Date ValidFrom;
	private Date ValidTo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private String PreApproved;
	private int IsActive;
	private Long ProjectId;
	private Long DivisionId;
	private Long InitiationId;
	private Long CARSInitiationId;
	private Long ProgrammeId;
	private String Status;
	private String ReferenceNo;
	private Date FormationDate;
	
}
