package com.vts.pfms.login;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.vts.pfms.pfmsserv.feign.MdmClient;

import feign.FeignException;
import jakarta.servlet.http.HttpServletRequest;

@Component
public class RemoteAuthProvider implements AuthenticationProvider {

    private static final Logger log = LoggerFactory.getLogger(RemoteAuthProvider.class);

    @Value("${is-mdm-connected}")
    private boolean isMdmConnected;

    private final MdmClient remoteAuthClient;
    private final DaoAuthenticationProvider defaultProvider;   // Spring's standard login
    private final HttpServletRequest request;
 // field + constructor assignment: this.userDetailsService = userDetailsService;
    private final UserDetailsService userDetailsService;
    
    public RemoteAuthProvider(MdmClient remoteAuthClient,
                              UserDetailsService userDetailsService,
                              PasswordEncoder passwordEncoder,
                              HttpServletRequest request,
                              UserDetailsService useDetailsService) {
        this.remoteAuthClient = remoteAuthClient;
        this.defaultProvider = new DaoAuthenticationProvider();
        this.defaultProvider.setUserDetailsService(userDetailsService);
        this.defaultProvider.setPasswordEncoder(passwordEncoder);
        this.request = request;
        this.userDetailsService = useDetailsService;
    }

    @Override
    public Authentication authenticate(Authentication authentication) {

        String username = authentication.getName();

        // PasswordDecryptFilter already decrypted it, so the password arrives as plain text
        Object credentials = authentication.getCredentials();
        if (credentials == null) {
            throw new BadCredentialsException("Invalid username or password");
        }
        String password = credentials.toString();

        Object rawDetails = authentication.getDetails();

        CustomAuthDetails details = (CustomAuthDetails) rawDetails;
       

        // MDM connected: MDM validates the login
        if (isMdmConnected) {
            try {
                AuthenticationRequest mdmRequest = new AuthenticationRequest();
                mdmRequest.setUsername(username);
                mdmRequest.setPassword(password);
                mdmRequest.setTimestamp(details.getClientTimestamp());

                ErrorResponse result = remoteAuthClient.getAuthentication(mdmRequest).getBody();
                

                if (result == null) {
                    throw new AuthenticationServiceException("Empty response from MDM");
                }
                if (result.getStatus() != 200) {
                    throw new BadCredentialsException(result.getMessage());
                }
                if(result.getStatus() == 200 && "DEFAULT_PASSWORD".equals(result.getErrorCode())) {
                	request.getSession().setAttribute("isDefaultPassword", "Y");
                }
                UserDetails local;
                try {
                    local = userDetailsService.loadUserByUsername(username);
                } catch (UsernameNotFoundException e) {
                    throw new BadCredentialsException("User is not enabled for PMS");
                }

                UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, null, local.getAuthorities());

                token.setDetails(details);

                return token;

            } catch (AuthenticationException e) {
                request.getSession().setAttribute("SPRING_SECURITY_LAST_EXCEPTION", e);
                throw e;
            } catch (FeignException e) {
                // MDM answered with an HTTP error status
                System.out.println("[AUTH] FAIL (FeignException): http status = " + e.status()
                        + ", message = " + e.getMessage());
                if (e.status() == 400 || e.status() == 401 || e.status() == 403) {
                    throw new BadCredentialsException("Invalid username or password");
                }
                log.error("MDM login failed with HTTP status {}", e.status(), e);
                throw new AuthenticationServiceException("MDM unavailable", e);
            } catch (Exception e) {
                e.printStackTrace();
                log.error("MDM login failed", e);
                throw new AuthenticationServiceException("MDM unavailable", e);
            }
        }

        try {
            Authentication plain = new UsernamePasswordAuthenticationToken(username, password);
            Authentication result = defaultProvider.authenticate(plain);

            // keep the browser details on the final token
            ((AbstractAuthenticationToken) result).setDetails(details);
            return result;
        } catch (AuthenticationException e) {
            throw e;
        }
    }

    @Override
    public boolean supports(Class<?> auth) {
        boolean ok = UsernamePasswordAuthenticationToken.class.isAssignableFrom(auth);
        return ok;
    }
}