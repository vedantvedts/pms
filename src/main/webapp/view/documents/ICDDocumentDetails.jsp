<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.documents.model.ICDSystemAttach"%>
<%@page import="com.vts.pfms.documents.model.ICDConnectionConnectors"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.util.Base64"%>
<%@page import="java.io.File"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.util.Comparator"%>
<%@page import="com.vts.pfms.documents.model.IGIConnector"%>
<%@page import="com.vts.pfms.documents.dto.ICDPinMapDTO"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.documents.dto.ICDConnectionDTO"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="java.util.stream.Stream"%>
<%@page import="com.vts.pfms.documents.model.IGIDocumentIntroduction"%>
<%@page import="com.vts.pfms.documents.model.IGIInterfaceTypes"%>
<%@page import="com.vts.pfms.documents.model.IGIInterfaceContent"%>
<%@page import="java.util.function.Function"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.vts.pfms.documents.model.PfmsICDDocument"%>
<%@page import="com.vts.pfms.documents.model.StandardDocuments"%>
<%@page import="com.vts.pfms.documents.model.IGIInterface"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.model.IGIDocumentShortCodes"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <jsp:include page="../static/header.jsp"></jsp:include>
    
    <spring:url value="/resources/css/Overall.css" var="StyleCSS" />
    <link href="${StyleCSS}" rel="stylesheet" /> 
    <spring:url value="/resources/js/excel.js" var="excel" />
    <script src="${excel}"></script>
    
	<!-- Pdfmake  -->
	<spring:url value="/resources/pdfmake/pdfmake.min.js" var="pdfmake" />
	<script src="${pdfmake}"></script>
	<spring:url value="/resources/pdfmake/vfs_fonts.js" var="pdfmakefont" />
	<script src="${pdfmakefont}"></script>
	<spring:url value="/resources/pdfmake/htmltopdf.js" var="htmltopdf" />
	<script src="${htmltopdf}"></script> 
	
	<!-- Summer Note -->
	<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
	<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
	<script src="${SummernoteJs}"></script>
	<link href="${SummernoteCss}" rel="stylesheet" />
<style type="text/css">

.topicsSideBar {
	min-height: 670px;
    max-height: 670px;
    overflow-y: auto;
    overflow-x: hidden;
    scrollbar-width: thin;
  	scrollbar-color: #4B70F5 #f8f9fa;
}

.modulecontainer {
	display: flex;
	flex-direction: column;
	gap: 20px;
	/* margin : 2rem 0rem 1rem 9rem; */
}

.module{
 	max-width: 280px;
 	min-width: 280px;
 	max-height: 60px;
 	min-height: 60px;
 	overflow: hidden;
 	cursor: pointer;
    border-top: 3px solid #007bff;
    border-left: 3px solid #007bff;
    border-radius: 0.5rem;
    box-shadow: 0px 20px 40px -20px #a3a5ae;
 }
 
 .module:hover {
 	background-color: #007bff !important;
 	color: white !important;
 }
 
 .topic-name {
 	font-weight: bold;
 	font-size: 14px;
 }
 
 #reqdiv {
 	width: 100%;
 	margin: 0 0.7rem 0.7rem 0.7rem; 
 }
 
 img{
 	width: 25px;
 }
 
 /* Custom colspan */
.col-custom-1-5 {
    width: calc(17.5%); /* This gives 2.5 out of 12 columns */
    flex: 0 0 calc(17.5%);
    max-width: calc(17.5%);
}

@media (max-width: 768px) {
    .col-custom-1-5 {
        width: 100%;
        flex: 0 0 100%;
        max-width: 100%;
    }
}

.col-custom-10-5 {
    width: calc(81.5%); 
    flex: 0 0 calc(81.5%);
    max-width: calc(81.5%);
    margin-left: 0.4rem;
}

@media (max-width: 768px) {
    .col-custom-10-5 {
        width: 100%;
        flex: 0 0 100%;
        max-width: 100%;
    }
}

/* Summer Note styles */
.note-editor {
	width: 100% !important;
} 
	
.customtable{
	border-collapse: collapse;
	width: 100%;
	margin: 1.5rem 0.5rem 0.5rem 0.5rem;
	overflow-y: auto; 
	overflow-x: auto;  
}
.customtable th{
	border: 1px solid #0000002b; 
	padding: 10px;
		background-color: #2883c0;
}
.customtable td{
	border: 1px solid #0000002b; 
	padding: 5px;
}

.customtable thead {
	text-align: center;
	color: white;
	position: sticky;
	top: 0; /* Keeps the header at the top */
	z-index: 10; /* Ensure the header stays on top of the body */
	/* background-color: white; */ /* For visibility */
}

.table-wrapper {
    max-height: 400px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: hidden; /* Enable vertical scrolling */
}

/* Loading spinner styling */
#loading {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 18px;
    color: #333;
}

@keyframes spin {
	0% { transform: rotate(0deg); }
	100% { transform: rotate(360deg); }
}

.select2-container {
	width: 100% !important;
}
</style>    

</head>
<%	
	String isPdf = (String)request.getAttribute("isPdf");
	String pdfForSystem = (String)request.getAttribute("pdfForSystem");
	String systemId = (String)request.getAttribute("systemId");
