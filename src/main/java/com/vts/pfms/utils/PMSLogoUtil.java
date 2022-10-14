package com.vts.pfms.utils;

import java.io.File;
import java.io.IOException;
import java.util.Base64;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class PMSLogoUtil 
{
	@Value("${LabLogoPath}")
	private String LabLogoPath;
	
	public String getLabLogoAsBase64String(String LabCode) throws IOException
	{
		return Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(LabLogoPath+"/images/lablogos/"+LabCode.trim()+".png")));
	}
}
