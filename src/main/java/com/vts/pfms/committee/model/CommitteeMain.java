package com.vts.pfms.committee.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
	private Long CARSInitiationId;;
	private String Status;
	private String ReferenceNo;
	private Date FormationDate;
	
}
