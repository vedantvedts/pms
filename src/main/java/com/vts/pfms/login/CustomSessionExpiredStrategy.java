package com.vts.pfms.login;

import org.springframework.security.web.session.SessionInformationExpiredEvent;
import org.springframework.security.web.session.SessionInformationExpiredStrategy;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CustomSessionExpiredStrategy implements SessionInformationExpiredStrategy {

    @Override
    public void onExpiredSessionDetected(SessionInformationExpiredEvent event) throws IOException {
        HttpServletRequest request = event.getRequest();
        HttpServletResponse response = event.getResponse();
        HttpSession session = request.getSession(false); // Session might be null
        String loginPage = "login"; // Default fallback

        if (session != null) {
            Object loginPageAttr = session.getAttribute("loginPage");
            if (loginPageAttr != null) {
                loginPage = loginPageAttr.toString();
            }
        }

        // Redirect dynamically based on loginPage
        response.sendRedirect(request.getContextPath() + "/" + loginPage);
    }
}

