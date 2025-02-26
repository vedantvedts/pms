package com.vts.pfms.print.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
