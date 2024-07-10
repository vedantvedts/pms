package com.vts.pfms.header.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
