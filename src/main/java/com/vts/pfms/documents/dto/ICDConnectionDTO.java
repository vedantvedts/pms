package com.vts.pfms.documents.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ICDConnectionDTO {
	
    private Long ICDConnectionId;
    private Long ICDDocId;
    private String DrawingNo;
    private String DrawingAttach;
    
    private String SubSystemIdsS1;
    private String SubSystemIdsS2;
    private String LevelNamesS1;
    private String LevelNamesS2;
    private String LevelCodesS1;
    private String LevelCodesS2;
    private String ElementTypesS1;
    private String ElementTypesS2;
    
    private String InterfaceIds;
    private String InterfaceCodes;
    private String InterfaceNames;
    private String InterfaceTypes;
    private String ParameterDatas;
    
    private String Purpose;
    private String PurposeIds;
    
   

}

