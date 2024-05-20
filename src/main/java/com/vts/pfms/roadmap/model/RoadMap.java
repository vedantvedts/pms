package com.vts.pfms.roadmap.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name="pfms_road_map")
public class RoadMap implements Serializable{
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "RoadMapId")
	private Long RoadMapId;
	@Column(name = "RoadMapType")
	private String RoadMapType;
	@Column(name = "ProjectId")
	private Long ProjectId;
	@Column(name = "InitiationId")
	private Long InitiationId;
	@Column(name = "DivisionId")
	private Long DivisionId;
	@Column(name = "InitiatedBy")
	private Long InitiatedBy;
	@Column(name = "InitiationDate")
	private String InitiationDate;
	@Column(name = "ProjectTitle")
	private String ProjectTitle;
	@Column(name = "AimObjectives")
	private String AimObjectives;
	@Column(name = "StartDate")
	private String StartDate;
	@Column(name = "EndDate")
	private String EndDate;
	@Column(name = "Duration")
	private long Duration;
	@Column(name = "Reference")
	private String Reference;
	@Column(name = "OtherReference")
	private String OtherReference;
	@Column(name = "ProjectCost")
	private String ProjectCost;
	@Column(name = "Scope")
	private String Scope;
	@Column(name = "MovedToASP")
	private String MovedToASP;
	@Column(name = "MovedToASPDate")
	private String MovedToASPDate;
	@Column(name = "RoadMapStatusCode")
	private String RoadMapStatusCode;
	@Column(name = "CreatedBy")
	private String CreatedBy;
	@Column(name = "CreatedDate")
	private String CreatedDate;
	@Column(name = "ModifiedBy")
	private String ModifiedBy;
	@Column(name = "ModifiedDate")
	private String ModifiedDate;
	@Column(name = "IsActive")
	private int IsActive;
	
	@JsonIgnore
	@OneToMany(mappedBy = "roadMap", cascade = CascadeType.ALL)
	private List<RoadMapAnnualTargets> roadMapAnnualTargets;
	
	@JsonIgnore
	@OneToMany(mappedBy = "roadMap", cascade = CascadeType.ALL)
	private List<RoadMapTrans> roadMapTrans;
	
}
