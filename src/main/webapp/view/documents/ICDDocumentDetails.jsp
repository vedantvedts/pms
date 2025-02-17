<%@page import="com.vts.pfms.documents.model.IGIInterfaceTypes"%>
<%@page import="com.vts.pfms.documents.model.IGIInterfaceContent"%>
<%@page import="java.util.function.Function"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.vts.pfms.documents.model.PfmsICDDocument"%>
<%@page import="com.vts.pfms.documents.model.PfmsApplicableDocs"%>
<%@page import="com.vts.pfms.documents.model.IGIInterface"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.model.IGIDocumentShortCodes"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
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
</style>    

</head>
<%	String isPdf = (String)request.getAttribute("isPdf"); %>
<body <%if(isPdf!=null && isPdf.equalsIgnoreCase("Y")) {%> style="display:none;" <%} %>>

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
		
		List<PfmsApplicableDocs> applicableDocsList = (List<PfmsApplicableDocs>)request.getAttribute("applicableDocsList");
		List<Object[]> icdApplicableDocsList = (List<Object[]>)request.getAttribute("icdApplicableDocsList");
		List<Long> icdApplicableDocIds = icdApplicableDocsList.stream().map(e -> Long.parseLong(e[1].toString())).collect(Collectors.toList());
		applicableDocsList = applicableDocsList.stream().filter(e -> !icdApplicableDocIds.contains(e.getApplicableDocId())).collect(Collectors.toList());
		List<String> icdApplicableDocNames = applicableDocsList.stream().map(e -> e.getDocumentName().toLowerCase()).collect(Collectors.toList());

		PfmsICDDocument icdDocument = (PfmsICDDocument)request.getAttribute("icdDocument");
		
		List<Object[]> productTreeList = (List<Object[]>)request.getAttribute("productTreeList"); 
		List<Object[]> icdConnectionsList = (List<Object[]>)request.getAttribute("icdConnectionsList"); 
		
		String isSubSystem = icdDocument!=null && icdDocument.getProductTreeMainId()!=0? "Y": "N";
		
		List<Object[]> productTreeAllList = (List<Object[]>)request.getAttribute("productTreeAllList"); 
		List<Object[]> productTreeSubList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("2")).collect(Collectors.toList());
		
		List<String> subsystems = productTreeList.stream().map(obj -> obj[7]+"").distinct().collect(Collectors.toList());
		List<String> supersubsystems = productTreeSubList.stream().map(obj -> obj[7]+"").distinct().collect(Collectors.toList());
		
		Map<String, String> connectionMap = new LinkedHashMap<>();
		Map<String, String> superSubConnectionMap = new HashMap<>();
		
		HashSet<String> interfaceCodeList = new HashSet<String>();
		
		Map<String, List<String>> codeValuesMap = new LinkedHashMap<>();
		
		Map<String, List<String>> interfaceTypeValuesMap = new LinkedHashMap<>();
		
		Map<String, Set<String>> fwdTraceValuesMap = new LinkedHashMap<>();
		Map<String, Set<String>> bwdTraceValuesMap = new LinkedHashMap<>();
		
		Map<String, Set<String>> fwdTraceValuesMapSuperSub = new LinkedHashMap<>();
		Map<String, Set<String>> bwdTraceValuesMapSuperSub = new LinkedHashMap<>();

		for (Object[] connection : icdConnectionsList) {
			
			 String interfaceCode = connection[8]!=null?connection[8].toString():"NA";
			 
		    String key = connection[4] + "_" + connection[5];
		    //int count = connectionMap.containsKey(key) ? connectionMap.get(key).split("<br>").length + 1 : 1;

		    //String seqNumber = (count >= 100) ? "_" + count : (count >= 10) ? "_0" + count : "_00" + count;
		    
		    //String value = count+". "+ connection[4] + "_" + connection[5] + "_" + interfaceCode;
		    
		    String value = connection[32].toString();
		    
		    connectionMap.merge(key, value, (oldValue, newValue) -> oldValue + " <br> " + newValue);
		    
		 	// Unique Interface Codes
		    interfaceCodeList.add(interfaceCode);
		    
		 	// Collecting values for each code
		    codeValuesMap.computeIfAbsent(interfaceCode, k -> new ArrayList<>()).add(value);
		 	
		 	// Grouping the connections by Interface Type
		    interfaceTypeValuesMap.computeIfAbsent(connection[10].toString(), k -> new ArrayList<>()).add(value);
		    
		    
		    // Super Sub System Map
		    String keysub = connection[16] + "_" + connection[17];

		    int countsub = superSubConnectionMap.containsKey(keysub) ? superSubConnectionMap.get(keysub).split("<br>").length + 1 : 1;

		    //String seqNumber = (countsub >= 100) ? "_" + countsub : (countsub >= 10) ? "_0" + countsub : "_00" + countsub;

		    String valuesub = connection[32].toString();
		    superSubConnectionMap.merge(keysub, valuesub, (oldValue, newValue) -> oldValue + "<br>" + newValue);
		
		    
		    /* Sub-System  */
		    // Forward Traceability Values
		    fwdTraceValuesMap.computeIfAbsent(connection[4].toString(), k -> new LinkedHashSet<>()).add(interfaceCode);
		    fwdTraceValuesMap.computeIfAbsent(connection[5].toString(), k -> new LinkedHashSet<>()).add(interfaceCode);
		    
		 	// Backward Traceability Values
		    bwdTraceValuesMap.computeIfAbsent(interfaceCode, k -> new LinkedHashSet<>()).add(connection[4].toString());
		    bwdTraceValuesMap.computeIfAbsent(interfaceCode, k -> new LinkedHashSet<>()).add(connection[5].toString());
		    
		    /* Super Sub-System */
		    if(isSubSystem.equalsIgnoreCase("Y") && connection[16]!=null && connection[17]!=null) {
		    	// Forward Traceability Values
		    	fwdTraceValuesMapSuperSub.computeIfAbsent(connection[16].toString(), k -> new LinkedHashSet<>()).add(interfaceCode);
			    fwdTraceValuesMapSuperSub.computeIfAbsent(connection[17].toString(), k -> new LinkedHashSet<>()).add(interfaceCode);
			    
			 	// Backward Traceability Values
			    bwdTraceValuesMapSuperSub.computeIfAbsent(interfaceCode, k -> new LinkedHashSet<>()).add(connection[16].toString());
			    bwdTraceValuesMapSuperSub.computeIfAbsent(interfaceCode, k -> new LinkedHashSet<>()).add(connection[17].toString());
		    }
		    
		}
		
		
		List<IGIInterface> igiInterfaceList = (List<IGIInterface>)request.getAttribute("igiInterfaceList");
		
		Map<String, IGIInterface> interfaceListToMap = igiInterfaceList.stream()
			    	.collect(Collectors.toMap(IGIInterface::getInterfaceCode, Function.identity(), (existing, replacement) -> existing ));

		//List<IGIInterface> physicalInterfaceList = igiInterfaceList.stream().filter(e -> e.getInterfaceType()!=null && e.getInterfaceType().equalsIgnoreCase("Physical Interface")).collect(Collectors.toList());
		//List<IGIInterface> electricalInterfaceList = igiInterfaceList.stream().filter(e -> e.getInterfaceType()!=null && e.getInterfaceType().equalsIgnoreCase("Electrical Interface")).collect(Collectors.toList());
		//List<IGIInterface> opticalInterfaceList = igiInterfaceList.stream().filter(e -> e.getInterfaceType()!=null && e.getInterfaceType().equalsIgnoreCase("Optical Interface")).collect(Collectors.toList());
		//List<IGIInterface> logicalInterfaceList = igiInterfaceList.stream().filter(e -> e.getInterfaceType()!=null && e.getInterfaceType().equalsIgnoreCase("Logical Interface")).collect(Collectors.toList());
				
		Object[] projectDetails = (Object[])request.getAttribute("projectDetails");
		Object[] labDetails = (Object[])request.getAttribute("labDetails");
		Object[] docTempAtrr = (Object[])request.getAttribute("docTempAttributes");
		String lablogo = (String)request.getAttribute("lablogo");
		String drdologo = (String)request.getAttribute("drdologo");
		String version =(String)request.getAttribute("version");
		String projectType =(String)request.getAttribute("projectType");
		String projectShortName = (projectDetails!=null && projectDetails[2]!=null)?projectDetails[2]+"":"";
		
		LocalDate now = LocalDate.now();
		FormatConverter fc = new FormatConverter();
		
		Gson gson = new GsonBuilder().create();
		String jsonicdApplicableDocNames = gson.toJson(icdApplicableDocNames);
		
		String documentNo = "ICD-" + (documentSummary!=null && documentSummary[11]!=null?documentSummary[11].toString().replaceAll("-", ""):"-") 
							+ "-" + ((String)session.getAttribute("labcode")) + "-" +((projectDetails!=null && projectDetails[1]!=null)?projectDetails[1]:"") + "-V"+version;
	
		Object[] subSystemDetails = productTreeList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[0].toString())).findFirst().orElse(null);
		
		List<IGIInterfaceTypes> interfaceTypesList = (List<IGIInterfaceTypes>)request.getAttribute("interfaceTypesList");
		List<IGIInterfaceContent> interfaceContentList = (List<IGIInterfaceContent>)request.getAttribute("interfaceContentList");
	%>

    <% String ses = (String) request.getParameter("result"); 
       String ses1 = (String) request.getParameter("resultfail");
       if (ses1 != null) { %>
        <div align="center">
            <div class="alert alert-danger" role="alert">
                <%= ses1 %>
            </div>
        </div>
    <% } if (ses != null) { %>
        <div align="center">
            <div class="alert alert-success" role="alert">
                <%= ses %>
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
	                        ICD Document Details - <%=documentNo %>
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
				
											<div class="card module" onclick="DownloadDocPDF()">
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
											
											<div class="card module" data-toggle="modal" data-target="#introductionModal">
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" > <span class="topic-name">Chapter 1 : Introduction</span></div>
												</div>
											</div>
											
											<div class="card module" onclick="showApplicableDocuments()" >
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" > <span class="topic-name">Chapter 2 : Applicable Docs</span></div>
												</div>
											</div>
											
											<div class="card module" onclick="showChapter3()">
												<div class="card-body">
													<div><img alt="" src="view/images/requirements.png" > <span class="topic-name">Chapter 3 : Connections</span></div>
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
										<td class="text-primary"><%=++docsumslno %>.&nbsp; Document Number: <span class="text-dark"><%=documentNo %></span> </td>
										<td class="text-primary"><%=++docsumslno %>.&nbsp; Month Year: <span style="color:black;"><%=now.getMonth().toString().substring(0,3) %>&nbsp;&nbsp;<%=now.getYear() %></span></td>
									</tr>
									<!-- <tr>
										<td class="text-primary">6.&nbsp; Number of Pages:</td>
										<td class="text-primary">7.&nbsp; Related Document:</td>
									</tr> -->
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Additional Information:
											<%if(documentSummary!=null && documentSummary[1]!=null) {%><span class="text-dark"><%=documentSummary[1]%></span> <%} %>
										</td>
									</tr>
								    <!-- <tr>
										<td  class="text-primary" colspan="2">9.&nbsp; Project Number and Project Name: <span class="text-dark"> </span></td>
									</tr> -->
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Abstract:
											<%if(documentSummary!=null && documentSummary[2]!=null) {%> <span class="text-dark"><%=documentSummary[2]%></span><%} %>
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Keywords:
											<%if(documentSummary!=null && documentSummary[3]!=null) {%> <span class="text-dark"><%=documentSummary[3]%></span><%} %>
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Organization and address:
											<span class="text-dark">		
												<%if (labDetails[1] != null) {%>
													<%=labDetails[1].toString() + "(" + labDetails[0].toString() + ")"%>
												<%} else {%>
													-
												<%}%>
												
												Government of India, Ministry of Defence,Defence
												Research & Development Organization
												<%if (labDetails[2] != null && labDetails[3] != null && labDetails[5] != null) {%>
													<%=labDetails[2] + " , " + labDetails[3].toString() + ", PIN-" + labDetails[5].toString()+"."%>
												<%}else{ %>
													-
												<%} %>
											</span>
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Distribution:
											<%if(documentSummary!=null && documentSummary[4]!=null) {%> <span class="text-dark"><%=documentSummary[4]%></span><%} %>
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Revision:</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Prepared by:
											<%if(documentSummary!=null && documentSummary[10]!=null) {%> <span class="text-dark"><%=documentSummary[10]%></span><%}else {%><span class="text-dark">-</span>  <%} %> <span class="text-dark"></span> 
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Reviewed by: 
											<%if(documentSummary!=null && documentSummary[9]!=null) {%> <span class="text-dark"><%=documentSummary[9]%></span><%}else {%><span class="text-dark">-</span>  <%} %> 
										</td>
									</tr>
									<tr>
										<td  class="text-primary" colspan="2"><%=++docsumslno %>.&nbsp; Approved by: 
											<%if(documentSummary!=null && documentSummary[8]!=null) {%> <span class="text-dark"><%=documentSummary[8]%></span><%}else {%><span class="text-dark">-</span>  <%} %> 
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
	
		<button type="submit" id="applicableDocumentsFormBtn" formaction="IGIApplicableDocumentsDetails.htm" formmethod="post" formnovalidate="formnovalidate" style="display:none;"></button>
		
		<button type="submit" id="connectionsFormBtn" formaction="ICDConnectionsDetails.htm" formmethod="post" formnovalidate="formnovalidate" style="display:none;"></button>
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
												<td ><%=obj[1].toString() %></td>
												<td ><%=obj[2].toString() %></td>
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
							        	<option value="<%=obj[0].toString()%>"> <%=obj[1].toString() %>,<%=(obj[2].toString()) %></option>
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
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(documentSummary!=null && documentSummary[1]!=null){%><%=documentSummary[1]%><%}else{%><%}%></textarea>
				   			</div>
   				 		</div>
   				 
   				 		<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Abstract <span class="mandatory">*</span></label>
				   			</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="abstract" class="form-control" id="" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(documentSummary!=null && documentSummary[2]!=null){%><%=documentSummary[2]%><%}else{%><%}%></textarea>
				   			</div>
			   			</div>
			   	
			   			<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Keywords <span class="mandatory">*</span></label>
				   			</div>
				   			<div class="col-md-8">
				   				<textarea required="required" name="keywords" class="form-control" id="" maxlength="4000"
								rows="3" cols="53" placeholder="Maximum 4000 Chararcters" required><%if(documentSummary!=null && documentSummary[3]!=null){%><%=documentSummary[3]%><%}else{%><%}%></textarea>
				   			</div>
   						</div>
   			
   		    			<div class="row mt-2">
				   			<div class="col-md-4">
				   				<label class="" style="font-size: 1rem;font-weight: bold;color:#07689f">Distribution <span class="mandatory">*</span></label>
				   			</div>
				   			<div class="col-md-8">
				   				<input required="required" name="distribution" class="form-control" id="" maxlength="255"
								 placeholder="Maximum 255 Chararcters" required value="<%if(documentSummary!=null && documentSummary[4]!=null){%><%=documentSummary[4]%><%}else{%><%}%>">
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
	        								<%=obj[1].toString() %>,<%=(obj[2].toString()) %>
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
	        								<%=obj[1].toString() %>,<%=(obj[2].toString()) %>
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
		       								<%=obj[1].toString() %>,<%=(obj[2].toString()) %>
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

	<!-- -------------------------------------------- Introduction Modal ------------------------------------------------------------- -->
	<div class="modal fade" id="introductionModal" tabindex="-1" role="dialog" aria-labelledby="introductionModal" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content" style="width:135%;margin-left:-20%;">
				<div class="modal-header" style="background: #055C9D;color: white;">
		        	<h5 class="modal-title ">Introduction</h5>
			        <button type="button" class="close" style="text-shadow: none !important" data-dismiss="modal" aria-label="Close">
			          <span class="text-light" aria-hidden="true">&times;</span>
			        </button>
		      	</div>
     			<div class="modal-body">
     				<div class="container-fluid mt-3">
     					<div class="row">
							<div class="col-md-12 " align="left">
								<form action="ICDIntroductionSubmit.htm" method="POST" id="myform">
									<div id="introductionEditor" class="center"></div>
									<textarea id="introduction" name="introduction" style="display: none;"></textarea>
									<div class="mt-2" align="center" id="detailsSubmit">
										<span id="EditorDetails"></span>
										<input type="hidden" name="icdDocId" value="<%=icdDocId %>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<span id="Editorspan">
											<span id="btn1" style="display: block;"><button type="submit"class="btn btn-sm btn-warning edit mt-2" onclick="return confirm('Are you sure to Update?')">UPDATE</button></span>
										</span>
									</div>
								</form>
							</div>
						</div>
     				</div>
     			</div>
     		</div>
		</div>
	</div>				
	<!-- -------------------------------------------- Introduction Modal End ------------------------------------------------------------- -->		
	
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
	
	function showShortCodes(shortCodeType) {
		$('#shortCodeType').val(shortCodeType);
		$('#shortCodesFormBtn').click();
	}
	
	function showApplicableDocuments() {
		$('#applicableDocumentsFormBtn').click();
	}
	
	function showChapter3(){
    	$('#connectionsFormBtn').click();
	}
        
//Define a common Summernote configuration
var summernoteConfig = {
    width: 900,
    toolbar: [
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
        ['insert', ['picture', 'table']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['height', ['height']]
    ],
    fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],
    fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana','Segoe UI','Segoe UI Emoji','Segoe UI Symbol'],
    buttons: {
        superscript: function() {
            return $.summernote.ui.button({
                contents: '<sup>S</sup>',
                tooltip: 'Superscript',
                click: function() {
                    document.execCommand('superscript');
                }
            }).render();
        },
        subscript: function() {
            return $.summernote.ui.button({
                contents: '<sub>S</sub>',
                tooltip: 'Subscript',
                click: function() {
                    document.execCommand('subscript');
                }
            }).render();
        }
    },
    height: 300
};

// This is for RSQR
/* CKEDITOR.replace('Editor', editor_config); */
$('#introductionEditor').summernote(summernoteConfig);

//Update the values of Editors
var html1 = '<%=icdDocument!=null && icdDocument.getIntroduction()!=null?icdDocument.getIntroduction().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):""%>';
$('#introductionEditor').summernote('code', html1);

//Set the values to the form when submitting.
$('#myform').submit(function() {

	 var data1 = $('#introductionEditor').summernote('code');
	 $('textarea[name=introduction]').val(data1);
	 
});

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
                    text: htmlToPdfmake('<h4 class="heading-color ">Interface Control Information (ICD) <br><br> FOR  <br><br>PROJECT <%=projectShortName %> </h4>'),
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
                    text: htmlToPdfmake('<h5><% if (labDetails != null && labDetails[1] != null) { %> <%= labDetails[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + labDetails[0].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + ")" %> <% } else { %> '-' <% } %></h5>'),
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
                    text: htmlToPdfmake('<h6><%if(labDetails!=null && labDetails[2]!=null && labDetails[3]!=null && labDetails[5]!=null){ %><%=labDetails[2]+" , "+labDetails[3]+", PIN-"+labDetails[5] %><%}else{ %>-<%} %></h6>'),
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
	                                { text: '<%= obj[1] %>', style: 'tableData' },
	                                { text: '<%= obj[2] %>', style: 'tableData' },
	                                { text: '<%= obj[3] %>', style: 'tableData',alignment: 'center' }
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
                                { text: '<%=documentNo %>', style: 'tableData' },
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
                                { text: htmlToPdfmake('<% if(documentSummary!=null){%><%=documentSummary[1]!=null?documentSummary[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-" %><%} %>'), style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Project Name', style: 'tableData' },
                                { text: '<%=projectShortName%>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Abstract', style: 'tableData' },
                                { text: htmlToPdfmake('<% if(documentSummary!=null){%><%=documentSummary[2]!=null?documentSummary[2].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-" %><%} %>'), style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Keywords', style: 'tableData' },
                                { text: htmlToPdfmake('<% if(documentSummary!=null){%><%=documentSummary[3]!=null?documentSummary[3].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-" %><%} %>'), style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Organization and address', style: 'tableData' },
                                { text: '<% if (labDetails!=null && labDetails[1] != null) {%> <%=labDetails[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + labDetails[0].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "")  + ")"%> <%} else {%> - <%}%>'
										+'\n Government of India, Ministry of Defence,Defence Research & Development Organization'
								+'<% if (labDetails!=null && labDetails[2] != null && labDetails[3] != null && labDetails[5] != null) { %>'
									+'<%=labDetails[2] + " , " + labDetails[3].toString() + ", PIN-" + labDetails[5].toString()+"."%>'
								+'<%}else{ %> - <%} %>' , style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Distribution', style: 'tableData' },
                                { text: htmlToPdfmake('<% if(documentSummary!=null){%><%=documentSummary[4]!=null?documentSummary[4].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):"-" %><%} %>'), style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Revision', style: 'tableData' },
                                { text: '<%=version!=null ?version:"-" %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Prepared by', style: 'tableData' },
                                { text: '<% if(documentSummary!=null){%><%=documentSummary[10]!=null?documentSummary[10]:"-" %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Reviewed by', style: 'tableData' },
                                { text: '<% if(documentSummary!=null){%><%=documentSummary[9]!=null?documentSummary[9]:"-" %><%} %>', style: 'tableData' },
                            ],
                            
                            [
                                { text: '<%=++docsn%>', style: 'tableData',alignment: 'center' },
                                { text: 'Approved by', style: 'tableData' },
                                { text: '<% if(documentSummary!=null){%><%=documentSummary[8]!=null?documentSummary[8]:"-" %><%} %>', style: 'tableData' },
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
		                                { text: '<%=obj[1] %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%=obj[2] %>', style: 'tableData' },
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
		                                { text: '<%=obj[1] %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%=obj[2] %>', style: 'tableData' },
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

                <%if(icdDocument!=null) {%>
                
	                {
	                	stack: [htmlToPdfmake(setImagesWidth('<%if(icdDocument.getIntroduction()!=null) {%><%=icdDocument.getIntroduction().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>'
	                		  +'<%}else {%> No Details Added! <%} %>', 500))],
	                    margin: [10, 0, 0, 0],
	                },
	                			
	            <%}%>
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
                        widths: ['20%', '80%'],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader' },
                                { text: 'Document Name', style: 'tableHeader' },
                            ],
                            // Populate table rows
                           <% if(icdApplicableDocsList!=null && icdApplicableDocsList.size()>0){
								int slno=0;
								for(Object[] obj : icdApplicableDocsList){
							%>
		                            [
		                                { text: '<%=++slno %>', style: 'tableData',alignment: 'center' },
		                                { text: '<%=obj[2] %>', style: 'tableData', },
		                            ],
		                        <% } %>
                            <% } else{%>
                            	[{ text: 'No Data Available', style: 'tableData',alignment: 'center', colSpan: 2 },]
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
                
                /* ************************************** Connections *********************************** */
                {
                    text: (++mainContentCount)+'. Connections',
                    style: 'chapterHeader',
                    tocItem: true,
                    id: 'chapter'+(++chapterCount),
                    pageOrientation: 'landscape',
                    pageBreak: 'before',
                  	/* pageSize: { width: 1190.55, height: 841.89 }, */
                    pageSize: { width: 1683.78, height: 1190.55 },
                },
				
                <%
	        	if(isSubSystem.equalsIgnoreCase("N")) {
	        		
	        	%>
                {
                    table: {
                        headerRows: 1,
                        widths: [
                        	 
                            <%-- <% for (int i = 0; i <subsystems.size()+2; i++) { %>
                                'auto',
                            <% } %> --%>
                            '4%', '8%', 
                            <% for (int i = 0; i <subsystems.size(); i++) { %>
                            	'<%= (double)((double)88/(double)(subsystems.size())) %>%',
                        	<% } %>
                            
                        ],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader2' },
                                { text: 'Sub-System', style: 'tableHeader2' },
                                <% for (String subsystem : subsystems) { %>
                                    { text: '<%= subsystem != null ? subsystem : "" %>', style: 'tableHeader2' },
                                <% } %>
                            ],

                            // Populate table rows
                            <% 
   
                            int slnoS = 0;
                            for (String rowSubsystem : subsystems) { %>
                                [
                                    { text: '<%= ++slnoS%>', style: 'tableData2', alignment: 'center' },
                                    { text: '<%= rowSubsystem != null ? rowSubsystem : "" %>', style: 'tableData2', alignment: 'center' },
                                    <% for (String colSubsystem : subsystems) { %>
                                        { text: 
                                            <%-- <% if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { %>
                                                'NA' --%>
                                            <% //} else { 
                                                String key = rowSubsystem + "_" + colSubsystem;
                                                String connections = connectionMap.getOrDefault(key, "-");
                                            %>
                                                htmlToPdfmake('<%= connections != null ? connections : "-" %>')
                                            <% //} %>, 
                                            style: 'tableData2',  },
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

                <% }else { %>
	        	
	        	/* {
                	text: '',
                    style: 'chapterHeader',
                    tocItem: false,
                    id: 'chapter'+(++chapterCount),
                    pageOrientation: 'landscape',
                    pageBreak: 'before',
                    pageSize: { width: 841.89, height: 595.28 },
                }, */
                
	        	{
                    table: {
                        headerRows: 1,
                        widths: [
                        	 
                        	'4%', '8%', 
                            <% for (int i = 0; i <supersubsystems.size(); i++) { %>
                            	'<%= (double)((double)88/(double)(supersubsystems.size())) %>%',
                        	<% } %>
                        ],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader2' },
                                { text: 'Sub-System', style: 'tableHeader2' },
                                <% for (String supersubsystem : supersubsystems) { %>
                                    { text: '<%= supersubsystem != null ? supersubsystem : "" %>', style: 'tableHeader2' },
                                <% } %>
                            ],

                            // Populate table rows
                            <% 
                            int slnoSS = 0;
                            for (String rowSubsystem : supersubsystems) { %>
                                [
                                    { text: '<%= ++slnoSS%>', style: 'tableData2', alignment: 'center' },
                                    { text: '<%= rowSubsystem != null ? rowSubsystem : "" %>', style: 'tableData2', alignment: 'center' },
                                    <% for (String colSubsystem : supersubsystems) { %>
                                        { text: 
                                            <%-- <% if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { %>
                                                'NA' --%>
                                            <% //} else { 
                                                String key = rowSubsystem + "_" + colSubsystem;
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
                
	        	<%} %>
                
                {
                	text: '',
                    style: 'chapterHeader',
                    tocItem: false,
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
                        widths: ['6%', '25%', '20%', '24%%', '25%' ],
                        body: [
                            // Table header
                            [
                                { text: 'SN', style: 'tableHeader2' },
                                { text: 'Connection ID', style: 'tableHeader2' },
                                /* { text: 'Sub-System 1', style: 'tableHeader' },
                                { text: 'Sub-System 2', style: 'tableHeader' },
                                { text: 'Code', style: 'tableHeader' },
                                { text: 'Interface Type', style: 'tableHeader' }, */
                                { text: 'Periodicity', style: 'tableHeader2' },
                                { text: 'Transmission Speed', style: 'tableHeader2' },
                                { text: 'Data Format', style: 'tableHeader2' },
                            ],
                            // Populate table rows
                            
                            <%if(icdConnectionsList!=null && icdConnectionsList.size()>0) {
                            	
                            	int slno = 0;
                    			
                    			for(Object[] obj : icdConnectionsList) { %>
	                    		[
	                    			{ text: '<%=++slno %>', style: 'tableData2',alignment: 'center' },
	                                <%-- { text: '<%=obj[4]+"_"+obj[5]+"_"+obj[8]+((count>=100)?"_"+count:((count>=10)?"_0"+count:"_00"+count)) %>', style: 'tableData',alignment: 'center' }, --%> 
	                                { text: '<%=obj[32] %>', style: 'tableData2',alignment: 'center' },
	                                <%-- { text: '<%=obj[4] %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%=obj[5] %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%=obj[8] %>', style: 'tableData',alignment: 'center' },
	                                { text: '<%=obj[10] %>', style: 'tableData', }, --%>
	                                { text: '<%=obj[30]!=null?obj[30]:"-" %>', style: 'tableData2', },
	                                { text: '<%=obj[13]!=null?obj[13]:"-" %>', style: 'tableData2', },
	                                { text: '<%=obj[11]!=null?obj[11]:"-" %>', style: 'tableData2', },
	                            ],
                    		<%} }%>
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
                
                /* ************************************** Connections End *********************************** */
                
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
							%>
							        [
							            { text: '<%= ++slno %>', style: 'tableData', alignment: 'center' },
							            { text: '<%= type %>', style: 'tableData',  },
							            { text: '<%= values.size() %>', style: 'tableData', alignment: 'center' },
							            { text: '<%= values %>', style: 'tableData', },
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

                %>
	                {
	                	text: mainContentCount+'.<%=++slno%>. <%=iface.getInterfaceName() %>',	
	                	style: 'chapterSubHeader',
	                    tocItem: true,
	                    id: 'chapter'+chapterCount+'.'+mainContentCount+'.<%=slno%>',
	                    tocMargin: [10, 0, 0, 0],
	                },
	                
	                {
	                	text: 'Connections: <%=connectionCodes%>',
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
	                                { text: '<%=iface.getInterfaceCode() %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Name', style: 'tableData', bold: true },
	                                { text: '<%=iface.getInterfaceName() %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Description', style: 'tableData', bold: true},
	                                <%if(iface.getInterfaceDescription()!=null && !iface.getInterfaceDescription().isEmpty()) {%>
	                                	{ stack: [htmlToPdfmake(setImagesWidth('<%=iface.getInterfaceDescription().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %>', 600))],},
	                                <%}else {%>
	                                	{ text: 'No Details Added!', style: 'tableData'},
	                                <%} %>
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Type', style: 'tableData', bold: true },
	                                { text: '<%=igiinterfaceTypes!=null?igiinterfaceTypes.getInterfaceType():"-" %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Content', style: 'tableData', bold: true },
	                                { text: '<%=igiInterfaceContent!=null?igiInterfaceContent.getInterfaceContent():"-" %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Type of Data', style: 'tableData', bold: true },
	                                { text: '<%=iface.getParameterData() %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'End-1 Connector', style: 'tableData', bold: true },
	                                { text: 'Part No : <%=(iface.getPartNoEOne()!=null && !iface.getPartNoEOne().isEmpty())? iface.getPartNoEOne():"-" %>'
	                                		+'\n' + 'Connector Make : <%=(iface.getConnectorMakeEOne()!=null && !iface.getConnectorMakeEOne().isEmpty())? iface.getConnectorMakeEOne():"-" %>'
	                                		+'\n' + 'Standard : <%=(iface.getStandardEOne()!=null && !iface.getStandardEOne().isEmpty())? iface.getStandardEOne():"-" %>'
	                                		+'\n' + 'Protection : <%=(iface.getProtectionEOne()!=null && !iface.getProtectionEOne().isEmpty())? iface.getProtectionEOne():"-" %>'
	                                		+'\n' + 'Ref Info : <%=(iface.getRefInfoEOne()!=null && !iface.getRefInfoEOne().isEmpty())? iface.getRefInfoEOne():"-" %>'
	                                		+'\n' + 'Remarks : <%=(iface.getRemarksEOne()!=null && !iface.getRemarksEOne().isEmpty())? iface.getRemarksEOne():"-" %>'
	                                		, style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'End-2 Connector', style: 'tableData', bold: true },
	                                { text: 'Part No : <%=(iface.getPartNoETwo()!=null && !iface.getPartNoETwo().isEmpty())? iface.getPartNoETwo():"-" %>'
	                                		+'\n' + 'Connector Make : <%=(iface.getConnectorMakeETwo()!=null && !iface.getConnectorMakeETwo().isEmpty())? iface.getConnectorMakeETwo():"-" %>'
	                                		+'\n' + 'Standard : <%=(iface.getStandardETwo()!=null && !iface.getStandardETwo().isEmpty())? iface.getStandardETwo():"-" %>'
	                                		+'\n' + 'Protection : <%=(iface.getProtectionETwo()!=null && !iface.getProtectionETwo().isEmpty())? iface.getProtectionETwo():"-" %>'
	                                		+'\n' + 'Ref Info : <%=(iface.getRefInfoETwo()!=null && !iface.getRefInfoETwo().isEmpty())? iface.getRefInfoETwo():"-" %>'
	                                		+'\n' + 'Remarks : <%=(iface.getRemarksETwo()!=null && !iface.getRemarksETwo().isEmpty())? iface.getRemarksETwo():"-" %>'
	                                		, style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Interface Speed', style: 'tableData', bold: true },
	                                { text: '<%=iface.getInterfaceSpeed() %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Cable Information', style: 'tableData', bold: true },
	                                { text: '<%=(iface.getCableInfo()!=null && !iface.getCableInfo().isEmpty())? iface.getCableInfo():"-" %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Cable Constraint', style: 'tableData', bold: true },
	                                { text: '<%=(iface.getCableConstraint()!=null && !iface.getCableConstraint().isEmpty())? iface.getCableConstraint():"-" %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Cable Diameter', style: 'tableData', bold: true },
	                                { text: '<%=(iface.getCableDiameter()!=null && !iface.getCableDiameter().isEmpty())? iface.getCableDiameter():"-" %>', style: 'tableData' },
	                            ],
	                            [
	                            	{ text: '<%=++sn%>', style: 'tableData', bold: true, alignment: 'center',},
	                                { text: 'Cable Details', style: 'tableData', bold: true },
	                                { text: '<%=(iface.getCableDetails()!=null && !iface.getCableDetails().isEmpty())? iface.getCableDetails():"-" %>', style: 'tableData' },
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
                
                /* ************************************* Sub-System End ******************************************  */
                
                /* ************************************* Super Sub-System ******************************************  */
                <% if(isSubSystem.equalsIgnoreCase("Y")) { %>
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
                <%} %>
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
                
                /* ************************************* Sub-System End ******************************************  */
                
                /* ************************************* Super Sub-System ******************************************  */
                
                <% if(isSubSystem.equalsIgnoreCase("Y")) { %>
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
	            <%} %>    
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
            footer: function (currentPage, pageCount, pageSize) {
                const isLandscape = pageSize.width > pageSize.height;
                const pageWidth = pageSize.width; // Adjust dynamically based on page size
                const margin = 30;

                if (currentPage > 2) {
                    return {
                        stack: [
                            {
                                canvas: [{ type: 'line', x1: margin, y1: 0, x2: pageWidth - margin, y2: 0, lineWidth: 1 }]
                            },
                            {
                                columns: [
                                    {
                                        text: '<%if(documentNo!=null) {%><%=documentNo %><%} %>',
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

<%if(isPdf!=null && isPdf.equalsIgnoreCase("Y")) {%>
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
