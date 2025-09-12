<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/admin/NotificationList.css" var="notificationList" />
<link href="${notificationList}" rel="stylesheet" />

<title>NOTIFICATION LIST</title>
</head>
<body>

<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> NotificationList=(List<Object[]>) request.getAttribute("NotificationList");

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

    



	
<br>	


	
<div class="container-fluid">		
	<div class="row">

		<div class="col-md-12">
		

		
			<div class="card shadow-nohover" >
			
				<h3 class="card-header">
					Notification List
				
				</h3>
				
				<div class="card-body"> 
		
				<div class="table-responsive">
    				<table class="table table-bordered table-hover table-striped table-condensed mt-4" id="myTable3" >
						
						<%if(NotificationList.size()>0) {%>
						
						<thead>	
							<tr>					
								<th class="text-center">Sl No</th>
								<th >Date</th>
								<th >Notification</th>								
							 	
							</tr>
						</thead>
						<tbody>					
											
					 	<%
					 	int  count=1;
						for(Object[] obj: NotificationList){ %>
														
						<tr >
							<td class="text-center"><%=count %></td>
							<td><%=obj[0]!=null?sdf.format(obj[0]):" - " %></td>
	 						<td><a onclick="test(<%=obj[3] %>)" id=<%=obj[3] %> href="<%=obj[2] %>" ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></a></td>
						</tr>
														
							<% count++; } %>
						</tbody>
						<%} else{%>
						
						<div align="center">
						
							<i class="fa fa-comment-o font" aria-hidden="true" 	></i><h4>  No Notifications to display</h4>
						
						</div>
						
						
						<%} %>
						
					</table>
				</div>
        	</div>
        </div>
        
	
	</div>

</div> 
	
</div>	
	
	
<script>


function test(id){
	
	 var notificationid=id;
	
	$.ajax({
		type : "GET",
		url : "NotificationUpdate.htm",
		data : {
				notificationid : notificationid,
				
			},
		datatype : 'json',
		success : function(result) {
			
		}
	});
	
}

</script>


	
	
<script type="text/javascript">


$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}

	
		  return true;
	 
			
	}


$(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 5
	})
})









</script>
</body>
</html>