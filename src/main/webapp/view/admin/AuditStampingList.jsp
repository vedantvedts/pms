<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/admin/AuditStampingList.css" var="auditstampinglist" />
<link href="${auditstampinglist}" rel="stylesheet" />
<title>AUDIT STAMPING LIST</title>
</head>
<body>

			<%
				SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
				SimpleDateFormat sdf1=new SimpleDateFormat("HH:mm:ss");
				SimpleDateFormat sdf2= new SimpleDateFormat("dd-MM-yyyy HH:mm:ss ");
				
				List<Object[]> usernamelist = (List<Object[]>) request.getAttribute("usernamelist");
				List<Object[]> auditstampinglist = (List<Object[]>) request.getAttribute("auditstampinglist");

				String Fromdate=(String)request.getAttribute("Fromdate");
				String Todate=(String)request.getAttribute("Todate");
				String loginid=(String)request.getAttribute("loginid");
				String empname=null;
			%>



	
		<div class="container-fluid">	
			<div class="nav navbar auditnavbar navbar-bg">
					<form class="form-inline " method="POST" action="AuditStampingView.htm">
						
						<label class="user-name" >User Name: <span class="mandatory text-danger" >*</span></label>
						<select class="form-control form-control selectdee m-l-12" name="loginid" required="required" id="username" >
							<%	for (Object[] obj : usernamelist) { %>
								<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(loginid)){ empname = obj[3].toString(); %>  selected <%} %>  > <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %> (<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %>) </option>
							<%} %> 
						</select>
		
						<label class="from-date">From Date:</label>
						<input  class="form-control form-control date w-120"  data-date-format="dd-mm-yyyy" id="datepicker1" name="Fromdate"  required="required" 
						<%if(Fromdate!=null){%> value="<%=StringEscapeUtils.escapeHtml4(Fromdate) %>" <%} %> >
							  
			
						<label class="to-date" >To Date:</label>
						
						<input  class="form-control form-control w-120" data-date-format="dd-mm-yyyy" id="datepicker3" name="Todate" 
					 	<%if(Todate!=null){%> value="<%=StringEscapeUtils.escapeHtml4(Todate) %>" <%} %>  >
							  
			
						<button type="submit" class="btn btn-primary btn-sm submit btn-mp"  id="submit">SUBMIT</button>
			
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					</form>
			
				</div>
		
				<div class="row">
					<div class="col-md-12" align="center">
						<div class="badge badge-info p-2" >
							<h6> Login Activity of <b><%=empname.toUpperCase()%></b> from <span class="datefont"><%=Fromdate!=null?StringEscapeUtils.escapeHtml4(Fromdate): " - "%></span> to <span class="datefont"><%=Todate!=null?StringEscapeUtils.escapeHtml4(Todate): " - " %></span></h6>
						</div>
					</div>
				</div>
		</div>		
		
		<div class="container">
			<div class="row mt-3">
				<div class="col-md-12">
				
					<div class="card shadow-nohover" >
						<div class="card-body"> 
					 		<div class="table-responsive">
						  		<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
						   			<thead class="text-center">
						   				<tr>		
											<th>Login Date</th>
											<th>Login Time</th>
											<th>IP Address</th>
											<th>Mac Address</th>
											<th>Logout Type</th>
											<th>Logout Date Time</th>
										</tr>
						   			</thead>
						   			
					    			<tbody>
						    			<%for(Object[] obj:auditstampinglist){ %>	
						    			<tr>
						   					<td><%=obj[1]!=null?sdf.format(obj[1]):" - " %></td>
						    				<td><%=obj[2]!=null?sdf1.format(obj[2]):" - "%></td>
						    				<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
						    				<td><%if(obj[4]!= null){%><%=StringEscapeUtils.escapeHtml4(obj[4].toString()) %> <% }else{%> - <%} %></td> 
						    				<td><%if(obj[5]!= null){%><%=StringEscapeUtils.escapeHtml4(obj[5].toString()) %> <% }else{%> S <%} %> </td> 
						    				<td><%if(obj[6]!= null){%><%= sdf2.format(obj[6]) %> <% }else{%> - <%} %></td> 
						    			</tr>
						    			<%} %>
						    		</tbody>
								</table>
					 		</div>
						</div>
					</div>
				</div>
			</div>
		</div>
			
			
			
			
			

<script type="text/javascript">
	$(document).ready(function(){
		
		    $("#datepicker1").daterangepicker({
		        minDate: 0,
		        maxDate: "+30D",
		        numberOfMonths: 1,
		        autoclose: true,
		        "singleDatePicker" : true,
				"linkedCalendars" : false,
				"showCustomRangeLabel" : true,
		        onSelect: function(selected) {
		        $("#datepicker3").datepicker("option","minDate", selected)
		        },
		        locale : {
					format : 'DD-MM-YYYY'
				}
		    });
		
		    $("#datepicker3").daterangepicker({
		        minDate: 0,
		        maxDate:"+30D", 
		        numberOfMonths: 1,
		        autoclose: true,
		        "singleDatePicker" : true,
				"linkedCalendars" : false,
				"showCustomRangeLabel" : true,
			    onSelect: function(selected) {
			    $("#datepicker1").datepicker("option","maxDate", selected)
		        },
		        locale : {
					format : 'DD-MM-YYYY'
				}
		    }); 
		
		});
	

	$(document).ready(function(){
		
		$("#myTable").DataTable({
			"pageLength": 10,
			"lengthMenu": [5,10,25, 50, 75, 100 ]
		})
	})

	</script> 


</body>
</html>