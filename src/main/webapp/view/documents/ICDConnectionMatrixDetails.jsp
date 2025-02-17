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
    max-height: 600px; /* Set the max height for the table wrapper */
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
	PfmsICDDocument icdDocument = (PfmsICDDocument)request.getAttribute("icdDocument");

	List<String> subsystems = productTreeList.stream().map(obj -> obj[7].toString()).distinct().collect(Collectors.toList());

	Map<String, String> connectionMap = new HashMap<>();

	for (Object[] connection : icdConnectionsList) {
	    String key = connection[4] + "_" + connection[5];
	    //int count = connectionMap.containsKey(key) ? connectionMap.get(key).split("<br>").length + 1 : 1;

	    //String seqNumber = (count >= 100) ? "_" + count : (count >= 10) ? "_0" + count : "_00" + count;

	    //String value = count + ". " +connection[4] + "_" + connection[5] + "_" + connection[8];
	    String value = connection[32].toString();
	    connectionMap.merge(key, value, (oldValue, newValue) -> oldValue + " <br> " + newValue);
	}
	
	String isSubSystem = icdDocument!=null && icdDocument.getProductTreeMainId()!=0? "Y": "N";
	
	Object[] subSystemDetails = productTreeList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[0].toString())).findFirst().orElse(null);
	
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
                    	<form action="ICDConnectionsDetails.htm" method="get">
                    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        			<input type="hidden" name="docId" value="<%=docId %>" />
		        			<input type="hidden" name="docType" value="<%=docType %>" />
		        			<input type="hidden" name="documentNo" value="<%=documentNo %>" />
		        			<input type="hidden" name="projectId" value="<%=projectId %>" />
		        			<button class="btn btn-info btn-sm shadow-nohover back">
		        				Back
		        			</button>
                		</form>
                    </div>
            	</div>
        	</div>
        	<div class="card-body">
	        	
	        	<%
	        	if(isSubSystem.equalsIgnoreCase("Y")) {
	        		
	        		List<Object[]> productTreeAllList = (List<Object[]>)request.getAttribute("productTreeAllList"); 
	        		List<Object[]> productTreeSubList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("2")).collect(Collectors.toList());
	        		List<String> supersubsystems = productTreeSubList.stream().map(obj -> obj[7].toString()).distinct().collect(Collectors.toList());
	        	
	        		Map<String, String> superSubConnectionMap = new HashMap<>();

	        		for (Object[] connection : icdConnectionsList) {
	        		    String key = connection[16] + "_" + connection[17];

	        		    //int count = superSubConnectionMap.containsKey(key) ? superSubConnectionMap.get(key).split("<br>").length + 1 : 1;

	        		    //String seqNumber = (count >= 100) ? "_" + count : (count >= 10) ? "_0" + count : "_00" + count;

	        		   // String value = count + ". " +connection[16] + "_" + connection[17] + "_" + connection[8] ;
	        		   	String value = connection[32].toString();

	        		    superSubConnectionMap.merge(key, value, (oldValue, newValue) -> oldValue + "<br>" + newValue);
	        		}
	        	%>
		        	<div class="table-responsive table-wrapper"> 
	
						<table class="customtable">
						    <thead>
						        <tr>
						            <th width="5%">SN</th>
						            <th width="8%">Super Sub-System</th>
						            <% for (String supersubsystem : supersubsystems) { %>
						                <th><%= supersubsystem %></th>
						            <% } %>
						        </tr>
						    </thead>
						    <tbody>
						        <% 
						        int slnoSS = 0;
						        for (String rowSubsystem : supersubsystems) { 
						        %>
						            <tr>
						                <td class="center"><%= ++slnoSS %></td>
						                <td class="center"><%= rowSubsystem %></td>
						                <% for (String colSubsystem : supersubsystems) { %>
						                    <td> &emsp;
						                        <% 
						                        //if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { 
						                        //    out.print("NA");
						                        //} else {
						                            String key = rowSubsystem + "_" + colSubsystem;
						                            String connections = superSubConnectionMap.getOrDefault(key, "-");
						                            out.print(connections);
						                        //}
						                        %>
						                    </td>
						                <% } %>
						            </tr>
						        <% } %>
						    </tbody>
						</table>
								
					</div>
	        	<%} else {%>
	        	
	        		<div class="table-responsive table-wrapper"> 
	
						<table class="customtable">
						    <thead>
						        <tr>
						            <th width="5%">SN</th>
						            <th width="8%">Sub-System</th>
						            <% for (String subsystem : subsystems) { %>
						                <th><%= subsystem %></th>
						            <% } %>
						        </tr>
						    </thead>
						    <tbody>
						        <% 
	      
	                            int slnoSS = 0;
						        for (String rowSubsystem : subsystems) { 
						        %>
						            <tr>
						                <td class="center"><%= ++slnoSS %></td>
						                <td class="center"><%= rowSubsystem %></td>
						                <% for (String colSubsystem : subsystems) { %>
						                    <td>
						                        <% 
						                        //if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { 
						                        //    out.print("NA");
						                        //} else {
						                            String key = rowSubsystem + "_" + colSubsystem;
						                            String connections = connectionMap.getOrDefault(key, "-");
						                            out.print(connections);
						                        //}
						                        %>
						                    </td>
						                <% } %>
						            </tr>
						        <% } %>
						    </tbody>
						</table>
								
					</div>
	        	<%} %>
        	</div>
        </div>
 	</div>
	

</body>
</html>