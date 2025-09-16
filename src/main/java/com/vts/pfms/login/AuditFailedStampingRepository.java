package com.vts.pfms.login;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface AuditFailedStampingRepository extends JpaRepository<AuditFailedStamping, Long> {

	
	@Query("SELECT COUNT(a) FROM AuditFailedStamping a WHERE a.UserName = :username AND a.LoginDateTime > :after")
    long countByUserNameAndLoginDateTimeAfter(String username, LocalDateTime after);
}
