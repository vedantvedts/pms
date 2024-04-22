package com.vts.pfms.roadmap.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="pfms_annual_targets")
public class AnnualTargets implements Serializable{
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long AnnualTargetId;
	private String AnnualTarget;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	
	@JsonIgnore
	@OneToMany(mappedBy = "annualTargets", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<RoadMapAnnualTargets> roadMapAnnualTargets;
}
