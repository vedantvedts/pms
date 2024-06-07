package com.vts.pfms.projectclosure.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
@Entity
@Table(name="pfms_closure_checklist_rev")
public class ProjectClosureCheckListRev {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long RevisionId;
	private long ClosureId;
	private String RevisionType;
	private String RequestedDate;
	private String GrantedDate;
	private String RevisionCost;
	private String RevisionPDC;
	private String Reason;
	private String CreatedBy;
	private String CreatedDate;
	private int isActive;
	

}
