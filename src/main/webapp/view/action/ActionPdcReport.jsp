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
.table button{
	
	background-color: white !important;
	border: 3px solid #17a2b8;
	padding: .275rem .5rem !important;
}

.table button:hover {
	color: black !important;
	
}
#table tbody tr td {

	    padding: 4px 3px !important;

}

</style>
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


<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
 if(ses1!=null){
	%>
	<center>
	<div class="alert alert-danger" role="alert" >
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert"  >
                     <%=ses %>
                   </div></center>
                    <%} %>

    <br/>


<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header ">  

					<div class="row">
						 <h4 class="col-md-2">Action Reports</h4>  <br>
							<div class="col-md-10" style="float: right; margin-top: -8px;">
					   			<form method="post" action="ActionPdcReport.htm" name="dateform" id="dateform">
					   				<table >
					   					<tr>
					   						<td >
					   							<label class="control-label" style="font-size: 14px; margin-bottom: .0rem;">Project: </label>
					   						</td>
					   						<td >
                                                        <select class="form-control selectdee " name="Project" id="Project" required="required"  data-live-search="true"  >
                                                           <option value="0"  <%if(Project.equalsIgnoreCase("0")){ %> selected="selected" <%} %>>General</option>	
                                                           <%
                                                           for(Object[] obj:ProjectList){ %>
														   <option value="<%=obj[0] %>" <%if(Project.equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[4] %></option>	
														<%} %>
																</select>	        
											</td>
					   					
					   						<td >
					   							<label class="control-label" style="font-size: 14px; margin-bottom: .0rem;">Name: </label>
					   						</td>
					   						<td >
                                                        <select class="form-control selectdee " name="EmpId" id="EmpId" required="required"  data-live-search="true"  >
                                                           <option value="A"  <%if(Employee.equalsIgnoreCase("A")){ %> selected="selected" <%} %>>ALL</option>	
                                                           
                                                           <%
                                                           for(Object[] obj:EmployeeList){ %>
														   <option value="<%=obj[0] %>" <%if(Employee.equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[1] %>, <%=obj[2] %></option>	
														<%} %>
																</select>	        
											</td>
											<td >
					   							<label class="control-label" style="font-size: 14px; margin-bottom: .0rem;">Date Type: </label>
					   						</td>
					   						<td >
                                                        <select class="form-control selectdee " name="Position" id="Assignee" required="required"  data-live-search="true"  >
                                               			 <option value="A" <%if("A".equalsIgnoreCase(Position)){ %> selected="selected" <%} %>>ALL</option>	
                                               			 <option value="P" <%if("P".equalsIgnoreCase(Position)){ %> selected="selected" <%} %>>PDC</option>	
															<option value="S" <%if("S".equalsIgnoreCase(Position)){ %> selected="selected" <%} %>>Assigned</option>	
															</select>					   						</td>
					   				
					   					    <td>
					   						<td >
					   							<label class="control-label" style="font-size: 14px; margin-bottom: .0rem;"> From Date:</label>
					   						</td>
					   						<td >
					   							<input  class="form-control"  data-date-format="dd/mm/yyyy" id="fdate" name="fdate"  required="required"  value="<%=fdate%>">
					   						</td>
					   						<td>
					   							<label class="control-label" style="font-size: 14px; margin-bottom: .0rem;"> To Date:</label>
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
												<table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
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
																				<button  type="submit" class="btn btn-outline-info"  formtarget="_blank" ><%=obj[0] %></button>
																			   <input type="hidden" name="ActionLinkId" value="<%=obj[10]%>"/>
																	           <input type="hidden" name="Assignee" value="<%=obj[1]%>,<%=obj[2]%>"/>
																	           <input type="hidden" name="ActionMainId" value="<%=obj[9]%>"/>
																	             <input type="hidden" name="ActionAssignId" value="<%=obj[12]%>"/>
 																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
																			
																			</form> 
                                                                        </td>
																		<td><%=sdf.format(obj[6])%></td>																		
																		<td><%=obj[1]%>, <%=obj[2]%></td>
																	  	<td> <%=obj[3]%>, <%=obj[4]%></td>
																		<td> 
																				<%if(obj[5]!=null && "N".equalsIgnoreCase(obj[5].toString())){%>
																						Assigned 
																				<%}else if(obj[5]!=null && "F".equalsIgnoreCase(obj[5].toString())){%>
																						Forward
																				<%}else if(obj[5]!=null && "B".equalsIgnoreCase(obj[5].toString())){%>
																						Send Back
																				<%}else if(obj[5]!=null && "Y".equalsIgnoreCase(obj[5].toString())){%>
																						Completed
																				<%}%>	
																		</td>
																		<td style="width:8% !important; "><%if(obj[11]!=null){ %>
																            <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																	            <div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[11]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																	            <%=obj[11]%>
																	            </div> 
																            </div> <%}else{ %>
																            <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																	            <div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
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