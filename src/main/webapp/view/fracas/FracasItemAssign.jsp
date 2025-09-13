<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<script src="./resources/js/multiselect.js"></script>
<link href="./resources/css/multiselect.css" rel="stylesheet"/>
 <spring:url value="/resources/css/fracasModule/fracasItemAssign.css" var="fracasItemAssign" />     
<link href="${fracasItemAssign}" rel="stylesheet" />

<title>New FRACAS</title>

<title> ADD COMMITTEE</title>



</head>

<body>
<% 
	FormatConverter fc=new FormatConverter();
	SimpleDateFormat sdf=fc.getRegularDateFormat();
	SimpleDateFormat sdf1=fc.getSqlDateFormat();
	
    List<Object[]>  employeelist=(List<Object[]>)request.getAttribute("employeelist");
    Object[]  fracasitemdata=(Object[])request.getAttribute("fracasitemdata");
    String fracasmainid=fracasitemdata[0].toString();
    List<Object[]>  fracasassignedlist=(List<Object[]>)request.getAttribute("fracasassignedlist");
    
    String LabCode=(String)request.getAttribute("LabCode");
    
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
  
    
    
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header">
					<h4 class="text-blue">Assign FRACAS Item</h4>
				</div>
				<div class="card-body">
					<form method="post" action="FracasAssignSubmit.htm" enctype="multipart/form-data" >
							<div class="row">		
							
								
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">Assignee</label>
										<select class="form-control"  name="employeeid" id="employeeid"  data-live-search="true" required  data-placeholder="Select Members" multiple>
											<%for(Object[] obj:employeelist){ %>																							
											<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></option>																				
											<%} %>
										</select>
									</div>
								</div>
							
							
													
								<div class="col-md-4">
									<div class="form-group">
										<label class="control-label">PDC</label>
										<input  class="form-control"  data-date-format="dd/mm/yyyy" id="pdc" name="pdc" readonly="readonly" required="required"   value="<%= sdf.format(sdf1.parse( LocalDate.now().toString()))%>">
									</div>
								</div>
										
								<div class="col-md-4">
									<label class="control-label">Remarks</label>
									<input type="text" class="form-control " name="remarks" maxlength="150"  >
								</div>
							</div>
							<br>
							<div class="row" >
								<div class="col-md-4"> </div>
								<div class="col-md-4" align="center">
								
									<button type="submit" class="btn btn-sm btn-primary submit"  onclick="return confirm('Are you Sure To Add this FRACAS Item?');">SUBMIT</button>
									<button type="button" class="btn btn-sm btn-primary back" onclick="submitForm()">BACK</button>
									<!-- <a class="btn btn-sm btn-primary  back"  href="MainDashBoard.htm" >BACK</a> -->
								 </div>
							</div>
							<input type="hidden" name="fracasmainid" value="<%=fracasmainid %>" >
							<input type="hidden" name="LabCode" value="<%=LabCode %>" > <!--line added  -->
							
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</div>
				<!-- <div class="card-footer"><br>
				</div> -->
				
				
				
			</div>
		</div>	
	</div>
</div>
 <br>
 
 <%if(fracasassignedlist.size()>0){ %>
 <div class="container-fluid" >
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header">
					<h4 class="text-blue">Assigned List</h4>
				</div>
				<div class="card-body">
						<div class="table-responsive">
	   					<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" > 
	   						<thead>
														<tr>
															<th>SN.</th>
															<th>Assignee</th>
															<th>Remarks</th>
															<th>PDC</th>
															<th>Progress</th>
															<th>Actions</th>
														</tr>
													</thead>   
													<%for(int i=0;i<fracasassignedlist.size();i++){ %>
														<tr>
															<td><%=i+1 %></td>
															<td><%=fracasassignedlist.get(i)[10]!=null?StringEscapeUtils.escapeHtml4(fracasassignedlist.get(i)[10].toString()): " - " %>(<%=fracasassignedlist.get(i)[11]!=null?StringEscapeUtils.escapeHtml4(fracasassignedlist.get(i)[11].toString()): " - " %>)</td>
															<td><%=fracasassignedlist.get(i)[2]!=null?StringEscapeUtils.escapeHtml4(fracasassignedlist.get(i)[2].toString()): " - " %></td>
															<td><%= sdf.format(sdf1.parse( fracasassignedlist.get(i)[3].toString() ))%></td>
															<td class="progress-width" >									
																	<%if(fracasassignedlist.get(i)[13]!=null){ %>
															           <div class="progress progress-div" >
																            <div class="progress-bar progress-bar-striped width<%=fracasassignedlist.get(i)[13]%>" role="progressbar"  aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																	            <%=StringEscapeUtils.escapeHtml4(fracasassignedlist.get(i)[13].toString())%>
																	        </div> 
																	   </div> 
																	<%}else{ %>
																	   <div class="progress progress-Zero-Div" >
																		   <div class="progress-bar progress-bar-Zero" role="progressbar"  >
																	             Not Yet Started .
																	   		</div>
																	   </div> <%} %>
															</td>	
															<td>
																 <form action="FracasToReviewDetails.htm" method="post"  class="reviewDetailsForm">
																	<button class="editable-click" name="sub" value="Modify">
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<i class="fa fa-window-close fa-lg closeButton"  aria-hidden="true"></i>
																				</figure>
																				<span>Close</span>
																			</div>
																		</div>
																	</button>															
																	<input type="hidden" name="forceclose"	value="Y" />
																	<input type="hidden" name="fracasassignid"	value="<%=fracasassignedlist.get(i)[0] %>" /> 
																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																</form>	
															</td>
														</tr>
													<%} %>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
  <%} %>
 				<form action="FracasMainItemsList.htm" method="post" id="backfrm">
					<input type="hidden" name="fracasmainid" value="<%=fracasmainid %>" >
					<input type="hidden" name="projectid" value="<%=fracasitemdata[4] %>" >
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />				
				</form>
</body>
<script type="text/javascript">
function submitForm()
{ 
  document.getElementById('backfrm').submit(); 
} 
</script>


<script type="text/javascript">
$('#employeeid').select2();
$('#pdc').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate":new Date(), */
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

</script>

 <script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
  

</script>


</html>