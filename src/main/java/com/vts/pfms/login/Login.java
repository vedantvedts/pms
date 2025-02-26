package com.vts.pfms.login;


import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "login")
public class Login {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long LoginId;
    private String username;
    private String Password;
    private Long EmpId;
    private Long DivisionId;
    private Long FormRoleId;
    private String LoginType;
    private String LoginTypeDms;
    private String Pfms;
    private int IsActive;
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
}
