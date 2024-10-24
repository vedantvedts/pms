package com.vts.pfms.ms.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.vts.pfms.login.ProjectHoa;

public interface ProjectHoaRepo extends JpaRepository<ProjectHoa, Long> {

	@Modifying
    @Transactional
    @Query(value = "ALTER TABLE project_hoa AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();
}
