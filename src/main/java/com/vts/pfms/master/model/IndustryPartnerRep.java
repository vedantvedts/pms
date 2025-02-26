package com.vts.pfms.master.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

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
