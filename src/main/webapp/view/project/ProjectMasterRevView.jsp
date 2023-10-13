<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Project Revision Data</title>
</head>
<%
	List<Object[]> projectslist=(List<Object[]>) request.getAttribute("projectslist");
	List<Object[]> ProjectMasterRevList=(List<Object[]>) request.getAttribute("ProjectMasterRevList");
	String projectid = (String) request.getAttribute("projectid");
%>

<body>
	<div class="container-fluid">
		<div class="card">
			<div class="card-header">
				<div class="row">
					<div class="col-6">
						<h4>Project Revision</h4>
					</div>
					<div class="col-6">
						<div class="row">
							<div class="col-2"></div>
							<div class="col-4" align="right"><h4>Project :</h4></div>
							<div class="col-4">
								<form action="ProjectMasterRevView.htm" method="POST" id="myform">
									<select class="form-control selectdee" name="ProjectId" onchange="this.form.submit()" required="required">
										<%for(Object[] project : projectslist){ %>
										<option value="<%=project[0]%>" <%if(project[0].toString().equalsIgnoreCase(projectid)){ %> selected <%} %> ><%=project[4] %></option>
										<%} %>
									</select>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								</form>
								
							</div>
							<div class="col-2"><a class="btn btn-sm back" href="ProjectList.htm">BACK</a></div>
						</div>
					</div>
				</div>
			</div>
			<div class="card-body" style="min-height: 35rem;">
				<div class="row" style="overflow-y: scroll; ;">
					<%for(Object[] obj :  ProjectMasterRevList){ %>
					<table style="width: 100%;margin: 10px; border-bottom: 1px solid black " >
						<tr>
							<td colspan="5" align="center" style="color :white;font-weight:600 ; background-color : #344CB7 ;border-top-left-radius :8px;border-top-right-radius :8px;"> 
							<%if(Integer.parseInt(obj[1].toString())==0){ %> Original <%}else{ %>Revision - <%=obj[1] %> <%} %>
							</td>
						</tr>
						<tr style="background-color: #577BC1 ; color: white;font-weight:600 ">
							<td style="padding: 6px;">Project Name </td>
							<td>Project Code</td>
							<td>Project Main</td>
							<td>Category</td>
							<td style="padding: 6px;" >Type</td>
						</tr>
						<tr style="font-weight:600 ">
							<td style="padding: 6px; " ><%=obj[4] %></td>
							<td><%=obj[3] %></td>
							<td><%=obj[2] %></td>
							<td><%=obj[7] %></td>
							<td><%=obj[8] %></td>
						</tr>
						<tr  style="background-color: #577BC1; color: white; font-weight:600" >
							<td style="padding: 6px;"  >Sanction Date</td>
							<td>PDC</td>
							<td>Total Cost (Lakhs)</td>
							<td>Project Director</td>
							<td>Sanction No.</td>
						</tr>
						<tr style="font-weight:600 ">
							<td style="padding: 6px;"><%=obj[10] %></td>
							<td><%=obj[12] %></td>
							<td><%=obj[11] %></td>
							<td><%=obj[13] %>, <%=obj[14] %></td>
							<td><%=obj[9] %></td>
						</tr>
					</table>
					<%} %>
				</div>
			</div>		
		</div>
	</div>	
</body>
</html>