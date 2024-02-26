package com.vts.pfms.projectclosure.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
@Entity
@Table(name="pfms_closure_acp_achievements")
public class ProjectClosureACPAchievements implements Serializable{

	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long AchievementsId;
	private long ProjectId;
	private String Envisaged;
	private String Achieved;
	private String Remarks;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

}
