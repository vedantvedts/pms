package com.vts.pfms.ms.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.vts.pfms.ms.model.ClusterLabEmployee;

public interface ClusterLabEmployeeRepo extends JpaRepository<ClusterLabEmployee, Long> {

	@Modifying
    @Transactional
    @Query(value = "ALTER TABLE cluster_lab_employee AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();
}
