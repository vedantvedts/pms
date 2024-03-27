package com.vts.pfms.master.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="pfms_industry_partner_rep")
public class IndustryPartnerRep  implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "IndustryPartnerRepId")
	private Long IndustryPartnerRepId;
	@Column(name = "RepName")
	private String RepName;
	@Column(name = "RepDesignation")
	private String RepDesignation;
	@Column(name = "RepMobileNo")
	private String RepMobileNo;
	@Column(name = "RepEmail")
	private String RepEmail;
	@Column(name = "CreatedBy")
	private String CreatedBy;
	@Column(name = "CreatedDate")
	private String CreatedDate;
	@Column(name = "ModifiedBy")
	private String ModifiedBy;
	@Column(name = "ModifiedDate")
	private String ModifiedDate;
	@Column(name = "IsActive")
	private int IsActive;
	
	@ManyToOne
	@JoinColumn(name = "IndustryPartnerId")
	private IndustryPartner industryPartner;
}
