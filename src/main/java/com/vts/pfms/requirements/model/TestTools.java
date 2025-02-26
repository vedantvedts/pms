package com.vts.pfms.requirements.model;
import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

import com.vts.pfms.projectclosure.model.ProjectClosureACP;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name="pfms_test_plan_testingtools")
public class TestTools {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long TestToolsId;
	private String TestType;
	private String TestIds;
	private String TestTools;
	private String TestSetupName;
	private int IsActive;

}
