package com.vts.pfms.project.model;

import java.io.Serializable;

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
@Table(name="pfms_initiation_req_intro")
public class PfmsInitiationReqIntro implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long IntroId;
	private Long InitiationId;
	private String Introduction;
	private String SystemBlockDiagram;
	private String SystemOverview;
	private String DocumentOverview;
	private String ApplicableStandards;
	private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
	private int IsActive;
}
