package com.vts.pfms.login;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

//@WebFilter("/*") // This filter applies to all URLs, you can adjust it if needed
public class LoginPageFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic, if required. We don't need any here.
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        // Check if the session exists (ensure it's not null)
        HttpSession session = httpRequest.getSession(false);
        if (session != null) {
            // Retrieve the loginPage from the session
            String loginPage = (String) session.getAttribute("loginPage");

            // If the loginPage is not null, set it as a request attribute
            if (loginPage != null) {
                httpRequest.setAttribute("loginPage", loginPage);
            }
            
            System.out.println("********************* ####################loginPage  "+loginPage);
            System.out.println("********************* session.getAttribute() "+session.getAttribute("loginPage"));
        }

        // Continue processing the request by passing it down the filter chain
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Clean-up logic, if needed. We don't need any here.
    }
}

