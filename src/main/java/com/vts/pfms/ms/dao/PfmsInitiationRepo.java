package com.vts.pfms.ms.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.vts.pfms.project.model.PfmsInitiation;

public interface PfmsInitiationRepo extends JpaRepository<PfmsInitiation, Long> {

	@Modifying
    @Transactional
    @Query(value = "ALTER TABLE pfms_initiation AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();
}
