<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Insert title here</title>

<style type="text/css">
 p{
  text-align: justify;
  text-justify: inter-word;
}
.form-check-input:checked ~ .form-check-label::before {
    color: #fff;
    border-color: #7B1FA2;
    background-color: red;
}
.form-check-input:checked ~ .form-check-label::before {
    color: #fff;
    border-color: #7B1FA2;
    background-color: red;
}
 th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
	overflow-wrap: break-word;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 	overflow-wrap: break-word;
 }
 
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
 
 .containers {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

summary[role=button] {
  background-color: white;
  color: black;
  border: 1px solid black ;
  border-radius:5px;
  padding: 0.5rem;
  cursor: pointer;
  
}
summary[role=button]:hover
 {
color: white;
border-radius:15px;
background-color: #4a47a3;

}
 summary[role=button]:focus
{
color: white;
border-radius:5px;
background-color: #4a47a3;
border: 0px ;

}
summary::marker{
	
}
details { 
  margin-bottom: 5px;  
}
details  .content {
background-color:white;
padding: 0 1rem ;
align: center;
border: 1px solid black;
}

}

.anchorlink{
	cursor: pointer;
	color: #C84B31;
}
.anchorlink:hover {
    text-decoration: underline;
}

</style>


<!-- --------------  tree   ------------------- -->
<style>
ul, #myUL {
  list-style-type: none;
}

#myUL {
  margin: 0;
  padding: 0;
}

