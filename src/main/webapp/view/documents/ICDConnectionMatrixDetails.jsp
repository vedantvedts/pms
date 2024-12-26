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


</style>
</head>
<body>
<%

	String docId = (String)request.getAttribute("docId");
	String docType = (String)request.getAttribute("docType");
	String documentNo = (String)request.getAttribute("documentNo");
	String projectId = (String)request.getAttribute("projectId");
	List<Object[]> productTreeList = (List<Object[]>)request.getAttribute("productTreeList"); 
	List<IGIInterface> igiInterfaceList = (List<IGIInterface>)request.getAttribute("igiInterfaceList"); 
	List<Object[]> icdConnectionsList = (List<Object[]>)request.getAttribute("icdConnectionsList"); 
	
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
               		<div class="col-md-9" align="left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                      Connection Matrix Details - <%=documentNo %>
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
                	</div>
                    <div class="col-md-1" align="right">
                        <a class="btn btn-info btn-sm shadow-nohover back" style="position: relative;" href="ICDDocumentDetails.htm?icdDocId=<%=docId %>">Back</a>
                    </div>
            	</div>
        	</div>
        	<div class="card-body">
        		<form action="ICDConnectionMatrixSubmit.htm" method="post">
        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        			<input type="hidden" name="docId" value="<%=docId %>" />
        			<input type="hidden" name="docType" value="<%=docType %>" />
        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
        			<input type="hidden" name="projectId" value="<%=projectId %>" />
	        		<table class="customtable">
	        			<thead>
	        				<tr>
	        					<th width="20%">Sub System</th>
	        					<th width="20%">Sub System</th>
	        					<th width="40%">Interface</th>
	        					<th width="20%">Action</th>
	        				</tr>
	        			</thead>	
	        			<tbody>
	        				<tr>
	        					<td>
	        						<select class="form-control selectdee subSystemOne" name="subSystemOne" id="subSystemOne" data-live-search="true" data-container="body" required>
								        <option value="" disabled selected>Choose...</option>
								        <% for(Object[] obj : productTreeList){ %>
								        	<option value="<%=obj[0]+"/"+obj[7] %>"><%=obj[7] %></option>
								        <%} %>
									</select>
	        					</td>
	        					<td>
	        						<select class="form-control selectdee subSystemTwo" name="subSystemTwo" id="subSystemTwo" data-live-search="true" data-container="body" required>
										<option value="" disabled selected>Choose...</option>
								        <% for(Object[] obj : productTreeList){ %>
								        	<option value="<%=obj[0]+"/"+obj[7] %>"><%=obj[7] %></option>
								        <%} %>
									</select>
	        					</td>
	        					<td>
	        						<select class="form-control selectdee interfaceId" name="interfaceId" id="interfaceId" multiple data-placeholder="Choose..." data-live-search="true" data-container="body" required>
								        <% for(IGIInterface igiinterface : igiInterfaceList){ %>
								        	<option value="<%=igiinterface.getInterfaceId() %>"><%=igiinterface.getInterfaceCode() %></option>
								        <%} %>
									</select>
	        					</td>
	        					<td>
	        						<button type="submit" class="btn btn-sm submit" onclick="confirm('Are you Sure to Submit?')">
	        							SUBMIT
	        						</button>
	        					</td>
	        				</tr>
	        			</tbody>	
	        		</table>
	        	</form>
	        	
	        	<hr class="mt-4 mb-4">	
	        	
        		<div class="table-responsive table-wrapper"> 
                	<table class="table table-bordered table-hover table-striped table-condensed" id="myTable">
                    	<thead class="center">
                    		<tr>
                    			<th>Connection ID</th>
                    			<th>Sub-System 1</th>
                    			<th>Sub-System 2</th>
                    			<th>Interface Code</th>
                    			<th>Interface Type</th>
                    			<th>Transmission Speed</th>
                    			<th>Data Format</th>
                    			<th>Action</th>
	                    	</tr>
                    	</thead>
                    	<tbody>
                    		<%if(icdConnectionsList!=null && icdConnectionsList.size()>0) {
                    			int slno = 0;
                    			for(Object[] obj : icdConnectionsList) {
                    				++slno;
                    		%>
                    			<tr>
                    				<td class="center">
                    					<%=obj[4]+"_"+obj[5]+((slno>=100)?"_"+slno:((slno>=10)?"_0"+slno:"_00"+slno)) %>
                    				</td>
                    				<td class="center"><%=obj[4] %></td>
                    				<td class="center"><%=obj[5] %></td>
                    				<td class="center"><%=obj[8] %></td>
                    				<td><%=obj[10] %></td>
                    				<td><%=obj[13] %></td>
                    				<td><%=obj[11] %></td>
                    				<td class="center">
						      			 <form action="ICDConnectionDelete.htm" method="POST" id="inlineapprform<%=slno%>">
									        <button type="submit" class="editable-clicko" onclick="return confirm('Are you sure to delete?')">
									            <img src="view/images/delete.png" alt="Delete">
									        </button>
									        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
									        <input type="hidden" name="icdConnectionId" value="<%=obj[0] %>">
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
	    // Function to synchronize options between dropdowns
	    function syncDropdowns(sourceId, targetId) {
	        // Get the selected value in the source dropdown
	        var selectedValue = $('#' + sourceId).val();
	
	        // Enable all options in the target dropdown
	        $('#' + targetId + ' option').prop('disabled', false);
	
	        // If a value is selected, disable it in the target dropdown
	        if (selectedValue) {
	            $('#' + targetId + ' option[value="' + selectedValue + '"]').prop('disabled', true);
	        }
	    }
	
	    // When the first dropdown changes
	    $('#subSystemOne').on('change', function () {
	        syncDropdowns('subSystemOne', 'subSystemTwo');
	    });
	
	    // When the second dropdown changes
	    $('#subSystemTwo').on('change', function () {
	        syncDropdowns('subSystemTwo', 'subSystemOne');
	    });
	});
	
	$(document).ready(function() {
        $('#myTable').DataTable({
            "lengthMenu": [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 100],
            "pagingType": "simple",
            "pageLength": 5
        });
    });
	
</script> 	
</body>
</html>