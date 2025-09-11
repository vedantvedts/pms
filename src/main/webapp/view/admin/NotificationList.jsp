<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>NOTIFICATION LIST</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}

.table .font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
}

.table button {
    background-color: Transparent !important;
    background-repeat:no-repeat;
    border: none;
    cursor:pointer;
    overflow: hidden;
    outline:none;
    text-align: left !important;
}
.table td{
	padding:5px !important;
}
 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}
	
.datatable-dashv1-list table tbody tr td{
	padding: 8px 10px !important;
}

.table-project-n{
	color: #005086;
}

#table thead tr th{
	padding: 0px 0px !important;
}

#table tbody tr td{
	padding:2px 3px !important;
}


/* icon styles */

.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:270px !important;
}
.font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 15px !important;
	  font-weight: 400 !important;
	 
}

</style>
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
    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable3" style="margin-top: 20px;">
						
						<%if(NotificationList.size()>0) {%>
						
						<thead>	
							<tr>					
								<th style="text-align: center">Sl No</th>
								<th style="">Date</th>
								<th style="">Notification</th>								
							 	
							</tr>
						</thead>
						<tbody>					
											
					 	<%
					 	int  count=1;
						for(Object[] obj: NotificationList){ %>
														
						<tr >
							<td style="text-align: center"><%=count %></td>
							<td><%=obj[0]!=null?sdf.format(obj[0]):" - " %></td>
	 						<td><a onclick="test(<%=obj[3] %>)" id=<%=obj[3] %> href="<%=obj[2] %>" ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></a></td>
						</tr>
														
							<% count++; } %>
						</tbody>
						<%} else{%>
						
						<div align="center">
						
							<i class="fa fa-comment-o " aria-hidden="true" style="font-size: 1.80rem"	></i><h4>  No Notifications to display</h4>
						
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