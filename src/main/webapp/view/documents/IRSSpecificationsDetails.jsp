<%@page import="com.vts.pfms.documents.model.IRSDocumentSpecifications"%>
<%@page import="com.vts.pfms.documents.model.IGILogicalInterfaces"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.stream.Collectors"%>
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
	String irsSpecificationId = (String)request.getAttribute("irsSpecificationId");
	List<IGILogicalInterfaces> logicalInterfaceList = (List<IGILogicalInterfaces>)request.getAttribute("logicalInterfaceList"); 
	List<Object[]> dataCarryingConnectionList = (List<Object[]>)request.getAttribute("dataCarryingConnectionList"); 
	List<Object[]> irsSpecificationsList = (List<Object[]>)request.getAttribute("irsSpecificationsList"); 
	IRSDocumentSpecifications irsSpecifications = (IRSDocumentSpecifications)request.getAttribute("irsDocSpecifications"); 
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
    
    <div class="container-fluid">
       
    	<div class="card shadow-nohover" style="margin-top: -0.6pc">
        	<div class="card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
            	<div class="row">
               		<div class="col-md-7" align="left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                      Specification Details - <%=documentNo %>
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
                	</div>
                    <div class="col-md-3" align="right">
	                    <form action="#" id="inlineapprform">
							      			 
					        <button type="submit" class="btn btn-info btn-sm shadow-nohover back" formaction="IRSSpecificationsDetails.htm" data-toggle="tooltip" title="Edit">
								ADD NEW SPEC
					        </button>
					        <button type="submit" class="btn btn-info btn-sm shadow-nohover back" formaction="IRSDocumentDetails.htm" data-toggle="tooltip" title="Back">
					        	BACK
					        </button>
					        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					        <input type="hidden" name="irsSpecificationId" value="0">
					        <input type="hidden" name="docId" value="<%=docId%>"> 
							<input type="hidden" name="docType" value="<%=docType%>"> 
							<input type="hidden" name="documentNo" value="<%=documentNo%>">
							<input type="hidden" name="projectId" value="<%=projectId%>">
							<input type="hidden" name="irsDocId" value="<%=docId%>">
					    </form>
                    </div>
            	</div>
        	</div>
        	<div class="card-body">
        		<form action="IRSSpecificationsSubmit.htm" method="post">
        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        			<input type="hidden" name="docId" value="<%=docId %>" />
        			<input type="hidden" name="docType" value="<%=docType %>" />
        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
        			<input type="hidden" name="projectId" value="<%=projectId %>" />
        			<input type="hidden" name="irsSpecificationId" value="<%=irsSpecificationId %>" />
	        		<div class="card">
	        			<div class="card-body">
	        				<div class="form-group">
	        					<div class="row">
	        						<div class="col-md-2">
	        							<label class="form-lable">Connection<span class="mandatory">*</span></label>
		        						<select class="form-control selectdee conInterfaceId" name="conInterfaceId" id="conInterfaceId"
		        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
											<option value="" disabled selected>Choose...</option>
									        <% for(Object[] obj : dataCarryingConnectionList){ %>
									        	<option value="<%=obj[0] %>" <%if(irsSpecifications!=null && irsSpecifications.getConInterfaceId()==Long.parseLong(obj[0].toString())) {%>selected<%} %> ><%=obj[3] %></option>
									        <%} %>
										</select>
        							</div>
	        						<div class="col-md-2">
	        							<label class="form-lable">Message Id<span class="mandatory">*</span></label>
		        						<select class="form-control selectdee logicalInterfaceId" name="logicalInterfaceId" id="logicalInterfaceId"
		        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
											<option value="" disabled selected>Choose...</option>
									        <% for(IGILogicalInterfaces iface : logicalInterfaceList){ %>
									        	<option value="<%=iface.getLogicalInterfaceId() %>" <%if(irsSpecifications!=null && irsSpecifications.getLogicalInterfaceId().equals(iface.getLogicalInterfaceId())) {%>selected<%} %>><%=iface.getMsgCode() %></option>
									        <%} %>
										</select>
        							</div>
        							<div class="col-md-2">
	        							<label class="form-lable">Info Name<span class="mandatory">*</span></label>
	        							<select class="form-control" name="infoName" id="infoName" required>
											<option value="" disabled selected>Choose...</option>
											<option value="Track Data" <%if(irsSpecifications!=null && irsSpecifications.getInfoName().equalsIgnoreCase("Track Data")) {%>selected<%} %> >Track Data</option>
											<option value="Search" <%if(irsSpecifications!=null && irsSpecifications.getInfoName().equalsIgnoreCase("Search")) {%>selected<%} %>>Search</option>
											<option value="Plot" <%if(irsSpecifications!=null && irsSpecifications.getInfoName().equalsIgnoreCase("Plot")) {%>selected<%} %>>Plot</option>
											<option value="Command" <%if(irsSpecifications!=null && irsSpecifications.getInfoName().equalsIgnoreCase("Command")) {%>selected<%} %>>Command</option>
										</select>
	        						</div>
        							<div class="col-md-3">
	        							<label class="form-lable">Action at Destination<span class="mandatory">*</span></label>
	        							<input type="text" class="form-control" name="actionAtDest" <%if(irsSpecifications!=null && irsSpecifications.getActionAtDest()!=null) {%>value="<%=irsSpecifications.getActionAtDest()%>"<%} %> placeholder="Enter Action at Destination" maxlength="255" required>
	        						</div>
	        					</div>
	        				</div>
	        				
	        				<div class="center">
	        					<%if(irsSpecificationId.equalsIgnoreCase("0")) {%>
		        					<button type="submit" class="btn btn-sm submit" onclick="return confirm('Are you Sure to Submit?')">
		        						SUBMIT
		        					</button>
	        					<%} else{%>
	        						<button type="submit" class="btn btn-sm edit" onclick="return confirm('Are you Sure to Update?')">
		        						UPDATE
		        					</button>
	        					<%} %>
	        				</div>	
	        				
	        			</div>
	        		</div>			
	        	</form>
	        	
	        	<hr class="mt-4 mb-4">	
	        	
        		<div class="table-responsive table-wrapper"> 
        			<input type="text" id="searchBar" class="search-bar form-control" placeholder="Search..." style="float: right;width: auto;" />
       				<br>
                	<table class="table activitytable" id="dataTable">
                    	<thead class="center">
                    		<tr>
                    			<th>SN</th>
                    			<th>Connection ID</th>
                    			<th>Message Id</th>
                    			<th>Info Name</th>
                    			<th>Source</th>
                    			<th>Destination</th>
                    			<th>Action at Dest</th>
                    			<th>Action</th>
	                    	</tr>
                    	</thead>
                    	<tbody>
                    		<%if(irsSpecificationsList!=null && irsSpecificationsList.size()>0) {
                    			int slno = 0;
                    			for(Object[] obj : irsSpecificationsList) {
                    				String[] split = obj[6].toString().split("_");
                    		%>
                    			<tr>
                    				<td class="center"><%=++slno %></td>
                    				<td><%=obj[6] %></td>
                    				<td><%=obj[7] %></td>
                    				<td><%=obj[4] %></td>
                    				<td><%=split[0].split("\\.")[1] %></td>
                    				<td><%=split[1] %></td>
                    				<td><%=obj[5] %></td>
                    				<td class="center">
                    					<form action="#" id="inlineapprform<%=slno%>">
						      			 
									        <%-- <button type="button" onclick="openConnectionEditModal('<%=slno%>')">
									            <img src="view/images/edit.png" alt="Edit">
									        </button> --%>
									        <button type="submit" class="editable-clicko" formaction="IRSSpecificationsDetails.htm" data-toggle="tooltip" title="Edit">
									            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
									        </button>
									        <button type="submit" class="editable-clicko" formaction="IRSSpecificationDelete.htm" data-toggle="tooltip" title="Delete" onclick="return confirm('Are you sure to Delete?')">
									            <i class="fa fa-lg fa-trash" style="padding: 0px;color: red;font-size: 25px;" aria-hidden="true"></i>
									        </button>
									        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
									        <input type="hidden" name="irsSpecificationId" id="irsSpecificationId_<%=slno%>" value="<%=obj[0] %>">
									        <input type="hidden" name="docId" value="<%=docId%>"> 
											<input type="hidden" name="docType" value="<%=docType%>"> 
											<input type="hidden" name="documentNo" value="<%=documentNo%>">
											<input type="hidden" name="projectId" value="<%=projectId%>">
									    </form>
                    				</td>
                    			</tr>
                    		<%} }%>
                    	</tbody>
                    </table>	
            	</div>        
        	</div>
        </div>
 	</div>
 
 <script type="text/javascript">
 	$(document).ready(function () {
	    $('#searchBar').on('keyup', function () {
	        const searchTerm = $(this).val().toLowerCase();
	        $('#dataTable tbody tr').filter(function () {
	            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
	        });
	    });
	});
 </script>	
</body>
</html>