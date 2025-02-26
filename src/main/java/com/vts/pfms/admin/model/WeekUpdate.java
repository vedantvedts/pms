package com.vts.pfms.admin.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "pfms_weekly_update")
public class WeekUpdate {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int update_id;
	
	@Getter
	@Setter
	String Procurement;
	
	@Getter
	@Setter
	String Empno;
	
	@Getter
	@Setter
	String UpdatedDate;
	
	@Getter
	@Setter
	int empId;
	
	@Getter
	@Setter
	String AcionPoints;
	
	@Getter
	@Setter
	String riskdetails;
	
	@Getter
	@Setter
	String meeting;
	
	@Getter
	@Setter
	String MileStone;
	
	@Getter
	@Setter
	int projectid;

	public WeekUpdate(String procurement, String role, String UpdatedDate, int empId, String AcionPoints,
			String riskdetails, String meeting, String mile, int projectid) {
		super();
		this.Procurement = procurement;
		this.Empno = role;
		this.UpdatedDate = UpdatedDate;
		this.empId = empId;
		this.AcionPoints = AcionPoints;
		this.riskdetails = riskdetails;
		this.meeting = meeting;
		this.MileStone = mile;
		this.projectid = projectid;
	}

	public WeekUpdate() {
		super();
	}
	
}
