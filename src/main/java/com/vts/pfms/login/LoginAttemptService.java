package com.vts.pfms.login;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

@Component
public class LoginAttemptService {

	private  AuditFailedStampingRepository auditRepo;
	
	 public LoginAttemptService(AuditFailedStampingRepository auditRepo) {
	        this.auditRepo = auditRepo;
	    }
	 
	 public boolean isBlocked(String username) {
	        LocalDateTime oneMinuteAgo = LocalDateTime.now().minusMinutes(3);
	        
	        long failedAttempts = auditRepo.countByUserNameAndLoginDateTimeAfter(username, oneMinuteAgo);
	       
	        System.out.println(failedAttempts+"------"+failedAttempts+"---"+oneMinuteAgo);
	        
	        return failedAttempts >= 3;
	    }
}
