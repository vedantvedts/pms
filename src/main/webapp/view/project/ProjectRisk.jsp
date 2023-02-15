<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Risk </title>


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

</style>


<meta charset="ISO-8859-1">

</head>
<body >
<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); int addcount=0; 
NFormatConvertion nfc=new NFormatConvertion();

List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectlist");
String projectid=(String)request.getAttribute("projectid");
List<Object[]> riskdatalist=(List<Object[]>)request.getAttribute("riskdatalist");
List<String> riskdatapresentlist=(List<String>)request.getAttribute("riskdatapresentlist");

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
								<h3>Project Risk List</h3>
							</div>
										
							<div class="col-md-6 justify-content-end" >
								<table style="float: right;" >
									<tr>
										<td ><h4>Project :</h4></td>
										<td >
											<form method="post" action="ProjectRisk.htm" id="projectchange">
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
								</table>							
							</div>
						 </div>
					 </div>
				
					<div class="card-body">	
					
						<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" >
							<thead>
								<tr>
									<th style="width: 10%;" data-field="0" tabindex="0" >SN</th>
									<th style="width: 50%;">Risk Description</th>
									<th style="width: 20%;">Progress</th>
									<th style="width: 20%;">View Or Add</th>
								</tr>
							</thead>
							<tbody>
					<% 
					if(riskdatalist.size()>0){ 
					for(int i=0;i<riskdatalist.size();i++){	
					%>
							<tr>
								<td class="center"><%=i+1 %></td>
								<td class="center"><%=riskdatalist.get(i)[1] %></td>
								<td class="center">
									<%if(riskdatalist.get(i)[3].toString().equals("I")){ %>
										In Progress
									<%}else if(riskdatalist.get(i)[3].toString().equals("A")){  %>
										Assigned
									<%}else if(riskdatalist.get(i)[3].toString().equals("C")){  %>
										Closed
										<%} %>
								</td>
								<td class="center">
									<form action="ProjectRiskData.htm" method="post">
										<%if(riskdatapresentlist.contains(riskdatalist.get(i)[0])){%>
											<button type="submit" class="btn"><i class="fa fa-eye fa-lg" aria-hidden="true"></i></button>											
										<%}else{%>
											<button type="submit" class="btn"><i class="fa fa-plus-square fa-lg" aria-hidden="true"></i></button>
										<%}%>
										<input type="hidden" name="actionmainid" value="<%=riskdatalist.get(i)[0]%>">
										<input type="hidden" name="actionassignid" value="<%=riskdatalist.get(i)[6]%>">
										<input type="hidden" name="projectid" value="<%=projectid%>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</form>
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