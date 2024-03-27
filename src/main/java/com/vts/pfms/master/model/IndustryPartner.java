package com.vts.pfms.master.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="pfms_industry_partner")
public class IndustryPartner implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="IndustryPartnerId")
	private Long IndustryPartnerId;
	@Column(name="IndustryName")
	private String IndustryName;
	@Column(name="IndustryAddress")
	private String IndustryAddress;
	@Column(name="IndustryCity")
	private String IndustryCity;
	@Column(name="IndustryPinCode")
	private String IndustryPinCode;
	@Column(name="CreatedBy")
	private String CreatedBy;
	@Column(name="CreatedDate")
	private String CreatedDate;
	@Column(name="ModifiedBy")
	private String ModifiedBy;
	@Column(name="ModifiedDate")
	private String ModifiedDate;
	@Column(name="IsActive")
	private int IsActive;
	
	@JsonIgnore
	@OneToMany(mappedBy = "industryPartner", cascade = CascadeType.ALL)
	private List<IndustryPartnerRep> rep;
}
