package com.vts.pfms.login;

import org.springframework.security.web.session.SessionInformationExpiredEvent;
import org.springframework.security.web.session.SessionInformationExpiredStrategy;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomSessionExpiredStrategy implements SessionInformationExpiredStrategy {
	
	@Override
	public void onExpiredSessionDetected(SessionInformationExpiredEvent event) throws IOException {
	    HttpServletRequest request = event.getRequest();
	    HttpServletResponse response = event.getResponse();
	    String requestUri = request.getRequestURI();
	    String contextPath = request.getContextPath();

	    // Prevent redirect loop by excluding sessionExpired URL
	    if (requestUri.contains("sessionInvalid") || requestUri.contains("sessionExpired")) {
	        return; // Avoid further redirection
	    }

	    String loginPage = (String) request.getAttribute("loginPage");
	    try {
	        if ("wr".equals(loginPage)) {
	            response.sendRedirect(contextPath + "/wr?sessionExpired");
	        } else {
	            response.sendRedirect(contextPath + "/login?sessionExpired");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

    
}
