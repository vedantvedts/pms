package com.vts.pfms.committee.model;
import java.util.Date;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Entity
@Table(name = "pfms_rfa_oldfile")
public class OldRfaUpload {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long RfaFileUploadId;
	private String LabCode;
	private Long ProjectId;
	private String RfaNo;
	private String RfaDate;
	private String RfaFile;
	private String ClosureFile;
	private String Path;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	

}
