package com.vts.pfms.mail;

import java.util.List;

public interface MailService {
	public List<Object[]> getTodaysMeetings(String date)throws Exception;

	public MailConfigurationDto getMailConfigByTypeOfHost(String typeOfHost)throws Exception;
}
