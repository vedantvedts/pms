package com.vts.pfms.project.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "pfms_initiation_approval_transaction")
public class PmsInitiationApprovalTransaction {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long EnoteTransId;
	private long EnoteId;
	private String EnoteStatusCode;
	private String Remarks;
	private Long ActionBy;
	private String ActionDate;
}
