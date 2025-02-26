package com.vts.pfms.mail;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;



import lombok.Data;
import lombok.NoArgsConstructor;
@NoArgsConstructor
@Data
@Entity
@Table(name="mail_configuration")
public class MailConfiguration {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private long MailConfigurationId;
	private String TypeOfHost;
	private String Host;
	private String Port;
	private String Username;
	private String Password;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
	private String ModifiedBy;
	private String ModifiedDate;
	
}