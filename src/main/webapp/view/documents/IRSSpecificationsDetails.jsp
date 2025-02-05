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
	List<IGIInterface> logicalInterfaceList = igiInterfaceList.stream().filter(e -> e.getInterfaceType()!=null && e.getInterfaceType().equalsIgnoreCase("Logical Interface") && e.getIsActive()==1).collect(Collectors.toList());
	List<Object[]> irsSpecificationsList = (List<Object[]>)request.getAttribute("irsSpecificationsList"); 
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
	                      Specification Details - <%=documentNo %>
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
                	</div>
                    <div class="col-md-1" align="right">
                        <a class="btn btn-info btn-sm shadow-nohover back" style="position: relative;" href="IRSDocumentDetails.htm?irsDocId=<%=docId %>">Back</a>
                    </div>
            	</div>
        	</div>
        	<div class="card-body">
        		<form action="IRSSpecificationsSubmit.htm" method="post" id="connectionForm">
        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        			<input type="hidden" name="docId" value="<%=docId %>" />
        			<input type="hidden" name="docType" value="<%=docType %>" />
        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
        			<input type="hidden" name="projectId" value="<%=projectId %>" />
	        		<table class="customtable">
	        			<thead>
	        				<tr>
	        					<th width="15%">Sub-System 1</th>
	        					<th width="15%">Super Sub-System 1</th>
	        					<th width="15%">Sub-System 2</th>
	        					<th width="15%">Super Sub-System 2</th>
	        					<th width="20%">Interface</th>
	        					<th width="10%">Message Type</th>
	        					<th width="10%">Action</th>
	        				</tr>
	        			</thead>	
	        			<tbody>
	        				<tr>
	        					<td>
	        						<select class="form-control selectdee subSystem1" name="subSystemOne" id="subSystem1" onchange="getSuperSubLevelList('1')" data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
								        <option value="" disabled selected>Choose...</option>
								        <% for(Object[] obj : productTreeList){ %>
								        	<option value="<%=obj[0]+"/"+obj[7] %>" data-id="<%=obj[0]%>"><%=obj[2]+" ("+obj[7]+")" %></option>
								        <%} %>
									</select>
	        					</td>
	        					<td>
	        						<select class="form-control selectdee superSubSystem1" name="superSubSystemOne" id="superSubSystem1" data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
									</select>
	        					</td>
	        					<td>
	        						<select class="form-control selectdee subSystem2" name="subSystemTwo" id="subSystem2" onchange="getSuperSubLevelList('2')" data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
										<option value="" disabled selected>Choose...</option>
								        <% for(Object[] obj : productTreeList){ %>
								        	<option value="<%=obj[0]+"/"+obj[7] %>" data-id="<%=obj[0]%>"><%=obj[2]+" ("+obj[7]+")" %></option>
								        <%} %>
									</select>
	        					</td>
	        					<td>
	        						<select class="form-control selectdee superSubSystem2" name="superSubSystemTwo" id="superSubSystem2" data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
									</select>
	        					</td>
	        					<td>
	        						<select class="form-control selectdee interfaceId" name="interfaceId" id="interfaceId" multiple data-placeholder="Choose..." data-live-search="true" data-container="body" required>
								        <% for(IGIInterface igiinterface : logicalInterfaceList){ %>
								        	<option value="<%=igiinterface.getInterfaceId() %>"><%=igiinterface.getInterfaceName() %> (<%=igiinterface.getInterfaceCode() %>)</option>
								        <%} %>
									</select>
	        					</td>
	        					<td>
	        						<select class="form-control" name="messageType" required>
    									<option value="" selected disabled>----select----</option>
    									<option value="Link Management">Link Management</option>
    									<option value="Control Message">Control Message</option>
    									<option value="Acknowledgement">Acknowledgement</option>
    									<option value="Track Report">Track Report</option>
    									<option value="Others">Others</option>
    								</select>
	        					</td>
	        					<td>
	        						<button type="submit" class="btn btn-sm submit" onclick="return validateConnectionsForm()">
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
                    			<th>Specification ID</th>
                    			<th>Sub-System 1</th>
                    			<th>Sub-System 2</th>
	        					<th>Super Sub-System 1</th>
                    			<th>Super Sub-System 2</th>
                    			<th>Interface Code</th>
                    			<th>Message Type</th>
                    			<!-- <th>Interface Type</th> -->
                    			<th>Transmission Speed</th>
                    			<th>Data Format</th>
                    			<th>Action</th>
	                    	</tr>
                    	</thead>
                    	<tbody>
                    		<%-- <%if(irsSpecificationsList!=null && irsSpecificationsList.size()>0) {
                    			int slno = 0;
                    			for(Object[] obj : irsSpecificationsList) {
                    				
                    		%>
                    			<tr>
                    				<td class="center"><%=++slno %></td>
                    				<!-- <td class="center">
                    					
                    				</td> -->
                    				<td class="center"><%=obj[6]+"_"+obj[7] %></td>
                    				<td class="center"><%=obj[13]+"_"+obj[14] %></td>
                    				<td class="center"><%=obj[20] %></td>
                    				<td class="center"><%=obj[5] %></td>
                    				<td><%=obj[23] %></td>
                    				<td><%=obj[26] %></td>
                    				<td><%=obj[24] %></td>
                    				<td class="center">
						      			 <form action="IRSSpecificationDelete.htm" method="POST" id="inlineapprform<%=slno%>">
									        <button type="submit" class="editable-clicko" onclick="return confirm('Are you sure to delete?')">
									            <img src="view/images/delete.png" alt="Delete">
									        </button>
									        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
									        <input type="hidden" name="irsSpecificationId" value="<%=obj[0] %>">
									        <input type="hidden" name="docId" value="<%=docId%>"> 
											<input type="hidden" name="docType" value="<%=docType%>"> 
											<input type="hidden" name="documentNo" value="<%=documentNo%>">
											<input type="hidden" name="projectId" value="<%=projectId%>">
									    </form>
						      		</td>
                    			</tr>
                    		<%} }%> --%>
                    		<%if(irsSpecificationsList!=null && irsSpecificationsList.size()>0) {
                    			int count = 0;
                    			int slno = 0;
                    			String systemOne1 = "", systemTwo1 = "", subSystemOne1 = "", subSystemTwo1 = "";

                    			for(Object[] obj : irsSpecificationsList) {
                    				
                    				String systemOne2 = obj[4]+"";
                    				String systemTwo2 = obj[5]+"";
                    				String subSystemOne2 = obj[16]+"";
                    				String subSystemTwo2 = obj[17]+"";
                    				
                    				if(!systemOne1.equalsIgnoreCase(systemOne2) || !systemTwo1.equalsIgnoreCase(systemTwo2) ||
                    				   !subSystemOne1.equalsIgnoreCase(subSystemOne2) || !subSystemTwo1.equalsIgnoreCase(subSystemTwo2)	) {
                    					systemOne1 = systemOne2;
                    					systemTwo1 = systemTwo2;
                    					subSystemOne1 = subSystemOne2;
                    					subSystemTwo1 = subSystemTwo2;
                    					count = 0;
                    				}
                    				
                    				++count;
                    		%>
                    			<tr>
                    				<td class="center"><%=++slno %></td>
                    				<td class="center">
                    					<%=obj[4] + "_" + obj[5] + "_" + obj[8] + ((count>=100)?"_"+count:((count>=10)?"_0"+count:"_00"+count)) %>
                    				</td>
                    				<td class="center"><%=obj[4] %></td>
                    				<td class="center"><%=obj[5] %></td>
                    				<td class="center"><%=obj[16] %></td>
                    				<td class="center"><%=obj[17] %></td>
                    				<td class="center"><%=obj[8] %></td>
                    				<td><%=obj[18] %></td>
                    				<td><%=obj[13] %></td>
                    				<td><%=obj[11] %></td>
                    				<td class="center">
						      			 <form action="IRSConnectionDelete.htm" method="POST" id="inlineapprform<%=count%>">
									        <button type="submit" class="editable-clicko" onclick="return confirm('Are you sure to delete?')">
									            <img src="view/images/delete.png" alt="Delete">
									        </button>
									        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
									        <input type="hidden" name="irsSpecificationId" value="<%=obj[0] %>">
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
$(document).ready(function() {
    $('#myTable').DataTable({
        "lengthMenu": [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 100],
        "pagingType": "simple",
        /* "pageLength": 5 */
    });
});

function getSuperSubLevelList(rowId){

	var projectId = '<%=projectId%>';
	var subSystemId = $('.subSystem'+rowId+' option:selected').attr('data-id');
	
	$.ajax({
		type : "GET",
		url : "GetProductTreeListByLevel.htm",	
		datatype : 'json',
		data : {
			subSystemId : subSystemId,				
			levelId : 2,				
			projectId : projectId,				
		},
		success : function(result) {
			var result = JSON.parse(result);
			var values = Object.keys(result).map(function(e) {return result[e]});
			
			var s = '';
			s += '<option value="0">Not Applicable</option>';
			for (i = 0; i < values.length; i++) {									
				s += '<option value="'+values[i][0]+"/"+values[i][7]+'">'+values[i][2] + " (" +values[i][7]+ ")" + '</option>';
			} 
						 
			$('#superSubSystem'+rowId).html(s);
			
		}
	});
}

function validateConnectionsForm() {
	
	var subSystem1 = $('#subSystem1').val();
	var subSystem2 = $('#subSystem2').val();
	var superSubSystem1 = $('#superSubSystem1').val();
	var superSubSystem2 = $('#superSubSystem2').val();
	
	console.log('subSystem1', subSystem1);
	console.log('superSubSystem1', superSubSystem1);
	console.log('subSystem2', subSystem2);
	console.log('superSubSystem2', subSystem2);
	if((subSystem1!=null && subSystem2!=null && subSystem1 === subSystem2) && (superSubSystem1!=null && superSubSystem2!=null && superSubSystem1 === superSubSystem2) ) {
		alert('Same System Connection is not allowed');
		event.preventDefault();
		return false;
	}else {
		if(confirm('Are You Sure to Submit?')){
			$('#superSubSystem1').submit();
		}else {
			event.preventDefault();
			return false;
		}
	}
}
	
</script> 	
</body>
</html>