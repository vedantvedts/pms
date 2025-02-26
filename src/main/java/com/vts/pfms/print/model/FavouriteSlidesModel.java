/**
 * 
 */
package com.vts.pfms.print.model;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Getter;
import lombok.Setter;

/**
 * @author vts11
 *
 */
@Getter
@Setter

@Entity
@Table(name = "Pfms_Favourite_Slides")
public class FavouriteSlidesModel {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long FavouriteSlidesId;
	private String FavouriteSlidesTitle;
	private String ProjectIds;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private Integer IsActive;
	

}
