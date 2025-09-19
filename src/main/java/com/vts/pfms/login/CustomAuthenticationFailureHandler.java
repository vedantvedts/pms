package com.vts.pfms.login;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

	
	 private final AuditFailedStampingRepository auditRepo;
	 private final LoginAttemptService loginAttemptService;
	    public CustomAuthenticationFailureHandler(AuditFailedStampingRepository auditRepo,LoginAttemptService loginAttemptService) {
	        this.auditRepo = auditRepo;
	        this.loginAttemptService = loginAttemptService;
	    }
	
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String loginPage = (String) session.getAttribute("loginPage");

        String username = request.getParameter("username"); // matches your login form
        
       

        // Check if user is already blocked
        if (loginAttemptService.isBlocked(username)) {
        	System.out.println("Inside LogOut handlere");
        	response.sendRedirect(request.getContextPath() +"/login?error=Too Many Attempt, Try After One min");

            return;
        }
        
        
        String ip = request.getRemoteAddr();

        AuditFailedStamping audit = new AuditFailedStamping();
        audit.setUserName(username);
        audit.setLoginDate(LocalDate.now());
        audit.setLoginDateTime(LocalDateTime.now());
        audit.setIpAddress(ip);
        audit.setIsactive(1);

        auditRepo.save(audit);
        
        
        // Default failure redirect
        String failureUrl = "/login?error";

        if ("wr".equals(loginPage)) {
            failureUrl = "/wr?error";
        }

        // Redirect to the appropriate page based on loginPage flag
        response.sendRedirect(request.getContextPath() + failureUrl);
    }
}

