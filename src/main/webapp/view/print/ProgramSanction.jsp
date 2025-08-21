<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List , java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
@media print {

    #printbtn {
        display :  none;
    }
}



</style>

</head>
<body>
<body>
<%
List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");
Object[] projectdata = (Object[])request.getAttribute("projectdata");
List<Object[]> itemlist = (List<Object[]>)request.getAttribute("itemlist");
String projectid = (String)request.getAttribute("projectid");
List<Object[]> authoritylist = (List<Object[]>)request.getAttribute("authoritylist");
List<Object[]> initiationcopy = (List<Object[]>)request.getAttribute("initiationcopy");
List<Object[]> initiationdept = (List<Object[]>)request.getAttribute("initiationdept");
Object[] initiationSanctionlist = (Object[])request.getAttribute("initiationSanctionlist");
List<Object[]> copyaddresslist = (List<Object[]>)request.getAttribute("copyaddresslist");
String editdata=(String)request.getAttribute("editdata");
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
%>
<div class="container-fluid" id ="printbtn">
		<div class="row">
			<div class="col-md-12">
						<div class="row card-header">
						<div class="col-md-6 " >
								<table style="float: left; " >
									<tr>
										<td style="border: none;"><h4>Project :</h4></td>
										<td style="border: none;">
											<form method="post" action="ProjectSanctionPreview.htm"  autocomplete="on" >
												<select class="form-control selectdee"  data-container="body" data-live-search="true"  name="projectinitiationid"  required="required" style="width:200px;"  onchange="this.form.submit()">
													<option disabled  selected value="">Choose...</option>
													<%if(projectslist!=null){ for(Object[] obj : projectslist){ %>
													<option value="<%=obj[0]%>" <%if(projectid!=null && projectid.equalsIgnoreCase(obj[0].toString())){%> selected="selected" <%}%>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></option>
													<%}} %> 
												</select>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										</td>
									</tr>
								</table>							
				            </div>
				   		    <div class="col-md-6 justify-content-end" >
								<a class="btn btn-info btn-sm shadow-nohover back" href="ProjectDocs.htm" style="float: right; " > Back</a>
							</div>
			            </div>
		         </div>
	     </div>
</div>

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
    
    
    
