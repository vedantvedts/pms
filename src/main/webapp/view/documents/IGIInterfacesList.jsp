
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.documents.model.IGIConnector"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.vts.pfms.documents.model.IGIInterfaceContent"%>
<%@page import="com.vts.pfms.documents.model.IGIInterfaceTypes"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.model.IGIInterface"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />

<style type="text/css">
label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

.tab-pane p{
	text-align: justify;
	
}

.tabpanes {
	min-height: 637px;
    max-height: 637px;
    overflow: auto;
    scrollbar-width: thin;
  	scrollbar-color: #216583 #f8f9fa;
}

.card-body {
    padding-bottom: 50px; /* Add some padding to make sure content doesn't overlap with the buttons */
}

/* Chrome, Edge, and Safari */
.tabpanes::-webkit-scrollbar {
  width: 12px;
}

.tabpanes::-webkit-scrollbar-track {
  background: #f8f9fa;
  border-radius: 5px;
}

.tabpanes::-webkit-scrollbar-thum {
  background-color: #216583;
  border-radius: 5px;
  border: 2px solid #f8f9fa;
}


.card-body{
	padding: 0rem !important;
}

.navigation_btn{
	margin: 1%;
}

 .b{
	background-color: #ebecf1;	
}
.a{
	background-color: #d6e0f0;
}

.nav-links{
	text-align: left;
}

.text-center{
	text-align: left !imporatant;
}

.previous{
	color: white !important;
}

.previous, .next{
	font-family: 'Montserrat', sans-serif;
    font-weight: 800 !important;
}

.next {
  padding: 4px 16px;
  font-weight: 800;
  background-color: #394989;
  border-color: #394989;
}

.center {
	text-align: center !important;
}

.right {
	text-align: right !important;
}

.left {
	text-align: left !important;
}

.fw-bold {
	font-weight: bold !important;
}
.select2-selection__rendered{
	text-align: left !important;
}

.agendaItemBtn > p {
	margin-bottom : 0;
}

.panel-bottom {
    bottom: 10px;
    right: 10px;
    text-align: right;
}

.customSidebar {
	min-height: 920px;
    max-height: 920px;
    overflow-y: auto;
    overflow-x: hidden;
    scrollbar-width: thin;
  	scrollbar-color: #007bff #f8f9fa;
}

.customeSidebarBtn {
	margin-right: 0.25rem;
	margin-left: 0.25rem;
	margin-top: 0.25rem;
	width: 97%;
	border-radius: 0.75rem;
}

.panel-buttons {
	margin: 1%;
}

.btn-print {
	background-color: purple;
	border: none;
	color: white;
	font-weight: bold;
	text-decoration: none;
}

.fs-custom {
	font-size: 0.95rem;
}

.nav-links.active {
	color: green !important;
	font-weight: bold;
	border: none !important;
	display: block;
    padding: .5rem 1rem;
}

.nav-links {
	color: black !important;
	font-weight: bold;
	border: none !important;
	display: block;
    padding: .5rem 1rem;
}

.custom-container {
	display: flex;
	margin: 1rem;
}

