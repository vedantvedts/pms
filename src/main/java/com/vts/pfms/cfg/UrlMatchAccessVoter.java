package com.vts.pfms.cfg;

import java.util.Collection;

import org.springframework.security.access.AccessDecisionVoter;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.FilterInvocation;

public class UrlMatchAccessVoter implements AccessDecisionVoter<Object>{

	
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
	public int vote(Authentication authentication, Object object, Collection<ConfigAttribute> attributes) 
	{
		
	String url;
	String fullurl = ((FilterInvocation) object).getRequestUrl();
	int firstQuestionMarkIndex = fullurl.indexOf("?");
	        
	if (firstQuestionMarkIndex != -1) {
		url=fullurl.substring(0, firstQuestionMarkIndex);
	}else {
	  	url=fullurl;
	}
	        
	      
	        
	     
		
		
		
		return ACCESS_DENIED;
		
	}

	
	
}
