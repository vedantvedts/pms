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

 

<title>Meeting Search</title>
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
  List<Object[]> meetingsearch=(List<Object[]>)request.getAttribute("meetingsearch");
  String LoginType=(String)session.getAttribute("LoginType");

  
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
						<h4 class="col-md-5">Meeting Id Search</h4>  
							<div class="col-md-7" style="margin-top: -8px;">
					   			<form method="post" action="MeetingSearch.htm" name="dateform" id="dateform">
					   				<table style="float: right;" >
					   					<tr>
					   						<td >
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">Meeting Id : </label>
					   						</td>
					   						<td style="max-width: 300px; padding-right: 50px">                      
					   							<input type="text" class="form-control form-control" name="search" maxlength="20" required="required">				   		
					   						</td>
					   						<td>
					   							<input type="submit" value="SUBMIT" class="btn  btn-sm submit "/>
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
															<th>SN </th>
															<th>Meeting Id</th>
															<th>Date & Time</th>
															<th>Committee</th>																							
														 	<th >Venue</th>					 	
														 	<!-- <th >Role</th> -->
														</tr>
													</thead>
													<tbody>
														<%int count=1;
															if(meetingsearch!=null&&meetingsearch.size()>0)
															{
												   					for (Object[] obj :meetingsearch) 
												   					{ 
												   					%>
												   					
																	<tr>
																		<td><%=count %></td>
																		<td>
																			<form action="CommitteeMinutesViewAll.htm" method="post" >
																				<button  type="submit" class="btn btn-outline-info" formtarget="_blank" ><%=obj[7] %></button>
																				<input type="hidden" name="committeescheduleid" value="<%=obj[2] %>" />
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																			</form>
																		</td>
																		<td><%=sdf.format(obj[3])%> - <%=obj[4] %></td>
																		<td> <%=obj[9]%></td>
																		<td><%if(obj[10]!=null){%> <%=obj[10]%> <%}else{ %> &nbsp;&nbsp;&nbsp;&nbsp;- <%} %></td>																	
																		<%-- <td>
																			<%if("CS".equalsIgnoreCase(obj[6].toString())){ %> Member Secretary <%} %>
																			<%if("CC".equalsIgnoreCase(obj[6].toString())){ %> Chairperson <%} %>
																			<%if("P".equalsIgnoreCase(obj[6].toString())){ %> Presenter <%} %>
																			<%if("C".equalsIgnoreCase(obj[6].toString())){ %> Committee Member <%} %>
																			<%if("E".equalsIgnoreCase(obj[6].toString())){ %> External Member <%} %>
																			<%if("I".equalsIgnoreCase(obj[6].toString())){ %> Internal Member<%} %>
																		</td> --%>
																					
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

/* $(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 10
	})
})
 */

</script>


</body>
</html>