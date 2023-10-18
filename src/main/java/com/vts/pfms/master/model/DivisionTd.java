package com.vts.pfms.master.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
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
