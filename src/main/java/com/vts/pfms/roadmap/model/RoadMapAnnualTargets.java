package com.vts.pfms.roadmap.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

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