<%if(projectdata!=null){%>
<br>
    
<form action="ProjectSanctionPreview.htm" method="POST" autocomplete="on" id="form1">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" name="initiationid" value="<%=projectid%>" />
<div>
<h4 align="center">SHEET_FF06</h4>

<div >

<%if(initiationSanctionlist!=null && editdata==null){ %>
<div align="right" style="padding-right: 35px;">
		<p align="right" > No.<%if(initiationSanctionlist[1]!=null){%> <%=StringEscapeUtils.escapeHtml4(initiationSanctionlist[1].toString())%> <%} %>/D(R&D)</p>
<div style="width: 30%;margin-top: -40px; ">
		<br><%if(initiationSanctionlist[7]!=null){%> <%=StringEscapeUtils.escapeHtml4(initiationSanctionlist[7].toString())%> <%}%> 
		<br><%if(initiationSanctionlist[8]!=null){%> <%=StringEscapeUtils.escapeHtml4(initiationSanctionlist[8].toString())%> <%} %>- <%if(initiationSanctionlist[10]!=null){%><%=StringEscapeUtils.escapeHtml4(initiationSanctionlist[10].toString())%><%}%>
		<br>Date :<%if(initiationSanctionlist[16]!=null){%> <%=sdf.format(initiationSanctionlist[16])%> <%}%>
</div>
</div>
<%}else{%>
<div align="right" style="padding-right: 35px;">
<p > No.<input type="text" name="RddNo" id="No" <%if(initiationSanctionlist!=null && initiationSanctionlist[1]!=null){%>value=<%=initiationSanctionlist[1]%> <%}%> required="required">/D(R&D)</p>
<div style="width: 30%;margin-top: -12px; ">
                          <select name="FromDepartment"  id="FromDepartment" class="form-control  form-control selectdee" data-width="100%" data-live-search="true">
							  <option disabled="disabled" selected="selected" value="">Choose From Department...</option>
							  <%for(Object[] obj:initiationdept){ %>
							  	<option value="<%=obj[0]%>" <%if(initiationSanctionlist!=null && initiationSanctionlist[17]!=null && obj[0].equals(initiationSanctionlist[17])){%> selected="selected" <%}%>> <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%> (<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>)</option>
							  <%}%>
							  </select>
</div> 
<input style="width: 9%; margin-top: 6px;" id="fromdate"  data-date-format="dd/mm/yyyy" readonly name="fromDate" class="form-control form-control">
</div>
<%}%>

<p style="padding-left: 35px;">To,<br></p>
<%if(initiationSanctionlist!=null  && editdata==null){ %>
<div style="width: 30%; padding-left: 50px;">
<%=initiationSanctionlist[2]!=null?StringEscapeUtils.escapeHtml4(initiationSanctionlist[2].toString()): " - " %><br>
<%=initiationSanctionlist[3]!=null?StringEscapeUtils.escapeHtml4(initiationSanctionlist[3].toString()): " - "%><br>
<%=initiationSanctionlist[4]!=null?StringEscapeUtils.escapeHtml4(initiationSanctionlist[4].toString()): " - "%>-<%=initiationSanctionlist[6]!=null?StringEscapeUtils.escapeHtml4(initiationSanctionlist[6].toString()): " - "%>
</div>
<%}else{ %>

    <div style="width: 30%; padding-left: 50px;"><select name="Authority" id="Authority"	class="form-control  form-control selectdee" data-width="100%" data-live-search="true">
							  <option disabled="disabled" selected="selected" value="">Choose Authority...</option>
							  <%for(Object[] obj:authoritylist){ %>
							  	<option value="<%=obj[0]%>" <%if(initiationSanctionlist!=null && initiationSanctionlist[19]!=null && obj[0].equals(initiationSanctionlist[19])){%> selected="selected" <%}%>> <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></option>
							  <%}%>
							  </select></div> 
<div style="width: 30%; padding-left: 50px;">
                          <select name="ToDepartment" id="ToDepartment" class="form-control  form-control selectdee" data-width="100%" data-live-search="true">
							  <option disabled="disabled" selected="selected" value="">Choose To Department...</option>
							  <%for(Object[] obj:initiationdept){ %>
							  	<option value="<%=obj[0]%>" <%if(initiationSanctionlist!=null && initiationSanctionlist[18]!=null && obj[0].equals(initiationSanctionlist[18])){%> selected="selected" <%}%>> <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%> (<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>)</option>
							  <%}%>
							  </select>
</div> 
<%}%>

<p align="center"> (For projects, where CFA is Lab Director / Cluster DG, addressee will be Lab Director / cluster DG and corresponding entries will be change accordingly).</p>

<p align="center">I am directed to convey the sanction of the President of India for undertaking the Project as per following details.</p>

<div align="center" style="padding-left: 35px; page-break-after: always;" >

<table  style="width: 90%;">
	<tr>
		<td style="width: 5%;">1.</td>
		<td style="width: 30%;">Title of the project</td>
		<td style="width: 60%;">:<b><%if(projectdata[0]!=null){%> <%=StringEscapeUtils.escapeHtml4(projectdata[0].toString())%><%}else{%>&nbsp;&nbsp;&nbsp;&nbsp; --<%}%></b></td>
	</tr>
	
	<tr>
		<td style="width: 5%;">2.</td>
		<td style="width: 30%;">Nodal Lab</td>
		<td style="width: 60%;">:<b><%if(projectdata[11]!=null){%> <%=StringEscapeUtils.escapeHtml4(projectdata[11].toString())%><%}else{%>&nbsp;&nbsp;&nbsp;&nbsp; --<%}%></b></td>
	</tr>
	
	<tr>
		<td style="width: 5%;">3.</td>
		<td style="width: 30%;">Other Participating Labs, if any </td>
		<td style="width: 60%;">:i)_________________</td>
	</tr>
	
	<tr>
		<td style="width: 5%;"></td>
		<td style="width: 30%;">(With name & title of subproject)</td>
		<td style="width: 60%;">:ii)________________</td>
	</tr>
	
	<tr>
		<td style="width: 5%;">4.</td>
		<td style="width: 30%;">Project No.</td>
		<td style="width: 60%;"></td>
	</tr>
	<tr>
		<td style="width: 5%;"></td>
		<td style="width: 30%;">(i) For Nodal Lab </td>
		<td style="width: 60%;">:______________</td>
	</tr>
	<tr>
		<td style="width: 5%;"></td>
		<td style="width: 30%;">(ii)For Participating Lab 1</td>
		<td style="width: 60%;">:______________</td>
	</tr>
	<tr>
		<td style="width: 5%;"></td>
		<td style="width: 40%;">(iii)For Participating Lab 2</td>
		<td style="width: 60%;">:______________</td>
	</tr>
	
	<tr>
		<td style="width: 5%;">5.</td>
		<td style="width: 30%;">Plan/Non-Plan Project </td>
		<td style="width: 60%;">:<b><%if(projectdata[8]!=null && "P".equals(projectdata[8]+"")){%> Planed Project<%}else if(projectdata[8]!=null && "N".equals(projectdata[8]+"")){%>Non-Plan Project <%} else{%>&nbsp;&nbsp;&nbsp;&nbsp; --<%}%></b></td>
	</tr>
	
	<tr>
		<td style="width: 5%;">6.</td>
		<td style="width: 30%;">Total estimated cost <br>(Rupees in words)</td>
		<td style="width: 60%;">:<b> &#8377; <%if(projectdata[1]!=null){%><%=StringEscapeUtils.escapeHtml4(projectdata[1].toString()) %> <%}else{%>&nbsp;&nbsp;&nbsp;&nbsp; --<%}%>Cr</b> (FE:&#8377;<b> <%if(projectdata[3]!=null){%><%=projectdata[3] %> <%}else{%>--<%}%>Cr)</b></td>
	</tr>
	
	<tr>
		<td style="width: 5%;"></td>
		<td style="width: 30%;"><b>Break-up of Share in case of Jointly Funded Projects </b></td>
		<td style="width: 60%;"></td>
	</tr>
	
	<tr>
		<td style="width: 5%;">7.</td>
		<td style="width: 30%;">Start Date	(DD: MM: YYYY)	</td>
		<%if(initiationSanctionlist!=null && editdata==null){%>
		<td style="width: 60%;"> :<b> <%if(initiationSanctionlist[16]!=null){%> <%=sdf.format(initiationSanctionlist[16])%> <%}%> </b></td>
		<%}else{ %>
		<td style="width: 60%;"><input style="width: 20%;" id="startdate" name="StartDate"  data-date-format="dd/mm/yyyy" readonly class="form-control form-control"></td>
		<%}%>
	</tr>
	
	<tr>
		<td style="width: 5%;">8.</td>
		<td style="width: 30%;">PDC (Months & Date) </td>
		<td style="width: 60%;">:<b><%if(projectdata[7]!=null){%> <%=StringEscapeUtils.escapeHtml4(projectdata[7].toString())%> Months <%}else{%>&nbsp;&nbsp;&nbsp;&nbsp; --<%}%></b></td>
	</tr>
	
	<tr>
		<td style="width: 5%;">9.</td>
		<td style="width: 30%;">Objectives</td>
		<td style="width: 60%;">:<b><%if(projectdata[9]!=null){%><br> <%=StringEscapeUtils.escapeHtml4(projectdata[9].toString()) %> <%}else{%>&nbsp;&nbsp;&nbsp;&nbsp; --<%}%></b></td>
	</tr>
