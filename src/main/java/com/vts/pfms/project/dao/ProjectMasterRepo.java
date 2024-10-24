package com.vts.pfms.project.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.vts.pfms.project.model.ProjectMaster;


@Repository
public interface ProjectMasterRepo extends JpaRepository<ProjectMaster, Long> {
	@Modifying
    @Transactional
    @Query(value = "ALTER TABLE project_master AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();
}

