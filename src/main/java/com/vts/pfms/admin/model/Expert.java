package com.vts.pfms.admin.model;

import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Entity;
import java.io.Serializable;

@Entity
@Table(name = "expert")
public class Expert implements Serializable
{
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ExpertId;
    private String ExpertNo;
    private String Title;
    private String Salutation;
    private String ExpertName;
    private Long DesigId;
    private String ExtNo;
    private Long MobileNo;
    private String Email;
    private String Organization;
    private int IsActive;
    private String CreatedBy;
    private String CreatedDate;
    private String ModifiedBy;
    private String ModifiedDate;
    
    
    
    public String getTitle() {
		return Title;
	}

	public void setTitle(String title) {
		Title = title;
	}

	public String getSalutation() {
		return Salutation;
	}

	public void setSalutation(String salutation) {
		Salutation = salutation;
	}

	public Long getExpertId() {
        return this.ExpertId;
    }
    
    public void setExpertId(final Long expertId) {
        this.ExpertId = expertId;
    }
    
    public String getExpertNo() {
        return this.ExpertNo;
    }
    
    public void setExpertNo(final String expertNo) {
        this.ExpertNo = expertNo;
    }
    
    public String getExpertName() {
        return this.ExpertName;
    }
    
    public void setExpertName(final String expertName) {
        this.ExpertName = expertName;
    }
    
    public Long getDesigId() {
        return this.DesigId;
    }
    
    public void setDesigId(final Long desigId) {
        this.DesigId = desigId;
    }
    
    public String getExtNo() {
        return this.ExtNo;
    }
    
    public void setExtNo(final String extNo) {
        this.ExtNo = extNo;
    }
    
    public Long getMobileNo() {
        return this.MobileNo;
    }
    
    public void setMobileNo(final Long mobileNo) {
        this.MobileNo = mobileNo;
    }
    
    public String getEmail() {
        return this.Email;
    }
    
    public void setEmail(final String email) {
        this.Email = email;
    }
    
    public String getOrganization() {
        return this.Organization;
    }
    
    public void setOrganization(final String organization) {
        this.Organization = organization;
    }
    
    public int getIsActive() {
        return this.IsActive;
    }
    
    public void setIsActive(final int isActive) {
        this.IsActive = isActive;
    }
    
    public String getCreatedBy() {
        return this.CreatedBy;
    }
    
    public void setCreatedBy(final String createdBy) {
        this.CreatedBy = createdBy;
    }
    
    public String getCreatedDate() {
        return this.CreatedDate;
    }
    
    public void setCreatedDate(final String createdDate) {
        this.CreatedDate = createdDate;
    }
    
    public String getModifiedBy() {
        return this.ModifiedBy;
    }
    
    public void setModifiedBy(final String modifiedBy) {
        this.ModifiedBy = modifiedBy;
    }
    
    public String getModifiedDate() {
        return this.ModifiedDate;
    }
    
    public void setModifiedDate(final String modifiedDate) {
        this.ModifiedDate = modifiedDate;
    }
}
