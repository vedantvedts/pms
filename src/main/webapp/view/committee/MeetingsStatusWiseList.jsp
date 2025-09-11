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
  List<Object[]> meetingstatuslist=(List<Object[]>)request.getAttribute("meetingstatuslist");
  String projectid=(String)request.getAttribute("projectid");
  String statustype=(String)request.getAttribute("statustype");
 %>

<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header ">  

					<div class="row">
						<h3 class="col-md-11">
						<%if("UP".equalsIgnoreCase(statustype)){ %>Upcoming <%} %>
						<%if("CO".equalsIgnoreCase(statustype)){ %>Completed <%} %>
						<%if("CA".equalsIgnoreCase(statustype)){ %> Cancelled<%} %>	 Meetings </h3>  
							<div class="col-md-1" style="float: right;">
								<form action="MeetingsStatusReports.htm" name="myfrm" id="myfrm" method="post">
								<input type="hidden" name="projectid"  value="<%=projectid%>"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
								
					   		  <button type="submit"  name="sub" value="back" class="btn btn-primary back"  style="margin-top:10px;padding: 0.375rem 17px;"> Back</button>
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
															<th>Meeting Id</th>	
															<th >Date </th>																							
														 	<th >Time</th>					 	
														 	<th >Committee</th>
														 	
														</tr>
													</thead>
													<tbody>
														<%int count=1;
															if(meetingstatuslist!=null && meetingstatuslist.size()>0)
															{
												   					for (Object[] obj :meetingstatuslist) 
												   					{ %>
												   					
																	<tr>
																		<td><%=count %></td>
																		<%-- <td>
																		<form action="ActionDetails.htm" method="POST" >
																				<button  type="submit" class="btn btn-outline-info"  formtarget="_blank" ><%=obj[0] %></button>
																			   <input type="hidden" name="ActionLinkId" value="<%=obj[11]%>"/>
																	           <input type="hidden" name="Assignee" value="<%=obj[1]%>,<%=obj[2]%>"/>
																	           <input type="hidden" name="ActionMainId" value="<%=obj[10]%>"/>
 																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
																			
																			</form>  
                                                                        </td> --%>
																		<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></td>																		
																		<td><%=obj[2]!=null?sdf.format(obj[2]): " - " %></td>
																	  	<td> <%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
																		<td><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - " %></td>				
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



</script>


</body>
</html>