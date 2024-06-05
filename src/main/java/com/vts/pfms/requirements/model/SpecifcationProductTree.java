package com.vts.pfms.requirements.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "pfms_specification_productTree")
public class SpecifcationProductTree {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ProjectDataId;
	
	private Long SpecificationId;
	
	private String FilesPath;
	
	private String imageName;
	private String Comment;
	
	private String CreatedBy;
	private String CreatedDate;
	
	private int Isactive;
	
	@Transient
	private MultipartFile file;
}
