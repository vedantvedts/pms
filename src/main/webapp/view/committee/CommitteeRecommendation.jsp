<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.master.model.IndustryPartner"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
	<%@page import="com.vts.pfms.FormatConverter"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../static/header.jsp"></jsp:include>
		<style type="text/css">
		.input-group-text {
			font-weight: bold;
		}

		label {
			font-weight: 800;
			font-size: 16px;
			color: #07689f;
		}

		hr {
			margin-top: -2px;
			margin-bottom: 12px;
		}

		.card b {
			font-size: 20px;
		}
		
		.tdclass {
			padding-top:7px;
			padding-bottom: 7px;
		}
		
		/* tr_clone .select2{
			width:600px !important;
		}
		
		tr_clone1 .select2{
			width:350px !important;
		}
		tr_clone2 select .select2{
			width:350px !important;
		} */
		sp::before {
		  content: "\2022";
		  color: red;
		  font-weight: bold;
		  display: inline-block; 
		  width: 1em;
		  margin-left: 1em;
		}		
	</style>
</head>
<body>
<%
Object[]CommitteMainEnoteList = (Object[])request.getAttribute("CommitteMainEnoteList");
Object[]NewApprovalList = (Object[])request.getAttribute("NewApprovalList");
FormatConverter fc = new FormatConverter();
SimpleDateFormat sdf = fc.getRegularDateFormat();
SimpleDateFormat sdf1 = fc.getSqlDateFormat();
SimpleDateFormat inputFormat = new SimpleDateFormat("ddMMMyyyy");
SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
List<Object[]>employeelist = (List<Object[]>)request.getAttribute("employeelist");

%>

