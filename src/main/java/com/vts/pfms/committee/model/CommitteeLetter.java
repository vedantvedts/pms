package com.vts.pfms.committee.model;

import java.io.File;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

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
@Table(name="committee_inivitationLetter")
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
	
	@Transient
	private String LabCode;
	
	@Transient
	private MultipartFile letter;
}
