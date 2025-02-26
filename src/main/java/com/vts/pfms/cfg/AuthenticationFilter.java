package com.vts.pfms.cfg;

import java.io.IOException;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;

//@Component
public class AuthenticationFilter extends OncePerRequestFilter {
	
	@Autowired
	Environment env;
	
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
      FilterChain filterChain) throws ServletException, IOException {
    	boolean status;

		try {
			Jws<Claims> claims = Jwts.parser().setSigningKey("vts-123").parseClaimsJws(env.getProperty("license"));
			status= true;
		} catch (SignatureException | MalformedJwtException | UnsupportedJwtException | IllegalArgumentException ex) {
			status= false;
		} catch (ExpiredJwtException ex) {
			status= false;
		}
		System.out.println("status: "+status);
		if(!status) {
			 
			response.sendRedirect(request.getContextPath()+"/accessdenied");
		}
        filterChain.doFilter(request, response);
    }
}