/* Summer Note styles */
.note-editor {
	width: 100% !important;
	/* margin: 1rem 2.5rem; */
}
</style>
</head>
<body>
	<%
		List<IGIInterface> igiInterfaceList = (List<IGIInterface>)request.getAttribute("igiInterfaceList");
		List<IGIInterfaceTypes> interfaceTypesList = (List<IGIInterfaceTypes>)request.getAttribute("interfaceTypesList");
		List<IGIInterfaceContent> interfaceContentList = (List<IGIInterfaceContent>)request.getAttribute("interfaceContentList");
		List<IGIConnector> connectorMasterList = (List<IGIConnector>)request.getAttribute("connectorMasterList");
		IGIInterface igiInterface = (IGIInterface)request.getAttribute("igiInterfaceData");
		IGIInterface igiInterfaceParent = (IGIInterface)request.getAttribute("igiInterfaceParentData");
		String interfaceId = (String)request.getAttribute("interfaceId");
		String igiDocId = (String)request.getAttribute("igiDocId");
		String parentId = (String)request.getAttribute("parentId");
		
		List<String> interfaceSpeedList = Arrays.asList("Not Applicable", "Low", "Medium", "High");
		
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
	
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
 			<div class="card-header" style="background-color: transparent;height: 3rem;">
 				<div class="row">
 					<div class="col-md-2">
 						<h3 class="text-dark" style="font-weight: bold;">Physical Interfaces</h3>
 					</div>
 					<div class="col-md-8"></div>
 					<div class="col-md-2 right">
	 					<a class="btn btn-info btn-sm shadow-nohover back" style="position:relative;" href="IGIDocumentDetails.htm?igiDocId=<%=igiDocId%>">Back</a>
 					</div>
 				</div>
       		</div>
       		
       		<div class="card-body">
       			<div class="custom-container">
       				<div style="width: 12%;">
       					<div class="card" style="border-color: #007bff;">
     						<div class="card-header center" style="background-color: transparent;border-color: #007bff;">
     							<h5 class="" style="font-weight: bold;color: #8b550c;">List of Interfaces</h5>
     						</div>
   							<div class="card-body customSidebar">
								<div class="row">
  									<div class="col-md-12">
  										<form action="IGIInterfacesList.htm" method="GET">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
											<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
     										<button type="submit" class="btn btn-outline-primary fw-bold customeSidebarBtn" <%if(0L==Long.parseLong(interfaceId) && Long.parseLong(parentId)==0) {%> style="background-color: green;color: white;border-color: green;padding: 0.2rem;" <%} else{%>style="padding: 0.2rem;"<%} %> data-toggle="tooltip" data-placement="top">
     											Add New Interface
     										</button>
	     								</form>		
  									</div>
   								</div>
    							
   								<% 
								    // Define interface types and corresponding variable names
								    Map<String, List<IGIInterface>> interfaceMap = new LinkedHashMap<>();
   									
   									for(IGIInterfaceTypes interfaceType : interfaceTypesList) {
   										
   										List<IGIInterface> igiinterfaceListByType = igiInterfaceList.stream().filter(e -> interfaceType.getInterfaceTypeId().equals(e.getInterfaceTypeId()) && e.getParentId()==0L).collect(Collectors.toList());
   										
   										interfaceMap.computeIfAbsent(interfaceType.getInterfaceType(), k -> new ArrayList<>()).addAll(igiinterfaceListByType);
   									}
   									
									int interfaceMainCount = 0;
								    for (Map.Entry<String, List<IGIInterface>> entry : interfaceMap.entrySet()) {
								        String interfaceType = entry.getKey();
								        List<IGIInterface> interfaceList = entry.getValue();
								        String buttonId = interfaceType.replace(" ", "").toLowerCase() + "InterfaceBtn";
								        String listId = interfaceType.replace(" ", "").toLowerCase() + "InterfaceList";
								%>
								    <!-- Interface List Section -->
								    <div class="row">
								        <div class="col-md-12">
								            <button type="button" class="btn btn-outline-secondary fw-bold customeSidebarBtn left" 
								                id="<%=buttonId%>" value="1" style="padding: 0.2rem;" 
								                data-toggle="tooltip" data-placement="top" title="<%=interfaceType%> Interfaces">
								                <span style="font-weight: bold;"><%=(++interfaceMainCount) + ". " + interfaceType!=null?StringEscapeUtils.escapeHtml4(interfaceType): " - "%></span>
								                <% if (interfaceList.size() > 0) { %>
								                &nbsp; <i class="fa fa-caret-up"></i>
								                <% } %>
								            </button>
								        </div>
								    </div>
								
								    <div id="<%=listId%>">
								        <% 
								        int interfaceSubCount = 0;
								        for (IGIInterface iface : interfaceList) { %>
								        <div class="row">
								            <div class="col-md-12 ml-3">
								                <form action="IGIInterfacesList.htm" method="GET">
								                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								                    <input type="hidden" name="igiDocId" value="<%=igiDocId%>" />
								                    <button type="submit" class="btn btn-sm btn-outline-primary fw-bold customeSidebarBtn left"
								                        name="interfaceId" value="<%=iface.getInterfaceId()%>" 
								                        data-toggle="tooltip" data-placement="top" title="<%=iface.getInterfaceCode()%>" 
								                        <% if (iface.getInterfaceId().equals(Long.parseLong(interfaceId))) { %>
								                        style="background-color: green; color: white; border-color: green; width: 89%;" 
								                        <% } else { %> style="width: 89%;" <% } %>>
								                        <%=(interfaceMainCount) + "." + (++interfaceSubCount) + ". " + iface.getInterfaceCode()!=null?StringEscapeUtils.escapeHtml4(iface.getInterfaceCode()): " - "%>
								                    </button>
								                </form>
								            </div>
								        </div>
								        <% 
								        List<IGIInterface> interfaceListSub = igiInterfaceList.stream().filter(e -> e.getParentId().equals(iface.getInterfaceId())).collect(Collectors.toList());
								        int interfaceSubSubCount = 0;
								        	for (IGIInterface ifacesub : interfaceListSub) {
								        %>
										        <div class="row">
										            <div class="col-md-12 ml-4">
										                <form action="IGIInterfacesList.htm" method="GET">
										                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										                    <input type="hidden" name="igiDocId" value="<%=igiDocId%>" />
										                    <button type="submit" class="btn btn-sm btn-outline-primary fw-bold customeSidebarBtn left"
										                        name="interfaceId" value="<%=ifacesub.getInterfaceId()%>" 
										                        data-toggle="tooltip" data-placement="top" title="<%=ifacesub.getInterfaceCode()%>" 
										                        <% if (ifacesub.getInterfaceId().equals(Long.parseLong(interfaceId))) { %>
										                        style="background-color: green; color: white; border-color: green; width: 86%;" 
										                        <% } else { %> style="width: 86%;" <% } %>>
										                        <%=(interfaceMainCount) + "." + (interfaceSubCount) + "." +(++interfaceSubSubCount) + ". " + ifacesub.getInterfaceCode()!=null?StringEscapeUtils.escapeHtml4(iface.getInterfaceCode()): " - "%>
										                    </button>
										                </form>
										            </div>
										        </div>
								        	<%} %>
								        <% } %>
								    </div>
								<% } %>
   								
   							</div>
       					</div>
       				</div>
       				<div style="width: 88%;">
       					<div class="card ml-3 mr-3">
       						<div class="card-header">
       							<div class="d-flex justify-content-between" style="margin-top: -0.5rem;">
       									<h4 class="text-dark mt-2">Interface Details <%if(igiInterface!=null) {%>- <%=StringEscapeUtils.escapeHtml4(igiInterface.getInterfaceName()) %><%} else{%>Add<%} %> </h4>
       									<%if(Long.parseLong(parentId)==0 && (Long.parseLong(interfaceId)!=0) && (igiInterface!=null && igiInterface.getParentId()==0L)) {%>
	       									<form action="IGIInterfacesList.htm" method="GET">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
												<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
												<input type="hidden" name="parentId" value="<%=interfaceId%>">
	     										<button type="submit" class="btn btn-primary fw-bold" data-toggle="tooltip" data-placement="top">
	     											Add New Sub Interface
	     										</button>
		     								</form>
	     								<%} %>
       							</div>
       						</div>
       						<div class="card-body m-2">
       							<form action="IGIInterfaceDetailsSubmit.htm" method="post" id="myform">
       								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
       								<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
       								<input type="hidden" name="interfaceId" id="interfaceId" value="<%=interfaceId%>">
       								<input type="hidden" name="parentId" value="<%=parentId%>">
	       							<div class="form-group border rounded shadow-sm p-3 mb-3 bg-light" style="border-color: #9898ff !important;">
		       							<div class="row">
		       								<div class="col-md-2">
		       									<label class="form-lable">Interface Type <span class="mandatory">*</span></label>
		       									<select class="form-control selectdee" id="interfaceType" name="interfaceType" <%if(igiInterface!=null || igiInterfaceParent!=null) {%>disabled<%} %> required>
		       										<option value="" selected disabled>----select----</option>
		       										<%
		       										String interfaceTypeParent = "";
		       										String interfaceContentParent = "";
		       										%>
		       										<%for(IGIInterfaceTypes interfaceType : interfaceTypesList) {%>
		       											<option value="<%=interfaceType.getInterfaceTypeId()+"/"+interfaceType.getInterfaceTypeCode()+"/"+interfaceType.getInterfaceType() %>" 
			       											<%if(igiInterface!=null && igiInterface.getInterfaceTypeId()!=null && igiInterface.getInterfaceTypeId().equals(interfaceType.getInterfaceTypeId())) {%>selected<%} %>
			       											<%if(igiInterfaceParent!=null && igiInterfaceParent.getInterfaceTypeId()!=null && igiInterfaceParent.getInterfaceTypeId().equals(interfaceType.getInterfaceTypeId())) {%>selected
			       											<%interfaceTypeParent = interfaceType.getInterfaceTypeId()+"/"+interfaceType.getInterfaceTypeCode()+"/"+interfaceType.getInterfaceType(); %> <%} %>>
			       											<%=interfaceType.getInterfaceType()!=null?StringEscapeUtils.escapeHtml4(interfaceType.getInterfaceType()): " - "+" ("+interfaceType.getInterfaceTypeCode()!=null?StringEscapeUtils.escapeHtml4(interfaceType.getInterfaceTypeCode()): " - "+")" %>
		       											</option>
		       										<%} %>
		       									</select>
		       								</div>
		       								
		       								<div class="col-md-2">
											    <label class="form-label">Interface Content <span class="mandatory">*</span></label>
											    <select class="form-control selectdee " id="interfaceContent" name="interfaceContent" <%if(igiInterface!=null || igiInterfaceParent!=null) {%>disabled<%} %> required>
											        <option value="0/NA/NA" selected>----select----</option>
											        <%if(igiInterface!=null) { 
											        	IGIInterfaceTypes igiInterfaceType = interfaceTypesList.stream().filter(e -> igiInterface.getInterfaceTypeId().equals(e.getInterfaceTypeId())).findFirst().orElse(null);
											        	//IGIInterfaceContent igiInterfaceContent = interfaceContentList.stream().filter(e -> igiInterface.getInterfaceContentId().equals(e.getInterfaceContentId())).findFirst().orElse(null);
											        	List<IGIInterfaceContent> igiInterfaceContentList = interfaceContentList.stream().filter(e -> igiInterface.getInterfaceTypeId().equals(e.getInterfaceTypeId())).collect(Collectors.toList());
											        	
											        	for(IGIInterfaceContent interfaceContent : igiInterfaceContentList) {
											        %>
											        	<option value="<%=interfaceContent.getInterfaceContentId()+"/"+interfaceContent.getInterfaceContentCode()+"/"+interfaceContent.getInterfaceContent() %>" 
												        	<%if(igiInterface!=null && igiInterface.getInterfaceContentId()!=null && igiInterface.getInterfaceContentId().equals(interfaceContent.getInterfaceContentId())) {%>selected<%} %>>
												        	<%=interfaceContent.getInterfaceContent()!=null?StringEscapeUtils.escapeHtml4(interfaceContent.getInterfaceContent()): " - "+" ("+interfaceContent.getInterfaceContentCode()!=null?StringEscapeUtils.escapeHtml4(interfaceContent.getInterfaceContentCode()): " - "+")" %>
											        	</option>
											        <%} }%>
											        <%if(igiInterfaceParent!=null) { 
											        	IGIInterfaceTypes igiInterfaceType = interfaceTypesList.stream().filter(e -> igiInterfaceParent.getInterfaceTypeId().equals(e.getInterfaceTypeId())).findFirst().orElse(null);
											        	//IGIInterfaceContent igiInterfaceContent = interfaceContentList.stream().filter(e -> igiInterface.getInterfaceContentId().equals(e.getInterfaceContentId())).findFirst().orElse(null);
											        	List<IGIInterfaceContent> igiInterfaceContentList = interfaceContentList.stream().filter(e -> igiInterfaceParent.getInterfaceTypeId().equals(e.getInterfaceTypeId())).collect(Collectors.toList());
											        	
											        	for(IGIInterfaceContent interfaceContent : igiInterfaceContentList) {
											        %>
											        	<option value="<%=interfaceContent.getInterfaceContentId()+"/"+interfaceContent.getInterfaceContentCode()+"/"+interfaceContent.getInterfaceContent() %>" 
												        	<%if(igiInterfaceParent!=null && igiInterfaceParent.getInterfaceContentId()!=null && igiInterfaceParent.getInterfaceContentId().equals(interfaceContent.getInterfaceContentId())) {%>selected
												        	<%interfaceContentParent = interfaceContent.getInterfaceContentId()+"/"+interfaceContent.getInterfaceContentCode()+"/"+interfaceContent.getInterfaceContent(); %> <%} %>>
												        	<%=interfaceContent.getInterfaceContent()!=null?StringEscapeUtils.escapeHtml4(interfaceContent.getInterfaceContent()): " - "+" ("+interfaceContent.getInterfaceContentCode()!=null?StringEscapeUtils.escapeHtml4(interfaceContent.getInterfaceContentCode()): " - "+")" %>
											        	</option>
											        <%} }%>
											    </select>
											</div>
											<div class="col-md-3">
		       									<label class="form-lable">Parameter</label>
		       									<input type="text" class="form-control" name="parameterData" 
		       									<%if(igiInterface!=null && igiInterface.getParameterData()!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(igiInterface.getParameterData()) %>" <%} %> 
		       									<%if(igiInterfaceParent!=null && igiInterfaceParent.getParameterData()!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(igiInterfaceParent.getParameterData()) %>" readonly <%} %> 
		       									<%if(igiInterface!=null && igiInterface.getParentId()!=0) {%> readonly <%} %> 
		       									placeholder="Enter Parameter" maxlength="255">
		       								</div>
		       								<%-- <div class="col-md-2">
		       									<label class="form-lable">Interface ID <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="interfaceCode" <%if(igiInterface!=null && igiInterface.getInterfaceCode()!=null) {%> value="<%=igiInterface.getInterfaceCode() %>" <%} %> placeholder="Enter Unique Id" onchange="checkDuplicateInterfaceCode(this)" required maxlength="10">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Interface Name <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="interfaceName" <%if(igiInterface!=null && igiInterface.getInterfaceName()!=null) {%> value="<%=igiInterface.getInterfaceName() %>" <%} %> placeholder="Enter Interface Name" required maxlength="500">
		       								</div> --%>
		       							<!-- </div>
		       						</div>
		       						
		       						<div class="form-group">
		       							<div class="row"> -->
		       								<div class="col-md-2">
		       									<label class="form-lable">Interface Speed <span class="mandatory">*</span></label>
		       									<select class="form-control" name="interfaceSpeed" <%if(igiInterfaceParent!=null || (igiInterface!=null && igiInterface.getParentId()!=0)) {%>disabled<%} %> required>
		       										<option value="" selected disabled>----select----</option>
		       										<%for(String interfaceSpeed : interfaceSpeedList) {%>
		       											<option value="<%=interfaceSpeed %>" 
			       											<%if(igiInterface!=null && igiInterface.getInterfaceSpeed()!=null && igiInterface.getInterfaceSpeed().equalsIgnoreCase(interfaceSpeed)) {%>selected<%} %>
			       											<%if(igiInterfaceParent!=null && igiInterfaceParent.getInterfaceSpeed()!=null && igiInterfaceParent.getInterfaceSpeed().equalsIgnoreCase(interfaceSpeed)) {%>selected<%} %>>
		       												<%=interfaceSpeed !=null?StringEscapeUtils.escapeHtml4(interfaceSpeed): " - "%>
		       											</option>
		       										<%} %>
		       									</select>
		       									<%if(igiInterfaceParent!=null) {%>
		       										<input type="hidden" name="interfaceSpeed" value="<%=igiInterfaceParent.getInterfaceSpeed()%>">
		       										<input type="hidden" name="interfaceType" value="<%=interfaceTypeParent%>">
		       										<input type="hidden" name="interfaceContent" value="<%=interfaceContentParent%>">
		       										<input type="hidden" name="interfaceCode" value="<%=igiInterfaceParent.getInterfaceCode()%>">
		       										<input type="hidden" name="interfaceName" value="<%=igiInterfaceParent.getInterfaceName()%>">
		       									<%} %>
		       								</div>
		       								<%-- <div class="col-md-3">
		       									<label class="form-lable">Connector </label>
		       									<input type="text" class="form-control" name="connector" <%if(igiInterface!=null && igiInterface.getConnector()!=null) {%> value="<%=igiInterface.getConnector() %>" <%} %> placeholder="Enter Connector Details" maxlength="255">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Protection </label>
		       									<input type="text" class="form-control" name="protection" <%if(igiInterface!=null && igiInterface.getProtection()!=null) {%> value="<%=igiInterface.getProtection() %>" <%} %> placeholder="Enter Protection Details" maxlength="255">
		       								</div> --%>
		       							</div>
		       						</div>
		       						
		       						<div class="form-group border rounded shadow-sm p-3 mb-3 bg-light" style="border-color: #9898ff !important;">
			       						<div class="row">
			                    		    <div class="col-md-6" style="text-align: left;">
			                    		    	<label class="control-label" style="color: black;">End-1 Connector :</label>
			                    		    	<select class="form-control selectdee connectorIdE1" name="connectorIdE1" id="connectorIdE1"
										    	data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
												<option value="" disabled selected>Choose...</option>
												    <%for(IGIConnector con : connectorMasterList){ %>
												    	<option value="<%=con.getConnectorId() %>"
												    	<%if(igiInterface!=null && igiInterface.getConnectorIdEOne().equals(con.getConnectorId())) {%>selected<%} %>>
												      		<%=con.getPartNo()!=null?StringEscapeUtils.escapeHtml4(con.getPartNo()): " - " %> (<%=con.getConnectorMake()!=null?StringEscapeUtils.escapeHtml4(con.getConnectorMake()): " - " %>)
												    	</option>
												    <% }%>
												</select>
			                    		    </div>
			                    		    
			                    		    <div class="col-md-6" style="text-align: left;">
			                    		    	<label class="control-label" style="color: black;">End-2 Connector :</label>
			                    		    	<select class="form-control selectdee connectorIdE2" name="connectorIdE2" id="connectorIdE2"
										    	data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
												<option value="" disabled selected>Choose...</option>
												    <%for(IGIConnector con : connectorMasterList){ %>
												    	<option value="<%=con.getConnectorId() %>"
												    	<%if(igiInterface!=null && igiInterface.getConnectorIdETwo().equals(con.getConnectorId())) {%>selected<%} %>>
												      		<%=con.getPartNo()!=null?StringEscapeUtils.escapeHtml4(con.getPartNo()): " - " %> (<%=con.getConnectorMake()!=null?StringEscapeUtils.escapeHtml4(con.getConnectorMake()): " - " %>)
												    	</option>
												    <% }%>
												</select>
			                    		    </div>
	                  				 	</div>
                    				</div>
                    				
		       						<div class="form-group border rounded shadow-sm p-3 mb-3 bg-light" style="border-color: #9898ff !important;">
		       							<div class="row">
		       								
		       								<div class="col-md-3">
		       									<label class="form-lable">Info</label>
		       									<input type="text" class="form-control" name="cableInfo" <%if(igiInterface!=null && igiInterface.getCableInfo()!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(igiInterface.getCableInfo()) %>" <%} %> placeholder="Enter Maximum of 255 Characters" maxlength="255">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Constraint</label>
		       									<input type="text" class="form-control" name="cableConstraint" <%if(igiInterface!=null && igiInterface.getCableConstraint()!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(igiInterface.getCableConstraint()) %>" <%} %> placeholder="Enter Maximum of 255 Characters" maxlength="255">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Diameter</label>
		       									<input type="text" class="form-control" name="cableDiameter" <%if(igiInterface!=null && igiInterface.getCableDiameter()!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(igiInterface.getCableDiameter()) %>" <%} %> placeholder="Enter Maximum of 255 Characters" maxlength="255">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Details </label>
		       									<input type="text" class="form-control" name="cableDetails" <%if(igiInterface!=null && igiInterface.getCableDetails()!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(igiInterface.getCableDetails()) %>" <%} %> placeholder="Enter Maximum of 255 Characters" maxlength="255">
		       								</div>
		       							</div>
		       							
		       							<div class="row mt-3">
		       								
		       								<div class="col-md-3">
		       									<label class="form-lable">Max Length (In Meters)<span class="mandatory">*</span></label>
		       									<input type="number" step="1" class="form-control" name="cableMaxLength" <%if(igiInterface!=null && igiInterface.getCableMaxLength()!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(igiInterface.getCableMaxLength().toString()) %>" <%} %> placeholder="Enter Maximum Length" min="0" max="1000000000" required>
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Interface Loss per Meter<span class="mandatory">*</span></label>
		       									<input type="number" step="1" class="form-control" name="interfaceLoss" <%if(igiInterface!=null && igiInterface.getInterfaceLoss()!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(igiInterface.getInterfaceLoss().toString()) %>" <%} %> placeholder="Enter Interface Loss per Meter" min="0" max="1000000000" required>
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Bending Radius<span class="mandatory">*</span></label>
		       									<input type="number" step="any" class="form-control" name="cableBendingRadius" <%if(igiInterface!=null && igiInterface.getCableBendingRadius()!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(igiInterface.getCableBendingRadius().toString()) %>" <%} %> placeholder="Enter Bending Radius" min="0" max="1000000000" required>
		       								</div>
		       							</div>
		       						</div>
		       						
		       						<div class="form-group">
		       							<div class="row">
		       								<div class="col-md-6">
		       									<label class="form-lable">Diagram </label>
		       									<div id="diagramEditor" class="center"></div>
												<textarea name="interfaceDiagram" style="display: none;"></textarea>
		       								</div>
		       								<div class="col-md-6">
		       									<label class="form-lable">Description </label>
		       									<div id="descriptionEditor" class="center"></div>
												<textarea name="interfaceDescription" style="display: none;"></textarea>
		       								</div>
		       							</div>
		       						</div>
	       						
	       							<div class="form-group">
	       								<div class="center">
	       									<%if(igiInterface!=null){ %>
												<button type="submit" class="btn btn-sm btn-warning edit btn-soc" name="action" value="Edit" onclick="return confirm('Are you sure to Update?')" >UPDATE</button>
											<%}else{ %>
												<button type="submit" class="btn btn-sm btn-success submit btn-soc" name="action" value="Add" onclick="return confirm('Are you sure to Submit?')" >SUBMIT</button>
											<%} %>
	       								</div>
	       							</div>	
	       						</form>	
       						</div>
       					</div>
       				</div>
       			</div>
       		</div>		
		</div>
	</div>	
	
	<script type="text/javascript">
		
		function toggleInterface(buttonId, listId) {
		    $('#'+buttonId).on('click', function () {
		        const currentValue = $(this).val();
		        $(this).val(currentValue === '1' ? '0' : '1');
		        $('#'+listId).toggle();
		        $(this).find('i').toggleClass('fa-caret-up fa-caret-down');
		    });
		}
	
		// Initialize toggles
		<%for(IGIInterfaceTypes interfaceType : interfaceTypesList) {%>
			toggleInterface('<%=interfaceType.getInterfaceType().toLowerCase() %>InterfaceBtn', '<%=interfaceType.getInterfaceType().toLowerCase() %>InterfaceList');
		<%} %>
		
		// Define a common Summernote configuration
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
		

		// Diagram Editor Configure
		$('#diagramEditor').summernote(summernoteConfig);
		
		// Description Editor Configure
		$('#descriptionEditor').summernote(summernoteConfig);
		
		// Update the values of Editors
		var html1 = '<%=igiInterface!=null && igiInterface.getInterfaceDiagram()!=null?StringEscapeUtils.escapeHtml4(igiInterface.getInterfaceDiagram()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):""%>';
		var html2 = '<%=igiInterface!=null && igiInterface.getInterfaceDescription()!=null?StringEscapeUtils.escapeHtml4(igiInterface.getInterfaceDescription()).replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):""%>';
		$('#diagramEditor').summernote('code', html1);
		$('#descriptionEditor').summernote('code', html2);		
		
		// Set the values to the form when submitting.
		$('#myform').submit(function() {

			 var data1 = $('#diagramEditor').summernote('code');
			 $('textarea[name=interfaceDiagram]').val(data1);
			 
			 var data2 = $('#descriptionEditor').summernote('code');
			 $('textarea[name=interfaceDescription]').val(data2);
			
		});
		

	    var interfaceContentMap = {};
	    <% for (IGIInterfaceTypes interfaceType : interfaceTypesList) { %>
	        var contentList = [];
	        <% for (IGIInterfaceContent content : interfaceContentList) { 
	            if (content.getInterfaceTypeId().equals(interfaceType.getInterfaceTypeId())) { %>
	                contentList.push({
	                    value: "<%= content.getInterfaceContentId()!=null?StringEscapeUtils.escapeHtml4(content.getInterfaceContentId().toString()): " - " +"/"+ content.getInterfaceContentCode()!=null?StringEscapeUtils.escapeHtml4(content.getInterfaceContentCode()): " - " +"/"+ content.getInterfaceContent()!=null?StringEscapeUtils.escapeHtml4(content.getInterfaceContent()): " - " %>",
	                    text: "<%= content.getInterfaceContent()!=null?StringEscapeUtils.escapeHtml4(content.getInterfaceContent()): " - "+" ("+content.getInterfaceContentCode()!=null?StringEscapeUtils.escapeHtml4(content.getInterfaceContentCode()): " - "+")" %>"
	                });
	        <% } } %>
	        interfaceContentMap["<%= interfaceType.getInterfaceTypeId()!=null?StringEscapeUtils.escapeHtml4(interfaceType.getInterfaceTypeId().toString()): " - " +"/"+interfaceType.getInterfaceTypeCode()!=null?StringEscapeUtils.escapeHtml4(interfaceType.getInterfaceTypeCode()): " - " +"/"+ interfaceType.getInterfaceType()!=null?StringEscapeUtils.escapeHtml4(interfaceType.getInterfaceType()): " - " %>"] = contentList;
	    <% } %>

	    $('.selectdee').select2({
            width: '100%'
        });
	    
	 	// Handle dropdown change
        $(document).on('change', '#interfaceType', function () {
            const selectedInterfaceType = $(this).val();
            const $contentDropdown = $('#interfaceContent');

            $contentDropdown.empty().append('<option value="0/NA/NA" selected>----select----</option>');

            const ifaceList = interfaceContentMap[selectedInterfaceType] || [];
            ifaceList.forEach(iface => {
                $contentDropdown.append(new Option(iface.text, iface.value));
            });

            $contentDropdown.trigger('change.select2');
        });
	 
	</script>

</body>
</html>