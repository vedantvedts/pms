package com.vts.pfms.print.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter

@Entity
@Table(name = "initiationsanction_copy_addr")
public class InitiationsanctionCopyAddr {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long InitiationSanctionCopyId;
	private Long InitiationId;
	private Long CopyaddrId;
	private String CreatedBy;
	private String CreatedDate;
}
