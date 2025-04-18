
<%@page import="com.vts.pfms.documents.model.IGILogicalChannel"%>
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
		List<IGILogicalChannel> logicalChannelList = (List<IGILogicalChannel>)request.getAttribute("logicalChannelList");
		IGILogicalInterfaces logicalInterface = (IGILogicalInterfaces)request.getAttribute("igiLogicalInterfaceData");
		String logicalInterfaceId = (String)request.getAttribute("logicalInterfaceId");
		String logicalChannelId = (String)request.getAttribute("logicalChannelId");
		if(logicalChannelId==null) {
			logicalChannelId = "0";
		}
		String igiDocId = (String)request.getAttribute("igiDocId");
		List<String> msgTypesList = Arrays.asList("Information", "Request", "Answer", "Command", "Acknowledement");
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
       				<div style="width: 15%;">
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
								    Map<String, List<IGILogicalInterfaces>> logicalInterfaceMap = new LinkedHashMap<>();
	   								
   									for(IGILogicalChannel channel : logicalChannelList) {
   										
   										List<IGILogicalInterfaces> interfaceListByType = logicalInterfaceList.stream().filter(e -> e.getLogicalChannelId().equals(channel.getLogicalChannelId())).collect(Collectors.toList());
   										
   										logicalInterfaceMap.computeIfAbsent(channel.getLogicalChannelId() +"/"+ channel.getChannelCode(), k -> new ArrayList<>()).addAll(interfaceListByType);
   									}
									
   									
									int interfaceMainCount = 0;
								    for (Map.Entry<String, List<IGILogicalInterfaces>> entry : logicalInterfaceMap.entrySet()) {
								        String key = entry.getKey();
								        String[] channelkey = key.split("/");
								        String channelId = channelkey[0];
								        String channelCode = channelkey[1];
								        List<IGILogicalInterfaces> interfaceList = entry.getValue();
   										
								        String buttonId = channelCode.replace(" ", "").toLowerCase() + "InterfaceBtn";
								        String listId = channelCode.replace(" ", "").toLowerCase() + "InterfaceList";
								        
								        IGILogicalChannel channel = logicalChannelList.stream().filter(e-> e.getLogicalChannelId()==Long.parseLong(channelId)).findFirst().orElse(null);
								%>
								    <!-- Interface List Section -->
								    <div class="row">
								        <div class="col-md-12">
								            <button type="button" class="btn btn-outline-secondary fw-bold customeSidebarBtn left" 
								                id="<%=buttonId%>" value="1" style="padding: 0.2rem;" 
								                data-toggle="tooltip" data-placement="top" title="<%=channelCode%> Interfaces">
								                <span style="font-weight: bold;"><%=(++interfaceMainCount) + ". " + channelCode%></span>
								                <span style="float: right;margin-right: 0.5rem;">
								                	<i class="fa fa-pencil-square-o" aria-hidden="true" onclick="openChannelEditModal('<%=channelId%>')"></i>
								                	&nbsp;&nbsp;<i class="fa fa-trash" aria-hidden="true" onclick="deleteChannel('<%=channelId%>')"></i>
									                <% if (interfaceList.size() > 0) { %>
									                &nbsp;&nbsp; <i id="facaret" class="fa fa-caret-up"></i>
									                <% } %>
								                </span>
								            </button>
								            <input type="hidden" id="logicalChannel<%=channelId %>" value="<%=channel.getLogicalChannel()%>">
								            <input type="hidden" id="channelCode<%=channelId %>" value="<%=channel.getChannelCode()%>">
								            <input type="hidden" id="description<%=channelId %>" value="<%=channel.getDescription()%>">
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
       				<div style="width: 85%;">
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
			       							<div class="col-md-3">
		       									<label class="form-lable">Logical Channel Name<span class="mandatory">*</span></label>
		       									<select class="form-control selectdee" id="logicalChannelId" name="logicalChannelId" required>
		       										<option value="" selected disabled>----select----</option>
		       										<option value="addNew" style="background-color: purple !important;">Add New</option>
		       										<%for(IGILogicalChannel channel : logicalChannelList) {%>
		       											<option value="<%=channel.getLogicalChannelId()+"/"+channel.getChannelCode() %>" 
		       											<%if(logicalInterface!=null && logicalInterface.getLogicalChannelId()!=null && logicalInterface.getLogicalChannelId().equals(channel.getLogicalChannelId()) ||
		       													Long.parseLong(logicalChannelId)==channel.getLogicalChannelId()) {%>selected<%} %>>
		       												<%=channel.getLogicalChannel()+" ("+channel.getChannelCode()+")" %>
		       											</option>
		       										<%} %>
		       									</select>
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Message Type <span class="mandatory">*</span></label>
		       									<select class="form-control" id="msgType" name="msgType" required>
		       										<option value="" selected disabled>----select----</option>
		       										<%for(String msgType : msgTypesList) {%>
		       											<option value="<%=msgType %>" <%if(logicalInterface!=null && logicalInterface.getMsgType()!=null && logicalInterface.getMsgType().equalsIgnoreCase(msgType)) {%>selected<%} %>><%=msgType %></option>
		       										<%} %>
		       									</select>
		       								</div>
			                    		    <div class="col-md-3">
		       									<label class="form-lable">Message Name <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="msgName" <%if(logicalInterface!=null && logicalInterface.getMsgName()!=null) {%>value="<%=logicalInterface.getMsgName() %>"<%} %> placeholder="Enter Message Name" maxlength="255" required>
		       								</div>
		       								
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Data Rate </label>
		       									<input type="text" class="form-control" name="dataRate" <%if(logicalInterface!=null && logicalInterface.getDataRate()!=null) {%>value="<%=logicalInterface.getDataRate() %>"<%} %> placeholder="Enter Data Rate" maxlength="255">
		       								</div>
	                  				 	</div>
                  				 	</div>
                  				 	
	       							<div class="form-group">
			       						<div class="row">
			                    		    <div class="col-md-3">
		       									<label class="form-lable">Description </label>
		       									<textarea class="form-control" name="msgDescription" rows="2" placeholder="Enter Msg Description" maxlength="255" ><%if(logicalInterface!=null && logicalInterface.getMsgDescription()!=null) {%><%=logicalInterface.getMsgDescription() %><%} %></textarea>
		       								</div>
			                    		    <div class="col-md-3">
		       									<label class="form-lable">Protocols </label>
		       									<textarea class="form-control" name="protocols" rows="2" placeholder="Enter Underlying Protocols" maxlength="255"><%if(logicalInterface!=null && logicalInterface.getProtocals()!=null) {%><%=logicalInterface.getProtocals() %><%} %></textarea>
		       								</div>
			                    		    <div class="col-md-3">
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
	
	
	<!-- ----------------------------------------------- Add New Logical Channel Modal --------------------------------------------------------------- -->
	<div class="modal fade bd-example-modal-lg center" id="addNewChannelsModal" tabindex="-1" role="dialog" aria-labelledby="addNewChannelsModal" aria-hidden="true" style="margin-top: 10%;">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content" style="width: 90%;margin-left: 10%;">
				<div class="modal-header" style="background: #055C9D;color: white;">
		        	<h5 class="modal-title ">Add New Channel</h5>
			        <button type="button" class="close" style="text-shadow: none !important" data-dismiss="modal" aria-label="Close">
			          <span class="text-light" aria-hidden="true">&times;</span>
			        </button>
		      	</div>
     			<div class="modal-body">
     				<div class="container-fluid mt-3">
     					<div class="row">
							<div class="col-md-12 " align="left">
								<form action="IGILogicalChannelDetailsSubmit.htm" method="POST" id="myform">
									<div class="form-group">
			       						<div class="row">
			                    		    <div class="col-md-7">
		       									<label class="form-lable">Logical Channel <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="logicalChannel" id="logicalChannel" placeholder="Enter Channel Name" maxlength="255" required>
		       								</div>
			                    		    <div class="col-md-5">
		       									<label class="form-lable">Channel Code <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="channelCode" id="channelCode" placeholder="Enter Channel Code" maxlength="5" required>
		       								</div>
	                  				 	</div>
                  				 	</div>
									<div class="form-group">
			       						<div class="row">
			                    		    <div class="col-md-12">
		       									<label class="form-lable">Description <span class="mandatory">*</span></label>
		       									<textarea class="form-control" name="description" id="description" rows="2" placeholder="Enter Channel Description" maxlength="1000" required></textarea>
		       								</div>
	                  				 	</div>
                  				 	</div>
									
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
       								<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
       								<input type="hidden" name="logicalInterfaceId" value="<%=logicalInterfaceId%>">
       								<input type="hidden" name="logicalChannelId" id="logicalChannelIdModal" value="0">
									
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
	
	<form action="IGILogicalChannelDelete.htm" method="post" style="display: none;">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="igiDocId" value="<%=igiDocId%>">
		<input type="hidden" name="logicalInterfaceId" value="<%=logicalInterfaceId%>">
		<input type="hidden" name="logicalChannelId" id="logicalChannelIdDelete">
		<button type="submit" id="logicalChannelDeleteBtn" formmethod="post" formnovalidate="formnovalidate" onclick="return confirm('Are you sure you want to Delete?\nDeleting a main level will also remove all its sub-levels.')" style="display:none;"></button>

	</form>			
	<!-- ----------------------------------------------- Add New Logical Channel Modal End-------------------------------------------------------- -->
	
	<script type="text/javascript">
		
		function toggleInterface(buttonId, listId) {
		    $('#'+buttonId).on('click', function () {
		        const currentValue = $(this).val();
		        $(this).val(currentValue === '1' ? '0' : '1');
		        $('#'+listId).toggle();
		        $(this).find('#facaret').toggleClass('fa-caret-up fa-caret-down');
		    });
		}
	
		// Initialize toggles
		<%for (Map.Entry<String, List<IGILogicalInterfaces>> entry : logicalInterfaceMap.entrySet()) {
			String key = entry.getKey();
	        String[] channelkey = key.split("/");
	        String channelCode = channelkey[1];
	        String buttonId = channelCode.replace(" ", "").toLowerCase() + "InterfaceBtn";
	        String listId = channelCode.replace(" ", "").toLowerCase() + "InterfaceList";
	        
	      %>
			toggleInterface('<%=buttonId %>', '<%=listId %>');
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
		
		$('#logicalChannelId').on('change', function(){
			var logicalChannelId = $(this).val();
			if(logicalChannelId=='addNew') {
				$('#logicalChannel').val('');
				$('#channelCode').val('');
				$('#description').val('');
				$('#logicalChannelIdModal').val('0');
				$('#addNewChannelsModal').modal('show');
			}
		});
		
		function openChannelEditModal(channelId) {
			$('#logicalChannel').val($('#logicalChannel'+channelId).val());
			$('#channelCode').val($('#channelCode'+channelId).val());
			$('#description').val($('#description'+channelId).val());
			$('#logicalChannelIdModal').val(channelId);
			$('#addNewChannelsModal').modal('show');
		}
		
		function deleteChannel(channelId) {
			$('#logicalChannelIdDelete').val(channelId);
			$('#logicalChannelDeleteBtn').click();
		}
	</script>

</body>
</html>