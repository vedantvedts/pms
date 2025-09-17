<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/action/actionPdcReport.css" var="actionPdcReport" />
<link href="${actionPdcReport}" rel="stylesheet" />
<spring:url value="/resources/css/action/actionCommon.css" var="actionCommon" />
<link href="${actionCommon}" rel="stylesheet" />
 

<title>Assignee List</title>
</head>
 
<body>
  <%
  FormatConverter fc=new FormatConverter(); 
  SimpleDateFormat sdf=fc.getRegularDateFormat();
  SimpleDateFormat sdf1=fc.getSqlDateFormat();

  List<Object[]> AssigneeList=(List<Object[]>)request.getAttribute("StatusList");
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  String Project=(String)request.getAttribute("Project");
  List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
  String Employee=(String)request.getAttribute("Employee");
  String fdate=(String)request.getAttribute("fdate");
  String tdate=(String)request.getAttribute("tdate"); 
  String Position=(String)request.getAttribute("Position");
  
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

    <br/>


<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header mb-2">  

					<div class="row">
						 <h4 class="col-md-2">Action Reports</h4>  <br>
							<div class="col-md-10 div-margin" >
					   			<form method="post" action="ActionPdcReport.htm" name="dateform" id="dateform">
					   				<table >
					   					<tr>
					   						<td >
					   							<label class="control-label td-label">Project: </label>
					   						</td>
					   						<td >
                                                        <select class="form-control selectdee " name="Project" id="Project" required="required"  data-live-search="true"  >
                                                           <option value="0"  <%if(Project.equalsIgnoreCase("0")){ %> selected="selected" <%} %>>General</option>	
                                                           <%
                                                           for(Object[] obj:ProjectList){ 
                                                           String projectShortName=(obj[17]!=null)?"("+obj[17].toString()+")":"";
                                                           %>
														   <option value="<%=obj[0] %>" <%if(Project.equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - "%> <%= projectShortName!=null?StringEscapeUtils.escapeHtml4(projectShortName):" - " %></option>	
														<%} %>
																</select>	        
											</td>
					   					
					   						<td >
					   							<label class="control-label td-label">Name: </label>
					   						</td>
					   						<td >
                                                        <select class="form-control selectdee " name="EmpId" id="EmpId" required="required"  data-live-search="true"  >
                                                           
                                                           <%
                                                           for(Object[] obj:EmployeeList){ %>
														   <option value="<%=obj[0] %>" <%if(Employee.equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - " %>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - " %></option>	
														<%} %>
																</select>	        
											</td>
											
					   						<td>

											<input type="hidden" name="Position" id="Assignee" value="P">
											</td>
					   				
					   					    <td>
					   						<td >
					   							<label class="control-label td-label" > From Date:</label>
					   						</td>
					   						<td >
					   							<input  class="form-control"  data-date-format="dd/mm/yyyy" id="fdate" name="fdate"  required="required"  value="<%=fdate%>">
					   						</td>
					   						<td>
					   							<label class="control-label td-label" > To Date:</label>
					   						</td>
					   						<td >
					   							<input  class="form-control "  data-date-format="dd/mm/yyyy" id="tdate" name="tdate"  required="required"  value="<%=tdate%>">
					   						</td>
					   						<td>
					   							<input type="submit" value="SUBMIT" class="btn  btn-sm submit	 "/>
					   						</td>			
					   					</tr>   					   				
					   				</table>
					   				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					   			</form>
		   					</div>
		   				</div>	   							

					</div>
						
					
    					<div class="data-table-area mg-b-15">
							<div class="container-fluid">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">
										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
													
												</div>
											<table class="table table-bordered table-hover table-striped table-condensed" id="myTable12" >

													<thead>

														<tr>
															<th> SN </th>
															<th> Action Id </th>	
															<th> PDC </th>																							
														 	<th> Assigner</th>	
														 	<th> Assignee </th>				 	
														 	<th> Status </th>
														 	<th> Progress </th>
														</tr>
													</thead>
													<tbody>
														<%int count=1;
															if(AssigneeList!=null&&AssigneeList.size()>0)
															{
												   					for (Object[] obj :AssigneeList) 
												   					{ %>
												   					
																	<tr>
																		<td><%=count %></td>
																		<td> 
																		<form action="ActionDetails.htm" method="POST" >
																				<button  type="submit" class="btn btn-outline-info"><%=obj[0] %></button>
																			   <input type="hidden" name="ActionLinkId" value="<%=obj[10]%>"/>
																	           <input type="hidden" name="Assignee" value="<%=obj[1]%>,<%=obj[2]%>"/>
																	           <input type="hidden" name="ActionMainId" value="<%=obj[9]%>"/>
																	             <input type="hidden" name="ActionAssignId" value="<%=obj[12]%>"/>
																	             <input type="hidden" name="text" value="Q">
 																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
																			
																			</form> 
                                                                        </td>
																		<td><%=obj[6]!=null?sdf.format(obj[6]):""%></td>																		
																		<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - "%></td>
																	  	<td> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):" - "%>, <%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - "%></td>
																		<td> 
																				<%if(obj[5]!=null && ("N".equalsIgnoreCase(obj[5].toString()) || "A".equalsIgnoreCase(obj[5].toString()))){%>
																						Assigned 
																				<%}else if(obj[5]!=null && "F".equalsIgnoreCase(obj[5].toString())){%>
																						Forward
																				<%}else if(obj[5]!=null && "B".equalsIgnoreCase(obj[5].toString())){%>
																						Send Back
																				<%}else if(obj[5]!=null && "C".equalsIgnoreCase(obj[5].toString())){%>
																						Closed
																				<%}else if(obj[5]!=null && "I".equalsIgnoreCase(obj[5].toString())){%>	
																				        In progress
																				 <%} %>
																		</td>
																		<td class="td-width"><%if(obj[11]!=null){ %>
																            <div class="progress div-progress" >
																	            <div class="progress-bar progress-bar-striped width-<%=obj[11]%>" role="progressbar"  aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																	            <%=StringEscapeUtils.escapeHtml4(obj[11].toString()) %>
																	            </div> 
																            </div> <%}else{ %>
																            <div class="progress div-progress">
																	            <div class="progress-bar progressbar" role="progressbar" >
																	             Not Yet Started .
																	            </div>
																            </div> <%} %>
															            </td>				
																	</tr>
																<% count++;
																	}									   					
															}%>
													</tbody>
												</table>												
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<br>
						<div class="card-footer" align="right">&nbsp;</div>
					</div>
				</div>
			</div>
		</div>

	
			
		

	
<script type='text/javascript'> 
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 




$('#fdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
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





$('#tdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});



function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	 
	
	
		 
	
		  return true;
	 
			
	}
/* 
$(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 10
	})
})
 */

</script>


</body>
</html>