<!-- 	<tr>
		<td style="width: 5%;"></td>
		<td style="width: 30%;"></td>
		<td style="width: 60%;">:(ii)_______________</td>
	</tr>
	<tr>
		<td style="width: 5%;"></td>
		<td style="width: 30%;"></td>
		<td style="width: 60%;">:(iii)_______________</td>
	</tr> -->
	
	<tr>
		<td style="width: 5%;">10.</td>
		<td style="width: 30%;">Scope</td>
		<td style="width: 60%;">:<b><%if(projectdata[10]!=null){%><br> <%= StringEscapeUtils.escapeHtml4(projectdata[10].toString()) %> <%}else{%>&nbsp;&nbsp;&nbsp;&nbsp; --<%}%></b></td>
	</tr>    
	
	<tr>
		<td style="width: 5%;">11.</td>
		<td style="width: 30%;">Deliverables/Output</td>
		<td style="width: 60%;">: <b><%if(projectdata[6]!=null){%><%= StringEscapeUtils.escapeHtml4(projectdata[6].toString()) %> <%}else{%>&nbsp;&nbsp;&nbsp;&nbsp;    --<%}%> </b></td>
	</tr>
	
	<tr>
		<td style="width: 5%;">12.</td>
		<td style="width: 30%;">Break-up of Estimated Funds (&#8377; Cr)</td>
		<%if(initiationSanctionlist!=null && editdata==null){%>
		<td style="width: 60%;">: <b><%if(initiationSanctionlist[12]!=null){%> <%=initiationSanctionlist[12]%> <%}%> </b></td>
		<%}else{ %>
		<td style="width: 60%;">:&nbsp;<input type="number" name="EstimateCost" <%if(initiationSanctionlist!=null && initiationSanctionlist[12]!=null){%> value="<%=StringEscapeUtils.escapeHtml4(initiationSanctionlist[12].toString())%>" <%}%>  id="EstimateCost" required="required"> </td>
		<%}%>
	</tr>
	
	</table>
</div>


<div align="center">
<br>
<%if(projectdata[12]!=null && "1".equalsIgnoreCase(projectdata[12]+"")||"2".equalsIgnoreCase(projectdata[12]+"")||"6".equalsIgnoreCase(projectdata[12]+"")||"4".equalsIgnoreCase(projectdata[12]+"") ||projectdata[12]!=null && "7".equalsIgnoreCase(projectdata[12]+"") || projectdata[12]!=null && "8".equalsIgnoreCase(projectdata[12]+"")){%>
   <p style="padding-right: 555px;"> a)	<b>For MM, TD, UT and IF projects:</b></p>
	<table style="width: 90%; padding-left: 35px;" >
	
		<tr style="border: 1px solid black;">
			<td rowspan="2" style=" border: 1px solid black; width: 10%;"><b>Minor Head</b></td>
			<td style=" border: 1px solid black;"><b>Major Head 4076 - Capital<br> Sub Major Head - 05 </b></td>
			<td style=" border: 1px solid black;">Nodal Lab</td>
			<td style=" border: 1px solid black;">Participating Lab, if any</td>
			<td rowspan="2" style=" border: 1px solid black;"> Total(FE)</td>
		</tr>
	
		<tr style="border: 1px solid black;">
		
			<td style=" border: 1px solid black;">Heads of Expenditure</td>
			<td style=" border: 1px solid black;">Total (FE)</td>
			<td style=" border: 1px solid black;">Total (FE)</td>
		  
		</tr>
		<!--  <tr style="border: 1px solid black;">
				<td rowspan="10"> <br><br><br> <br><br><br><b> 052 (Code Head- 929/25)* </b></td>
				<td style=" border: 1px solid black;">Transportation(Movement of Stores)</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Equipment/Stores</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">CARS/CAPSI</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Consultancy Contracts</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Job Work/Contracts/<br> Technical Services</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Hiring of Transport</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">FOL for Project Vehicles</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Contingency & Miscellaneous</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Plant & Machinery</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Project related Vehicles</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				<td>1111</td>
				<td style=" border: 1px solid black;">Works</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr> -->
		<%if(itemlist!=null){ for(Object[] obj:itemlist){%>
		<tr style=" border: 1px solid black;">
			<td style=" border: 1px solid black;"><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%></td>
			<td style=" border: 1px solid black;"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%></td>
			<td style=" border: 1px solid black;"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></td>
			<td style=" border: 1px solid black;"></td>
			<td style=" border: 1px solid black;"></td>
			
		</tr>
		<%}}%>
		
		<tr style="border: 1px solid black;">
				
				<td colspan="2" align="right"><b>TOTAL</b></td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		
	</table>
	<p style="padding-left: 35px;" >* Total project expenditure related to MM, TD, IF and UT projects including equipment, hardware, consultancy, project related contingency, purchase/hiring of transport, freight, contracts for "Acquisition of Research Services (CARS)" under the project etc will be compiled to this head.</p>
	<%}%>
	 <%if(projectdata[12]!=null && "3".equalsIgnoreCase(projectdata[12]+"")||"5".equalsIgnoreCase(projectdata[12]+"")){%> 
	  <p style="padding-right: 555px;"> b)	<b>	For S&T and PS Projects:</b></p>
	 <table style="width: 90%; padding-left: 35px;" >
	
		<tr style="border: 1px solid black;">
			<td rowspan="2" style=" border: 1px solid black;"><b>Minor Head</b></td>
			<td style=" border: 1px solid black;"><b>Major Head 2080 - Revenue </b></td>
			<td style=" border: 1px solid black;">Nodal Lab</td>
			<td style=" border: 1px solid black;">Participating Lab, if any</td>
			<td rowspan="2" style=" border: 1px solid black;"> Total(FE)</td>
		</tr>
	
		<tr style="border: 1px solid black;">
		
			<td style=" border: 1px solid black;">Heads of Expenditure</td>
			<td style=" border: 1px solid black;">Total (FE)</td>
			<td style=" border: 1px solid black;">Total (FE)</td>
		  
		</tr>
		
		<tr style="border: 1px solid black;">
				<td>105</td>
				<td style=" border: 1px solid black;">Transportation<br>(Movement of Stores)</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		
		<!-- <tr style="border: 1px solid black;">
				<td rowspan="7"> 110 <br><br><b>(Code Head- 856/01)**</b></td>
				<td style=" border: 1px solid black;">Equipment/Stores</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">CARS</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">CAPSI</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Consultancy Contracts</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Job Work/Contracts/Hiring of <br> Technical Services</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Hiring of Transport, FOL for Project Vehicles</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Contingency & Miscellaneous</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				<td>111</td>
				<td style=" border: 1px solid black;">Works</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black; " colspan="2" ><b style="float: right;">TOTAL (REVENUE)</b></td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		
		<tr style="border: 1px solid black;">
				<td></td>
				<td style=" border: 1px solid black;"><b>Major Head 4076 - Capital </b></td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				<td>052</td>
				<td style=" border: 1px solid black;">Plant & Machinery</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<tr style="border: 1px solid black;">
				<td rowspan="2"><b>(Code Head-929/24) ***</b></td>
				<td style=" border: 1px solid black;">Project related Vehicles</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr> 
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;">Works</td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>-->
		<%if(itemlist!=null){ for(Object[] obj:itemlist){%>
		<tr style=" border: 1px solid black;">
			<td style=" border: 1px solid black;"><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%></td>
			<td style=" border: 1px solid black;"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%></td>
			<td style=" border: 1px solid black;"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></td>
			<td style=" border: 1px solid black;"></td>
			<td style=" border: 1px solid black;"></td>
			
		</tr>
		<%}}%>
		<tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;" colspan="2"><b style="float: right;">TOTAL (CAPITAL)</b></td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr>
		<!-- <tr style="border: 1px solid black;">
				
				<td style=" border: 1px solid black;" colspan="2"><b style="float:right;">GRAND TOTAL (REVENUE & CAPITAL)</b></td>
				<td style=" border: 1px solid black;"></td>
				<td style=" border: 1px solid black;"></td>
			  	<td></td>
		</tr> -->
	  </table>
	  <%}%>
