package com.vts.pfms.milestone.dto;

import java.io.InputStream;


public class FileUploadDto {
	private String UserId;
	private String PathName;
	private String ProjectId;
	private String FileId;
	private String FileName;
    private String FileNamePath;
    private String Rel;
    private String Ver;
	private InputStream IS;
	private String Description;
	private String SubL1;
	private String Docid;
	public String getUserId() {
		return UserId;
	}
	public void setUserId(String userId) {
		UserId = userId;
	}
	public String getPathName() {
		return PathName;
	}
	public void setPathName(String pathName) {
		PathName = pathName;
	}
	public String getProjectId() {
		return ProjectId;
	}
	public void setProjectId(String projectId) {
		ProjectId = projectId;
	}
	public String getFileId() {
		return FileId;
	}
	public void setFileId(String fileId) {
		FileId = fileId;
	}
	public String getFileName() {
		return FileName;
	}
	public void setFileName(String fileName) {
		FileName = fileName;
	}
	public String getFileNamePath() {
		return FileNamePath;
	}
	public void setFileNamePath(String fileNamePath) {
		FileNamePath = fileNamePath;
	}
	public String getRel() {
		return Rel;
	}
	public void setRel(String rel) {
		Rel = rel;
	}
	public String getVer() {
		return Ver;
	}
	public void setVer(String ver) {
		Ver = ver;
	}
	public InputStream getIS() {
		return IS;
	}
	public void setIS(InputStream iS) {
		IS = iS;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public String getSubL1() {
		return SubL1;
	}
	public void setSubL1(String subL1) {
		SubL1 = subL1;
	}
	public String getDocid() {
		return Docid;
	}
	public void setDocid(String docid) {
		Docid = docid;
	}
	
	

}
