package com.vts.pfms.print.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import org.hibernate.annotations.Where;

import lombok.Getter;
import lombok.Setter;



@Getter
@Setter

@Entity
@Table(name = "pfms_tech_images" )
@Where(clause = "IsActive='1'")
public class TechImages {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long TechImagesId;
	private String ImageName;
	private Long ProjectId;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;

}
