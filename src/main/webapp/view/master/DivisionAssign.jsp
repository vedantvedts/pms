<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Division Employee</title>
<style type="text/css">

.table-responsive{
  overflow-x: hidden;
}

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
List<Object[]> DivisionList=(List<Object[]>) request.getAttribute("divisionlist");
List<Object[]> divisionemplist=(List<Object[]>) request.getAttribute("divisionemplist");
List<Object[]> empoyeelist=(List<Object[]>) request.getAttribute("empoyeelist");
Object[] divisiondata=(Object[]) request.getAttribute("divisiondata");
String divisionid=divisiondata[0].toString();

//divisiondata[2]="<h1>sdgfsgf</h1>";

%>


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




<div class="container-fluid">
<div class="col-md-12">
		<div class="card">
		
		<div class="card-header">
			<div class="row">
				<div class="col-md-10"><h4>Division Assign</h4></div>
				<div class="col-md-2">		      
					<a class="btn btn-info btn-sm  back"  style="margin-left: 4.2rem; "   href="MainDashBoard.htm">Back</a>
				</div>
			</div>
		</div>
		
		
<div class="nav navbar auditnavbar" style="background-color: #f4f5f0;">

			<form class="form-inline " method="POST" action="DivisionEmployee.htm">
				<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				<label style="margin-left: 450px; margin-right: 10px;font-weight: 800">Division: <span class="mandatory" style="color: red;">*</span></label>
					<select class="form-control form-control selectpicker" name="divisionid" style="margin-left: 12px;" data-width="300"  id="name">
		        <option value="" disabled="disabled" selected="selected">Select Division </option>
			                <%
			                for(Object[] obj:DivisionList){
	
	                           %>
	                           
								<option value="<%=obj[0] %>" <%if(divisionid!=null){ if(obj[0].toString().equalsIgnoreCase(divisionid)){%> selected="selected" <%}} %>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%></option> 
							
								<%} %>
					</select>
	
	 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
			</form>
	
	</div>



                    
                    
 <div class="row" style="margin-top: 10px;">
      <div class="col-md-8">
<div style="margin-top: 0px;">

<div class="card   " >
		  	
     <div class="card-body  shadow-nohover" >
  <form action="DivsionEmployeeRevoke.htm" method="POST" name="frm1" >
    <div class="row" style="margin-top: 20px;">
      <div class="col-md-12">
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed" id="myTable"> 
	   <thead style=" text-align: center;">
	   <tr style="background-color: white;color: black">
	   <th colspan="5">List Of User Assigned for <%if(divisiondata!=null){ %><%=divisiondata[1]!=null?StringEscapeUtils.escapeHtml4(divisiondata[1].toString()):"-"%><%} %></th>
	  </tr>
	   <tr>
	   <th style="width:5%; ">Select</th>
	  
	   <th >Employee Name</th>
	  <th>Designation</th>
	  
	  
	  </tr>
	   </thead>
    <tbody>
    
    
	 <%if(divisionemplist!=null && divisionemplist.size() > 0){
	 for(Object[] obj:divisionemplist){ %>
	    <tr>
	  <td><input type="radio" name="divisionempid" value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):" - "%>></td>
	    
        <td style="text-align: left;"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"%> </td>
        <td style="text-align: left;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%> </td>
	    </tr>
	    <%} } else if(divisionemplist == null) {%>
	     <tr class="center">     
	      <td valign="top" colspan="4" class="dataTables_empty">Select division to assign !!</td>
	    </tr>
	           <% }  else { %>
	         <tr class="center">     
	      <td valign="top" colspan="4" class="dataTables_empty">no members assigned </td>
	    </tr>
	     <% } %>
	    </tbody>
</table>
 	
</div>
<div style="text-align: center;">
 <button type="submit" class="btn btn-danger btn-sm delete"  formaction="DivsionEmployeeRevoke.htm" onclick="return Edit('frm1');"  >REVOKE</button>&nbsp;&nbsp;

</div>
</div>
</div>

<input type="hidden" name="divisionid" value="<%=divisionid %>" /> 	 						
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					
 	</form>

</div>

</div>
</div>
</div>
<div class="col-md-4">
<div style="margin-top: 0px;">

<div class="card  " >
		  	
     <div class="card-body  shadow-nohover" >
  <form action="DivisionAssignSubmit.htm" method="POST" name="frm2" >
    <div class="row" style="margin-top: 20px;">
      <div class="col-md-12">
    <div class="table-responsive" >
	   <table class="table table-bordered table-hover table-striped table-condensed"  > 
	   <thead>
	   <tr>
	   <th colspan="4">Select User  for <%if(divisiondata!=null){ %><%=divisiondata[2]!=null?StringEscapeUtils.escapeHtml4(divisiondata[2].toString()):"-"%><%} %></th>
	  </tr>
	 </thead>
    <tbody>
	    <tr>
	    
	     <td colspan="4">
					<select class="form-control form-control" name="employeeid" style="margin-left: 12px;" data-placeholder="Select Employees"  required="required" id= "LogInId" multiple="multiple" >
			        <%if(empoyeelist != null){ 
			             for(Object[] obj:empoyeelist){ %> 
			           
			            <option value="<%=obj[0] %>">
				        	<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%></option>
			        <% }} %>	  	
				 	</select>
	    </td>
	    </tr>
	    </tbody>
</table>
</div>
<div style="text-align: center;">

 <button type="submit" class="btn btn-success btn-sm submit" name="sub" value="edit" onclick="return confirm('Are you Sure To Assign ?');" >ASSIGN</button>&nbsp;&nbsp;
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<input type="hidden" name="divisionid" value="<%=divisionid %>" />
</div>
      </div>
      </div>
      </form>
      </div>
      </div>
</div>
</div>
</div>

</div>

</div>
	</div>
  
  <script type='text/javascript'>
  
    $(document).ready(function(){
    	$('#name').select2();
    	$('#LogInId').select2();
    	
    });
  
  </script>
<script>
function Edit(myfrm){
	
	 var fields = $("input[name='divisionempid']").serializeArray();

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