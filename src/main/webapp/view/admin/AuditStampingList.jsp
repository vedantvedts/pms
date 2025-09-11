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
<title>AUDIT STAMPING LIST</title>
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

.content-header {
	margin-bottom: 0px;
}

.border {
	border-style: groove;
	border-radius: 5px 5px;
}

.cardpad {
	padding: 5px;
}

 .auditnavbar{
	margin-top: 0px !important;
	margin-bottom: 15px !important;
}

.btn {
    padding: 1px 5px;
}
h6{
	font-family:'Montserrat', sans-serif;
}

.datefont{
	font-family:'Muli', sans-serif;
	font-size: 15px;
}

.badge{
	padding-bottom: 0px !important;
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

</style>
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
			<div class="nav navbar auditnavbar" style="background-color: white; padding: 10px;">		
					<form class="form-inline " method="POST" action="AuditStampingView.htm">
						
						<label style="margin-left: 100px; margin-right: 10px;font-weight: 800">User Name: <span class="mandatory" style="color: red;">*</span></label>
						<select class="form-control form-control selectdee" name="loginid" style="margin-left: 12px;" required="required" id="username" >
							<%	for (Object[] obj : usernamelist) { %>
								<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(loginid)){ empname = obj[3].toString(); %>  selected <%} %>  > <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %> (<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %>) </option>
							<%} %> 
						</select>
		
						<label style="margin-left: 80px; margin-right: 20px; font-weight: 800">From Date:</label>
						<input  class="form-control form-control date"  data-date-format="dd-mm-yyyy" id="datepicker1" name="Fromdate"  required="required"  style="width: 120px;"
						<%if(Fromdate!=null){%> value="<%=StringEscapeUtils.escapeHtml4(Fromdate) %>" <%} %> >
							  
			
						<label style="margin-left: 20px; margin-right: 20px;font-weight: 800">To Date:</label>
						
						<input  class="form-control form-control" data-date-format="dd-mm-yyyy" id="datepicker3" name="Todate"  style="width: 120px;"
					 	<%if(Todate!=null){%> value="<%=StringEscapeUtils.escapeHtml4(Todate) %>" <%} %>  >
							  
			
						<button type="submit" class="btn btn-primary btn-sm submit" style="margin-left: 12px;padding: 5px;" id="submit">SUBMIT</button>
			
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					</form>
			
				</div>
		
				<div class="row">
					<div class="col-md-12" align="center">
						<div class="badge badge-info" style="padding: 8px; ">
							<h6> Login Activity of <b><%=empname.toUpperCase()%></b> from <span class="datefont"><%=Fromdate!=null?StringEscapeUtils.escapeHtml4(Fromdate): " - "%></span> to <span class="datefont"><%=Todate!=null?StringEscapeUtils.escapeHtml4(Todate): " - " %></span></h6>
						</div>
					</div>
				</div>
		</div>		
		
		<div class="container">
			<div class="row" style="margin-top: 10px;">
				<div class="col-md-12">
				
					<div class="card shadow-nohover" >
						<div class="card-body"> 
					 		<div class="table-responsive">
						  		<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
						   			<thead style=" text-align: center;">
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