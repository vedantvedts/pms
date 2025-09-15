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
<spring:url value="/resources/css/master/updateSeniority.css" var="updateSeniority" />     
<link href="${updateSeniority}" rel="stylesheet" />


<title>OFFICER DETAILS</title>

</head>
<body>

<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
Object[] officerData=(Object[])request.getAttribute("officersDetalis");
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
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="card-header seniorityHeader">
					<b class="text-white">Update Seniority</b>
				</div>
				
				<form action="UpdateSenioritySubmit" method="post">
				  				<div class="card-body">
					<div class="row">
						<div class="col-md-1"></div>
						<div class="col-md-1">
							<label class="control-label">SrNo :</label> 
							<input class="form-control " type="number" min="0" name="UpdatedSrNo"  onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57" id="SrNo" value="<%=officerData[9]!=null?StringEscapeUtils.escapeHtml4(officerData[9].toString()):""%>">
							<input type="hidden" name="empid" value="<%=officerData[0]%>" >					
						</div>
						<div class="col-md-2">
							<label class="control-label">Employee No :</label> 
							<input class="form-control " value="<%=officerData[1]!=null?StringEscapeUtils.escapeHtml4(officerData[1].toString()):""%>"  readonly="readonly">
						</div>
						<div class="col-md-3">
							<label class="control-label">Employee Name :</label> 
							<input class="form-control " value="<%=officerData[2]!=null?StringEscapeUtils.escapeHtml4(officerData[2].toString()):""%>"  readonly="readonly">
						</div>
						<div class="col-md-2">
							<label class="control-label">Designation  :</label> 
							<input class="form-control " value="<%=officerData[3]!=null?StringEscapeUtils.escapeHtml4(officerData[3].toString()):""%>" readonly="readonly">
						</div>
						

                        <div class="col-md-2">
							<label class="control-label">Division :</label> 
							<input class="form-control " value="<%=officerData[6]!=null?StringEscapeUtils.escapeHtml4(officerData[6].toString()):""%>" readonly="readonly">
						</div>
				
						
					</div>
                   <div class="row submitDiv"  >
                       <div class="col-md-5"></div>
                         <div class="col-md-2">
                         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                      <button class="btn btn-sm submit" type="submit" id="UpdateSenioritySubmit"    onclick="return confirm('Are You Sure To Submit!')"> Submit</button>
                      <a class="btn btn-sm back" href="Officer.htm" >Back</a>
                      </div>
                   </div>
				</div>
				</form>
			</div>
		</div>

	</div>
<script type="text/javascript">
$(document).ready(function(){
    $("#SrNo").numeric();
})
</script>
</body>
</html>