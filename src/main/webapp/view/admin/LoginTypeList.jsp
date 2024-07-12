<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>LOGIN TYPE LIST</title>
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

th td {
	text-align: center;
}


</style>
</head>
<body>


<%List<Object[]> LoginTypeList=(List<Object[]>)request.getAttribute("loginTypeList"); %>


	
<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><center>
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></center>
                    <%} %>

    

	
	<div class="container-fluid">		
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" >
				<div class="card-header">
					<h4> Login Type List </h4>
				</div>
				<div class="card-body" align="center" > 
					<div class="col-md-8">
						<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" >
				              <thead>
				              		<tr>
				                    	<th style="text-align: center;" >SN</th>
				                        <th style="text-align: center;">Login Type</th>
				                        <th style="text-align: center;">Code</th>
									</tr>
		                      </thead>
				              <tbody>
									<%for(Object[] 	obj:LoginTypeList){ %>
									<tr>
										<td style="text-align: center;" ><%=obj[2] %></td>
										<td style="text-align: center;" ><%=obj[1] %></td>				 
										<td style="text-align: center;" ><%=obj[0] %></td>
									</tr>
									<%} %>
							  </tbody>
				          </table>
			          </div>
				</div>
             </div>
	</div></div>
	
</div>	
	
	
	


				
					
<script type="text/javascript">


$(document).ready(function() {
	$("#myTable").DataTable({
			'aoColumnDefs': [{
			'bSortable': false,
			'aTargets': [-1] /* 1st one, start by the right */
		}]
	});
});
	  
</script>
				
				
</body>
</html>