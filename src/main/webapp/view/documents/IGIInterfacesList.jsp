
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

body { 
   font-family : "Lato", Arial, sans-serif !important;
   overflow-x: hidden;
}

input,select,table,div,label,span {
	font-family : "Lato", Arial, sans-serif !important;
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
	min-height: 670px;
    max-height: 670px;
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
 						<h3 class="text-dark" style="font-weight: bold;">Interfaces</h3>
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
    							
   								<%if(igiInterfaceList!=null && igiInterfaceList.size()>0) {
   									List<IGIInterface> physicalInterfaceList = igiInterfaceList.stream().filter(e -> e.getInterfaceType()!=null && e.getInterfaceType().equalsIgnoreCase("Physical Interface")).collect(Collectors.toList());
   									List<IGIInterface> electricalInterfaceList = igiInterfaceList.stream().filter(e -> e.getInterfaceType()!=null && e.getInterfaceType().equalsIgnoreCase("Electrical Interface")).collect(Collectors.toList()); %>
   									
   									<!-- Physical Interfaces List -->
   									<div class="row">
	   									<div class="col-md-12">
	  										<button type="button" class="btn btn-outline-secondary fw-bold customeSidebarBtn" id="physicalInterfaceBtn" value="1" style="padding: 0.2rem;" data-toggle="tooltip" data-placement="top" title="Physical Interfaces">
												<span style="font-weight: bold;">Physical Interfaces</span>
												<%if(physicalInterfaceList.size()>0) {%>
												&nbsp; <i class="fa fa-caret-up"></i>
												<%} %>
											</button>
	  									</div>
	  								</div>	
	  								
	  								<div id="physicalInterfaceList">
	   									<%for(IGIInterface physicalInterface : physicalInterfaceList) {%>
		   									<div class="row">
		   										<div class="col-md-12 ml-4">
		   											<form action="IGIInterfacesList.htm" method="GET">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
														<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
			     										<button class="btn btn-sm btn-outline-primary fw-bold customeSidebarBtn" type="submit" name="interfaceId" value="<%=physicalInterface.getInterfaceId()%>"  
			     										data-toggle="tooltip" data-placement="top" title="<%=physicalInterface.getInterfaceCode() %>" 
			     										<%if(physicalInterface.getInterfaceId().equals(Long.parseLong(interfaceId))) {%> style="background-color: green;color: white;border-color: green;width: 86%;" <%} else{%>style="width: 86%;" <%} %> >
			     											<%=physicalInterface.getInterfaceCode() %>
			     										</button>
			     									</form>
		   										</div>
		   									</div>
		   								<%} %>	
	   								</div>
	   								
	   								<!-- Electrical Interfaces List -->
	   								<div class="row">
	   									<div class="col-md-12">
	  										<button type="button" class="btn btn-outline-secondary fw-bold customeSidebarBtn" id="electricalInterfaceBtn" value="1" style="padding: 0.2rem;" data-toggle="tooltip" data-placement="top" title="Electrical Interfaces">
												<span style="font-weight: bold;">Electrical Interfaces</span>
												<%if(electricalInterfaceList.size()>0) {%>
												&nbsp; <i class="fa fa-caret-up"></i>
												<%} %>
											</button>
	  									</div>
	  								</div>	
	  								
	  								<div id="electricalInterfaceList">
	   									<%for(IGIInterface electricalInterface : electricalInterfaceList) {%>
		   									<div class="row">
		   										<div class="col-md-12 ml-4">
		   											<form action="IGIInterfacesList.htm" method="GET">
														<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
														<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
			     										<button class="btn btn-sm btn-outline-primary fw-bold customeSidebarBtn" type="submit" name="interfaceId" value="<%=electricalInterface.getInterfaceId()%>" 
			     										data-toggle="tooltip" data-placement="top" title="<%=electricalInterface.getInterfaceCode() %>" 
			     										<%if(electricalInterface.getInterfaceId().equals(Long.parseLong(interfaceId))) {%> style="background-color: green;color: white;border-color: green;width: 86%;" <%} else{%>style="width: 86%;" <%} %> >
			     											<%=electricalInterface.getInterfaceCode() %>
			     										</button>
			     									</form>
		   										</div>
		   									</div>
		   								<%} %>
		   							</div>		
	   							<%} else{%>
   									<div class="row">
   										<div class="col-md-12">
   											<button type="button" class="btn btn-outline-secondary fw-bold customeSidebarBtn" style="padding: 0.2rem;" data-toggle="tooltip" data-placement="top" title="No Interfaces">
												<span style="font-weight: bold;">No Interfaces</span>
											</button>
   										</div>
   									</div>
	   							<%} %>
   								
   							</div>
       					</div>
       				</div>
       				<div style="width: 88%;">
       					<div class="card ml-3 mr-3">
       						<div class="card-header">
       							<h4 class="text-dark">Interface Details <%if(igiInterface!=null) {%>- <%=igiInterface.getInterfaceCode() %><%} %> </h4>
       						</div>
       						<div class="card-body m-2">
       							<form action="IGIInterfaceDetailsSubmit.htm" method="post" id="myform">
       								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
       								<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
       								<input type="hidden" name="interfaceId" id="interfaceId" value="<%=interfaceId%>">
	       							<div class="form-group">
		       							<div class="row">
		       								<div class="col-md-2">
		       									<label class="form-lable">Interface ID <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="interfaceCode" <%if(igiInterface!=null && igiInterface.getInterfaceCode()!=null) {%> value="<%=igiInterface.getInterfaceCode() %>" <%} %> placeholder="Enter Unique Id" onchange="checkDuplicateInterfaceCode(this)" required maxlength="10">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Interface Name <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="interfaceName" <%if(igiInterface!=null && igiInterface.getInterfaceName()!=null) {%> value="<%=igiInterface.getInterfaceName() %>" <%} %> placeholder="Enter Interface Name" required maxlength="500">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Type of Data <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="dataType" <%if(igiInterface!=null && igiInterface.getDataType()!=null) {%> value="<%=igiInterface.getDataType() %>" <%} %> placeholder="e.g., analog, digital, video, audio" required maxlength="255">
		       								</div>
		       								<div class="col-md-2">
		       									<label class="form-lable">Type of Signal <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="signalType" <%if(igiInterface!=null && igiInterface.getSignalType()!=null) {%> value="<%=igiInterface.getSignalType() %>" <%} %> placeholder="e.g., RF, optical, electrical" required maxlength="255">
		       								</div>
		       								<div class="col-md-2">
		       									<label class="form-lable">Interface Type <span class="mandatory">*</span></label>
		       									<select class="form-control" name="interfaceType" required>
		       										<option value="" selected disabled>----select----</option>
		       										<option value="Physical Interface" <%if(igiInterface!=null && igiInterface.getInterfaceType()!=null && igiInterface.getInterfaceType().equalsIgnoreCase("Physical Interface")) {%>selected<%} %>>Physical Interface</option>
		       										<option value="Electrical Interface" <%if(igiInterface!=null && igiInterface.getInterfaceType()!=null && igiInterface.getInterfaceType().equalsIgnoreCase("Electrical Interface")) {%>selected<%} %>>Electrical Interface</option>
		       									</select>
		       								</div>
		       							</div>
		       						</div>
		       						
		       						<div class="form-group">
		       							<div class="row">
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
		       								<div class="col-md-3">
		       									<label class="form-lable">Connector <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="connector" <%if(igiInterface!=null && igiInterface.getConnector()!=null) {%> value="<%=igiInterface.getConnector() %>" <%} %> placeholder="Enter Connector Details" required maxlength="255">
		       								</div>
		       								<div class="col-md-3">
		       									<label class="form-lable">Protection <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="protection" <%if(igiInterface!=null && igiInterface.getProtection()!=null) {%> value="<%=igiInterface.getProtection() %>" <%} %> placeholder="Enter Protection Details" required maxlength="255">
		       								</div>
		       							</div>
		       						</div>
		       						
		       						<div class="form-group">
		       							<div class="row">
		       								<div class="col-md-6">
		       									<label class="form-lable">Diagram <span class="mandatory">*</span></label>
		       									<div id="diagramEditor" class="center"></div>
												<textarea name="interfaceDiagram" style="display: none;"></textarea>
		       								</div>
		       								<div class="col-md-6">
		       									<label class="form-lable">Description <span class="mandatory">*</span></label>
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
	
		$('#physicalInterfaceBtn').on('click', function(){
			var physicalInterfaceVal = $(this).val();
			var htmlContent = $(this).html();

			if(physicalInterfaceVal=='1') {
				$('#physicalInterfaceBtn').val('0');
				$('#physicalInterfaceList').hide();
				// Change the icon to fa-caret-down
		        $(this).find('i').removeClass('fa-caret-up').addClass('fa-caret-down');
			}else{
				$('#physicalInterfaceBtn').val('1');
				$('#physicalInterfaceList').show();
				 // Change the icon to fa-caret-up
		        $(this).find('i').removeClass('fa-caret-down').addClass('fa-caret-up');
			}
			
		});
	
		$('#electricalInterfaceBtn').on('click', function(){
			var electricalInterfaceVal = $(this).val();
			var htmlContent = $(this).html();

			if(electricalInterfaceVal=='1') {
				$('#electricalInterfaceBtn').val('0');
				$('#electricalInterfaceList').hide();
				// Change the icon to fa-caret-down
		        $(this).find('i').removeClass('fa-caret-up').addClass('fa-caret-down');
			}else{
				$('#electricalInterfaceBtn').val('1');
				$('#electricalInterfaceList').show();
				 // Change the icon to fa-caret-up
		        $(this).find('i').removeClass('fa-caret-down').addClass('fa-caret-up');
			}
			
		});
	
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

		// Check Duplicate
		function checkDuplicateInterfaceCode(field) {
			var interfaceCode = $(field).val();
			var interfaceId = $('#interfaceId').val();
			console.log(interfaceCode);
			
			$.ajax({
				type : "GET",
				url : "DuplicateInterfaceCodeCheck.htm",	
				datatype : 'json',
				data : {
					interfaceCode : interfaceCode,				
					interfaceId : interfaceId,				
				},
				success : function(result) {
					var ajaxresult = JSON.parse(result);
					
					if(ajaxresult>0){
						alert('Interface Id Already Exists');
						$(field).val('');
						event.preventDefault();
						return false;
					}
					
				}
			});
		}
		
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