package com.vts.pfms.login;

import org.springframework.security.web.session.InvalidSessionStrategy;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomInvalidSessionStrategy implements InvalidSessionStrategy {
	
	@Override
	public void onInvalidSessionDetected(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    String requestUri = request.getRequestURI();
	    String contextPath = request.getContextPath();

	    // Prevent redirect loop by excluding sessionInvalid URL
	    if (requestUri.contains("sessionInvalid") || requestUri.contains("sessionExpired")) {
	        return; // Avoid further redirection
	    }

	    String loginPage = (String) request.getAttribute("loginPage");
	    try {
	        if ("wr".equals(loginPage)) {
	            response.sendRedirect(contextPath + "/wr?sessionInvalid");
	        } else {
	            response.sendRedirect(contextPath + "/login?sessionInvalid");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

    
}