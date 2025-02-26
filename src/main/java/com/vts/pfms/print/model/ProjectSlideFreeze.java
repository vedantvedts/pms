package com.vts.pfms.print.model;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Entity
@Table(name ="pfms_project_slides_freeze")
public class ProjectSlideFreeze {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FreezeId;
	private Long ProjectId;
	private Long EmpId;
	private String Reviewby;
	private Date ReviewDate;
	private String Path;
	private String AttachName;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
