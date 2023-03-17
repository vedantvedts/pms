package com.vts.pfms.download.service;

public interface DownloadService {

	public Object[] AgendaDocLinkDownload(String filerepid) throws Exception;
	public Object[] ProjectDataSpecsFileData(String projectdataid) throws Exception;
	public Object[] reqAttachDownload(String attachmentid) throws Exception;

}
