package com.vts.pfms.roadmap.model;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

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
