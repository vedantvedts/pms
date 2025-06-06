package com.vts.pfms.admin.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="division_master")
public class DivisionMaster {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DivisionId;
	private String LabCode;
	private String DivisionCode;
	private String DivisionName;
	private String DivisionShortName;
	private long DivisionHeadId;
	private long GroupId;
	private Integer IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	
}
