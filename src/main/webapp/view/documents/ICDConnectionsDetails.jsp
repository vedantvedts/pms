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
	PfmsICDDocument icdDocument = (PfmsICDDocument)request.getAttribute("icdDocument"); 
	
	List<Object[]> productTreeAllList = (List<Object[]>)request.getAttribute("productTreeAllList"); 
	
	List<Object[]> productTreeList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
	List<Object[]> productTreeSubList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("2")).collect(Collectors.toList());

	
	List<IGIInterface> igiInterfaceList = (List<IGIInterface>)request.getAttribute("igiInterfaceList"); 
	igiInterfaceList = igiInterfaceList.stream().filter(e -> e.getIsActive()==1).collect(Collectors.toList());
	
	List<ICDPurpose> icdPurposeList = (List<ICDPurpose>)request.getAttribute("icdPurposeList"); 
	icdPurposeList = icdPurposeList.stream().filter(e -> e.getIsActive()==1).collect(Collectors.toList());
	
	List<Object[]> icdConnectionsList = (List<Object[]>)request.getAttribute("icdConnectionsList"); 
	
	Map<String, List<Object[]>> icdConnectionsListToListMap = icdConnectionsList!=null && icdConnectionsList.size()>0?icdConnectionsList.stream()
			  .collect(Collectors.groupingBy(e -> (e[2] + "_" + e[3] + "_" + e[14] + "_" + e[15] ), LinkedHashMap::new, Collectors.toList())) : new HashMap<>();
	
	String isSubSystem = icdDocument!=null && icdDocument.getProductTreeMainId()!=0? "Y": "N";
	Object[] subsystem = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId().equals(Long.parseLong(e[0].toString()))).findFirst().orElse(null);

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
        		
        		<form action="ICDConnectionMatrixSubmit.htm" method="post" id="connectionForm" enctype="multipart/form-data">
        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        			<input type="hidden" name="docId" value="<%=docId %>" />
        			<input type="hidden" name="docType" value="<%=docType %>" />
        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
        			<input type="hidden" name="projectId" value="<%=projectId %>" />
        			<input type="hidden" name="isSubSystem" id="isSubSystem" value="<%=isSubSystem %>" />
	        		<%if(isSubSystem.equalsIgnoreCase("Y")) {%>
		        		<input type="hidden" name="subSystemOne" id="subSystem1" value="<%=subsystem[0]+"/"+subsystem[7] %>">
		        		<input type="hidden" name="subSystemTwo" id="subSystem2" value="<%=subsystem[0]+"/"+subsystem[7] %>">
		        	<%} %>
	        		<div class="card">
	        			<div class="card-body">
	        				<div class="form-group">
	        					<div class="row">
	        					
		        					 <%if(isSubSystem.equalsIgnoreCase("N")) {%>
		        						<div class="col-md-2">
		        							<label class="form-lable">Sub-System 1<span class="mandatory">*</span></label>
		        							<select class="form-control selectdee subSystem1" name="subSystemOne" id="subSystem1" onchange="checkConnectionExistence()"
			        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
										        
									        	<option value="" disabled selected>Choose...</option>
										        <%
										        for(Object[] obj : productTreeList){ %>
										        	<option value="<%=obj[0]+"/"+obj[7] %>" data-id="<%=obj[0]%>" ><%=obj[2]+" ("+obj[7]+")" %></option>
										        <%} %>
											</select>
		        						</div>
		        						<div class="col-md-2">
		        							<label class="form-lable">Sub-System 2<span class="mandatory">*</span></label>
			        						<select class="form-control selectdee subSystem2" name="subSystemTwo" id="subSystem2" onchange="checkConnectionExistence()"
			        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
												<option value="" disabled selected>Choose...</option>
										        <% for(Object[] obj : productTreeList){ %>
										        	<option value="<%=obj[0]+"/"+obj[7] %>" data-id="<%=obj[0]%>"><%=obj[2]+" ("+obj[7]+")" %></option>
										        <%} %>
											</select>
	        							</div>
	        						<%} %>
	        						<%if(isSubSystem.equalsIgnoreCase("Y")) {%>
		        						<div class="col-md-2">
		        							<label class="form-lable">Super Sub-System 1<span class="mandatory">*</span></label>
		        							<select class="form-control selectdee superSubSystem1" name="superSubSystemOne" id="superSubSystem1" onchange="checkConnectionExistence()" 
		        							data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
		        								<option value="" disabled selected>Choose...</option>
										        <%
										        for(Object[] obj : productTreeSubList){ %>
										        	<option value="<%=obj[0]+"/"+obj[7] %>" data-id="<%=obj[0]%>" ><%=obj[2]+" ("+obj[7]+")" %></option>
										        <%} %>
											</select>
		        						</div>	
			        					<div class="col-md-2">
			        						<label class="form-lable">Super Sub-System 2<span class="mandatory">*</span></label>
			        						<select class="form-control selectdee superSubSystem2" name="superSubSystemTwo" id="superSubSystem2" onchange="checkConnectionExistence()" 
			        						data-placeholder="---------Select------------" data-live-search="true" data-container="body" required>
			        							<option value="" disabled selected>Choose...</option>
										        <%
										        for(Object[] obj : productTreeSubList){ %>
										        	<option value="<%=obj[0]+"/"+obj[7] %>" data-id="<%=obj[0]%>" ><%=obj[2]+" ("+obj[7]+")" %></option>
										        <%} %>
											</select>
			        					</div>
	        						<%} %>
	        						<div class="col-md-4">
	        							<label class="form-lable">Interface<span class="mandatory">*</span></label>
		        						<select class="form-control selectdee interfaceId" name="interfaceId" id="interfaceId" multiple data-placeholder="Choose..." data-live-search="true" data-container="body" required>
									        <% for(IGIInterface igiinterface : igiInterfaceList){ %>
									        	<option value="<%=igiinterface.getInterfaceId()+"/"+igiinterface.getInterfaceCode() %>"><%=igiinterface.getInterfaceName() %></option>
									        <%} %>
										</select>
	        						</div>
	        						<div class="col-md-4">
	        							<label class="form-lable">Purpose<span class="mandatory">*</span></label>
		        						<select class="form-control selectdee purpose" name="purpose" id="purposeAdd" multiple data-placeholder="Choose..." data-live-search="true" data-container="body" required>
									        <% for(ICDPurpose icdPurpose : icdPurposeList){ %>
									        	<option value="<%=icdPurpose.getPurposeId() %>"><%=icdPurpose.getPurpose() %></option>
									        <%} %>
										</select>
	        						</div>
	        						
	        					</div>
	        				</div>
	        				
	        				<div class="form-group">
	        					<div class="row">
	        						
	        						<div class="col-md-2">
	        							<label class="form-lable">Constraints<span class="mandatory">*</span></label>
	        							<!-- <textarea class="form-control" name="constraints" rows="2" cols="" placeholder="Enter Constraints" required></textarea> -->
	        							<input type="text" class="form-control" name="constraints" placeholder="Enter Constraints" required>
	        						</div>
	        						<div class="col-md-2">
	        							<label class="form-lable">Periodicity<span class="mandatory">*</span></label> <br>
	        							<input type="radio" name="periodicity" value="Periodic" required>Periodic&nbsp;
	        							<input type="radio" name="periodicity" value="Non-Periodic" required>Non-Periodic&nbsp;
	        							<input type="radio" name="periodicity" value="Descrete" required>Descrete
	        						</div>
	        						<div class="col-md-2">
	        							<label class="form-lable">Description<span class="mandatory">*</span></label>
	        							<!-- <textarea class="form-control" name="description" rows="2" cols="" placeholder="Enter Description" required></textarea> -->
	        							<input type="text" class="form-control" name="description" placeholder="Enter Periodicity Description" required>
	        						</div>
	        						<div class="col-md-2">
	        							<label class="form-lable">Drawing No</label>
	        							<input type="text" class="form-control" name="drawingNo" placeholder="Enter Drawing No" >
	        						</div>
	        						<div class="col-md-4">
	        							<label class="form-lable">Drawing Attachment</label>
	        							<input type="file" class="form-control" name="drawingAttachment" accept="application/pdf" >
	        						</div>
	        						
	        					</div>
	        				</div>	
	        				
	        				<div class="center">
	        					<button type="submit" class="btn btn-sm submit" onclick="return confirm('Are you Sure to Submit?')">
	        						SUBMIT
	        					</button>
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
                    			<%-- <th>Sub-System 1</th>
                    			<th>Sub-System 2</th>
                    			<%if(isSubSystem.equalsIgnoreCase("Y")) {%>
	                    			<th>Super Sub-System 1</th>
	                    			<th>Super Sub-System 2</th>
                    			<%} %> --%>
                    			<!-- <th>Interface Code</th>
                    			<th>Interface Type</th> -->
                    			<!-- <th>Transmission Speed</th>
                    			<th>Data Format</th> -->
                    			<th>Purpose</th>
                    			<th>Constraints</th>
                    			<th>Periodicity</th>
                    			<th>Description</th>
                    			<th>Action</th>
                    			<th>Delete</th>
	                    	</tr>
                    	</thead>
                    	<tbody>
                    		<% if (icdConnectionsListToListMap!=null && icdConnectionsListToListMap.size() > 0) {
								int slno = 0;
								for (Map.Entry<String, List<Object[]>> map : icdConnectionsListToListMap.entrySet()) {
                 							
          							List<Object[]> values = map.getValue();
          							int i=0;
          							for (Object[] obj : values) {
							%>
                    			<tr>
                    				<td class="center"><%=++slno %></td>
                    				<td id="connectionId_<%=slno%>">
                    					<%-- <%=obj[4] + "_" + obj[5] + "_" + obj[8] + ((count>=100)?"_"+count:((count>=10)?"_0"+count:"_00"+count)) %> --%>
                    					<%=obj[32] %>
                    				</td>
                    				<%-- <td class="center"><%=obj[4] %></td>
                    				<td class="center"><%=obj[5] %></td>
                    				<%if(isSubSystem.equalsIgnoreCase("Y")) {%>
	                    				<td class="center"><%=obj[16] %></td>
	                    				<td class="center"><%=obj[17] %></td>
	                    			<%} %> --%>	
                    				<%-- <td class="center"><%=obj[8] %></td>
                    				<td><%=obj[10] %></td> --%>
                    				<%-- <td><%=obj[13] %></td>
                    				<td><%=obj[11] %></td> --%>
                    				<%if(i==0) {%>
							    		<td rowspan="<%=values.size() %>" style="vertical-align: middle;"><%=obj[28]!=null?obj[28]:"-" %></td>
	                    				<td rowspan="<%=values.size() %>" style="vertical-align: middle;"><%=obj[29]!=null?obj[29]:"-"  %></td>
	                    				<td rowspan="<%=values.size() %>" style="vertical-align: middle;"><%=obj[30]!=null?obj[30]:"-"  %></td>
	                    				<td rowspan="<%=values.size() %>" style="vertical-align: middle;"><%=obj[31]!=null?obj[31]:"-"  %></td>
	                    				<td rowspan="<%=values.size() %>" style="vertical-align: middle;" class="center">
									       	<button type="button" class="editable-clicko" onclick="openNewConnectionAddModal('<%=slno%>')" data-toggle="tooltip" title="Add New Connections">
									            <i class="fa fa-plus-square fa-lg" style="padding: 0px;color: green;font-size: 25px;" aria-hidden="true"></i>
									        </button>
									        <button type="button" class="editable-clicko" onclick="openConnectionEditModal('<%=slno%>')" data-toggle="tooltip" title="Edit">
									            <i class="fa fa-lg fa-edit" style="padding: 0px;color: darkorange;font-size: 25px;" aria-hidden="true"></i>
									        </button>
						      			</td>
        							<%} %>
                    				
                    				<td class="center">
						      			 <form action="ICDConnectionDelete.htm" method="POST" id="inlineapprform<%=slno%>">
						      			 
									        <%-- <button type="button" onclick="openConnectionEditModal('<%=slno%>')">
									            <img src="view/images/edit.png" alt="Edit">
									        </button> --%>
									        <button type="submit" class="editable-clicko" data-toggle="tooltip" title="Delete" onclick="return confirm('Are you sure to Delete?')">
									            <i class="fa fa-lg fa-trash" style="padding: 0px;color: red;font-size: 25px;" aria-hidden="true"></i>
									        </button>
									        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
									        <input type="hidden" name="icdConnectionId" id="icdConnectionId_<%=slno%>" value="<%=obj[0] %>">
									        <input type="hidden" name="conInterfaceId" id="conInterfaceId_<%=slno%>" value="<%=obj[33] %>">
									        <input type="hidden" name="docId" value="<%=docId%>"> 
											<input type="hidden" name="docType" value="<%=docType%>"> 
											<input type="hidden" name="documentNo" value="<%=documentNo%>">
											<input type="hidden" name="projectId" value="<%=projectId%>">
											<input type="hidden" id="purpose_<%=slno%>" value="<%=obj[28]%>">
											<input type="hidden" id="constraints_<%=slno%>" value="<%=obj[29]%>">
											<input type="hidden" id="periodicity_<%=slno%>" value="<%=obj[30]%>">
											<input type="hidden" id="description_<%=slno%>" value="<%=obj[31]%>">
											<input type="hidden" id="drawingNo_<%=slno%>" value="<%=obj[34]%>">
											<input type="hidden" id="drawingAttachment_<%=slno%>" value="<%=obj[35]%>">
											<input type="hidden" id="purposeIds_<%=slno%>" value="<%=obj[36]%>">
											<input type="hidden" id="modalTitle_<%=slno%>" 
											<%if(isSubSystem.equalsIgnoreCase("Y")) {%>
	 											value="<%=obj[16] %>_<%=obj[17] %>"
	                    					<%} else{%>
	                    						value="<%=obj[4] %>_<%=obj[5] %>"
	                    					<%} %>
											>
									    </form>
						      		</td>
                    			</tr>
                    		<% ++i; } } } else{%>
								<tr>
									<td colspan="12" style="text-align: center;">No Data Available</td>
								</tr>
							<%} %>
                    	</tbody>
        			</table>
				</div>
	        	
        	</div>
        </div>
 	</div>
	
	<!-- -------------------------------------------- Add Connections Modal -------------------------------------------- -->
	<div class="modal fade" id="addNewConnectionModal" tabindex="-1" role="dialog" aria-labelledby="addNewConnectionModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width: 100%;margin-top: 25%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title" >Add New Connections - <span class="modalTitle"></span> </h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
       				<form action="ICDAddNewConnectionSubmit.htm" method="post">
       					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
       					<input type="hidden" name="icdConnectionId" class="icdConnectionId">
       					<input type="hidden" name="docId" value="<%=docId%>"> 
						<input type="hidden" name="docType" value="<%=docType%>"> 
						<input type="hidden" name="documentNo" value="<%=documentNo%>">
						<input type="hidden" name="projectId" value="<%=projectId%>">
						<input type="hidden" name="isSubSystem" value="<%=isSubSystem%>">
      					<div class="form-group">
        					<div class="row">
	        					
        						<div class="col-md-10">
        							<label class="form-lable">Interface<span class="mandatory">*</span></label>
	        						<select class="form-control selectdee interfaceId" name="interfaceId" id="interfaceIdEdit" multiple data-placeholder="Choose..." data-live-search="true" data-container="body" required>
								        <% for(IGIInterface igiinterface : igiInterfaceList){ %>
								        	<option value="<%=igiinterface.getInterfaceId()+"/"+igiinterface.getInterfaceCode() %>"><%=igiinterface.getInterfaceName() %></option>
								        <%} %>
									</select>
        						</div>
        					</div>	
        				</div>		
        				
        				<div class="center">
        					<button type="submit" class="btn btn-sm submit" onclick="return confirm('Are you Sure to Submit?')">
        						SUBMIT
        					</button>
        				</div>	
      				</form>
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- Add Connections Modal End -------------------------------------------- -->
	
	<!-- -------------------------------------------- Connection Edit Modal -------------------------------------------- -->
	<div class="modal fade" id="connectionEditModal" tabindex="-1" role="dialog" aria-labelledby="connectionEditModal" aria-hidden="true">
  		<div class="modal-dialog modal-lg modal-dialog-jump" role="document">
    		<div class="modal-content" style="width: 150%;margin-left: -20%;margin-top: 25%;">
      			<div class="modal-header" id="ModalHeader" style="background: #055C9D ;color: white;">
			        <h5 class="modal-title" >Connection Edit - <span class="modalTitle"></span> </h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true" class="text-light">&times;</span>
			        </button>
      			</div>
      			
      			<div class="modal-body">
       				<form action="ICDConnectionEditSubmit.htm" method="post">
       					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
       					<input type="hidden" name="icdConnectionId" class="icdConnectionId">
       					<input type="hidden" name="docId" value="<%=docId%>"> 
						<input type="hidden" name="docType" value="<%=docType%>"> 
						<input type="hidden" name="documentNo" value="<%=documentNo%>">
						<input type="hidden" name="projectId" value="<%=projectId%>">
      					<div class="form-group">
        					<div class="row">
	        					
        						<div class="col-md-5">
        							<label class="form-lable">Purpose<span class="mandatory">*</span></label>
	        						<select class="form-control selectdee purpose" name="purpose" id="purpose" multiple data-placeholder="Choose..." data-live-search="true" data-container="body" required>
								        <% for(ICDPurpose icdPurpose : icdPurposeList){ %>
								        	<option value="<%=icdPurpose.getPurposeId() %>"><%=icdPurpose.getPurpose() %></option>
								        <%} %>
									</select>
	        					</div>
        						<div class="col-md-4">
        							<label class="form-lable">Constraints<span class="mandatory">*</span></label>
        							<!-- <textarea class="form-control" name="constraints" rows="2" cols="" placeholder="Enter Constraints" required></textarea> -->
        							<input class="form-control" name="constraints" id="constraints" placeholder="Enter Constraints" required>
        						</div>
        					</div>	
        				</div>		
        				<div class="form-group">
        					<div class="row">	
        						<div class="col-md-3">
        							<label class="form-lable">Periodicity<span class="mandatory">*</span></label> <br>
        							<input type="radio" name="periodicityEdit" value="Periodic" required>Periodic&nbsp;
        							<input type="radio" name="periodicityEdit" value="Non-Periodic" required>Non-Periodic&nbsp;
        							<input type="radio" name="periodicityEdit" value="Descrete" required>Descrete
        						</div>
        						<div class="col-md-3">
        							<label class="form-lable">Description<span class="mandatory">*</span></label>
        							<!-- <textarea class="form-control" name="description" rows="2" cols="" placeholder="Enter Description" required></textarea> -->
        							<input class="form-control" name="description" id="description" placeholder="Enter Periodicity Description" required>
        						</div>
        						<div class="col-md-2">
        							<label class="form-lable">Drawing No<span class="mandatory">*</span></label>
        							<input type="text" class="form-control" name="drawingNo" id="drawingNo" placeholder="Enter Drawing No" required>
        						</div>
        						<div class="col-md-4">
        							<label class="form-lable">Drawing Attachment </label>
        							<button type="submit" class="btn btn-sm attachments" name="drawingAttach" id="drawingAttach" value="image" formaction="ICDConnectionDrawingAttachDownload.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
	                      				<i class="fa fa-download"></i>
	                      			</button>
        							<input type="file" class="form-control" name="drawingAttachment" id="drawingAttachment" accept="application/pdf">
        						</div>
        					</div>
        				</div>	
        				
        				<div class="center">
        					<button type="submit" class="btn btn-sm submit" onclick="return confirm('Are you Sure to Submit?')">
        						SUBMIT
        					</button>
        				</div>	
      				</form>
      			</div>
    		</div>
  		</div>
	</div>
	<!-- -------------------------------------------- Connection Edit Modal End -------------------------------------------- -->
	