</div>
<br>
<p style="padding-left: 35px;">**Expenditure under Product Support (PS) and Science & Technology (S&T) on Project, Hardware on the basis of items less than Rs. 10 Lakhs and with less than 7 years expected life will be compiled to this Head, Consultancy, Transport, Freight, CARS and other Project related contingencies which do not create tangible assets related to Science & Technology (S&T) and Product Support (PS) Project.</p>
<p style="padding-left: 35px;">*** Cost of any upgrades / improvements in the existing product and creation of permanent infrastructure (such as testing facilities) for PS projects; and all expenditures resulting in creation of tangible assets such as testing equipment, testing infrastructure, permanent facilities such as ranges/ buildings etc, which remain after project closure, for S&T projects.</p>
<p style="padding-left: 35px;"><b>Note:</b>In case of project jointly funded by DRDO, Services, PSUs etc; details of funds of Services, PSUs etc along with budget heads be given and grand total be mentioned accordingly. </p>


<p style="padding-left: 35px;">13.	Add para <b>If Required/Applicable.</b>  If Demand approval is accorded along with project sanction, additional information viz. name of equipment(s), estimated cost, probable source of supply, mode of tendering, wherever applicable be mentioned.</p>
<p style="padding-left: 35px;">14.	Director, Nodal Lab is authorized to allot sub-projects to other Defence R&D Labs/Estts for development / manufacture of sub-systems / sub-assemblies required for the project within the sanctioned funds under specific budget heads and likely date of completion. </p>
<p style="padding-left: 35px;">15.	<b>If Required/ Applicable </b>----- Director(s) / PD(s) of Nodal Lab and  participating   Labs (if applicable) are also authorized to place supply orders for development, consultancy, or research contracts with other Govt./public/private sector  organizations, academic institutions etc.  restricting it within the total sanctioned funds (within the budget sanctioned under the relevant heads subject to financial powers authorized vide Government of India, Min of Defence letter no DRDO/DFMM/PL/83226/M/01/1976/ D(R&D)  dated 18 Dec 2019 as amended from time to time. </p>
<p style="padding-left: 35px;">15.	Authority letter for appointment of Programme / Project Director will be issued separately  to concerned CDA (R&D)/Agency by the Competent Authority as per DPFM 2021</p>
<p style="padding-left: 35px;">16.	Procurement of stores will be made in accordance with the rules and procedures for procurement of Equipment/Stores and services within the available powers and in terms of DRDO "Procurement Manual- 2020", as amended from time to time. </p>
<p style="padding-left: 35px;">17.	Director (Nodal Lab) is authorized to change the FE element as given in the GoI letter which can be converted to IC, subject to the overall sanctioned cost of the project not being exceeded. </p>
<p style="padding-left: 35px;">18.	The project monitoring committee structures as applicable may be brought out as Annexure to this Govt. Letter.</p>
<p style="padding-left: 35px;">19.	Para on Special Powers (as applicable) & other specific issues, if any: should be mentioned (if approved on file).</p>
<p style="padding-left: 35px;">20.	The expenditure will be debited to the relevant Minor Heads, under Major Head 2080 "Revenue" and Major Head 4076 "Capital" <b>(as the case may be)</b>, of Defence Services Estimates, Research & Development. </p>
<p style="padding-left: 35px;">21.	<b>Add:-</b> Para on Debit of Expenditure /Flow of funds in case of Joint Projects with Services/PSUs and other agencies.</p>
<p style="padding-left: 35px;">22.	Unique Sanction Code (USC) 	:&nbsp;<%if(initiationSanctionlist!=null && editdata==null && initiationSanctionlist[13]!=null){%> <%=initiationSanctionlist[13] %> <%}else{%><input type="text" name="USC" id="USC" <%if(initiationSanctionlist!=null && initiationSanctionlist[13]!=null){%>  value="<%=initiationSanctionlist[13]%>" <%}%> required="required"> <%}%>(Please refer guidelines issued vide letter No- DBFA/FA/83301/M/01 dated 31st Mar 2014, available on DRONA portal of DFMM, DRDO HQ) </p>
<p style="padding-left: 35px;">23.	This issues with the concurrence of IFA (R&D) or Add FA (R&D) (as the case may be) vide their By. No &nbsp;<%if(initiationSanctionlist!=null && initiationSanctionlist[15]!=null && editdata==null){%>  <%=initiationSanctionlist[15] %> <%}else{%> <input type="text"  name="videNo" <%if(initiationSanctionlist!=null && initiationSanctionlist[15]!=null){%>  value="<%=initiationSanctionlist[15]%>" <%}%>  id="vide" required="required"> <%} %> &nbsp;/MoD(Fin)/R&D dated <%if(initiationSanctionlist!=null && initiationSanctionlist[14]!=null  && editdata==null){%>  <%=sdf.format(initiationSanctionlist[14])%> <%}else{%> <input style="width: 9%;" id="rddate"  data-date-format="dd/mm/yyyy" readonly name="RdDate" class="form-control form-control"></p><%}%>
<br>
<p align="right" style="padding-right: 35px;">(Authorised Signatory)</p>
</div>
<div>
<p style="padding-left: 35px;"><b>Note:</b> The circulation of the sanction letter of the project will be as per the table given below:</p>
</div>

<div align="center">


	<!-- 	 <table style="width: 60%;" >
			<tr style="border: 1px solid black;">
				<td style=" border: 1px solid black;"><b>Mandatory Ink Signed copy </b></td>
				<td style=" border: 1px solid black;"><b>Copy to</b></td>
			</tr>
			<tr style="border: 1px solid black;">
				<td style=" border: 1px solid black;">&#x2022	Cluster DG<br>
					&#x2022	Lab Director<br>
					&#x2022	DP&C <br>
					&#x2022	CDA (R&D) of concerned lab<br>
					&#x2022	CDA (R&D) of participating lab<br>
				</td>
				<td style=" border: 1px solid black;">&#x2022	DGADS/PDA(AF)/PDA(Navy) as per case<br>
                    &#x2022	DFMM <br>
					&#x2022	User (Services), if any 
				</td>
			</tr>
			
			<tr style="border: 1px solid black;">
				<td style=" border: 1px solid black;">&#x2022	PCDA (R&D), New Delhi<br>
					&#x2022	Labs Holding sub-projects.<br>
					&#x2022	CDA (Services) - for jointly funded projects
				</td>
				<td style=" border: 1px solid black;">&#x2022 IFA (Cluster)<br>
					&#x2022	 Controller General of Defense Accounts (CGDA) <br>
					&#x2022	DCW&E - if provision for Rev/Cap (Works) 
				</td>
			</tr>
			
		</table>  -->
	
		<table  style=" width: 30%; ">
		
			
			<%if(copyaddresslist!=null && copyaddresslist.size()>0 && editdata==null){ %>
			<tr>
						<td style=" border: 1px solid black;">
						<b>Mandatory Ink Signed copy</b>
						</td>
			</tr>
				<%for(Object[] obj :copyaddresslist ){ %>
				<tr> 
				<td style=" border: 1px solid black;">
					<%if(obj[1]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[1].toString())%><%}%> 
					<%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString())%><%}%>
					<%if(obj[3]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[3].toString())%><%}%>
				</td>
				</tr>
				<%}%>

			<%}else{%>
			<tr>
				<td ><b>Mandatory Ink Signed copy</b></td>
			</tr>	
			<tr> 
				<td>
				<div style=" width: 100%; ">
					<select name="CopyAddr" id="CopyAddr" required="required" multiple="multiple" class="form-control  form-control selectdee"  data-width="100%" data-live-search="true">
					
						<%for(Object[] obj  :initiationcopy){%>
						<option value="<%=obj[0]%>" 
						
						
						 <%if(copyaddresslist!=null){ for(Object[] val:copyaddresslist){ 
								   if(String.valueOf(val[0]).equalsIgnoreCase(obj[0]+"")){%>
									 selected="selected"
								 <%}}}%>
						
						> <%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%> <%if(obj[2]!=null){%><%=StringEscapeUtils.escapeHtml4(obj[2].toString())%><%}%></option>
						<%}%>
					</select>
				</div>
				</td>
			</tr>
		</table>
		
		<%}%>
		
