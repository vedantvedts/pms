package com.vts.pfms.login;

import java.io.IOException;
import java.util.Base64;
import java.util.Date;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Value("${license:NA}")
	public String license;
	@Autowired
	Environment env;
	
	
	
	 private final LoginAttemptService loginAttemptService;
	 private final AuditFailedStampingRepository auditRepo;
	    public LoginSuccessHandler(AuditFailedStampingRepository auditRepo,LoginAttemptService loginAttemptService) {
	       
	        this.loginAttemptService = loginAttemptService;
	        this.auditRepo = auditRepo;
	    }
	
    @Override
    @Transactional
    public void onAuthenticationSuccess(HttpServletRequest request,   HttpServletResponse response, Authentication authentication ) throws IOException  {

    	try {
//
//        // Split into parts
//        String[] parts = license.split("\\.");
//        if (parts.length < 2) {
//            System.out.println("Invalid JWT format");
//            return;
//        }
//
//        // Decode the payload
//        String payloadJson = new String(Base64.getUrlDecoder().decode(parts[1]));
//
//       
//        
//        JSONObject payload = new JSONObject(payloadJson);
//
//        System.out.println(payload);
//        
//        long iat = payload.getLong("iat");
//        long exp = payload.getLong("exp");
//        Date now = new Date(System.currentTimeMillis()); 
//        
//        Date issuedAt = new Date(iat * 1000); // Convert seconds to milliseconds
//        Date expiresAt = new Date(exp * 1000);
//    	
//        String Issuer = payload.getString("Issuer");
//        
        
//        String username = request.getParameter("username"); // matches your login form
//        // Check if user is already blocked
//        if (loginAttemptService.isBlocked(username)) {
//        	System.out.println("Inside Login handlere");
//        	response.sendRedirect(request.getContextPath() +"/login?error=There have been several failed attempts. Please wait a while and try again later");
//
//            return;
//        }
//        
//        auditRepo.deactivateByUserName(username);
//        
//        System.out.println(expiresAt);
//        System.out.println(now);
//        System.out.println(Issuer);
        
//        if (expiresAt.before(now)) {
//        	response.sendRedirect(request.getContextPath()+"/accessdenied");
//        }else {
        	response.sendRedirect(request.getContextPath()+"/welcome");
//        }
        	
    	}catch (Exception e) {
			e.printStackTrace();
		}
   }
    
    
    
    

}