<div class="container-fluid" style=";">
	<div class="row">
		<div class="col-md-12">	
		   
			<div class="card shadow-nohover">	
						
					<div class="card-header">
				
					</div>
						<div class="card-body">	
						<div class="row">
						<div class="col-md-2"></div>
						
						
					<div class="col-md-8">
					<form action="EnoteForward.htm" method="post">
					<table class="table table-bordered" >
					<tbody>
					<tr>
					<td class="text-primary" style="width:22%"> Reference No. &nbsp;:</td>
					<td><%=CommitteMainEnoteList[1].toString() %></td>
					<td class="text-primary" style="width:15%"> Reference Date.&nbsp; :</td>
					<td ><%=sdf.format(sdf1.parse(CommitteMainEnoteList[2].toString()))%></td>
					</tr>
					
					<tr>
					<td class="text-primary"> Subject -</td>
					<td style="width:40%"> <%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[3]!=null){%><%=CommitteMainEnoteList[3].toString() %><%} %></td>
					
					<td class="text-primary"> Comment -</td>
					<td style="width:40%"> <%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[4]!=null){%><%=CommitteMainEnoteList[4].toString() %><%} %></td>
					</tr>
					
					<tr>
					<td class="text-primary"> Initiated By -</td>
					<td colspan="3"> <%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[18]!=null){%><%=CommitteMainEnoteList[18].toString() %>, <%=CommitteMainEnoteList[19].toString()%><%} %></td>
					</tr>
					
					<tr>
					<td class="text-primary">Recommended Officer 1: -</td>
					<td colspan="3"> 
					<%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[7]!=null){
					for(Object[] obj:employeelist){
					if(obj[0].toString().equalsIgnoreCase(CommitteMainEnoteList[7].toString())){
					%>
					<%=obj[1].toString() %>, <%=CommitteMainEnoteList[8].toString() %> 
					<%}}} %>
					</td>
					</tr>
					
					<%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[9]!=null){%>
					<tr>
					<td class="text-primary">Recommended Officer 2: -</td>
					<td colspan="3"> 
				
					<%for(Object[] obj:employeelist){
					if(obj[0].toString().equalsIgnoreCase(CommitteMainEnoteList[9].toString())){
					%>
					<%=obj[1].toString() %>, <%=CommitteMainEnoteList[10].toString() %> 
					<%}} %>
					</td>
					</tr>
					<%} %>
					
					
					<%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[11]!=null){%>
					<tr>
					<td class="text-primary">Recommended Officer 3: -</td>
					<td colspan="3"> 
				
					<%for(Object[] obj:employeelist){
					if(obj[0].toString().equalsIgnoreCase(CommitteMainEnoteList[11].toString())){
					%>
					<%=obj[1].toString() %>, <%=CommitteMainEnoteList[12].toString() %> 
					<%}} %>
					</td>
					</tr>
					<%} %>
					
						<%if(CommitteMainEnoteList!=null && CommitteMainEnoteList[13]!=null){%>
					<tr>
					<td class="text-primary">Approving Officer : -</td>
					<td colspan="3"> 
				
					<%for(Object[] obj:employeelist){
					if(obj[0].toString().equalsIgnoreCase(CommitteMainEnoteList[13].toString())){
					%>
					<%=obj[1].toString() %>, <%=CommitteMainEnoteList[14].toString() %> 
					<%}} %>
					</td>
					</tr>
					<%} %>
					<tr>
					<td colspan="4">
					<span class="text-primary" style="margin-bottom: 4px !important">Remarks :</span>
					
					<textarea class="form-control" rows="2" cols="40" name="Remarks" id="Remarks"></textarea>
					<div align="center" class="mt-2">
					
					<input type="hidden" name="flow" value="" id="flow">
					<input id="submit" type="submit" hidden="hidden">     
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />     
					<button type="button" class="btn btn-sm submit" onclick="return formsubmit('A')"><%if(CommitteMainEnoteList[16].toString().equalsIgnoreCase("APR")){ %>Approve<%}else {%>Recommend <%} %></button>
					<input type="hidden" name="EnoteId" value="<%=CommitteMainEnoteList!=null?CommitteMainEnoteList[0].toString():"0" %>">
					<button type="button" class="btn btn-sm btn-danger" onclick="return formsubmit('R')" style="font-weight: 800;font-family: 'Montserrat', sans-serif;">RETURN</button>
					<a class="btn btn-sm back" type="button" href="CommitteeApprovalList.htm">BACK</a>
					</div>
					</td>
					</tr>
					</tbody>
					</table>
						</form>
					</div>
					</div>
					
					</div>
					</div>
					</div>
					</div>
					</div>
					
						 	<div class="row mt-3"  style="text-align: center; padding-top: 10px;" >
				                <table  align="center" >
				                	<tr>
				                	
				                		<td class="trup" style="background: #B5EAEA;">
				                		&nbsp;<%if(Arrays.asList("FWD","RC1","RC2","RC3","APR").contains(CommitteMainEnoteList[15].toString())) {%>
				                		<img src="view/images/check.png">
				                		<%} %><br>
				                			Constituted By 
				                			<br>
				                			<%=NewApprovalList[0].toString() %>
				                		</td>
				                		<%if(NewApprovalList!=null && NewApprovalList[2]!=null){ %>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td >
				                		
				                		<td class="trup" style="background: #C6B4CE;">
				                			&nbsp;<%if(Arrays.asList("RC1","RC2","RC3","APR").contains(CommitteMainEnoteList[15].toString())) {%>
				                		<img src="view/images/check.png">
				                		<%} %><br>
				                			Recommended Officer 1
				                		
				                			<br>
				                			<%=NewApprovalList[1].toString() %>
				                		</td>
				                		
				                		<%} %>
				                		<%if(NewApprovalList!=null && NewApprovalList[4]!=null){ %>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td>
				                		
				                		<td class="trup" style="background: #E8E46E;">
				                			&nbsp;<%if(Arrays.asList("RC2","RC3","APR").contains(CommitteMainEnoteList[15].toString())) {%>
				                		<img src="view/images/check.png">
				                		<%} %>
				                		<br>
				                		Recommended Officer 2
				                	
				                		<br>
				                			<%=NewApprovalList[3].toString() %>
				                		</td>
				                		<%} %>
				                		<%if(NewApprovalList!=null && NewApprovalList[6]!=null){ %>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td>
				                		
				                		<td class="trup" style="background: #FBC7F7;" >
				                			&nbsp;<%if(Arrays.asList("RC3","APR").contains(CommitteMainEnoteList[15].toString())) {%>
				                		<img src="view/images/check.png">
				                		<%} %>
				                		<br>
				                			Recommended Officer 3
				                		
				                			<br>
				                			<%=NewApprovalList[5].toString() %>
				                		</td>
				                		<%} %>
				                		<%if(NewApprovalList!=null && NewApprovalList[8]!=null){ %>
				                		<td rowspan="2">
				                			 <b>----------&gt;</b>
				                		</td>
				                		
				                		<td class="trup" style="background: #F4A261;" >
				                			Approving Officer
				                			<br>
				                			<%=NewApprovalList[7].toString() %>
				                		</td>
				                		<%} %>
				                			                		
				                	</tr>	
				                	
				                	</table>
				                	</div>
</body>
<script type="text/javascript">

function formsubmit(value) {
	if(value=='R'){
		var remarks= $('#Remarks').val().trim();
		if(remarks.length===0){
			alert("Please give some Remarks");
			return false;
		}
	}
	$('#flow').val(value)
	if(confirm('Are you sure to submit?')){
		$('#submit').click();
	}else{
		event.preventDefault();
	}
}

</script>

</html>