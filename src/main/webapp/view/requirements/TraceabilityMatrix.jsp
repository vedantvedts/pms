<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.util.stream.Collectors"%>
<%@page import="java.util.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
<%@page import="com.vts.pfms.FormatConverter"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
</head>
<body>
<%
List<Object[]>ProjectParaDetails=(List<Object[]>)request.getAttribute("ProjectParaDetails");
List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList");
List<Object[]>subList=new ArrayList<>();
if(RequirementList!=null && ProjectParaDetails!=null && !ProjectParaDetails.isEmpty()&&!RequirementList.isEmpty()) {   
	subList= RequirementList.stream().filter(e->e[15]!=null&&!e[15].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
}


%>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
			<div class="card shadow-nohover" style="margin-top: -0.6pc">
			<div class="row card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
					<div class="col-md-4">
				<h5 id="text" style="margin-left: 1%; font-weight: 600">Forward Traceability Matrix</h5>
					</div>
					</div>
					
						<div class="card">
					<div class="card-body">
					
					
					
			<table class="table table-bordered">
					<thead>
						<tr>
						<th>SN </th>
						<th>QR Para </th>
						<th>Requirement Id </th>
						<th>Specification Id </th>
						
						
						</tr>
					</thead>
						<tbody>
					<%if(ProjectParaDetails!=null && ProjectParaDetails.size()>0) {
					int paraCount=0;
					%>
						<%for(Object []obj:ProjectParaDetails) {
							List<Object[]>ReqId = new ArrayList<>();
							
							if(subList.size()>0){
								ReqId=subList.stream().filter(e->e[12]!=null && Arrays.asList(e[12].toString().split(", ")).contains(obj[0].toString())).collect(Collectors.toList());
							}
						
						%>
						<tr>
						<td ><%=++paraCount %></td>
						<td ><%=obj[3].toString() %></td>
						<td >
						<%if(ReqId.size()>0) {
						for(Object[]obj1:ReqId){
						%>
						<div style="border: 1px solid #dee2e6"><%=obj1[1] %></div>
						
						<%}} %>
						</td>
					
						</tr>
						<%} %>
					<%}else{ %>
					
					<tr>
					<td colspan="4" style="text-align: center;">No Traceability made yet!</td>
					</tr>
					<%} %>
						</tbody>
					</table>
					
					
					</div>
					</div>
					</div>
			
			</div>
			</div>
			</div>
</body>
</html>