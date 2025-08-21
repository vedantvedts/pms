<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.documents.dto.ICDConnectionDTO"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="com.vts.pfms.documents.model.ICDPurpose"%>
<%@page import="com.vts.pfms.documents.model.PfmsICDDocument"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.model.IGIInterface"%>
<%@page import="java.util.List"%>
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
    max-height: 500px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: hidden; /* Enable vertical scrolling */
}

.select2-container {
	width: 100% !important;
}

label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

.activitytable{
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #0000002b; 
	margin-top: 1.2rem;
	overflow-y: auto; 
	overflow-x: auto;  
}
.activitytable th, .activitytable td{
	border: 1px solid #0000002b; 
	padding: 20px;
}
.activitytable th{

	vertical-align: middle;
}
.activitytable thead {
	text-align: center;
	background-color: #2883c0;
	color: white;
	position: sticky;
	top: 0; /* Keeps the header at the top */
	z-index: 10; /* Ensure the header stays on top of the body */
	/* background-color: white; */ /* For visibility */
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
	PfmsICDDocument icdDocument = (PfmsICDDocument)request.getAttribute("icdDocument"); 
	
	List<Object[]> productTreeAllList = (List<Object[]>)request.getAttribute("productTreeAllList"); 
	
	//List<Object[]> productTreeList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
	//List<Object[]> productTreeSubList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("2")).collect(Collectors.toList());

	
	List<IGIInterface> igiInterfaceList = (List<IGIInterface>)request.getAttribute("igiInterfaceList"); 
	igiInterfaceList = igiInterfaceList.stream().filter(e -> e.getIsActive()==1).collect(Collectors.toList());
	
	List<ICDPurpose> icdPurposeList = (List<ICDPurpose>)request.getAttribute("icdPurposeList"); 
	icdPurposeList = icdPurposeList.stream().filter(e -> e.getIsActive()==1).collect(Collectors.toList());
	
	List<ICDConnectionDTO> icdConnectionsList = (List<ICDConnectionDTO>)request.getAttribute("icdConnectionsList"); 
	ICDConnectionDTO condto = icdConnectionsList.stream().filter(e -> e.getICDConnectionId()==Long.parseLong(icdConnectionId)).findFirst().orElse(null);
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
               		<div class="col-md-10 left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                       Connection-Interface Details - <%=documentNo %>
	                    </h5>
                	</div>
                	<div class="col-md-2 right">
                		<!-- <button class="btn btn-sm btn-info" data-toggle="modal" data-target="#connectinoMatrixModal">Connection Matrix</button> -->
						<form action="ICDConnectionList.htm" method="post">
                    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        			<input type="hidden" name="docId" value="<%=docId %>" />
		        			<input type="hidden" name="docType" value="<%=docType %>" />
		        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
		        			<input type="hidden" name="projectId" value="<%=projectId %>" />
		        			<button class="btn btn-info btn-sm shadow-nohover back">
		        				BACK
		        			</button>
                		</form>                	
                	</div>
            	</div>
        	</div>
        	<div class="card-body">
        		
        		<form action="ICDConnectionDetailsSubmit.htm" method="post" id="connectionForm" enctype="multipart/form-data">
        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        			<input type="hidden" name="docId" value="<%=docId %>" />
        			<input type="hidden" name="docType" value="<%=docType %>" />
        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
        			<input type="hidden" name="projectId" value="<%=projectId %>" />
        			<input type="hidden" name="icdConnectionId" value="<%=icdConnectionId %>" />
        			<%-- <input type="hidden" name="isSubSystem" id="isSubSystem" value="<%=isSubSystem %>" />
	        		<%if(isSubSystem.equalsIgnoreCase("Y")) {%>
		        		<input type="hidden" name="subSystemOne" id="subSystem1" value="<%=subsystem[0]+"/"+subsystem[7] %>">
		        		<input type="hidden" name="subSystemTwo" id="subSystem2" value="<%=subsystem[0]+"/"+subsystem[7] %>">
		        	<%} %> --%>
	        		<div class="card">
	        			<div class="card-body">
	        				<div class="form-group">
	        					<div class="row">
	        					
	        						<div class="col-md-4">
	        							<label class="form-lable">Sub-System 1<span class="mandatory">*</span></label>
	        							<%if(condto!=null) {%>
		        							<button type="button" class="btn btn-sm" id="subSystemId1btn" data-toggle="tooltip" title="Edit" data-target="#subSystem1">
									            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
									        </button>
									    <%} %>    
	        							<select class="form-control selectdee subSystem1" name="subSystemIdOne" id="subSystem1" <%if(condto!=null) {%> disabled="disabled" <%} %>
		        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required multiple="multiple">
									        
								        	<!-- <option value="" disabled selected>Choose...</option> -->
									        <%
									        for(Object[] obj : productTreeAllList){ %>
									        	<option value="<%=obj[0] %>"
									        	<%if(condto!=null && condto.getSubSystemIdsS1()!=null) {
									        		List<Long> s1List = Arrays.stream(condto.getSubSystemIdsS1().split(","))
								                            			.map(Long::parseLong).collect(Collectors.toList());
									        	%>
									        		<%if(s1List.contains(Long.parseLong(obj[0].toString()))) {%>selected<%} %>
									        	<%} %>
									        	 ><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "+" ("+obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "+")" %></option>
									        <%} %>
										</select>
	        						</div>
	        						<div class="col-md-4">
	        							<label class="form-lable">Sub-System 2<span class="mandatory">*</span></label>
	        							<%if(condto!=null) {%>
		        							<button type="button" class="btn btn-sm" id="subSystemId2btn" data-toggle="tooltip" title="Edit" data-target="#subSystem2">
									            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
									        </button>
									    <%} %> 
		        						<select class="form-control selectdee subSystem2" name="subSystemIdTwo" id="subSystem2" <%if(condto!=null) {%> disabled="disabled" <%} %> 
		        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required multiple="multiple">
											<!-- <option value="" disabled selected>Choose...</option> -->
									        <% for(Object[] obj : productTreeAllList){ %>
									        	<option value="<%=obj[0] %>" 
									        	<%if(condto!=null && condto.getSubSystemIdsS2()!=null) {
									        		List<Long> s2List = Arrays.stream(condto.getSubSystemIdsS2().split(","))
								                            			.map(Long::parseLong).collect(Collectors.toList());
									        	%>
									        		<%if(s2List.contains(Long.parseLong(obj[0].toString()))) {%>selected<%} %>
									        	<%} %>
									        	><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "+" ("+obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "+")" %></option>
									        <%} %>
										</select>
        							</div>
	        						
	        						<div class="col-md-4">
	        							<label class="form-lable">Interface<span class="mandatory">*</span></label>
	        							<%if(condto!=null) {%>
		        							<button type="button" class="btn btn-sm" id="interfaceIdbtn" data-toggle="tooltip" title="Edit" data-target="#interfaceId">
									            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
									        </button>
									    <%} %>    
		        						<select class="form-control interfaceId" name="interfaceId" id="interfaceId" <%if(condto!=null) {%> disabled="disabled" <%} %> 
		        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required multiple="multiple">
									        <!-- <option value="" disabled selected>---------Select------------</option> -->
									        <% for(IGIInterface iface : igiInterfaceList){ %>
									        	<option value="<%=iface.getInterfaceId() %>"
									        	data-title="<%=iface.getParameterData() %> (<%=iface.getInterfaceSpeed() %>)"
									        	<%if(condto!=null && condto.getInterfaceIds()!=null) {
									        		List<Long> ifaceList = Arrays.stream(condto.getInterfaceIds().split(","))
								                            			.map(Long::parseLong).collect(Collectors.toList());
									        	%>
									        		<%if(ifaceList.contains(iface.getInterfaceId())) {%>selected<%} %>
									        	<%} %>
									        	>
									        		<%=iface.getInterfaceName()!=null?StringEscapeUtils.escapeHtml4(iface.getInterfaceName()): " - " %>
									        	</option>
									        <%} %>
										</select>
	        						</div>
	        						
	        					</div>
	        				</div>
	        				
	        				<div class="form-group">
	        					<div class="row">
	        						<div class="col-md-4">
	        							<label class="form-lable">Purpose<span class="mandatory">*</span></label>
	        							<%if(condto!=null) {%>
		        							<button type="button" class="btn btn-sm" id="purposeIdbtn" data-toggle="tooltip" title="Edit" data-target="#purposeId">
									            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
									        </button>
								        <%} %>
		        						<select class="form-control selectdee purpose" name="purposeId" id="purposeId" <%if(condto!=null) {%> disabled="disabled" <%} %> 
		        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required multiple="multiple">
									        <% for(ICDPurpose icdPurpose : icdPurposeList){ %>
									        	<option value="<%=icdPurpose.getPurposeId() %>"
									        	<%if(condto!=null && condto.getPurposeIds()!=null) {
									        		List<Long> purpList = Arrays.stream(condto.getPurposeIds().split(","))
								                            			.map(Long::parseLong).collect(Collectors.toList());
									        	%>
									        		<%if(purpList.contains(icdPurpose.getPurposeId())) {%>selected<%} %>
									        	<%} %>
									        	><%=icdPurpose.getPurpose()!=null?StringEscapeUtils.escapeHtml4(icdPurpose.getPurpose()): " - " %></option>
									        <%} %>
										</select>
	        						</div>
	        						
	        						<div class="col-md-4">
	        							<label class="form-lable">Drawing Attachment</label>
	        							<%if(condto!=null && condto.getDrawingAttach()!=null) {%>
		        							<button type="submit" class="btn btn-sm" name="drawingAttach"value="<%=condto.getDrawingAttach() %>" formaction="ICDConnectionDrawingAttachDownload.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
			                      				<i class="fa fa-download"></i>
			                      			</button>
		                      			 <%} %>
	        							<input type="file" class="form-control" name="drawingAttachment"  accept="image/png, image/jpeg" >
	        						</div>
	        						
	        						<div class="col-md-2">
	        							<label class="form-lable">Drawing No</label>
	        							<input type="text" class="form-control" name="drawingNo" <%if(condto!=null && condto.getDrawingNo()!=null) {%>value="<%=condto.getDrawingNo() %>" <%} %> placeholder="Enter Drawing No" >
	        						</div>
	        					</div>
	        				</div>	
	        				
	        				<!-- <div class="form-group">
       							<div class="row">
       								
       								<div class="col-md-3">
       									<label class="form-lable">Cable Max Length (In Meters)<span class="mandatory">*</span></label>
       									<input type="number" step="1" class="form-control" name="cableMaxLength" id="cableMaxLengthAdd" placeholder="Enter Maximum Length of Cable" min="0" required>
       									<span class="mandatory" id="cablelengthwarning"></span>
       								</div>
       								<div class="col-md-3">
       									<label class="form-lable">Interface Loss per Meter<span class="mandatory">*</span></label>
       									<input type="number" step="1" class="form-control" name="interfaceLoss" id="interfaceLossAdd" placeholder="Enter Interface Loss per Meter" min="0" required>
       									<span class="mandatory" id="interfacelosswarning"></span>
       								</div>
       								<div class="col-md-3">
       									<label class="form-lable">Cable Bending Radius<span class="mandatory">*</span></label>
       									<input type="number" step="any" class="form-control" name="cableBendingRadius" id="cableBendingRadiusAdd" placeholder="Enter Cable Bending Radius" min="0" required>
       									<span class="mandatory" id="cableradiuswarning"></span>
       								</div>
       							</div>
       						</div> -->
		       						
	        				<div class="center">
	        					<%if(condto!=null) {%>
	        						<button type="submit" class="btn btn-sm edit" name="action" value="Edit" onclick="return confirm('Are you Sure to Update?')">UPDATE</button>
	        					<%} else{%>
	        						<button type="submit" class="btn btn-sm submit" name="action" value="Add" onclick="return confirm('Are you Sure to Submit?')">SUBMIT</button>
	        					<%} %>
	        				</div>	
	        			</div>
	        		</div>
	        		
	        	</form>
	        	
        	</div>
        </div>
 	</div>
	
	
	
<script type="text/javascript">
$('[data-target]').on('click', function() {
    const target = $(this).data('target');
    $(target).prop('disabled', function(i, val) {
        return !val;
    });
});

$('#interfaceId').select2({
    width: '100%',
    templateResult: function (data) {
      if (!data.id) return data.text;

      var $option = $(data.element);
      var tooltip = $option.attr('data-title') || '';
      var $result = $('<span data-toggle="tooltip" title="' + tooltip + '">' + data.text + '</span>');
      return $result;
    }
  });

  $('#interfaceId').on('select2:open', function () {
    setTimeout(function () {
      $('[data-toggle="tooltip"]').tooltip();
    }, 0);
  });
</script> 	
</body>
</html>