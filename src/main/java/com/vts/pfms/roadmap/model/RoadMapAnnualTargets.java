package com.vts.pfms.roadmap.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="pfms_road_map_annual_targets")
public class RoadMapAnnualTargets  implements Serializable {

	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "AnnualTargetsId")
	private Long AnnualTargetsId;
	@Column(name = "AnnualYear")
	private String AnnualYear;
//	@Column(name = "AnnualTarget")
//	private String AnnualTarget;
//	@Column(name = "Others")
//	private String Others;
	@Column(name = "CreatedBy")
	private String CreatedBy;
	@Column(name = "CreatedDate")
	private String CreatedDate;
	@Column(name = "IsActive")
	private int IsActive;
	
	@ManyToOne
	@JoinColumn(name="RoadMapId")
	private RoadMap roadMap;
	
	@ManyToOne
	@JoinColumn(name="AnnualTargetId")
	private AnnualTargets annualTargets;
	
}
