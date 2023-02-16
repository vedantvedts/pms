<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>PROJECT  ASSIGN</title>
<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}

b{
	font-family: 'Lato',sans-serif;
}

#myTable thead tr{
	background-color: #055C9D;
    color: white;
}
</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectAssignList=(List<Object[]>) request.getAttribute("ProjectAssignList");
List<Object[]> OfficerList=(List<Object[]>) request.getAttribute("OfficerList");
List<Object[]> ProjectList=(List<Object[]>) request.getAttribute("ProjectList");
String ProjectId=(String)request.getAttribute("ProjectId");
Object[] ProjectCode=(Object[])request.getAttribute("ProjectCode");
%>


                    

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><center>
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></center>
                    <%} %>




<div class="container-fluid">
		<div class="col-md-12">
		<div class="card">
		<div class="card-header">
			<div class="row">
				<div class="col-md-10"><h4>Project Assign</h4></div>
				<div class="col-md-2">		      
					<a class="btn btn-info btn-sm  back"  style="margin-left: 4.2rem; margin-top: -5px;"   href="MainDashBoard.htm">Back</a>
				</div>
			</div>
		</div>
<div class="nav navbar auditnavbar" style="background-color: #f4f5f0;">

			<form class="form-inline " method="POST" action="ProjectProSubmit.htm">
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				<label style="margin-left: 450px; margin-right: 10px;font-weight: 800">Project Code: <span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control selectdee" name="ProjectId" style="margin-left: 12px;"  id="name">
			                <option value="" disabled="disabled" selected="selected">Select Project </option>
			                <%
			                for(Object[] protype:ProjectList ){
	                        %>
								<option value="<%=protype[0] %>" <%if(ProjectCode!=null){ if(protype[0].toString().equalsIgnoreCase(ProjectCode[0].toString())){%>selected="selected" <%}} %>><%=protype[4] %></option>
							<%} %>
					</select>
	
	 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
			</form>
	
	</div>



                    
                    
 <div class="row" style="margin-top: 10px;">
      <div class="col-md-8">
<div style="margin-top: 0px;">

<div class="card " >
		  	
     <div class="card-body  shadow-nohover" >
  <form action="ProjectRevokeSubmit.htm" method="POST" name="frm1" >
    <div class="row" style="margin-top: 20px;">
      <div class="col-md-12">
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed" id="myTable"> 
	   <thead style=" text-align: center;">
	   <tr style="background-color: white;color: black">
	   <th colspan="5">List Of User Assigned for <%if(ProjectCode!=null){ %><%=ProjectCode[1]%><%} %></th>
	  </tr>
	   <tr>
	   <th style="width:5%; ">Select</th>
	   <th >Employee Name</th>
	  <th>Designation</th>
	  <th>Division</th>
	  
	  </tr>
	   </thead>
    <tbody>
	 <%if(ProjectAssignList!=null){
	 for(Object[] obj:ProjectAssignList){ %>
	    <tr>
	  <td><input type="radio" name="ProjectEmployeeId" value=<%=obj[0]%>></td>
	    <td style="text-align: left;"><%=obj[3].toString() %></td>
        <td style="text-align: left;"><%=obj[4].toString() %></td>
        <td style="text-align: left;"><%=obj[5].toString() %></td>
	    </tr>
	    <%} }%>
	    </tbody>
</table>
 	
</div>
<div style="text-align: center;">
 <button type="submit" class="btn btn-danger btn-sm delete"  onclick="Edit(frm1)"  >REVOKE</button>&nbsp;&nbsp;

</div>
</div>
</div>





<input type="hidden" name="ProjectId" <%if(ProjectCode!=null){ %>value="<%=ProjectCode[0]%>"<%} %> /> 	 						
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 	</form>

</div>

</div>
</div>
</div>
<div class="col-md-4">
<div style="margin-top: 0px;">

<div class="card" >
		  	
     <div class="card-body  shadow-nohover" >
  <form action="ProjectAssignSubmit.htm" method="POST" name="frm1" >
    <div class="row" style="margin-top: 20px;">
      <div class="col-md-12">
      <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed"  > 
	   <thead>
	   <tr>
	   <th colspan="4">Select User  for <%if(ProjectCode!=null){ %><%=ProjectCode[1]%><%} %></th>
	  </tr>
	 
	   </thead>
    <tbody>
	    <tr>
	    
	     <td colspan="4">
					<select class="form-control selectdee " name="EmpId" style="margin-left: 12px;" required="required" multiple="multiple" data-placeholder= "Select Employees"  >
			           	<%if(ProjectAssignList!=null){
				          for(Object[] protype:OfficerList ){ %>
				        	<option value="<%=protype[0] %>"><%=protype[1]%>, <%=protype[3]%></option>
			        	<%}}%>
				  </select>
	    </td>
	    </tr>
	    </tbody>
</table>
 	
</div>
<div style="text-align: center;">
 <button type="submit" class="btn btn-success btn-sm submit" name="sub" value="edit"   >ASSIGN</button>&nbsp;&nbsp;
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" name="ProjectId" <%if(ProjectCode!=null){ %>value="<%=ProjectCode[0]%>"<%} %> />
</div>
      </div>
      </div>
      </form>
      </div>
      </div>
</div>
</div>
</div></div>

</div>
	</div>
  
<script>
function Edit(myfrm){
	
	 var fields = $("input[name='ProjectEmployeeId']").serializeArray();

			  if (fields.length === 0){
				  bootbox.alert("Please Select One Record");
			 event.preventDefault();
			return false;
			}
			  var cnf=confirm("Are You Sure To Revoke!");
			  

			    
			  
			  if(cnf){
			
			return true;
			
			}
			  else{
				  event.preventDefault();
					return false;
					}
			
			}
</script>
<script>
$(document).ready(function() {
	   $('#name').on('change', function() {
	     $('#submit').click();

	   });
	});

</script>
</body>
</html>