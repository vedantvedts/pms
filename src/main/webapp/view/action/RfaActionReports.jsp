<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../static/header.jsp"></jsp:include>
<meta charset="ISO-8859-1">
<title>RFA Action Reports</title>

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

#table tbody tr td {

	    padding: 4px 3px !important;

}
.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}
</style>
</head>
<body>
<%
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat();

SimpleDateFormat sdf2=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf3=new SimpleDateFormat("yyyy-MM-dd");

List<Object[]> ProjectList = (List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> RfaNoTypeList = (List<Object[]>)request.getAttribute("RfaNoTypeList");
List<Object[]> RfaActionList = (List<Object[]>)request.getAttribute("rfaActionList");
String fdate=(String)request.getAttribute("fdate");
String tdate=(String)request.getAttribute("tdate");  
String rfatypeid=(String)request.getAttribute("rfatypeid");  

String projectid = (String)request.getAttribute("projectid");

%>
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
           <div class="card-header ">  
					<div class="row">
						<h4 class="col-md-3">RFA Action Reports</h4>  
							<div class="col-md-9" style="float: right; margin-top: -8px;margin-left: -3%" >
					   			<form method="post" action="RfaActionReports.htm" name="dateform" id="myform">
					   				<table>
					   					<tr>
					   						<td>
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">Project: </label>
					   						</td>
					   						<td>
                                               <select class="form-control selectdee" id="projectid" required="required" name="projectid" onchange='submitForm1();' >
										<% if(ProjectList!=null && ProjectList.size()>0){
										 for (Object[] obj : ProjectList) {
											 String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";			 
										 %>
												<option value="<%=obj[0]%>" <%if(projectid.equalsIgnoreCase(obj[0].toString())) {%> selected <%} %>><%=obj[4]+projectshortName%></option>
										<%}} %>
								             </select>       
											</td>
											<td style="width:8%">
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">Type : </label>
					   						</td>
					   						<td style="width:15%">
                                              <select class="form-control selectdee" id="rfatypeid" name="rfatypeid"  >
                                              <option value="-" <%if(rfatypeid.equalsIgnoreCase("")) {%> selected <%} %>>ALL</option>
							   			        	<%if(RfaNoTypeList!=null && RfaNoTypeList.size()>0){
							   			        	  for (Object[] obj : RfaNoTypeList) {%>
											     <option value="<%=obj[1].toString()%>" <%if(rfatypeid!=null && rfatypeid.equalsIgnoreCase(obj[1].toString())){%>selected<%} %>><%=obj[1].toString()%></option>
											        <%}} %>   
							  	             </select>
											</td>
					   						<td style="width:11%">
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;" >From Date:</label>
					   						</td>
					   						<td>
					   							<input  class="form-control"  data-date-format="dd/mm/yyyy" id="fdate" name="fdate"  required="required"  value="<%=sdf.format(sdf1.parse(fdate))%>">
					   						</td>
					   						<td style="width:11%">
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">To Date:</label>
					   						</td>
					   						<td >
					   							<input  class="form-control "  data-date-format="dd/mm/yyyy" id="tdate" name="tdate"  required="required" value="<%=sdf.format(sdf1.parse(tdate))%>">
					   						</td>
					   							   									
					   					</tr>   					   				
					   				</table>
					   				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					   			</form>
		   					</div>
		   				</div>	   							
					</div>
			<form action="#">		
			<div class="card-body">
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed "
									id="myTable">
													<thead>
														<tr style="text-align: center;">
															<th >SN</th>
															<th>RFA No</th>	
															<th>RFA Date</th>
															<th>Priority</th>																								
														 	<th>Problem Statement</th>					 	
														 	<th>Observation</th>
														 	<th>Completion Date</th>
														 	<th>RFA Status</th>
														</tr>
													</thead>
													<tbody>
													<%if(!RfaActionList.isEmpty()) {
													int count=0;
													  for(Object[]obj:RfaActionList){%>
													<tr>
													<td style="text-align: center;"><%=++count %></td>
													<td><%if(obj[1]!=null){%><%=obj[1].toString() %><%}else{ %>-<%} %></td>
													<td><%if(obj[2]!=null){%><%=obj[2].toString()  %><%}else{ %>-<%} %></td>
													<td><%if(obj[3]!=null){%><%=obj[3].toString()  %><%}else{ %>-<%} %></td>
													<td><%if(obj[5]!=null){%><%=obj[5].toString()  %><%}else{ %>-<%} %></td>
													<td><%if(obj[10]!=null){%><%=obj[10].toString()  %><%}else{ %>-<%} %></td>
													<td><%if(obj[9]!=null){%><%=obj[9].toString()  %><%}else{ %>-<%} %></td>
													<td style="text-align: center;">
													
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                                       	  	<button type="submit" class="btn btn-sm btn-link btn-status" formaction="RfaTransStatus.htm" value="<%=obj[0] %>" name="rfaTransId"  data-toggle="tooltip" data-placement="top" title="Transaction History" 
	                                       	  	style=" color: #E65100; font-weight: 600;" formtarget="_blank"><%=obj[8] %> 
								    			</button>
													
													</td>
													</tr>
													<%}} %>
													</tbody>
												</table>												
											</div>
										</div>
										</form>
									</div>
								</div>
							</div>
						</div>
						
					
						<br>
						<div class="card-footer" align="right">&nbsp;</div>
		
</body>
<script type="text/javascript">
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

$(document).ready(function() {
	$('#projectid').on('change', function() {
		var temp = $(this).children("option:selected").val();
		$('#myform').submit();
	});
	});
	
$('#rfatypeid').on('change', function() {
	var temp = $(this).children("option:selected").val();
	$('#myform').submit();
});
$('#fdate').on('change', function() {
	$('#myform').submit();
});
$('#tdate').on('change', function() {
	$('#myform').submit();
});

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
});
</script>
</html>