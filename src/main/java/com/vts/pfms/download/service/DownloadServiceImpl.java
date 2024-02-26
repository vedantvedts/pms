package com.vts.pfms.download.service;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vts.pfms.download.controller.TemplateAttributes;
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

	@Override
	public Object[] reqAttachDownload(String attachmentid) throws Exception {
		// TODO Auto-generated method stub
		return dao.reqAttachDownload( attachmentid);
	}
	
	@Override
	public Object[] getLabDetails(String labCode) throws Exception {
		// TODO Auto-generated method stub
		return dao.getLabDetails(labCode);
	}
	
	@Override
	public Long TemplateAttributesAdd(TemplateAttributes ta) throws Exception {
		// TODO Auto-generated method stub
		return dao.TemplateAttributesAdd(ta);
	}
	
	@Override
	public TemplateAttributes TemplateAttributesEditById(long Attributid) throws Exception {
		
		return dao.TemplateAttributesEditById(Attributid);
	}
	
	@Override
	public long TemplateAttributesEdit(TemplateAttributes AttributId) throws Exception {
		
		
		return dao.TemplateAttributesEdit(AttributId);
	}
	@Override
	public Object[] ProjectDataTempAttr() throws Exception {
		
		return dao.ProjectDataTempAttr();
	}
}
