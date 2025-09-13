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

   <spring:url value="/resources/css/fracasModule/fracasToReviewList.css" var="fracasToReviewList" />     
<link href="${fracasToReviewList}" rel="stylesheet" />

<title>Assignee List</title>

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
														 	<th >Assigner</th>
														 	<th >Progress</th>
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
															<td class="progresstd" >									
																	<%if(obj[13]!=null){ %>
															           <div class="progress progress-div" >
																            <div class="progress-bar progress-bar-striped width<%=obj[13]%>" role="progressbar"  aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																	            <%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()): " - "%>
																	        </div> 
																	   </div> 
																	<%}else{ %>
																	   <div class="progress progress-Zero-div" >
																		   <div class="progress-bar progress-bar-Zero" role="progressbar" >
																	             Not Yet Started .
																	   		</div>
																	   </div> <%} %>
															</td>	
															
															<td><%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString()) %><%}else{ %>-<%} %></td>
																													
															<td class="left width">		
																
															<form name="myForm1" id="myForm1" action="FracasToReviewDetails.htm" method="POST"  class="detailsForm">
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
													<td colspan="8" class="no-List-tD" >No List Found</td>
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