.caret {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret::before {
  content: "  \25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down::before {
  content: "\25B6  ";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.caret-last {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last::before {
  content: "\25B7";
  color: black;
  display: inline-block;
  margin-right: 6px;
}


.nested {
  display: none;
}

.active {
  display: block;
}
</style>

<!------------------- tree -------------------->
<!----------------- model  tree   ---------------------->
<style>

.caret-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}

.caret-last-1 {
  cursor: pointer;
  -webkit-user-select: none; /* Safari 3.1+ */
  -moz-user-select: none; /* Firefox 2+ */
  -ms-user-select: none; /* IE 10+ */
  user-select: none;
}


.caret-last-1::before {
  content: "\25B7" ;
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-1::before {
  content: "\25B7" ;
  color: black;
  display: inline-block;
  margin-right: 6px;
}

.caret-down-1::before {
  content: "\25B6";
  -ms-transform: rotate(90deg); /* IE 9 */
  -webkit-transform: rotate(90deg); /* Safari */'
  transform: rotate(90deg);  
}

.nested-1 {
  display: none;
}

.active-1 {
  display: block;
}

 .completed{
	color: green;
	font-weight: 700;
}

.briefactive{
	color: blue;
	font-weight: 700;
}

.inprogress{
	color: #F66B0E;
	font-weight: 700;
}

.assigned{
	color: brown;
	font-weight: 700;
}

.notyet{
	color: purple;
	font-weight: 700;
}
.notassign{
	color:#AB0072;
	font-weight: 700;
}
.ongoing{
	color: #F66B0E;
	font-weight: 700;
}

.completed{
	color: green;
	font-weight: 700;
}

.delay{
	color: maroon;
	font-weight: 700;
}

.completeddelay{
	color:#BABD42;
	font-weight: 700;
}

.inactive{
	color: red;
	font-weight: 700;
}

.delaydays
{
	color:#000000;
	font-weight: 700;
}

.select2-container{
	float:right !important;
	margin-top: 5px;
	
}

.modal-xl{
	max-width: 1400px;
}

.sub-title{
	font-size : 20px !important;
	color: #145374 !important
}

.subtables{
	width: 1100px !important;
}

.date-column{
	max-width:60px !important;
}
 
.status-column{
	max-width:10px !important;
} 

.resp-column{
	max-width:80px !important;
} 
 
.currency{
	color:#367E18 !important;
	font-style: italic;
} 


.subtables th{
	/* background-color: #001253 !important; 
	color: white !important;
	border-color: white; */
	color: #001253 !important;
	
}
 

 
 
.projectattributetable th{
	text-align: left !important;
} 
 
.select2-container {
	width: 100% !important;
}

</style>

</head>
<body>

<%
DecimalFormat df=new DecimalFormat("####################.##");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); 

List<Object[]> proList=(List<Object[]>)request.getAttribute("proList");

Object[] ProjectEditData=(Object[])request.getAttribute("ProjectEditData");
Object[] ProjectEditData1=(Object[])request.getAttribute("ProjectEditData1");
List<Object[]> ProjectAssignList=(List<Object[]>)request.getAttribute("ProjectAssignList");
List<Object[]> ProjectDetail=(List<Object[]>)request.getAttribute("ProjectDetails"); 
List<Object[]> riskdatalist=(List<Object[]>)request.getAttribute("riskdatalist");
List<String> projectidlist = (List<String>)request.getAttribute("projectidlist");
int ProjectAssignListsize=ProjectAssignList.size();
String Project=(String)request.getAttribute("ProjectId");
List<Object[]> MilestoneActivityList=(List<Object[]>)request.getAttribute("MilestoneActivityList");

%>

<div class="container-fluid">
		<div class="row" id="main">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="row card-header" style="">
			   			<div class="col-md-6"  style="margin-top: -8px;">
							<h3>Project Charter</h3>
						</div>	  
						<div class="col-md-6" style="float: right;">
							<form method="get" action="ProjectCharter.htm" id="projectchange" >
								<div class="row">
									<div class="col-md-4 right">
                            			<label class="control-label"style="font-size: 17px"><b>Project Name :</b></label>
                            		</div>
								 
									<div class="col-md-4" style="margin-top: -10px;">
											
										<select class="form-control items selectdee" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="this.form.submit();">
											<option disabled="true"  selected value="">Choose...</option>
											<%for(Object[] obj : proList){ 
												String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":""; %>
												<option  value="<%=obj[0] %>" <%if (Project.equalsIgnoreCase(obj[0].toString())) {%>
												selected="selected" <%}%>><%=obj[4] +projectshortName%></option>
											<%} %>
										</select>
									</div>
									
									<div class="col-md-2 left">
										<button  type="submit" class="btn btn-sm " style="border: 0 ;border-radius: 3px;color: red;margin-left: 170px;margin-top: -15px;size: 25px" formmethod="GET" formaction="ProjectCharterDownload.htm" formtarget="_blank">
											<i class="fa fa-lg fa-file-pdf-o" aria-hidden="true"></i>
										</button>
									</div>	
									<div class="col-md-2"></div>
								</div>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>				
						</div>
				
						<div class="card-body" style="background-color: white;">	
						
				 		
							 <details>					
							    <summary role="button" tabindex="0"><b>1. General Project Information </b>  </summary>
							
								<div class="content">
												
												<table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
											
										<tr>
											 <td style="width: 5px !important; padding: 5px; padding-left: 10px">(a)</td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Project Name</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[1] %></td>
											
										</tr>
										
										<tr>
											 <td  style=" padding: 5px; padding-left: 10px">(b)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Category</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[14] %></td>
										</tr>
										<tr>
											 <td  style="padding: 5px; padding-left: 10px">(c)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Date of Sanction</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=sdf.format(sdf1.parse(ProjectEditData[3].toString()))%></td>
										</tr>
										<tr>
											 <td  style="width: 20px; padding: 5px; padding-left: 10px">(d)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>User</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"> <%if(ProjectEditData[16]!=null ){%> <%=ProjectEditData[16] %> <%} %></td>
										</tr>
										
									
										
									</table>
								
		
							</div>
						</details>
						
						
						 <details>					
							    <summary role="button" tabindex="0"><b>2.Project Team </b>  </summary>
								<div class="content">
								
								
									
					      <table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
					            <tr>
									<td style="width: 85px !important; padding: 5px; padding-left: 10px">Role</td>
									<td style="width: 120px;padding: 5px; padding-left: 10px"><b>Member</b></td>
									<td style="width:90px;padding: 5px; padding-left: 10px"><b> Lab</b></td>
									<td style="width: 100px;padding: 5px; padding-left: 10px"><b> Telephone</b></td>
									<td style="width: 90px;padding: 5px; padding-left: 10px"><b> Email</b></td>
								</tr>
										
										
										<%-- <tr>
										<td   style="width: 125px !important; padding: 5px; padding-left: 10px">	Project Director</td>
										 <td style="width: 150px;padding: 5px; padding-left: 10px"><b><%=ProjectEditData1[28] %>, <%=ProjectEditData1[29] %></b></td>
											  <td style="width: 90px;padding: 5px; padding-left: 10px"><b> <%=ProjectEditData1[29] %></b></td>
											   <td style="width: 100px;padding: 5px; padding-left: 10px"><b> <%=ProjectEditData1[30] %></b></td>
											    <td style="width: 90px;padding: 5px; padding-left: 10px"><b><%=ProjectEditData1[31] %> </b></td>
										</tr> --%>
										
										<%-- <tr>
									 <td  rowspan="<%=ProjectAssignListsize+1 %>" style="width: 85px !important; padding: 5px; padding-left: 10px">Team Members</td>
										</tr> --%>
										<% for(Object[]o:ProjectAssignList){%>
											<tr>
												<td style="width: 85px !important; padding: 5px; padding-left: 10px"><%=o[12]!=null?o[12]:"-" %></td>
												<td style="width: 180px;padding: 5px; padding-left: 10px"><b><%=o[3] %>, <%=o[4] %></b></td>
												<td style="width: 30px;padding: 5px; padding-left: 10px"><b><%=o[9]!=null?o[9]:"-" %></b></td>
												<td style="width: 100px;padding: 5px; padding-left: 10px"><b><%=o[6] %> </b></td>
												<td style="width: 90px;padding: 5px; padding-left: 10px"><b><%=o[7] %> </b></td>
											</tr>
										<%} %>
									
									</table>
		
							</div>
						</details>
						
						
					<!-- StakeHolders -->
					<details>
   						<summary role="button" tabindex="0"><b>3. StakeHolders</b>     </summary>
   						
						  <div class="content">
						  <h6>No data avaiable</h6>
						  </div>
						</details>
						
						<details>
   						<summary role="button" tabindex="0"><b>4. Project Scope Statement</b>     </summary>
   						
						  <div class="content" >
						  
						    <table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
					               <tr>
											 <td style="width: 5px !important; padding: 5px; padding-left: 10px">(a)</td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Project Scope</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[17] %></td>
											
										</tr>
										
										<tr>
											 <td  style=" padding: 5px; padding-left: 10px">(b)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Objectives</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[4] %></td>
										</tr>
										
											<tr>
											 <td  style=" padding: 5px; padding-left: 10px">(c)</td>
											 <td  style="width: 150px;padding: 5px; padding-left: 10px"><b>Deliverables</b></td>
											 <td colspan="4" style=" width: 370px; padding: 5px; padding-left: 10px;color: black;"><%=ProjectEditData[5] %></td>
										</tr>
						
		                      </table>
		                         <h5 style="margin-left: 18px"> Project Major MileStones</h5>
		                       <table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
										<tr>
											 <td style="width: 60px !important; padding: 5px; padding-left: 10px">Mil-No</td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Milestone Activity</b></td>
									
										</tr>
										<%if(MilestoneActivityList.size()>0){ %>
										<%for(Object[]o:MilestoneActivityList){ 
									
										%>
										<tr>
											 <td style="width: 60px !important; padding: 5px; padding-left: 10px">Mil-<%=o[5]%></td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b><%=o[4] %></b></td>
										
										</tr>
									
										<%}}else{ %>
										<td colspan="2"style="text-align: center;">No data found</td>
										<%} %>
										
										</table>
		                      
		                      <h5>Major Known Risk</h5>
		         
                   
                     
						
					
						    <table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
										<tr>
											 <td style="width: 5px !important; padding: 5px; padding-left: 10px">Risk</td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Risk Rating</b></td>
									
										</tr>
										<%if(riskdatalist.size()>0){ %>
									<%for(Object[]o:riskdatalist){ %>
										<tr>
											 <td style="width: 5px !important; padding: 5px; padding-left: 10px"><%=o[1] %></td>
											 <td style="width: 150px;padding: 5px; padding-left: 10px"><b>Risk</b></td>
										</tr>
									<%}}else{ %>
									<td colspan="2" style="text-align: center;">No data found</td>
									<%} %>
									</div>
									</table>
						   <h6>Issues</h6>
						  <table class="subtables projectattributetable" style="align: left; margin-top: 10px; margin-bottom: 10px; margin-left: 25px;   border-collapse:collapse;" >
										<tr>
											
											 <td style=" width: 5px !important; padding: 5px; padding-left: 10px;text-align:center;"><b>Issues</b></td>
									
										</tr>
										
										<tr>
											 
											 <td style="width: 5px !important;  5px; padding-left: 10px;text-align:center;"><b>No data Available</b></td>
									
										</tr>
										</table>
						   	</div>
						
						</details>
						
						<details>
   						<summary role="button" tabindex="0"><b>5. Communication Strategy (specify how the project manager will communicate to the Executive Sponsor, Project Team members and Stakeholders, e.g., frequency of status reports, frequency of Project Team meetings, etc.</b></summary>
   						
						  <div class="content" >
						  No data is available
						</div>
						</details>
						
						<details>
   						<summary role="button" tabindex="0"><b>	6.Sign-off</b>     </summary>
   						
						  <div class="content" >
						   No data is available
						  </div>
						  </details>
						  
						  <details>
   						<summary role="button" tabindex="0"><b>	7.Notes</b>     </summary>
   						
						  <div class="content" >
						   No data is available
						  </div>
						  </details>	
					
					</div>
					</div>
					</div>
					</div>
					</div>
					  
						
						  
						<script>
// JavaScript to open all details elements by default
document.addEventListener("DOMContentLoaded", function() {
  var detailsElements = document.querySelectorAll("details");
  detailsElements.forEach(function(details) {
    details.open = true;
  });
});
</script>
	
			
</body>
</html>