package com.vts.pfms.login;

import java.time.LocalDateTime;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface AuditFailedStampingRepository extends JpaRepository<AuditFailedStamping, Long> {

	
	@Query("SELECT COUNT(a) FROM AuditFailedStamping a " +
		       "WHERE a.UserName = :username AND a.LoginDateTime > :after AND a.isactive = 1")
    long countByUserNameAndLoginDateTimeAfter(String username, LocalDateTime after);
	
	
	 	@Modifying
	    @Query("UPDATE AuditFailedStamping a SET a.isactive = 0 WHERE a.UserName = :username AND a.isactive = 1")
	    int deactivateByUserName(@Param("username") String username);
}
