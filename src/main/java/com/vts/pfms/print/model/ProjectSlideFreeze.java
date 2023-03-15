package com.vts.pfms.print.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

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
	private String Review;
	private Date ReviewDate;
	private String Path;
	private String AttachName;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
