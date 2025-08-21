<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<style type="text/css">
 .popup-content {
            display: none;
            position: relative;
            top: 100%;
            left: 50%;
            transform: translateX(-50%);
            padding: 10px;
            background-color: #f1f1f1;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

#forward img {
width:300px !important;
}

.RDiv{
border: 1px solid #dee2e6;
text-align: center;
padding:3px;
cursor: pointer;
}
</style>
</head>
<body>
<%
String projectType = (String)request.getAttribute("projectType");
String projectId =(String)request.getAttribute("projectId");
String initiationId =(String)request.getAttribute("initiationId");
String productTreeMainId =(String)request.getAttribute("productTreeMainId");
List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList");
List<Object[]>subList=new ArrayList<>();
if(RequirementList!=null &&!RequirementList.isEmpty()) {   
subList= RequirementList.stream().filter(e->e[15]!=null&&!e[15].toString().equalsIgnoreCase("0"))
			.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
			.collect(Collectors.toList());}
List<Object[]>specsList = (List<Object[]>)request.getAttribute("specsList");
if(specsList!=null && specsList.size()>0)
{
specsList=specsList.stream().filter(e->!e[7].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
}
%>

	<div class="container-fluid">
		
		<div class="row">
			<div class="col-md-12">
			<div class="card shadow-nohover" style="margin-top: -0.6pc">
			<div class="row card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
					<div class="col-md-6">Project Development System</div>
						<div class="col-md-4"></div>
					<div class="col-md-2">
					<form action="ProjectSpecification.htm" method="post">
				    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden" name="projectType" id="projectType11" value="<%=projectType %>">
	                <input type="hidden" name="projectId"  value="<%=projectId!=null?projectId:"0" %>">
	                <input type="hidden" name="initiationId"  value="<%=initiationId!=null?initiationId:"0" %>">
	                <input type="hidden" name="productTreeMainId"  value="<%=productTreeMainId!=null ?productTreeMainId:"0" %>">
	                <button class="btn btn-sm back" style="margin-top: -1%;">BACK</button>
					</form>
					</div>
					
					
					</div>
					
						<div class="card">
						<div align="center" class="mt-2">
						<button id="forwardbtn" class="btn btn-lg" onclick="showDiv('forward','backward')">Forward Traceability</button>
						&nbsp;&nbsp;
						<button id="backwardbtn" class="btn btn-lg" onclick="showDiv('backward','forward')">Backward Traceability</button>
						</div>
					<div class="card-body" id="forward">
					
					
					<table class="table table-bordered">
					<thead>
						<tr>
						<th style="width:5% ;text-align: center;">SN </th>
						<th>System SpecificationId </th>
						<th>System RequirementId</th>
						</tr>
						</thead>
						<tbody>
								<%
						
						if(specsList!=null && specsList.size()>0){
							specsList=specsList.stream().filter(e->!e[7].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
						}
						if(specsList!=null && specsList.size()>0){
							int rowCOunt=0;
						for(Object[]obj:specsList) {%>
						<tr>
						<td style="text-align: center;"> <%=++rowCOunt %>. </td>
						<td > <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%> </td>
						<td > 
							<%
							List<Object[]>linkedReq= new ArrayList<>();
							List<String>tempReq = new ArrayList<>();
							if(obj[4]!=null){
								tempReq= Arrays.asList(obj[4].toString().split(","));
							}
							if(subList!=null && subList.size()>0){
							for(Object[]obj1:subList){
								if(tempReq.contains(obj1[0].toString())){
									linkedReq.add(obj1);
								}
							%>
							<%}} %>	
							<%if(linkedReq.size()>0) {
							for(Object[]obj2:linkedReq){
							%>
							<div class="RDiv" id ='' style="" onclick="showReqDiv()"><%=obj2[1]!=null?StringEscapeUtils.escapeHtml4(obj2[1].toString()): " - " %></div>
							<% %>
						
							<%}}else{ %>
							<div align="center">-</div>
							<%} %>
						
						 </td>
						</tr>
						<%}} %>
						</tbody>
						</table>
					
					</div>
					
				<div class="card-body" id="backward">
				<table class="table table-bordered">
				  <thead>
					<tr>
					<th style="width:5% ;text-align: center;">SN </th>
					<th>System RequirementId</th>
					<th>System SpecificationId </th>
					</tr>
					</thead>
					<%
					if(subList!=null && subList.size()>0){
					int rowCOunt=0;
					for(Object[]obj:subList) {
					List<Object[]>specid = new ArrayList<>();
					for(Object[]obj1:specsList) {
				    String spec=obj1[4]!=null?obj1[4].toString():""; 
					if(Arrays.asList(spec.split(",")).contains(obj[0].toString())){
					specid.add(obj1);
					}%><%} %>
					<tr>
					<td style="text-align: center;"> <%=++rowCOunt %>. </td>
					<td> <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %> </td>
					<td> 
					<%if(specid.size()>0){
					for(Object[]spec:specid){%>
					<div class="RDiv"><%=spec[1]!=null?StringEscapeUtils.escapeHtml4(spec[1].toString()):"-" %></div>
					<%}}else{ %>
					<div align="center">-</div>
					<%} %>
					</td>
						</tr>
						<%}} %> 
					<tbody>
					
					</tbody>
					</table>
					</div>
					
					
					</div>
					
					
					</div>
					</div>
					</div>
					</div>
					
					
		<script type="text/javascript">
		
		$('#forwardbtn').click();
		
		function showDiv(a,b){
			
			$('#'+a).show();
			$('#'+b).hide();
			
			$('#'+a+'btn').css('background-color','green');
			$('#'+a+'btn').css('color','white');
			$('#'+b+'btn').css('background-color','grey');
			$('#'+b+'btn').css('color','black');
		
		}
		</script>
</body>
</html>