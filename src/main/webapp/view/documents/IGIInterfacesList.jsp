
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
		IGIInterface igiInterface = (IGIInterface)request.getAttribute("igiInterfaceData");
		String interfaceId = (String)request.getAttribute("interfaceId");
		String igiDocId = (String)request.getAttribute("igiDocId");
	%>
	
	<% String ses=(String)request.getParameter("result");
	 	String ses1=(String)request.getParameter("resultfail");
		if(ses1!=null){
		%>
		<div align="center">
			<div class="alert alert-danger" role="alert">
		    <%=ses1 %>
		    </div>
		</div>
		<%}if(ses!=null){ %>
		<div align="center">
			<div class="alert alert-success" role="alert" >
		    	<%=ses %>
			</div>
		</div>
	<%} %>
	
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
     										<button type="submit" class="btn btn-outline-primary fw-bold customeSidebarBtn" <%if(0L==Long.parseLong(interfaceId)) {%> style="background-color: green;color: white;border-color: green;padding: 0.2rem;" <%} else{%>style="padding: 0.2rem;"<%} %> data-toggle="tooltip" data-placement="top">
     											Add New Interface
     										</button>
	     								</form>		
  									</div>
   								</div>
    							
   								<% 
								    // Define interface types and corresponding variable names
								    Map<String, List<IGIInterface>> interfaceMap = new LinkedHashMap<>();
   									
   									for(IGIInterfaceTypes interfaceType : interfaceTypesList) {
   										
   										List<IGIInterface> igiinterfaceListByType = igiInterfaceList.stream().filter(e -> interfaceType.getInterfaceTypeId().equals(e.getInterfaceTypeId())).collect(Collectors.toList());
   										
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
								                <span style="font-weight: bold;"><%=(++interfaceMainCount) + ". " + interfaceType%></span>
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
								            <div class="col-md-12 ml-4">
								                <form action="IGIInterfacesList.htm" method="GET">
								                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								                    <input type="hidden" name="igiDocId" value="<%=igiDocId%>" />
								                    <button type="submit" class="btn btn-sm btn-outline-primary fw-bold customeSidebarBtn left"
								                        name="interfaceId" value="<%=iface.getInterfaceId()%>" 
								                        data-toggle="tooltip" data-placement="top" title="<%=iface.getInterfaceCode()%>" 
								                        <% if (iface.getInterfaceId().equals(Long.parseLong(interfaceId))) { %>
								                        style="background-color: green; color: white; border-color: green; width: 86%;" 
								                        <% } else { %> style="width: 86%;" <% } %>>
								                        <%=(interfaceMainCount) + "." + (++interfaceSubCount) + ". " + iface.getInterfaceCode()%>
								                    </button>
								                </form>
								            </div>
								        </div>
								        <% } %>
								    </div>
								<% } %>
   								
   							</div>
       					</div>
       				</div>
       				<div style="width: 88%;">
       					<div class="card ml-3 mr-3">
       						<div class="card-header">
       							<h4 class="text-dark">Interface Details <%if(igiInterface!=null) {%>- <%=igiInterface.getInterfaceName() %><%} %> </h4>
       						</div>
       						<div class="card-body m-2">
       							<form action="IGIInterfaceDetailsSubmit.htm" method="post" id="myform">
       								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
       								<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
       								<input type="hidden" name="interfaceId" id="interfaceId" value="<%=interfaceId%>">
	       							<div class="form-group">
		       							<div class="row">
		       								<div class="col-md-2">
		       									<label class="form-lable">Interface Type <span class="mandatory">*</span></label>
		       									<%-- <select class="form-control" id="interfaceType" name="interfaceType" required>
		       										<option value="" selected disabled>----select----</option>
		       										<option value="Power" <%if(igiInterface!=null && igiInterface.getInterfaceType()!=null && igiInterface.getInterfaceType().equalsIgnoreCase("Power")) {%>selected<%} %>>Power</option>
		       										<option value="Analog" <%if(igiInterface!=null && igiInterface.getInterfaceType()!=null && igiInterface.getInterfaceType().equalsIgnoreCase("Analog")) {%>selected<%} %>>Analog</option>
		       										<option value="Digital" <%if(igiInterface!=null && igiInterface.getInterfaceType()!=null && igiInterface.getInterfaceType().equalsIgnoreCase("Digital")) {%>selected<%} %>>Digital</option>
		       										<option value="Optical" <%if(igiInterface!=null && igiInterface.getInterfaceType()!=null && igiInterface.getInterfaceType().equalsIgnoreCase("Optical")) {%>selected<%} %>>Optical</option>
		       										<option value="Mechanical" <%if(igiInterface!=null && igiInterface.getInterfaceType()!=null && igiInterface.getInterfaceType().equalsIgnoreCase("Mechanical")) {%>selected<%} %>>Mechanical</option>
		       										<option value="Liquid Cooling" <%if(igiInterface!=null && igiInterface.getInterfaceType()!=null && igiInterface.getInterfaceType().equalsIgnoreCase("Liquid Cooling")) {%>selected<%} %>>Liquid Cooling</option>
		       									</select> --%>
		       									<select class="form-control" id="interfaceType" name="interfaceType" <%if(igiInterface!=null) {%>disabled<%} %> required>
		       										<option value="" selected disabled>----select----</option>
		       										<%for(IGIInterfaceTypes interfaceType : interfaceTypesList) {%>
		       											<option value="<%=interfaceType.getInterfaceTypeId()+"/"+interfaceType.getInterfaceTypeCode()+"/"+interfaceType.getInterfaceType() %>" <%if(igiInterface!=null && igiInterface.getInterfaceTypeId()!=null && igiInterface.getInterfaceTypeId().equals(interfaceType.getInterfaceTypeId())) {%>selected<%} %>><%=interfaceType.getInterfaceType() %></option>
		       										<%} %>
		       									</select>
		       								</div>
		       								
		       								<div class="col-md-2">
											    <label class="form-label">Interface Content <span class="mandatory">*</span></label>
											    <select class="form-control " id="interfaceContent" name="interfaceContent" <%if(igiInterface!=null) {%>disabled<%} %> required>
											        <option value="0/NA/NA" selected>----select----</option>
											        <%if(igiInterface!=null) { 
											        	IGIInterfaceTypes igiInterfaceType = interfaceTypesList.stream().filter(e -> igiInterface.getInterfaceTypeId().equals(e.getInterfaceTypeId())).findFirst().orElse(null);
											        	//IGIInterfaceContent igiInterfaceContent = interfaceContentList.stream().filter(e -> igiInterface.getInterfaceContentId().equals(e.getInterfaceContentId())).findFirst().orElse(null);
											        	List<IGIInterfaceContent> igiInterfaceContentList = interfaceContentList.stream().filter(e -> igiInterface.getInterfaceTypeId().equals(e.getInterfaceTypeId())).collect(Collectors.toList());
											        	
											        	for(IGIInterfaceContent interfaceContent : igiInterfaceContentList) {
											        %>
											        	<option value="<%=interfaceContent.getInterfaceContentId()+"/"+interfaceContent.getInterfaceContentCode()+"/"+interfaceContent.getInterfaceContent() %>" <%if(igiInterface!=null && igiInterface.getInterfaceContentId()!=null && igiInterface.getInterfaceContentId().equals(interfaceContent.getInterfaceContentId())) {%>selected<%} %>><%=interfaceContent.getInterfaceContent() %></option>
											        <%} }%>
											    </select>
											</div>
											<div class="col-md-3">
		       									<label class="form-lable">Parameter</label>
		       									<input type="text" class="form-control" name="parameterData" <%if(igiInterface!=null && igiInterface.getParameterData()!=null) {%> value="<%=igiInterface.getParameterData() %>" <%} %> placeholder="Enter Parameter" maxlength="255">
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
		       									<select class="form-control" name="interfaceSpeed" required>
		       										<option value="" selected disabled>----select----</option>
		       										<option value="Not Applicable" <%if(igiInterface!=null && igiInterface.getInterfaceSpeed()!=null && igiInterface.getInterfaceSpeed().equalsIgnoreCase("Not Applicable")) {%>selected<%} %>>Not Applicable</option>
		       										<option value="Low" <%if(igiInterface!=null && igiInterface.getInterfaceSpeed()!=null && igiInterface.getInterfaceSpeed().equalsIgnoreCase("Low")) {%>selected<%} %>>Low</option>
		       										<option value="Medium" <%if(igiInterface!=null && igiInterface.getInterfaceSpeed()!=null && igiInterface.getInterfaceSpeed().equalsIgnoreCase("Medium")) {%>selected<%} %>>Medium</option>
		       										<option value="High" <%if(igiInterface!=null && igiInterface.getInterfaceSpeed()!=null && igiInterface.getInterfaceSpeed().equalsIgnoreCase("High")) {%>selected<%} %>>High</option>
		       									</select>
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
		       						
		       						<div class="row">
		                    		    <div class="col-md-6" style="text-align: left;">
		                    		    	<label class="control-label" style="color: black;">End-1 Connector :</label>
		                    		    </div>
                  				 	</div>

		       						
		       						<div class="form-group">
			       						<div class="row">
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Part No </label>
		       									<input type="text" class="form-control" name="partNoEOne" <%if(igiInterface!=null && igiInterface.getPartNoEOne()!=null) {%>value="<%=igiInterface.getPartNoEOne() %>"<%} %> placeholder="Enter Part No" maxlength="255">
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Connector Make </label>
		       									<input type="text" class="form-control" name="connectorMakeEOne" <%if(igiInterface!=null && igiInterface.getConnectorMakeEOne()!=null) {%>value="<%=igiInterface.getConnectorMakeEOne() %>"<%} %> placeholder="Enter Connector Make" maxlength="255">
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Standard </label>
		       									<input type="text" class="form-control" name="standardEOne" <%if(igiInterface!=null && igiInterface.getStandardEOne()!=null) {%>value="<%=igiInterface.getStandardEOne() %>"<%} %> placeholder="Enter Standard" maxlength="255">
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Protection </label>
		       									<input type="text" class="form-control" name="protectionEOne" <%if(igiInterface!=null && igiInterface.getProtectionEOne()!=null) {%>value="<%=igiInterface.getProtectionEOne() %>"<%} %> placeholder="Enter Protection" maxlength="255">
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Ref Info </label>
		       									<input type="text" class="form-control" name="refInfoEOne" <%if(igiInterface!=null && igiInterface.getRefInfoEOne()!=null) {%>value="<%=igiInterface.getRefInfoEOne() %>"<%} %> placeholder="Enter Ref Info" maxlength="255">
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Remarks </label>
		       									<input type="text" class="form-control" name="remarksEOne" <%if(igiInterface!=null && igiInterface.getRemarksEOne()!=null) {%>value="<%=igiInterface.getRemarksEOne() %>"<%} %> placeholder="Enter Remarks" maxlength="255">
		       								</div>
	                  				 	</div>
                  				 	</div>
                    				 
                    				<hr class="mb-4">
                    				 
		       						<div class="row">
		                    		    <div class="col-md-6" style="text-align: left;">
		                    		    	<label class="control-label" style="color: black;">End-2 Connector :</label>
		                    		    </div>
                  				 	</div>

                  				 	
		       						<div class="form-group">
			       						<div class="row">
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Part No </label>
		       									<input type="text" class="form-control" name="partNoETwo" <%if(igiInterface!=null && igiInterface.getPartNoETwo()!=null) {%>value="<%=igiInterface.getPartNoETwo() %>"<%} %> placeholder="Enter Part No" maxlength="255">
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Connector Make </label>
		       									<input type="text" class="form-control" name="connectorMakeETwo" <%if(igiInterface!=null && igiInterface.getConnectorMakeETwo()!=null) {%>value="<%=igiInterface.getConnectorMakeETwo() %>"<%} %> placeholder="Enter Connector Make" maxlength="255">
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Standard </label>
		       									<input type="text" class="form-control" name="standardETwo" <%if(igiInterface!=null && igiInterface.getStandardETwo()!=null) {%>value="<%=igiInterface.getStandardETwo() %>"<%} %> placeholder="Enter Standard" maxlength="255">
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Protection </label>
		       									<input type="text" class="form-control" name="protectionETwo" <%if(igiInterface!=null && igiInterface.getProtectionETwo()!=null) {%>value="<%=igiInterface.getProtectionETwo() %>"<%} %> placeholder="Enter Protection" maxlength="255">
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Ref Info </label>
		       									<input type="text" class="form-control" name="refInfoETwo" <%if(igiInterface!=null && igiInterface.getRefInfoETwo()!=null) {%>value="<%=igiInterface.getRefInfoETwo() %>"<%} %> placeholder="Enter Ref Info" maxlength="255">
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Remarks </label>
		       									<input type="text" class="form-control" name="remarksETwo" <%if(igiInterface!=null && igiInterface.getRemarksETwo()!=null) {%>value="<%=igiInterface.getRemarksETwo() %>"<%} %> placeholder="Enter Remarks" maxlength="255">
		       								</div>
	                  				 	</div>
                  				 	</div>
                    				
                    				<hr class="mb-4">
                    				 
		       						<div class="form-group">
		       							<div class="row">
		       								
		       								<div class="col-md-3">
		       									<label class="form-lable">Cable Info</label>
		       									<input type="text" class="form-control" name="cableInfo" <%if(igiInterface!=null && igiInterface.getCableInfo()!=null) {%> value="<%=igiInterface.getCableInfo() %>" <%} %> placeholder="Enter Maximum of 255 Characters" maxlength="255">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Cable Constraint</label>
		       									<input type="text" class="form-control" name="cableConstraint" <%if(igiInterface!=null && igiInterface.getCableConstraint()!=null) {%> value="<%=igiInterface.getCableConstraint() %>" <%} %> placeholder="Enter Maximum of 255 Characters" maxlength="255">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Cable Diameter</label>
		       									<input type="text" class="form-control" name="cableDiameter" <%if(igiInterface!=null && igiInterface.getCableDiameter()!=null) {%> value="<%=igiInterface.getCableDiameter() %>" <%} %> placeholder="Enter Maximum of 255 Characters" maxlength="255">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Cable Details </label>
		       									<input type="text" class="form-control" name="cableDetails" <%if(igiInterface!=null && igiInterface.getCableDetails()!=null) {%> value="<%=igiInterface.getCableDetails() %>" <%} %> placeholder="Enter Maximum of 255 Characters" maxlength="255">
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
		var html1 = '<%=igiInterface!=null && igiInterface.getInterfaceDiagram()!=null?igiInterface.getInterfaceDiagram().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):""%>';
		var html2 = '<%=igiInterface!=null && igiInterface.getInterfaceDescription()!=null?igiInterface.getInterfaceDescription().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", ""):""%>';
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
	                    value: "<%= content.getInterfaceContentId() +"/"+ content.getInterfaceContentCode() +"/"+ content.getInterfaceContent() %>",
	                    text: "<%= content.getInterfaceContent() %>"
	                });
	        <% } } %>
	        interfaceContentMap["<%= interfaceType.getInterfaceTypeId() +"/"+interfaceType.getInterfaceTypeCode() +"/"+ interfaceType.getInterfaceType() %>"] = contentList;
	    <% } %>

	    document.getElementById("interfaceType").addEventListener("change", function () {
	        const selectedInterfaceType = this.value;
	        const contentDropdown = document.getElementById("interfaceContent");
	        
	        // Clear existing options
	        contentDropdown.innerHTML = '<option value="0/NA/NA" selected>----select----</option>';
	        
	        // Get the options for the selected interface type
	        const contentList = interfaceContentMap[selectedInterfaceType] || [];
	        
	        // Append options to the content dropdown
	        contentList.forEach(content => {
	            const option = document.createElement("option");
	            option.value = content.value;
	            option.textContent = content.text;
	            contentDropdown.appendChild(option);
	        });
	    });
	    
	</script>

</body>
</html>