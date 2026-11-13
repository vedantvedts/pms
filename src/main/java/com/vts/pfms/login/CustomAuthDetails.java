package com.vts.pfms.login;

import org.springframework.security.web.authentication.WebAuthenticationDetails;

import jakarta.servlet.http.HttpServletRequest;

public class CustomAuthDetails extends WebAuthenticationDetails {

    private final String clientTimestamp;
    private final String clientTimeZone;

    public CustomAuthDetails(HttpServletRequest request) {
        super(request);
        this.clientTimestamp = request.getParameter("clientTimestamp");
        this.clientTimeZone = request.getParameter("clientTimeZone");
    }

    public String getClientTimestamp() { return clientTimestamp; }
    public String getClientTimeZone() { return clientTimeZone; }
}