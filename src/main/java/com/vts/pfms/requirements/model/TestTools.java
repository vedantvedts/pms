package com.vts.pfms.requirements.model;
import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

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
