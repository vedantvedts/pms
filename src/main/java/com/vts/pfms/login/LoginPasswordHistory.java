package com.vts.pfms.login;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "pfms_login_password_history")
public class LoginPasswordHistory {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY )
	private Long PasswordHistoryId;
	private Long LoginId;
	private String Password;
	private String ActionType;
	private Long ActionBy;
	private String ActionDate;

}
