package com.vts.pfms.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Base64;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class PMSLogoUtil 
{
	@Value("${ApplicationFilesDrive}")
	private String ApplicationFilesDrive;
	
	public String getLabLogoAsBase64String(String LabCode) throws IOException
	{
		try {
			return Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ApplicationFilesDrive+"PMS/images/lablogos/"+LabCode.trim().toLowerCase()+".png")));
		}catch (FileNotFoundException e) {
			return Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(ApplicationFilesDrive+"PMS/images/lablogos/"+"lablogo"+".png")));
		}
	}
	
	
}
