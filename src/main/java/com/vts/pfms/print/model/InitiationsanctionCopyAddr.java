package com.vts.pfms.print.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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
