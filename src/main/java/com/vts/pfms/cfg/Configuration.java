package com.vts.pfms.cfg;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties("dg-pfms-service")
public class Configuration {
	private int minimum;
	private int maximum;
    private String file_upload_path;
	public int getMinimum() {
		return minimum;
	}

	public void setMinimum(int minimum) {
		this.minimum = minimum;
	}

	public int getMaximum() {
		return maximum;
	}

	public void setMaximum(int maximum) {
		this.maximum = maximum;
	}

	public String getFile_upload_path() {
		return file_upload_path;
	}

	public void setFile_upload_path(String file_upload_path) {
		this.file_upload_path = file_upload_path;
	}

	@Override
	public String toString() {
		return "Configuration [minimum=" + minimum + ", maximum=" + maximum + ", file_upload_path=" + file_upload_path
				+ "]";
	}

	
}
