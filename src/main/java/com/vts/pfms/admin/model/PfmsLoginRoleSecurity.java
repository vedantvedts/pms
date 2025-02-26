package com.vts.pfms.admin.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "pfms_login_role_security")
public class PfmsLoginRoleSecurity implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long LoginRoleSecurityId;
	private Long LoginId;
	private Long RoleId;
	public Long getLoginRoleSecurityId() {
		return LoginRoleSecurityId;
	}
	public void setLoginRoleSecurityId(Long loginRoleSecurityId) {
		LoginRoleSecurityId = loginRoleSecurityId;
	}
	public Long getLoginId() {
		return LoginId;
	}
	public void setLoginId(Long loginId) {
		LoginId = loginId;
	}
	public Long getRoleId() {
		return RoleId;
	}
	public void setRoleId(Long roleId) {
		RoleId = roleId;
	}
	
	
	
	
}
