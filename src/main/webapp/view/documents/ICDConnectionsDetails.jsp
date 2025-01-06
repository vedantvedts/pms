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
	igiInterfaceList = igiInterfaceList.stream().filter(e -> e.getIsActive()==1).collect(Collectors.toList());
	List<Object[]> icdConnectionsList = (List<Object[]>)request.getAttribute("icdConnectionsList"); 
	

	//List<String> subsystems = productTreeList.stream().map(obj -> obj[7].toString()).distinct().collect(Collectors.toList());

	//Map<String, String> connectionMap = new HashMap<>();

	//for (Object[] connection : icdConnectionsList) {
	//    String key = connection[4] + "_" + connection[5];
	//    int count = connectionMap.containsKey(key) ? connectionMap.get(key).split("<br>").length + 1 : 1;

	//    String seqNumber = (count >= 100) ? "_" + count : (count >= 10) ? "_0" + count : "_00" + count;

	//    String value = connection[4] + "_" + connection[5] + "_" + connection[8] + "_" + seqNumber;
	//    connectionMap.merge(key, value, (oldValue, newValue) -> oldValue + "<br>" + newValue);
	//}
	
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
	                      Connection Details - <%=documentNo %>
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
                		<!-- <button class="btn btn-sm btn-info" data-toggle="modal" data-target="#connectinoMatrixModal">Connection Matrix</button> -->
						<form action="ICDConnectionMatrixDetails.htm" method="post">
                    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        			<input type="hidden" name="docId" value="<%=docId %>" />
		        			<input type="hidden" name="docType" value="<%=docType %>" />
		        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
		        			<input type="hidden" name="projectId" value="<%=projectId %>" />
		        			<button class="btn btn-info btn-sm shadow-nohover back">
		        				Connection Matrix
		        			</button>
                		</form>                	
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
	        					<th width="20%">Sub-System 1</th>
	        					<th width="20%">Sub-System 2</th>
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
								        	<option value="<%=obj[0]+"/"+obj[7] %>"><%=obj[2]+" ("+obj[7]+")" %></option>
								        <%} %>
									</select>
	        					</td>
	        					<td>
	        						<select class="form-control selectdee subSystemTwo" name="subSystemTwo" id="subSystemTwo" data-live-search="true" data-container="body" required>
										<option value="" disabled selected>Choose...</option>
								        <% for(Object[] obj : productTreeList){ %>
								        	<option value="<%=obj[0]+"/"+obj[7] %>"><%=obj[2]+" ("+obj[7]+")" %></option>
								        <%} %>
									</select>
	        					</td>
	        					<td>
	        						<select class="form-control selectdee interfaceId" name="interfaceId" id="interfaceId" multiple data-placeholder="Choose..." data-live-search="true" data-container="body" required>
								        <% for(IGIInterface igiinterface : igiInterfaceList){ %>
								        	<option value="<%=igiinterface.getInterfaceId() %>"><%=igiinterface.getInterfaceName() %> (<%=igiinterface.getInterfaceCode() %>)</option>
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
                    			<th>SN</th>
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
                    			int count = 0;
                    			int slno = 0;
                    			String systemOne1 = "";
                				String systemTwo1 = "";
                    			for(Object[] obj : icdConnectionsList) {
                    				
                    				String systemOne2 = obj[4]+"";
                    				String systemTwo2 = obj[5]+"";
                    				
                    				if(!systemOne1.equalsIgnoreCase(systemOne2) || !systemTwo1.equalsIgnoreCase(systemTwo2)) {
                    					systemOne1 = systemOne2;
                    					systemTwo1 = systemTwo2;
                    					count = 0;
                    				}
                    				
                    				++count;
                    		%>
                    			<tr>
                    				<td class="center"><%=++slno %></td>
                    				<td class="center">
                    					<%=obj[4] + "_" + obj[5] + "_" + obj[8] + ((count>=100)?"_"+count:((count>=10)?"_0"+count:"_00"+count)) %>
                    					<%-- <%=obj[4]+"_"+obj[5] %> --%>
                    				</td>
                    				<td class="center"><%=obj[4] %></td>
                    				<td class="center"><%=obj[5] %></td>
                    				<td class="center"><%=obj[8] %></td>
                    				<td><%=obj[10] %></td>
                    				<td><%=obj[13] %></td>
                    				<td><%=obj[11] %></td>
                    				<td class="center">
						      			 <form action="ICDConnectionDelete.htm" method="POST" id="inlineapprform<%=count%>">
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
 	
 	<!-- ----------------------------------------------- Add New Applicable Documents Modal --------------------------------------------------------------- -->
	<%-- <div class="modal fade " id="connectinoMatrixModal" tabindex="-1" role="dialog" aria-labelledby="connectinoMatrixModal" aria-hidden="true" style="">
		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
			<div class="modal-content" style="width: 200%;margin-left: -50%;">
				<div class="modal-header" style="background: #055C9D;color: white;">
		        	<h5 class="modal-title ">ICD Connection Matrix</h5>
			        <button type="button" class="close" style="text-shadow: none !important" data-dismiss="modal" aria-label="Close">
			          <span class="text-light" aria-hidden="true">&times;</span>
			        </button>
		      	</div>
     			<div class="modal-body">
     				<div class="container-fluid">
     					<div class="row">
							<div class="col-md-12 " align="left">

								<table class="customtable">
								    <thead>
								        <tr>
								            <th width="8%">Sub-System</th>
								            <% for (String subsystem : subsystems) { %>
								                <th><%= subsystem %></th>
								            <% } %>
								        </tr>
								    </thead>
								    <tbody>
								        <% 
								        for (String rowSubsystem : subsystems) { 
								        %>
								            <tr>
								                <td class="center"><%= rowSubsystem %></td>
								                <% for (String colSubsystem : subsystems) { %>
								                    <td class="center">
								                        <% 
								                        if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { 
								                            out.print("NA");
								                        } else {
								                            String key = rowSubsystem + "_" + colSubsystem;
								                            String connections = connectionMap.getOrDefault(key, "-");
								                            out.print(connections);
								                        }
								                        %>
								                    </td>
								                <% } %>
								            </tr>
								        <% } %>
								    </tbody>
								</table>

							</div>
						</div>
     				</div>
     			</div>
     		</div>
		</div>
	</div> --%>				
	<!-- ----------------------------------------------- Add New Short Codes Modal End-------------------------------------------------------- -->
	
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
            /* "pageLength": 5 */
        });
    });
	
</script> 	
</body>
</html>