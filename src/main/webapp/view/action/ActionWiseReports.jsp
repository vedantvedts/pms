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
<spring:url value="/resources/css/action/actionWiseReports.css" var="actionWiseReports" />
<link href="${actionWiseReports}" rel="stylesheet" />
<spring:url value="/resources/css/action/actionCommon.css" var="actionCommon" />
<link href="${actionCommon}" rel="stylesheet" />
 

<title>Assignee List</title>

</head>
 
<body>
  <%
  FormatConverter fc=new FormatConverter(); 
  SimpleDateFormat sdf=fc.getRegularDateFormat();
  List<Object[]> AssigneeList=(List<Object[]>)request.getAttribute("StatusList");
  String ProjectId=(String)request.getAttribute("ProjectId");
  String ActionType=(String)request.getAttribute("ActionType");
 %>





<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header ">  

					<div class="row">
						<h3 class="col-md-11"><%if("F".equalsIgnoreCase(ActionType)){ %>Act To Review Wise <%} %>
						<%if("Y".equalsIgnoreCase(ActionType)){ %>Completed   Wise <%} %>
						<%if("P".equalsIgnoreCase(ActionType)){ %>Pending   Wise <%} %>
						<%if("E".equalsIgnoreCase(ActionType)){ %>Delayed Wise <%} %> Action Reports</h3>  
							<div class="col-md-1 float-right">
								<form action="ActionPDReports.htm" name="myfrm" id="myfrm" method="post">
								<input type="hidden" name="ProjectId"  value="<%=ProjectId%>"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								
					   		  <button type="submit"  name="sub" value="back" class="btn btn-primary back back-btn"  > Back</button>
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
															<th>SN</th>
															<th>Action Id</th>	
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
																		
																				<button  type="submit" class="btn btn-outline-info"  formtarget="_blank" ><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):"" %></button>
																			 
                                                                        </td>
																		<td><%=obj[6]!=null?sdf.format(obj[6]):""%></td>																		
																		<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - "%></td>
																	  	<td>Ext: <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):" - "%>, Mob: <%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - "%></td>
																		<td class="td-styl"><%if(obj[12]!=null){ %>
															            <div class="progress div-progress">
															            <div class="progress-bar progress-bar-striped width-<%=obj[12]%>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															            <%= StringEscapeUtils.escapeHtml4(obj[12].toString())%>
															            </div> 
															            </div> <%}else{ %>
															            <div class="progress div-progress">
															            <div class="progress-bar progressbar" role="progressbar" >
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