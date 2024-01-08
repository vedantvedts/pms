package com.vts.pfms.mail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MailServiceImpl implements MailService {

	@Autowired
	MailDao dao;
	
	@Autowired
	ReversibleEncryptionAlg rea;
	@Override
	public List<Object[]> getTodaysMeetings(String date) throws Exception {
		// TODO Auto-generated method stub
		return dao.getTodaysMeetings(date);
	}
	@Override
	public MailConfigurationDto getMailConfigByTypeOfHost(String typeOfHost) throws Exception {
		  List<Object[]> mailPropertiesByTypeOfHost = dao.GetMailPropertiesByTypeOfHost(typeOfHost);
		    if (mailPropertiesByTypeOfHost != null && !mailPropertiesByTypeOfHost.isEmpty()) {
		        Object[] obj = mailPropertiesByTypeOfHost.get(0); // Assuming you only expect one result

		        if (obj[2] != null && obj[3] != null && obj[4] != null && obj[5] != null) {
		            MailConfigurationDto dto = new MailConfigurationDto();
		            dto.setHost(obj[2].toString());
		            dto.setPort(obj[3].toString());
		            dto.setUsername(obj[4].toString());
		            // Assuming you have a method to decrypt the password using aes algorithm
		            String decryptedPassword = rea.decryptByAesAlg(obj[5].toString());
		            dto.setPassword(decryptedPassword);

		            return dto;
		        } else {
		            return null;
		        }
		    } else {
		        return null;
		    }
	}
}
