package com.vts.pfms.master.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="pfms_holiday_master")
@Data
public class HolidayMaster {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long HolidayId;
	private String HolidayDate;
	private String HolidayName;
	private String HolidayType;
	private String CreatedBy;
	private String CreatedDate;
	private String ModifiedBy;
	private String ModifiedDate;
	private int isActive;
}
