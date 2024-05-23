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
@Table(name="pfms_doc_trans")
public class DocumentTrans {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long DocInitiationTransId;
	private String ReqStatusCode;
	private String Remarks;
	private String ActionBy;
	private String ActionDate;
	private String DocType;
	private Long DocInitiationId;
}
