<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.documents.model.IGILogicalChannel"%>
<%@page import="com.vts.pfms.documents.model.IGILogicalInterfaces"%>
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
    max-height: 680px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: auto; /* Enable vertical scrolling */
}


</style>
</head>
<body>
	<%
		List<Object[]> interfaceConnectionList = (List<Object[]>) request.getAttribute("igiLogicalInterfaceConnectionList");
		List<Object[]> systemProductTreeAllList = (List<Object[]>) request.getAttribute("systemProductTreeAllList");
		List<Object[]> softwareList = systemProductTreeAllList.stream().filter(e -> e[10]!=null && (e[10].toString().equalsIgnoreCase("S") || e[10].toString().equalsIgnoreCase("F")) ).collect(Collectors.toList());
		String igiDocId = (String)request.getAttribute("igiDocId");
		
		Map<String, String> connectionMap = new HashMap<>();

		for (Object[] connection : interfaceConnectionList) {
		    String key = connection[15] + "_" + connection[17];
		    String value = connection[1].toString();
		    connectionMap.merge(key, value, (oldValue, newValue) -> oldValue + " <br> " + newValue);
		}
	%>
	
	<div class="container-fluid">
       
    	<div class="card shadow-nohover" style="margin-top: -0.6pc">
        	<div class="card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
            	<div class="row">
               		<div class="col-md-9" align="left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                      Logical Interface Matrix
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
                		
                	</div>
                    <div class="col-md-1" align="right">
                    	<form action="IGILogicalInterfacesList.htm" method="get">
                    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		        			<input type="hidden" name="igiDocId" value="<%=igiDocId %>" />
		        			<button class="btn btn-info btn-sm shadow-nohover back">
		        				Back
		        			</button>
                		</form>
                    </div>
            	</div>
        	</div>
        	<div class="card-body">
        	
        		<div class="table-responsive table-wrapper"> 
					<table class="customtable">
					    <thead>
					        <tr>
					            <th width="3%">SN</th>
					            <th width="10%">Sub-System</th>
					            <% for (Object[] subsystem : softwareList) { %>
					                <th><%= subsystem[2] + " (" + subsystem[7] + ")" %></th>
					            <% } %>
					        </tr>
					    </thead>
					    <tbody>
					        <% 
      
                            int slnoSS = 0;
					        for (Object[] rowSubsystem : softwareList) { 
					        %>
					            <tr>
					                <td class="center"><%= ++slnoSS %></td>
					                <td><%= rowSubsystem[2] + " (" + rowSubsystem[7] + ")" %></td>
					                <% for (Object[] colSubsystem : softwareList) { %>
					                    <td>
					                        <% 
					                        //if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { 
					                        //    out.print("NA");
					                        //} else {
					                            String key = rowSubsystem[7] + "_" + colSubsystem[7];
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
				
        	</div>
		</div>
	</div>
        	
</body>
</html>