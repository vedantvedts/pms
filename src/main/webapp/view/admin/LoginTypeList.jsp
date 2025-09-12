<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/admin/LoginTypeList.css" var="loginTypeList" />
<link href="${loginTypeList}" rel="stylesheet" />

<title>LOGIN TYPE LIST</title>
</head>
<body>


<%List<Object[]> LoginTypeList=(List<Object[]>)request.getAttribute("loginTypeList"); %>


	
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

    

	
	<div class="container-fluid">		
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover" >
				<div class="card-header">
					<h4> Login Type List </h4>
				</div>
				<div class="card-body" align="center" > 
					<div class="col-md-8">
						<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" >
				              <thead>
				              		<tr>
				                    	<th class="text-center" >SN</th>
				                        <th class="text-center">Login Type</th>
				                        <th class="text-center">Code</th>
									</tr>
		                      </thead>
				              <tbody>
									<%for(Object[] 	obj:LoginTypeList){ %>
									<tr>
										<td class="text-center" ><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
										<td class="text-center" ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></td>				 
										<td class="text-center" ><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - " %></td>
									</tr>
									<%} %>
							  </tbody>
				          </table>
			          </div>
				</div>
             </div>
	</div></div>
	
</div>	
	
	
	


				
					
<script type="text/javascript">


$(document).ready(function() {
	$("#myTable").DataTable({
			'aoColumnDefs': [{
			'bSortable': false,
			'aTargets': [-1] /* 1st one, start by the right */
		}]
	});
});
	  
</script>
				
				
</body>
</html>