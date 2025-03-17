package com.vts.pfms.login;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;

import com.vts.pfms.service.RfpMainService;

public class CustomLogoutHandler implements LogoutHandler  {

	@Autowired
	RfpMainService rfpmainservice;


	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
		HttpSession ses=request.getSession();
		try {
			String LogId = ((Long) ses.getAttribute("LoginId")).toString();
			String loginPage = (String) ses.getAttribute("loginPage");
			
			rfpmainservice.LoginStampingUpdate(LogId, "L");

			// Handle redirect based on session attributes
			if ("wr".equalsIgnoreCase(loginPage)) {
				response.sendRedirect(request.getContextPath() + "/wr?logout");
			} else {
				response.sendRedirect(request.getContextPath() + "/login?logout");
			}

		}
		catch (Exception e) {
			e.printStackTrace();
		}	
	}


}
