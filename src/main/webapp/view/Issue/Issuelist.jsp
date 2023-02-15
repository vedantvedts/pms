<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <jsp:include page="../static/header.jsp"></jsp:include>
	<title>Issue</title>
 <style type="text/css">
 
 p{
  text-align: justify;
  text-justify: inter-word;
}

  label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 
  
 th
 {
 	
 	text-align: center;
 	
 }
 

.table .font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
}

.table button {
    background-color: Transparent !important;
    background-repeat:no-repeat;
    border: none;
    cursor:pointer;
    overflow: hidden;
    outline:none;
    text-align: left !important;
}
.table td{
	padding:5px ;
}
 
  
 .textcenter{
 	
 	text-align: center;
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 108px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 28px;
	height: 52px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 6px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 14px;
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}
</style>


<meta charset="ISO-8859-1">

</head>
<body >
<%

 int addcount=0; 
List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectlist");
String projectid=(String)request.getAttribute("projectid");
List<Object[]> issuedatalist=(List<Object[]>)request.getAttribute("issuedatalist");
String action = (String)request.getAttribute("action");
%>



<%String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	<div align="center">
	
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</div>
	<%} %>

<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="col-md-12">
						<div class="row card-header" style="margin-left: -13px;width: 102%;">
				   			<div class="col-md-6">
								<h3>Issue List</h3>
							</div>
							<!-- <div class="col-md-2"></div>		 -->				
							<div class="col-md-6 justify-content-end" >
								<%-- <table style="float: right;" >
									<tr>
										<td ><h5>Project :</h5></td>
										<td >
											<form method="post" action="ActionIssue.htm" id="projectchange">
												<select class="form-control items" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="submitForm('projectchange');">
													<option disabled  selected value="">Choose...</option>
													<option <%if(projectid!=null && projectid.equals("0")) { %>selected <%} %>value="0" >General</option>
													<%for(Object[] obj : projectslist){ %>
													<option <%if(projectid!=null && projectid.equals(obj[0].toString())) { %>selected <%} %>value="<%=obj[0]%>" ><%=obj[4] %></option>
													<%} %>
												</select>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										</td>
									</tr>
								</table> --%>
								<table style="float: right;" >
									<tr>
										<td>
											<form method="post" action="ActionIssue.htm" id="projectchange">
												<select class="form-control items" name="Action"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="submitForm('projectchange');">
													<option disabled  selected value="">Choose...</option>
													<option value="All" <%if(action!=null && "All".equalsIgnoreCase(action)){%> selected<%}%>>All</option>
													<option value="TA" <%if(action!=null && "TA".equalsIgnoreCase(action)){%> selected<%}%>>Assigned To</option>
													<option value="FA" <%if(action!=null && "FA".equalsIgnoreCase(action)){%> selected<%}%>>Assigned From</option>
													<option value="F" <%if(action!=null && "F".equalsIgnoreCase(action)){%> selected <%}%>>Forwarded</option>
												</select>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										</td>
									</tr>
								</table>							
							</div>
						 </div>
					 </div>
				
					<div class="card-body">	
					
						<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" >
							<thead>
								<tr>
									<th style="width: 5%;" data-field="0" tabindex="0" >SN</th>
									<th style="width: 40%;"> Issue Description </th>
									<th style="width: 20%;"> Status </th>
									<th style="width: 15%;"> Progress </th>
									<th style="width: 20%;"> Action </th>
								</tr>
							</thead>
							<tbody>
					<% 
					if(issuedatalist.size()>0){ 
					for(int i=0;i<issuedatalist.size();i++){	
					%>
							<tr>
								<td class="center"><%=i+1 %></td>
								<td class="center"><%=issuedatalist.get(i)[1] %></td>
								<td class="center">
									<%if(issuedatalist.get(i)[3].toString().equals("I")){ %>
										In Progress
									<%}else if(issuedatalist.get(i)[3].toString().equals("A")){  %>
										Assigned
									<%}else if(issuedatalist.get(i)[3].toString().equals("C")){  %>
										Closed
										<%} %>
								</td>
								<td><%if(issuedatalist!=null && issuedatalist.size()>0 && issuedatalist.get(i)[8]!=null){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=issuedatalist.get(i)[8]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=issuedatalist.get(i)[8]%>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Yet Started .
															</div>
															</div> <%} %></td>
								<td class="center">
								<%if(action!=null && !"F".equalsIgnoreCase(action)){%>
									<form action="IssueUpdate.htm" method="post">
										<button class="editable-click" name="sub" value="Details" 	>
													<div class="cc-rockmenu">
																<div class="rolling">
																		<figure class="rolling_icon">
																			<img src="view/images/preview3.png">
																		</figure>
																	<span>Details</span>
																</div>
													</div>
										</button>
										<input type="hidden" name="ActionMainId" value="<%=issuedatalist.get(i)[0]%>">
										<input type="hidden" name="ActionAssignid" value="<%=issuedatalist.get(i)[6]%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>
									
								<%}else{%>
									<form name="myForm1" id="myForm1" action="ForwardSub.htm" method="POST" 
																	style="display: inline">

																	<button class="editable-click" name="sub" value="Details" 	>
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Details</span>
																			</div>
																		</div>
																	</button>
																	<input type="hidden" name="ActionMainId" value="<%=issuedatalist.get(i)[0]%>"/>
																	<input type="hidden" name="ActionAssignId" value="<%=issuedatalist.get(i)[6]%>"/> 
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form> 
								<%}%>					
								</td>	
							</tr>														
						<%}
					}%>
						</tbody>
					</table>
											
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">

function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
</script>


<script type="text/javascript">

$('.items').select2();


$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
  

</script>


</body>
</html>