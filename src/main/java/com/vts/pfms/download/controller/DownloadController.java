package com.vts.pfms.download.controller;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.vts.pfms.AESCryptor;
import com.vts.pfms.Zipper;
import com.vts.pfms.download.service.DownloadService;

@Controller
@RequestMapping("/download")
public class DownloadController {

	
	@Autowired
	DownloadService service;
	
	AESCryptor cryptor=new AESCryptor();
	
	private static final Logger logger=LogManager.getLogger(DownloadController.class);
	
	
	@RequestMapping(value = "AttachDocLinkDownload.htm")
	public void FileUnpack(Model model,HttpServletRequest req, HttpSession ses,HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");

		logger.info(new Date() +"Inside AttachDocLinkDownload.htm "+UserId);
		
		try {	
			String filerepid=cryptor.decryptParam(req.getParameter("filerepid"));
            Object[] obj=service.AgendaDocLinkDownload(filerepid);
            String path=req.getServletContext().getRealPath("/view/temp");
            Zipper zip=new Zipper();
            zip.unpack(obj[2].toString()+obj[3].toString()+obj[7].toString()+"-"+obj[6].toString()+".zip",path,obj[5].toString());
            res.setContentType("application/pdf");
            res.setHeader("Content-disposition","attachment;filename="+obj[4]); 
            File f=new File(path+"/"+obj[4]);
            FileInputStream fis = new FileInputStream(f);
            DataOutputStream os = new DataOutputStream(res.getOutputStream());
            res.setHeader("Content-Length",String.valueOf(f.length()));
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = fis.read(buffer)) >= 0) {
                os.write(buffer, 0, len);
            } 
            os.close();
            fis.close();
            Path pathOfFile2= Paths.get(path+"/"+obj[4]); 
            Files.delete(pathOfFile2);

		}
		catch (Exception e) {
			
			e.printStackTrace();  
			logger.error(new Date() +" Inside AttachDocLinkDownload.htm "+UserId, e); 
			
		}

	}
	
	
	@RequestMapping(value = "ProjectDataSystemSpecsFileDownload.htm")
	public void ProjectDataSystemSpecsFileDownload(HttpServletRequest req, HttpSession ses, HttpServletResponse res)throws Exception 
	{
		String UserId = (String) ses.getAttribute("Username");
		logger.info(new Date() +"Inside ProjectDataSystemSpecsFileDownload.htm "+UserId);
		try
		{
//			String ftype=AESCryptor.decrypt( req.getParameter("filename"));
			String ftype=req.getParameter("filename");
			String projectdataid=cryptor.decryptParam( req.getParameter("projectdataid"));
			
			System.out.println(projectdataid+"--------");
			
			res.setContentType("Application/octet-stream");	
			Object[] projectdatafiledata=service.ProjectDataSpecsFileData(projectdataid);
			File my_file=null;
			int index=3;
			if(ftype.equalsIgnoreCase("sysconfig")) 
			{
				index=4;
			}else if(ftype.equalsIgnoreCase("protree"))
			{
				index=5;
			}else if(ftype.equalsIgnoreCase("pearl"))
			{
				index=6;
			}else if(ftype.equalsIgnoreCase("sysspecs"))
			{
				index=3;
			}
		
			my_file = new File(projectdatafiledata[2]+File.separator+projectdatafiledata[index]); 
	        res.setHeader("Content-disposition","attachment; filename="+projectdatafiledata[index].toString()); 
	        OutputStream out = res.getOutputStream();
	        FileInputStream in = new FileInputStream(my_file);
	        byte[] buffer = new byte[4096];
	        int length;
	        while ((length = in.read(buffer)) > 0){   
	           out.write(buffer, 0, length);
	        }
	        in.close();
	        out.flush();
	        out.close();
			
		}catch (Exception e) {
				e.printStackTrace(); 
				logger.error(new Date() +"Inside ProjectDataSystemSpecsFileDownload.htm "+UserId,e);
		}
	}
		
	
		
}
