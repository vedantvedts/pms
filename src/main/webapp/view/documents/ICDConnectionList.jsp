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
.middle {
	vertical-align: middle !important;
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
	PfmsICDDocument icdDocument = (PfmsICDDocument)request.getAttribute("icdDocument"); 
	
	List<Object[]> productTreeAllList = (List<Object[]>)request.getAttribute("productTreeAllList"); 
	
	//List<Object[]> productTreeList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
	//List<Object[]> productTreeSubList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("2")).collect(Collectors.toList());

	
	List<IGIInterface> igiInterfaceList = (List<IGIInterface>)request.getAttribute("igiInterfaceList"); 
	igiInterfaceList = igiInterfaceList.stream().filter(e -> e.getIsActive()==1).collect(Collectors.toList());
	
	List<ICDPurpose> icdPurposeList = (List<ICDPurpose>)request.getAttribute("icdPurposeList"); 
	icdPurposeList = icdPurposeList.stream().filter(e -> e.getIsActive()==1).collect(Collectors.toList());
	
	List<ICDConnectionDTO> icdConnectionsList = (List<ICDConnectionDTO>)request.getAttribute("icdConnectionsList"); 
	
	//Map<String, List<ICDConnectionDTO>> icdConnectionsListToListMap = icdConnectionsList!=null && icdConnectionsList.size()>0?icdConnectionsList.stream()
	//		  .collect(Collectors.groupingBy(e -> (e.getICDConnectionId()+""), LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
	
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
               		<div class="col-md-9 left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                      Connection-Interface List - <%=documentNo %>
	                    </h5>
                	</div>
                	<div class="col-md-3 right">
                		<!-- <button class="btn btn-sm btn-info" data-toggle="modal" data-target="#connectinoMatrixModal">Connection Matrix</button> -->
						<form action="ICDConnectionMatrixDetails.htm" method="post" id="myform1">
                    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        			<input type="hidden" name="icdDocId" value="<%=docId %>" />
		        			<input type="hidden" name="docId" value="<%=docId %>" />
		        			<input type="hidden" name="docType" value="<%=docType %>" />
		        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
		        			<input type="hidden" name="projectId" value="<%=projectId %>" />
		        			
		        			<button class="btn btn-info btn-sm shadow-nohover back" formaction="ICDSystemDrawingDetails.htm" data-toggle="tooltip" title="System Drawings">
		        				SYSTEM DRAWINGS
		        			</button>
		        			<button class="btn btn-info btn-sm shadow-nohover back" data-toggle="tooltip" title="Interface Matrix">
		        				INTERFACE MATRIX
		        			</button>
		        			<button class="btn btn-info btn-sm shadow-nohover back" formaction="ICDDocumentDetails.htm" data-toggle="tooltip" title="Back">
		        				BACK
		        			</button>
                		</form>                	
                	</div>
            	</div>
        	</div>
        	<div class="card-body">
        		<div class="table-responsive"> 
        			<!-- <input type="text" id="searchBar" class="search-bar form-control" placeholder="Search..." style="float: right;width: auto;" />
       				<br> -->
      				<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable" >
                    	<thead class="center">
                    		<tr>
                    			<th width="5%">SN</th>
                    			<th width="20%">End-1</th>
                    			<th width="20%">End-2</th>
                    			<th width="25%">Interface</th>
                    			<th width="20%">Purpose</th>
                    			<th width="10%">Action</th>
	                    	</tr>
                    	</thead>
                    	<tbody>
                    		<%if (icdConnectionsList!=null && icdConnectionsList.size() > 0) {
								int slno = 0;
          						for (ICDConnectionDTO con : icdConnectionsList) {
							%>
                    			<tr>
									<td class="center middle"><%=++slno %></td>
									<td ><%=con.getLevelNamesS1() %></td>
									<td ><%=con.getLevelNamesS2() %></td>
									<td ><%=con.getInterfaceNames()!=null?con.getInterfaceNames():"-" %></td>
									<td ><%=con.getPurpose()!=null?con.getPurpose():"-" %></td>
                    				<td class="center middle">
                    					<form action="#" method="post" id="inlineactform<%=slno%>">
	                    					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						        			<input type="hidden" name="icdDocId" value="<%=docId %>" />
						        			<input type="hidden" name="docId" value="<%=docId %>" />
						        			<input type="hidden" name="docType" value="<%=docType %>" />
						        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
						        			<input type="hidden" name="projectId" value="<%=projectId %>" />
						        			<input type="hidden" name="icdConnectionId" value="<%=con.getICDConnectionId() %>" />
						        			
                    						<button type="submit" class="editable-clicko" formaction="ICDConnectionDetails.htm" data-toggle="tooltip" title="Edit">
									            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
									        </button>
									        <button type="submit" class="editable-clicko" formaction="ICDConnectionPinDetails.htm" data-toggle="tooltip" title="Add Pin Details">
									            <i class="fa fa-plug" style="padding: 0px;color: #ff00e9ab;font-size: 21px;" aria-hidden="true"></i>
									        </button>	
                    					</form>
					      			</td>
                    				
                    			</tr>
							<%} }%>
                    	</tbody>
        			</table>
				</div>
	        	<div class="center">
	        		<button form="myform1" type="submit" class="btn btn-sm add" formaction="ICDConnectionDetails.htm" data-toggle="tooltip" title="Add">
						ADD
			        </button>
	        	</div>
        	</div>
        </div>
 	</div>
	
<script type="text/javascript">
	
	$(document).ready(function () {
	    /* $('#searchBar').on('keyup', function () {
	        const searchTerm = $(this).val().toLowerCase();
	        $('#dataTable tbody tr').filter(function () {
	            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
	        });
	    });
	    $('#searchBar2').on('keyup', function () {
	        const searchTerm = $(this).val().toLowerCase();
	        $('#dataTable2 tbody tr').filter(function () {
	            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
	        });
	    }); */
	    
		$('#myTable').DataTable({
	        "lengthMenu": [10, 25, 50, 75, 100],
	        "pagingType": "simple",
	        "pageLength": 10
	    });
	});
</script> 	
</body>
</html>