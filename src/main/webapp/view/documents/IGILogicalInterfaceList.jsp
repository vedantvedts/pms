
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.documents.model.IGILogicalInterfaces"%>
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
		List<IGILogicalInterfaces> logicalInterfaceList = (List<IGILogicalInterfaces>)request.getAttribute("logicalInterfaceList");
		IGILogicalInterfaces logicalInterface = (IGILogicalInterfaces)request.getAttribute("igiLogicalInterfaceData");
		String logicalInterfaceId = (String)request.getAttribute("logicalInterfaceId");
		String igiDocId = (String)request.getAttribute("igiDocId");
		List<String> msgTypesList = Arrays.asList("Point to Point", "Broadcast", "Info", "Logging", "Multicast", "Commanding");
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
 						<h3 class="text-dark" style="font-weight: bold;">Logical Interfaces</h3>
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
  										<form action="IGILogicalInterfacesList.htm" method="GET">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
											<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
     										<button type="submit" class="btn btn-outline-primary fw-bold customeSidebarBtn" <%if(0L==Long.parseLong(logicalInterfaceId)) {%> style="background-color: green;color: white;border-color: green;padding: 0.2rem;" <%} else{%>style="padding: 0.2rem;"<%} %> data-toggle="tooltip" data-placement="top">
     											Add New Interface
     										</button>
	     								</form>		
  									</div>
   								</div>
    							
   								<% 
								    // Define interface types and corresponding variable names
								    Map<String, List<IGILogicalInterfaces>> interfaceMap = new LinkedHashMap<>();
   								
   									for(String msgType : msgTypesList) {
   										
   										List<IGILogicalInterfaces> interfaceListByType = logicalInterfaceList.stream().filter(e -> e.getMsgType().equalsIgnoreCase(msgType)).collect(Collectors.toList());
   										
   										interfaceMap.computeIfAbsent(msgType, k -> new ArrayList<>()).addAll(interfaceListByType);
   									}
   									
									int interfaceMainCount = 0;
								    for (Map.Entry<String, List<IGILogicalInterfaces>> entry : interfaceMap.entrySet()) {
								        String msgType = entry.getKey();
								        List<IGILogicalInterfaces> interfaceList = entry.getValue();
   										
								        String buttonId = msgType.replace(" ", "").toLowerCase() + "InterfaceBtn";
								        String listId = msgType.replace(" ", "").toLowerCase() + "InterfaceList";
								%>
								    <!-- Interface List Section -->
								    <div class="row">
								        <div class="col-md-12">
								            <button type="button" class="btn btn-outline-secondary fw-bold customeSidebarBtn left" 
								                id="<%=buttonId%>" value="1" style="padding: 0.2rem;" 
								                data-toggle="tooltip" data-placement="top" title="<%=msgType%> Interfaces">
								                <span style="font-weight: bold;"><%=(++interfaceMainCount) + ". " + msgType%></span>
								                <% if (interfaceList.size() > 0) { %>
								                &nbsp; <i class="fa fa-caret-up"></i>
								                <% } %>
								            </button>
								        </div>
								    </div>
								
								    <div id="<%=listId%>">
								        <% 
								        int interfaceSubCount = 0;
								        for (IGILogicalInterfaces iface : interfaceList) { %>
								        <div class="row">
								            <div class="col-md-12 ml-4">
								                <form action="IGILogicalInterfacesList.htm" method="GET">
								                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								                    <input type="hidden" name="igiDocId" value="<%=igiDocId%>" />
								                    <button type="submit" class="btn btn-sm btn-outline-primary fw-bold customeSidebarBtn left"
								                        name="logicalInterfaceId" value="<%=iface.getLogicalInterfaceId()%>" 
								                        data-toggle="tooltip" data-placement="top" title="<%=iface.getMsgCode()%>" 
								                        <% if (iface.getLogicalInterfaceId().equals(Long.parseLong(logicalInterfaceId))) { %>
								                        style="background-color: green; color: white; border-color: green; width: 86%;" 
								                        <% } else { %> style="width: 86%;" <% } %>>
								                        <%=(interfaceMainCount) + "." + (++interfaceSubCount) + ". " + iface.getMsgCode()%>
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
       							<h4 class="text-dark">Interface Details <%if(logicalInterface!=null) {%>- <%=logicalInterface.getMsgName() %><%} %> </h4>
       						</div>
       						<div class="card-body m-2">
       							<form action="IGILogicalInterfaceDetailsSubmit.htm" method="post" id="myform">
       								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
       								<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
       								<input type="hidden" name="logicalInterfaceId" id="logicalInterfaceId" value="<%=logicalInterfaceId%>">
	       							
	       							<div class="form-group">
			       						<div class="row">
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Message Type <span class="mandatory">*</span></label>
		       									<select class="form-control" id="msgType" name="msgType" required>
		       										<option value="" selected disabled>----select----</option>
		       										<%for(String msgType : msgTypesList) {%>
		       											<option value="<%=msgType %>" <%if(logicalInterface!=null && logicalInterface.getMsgType()!=null && logicalInterface.getMsgType().equalsIgnoreCase(msgType)) {%>selected<%} %>><%=msgType %></option>
		       										<%} %>
		       									</select>
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Message Name <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="msgName" <%if(logicalInterface!=null && logicalInterface.getMsgName()!=null) {%>value="<%=logicalInterface.getMsgName() %>"<%} %> placeholder="Enter Message Name" maxlength="255" required>
		       								</div>
		       								<div class="col-md-2">
		       									<label class="form-lable">Message Title <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="msgTitle" <%if(logicalInterface!=null && logicalInterface.getMsgTitle()!=null) {%>value="<%=logicalInterface.getMsgTitle() %>"<%} %> placeholder="Enter Message Title" maxlength="255" required>
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Data Rate </label>
		       									<input type="text" class="form-control" name="dataRate" <%if(logicalInterface!=null && logicalInterface.getDataRate()!=null) {%>value="<%=logicalInterface.getDataRate() %>"<%} %> placeholder="Enter Data Rate" maxlength="255">
		       								</div>
	                  				 	</div>
                  				 	</div>
                  				 	
	       							<div class="form-group">
			       						<div class="row">
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Description </label>
		       									<textarea class="form-control" name="msgDescription" rows="2" placeholder="Enter Msg Description" maxlength="255" ><%if(logicalInterface!=null && logicalInterface.getMsgDescription()!=null) {%><%=logicalInterface.getMsgDescription() %><%} %></textarea>
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Protocols </label>
		       									<textarea class="form-control" name="protocols" rows="2" placeholder="Enter Underlying Protocols" maxlength="255"><%if(logicalInterface!=null && logicalInterface.getProtocals()!=null) {%><%=logicalInterface.getProtocals() %><%} %></textarea>
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Additional Info </label>
		       									<textarea class="form-control" name="additionalInfo" rows="2" placeholder="Enter Additional Info" maxlength="255"><%if(logicalInterface!=null && logicalInterface.getAdditionalInfo()!=null) {%><%=logicalInterface.getAdditionalInfo() %><%} %></textarea>
		       								</div>
	                  				 	</div>
                  				 	</div>
                  				 	
	       							<div class="form-group">
	       								<div class="center">
	       									<%if(logicalInterface!=null){ %>
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
		<%for(String msgType : msgTypesList) {%>
			toggleInterface('<%=msgType.toLowerCase() %>InterfaceBtn', '<%=msgType.toLowerCase() %>InterfaceList');
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

		// Set the values to the form when submitting.
		$('#myform').submit(function() {

			 var data1 = $('#diagramEditor').summernote('code');
			 $('textarea[name=interfaceDiagram]').val(data1);
			 
			 var data2 = $('#descriptionEditor').summernote('code');
			 $('textarea[name=interfaceDescription]').val(data2);
			
		});
		

	   
	    
	</script>

</body>
</html>