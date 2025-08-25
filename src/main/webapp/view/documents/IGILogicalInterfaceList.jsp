
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.documents.model.FieldGroupMaster"%>
<%@page import="com.vts.pfms.documents.model.IGIFieldDescription"%>
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

.customSidebar {
	min-height: 660px;
    max-height: 660px;
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
		List<Object[]> fieldDescriptionList = (List<Object[]>)request.getAttribute("fieldDescriptionList");
		List<Object[]> fieldMasterList = (List<Object[]>)request.getAttribute("fieldMasterList");
		List<Object[]> dataTypeMasterList = (List<Object[]>)request.getAttribute("dataTypeMasterList");
		IGILogicalInterfaces logicalInterface = (IGILogicalInterfaces)request.getAttribute("igiLogicalInterfaceData");
		String logicalInterfaceId = (String)request.getAttribute("logicalInterfaceId");
		String logicalChannelId = (String)request.getAttribute("logicalChannelId");
		if(logicalChannelId==null) {
			logicalChannelId = "0";
		}
		String igiDocId = (String)request.getAttribute("igiDocId");
		List<String> msgTypesList = Arrays.asList("Information", "Request", "Answer", "Command", "Acknowledement");
		
		fieldDescriptionList = fieldDescriptionList.stream().filter(e -> logicalInterfaceId.equalsIgnoreCase(e[1].toString()) ).collect(Collectors.toList());
	
		List<FieldGroupMaster> fieldGroupList = (List<FieldGroupMaster>) request.getAttribute("fieldGroupList");
		
		Map<String, List<Object[]>> fieldGroupMap = new LinkedHashMap<>();
		fieldGroupMap.put("0", fieldMasterList);
	    
		for(FieldGroupMaster fieldGroup : fieldGroupList) {
			
			List<Object[]> fieldMasterByType = fieldMasterList.stream()
											    .filter(e -> {
											    	if(e[18]!=null) {
											    		String fieldGroupIds = e[18].toString();
												        List<String> idList = Arrays.asList(fieldGroupIds.split(","));
												        return idList.contains(fieldGroup.getFieldGroupId()+"");
											    	}else{
											    		return false;
											    	}
											        
											    })
				    							.collect(Collectors.toList());
			
			fieldGroupMap.computeIfAbsent(fieldGroup.getFieldGroupId()+"", k -> new ArrayList<>()).addAll(fieldMasterByType);
		}
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
 						<h3 class="text-dark" style="font-weight: bold;">Logical Interfaces</h3>
 					</div>
 					<div class="col-md-7"></div>
 					<div class="col-md-2"  align="right">
						<form action="IGILogicalInterfaceMatrixDetails.htm" method="post">
                    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        			<input type="hidden" name="igiDocId" value="<%=igiDocId %>" />
		        			<input type="hidden" name="docType" value="A" />
		        			<button class="btn btn-info btn-sm shadow-nohover back">
		        				Interface Matrix
		        			</button>
                		</form>                	
                	</div>
 					<div class="col-md-1 right">
	 					<a class="btn btn-info btn-sm shadow-nohover back" style="position:relative;" href="IGIDocumentDetails.htm?igiDocId=<%=igiDocId%>">Back</a>
 					</div>
 				</div>
       		</div>
       		
       		<div class="card-body">
       			<div class="custom-container">
       				<div style="width: 18%;">
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
   										
   										logicalInterfaceMap.computeIfAbsent(channel.getLogicalChannelId() +"/"+ channel.getLogicalChannel(), k -> new ArrayList<>()).addAll(interfaceListByType);
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
								                        <%=(interfaceMainCount) + "." + (++interfaceSubCount) + ". " %> <%= iface.getMsgCode()!=null?StringEscapeUtils.escapeHtml4(iface.getMsgCode()): " - "%>
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
       				<div style="width: 82%;">
       					<div class="card ml-3 mr-3">
       						<div class="card-header">
       							<h4 class="text-dark">Interface Details <%if(logicalInterface!=null) {%>- <%=logicalInterface.getMsgCode()!=null?StringEscapeUtils.escapeHtml4(logicalInterface.getMsgCode()): " - " %><%} else{%>Add<%} %> </h4>
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
		       										<!-- <option value="addNew" style="background-color: purple !important;">Add New</option> -->
		       										<%for(IGILogicalChannel channel : logicalChannelList) {%>
		       											<option value="<%=channel.getLogicalChannelId()+"/"+channel.getLogicalChannel() %>" 
		       											<%if(logicalInterface!=null && logicalInterface.getLogicalChannelId()!=null && logicalInterface.getLogicalChannelId().equals(channel.getLogicalChannelId()) ||
		       													Long.parseLong(logicalChannelId)==channel.getLogicalChannelId()) {%>selected<%} %>>
		       												<%=channel.getLogicalChannel()!=null?StringEscapeUtils.escapeHtml4(channel.getLogicalChannel()): " - "%> <%=" ("+(channel.getChannelCode()!=null?StringEscapeUtils.escapeHtml4(channel.getChannelCode()): " - ")+")" %>
		       											</option>
		       										<%} %>
		       									</select>
		       								</div>
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Message Type <span class="mandatory">*</span></label>
		       									<select class="form-control" id="msgType" name="msgType" required>
		       										<option value="" selected disabled>----select----</option>
		       										<%for(String msgType : msgTypesList) {%>
		       											<option value="<%=msgType %>" <%if(logicalInterface!=null && logicalInterface.getMsgType()!=null && logicalInterface.getMsgType().equalsIgnoreCase(msgType)) {%>selected<%} %>><%=msgType!=null?StringEscapeUtils.escapeHtml4(msgType): " - " %></option>
		       										<%} %>
		       									</select>
		       								</div>
			                    		    <div class="col-md-3">
		       									<label class="form-lable">Message Name <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="msgName" id="msgName" <%if(logicalInterface!=null && logicalInterface.getMsgName()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(logicalInterface.getMsgName()) %>"<%} %> placeholder="Enter Message Name" maxlength="255" required>
		       								</div>
		       								
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Data Rate </label>
		       									<input type="text" class="form-control" name="dataRate" <%if(logicalInterface!=null && logicalInterface.getDataRate()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(logicalInterface.getDataRate()) %>"<%} %> placeholder="Enter Data Rate" maxlength="255">
		       								</div>
	                  				 	</div>
                  				 	</div>
                  				 	
	       							<div class="form-group">
			       						<div class="row">
			                    		    <div class="col-md-3">
		       									<label class="form-lable">Description </label>
		       									<textarea class="form-control" name="msgDescription" rows="2" placeholder="Enter Msg Description" maxlength="255" ><%if(logicalInterface!=null && logicalInterface.getMsgDescription()!=null) {%><%=StringEscapeUtils.escapeHtml4(logicalInterface.getMsgDescription()) %><%} %></textarea>
		       								</div>
			                    		    <div class="col-md-3">
		       									<label class="form-lable">Protocols </label>
		       									<textarea class="form-control" name="protocols" rows="2" placeholder="Enter Underlying Protocols" maxlength="255"><%if(logicalInterface!=null && logicalInterface.getProtocals()!=null) {%><%=StringEscapeUtils.escapeHtml4(logicalInterface.getProtocals()) %><%} %></textarea>
		       								</div>
			                    		    <div class="col-md-3">
		       									<label class="form-lable">Additional Info </label>
		       									<textarea class="form-control" name="additionalInfo" rows="2" placeholder="Enter Additional Info" maxlength="255"><%if(logicalInterface!=null && logicalInterface.getAdditionalInfo()!=null) {%><%=StringEscapeUtils.escapeHtml4(logicalInterface.getAdditionalInfo()) %><%} %></textarea>
		       								</div>
	                  				 	</div>
                  				 	</div>
                  				 	
                  				 	<div class="form-group">
                  				 		<div class="form-row">
                  				 			<div class="col-md-2">
		       									<label class="form-lable">Message Length <span class="mandatory">*</span></label>
		       									<input type="number" class="form-control" name="msgLength" <%if(logicalInterface!=null && logicalInterface.getMsgLength()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(logicalInterface.getMsgLength().toString()) %>"<%} %> min="0" max="9999999999" required>
		       								</div>
		       								
			                    		    <div class="col-md-2">
		       									<label class="form-lable">Message Number <span class="mandatory">*</span></label>
		       									<input type="text" class="form-control" name="msgNo" <%if(logicalInterface!=null && logicalInterface.getMsgNo()!=null) {%>value="<%=StringEscapeUtils.escapeHtml4(logicalInterface.getMsgNo()) %>"<%} %> placeholder="Enter Message No" maxlength="255" required>
		       								</div>
                  				 		</div>
                  				 	</div>
                  				 	<hr class="mt-3 mb-3">
	                    				 
		       						<div class="row">
		                    		    <div class="col-md-6" style="text-align: left;">
		                    		    	<label class="control-label" style="color: black;">Field Description :</label>
		                    		    </div>
                  				 	</div>
	                  				 	
                  				 	<div class="form-group">
                  				 		<div class="row">
                  				 			<div class="col-md-12">
                  				 				<table id="fielddesctable" class="table table-bordered fielddesctable" style="width: 100%;" >
													<thead class="center" style="background: #055C9D;color: white;">
														<tr>
															<th width="20%">Group</th>
															<th width="25%">Field Name</th>
															<th width="20%">Data Type (bits)</th>
															<th width="15%">Quantum</th>
															<th width="15%">Unit</th>
															<!-- <th width="20%">Remarks</th> -->
															<td width="5%">
																<button type="button" class=" btn btn-sm btn_add_fielddesc "><i class="btn btn-sm fa fa-plus" style="color: green;"></i></button>
															</td>
														</tr>
													</thead>
													<tbody>
														<%
														int slno = 1;
														if(fieldDescriptionList!=null && fieldDescriptionList.size()>0) {
															for(Object[] desc : fieldDescriptionList) {
														%>
															<tr class="tr_clone_fielddesc">
																<td>
																	<select class="form-control selectitem fieldGroupId" name="fieldGroupId" id="fieldGroupId_<%=slno %>" data-live-search="true" data-container="body" required>
											               				<option value="" disabled selected>Choose...</option>
											               				<option value="0" <%if(desc[12]!=null && Long.parseLong(desc[12].toString())==0) {%>selected<%} %>>Not Applicable</option>
											               				<%for(FieldGroupMaster fieldGroup : fieldGroupList){
											                			 %>
																			<option value="<%=fieldGroup.getFieldGroupId()%>" <%if(desc[12]!=null && Long.parseLong(desc[12].toString())==(fieldGroup.getFieldGroupId())) {%>selected<%} %> >
																				<%=fieldGroup.getGroupName()!=null?StringEscapeUtils.escapeHtml4(fieldGroup.getGroupName()): " - "%> <%=" ("+(fieldGroup.getGroupCode()!=null?StringEscapeUtils.escapeHtml4(fieldGroup.getGroupCode()): " - ")+")" %>
																			</option>
																		<%} %>
																	</select>
																</td>
																<td>
																	<select class="form-control selectitem fieldMasterId" name="fieldMasterId" id="fieldMasterId_<%=slno %>" data-live-search="true" data-container="body" required>
											               				<option value="" disabled selected>Choose...</option>
											               				<%for(Object[] obj : fieldMasterList ){
											                			 %>
																			<option value="<%=obj[0]%>" <%if(desc[2]!=null && Long.parseLong(desc[2].toString())==Long.parseLong(obj[0].toString())) {%>selected<%} %> >
																				<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %>
																			</option>
																		<%} %>
																	</select>
																</td>	
																<td>
																	<input type="text" class="form-control dataType" name="dataType" id="dataType_<%=slno %>" <%if(desc[19]!=null) {%> value="<%=StringEscapeUtils.escapeHtml4(desc[19].toString()) %>" <%} %> readonly>
																</td>	
																<td>
																	<input type="text" class="form-control quantum" name="quantum" id="quantum_<%=slno %>" value="<%=StringEscapeUtils.escapeHtml4(desc[6].toString()) %>" readonly>
																</td>
																<td>
																	<input type="text" class="form-control unit" name="unit" id="unit_<%=slno %>" value="<%=StringEscapeUtils.escapeHtml4(desc[18].toString()) %>" readonly>
																</td>	
																<%-- <td>
																	<input type="text" class="form-control remarks" name="remarks" id="remarks_<%=slno %>" value="<%=desc.getRemarks() %>" readonly>
																</td> --%>	
																<td class="center">
																	<button type="button" class=" btn btn-sm btn_rem_fielddesc" > <i class="btn btn-sm fa fa-minus" style="color: red;"></i></button>
																</td>		
															</tr>
														<%++slno;} }else{%>
															<tr class="tr_clone_fielddesc">
																<td>
																	<select class="form-control selectitem fieldGroupId" name="fieldGroupId" id="fieldGroupId_1" data-live-search="true" data-container="body" required>
											               				<option value="" disabled selected>Choose...</option>
											               				<option value="0" >Not Applicable</option>
											               				<%for(FieldGroupMaster fieldGroup : fieldGroupList){
											                			 %>
																			<option value="<%=fieldGroup.getFieldGroupId()%>">
																				<%=fieldGroup.getGroupName()!=null?StringEscapeUtils.escapeHtml4(fieldGroup.getGroupName()): " - "%> <%=" ("+(fieldGroup.getGroupCode()!=null?StringEscapeUtils.escapeHtml4(fieldGroup.getGroupCode()): " - ")+")" %>
																			</option>
																		<%} %>
																	</select>
																</td>
																<td>
																	<select class="form-control selectitem fieldMasterId" name="fieldMasterId" id="fieldMasterId_1" data-live-search="true" data-container="body" required>
											               				<%-- <option value="" disabled selected>Choose...</option>
											               				<%for(Object[] obj : fieldMasterList ){
											                			 %>
																			<option value="<%=obj[0]%>" 
																			data-fieldname="<%=obj[1]%>"
																			data-fieldcode="<%=obj[3]%>"
																			data-quantum="<%=obj[11]%>"
																			data-unit="<%=obj[12]%>"
																			data-remarks="<%=obj[13]%>"
																			data-datatype="<%=obj[14]%>"
																			data-datalength="<%=obj[15]%>"
																			>
																				<%=obj[1]+" ("+obj[3]+")" %>
																			</option>
																		<%} %> --%>
																	</select>
																</td>	
																<td>
																	<input type="text" class="form-control dataType" name="dataType" id="dataType_1" readonly>
																</td>	
																<td>
																	<input type="text" class="form-control quantum" name="quantum" id="quantum_1" readonly>
																</td>	
																<td>
																	<input type="text" class="form-control unit" name="unit" id="unit_1" readonly>
																</td>	
																<!-- <td>
																	<input type="text" class="form-control remarks" name="remarks" id="remarks_1" readonly>
																</td> -->	
																<td class="center">
																	<button type="button" class=" btn btn-sm btn_rem_fielddesc" > <i class="btn btn-sm fa fa-minus" style="color: red;"></i></button>
																</td>		
															</tr>
														<%} %>		
													</tbody>
												</table>
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
	<%-- <div class="modal fade bd-example-modal-lg center" id="addNewChannelsModal" tabindex="-1" role="dialog" aria-labelledby="addNewChannelsModal" aria-hidden="true" style="margin-top: 10%;">
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
	</div> --%>	
	
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
		
		$('#msgType').on('change', function(){
			var msgtype = $(this).val();
			var msgtypecode = "";
			var logicalInterfaceId = $('#logicalInterfaceId').val();
			//if(logicalInterfaceId==0){
				if(msgtype=='Command'){
					msgtypecode = "CMD_";
				}else{
					msgtypecode = msgtype.substring(0, 3).toUpperCase()+"_";
				}
			//}
			$('#msgName').val(msgtypecode);
		});
		/* $('#logicalChannelId').on('change', function(){
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
		} */ 
		
		var fieldGroupMap = {};
	    <% for (Map.Entry<String, List<Object[]>> entry : fieldGroupMap.entrySet()) { %>
	        fieldGroupMap["<%= entry.getKey() %>"] = [
	            <% for (Object[] field : entry.getValue()) { %>
	                {
	                	value: "<%= field[0] %>",
	                    text: "<%= field[1] %>",
	                    datatype: "<%= field[16] %>",
	                    quantum: "<%= field[11] %>",
	                    unit: "<%= field[12] %>",
	                    remarks: "<%= field[13] %>"
	                },
	            <% } %>
	        ];
	    <% } %>
	    
		/* Cloning (Adding) the table body rows */
		let fieldDescIndex = '<%=slno%>'; // Start from 1 if one row is already present

		$("#fielddesctable").on('click', '.btn_add_fielddesc', function () {
		    const $last = $('.tr_clone_fielddesc').last();
		    const $clone = $last.clone();

		    fieldDescIndex++;

		    // Clean up old select2 from clone
		    $clone.find('.select2-container').remove();
		    $clone.find('.fieldGroupId, .fieldMasterId')
		        .removeClass('select2-hidden-accessible')
		        .removeAttr('data-select2-id')
		        .removeAttr('aria-hidden')
		        .removeAttr('tabindex');

		    // Update IDs and reset values
		    $clone.find('.fieldGroupId')
		        .val('')
		        .attr('id', 'fieldGroupId_' + fieldDescIndex)

		    $clone.find('.fieldMasterId')
		        .val('')
		        .attr('id', 'fieldMasterId_' + fieldDescIndex)
		        .html('<option value="" selected disabled>Choose...</option>');

		    // Reset any inputs
		    $clone.find("input[type='text'], textarea").val('');
		    $clone.find("input[type='number']").val('0');

		    // Add to DOM
		    $last.after($clone);

		    // Reinitialize all select2 (important!)
		    initializeSelect2ForAll();
		});

		/* Cloning (Removing) the table body rows */
		$("#fielddesctable").on('click','.btn_rem_fielddesc' ,function() {
			
			var cl=$('.tr_clone_fielddesc').length;
				
			if(cl>1){
			   var $tr = $(this).closest('.tr_clone_fielddesc');
			  
			   var $clone = $tr.remove();
			   $tr.after($clone);
			   
			}
		 
		});


		function initializeSelect2ForAll() {
		    // Clean up and reinitialize all select2
		    $('.fieldGroupId, .fieldMasterId').each(function () {
		        // Destroy existing Select2 if initialized
		        if ($(this).hasClass("select2-hidden-accessible")) {
		            $(this).select2('destroy');
		        }
		        // Reinitialize
		        $(this).select2({ width: '100%' });
		    });
		}
		
		function handleFieldGroupChange(rowId) {
		    const selectedGroupId = $('#fieldGroupId_' + rowId).val();
		    const $originalRow = $('#fieldGroupId_' + rowId).closest('tr');
		    const fieldList = fieldGroupMap[selectedGroupId] || [];

		    // Clear the fieldMaster dropdown and populate options
		    const $fieldDropdown = $('#fieldMasterId_' + rowId);
		    $fieldDropdown.empty().append('<option value="" selected disabled>Choose...</option>');

		 	// Always clear data fields first for safety
		    $originalRow.find('.dataType').val('');
		    $originalRow.find('.quantum').val('');
		    $originalRow.find('.unit').val('');
		    // $originalRow.find('.remarks').val('');
		    $originalRow.find("input[type='text'], textarea").val('');
		    $originalRow.find("input[type='number']").val('0');
		    
		    if (selectedGroupId === '0' || fieldList.length === 0) {

		        fieldList.forEach(field => {
		            $fieldDropdown.append(new Option(field.text, field.value));
		        });

		        // Reinitialize select2 only for this dropdown
		        initializeSelect2ForAll();
		        return;
		    }

		    let $lastInsertedRow = $originalRow; // Start from the original row

		    // If multiple fields exist, populate current row and clone only remaining ones
		    fieldList.forEach((field, index) => {
		        if (index === 0) {
		            // First item: update current row
		            $fieldDropdown.append(new Option(field.text, field.value, true, true));
		            $originalRow.find('.fieldGroupId').val(selectedGroupId);
		            $originalRow.find("input[type='text'], textarea").val('');
		            $originalRow.find("input[type='number']").val('0');
		            
		            $originalRow.find('.dataType').val(field.datatype || '');
		            $originalRow.find('.quantum').val(field.quantum || '');
		            $originalRow.find('.unit').val(field.unit || '');
		            // $originalRow.find('.remarks').val(field.remarks || '');
		            
		        } else {
		            // For additional fields, clone new rows
		            fieldDescIndex++;

		            const $newRow = $('.tr_clone_fielddesc').first().clone();

		            $newRow.find('.select2-container').remove();
		            $newRow.find('.fieldGroupId, .fieldMasterId')
		                .removeClass('select2-hidden-accessible')
		                .removeAttr('data-select2-id')
		                .removeAttr('aria-hidden')
		                .removeAttr('tabindex');

		            $newRow.find('.fieldGroupId')
		                .val(selectedGroupId)
		                .attr('id', 'fieldGroupId_' + fieldDescIndex);

		            $newRow.find('.fieldMasterId')
		                .empty()
		                .append(new Option(field.text, field.value, true, true))
		                .attr('id', 'fieldMasterId_' + fieldDescIndex);

		            $newRow.find("input[type='text'], textarea").val('');
		            $newRow.find("input[type='number']").val('0');

		            $newRow.find('.dataType').val(field.datatype || '');
		            $newRow.find('.quantum').val(field.quantum || '');
		            $newRow.find('.unit').val(field.unit || '');
		            // $newRow.find('.remarks').val(field.remarks || '');

		            $lastInsertedRow.after($newRow);
        			$lastInsertedRow = $newRow; // Update reference
		        }
		    });

		    initializeSelect2ForAll();
		}


		$(document).ready(function () {
		    // Set initial counter
		    const lastId = $('.fieldGroupId').last().attr('id');
		    if (lastId) {
		        const parts = lastId.split('_');
		        fieldDescIndex = parseInt(parts[1]) || 1;
		    }

		    // Initialize all existing selects
		    initializeSelect2ForAll();
		    
		 	// Use event delegation to bind change handler to current and future .fieldGroupId elements
		    $('#fielddesctable').on('change', '.fieldGroupId', function () {
		    	const id = $(this).attr('id'); // e.g., fieldGroupId_2
		        const index = parseInt(id.split('_')[1]); // get 2
		        handleFieldGroupChange(index);
		    });

		 	// Field Master selection change handler
		    $('#fielddesctable').on('change', '.fieldMasterId', function () {
		        const selectedFieldId = $(this).val();
		        const $row = $(this).closest('tr');
		        const groupId = $row.find('.fieldGroupId').val();
		        const fieldList = fieldGroupMap[groupId] || [];
		        const matchedField = fieldList.find(f => f.value === selectedFieldId);

		        if (matchedField) {
		            $row.find('.dataType').val(matchedField.datatype || '');
		            $row.find('.quantum').val(matchedField.quantum || '');
		            $row.find('.unit').val(matchedField.unit || '');
		            // $row.find('.remarks').val(matchedField.remarks || '');
		        }
		    });

		});

	</script>

</body>
</html>