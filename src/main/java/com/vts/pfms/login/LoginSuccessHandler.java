package com.vts.pfms.login;

import java.io.IOException;
import java.util.Base64;
import java.util.Date;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Value("${license:NA}")
	public String license;
	@Autowired
	Environment env;
	
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,   HttpServletResponse response, Authentication authentication ) throws IOException  {


        // Split into parts
        String[] parts = license.split("\\.");
        if (parts.length < 2) {
            System.out.println("Invalid JWT format");
            return;
        }

        // Decode the payload
        String payloadJson = new String(Base64.getUrlDecoder().decode(parts[1]));

       
        
        JSONObject payload = new JSONObject(payloadJson);

        System.out.println(payload);
        
        long iat = payload.getLong("iat");
        long exp = payload.getLong("exp");
        Date now = new Date(System.currentTimeMillis()); 
        
        Date issuedAt = new Date(iat * 1000); // Convert seconds to milliseconds
        Date expiresAt = new Date(exp * 1000);
    	
        System.out.println(expiresAt);
        System.out.println(now);
        
//        if (expiresAt.before(now)) {
//        	response.sendRedirect(request.getContextPath()+"/accessdenied");
//        }else {
        	response.sendRedirect(request.getContextPath()+"/welcome");
//        }
   }
    
    
    
    

}
