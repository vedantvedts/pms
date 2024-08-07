package com.vts.pfms.committee.model;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
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