%>
<body <%if(isPdf!=null && isPdf.equalsIgnoreCase("Y") || (pdfForSystem!=null && pdfForSystem.equalsIgnoreCase("Y"))) {%> style="display:none;" <%} %>>

	<%
		List<Object[]> igiDocumentSummaryList = (List<Object[]>)request.getAttribute("icdDocumentSummaryList");
		Object[] documentSummary=null;
		if(igiDocumentSummaryList!=null && igiDocumentSummaryList.size()>0){
			documentSummary=igiDocumentSummaryList.get(0);
		}
		String icdDocId =(String)request.getAttribute("icdDocId");
		List<Object[]> totalEmployeeList = (List<Object[]>)request.getAttribute("totalEmployeeList");
		
		List<Object[]> memberList = (List<Object[]>)request.getAttribute("memberList");
		List<Object[]> employeeList = (List<Object[]>)request.getAttribute("employeeList");
		
		List<IGIDocumentShortCodes> shortCodesList = (List<IGIDocumentShortCodes>)request.getAttribute("shortCodesList");
		List<IGIDocumentShortCodes> abbreviationsList = shortCodesList.stream().filter(e -> e.getShortCodeType().equalsIgnoreCase("A")).collect(Collectors.toList());
		List<IGIDocumentShortCodes> acronymsList = shortCodesList.stream().filter(e -> e.getShortCodeType().equalsIgnoreCase("B")).collect(Collectors.toList());
		
		List<Object[]> shortCodesLinkedList = (List<Object[]>)request.getAttribute("shortCodesLinkedList");
		List<Object[]> abbreviationsLinkedList = shortCodesLinkedList.stream().filter(e -> e[3].toString().equalsIgnoreCase("A")).collect(Collectors.toList());
		List<Object[]> acronymsLinkedList = shortCodesLinkedList.stream().filter(e -> e[3].toString().equalsIgnoreCase("B")).collect(Collectors.toList());
		
		List<StandardDocuments> applicableDocsList = (List<StandardDocuments>)request.getAttribute("applicableDocsList");
		List<Object[]> icdApplicableDocsList = (List<Object[]>)request.getAttribute("icdApplicableDocsList");
		List<Long> icdApplicableDocIds = icdApplicableDocsList.stream().map(e -> Long.parseLong(e[1].toString())).collect(Collectors.toList());
		applicableDocsList = applicableDocsList.stream().filter(e -> !icdApplicableDocIds.contains(e.getStandardDocumentId())).collect(Collectors.toList());
		List<String> icdApplicableDocNames = applicableDocsList.stream().map(e -> e.getDocumentName().toLowerCase()).collect(Collectors.toList());

		PfmsICDDocument icdDocument = (PfmsICDDocument)request.getAttribute("icdDocument");
		
		//List<Object[]> productTreeList = (List<Object[]>)request.getAttribute("productTreeList"); 
		List<ICDConnectionDTO> icdConnectionsList = (List<ICDConnectionDTO>)request.getAttribute("icdConnectionsList"); 
		List<Object[]> mechanicalInterfacesList = (List<Object[]>)request.getAttribute("mechanicalInterfacesList"); 
		
		List<IGIDocumentIntroduction> introductionList = (List<IGIDocumentIntroduction>)request.getAttribute("igiDocumentIntroductionList");
		introductionList = introductionList.stream().filter(e -> e.getDocId()==Long.parseLong(icdDocId) && e.getDocType().equalsIgnoreCase("B")).collect(Collectors.toList());
		
		//String isSubSystem = icdDocument!=null && icdDocument.getProductTreeMainId()!=0? "Y": "N";
		
		List<Object[]> productTreeAllList = (List<Object[]>)request.getAttribute("productTreeAllList"); 
		List<Object[]> productTreeList = (List<Object[]>)request.getAttribute("productTreeList"); 
		List<Object[]> productTreeListInternal = (List<Object[]>)request.getAttribute("productTreeListInternal"); 
		List<Object[]> productTreeListExternal = (List<Object[]>)request.getAttribute("productTreeListExternal"); 
		//List<Object[]> productTreeList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
		//List<Object[]> productTreeSubList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("2")).collect(Collectors.toList());
		
		List<Object[]> externalElementsList = productTreeAllList.stream().filter(e -> e[11]!=null && e[11].toString().equalsIgnoreCase("E")).collect(Collectors.toList());
		
		Map<String, String> connectionMap = new LinkedHashMap<>();
		
		HashSet<String> interfaceCodeList = new HashSet<String>();
		
		Map<String, List<String>> codeValuesMap = new LinkedHashMap<>();
		
		Map<String, List<String>> interfaceTypeValuesMap = new LinkedHashMap<>();
		
		Map<String, Set<String>> fwdTraceValuesMap = new LinkedHashMap<>();
		Map<String, Set<String>> bwdTraceValuesMap = new LinkedHashMap<>();
		
		for (ICDConnectionDTO con : icdConnectionsList) {
		    String[] levelNamesS1 = con.getLevelNamesS1().split(",");
		    String[] levelNamesS2 = con.getLevelNamesS2().split(",");
		    String[] levelCodesS1 = con.getLevelCodesS1().split(",");
		    String[] levelCodesS2 = con.getLevelCodesS2().split(",");
		    String[] interfaceCodes = con.getInterfaceCodes().split(",");
		    String[] interfaceTypes = con.getInterfaceTypes().split(",");
		    String value = con.getInterfaceCodes().replaceAll(",", "<br>");
		
		    for (String codeS1 : levelCodesS1) {
		        codeS1 = codeS1.trim();
		        for (String codeS2 : levelCodesS2) {
		            codeS2 = codeS2.trim();
		            String key = codeS1 + "_" + codeS2;
		
		            connectionMap.merge(key, value, (oldValue, newValue) -> oldValue + " <br> " + newValue);
		        }
		    }
		
		    for (String nameS1 : levelNamesS1) {
		    	nameS1 = nameS1.trim();
		        for (String nameS2 : levelNamesS2) {
		        	nameS2 = nameS2.trim();
		            String key = nameS1 + "_" + nameS2;
		
		            connectionMap.merge(key, value, (oldValue, newValue) -> oldValue + " <br> " + newValue);
		            
		            for(int i=0;i<interfaceCodes.length;i++) {
						// Unique Interface Codes
						interfaceCodeList.add(interfaceCodes[i]);
						
						// Collecting values for each code
						codeValuesMap.computeIfAbsent(interfaceCodes[i], k -> new ArrayList<>()).add(nameS1);
						codeValuesMap.computeIfAbsent(interfaceCodes[i], k -> new ArrayList<>()).add(nameS2);
					
						// Grouping the connections by Interface Type
						if(interfaceTypes.length<i){
			    			interfaceTypeValuesMap.computeIfAbsent(interfaceTypes[i], k -> new ArrayList<>()).add(nameS1);
			    			interfaceTypeValuesMap.computeIfAbsent(interfaceTypes[i], k -> new ArrayList<>()).add(nameS2);
						}
								
						/* Sub-System  */
					    // Forward Traceability Values
					    fwdTraceValuesMap.computeIfAbsent(nameS1, k -> new LinkedHashSet<>()).add(interfaceCodes[i]);
					   	fwdTraceValuesMap.computeIfAbsent(nameS2, k -> new LinkedHashSet<>()).add(interfaceCodes[i]);
					    
					 	// Backward Traceability Values
					   	bwdTraceValuesMap.computeIfAbsent(interfaceCodes[i], k -> new LinkedHashSet<>()).add(nameS1);
					   	bwdTraceValuesMap.computeIfAbsent(interfaceCodes[i], k -> new LinkedHashSet<>()).add(nameS2);
				    }
		        }
		    }
		}
		
		List<IGIInterface> igiInterfaceList = (List<IGIInterface>)request.getAttribute("igiInterfaceList");
		List<IGIConnector> connectorMasterList = (List<IGIConnector>) request.getAttribute("connectorMasterList");
		List<ICDConnectionConnectors> allICDConnectorList = (List<ICDConnectionConnectors>) request.getAttribute("allICDConnectorList");

		Map<String, IGIInterface> interfaceListToMap = igiInterfaceList.stream()
			    	.collect(Collectors.toMap(IGIInterface::getInterfaceCode, Function.identity(), (existing, replacement) -> existing ));

				
		Object[] projectDetails = (Object[])request.getAttribute("projectDetails");
		Object[] labDetails = (Object[])request.getAttribute("labDetails");
		Object[] docTempAtrr = (Object[])request.getAttribute("docTempAttributes");
		String lablogo = (String)request.getAttribute("lablogo");
		String drdologo = (String)request.getAttribute("drdologo");
		String version =(String)request.getAttribute("version");
		String projectType =(String)request.getAttribute("projectType");
		String filePath =(String)request.getAttribute("filePath");
		String labcode = (String)session.getAttribute("labcode");
		String projectShortName = (projectDetails!=null && projectDetails[2]!=null)?projectDetails[2]+"":"";
		
		LocalDate now = LocalDate.now();
		FormatConverter fc = new FormatConverter();
		
		Gson gson = new GsonBuilder().create();
		String jsonicdApplicableDocNames = gson.toJson(icdApplicableDocNames);
		
		String documentNo = "ICD-" + (documentSummary!=null && documentSummary[11]!=null?documentSummary[11].toString().replaceAll("-", ""):"-") 
							+ "-" + (labcode) + "-" +((projectDetails!=null && projectDetails[1]!=null)?projectDetails[1]:"") + "-V"+version;
	
		Object[] subSystemDetails = productTreeList.stream().filter(e -> Long.parseLong(systemId!=null?systemId:"0")==Long.parseLong(e[0].toString())).findFirst().orElse(null);
		
		List<IGIInterfaceTypes> interfaceTypesList = (List<IGIInterfaceTypes>)request.getAttribute("interfaceTypesList");
		List<IGIInterfaceContent> interfaceContentList = (List<IGIInterfaceContent>)request.getAttribute("interfaceContentList");
		
		List<ICDPinMapDTO> icdConnectorPinMapList = (List<ICDPinMapDTO>)request.getAttribute("icdConnectorPinMapList"); 
		Map<Long, List<ICDPinMapDTO>> pinMapListBySystem = icdConnectorPinMapList.stream()
			    .collect(Collectors.groupingBy(
			        ICDPinMapDTO::getSubSystemIdE1,
			        LinkedHashMap::new,
			        Collectors.collectingAndThen(
			            Collectors.toCollection(ArrayList::new),
			            list -> {
			                list.sort(Comparator.comparing(
			                    ICDPinMapDTO::getLevelNameE1,
			                    Comparator.nullsLast(String::compareToIgnoreCase)
			                ));
			                return list;
			            }
			        )
			    ));
		
		List<ICDSystemAttach> icdSystemAttachList = (List<ICDSystemAttach>)request.getAttribute("icdSystemAttachList"); 

	%>

    <% 
	    String ses = (String) request.getParameter("result");
	    String ses1 = (String) request.getParameter("resultfail");
	    if (ses1 != null) { %>
	    <div align="center">
	        <div class="alert alert-danger" role="alert">
	            <%=StringEscapeUtils.escapeHtml4(ses1) %>
	        </div>
	    </div>
	<% }if (ses != null) { %>
	    <div align="center">
	        <div class="alert alert-success" role="alert">
	            <%=StringEscapeUtils.escapeHtml4(ses) %>
	        </div>
	    </div>
	<% } %>
    
	<div id="loadingOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999; justify-content: center; align-items: center; flex-direction: column; color: white; font-size: 20px; font-weight: bold;">
		<div class="spinner" style="border: 4px solid rgba(255, 255, 255, 0.3); border-top: 4px solid white; border-radius: 50%; width: 40px; height: 40px; animation: spin 1s linear infinite; margin-bottom: 10px;"></div>
	   	Please wait while we are generating the PDF...
	</div>
	
    <div class="container-fluid">
       
    	<div class="card shadow-nohover" style="margin-top: -0.6pc">
        	<div class="card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
            	<div class="row">
               		<div class="col-md-10" id="projecthead" align="left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                        ICD Document Details - <%=documentNo!=null?StringEscapeUtils.escapeHtml4(documentNo): " - " %>
	                    </h5>
                	</div>
                    <div class="col-md-2" align="right">
                        <form action="ICDDocumentList.htm" method="get">
                    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        			<input type="hidden" name="projectId" value="<%=icdDocument.getProjectId() %>" />
		        			<input type="hidden" name="initiationId" value="<%=icdDocument.getInitiationId() %>" />
		        			<input type="hidden" name="productTreeMainId" value="<%=icdDocument.getProductTreeMainId() %>" />
		        			<input type="hidden" name="projectType" value="<%=icdDocument.getProjectId()!=0?"M":"I" %>" />
		        			<button class="btn btn-info btn-sm shadow-nohover back">
		        				Back
		        			</button>
                		</form>
                    </div>
            	</div>
        	</div>
        	<div class="card-body">
        		<div class="row ml-2">
       				<div class="col-custom-1-5 p-0 mb-2">
       					<div class="card" style="border: 3px solid #007bff;">
   							<div class="card-body topicsSideBar">
								<div class="row">
  									<div class="col-md-12">
  										<div class="modulecontainer">
				
											<!-- <div class="card module" onclick="DownloadDocPDF()"> -->
											<div class="card module" data-toggle="modal" data-target="#systemWisePdfModal">
												<div class="card-body">
													<div><img alt="" src="view/images/pdf.png" > <span class="topic-name">ICD Document</span></div>
												</div>
											</div>
											
											<div class="card module" data-toggle="modal" data-target="#distributionModal">
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" > <span class="topic-name">Document Distribution</span></div>
												</div>
											</div>
											
											<div class="card module" data-toggle="modal" data-target="#summaryModal">
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" > <span class="topic-name">Document Summary</span></div>
												</div>
											</div>
											
											<div class="card module" onclick="showShortCodes('A')">
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" > <span class="topic-name">Abbreviations</span></div>
												</div>
											</div>
											
											<div class="card module" onclick="showShortCodes('B')">
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" > <span class="topic-name">Acronyms</span></div>
												</div>
											</div>
											
											<div class="card module" onclick="showChapter1()">
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" > <span class="topic-name">Chapter 1 : Introduction</span></div>
												</div>
											</div>
											
											<div class="card module" onclick="showChapter2()" >
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" > <span class="topic-name">Chapter 2 : Applicable Docs</span></div>
												</div>
											</div>
											
											<div class="card module" onclick="showChapter3()">
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" > <span class="topic-name">Chapter 3 : Interfaces</span></div>
												</div>
											</div>
											
											<div class="card module" onclick="showChapter4()">
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" ><span class="topic-name">Chapter 4 : External Elements</span></div>
												</div>
											</div>
											
											<div class="card module" onclick="showChapter5()">
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" ><span class="topic-name">Chapter 5 : Mech Interfaces</span></div>
												</div>
											</div>
											
										</div>
  									</div>
   								</div>
   								
   							</div>
       					</div>
       				</div>
       				<div class="col-custom-10-5">
       					<div class="" id="reqdiv">
							<div style="">
								<% int docsumslno = 0; %>
								<table class="table table-bordered">
									<tr class="table-warning">
										<td align="center" colspan="2" class="text-primary">DOCUMENT SUMMARY</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Title: <span class="text-dark">Interface Control Information (ICD)</span></td>
									</tr>
									<tr >
										<td class="text-primary"><%=++docsumslno %>.&nbsp; Type of Document:<span class="text-dark">Interface Control Information (ICD) Document</span></td>
										<td class="text-primary"><%=++docsumslno %>.&nbsp; Classification: <span class="text-dark">Restricted</span></td>
									</tr>
								    <tr >
										<td class="text-primary"><%=++docsumslno %>.&nbsp; Document Number: <span class="text-dark"><%=documentNo!=null?StringEscapeUtils.escapeHtml4(documentNo): " - " %></span> </td>
										<td class="text-primary"><%=++docsumslno %>.&nbsp; Month Year: <span style="color:black;"><%=now.getMonth().toString().substring(0,3) %>&nbsp;&nbsp;<%=now.getYear() %></span></td>
									</tr>
									<!-- <tr>
										<td class="text-primary">6.&nbsp; Number of Pages:</td>
										<td class="text-primary">7.&nbsp; Related Document:</td>
									</tr> -->
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Additional Information:
											<%if(documentSummary!=null && documentSummary[1]!=null) {%><span class="text-dark"><%=StringEscapeUtils.escapeHtml4(documentSummary[1].toString())%></span> <%} %>
										</td>
									</tr>
								    <!-- <tr>
										<td  class="text-primary" colspan="2">9.&nbsp; Project Number and Project Name: <span class="text-dark"> </span></td>
									</tr> -->
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Abstract:
											<%if(documentSummary!=null && documentSummary[2]!=null) {%> <span class="text-dark"><%=StringEscapeUtils.escapeHtml4(documentSummary[2].toString())%></span><%} %>
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Keywords:
											<%if(documentSummary!=null && documentSummary[3]!=null) {%> <span class="text-dark"><%=StringEscapeUtils.escapeHtml4(documentSummary[3].toString())%></span><%} %>
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Organization and address:
											<span class="text-dark">		
												<%if (labDetails[1] != null) {%>
													<%=StringEscapeUtils.escapeHtml4(labDetails[1].toString()) + "(" + labDetails[0]!=null?StringEscapeUtils.escapeHtml4(labDetails[0].toString()): " - " + ")"%>
												<%} else {%>
													-
												<%}%>
												
												Government of India, Ministry of Defence,Defence
												Research & Development Organization
												<%if (labDetails[2] != null && labDetails[3] != null && labDetails[5] != null) {%>
													<%=StringEscapeUtils.escapeHtml4(labDetails[2].toString())+ " , " + StringEscapeUtils.escapeHtml4(labDetails[3].toString()) + ", PIN-" + StringEscapeUtils.escapeHtml4(labDetails[5].toString())+"."%>
												<%}else{ %>
													-
												<%} %>
											</span>
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Distribution:
											<%if(documentSummary!=null && documentSummary[4]!=null) {%> <span class="text-dark"><%=StringEscapeUtils.escapeHtml4(documentSummary[4].toString())%></span><%} %>
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Revision:</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Prepared by:
											<%if(documentSummary!=null && documentSummary[10]!=null) {%> <span class="text-dark"><%=StringEscapeUtils.escapeHtml4(documentSummary[10].toString())%></span><%}else {%><span class="text-dark">-</span>  <%} %> <span class="text-dark"></span> 
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Reviewed by: 
											<%if(documentSummary!=null && documentSummary[9]!=null) {%> <span class="text-dark"><%=StringEscapeUtils.escapeHtml4(documentSummary[9].toString())%></span><%}else {%><span class="text-dark">-</span>  <%} %> 
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Approved by: 
											<%if(documentSummary!=null && documentSummary[8]!=null) {%> <span class="text-dark"><%=StringEscapeUtils.escapeHtml4(documentSummary[8].toString())%></span><%}else {%><span class="text-dark">-</span>  <%} %> 
										</td>
									</tr>
								</table>
							</div>
						</div>
       				</div>
       			</div>
       		</div>		
		</div>
    </div>

	<form action="#">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
		<input type="hidden" name="icdDocId" value="<%=icdDocId%>"> 
		<input type="hidden" name="docId" value="<%=icdDocId%>"> 
		<input type="hidden" name="documentNo" value="<%=documentNo%>"> 
		<input type="hidden" name="projectType" value="<%=projectType%>"> 
		<input type="hidden" name="projectId" value="<%=(projectDetails!=null && projectDetails[0]!=null)?projectDetails[0]:"0"%>"> 
		<input type="hidden" name="docType" value="B"> 
		<input type="hidden" name="shortCodeType" id="shortCodeType"> 
	
		<button type="submit" id="shortCodesFormBtn" formaction="IGIShortCodesDetails.htm" formmethod="post" formnovalidate="formnovalidate" style="display:none;"></button>
		
		<button type="submit" id="introductionDetailsFormBtn" formaction="IGIIntroductionDetails.htm" formmethod="post" formnovalidate="formnovalidate" style="display:none;"></button>
	
		<button type="submit" id="applicableDocumentsFormBtn" formaction="IGIApplicableDocumentsDetails.htm" formmethod="post" formnovalidate="formnovalidate" style="display:none;"></button>
		
		<button type="submit" id="connectionsFormBtn" formaction="ICDConnectionList.htm" formmethod="post" formnovalidate="formnovalidate" style="display:none;"></button>
	
		<button type="submit" id="mechanicalInterfaceFormBtn" formaction="ICDMechanicalInterfacesList.htm" formmethod="post" formnovalidate="formnovalidate" style="display:none;"></button>
		
	</form>
	<!-- -------------------------------------------- Document Distribution Modal -------------------------------------------- -->
	<div class="modal fade" id="distributionModal" tabindex="-1" role="dialog" aria-labelledby="distributionModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width:135%;margin-left:-20%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title" >Document Sent to</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				<%if(memberList!=null && !memberList.isEmpty()) {%>
      					<div class="row mb-2">
							<div class="col-md-12">
								<table class="table table-bordered" id="myTables" style="width: 100%;">
									<thead class="center" style="background: #055C9D ;color: white;">
										<tr>
											<th width="10%">SN</th>
											<th width="40%">Name</th>
											<th width="30%">Designation</th>
											<th width="20%">Action</th>
										</tr>
									</thead>
									<tbody>
									<%int rowCount=0;
										for(Object[]obj:memberList) {%>
											<tr>
												<td class="center"><%=++rowCount %></td>
												<td ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></td>
												<td ><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
												<td class="center" >
												    <form id="deleteForm_<%= obj[5] %>" action="#" method="POST" name="myfrm" style="display: inline">
												        <button type="submit" class="editable-clicko" formaction="IGIDocumentMembersDelete.htm" onclick="return confirmDeletion('<%= obj[5] %>');">
												            <img src="view/images/delete.png" alt="Delete">
												        </button>
												        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
												        <input type="hidden" name="IgiMemeberId" value="<%= obj[5] %>">
												        <input type="hidden" name="icdDocId" value="<%=icdDocId %>">
												        <input type="hidden" name="docId" value="<%=icdDocId%>">	 
														<input type="hidden" name="docType" value="B">	
												    </form>
												</td>

											</tr>
										<%} %>
									</tbody>
								</table>
							</div>      
      					</div>
      				<%} %>
      				
       				<form action="IGIDocumentMemberSubmit.htm" method="post">
      					<div class="row">
							<div class="col-md-10">
								<select class="form-control selectdee"name="Assignee" id="Assignee"data-width="100%" data-live-search="true" multiple required>
							        <%for(Object[] obj: employeeList){ %>
							        	<option value="<%=obj[0].toString()%>"> <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=(obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - ") %></option>
							        <%} %>
							       
        						</select>
        					</div>
					      	<div class="col-md-2" align="center">
					      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
		
								<input type="hidden" name="icdDocId" value="<%=icdDocId%>">	 
								<input type="hidden" name="docId" value="<%=icdDocId%>">	 
								<input type="hidden" name="docType" value="B">	 
					    		<button type="submit" class="btn btn-sm submit" onclick="return confirm ('Are you sure to submit?')"> SUBMIT</button>
					      	</div>
      					</div>
      				</form>
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- Document Distribution Modal End -------------------------------------------- -->
	
	<!-- -------------------------------------------- Document Summary Modal Structure ----------------------------------- -->
	<div class="modal fade" id="summaryModal" tabindex="-1" aria-labelledby="summaryModal" aria-hidden="true">
    	<div class="modal-dialog modal-lg modal-dialog-jump">
        	<div class="modal-content" style="width:150%;margin-left: -20%">
	            <div class="modal-header" style="background: #055C9D;color:white;">
	                <h5 class="modal-title" id="SummaryModalLabel">ICD Document Summary</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span class="text-light" aria-hidden="true">&times;</span>
	                </button>
	            </div>
            	<div class="modal-body">
               		<form action="IGIDocumentSummaryAdd.htm" method="post">
               
                  		<div class="row">
   							<div class="col-md-4">
   								<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Additional Information <span class="mandatory">*</span></label>
   							</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="information" class="form-control" id="additionalReq" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(documentSummary!=null && documentSummary[1]!=null){%><%=StringEscapeUtils.escapeHtml4(documentSummary[1].toString())%><%}else{%><%}%></textarea>
				   			</div>
   				 		</div>
   				 
   				 		<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Abstract <span class="mandatory">*</span></label>
				   			</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="abstract" class="form-control" id="" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(documentSummary!=null && documentSummary[2]!=null){%><%=StringEscapeUtils.escapeHtml4(documentSummary[2].toString())%><%}else{%><%}%></textarea>
				   			</div>
			   			</div>
			   	
			   			<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Keywords <span class="mandatory">*</span></label>
				   			</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="keywords" class="form-control" id="" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(documentSummary!=null && documentSummary[3]!=null){%><%=StringEscapeUtils.escapeHtml4(documentSummary[3].toString())%><%}else{%><%}%></textarea>
				   			</div>
   						</div>
   			
   		    			<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Distribution <span class="mandatory">*</span></label>
				   			</div>
				   			<div class="col-md-8">
				   				<input required="required" name="distribution" class="form-control" id="" maxlength="255"
								 placeholder="Maximum 255 Chararcters" required value="<%if(documentSummary!=null && documentSummary[4]!=null){%><%=StringEscapeUtils.escapeHtml4(documentSummary[4].toString())%><%}else{%><%}%>">
				   			</div>
   						</div>
   			
   						<div class="row mt-2">
   				
   				            <div class="col-md-2">
			   	 				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Release Date <span class="mandatory">*</span>:</label>
			   				</div>	
   				
   				 			<div class="col-md-4">
	   							<input id="pdc-date"  readonly name="pdc" <%if(documentSummary!=null && documentSummary[11]!=null){%> value="<%=fc.sdfTordf(documentSummary[11].toString()) %>" <%}%> class="form-control">
   				
   							</div>
   				
   							<div class="col-md-2 right">
			   	 				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Prepared By <span class="mandatory">*</span></label>
			   				</div>
			   				<div class="col-md-4">
	   							<select class="form-control selectdee"name="preparedBy" id=""data-width="100%" data-live-search="true"  required>
	          						<option value="" selected disabled>--SELECT--</option>
	        						<%for(Object[] obj: totalEmployeeList){ %>
	        							<option value="<%=obj[0].toString()%>" <%if(documentSummary!=null && documentSummary[7]!=null && documentSummary[7].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        								<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=(obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - ") %>
	        							</option>
	        						<%} %>
	        					</select>
   					      </div>
   						</div>
   				
	   					<div class="row mt-2">
				   			<div class="col-md-2">
			   	 				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Reviewer <span class="mandatory">*</span></label>
			   				</div>	
	   				
	   				 		<div class="col-md-4">
	   							<select class="form-control selectdee"name="reviewer" id=""data-width="100%" data-live-search="true" required>
	       		 					<option value="" selected disabled="disabled">--SELECT--</option>
	       		 					<%for(Object[] obj: totalEmployeeList){ %>
	        							<option value="<%=obj[0].toString()%>" <%if(documentSummary!=null && documentSummary[5]!=null &&  documentSummary[5].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
	        								<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=(obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - ") %>
	        							</option>
	        						<%} %>
	        					</select>
	   				
	   						</div>
	   				
			   				<div class="col-md-2">
						   		<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f;float:right;">Approver <span class="mandatory">*</span></label>
						   	</div>	
		 					<div class="col-md-4">
		   						<select class="form-control selectdee"name="approver" id=""data-width="100%" data-live-search="true"  required>
		       						<option value="" selected disabled="disabled">--SELECT--</option>
		       						<%for(Object[] obj: totalEmployeeList){ %>
		      	 							<option value="<%=obj[0].toString()%>" <%if(documentSummary!=null && documentSummary[6]!=null && documentSummary[6].toString().equalsIgnoreCase(obj[0].toString())){%>selected<%}%>>
		       								<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>,<%=(obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - ") %>
		       							</option>
		       						<%} %>
		        				</select>
		 					</div>
	   					</div>
   						
	   					<div class="mt-2" align="center">
	  						<%if(igiDocumentSummaryList!=null && igiDocumentSummaryList.size()>0) {%>
	  							<button class="btn btn-sm edit" name="action" value="Edit" onclick="return confirm ('Are you sure to submit?')">UPDATE</button>
	  							<input type="hidden" name="summaryId" value="<%=documentSummary[0]%>"> 
	  						<%}else{ %>
	  							<button class="btn btn-sm submit" name="action" value="Add" onclick="return confirm('Are you sure to submit?')">SUBMIT</button>
	  						<%} %>
	   						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
							<input type="hidden" name="icdDocId" value="<%=icdDocId%>"> 
							<input type="hidden" name="docId" value="<%=icdDocId%>"> 
							<input type="hidden" name="docType" value="B"> 
	   					</div>
					</form>
        		</div>
        	</div>
    	</div>
	</div>
	<!-- -------------------------------------------- Document Summary Modal Structure End ----------------------------------- -->
	
	<!-- -------------------------------------------- External Elements Modal -------------------------------------------- -->
	<div class="modal fade" id="externalElementsModal" tabindex="-1" role="dialog" aria-labelledby="externalElementsModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width:135%;margin-left:-20%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title" >External Elements</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				<%if(externalElementsList!=null && !externalElementsList.isEmpty()) {%>
      					<div class="row mb-2">
							<div class="col-md-12">
								<table class="table table-bordered" id="myTables" style="width: 100%;">
									<thead class="center" style="background: #055C9D ;color: white;">
										<tr>
											<th width="10%">SN</th>
											<th width="30%">Element Code</th>
											<th width="40%">Element Name</th>
											<th width="20%">Action</th>
										</tr>
									</thead>
									<tbody>
									<%int slno=0;
										for(Object[] obj : externalElementsList) {%>
											<tr>
												<td class="center"><%=++slno %></td>
												<td ><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %></td>
												<td ><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
												<td class="center" >
												    <form id="deleteForm_<%= obj[0] %>" action="#" method="POST" name="myfrm" style="display: inline">
												        <button type="submit" class="editable-clicko" formaction="ExternalElementDelete.htm" onclick="return confirm('Are you sure to delete?')">
												            <img src="view/images/delete.png" alt="Delete">
												        </button>
												        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
												        <input type="hidden" name="mainId" value="<%=obj[0] %>">
												        <input type="hidden" name="icdDocId" value="<%=icdDocId %>">
												        <input type="hidden" name="docId" value="<%=icdDocId%>">	 
														<input type="hidden" name="docType" value="B">	
												    </form>
												</td>

											</tr>
										<%} %>
									</tbody>
								</table>
							</div>      
      					</div>
      				<%} %>
      				
      				<hr class="mt-3 mb-3">
      				<div class="container-fluid mt-3">
	       				<div class="row">
							<div class="col-md-12 " align="left">
								<form action="ExternalElementsSubmit.htm" method="POST" id="myform">
									<table id="externalelementstable" class="table table-bordered externalelementstable" style="width: 100%;" >
										<thead class="center" style="background: #055C9D;color: white;">
											<tr>
												<th width="30%">Element Code</th>
												<th width="60%">Element Name</th>
												<td width="10%">
													<button type="button" class="btn btn-sm btn_add_externalelements "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
												</td>
											</tr>
										</thead>
										<tbody id="activityTableBody">
											<tr class="tr_clone_externalelements">
												<td>
													<input type="text"class="form-control levelCode" name="levelCode" id="levelCode_1" maxlength="5" placeholder="Enter Maximum of 5 characters" required="required">
												</td>
												<td>
													<input type="text"class="form-control levelName" name="levelName" id="levelName_1" maxlength="255" placeholder="Enter Maximum of 255 characters" required="required">
												</td>	
												<td class="center">
													<button type="button" class="btn btn-sm btn_rem_externalelements" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
												</td>		
											</tr>	
										</tbody>
									</table>
									<input type="hidden" name="icdDocId" value="<%=icdDocId%>">	 
									<input type="hidden" name="projectId" value="<%=projectDetails[0]%>">	 
									<input type="hidden" name="projectType" value="<%=projectType%>">	 
									<input type="hidden" name="docId" value="<%=icdDocId%>">	 
									<input type="hidden" name="docType" value="B">	
									
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									
									<div class="center mt-2">
										<button type="submit"class="btn btn-sm submit" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
									</div>
								</form>
							</div>
						</div>
					</div>	
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- External Elements Modal End -------------------------------------------- -->
	
	<!-- -------------------------------------------- ICD Document Download Modal -------------------------------------------- -->
	<div class="modal fade" id="systemWisePdfModal" tabindex="-1" role="dialog" aria-labelledby="systemWisePdfModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width:135%;margin-left:-20%;">
      			<div class="modal-header" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title" >ICD Document Download</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
      				<form action="ICDDocumentDetails.htm" method="post" target="blank">
               			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
               			<input type="hidden" name="pdfForSystem" value="Y">
               			<input type="hidden" name="icdDocId" value="<%=icdDocId%>">
                  		<div class="row">
                  			<div class="col-md-1"></div>
   							<div class="col-md-4">
   								<button type="button" class="btn btn-sm btn-primary" onclick="DownloadDocPDF()"><%=projectShortName+" ("+projectDetails[1]+")" %> Document</button>
   							</div>
   							<div class="col-md-2 right">
   								<label class="form-lable" style="font-weight: bold;"> For System:</label>
   							</div>
   							<div class="col-md-4">
   								<select class="form-control selectdee" name="systemId" id="systemId" onchange="this.form.submit()">
   									<option value="" selected disabled>Choose...</option>
   									<%for(Object[] obj : productTreeList) {%>
   										<option value="<%=obj[0]%>"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " + " (" + obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " + ")" %></option>
   									<%} %>
   								</select>
   							</div>
   							<div class="col-md-1"></div>
   				 		</div>
   				 	</form>
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- ICD Document Download Modal End -------------------------------------------- -->
	
	
<script type="text/javascript">
	
    function confirmDeletion(memberId) {
        if (confirm('Are you sure you want to delete this member?')) {
            var form = $('#deleteForm_' + memberId);
            form.submit();
            return true;
        } else {
            return false;
        }
    }

	$('#pdc-date').daterangepicker({
		
		"singleDatePicker": true,
		"showDropdowns": true,
		"cancelClass": "btn-default",
		
		<%if(documentSummary==null || documentSummary[10]==null) {%>
		"startDate":new Date() ,
		<%}%>
	
		locale: {
	    	format: 'DD-MM-YYYY'
			}
	});
	
	/* Cloning (Adding) the table body rows for Add New Short Codes */
	var cloneCount = 1;
	$("#externalelementstable").on('click','.btn_add_externalelements' ,function() {
		
		var $tr = $('.tr_clone_externalelements').last('.tr_clone_externalelements');
		var $clone = $tr.clone();
		$tr.after($clone);
		++cloneCount;
		
		$clone.find("input").val("").end();
		
	});


	/* Cloning (Removing) the table body rows for Add New Short Codes */
	$("#externalelementstable").on('click','.btn_rem_externalelements' ,function() {
		
		var cl=$('.tr_clone_externalelements').length;
			
		if(cl>1){
		   var $tr = $(this).closest('.tr_clone_externalelements');
		  
		   var $clone = $tr.remove();
		   $tr.after($clone);
		   
		}
	 
	});
	
	
	function showShortCodes(shortCodeType) {
		$('#shortCodeType').val(shortCodeType);
		$('#shortCodesFormBtn').click();
	}

	function showChapter1() {
		$('#introductionDetailsFormBtn').click();
	}
	
	function showChapter2() {
		$('#applicableDocumentsFormBtn').click();
	}
	
	function showChapter3(){
    	$('#connectionsFormBtn').click();
	}

	function showChapter4() {
		$('#externalElementsModal').modal('show');
	}

	function showChapter5() {
    	$('#mechanicalInterfaceFormBtn').click();
	}
	
</script>    
<script type="text/javascript">
function DownloadDocPDF(){

	document.getElementById('loadingOverlay').style.display = 'flex';
	
	var chapterCount = 0;
    var mainContentCount = 0;
	var leftSideNote = '<%if(docTempAtrr!=null && docTempAtrr[12]!=null) {%><%=docTempAtrr[12].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%} else{%>-<%}%>';
	
	var docDefinition = {
            content: [
                // Cover Page with Project Name and Logo
                {
                    text: htmlToPdfmake('<h4 class="heading-color ">Interface Control Document (ICD) <br><br> FOR  <br><br>PROJECT <%if(pdfForSystem!=null && pdfForSystem.equalsIgnoreCase("Y")) {%><%=subSystemDetails[2]+" ("+subSystemDetails[7]+")" %><%} else {%><%=projectShortName %><%}%> </h4>'),
                    style: 'DocumentName',
                    alignment: 'center',
                    fontSize: 18,
                    margin: [0, 200, 0, 20]
                }, 
                <% if (lablogo != null) { %>
                {
                    image: 'data:image/png;base64,<%= lablogo %>',
                    width: 95,
                    height: 95,
                    alignment: 'center',
                    margin: [0, 20, 0, 30]
                },
                <% } %>
                
                {
                    text: htmlToPdfmake('<h5><% if (labDetails != null && labDetails[1] != null) { %> <%= StringEscapeUtils.escapeHtml4(labDetails[1].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + labDetails[0]!=null?StringEscapeUtils.escapeHtml4(labDetails[0].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):" - " + ")" %> <% } else { %> '-' <% } %></h5>'),
                    alignment: 'center',
                    fontSize: 16,
                    bold: true,
                    margin: [0, 20, 0, 20]
                },
                {
                    text: htmlToPdfmake('<h6>Government of India, Ministry of Defence<br>Defence Research & Development Organization </h6>'),
                    alignment: 'center',
                    fontSize: 14,
                    bold: true,
                    margin: [0, 10, 0, 10]
                },
                {
                    text: htmlToPdfmake('<h6><%if(labDetails!=null && labDetails[2]!=null && labDetails[3]!=null && labDetails[5]!=null){ %><%=StringEscapeUtils.escapeHtml4(labDetails[2].toString())+ " , " + StringEscapeUtils.escapeHtml4(labDetails[3].toString()) + ", PIN-" + StringEscapeUtils.escapeHtml4(labDetails[5].toString()) %><%}else{ %>-<%} %></h6>'),
                    alignment: 'center',
                    fontSize: 14,
                    bold: true,
                    margin: [0, 10, 0, 10]
                },
                // Table of Contents
                {
                    toc: {
                        title: { text: 'INDEX', style: 'header', pageBreak: 'before' }
                    }
                },
                
                /* ************************************** Distribution List *********************************** */ 
                {
                    text: 'Distribution List',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before',
                    alignment: 'center'
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['15%', '35%', '25%', '25%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Name', style: 'tableHeader' },
                                { text: 'Designation', style: 'tableHeader' },
                                { text: 'Division/Lab', style: 'tableHeader' }
                            ],
                            // Populate table rows
                            <% if (memberList != null && memberList.size()>0) { %>
	                            <% int slno = 0; for (Object[] obj : memberList) { %>
	                            [
	                                { text: '<%= ++slno %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%= obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>', style: 'tableData' },
	                                { text: '<%= obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>', style: 'tableData' },
	                                { text: '<%= obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %>', style: 'tableData',alignment: 'center' }
	                            ],
	                            <% } %>
                            <% } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 4 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Distribution List End*********************************** */

                /* ************************************** Document Summary *********************************** */
                {
                    text: 'Document Summary',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                {
                    table: {
                        headerRows: 0,
                        widths: ['10%', '30%', '60%'],
                        body: [
                            <% int docsn = 0; %>
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Title', style: 'tableData' },
                                { text: 'Interface Control Information (ICD)', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Type of Document', style: 'tableData' },
                                { text: 'Interface Control Information (ICD) Document', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Classification', style: 'tableData' },
                                { text: 'Restricted', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Document Number', style: 'tableData' },
                                { text: '<%=documentNo!=null?StringEscapeUtils.escapeHtml4(documentNo): " - " %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Month Year', style: 'tableData' },
                                { text: '<%=now.getMonth().toString().substring(0,3) %> <%=now.getYear() %>', style: 'tableData' },
                            ],
                            
                            /* [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Number of Pages', style: 'tableData' },
                                { text: '', style: 'tableData' },
                            ], */
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Related Document', style: 'tableData' },
                                { text: '', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Additional Information', style: 'tableData' },
                                { text: htmlToPdfmake('<% if(documentSummary!=null){%><%=documentSummary[1]!=null?StringEscapeUtils.escapeHtml4(documentSummary[1].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-" %><%} %>'), style: 'tableData' },
                            ],
                            
                            <%-- [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Project Name', style: 'tableData' },
                                { text: '<%if(pdfForSystem!=null && pdfForSystem.equalsIgnoreCase("Y")) {%><%=subSystemDetails[2]+" ("+subSystemDetails[7]+")" %><%} else {%><%=projectShortName %><%}%>', style: 'tableData' },
                            ], --%>
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Abstract', style: 'tableData' },
                                { text: htmlToPdfmake('<% if(documentSummary!=null){%><%=documentSummary[2]!=null?StringEscapeUtils.escapeHtml4(documentSummary[2].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-" %><%} %>'), style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Keywords', style: 'tableData' },
                                { text: htmlToPdfmake('<% if(documentSummary!=null){%><%=documentSummary[3]!=null?StringEscapeUtils.escapeHtml4(documentSummary[3].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-" %><%} %>'), style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Organization and address', style: 'tableData' },
                                { text: '<% if (labDetails!=null && labDetails[1] != null) {%> <%=StringEscapeUtils.escapeHtml4(labDetails[1].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + labDetails[0]!=null?StringEscapeUtils.escapeHtml4(labDetails[0].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") :" - " + ")"%> <%} else {%> - <%}%>'
										+'\n Government of India, Ministry of Defence,Defence Research & Development Organization'
								+'<% if (labDetails!=null && labDetails[2] != null && labDetails[3] != null && labDetails[5] != null) { %>'
									+'<%=StringEscapeUtils.escapeHtml4(labDetails[2].toString())+ " , " + StringEscapeUtils.escapeHtml4(labDetails[3].toString()) + ", PIN-" + StringEscapeUtils.escapeHtml4(labDetails[5].toString())+"."%>'
								+'<%}else{ %> - <%} %>' , style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Distribution', style: 'tableData' },
                                { text: htmlToPdfmake('<% if(documentSummary!=null){%><%=documentSummary[4]!=null?StringEscapeUtils.escapeHtml4(documentSummary[4].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-" %><%} %>'), style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Revision', style: 'tableData' },
                                { text: '<%=version!=null ?StringEscapeUtils.escapeHtml4(version):"-" %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Prepared by', style: 'tableData' },
                                { text: '<% if(documentSummary!=null){%><%=documentSummary[10]!=null?StringEscapeUtils.escapeHtml4(documentSummary[10].toString()):"-" %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Reviewed by', style: 'tableData' },
                                { text: '<% if(documentSummary!=null){%><%=documentSummary[9]!=null?StringEscapeUtils.escapeHtml4(documentSummary[9].toString()):"-" %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Approved by', style: 'tableData' },
                                { text: '<% if(documentSummary!=null){%><%=documentSummary[8]!=null?StringEscapeUtils.escapeHtml4(documentSummary[8].toString()):"-" %><%} %>', style: 'tableData' },
                            ],

                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
			
                /* ************************************** Document Summary End *********************************** */
                
                /* ************************************** Abbreviations ****************************************** */ 
                {
                    text: 'Abbreviations',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before',
                    alignment: 'center'
                },
                {
                	text: 'Abbreviations used in the Manual to be listed and arranged in alphabetical order',	
                	style: 'chapterNote',
                    alignment: 'center'
                },
                
                {
                    table: {
                        headerRows: 1,
                        widths: ['20%', '30%', '50%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Abbreviation', style: 'tableHeader' },
                                { text: 'Full form', style: 'tableHeader' },
                            ],
                            // Populate table rows
                           <% if(abbreviationsLinkedList!=null && abbreviationsLinkedList.size()>0){
								int slno=0;
								for(Object[] obj : abbreviationsLinkedList){
							%>
		                            [
		                                { text: '<%=++slno %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>', style: 'tableData' },
		                            ],
		                        <% } %>
                            <% } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 3 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                
                /* ************************************** Abbreviations End*********************************** */ 
                
                /* ************************************** Acronyms ************************************** */ 
                {
                    text: 'Acronyms',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before',
                    alignment: 'center'
                },
                {
                	text: 'Acronyms used in the Manual to be listed and arranged in alphabetical order',	
                	style: 'chapterNote',
                    alignment: 'center'
                },
                
                {
                    table: {
                        headerRows: 1,
                        widths: ['20%', '30%', '50%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Acronym', style: 'tableHeader' },
                                { text: 'Full form', style: 'tableHeader' },
                            ],
                            // Populate table rows
                           <% if(acronymsLinkedList!=null && acronymsLinkedList.size()>0){
								int slno=0;
								for(Object[] obj : acronymsLinkedList){
							%>
		                            [
		                                { text: '<%=++slno %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>', style: 'tableData' },
		                            ],
		                        <% } %>
                            <% } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 3 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                
                /* ************************************** Acronyms End*********************************** */ 
                
                /* ************************************** Introduction *********************************** */
                {
                    text: (++mainContentCount)+'. Introduction',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before',
                },

                <%if(introductionList!=null && introductionList.size()>0) {
                	int Sub0Count = 1;
                	for(IGIDocumentIntroduction intro : introductionList) {
                		if(intro.getLevelId()==1) {
                %>
	                {
	                    text: '<%=Sub0Count+". "+intro.getChapterName()%>',
	                    style: 'chapterSubHeader',
	                    tocItem: true,
	                    tocMargin: [10, 0, 0, 0],
	                },
	                {
	                	stack: [htmlToPdfmake(setImagesWidth('<%if(intro.getChapterContent()!=null) {%><%=StringEscapeUtils.escapeHtml4(intro.getChapterContent()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'
	                		  +'<%}else {%> - <%} %>', 500))],
	                    margin: [15, 0, 0, 0],
	                },
	                
	                <%
	                	int Sub1Count = 1;
	                	for(IGIDocumentIntroduction intro1 : introductionList) {
	                		if(intro1.getLevelId()==2 && intro1.getParentId().equals(intro.getIntroductionId())) {
	                %>
	                
		                {
		                    text: '<%=Sub0Count+". "+Sub1Count+". "+intro1.getChapterName()!=null?StringEscapeUtils.escapeHtml4(intro1.getChapterName()): " - "%>',
		                    style: 'chapterSubSubHeader',
		                    tocItem: true,
		                    tocMargin: [20, 0, 0, 0],
		                },
		                {
		                	stack: [htmlToPdfmake(setImagesWidth('<%if(intro1.getChapterContent()!=null) {%><%=StringEscapeUtils.escapeHtml4(intro1.getChapterContent()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'
		                		  +'<%}else {%> - <%} %>', 500))],
		                    margin: [25, 0, 0, 0],
		                },
	                <%++Sub1Count;} }%>
	                
                <%++Sub0Count;} } }else{%>
	                {
	                    text: '-',
	                    margin: [10, 0, 0, 0],
	                },
                <%} %>
                /* ************************************** Introduction End *********************************** */
                
                /* ************************************** Applicable Documents *********************************** */
                {
                    text: (++mainContentCount)+'. Applicable Documents',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before',
                },

                {
                    table: {
                        headerRows: 1,
                        widths: ['20%', '60%', '20%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Document Name', style: 'tableHeader' },
                                { text: 'Action', style: 'tableHeader' },
                            ],
                            // Populate table rows
                           <% if(icdApplicableDocsList!=null && icdApplicableDocsList.size()>0){
								int slno=0;
								for(Object[] obj : icdApplicableDocsList){
							%>
		                            [
		                                { text: '<%=++slno %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>', style: 'tableData', },
		                                {
		                                    text: 'Download',
		                                    style: 'tableData',
		                                    link: '<%= request.getRequestURL().toString().replace(request.getRequestURI(), "") + request.getContextPath() + "/StandardDocumentsDownload.htm?StandardDocumentId=" + obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): "" %>',
		                                    color: 'blue',
		                                    decoration: 'underline',
		                                    alignment: 'center',
		                                },
		                            ],
		                        <% } %>
                            <% } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 3 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }
                    }
                },
                /* ************************************** Applicable Documents End *********************************** */
                
                /* ************************************** Interfaces ************************************************* */
                /* ************************************** Interfaces - All *********************************** */
                {
                    text: (++mainContentCount)+'. Interfaces',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageOrientation: 'landscape',
                    pageBreak: 'before',
                  	/* pageSize: { width: 1190.55, height: 841.89 }, */
                    pageSize: { width: 1683.78, height: 1190.55 },
                },
                {
                    text: (mainContentCount)+'.1. All',
                    style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.1',
                    tocMargin: [10, 0, 0, 0],
                },
				
                <%-- <%
	        	if(isSubSystem.equalsIgnoreCase("N")) {
	        		
	        	%> --%>
                {
                    table: {
                        headerRows: 1,
                        widths: [
                        	 
                            <%-- <% for (int i = 0; i <subsystems.size()+2; i++) { %>
                                'auto',
                            <% } %> --%>
                            '4%', '12%', 
                            <% for (int i = 0; i <productTreeList.size(); i++) { %>
                            	'<%= (double)((double)84/(double)(productTreeList.size())) %>%',
                        	<% } %>
                            
                        ],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader2' },
                                { text: 'Sub-System', style: 'tableHeader2' },
                                <% for (Object[] subsystem : productTreeList) { %>
                                    { text: '<%= subsystem != null ? subsystem[2]!=null?StringEscapeUtils.escapeHtml4(subsystem[2].toString()): " - " + " (" + subsystem[7]!=null?StringEscapeUtils.escapeHtml4(subsystem[7].toString()): " - " + ")" : "" %>', style: 'tableHeader2' },
                                <% } %>
                            ],

                            // Populate table rows
                            <% 
   
                            int slnoA = 0;
                            if(productTreeList!=null && productTreeList.size()>0) {
                            for (Object[] rowSubsystem : productTreeList) { %>
                                [
                                    { text: '<%= ++slnoA%>', style: 'tableData2', alignment: 'center' },
                                    { text: '<%= rowSubsystem != null ? rowSubsystem[2]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[2].toString()): " - " + " (" + rowSubsystem[7]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[7].toString()): " - " + ")" : "" %>', style: 'tableData2', alignment: 'left' },
                                    <% for (Object[] colSubsystem : productTreeList) { %>
                                        { text: 
                                            <%-- <% if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { %>
                                                'NA' --%>
                                            <% //} else { 
                                                String key = rowSubsystem[7] + "_" + colSubsystem[7];
                                                String connections = connectionMap.getOrDefault(key, "-");
                                            %>
                                                htmlToPdfmake('<%= connections != null ? StringEscapeUtils.escapeHtml4(connections) : "-" %>')
                                            <% //} %>, 
                                            style: 'tableData2',  },
                                    <% } %>
                                ],
                            <% } }else {%>
                            	[{ text: 'No Data Available', style: 'tableData2',alignment: 'center', colSpan: 2 },]
                            <%}%>
                        ]
                    },
                    layout: {
                        hLineWidth: function (i, node) { return 1; },
                        vLineWidth: function (i, node) { return 1; },
                        hLineColor: function (i, node) { return '#aaaaaa'; },
                        vLineColor: function (i, node) { return '#aaaaaa'; },
                        paddingLeft: function(i, node) { return 2; },
                        paddingRight: function(i, node) { return 2; },
                    },

                },
                
                /* ************************************** Interfaces - All End *********************************** */
                /* ************************************** Interfaces - Internal *********************************** */
                
                {
                    text: (mainContentCount)+'.2. Internal',
                    style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.2',
                    pageOrientation: 'landscape',
                    pageBreak: 'before',
                  	/* pageSize: { width: 1190.55, height: 841.89 }, */
                    pageSize: { width: 1683.78, height: 1190.55 },
                    tocMargin: [10, 0, 0, 0],
                },
				
                <%-- <%
	        	if(isSubSystem.equalsIgnoreCase("N")) {
	        		
	        	%> --%>
                {
                    table: {
                        headerRows: 1,
                        widths: [
                        	 
                            <%-- <% for (int i = 0; i <subsystems.size()+2; i++) { %>
                                'auto',
                            <% } %> --%>
                            '4%', '12%', 
                            <% for (int i = 0; i <productTreeListInternal.size(); i++) { %>
                            	'<%= (double)((double)84/(double)(productTreeListInternal.size())) %>%',
                        	<% } %>
                            
                        ],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader2' },
                                { text: 'Sub-System', style: 'tableHeader2' },
                                <% for (Object[] subsystem : productTreeListInternal) { %>
                                    { text: '<%= subsystem != null ? subsystem[2]!=null?StringEscapeUtils.escapeHtml4(subsystem[2].toString()): " - " + " (" + subsystem[7]!=null?StringEscapeUtils.escapeHtml4(subsystem[7].toString()): " - " + ")" : "" %>', style: 'tableHeader2' },
                                <% } %>
                            ],

                            // Populate table rows
                            <% 
   
                            int slnoI = 0;
                            if(productTreeListInternal!=null && productTreeListInternal.size()>0) {
                            for (Object[] rowSubsystem : productTreeListInternal) { %>
                                [
                                    { text: '<%= ++slnoI%>', style: 'tableData2', alignment: 'center' },
                                    { text: '<%= rowSubsystem != null ? rowSubsystem[2]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[2].toString()): " - " + " (" + rowSubsystem[7]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[7].toString()): " - " + ")" : "" %>', style: 'tableData2', alignment: 'left' },
                                    <% for (Object[] colSubsystem : productTreeListInternal) { %>
                                        { text: 
                                            <%-- <% if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { %>
                                                'NA' --%>
                                            <% //} else { 
                                                String key = rowSubsystem[7] + "_" + colSubsystem[7];
                                                String connections = connectionMap.getOrDefault(key, "-");
                                            %>
                                                htmlToPdfmake('<%= connections != null ? StringEscapeUtils.escapeHtml4(connections) : "-" %>')
                                            <% //} %>, 
                                            style: 'tableData2',  },
                                    <% } %>
                                ],
                            <% } }else {%>
                            	[{ text: 'No Data Available', style: 'tableData2',alignment: 'center', colSpan: 2 },]
                            <%}%>
                            
                        ]
                    },
                    layout: {
                        hLineWidth: function (i, node) { return 1; },
                        vLineWidth: function (i, node) { return 1; },
                        hLineColor: function (i, node) { return '#aaaaaa'; },
                        vLineColor: function (i, node) { return '#aaaaaa'; },
                        paddingLeft: function(i, node) { return 2; },
                        paddingRight: function(i, node) { return 2; },
                    },

                },

                /* ************************************** Interfaces - Internal End *********************************** */
                /* ************************************** Interfaces - External *********************************** */
                
                {
                	text: (mainContentCount)+'.3. External',
                    style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.3',
                    pageOrientation: 'landscape',
                    pageBreak: 'before',
                  	/* pageSize: { width: 1190.55, height: 841.89 }, */
                    pageSize: { width: 1683.78, height: 1190.55 },
                    tocMargin: [10, 0, 0, 0],
                },
				
                <%-- <%
	        	if(isSubSystem.equalsIgnoreCase("N")) {
	        		
	        	%> --%>
                {
                    table: {
                        headerRows: 1,
                        widths: [
                        	 
                            <%-- <% for (int i = 0; i <subsystems.size()+2; i++) { %>
                                'auto',
                            <% } %> --%>
                            '4%', '12%', 
                            <% for (int i = 0; i <productTreeListExternal.size(); i++) { %>
                            	'<%= (double)((double)84/(double)(productTreeListExternal.size())) %>%',
                        	<% } %>
                            
                        ],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader2' },
                                { text: 'Sub-System', style: 'tableHeader2' },
                                <% for (Object[] subsystem : productTreeListExternal) { %>
                                    { text: '<%= subsystem != null ? subsystem[2]!=null?StringEscapeUtils.escapeHtml4(subsystem[2].toString()): " - " + " (" + subsystem[7]!=null?StringEscapeUtils.escapeHtml4(subsystem[7].toString()): " - " + ")" : "" %>', style: 'tableHeader2' },
                                <% } %>
                            ],

                            // Populate table rows
                            <% 
   
                            int slnoE = 0;
                            if(productTreeListExternal!=null && productTreeListExternal.size()>0) {
                            for (Object[] rowSubsystem : productTreeListExternal) { %>
                                [
                                    { text: '<%= ++slnoE%>', style: 'tableData2', alignment: 'center' },
                                    { text: '<%= rowSubsystem != null ? rowSubsystem[2]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[2].toString()): " - " + " (" + rowSubsystem[7]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[7].toString()): " - " + ")" : "" %>', style: 'tableData2', alignment: 'left' },
                                    <% for (Object[] colSubsystem : productTreeListExternal) { %>
                                        { text: 
                                            <% if (rowSubsystem[11].toString().equalsIgnoreCase("I") && colSubsystem[11].toString().equalsIgnoreCase("I")) { %>
                                                'NA' 
                                            <% } else { 
                                                String key = rowSubsystem[7] + "_" + colSubsystem[7];
                                                String connections = connectionMap.getOrDefault(key, "-");
                                            %>
                                                htmlToPdfmake('<%= connections != null ? StringEscapeUtils.escapeHtml4(connections) : "-" %>')
                                            <% } %>, 
                                            style: 'tableData2',  },
                                    <% } %>
                                ],
                            <% } }else {%>
                            	[{ text: 'No Data Available', style: 'tableData2',alignment: 'center', colSpan: 2 },]
                            <%}%>
                        ]
                    },
                    layout: {
                        hLineWidth: function (i, node) { return 1; },
                        vLineWidth: function (i, node) { return 1; },
                        hLineColor: function (i, node) { return '#aaaaaa'; },
                        vLineColor: function (i, node) { return '#aaaaaa'; },
                        paddingLeft: function(i, node) { return 2; },
                        paddingRight: function(i, node) { return 2; },
                    },

                },
                
                /* ************************************** Interfaces - External End *********************************** */
                
                
                <%-- <% }else { %>
	        	
	        	{
                    table: {
                        headerRows: 1,
                        widths: [
                        	 
                        	'4%', '12%', 
                            <% for (int i = 0; i <productTreeAllList.size(); i++) { %>
                            	'<%= (double)((double)84/(double)(productTreeAllList.size())) %>%',
                        	<% } %>
                        ],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader2' },
                                { text: 'Sub-System', style: 'tableHeader2' },
                                <% for (Object[] supersubsystem : productTreeAllList) { %>
                                    { text: '<%= supersubsystem != null ? supersubsystem[2] + " (" + supersubsystem[7] + ")" : "" %>', style: 'tableHeader2' },
                                <% } %>
                            ],

                            // Populate table rows
                            <% 
                            int slnoSS = 0;
                            for (Object[] rowSuperSubsystem : productTreeAllList) { %>
                                [
                                    { text: '<%= ++slnoSS%>', style: 'tableData2', alignment: 'center' },
                                    { text: '<%= rowSuperSubsystem != null ? rowSuperSubsystem[2] + " (" + rowSuperSubsystem[7] + ")" : "" %>', style: 'tableData2', alignment: 'left' },
                                    <% for (Object[] colSuperSubsystem : productTreeAllList) { %>
                                        { text: 
                                            <% if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { %>
                                                'NA'
                                            <% //} else { 
                                                String key = rowSuperSubsystem[7] + "_" + colSuperSubsystem[7];
                                                String connections = superSubConnectionMap.getOrDefault(key, "-");
                                            %>
                                                htmlToPdfmake('<%= connections != null ? connections : "-" %>')
                                            <% //} %>, 
                                            style: 'tableData2', alignment: 'center' },
                                    <% } %>
                                ],
                            <% } %>
                        ]
                    },
                    layout: {
                        hLineWidth: function (i, node) { return 1; },
                        vLineWidth: function (i, node) { return 1; },
                        hLineColor: function (i, node) { return '#aaaaaa'; },
                        vLineColor: function (i, node) { return '#aaaaaa'; },
                        paddingLeft: function(i, node) { return 2; },
                        paddingRight: function(i, node) { return 2; },
                    },

                },
                
	        	<%} %> --%>
                
	        	 /* ************************************** Interfaces End *********************************** */
	        	 
	        	 /* ************************************** Interface Summary *********************************** */
	        	 
                {
                	text: (++mainContentCount)+'. Interface Summary',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageOrientation: 'landscape',
                    pageBreak: 'before',
                    pageSize: { width: 841.89, height: 595.28 },
                },
                {
                    table: {
                        headerRows: 1,
                        /* widths: ['15%', '15%', '15%', '10%', '15%', '15%', '10%' ], */
                        /* widths: ['auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto' ], */
                        widths: ['6%', '20%', '20%', '20%', '14%', '20%' ],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader2' },
                                { text: 'End-1', style: 'tableHeader2' },
                                { text: 'End-2', style: 'tableHeader2' },
                                { text: 'Interface', style: 'tableHeader2' },
                                { text: 'Parameter', style: 'tableHeader2' },
                                { text: 'Purpose', style: 'tableHeader2' },
                            ],
                            // Populate table rows
                            
                            <%if(icdConnectionsList!=null && icdConnectionsList.size()>0) {
                            	
                            	int slno = 0;
                    			
                    			for(ICDConnectionDTO con : icdConnectionsList) { %>
	                    		[
	                    			{ text: '<%=++slno %>', style: 'tableData2',alignment: 'center' },
	                                <%-- { text: '<%=obj[4]+"_"+obj[5]+"_"+obj[8]+((count>=100)?"_"+count:((count>=10)?"_0"+count:"_00"+count)) %>', style: 'tableData',alignment: 'center' }, --%> 
	                                { text: '<%=con.getLevelNamesS1()!=null?StringEscapeUtils.escapeHtml4(con.getLevelNamesS1()): "-" %>', style: 'tableData2' },
	                                { text: '<%=con.getLevelNamesS2()!=null?StringEscapeUtils.escapeHtml4(con.getLevelNamesS2()): "-" %>', style: 'tableData2' },
	                                { text: '<%=con.getInterfaceNames()!=null?StringEscapeUtils.escapeHtml4(con.getInterfaceNames()):"-" %>', style: 'tableData2', },
	                                { text: '<%=con.getParameterDatas()!=null?StringEscapeUtils.escapeHtml4(con.getParameterDatas()):"-" %>', style: 'tableData2', },
	                                { text: '<%=con.getPurpose()!=null?StringEscapeUtils.escapeHtml4(con.getPurpose()):"-" %>', style: 'tableData2', },
	                            ],
                    		<%} } else { %>
								[{ text: 'No Data Available', style: 'tableData2',alignment: 'center', colSpan: 6 },]
                    		<%} %>
                        ]
                    },
                    layout: {
                        hLineWidth: function (i, node) { return 1; },
                        vLineWidth: function (i, node) { return 1; },
                        hLineColor: function (i, node) { return '#aaaaaa'; },
                        vLineColor: function (i, node) { return '#aaaaaa'; },
                        paddingLeft: function(i, node) { return 2; },
                        paddingRight: function(i, node) { return 2; },
                    },
                },
                
                /* ************************************** Interface Summary End *********************************** */
	        	 
	        	 /* ************************************** Pin Details Summary *********************************** */
	        	 
                {
                	text: (++mainContentCount)+'. Pin Details Summary',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageOrientation: 'landscape',
                    pageBreak: 'before',
                    pageSize: { width: 841.89, height: 595.28 },
                },
                <%
                if (pinMapListBySystem != null) {
                    int slno = 0;
                	for (Map.Entry<Long, List<ICDPinMapDTO>> entry : pinMapListBySystem.entrySet()) {
                        Long subSystemId = entry.getKey();
                        List<ICDPinMapDTO> dtoList = entry.getValue();
                        ICDPinMapDTO firstRow = dtoList.stream().findFirst().orElse(null);
						ICDSystemAttach attach = icdSystemAttachList.stream().filter(e -> e.getSubSystemId().equals(subSystemId)).findFirst().orElse(null);
                %>
                
                {
                	text: mainContentCount+'.<%=++slno%>. <%=firstRow!=null? firstRow.getLevelNameE1()!=null?StringEscapeUtils.escapeHtml4(firstRow.getLevelNameE1()): " - "+"("+firstRow.getLevelCodeE1()!=null?StringEscapeUtils.escapeHtml4(firstRow.getLevelCodeE1()): " - "+")":"-" %>',	
                	style: 'chapterSubHeader',
                    tocItem: true,
                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.<%=slno%>',
                    <%-- id: '<%=iface.getInterfaceCode() %>', --%>
                    tocMargin: [10, 0, 0, 0],
                },
                
                <%
                if(attach!=null && attach.getAttachment()!=null && !attach.getAttachment().isEmpty()){
	                Path imagepath = Paths.get(filePath, labcode, "ICD", "SubSystems", attach.getAttachment());
           			File imagepathFile = imagepath.toFile();
                	if(imagepathFile.exists()){ %>
	           			{
	                    	image: 'data:image/png;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(imagepathFile))%>',
	                    	width: 500,
	                       	height: 400,
	                       	alignment: 'center',
	                       	margin: [0, 5, 0, 5],
	                   	},
	                   	
           		<%} }%>
           		
                {
                    table: {
                        headerRows: 1,
                        /* widths: ['15%', '15%', '15%', '10%', '15%', '15%', '10%' ], */
                        /* widths: ['auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto' ], */
                        widths: ['5%', '15%', '10%', '10%', '10%', '10%', '15%', '15%', '10%' ],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader2' },
                                { text: 'Interface Id', style: 'tableHeader2' },
                                { text: 'Function', style: 'tableHeader2' },
                                { text: 'Signal Name', style: 'tableHeader2' },
                                { text: 'Type', style: 'tableHeader2' },
                                { text: 'Cable Length', style: 'tableHeader2' },
                                { text: 'From', style: 'tableHeader2' },
                                { text: 'To', style: 'tableHeader2' },
                                { text: 'Remarks', style: 'tableHeader2' },
                            ],
                            // Populate table rows
                            
                            <%if(dtoList!=null && dtoList.size()>0) {
                            	
                            	int sn = 0;
                    			
                    			for(ICDPinMapDTO pinmap : dtoList) { %>
	                    		[
	                    			{ text: '<%=++sn %>', style: 'tableData2',alignment: 'center' },
	                                { text: '<%=pinmap.getConnectionCode()!=null?StringEscapeUtils.escapeHtml4(pinmap.getConnectionCode()): "-" %>', style: 'tableData2' },
	                                { text: '<%=pinmap.getPinFunction()!=null?StringEscapeUtils.escapeHtml4(pinmap.getPinFunction()): "-" %>', style: 'tableData2' },
	                                { text: '<%=pinmap.getSignalName()!=null?StringEscapeUtils.escapeHtml4(pinmap.getSignalName()):"-" %>', style: 'tableData2', },
	                                { text: '<%if(pinmap.getInterfaceId()==-1) { %>Not Connected<%} else if(pinmap.getInterfaceId()==0){ %>Ground<%} else{ %><%=pinmap.getInterfaceContent()!=null?StringEscapeUtils.escapeHtml4(pinmap.getInterfaceContent()):"-" %><%} %>', style: 'tableData2', },
	                                { text: '<%=pinmap.getCableMaxLength()!=null?StringEscapeUtils.escapeHtml4(pinmap.getCableMaxLength().toString()):"-" %>', style: 'tableData2',alignment: 'center', },
	                                { text: '<%=pinmap.getLevelNameE1()!=null?StringEscapeUtils.escapeHtml4(pinmap.getLevelNameE1()): " - " %> (<%=pinmap.getLevelCodeE1()!=null?StringEscapeUtils.escapeHtml4(pinmap.getLevelCodeE1()): " - " %>) - <%=pinmap.getPinNoE1()!=null?StringEscapeUtils.escapeHtml4(pinmap.getPinNoE1()): " - " %>', style: 'tableData2', },
	                                { text: '<%=pinmap.getLevelNameE2()!=null?StringEscapeUtils.escapeHtml4(pinmap.getLevelNameE2()): " - " %> (<%=pinmap.getLevelCodeE2()!=null?StringEscapeUtils.escapeHtml4(pinmap.getLevelCodeE2()): " - " %>) - <%=pinmap.getPinNoE2()!=null?StringEscapeUtils.escapeHtml4(pinmap.getPinNoE2()): " - " %>', style: 'tableData2', },
	                                { text: '<%=pinmap.getRemarks()!=null && !pinmap.getRemarks().isEmpty()?StringEscapeUtils.escapeHtml4(pinmap.getRemarks()):"-" %>', style: 'tableData2', },

	                            ],
                    		<%} } else { %>
								[{ text: 'No Data Available', style: 'tableData2',alignment: 'center', colSpan: 9 },]
                    		<%} %>
                        ]
                    },
                    layout: {
                        hLineWidth: function (i, node) { return 1; },
                        vLineWidth: function (i, node) { return 1; },
                        hLineColor: function (i, node) { return '#aaaaaa'; },
                        vLineColor: function (i, node) { return '#aaaaaa'; },
                        paddingLeft: function(i, node) { return 2; },
                        paddingRight: function(i, node) { return 2; },
                    },
                },
                <%} } %>
                /* ************************************** Pin Details Summary End *********************************** */
                	        	 
	        	/* ************************************** Connector & Pin Details *********************************** */
	        	 {
                	text: (++mainContentCount)+'. Connector & Pin Details',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageOrientation: 'landscape',
                    pageBreak: 'before',
                    pageSize: { width: 841.89, height: 595.28 },
                },
	        	<%if(icdConnectionsList!=null && icdConnectionsList.size()>0) {
					int slno = 0;
					for(ICDConnectionDTO con : icdConnectionsList) { 

						List<ICDPinMapDTO> connectionPinMapList = icdConnectorPinMapList.stream().filter(e -> e.getICDConnectionId().equals(con.getICDConnectionId())).collect(Collectors.toList());
						List<Long> connectorIds = allICDConnectorList.stream().filter(e-> e.getICDConnectionId().equals(con.getICDConnectionId())).map(e -> e.getConnectorId()).collect(Collectors.toList());
						List<IGIConnector> connectorsList = connectorMasterList.stream().filter(e -> connectorIds.contains(e.getConnectorId())).collect(Collectors.toList());
						List<String> partNos = new ArrayList<>();
						for (IGIConnector conn : connectorsList) {
						    partNos.add(conn.getPartNo());
						}
					%>
						{
		                	text: mainContentCount+'.<%=++slno%>. <%=con.getLevelNamesS1()!=null?StringEscapeUtils.escapeHtml4(con.getLevelNamesS1()): "-" %> to <%=con.getLevelNamesS2()!=null?StringEscapeUtils.escapeHtml4(con.getLevelNamesS2()): "-" %>',	
		                	style: 'chapterSubHeader',
		                    tocItem: true,
		                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.<%=slno%>',
		                    <%-- id: '<%=iface.getInterfaceCode() %>', --%>
		                    tocMargin: [10, 0, 0, 0],
		                },	 
		                {
		                	text: 'Connectors: [<%=String.join(", ", partNos)%>]',
		                	margin: [10, 0, 0, 0],
		                	bold: true,
		                	fontSize: 11.5,
		                },
		                <%
		                if(con.getDrawingAttach()!=null && !con.getDrawingAttach().isEmpty()){
			                Path imagepath = Paths.get(filePath, labcode, "ICD", "Connections", con.getDrawingAttach());
		           			File imagepathFile = imagepath.toFile();
		                	if(imagepathFile.exists()){ %>
			           			{
			                    	image: 'data:image/png;base64,<%=Base64.getEncoder().encodeToString(FileUtils.readFileToByteArray(imagepathFile))%>',
			                    	width: 500,
			                       	height: 100,
			                       	alignment: 'center',
			                       	margin: [0, 5, 0, 5],
			                   	},
			                   	
			                   	{
				                	text: 'Figure-'+mainContentCount+'.<%=slno%>',
				                	alignment: 'center',
				                	bold: true,
				                	fontSize: 10.5,
				                	margin: [0, 5, 0, 10],
				                },
		           		<%} }%>
		           		
		                {
		                    table: {
		                        headerRows: 1,
		                        /* widths: ['15%', '15%', '15%', '10%', '15%', '15%', '10%' ], */
		                        /* widths: ['auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto' ], */
		                        widths: ['5%', '15%', '10%', '10%', '10%', '10%', '15%', '15%', '10%' ],
		                        body: [
		                            // Table header
		                            [
		                                { text: 'SN', style: 'tableHeader2' },
		                                { text: 'Interface Id', style: 'tableHeader2' },
		                                { text: 'Function', style: 'tableHeader2' },
		                                { text: 'Signal Name', style: 'tableHeader2' },
		                                { text: 'Type', style: 'tableHeader2' },
		                                { text: 'Cable Length', style: 'tableHeader2' },
		                                { text: 'From', style: 'tableHeader2' },
		                                { text: 'To', style: 'tableHeader2' },
		                                { text: 'Remarks', style: 'tableHeader2' },
		                            ],
		                            // Populate table rows
		                            
		                            <%if(connectionPinMapList!=null && connectionPinMapList.size()>0) {
		                            	
		                            	int sn = 0;
		                    			
		                    			for(ICDPinMapDTO pinmap : connectionPinMapList) { %>
			                    		[
			                    			{ text: '<%=++sn %>', style: 'tableData2',alignment: 'center' },
			                                { text: '<%=pinmap.getConnectionCode()!=null?StringEscapeUtils.escapeHtml4(pinmap.getConnectionCode()): "-" %>', style: 'tableData2' },
			                                { text: '<%=pinmap.getPinFunction()!=null?StringEscapeUtils.escapeHtml4(pinmap.getPinFunction()): "-" %>', style: 'tableData2' },
			                                { text: '<%=pinmap.getSignalName()!=null?StringEscapeUtils.escapeHtml4(pinmap.getSignalName()):"-" %>', style: 'tableData2', },
			                                { text: '<%if(pinmap.getInterfaceId()==-1) { %>Not Connected<%} else if(pinmap.getInterfaceId()==0){ %>Ground<%} else{ %><%=pinmap.getInterfaceContent()!=null?StringEscapeUtils.escapeHtml4(pinmap.getInterfaceContent()):"-" %><%} %>', style: 'tableData2', },
			                                { text: '<%=pinmap.getCableMaxLength()!=null?StringEscapeUtils.escapeHtml4(pinmap.getCableMaxLength().toString()):"-" %>', style: 'tableData2',alignment: 'center', },
			                                { text: '<%=pinmap.getLevelNameE1()!=null?StringEscapeUtils.escapeHtml4(pinmap.getLevelNameE1()): " - " %> (<%=pinmap.getLevelCodeE1()!=null?StringEscapeUtils.escapeHtml4(pinmap.getLevelCodeE1()): " - " %>) - <%=pinmap.getPinNoE1()!=null?StringEscapeUtils.escapeHtml4(pinmap.getPinNoE1()): " - " %>', style: 'tableData2', },
			                                { text: '<%=pinmap.getLevelNameE2()!=null?StringEscapeUtils.escapeHtml4(pinmap.getLevelNameE2()): " - " %> (<%=pinmap.getLevelCodeE2()!=null?StringEscapeUtils.escapeHtml4(pinmap.getLevelCodeE2()): " - " %>) - <%=pinmap.getPinNoE2()!=null?StringEscapeUtils.escapeHtml4(pinmap.getPinNoE2()): " - " %>', style: 'tableData2', },
			                                { text: '<%=pinmap.getRemarks()!=null && !pinmap.getRemarks().isEmpty()?StringEscapeUtils.escapeHtml4(pinmap.getRemarks()):"-" %>', style: 'tableData2', },

			                            ],
		                    		<%} } else { %>
										[{ text: 'No Data Available', style: 'tableData2',alignment: 'center', colSpan: 9 },]
		                    		<%} %>
		                        ]
		                    },
		                    layout: {
		                        hLineWidth: function (i, node) { return 1; },
		                        vLineWidth: function (i, node) { return 1; },
		                        hLineColor: function (i, node) { return '#aaaaaa'; },
		                        vLineColor: function (i, node) { return '#aaaaaa'; },
		                        paddingLeft: function(i, node) { return 2; },
		                        paddingRight: function(i, node) { return 2; },
		                    },
		                    margin: [10, 0, 0, 10],
		                },
               <%} }%>

	        	 /* ************************************** Connector & Pin Details *********************************** */
	        	 
                /* ************************************** Interface Details *********************************** */
                {
                	text: (++mainContentCount)+'. Interface Details',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageOrientation: 'potrait',
                    pageBreak: 'before',
                },
                
                {
                	text: '',
                    style: 'chapterHeader',
                    tocItem: false,
                    id: 'chapter'+(++chapterCount),
                    /* pageOrientation: 'landscape',
                    pageBreak: 'before',
                    pageSize: { width: 841.89, height: 595.28 }, */
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['9%', '19%', '12%', '60%' ],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Interface Type', style: 'tableHeader' },
                                { text: 'Count', style: 'tableHeader' },
                                { text: 'Sub-Systems', style: 'tableHeader' },
                            ],
                            // Populate table rows
                            <%if (interfaceTypeValuesMap != null && !interfaceTypeValuesMap.isEmpty()) {
							    int slno = 0;
							    
							    for (Map.Entry<String, List<String>> entry : interfaceTypeValuesMap.entrySet()) {
							        String type = entry.getKey();
							        List<String> values = entry.getValue();
							        Set<String> printedValues = new HashSet<>();
							        List<String> uniqueValues = new ArrayList<>();
							        for (String val : values) {
							            if (printedValues.add(val)) {
							                uniqueValues.add(val);
							            }
							        }
							%>
							        [
							            { text: '<%= ++slno %>', style: 'tableData', alignment: 'center' },
							            { text: '<%= type %>', style: 'tableData',  },
							            { text: '<%= uniqueValues.size() %>', style: 'tableData', alignment: 'center' },
							            { text: '<%= uniqueValues %>', style: 'tableData', },
							        ],
							<% } } else {%>
								[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 4 },]
                            <%} %>

                        ]
                    },
                    layout: {
                        hLineWidth: function (i, node) { return 1; },
                        vLineWidth: function (i, node) { return 1; },
                        hLineColor: function (i, node) { return '#aaaaaa'; },
                        vLineColor: function (i, node) { return '#aaaaaa'; },
                        paddingLeft: function(i, node) { return 2; },
                        paddingRight: function(i, node) { return 2; },
                    },
                },
                
                <%if(interfaceCodeList!=null && interfaceCodeList.size()>0) {
                	int slno = 0 ;
                	for(String interfaceCode : interfaceCodeList) {
                		int sn = 0;
                		IGIInterface iface = interfaceListToMap.get(interfaceCode);
                		List<String> connectionCodes = codeValuesMap.getOrDefault(iface.getInterfaceCode(), Collections.emptyList());
                		IGIInterfaceTypes igiinterfaceTypes = interfaceTypesList.stream().filter(e -> iface.getInterfaceTypeId().equals(e.getInterfaceTypeId())).findFirst().orElse(null);
						IGIInterfaceContent igiInterfaceContent = interfaceContentList.stream().filter(e -> iface.getInterfaceContentId().equals(e.getInterfaceContentId())).findFirst().orElse(null);
						IGIConnector e1Con = connectorMasterList.stream().filter(e -> e.getConnectorId().equals(iface.getConnectorIdEOne())).findFirst().orElse(null);
						IGIConnector e2Con = connectorMasterList.stream().filter(e -> e.getConnectorId().equals(iface.getConnectorIdETwo())).findFirst().orElse(null);
                %>
	                {
	                	text: mainContentCount+'.<%=++slno%>. <%=iface.getInterfaceName()!=null?StringEscapeUtils.escapeHtml4(iface.getInterfaceName()): " - " %>',	
	                	style: 'chapterSubHeader',
	                    tocItem: true,
	                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.<%=slno%>',
	                    <%-- id: '<%=iface.getInterfaceCode() %>', --%>
	                    tocMargin: [10, 0, 0, 0],
	                },
	                
	                {
	                	text: 'Sub-Systems: <%=connectionCodes%>',
	                	margin: [10, 5, 10, 10],
	                	bold: true,
	                	fontSize: 11.5,
	                },
	                
	                {
	                	table: {
	                        headerRows: 1,
	                        widths: ['10%', '25%', '65%'],
	                        body: [
	                            // Table header
	                            [
	                                { text: 'SN', style: 'tableHeader' },
	                                { text: 'Section', style: 'tableHeader' },
	                                { text: 'Details', style: 'tableHeader' },
	                            ],
	                            // Populate table rows
	                            <%-- [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Unique Interface Id', style: 'tableData', bold: true},
	                                { text: '<%=iface.getInterfaceSeqNo()+"_"+iface.getInterfaceCode() %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Seq', style: 'tableData', bold: true},
	                                { text: '<%=iface.getInterfaceSeqNo() %>', style: 'tableData' },
	                            ], --%>
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Code', style: 'tableData', bold: true},
	                                { text: '<%=iface.getInterfaceCode()!=null?StringEscapeUtils.escapeHtml4(iface.getInterfaceCode()): " - " %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Name', style: 'tableData', bold: true },
	                                { text: '<%=iface.getInterfaceName()!=null?StringEscapeUtils.escapeHtml4(iface.getInterfaceName()): " - " %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Description', style: 'tableData', bold: true},
	                                <%if(iface.getInterfaceDescription()!=null && !iface.getInterfaceDescription().isEmpty()) {%>
	                                	{ stack: [htmlToPdfmake(setImagesWidth('<%=iface.getInterfaceDescription()!=null?StringEscapeUtils.escapeHtml4(iface.getInterfaceDescription()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):" - " %>', 600))],},
	                                <%}else {%>
	                                	{ text: '-', style: 'tableData'},
	                                <%} %>
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Type', style: 'tableData', bold: true },
	                                { text: '<%=igiinterfaceTypes!=null?StringEscapeUtils.escapeHtml4(igiinterfaceTypes.getInterfaceType()):"-" %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Content', style: 'tableData', bold: true },
	                                { text: '<%=igiInterfaceContent!=null?StringEscapeUtils.escapeHtml4(igiInterfaceContent.getInterfaceContent()):"-" %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Type of Data', style: 'tableData', bold: true },
	                                { text: '<%=iface.getParameterData() %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'End-1 Connector', style: 'tableData', bold: true },
	                                { text: 'Part No : <%=(e1Con!=null && e1Con.getPartNo()!=null && !e1Con.getPartNo().isEmpty())? StringEscapeUtils.escapeHtml4(e1Con.getPartNo()):"-" %>'
	                                		+'\n' + 'Connector Make : <%=(e1Con!=null && e1Con.getConnectorMake()!=null && !e1Con.getConnectorMake().isEmpty())? StringEscapeUtils.escapeHtml4(e1Con.getConnectorMake()):"-" %>'
	                                		+'\n' + 'Standard : <%=(e1Con!=null && e1Con.getStandardName()!=null && !e1Con.getStandardName().isEmpty())?StringEscapeUtils.escapeHtml4(e1Con.getStandardName()):"-" %>'
	                                		+'\n' + 'Protection : <%=(e1Con!=null && e1Con.getProtection()!=null && !e1Con.getProtection().isEmpty())? StringEscapeUtils.escapeHtml4(e1Con.getProtection()):"-" %>'
	                                		+'\n' + 'Ref Info : <%=(e1Con!=null && e1Con.getRefInfo()!=null && !e1Con.getRefInfo().isEmpty())?StringEscapeUtils.escapeHtml4(e1Con.getRefInfo()):"-" %>'
	                                		+'\n' + 'Remarks : <%=(e1Con!=null && e1Con.getRemarks()!=null && !e1Con.getRemarks().isEmpty())?StringEscapeUtils.escapeHtml4(e1Con.getRemarks()):"-" %>'
	                                		, style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'End-2 Connector', style: 'tableData', bold: true },
	                                { text: 'Part No : <%=(e2Con.getPartNo()!=null && !e2Con.getPartNo().isEmpty())? StringEscapeUtils.escapeHtml4(e2Con.getPartNo()):"-" %>'
	                                		+'\n' + 'Connector Make : <%=(e2Con.getConnectorMake()!=null && !e2Con.getConnectorMake().isEmpty())? StringEscapeUtils.escapeHtml4(e2Con.getConnectorMake()):"-" %>'
	                                		+'\n' + 'Standard : <%=(e2Con.getStandardName()!=null && !e2Con.getStandardName().isEmpty())? StringEscapeUtils.escapeHtml4(e2Con.getStandardName()):"-" %>'
	                                		+'\n' + 'Protection : <%=(e2Con.getProtection()!=null && !e2Con.getProtection().isEmpty())? StringEscapeUtils.escapeHtml4(e2Con.getProtection()):"-" %>'
	                                		+'\n' + 'Ref Info : <%=(e2Con.getRefInfo()!=null && !e2Con.getRefInfo().isEmpty())?StringEscapeUtils.escapeHtml4(e2Con.getRefInfo()):"-" %>'
	                                		+'\n' + 'Remarks : <%=(e2Con.getRemarks()!=null && !e2Con.getRemarks().isEmpty())?StringEscapeUtils.escapeHtml4(e2Con.getRemarks()):"-" %>'
	                                		, style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Speed', style: 'tableData', bold: true },
	                                { text: '<%=iface.getInterfaceSpeed()!=null?StringEscapeUtils.escapeHtml4(iface.getInterfaceSpeed()): " - " %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Cable Information', style: 'tableData', bold: true },
	                                { text: '<%=(iface.getCableInfo()!=null && !iface.getCableInfo().isEmpty())? StringEscapeUtils.escapeHtml4(iface.getCableInfo()):"-" %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Cable Constraint', style: 'tableData', bold: true },
	                                { text: '<%=(iface.getCableConstraint()!=null && !iface.getCableConstraint().isEmpty())?StringEscapeUtils.escapeHtml4(iface.getCableConstraint()):"-" %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Cable Diameter', style: 'tableData', bold: true },
	                                { text: '<%=(iface.getCableDiameter()!=null && !iface.getCableDiameter().isEmpty())? StringEscapeUtils.escapeHtml4(iface.getCableDiameter()):"-" %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Cable Details', style: 'tableData', bold: true },
	                                { text: '<%=(iface.getCableDetails()!=null && !iface.getCableDetails().isEmpty())? StringEscapeUtils.escapeHtml4(iface.getCableDetails()):"-" %>', style: 'tableData' },
	                            ],
	                            
	                            <%if(iface.getInterfaceDiagram()!=null && !iface.getInterfaceDiagram().isEmpty()) {%>
		                            [
		                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
		                                { text: 'Diagram', style: 'tableData', bold: true, colSpan: 2 },
		                            ],
		                            [
	                        			{ stack: [htmlToPdfmake(setImagesWidth('<%=iface.getInterfaceDiagram().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>', 600))], colSpan: 3,},
	                            	],
	                            <%} %>
	                        ]
	                    },
	                    layout: {
	                        /* fillColor: function(rowIndex) {
	                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
	                        }, */
	                        hLineWidth: function(i, node) {
	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
	                        },
	                        vLineWidth: function(i) {
	                            return 0.5;
	                        },
	                        hLineColor: function(i) {
	                            return '#aaaaaa';
	                        },
	                        vLineColor: function(i) {
	                            return '#aaaaaa';
	                        }
	                    },
	                },
	                { text: '\n',},
                
                <%} }%>
                /* ************************************** Interface Details End *********************************** */

                /* ************************************** Mechanical Interfaces *********************************** */
                {
                	text: (++mainContentCount)+'. Mechanical Interfaces',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageOrientation: 'potrait',
                    pageBreak: 'before',
                },
                
                <%if(mechanicalInterfacesList!=null && mechanicalInterfacesList.size()>0) {
                	int mechCount = 0;
                	for(Object[] obj : mechanicalInterfacesList) {
                		int sn = 0;
                %>
	                {
	                	text: mainContentCount+'. <%=++mechCount%>. <%=obj[6]%>',	
	                	style: 'chapterSubHeader',
	                    tocItem: true,
	                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.<%=mechCount%>',
	                    tocMargin: [10, 0, 0, 0],
	                },
                
	                {
	                	table: {
	                        headerRows: 1,
	                        widths: ['10%', '25%', '65%'],
	                        body: [
	                            // Table header
	                            [
	                                { text: 'SN', style: 'tableHeader' },
	                                { text: 'Section', style: 'tableHeader' },
	                                { text: 'Details', style: 'tableHeader' },
	                            ],
	                            
	                            // Populate table rows
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Code', style: 'tableData', bold: true},
	                                { text: '<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Name', style: 'tableData', bold: true},
	                                { text: '<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'System-1', style: 'tableData', bold: true},
	                                { text: '<%=obj[16]!=null?StringEscapeUtils.escapeHtml4(obj[16].toString()): " - " %> (<%=obj[18]!=null?StringEscapeUtils.escapeHtml4(obj[18].toString()): " - " %>)', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'System-2', style: 'tableData', bold: true},
	                                { text: '<%=obj[17]!=null?StringEscapeUtils.escapeHtml4(obj[17].toString()): " - " %> (<%=obj[19]!=null?StringEscapeUtils.escapeHtml4(obj[19].toString()): " - " %>)', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Part-1', style: 'tableData', bold: true},
	                                <%if(obj[7]!=null && !obj[7].toString().isEmpty()) { %>
	                                	{ text: htmlToPdfmake('<%=StringEscapeUtils.escapeHtml4(obj[7].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'), style: 'tableData' },
	                                <%}else { %>
	                                	{ text: '-', style: 'tableData'},
	                                <%} %>
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Drawing-1', style: 'tableData', bold: true},
	                                {
	                                    text: 'Drawing-1 Download',
	                                    style: 'tableData',
	                                    link: '<%= request.getRequestURL().toString().replace(request.getRequestURI(), "") + request.getContextPath() + "/ICDMechanicalDrawingAttachDownload.htm?drawingAttach=" + obj[9] %>',
	                                    color: 'blue',
	                                    decoration: 'underline',
	                                    alignment: 'left',
	                                },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Part-2', style: 'tableData', bold: true},
	                                <%if(obj[8]!=null && !obj[8].toString().isEmpty()) { %>
	                                	{ text: htmlToPdfmake('<%=StringEscapeUtils.escapeHtml4(obj[8].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'), style: 'tableData' },
	                                <%}else { %>
	                                	{ text: '-', style: 'tableData'},
	                                <%} %>
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Drawing-2', style: 'tableData', bold: true},
	                                {
	                                    text: 'Drawing-2 Download',
	                                    style: 'tableData',
	                                    link: '<%= request.getRequestURL().toString().replace(request.getRequestURI(), "") + request.getContextPath() + "/ICDMechanicalDrawingAttachDownload.htm?drawingAttach=" + obj[10] %>',
	                                    color: 'blue',
	                                    decoration: 'underline',
	                                    alignment: 'left',
	                                },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Description', style: 'tableData', bold: true},
	                                <%if(obj[11]!=null && !obj[11].toString().isEmpty()) { %>
		                                { text: htmlToPdfmake('<%=StringEscapeUtils.escapeHtml4(obj[11].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'), style: 'tableData' },
	                                <%}else { %>
	                                	{ text: '-', style: 'tableData'},
	                                <%} %>
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Standards', style: 'tableData', bold: true},
	                                <%if(obj[12]!=null && !obj[12].toString().isEmpty()) { %>
		                                { text: htmlToPdfmake('<%=StringEscapeUtils.escapeHtml4(obj[12].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'), style: 'tableData' },
	                                <%}else { %>
	                                	{ text: '-', style: 'tableData'},
	                                <%} %>
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Precautions', style: 'tableData', bold: true},
	                                <%if(obj[13]!=null && !obj[13].toString().isEmpty()) { %>
		                                { text: htmlToPdfmake('<%=StringEscapeUtils.escapeHtml4(obj[13].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'), style: 'tableData' },
	                                <%}else { %>
	                                	{ text: '-', style: 'tableData'},
	                                <%} %>	                            
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Instructions', style: 'tableData', bold: true},
	                                <%if(obj[14]!=null && !obj[14].toString().isEmpty()) { %>
		                                { text: htmlToPdfmake('<%=StringEscapeUtils.escapeHtml4(obj[14].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'), style: 'tableData' },
	                                <%}else { %>
	                                	{ text: '-', style: 'tableData'},
	                                <%} %>	                            
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Remarks', style: 'tableData', bold: true},
	                                <%if(obj[15]!=null && !obj[15].toString().isEmpty()) { %>
		                                { text: htmlToPdfmake('<%=StringEscapeUtils.escapeHtml4(obj[15].toString()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'), style: 'tableData' },
	                                <%}else { %>
	                                	{ text: '-', style: 'tableData'},
	                                <%} %>	                            
	                            ],
	                    	]
	                    },
	                    layout: {
	                        /* fillColor: function(rowIndex) {
	                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
	                        }, */
	                        hLineWidth: function(i, node) {
	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
	                        },
	                        vLineWidth: function(i) {
	                            return 0.5;
	                        },
	                        hLineColor: function(i) {
	                            return '#aaaaaa';
	                        },
	                        vLineColor: function(i) {
	                            return '#aaaaaa';
	                        }
	                    }
	                },
	                { text: '\n',},
                <%} }%>
                /* ************************************** Mechanical Interfaces End *********************************** */

           		/* ************************************** Forward Traceability *********************************** */
                {
                	text: (++mainContentCount)+'. Forward Traceability',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageOrientation: 'potrait',
                    pageBreak: 'before',
                },
                
                /* ************************************* Sub-System ******************************************  */
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '30%', '60%'],
                        body: [
                        	[
                        		{text: 'SN', style:'tableHeader'},
                        		{text: 'Sub-System', style:'tableHeader'},
                        		{text: 'Interfaces', style:'tableHeader'},
                        	],
                            // Populate table rows
                            <%if (fwdTraceValuesMap != null && !fwdTraceValuesMap.isEmpty()) {
							    int slno = 0;
							    for (Map.Entry<String, Set<String>> entry : fwdTraceValuesMap.entrySet()) {
							        String interfacecode = entry.getKey();
							        Set<String> values = entry.getValue();
							%>
							        [
							            { text: '<%= ++slno %>', style: 'tableData', alignment: 'center' },
							            { text: '<%= interfacecode!=null?StringEscapeUtils.escapeHtml4(interfacecode): " - " %>', style: 'tableData',  },
							            { text: '<%= values %>', style: 'tableData', },
							        ],
							<% } } else {%>
								[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 3 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }  
                    }
                },
                
                /* ************************************* Sub-System End ******************************************  */
                
                /* ************************************* Super Sub-System ******************************************  */
                <%-- <% if(isSubSystem.equalsIgnoreCase("Y")) { %>
                	{text: '\n\n'},
	                {
	                    table: {
	                        headerRows: 1,
	                        widths: ['10%', '30%', '60%'],
	                        body: [
	                        	[
	                        		{text: 'SN', style:'tableHeader'},
	                        		{text: 'Super Sub-System', style:'tableHeader'},
	                        		{text: 'Interfaces', style:'tableHeader'},
	                        	],
	                            // Populate table rows
	                            <%if (fwdTraceValuesMapSuperSub!= null && !fwdTraceValuesMapSuperSub.isEmpty()) {
								    int slno = 0;
								    for (Map.Entry<String, Set<String>> entry : fwdTraceValuesMapSuperSub.entrySet()) {
								        String interfacecode = entry.getKey();
								        Set<String> values = entry.getValue();
								%>
								        [
								            { text: '<%= ++slno %>', style: 'tableData', alignment: 'center' },
								            { text: '<%= interfacecode %>', style: 'tableData',  },
								            { text: '<%= values %>', style: 'tableData', },
								        ],
								<% } } else {%>
									[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 4 },]
	                            <%} %>
	                        ]
	                    },
	                    layout: {
	                        /* fillColor: function(rowIndex) {
	                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
	                        }, */
	                        hLineWidth: function(i, node) {
	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
	                        },
	                        vLineWidth: function(i) {
	                            return 0.5;
	                        },
	                        hLineColor: function(i) {
	                            return '#aaaaaa';
	                        },
	                        vLineColor: function(i) {
	                            return '#aaaaaa';
	                        }  
	                    }
	                },
                <%} %> --%>
                /* ************************************* Super Sub-System End******************************************  */
                
 				/* ************************************** Forward Traceability End *********************************** */
                
 				
           		/* ************************************** Backward Traceability *********************************** */
                {
                    text: (++mainContentCount)+'. Backward Traceability',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageBreak: 'before'
                },
                /* ************************************* Sub-System ******************************************  */
                {
                    table: {
                        headerRows: 1,
                        widths: ['10%', '30%', '60%'],
                        body: [
                        	[
                        		{text: 'SN', style:'tableHeader'},
                        		{text: 'Interface', style:'tableHeader'},
                        		{text: 'Sub-Systems', style:'tableHeader'},
                        	],
                            // Populate table rows
                            <%if (bwdTraceValuesMap != null && !bwdTraceValuesMap.isEmpty()) {
							    int slno = 0;
							    for (Map.Entry<String, Set<String>> entry : bwdTraceValuesMap.entrySet()) {
							        String subSystem = entry.getKey();
							        Set<String> values = entry.getValue();
							%>
							        [
							            { text: '<%= ++slno %>', style: 'tableData', alignment: 'center' },
							            { text: '<%= subSystem!=null?StringEscapeUtils.escapeHtml4(subSystem): " - " %>', style: 'tableData',  },
							            { text: '<%= values %>', style: 'tableData', },
							        ],
							<% } } else {%>
								[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 3 },]
                            <%} %>
                        ]
                    },
                    layout: {
                        /* fillColor: function(rowIndex) {
                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
                        }, */
                        hLineWidth: function(i, node) {
                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
                        },
                        vLineWidth: function(i) {
                            return 0.5;
                        },
                        hLineColor: function(i) {
                            return '#aaaaaa';
                        },
                        vLineColor: function(i) {
                            return '#aaaaaa';
                        }  
                    }
                },
                
                /* ************************************* Sub-System End ******************************************  */
                
                /* ************************************* Super Sub-System ******************************************  */
                
                <%-- <% if(isSubSystem.equalsIgnoreCase("Y")) { %>
            		{text: '\n\n'},
	                {
	                    table: {
	                        headerRows: 1,
	                        widths: ['10%', '30%', '60%'],
	                        body: [
	                        	[
	                        		{text: 'SN', style:'tableHeader'},
	                        		{text: 'Interface', style:'tableHeader'},
	                        		{text: 'Super Sub-Systems', style:'tableHeader'},
	                        	],
	                            // Populate table rows
	                            <%if (bwdTraceValuesMapSuperSub != null && !bwdTraceValuesMapSuperSub.isEmpty()) {
								    int slno = 0;
								    for (Map.Entry<String, Set<String>> entry : bwdTraceValuesMapSuperSub.entrySet()) {
								        String subSystem = entry.getKey();
								        Set<String> values = entry.getValue();
								%>
								        [
								            { text: '<%= ++slno %>', style: 'tableData', alignment: 'center' },
								            { text: '<%= subSystem %>', style: 'tableData',  },
								            { text: '<%= values %>', style: 'tableData', },
								        ],
								<% } } else {%>
									[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 4 },]
	                            <%} %>
	                        ]
	                    },
	                    layout: {
	                        /* fillColor: function(rowIndex) {
	                            return (rowIndex % 2 === 0) ? '#f0f0f0' : null;
	                        }, */
	                        hLineWidth: function(i, node) {
	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
	                        },
	                        vLineWidth: function(i) {
	                            return 0.5;
	                        },
	                        hLineColor: function(i) {
	                            return '#aaaaaa';
	                        },
	                        vLineColor: function(i) {
	                            return '#aaaaaa';
	                        }  
	                    }
	                },
	            <%} %> --%>    
	            /* ************************************* Super Sub-System End ******************************************  */
                /* ************************************** Backward Traceability End *********************************** */
                
			],
			styles: {
                DocumentName: { fontSize: 18, bold: true, margin: [0, 0, 0, 10] },
                chapterHeader: { fontSize: 16, bold: true, margin: [0, 0, 0, 10] },
                chapterNote: { fontSize: 13, bold: true, margin: [0, 10, 0, 10]},
                chapterSubHeader: { fontSize: 13, bold: true, margin: [10, 10, 0, 10]},
                tableHeader: { fontSize: 12, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [10, 5, 10, 5], fontWeight: 'bold' },
                tableData: { fontSize: 11.5, margin: [0, 5, 0, 5] },
                tableHeader2: { fontSize: 9, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [5, 0, 5, 0], fontWeight: 'bold' },
                tableData2: { fontSize: 8.5, margin: [0, 5, 0, 5] },
                chapterSubSubHeader: { fontSize: 12, bold: true, margin: [15, 10, 10, 10] },
                chapterSubSubSubHeader: { fontSize: 12, bold: true, margin: [20, 10, 10, 10] },
                subChapterNote: { margin: [15, 15, 0, 10] },
                header: { alignment: 'center', bold: true},
                chapterContent: {fontSize: 11.5, margin: [0, 5, 0, 5] },
            },
            info: {
            	title : 'ICD_Document',
            },
            footer: function (currentPage, pageCount, pageSize) {
                const isLandscape = pageSize.width > pageSize.height;
                const pageWidth = pageSize.width; // Adjust dynamically based on page size
                const margin = 30;

                if (currentPage > 0) {
                    return {
                        stack: [
                            {
                                canvas: [{ type: 'line', x1: margin, y1: 0, x2: pageWidth - margin, y2: 0, lineWidth: 1 }]
                            },
                            {
                                columns: [
                                    {
                                        text: '<%if(documentNo!=null) {%><%=StringEscapeUtils.escapeHtml4(documentNo) %><%} %>',
                                        alignment: 'left',
                                        margin: [margin, 0, 0, 0],
                                        fontSize: 8
                                    },
                                    {
                                        text: 'Restricted',
                                        alignment: 'center',
                                        fontSize: 8,
                                        margin: [0, 0, 0, 0],
                                        bold: true
                                    },
                                    {
                                    	text: currentPage.toString() + ' of ' + pageCount,
                                        alignment: 'right',
                                        margin: [0, 0, margin, 0],
                                        fontSize: 8
                                    }
                                ]
                            }
                        ]
                    };
                }
                return '';
            },
            header: function (currentPage) {
                return {
                    stack: [
                        
                        {
                            columns: [
                                {
                                    // Left: Lab logo
                                    image: '<%= lablogo != null ? "data:image/png;base64," + lablogo : "" %>',
                                    width: 30,
                                    height: 30,
                                    alignment: 'left',
                                    margin: [35, 10, 0, 10]
                                },
                                {
                                    // Center: Text
                                    text: 'Restricted',
                                    alignment: 'center',
                                    fontSize: 10,
                                    bold: true,
                                    margin: [0, 10, 0, 0]
                                },
                                {
                                    // Right: DRDO logo
                                    image: '<%=drdologo != null ? "data:image/png;base64," + drdologo : "" %>',
                                    width: 30,
                                    height: 30,
                                    alignment: 'right',
                                    margin: [0, 10, 20, 10]
                                }
                            ]
                        },
                        
                    ]
                };
            },
			pageMargins: [50, 50, 30, 40],
            
            background: function(currentPage) {
                return [
                    {
                        image: generateRotatedTextImage(leftSideNote),
                        width: 100, // Adjust as necessary for your content
                        absolutePosition: { x: -10, y: 50 }, // Position as needed
                    }
                ];
            },
            watermark: { text: 'DRAFT', opacity: 0.1, bold: true, italics: false, fontSize: 80,  },
           
            defaultStyle: { fontSize: 12, color: 'black', }
        };
		
	//pdfMake.createPdf(docDefinition).open();
	pdfMake.createPdf(docDefinition).getBlob((blob) => {
        // Create a URL for the blob
        const url = URL.createObjectURL(blob);

        // Open the PDF in a new tab
        window.open(url, '_blank');

        // Hide the loading spinner
          document.getElementById('loadingOverlay').style.display='none';
        window.close();
    });
}

const setImagesWidth = (htmlString, width) => {
    const container = document.createElement('div');
    container.innerHTML = htmlString;
  
    const images = container.querySelectorAll('img');
    
    images.forEach(img => {
    	
      img.style.width = width+'px';
      img.style.textAlign = 'center';
    });
  
    const textElements = container.querySelectorAll('p, h1, h2, h3, h4, h5, h6, span, div, td, th, table, v, figure, hr, ul, li');
    textElements.forEach(element => {
      if (element.style) {
        element.style.fontFamily = '';
        element.style.margin = '';
        element.style.marginTop = '';
        element.style.marginRight = '';
        element.style.marginBottom = '';
        element.style.marginLeft = '';
        element.style.lineHeight = '';
        element.style.height = '';
        element.style.width = '';
        element.style.padding = '';
        element.style.paddingTop = '';
        element.style.paddingRight = '';
        element.style.paddingBottom = '';
        element.style.paddingLeft = '';
        element.style.fontSize = '';
        element.id = '';
        
        const elementColor = element.style.color;
        if (elementColor && elementColor.startsWith("var")) {
            // Replace `var(...)` with a fallback or remove it
            element.style.color = 'black'; // Default color
        }
        
        const elementbackgroundColor = element.style.backgroundColor;
        if (elementbackgroundColor && elementbackgroundColor.startsWith("var")) {
            // Replace `var(...)` with a fallback or remove it
            element.style.backgroundColor = 'transparent'; // Set a default or fallback background color
        }
      }
    });
  
    const tables = container.querySelectorAll('table');
    tables.forEach(table => {
      if (table.style) {
        table.style.borderCollapse = 'collapse';
        table.style.width = '100%';
      }
  
      const cells = table.querySelectorAll('th, td');
      cells.forEach(cell => {
        if (cell.style) {
          cell.style.border = '1px solid black';
  
          if (cell.tagName.toLowerCase() === 'th') {
            cell.style.textAlign = 'center';
          }
        }
      });
    });
  
    return container.innerHTML;
 	}; 	
 
 
 
 	function splitTextIntoLines(text, maxLength) {
	const lines = [];
  	let currentLine = '';

	for (const word of text.split(' ')) {
		if ((currentLine + word).length > maxLength) {
	    	lines.push(currentLine.trim());
	    	currentLine = word + ' ';
		} else {
		  currentLine += word + ' ';
		}
	}
  	lines.push(currentLine.trim());
  	return lines;
}

// Generate rotated text image with line-wrapped text
function generateRotatedTextImage(text) {
	const maxLength = 260;
	const lines = splitTextIntoLines(text, maxLength);
	
	const canvas = document.createElement('canvas');
	const ctx = canvas.getContext('2d');
	
	// Set canvas dimensions based on anticipated text size and rotation
	canvas.width = 200;
	canvas.height = 1560;
	
	// Set text styling
	ctx.font = '14px Roboto';
	ctx.fillStyle = 'rgba(128, 128, 128, 1)'; // Gray color for watermark
	
	// Position and rotate canvas
	ctx.translate(80, 1480); // Adjust position as needed
	ctx.rotate(-Math.PI / 2); // Rotate 270 degrees
	
	// Draw each line with a fixed vertical gap
	const lineHeight = 20; // Adjust line height if needed
	lines.forEach((line, index) => {
	  ctx.fillText(line, 0, index * lineHeight); // Position each line below the previous
	});
	
	return canvas.toDataURL();
}

<%if(isPdf!=null && isPdf.equalsIgnoreCase("Y") || (pdfForSystem!=null && pdfForSystem.equalsIgnoreCase("Y"))) { %>
$( document ).ready(function(){

	document.body.style.display="block"
	document.body.innerHTML = '<div id="loadingOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999; justify-content: center; align-items: center; flex-direction: column; color: white; font-size: 20px; font-weight: bold;">'+
		    '<div class="spinner" style="border: 4px solid rgba(255, 255, 255, 0.3); border-top: 4px solid white; border-radius: 50%; width: 40px; height: 40px; animation: spin 1s linear infinite; margin-bottom: 10px;"></div>'+
		   ' Please wait while we are generating the PDF...</div>'
		 
	DownloadDocPDF();
	/* window.close(); */
	
	// Hide the current JSP page immediately after opening the PDF
	//document.body.style.display = "none";
	
	/* setTimeout(function () {
        window.close();
    }, 8000) */; // Adjust the delay time as needed
});
<%} %>
</script> 

</body>
</html>
