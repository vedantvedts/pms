<%@page import="com.vts.pfms.login.Login"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>LOGIN TYPE EDIT</title>
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
.card b{
	font-size: 20px;
}


</style>
</head>
<body>
<%List<Object[]> DivisionList=(List<Object[]>)request.getAttribute("DivisionList");
List<Object[]> RoleList=(List<Object[]>)request.getAttribute("RoleList");
Login login=(Login)request.getAttribute("UserManagerEditData");
List<Object[]> EmpList=(List<Object[]>)request.getAttribute("EmpList");
List<Object[]> LoginTypeList=(List<Object[]>)request.getAttribute("LoginTypeList");

%>




<%
String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	
	
<div align="center">	

	<div class="alert alert-danger" role="alert">
           <%=ses1 %>
    </div>
    
	<%}if(ses!=null){ %>
	
	<div class="alert alert-success" role="alert" >
          <%=ses %>
    </div>
            
</div>
    
  <%} %>
	
<br>
	
<div class="container">
	<div class="row" style="">

		<div class="col-md-12">
		<div align="center">
		<div class="badge badge-success" >LoginType:<%=login.getLoginType() %>&nbsp;&nbsp;||&nbsp;Username:<%=login.getUsername() %> </div></div>
 			<div class="card shadow-nohover" >
				
				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white">Login  Edit</b>
        		</div>
        
        		<div class="card-body">
<form name="myfrm" action="UserManagerEditSubmit.htm" method="POST" >
  <div class="form-group">
  <div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed "  >
  <thead>


<tr>
  <th>
<label >Division:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td >
 <select class="form-control selectdee" name="Division" data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
				<%
					for (Object[] obj : DivisionList) {
				%>
				<option value="<%=obj[0]%>" <%if(Integer.parseInt(obj[0].toString())==login.getDivisionId()) {%> selected="selected" <%} %>><%=obj[1]%></option>
				<%
					}
				%>

			</select> 
 
</td>

  <th>
<label >Login Type:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
 <td style="width: 300px;">
 <input type="hidden" name="Role"  value="1">
 			<select class="form-control selectdee" name="LoginType" id="LoginType" data-container="body" data-live-search="true"  required="required" style="width:100% ;font-size: 5px;">
				<option value="" disabled="disabled" selected="selected"
					hidden="true">--Select--</option>
					<%	for (Object[] obj : LoginTypeList) { %>			
					<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase( login.getLoginType())) {%> selected="selected" <%} %>><%=obj[1]%></option>
					<% } %>
			</select> 
 
</td>
</tr>
<tr>
   <th>
<label >Employee:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
<td >
 <select class="form-control selectdee" name="Employee" id="Employee" 
 	data-container="body" data-live-search="true"  required="required" style="font-size: 5px;">
				
				<% 	for (Object[] obj : EmpList) {	%>
				<option value="<%=obj[0]%>"  <%if(Long.parseLong(obj[0].toString())==login.getEmpId()) {%> selected="selected" <%} %>><%=obj[1]%></option>
				<%	}	%>

			</select>
</td> 
<th>
<label >PFMS Login:
<span class="mandatory" style="color: red;">*</span>
</label>
</th>
<td colspan="3">
<select class="form-control" name="pfmsLogin" style="width:50%; " required="required">
<option value="N" <%if(login.getPfms().equals("N")){ %> selected="selected" <%} %> >No</option>
<option value="Y"  <%if(login.getPfms().equals("Y")){ %> selected="selected" <%} %>>Yes</option>
</select>

</td>
</tr>
</thead> 
</table>

</div>
</div>
  <div class="row" style="margin-left: 47%;" align="center">
 <input type="submit"  class="btn btn-primary btn-sm submit"/>  
 <a class="btn btn-info btn-sm shadow-nohover back" style="margin-left: 0.5rem;"  href="UserManagerList.htm">Back</a>
 </div>
	<input type="hidden" name="LoginId"
								value="<%=login.getLoginId() %>" />
	 <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />
								
	  </form>
	
	
	  </div>
</div>
</div>
</div>	
	
	
	  
<script type="text/javascript">

$(document)
.on(
		"change",
		"#LoginType",

		function() {
			// SUBMIT FORM

	
			var $LoginType = this.value;

		
		
			if($LoginType=="D"||$LoginType=="G"||$LoginType=="T"||$LoginType=="O"||$LoginType=="B"||$LoginType=="S"||$LoginType=="C"||$LoginType=="P"||$LoginType=="U"){
			
				$("#Employee").prop('required',true);
			}
			else{
				$("#Employee").prop('required',false);
			}
	
		});

</script>
</body>
</html>