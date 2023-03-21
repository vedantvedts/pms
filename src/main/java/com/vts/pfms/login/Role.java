package com.vts.pfms.login;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import lombok.ToString;
@ToString
@Entity
@Table(name = "pfms_role_security")
public class Role {
	
	 private Long RoleId;
	 private String RoleName;
 private Set<Login> Login;
	
	public String getRoleName() {
		return RoleName;
	}
	public void setRoleName(String roleName) {
		RoleName = roleName;
	}
	@ManyToMany(mappedBy = "roles")
	public Set<Login> getLogin() {
		return Login;
	}
	public void setLogin(Set<Login> login) {
		Login = login;
	}
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long getRoleId() {
		return RoleId;
	}
	public void setRoleId(Long roleId) {
		RoleId = roleId;
	}

   
    
}
