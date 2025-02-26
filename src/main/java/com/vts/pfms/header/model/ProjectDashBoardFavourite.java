package com.vts.pfms.header.model;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.vts.pfms.roadmap.model.RoadMap;
import com.vts.pfms.roadmap.model.RoadMapAnnualTargets;
import com.vts.pfms.roadmap.model.RoadMapTrans;

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
@Table(name="project_dashboard_favourite")
public class ProjectDashBoardFavourite {

	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DashBoardId;
	private String DashBoardName;
	private String LoginType;
	private Long EmpId;
	private int IsActive;
	
	@JsonIgnore
	@OneToMany( mappedBy ="projectdbfav" , cascade = CascadeType.ALL)
	private List<ProjectDashBoardFavouriteProjetcts> projects;
}
