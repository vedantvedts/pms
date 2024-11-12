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
List<Object[]>ProjectParaDetails=(List<Object[]>)request.getAttribute("ProjectParaDetails");
List<Object[]>RequirementList=(List<Object[]>)request.getAttribute("RequirementList");
List<Object[]>subList=new ArrayList<>();
if(RequirementList!=null && ProjectParaDetails!=null && !ProjectParaDetails.isEmpty()&&!RequirementList.isEmpty()) {   
subList= RequirementList.stream().filter(e->e[15]!=null&&!e[15].toString().equalsIgnoreCase("0"))
			.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
			.collect(Collectors.toList());}

String projectType = (String)request.getAttribute("projectType");
String projectId =(String)request.getAttribute("projectId");
String initiationId =(String)request.getAttribute("initiationId");
String productTreeMainId =(String)request.getAttribute("productTreeMainId");
%>

	<div class="container-fluid">
		
		<div class="row">
			<div class="col-md-12">
			<div class="card shadow-nohover" style="margin-top: -0.6pc">
			<div class="row card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
					<div class="col-md-6">Project Development System</div>
						<div class="col-md-4"></div>
					<div class="col-md-2">
					<form action="Requirements.htm" method="post">
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
						<th>QR Para </th>
						<th>Requirement Id </th>
						
						
						
						</tr>
					</thead>
						<tbody>
					<%if(ProjectParaDetails!=null && ProjectParaDetails.size()>0) {
					int paraCount=0;
					int idCount=0;
					%>
						<%for(Object []obj:ProjectParaDetails) {
							List<Object[]>ReqId = new ArrayList<>();
							
							if(subList.size()>0){
								ReqId=subList.stream().filter(e->e[12]!=null && Arrays.asList(e[12].toString().split(", ")).contains(obj[0].toString())).collect(Collectors.toList());
							}
						
						%>
						<tr>
						<td  style="text-align: center;"><%=++paraCount %>.</td>
						<td onmouseover="showContent('<%=obj[0].toString()%>')" onmouseout="hideContent('<%=obj[0].toString()%>')"><span class="viewbtn" ><%=obj[3].toString() %></span>
						 <div class="popup-content" id="popupContent<%=obj[0].toString()%>">
         					<%=obj[4]!=null?obj[4].toString():"No Details Added" %>
       					 </div>
						
						</td>
						<td >
						<%if(ReqId.size()>0) {
							++idCount;
						for(Object[]obj1:ReqId){
						%>
						<div class="RDiv" id ='<%=idCount+"R"+obj1[0].toString()%>' style="" onclick="showReqDiv('<%=idCount+"R"+obj1[0].toString()%>')"><%=obj1[1] %></div>
						 <div class="popup-content" id="popReqContent<%=idCount+"R"+obj1[0].toString()%>" onclick="hideContent()">
         					<%=obj1[4]!=null?obj1[4].toString():"No Details Added" %>
       					 </div>
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
					
					<div class="card-body" id="backward">
					
					
					<table class="table table-bordered">
			<thead>
						<tr>
						<th style="width:5%;text-align: center;">SN </th>
						<th>Requirement Id </th>
						<th>QR Para </th>
						</tr>
					</thead>
					<tbody>
					<%int snCount=0;	
					for(Object[]objs:subList) {
					%>
					<%if(objs[12]!=null) {%>
					<tr>
					<td  style="text-align: center;" ><%=++snCount %>.</td>
					<td  ><%=objs[1].toString() %></td>
					 <td  >
					
					
								<%if(objs[12]!=null) {
									String [] a=objs[12].toString().split(", ");
									List<String>paras= new ArrayList<>();
									for(String s:a){
										
									for(Object[]obj:ProjectParaDetails){
										if(obj[0].toString().equalsIgnoreCase(s)){
											paras.add(obj[3].toString());
										}
									}
									}
								%>
								<% for(String s:paras){
								%>
							<div style="border: 1px solid #dee2e6"><%=s %></div>
								<%} %>
								<%--  <%=ProjectParaDetails.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[3].toString()).collect(Collectors.joining(",")) %> <br> --%>
								<%}else{ %>
								-
								<%} %>
					</td> 
					</tr>
					<%} %>
					<%} %>					
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
		
			function showContent(a){
				console.log(a)
				$('.popup-content').hide();
				$('#popupContent'+a).show();
				$('.RDiv').css('background-color','white');
				$('.RDiv').css('color','black');
			}
			function hideContent(a) {
				  $('#popupContent' + a).hide();
					$('.popup-content').hide();
					$('.RDiv').css('background-color','white');
					$('.RDiv').css('color','black');
				}
			
			
			function showReqDiv(a){
				$('.RDiv').css('background-color','white');
				$('.RDiv').css('color','black');
				$('#'+a).css('background-color','green');
				$('#'+a).css('color','white');
				 const element = $('#popReqContent' + a);
				    
				    // Check if the modal is currently visible
				    if (element.is(':visible')) {
				        element.hide();  // Hide it if it's visible
				    } else {
				        $('.popup-content').hide();  // Hide all popups
				        element.show();  // Show the selected modal
				    }
			}
			</script>
</body>
</html>