</div>

<br><br>

</div>
<div align="center">
<%if(initiationSanctionlist!=null && copyaddresslist!=null && editdata==null){%>

<button type="button" id ="printbtn"   class="btn btn-sm prints" onclick="window.print()">Print </button>
<button type="submit" id ="printbtn" name="Action" formnovalidate="formnovalidate" value="EditSanction" class="btn btn-sm  edit" >Edit </button>

<br>

<%}else{%>
<input type="hidden" name="initiationsanid" <%if(initiationSanctionlist!=null && copyaddresslist!=null && editdata!=null && editdata.equalsIgnoreCase("edit")){%> value="<%=initiationSanctionlist[20]%>" <%} %>>
<button type="submit" id ="printbtn" name="Action" formnovalidate="formnovalidate" value="AddEditSanction" class="btn btn-sm submit" onclick="return CheckData();">Submit </button>

<%}%>
</div>
</form>
 <%}%> 
<script type="text/javascript">
$('#fromdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	<%if(initiationSanctionlist!=null &&initiationSanctionlist[16]!=null && editdata!=null){ %>
	"startDate" :new Date("<%=initiationSanctionlist[16]%>"),
	<%}%>
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	<%if(initiationSanctionlist!=null &&initiationSanctionlist[11]!=null && editdata!=null){ %>
	"startDate" :new Date("<%=initiationSanctionlist[11]%>"),
	<%}%>
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
$('#rddate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	<%if(initiationSanctionlist!=null &&initiationSanctionlist[14]!=null && editdata!=null){ %>
	"startDate" :new Date("<%=initiationSanctionlist[14]%>"),
	<%}%>
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});




 function CheckData()
{
	var no = $('#No').val();
	var authority = $('#Authority').val();
	var fromdept= $('#FromDepartment').val();
	var todept = $('#ToDepartment').val();
	var estimatecost = $('#EstimateCost').val();
	var usc = $('#USC').val();
	var vide = $('#vide').val();
	var copyaddr = $('#CopyAddr').val();
	
	if(no=="" ||no==null || no=="null"){
		alert("Please Enter the No!");
		return false;
	}else if(fromdept==null||fromdept=="" || fromdept=="null"){
		alert("Please Select From Department!");
		return false;
	}else if(authority==null||authority=="" || authority=="null"){
		alert("Please Select Authority!");
		return false;
	}else if(todept==null||todept=="" || todept=="null"){
		alert("Please Select To Department!");
		return false;
	}else if(estimatecost=="" ||estimatecost==null || estimatecost=="null"){
		alert("Please Enter the Estimat Fund!");
		return false;
	}else if(usc=="" ||usc==null || usc=="null"){
		alert("Please Enter the Unique Sanction Code!");
		return false;
	}else if(vide=="" ||vide==null || vide=="null"){
		alert("Please Enter vide No!");
		return false;
	}else if(copyaddr=="" ||copyaddr==null || copyaddr=="null"){
		alert("Please Select Copy Address!");
		return false;
	}else{
		if(confirm("Are you sure to submit?")){
			$('#form1').submit();
			return true;
		}else{
			return false;
		}
		
		
	}
	
} 
</script>
</body>
</html>