package com.vts.pfms.header.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

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
@Table(name="project_dashboard_favourite_projects")
public class ProjectDashBoardFavouriteProjetcts {

	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FavouriteId;
	private Long ProjectId;
	private String CreatedBy;
	private String CreatedDate;
	
	@JoinColumn(name ="DashBoardId")
	@ManyToOne
	private ProjectDashBoardFavourite projectdbfav;
}
