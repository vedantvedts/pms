package com.vts.pfms.master.model;



import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name="division_group")

public class DivisionGroup {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private Long GroupId;
	private String GroupCode;
	private String GroupName;
	private Long GroupHeadId;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int IsActive;
	private String LabCode;
	private String TDId;
	
}