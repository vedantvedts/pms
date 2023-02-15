package com.vts.pfms.print.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

@Entity
@Table(name = "pfms_recdec_point")
public class RecDecDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RecDecId;
	private Long ScheduleId;
	private String Type;
	private String Point;
	private int IsActive;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
