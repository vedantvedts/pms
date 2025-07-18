package com.vts.pfms.committee.model;

import java.io.File;
import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.vts.pfms.print.model.CommitteeProjectBriefingFrozen;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="committee_inivitationletter")
public class CommitteeLetter implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long LetterId;
	private Long ProjectId;
	private Long InitiationId;
	private Long DivisionId;
	private Long CommitteId;
	private String FilePath;
	private String AttachmentName;
	private String CreatedBy;
	private String CreatedDate;
	private Integer IsActive;
	
	@Transient
	private String LabCode;
	
	@Transient
	private MultipartFile letter;
}
