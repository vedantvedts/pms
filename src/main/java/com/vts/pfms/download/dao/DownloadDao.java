package com.vts.pfms.download.dao;

import com.vts.pfms.download.controller.TemplateAttributes;

public interface DownloadDao {

	public Object[] AgendaDocLinkDownload(String filerepid) throws Exception;

	public Object[] ProjectDataSpecsFileData(String projectdataid) throws Exception;

	public Object[] reqAttachDownload(String attachmentid)throws Exception;

	public Long TemplateAttributesAdd(TemplateAttributes ta) throws Exception;

	public Object[] getLabDetails(String labCode) throws Exception;

}
