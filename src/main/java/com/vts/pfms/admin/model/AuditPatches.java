package com.vts.pfms.admin.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
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
