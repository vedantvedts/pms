package com.vts.pfms.pfts.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity 
@Table(name = "pfts_status")
public class PFTSStatus implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long PftsStatusId;
	private String PftsStatus;
	private String PftsStageName;
	
	
	public Long getPftsStatusId() {
		return PftsStatusId;
	}
	public void setPftsStatusId(Long pftsStatusId) {
		PftsStatusId = pftsStatusId;
	}
	public String getPftsStatus() {
		return PftsStatus;
	}
	public void setPftsStatus(String pftsStatus) {
		PftsStatus = pftsStatus;
	}
	public String getPftsStageName() {
		return PftsStageName;
	}
	public void setPftsStageName(String pftsStageName) {
		PftsStageName = pftsStageName;
	}
	
}
