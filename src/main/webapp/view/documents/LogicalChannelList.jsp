<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">

.card{
	box-shadow: rgba(0, 0, 0, 0.25) 0px 4px 14px;
	border-radius: 10px;
	border: 0px;
}

.table button {
	background-color: Transparent !important;
	background-repeat: no-repeat;
	border: none;
	cursor: pointer;
	overflow: hidden;
	outline: none;
	text-align: left !important;
}

.table td {
	padding: 5px !important;
}

#table thead tr th {
	padding: 0px 0px !important;
}

#table tbody tr td {
	padding: 2px 3px !important;
}

.center {
	text-align: center !important;
}

.right {
	text-align: right !important;
}

.left {
	text-align: left !important;
}

.select2-container {
	width: 100% !important;
}
</style>   

</head>
<body>
<%
    List<Object[]> logicalChannelList = (List<Object[]>) request.getAttribute("logicalChannelList");
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
        <div class="card shadow-nohover">
            <div class="card-header">
                <div class="row" style="display: flex; justify-content: space-between;">
                    <div class="col-md-10">
                        <h5 class="mb-0"><b>Logical Channel List </b></h5> 
                    </div>  
                    <div class="col-md-2 text-md-end">
                       
                    </div>   
                </div>
            </div>
            <div class="card-body">
                <form action="LogicalChannelMaster.htm" method="post">
                    <div class="table-responsive"> 
                        <table class="table table-bordered table-hover table-striped table-condensed" id="myTable">
                            <thead class="center">
                                <tr>
                                    <th style="width: 10%;">Select</th>
                                    <th style="width: 25%;">Logical Channel</th>
                                    <th style="width: 25%;">Source</th>
                                    <th style="width: 25%;">Destination</th>
                                    <th style="width: 15%;">Channel Code</th>
                                </tr>
                            </thead>
                            <tbody>    
                                <% if (logicalChannelList != null && logicalChannelList.size() > 0) {
                                    int slno = 0;
                                    for (Object[] obj : logicalChannelList) {
                                %>
                                <tr>
                                    <td class="center">
                                    	<input type="radio" name="logicalChannelId" value=<%=obj[0]%> required>
									</td>
                                   	<td class="center"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
                                   	<td class="center"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "+" ("+obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "+")" %></td>
                                   	<td class="center"><%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - "+" ("+obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - "+")" %></td>
                                   	<td class="center"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
                                </tr>
                                
                                <% } }%>
                            </tbody>
                        </table>
                    </div>
                    <div style="text-align: center;">
                   		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                       	<button class="btn btn-sm add" type="submit" name="action" value="Add" formnovalidate="formnovalidate">ADD</button>
                       	<button class="btn btn-sm edit" type="submit" name="action" value="Edit">EDIT</button>
                       	<!-- <button class="btn btn-sm btn-danger delete" type="submit" name="action" value="Delete" formaction="IGILogicalChannelDelete.htm"
                       		onclick="confirm('Are you Sure to Delete?')">DELETE</button> -->
                    </div>
				</form>
            </div>
        </div>
	</div>

	
<!-- DataTables Initialization Script -->
<script>
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


