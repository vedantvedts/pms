package com.vts.pfms.print.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

@Entity
@Table(name = "initiation_sanction")
public class InitiationSanction {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InitiationSanctionId;
	private Long InitiationId;
	private String RdNo;
	private Long AuthorityId;
	private Long FromDeptId;
	private Long ToDeptId;
	private Date FromDate;
	private Date StartDate;
	private Double EstimateFund;
	private String UAC;
	private Date RdDate;
	private String VideNo;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
