package com.vts.pfms.login;


public interface LoginService {
    void save(Login login);

    Login findByUsername(String username);
}
