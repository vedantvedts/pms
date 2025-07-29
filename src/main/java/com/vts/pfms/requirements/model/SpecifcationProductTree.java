package com.vts.pfms.requirements.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "pfms_specification_producttree")
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
