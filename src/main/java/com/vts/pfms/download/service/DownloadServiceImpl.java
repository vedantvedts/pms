package com.vts.pfms.download.service;

import java.util.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.download.dao.DownloadDao;

@Service
public class DownloadServiceImpl implements DownloadService
{
	
	
	@Autowired DownloadDao dao;
	
	private static final Logger logger=LogManager.getLogger(DownloadServiceImpl.class);
	
	@Override
	public Object[] AgendaDocLinkDownload(String filerepid)throws Exception
	{
		return dao.AgendaDocLinkDownload(filerepid);
	}
	
	@Override
	public Object[] ProjectDataSpecsFileData(String projectdataid) throws Exception
	{
		return dao.ProjectDataSpecsFileData(projectdataid);
	}
	
}
