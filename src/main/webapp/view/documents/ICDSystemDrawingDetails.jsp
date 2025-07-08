<%@page import="com.vts.pfms.documents.model.ICDSystemAttach"%>
<%@page import="com.vts.pfms.documents.dto.ICDConnectionDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.documents.model.PfmsICDDocument"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">
.table-wrapper {
    max-height: 690px;
    max-height: 690px;
    overflow-y: auto;
    overflow-x: auto;
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
	List<Object[]> productTreeList = (List<Object[]>)request.getAttribute("productTreeList"); 
	List<ICDConnectionDTO> icdConnectionsList = (List<ICDConnectionDTO>)request.getAttribute("icdConnectionsList"); 
	List<ICDSystemAttach> icdSystemAttachList = (List<ICDSystemAttach>)request.getAttribute("icdSystemAttachList"); 
	
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
	                      System Drawing List - <%=documentNo %>
	                    </h5>
                	</div>
                	<div class="col-md-3 right">
						<form action="#" method="post" id="myform1">
                    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        			<input type="hidden" name="icdDocId" value="<%=docId %>" />
		        			<input type="hidden" name="docId" value="<%=docId %>" />
		        			<input type="hidden" name="docType" value="<%=docType %>" />
		        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
		        			<input type="hidden" name="projectId" value="<%=projectId %>" />
		        			
		        			<button class="btn btn-info btn-sm shadow-nohover back" formaction="ICDConnectionList.htm" data-toggle="tooltip" title="Back">
		        				BACK
		        			</button>
                		</form>                	
                	</div>
            	</div>
        	</div>
        	<div class="card-body">
        		<div class="table-responsive table-wrapper"> 
        			<table class="table table-bordered table-hover table-striped table-condensed dataTable" id="myTable" >
                    	<thead class="center">
                    		<tr>
                    			<th width="10%">SN</th>
                    			<th width="20%">Sub-System</th>
                    			<th width="20%">Attachment</th>
                    			<th width="20%">Description</th>
                    			<th width="15%">Action</th>
                    			<th width="15%">Download</th>
	                    	</tr>
                    	</thead>
                    	<tbody>
                    		<%if (productTreeList!=null && productTreeList.size() > 0) {
								int slno = 0;
          						for (Object[] obj : productTreeList) {
          							ICDSystemAttach attach = icdSystemAttachList.stream().filter(e -> e.getSubSystemId()==Long.parseLong(obj[0].toString())).findFirst().orElse(null);
							%>
                    			<tr>
                    				<td class="center"><%=++slno %></td>
                    				<td><%=obj[2] %> (<%=obj[7] %>)</td>
                    				<td>
                    					<input form="uploadform_<%=slno%>" type="file" class="form-control" name="attachment" accept="image/png, image/jpeg" <%if(attach==null) { %>required<%} %>>
                    				</td>
                    				<td>
                    					<input form="uploadform_<%=slno%>" type="text" class="form-control" name="description" <%if(attach!=null && attach.getDescription()!=null) {%>value="<%=attach.getDescription()%>"<%} %> >
                    				</td>
                    				<td class="center">
                    					<form action="ICDSystemDrawingDetailsSubmit.htm" method="post" id="uploadform_<%=slno%>" enctype="multipart/form-data">
                    						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						        			<input type="hidden" name="icdDocId" value="<%=docId %>" />
						        			<input type="hidden" name="docId" value="<%=docId %>" />
						        			<input type="hidden" name="docType" value="<%=docType %>" />
						        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
						        			<input type="hidden" name="projectId" value="<%=projectId %>" />
						        			<input type="hidden" name="subSystemId" value="<%=obj[0] %>" />
						        			<%if(attach!=null) { %>
						        				<input type="hidden" name="systemAttachId" value="<%=attach.getSystemAttachId() %>" />
						        				<button type="submit" class="btn btn-sm edit" onclick="return confirm('Are you Sure to Upload?')">UPLOAD</button>
						        			<%} else{ %>
						        				<input type="hidden" name="systemAttachId" value="0" />
						        				<button type="submit" class="btn btn-sm submit" onclick="return confirm('Are you Sure to Upload?')">UPLOAD</button>
						        			<%} %>
                    					</form>
                    				</td>
                    				<td class="center">
                    					<%if(attach!=null && attach.getAttachment()!=null && !attach.getAttachment().isEmpty()) {%>
	                    					<button form="uploadform_<%=slno%>" type="submit" class="btn btn-sm" name="drawingAttach" value="<%=attach.getAttachment() %>" formaction="ICDSystemDrawingAttachDownload.htm" formmethod="get" formnovalidate="formnovalidate" formtarget="_blank" data-toggle="tooltip" data-placement="top" title="Download">
			                      				<i class="fa fa-download fa-lg"></i>
			                      			</button>
		                      			<%} else{%>
		                      				Not Attached
		                      			<%} %>
                    				</td>
                    			</tr>
                    		<%} } %>	
                    	</tbody>
                   	</table>	
        		</div>
        	</div>	
        </div>
    </div>
<script type="text/javascript">
	
	$(document).ready(function () {
		$('#myTable').DataTable({
	        "lengthMenu": [10, 25, 50, 75, 100],
	        "pagingType": "simple",
	        "pageLength": 10
	    });
	});
</script> 	    	
</body>
</html>