<script type="text/javascript">
	/* $(document).ready(function () {
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
	}); */
	
	
	
	$(document).ready(function () {
	    $('#searchBar').on('keyup', function () {
	        const searchTerm = $(this).val().toLowerCase();
	        $('#dataTable tbody tr').filter(function () {
	            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
	        });
	    });
	    /* $('#searchBar2').on('keyup', function () {
	        const searchTerm = $(this).val().toLowerCase();
	        $('#dataTable2 tbody tr').filter(function () {
	            $(this).toggle($(this).text().toLowerCase().indexOf(searchTerm) > -1);
	        });
	    }); */
	});
	<%-- <%if(isSubSystem.equalsIgnoreCase("Y")) {%> 
	
	getSuperSubLevelList('1');
	
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
	
	<%} %> --%>
	/* function validateConnectionsForm() {
		
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
	} */
	
	function openConnectionEditModal(rowId) {
		
		var connectionId = $('#connectionId_'+rowId).text();
		var purpose = $('#purpose_'+rowId).val();
		var constraints = $('#constraints_'+rowId).val();
		var periodicity = $('#periodicity_'+rowId).val();
		var description = $('#description_'+rowId).val();
		var icdConnectionId = $('#icdConnectionId_'+rowId).val();
		var drawingNo = $('#drawingNo_'+rowId).val();
		var icdConnectionId = $('#icdConnectionId_'+rowId).val();
		var drawingAttachment = $('#drawingAttachment_'+rowId).val();
		var purposeIds = $('#purposeIds_'+rowId).val();
		var modalTitle = $('#modalTitle_'+rowId).val();

		$('#connectionid').text(connectionId);
		$('.modalTitle').text(modalTitle);
		$('#purpose').val(purpose);
		$('#constraints').val(constraints);
		if(periodicity==null || periodicity=='null') {
			$('input[name="periodicityEdit"]').prop('checked', false);
		}else {
			$('input[name="periodicityEdit"][value="'+periodicity+'"]').prop('checked', true);
		}
		
		$('#description').val(description);
		$('.icdConnectionId').val(icdConnectionId);
		$('#drawingNo').val(drawingNo);
		$('#drawingAttach').val(drawingAttachment);
		
		if (purposeIds) {
	        // Split the purposeIds into an array
	        var selectedIds = purposeIds.split(',').map(function(id) {
	            return id.trim(); // Trim whitespace
	        });

	        // Select the matching options in the dropdown
	        selectedIds.forEach(function(id) {
	            $('#purpose option[value="' + id + '"]').prop('selected', true);
	        });

	        // Trigger the 'change' event to update the multi-select UI
	        $('#purpose').trigger('change');
	    }
		
		$('#connectionEditModal').modal('show');
	}
	
	function checkConnectionExistence(){

		var docId = '<%=docId%>';
		var subSystem1 = $('#subSystem1').val();
		var subSystem2 = $('#subSystem2').val();
		var superSubSystem1 = $('#superSubSystem1').val();
		var superSubSystem2 = $('#superSubSystem2').val();
		
		$.ajax({
			type : "GET",
			url : "CheckICDConnectionExistence.htm",	
			datatype : 'json',
			data : {
				docId : docId,				
				subSystem1 : subSystem1,				
				subSystem2 : subSystem2,				
				superSubSystem1 : superSubSystem1,				
				superSubSystem2 : superSubSystem2,				
			},
			success : function(result) {
				var result = JSON.parse(result);
				
				if(result>0) {
					alert('System Connection is already Available. Please choose from the Connection list to add new Connections');
					$('#subSystem1').val("").trigger("change");
					$('#subSystem2').val("").trigger("change");
					$('#superSubSystem1').val("").trigger("change");
					$('#superSubSystem1').val("").trigger("change");
				}
			}
		});
	}
	
	function openNewConnectionAddModal(rowId) {
		
		var modalTitle = $('#modalTitle_'+rowId).val();
		var icdConnectionId = $('#icdConnectionId_'+rowId).val();
		$('.icdConnectionId').val(icdConnectionId);
		$('.modalTitle').text(modalTitle);
		
		$('#addNewConnectionModal').modal('show');
		
	}
</script> 	
</body>
</html>