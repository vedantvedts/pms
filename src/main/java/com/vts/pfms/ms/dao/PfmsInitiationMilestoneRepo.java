package com.vts.pfms.ms.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.vts.pfms.project.model.PfmsInitiationMilestone;

public interface PfmsInitiationMilestoneRepo extends JpaRepository<PfmsInitiationMilestone, Long> {

	@Modifying
    @Transactional
    @Query(value = "ALTER TABLE pfms_initiation_ms AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();
}
