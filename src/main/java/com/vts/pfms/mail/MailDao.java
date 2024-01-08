package com.vts.pfms.mail;

import java.util.List;

public interface MailDao {
	public List<Object[]> getTodaysMeetings(String date)throws Exception;

	public List<Object[]> GetMailPropertiesByTypeOfHost(String typeOfHost)throws Exception;
}
