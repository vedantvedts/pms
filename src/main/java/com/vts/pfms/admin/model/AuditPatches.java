package com.vts.pfms.admin.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
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
@Table(name="pfms_Audit_patches")
public class AuditPatches {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="AuditPatchesId")
	private Long AuditPatchesId;
	@Column(name="VersionNo")
	private String VersionNo;
	@Column(name="Description")
	private String Description;
	@Column(name="PatchDate")
	private Date PatchDate;
	@Lob
    @Column(name = "Attachment")
    private byte[] Attachment;
	@Column(name="CreatedDate")
	private String CreatedDate;
	@Column(name="ModifiedBy")
	private String ModifiedBy;
	@Column(name="ModifiedDate")
	private String ModifiedDate;

}
