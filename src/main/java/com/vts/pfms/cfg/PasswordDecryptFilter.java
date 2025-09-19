package com.vts.pfms.cfg;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class PasswordDecryptFilter extends OncePerRequestFilter {
	
	private static final Logger logger=LogManager.getLogger(PasswordDecryptFilter.class);

	private boolean isValidBase64(String input) {
	    if (input == null || input.isEmpty()) {
	        return false;
	    }
	    String base64Pattern = "^[A-Za-z0-9+/]*={0,2}$";
	    if (!input.matches(base64Pattern)) {
	        return false;
	    }
	    return input.length() % 4 == 0;
	}
	
	private String decrypt(String encrypted, String sessionKey, String sessionIv) throws Exception {
	    try {
	    	
	    	if (!isValidBase64(encrypted)) {
	            throw new IllegalArgumentException("Invalid Base64 input.");
	        }
	        if (!isValidBase64(sessionKey) || !isValidBase64(sessionIv)) {
	            throw new IllegalArgumentException("Invalid encryption keys.");
	        }
	        
	        byte[] keyBytes = Base64.getDecoder().decode(sessionKey);
	        byte[] ivBytes  = Base64.getDecoder().decode(sessionIv);

	        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
	        IvParameterSpec ivSpec = new IvParameterSpec(ivBytes);

	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	        cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);

	        byte[] decodedBytes = Base64.getDecoder().decode(encrypted);

	        if (decodedBytes.length % 16 != 0) {
	            throw new IllegalArgumentException("Invalid encrypted input length.");
	        }

	        byte[] decryptedBytes = cipher.doFinal(decodedBytes);

	        return new String(decryptedBytes, StandardCharsets.UTF_8);
	    } catch (IllegalArgumentException e) {
	        throw e;
	    } catch (javax.crypto.BadPaddingException | javax.crypto.IllegalBlockSizeException e) {
	        throw new IllegalArgumentException("Invalid encrypted data.", e);
	    }
	}


	@Override
	protected void doFilterInternal(HttpServletRequest request,
	                                HttpServletResponse response,
	                                FilterChain filterChain) throws ServletException, IOException {
	    String path = request.getServletPath();
	    boolean isLogin = "/login".equals(path);
	    boolean isPwdChange = "/PasswordChanges.htm".equals(path);
	    boolean isNewPwdChange = "/NewPasswordChangeCheck.htm".equals(path);

	    if ((isLogin || isPwdChange || isNewPwdChange) && "POST".equalsIgnoreCase(request.getMethod())) {
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
	                                "NewPassword".equals(name) || 
	                                "oldpass".equals(name)) {
	                                String encrypted = super.getParameter(name);
	                                if (encrypted != null && !encrypted.isEmpty()) {
	                                	try {
	                                        return decrypt(encrypted, sessionKey, sessionIv);
	                                    } catch (Exception e) {
	                                    	 logger.warn("Invalid encrypted input for parameter '{}': {}", name, e.getMessage());
	                                         
	                                         return "";
	                                    }
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
	            } catch (IllegalArgumentException e) {
	                logger.warn("Bad request due to invalid encrypted input: {}", e.getMessage());
	                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request parameters.");
	                return;
	            } catch (Exception e) {
	                logger.error("Unexpected error during decryption: {}", e.getMessage());
	                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal error.");
	                return;
	            }
	        }
	    }

	    filterChain.doFilter(request, response);
	}

}


