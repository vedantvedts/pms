<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.login.Login"%>
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

<spring:url value="/resources/css/admin/UserManagerEdit.css" var="userManagerEdit" />
<link href="${userManagerEdit}" rel="stylesheet" />
<title>User Credentials Update</title>
</head>
<body>
<%List<Object[]> DivisionList=(List<Object[]>)request.getAttribute("DivisionList");
List<Object[]> RoleList=(List<Object[]>)request.getAttribute("RoleList");
Login login=(Login)request.getAttribute("UserManagerEditData");
List<Object[]> EmpList=(List<Object[]>)request.getAttribute("EmpList");
List<Object[]> LoginTypeList=(List<Object[]>)request.getAttribute("LoginTypeList");

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
	
<div class="container">
	<div class="row" >

		<div class="col-md-12">
		<div align="center">
		<div class="badge badge-success" >LoginType:<%=login.getLoginType()!=null?StringEscapeUtils.escapeHtml4(login.getLoginType()): " - " %>&nbsp;&nbsp;||&nbsp;Username:<%=login.getUsername()!=null?StringEscapeUtils.escapeHtml4(login.getUsername()): " - " %> </div></div>
 			<div class="card shadow-nohover" >
				
				<div class="card-header" >
                    <b class="text-white">User Credentials Update</b>
        		</div>
        
        		<div class="card-body">
						<form name="myfrm" action="UserManagerEditSubmit.htm"
							method="POST">
							<div class="form-group">
								<div class="table-responsive">
									<table
										class="table table-bordered table-hover table-striped table-condensed ">
										<thead>


											<tr>
												<th><label>Division: <span class="mandatory">*</span>
												</label></th>
												<td><select class="form-control selectdee font-5"
													name="Division" data-container="body"
													data-live-search="true" required="required">
														<option value="" disabled="disabled" selected="selected"
															hidden="true">--Select--</option>
														<% for (Object[] obj : DivisionList) { %>
														<option value="<%=obj[0]%>" <%if (Integer.parseInt(obj[0].toString()) == login.getDivisionId()) {%> selected="selected" <%}%>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
														<% } %>

												</select></td>

												<th><label>Login Type: <span class="mandatory">*</span>
												</label></th>
												<td class="w-300"><input type="hidden"
													name="Role" value="1"> <select
													class="form-control selectdee w-100 font-5" name="LoginType"
													id="LoginType" data-container="body"
													data-live-search="true" required="required">
														<option value="" disabled="disabled" selected="selected"
															hidden="true">--Select--</option>
														<%
														for (Object[] obj : LoginTypeList) {
														%>
														<option value="<%=obj[0]%>"
															<%if (obj[0].toString().equalsIgnoreCase(login.getLoginType())) {%>
															selected="selected" <%}%>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
														<%
														}
														%>
												</select></td>
											</tr>
											<tr>
												<th><label>Employee: <span class="mandatory">*</span>
												</label></th>
												<td><select class="form-control selectdee font-5"
													name="Employee" id="Employee" data-container="body"
													data-live-search="true" required="required">

														<%
														for (Object[] obj : EmpList) {
														%>
														<option value="<%=obj[0]%>"
															<%if (Long.parseLong(obj[0].toString()) == login.getEmpId()) {%>
															selected="selected" <%}%>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
														<%
														}
														%>

												</select></td>
												<th><label>PMS Login: <span class="mandatory">*</span>
												</label></th>
												<td colspan="3"><select class="form-control w-50"
													name="pfmsLogin" required="required">
														<option value="N" <%if (login.getPfms().equals("N")) {%>
															selected="selected" <%} %>>No</option>
														<option value="Y" <%if(login.getPfms().equals("Y")){ %>
															selected="selected" <%} %>>Yes</option>
												</select></td>
											</tr>
										</thead>
									</table>

								</div>
							</div>
							<div class="row ml-40"  align="center">
                               <button type="submit" class="btn btn-primary btn-sm submit">SUBMIT</button>
                               <a class="btn btn-info btn-sm shadow-nohover back ml-2"  
                               href="UserManagerList.htm">Back</a>
                           </div>
							<input type="hidden" name="LoginId"
								value="<%=login.getLoginId() %>" /> <input type="hidden"
								name="${_csrf.parameterName}" value="${_csrf.token}" />

						</form>


					</div>
</div>
</div>
</div>	
	
	
	  
<script type="text/javascript">

$(document)
.on(
		"change",
		"#LoginType",

		function() {
			// SUBMIT FORM

	
			var $LoginType = this.value;

		
		
			if($LoginType=="D"||$LoginType=="G"||$LoginType=="T"||$LoginType=="O"||$LoginType=="B"||$LoginType=="S"||$LoginType=="C"||$LoginType=="P"||$LoginType=="U"){
			
				$("#Employee").prop('required',true);
			}
			else{
				$("#Employee").prop('required',false);
			}
	
		});

</script>
</body>
</html>