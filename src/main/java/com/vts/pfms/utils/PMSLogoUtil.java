package com.vts.pfms.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.util.Base64;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.ibm.icu.text.SimpleDateFormat;

@Component
public class PMSLogoUtil 
{
	@Value("${ApplicationFilesDrive}")
	private String LabLogoPath;
	SimpleDateFormat  inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
	
	public String getLabLogoAsBase64String(String LabCode) throws IOException
	{
		String path = LabLogoPath+"/images/lablogos/"+LabCode.trim().toLowerCase()+".png";
		try {
			return Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(new File(path)));
		}catch (FileNotFoundException e) {
			System.err.println("File Not Found at Path "+path);
			File lablogo = new File(LabLogoPath+"/images/lablogos/"+"lablogo"+".png");
			if(lablogo.exists()) {
				return Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(lablogo));
			}
			else
			{
				return null;
			}
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
	public String formatD(String date) throws ParseException {
		String approvedDate=outputFormat.format(inputFormat.parse(date));
		String[] approvedDate2=approvedDate.toString().split(":");
		String approvedDateFormatted=approvedDate2[0]+" : "+approvedDate2[1];
		return approvedDateFormatted;
	}
	
}
