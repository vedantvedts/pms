package com.vts.pfms.download.service;

import com.vts.pfms.download.controller.TemplateAttributes;

public interface DownloadService {

	public Object[] AgendaDocLinkDownload(String filerepid) throws Exception;
	public Object[] ProjectDataSpecsFileData(String projectdataid) throws Exception;
	public Object[] reqAttachDownload(String attachmentid) throws Exception;
	public Long TemplateAttributesAdd(TemplateAttributes ta)throws Exception;
	public Object[] getLabDetails(String labCode) throws Exception;
	public TemplateAttributes TemplateAttributesEditById(long Attributid) throws Exception;
	public long TemplateAttributesEdit(TemplateAttributes AttributId) throws Exception;
	public Object[] ProjectDataTempAttr() throws Exception;
}
