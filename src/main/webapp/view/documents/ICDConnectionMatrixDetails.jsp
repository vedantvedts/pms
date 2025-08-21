<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.documents.dto.ICDConnectionDTO"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.stream.Stream"%>
<%@page import="java.util.Set"%>
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
    max-height: 680px; /* Set the max height for the table wrapper */
    overflow-y: auto; /* Enable vertical scrolling */
    overflow-x: auto; /* Enable vertical scrolling */
}


</style>
</head>
<body>
<%

	String docId = (String)request.getAttribute("docId");
	String docType = (String)request.getAttribute("docType");
	String documentNo = (String)request.getAttribute("documentNo");
	String projectId = (String)request.getAttribute("projectId");
	//List<Object[]> productTreeList = (List<Object[]>)request.getAttribute("productTreeList"); 

	//List<IGIInterface> igiInterfaceList = (List<IGIInterface>)request.getAttribute("igiInterfaceList"); 
	//igiInterfaceList = igiInterfaceList.stream().filter(e -> e.getIsActive()==1).collect(Collectors.toList());
	List<ICDConnectionDTO> icdConnectionsList = (List<ICDConnectionDTO>)request.getAttribute("icdConnectionsList"); 
	//PfmsICDDocument icdDocument = (PfmsICDDocument)request.getAttribute("icdDocument");

	List<Object[]> productTreeAllList = (List<Object[]>)request.getAttribute("productTreeAllList"); 
	List<Object[]> productTreeList = (List<Object[]>)request.getAttribute("productTreeList"); 
	List<Object[]> productTreeListInternal = (List<Object[]>)request.getAttribute("productTreeListInternal"); 
	List<Object[]> productTreeListExternal = (List<Object[]>)request.getAttribute("productTreeListExternal"); 
	//List<Object[]> productTreeList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("1")).collect(Collectors.toList());
	//List<String> subsystems = productTreeList.stream().map(obj -> obj[7].toString()).distinct().collect(Collectors.toList());

	Map<String, String> connectionMap = new HashMap<>();

	for (ICDConnectionDTO con : icdConnectionsList) {
	    String[] levelCodesS1 = con.getLevelCodesS1().split(",");
	    String[] levelCodesS2 = con.getLevelCodesS2().split(",");
	    String value = con.getInterfaceCodes().replaceAll(",", "<br>");
	
	    for (String codeS1 : levelCodesS1) {
	        codeS1 = codeS1.trim(); // clean spaces
	        for (String codeS2 : levelCodesS2) {
	            codeS2 = codeS2.trim();
	            String key = codeS1 + "_" + codeS2;
	
	            connectionMap.merge(key, value, (oldValue, newValue) -> oldValue + " <br> " + newValue);
	        }
	    }
	}

	
	//String isSubSystem = icdDocument!=null && icdDocument.getProductTreeMainId()!=0? "Y": "N";
	
	//Object[] subSystemDetails = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[0].toString())).findFirst().orElse(null);
	
