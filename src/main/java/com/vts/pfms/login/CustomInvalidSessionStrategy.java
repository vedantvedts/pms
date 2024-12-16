package com.vts.pfms.login;

import org.springframework.security.web.session.InvalidSessionStrategy;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.http.HttpSession;

public class CustomInvalidSessionStrategy implements InvalidSessionStrategy {

    @Override
    public void onInvalidSessionDetected(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); // Session might be null
        String loginPage = "login"; // Default fallback

        if (session != null) {
            Object loginPageAttr = session.getAttribute("loginPage");
            if (loginPageAttr != null) {
                loginPage = loginPageAttr.toString();
            }
        }

        // Redirect dynamically based on loginPage
        response.sendRedirect(request.getContextPath() + "/" + loginPage + "?error=session");
    }
}

