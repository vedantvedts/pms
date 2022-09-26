package com.vts.pfms.download.dao;

public interface DownloadDao {

	public Object[] AgendaDocLinkDownload(String filerepid) throws Exception;

	public Object[] ProjectDataSpecsFileData(String projectdataid) throws Exception;

}
