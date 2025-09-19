package com.vts.pfms.cfg;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Set;

public class HostValidationFilter implements Filter {
    private static final Set<String> ALLOWED_HOSTS = Set.of("yourdomain.com", "localhost","192.168.1.150");

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String host = req.getHeader("Host");
        if (host != null && !ALLOWED_HOSTS.contains(host.split(":")[0])) {
            throw new ServletException("Invalid Host header");
        }
        chain.doFilter(request, response);
    }
}
