package com.vts.pfms.cfg;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDecisionVoter;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.vote.AuthenticatedVoter;
import org.springframework.security.access.vote.RoleVoter;
import org.springframework.security.access.vote.UnanimousBased;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.expression.WebExpressionVoter;
import org.springframework.security.web.authentication.logout.LogoutHandler;

import com.vts.pfms.login.CustomAuthenticationFailureHandler;
import com.vts.pfms.login.CustomInvalidSessionStrategy;
import com.vts.pfms.login.CustomLogoutHandler;
import com.vts.pfms.login.CustomSessionExpiredStrategy;
import com.vts.pfms.login.LoginSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter
{
	
	 @Autowired
	 private UserDetailsService userDetailsService;

	 @Autowired
     private LoginSuccessHandler successHandler;
	 
	 @Autowired
	 private CustomAuthenticationFailureHandler customAuthenticationFailureHandler;
	 
	 @Autowired
	 private CustomInvalidSessionStrategy customInvalidSessionStrategy;
	 
	 @Autowired
	 private CustomSessionExpiredStrategy customSessionExpiredStrategy;
	 
	 @Override
	 @Bean
	 public AuthenticationManager authenticationManagerBean() throws Exception {
	     return super.authenticationManagerBean();
	 }
	 
	 	 
	 @Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		 auth.userDetailsService(userDetailsService).passwordEncoder(passwordencoder());
	}
	
	 
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		  http.authorizeRequests()
		
		  .antMatchers("/").hasAnyRole("USER","ADMIN")
		  .antMatchers("/webjars/**", "/resources/**", "/view/**", "/LoginPage/*", "/pfms-dg/*", "/api/sync/**", 
				  "/login", "/wr", "/login?sessionInvalid", "/login?sessionExpired", "/wr?sessionInvalid", "/wr?sessionExpired",
				  "/ProjectRequirementAttachmentDownload.htm", "/ProjectClosureChecklistFileDownload.htm", "/TimeSheetWorkFlowPdf.htm").permitAll()
		  .anyRequest().authenticated().accessDecisionManager(adm())
		  
		  .and()
			  .formLogin()
	          .loginPage("/login") // Your custom login page
	          .defaultSuccessUrl("/welcome", true) // Success URL after successful login
	          .failureUrl("/login?error") // Failure URL after unsuccessful login
	          .failureHandler(customAuthenticationFailureHandler) // Custom failure handler
	          .permitAll()
		    .usernameParameter("username").passwordParameter("password").successHandler(successHandler)
		  .and()
		  .logout()
		  .logoutSuccessHandler((request, response, authentication) -> {
		        HttpSession session = request.getSession(false);  // Get the current session without creating a new one
		        if (session != null) {
		            String loginPage = (String) session.getAttribute("loginPage");

		            // Handle redirect based on session attributes
		            if ("wr".equals(loginPage)) {
		                response.sendRedirect(request.getContextPath() + "/wr?logout");
		            } else {
		                response.sendRedirect(request.getContextPath() + "/login?logout");
		            }
		        } else {
		            response.sendRedirect(request.getContextPath() + "/login?logout");  // Fallback
		        }
		    })
		    .invalidateHttpSession(false) 
          .permitAll()

		   .and()
		   .exceptionHandling().accessDeniedPage("/login?accessDenied")
		 
		    
		    .and()
		    
		    .csrf()
		    .and().sessionManagement()
		    .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
		    .sessionFixation().migrateSession()
			.invalidSessionUrl("/login?sessionInvalid")
			//.invalidSessionStrategy(customInvalidSessionStrategy)
			.maximumSessions(2)
			.maxSessionsPreventsLogin(false)
			.expiredUrl("/login?sessionExpired")
			//.expiredSessionStrategy(customSessionExpiredStrategy)
		    //.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED).invalidSessionUrl("/login")
		    
		    ;
		}
	 
	
	
	
	@Bean
	public AccessDecisionManager  adm() {
		List<AccessDecisionVoter<? extends Object>> DecisionVoter= Arrays.asList(new RoleVoter(),new AuthenticatedVoter(),new WebExpressionVoter(),new RealTimeLockVoter());
		
		return  new UnanimousBased(DecisionVoter);
	}
	
	

	
	class RealTimeLockVoter implements AccessDecisionVoter<Object>{

		@Override
		public boolean supports(ConfigAttribute attribute) {
			// TODO Auto-generated method stub
			return true;
		}

		@Override
		public boolean supports(Class<?> clazz) {
			// TODO Auto-generated method stub
			return true;
		}

		@Override
		public int vote(Authentication authentication, Object object, Collection<ConfigAttribute> attributes) {
	

			/*
			 * if(url.equalsIgnoreCase("DemandInitiationList.htm")) { return ACCESS_GRANTED;
			 * } }
			 */
			
			return ACCESS_GRANTED;
		}
		
	}
	
	
	
	
	
	
	
	
		public PasswordEncoder passwordencoder(){
	     return new BCryptPasswordEncoder();
	    }
		
		
		
		@Bean
		public LogoutHandler  logoutSuccessHandler() {
		return  new CustomLogoutHandler();
		}
		
	
		
		
		
}
