package com.vts.pfms.requirements.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "pfms_systemsub_introduction")
public class PfmsSystemSubIntroduction {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "introductionId")
    private Long introductionId;

    @Column(name = "mainId")
    private Long mainId;

    
    @Column(name = "Introduction")
    private String introduction;

    @Lob
    @Column(name = "Details")
    private String Details;


    @Column(name = "CreatedBy", length = 100)
    private String createdBy;

    @Column(name = "CreatedDate", length = 100)
    private String createdDate;

    @Column(name = "ModifiedBy", length = 100)
    private String modifiedBy;

    @Column(name = "ModifiedDate", length = 100)
    private String modifiedDate;

    @Column(name = "isActive")
    private Integer isActive;
}
