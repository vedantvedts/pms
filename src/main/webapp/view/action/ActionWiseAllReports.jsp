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
  List<Object[]> AssigneeList=(List<Object[]>)request.getAttribute("StatusList");
  String ProjectId=(String)request.getAttribute("ProjectId");
  String ActionType=(String)request.getAttribute("ActionType");
  String Type=(String)request.getAttribute("Type");
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
 %>





<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header ">  

					<div class="row">
						<h4 class="col-md-4">
						<%if("F".equalsIgnoreCase(Type)){ %>Forwarded <%} %>
						<%if("C".equalsIgnoreCase(Type)){ %>Completed  <%} %>
						<%if("P".equalsIgnoreCase(Type)){ %>Pending    <%} %>
						<%if("D".equalsIgnoreCase(Type)){ %>Delayed  <%} %> Action Reports</h4>  
							<div class="col-md-8" style="float: right; margin-top: -8px;">
								 <table>
								 	<tr style="">
								 		
								 		<td>
											 Project :   &ensp;
										</td>
										
										<td>
											<form class="form-inline" method="post" action="ActionWiseAllReport.htm" name="myform" id="myform" style="float:right">
				                            	<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId" style="width:220px !important">
				    									<option disabled="true"  selected value="">Choose...</option>
				    									<%-- <option value="A" <%if(ProjectId.toString().equalsIgnoreCase("A")){ %>selected="selected" <%} %>>All</option>
				    									<option value="0" <%if(ProjectId.toString().equalsIgnoreCase("0")){ %>selected="selected" <%} %>>General</option> --%>
				    									
				    										<% 
				    										if(ProjectList!=null && ProjectList.size()>0){
				    										for (Object[] obj : ProjectList) {
				    											String projectshortName=(obj[4]!=null)?" ( "+obj[4].toString()+" ) ":"";
				    										%>
														<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - "+projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName):" - "%></option>
															<%}} %>
				  								</select>
                            					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
												<input type="hidden" name="ProjectId"  id="ProjectId" value="<%=ProjectId %>" /> 
												<input type="hidden" name="ActionType"  id="ActionType" value="<%=ActionType %>" />
												<input type="hidden" name="Type"  id="Type" value="<%=Type %>" />
											</form>	
								  		</td>
								 		
								 		<td>Action Type :   &ensp;</td>
								 		
								 		<td>
								 		  <form action="ActionWiseAllReport.htm" name="actiontypefrm" id="actiontypefrm" method="post">	
											<select class="form-control " id="ActionType" required="required" name="ActionType" onchange="submitForm('actiontypefrm');" >
								   				<%-- <option <%if("A".equalsIgnoreCase(ActionType)){ %>selected<%} %> value="A">All</option> --%>
								   				<option <%if("NA".equalsIgnoreCase(ActionType)){ %>selected<%} %> value="NA">Action</option>
								   				<option <%if("MA".equalsIgnoreCase(ActionType)){ %>selected<%} %> value="MA">Meeting</option>
								   				<option <%if("MLA".equalsIgnoreCase(ActionType)){ %>selected<%} %> value="MLA">Milestone</option>
								   				<option <%if("RK".equalsIgnoreCase(ActionType)){ %>selected<%} %> value="RK">Risk</option>								   				 
								   				<option <%if("IU".equalsIgnoreCase(ActionType)){ %>selected<%} %> value="IU">Issue</option>								   				 
								   				<option <%if("RC".equalsIgnoreCase(ActionType)){ %>selected<%} %> value="RC">Recommendation</option>								   				 
								  			</select>
								  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								  			<input type="hidden" name="ProjectId"  id="ProjectId" value="<%=ProjectId %>" /> 
											<input type="hidden" name="ActionType"  id="ActionType" value="<%=ActionType %>" />
											<input type="hidden" name="Type"  id="Type" value="<%=Type %>" />
								  			</form>	
								 		</td>
								 		
								 		
								 		<td>
											 Type :   &ensp;
										</td>
										
										<td>
											<form action="ActionWiseAllReport.htm" name="typefrm" id="typefrm" method="post">	
											<select class="form-control " id="Type" required="required" name="Type" onchange="submitForm('typefrm');" >
								   				<%-- <option <%if("A".equalsIgnoreCase(ActionType)){ %>selected<%} %> value="A">All</option> --%>
								   				<option <%if("P".equalsIgnoreCase(Type)){ %>selected<%} %> value="P">Pending</option>
								   				<option <%if("F".equalsIgnoreCase(Type)){ %>selected<%} %> value="F">Forwarded</option>
								   				<option <%if("C".equalsIgnoreCase(Type)){ %>selected<%} %> value="C">Completed</option>
								   				<option <%if("D".equalsIgnoreCase(Type)){ %>selected<%} %> value="D">Delayed</option>								   				 
								  			</select>
								  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								  			<input type="hidden" name="ProjectId"  id="ProjectId" value="<%=ProjectId %>" /> 
											<input type="hidden" name="ActionType"  id="ActionType" value="<%=ActionType %>" />
											<input type="hidden" name="Type"  id="Type" value="<%=Type %>" />
								  			</form>	
								  		</td>
										<td> 	 	
									   		  <a type="submit"  class="btn btn-sm back" href="MainDashBoard.htm" style="margin-left :25px ;"> Back</a>
								   		</td>
					   			
					   			</tr>
							</table>
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
															<th>SN</th>
															<th>Action No</th>	
															<th >PDC</th>																							
														 	<th >Assignee</th>					 	
														 	<th >Mob No</th>
														 	<th class="width-115px">Progress</th>
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
																				<button  type="submit" class="btn btn-outline-info"  formtarget="_blank" ><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - " %></button>
																			   <input type="hidden" name="ActionLinkId" value="<%=obj[13]%>"/>
																	           <input type="hidden" name="Assignee" value="<%=obj[3]%>,<%=obj[4]%>"/>
																	           <input type="hidden" name="ActionMainId" value="<%=obj[1]%>"/>
																	           <input type="hidden" name="ActionAssignId" value="<%=obj[0]%>"/>
																	           <input type="hidden" name="ActionNo" value="<%=obj[2]%>">
 																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
																			
																			</form>  
                                                                        </td>
																		<td><%=obj[8]!=null?sdf.format(obj[8]):" - "%></td>																		
																		<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):" - "%>, <%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - "%></td>
																	  	<td>Ext: <%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()):" - "%>, Mob: <%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()):" - "%></td>
																		<td style="width:8% !important; "><%if(obj[14]!=null){ %>
															            <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															            <div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[14]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															            <%=StringEscapeUtils.escapeHtml4(obj[14].toString()) %>
															            </div> 
															            </div> <%}else{ %>
															            <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															            <div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															             Not Yet Started .
															            </div>
															            </div> <%} %></td>				
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

$('#ProjectId').on('change',function(){
	
	$('#myform').submit();
})




$('#fdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	"maxDate" : new Date(),
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
	"maxDate" : new Date(),
	
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

/* $(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 10
	})
})

 */
</script>
<script type='text/javascript'> 
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
</script>



</body>
</html>