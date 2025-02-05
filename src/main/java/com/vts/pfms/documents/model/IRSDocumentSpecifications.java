package com.vts.pfms.documents.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name="pfms_irs_document_specifications")
public class IRSDocumentSpecifications implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long IRSSpecificationId;
	private Long IRSDocId;
	private Long SubSystemMainIdOne;
	private Long SubSystemMainIdTwo;
	private String SubSystemOne;
	private String SubSystemTwo;
	private Long SuperSubSysMainIdOne;
	private Long SuperSubSysMainIdTwo;
	private String SuperSubSystemOne;
	private String SuperSubSystemTwo;
	private Long InterfaceId;
	private String MessageType;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
}
