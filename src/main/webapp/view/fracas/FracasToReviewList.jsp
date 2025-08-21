<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Assignee List</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}
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

.width {
	width: 270px !important;
}

a:hover {
	color: white;
}

</style>
</head>
 
<body>
  <%
  


  List<Object[]> fracastoreviewlist=(List<Object[]>)request.getAttribute("fracastoreviewlist");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
 
  
  
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

    <br />
    

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
				
					<h4 class="card-header">FRACAS Review List</h4>
					
					<div class="card-body">

					<div class="table-responsive">
						   					<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" > 
						   						<thead>

														<tr>
															<th>SN</th>															
															<th>FRACAS Item</th>
															<th class="width-110px">PDC</th>
															<th class="width-110px">Assigned Date</th>								
														 	<th style="">Assigner</th>
														 	<th style="">Progress</th>
														 	<th>Remarks</th>
														 	
														 	<th class="width-140px">Action</th>
														</tr>
													</thead>
													<tbody>
														<%int count=1;
														if(fracastoreviewlist!=null && fracastoreviewlist.size()>0){	
										   					for (Object[] obj :fracastoreviewlist) {
										   			   %>
														<tr>
															<td class="center"><%=count %></td>
															<td><%=obj[12]!=null?StringEscapeUtils.escapeHtml4(obj[12].toString()): " - " %></td>
															<td><%=obj[3]!=null?sdf.format(obj[3]):" - " %></td>
															<td><%=obj[6]!=null?sdf.format(obj[6]):" - " %></td>
															<td><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - "%>, <%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - "%></td>
															<td style="width:15%;">									
																	<%if(obj[13]!=null){ %>
															           <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																            <div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[13]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																	            <%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()): " - "%>
																	        </div> 
																	   </div> 
																	<%}else{ %>
																	   <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																		   <div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																	             Not Yet Started .
																	   		</div>
																	   </div> <%} %>
															</td>	
															
															<td><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %>-<%} %></td>
																													
															<td class="left width">		
																
															<form name="myForm1" id="myForm1" action="FracasToReviewDetails.htm" method="POST" style="display: inline">
																	<button class="editable-click" name="sub" value="Details" 	>
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Details</span>
																			</div>
																		</div>
																	</button>
												                    <input type="hidden" name="fracasassignid" value="<%=obj[0]%>"/>													
                                                                    <input type="hidden" name="forceclose"	value="N" />
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

																</form> 
																
																
																
																		
															</td>
														</tr>
												<% count++; } }else{%>
												<tr>
													<td colspan="8" style="text-align: center">No List Found</td>
												</tr>
												<%} %>
												</tbody>
												</table>
												
							<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />


											</div>
									<div class="row">
								         <div class="col-md-4"> </div>
								         <div class="col-md-4" align="center">
									       <a  class="btn btn-sm back" href="MainDashBoard.htm">Back</a>
								        </div>
							      </div>
										</div>
									</div>
								</div>
							</div>
						</div>





<script type="text/javascript">

$(document).ready(function(){

		  $("#myTable").DataTable({
		 "lengthMenu": [10,25, 50, 75, 100 ],
		 "pagingType": "simple",
			 "pageLength": 10
	});
});
	  
</script>  


</body>
</html>