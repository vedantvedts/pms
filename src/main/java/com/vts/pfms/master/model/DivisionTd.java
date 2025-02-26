package com.vts.pfms.master.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Entity
@Table(name = "division_td")
public class DivisionTd {

	
	@Id	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long tdId;
	private String labCode;
	private String tdCode;
	private String tdName;
	private Long tdHeadId;
	private int isActive;
	private String createdBy;
	private String createdDate;
	private String modifiedBy;
	private String modifiedDate;
}
