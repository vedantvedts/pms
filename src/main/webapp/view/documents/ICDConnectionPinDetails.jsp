<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Stream"%>
<%@page import="com.vts.pfms.documents.model.IGIConnector"%>
<%@page import="com.vts.pfms.documents.dto.ICDPinMapDTO"%>
<%@page import="com.vts.pfms.documents.model.ICDConnectorPinMapping"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.documents.model.IGIInterface"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.dto.ICDConnectionDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.documents.model.ICDDocumentConnections"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">
.left {
	text-align: left;
}
.center {
	text-align: center;
}
.right {
	text-align: right;
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
	min-height: 450px;
    max-height: 450px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: auto; /* Enable vertical scrolling */
}

.table-wrapper-2 {
	min-height: 600px;
    max-height: 650px; /* Set the max height for the table wrapper */
    overflow-y: hidden; /* Enable vertical scrolling */
    overflow-x: hidden; /* Enable vertical scrolling */
}

.select2-container {
	width: 100% !important;
}

.form-label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}
.fw-bold {
	font-weight: bold;
}
</style>
</head>
<body>
	<%
		String docId = (String)request.getAttribute("docId");
		String docType = (String)request.getAttribute("docType");
		String documentNo = (String)request.getAttribute("documentNo");
		String projectId = (String)request.getAttribute("projectId");
		String icdConnectionId = (String)request.getAttribute("icdConnectionId");
		String tab = (String)request.getAttribute("tab");
		String icdConnectorIdE1 = (String)request.getAttribute("icdConnectorIdE1");
		String icdConnectorIdE2 = (String)request.getAttribute("icdConnectorIdE2");
		String connectorPinMapId = (String)request.getAttribute("connectorPinMapId");
		List<Object[]> productTreeAllList = (List<Object[]>)request.getAttribute("productTreeAllList"); 
		ICDDocumentConnections connection = (ICDDocumentConnections)request.getAttribute("icdDocumentConnections");
		
		List<ICDConnectionDTO> icdConnectionsList = (List<ICDConnectionDTO>)request.getAttribute("icdConnectionsList"); 
		ICDConnectionDTO condto = icdConnectionsList.stream().filter(e -> e.getICDConnectionId()==Long.parseLong(icdConnectionId)).findFirst().orElse(null);
		List<Long> s1List = Arrays.stream(condto.getSubSystemIdsS1().split(",")).map(Long::parseLong).collect(Collectors.toList());
		List<Long> s2List = Arrays.stream(condto.getSubSystemIdsS2().split(",")).map(Long::parseLong).collect(Collectors.toList());
		List<Long> ifaceList = Arrays.stream(condto.getInterfaceIds().split(",")).map(Long::parseLong).collect(Collectors.toList());
		
		List<IGIInterface> igiInterfaceList = (List<IGIInterface>)request.getAttribute("igiInterfaceList"); 
		igiInterfaceList = igiInterfaceList.stream().filter(e -> ifaceList.contains(e.getInterfaceId())).collect(Collectors.toList());
		List<Long> connectorIds = igiInterfaceList.stream().flatMap(e -> Stream.of(e.getConnectorIdEOne(), e.getConnectorIdETwo())).collect(Collectors.toList());
		
		List<Object[]> productTreeS1List = productTreeAllList.stream().filter(e -> s1List.contains(Long.parseLong(e[0].toString()))).collect(Collectors.toList());
		List<Object[]> productTreeS2List = productTreeAllList.stream().filter(e -> s2List.contains(Long.parseLong(e[0].toString()))).collect(Collectors.toList());
		
		List<Object[]> icdConnectorList = (List<Object[]>)request.getAttribute("icdConnectorList"); 
		List<Object[]> icdConnectorListE1 = icdConnectorList.stream().filter(e -> e[3].toString().equalsIgnoreCase("A")).collect(Collectors.toList());
		List<Object[]> icdConnectorListE2 = icdConnectorList.stream().filter(e -> e[3].toString().equalsIgnoreCase("B")).collect(Collectors.toList());

		List<Object[]> icdConnectorPinList = (List<Object[]>)request.getAttribute("icdConnectorPinList"); 
		List<ICDPinMapDTO> icdConnectorPinMapList = (List<ICDPinMapDTO>)request.getAttribute("icdConnectorPinMapList"); 
		
		List<Object[]> pinListE1 = (List<Object[]>)request.getAttribute("pinListE1"); 
		List<Object[]> pinListE2 = (List<Object[]>)request.getAttribute("pinListE2"); 

		Object[] e1Data = pinListE1!=null && pinListE1.size()>0?pinListE1.get(0):null;
		Object[] e2Data = pinListE2!=null && pinListE2.size()>0?pinListE2.get(0):null;
		
		ICDConnectorPinMapping mapping = (ICDConnectorPinMapping)request.getAttribute("icdConnectorPinMapping");

		List<IGIConnector> connectorMasterList = (List<IGIConnector>)request.getAttribute("connectorMasterList"); 
		connectorMasterList = connectorMasterList.stream().filter(e -> connectorIds.contains(e.getConnectorId())).collect(Collectors.toList());;
		int tabNo = Integer.parseInt(tab);
		
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
    
    <div class="container-fluid">
    	<div class="card shadow-nohover" style="margin-top: -0.6pc">
        	<div class="card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
            	<div class="row">
               		<div class="col-md-5" class="left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                      Pin Details - <%=documentNo!=null?StringEscapeUtils.escapeHtml4(documentNo): " - " %>
	                    </h5>
                	</div>
                	
                	<div class="col-md-1 right">
                	</div>
                	
                	<div class="col-md-2" style="margin-top: -0.5rem;">
                		
                	</div>
                	
                	<div class="col-md-2">
                	</div>
                    <div class="col-md-2 right">
	                    <form action="#" id="inlineapprform">
					        <button type="submit" class="btn btn-info btn-sm shadow-nohover back" formaction="ICDConnectionList.htm" data-toggle="tooltip" title="Back">
					        	BACK
					        </button>
					        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					        <input type="hidden" name="docId" value="<%=docId%>"> 
							<input type="hidden" name="docType" value="<%=docType%>"> 
							<input type="hidden" name="documentNo" value="<%=documentNo%>">
							<input type="hidden" name="projectId" value="<%=projectId%>">
							<input type="hidden" name="icdDocId" value="<%=docId%>">
					    </form>
                    </div>
            	</div>
        	</div>
        	
        	<div class="row" style="margin: 0.5rem;">
				<div class="col-12">
	        		<ul class="nav nav-pills" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  				<li class="nav-item" style="width: 33%;"  >
		    				<div class="nav-link center <%if(tabNo==1) {%>active<%} %>" id="pills-tab-1" data-toggle="pill" data-target="#tab-1" role="tab" aria-controls="tab-1" aria-selected="<%if(tabNo==1) {%>true<%} else{%>false<%}%>">
			   					<span>End-1</span> 
		    				</div>
		  				</li>
		  				<li class="nav-item"  style="width: 33%;">
		    				<div class="nav-link center <%if(tabNo==2) {%>active<%} %>" id="pills-tab-2" data-toggle="pill" data-target="#tab-2" role="tab" aria-controls="tab-2" aria-selected="<%if(tabNo==2) {%>true<%} else{%>false<%}%>">
		    	 				<span>End-2</span> 
		    				</div>
		  				</li>
		  				<li class="nav-item"  style="width: 34%;">
		    				<div class="nav-link center <%if(tabNo==3) {%>active<%} %>" id="pills-tab-3" data-toggle="pill" data-target="#tab-3" role="tab" aria-controls="tab-3" aria-selected="<%if(tabNo==3) {%>true<%} else{%>false<%}%>">
		    	 				<span>Pin Mapping</span> 
		    				</div>
		  				</li>
					</ul>
	   			</div>
			</div>
			
        	<div class="tab-content" id="pills-tabContent">
        	
				<!-- Tab-1  -->
	       		<div class="tab-pane fade <%if(tabNo==1) {%>show active<%} %>" id="tab-1" role="tabpanel" aria-labelledby="pills-tab-1">
		        	<div class="card-body">
		        	
       					<div class="row">
       						<div class="ml-2 mr-2" style="width: 36%;">
       							<div class="table-responsive" >
		      						<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable1" >
										<thead class="center" style="background: #055C9D;color: white;">
								      		<tr>
								     	 		<th width="10%">SN</th>
								      			<th width="28%">Connector No</th>
								      			<th width="40%">Source</th>
								      			<th width="20%">Action</th>
								      		</tr>
								      	</thead>
				      
				      					<tbody>
				      						<%if(icdConnectorListE1!=null && icdConnectorListE1.size()>0) {
				      							int slno=0;
				    							for(Object[] obj : icdConnectorListE1){
				      						%>
												<tr>
										      		<td class="center"><%=++slno %></td>
										      		<td class="center">J<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
										      		<td class="center"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %> (<%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %>)</td>
										      		<td class="center">
										      			 <form action="#" method="POST" id="inlinee1form<%=slno%>">
													        <button type="submit" class="editable-clicko" formaction="ICDConnectionPinDetails.htm" formmethod="post" data-toggle="tooltip" title="Edit">
													            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
													        </button>
													        <button type="submit" class="editable-clicko" formaction="ICDConnectionConnectorDelete.htm" formmethod="post" data-toggle="tooltip" title="Delete"
													        onclick="return confirm('Are you sure to Delete?')">
													            <i class="fa fa-lg fa-trash" style="padding: 0px;color: red;font-size: 25px;" aria-hidden="true"></i>
													        </button>
													        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
													        <input type="hidden" name="icdConnectorId" value="<%=obj[0] %>">
													        <input type="hidden" name="endNo" value="E1">
													        <input type="hidden" name="icdConnectorIdE1" value="<%=obj[0] %>">
													        <input type="hidden" name="icdConnectorIdE2" value="<%=icdConnectorIdE2 %>">
													        <input type="hidden" name="docId" value="<%=docId%>"> 
															<input type="hidden" name="docType" value="<%=docType%>"> 
															<input type="hidden" name="documentNo" value="<%=documentNo%>">
															<input type="hidden" name="projectId" value="<%=projectId%>">
															<input type="hidden" name="icdConnectionId" value="<%=icdConnectionId%>">
															<input type="hidden" name="tab" value="1">
													    </form>
										      		</td>
										      	</tr>
				      						<%} }%>
				      					</tbody>
				      				</table>
				      			</div>	
				      			
				      			<div class="center">
				      				<form action="#" method="post">
				      					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				      					<input type="hidden" name="docId" value="<%=docId%>"> 
										<input type="hidden" name="docType" value="<%=docType%>"> 
										<input type="hidden" name="documentNo" value="<%=documentNo%>">
										<input type="hidden" name="projectId" value="<%=projectId%>">
										<input type="hidden" name="irsDocId" value="<%=docId%>">
										<input type="hidden" name="tab" value="1">
										
				      					<button type="submit" class="btn btn-sm add" name="icdConnectionId" value="<%=icdConnectionId%>" formaction="ICDConnectionPinDetails.htm" data-toggle="tooltip" title="Add">
											ADD
								        </button>
				      				</form>
				      			</div>
		        			</div>
		        			
       						<div class="ml-2 mr-2" style="width: 0.1%; border-left: 1px solid #000;"></div>
       			
       						<div class="table-wrapper-2 ml-2 mr-2" style="width: 60%">
								<!-- <h4 class="mb-4 text-primary">Connector Pin Configuration</h4> -->
								<!-- <div id="connectors"></div>
								<button id="addConnectorBtn" type="button" class="btn btn-success mt-3" style="display: none;">+ Add Connector</button> -->
								
								
								<div>
									<div class="card table-wrapper-2 mb-3" style="">
										<div class="card-header text-white d-flex justify-content-between align-items-center" style="background-color: #055C9D;">
											<span class="connector-title">Connector Details</span>
											<!-- <button type="button" class="btn btn-sm btn-light remove-connector">Remove</button> -->
										</div>
										<div class="card-body">
											<form action="ICDConnectionPinDetailsSubmit.htm" method="post" id="myform_E1">
        										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        										<input type="hidden" name="docId" value="<%=docId%>"> 
												<input type="hidden" name="docType" value="<%=docType%>"> 
												<input type="hidden" name="documentNo" value="<%=documentNo%>">
												<input type="hidden" name="projectId" value="<%=projectId%>">
												<input type="hidden" name="icdConnectionId" value="<%=icdConnectionId%>">
												<input type="hidden" name="icdConnectorId" id="icdConnectorId_E1" value="<%=icdConnectorIdE1!=null?icdConnectorIdE1:"0"%>">
												<input type="hidden" name="systemType" id="systemType_E1" value="A">
												<input type="hidden" name="endNo" value="E1">
												<input type="hidden" name="tab" value="1">
												
												<div class="row">
													
													<div class="col-md-2">
														<label class="form-label">Connector No<span class="mandatory">*</span></label>
														<div class=" d-flex align-items-center">
														    <span class="fw-bold" style="margin-right: 4px;font-size: larger;">J</span>
															<input type="number" class="form-control connectorNo" name="connectorNo" id="connectorNo_E1" min="1" oninput="generatePinDetails('E1')"
															<%if(e1Data!=null && e1Data[2]!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(e1Data[2].toString())%>" readonly<%} %> required>
														</div>
													</div>
													<div class="col-md-4">
														<label class="form-label">Source<span class="mandatory">*</span></label>
														<select class="form-control selectdee subSystemId" name="subSystemId" id="subSystemId_E1" onchange="generatePinDetails('E1')" <%if(e1Data!=null) {%>disabled<%} %>
													    data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
														    <option value="" disabled selected>Choose...</option>
														    <% for(Object[] obj : productTreeS1List){ %>
														      <option value="<%=obj[0] %>"  <%if(e1Data!=null && e1Data[4]!=null && e1Data[4].toString().equalsIgnoreCase(obj[0].toString())) {%>selected<%} %>>
														        <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%> <%=" ("+(obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - ")+")" %>
														      </option>
														    <% } %>
														</select>
													</div>
													<div class="col-md-4">
														<label class="form-label">Connector<span class="mandatory">*</span></label>
					                    		    	<select class="form-control selectdee connectorId" name="connectorId" id="connectorId_E1" onchange="setPinCount('E1')" <%if(e1Data!=null) {%>disabled<%} %>
												    	data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
														<option value="" disabled selected>Choose...</option>
														    <%for(IGIConnector con : connectorMasterList){ %>
														    	<option value="<%=con.getConnectorId() %>"
														    	data-pincount="<%=con.getPinCount() %>"
														    	<%if(e1Data!=null && e1Data[15]!=null && con.getConnectorId() == Long.parseLong(e1Data[15].toString())) {%>selected<%} %>>
														      		<%=con.getPartNo()!=null?StringEscapeUtils.escapeHtml4(con.getPartNo()): " - " %> (<%=con.getConnectorMake()!=null?StringEscapeUtils.escapeHtml4(con.getConnectorMake()): " - " %>)
														    	</option>
														    <% }%>
														</select>
													</div>
													<div class="col-md-2">
														<label class="form-label">Pins<span class="mandatory">*</span></label>
														<input type="number" class="form-control pinCount" name="pinCount" id="pinCount_E1" min="1" oninput="generatePinDetails('E1')" 
														<%if(e1Data!=null && e1Data[22]!=null) { %>value="<%=e1Data[22]%>"<%} %> required readonly>
													</div>
												</div>
										      	<!-- <button type="button" class="btn btn-primary generate-pins mb-3">Generate Pins</button> -->
												<div class="table-responsive table-wrapper mt-3">
													<table class="table table-bordered table-sm pinstable customtable" id="pinsTable_E1" style="width: 100%;">
														<thead class=" center">
															<tr>
																<th width="7%">Pin No</th>
																<th width="26%">Interface<span class="mandatory">*</span></th>
																<th width="23%">Constraints</th>
																<th width="20%">Periodicity<span class="mandatory">*</span></th>
																<th width="23%">Description</th>
																<%if(e1Data!=null) {%>
																	<th>Action</th>
																<%} %>
															</tr>
														</thead>
														<tbody>
															<%if(pinListE1!=null && pinListE1.size()>0) {
																int slno = 0;
																for(Object[] obj : pinListE1) { 
																 ++slno;
																%>
																<tr>
																	<td class="center">
																		<span class="pinNoText_E1"><%=obj[8] %></span>
																		<input type="hidden" class="connectorPinId_E1" id="connectorPinId_E1_<%=slno %>" name="connectorPinId" value="<%=obj[7] %>">
																		<input type="hidden" class="pinNo_E1" id="pinNo_E1_<%=slno %>" name="pinNo" value="<%=obj[8] %>">
																	</td>
																	<td>
																		<select class="form-control form-control-sm selectdee" name="interfaceId" id="interfaceId_E1_<%=slno %>" required>
   			        														<option value="-1" <%if(-1==Long.parseLong(obj[9].toString())) {%>selected<%} %>>Not Connected</option>
   			        														<option value="0" <%if(0==Long.parseLong(obj[9].toString())) {%>selected<%} %>>Ground</option>
															    			<% for(IGIInterface iface : igiInterfaceList){ %>
															    				<option value="<%=iface.getInterfaceId() %>" <%if(iface.getInterfaceId()==Long.parseLong(obj[9].toString())) {%>selected<%} %> >
															    					<%=iface.getInterfaceName()!=null?StringEscapeUtils.escapeHtml4(iface.getInterfaceName()): " - "%>
															    			    </option>
															    			<% } %>
															    		</select>
																	</td>
																	<td>
																		<input type="text" class="form-control form-control-sm" name="constraints" id="constraints_E1_<%=slno %>" value="<%=obj[10] %>" >
																	</td>
																	<td>
																		<input type="radio" name="periodicity_E1_<%=slno %>" id="periodicity_E1_<%=slno %>" value="Periodic" <%if(obj[11]!=null && obj[11].toString().equalsIgnoreCase("Periodic")) {%>checked<%} %>  required />Periodic &nbsp;&nbsp;
											    					    <input type="radio" name="periodicity_E1_<%=slno %>" id="periodicity_E1_<%=slno %>" value="Non-Periodic" <%if(obj[11]!=null && obj[11].toString().equalsIgnoreCase("Non-Periodic")) {%>checked<%} %>  required />Non-Periodic
											    					    <input type="radio" name="periodicity_E1_<%=slno %>" id="periodicity_E1_<%=slno %>" value="Descrete" <%if(obj[11]!=null && obj[11].toString().equalsIgnoreCase("Descrete")) {%>checked<%} %>  required />Descrete</td>
																	<td>
																		<input type="text" class="form-control form-control-sm" name="description" id="description_E1_<%=slno %>" value="<%=obj[12] %>" >
																	</td>
																	<%if(e1Data!=null) {%>
																		<td class="center">
																			<button type="button" class="editable-clicko" name="action" value="Edit" formmethod="post" data-toggle="tooltip" title="Update" onclick="updatePinDetails('<%="E1_"+slno %>')">
																	            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
																	        </button>
																		</td>
																	<%} %>
																</tr>
															<%} }%>
														</tbody>
													</table>
												</div>
												
												<div class="center">
		        									<%if(e1Data!=null) {%>
														<!-- <button type="submit" class="btn btn-sm edit" name="action" value="Edit" onclick="return confirm('Are you sure to Update?')">UPDATE</button> -->
													<%} else {%>
														<button type="submit" class="btn btn-sm submit" name="action" value="Add" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
													<%} %>
												</div>
									
											</form>	
											
											<form action="ICDConnectionPinDetailsUpdate.htm" method="post" id="pindetupdateform">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        										<input type="hidden" name="docId" value="<%=docId%>"> 
												<input type="hidden" name="docType" value="<%=docType%>"> 
												<input type="hidden" name="documentNo" value="<%=documentNo%>">
												<input type="hidden" name="projectId" value="<%=projectId%>">
												<input type="hidden" name="icdConnectionId" value="<%=icdConnectionId%>">
												<input type="hidden" name="icdConnectorId" id="icdConnectorId_E1" value="<%=icdConnectorIdE1!=null?icdConnectorIdE1:"0"%>">
												<input type="hidden" name="systemType" id="systemType_E1" value="A">
												<input type="hidden" name="endNo" value="E1">
												<input type="hidden" name="tab" value="1">
												<input type="hidden" name="connectorPinId" id="connectorPinId">
												<input type="hidden" name="pinNo" id="pinNo">
												<input type="hidden" name="interfaceId" id="interfaceId">
												<input type="hidden" name="constraints" id="constraints">
												<input type="hidden" name="periodicity" id="periodicity">
												<input type="hidden" name="description" id="description">
											</form>
										</div>
									</div>
								</div>
							</div>
       					</div>

        			</div>
        		</div>	
        		
        		<!-- Tab-2  -->
        		<div class="tab-pane fade <%if(tabNo==2) {%>show active<%} %>" id="tab-2" role="tabpane2" aria-labelledby="pills-tab-2">
					<div class="card-body">
					
						<div class="row">
       						<div class="ml-2 mr-2" style="width: 36%;">
       							<div class="table-responsive " >
		      						<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable2" >
										<thead class="center" style="background: #055C9D;color: white;">
								      		<tr>
								     	 		<th width="10%">SN</th>
								      			<th width="28%">Connector No</th>
								      			<th width="40%">Source</th>
								      			<th width="20%">Action</th>
								      		</tr>
								      	</thead>
				      					<tbody>
				      						<%if(icdConnectorListE2!=null && icdConnectorListE2.size()>0) {
				      							int slno=0;
				    							for(Object[] obj : icdConnectorListE2){
				      						%>
												<tr>
										      		<td class="center"><%=++slno %></td>
										      		<td class="center">J<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
										      		<td class="center"><%=obj[5] !=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - "%> (<%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %>)</td>
										      		<td class="center">
										      			 <form action="#" method="POST" id="inlinee2form<%=slno%>">
													        <button type="submit" class="editable-clicko" formaction="ICDConnectionPinDetails.htm" formmethod="post" data-toggle="tooltip" title="Edit">
													            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
													        </button>
													        <button type="submit" class="editable-clicko" formaction="ICDConnectionConnectorDelete.htm" formmethod="post" data-toggle="tooltip" title="Delete"
													        onclick="return confirm('Are you sure to Delete?')">
													            <i class="fa fa-lg fa-trash" style="padding: 0px;color: red;font-size: 25px;" aria-hidden="true"></i>
													        </button>
													        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
													        <input type="hidden" name="icdConnectorId" value="<%=obj[0] %>">
													        <input type="hidden" name="endNo" value="E2">
													        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
													        <input type="hidden" name="icdConnectorIdE1" value="<%=icdConnectorIdE1 %>">
													        <input type="hidden" name="icdConnectorIdE2" value="<%=obj[0] %>">
													        <input type="hidden" name="docId" value="<%=docId%>"> 
															<input type="hidden" name="docType" value="<%=docType%>"> 
															<input type="hidden" name="documentNo" value="<%=documentNo%>">
															<input type="hidden" name="projectId" value="<%=projectId%>">
															<input type="hidden" name="icdConnectionId" value="<%=icdConnectionId%>">
															<input type="hidden" name="tab" value="2">
													    </form>
										      		</td>
										      	</tr>
				      						<%} }%>
				      					</tbody>
				      				</table>
				      			</div>	
				      			
				      			<div class="center">
				      				<form action="#" method="post">
				      					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				      					<input type="hidden" name="docId" value="<%=docId%>"> 
										<input type="hidden" name="docType" value="<%=docType%>"> 
										<input type="hidden" name="documentNo" value="<%=documentNo%>">
										<input type="hidden" name="projectId" value="<%=projectId%>">
										<input type="hidden" name="irsDocId" value="<%=docId%>">
										<input type="hidden" name="tab" value="2">
										
				      					<button type="submit" class="btn btn-sm add" name="icdConnectionId" value="<%=icdConnectionId%>" formaction="ICDConnectionPinDetails.htm" data-toggle="tooltip" title="Add">
											ADD
								        </button>
				      				</form>
				      			</div>
		        			</div>
		        			
       						<div class="ml-2 mr-2" style="width: 0.1%; border-left: 1px solid #000;"></div>
       			
       						<div class="table-wrapper-2 ml-2 mr-2" style="width: 60%">
								<!-- <h4 class="mb-4 text-primary">Connector Pin Configuration</h4> -->
								<!-- <div id="connectors"></div>
								<button id="addConnectorBtn" type="button" class="btn btn-success mt-3" style="display: none;">+ Add Connector</button> -->
								
								
								<div>
									<div class="card table-wrapper-2 mb-3">
										<div class="card-header text-white d-flex justify-content-between align-items-center" style="background-color: #055C9D;">
											<span class="connector-title">Connector Details</span>
											<!-- <button type="button" class="btn btn-sm btn-light remove-connector">Remove</button> -->
										</div>
										<div class="card-body">
											<form action="ICDConnectionPinDetailsSubmit.htm" method="post" id="myform_E2">
        										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        										<input type="hidden" name="docId" value="<%=docId%>"> 
												<input type="hidden" name="docType" value="<%=docType%>"> 
												<input type="hidden" name="documentNo" value="<%=documentNo%>">
												<input type="hidden" name="projectId" value="<%=projectId%>">
												<input type="hidden" name="icdConnectionId" value="<%=icdConnectionId%>">
												<input type="hidden" name="icdConnectorId" id="icdConnectorId_E2" value="<%=icdConnectorIdE2!=null?icdConnectorIdE2:"0"%>">
												<input type="hidden" name="systemType" id="systemType_E2" value="B">
												<input type="hidden" name="endNo" value="E2">
												<input type="hidden" name="tab" value="2">
												
												<div class="row">
													<div class="col-md-2">
														<label class="form-label">Connector No<span class="mandatory">*</span></label>
														<div class="d-flex align-items-center">
														    <span class="fw-bold" style="margin-right: 4px;font-size: larger;">J</span>
														    <input type="number" class="form-control connectorNo" name="connectorNo" id="connectorNo_E2" min="1" oninput="generatePinDetails('E2')"
														        <%if(e2Data!=null && e2Data[2]!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(e2Data[2].toString())%>" readonly<%} %> required>
														</div>
													</div>	
													<div class="col-md-4">
														<label class="form-label">Destination<span class="mandatory">*</span></label>
														<select class="form-control selectdee subSystemId" name="subSystemId" id="subSystemId_E2" onchange="generatePinDetails('E2')" <%if(e2Data!=null) {%>disabled<%} %>
													    data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
														    <option value="" disabled selected>Choose...</option>
														    <% for(Object[] obj : productTreeS2List){ %>
														      <option value="<%=obj[0] %>"  <%if(e2Data!=null && e2Data[4]!=null && e2Data[4].toString().equalsIgnoreCase(obj[0].toString())) {%>selected<%} %>>
														        <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%> <%=" ("+(obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - ")+")" %>
														      </option>
														    <% } %>
														</select>
													</div>
													<div class="col-md-4">
														<label class="form-label">Connector<span class="mandatory">*</span></label>
					                    		    	<select class="form-control selectdee connectorId" name="connectorId" id="connectorId_E2" onchange="setPinCount('E2')" <%if(e2Data!=null) {%>disabled<%} %>
												    	data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
														<option value="" disabled selected>Choose...</option>
														    <%for(IGIConnector con : connectorMasterList){ %>
														    	<option value="<%=con.getConnectorId() %>"
														    	data-pincount="<%=con.getPinCount() %>"
														    	<%if(e2Data!=null && e2Data[15]!=null && con.getConnectorId() == Long.parseLong(e2Data[15].toString())) {%>selected<%} %>>
														      		<%=con.getPartNo()!=null?StringEscapeUtils.escapeHtml4(con.getPartNo()): " - " %> (<%=con.getConnectorMake()!=null?StringEscapeUtils.escapeHtml4(con.getConnectorMake()): " - " %>)
														    	</option>
														    <% }%>
														</select>
													</div>
													<div class="col-md-2">
														<label class="form-label">Pins<span class="mandatory">*</span></label>
														<input type="number" class="form-control pinCount" name="pinCount" id="pinCount_E2" min="1" oninput="generatePinDetails('E2')" 
														<%if(e2Data!=null && e2Data[22]!=null) { %>value="<%=StringEscapeUtils.escapeHtml4(e2Data[22].toString())%>"<%} %> required readonly>
													</div>
												</div>
										      	<!-- <button type="button" class="btn btn-primary generate-pins mb-3">Generate Pins</button> -->
												<div class="table-responsive table-wrapper mt-3">
													<table class="table table-bordered table-sm pinstable customtable" id="pinsTable_E2" style="width: 100%;">
														<thead class=" center">
															<tr>
																<th width="7%">Pin No</th>
																<!-- <th width="26%">Interface<span class="mandatory">*</span></th>
																<th width="23%">Constraints<span class="mandatory">*</span></th>
																<th width="20%">Periodicity<span class="mandatory">*</span></th>
																<th width="23%">Description<span class="mandatory">*</span></th> -->
															</tr>
														</thead>
														<tbody>
															<%if(pinListE2!=null && pinListE2.size()>0) {
																int slno = 0;
																for(Object[] obj : pinListE2) { 
																 ++slno;
																%>
																<tr>
																	<td class="center">
																		<span class="pinNoText_E2"><%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %></span>
																		<input type="hidden" class="pinNo_E2" id="pinNo_E2_<%=slno %>" name="pinNo" value="<%=obj[8] %>">
																	</td>
																	<%-- <td>
																		<select class="form-control form-control-sm selectdee" name="interfaceId" id="interfaceId_E2_<%=slno %>" required>
   			        														<option value="" disabled selected>Choose...</option>
															    			<% for(IGIInterface iface : igiInterfaceList){ %>
															    				<option value="<%=iface.getInterfaceId() %>" <%if(iface.getInterfaceId()==Long.parseLong(obj[9].toString())) {%>selected<%} %> >
															    					<%=iface.getInterfaceName()%>
															    			    </option>
															    			<% } %>
															    		</select>
																	</td>
																	<td>
																		<input type="text" class="form-control form-control-sm" name="constraints" id="constraints_E2_<%=slno %>" value="<%=obj[10] %>" required>
																	</td>
																	<td>
																		<input type="radio" name="periodicity_E2_<%=slno %>" id="periodicity_E2_<%=slno %>" value="Periodic" <%if(obj[11]!=null && obj[11].toString().equalsIgnoreCase("Periodic")) {%>checked<%} %>  required />Periodic &nbsp;&nbsp;
											    					    <input type="radio" name="periodicity_E2_<%=slno %>" id="periodicity_E2_<%=slno %>" value="Non-Periodic" <%if(obj[11]!=null && obj[11].toString().equalsIgnoreCase("Non-Periodic")) {%>checked<%} %>  required />Non-Periodic
											    					    <input type="radio" name="periodicity_E2_<%=slno %>" id="periodicity_E2_<%=slno %>" value="Descrete" <%if(obj[11]!=null && obj[11].toString().equalsIgnoreCase("Descrete")) {%>checked<%} %>  required />Descrete</td>
																	<td>
																		<input type="text" class="form-control form-control-sm" name="description" id="description_E2_<%=slno %>" value="<%=obj[12] %>" required>
																	</td> --%>
																</tr>
															<%} }%>
														</tbody>
													</table>
												</div>
												
												<div class="center" style="margin-top: auto;">
		        									<%if(e2Data!=null) {%>
														<!-- <button type="submit" class="btn btn-sm edit" name="action" value="Edit" onclick="return confirm('Are you sure to Update?')">UPDATE</button> -->
													<%} else {%>
														<button type="submit" class="btn btn-sm submit" name="action" value="Add" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
													<%} %>
												</div>
									
											</form>	
										</div>
									</div>
								</div>
							</div>
       					</div>
					</div>
				</div>	
        		
        		<!-- Tab-3  -->
        		<div class="tab-pane fade <%if(tabNo==3) {%>show active<%} %> " id="tab-3" role="tabpane3" aria-labelledby="pills-tab-3">
					<div class="card-body">
						<div class="border rounded shadow-sm mb-3 bg-light" style="border-color: #007bff !important;margin-top: -1rem;border-width: 0.15rem !important;">
							<form action="ICDPinMappingDetailsSubmit.htm" method="post">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="docId" value="<%=docId%>"> 
								<input type="hidden" name="docType" value="<%=docType%>"> 
								<input type="hidden" name="documentNo" value="<%=documentNo%>">
								<input type="hidden" name="projectId" value="<%=projectId%>">
								<input type="hidden" name="icdConnectionId" value="<%=icdConnectionId%>">
								<input type="hidden" name="connectorPinMapId" value="<%=connectorPinMapId==null?"0":connectorPinMapId%>">
								<input type="hidden" name="tab" value="3">
								<div class="form-group mt-4">
									<div class="row ml-1 mr-1">
										<div class="col-md-2">
											<label class="fw-bold">Function<span class="mandatory">*</span></label>
											<input type="text" class="form-control" name="pinFunction" maxlength="255" placeholder="Enter Function" 
											<%if(mapping!=null && mapping.getPinFunction()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(mapping.getPinFunction())%>"<%} %> required>
										</div>
										<div class="col-md-2">
											<label class="fw-bold">Signal Name<span class="mandatory">*</span></label>
											<input type="text" class="form-control" name="signalName" maxlength="255" placeholder="Enter Signal Name"
											<%if(mapping!=null && mapping.getSignalName()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(mapping.getSignalName())%>"<%} %> required>
										</div>
										<div class="col-md-2">
											<label class="fw-bold">From<span class="mandatory">*</span></label>
											<select class="form-control selectdee connectorPinIdFrom" name="connectorPinIdFrom" id="connectorPinIdFrom" onchange="updateInterfaceNameText()"
										    data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
												<option value="" disabled selected>Choose...</option>
											    <%for(Object[] obj : icdConnectorPinList){
											    	//if(obj[3].toString().equalsIgnoreCase("A")) { %>
											    	<option value="<%=obj[7]+"/"+obj[6]+"/"+obj[8]+"/"+obj[13] %>" 
											    	data-interfacename="<%=obj[14] %>"
											    	data-interfacecode="<%=obj[13] %>"
											    	data-interfaceid="<%=obj[9] %>"
											    	data-systemtype="<%=obj[3] %>"
											    	data-subsystemid="<%=obj[4] %>"
											    	<%if(mapping!=null && mapping.getConnectorPinIdFrom()!=null && mapping.getConnectorPinIdFrom()== Long.parseLong(obj[7].toString())) {%>selected<%} %>>
											      		<%=obj[5] !=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - "%> (<%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %>) - <%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %>
											    	</option>
											    <% } //} %>
											</select>
										</div>
										<div class="col-md-2">
											<label class="fw-bold">To<span class="mandatory">*</span></label>
											<select class="form-control selectdee connectorPinIdTo" name="connectorPinIdTo" id="connectorPinIdTo" onchange="updateInterfaceNameText()"
										    data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
												<option value="" disabled selected>Choose...</option>
											    <%for(Object[] obj : icdConnectorPinList){
											    	//if(obj[3].toString().equalsIgnoreCase("B")) {%>
											    	<option value="<%=obj[7]+"/"+obj[6]+"/"+obj[8]+"/"+obj[13] %>"
											    	data-interfacename="<%=obj[14] %>"
											    	data-interfacecode="<%=obj[13] %>"
											    	data-interfaceid="<%=obj[9] %>"
											    	data-systemtype="<%=obj[3] %>"
											    	data-subsystemid="<%=obj[4] %>"
											    	<%if(mapping!=null && mapping.getConnectorPinIdTo()!=null && mapping.getConnectorPinIdTo()== Long.parseLong(obj[7].toString())) {%>selected<%} %>>
											      		<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %> (<%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %>) - <%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %>
											    	</option>
											    <% } //} %>
											</select>
										</div>
	       								<div class="col-md-3">
	       									<label class="fw-bold">Interface<span class="mandatory">*</span></label>
	       									<input type="hidden" name="interfaceId" id="interfaceIdMap">
	       									<input type="hidden" name="interfaceCode" id="interfaceCode">
	       									<input type="text" class="form-control" id="interfaceNameText" placeholder="Enter Interface Name" readonly>
	       								</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row ml-1 mr-1">
										<div class="col-md-2">
	       									<label class="fw-bold">Cable Max Length (In Meters)<span class="mandatory">*</span></label>
	       									<input type="number" step="1" class="form-control " name="cableMaxLength" id="cableMaxLengthAdd" placeholder="Enter Maximum Length of Cable" min="0"
	       									<%if(mapping!=null && mapping.getCableMaxLength()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(mapping.getCableMaxLength().toString())%>"<%} %> required>
	       									<span class="mandatory" id="cablelengthwarning"></span>
	       								</div>
	       								<div class="col-md-2">
	       									<label class="fw-bold">Interface Loss per Meter<span class="mandatory">*</span></label>
	       									<input type="number" step="1" class="form-control " name="interfaceLoss" id="interfaceLossAdd" placeholder="Enter Interface Loss per Meter" min="0" 
	       									<%if(mapping!=null && mapping.getInterfaceLoss()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(mapping.getInterfaceLoss().toString())%>"<%} %> required>
	       									<span class="mandatory" id="interfacelosswarning"></span>
	       								</div>
	       								<div class="col-md-2">
	       									<label class="fw-bold">Cable Bending Radius<span class="mandatory">*</span></label>
	       									<input type="number" step="any" class="form-control " name="cableBendingRadius" id="cableBendingRadiusAdd" placeholder="Enter Cable Bending Radius" min="0" 
	       									<%if(mapping!=null && mapping.getCableBendingRadius()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(mapping.getCableBendingRadius().toString())%>"<%} %> required>
	       									<span class="mandatory" id="cableradiuswarning"></span>
	       								</div>
										<div class="col-md-2">
											<label class="fw-bold">Remarks</label>
											<input type="text" class="form-control " name="remarks" maxlength="255" placeholder="Enter Remarks"
											<%if(mapping!=null && mapping.getRemarks()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(mapping.getRemarks())%>"<%} %>>
										</div>
										<div class="col-md-1 left" style="margin-top: auto;">
											<%if(mapping!=null) {%>
												<button type="submit" class="btn btn-sm edit" name="action" value="Edit" onclick="return confirm('Are you sure to Update?')">UPDATE</button>
											<%} else {%>
												<button type="submit" class="btn btn-sm submit" name="action" value="Add" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
											<%} %>
										</div>
									</div>
								</div>	
							</form>		
						</div>
							
						<div class="table-responsive" >
      						<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable3"  style="width: 100%;">
								<thead class="center" style="background: #055C9D;color: white;">
						      		<tr>
						     	 		<th style="width: 4% !important;">SN</th>
						      			<th style="width: 15% !important;">Connection Code</th>
						      			<th style="width: 10% !important;">Function</th>
						      			<th style="width: 10% !important;">Signal Name</th>
						      			<th style="width: 10% !important;">Type</th>
						      			<th style="width: 10% !important;">Cable Length</th>
						      			<th style="width: 13% !important;">From</th>
						      			<th style="width: 13% !important;">To</th>
						      			<th style="width: 10% !important;">Remarks</th>
						      			<th style="width: 5% !important;">Action</th>
						      		</tr>
						      	</thead>
		      					<tbody>
		      						<%if(icdConnectorPinMapList!=null && icdConnectorPinMapList.size()>0) {
		      							int slno=0;
		    							for(ICDPinMapDTO map : icdConnectorPinMapList){
		      						%>
										<tr>
								      		<td class="center"><%=++slno %></td>
								      		<td class="center"><%=map.getConnectionCode()!=null?StringEscapeUtils.escapeHtml4(map.getConnectionCode()): " - " %></td>
								      		<td><%=map.getPinFunction()!=null?StringEscapeUtils.escapeHtml4(map.getPinFunction()): " - " %></td>
								      		<td><%=map.getSignalName()!=null?StringEscapeUtils.escapeHtml4(map.getSignalName()): " - " %></td>
								      		<td>
								      			<%if(map.getInterfaceId()==-1) { %> 
								      				Not Connected
								      			<%} else if(map.getInterfaceId()==0){ %>
								      				Ground
								      			<%} else{ %>
								      				<%=map.getInterfaceContent()!=null?StringEscapeUtils.escapeHtml4(map.getInterfaceContent()): " - " %>
								      			<%} %>
								      		</td>
								      		<td class="center"><%=map.getCableMaxLength()!=null?StringEscapeUtils.escapeHtml4(map.getCableMaxLength().toString()): " - " %> Meters</td>
								      		<td ><%=map.getLevelNameE1()!=null?StringEscapeUtils.escapeHtml4(map.getLevelNameE1()): " - " %> (<%=map.getLevelCodeE1()!=null?StringEscapeUtils.escapeHtml4(map.getLevelCodeE1()): " - " %>) - <%=map.getPinNoE1()!=null?StringEscapeUtils.escapeHtml4(map.getPinNoE1()): " - " %></td>
								      		<td ><%=map.getLevelNameE2()!=null?StringEscapeUtils.escapeHtml4(map.getLevelNameE2()): " - " %> (<%=map.getLevelCodeE2()!=null?StringEscapeUtils.escapeHtml4(map.getLevelCodeE2()): " - " %>) - <%=map.getPinNoE2()!=null?StringEscapeUtils.escapeHtml4(map.getPinNoE2()): " - " %></td>
								      		<td class="center"><%=map.getRemarks()!=null && !map.getRemarks().isEmpty()?map.getRemarks():"-" %></td>
								      		<td class="center">
								      			 <form action="ICDConnectionPinDetails.htm" method="POST" id="inlinemapform<%=slno%>">
											        <button type="submit" class="editable-clicko" formmethod="post" data-toggle="tooltip" title="Edit">
											            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
											        </button>
											        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
											        <input type="hidden" name="icdConnectorIdE1" value="<%=icdConnectorIdE1 %>">
											        <input type="hidden" name="icdConnectorIdE2" value="<%=icdConnectorIdE2 %>">
											        <input type="hidden" name="connectorPinMapId" value="<%=map.getConnectorPinMapId() %>">
											        <input type="hidden" name="docId" value="<%=docId%>"> 
													<input type="hidden" name="docType" value="<%=docType%>"> 
													<input type="hidden" name="documentNo" value="<%=documentNo%>">
													<input type="hidden" name="projectId" value="<%=projectId%>">
													<input type="hidden" name="icdConnectionId" value="<%=icdConnectionId%>">
													<input type="hidden" name="tab" value="3">
											    </form>
								      		</td>
								      	</tr>
		      						<%} }%>
		      					</tbody>
		      				</table>
		      			</div>		
		      			
		      			<div class="center">
		      				<form action="#" method="post">
		      					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						        <input type="hidden" name="icdConnectorIdE1" value="<%=icdConnectorIdE1 %>">
						        <input type="hidden" name="icdConnectorIdE2" value="<%=icdConnectorIdE2 %>">
						        <input type="hidden" name="connectorPinMapId" value="0">
						        <input type="hidden" name="docId" value="<%=docId%>"> 
								<input type="hidden" name="docType" value="<%=docType%>"> 
								<input type="hidden" name="documentNo" value="<%=documentNo%>">
								<input type="hidden" name="projectId" value="<%=projectId%>">
								<input type="hidden" name="icdConnectionId" value="<%=icdConnectionId%>">
								<input type="hidden" name="tab" value="3">
								
		      					<button type="submit" class="btn btn-sm add" formaction="ICDConnectionPinDetails.htm" data-toggle="tooltip" title="Add">
									ADD
						        </button>
		      				</form>
		      			</div>
				      			
							
					</div>
				</div>
					
        	</div>
        </div>
	</div>

<script type="text/javascript">
$(document).ready(function () {

    $('#myTable1,#myTable2').DataTable({
        "lengthMenu": [10, 25, 50, 75, 100],
        "pagingType": "simple",
        "pageLength": 10
    });
    
    $('#myTable3').DataTable({
        "lengthMenu": [5, 10, 25, 50, 75, 100],
        "pagingType": "simple",
        "pageLength": 5
    });
	
});

function generatePinDetails(endNo) {

    var pinCount = parseInt($('#pinCount_'+endNo).val());
    var connectorNo = parseInt($('#connectorNo_'+endNo).val());
    var subSystemId = parseInt($('#subSystemId_'+endNo).val());
    var systemType = $('#systemType_'+endNo).val();
    var icdConnectorId = $('#icdConnectorId_'+endNo).val();
    var $tbody = $('#pinsTable_'+endNo+' tbody');
    
    if(isNaN(pinCount) ||  pinCount<=0) {
    	pinCount = 0;
    }
    if (!isNaN(connectorNo) && connectorNo>0 && !isNaN(subSystemId) && subSystemId>0) {
    	$.ajax({
    		type : "GET",
    		url : "DuplicateConnectorNoCheck.htm",	
    		datatype : 'json',
    		data : {
    			icdConnectionId : <%=icdConnectionId%>,				
    			connectorNo : connectorNo,				
    			systemType : systemType,				
    			subSystemId : subSystemId,							
    			icdConnectorId : icdConnectorId,							
    		},
    		success : function(result) {
    			var result = JSON.parse(result);
    			
    			if(result>0) {
    				alert('Connector No is already available. Use different Connector No');
    				$('#connectorNo_'+endNo).val('');
    				$('#pinCount_'+endNo).val('');
    				$('#subSystemId_'+endNo).val('').trigger("change");
    				$tbody.empty();
    				return;
    			}else {
    				// Current rows count
    			    var existingRows = $tbody.find('tr').length;
    				
    			    $tbody.find('tr').each(function (index) {
    			        var pinNo = "J" + connectorNo + "." + (index + 1);
    			        $(this).find('.pinNoText_'+endNo).text(pinNo);
    			        $(this).find('input.pinNo_'+endNo).val(pinNo);
    			    });
    			    
    			 	// Append only new rows
    			    for (var i = existingRows + 1; i <= pinCount; i++) {
    			        var pinNo = "J" + connectorNo + "." + i;
    					var selectHTML = '<select class="form-control form-control-sm selectdee" name="interfaceId" id="interfaceId_' + endNo +'_' + i + '" required>' +
				    			        '<option value="-1">Not Connected</option>' +
				    			        '<option value="0">Ground</option>' +
				    			        '<% for(IGIInterface iface : igiInterfaceList){ %>' +
				    			        '<option value="<%=iface.getInterfaceId() %>" >' +
				    			        '<%=iface.getInterfaceName()%>' +
				    			        '</option>' +
				    			        '<% } %>' +
				    			        '</select>';

    					var row = '<tr>' +
    					    '<td class="center"><span class="pinNoText">' + pinNo + '</span><input type="hidden" class="pinNo" name="pinNo" value="'+pinNo+'"></td>';
    					    if(endNo=='E1') {
    					    	row+='<td>' + selectHTML + '</td>' +
        						'<td><input type="text" class="form-control form-control-sm" name="constraints" id="constraints_' + endNo +'_' + i + '" /></td>' +
        					    '<td><input type="radio" name="periodicity_' + endNo +'_' + i + '" id="periodicity_' + endNo +'_' + i + '" value="Periodic" required checked/>Periodic &nbsp;&nbsp;' +
        					    '<input type="radio" name="periodicity_' + endNo +'_' + i + '" id="periodicity_' + endNo +'_' + i + '" value="Non-Periodic" required/>Non-Periodic &nbsp;&nbsp;' +
        					    '<input type="radio" name="periodicity_' + endNo +'_' + i + '" id="periodicity_' + endNo +'_' + i + '" value="Descrete" required/>Descrete</td>' +
        					    '<td><input type="text" class="form-control form-control-sm" name="description" id="description_' + endNo +'_' + i + '" /></td>';
    					    }
    					
    					row+='</tr>';
    					$tbody.append(row);
    					
    					// Apply select2 to only the newly added row
    			        $tbody.find('tr:last .selectdee').select2({
    			            width: '100%',
    			        });
    				}
    			 	
    			 	// If pin count is reduced, remove extra rows
    			    if (existingRows > pinCount) {
    			        $tbody.find('tr:gt(' + (pinCount - 1) + ')').remove();
    			    }
    			}
    		}
    	}); 
    	
    }
}

function setPinCount(endNo) {
	var pincount = $('#connectorId_'+endNo+' option:selected').data('pincount');
    $('#pinCount_'+endNo).val(pincount).trigger('input');;
}

function updateInterfaceNameText() {
    var selectedPinFrom = $('#connectorPinIdFrom option:selected');
    var interfaceNameFrom = selectedPinFrom.data('interfacename');
    var interfaceCodeFrom = selectedPinFrom.data('interfacecode');
    var interfaceIdFrom = selectedPinFrom.data('interfaceid');
    var systemTypeFrom = selectedPinFrom.data('systemtype');
    
    var selectedPinTo = $('#connectorPinIdTo option:selected');
    var interfaceNameTo = selectedPinTo.data('interfacename');
    var interfaceCodeTo = selectedPinFrom.data('interfacecode');
    var interfaceIdTo = selectedPinTo.data('interfaceid');
    var systemTypeTo = selectedPinTo.data('systemtype');
    
    if(systemTypeFrom=='A') {
    	if(interfaceIdFrom=='-1'){
    		interfaceNameFrom = 'Not Connected';
        }else if(interfaceIdFrom=='0') {
        	interfaceNameFrom = 'Ground';
        }
    	$('#interfaceIdMap').val(interfaceIdFrom);
    	$('#interfaceCode').val(interfaceCodeFrom);
    	$('#interfaceNameText').val(interfaceNameFrom);
    }else if(systemTypeTo=='A') {
    	if(interfaceIdTo=='-1'){
    		interfaceNameTo = 'Not Connected';
        }else if(interfaceIdTo=='0') {
        	interfaceNameTo = 'Ground';
        }
    	$('#interfaceIdMap').val(interfaceIdTo);
    	$('#interfaceCode').val(interfaceCodeTo);
    	$('#interfaceNameText').val(interfaceNameTo);
    }
    
    
}

function updatePinDetails(slno) {
	$('#connectorPinId').val($('#connectorPinId_' + slno).val());
	$('#pinNo').val($('#pinNo_' + slno).val());
	$('#interfaceId').val($('#interfaceId_' + slno).val());
	$('#constraints').val($('#constraints_' + slno).val());
	$('#periodicity').val($('input[name="periodicity_' + slno + '"]:checked').val());
	$('#description').val($('#description_' + slno).val());
	
	event.preventDefault(); 
	if (confirm("Are you sure you want to update?")) {
	    $('#pindetupdateform').submit();
	}

}


$(document).ready(function () {
	
	updateInterfaceNameText();
	
	syncDropdowns('connectorPinIdFrom', 'connectorPinIdTo');
	syncDropdowns('connectorPinIdTo', 'connectorPinIdFrom');
	
	// Function to synchronize options between dropdowns
	function syncDropdowns(sourceId, targetId) {
	    // Get the selected value in the source dropdown
	    var selectedValue = $('#' + sourceId).val();
	
	    var selectedoption = $('#' + sourceId +' option:selected');
	    var subSystemId = selectedoption.data('subsystemid');
	    // Enable all options in the target dropdown
	    $('#' + targetId + ' option').prop('disabled', false);
	
	    // If a value is selected, disable it in the target dropdown
	    if (selectedValue) {
	        $('#' + targetId + ' option[data-subsystemid="' + subSystemId + '"]').prop('disabled', true);
	    }
	}

	// When the first dropdown changes
	$('#connectorPinIdFrom').on('change', function () {
	    syncDropdowns('connectorPinIdFrom', 'connectorPinIdTo');
	});
	
	// When the second dropdown changes
	$('#connectorPinIdTo').on('change', function () {
	    syncDropdowns('connectorPinIdTo', 'connectorPinIdFrom');
	});
});
</script>	
	
</body>
</html>