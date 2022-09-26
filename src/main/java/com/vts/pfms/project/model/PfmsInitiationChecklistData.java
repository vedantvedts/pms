package com.vts.pfms.project.model;

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
@Table(name= "pfms_initiation_checklist_data")
public class PfmsInitiationChecklistData {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY )
	private long ChecklistDataId;
	private long InitiationId;
	private long ChecklistId;
	private int IsChecked;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String modifiedDate;
	
	
}
