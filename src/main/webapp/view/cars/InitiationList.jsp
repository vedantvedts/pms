<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">
/* icon styles */
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 108px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
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
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 }
 
.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}
</style>
</head>
<body>
<%
FormatConverter fc = new FormatConverter();
List<Object[]> intiationList = (List<Object[]>)request.getAttribute("InitiationList");
%>

<% String ses=(String)request.getParameter("result");
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
	    <%=ses1 %>
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
	    	<%=ses %>
		</div>
	</div>
	<%} %>
	
<br>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="row card-header">
			   		<div class="col-md-6">
						<h4>Initiation List</h4>
					</div>
				</div>
				<div class="card-body">	
					<div class="table-responsive">
	                	<table class="table table-bordered table-hover table-striped table-condensed" id="myTable"> 
	                    	<thead>
	                        	<tr>
	                            	<th width="5%">SN</th>
	                                <th width="10%">Date</th>
	                                <th width="15%">CARSNo</th>
	                                <th width="10%">Funds From</th>
	                                <th width="20%">Title</th>
	                                <th width="20%">Status</th>
	                                <th width="20%">Action</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                        	<% if(intiationList!=null && intiationList.size()>0) {
	                               int slno=0; 
	                               for(Object[] obj : intiationList) {%>   
	                            	<tr>
	                                	<td style="text-align: center;"><%=++slno %> </td>
	                                    <td style="text-align: center;"><%if(obj[3]!=null) {%><%=fc.SqlToRegularDate(obj[3].toString()) %><%} else {%>- <%} %></td>
	                                    <td style="text-align: center;"><%=obj[2] %> </td>
	                                    <td style="text-align: left;">
	                                    	<%if(obj[7]!=null) {%> <%if(obj[7].toString().equalsIgnoreCase("0")) {%>Buildup<%} else{%>Project<%} }%>
	                                    </td>
	                                    <td style="text-align: left;"><%=obj[4] %> </td>
	                                    <td style="text-align: center;">
	                                    	<form action="#">
	                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                                        	<input type="hidden" name="carsInitiationId" value="<%=obj[0] %>">
	                                       	  	<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction=CARSTransStatus.htm value="<%=obj[0] %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[11] %>; font-weight: 600;" formtarget="_blank">
								    			<%=obj[10] %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    			</button>
	                                        </form>
	                                    </td>
	                                    <td style="text-align: center;">
	                                        <form action="#" method="post">
	                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                                        	
	                                       	 	<button class="editable-click" name="carsInitiationId" value="<%=obj[0] %>" formaction="CARSInitiationDetails.htm">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/clipboard.png">
															</figure>
															<span>Details</span>
														</div>
													</div>
											    </button>
											    <%if(obj[12]!=null && (obj[12].toString().equalsIgnoreCase("FWD") || obj[12].toString().equalsIgnoreCase("SFU"))) {%>
	                                       	 	<button class="editable-click" name="carsUserRevoke" value="<%=obj[0] %>/<%=obj[12] %>" formaction="CARSUserRevoke.htm" formmethod="post" onclick="return confirm('Are you sure to revoke?')">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/userrevoke.png" style="width: 22px !important;">
															</figure>
															<span>Revoke</span>
														</div>
													</div>
											    </button>
											    <%} %>
	                                        </form>
	                                    </td>
	                                </tr>
	                            <%} }%>
	                        </tbody>
	                    </table>
	                </div>
	                <div align="center">
	                	<form action="#" id="myform" method="post">
	                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                        <button  class="btn add" type="submit" name="Action" value="Add" formaction="CARSInitiationDetails.htm" formnovalidate="formnovalidate">Add CARS</button>
	                 	</form>
	              	</div>
				</div>
			</div>
		</div>
	</div>
</div>	

<script type="text/javascript">

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
	});
});

$(function () {
	$('[data-toggle="tooltip"]').tooltip()
});	
</script>
</body>
</html>