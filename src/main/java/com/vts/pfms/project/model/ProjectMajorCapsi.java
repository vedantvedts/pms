package com.vts.pfms.project.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "pfms_initiation_soc_capsi")
public class ProjectMajorCapsi implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CapsId;
	private Long InitiationId;
	private String Station;
	private String Consultant;
	private String AreaRD;
	private Double Cost;
	private int PDC;
	private int Confidencelevel;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
}
