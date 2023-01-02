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
	private String LabLogoPath;
	
	public String getLabLogoAsBase64String(String LabCode) throws IOException
	{
		String path = LabLogoPath+"/images/lablogos/"+LabCode.trim().toLowerCase()+".png";
		try {
			return Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(path)));
		}catch (FileNotFoundException e) {
			System.err.println("File Not Found at Path "+path);
			return Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(LabLogoPath+"/images/lablogos/"+"lablogo"+".png")));
		}
	}
	
	
	public String getDRDOLogoAsBase64String() throws IOException
	{
		try {
			return Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(LabLogoPath+"/images/lablogos/drdo.png")));
		}catch (FileNotFoundException e) {
			System.err.println("File Not Found at Path "+LabLogoPath+"/images/lablogos/"+"lablogo"+".png");
			return null;
		}
	}
	
}
