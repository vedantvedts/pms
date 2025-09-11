package com.vts.pfms.cfg;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class PasswordDecryptFilter extends OncePerRequestFilter {

	private String decrypt(String encrypted, String sessionKey, String sessionIv) throws Exception {
	    byte[] keyBytes = Base64.getDecoder().decode(sessionKey);
	    byte[] ivBytes  = Base64.getDecoder().decode(sessionIv);

	    SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
	    IvParameterSpec ivSpec = new IvParameterSpec(ivBytes);

	    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	    cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);

	    byte[] decodedBytes = Base64.getDecoder().decode(encrypted);
	    byte[] decryptedBytes = cipher.doFinal(decodedBytes);

	    return new String(decryptedBytes, StandardCharsets.UTF_8);
	}

	@Override
	protected void doFilterInternal(HttpServletRequest request,
	                                HttpServletResponse response,
	                                FilterChain filterChain) throws ServletException, IOException {
	    String path = request.getServletPath();
	    boolean isLogin = "/login".equals(path);
	    boolean isPwdChange = "/PasswordChanges.htm".equals(path);

	    if ((isLogin || isPwdChange) && "POST".equalsIgnoreCase(request.getMethod())) {
	        String sessionKey  = (String) request.getSession().getAttribute("LOGIN_AES_KEY");
	        String sessionIv   = (String) request.getSession().getAttribute("LOGIN_AES_IV");

	        if (sessionKey != null && sessionIv != null) {
	            try {
	                HttpServletRequest wrappedRequest = new HttpServletRequestWrapper(request) {
	                    @Override
	                    public String getParameter(String name) {
	                        try {
	                            if ("password".equals(name) || 
	                                "OldPassword".equals(name) || 
	                                "NewPassword".equals(name)) {
	                                String encrypted = super.getParameter(name);
	                                if (encrypted != null && !encrypted.isEmpty()) {
	                                    return decrypt(encrypted, sessionKey, sessionIv);
	                                }
	                            }
	                        } catch (Exception e) {
	                            e.printStackTrace();
	                        }
	                        return super.getParameter(name);
	                    }
	                };

	                filterChain.doFilter(wrappedRequest, response);
	                return;
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }

	    filterChain.doFilter(request, response);
	}


}


