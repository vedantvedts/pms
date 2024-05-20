package com.vts.pfms.requirements.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="pfms_req_trans")
public class RequirementsTrans {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ReqInitiationTransId;
	private String ReqStatusCode;
	private String Remarks;
	private String ActionBy;
	private String ActionDate;
	private Long ReqInitiationId;
}
