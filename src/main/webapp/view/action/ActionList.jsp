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

<spring:url value="/resources/css/action/actionList.css" var="actionList" />
<link href="${actionList}" rel="stylesheet" />

<title>Assignee List</title>

</head>
 
<body>
  <%
  


  List<Object[]> ActionList=(List<Object[]>)request.getAttribute("ActionList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("HH:mm:ss");
 
  
  
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
				
					<h4 class="card-header">Meeting Action List</h4>
					
					<div class="card-body">

						<div class="data-table-area mg-b-15">
							<div class="container-fluid">


								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">

										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">

										<table class="table table-bordered table-hover table-striped table-condensed" id="myTable12" >
													
													<thead>

														<tr>
															<th>SN</th>
															<th class="text-left;">Committee Name</th>
															<th>Schedule Date</th>
															<th>Time</th>									
														 	<th>Action</th>	
														</tr>
													</thead>
													<tbody>
														<%int  count=1;
															
														 	if(ActionList!=null&&ActionList.size()>0){
															for(Object[] obj: ActionList){ %>
														<tr>
															<td class="center"><%=count %></td>
															<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):" - " %></td>
															<td><%=obj[4]!=null?sdf.format(obj[4]):" - "%></td>
															<td><%=obj[5]!=null?sdf1.format(obj[5]):" - "%></td>
															

															<td class="left width">		
																
															<form name="myForm1" id="myForm1" action="CommitteeAction.htm" method="POST" 
																	class="d-inline">

																	<button class="editable-click" name="sub" value="Details" 	>
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Assign</span>
																			</div>
																		</div>
																	</button>

																	<input type="hidden" name="ScheduleId" value="<%=obj[0]%>"/>
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

																</form> 
																
																
																
																		
															</td>
														</tr>
												<% count++; } }else{%>
												<tr>
													<td colspan="6" class="text-center">No List Found</td>
												</tr>
												<%} %>
												</tbody>
												</table>
												
							<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />


											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>
				

				</div>

	
			</div>

		</div>

	</div>			
				
				

<script>
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			/* "minDate" : new Date(), */
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
	
	 $(document).ready(function(){
		  $("#myTable12").DataTable({
		 "lengthMenu": [  5,10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 10

		});
	});
	
	
	
	
	
	
	</script>  


</body>
</html>