%>

	<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>
    
    <div class="container-fluid">
       
    	<div class="card shadow-nohover" style="margin-top: -0.6pc">
        	<div class="card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
            	<div class="row">
               		<div class="col-md-9" align="left">
	                    <h5 id="text" style="margin-left: 1%; font-weight: 600">
	                      Interface Matrix Details - <%=documentNo!=null?StringEscapeUtils.escapeHtml4(documentNo): " - " %>
	                    </h5>
                	</div>
                	<div class="col-md-2"  align="right">
                		
                	</div>
                    <div class="col-md-1" align="right">
                    	<form action="ICDConnectionList.htm" method="get">
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
        	
        	<div class="row" style="margin: 0.5rem;">
				<div class="col-12">
	        			<ul class="nav nav-pills" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  				<li class="nav-item" style="width: 34%;"  >
		    				<div class="nav-link active" style="text-align: center;" id="pills-tab-1" data-toggle="pill" data-target="#tab-1" role="tab" aria-controls="tab-1" aria-selected="true">
			   					<span>All</span> 
		    				</div>
		  				</li>
		  				<li class="nav-item"  style="width: 33%;">
		    				<div class="nav-link" style="text-align: center;" id="pills-tab-2" data-toggle="pill" data-target="#tab-2" role="tab" aria-controls="tab-2" aria-selected="false">
		    	 				<span>Internal</span> 
		    				</div>
		  				</li>
		  				<li class="nav-item"  style="width: 33%;">
		    				<div class="nav-link" style="text-align: center;" id="pills-tab-3" data-toggle="pill" data-target="#tab-3" role="tab" aria-controls="tab-3" aria-selected="false">
		    	 				<span>External</span> 
		    				</div>
		  				</li>
					</ul>
	   			</div>
			</div>
			
			<div class="tab-content" id="pills-tabContent">
			
	       		<div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="pills-tab-1">
		        	<div class="card-body">
			        	
			        	<%-- <%
			        	if(isSubSystem.equalsIgnoreCase("Y")) {
			        		
			        		List<Object[]> productTreeSubList = productTreeAllList.stream().filter(e -> icdDocument.getProductTreeMainId()==Long.parseLong(e[9].toString()) && e[10].toString().equalsIgnoreCase("2")).collect(Collectors.toList());
			        		//List<String> supersubsystems = productTreeSubList.stream().map(obj -> obj[7].toString()).distinct().collect(Collectors.toList());
			        	
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
								            <% for (Object[] supersubsystem : productTreeSubList) { %>
								                <th><%= supersubsystem[2] + " (" + supersubsystem[7] + ")" %></th>
								            <% } %>
								        </tr>
								    </thead>
								    <tbody>
								        <% 
								        int slnoSS = 0;
								        for (Object[] rowSuperSubsystem : productTreeSubList) { 
								        %>
								            <tr>
								                <td class="center"><%= ++slnoSS %></td>
								                <td><%= rowSuperSubsystem[2] + " (" + rowSuperSubsystem[7] + ")" %></td>
								                <% for (Object[] colSuperSubsystem : productTreeSubList) { %>
								                    <td>
								                        <% 
								                        //if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { 
								                        //    out.print("NA");
								                        //} else {
								                            String key = rowSuperSubsystem[7] + "_" + colSuperSubsystem[7];
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
			        	<%} else {%> --%>
			        	
			        		<div class="table-responsive table-wrapper"> 
			
								<table class="customtable">
								    <thead>
								        <tr>
								            <th width="3%">SN</th>
								            <th width="10%">Sub-System</th>
								            <% for (Object[] subsystem : productTreeList) { %>
								                <th><%= subsystem[2]!=null?StringEscapeUtils.escapeHtml4(subsystem[2].toString()): " - " + " (" + subsystem[7]!=null?StringEscapeUtils.escapeHtml4(subsystem[7].toString()): " - " + ")" %></th>
								            <% } %>
								        </tr>
								    </thead>
								    <tbody>
								        <% 
			      
			                            int slnoA = 0;
								        for (Object[] rowSubsystem : productTreeList) { 
								        %>
								            <tr>
								                <td class="center"><%= ++slnoA %></td>
								                <td><%= rowSubsystem[2]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[2].toString()): " - " + " (" + rowSubsystem[7]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[7].toString()): " - " + ")" %></td>
								                <% for (Object[] colSubsystem : productTreeList) { %>
								                    <td>
								                        <% 
								                        //if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { 
								                        //    out.print("NA");
								                        //} else {
								                            String key = rowSubsystem[7] + "_" + colSubsystem[7];
								                            String connections = connectionMap.getOrDefault(key, "-");
								                            out.print(StringEscapeUtils.escapeHtml4(connections));
								                        //}
								                        %>
								                    </td>
								                <% } %>
								            </tr>
								        <% } %>
								    </tbody>
								</table>
										
							</div>
			        	<%-- <%} %> --%>
		        	</div>
		        </div>
				
				<div class="tab-pane fade show " id="tab-2" role="tabpane2" aria-labelledby="pills-tab-2">
				
					<div class="card-body">
						<div class="table-responsive table-wrapper"> 
							<table class="customtable">
							    <thead>
							        <tr>
							            <th width="3%">SN</th>
							            <th width="10%">Sub-System</th>
							            <% for (Object[] subsystem : productTreeListInternal) { %>
							                <th><%= subsystem[2]!=null?StringEscapeUtils.escapeHtml4(subsystem[2].toString()): " - " + " (" + subsystem[7]!=null?StringEscapeUtils.escapeHtml4(subsystem[7].toString()): " - " + ")" %></th>
							            <% } %>
							        </tr>
							    </thead>
							    <tbody>
							        <% 
		      
		                            int slnoI = 0;
							        for (Object[] rowSubsystem : productTreeListInternal) { 
							        %>
							            <tr>
							                <td class="center"><%= ++slnoI %></td>
							                <td><%= rowSubsystem[2]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[2].toString()): " - " + " (" + rowSubsystem[7]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[7].toString()): " - " + ")" %></td>
							                <% for (Object[] colSubsystem : productTreeListInternal) { %>
							                    <td>
							                        <% 
							                        //if (rowSubsystem.equalsIgnoreCase(colSubsystem)) { 
							                        //    out.print("NA");
							                        //} else {
							                            String key = rowSubsystem[7] + "_" + colSubsystem[7];
							                            String connections = connectionMap.getOrDefault(key, "-");
							                            out.print(StringEscapeUtils.escapeHtml4(connections));
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
				
				<div class="tab-pane fade show " id="tab-3" role="tabpane3" aria-labelledby="pills-tab-3">
					
					<div class="card-body">
						<div class="table-responsive table-wrapper"> 
							<table class="customtable">
							    <thead>
							        <tr>
							            <th width="3%">SN</th>
							            <th width="10%">Sub-System</th>
							            <% for (Object[] subsystem : productTreeListExternal) { %>
							                <th><%= subsystem[2]!=null?StringEscapeUtils.escapeHtml4(subsystem[2].toString()): " - " + " (" + subsystem[7]!=null?StringEscapeUtils.escapeHtml4(subsystem[7].toString()): " - " + ")" %></th>
							            <% } %>
							        </tr>
							    </thead>
							    <tbody>
							        <% 
		      
		                            int slnoE = 0;
							        for (Object[] rowSubsystem : productTreeListExternal) { 
							        %>
							            <tr>
							                <td class="center"><%= ++slnoE %></td>
							                <td><%= rowSubsystem[2]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[2].toString()): " - " + " (" + rowSubsystem[7]!=null?StringEscapeUtils.escapeHtml4(rowSubsystem[7].toString()): " - " + ")" %></td>
							                <% for (Object[] colSubsystem : productTreeListExternal) { %>
							                    <td>
							                        <% 
							                        if (rowSubsystem[11].toString().equalsIgnoreCase("I") && colSubsystem[11].toString().equalsIgnoreCase("I")) { 
							                            out.print("NA");
							                        } else {
							                            String key = rowSubsystem[7] + "_" + colSubsystem[7];
							                            String connections = connectionMap.getOrDefault(key, "-");
							                            out.print(StringEscapeUtils.escapeHtml4(connections));
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
	

</body>
</html>