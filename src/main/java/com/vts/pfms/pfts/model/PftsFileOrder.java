package com.vts.pfms.pfts.model;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name="pfts_file_order")
public class PftsFileOrder implements Serializable {
		
	private static final long serialVersionUID = 1L;
		
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long PftsFileOrderId;
    private Long PftsFileId;
	private String OrderNo;
	private String OrderDate;
	private Double OrderCost;
	private String DpDate;
	private Date RevisedDp;
	private String VendorName;
	private String ItemFor;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
}
