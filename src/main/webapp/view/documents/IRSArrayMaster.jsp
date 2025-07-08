<%@page import="com.vts.pfms.documents.model.IRSArrayMaster"%>
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

</style>
</head>
<body>
	<%
		List<IRSArrayMaster> arrayMasterList = (List<IRSArrayMaster>) request.getAttribute("arrayMasterList");
		String docId = (String)request.getAttribute("docId");
		String docType = (String)request.getAttribute("docType");
		String documentNo = (String)request.getAttribute("documentNo");
		String projectId = (String)request.getAttribute("projectId");
		String irsDocId = (String)request.getAttribute("irsDocId");
		String arrayMasterId = (String)request.getAttribute("arrayMasterId");
		
		IRSArrayMaster arrayMaster = arrayMasterList.stream().filter(e -> e.getArrayMasterId()==Long.parseLong(arrayMasterId)).findAny().orElse(null);
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
	                      Array Master - <%=documentNo %>
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
                	</div>
                    <div class="col-md-1" align="right">
                    	<form action="#" method="post">
					        <button type="submit" class="btn btn-info btn-sm shadow-nohover back" formaction="IRSSpecificationsDetails.htm" data-toggle="tooltip" title="Back">
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
        		<div class="row">
        			<div class="ml-2 mr-2" style="width: 45%;">
        				<div class="table-responsive table-wrapper" >
      						<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable" >
								<thead class="center" style="background: #055C9D;color: white;">
						      		<tr>
						     	 		<th width="10%">SN</th>
						      			<th width="40%">Array Name</th>
						      			<th width="28%">Array Value</th>
						      			<th width="20%">Action</th>
						      		</tr>
						      	</thead>
		      
		      					<tbody>
		      						<%if(arrayMasterList!=null && arrayMasterList.size()>0) {
		      							int slno=0;
		    							for(IRSArrayMaster arr : arrayMasterList){
		      						%>
										<tr>
								      		<td class="center"><%=++slno %></td>
								      		<td><%=arr.getArrayName() %></td>
								      		<td class="center"><%=arr.getArrayValue() %></td>
								      		<td class="center">
								      			 <form action="IRSArrayMaster.htm" method="POST" id="inlineapprform<%=slno%>">
											        <button type="submit" class="editable-clicko" formmethod="post" data-toggle="tooltip" title="Edit">
											            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
											        </button>
											        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
											        <input type="hidden" name="arrayMasterId" value="<%=arr.getArrayMasterId() %>">
											        <input type="hidden" name="irsDocId" value="<%=irsDocId%>"> 
											        <input type="hidden" name="docId" value="<%=docId%>"> 
													<input type="hidden" name="docType" value="<%=docType%>"> 
													<input type="hidden" name="documentNo" value="<%=documentNo%>">
											    </form>
								      		</td>
								      	</tr>
		      						<%}}else{ %>
		      						<tr><td colspan="4" style="text-align: center">No Documents Added!</tr>
		      						<%} %>
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
		      					<button type="submit" class="btn btn-sm add" name="arrayMasterId" value="0" formaction="IRSArrayMaster.htm" data-toggle="tooltip" title="Add">
									ADD
						        </button>
		      				</form>
		      			</div>
        			</div>
        			
        			<div class="ml-2 mr-2" style="width: 0.1%; border-left: 1px solid #000;"></div>
        			
        			<div class="ml-2 mr-2" style="width: 51%">
        				<div class="card shadow-nohover">
        					<div class="card-header" style="background-color: #055C9D;">
        						<h5 class="text-white">Array Master <%if(arrayMaster!=null) {%>Edit<%} else {%>Add<%} %></h5>
        					</div>
        					<div class="card-body">
        						<form action="IRSArrayMasterDetailsSubmit.htm" method="post">
        							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        							<input type="hidden" name="arrayMasterId" value="<%=arrayMasterId %>">
        							<input type="hidden" name="docId" value="<%=docId%>"> 
									<input type="hidden" name="docType" value="<%=docType%>"> 
									<input type="hidden" name="documentNo" value="<%=documentNo%>">
									<input type="hidden" name="projectId" value="<%=projectId%>">
									<input type="hidden" name="irsDocId" value="<%=docId%>">
        							<div class="row">
        								<div class="col-md-5">
        									<label class="form-label">Array Name: <span class="mandatory">*</span></label>
        									<input type="text" class="form-control" name="arrayName" placeholder="Enter Array Name" maxlength="255"
        									<%if(arrayMaster!=null && arrayMaster.getArrayName()!=null) {%> value="<%=arrayMaster.getArrayName() %>" <%} %> required>
        								</div>
        								<div class="col-md-4">
        									<label class="form-label">Array Value: <span class="mandatory">*</span></label>
        									<input type="number" class="form-control" name="arrayValue" placeholder="Enter Array Value" min="0" max="9999999999"
        									<%if(arrayMaster!=null && arrayMaster.getArrayValue()!=null) {%> value="<%=arrayMaster.getArrayValue() %>" <%} %> required>
        								</div>
        								<div class="col-md-2 center" style="margin-top: auto;">
        									<%if(arrayMaster!=null) {%>
												<button type="submit" class="btn btn-sm edit" name="action" value="Edit" onclick="return confirm('Are you sure to Update?')">UPDATE</button>
											<%} else {%>
												<button type="submit" class="btn btn-sm submit" name="action" value="Add" onclick="return confirm('Are you sure to Submit?')">SUBMIT</button>
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
$(document).ready(function() {
    $('#myTable').DataTable({
        "lengthMenu": [10, 25, 50, 75, 100],
        "pagingType": "simple",
        "pageLength": 10
    });
});
</script>	  			
</body>
</html>