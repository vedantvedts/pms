package com.vts.pfms.login;


import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vts.pfms.dao.RfpMainDao;
import com.vts.pfms.master.proxy.MasterServiceProxy;
import com.vts.pfms.model.LoginStamping;

@Service
public class LoginDetailsServiceImpl implements UserDetailsService{
	private SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


	@Autowired
	private RfpMainDao pfmsmaindao;
	
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
    private LoginRepository loginRepository;

//	@Autowired	
//	private MasterServiceProxy loginclient;
	
    @Override
    @Transactional(readOnly = false)
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    	
    	Login login = loginRepository.findByUsername(username);
//    	Login login = loginclient.LoginDetails("VEDTS",username);
    	
        if(login != null && login.getIsActive()==1 && login.getPfms().equalsIgnoreCase("Y")) {
        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
//        for (Role role : login.getRoles()){
//            grantedAuthorities.add(new SimpleGrantedAuthority(role.getRoleName()));
//        }
        String IpAddress="Not Available";
        String str = ""; 
        String macAddress ="Not Available"; 	
     		try{
     			
     			IpAddress = request.getRemoteAddr();
     		 
	     		if("0:0:0:0:0:0:0:1".equalsIgnoreCase(IpAddress))
	     		{
	     			
	     			InetAddress ip = InetAddress.getLocalHost();
	     			IpAddress= ip.getHostAddress();
	     		}
     		
     		}
     		catch(Exception e)
     		{
     		IpAddress="Not Available";	
     		e.printStackTrace();	
     		}
     		try{
        LoginStamping stamping=new LoginStamping();
        stamping.setLoginId(login.getLoginId());
        stamping.setLoginDate(new java.sql.Date(new Date().getTime()));
        stamping.setUsername(login.getUsername());
        stamping.setIpAddress(IpAddress);
        stamping.setLoginDateTime(sdf1.format(new Date()));
        pfmsmaindao.LoginStampingInsert(stamping);
     		}catch (Exception e) {
				e.printStackTrace();
			}
       
        
        return new org.springframework.security.core.userdetails.User(login.getUsername(), login.getPassword(), grantedAuthorities);
    }
        else {
        	   throw new UsernameNotFoundException("username not found");
        }
    }
}
