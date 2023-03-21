package com.vts.pfms.login;


import java.util.Date;
import java.util.HashSet;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    private LoginRepository loginRepository;
    @Autowired
  
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    
    private static final Logger logger=LogManager.getLogger(LoginServiceImpl.class);

    @Override
    public void save(Login login) {
    	logger.info(new Date() +"Inside save");
    	login.setPassword(bCryptPasswordEncoder.encode(login.getPassword()));
//        HashSet<Role> test=new HashSet<Role>();
//        test.add(roleRepository.findAll().get(0));
//        login.setRoles(test);
        loginRepository.save(login);
    }

    @Override
    public Login findByUsername(String loginName) {
        return loginRepository.findByUsername(loginName);
    }
}
