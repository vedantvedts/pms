<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/admin/InitiationApprAuthList.css" var="initiationApprAuthList" />
<link href="${initiationApprAuthList}" rel="stylesheet" />

</head>
<body>
<%
List<Object[]> InitiationApprAuthList=(List<Object[]>) request.getAttribute("InitiationApprAuthList");

FormatConverter fc = new FormatConverter();
SimpleDateFormat rdf = fc.getRegularDateFormat();
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


	
<br>	
	
<div class="container-fluid">		
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover" >
				<div class="card-header">
					<div class="row">
						<div class="col-md-2"><h4>Approval Authority</h4></div>
					</div>
				</div>
				<div class="card-body"> 
		        	<form action="InitiationApprAuth.htm" method="POST" name="frm1">
						<div class="data-table-area mg-b-15">
			            	<div class="container-fluid">
			                	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			                        <div class="sparkline13-list">
			                            <div class="sparkline13-graph">
			                                <div class="datatable-dashv1-list custom-datatable-overright">
			                					<table class="table table-bordered table-hover table-striped table-condensed " id="myTable" > 
			                      					<thead  class="text-center">
			                                        	<tr> 
						                              		<th>Select</th>
						                              		<th>Authorized Officer </th>
				                                            <th>Role</th>
				                                            <th>valid From</th>
				                                            <th>valid To</th>
				                                    	</tr>      
			                          				</thead>
								                    <tbody>
						                                 <%
						                                 if(InitiationApprAuthList!=null && InitiationApprAuthList.size()>0) {
						                                 for(Object[] obj:InitiationApprAuthList){ %>
						                                     <tr>
							                                     <td class="text-center"><input type="radio" name="RtmddoId" value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):""%>  ></td> 
							                                     <td class="text-left"><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %> (<%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "%>), <%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %></td>
							                                     <td class="text-center"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
																 <td class="text-center"><%if(obj[3]!=null){%><%=StringEscapeUtils.escapeHtml4(rdf.format(obj[3])) %><%}else{ %>-<%} %></td>
																 <td class="text-center"><%if(obj[4]!=null){%><%=StringEscapeUtils.escapeHtml4(rdf.format(obj[4])) %><%}else{ %>-<%} %></td>
						                                     </tr>
						                                  <%} }%>
						                             </tbody>
			                 					</table>
			                   				</div>
			                 			</div>
			                		</div>
			             		</div>
			          		</div>
			        	</div>
						<div align="center"> 
							<button type="submit" class="btn btn-primary btn-sm add" name="action" value="Add">ADD</button>&nbsp;&nbsp;
					        <%if(InitiationApprAuthList!=null&&InitiationApprAuthList.size()>0){%>
					        	<button type="submit" class="btn btn-warning btn-sm edit" name="action" value="Edit" onclick="Edit(frm1)"  >EDIT</button>&nbsp;&nbsp;
					        	<button type="submit" class="btn btn-danger btn-sm delete" name="action" value="Revoke" onclick="return Revoke()"  >REVOKE</button>&nbsp;&nbsp;
					        <%}%>
						</div>	
 						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
			        </form>
        		</div>
			</div>
		</div> 
	</div>	
</div>
	
	
<script type="text/javascript">
function Edit(myfrm){
	
	 var fields = $("input[name='RtmddoId']").serializeArray();

	  if (fields.length === 0){
	alert("Please Select Atleast One Admin");
	 event.preventDefault();
	return false;
	}
		  return true;
	}
	
function Revoke() {

	var fields = $("input[name='RtmddoId']").serializeArray();

	if (fields.length === 0) {
		alert("Please Select Atleast One Admin");

		event.preventDefault();
		return false;
	}else {
		if(confirm("Are you sure To Revoke?")){
			return true;
		}else{
			return false;
		}
		
	}
}	
</script>

<script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
});
});

</script>

</body>
</html>