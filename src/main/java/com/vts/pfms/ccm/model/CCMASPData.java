package com.vts.pfms.ccm.model;


import java.io.Serializable;
import java.math.BigDecimal;

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
@Table(name = "pfms_ccm_asp")
public class CCMASPData implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long CCMASPId; 
	private String LabCode; 
	private Long InitiationId; 
	private String ProjectShortName; 
	private String ProjectTitle; 
	private String Category; 
	private BigDecimal ProjectCost; 
	private int PDC; 
	private String PDD; 
	private String PDRPDC; 
	private String PDRRev; 
	private String PDRADC; 
	private String TiECPDC; 
	private String TiECRev; 
	private String TiECADC; 
	private String CECPDC; 
	private String CECRev; 
	private String CECADC; 
	private String CCMPDC; 
	private String CCMRev; 
	private String CCMADC; 
	private String DMCPDC; 
	private String DMCRev; 
	private String DMCADC; 
	private String SanctionPDC; 
	private String SanctionRev; 
	private String SanctionADC; 
	private String CreatedBy; 
	private String CreatedDate; 
	private int IsActive; 
	
}
