package com.vts.pfms.committee.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.vts.pfms.committee.model.ActionMain;



	@Repository
	public interface ActionDaoRepo 
	  extends JpaRepository<ActionMain, Long> {
		
	}