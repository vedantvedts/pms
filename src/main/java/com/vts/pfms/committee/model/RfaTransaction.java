package com.vts.pfms.committee.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfms_rfa_action_transaction")
public class RfaTransaction  {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RfaTransactionId;
	private Long RfaId;
	private Long EmpId;
	private String Remarks;
	private String RfaStatus;
	private String ActionBy;
	private String ActionDate;

}
