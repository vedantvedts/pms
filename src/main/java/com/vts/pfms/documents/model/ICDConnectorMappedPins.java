package com.vts.pfms.documents.model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name = "pfms_icd_connector_mapped_pins")
public class ICDConnectorMappedPins implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ConPinMappedId;
	private Long ConnectorPinMapId;
	private String ConnectorPinType;
	private Long ConnectorPinId;
	private String CreatedBy;
	private String CreatedDate;
	private int IsActive;
}
