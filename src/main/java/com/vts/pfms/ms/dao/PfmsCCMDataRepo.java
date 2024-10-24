package com.vts.pfms.ms.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.vts.pfms.login.PFMSCCMData;

public interface PfmsCCMDataRepo extends JpaRepository<PFMSCCMData, Long> {

	@Modifying
    @Transactional
    @Query(value = "ALTER TABLE pfms_ccm_data AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();
}
