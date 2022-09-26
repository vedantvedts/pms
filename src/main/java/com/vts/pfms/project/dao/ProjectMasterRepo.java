package com.vts.pfms.project.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.vts.pfms.project.model.ProjectMaster;


	@Repository
	public interface ProjectMasterRepo 
	  extends JpaRepository<ProjectMaster, Long> {
		
	}

