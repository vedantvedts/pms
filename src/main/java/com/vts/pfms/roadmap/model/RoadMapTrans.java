package com.vts.pfms.roadmap.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name="pfms_road_map_trans")
public class RoadMapTrans {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RoadMapTransId;
	private String RoadMapStatusCode;
	private String Remarks;
	private String ActionBy;
	private String ActionDate;
	
	@ManyToOne
	@JoinColumn(name="RoadMapId")
	private RoadMap roadMap;
}
